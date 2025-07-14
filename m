Return-Path: <netdev+bounces-206878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E3B04A9A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5AA1661B3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF5727979A;
	Mon, 14 Jul 2025 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4kImkVO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18427279785
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532072; cv=none; b=EHY1b+GVV+S3VpGxRsgc6qufjbgb4LynmlsJ7BI5LB6ih+LmDAJWgeNAbWA8URSMjlSfR9VhegJAOG03sDzfSYiKY+m0ly7fprwQpE6q+5HcHULYn7i0P7wwl212cLq4PIbotlWHqRxAoAfiDnmo97o817znZjfSlIsyntPauBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532072; c=relaxed/simple;
	bh=hTExFP2oYk+LGuVw7aMnh+sRqKrE10AFQy28QLPD56M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FME5ye+q4pYCiBG8En0LytKg+D8KkDKPbbTmIKZoFNL94yeZ1BwB0YPcNg40PGGc76hmnzFTngKzauDSKEG8cK2VKVvHogA9140CghxowXqApmcbx1LZl92+WmDX+wQ51TUROpfGG+r0HpPRwKlpO9FR4+aegWMUO2+R3tiC/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4kImkVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7971AC4CEF4;
	Mon, 14 Jul 2025 22:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532071;
	bh=hTExFP2oYk+LGuVw7aMnh+sRqKrE10AFQy28QLPD56M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4kImkVOysYkPSNqLubpdgkygJjL2j+JkhfK9D2ZEfcdkyUNgXzI8P0I+tvzdDHuY
	 svwDhFuVqn306WPASpUlVnu3uDx0CgsVnvUVc15RSLjcgdyYrm2fL7HBZmHTxIndIl
	 Tebknw/gS2F0PRNI6b1F3ye33xiqo/ambcyGdIqg6N2TiqDvtw6vwXlv06Hcacm9Xq
	 xSOw0ZU8NRor6n6zY5xSatL3Xko1K1WSEvlb62fLv+e8dv3MeaaHiorpvPFCUZ53Np
	 yKKTTVztyRz9qEZUhzVqayq/zZN6g72eZo6eI+cJ2FG1PGznH3EUfvAogBkRzO3Zl6
	 TjIobz8O0lRvQ==
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
Subject: [PATCH net-next v2 05/11] ethtool: rss: support setting hfunc via Netlink
Date: Mon, 14 Jul 2025 15:27:23 -0700
Message-ID: <20250714222729.743282-6-kuba@kernel.org>
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
index 989cdb93a6e8..03e42aac8c36 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -475,6 +475,7 @@ void ethtool_rss_notify(struct net_device *dev, u32 rss_context)
 const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_START_CONTEXT + 1] = {
 	[ETHTOOL_A_RSS_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
 	[ETHTOOL_A_RSS_CONTEXT] = { .type = NLA_U32, },
+	[ETHTOOL_A_RSS_HFUNC] = NLA_POLICY_MIN(NLA_U32, 1),
 	[ETHTOOL_A_RSS_INDIR] = { .type = NLA_BINARY, },
 };
 
@@ -489,6 +490,9 @@ ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (request->rss_context && !ops->create_rxfh_context)
 		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_CONTEXT];
 
+	if (request->rss_context && !ops->rxfh_per_ctx_key)
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HFUNC];
+
 	if (bad_attr) {
 		NL_SET_BAD_ATTR(info->extack, bad_attr);
 		return -EOPNOTSUPP;
@@ -588,6 +592,8 @@ rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
 			ethtool_rxfh_context_indir(ctx)[i] = rxfh->indir[i];
 		ctx->indir_configured = !!nla_len(tb[ETHTOOL_A_RSS_INDIR]);
 	}
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE)
+		ctx->hfunc = rxfh->hfunc;
 }
 
 static int
@@ -618,7 +624,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 		goto exit_clean_data;
 	indir_mod = !!tb[ETHTOOL_A_RSS_INDIR];
 
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


