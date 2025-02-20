Return-Path: <netdev+bounces-167934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF618A3CE45
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 01:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09B6188F071
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E732AE66;
	Thu, 20 Feb 2025 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VccPGti4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC623214
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012820; cv=none; b=UvJFnLmEIl2T787AhFxoHn9JHR8Xa1JdE8jv/8pXezF5oa1xCYxFv6rG1irRjvrDbwvi/kfyBonUlQYABvvKmJLWmGMtP/FiasXvjm8Fwve2NsG+FQrh9W7EgWGRwHNcgh7Xy4qtO0Hj79re3aNCz7Mu8IJSDZyBsryR/TVe6UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012820; c=relaxed/simple;
	bh=EH+cjVsNpn4d0275w+cmO6LgTbGFirrnZ/HHB4De2w8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0nMUAbc8r+FVlBvutSKpau5wGPGUEVK+A6oCDWFfu899jqUGdD3PVK5bmVWf1lZ6o8tF1Euom3Acdb9elDtZq0BQbVITGYubnWE2fAtaQlHTZjAsdDlUEExeopV+y/g3NyOZ2rxG2zk+ABtyAlwS4aIM3dgq1VfJZuasD1yawE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VccPGti4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E56C4CED1;
	Thu, 20 Feb 2025 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740012820;
	bh=EH+cjVsNpn4d0275w+cmO6LgTbGFirrnZ/HHB4De2w8=;
	h=From:To:Cc:Subject:Date:From;
	b=VccPGti4ufC6wL4UJtLuGucUwU6In6pcinVStJPRv3c2hjP6PTXt9pxDZ5c/F6RT1
	 +2WaK36+PCNe50xtdBpZC8Zm9NRbM0tFbW2mfHHz62BWVdZU04WiUsiCxzJ46BDNkM
	 KbsHMjouSd4w8pzzgHTtkEgACuUoy8xouUyxWx2wVtGH/WHg+YK98EnrkfyJl2p5I1
	 9QskGWftG9bubiIlHdvEqpKJX9K53XSgFJYhdhOGSbvD/LkIkwpYANJs3yJ3Xukidv
	 gw1hVxhbmfCz49fSOLjpKYQi1CpSWDZwyQ37nqU30i6Ylgm4INYI+BPe7T0e+izq6K
	 DZJ0rAHCAlpLQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dxu@dxuuu.xyz,
	Jakub Kicinski <kuba@kernel.org>,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ap420073@gmail.com
Subject: [PATCH net 1/2] bnxt: don't reject XDP installation when HDS isn't forced on
Date: Wed, 19 Feb 2025 16:53:17 -0800
Message-ID: <20250220005318.560733-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDS flag is often set because GRO-HW is enabled. But we call
bnxt_set_rx_skb_mode() later, which will clear it. So make
sure we reject XDP when user asked for HDS, not when it's
enabled for other reasons.

Fixes: 87c8f8496a05 ("bnxt_en: add support for tcp-data-split ethtool command")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: daniel@iogearbox.net
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
CC: ap420073@gmail.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index e6c64e4bd66c..ff208c4b7d70 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -11,10 +11,12 @@
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/if_vlan.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/filter.h>
+#include <net/netdev_queues.h>
 #include <net/page_pool/helpers.h>
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -395,7 +397,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 			    bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
 		return -EOPNOTSUPP;
 	}
-	if (prog && bp->flags & BNXT_FLAG_HDS) {
+	if (prog && dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
 		netdev_warn(dev, "XDP is disallowed when HDS is enabled.\n");
 		return -EOPNOTSUPP;
 	}
-- 
2.48.1


