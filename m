Return-Path: <netdev+bounces-268488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kELHBvsRuWmFowEAu9opvQ
	(envelope-from <netdev+bounces-268488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:34:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 065062A5B88
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 529813004CA9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C834F486;
	Tue, 17 Mar 2026 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRbg76ae"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3633DEE6;
	Tue, 17 Mar 2026 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736430; cv=none; b=A0iMS54/SN0OD8IU3g5fyLdIJ2PsTWvK2z6PnB+F4GZxwGpeFo+H/c924tAJ01pyneBDQ51P6ihFEqvEGr7n1789O3uaDGORt35iZFUcFIPrTFdn6Hy5UKkAeRSWbHPc+Zy7SGgYGCJWB0a6p1bhp6drdp6dUzrNB0TnsWPNMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736430; c=relaxed/simple;
	bh=mDmrfSYZYwK3YQ3V0N8DsDfXL3bNzRnqnz5WvYb5Qo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZO3E8iOAC1E1Sc+qgqwIxjXKZt0LPsnC6l2y8lVnR9qQwHChZX1xM01MG8XvBQ0xHy7tnd68SXVC3ugUuICxjgio0Sxk7jw0LRXeWCdgr544e3UTNb9yvyugT0vDkCvnF2/HrfJ7l4JCw+0H8ljtM82TAE6u7nl7rCR60SIzBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRbg76ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF24C4CEF7;
	Tue, 17 Mar 2026 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773736429;
	bh=mDmrfSYZYwK3YQ3V0N8DsDfXL3bNzRnqnz5WvYb5Qo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRbg76aeYiBcEakThvW5h3g/ig2QbMipQJf2HIykQbbClfDGDIskub7YkVvPJkqnv
	 WY+XfL+bkZ0K0K/Cpd8vTRt1W+izrnyh8Rs2vC1fAWnu9DmX0kP02Vcrlrn/aYMHaT
	 IZpK1bhjUTHNeqLM16dCVRt2Dn+LEFnixXQ8xev9cNCLY6JEdzZmxSXOwWb5ig3kay
	 GAg0Kfq/yMPxLgpKIIRmUoCPdMwvi+rwQE/reCb23Zd9KaSp8g8LYmzydAXO1C9OME
	 V1aY1n30FlHFHSOoxsDQ+d8Sk3owj0Ir/XgcLpngHFeFg6tXfh3VU7DoLOOlgPqj63
	 8TV8En5QYMLZQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v5 1/3] ethtool: Add RSS indirection table resize helpers
Date: Tue, 17 Mar 2026 09:33:34 +0100
Message-ID: <20260317083339.2811865-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317083339.2811865-1-bjorn@kernel.org>
References: <20260317083339.2811865-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268488-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 065062A5B88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The core locks ctx->indir_size when an RSS context is created. Some
NICs (e.g. bnxt) change their indirection table size based on the
channel count, because the hardware table is a shared resource. This
forces drivers to reject channel changes when RSS contexts exist.

Add helpers to resize indirection tables:

ethtool_rxfh_can_resize() checks whether a table can be resized
without modifying it.

ethtool_rxfh_resize() resizes a raw u32 table in place. Folding
(shrink) requires the table to be periodic at the new size;
non-periodic tables are rejected. Unfolding (grow) replicates the
existing pattern. Sizes must be multiples of each other.

Both ethtool_rxfh_can_resize() and ethtool_rxfh_resize() take a
user_size parameter: the number of indirection table entries the user
originally provided. When shrinking, the table will not fold below
this floor.

ethtool_rxfh_ctxs_can_resize() validates all non-default RSS contexts
can be resized. ethtool_rxfh_ctxs_resize() applies the resize and
sends ETHTOOL_MSG_RSS_NTF per resized context after releasing
rss_lock.

No reallocation is needed because ethtool_rxfh_ctx_alloc() reserves
space for rxfh_indir_space entries, and key_off is based on that
maximum.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/ethtool.h |  11 +++
 net/ethtool/common.c    | 150 ++++++++++++++++++++++++++++++++++++++++
 net/ethtool/ioctl.c     |  15 ++--
 net/ethtool/rss.c       |  24 +++++--
 4 files changed, 190 insertions(+), 10 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 83c375840835..6283a8cf3004 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -182,10 +182,13 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
  *	of %RXH_XFRM_*.
  * @indir_configured: indir has been specified (at create time or subsequently)
  * @key_configured: hkey has been specified (at create time or subsequently)
+ * @indir_user_size: number of entries the user provided for the indirection
+ *	table.
  */
 struct ethtool_rxfh_context {
 	u32 indir_size;
 	u32 key_size;
+	u32 indir_user_size;
 	u16 priv_size;
 	u8 hfunc;
 	u8 input_xfrm;
@@ -214,6 +217,11 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 }
 
 void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
+bool ethtool_rxfh_can_resize(const u32 *tbl, u32 old_size, u32 new_size,
+			     u32 user_size);
+int ethtool_rxfh_resize(u32 *tbl, u32 old_size, u32 new_size, u32 user_size);
+int ethtool_rxfh_ctxs_can_resize(struct net_device *dev, u32 new_indir_size);
+void ethtool_rxfh_ctxs_resize(struct net_device *dev, u32 new_indir_size);
 
 struct link_mode_info {
 	int	speed;
@@ -1333,12 +1341,15 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  * @rss_ctx:		XArray of custom RSS contexts
  * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
  *			within RTNL.
+ * @rss_indir_user_size: number of indirection table entries the user
+ *			provided for the default (context 0) RSS table.
  * @wol_enabled:	Wake-on-LAN is enabled
  * @module_fw_flash_in_progress: Module firmware flashing is in progress.
  */
 struct ethtool_netdev_state {
 	struct xarray		rss_ctx;
 	struct mutex		rss_lock;
+	u32			rss_indir_user_size;
 	unsigned		wol_enabled:1;
 	unsigned		module_fw_flash_in_progress:1;
 };
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index e252cf20c22f..0f8b5c84aba6 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -1204,6 +1204,156 @@ void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id)
 }
 EXPORT_SYMBOL(ethtool_rxfh_context_lost);
 
+static bool rxfh_indir_is_periodic(const u32 *tbl, u32 old_size, u32 new_size)
+{
+	u32 i;
+
+	for (i = new_size; i < old_size; i++)
+		if (tbl[i] != tbl[i % new_size])
+			return false;
+	return true;
+}
+
+/**
+ * ethtool_rxfh_can_resize - Check if an indirection table can be resized
+ * @tbl: indirection table
+ * @old_size: current number of entries in the table
+ * @new_size: desired number of entries
+ * @user_size: number of entries the user configured (lower bound),
+ *
+ * Validate that @tbl can be resized from @old_size to @new_size without
+ * data loss. When shrinking, @new_size must not be smaller than @user_size.
+ * Read-only; does not modify the table.
+ *
+ * Return: true if resize is possible, false otherwise.
+ */
+bool ethtool_rxfh_can_resize(const u32 *tbl, u32 old_size, u32 new_size,
+			     u32 user_size)
+{
+	if (new_size == old_size)
+		return true;
+
+	if (new_size < old_size) {
+		if (user_size && new_size < user_size)
+			return false;
+		if (old_size % new_size)
+			return false;
+		if (!rxfh_indir_is_periodic(tbl, old_size, new_size))
+			return false;
+		return true;
+	}
+
+	if (new_size % old_size)
+		return false;
+	return true;
+}
+EXPORT_SYMBOL(ethtool_rxfh_can_resize);
+
+/* Resize without validation; caller must have called can_resize first */
+static void __ethtool_rxfh_resize(u32 *tbl, u32 old_size, u32 new_size)
+{
+	u32 i;
+
+	/* Grow: replicate existing pattern; shrink is a no-op on the data */
+	for (i = old_size; i < new_size; i++)
+		tbl[i] = tbl[i % old_size];
+}
+
+/**
+ * ethtool_rxfh_resize - Fold or unfold an indirection table
+ * @tbl: indirection table (must have room for max(old_size, new_size) entries)
+ * @old_size: current number of entries in the table
+ * @new_size: desired number of entries
+ * @user_size: number of entries the user configured (lower bound),
+ *
+ * Resize an RSS indirection table in place. When folding (shrinking),
+ * the table must be periodic with period @new_size and @new_size must
+ * not be smaller than @user_size.
+ * When unfolding (growing), the existing pattern is replicated. Both
+ * directions require the sizes to be multiples of each other.
+ *
+ * Return: 0 on success, -%EINVAL on failure (no mutation on failure).
+ */
+int ethtool_rxfh_resize(u32 *tbl, u32 old_size, u32 new_size, u32 user_size)
+{
+	if (!ethtool_rxfh_can_resize(tbl, old_size, new_size, user_size))
+		return -EINVAL;
+
+	__ethtool_rxfh_resize(tbl, old_size, new_size);
+	return 0;
+}
+EXPORT_SYMBOL(ethtool_rxfh_resize);
+
+/**
+ * ethtool_rxfh_ctxs_can_resize - Validate resize for all RSS contexts
+ * @dev: network device
+ * @new_indir_size: new indirection table size
+ *
+ * Validate that the indirection tables of all non-default RSS contexts
+ * can be resized to @new_indir_size. Read-only; does not modify any
+ * context. Intended to be paired with ethtool_rxfh_ctxs_resize().
+ *
+ * Return: 0 if all contexts can be resized, negative errno on failure.
+ */
+int ethtool_rxfh_ctxs_can_resize(struct net_device *dev,
+				 u32 new_indir_size)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+	int ret = 0;
+
+	if (!dev->ethtool_ops->rxfh_indir_space ||
+	    new_indir_size > dev->ethtool_ops->rxfh_indir_space)
+		return -EINVAL;
+
+	mutex_lock(&dev->ethtool->rss_lock);
+	xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
+		u32 *indir = ethtool_rxfh_context_indir(ctx);
+
+		if (!ethtool_rxfh_can_resize(indir, ctx->indir_size,
+					     new_indir_size,
+					     ctx->indir_user_size)) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+	}
+unlock:
+	mutex_unlock(&dev->ethtool->rss_lock);
+	return ret;
+}
+EXPORT_SYMBOL(ethtool_rxfh_ctxs_can_resize);
+
+/**
+ * ethtool_rxfh_ctxs_resize - Resize all RSS context indirection tables
+ * @dev: network device
+ * @new_indir_size: new indirection table size
+ *
+ * Resize the indirection table of every non-default RSS context to
+ * @new_indir_size. Caller must have validated with
+ * ethtool_rxfh_ctxs_can_resize() first. An %ETHTOOL_MSG_RSS_NTF is
+ * sent for each resized context.
+ *
+ * Notifications are sent outside the RSS lock to avoid holding the
+ * mutex during notification delivery.
+ */
+void ethtool_rxfh_ctxs_resize(struct net_device *dev, u32 new_indir_size)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+
+	mutex_lock(&dev->ethtool->rss_lock);
+	xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
+		__ethtool_rxfh_resize(ethtool_rxfh_context_indir(ctx),
+				      ctx->indir_size, new_indir_size);
+		ctx->indir_size = new_indir_size;
+	}
+	mutex_unlock(&dev->ethtool->rss_lock);
+
+	xa_for_each(&dev->ethtool->rss_ctx, context, ctx)
+		ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_NTF, context);
+}
+EXPORT_SYMBOL(ethtool_rxfh_ctxs_resize);
+
 enum ethtool_link_medium ethtool_str_to_medium(const char *str)
 {
 	int i;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index ff4b4780d6af..c60b92bf09a4 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1403,10 +1403,13 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 		goto out_unlock;
 
 	/* indicate whether rxfh was set to default */
-	if (user_size == 0)
+	if (user_size == 0) {
 		dev->priv_flags &= ~IFF_RXFH_CONFIGURED;
-	else
+		dev->ethtool->rss_indir_user_size = 0;
+	} else {
 		dev->priv_flags |= IFF_RXFH_CONFIGURED;
+		dev->ethtool->rss_indir_user_size = rxfh_dev.indir_size;
+	}
 
 out_unlock:
 	mutex_unlock(&dev->ethtool->rss_lock);
@@ -1720,10 +1723,13 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 
 	if (!rxfh_dev.rss_context) {
 		/* indicate whether rxfh was set to default */
-		if (rxfh.indir_size == 0)
+		if (rxfh.indir_size == 0) {
 			dev->priv_flags &= ~IFF_RXFH_CONFIGURED;
-		else if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
+			dev->ethtool->rss_indir_user_size = 0;
+		} else if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE) {
 			dev->priv_flags |= IFF_RXFH_CONFIGURED;
+			dev->ethtool->rss_indir_user_size = dev_indir_size;
+		}
 	}
 	/* Update rss_ctx tracking */
 	if (rxfh_dev.rss_delete) {
@@ -1736,6 +1742,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			ctx->indir_configured =
 				rxfh.indir_size &&
 				rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE;
+			ctx->indir_user_size = dev_indir_size;
 		}
 		if (rxfh_dev.key) {
 			memcpy(ethtool_rxfh_context_key(ctx), rxfh_dev.key,
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index da5934cceb07..93a0f1de4cee 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -618,7 +618,7 @@ ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 static int
 rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh,
-		   bool *reset, bool *mod)
+		   bool *reset, bool *mod, u32 *user_sizep)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr **tb = info->attrs;
@@ -685,6 +685,7 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 	}
 
 	*mod |= memcmp(rxfh->indir, data->indir_table, data->indir_size);
+	*user_sizep = user_size;
 
 	return 0;
 
@@ -833,6 +834,7 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct nlattr **tb = info->attrs;
 	struct rss_reply_data data = {};
 	const struct ethtool_ops *ops;
+	u32 indir_user_size = 0;
 	int ret;
 
 	ops = dev->ethtool_ops;
@@ -844,7 +846,8 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	rxfh.rss_context = request->rss_context;
 
-	ret = rss_set_prep_indir(dev, info, &data, &rxfh, &indir_reset, &mod);
+	ret = rss_set_prep_indir(dev, info, &data, &rxfh, &indir_reset, &mod,
+				 &indir_user_size);
 	if (ret)
 		goto exit_clean_data;
 	indir_mod = !!tb[ETHTOOL_A_RSS_INDIR];
@@ -889,12 +892,17 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		goto exit_unlock;
 
-	if (ctx)
+	if (ctx) {
 		rss_set_ctx_update(ctx, tb, &data, &rxfh);
-	else if (indir_reset)
+		if (indir_user_size)
+			ctx->indir_user_size = indir_user_size;
+	} else if (indir_reset) {
 		dev->priv_flags &= ~IFF_RXFH_CONFIGURED;
-	else if (indir_mod)
+		dev->ethtool->rss_indir_user_size = 0;
+	} else if (indir_mod) {
 		dev->priv_flags |= IFF_RXFH_CONFIGURED;
+		dev->ethtool->rss_indir_user_size = indir_user_size;
+	}
 
 exit_unlock:
 	mutex_unlock(&dev->ethtool->rss_lock);
@@ -998,6 +1006,7 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct rss_reply_data data = {};
 	const struct ethtool_ops *ops;
 	struct rss_req_info req = {};
+	u32 indir_user_size = 0;
 	struct net_device *dev;
 	struct sk_buff *rsp;
 	void *hdr;
@@ -1034,7 +1043,8 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto exit_ops;
 
-	ret = rss_set_prep_indir(dev, info, &data, &rxfh, &indir_dflt, &mod);
+	ret = rss_set_prep_indir(dev, info, &data, &rxfh, &indir_dflt, &mod,
+				 &indir_user_size);
 	if (ret)
 		goto exit_clean_data;
 
@@ -1080,6 +1090,8 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	/* Store the config from rxfh to Xarray.. */
 	rss_set_ctx_update(ctx, tb, &data, &rxfh);
+	if (indir_user_size)
+		ctx->indir_user_size = indir_user_size;
 	/* .. copy from Xarray to data. */
 	__rss_prepare_ctx(dev, &data, ctx);
 
-- 
2.53.0


