Return-Path: <netdev+bounces-212658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F98B2197B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6ED189F39C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC6214A91;
	Mon, 11 Aug 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jkabgm20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DD20C494
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955765; cv=none; b=IRkt+bL+QzeuGOaSx/JPXIofsUnqX2g9ZyHili328bxgyLTw7etjR+eIsDDkRK++B63gLclQkGNaBDZ9UtpGJSbYB8GKnQxLW0WVng2wjJO3E6QV6E4UBsW3QvEzTlTF0ER9vpSBQrEW459t9MXVRIhpoNPAlDBhtd0wawgVVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955765; c=relaxed/simple;
	bh=+PdnFyG4X1FuGoVDvbQrnjDqTV4+NXU3hrIUVuxVWAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqrjmOEjc3HtxZQuBkiqSZn+QOl8+65sg9RYyBm9qtWSd56TXOZay9SX883qULGt6gMqC/VXW0EXLby9jlbrLhceiOCtRipGbIeF+VXeTKJ7oscQVIadkBQMYwZiavZcrXlR4oc24PwvLRNBGFUo+s6oZ0P6AuUziwZxPuaRCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jkabgm20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6BDC4CEED;
	Mon, 11 Aug 2025 23:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754955764;
	bh=+PdnFyG4X1FuGoVDvbQrnjDqTV4+NXU3hrIUVuxVWAg=;
	h=From:To:Cc:Subject:Date:From;
	b=Jkabgm20sk1MU3OLGLLGDIeUcYxWbKHuBgz9PrOziEMjC/7nrnldPd2sEWlOVnKO4
	 9PZv6I8iaTBHiyBiiLjyDJ4PInhicFLPzliYgWPXS0rhKPesXoUFHIMMX97ePVueVn
	 xluH3yJLZLwHBo1sBwSv71JVXH63ZYPuQGnWqQW8B7y+8qx3Pm9jsk6iDpQmyM5VOF
	 9lqL4ClcSiUfaHqjuDh/sWYtXQfxo0TeH0xK3WXM5B6X1RM2NucOEftDYQh315s6YM
	 R1W4PquKgHYY9hesxLEW5T/8OUfbrfblZGDrY5BKj9hosw/FQCfjg79r7w9a184rjn
	 Zf/01EVuXZajQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 0/4] net: ethtool: support including Flow Label in the flow hash for RSS
Date: Mon, 11 Aug 2025 16:42:08 -0700
Message-ID: <20250811234212.580748-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for using IPv6 Flow Label in Rx hash computation
and therefore RSS queue selection.

v4:
 - adjust the 2 tuple / 4 tuple condition in bnxt
v3: https://lore.kernel.org/20250724015101.186608-1-kuba@kernel.org
 - change the bnxt driver, bits are now exclusive
 - check for RPS/RFS in the test
v2:  https://lore.kernel.org/20250722014915.3365370-1-kuba@kernel.org
RFC: https://lore.kernel.org/20250609173442.1745856-1-kuba@kernel.org

Jakub Kicinski (4):
  net: ethtool: support including Flow Label in the flow hash for RSS
  eth: fbnic: support RSS on IPv6 Flow Label
  eth: bnxt: support RSS on IPv6 Flow Label
  selftests: drv-net: add test for RSS on flow label

 Documentation/netlink/specs/ethtool.yaml      |   3 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 include/uapi/linux/ethtool.h                  |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  20 ++-
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   2 +
 net/ethtool/ioctl.c                           |  25 +++
 net/ethtool/rss.c                             |  27 +--
 .../drivers/net/hw/rss_flow_label.py          | 167 ++++++++++++++++++
 11 files changed, 233 insertions(+), 18 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_flow_label.py

-- 
2.50.1


