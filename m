Return-Path: <netdev+bounces-108628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101BC924C53
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD791F21A5A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2952617A5B8;
	Tue,  2 Jul 2024 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxG2sKe8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036FD17A597
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964101; cv=none; b=IS+SuqMavdOC9rE6nK0+kkpibFkVppfNvE5A00xmbOMppUCNCUL6f7aG23Ox92MIFLVUOeDxWSucRloBeEIG/jH/J8uASlsOsEd2QcrFIagrmhDI792KJrsiyf6/Liph9BubWG7aVZkerH2xLF1bfGpdKEcGALPEreQF79F58/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964101; c=relaxed/simple;
	bh=++cfoAjTVGm8Eom4+oG2UqBRpCWMIa0OdK4+nFPK+fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltNq0wiaXgjqQDLeWwYXUfeO7nPCP50XmYPfRavOPt1akzS+OpwPDHVAMf+sYt2u51NyKaGWVB4vZBh60lm5ymCQ7aiSnpjDbpkgCBAiLxBIxyJIue1M1BDl/cdlgL8xXnYCMgzKHW93itv1R1cyJU22L+zr2tOrBISNUYIh17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxG2sKe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D127C32781;
	Tue,  2 Jul 2024 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964100;
	bh=++cfoAjTVGm8Eom4+oG2UqBRpCWMIa0OdK4+nFPK+fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxG2sKe8S3aMxMD2TLxebhaGMKeB+sklt3CKwgBExJRcHTyWYiOS+le+jXuAB/4lR
	 W6qQiALzmccJkdCa4EKz0y98DVzofY2LVZtZahAVPV31JRaXt90TPpiZQg7syckYYY
	 lj2NB/QpDkLbPqdt/cWsv31SUhWZ7eOA19JMXRUJAH93lO0t6RnTDRTvwJv1b+LvT/
	 wdC84SZZ1npR6On+b2MvB5HoaPPgK8Y4T8XhrkY0cF5cgtb01NhWWDYzXllgOof38h
	 psaJo+IGsT98ERnroiU8tZlaLLh5Ixnu+tuNRpSwJjuMFQUdgmvduHOcMkrzZ55qKk
	 +ObmSFauEVATA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/11] net: ethtool: let drivers remove lost RSS contexts
Date: Tue,  2 Jul 2024 16:47:46 -0700
Message-ID: <20240702234757.4188344-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702234757.4188344-1-kuba@kernel.org>
References: <20240702234757.4188344-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RSS contexts may get lost from a device, in various extreme circumstances.
Specifically if the firmware leaks resources and resets, or crashes and
either recovers in partially working state or the crash causes a
different FW version to run - creating the context again may fail.

Drivers should do their absolute best to prevent this from happening.
When it does, however, telling user that a context exists, when it can't
possibly be used any more is counter productive. Add a helper for
drivers to discard contexts. Print an error, in the future netlink
notification will also be sent.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/rss.c       | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f74bb0cf8ed1..3ce5be0d168a 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -210,6 +210,8 @@ static inline size_t ethtool_rxfh_context_size(u32 indir_size, u32 key_size,
 	return struct_size_t(struct ethtool_rxfh_context, data, flex_len);
 }
 
+void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
+
 /* declare a link mode bitmap */
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 71679137eff2..e2e5bab56a6b 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -159,3 +159,17 @@ const struct ethnl_request_ops ethnl_rss_request_ops = {
 	.fill_reply		= rss_fill_reply,
 	.cleanup_data		= rss_cleanup_data,
 };
+
+void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id)
+{
+	struct ethtool_rxfh_context *ctx;
+
+	WARN_ONCE(!rtnl_is_locked() &&
+		  !lockdep_is_held_type(&dev->ethtool->rss_lock, -1),
+		  "RSS context lock assertion failed\n");
+
+	netdev_err(dev, "device error, RSS context %d lost\n", context_id);
+	ctx = xa_erase(&dev->ethtool->rss_ctx, context_id);
+	kfree(ctx);
+}
+EXPORT_SYMBOL(ethtool_rxfh_context_lost);
-- 
2.45.2


