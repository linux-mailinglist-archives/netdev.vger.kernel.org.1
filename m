Return-Path: <netdev+bounces-291748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM6LFmHJFWpEbgcAu9opvQ
	(envelope-from <netdev+bounces-291748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:25:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF05D9A0E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 146B9320E2D4
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3686536DA0B;
	Tue, 26 May 2026 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKziWvB0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5136C582
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809754; cv=none; b=owY0jmCCnkSksN54xrnYLqSLY5ZqqUqmoivj9aPyCO/SLoOyphEcnmu+g3KDVSDSAtKbvsImX2EjcftnHanf1M0D/JRmfdk4COxkRqZ+/JoD3ur5MyZuFed8VtKiYGt9r/b7lqtfN33hwqkB3KhxLrxEnmikiALTQAkX2/jZoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809754; c=relaxed/simple;
	bh=y5jAeEzKVylHln/eooXyBAMKXpNtiF7YyI4y6prUiZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9UUc/3J+U8fZ7h9Dejjm1yXBeTn2OkymoBj8UuuvNUd+WN2NDMDBppYjG2MC3whyE5wGoNO+SOaYcFfL/quLJkL8bDcCel0q8r9mpwCB4Hq7r37shjvbJWmHeoJa672GOJtPcX9IohunWI4Kr9QIJrYx3UR6hH6Mk9E9g8QI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKziWvB0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618071F00A3C;
	Tue, 26 May 2026 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809749;
	bh=7dP2YntmRv3hS/9iXAzM6939O760TfuVaVHzlpcD2Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QKziWvB0Futl2LSZfIAhMoQHKKS/okD905lOm9gYdcNDyPHETkzhECi1Zjz5af8xW
	 kall9OaeqLDGtwID7vT6Z80iDwlhco9/JH8SsN+WhLHO85KYJ9kxi9bPOZI/79KPj0
	 gEP0ec2p9wRDLVNuTOQ0rFj3qwmfNs4gphEJbP84pf5x8VPN79P371PDGUsoPk1pJ3
	 7kmg/eQstBqCIqkomJzMsqmI5yG+fbC6aqk91SleNp1I64kg/BZ79E7ETLcCTwyuE1
	 FoLWFdgngglUHBC3DyMAFCZZbIqK5pskBzd6UZFdBWFpiFLZfpzUmFoaPkxglpYDfb
	 Dk0FZ8Nb8v8oA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hengqi@linux.alibaba.com
Subject: [PATCH net 01/10] ethtool: coalesce: cap profile updates at NET_DIM_PARAMS_NUM_PROFILES
Date: Tue, 26 May 2026 08:35:24 -0700
Message-ID: <20260526153533.2779187-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291748-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: 9CCF05D9A0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ethnl_update_profile() walks the ETHTOOL_A_PROFILE_IRQ_MODERATION
nest list with an index 'i' and writes new_profile[i++] without
bounding i. The destination is kmemdup()'d at NET_DIM_PARAMS_NUM_PROFILES
entries (5), but the Netlink nest count is entirely user-controlled.
Netlink policies do not have support for constraining the number
of nested entries (or number of multi-attr entries).

Fixes: f750dfe825b9 ("ethtool: provide customized dim profile management")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: haiyangz@microsoft.com
CC: hengqi@linux.alibaba.com
---
 net/ethtool/coalesce.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 1e2c5c7048a8..e73fc3e5a02b 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -472,6 +472,12 @@ static int ethnl_update_profile(struct net_device *dev,
 
 	nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION,
 				 nests, rem) {
+		if (i >= NET_DIM_PARAMS_NUM_PROFILES) {
+			NL_SET_BAD_ATTR(extack, nest);
+			ret = -E2BIG;
+			goto err_out;
+		}
+
 		ret = nla_parse_nested(tb, len_irq_moder - 1, nest,
 				       coalesce_irq_moderation_policy,
 				       extack);
-- 
2.54.0


