Return-Path: <netdev+bounces-148989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5B79E3BAD
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C62163DB8
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C831BBBD7;
	Wed,  4 Dec 2024 13:51:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AD1AF0C6
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320283; cv=none; b=OOl1PjF4hcSMZzXzfJi/muHqdxbcV20d/PX7hdLOE/yKBYDOdQ7UI25ripPZHCSXUi5bRuYDmbdXcbjSB6zqZgnfrNCFMFrCinbuhSdD+++jh9AXaIVnd1IxkSUT/ZNMoLUm4x2Rb4pLf+d9pdMtJ/6jfUGcghZGm1374JTHS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320283; c=relaxed/simple;
	bh=4/iY0f+algWqbjlcrCEq9/HqzByTZcj67eoyGs58ghc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d5qGHMUgjJF2CuQUS2RU22ROH85s6y6MxUBx1gQmju359GLNYLwQa1gYIEqe0gjx0llXAE3eUMN2wXaAhVpB/xmt4d5ilkcM/AMzXALLdIM5x/3tYM8g4741sKhHQWCeds48x8fdZjeZd4ClsRxIHHiUCMReX88uIyAbDPOjDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 4B4Dp7RS022573;
	Wed, 4 Dec 2024 05:51:08 -0800
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, andrew+netdev@lunn.ch,
        pabeni@redhat.com, bharat@chelsio.com,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>
Subject: [PATCH net-next] cxgb4: add driver support for FW_CLIP2_CMD
Date: Wed,  4 Dec 2024 19:24:16 +0530
Message-Id: <20241204135416.14041-1-anumula@chelsio.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Query firmware for FW_CLIP2_CMD support and enable it. FW_CLIP2_CMD
will be used for setting LIP mask for the corresponding entry in the
CLIP table. If no LIP mask is specified, a default value of ~0 is
written for mask.

Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c | 146 ++++++++++++++----
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h |   6 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   1 +
 .../net/ethernet/chelsio/cxgb4/cxgb4_filter.c |  23 ++-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |   3 +
 drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h |  12 ++
 6 files changed, 152 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
index 5060d3998889..8da9e7fe7f65 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
@@ -18,6 +18,8 @@
 #include "cxgb4.h"
 #include "clip_tbl.h"
 
+static const u64 clip_ipv6_exact_mask[2] = { ~0, ~0 };
+
 static inline unsigned int ipv4_clip_hash(struct clip_tbl *c, const u32 *key)
 {
 	unsigned int clipt_size_half = c->clipt_size / 2;
@@ -42,36 +44,73 @@ static unsigned int clip_addr_hash(struct clip_tbl *ctbl, const u32 *addr,
 }
 
 static int clip6_get_mbox(const struct net_device *dev,
-			  const struct in6_addr *lip)
+			  const struct in6_addr *lip,
+			  const struct in6_addr *lipm)
 {
 	struct adapter *adap = netdev2adap(dev);
-	struct fw_clip_cmd c;
+	struct fw_clip2_cmd c;
+
+	if (!adap->params.clip2_cmd_support) {
+		struct fw_clip_cmd old_cmd;
+
+		memset(&old_cmd, 0, sizeof(old_cmd));
+		old_cmd.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP_CMD) |
+					    FW_CMD_REQUEST_F | FW_CMD_WRITE_F);
+		old_cmd.alloc_to_len16 = htonl(FW_CLIP_CMD_ALLOC_F |
+					       FW_LEN16(old_cmd));
+		*(__be64 *)&old_cmd.ip_hi = *(__be64 *)(lip->s6_addr);
+		*(__be64 *)&old_cmd.ip_lo = *(__be64 *)(lip->s6_addr + 8);
+
+		return t4_wr_mbox_meat(adap, adap->mbox, &old_cmd,
+				       sizeof(old_cmd), &old_cmd, false);
+	}
 
 	memset(&c, 0, sizeof(c));
-	c.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP_CMD) |
+	c.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP2_CMD) |
 			      FW_CMD_REQUEST_F | FW_CMD_WRITE_F);
 	c.alloc_to_len16 = htonl(FW_CLIP_CMD_ALLOC_F | FW_LEN16(c));
 	*(__be64 *)&c.ip_hi = *(__be64 *)(lip->s6_addr);
 	*(__be64 *)&c.ip_lo = *(__be64 *)(lip->s6_addr + 8);
+	*(__be64 *)&c.ipm_hi = *(__be64 *)(lipm->s6_addr);
+	*(__be64 *)&c.ipm_lo = *(__be64 *)(lipm->s6_addr + 8);
 	return t4_wr_mbox_meat(adap, adap->mbox, &c, sizeof(c), &c, false);
 }
 
 static int clip6_release_mbox(const struct net_device *dev,
-			      const struct in6_addr *lip)
+			      const struct in6_addr *lip,
+			      const struct in6_addr *lipm)
 {
 	struct adapter *adap = netdev2adap(dev);
-	struct fw_clip_cmd c;
+	struct fw_clip2_cmd c;
+
+	if (!adap->params.clip2_cmd_support) {
+		struct fw_clip_cmd old_cmd;
+
+		memset(&old_cmd, 0, sizeof(old_cmd));
+		old_cmd.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP_CMD) |
+					    FW_CMD_REQUEST_F | FW_CMD_WRITE_F);
+		old_cmd.alloc_to_len16 = htonl(FW_CLIP_CMD_FREE_F |
+					       FW_LEN16(old_cmd));
+		*(__be64 *)&old_cmd.ip_hi = *(__be64 *)(lip->s6_addr);
+		*(__be64 *)&old_cmd.ip_lo = *(__be64 *)(lip->s6_addr + 8);
+
+		return t4_wr_mbox_meat(adap, adap->mbox, &old_cmd,
+				       sizeof(old_cmd), &old_cmd, false);
+	}
 
 	memset(&c, 0, sizeof(c));
-	c.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP_CMD) |
-			      FW_CMD_REQUEST_F | FW_CMD_READ_F);
+	c.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP2_CMD) |
+			      FW_CMD_REQUEST_F | FW_CMD_WRITE_F);
 	c.alloc_to_len16 = htonl(FW_CLIP_CMD_FREE_F | FW_LEN16(c));
 	*(__be64 *)&c.ip_hi = *(__be64 *)(lip->s6_addr);
 	*(__be64 *)&c.ip_lo = *(__be64 *)(lip->s6_addr + 8);
+	*(__be64 *)&c.ipm_hi = *(__be64 *)(lipm->s6_addr);
+	*(__be64 *)&c.ipm_lo = *(__be64 *)(lipm->s6_addr + 8);
+
 	return t4_wr_mbox_meat(adap, adap->mbox, &c, sizeof(c), &c, false);
 }
 
-int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
+static int clip_get(const struct net_device *dev, const u32 *lip, const u32 *lipm, u8 v6)
 {
 	struct adapter *adap = netdev2adap(dev);
 	struct clip_tbl *ctbl = adap->clipt;
@@ -82,17 +121,23 @@ int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
 
 	if (!ctbl)
 		return 0;
+	if (!lipm)
+		lipm = (const u32 *)clip_ipv6_exact_mask;
 
 	hash = clip_addr_hash(ctbl, addr, v6);
 
 	read_lock_bh(&ctbl->lock);
 	list_for_each_entry(cte, &ctbl->hash_list[hash], list) {
-		if (cte->addr6.sin6_family == AF_INET6 && v6)
-			ret = memcmp(lip, cte->addr6.sin6_addr.s6_addr,
-				     sizeof(struct in6_addr));
-		else if (cte->addr.sin_family == AF_INET && !v6)
-			ret = memcmp(lip, (char *)(&cte->addr.sin_addr),
-				     sizeof(struct in_addr));
+		if (cte->val.addr6.sin6_family == AF_INET6 && v6)
+			ret = (memcmp(lip, &cte->val.addr6.sin6_addr.s6_addr,
+				      sizeof(struct in6_addr)) ||
+			       memcmp(lipm, &cte->mask.addr6.sin6_addr.s6_addr,
+				      sizeof(struct in6_addr)));
+		else if (cte->val.addr.sin_family == AF_INET && !v6)
+			ret = (memcmp(lip, (char *)(&cte->val.addr.sin_addr),
+				      sizeof(struct in_addr)) ||
+			       memcmp(lipm, (char *)(&cte->mask.addr.sin_addr),
+				      sizeof(struct in_addr)));
 		if (!ret) {
 			ce = cte;
 			read_unlock_bh(&ctbl->lock);
@@ -112,22 +157,29 @@ int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
 		atomic_dec(&ctbl->nfree);
 		list_add_tail(&ce->list, &ctbl->hash_list[hash]);
 		if (v6) {
-			ce->addr6.sin6_family = AF_INET6;
-			memcpy(ce->addr6.sin6_addr.s6_addr,
+			ce->val.addr6.sin6_family = AF_INET6;
+			ce->mask.addr6.sin6_family = AF_INET6;
+			memcpy(ce->val.addr6.sin6_addr.s6_addr,
 			       lip, sizeof(struct in6_addr));
-			ret = clip6_get_mbox(dev, (const struct in6_addr *)lip);
+			memcpy(ce->mask.addr6.sin6_addr.s6_addr,
+			       lipm, sizeof(struct in6_addr));
+			ret = clip6_get_mbox(dev, (const struct in6_addr *)lip,
+					     (const struct in6_addr *)lipm);
 			if (ret) {
 				write_unlock_bh(&ctbl->lock);
 				dev_err(adap->pdev_dev,
 					"CLIP FW cmd failed with error %d, "
 					"Connections using %pI6c won't be "
 					"offloaded",
-					ret, ce->addr6.sin6_addr.s6_addr);
+					ret, ce->val.addr6.sin6_addr.s6_addr);
 				return ret;
 			}
 		} else {
-			ce->addr.sin_family = AF_INET;
-			memcpy((char *)(&ce->addr.sin_addr), lip,
+			ce->val.addr.sin_family = AF_INET;
+			ce->mask.addr.sin_family = AF_INET;
+			memcpy((char *)(&ce->val.addr.sin_addr), lip,
+			       sizeof(struct in_addr));
+			memcpy((char *)(&ce->mask.addr.sin_addr), lipm,
 			       sizeof(struct in_addr));
 		}
 	} else {
@@ -141,9 +193,20 @@ int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
 	refcount_set(&ce->refcnt, 1);
 	return 0;
 }
+
+int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
+{
+	return clip_get(dev, lip, NULL, v6);
+}
 EXPORT_SYMBOL(cxgb4_clip_get);
 
-void cxgb4_clip_release(const struct net_device *dev, const u32 *lip, u8 v6)
+int cxgb4_clip_get_filter(const struct net_device *dev, const u32 *lip,
+			  const u32 *lipm, u8 v6)
+{
+	return clip_get(dev, lip, lipm, v6);
+}
+
+static void clip_release(const struct net_device *dev, const u32 *lip, const u32 *lipm, u8 v6)
 {
 	struct adapter *adap = netdev2adap(dev);
 	struct clip_tbl *ctbl = adap->clipt;
@@ -154,17 +217,23 @@ void cxgb4_clip_release(const struct net_device *dev, const u32 *lip, u8 v6)
 
 	if (!ctbl)
 		return;
+	if (!lipm)
+		lipm = (const u32 *)clip_ipv6_exact_mask;
 
 	hash = clip_addr_hash(ctbl, addr, v6);
 
 	read_lock_bh(&ctbl->lock);
 	list_for_each_entry(cte, &ctbl->hash_list[hash], list) {
-		if (cte->addr6.sin6_family == AF_INET6 && v6)
-			ret = memcmp(lip, cte->addr6.sin6_addr.s6_addr,
-				     sizeof(struct in6_addr));
-		else if (cte->addr.sin_family == AF_INET && !v6)
-			ret = memcmp(lip, (char *)(&cte->addr.sin_addr),
-				     sizeof(struct in_addr));
+		if (cte->val.addr6.sin6_family == AF_INET6 && v6)
+			ret = (memcmp(lip, &cte->val.addr6.sin6_addr.s6_addr,
+				      sizeof(struct in6_addr)) ||
+			       memcmp(lipm, &cte->mask.addr6.sin6_addr.s6_addr,
+				      sizeof(struct in6_addr)));
+		else if (cte->val.addr.sin_family == AF_INET && !v6)
+			ret = (memcmp(lip, (char *)(&cte->val.addr.sin_addr),
+				      sizeof(struct in_addr)) ||
+			       memcmp(lipm, (char *)(&cte->mask.addr.sin_addr),
+				      sizeof(struct in_addr)));
 		if (!ret) {
 			ce = cte;
 			read_unlock_bh(&ctbl->lock);
@@ -182,13 +251,25 @@ void cxgb4_clip_release(const struct net_device *dev, const u32 *lip, u8 v6)
 		list_add_tail(&ce->list, &ctbl->ce_free_head);
 		atomic_inc(&ctbl->nfree);
 		if (v6)
-			clip6_release_mbox(dev, (const struct in6_addr *)lip);
+			clip6_release_mbox(dev, (const struct in6_addr *)lip,
+					   (const struct in6_addr *)lipm);
 	}
 	spin_unlock_bh(&ce->lock);
 	write_unlock_bh(&ctbl->lock);
 }
+
+void cxgb4_clip_release(const struct net_device *dev, const u32 *lip, u8 v6)
+{
+	return clip_release(dev, lip, NULL, v6);
+}
 EXPORT_SYMBOL(cxgb4_clip_release);
 
+void cxgb4_clip_release_filter(const struct net_device *dev, const u32 *lip,
+			       const u32 *lipm, u8 v6)
+{
+	return clip_release(dev, lip, lipm, v6);
+}
+
 /* Retrieves IPv6 addresses from a root device (bond, vlan) associated with
  * a physical device.
  * The physical device reference is needed to send the actul CLIP command.
@@ -252,17 +333,18 @@ int clip_tbl_show(struct seq_file *seq, void *v)
 	struct adapter *adapter = seq->private;
 	struct clip_tbl *ctbl = adapter->clipt;
 	struct clip_entry *ce;
-	char ip[60];
+	char ip[96];
 	int i;
 
 	read_lock_bh(&ctbl->lock);
 
-	seq_puts(seq, "IP Address                  Users\n");
+	seq_printf(seq, "%-83s   %s\n", "IP Address / IP Mask", "Users");
 	for (i = 0 ; i < ctbl->clipt_size;  ++i) {
 		list_for_each_entry(ce, &ctbl->hash_list[i], list) {
 			ip[0] = '\0';
-			sprintf(ip, "%pISc", &ce->addr);
-			seq_printf(seq, "%-25s   %u\n", ip,
+			sprintf(ip, "%pISc / %pISc", &ce->val.addr,
+				&ce->mask.addr);
+			seq_printf(seq, "%-83s   %d\n", ip,
 				   refcount_read(&ce->refcnt));
 		}
 	}
diff --git a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h
index 847c7fc2bbd9..dea64bf828b5 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h
@@ -19,7 +19,7 @@ struct clip_entry {
 	union {
 		struct sockaddr_in addr;
 		struct sockaddr_in6 addr6;
-	};
+	} val, mask;
 };
 
 struct clip_tbl {
@@ -43,3 +43,7 @@ void cxgb4_clip_release(const struct net_device *dev, const u32 *lip, u8 v6);
 int clip_tbl_show(struct seq_file *seq, void *v);
 int cxgb4_update_root_dev_clip(struct net_device *dev);
 void t4_cleanup_clip_tbl(struct adapter *adap);
+int cxgb4_clip_get_filter(const struct net_device *dev, const u32 *lip,
+			  const u32 *lipm, u8 v6);
+void cxgb4_clip_release_filter(const struct net_device *dev, const u32 *lip,
+			       const u32 *lipm, u8 v6);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 75bd69ff61a8..86f46d79e6bc 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -487,6 +487,7 @@ struct adapter_params {
 	u8 mps_bg_map[MAX_NPORTS];	/* MPS Buffer Group Map */
 	bool write_w_imm_support;       /* FW supports WRITE_WITH_IMMEDIATE */
 	bool write_cmpl_support;        /* FW supports WRITE_CMPL */
+	bool clip2_cmd_support;
 };
 
 /* State needed to monitor the forward progress of SGE Ingress DMA activities
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index dd9e68465e69..4e456f34acbb 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -993,9 +993,10 @@ void clear_filter(struct adapter *adap, struct filter_entry *f)
 		t4_free_encap_mac_filt(adap, pi->viid,
 				       f->fs.val.ovlan & 0x1ff, 0);
 
-	if ((f->fs.hash || is_t6(adap->params.chip)) && f->fs.type)
-		cxgb4_clip_release(f->dev, (const u32 *)&f->fs.val.lip, 1);
-
+	if ((f->fs.hash || is_t6(adap->params.chip)) && f->fs.type) {
+		cxgb4_clip_release_filter(f->dev, (const u32 *)&f->fs.val.lip,
+					  (const u32 *)&f->fs.mask.lip, 1);
+	}
 	/* The zeroing of the filter rule below clears the filter valid,
 	 * pending, locked flags, l2t pointer, etc. so it's all we need for
 	 * this operation.
@@ -1463,7 +1464,13 @@ static int cxgb4_set_hash_filter(struct net_device *dev,
 
 	size = sizeof(struct cpl_t6_act_open_req);
 	if (f->fs.type) {
-		ret = cxgb4_clip_get(f->dev, (const u32 *)&f->fs.val.lip, 1);
+		struct ch_filter_specification *fs = &f->fs;
+
+		ret = cxgb4_clip_get_filter(f->dev,
+					    (const u32 *)&fs->val.lip,
+					    (const u32 *)&fs->mask.lip,
+					    1);
+
 		if (ret)
 			goto free_mps;
 
@@ -1494,7 +1501,8 @@ static int cxgb4_set_hash_filter(struct net_device *dev,
 	return 0;
 
 free_clip:
-	cxgb4_clip_release(f->dev, (const u32 *)&f->fs.val.lip, 1);
+	cxgb4_clip_release_filter(f->dev, (const u32 *)&f->fs.val.lip,
+				  (const u32 *)&f->fs.mask.lip, 1);
 
 free_mps:
 	if (f->fs.val.encap_vld && f->fs.val.ovlan_vld)
@@ -1666,7 +1674,10 @@ int __cxgb4_set_filter(struct net_device *dev, int ftid,
 	if (is_t6(adapter->params.chip) && fs->type &&
 	    ipv6_addr_type((const struct in6_addr *)fs->val.lip) !=
 	    IPV6_ADDR_ANY) {
-		ret = cxgb4_clip_get(dev, (const u32 *)&fs->val.lip, 1);
+		ret = cxgb4_clip_get_filter(dev,
+					    (const u32 *)&fs->val.lip,
+					    (const u32 *)&fs->mask.lip,
+					    1);
 		if (ret)
 			goto free_tid;
 	}
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 97a261d5357e..b0ef1d6a5d79 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5137,6 +5137,9 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 			      1, params, val);
 	adap->params.viid_smt_extn_support = (ret == 0 && val[0] != 0);
 
+	params[0] = FW_PARAM_DEV(CLIP2_CMD);
+	ret = t4_query_params(adap, adap->mbox, adap->pf, 0, 1, params, val);
+	adap->params.clip2_cmd_support = (!ret && val[0]);
 	/*
 	 * Get device capabilities so we can determine what resources we need
 	 * to manage.
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h b/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
index 2419459a0b85..c93072994f83 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
@@ -847,6 +847,7 @@ enum fw_cmd_opcodes {
 	FW_SCHED_CMD                   = 0x24,
 	FW_DEVLOG_CMD                  = 0x25,
 	FW_CLIP_CMD                    = 0x28,
+	FW_CLIP2_CMD                   = 0x29,
 	FW_PTP_CMD                     = 0x3e,
 	FW_HMA_CMD                     = 0x3f,
 	FW_LASTC2E_CMD                 = 0x40,
@@ -1226,6 +1227,16 @@ enum fw_memtype_cf {
 	FW_MEMTYPE_CF_HMA		= 0x7,
 };
 
+struct fw_clip2_cmd {
+	__be32 op_to_write;
+	__be32 alloc_to_len16;
+	__be64 ip_hi;
+	__be64 ip_lo;
+	__be64 ipm_hi;
+	__be64 ipm_lo;
+	__be32 r4[2];
+};
+
 struct fw_caps_config_cmd {
 	__be32 op_to_write;
 	__be32 cfvalid_to_len16;
@@ -1331,6 +1342,7 @@ enum fw_params_param_dev {
 	FW_PARAMS_PARAM_DEV_DBQ_TIMERTICK = 0x2A,
 	FW_PARAMS_PARAM_DEV_NUM_TM_CLASS = 0x2B,
 	FW_PARAMS_PARAM_DEV_FILTER = 0x2E,
+	FW_PARAMS_PARAM_DEV_CLIP2_CMD = 0x2F,
 	FW_PARAMS_PARAM_DEV_KTLS_HW = 0x31,
 };
 
-- 
2.39.3


