Return-Path: <netdev+bounces-207314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C89B06A48
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D444E1C00
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D4818BBAE;
	Wed, 16 Jul 2025 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtIW1F5h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E743145348
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624259; cv=none; b=kluJrxl1q6BHa26ff/4mkcfKry5u8Vlqc7rb499PIzRQXOXg7Q29SrAvF2trfV2RDrjG6m2Qz6mViXuaC3sxyqsRBwqPuVh1T6lbr/e413V1y9PYEvZGYdPVCc1uZOaNvVz8AsWIVu/Lwzf/CrntNtk6WCD8giexba6F85O/Eog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624259; c=relaxed/simple;
	bh=BkLJf8rmZVA73k/nXlvLspSUqAv5F97YYjqdJX1X9Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfvakdLOlbxOBrlIa75PwWkbT6V9zyG86gEpyFpB6REstYyUsDbl0f824FXU4mJVPb7n9s5OJfkvwZKW5aa+TuFC/uNR6DtIo/tioDVpJBOwpZacTNXNDT3lRYR1Rk8rNrMFBSISivsyM6ILdYcCPG8c4RUAnaSZQxa4FNwjjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtIW1F5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12789C4CEF8;
	Wed, 16 Jul 2025 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752624258;
	bh=BkLJf8rmZVA73k/nXlvLspSUqAv5F97YYjqdJX1X9Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtIW1F5hMNeryNTchSYhOYRzlALYy/+NSF5UY2QcXUpNaH4V0Jf9RdC0ud7wfOBTs
	 2yC8grJtfQc+/DZd4WUh1y1McmPPsJu5TMqmNyoI8PZWUjT3DgoOA0FBzGENZMeeu9
	 MOpRpqJ/umJyLkIq2kCGQ5/JULNDVngIY0JFY3Bld+AvRyN1xDG0tgdtEczTnvJcJ/
	 WzlJJpGb/xdZrqtjk1qbL88JGYE+yWhXriFsoEkJlAGgYvwSyhwV8/VilydofiGZzd
	 esRY1ZCS/b3ez49mApA7FBvC/wD+rHpyOt1OVr5ab1RrQZw5thitmK1008tV2Cq67V
	 zq191iG+WDsKQ==
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
	jdamato@fastly.com,
	andrew@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 06/11] ethtool: rss: support setting hkey via Netlink
Date: Tue, 15 Jul 2025 17:03:26 -0700
Message-ID: <20250716000331.1378807-7-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716000331.1378807-1-kuba@kernel.org>
References: <20250716000331.1378807-1-kuba@kernel.org>
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

Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use ethnl_update_binary()
 - make sure we free indir if key parsing fails
---
 Documentation/netlink/specs/ethtool.yaml     |  1 +
 Documentation/networking/ethtool-netlink.rst |  1 +
 net/ethtool/rss.c                            | 41 +++++++++++++++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

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
index bc9025cfcf1c..55260830639f 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -477,6 +477,7 @@ const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_START_CONTEXT + 1] =
 	[ETHTOOL_A_RSS_CONTEXT] = { .type = NLA_U32, },
 	[ETHTOOL_A_RSS_HFUNC] = NLA_POLICY_MIN(NLA_U32, 1),
 	[ETHTOOL_A_RSS_INDIR] = { .type = NLA_BINARY, },
+	[ETHTOOL_A_RSS_HKEY] = NLA_POLICY_MIN(NLA_BINARY, 1),
 };
 
 static int
@@ -490,8 +491,10 @@ ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (request->rss_context && !ops->create_rxfh_context)
 		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_CONTEXT];
 
-	if (request->rss_context && !ops->rxfh_per_ctx_key)
+	if (request->rss_context && !ops->rxfh_per_ctx_key) {
 		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HFUNC];
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HKEY];
+	}
 
 	if (bad_attr) {
 		NL_SET_BAD_ATTR(info->extack, bad_attr);
@@ -581,6 +584,31 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
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
+	rxfh->key = kmemdup(data->hkey, data->hkey_size, GFP_KERNEL);
+	if (!rxfh->key)
+		return -ENOMEM;
+
+	ethnl_update_binary(rxfh->key, rxfh->key_size, tb[ETHTOOL_A_RSS_HKEY],
+			    mod);
+	return 0;
+}
+
 static void
 rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
 		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh)
@@ -592,6 +620,11 @@ rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
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
@@ -629,6 +662,10 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (rxfh.hfunc == data.hfunc)
 		rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
 
+	ret = rss_set_prep_hkey(dev, info, &data, &rxfh, &mod);
+	if (ret)
+		goto exit_free_indir;
+
 	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
 
 	mutex_lock(&dev->ethtool->rss_lock);
@@ -660,6 +697,8 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 
 exit_unlock:
 	mutex_unlock(&dev->ethtool->rss_lock);
+	kfree(rxfh.key);
+exit_free_indir:
 	kfree(rxfh.indir);
 exit_clean_data:
 	rss_cleanup_data(&data.base);
-- 
2.50.1


