Return-Path: <netdev+bounces-160671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358DA1AC8D
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 23:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E56A188DBA6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3EC1CD205;
	Thu, 23 Jan 2025 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNd55fGZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB047A7E
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670454; cv=none; b=lkvew/7/+Z/V6GsUbEqplzM2D4fCfYtQYRfjJp8wJHIpaAp6blE06IPJ7RjUoA1AMHE5U7Zl1e544ZFg8t1jmiu8CV+SahTQj3i7jg7DeT3yHrthTX8hCCFdcML63ZfIDM4cE5/6+d/lt0wNNpXAq5ehytM75gX3NIJElbjhvcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670454; c=relaxed/simple;
	bh=5NOaIifm7hiIe5OARt5/1ZQC2aFx/UpJVSSRsVFL3rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nz/0xkqpJtrVjE41DcQ3AK2yM51PXBqRwKrnfIEhSSWOtEt2/mQKoEBdokMhxo6C3Sg9XXlcubzXwOIZ/ixbSA/xpX32RDsLR3/4gddMoOX4TYqx+nI+OMkn8/89EYn6HvfCSR1VafZtGlu4a22OOLa1+MLcxPZgUnJ6+sTAJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNd55fGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C6DC4CED3;
	Thu, 23 Jan 2025 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737670453;
	bh=5NOaIifm7hiIe5OARt5/1ZQC2aFx/UpJVSSRsVFL3rs=;
	h=From:To:Cc:Subject:Date:From;
	b=eNd55fGZ/aHpyDrH9pDqhAItm9xzzPuRAUqRWD1DGzgTxroHK8nfE76X8co6fXTQY
	 VkoKCfMA4FuXb8p58D0b1zZ0DsKgcqNGlRqMHbQB0AksIaqsFbvxZRbCbIWwuw0ajS
	 HnxzjMGODre5NCcQ5nNXou++QlBgWR8zkYYtT27Fzp5ZVkqe7KRrdt84bW1UClvA82
	 zxQ/xSyLt8nGqBvpw91PjXlk/dutg0hzHAJ0K2rMxeDtaVERw6Dp2n84SiW+D40ooF
	 G+4Bk03/ENZTnP5P4AEmK+Le5D79dD0Omr13gy4876iJQtA2LS0RvvaaWs2V4iGUrq
	 85JKrwjWyuFpA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+b3bcd80232d00091e061@syzkaller.appspotmail.com
Subject: [PATCH net] netdevsim: don't assume core pre-populates HDS params on GET
Date: Thu, 23 Jan 2025 14:14:10 -0800
Message-ID: <20250123221410.1067678-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reports:

  BUG: KMSAN: uninit-value in nsim_get_ringparam+0xa8/0xe0 drivers/net/netdevsim/ethtool.c:77
   nsim_get_ringparam+0xa8/0xe0 drivers/net/netdevsim/ethtool.c:77
   ethtool_set_ringparam+0x268/0x570 net/ethtool/ioctl.c:2072
   __dev_ethtool net/ethtool/ioctl.c:3209 [inline]
   dev_ethtool+0x126d/0x2a40 net/ethtool/ioctl.c:3398
   dev_ioctl+0xb0e/0x1280 net/core/dev_ioctl.c:759

This is the SET path, where we call GET to either check user request
against max values, or check if any of the settings will change.

The logic in netdevsim is trying to report the default (ENABLED)
if user has not requested any specific setting. The user setting
is recorded in dev->cfg, don't depend on kernel_ringparam being
pre-populated with it.

Fixes: 928459bbda19 ("net: ethtool: populate the default HDS params in the core")
Reported-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+b3bcd80232d00091e061@syzkaller.appspotmail.com
Tested-by: syzbot+b3bcd80232d00091e061@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 3b23f3d3ca2b..5c80fbee7913 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -74,7 +74,7 @@ static void nsim_get_ringparam(struct net_device *dev,
 	memcpy(ring, &ns->ethtool.ring, sizeof(ns->ethtool.ring));
 	kernel_ring->hds_thresh_max = NSIM_HDS_THRESHOLD_MAX;
 
-	if (kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
+	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
 		kernel_ring->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
 }
 
-- 
2.48.1


