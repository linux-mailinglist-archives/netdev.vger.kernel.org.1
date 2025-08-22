Return-Path: <netdev+bounces-216101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447C7B320BE
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47885AE0B86
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32339307AF0;
	Fri, 22 Aug 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cre8JCJ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73E1DE4CE
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881266; cv=none; b=JAyT7llpFfQo9X0Ho3TcwsI0YU2NPPFJacs2E/dlN4yTBIQ0watrlhw4CZHHUOffQEeuwuL0EV/6DVbDn7hISecs3qeEqvoZGf9QSXZKMMFmGjniTSXsCAdwY4fTnG138vhFherKPT/0MulVzESxpWQDmvKoJGUPY+k4j2TaZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881266; c=relaxed/simple;
	bh=rrxoeMbsiWQ3umzDugb1imvlDZfjptqc+pgImBJJQFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvW8SP+eOnPJIghbVYFFnLqoERB1JNRoiwGzKR4nFsFa+ZmlWW3mP+r04D6rFDMssV9NAvKOFA9+BpVDI4F9MBtpuL/b8D35QMIRVnj07JbDS3GRsqHuNQ4Jp7m29mRm8esQX8UjiC5078yOPM+3+bkz66p/Uc/Pe2tk908crkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cre8JCJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D8DC4CEED;
	Fri, 22 Aug 2025 16:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881265;
	bh=rrxoeMbsiWQ3umzDugb1imvlDZfjptqc+pgImBJJQFM=;
	h=From:To:Cc:Subject:Date:From;
	b=cre8JCJ8lBdBb+Wy7PuJd8IaK7HXVUqquegvE8nBTeXqav3zvUbK9BgRvzB5ySnv3
	 7kVt5WtQVY4SlRjWJYgy5xLCyYEx0pTIh358aE50eIZoHwOXX9pWqq5Xw9rgj0HVEC
	 JUUdpvsVevEugVfpt57TKGScUg/UVMcKOQTafbDIZrNy7IeFW9JdPlRW/jB5XRwVte
	 uUpNSvuaRARU7Zdn6cPWC15fXmgAsc8y6L21RqnGVaYcfh6ttndt8+V+EFMCzOmQ6O
	 s/8QGHLTkwltQo7SLk3opQq7PnUwgEUjkv1Qv7+jNS/2uUpr0ywm0W4y5D5ULZuarG
	 8RPKYuWH8hrJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	linux@armlinux.org.uk,
	mohsin.bashr@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/6] eth: fbnic: Extend hw stats support
Date: Fri, 22 Aug 2025 09:47:25 -0700
Message-ID: <20250822164731.1461754-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mohsin says:

Extend hardware stats support for fbnic by adding the ability to reset
hardware stats when the device experience a reset due to a PCI error and
include MAC stats in the hardware stats reset. Additionally, expand
hardware stats coverage to include FEC, PHY, and Pause stats.

Mohsin Bashir (6):
  eth: fbnic: Move hw_stats_lock out of fbnic_dev
  eth: fbnic: Reset hw stats upon PCI error
  eth: fbnic: Reset MAC stats
  eth: fbnic: Fetch PHY stats from device
  eth: fbnic: Read PHY stats via the ethtool API
  eth: fbnic: Add pause stats support

 drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 -
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 19 ++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  | 28 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  6 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 63 +++++++++++++++++-
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 64 ++++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 57 +++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 12 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  7 +-
 9 files changed, 238 insertions(+), 21 deletions(-)

-- 
2.50.1


