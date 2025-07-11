Return-Path: <netdev+bounces-206021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DC5B010F8
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FFD5C2E58
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29041624C5;
	Fri, 11 Jul 2025 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaQMTXvV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23415CD74
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198820; cv=none; b=dEwf9EhkDm/IfkaOLhdkL1HNjIe11wBpO9+FGs3rnpM5Vrv6eKDxWCiBCA91ptJvPctq+J8sjEuavzvAzLKIyAJHMbDA3eT5RZLv2TH4P8G30Yn+JWMCpTU7po2FhhDllnVaCd89WAyA8VBJ3xpVLsm67B8MItr2N6lJS6weQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198820; c=relaxed/simple;
	bh=VeOV+bCNOi00TGi6Du67MGJ1up8MMIZOFGVN4OsvlXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBLBiNJxZK4rbebFeZdsOfUbcg2sqPF5UJwzYGkRGyeW8MBjzBxjo7bzLCF9xBD0jxYbXWlGaHKbw37sFUk5zOw4yzwB8le2hnjqr8AgI9+8Oe6SpJhA/gF8lw/H+4xVHNfr+xroUmKUI9TwMEcS6/OIbyCJOZCjTnYbu7HcQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaQMTXvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF1AC4CEF7;
	Fri, 11 Jul 2025 01:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198820;
	bh=VeOV+bCNOi00TGi6Du67MGJ1up8MMIZOFGVN4OsvlXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaQMTXvVjjkaWMPSCXLLXCO5Z+s98RhtWV4WyvHnCNgo8tjTsH2sqTeNb0xi7yAXS
	 b4al7gm72gVjRLo0aPY/mEVWSCX07UehUnETyXz0fDWt8Fdv1vWsVfGXFXV+YvzI/M
	 7jSPlxpKVjT9SgBcKr0BDYRt5LxBDYj2+eQO7isU3D10W6/lXi6n7ASxEhZrYMfyNV
	 vV4F6cdpV9VuU5/OvHaaKG54XvckA9VauKnCrlVW/3ycAxMSGFL/aEGZJ0zehaqsjI
	 2M+0LdNvFfOnVLzP6soE/yFKqjTJqQ5p19sxZGSYzslpyMe7bf47vsP4MLNshoHwwW
	 dkdHCStOIM9cw==
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
Subject: [PATCH net-next 05/11] ethtool: rss: support setting hfunc via Netlink
Date: Thu, 10 Jul 2025 18:52:57 -0700
Message-ID: <20250711015303.3688717-6-kuba@kernel.org>
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

Support setting RSS hash function / algo via ethtool Netlink.
Like IOCTL we don't validate that the function is within the
range known to the kernel. The drivers do a pretty good job
validating the inputs, and the IDs are technically "dynamically
queried" rather than part of uAPI.

Only change should be that in Netlink we don't support user
explicitly passing ETH_RSS_HASH_NO_CHANGE (0), if no change
is requested the attribute should be absent.

The ETH_RSS_HASH_NO_CHANGE is retained in driver-facing
API for consistency (not that I see a strong reason for it).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml     |  1 +
 Documentation/networking/ethtool-netlink.rst |  1 +
 net/ethtool/rss.c                            | 12 +++++++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 1eca88a508a0..0d02d8342e4c 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2654,6 +2654,7 @@ c-version-name: ethtool-genl-version
           attributes:
             - header
             - context
+            - hfunc
             - indir
     -
       name: rss-ntf
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 27db7540e60e..f6e4439caa94 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1999,6 +1999,7 @@ RSS_SET
 =====================================  ======  ==============================
   ``ETHTOOL_A_RSS_HEADER``             nested  request header
   ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
+  ``ETHTOOL_A_RSS_HFUNC``              u32     RSS hash func
   ``ETHTOOL_A_RSS_INDIR``              binary  Indir table bytes
 =====================================  ======  ==============================
 
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 7167fc3c27a0..a11428889419 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -473,6 +473,7 @@ void ethtool_rss_notify(struct net_device *dev, u32 rss_context)
 const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_START_CONTEXT + 1] = {
 	[ETHTOOL_A_RSS_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
 	[ETHTOOL_A_RSS_CONTEXT] = { .type = NLA_U32, },
+	[ETHTOOL_A_RSS_HFUNC] = NLA_POLICY_MIN(NLA_U32, 1),
 	[ETHTOOL_A_RSS_INDIR] = { .type = NLA_BINARY, },
 };
 
@@ -487,6 +488,9 @@ ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (request->rss_context && !ops->create_rxfh_context)
 		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_CONTEXT];
 
+	if (request->rss_context && !ops->rxfh_per_ctx_key)
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HFUNC];
+
 	if (bad_attr) {
 		NL_SET_BAD_ATTR(info->extack, bad_attr);
 		return -EOPNOTSUPP;
@@ -586,6 +590,8 @@ rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
 			ethtool_rxfh_context_indir(ctx)[i] = rxfh->indir[i];
 		ctx->indir_configured = !!nla_len(tb[ETHTOOL_A_RSS_INDIR]);
 	}
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE)
+		ctx->hfunc = rxfh->hfunc;
 }
 
 static int
@@ -617,7 +623,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 		goto exit_clean_data;
 	mod |= indir_mod;
 
-	rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
+	rxfh.hfunc = data.hfunc;
+	ethnl_update_u8(&rxfh.hfunc, tb[ETHTOOL_A_RSS_HFUNC], &mod);
+	if (rxfh.hfunc == data.hfunc)
+		rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
+
 	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
 
 	mutex_lock(&dev->ethtool->rss_lock);
-- 
2.50.1


