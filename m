Return-Path: <netdev+bounces-195804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF0EAD2506
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A533ADF8F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707121B8E7;
	Mon,  9 Jun 2025 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+cDkXnn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DC721578F
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490495; cv=none; b=PlVRKH7aOfCRstwtiKzpISWU+JMYMT9iFtC2bEw/UpF6LJ9hYdr8oF00CD2IADTn2RytMTH5NrQgzLd0W5TVzcN/0G+YSCc7wVtBd+iJ6/oKUSI+wHqqRUdePqOmAMWZL0WVxkY9nNkh9WX79ysgfZarX8XKJHvaoP2Hn14FPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490495; c=relaxed/simple;
	bh=5hUAgA69jvfeGqvNl6Fur3j6VNCDK4WsOhZH/sUKsjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q39qIpOTQBuT7GhmWFWoNUuQh8S8KItJfzEJj8HTrotVvjz/5FZyXdU9UY4KvVAgcdGjnHfd92jDMh2wIDE9qh/AYbfRTytWB94Uf2aSkOUUa7wv4mUZkv6rVO8Lkw3PZiXJpzmjvHv7Zomriq32f+jfnlowfb4QRJlaJ1/HQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+cDkXnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536FAC4CEF0;
	Mon,  9 Jun 2025 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749490494;
	bh=5hUAgA69jvfeGqvNl6Fur3j6VNCDK4WsOhZH/sUKsjo=;
	h=From:To:Cc:Subject:Date:From;
	b=H+cDkXnnsa4MfXxqUqcyCPl2gnsVA9+wVEkRMZFNbSIQVNtDM3MH039FWHhOMAtqA
	 V3/MMK3a3i9ACAhaKs/GbcC3ETNkyDS5lwcLuTlS+znDMiOvWT/EhiANbAVZbnbgem
	 4qzVJb0SY9ffb5UiDIGFrcUhlH50tj8hykT1V8t/xy2E/AzZ+Myu738T7eRn0Zh/o8
	 kDvMTU8Egrl17USe9I/404zM8A1o4/1XQPorIPK/5NXNK3tFDpJ52V+MjcEhZwhhT/
	 VYLto6wH0FDZdNvX9+yqZB6jI19bbI1mHes6bxGKA+PJU/VTxxrCCKaCfo8a/8fk7U
	 h0maKxe0Z34bg==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 0/6] net: ethtool: support including Flow Label in the flow hash for RSS
Date: Mon,  9 Jun 2025 10:34:36 -0700
Message-ID: <20250609173442.1745856-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for using IPv6 Flow Label in Rx hash computation
and therefore RSS queue selection.

Michael, Pavan, could you please give this series a whirl?
I see the capability bit in bnxt but none of the devices
I have access to seem to expose it. Note the test in the
last patch which you should be able to run. ethtool with
the support: https://github.com/kuba-moo/ethtool

Jakub Kicinski (6):
  net: ethtool: factor out the validation for ETHTOOL_SRXFH
  net: ethtool: support including Flow Label in the flow hash for RSS
  eth: fbnic: support RSS on IPv6 Flow Label
  eth: bnxt: support RSS on IPv6 Flow Label
  selftests: drv-net: import things in lib one by one
  selftests: drv-net: add test for RSS on flow label

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 include/uapi/linux/ethtool.h                  |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  26 ++-
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   2 +
 net/ethtool/ioctl.c                           |  56 ++++++-
 .../drivers/net/hw/lib/py/__init__.py         |  17 ++
 .../drivers/net/hw/rss_flow_label.py          | 151 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |  14 ++
 11 files changed, 260 insertions(+), 13 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_flow_label.py

-- 
2.49.0


