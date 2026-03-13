Return-Path: <netdev+bounces-267301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PMSLi+5s2nbaAAAu9opvQ
	(envelope-from <netdev+bounces-267301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:13:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFFE27EA2F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3471301075B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56670366836;
	Fri, 13 Mar 2026 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH6Lo08m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B23659F6;
	Fri, 13 Mar 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773386015; cv=none; b=h6rl9MNd4aPZK7PM8wvdyV2PHOFiYAX7u/D6KEG3Q7UvB2Dr0a6I5WXee7Jg5b+ZsqWoFnU6yjbJnqQ8GX3dS/PofSNlMSye3T4YHprmmRQm2f//S0PgGUto20EkVEuJOR5wZYqglhEM9MixS/2+RZBoqD9+f5B+G+cn2kF/y1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773386015; c=relaxed/simple;
	bh=FvJKbZgamfnmKxUUtbTe6ppykVXHPJ9khlH2c7HuyFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMKWQtlDHtAhvLoSbZfgILaEiMyIYO5MplNRiRmQPUut8Ph/5OxF3wUTldXYFKqwn1k4L0OGVMdG/ZKf+PlZYUMxsoOgr3+SYVE3oOiS/3LbzyH5Y5lXaj/gDlGzLyZDog8GQh0Tjb7f/CK/zX7iUk6lAujATPSpOoXx1GWCftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH6Lo08m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B9CC19421;
	Fri, 13 Mar 2026 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773386014;
	bh=FvJKbZgamfnmKxUUtbTe6ppykVXHPJ9khlH2c7HuyFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pH6Lo08mqjF7QTecEZ4CIHrBUp56jSoLLUM2WWgLh7IzTkBymGtvlcgi8VIpRSeiO
	 8HvpY8D9mPNW8EHGGCSwUezw19bxWPomL0NQyMEJlzeQ5+9ZTG92fi1uegcuVizfBs
	 mdHRI30Nd2YljSyPxOMdlvBHZBN+3vHGkhCdMyTaMvhNjghLyaspg1K0lro12cl7eV
	 F2CIq+5vgfj7b7wUce6jJLQ8IdqnHyKXBGrxjmlpwtkLJGhrm/uUJZTqNbN45hCrMq
	 MNFwNV/G/1Ivc27LJvlRQOHQQIiwOD05jrUwyonmXdsQIogWeakOgfc4HY0To5P2lp
	 /cMlGyE3iKZGA==
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
Subject: [PATCH net-next v4 1/3] ethtool: Add RSS indirection table resize helpers
Date: Fri, 13 Mar 2026 08:13:13 +0100
Message-ID: <20260313071322.3489243-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313071322.3489243-1-bjorn@kernel.org>
References: <20260313071322.3489243-1-bjorn@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-267301-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: BBFFE27EA2F
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

ethtool_rxfh_ctxs_can_resize() validates all non-default RSS contexts
can be resized. ethtool_rxfh_ctxs_resize() applies the resize and
sends ETHTOOL_MSG_RSS_NTF per resized context after releasing
rss_lock.

No reallocation is needed because ethtool_rxfh_ctx_alloc() reserves
space for rxfh_indir_space entries, and key_off is based on that
maximum.

Tested-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/ethtool.h |   4 ++
 net/ethtool/common.c    | 143 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 83c375840835..e2c4aa0a3348 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -214,6 +214,10 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 }
 
 void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
+bool ethtool_rxfh_can_resize(const u32 *tbl, u32 old_size, u32 new_size);
+int ethtool_rxfh_resize(u32 *tbl, u32 old_size, u32 new_size);
+int ethtool_rxfh_ctxs_can_resize(struct net_device *dev, u32 new_indir_size);
+void ethtool_rxfh_ctxs_resize(struct net_device *dev, u32 new_indir_size);
 
 struct link_mode_info {
 	int	speed;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index e252cf20c22f..ad6056297479 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -1204,6 +1204,149 @@ void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id)
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
+ *
+ * Validate that @tbl can be resized from @old_size to @new_size without
+ * data loss. Read-only; does not modify the table.
+ *
+ * Return: true if resize is possible, false otherwise.
+ */
+bool ethtool_rxfh_can_resize(const u32 *tbl, u32 old_size, u32 new_size)
+{
+	if (new_size == old_size)
+		return true;
+
+	if (new_size < old_size) {
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
+ *
+ * Resize an RSS indirection table in place. When folding (shrinking),
+ * the table must be periodic with period @new_size; otherwise the
+ * operation is rejected. When unfolding (growing), the existing
+ * pattern is replicated. Both directions require the sizes to be
+ * multiples of each other.
+ *
+ * Return: 0 on success, -%EINVAL on failure (no mutation on failure).
+ */
+int ethtool_rxfh_resize(u32 *tbl, u32 old_size, u32 new_size)
+{
+	if (!ethtool_rxfh_can_resize(tbl, old_size, new_size))
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
+					     new_indir_size)) {
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
-- 
2.53.0


