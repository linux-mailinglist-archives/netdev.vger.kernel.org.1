Return-Path: <netdev+bounces-208042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FEEB0986B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C251AA5E56
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142182550D2;
	Thu, 17 Jul 2025 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgpW+PgA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A282550CF
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795855; cv=none; b=OTwqXj4uUY1ps2Igj+Efg6NtmTb4/gFr6PYn6kPQggBSq21jBpuZKZ/t/+9DesQoMiE2s7tLfY937kelxrQWRib+qLsJpDSoGl2PJ0pNugysKAPUq6OUVtBl5S1EjnddVQXUssbELvjUgU7Ar/HMHokQJLT7boAzC163zhdCOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795855; c=relaxed/simple;
	bh=TyWWd2WaOkxopc1TUU3gezcy6kr0ptzeppYa5tyS5Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkEmbNap8ymmHuxfyc3qOLg99Pqnwx/oI4tLV6NLIlt8KKprTkpSDSu4f9EpKT0kjq65reLrhnIykQkHGm3MmpJ80dD616vF38VjWd44In9K+boZMzA6aT0IPUZ5eTyE0xRWTunQp18EFLSsUGjlJvXK6QMJWh+PjvE8J43EsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgpW+PgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3954FC4CEE3;
	Thu, 17 Jul 2025 23:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795854;
	bh=TyWWd2WaOkxopc1TUU3gezcy6kr0ptzeppYa5tyS5Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgpW+PgAxM7HGI6meXm0OsVhzEV060CSvILSFOU170EsAIb7mcK6C5oxTNvpzJqBn
	 PtBDs/qT2+aOaI6mkDLMByiFgVYym4byvGWOHQNtB+AMAJETYN37IEvJUpZbeVkShR
	 ZbA5HDOf9U9PMDYgMtuH3qvmfVw+OIO4o97EFl2h+thR1Z18HNiVfRhYHisOE5TML5
	 fMVy/HXJQoq0heYIFLKuvBHooudfN7apU+5COelT9v9Vr947RitIUli552fxhVoBSw
	 6FPF45/a3uGnvc89A3xM4D5UZlZUGOm/MCib6QGIn+NlgFS/pHjQjXSnFcht4F/DxC
	 D8qjUVWatZESg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/8] ethtool: move ethtool_rxfh_ctx_alloc() to common code
Date: Thu, 17 Jul 2025 16:43:40 -0700
Message-ID: <20250717234343.2328602-6-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717234343.2328602-1-kuba@kernel.org>
References: <20250717234343.2328602-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ethtool_rxfh_ctx_alloc() to common code, Netlink will need it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/common.h |  3 +++
 net/ethtool/common.c | 34 ++++++++++++++++++++++++++++++++++
 net/ethtool/ioctl.c  | 34 ----------------------------------
 3 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index c8385a268ced..c4d084dde5bf 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -43,6 +43,9 @@ bool convert_legacy_settings_to_link_ksettings(
 int ethtool_check_max_channel(struct net_device *dev,
 			      struct ethtool_channels channels,
 			      struct genl_info *info);
+struct ethtool_rxfh_context *
+ethtool_rxfh_ctx_alloc(const struct ethtool_ops *ops,
+		       u32 indir_size, u32 key_size);
 int ethtool_check_rss_ctx_busy(struct net_device *dev, u32 rss_context);
 int ethtool_rxfh_config_is_sym(u64 rxfh);
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 82afe0f2a7cd..2a1d40efb1fc 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -806,6 +806,40 @@ int ethtool_check_rss_ctx_busy(struct net_device *dev, u32 rss_context)
 	return rc;
 }
 
+struct ethtool_rxfh_context *
+ethtool_rxfh_ctx_alloc(const struct ethtool_ops *ops,
+		       u32 indir_size, u32 key_size)
+{
+	size_t indir_bytes, flex_len, key_off, size;
+	struct ethtool_rxfh_context *ctx;
+	u32 priv_bytes, indir_max;
+	u16 key_max;
+
+	key_max = max(key_size, ops->rxfh_key_space);
+	indir_max = max(indir_size, ops->rxfh_indir_space);
+
+	priv_bytes = ALIGN(ops->rxfh_priv_size, sizeof(u32));
+	indir_bytes = array_size(indir_max, sizeof(u32));
+
+	key_off = size_add(priv_bytes, indir_bytes);
+	flex_len = size_add(key_off, key_max);
+	size = struct_size_t(struct ethtool_rxfh_context, data, flex_len);
+
+	ctx = kzalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!ctx)
+		return NULL;
+
+	ctx->indir_size = indir_size;
+	ctx->key_size = key_size;
+	ctx->key_off = key_off;
+	ctx->priv_size = ops->rxfh_priv_size;
+
+	ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
+	ctx->input_xfrm = RXH_XFRM_NO_CHANGE;
+
+	return ctx;
+}
+
 /* Check if fields configured for flow hash are symmetric - if src is included
  * so is dst and vice versa.
  */
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index beb17f3671a2..c53868889969 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1473,40 +1473,6 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	return ret;
 }
 
-static struct ethtool_rxfh_context *
-ethtool_rxfh_ctx_alloc(const struct ethtool_ops *ops,
-		       u32 indir_size, u32 key_size)
-{
-	size_t indir_bytes, flex_len, key_off, size;
-	struct ethtool_rxfh_context *ctx;
-	u32 priv_bytes, indir_max;
-	u16 key_max;
-
-	key_max = max(key_size, ops->rxfh_key_space);
-	indir_max = max(indir_size, ops->rxfh_indir_space);
-
-	priv_bytes = ALIGN(ops->rxfh_priv_size, sizeof(u32));
-	indir_bytes = array_size(indir_max, sizeof(u32));
-
-	key_off = size_add(priv_bytes, indir_bytes);
-	flex_len = size_add(key_off, key_max);
-	size = struct_size_t(struct ethtool_rxfh_context, data, flex_len);
-
-	ctx = kzalloc(size, GFP_KERNEL_ACCOUNT);
-	if (!ctx)
-		return NULL;
-
-	ctx->indir_size = indir_size;
-	ctx->key_size = key_size;
-	ctx->key_off = key_off;
-	ctx->priv_size = ops->rxfh_priv_size;
-
-	ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
-	ctx->input_xfrm = RXH_XFRM_NO_CHANGE;
-
-	return ctx;
-}
-
 static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 					       void __user *useraddr)
 {
-- 
2.50.1


