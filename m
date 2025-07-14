Return-Path: <netdev+bounces-206879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E81FB04A98
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888464A29C7
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EA827A122;
	Mon, 14 Jul 2025 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM0ertFL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D8279DA9
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532073; cv=none; b=BBJQ1IShQ2rHp31Vi1cxGpMP5pSJe+KTmF5Vo1TmHxb0lmK6meWBrSQu3lnI24Gq2+btxO49SsYKL44xeNFsLLYWDnR89pvsmq97UnOM9OCsNfqp/cMZEcYdLcgDutL5qyuKLHwLExQtAtqfDcCuLZw9foIp1XiD7SOd6TL7eUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532073; c=relaxed/simple;
	bh=w15p4K3xBkjfoDfPWBYUWiyKLCnLM/nnJudWY/sCSSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPvg7Saap/ETao+m5/3Ug0Vfo2UKtUmWcXCZ+RsoLXgLNc2pDebCvfb38h9ombpevBmV1DCklCyIhF++LlPcNWogkq8CnJIStKJvBeZSybtv3FPL9xalc/12S2T4vSc1OFxHK2FTZ5kdD3qBszcIUU5s+GlzQzP3tVopCKNTVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM0ertFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F5FC4CEED;
	Mon, 14 Jul 2025 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532072;
	bh=w15p4K3xBkjfoDfPWBYUWiyKLCnLM/nnJudWY/sCSSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jM0ertFLS+m4gG0JKwvSfqiCUFKzSN3dQBcJayY6oKP+ihjzGojhyEnYbBG39w44c
	 31A9Mi5XHt+kNvJabRTD6Xuv3obzkixtvHdV4o+NUvr2qf1bPO/pS76IUzrYrlk2lo
	 swjM5RGHbljOjIjO1X0qlSzNhWqf8UqnOUhuOss5kwXyb64eNP/Tab0NgyaLsial5d
	 +ZhQvtecCRQkw5r8Z1ec92lyny1A6zxlCD/yxHjtFVWvWhl4PRw375MbJwBvcS096W
	 maeJt5CiwKz/rr/k/0/q9X8XYtfx8J2FZF7j/LTDPfTGbSS4qyoQEuLZp7lLNmcQpg
	 UFw4VvlBPNkOw==
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
Subject: [PATCH net-next v2 06/11] ethtool: rss: support setting hkey via Netlink
Date: Mon, 14 Jul 2025 15:27:24 -0700
Message-ID: <20250714222729.743282-7-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714222729.743282-1-kuba@kernel.org>
References: <20250714222729.743282-1-kuba@kernel.org>
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
index 03e42aac8c36..416ad428e61e 100644
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


