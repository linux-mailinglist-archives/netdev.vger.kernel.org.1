Return-Path: <netdev+bounces-206022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6DB010F9
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880245C2BC9
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697AE16DC28;
	Fri, 11 Jul 2025 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuRQ4L5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458091684AC
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198821; cv=none; b=VBpvtQTzd9Bi5MqvNuMu+k9T9oqeAIJ8q0bobVH+X6JAT4lOJLQnZ6KZk9eo80c52QLCi+vLXXlvy1iQOLtYrSt+92SqJvKKH3JmR4ydn2qU5/zUJTSvzaeUUv1YGf8ZllqhIdHxtOAkYlpWdhKuIk1za/9LmpTLST0MY1X9E8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198821; c=relaxed/simple;
	bh=iGkuccrENqi7GaZuRDyxvozsK3bG56mNDTQ3WbFGFpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHwPMjmC0ue5OUBVidf0wj9Rm4YIFL8c+8UxcVyA5O5c+62GoK4RGhIfm7HVWiMVfKiob+lOy3FQ9jbMMNOosv1QVu/fAhb3yMKXo89WIQlcphSVE+T8o1n+dydetwDtBKS3verBn8qdtnakg/7um+MH4cxCOGwm5vLeGfBOFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuRQ4L5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B975C4CEF6;
	Fri, 11 Jul 2025 01:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198821;
	bh=iGkuccrENqi7GaZuRDyxvozsK3bG56mNDTQ3WbFGFpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FuRQ4L5KHIxykG7cNs9IRpKobpH8VnmJ2IzXF9KrPtv9POJuQ1KyR5R97AUY8G+T9
	 06cd0KAF2nf6Y+62+sDrlL5VgwotYvZBcJqaZjqrsv9ahLZE711wdCffT4jMBFXIvQ
	 x+1xgqetdQs6Di769kdvOYOSX/J1ZLdJsJsJEWLh9Gj22OODAs7nEC2ojxX5mVsZIQ
	 Fh9Gh5xqibrmpfFn5Hq1IntQIPA3TiVvRVokOZwagWPa7MTaCJ6trFsiIUOEMQ8sFb
	 PypjAvBl6DrZHWTGq/oES4DSXyaylY6kFUb/tDCusGaztc1g2EfKEzoc9duAQaMYGW
	 AMLjQHDQDb42w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/11] ethtool: rss: support setting hkey via Netlink
Date: Thu, 10 Jul 2025 18:52:58 -0700
Message-ID: <20250711015303.3688717-7-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711015303.3688717-1-kuba@kernel.org>
References: <20250711015303.3688717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support setting RSS hashing key via ethtool Netlink.
Use the Netlink policy to make sure user doesn't pass
an empty key, "resetting" the key is not a thing.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml     |  1 +
 Documentation/networking/ethtool-netlink.rst |  1 +
 net/ethtool/rss.c                            | 42 +++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 0d02d8342e4c..aa55fc9068e1 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2656,6 +2656,7 @@ c-version-name: ethtool-genl-version
             - context
             - hfunc
             - indir
+            - hkey
     -
       name: rss-ntf
       doc: |
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index f6e4439caa94..1830354495ae 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2001,6 +2001,7 @@ RSS_SET
   ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
   ``ETHTOOL_A_RSS_HFUNC``              u32     RSS hash func
   ``ETHTOOL_A_RSS_INDIR``              binary  Indir table bytes
+  ``ETHTOOL_A_RSS_HKEY``               binary  Hash key bytes
 =====================================  ======  ==============================
 
 ``ETHTOOL_A_RSS_INDIR`` is the minimal RSS table the user expects. Kernel and
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index a11428889419..20c7122fdc99 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -475,6 +475,7 @@ const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_START_CONTEXT + 1] =
 	[ETHTOOL_A_RSS_CONTEXT] = { .type = NLA_U32, },
 	[ETHTOOL_A_RSS_HFUNC] = NLA_POLICY_MIN(NLA_U32, 1),
 	[ETHTOOL_A_RSS_INDIR] = { .type = NLA_BINARY, },
+	[ETHTOOL_A_RSS_HKEY] = NLA_POLICY_MIN(NLA_BINARY, 1),
 };
 
 static int
@@ -488,8 +489,10 @@ ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (request->rss_context && !ops->create_rxfh_context)
 		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_CONTEXT];
 
-	if (request->rss_context && !ops->rxfh_per_ctx_key)
+	if (request->rss_context && !ops->rxfh_per_ctx_key) {
 		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HFUNC];
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HKEY];
+	}
 
 	if (bad_attr) {
 		NL_SET_BAD_ATTR(info->extack, bad_attr);
@@ -579,6 +582,33 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 	return err;
 }
 
+static int
+rss_set_prep_hkey(struct net_device *dev, struct genl_info *info,
+		  struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh,
+		  bool *mod)
+{
+	struct nlattr **tb = info->attrs;
+
+	if (!tb[ETHTOOL_A_RSS_HKEY])
+		return 0;
+
+	if (nla_len(tb[ETHTOOL_A_RSS_HKEY]) != data->hkey_size) {
+		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_HKEY]);
+		return -EINVAL;
+	}
+
+	rxfh->key_size = data->hkey_size;
+	rxfh->key = kzalloc(data->hkey_size, GFP_KERNEL);
+	if (!rxfh->key)
+		return -ENOMEM;
+
+	nla_memcpy(rxfh->key, tb[ETHTOOL_A_RSS_HKEY], rxfh->key_size);
+
+	*mod |= memcmp(rxfh->key, data->hkey, data->hkey_size);
+
+	return 0;
+}
+
 static void
 rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
 		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh)
@@ -590,6 +620,11 @@ rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
 			ethtool_rxfh_context_indir(ctx)[i] = rxfh->indir[i];
 		ctx->indir_configured = !!nla_len(tb[ETHTOOL_A_RSS_INDIR]);
 	}
+	if (rxfh->key) {
+		memcpy(ethtool_rxfh_context_key(ctx), rxfh->key,
+		       data->hkey_size);
+		ctx->key_configured = !!rxfh->key_size;
+	}
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE)
 		ctx->hfunc = rxfh->hfunc;
 }
@@ -628,6 +663,10 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (rxfh.hfunc == data.hfunc)
 		rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
 
+	ret = rss_set_prep_hkey(dev, info, &data, &rxfh, &mod);
+	if (ret)
+		goto exit_clean_data;
+
 	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
 
 	mutex_lock(&dev->ethtool->rss_lock);
@@ -657,6 +696,7 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 
 exit_unlock:
 	mutex_unlock(&dev->ethtool->rss_lock);
+	kfree(rxfh.key);
 	kfree(rxfh.indir);
 exit_clean_data:
 	rss_cleanup_data(&data.base);
-- 
2.50.1


