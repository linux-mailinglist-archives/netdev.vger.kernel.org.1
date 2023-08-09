Return-Path: <netdev+bounces-26020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9290B77674A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47871C21316
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F31E513;
	Wed,  9 Aug 2023 18:27:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576751E526
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CF9C07619;
	Wed,  9 Aug 2023 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691605621;
	bh=3+OArv/F4mz0eHrjYttg3xbdiZ11xELQJfMy4tvrYYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RY7ocZKsBrINfxs8u13RZBg1yjBE2iYfZ7ong2jIjeuUEfy8+/CN0PhRgSsz/+20i
	 D4+siBjcON/BUTy29OePR6ZKv3kBgud3afEq9euJ+r/k2NYjxcR8OmoiqgGH1iM0UK
	 p1zaC035Lw5brITYT5kczSIrdzsMQBhyqMpChDTkKMirHiOk4xXVTXoCtFG6uXINTo
	 by3Q9dlNxQ6P6XdAy1ZPI3K1+dd82yJKtCUfY1tCQ4tbH0Wq01lJ94nVJl3gcCmkdA
	 ijJgj6u8OcVWDRfvZy9GaptDc6xM77e9g+etlDY2gchLb2OaOrdJ3Knnpq+LL4Lr+6
	 VSXN8Cvt65N5A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	gal@nvidia.com,
	tariqt@nvidia.com,
	lucien.xin@gmail.com,
	f.fainelli@gmail.com,
	andrew@lunn.ch,
	vladimir.oltean@nxp.com,
	simon.horman@corigine.com,
	linux@rempel-privat.de,
	mkubecek@suse.cz
Subject: [PATCH net-next 10/10] ethtool: netlink: always pass genl_info to .prepare_data
Date: Wed,  9 Aug 2023 11:26:48 -0700
Message-ID: <20230809182648.1816537-11-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809182648.1816537-1-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We had a number of bugs in the past because developers forgot
to fully test dumps, which pass NULL as info to .prepare_data.
.prepare_data implementations would try to access info->extack
leading to a null-deref.

Now that dumps and notifications can access struct genl_info
we can pass it in, and remove the info null checks.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: gal@nvidia.com
CC: tariqt@nvidia.com
CC: lucien.xin@gmail.com
CC: f.fainelli@gmail.com
CC: andrew@lunn.ch
CC: vladimir.oltean@nxp.com
CC: simon.horman@corigine.com
CC: linux@rempel-privat.de
CC: mkubecek@suse.cz
CC: johannes@sipsolutions.net
---
 net/ethtool/channels.c    |  2 +-
 net/ethtool/coalesce.c    |  6 +++---
 net/ethtool/debug.c       |  2 +-
 net/ethtool/eee.c         |  2 +-
 net/ethtool/eeprom.c      |  9 ++++-----
 net/ethtool/features.c    |  2 +-
 net/ethtool/fec.c         |  2 +-
 net/ethtool/linkinfo.c    |  2 +-
 net/ethtool/linkmodes.c   |  2 +-
 net/ethtool/linkstate.c   |  2 +-
 net/ethtool/mm.c          |  2 +-
 net/ethtool/module.c      |  5 ++---
 net/ethtool/netlink.c     | 11 ++++++-----
 net/ethtool/netlink.h     |  2 +-
 net/ethtool/pause.c       |  5 ++---
 net/ethtool/phc_vclocks.c |  2 +-
 net/ethtool/plca.c        |  4 ++--
 net/ethtool/privflags.c   |  2 +-
 net/ethtool/pse-pd.c      |  6 +++---
 net/ethtool/rings.c       |  5 ++---
 net/ethtool/rss.c         |  3 ++-
 net/ethtool/stats.c       |  5 ++---
 net/ethtool/strset.c      |  2 +-
 net/ethtool/tsinfo.c      |  2 +-
 net/ethtool/wol.c         |  5 +++--
 25 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index 61c40e889a4d..7b4bbd674bae 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -24,7 +24,7 @@ const struct nla_policy ethnl_channels_get_policy[] = {
 
 static int channels_prepare_data(const struct ethnl_req_info *req_base,
 				 struct ethnl_reply_data *reply_base,
-				 struct genl_info *info)
+				 const struct genl_info *info)
 {
 	struct channels_reply_data *data = CHANNELS_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 01a59ce211c8..83112c1a71ae 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -59,10 +59,9 @@ const struct nla_policy ethnl_coalesce_get_policy[] = {
 
 static int coalesce_prepare_data(const struct ethnl_req_info *req_base,
 				 struct ethnl_reply_data *reply_base,
-				 struct genl_info *info)
+				 const struct genl_info *info)
 {
 	struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
-	struct netlink_ext_ack *extack = info ? info->extack : NULL;
 	struct net_device *dev = reply_base->dev;
 	int ret;
 
@@ -73,7 +72,8 @@ static int coalesce_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 	ret = dev->ethtool_ops->get_coalesce(dev, &data->coalesce,
-					     &data->kernel_coalesce, extack);
+					     &data->kernel_coalesce,
+					     info->extack);
 	ethnl_ops_complete(dev);
 
 	return ret;
diff --git a/net/ethtool/debug.c b/net/ethtool/debug.c
index e4369769817e..0b2dea56d461 100644
--- a/net/ethtool/debug.c
+++ b/net/ethtool/debug.c
@@ -23,7 +23,7 @@ const struct nla_policy ethnl_debug_get_policy[] = {
 
 static int debug_prepare_data(const struct ethnl_req_info *req_base,
 			      struct ethnl_reply_data *reply_base,
-			      struct genl_info *info)
+			      const struct genl_info *info)
 {
 	struct debug_reply_data *data = DEBUG_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index 42104bcb0e47..2853394d06a8 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -26,7 +26,7 @@ const struct nla_policy ethnl_eee_get_policy[] = {
 
 static int eee_prepare_data(const struct ethnl_req_info *req_base,
 			    struct ethnl_reply_data *reply_base,
-			    struct genl_info *info)
+			    const struct genl_info *info)
 {
 	struct eee_reply_data *data = EEE_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index 49c0a2a77f02..6209c3a9c8f7 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -51,8 +51,7 @@ static int fallback_set_params(struct eeprom_req_info *request,
 }
 
 static int eeprom_fallback(struct eeprom_req_info *request,
-			   struct eeprom_reply_data *reply,
-			   struct genl_info *info)
+			   struct eeprom_reply_data *reply)
 {
 	struct net_device *dev = reply->base.dev;
 	struct ethtool_modinfo modinfo = {0};
@@ -103,7 +102,7 @@ static int get_module_eeprom_by_page(struct net_device *dev,
 
 static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
 			       struct ethnl_reply_data *reply_base,
-			       struct genl_info *info)
+			       const struct genl_info *info)
 {
 	struct eeprom_reply_data *reply = MODULE_EEPROM_REPDATA(reply_base);
 	struct eeprom_req_info *request = MODULE_EEPROM_REQINFO(req_base);
@@ -124,7 +123,7 @@ static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret)
 		goto err_free;
 
-	ret = get_module_eeprom_by_page(dev, &page_data, info ? info->extack : NULL);
+	ret = get_module_eeprom_by_page(dev, &page_data, info->extack);
 	if (ret < 0)
 		goto err_ops;
 
@@ -140,7 +139,7 @@ static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
 	kfree(page_data.data);
 
 	if (ret == -EOPNOTSUPP)
-		return eeprom_fallback(request, reply, info);
+		return eeprom_fallback(request, reply);
 	return ret;
 }
 
diff --git a/net/ethtool/features.c b/net/ethtool/features.c
index 55d449a2d3fc..a79af8c25a07 100644
--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -35,7 +35,7 @@ static void ethnl_features_to_bitmap32(u32 *dest, netdev_features_t src)
 
 static int features_prepare_data(const struct ethnl_req_info *req_base,
 				 struct ethnl_reply_data *reply_base,
-				 struct genl_info *info)
+				 const struct genl_info *info)
 {
 	struct features_reply_data *data = FEATURES_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/fec.c b/net/ethtool/fec.c
index 0d9a3d153170..e7d3f2c352a3 100644
--- a/net/ethtool/fec.c
+++ b/net/ethtool/fec.c
@@ -92,7 +92,7 @@ fec_stats_recalc(struct fec_stat_grp *grp, struct ethtool_fec_stat *stats)
 
 static int fec_prepare_data(const struct ethnl_req_info *req_base,
 			    struct ethnl_reply_data *reply_base,
-			    struct genl_info *info)
+			    const struct genl_info *info)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(active_fec_modes) = {};
 	struct fec_reply_data *data = FEC_REPDATA(reply_base);
diff --git a/net/ethtool/linkinfo.c b/net/ethtool/linkinfo.c
index 310dfe63292a..5c317d23787b 100644
--- a/net/ethtool/linkinfo.c
+++ b/net/ethtool/linkinfo.c
@@ -23,7 +23,7 @@ const struct nla_policy ethnl_linkinfo_get_policy[] = {
 
 static int linkinfo_prepare_data(const struct ethnl_req_info *req_base,
 				 struct ethnl_reply_data *reply_base,
-				 struct genl_info *info)
+				 const struct genl_info *info)
 {
 	struct linkinfo_reply_data *data = LINKINFO_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/linkmodes.c b/net/ethtool/linkmodes.c
index 20165e07ef90..b2591db49f7d 100644
--- a/net/ethtool/linkmodes.c
+++ b/net/ethtool/linkmodes.c
@@ -27,7 +27,7 @@ const struct nla_policy ethnl_linkmodes_get_policy[] = {
 
 static int linkmodes_prepare_data(const struct ethnl_req_info *req_base,
 				  struct ethnl_reply_data *reply_base,
-				  struct genl_info *info)
+				  const struct genl_info *info)
 {
 	struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 2158c17a0b32..b2de2108b356 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -81,7 +81,7 @@ static int linkstate_get_link_ext_state(struct net_device *dev,
 
 static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 				  struct ethnl_reply_data *reply_base,
-				  struct genl_info *info)
+				  const struct genl_info *info)
 {
 	struct linkstate_reply_data *data = LINKSTATE_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
index 4058a557b5a4..2816bb23c3ad 100644
--- a/net/ethtool/mm.c
+++ b/net/ethtool/mm.c
@@ -27,7 +27,7 @@ const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1] = {
 
 static int mm_prepare_data(const struct ethnl_req_info *req_base,
 			   struct ethnl_reply_data *reply_base,
-			   struct genl_info *info)
+			   const struct genl_info *info)
 {
 	struct mm_reply_data *data = MM_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index e0d539b21423..ceb575efc290 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -38,10 +38,9 @@ static int module_get_power_mode(struct net_device *dev,
 
 static int module_prepare_data(const struct ethnl_req_info *req_base,
 			       struct ethnl_reply_data *reply_base,
-			       struct genl_info *info)
+			       const struct genl_info *info)
 {
 	struct module_reply_data *data = MODULE_REPDATA(reply_base);
-	struct netlink_ext_ack *extack = info ? info->extack : NULL;
 	struct net_device *dev = reply_base->dev;
 	int ret;
 
@@ -49,7 +48,7 @@ static int module_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
-	ret = module_get_power_mode(dev, data, extack);
+	ret = module_get_power_mode(dev, data, info->extack);
 	if (ret < 0)
 		goto out_complete;
 
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index f7b3171a0aad..5aa319c4279c 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -444,12 +444,12 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 				  const struct ethnl_dump_ctx *ctx,
-				  struct netlink_callback *cb)
+				  const struct genl_info *info)
 {
 	void *ehdr;
 	int ret;
 
-	ehdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+	ehdr = genlmsg_put(skb, info->snd_portid, info->snd_seq,
 			   &ethtool_genl_family, NLM_F_MULTI,
 			   ctx->ops->reply_cmd);
 	if (!ehdr)
@@ -457,7 +457,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 
 	ethnl_init_reply_data(ctx->reply_data, ctx->ops, dev);
 	rtnl_lock();
-	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, NULL);
+	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
 	rtnl_unlock();
 	if (ret < 0)
 		goto out;
@@ -495,7 +495,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 		dev_hold(dev);
 		rtnl_unlock();
 
-		ret = ethnl_default_dump_one(skb, dev, ctx, cb);
+		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
 
 		rtnl_lock();
 		dev_put(dev);
@@ -644,6 +644,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 				 const void *data)
 {
+	GENL_INFO_NTF(info, &ethtool_genl_family, cmd);
 	struct ethnl_reply_data *reply_data;
 	const struct ethnl_request_ops *ops;
 	struct ethnl_req_info *req_info;
@@ -670,7 +671,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 	req_info->flags |= ETHTOOL_FLAG_COMPACT_BITSETS;
 
 	ethnl_init_reply_data(reply_data, ops, dev);
-	ret = ops->prepare_data(req_info, reply_data, NULL);
+	ret = ops->prepare_data(req_info, reply_data, &info);
 	if (ret < 0)
 		goto err_cleanup;
 	ret = ops->reply_size(req_info, reply_data);
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 79424b34b553..9a333a8d04c1 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -355,7 +355,7 @@ struct ethnl_request_ops {
 			     struct netlink_ext_ack *extack);
 	int (*prepare_data)(const struct ethnl_req_info *req_info,
 			    struct ethnl_reply_data *reply_data,
-			    struct genl_info *info);
+			    const struct genl_info *info);
 	int (*reply_size)(const struct ethnl_req_info *req_info,
 			  const struct ethnl_reply_data *reply_data);
 	int (*fill_reply)(struct sk_buff *skb,
diff --git a/net/ethtool/pause.c b/net/ethtool/pause.c
index 6657d0b888d8..f7c847aeb1a2 100644
--- a/net/ethtool/pause.c
+++ b/net/ethtool/pause.c
@@ -51,10 +51,9 @@ static int pause_parse_request(struct ethnl_req_info *req_base,
 
 static int pause_prepare_data(const struct ethnl_req_info *req_base,
 			      struct ethnl_reply_data *reply_base,
-			      struct genl_info *info)
+			      const struct genl_info *info)
 {
 	const struct pause_req_info *req_info = PAUSE_REQINFO(req_base);
-	struct netlink_ext_ack *extack = info ? info->extack : NULL;
 	struct pause_reply_data *data = PAUSE_REPDATA(reply_base);
 	enum ethtool_mac_stats_src src = req_info->src;
 	struct net_device *dev = reply_base->dev;
@@ -74,7 +73,7 @@ static int pause_prepare_data(const struct ethnl_req_info *req_base,
 	if ((src == ETHTOOL_MAC_STATS_SRC_EMAC ||
 	     src == ETHTOOL_MAC_STATS_SRC_PMAC) &&
 	    !__ethtool_dev_mm_supported(dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
+		NL_SET_ERR_MSG_MOD(info->extack,
 				   "Device does not support MAC merge layer");
 		ethnl_ops_complete(dev);
 		return -EOPNOTSUPP;
diff --git a/net/ethtool/phc_vclocks.c b/net/ethtool/phc_vclocks.c
index 637b2f5297d5..cadaabed60bd 100644
--- a/net/ethtool/phc_vclocks.c
+++ b/net/ethtool/phc_vclocks.c
@@ -24,7 +24,7 @@ const struct nla_policy ethnl_phc_vclocks_get_policy[] = {
 
 static int phc_vclocks_prepare_data(const struct ethnl_req_info *req_base,
 				    struct ethnl_reply_data *reply_base,
-				    struct genl_info *info)
+				    const struct genl_info *info)
 {
 	struct phc_vclocks_reply_data *data = PHC_VCLOCKS_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index 5a8cab4df0c9..b238a1afe9ae 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -40,7 +40,7 @@ const struct nla_policy ethnl_plca_get_cfg_policy[] = {
 
 static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 				     struct ethnl_reply_data *reply_base,
-				     struct genl_info *info)
+				     const struct genl_info *info)
 {
 	struct plca_reply_data *data = PLCA_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
@@ -183,7 +183,7 @@ const struct nla_policy ethnl_plca_get_status_policy[] = {
 
 static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 					struct ethnl_reply_data *reply_base,
-					struct genl_info *info)
+					const struct genl_info *info)
 {
 	struct plca_reply_data *data = PLCA_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/privflags.c b/net/ethtool/privflags.c
index 23264a1ebf12..297be6a13ab9 100644
--- a/net/ethtool/privflags.c
+++ b/net/ethtool/privflags.c
@@ -57,7 +57,7 @@ static int ethnl_get_priv_flags_info(struct net_device *dev,
 
 static int privflags_prepare_data(const struct ethnl_req_info *req_base,
 				  struct ethnl_reply_data *reply_base,
-				  struct genl_info *info)
+				  const struct genl_info *info)
 {
 	struct privflags_reply_data *data = PRIVFLAGS_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 530b8b99e6df..cc478af77111 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -53,8 +53,8 @@ static int pse_get_pse_attributes(struct net_device *dev,
 }
 
 static int pse_prepare_data(const struct ethnl_req_info *req_base,
-			       struct ethnl_reply_data *reply_base,
-			       struct genl_info *info)
+			    struct ethnl_reply_data *reply_base,
+			    const struct genl_info *info)
 {
 	struct pse_reply_data *data = PSE_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
@@ -64,7 +64,7 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
-	ret = pse_get_pse_attributes(dev, info ? info->extack : NULL, data);
+	ret = pse_get_pse_attributes(dev, info->extack, data);
 
 	ethnl_ops_complete(dev);
 
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 1c4972526142..fb09f774ea01 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -24,10 +24,9 @@ const struct nla_policy ethnl_rings_get_policy[] = {
 
 static int rings_prepare_data(const struct ethnl_req_info *req_base,
 			      struct ethnl_reply_data *reply_base,
-			      struct genl_info *info)
+			      const struct genl_info *info)
 {
 	struct rings_reply_data *data = RINGS_REPDATA(reply_base);
-	struct netlink_ext_ack *extack = info ? info->extack : NULL;
 	struct net_device *dev = reply_base->dev;
 	int ret;
 
@@ -39,7 +38,7 @@ static int rings_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 	dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
-					&data->kernel_ringparam, extack);
+					&data->kernel_ringparam, info->extack);
 	ethnl_ops_complete(dev);
 
 	return 0;
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index be260ab34e58..5764202e6cb6 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -42,7 +42,8 @@ rss_parse_request(struct ethnl_req_info *req_info, struct nlattr **tb,
 
 static int
 rss_prepare_data(const struct ethnl_req_info *req_base,
-		 struct ethnl_reply_data *reply_base, struct genl_info *info)
+		 struct ethnl_reply_data *reply_base,
+		 const struct genl_info *info)
 {
 	struct rss_reply_data *data = RSS_REPDATA(reply_base);
 	struct rss_req_info *request = RSS_REQINFO(req_base);
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 010ed19ccc99..912f0c4fff2f 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -114,10 +114,9 @@ static int stats_parse_request(struct ethnl_req_info *req_base,
 
 static int stats_prepare_data(const struct ethnl_req_info *req_base,
 			      struct ethnl_reply_data *reply_base,
-			      struct genl_info *info)
+			      const struct genl_info *info)
 {
 	const struct stats_req_info *req_info = STATS_REQINFO(req_base);
-	struct netlink_ext_ack *extack = info ? info->extack : NULL;
 	struct stats_reply_data *data = STATS_REPDATA(reply_base);
 	enum ethtool_mac_stats_src src = req_info->src;
 	struct net_device *dev = reply_base->dev;
@@ -130,7 +129,7 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	if ((src == ETHTOOL_MAC_STATS_SRC_EMAC ||
 	     src == ETHTOOL_MAC_STATS_SRC_PMAC) &&
 	    !__ethtool_dev_mm_supported(dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
+		NL_SET_ERR_MSG_MOD(info->extack,
 				   "Device does not support MAC merge layer");
 		ethnl_ops_complete(dev);
 		return -EOPNOTSUPP;
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index 3f7de54d85fb..c678b484a079 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -274,7 +274,7 @@ static int strset_prepare_set(struct strset_info *info, struct net_device *dev,
 
 static int strset_prepare_data(const struct ethnl_req_info *req_base,
 			       struct ethnl_reply_data *reply_base,
-			       struct genl_info *info)
+			       const struct genl_info *info)
 {
 	const struct strset_req_info *req_info = STRSET_REQINFO(req_base);
 	struct strset_reply_data *data = STRSET_REPDATA(reply_base);
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 63b5814bd460..9daed0aab162 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -25,7 +25,7 @@ const struct nla_policy ethnl_tsinfo_get_policy[] = {
 
 static int tsinfo_prepare_data(const struct ethnl_req_info *req_base,
 			       struct ethnl_reply_data *reply_base,
-			       struct genl_info *info)
+			       const struct genl_info *info)
 {
 	struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
index a4a43d9e6e9d..5f2bc8e549af 100644
--- a/net/ethtool/wol.c
+++ b/net/ethtool/wol.c
@@ -24,7 +24,7 @@ const struct nla_policy ethnl_wol_get_policy[] = {
 
 static int wol_prepare_data(const struct ethnl_req_info *req_base,
 			    struct ethnl_reply_data *reply_base,
-			    struct genl_info *info)
+			    const struct genl_info *info)
 {
 	struct wol_reply_data *data = WOL_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
@@ -39,7 +39,8 @@ static int wol_prepare_data(const struct ethnl_req_info *req_base,
 	dev->ethtool_ops->get_wol(dev, &data->wol);
 	ethnl_ops_complete(dev);
 	/* do not include password in notifications */
-	data->show_sopass = info && (data->wol.supported & WAKE_MAGICSECURE);
+	data->show_sopass = genl_info_is_ntf(info) &&
+		(data->wol.supported & WAKE_MAGICSECURE);
 
 	return 0;
 }
-- 
2.41.0


