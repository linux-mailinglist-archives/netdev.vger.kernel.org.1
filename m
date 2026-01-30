Return-Path: <netdev+bounces-255231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKA1JXoAfWk5PwIAu9opvQ
	(envelope-from <netdev+bounces-255231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:03:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC77FBE0A8
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E0A3303EE83
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C552E7637;
	Fri, 30 Jan 2026 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puTFmBaa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D542737F2
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799798; cv=none; b=ojUOiEk9Zcz3yvB5/Q8SVe0X9jX/1Kd6xe830tK16hgemIyq94tM+KkLeBfB/U+hwKux9rfkq/o5qf5JKf9zgoKLYQ4o7rbSoWe2QRaPIFdnod2QKD4Ff0zENgvvJKVnJJ3KuTICLK/hzzINdq1AEUUgNacGfrUBj3y4Xm8Mwuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799798; c=relaxed/simple;
	bh=dDNSwUmfeXJwNEzP6xwy2mEeBOsNB1GSoOc0BtkqYGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XICkihymQsyxHyhPU5B84uOtTvoDKQuw7fL+AFat5a2SbVbnspPm4gJVQms1VOH1VH3Lgs13QLo4CjOZHLDRWdui447Nbu1c5o2e+PuEOLc3V6wFnl0IOzX50xYpAm2pu1Kh08+YK3Djj5XIekt1tNuMl4iDTzRCLFKmjmGlVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puTFmBaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C4EC4CEF7;
	Fri, 30 Jan 2026 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769799797;
	bh=dDNSwUmfeXJwNEzP6xwy2mEeBOsNB1GSoOc0BtkqYGA=;
	h=From:To:Cc:Subject:Date:From;
	b=puTFmBaaZPxr5JabxVrRGklf+47UPG2PRZatvklmXqrrS9Z+nQSP7pm9uMr3UPKJw
	 CP0/bcKPxj3Q0CPXqmdbQOhrI3caINtHMXIcU3gmxq3zExBiO6E8qLtztGnQprU2yO
	 rWDTPHqi7GPyupi3NVvOZ3i2RNy90AZNDZEXffCJgPU9S6jkTR3NCsDmFmp5V912R5
	 5aQIHSn8NrcozsDlVdKhz7dDA6U6S4xLU1u5ocVo0Z4KLPbFkW67MSbB+Zyh0sh/JQ
	 SL/eJmo0oY1G0ofAB/m0V+wht5bCsmGUdPNcLKcfPI6NXRtyd0bU7DSL8DEwwiCKlN
	 AgHaIyAs+Clvw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	gal@nvidia.com
Subject: [PATCH net] net: rss: fix reporting RXH_XFRM_NO_CHANGE as input_xfrm for contexts
Date: Fri, 30 Jan 2026 11:03:11 -0800
Message-ID: <20260130190311.811129-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255231-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,bootlin.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: EC77FBE0A8
X-Rspamd-Action: no action

Initializing input_xfrm to RXH_XFRM_NO_CHANGE in RSS contexts is
problematic. I think I did this to make it clear that the context
does not have its own settings applied. But unlike ETH_RSS_HASH_NO_CHANGE
which is zero, RXH_XFRM_NO_CHANGE is 0xff. We need to be careful
when reading the value back, and remember to treat 0xff as 0.

Remove the initialization and switch to storing 0. This lets us
also remove the workaround in ethnl_rss_set(). Get side does not
need any adjustments and context get no longer reports:

  RSS input transformation:
    symmetric-xor: on
    symmetric-or-xor: on
    Unknown bits in RSS input transformation: 0xfc

for NICs which don't support input_xfrm.

Remove the init of hfunc to ETH_RSS_HASH_NO_CHANGE while at it.
As already mentioned this is a noop since ETH_RSS_HASH_NO_CHANGE
is 0 and struct is zalloc'd. But as this fix exemplifies storing
NO_CHANGE as state is fragile.

This issue is implicitly caught by running our selftests because
YNL in selftests errors out on unknown bits.

Fixes: d3e2c7bab124 ("ethtool: rss: support setting input-xfrm via Netlink")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: gal@nvidia.com
---
 net/ethtool/common.c | 3 ---
 net/ethtool/rss.c    | 9 ++-------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index c5ed88bccbb4..5fae329795c8 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -901,9 +901,6 @@ ethtool_rxfh_ctx_alloc(const struct ethtool_ops *ops,
 	ctx->key_off = key_off;
 	ctx->priv_size = ops->rxfh_priv_size;
 
-	ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
-	ctx->input_xfrm = RXH_XFRM_NO_CHANGE;
-
 	return ctx;
 }
 
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 4dced53be4b3..da5934cceb07 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -824,8 +824,8 @@ rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
 static int
 ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 {
-	bool indir_reset = false, indir_mod, xfrm_sym = false;
 	struct rss_req_info *request = RSS_REQINFO(req_info);
+	bool indir_reset = false, indir_mod, xfrm_sym;
 	struct ethtool_rxfh_context *ctx = NULL;
 	struct net_device *dev = req_info->dev;
 	bool mod = false, fields_mod = false;
@@ -860,12 +860,7 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	rxfh.input_xfrm = data.input_xfrm;
 	ethnl_update_u8(&rxfh.input_xfrm, tb[ETHTOOL_A_RSS_INPUT_XFRM], &mod);
-	/* For drivers which don't support input_xfrm it will be set to 0xff
-	 * in the RSS context info. In all other case input_xfrm != 0 means
-	 * symmetric hashing is requested.
-	 */
-	if (!request->rss_context || ops->rxfh_per_ctx_key)
-		xfrm_sym = rxfh.input_xfrm || data.input_xfrm;
+	xfrm_sym = rxfh.input_xfrm || data.input_xfrm;
 	if (rxfh.input_xfrm == data.input_xfrm)
 		rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
 
-- 
2.52.0


