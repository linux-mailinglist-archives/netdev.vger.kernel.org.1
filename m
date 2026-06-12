Return-Path: <netdev+bounces-298495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uo+YKNe6K2rWDQQAu9opvQ
	(envelope-from <netdev+bounces-298495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:52:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 021B2677763
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:52:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=OZMjzBpE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298495-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298495-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC6083404E17
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0004F3E315F;
	Fri, 12 Jun 2026 07:48:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6223E1718
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250494; cv=none; b=FfjQVt2QbgpP61sEhCNYNzW6OoOzqQFQe946w2/KeKu/sXjeZLSqTNSsiicDBTxbByEwmUkGLbnIIHPoWtPGmc3QnhvpIkCRCioRyT+t6fW3DNeJutPTY9oF+LeQP7FlFTi0NgDw61qhMu3MXti4IaB/syD67E0exVG3WZSUyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250494; c=relaxed/simple;
	bh=UAfOgZlItzTFYNieKsx9sEQjvr3E0AI9MyDU/jNiVaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzU3syy+gnyAYhxWsEMl1LoJDjACMJwU18vi6yhkrCQCarA/Qm65eUzhjOfKtuRSkrVGrrtWzCgXsUPphXP76kgCE1VsqRw3+qrrsWgbVJy22Yy/eKQZrZd7df0kXKQMCCzxBbBvjSlLsR2tXDHeWfbzMX3HClfODPxz3GN/Hz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OZMjzBpE; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EBB2F2082E;
	Fri, 12 Jun 2026 09:48:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bPhrpcPoKpjw; Fri, 12 Jun 2026 09:48:09 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 50D612082B;
	Fri, 12 Jun 2026 09:48:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 50D612082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250489;
	bh=WptCN0ddTJuk7UkknFwAnjjZUUijeuXK7m/NzQMqeC4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=OZMjzBpEccOFQY1Vo3lmqSQIRr8ZzCsAksSNVVLr1ZMQ6B/dYgqURgCHbXtYvuH6W
	 cGkXS3TSOu5WnGiNWMZDeORbAWNppRnBAQbnYosp0QZJZqAbh/ylk3wYf/ge0GZ+8Z
	 zOgHQmsVNzkJ751+MxNz+36QNGyhOaDvOqS3ryUoA34X/YJuZllwvYyI0h420AZkp9
	 aKfRTDx/lXCh/6ghOWYrpiQFc/WpPQMqybU6nOcWo++kiBXGa5kUICeYxfS8wvrbTA
	 BeLd7p5EOWAd7B+wvsOHSxZgBCAdJrjgFNie/Y/gqu+AfoEArgBoSfmeT9funfX9rv
	 Bh+ZdUsHvLtpQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:48:08 +0200
Received: (nullmailer pid 1768305 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 14/18] xfrm: extract address family and selector validation helpers
Date: Fri, 12 Jun 2026 09:46:30 +0200
Message-ID: <20260612074725.1760473-15-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612074725.1760473-1-steffen.klassert@secunet.com>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298495-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,secunet.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 021B2677763

From: Antony Antony <antony.antony@secunet.com>

Extract verify_xfrm_family() and verify_selector_prefixlen() from
verify_newsa_info() to allow reuse by other netlink handlers.

verify_xfrm_family() validates that a given address family is AF_INET
or AF_INET6 (with CONFIG_IPV6 guard).

verify_selector_prefixlen() validates that the selector prefix lengths
are within the bounds for the given address family.

No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 80 ++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 62eccdbe245f..de857ef65b2f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -264,66 +264,74 @@ static int verify_mtimer_thresh(bool has_encap, u8 dir,
 	return 0;
 }
 
-static int verify_newsa_info(struct xfrm_usersa_info *p,
-			     struct nlattr **attrs,
-			     struct netlink_ext_ack *extack)
+static int verify_xfrm_family(u16 family, struct netlink_ext_ack *extack)
 {
-	int err;
-	u8 sa_dir = nla_get_u8_default(attrs[XFRMA_SA_DIR], 0);
-	u16 family = p->sel.family;
-
-	err = -EINVAL;
-	switch (p->family) {
+	switch (family) {
 	case AF_INET:
-		break;
-
+		return 0;
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
-		break;
+		return 0;
 #else
-		err = -EAFNOSUPPORT;
 		NL_SET_ERR_MSG(extack, "IPv6 support disabled");
-		goto out;
+		return -EAFNOSUPPORT;
 #endif
-
 	default:
 		NL_SET_ERR_MSG(extack, "Invalid address family");
-		goto out;
+		return -EINVAL;
 	}
+}
 
-	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
-		family = p->family;
-
+static int verify_selector_prefixlen(u16 family,
+				     const struct xfrm_selector *sel,
+				     struct netlink_ext_ack *extack)
+{
 	switch (family) {
 	case AF_UNSPEC:
-		break;
-
+		return 0;
 	case AF_INET:
-		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32) {
-			NL_SET_ERR_MSG(extack, "Invalid prefix length in selector (must be <= 32 for IPv4)");
-			goto out;
+		if (sel->prefixlen_d > 32 || sel->prefixlen_s > 32) {
+			NL_SET_ERR_MSG(extack,
+				       "Invalid prefix length in selector (must be <= 32 for IPv4)");
+			return -EINVAL;
 		}
-
-		break;
-
+		return 0;
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
-		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128) {
-			NL_SET_ERR_MSG(extack, "Invalid prefix length in selector (must be <= 128 for IPv6)");
-			goto out;
+		if (sel->prefixlen_d > 128 || sel->prefixlen_s > 128) {
+			NL_SET_ERR_MSG(extack,
+				       "Invalid prefix length in selector (must be <= 128 for IPv6)");
+			return -EINVAL;
 		}
-
-		break;
+		return 0;
 #else
 		NL_SET_ERR_MSG(extack, "IPv6 support disabled");
-		err = -EAFNOSUPPORT;
-		goto out;
+		return -EAFNOSUPPORT;
 #endif
-
 	default:
 		NL_SET_ERR_MSG(extack, "Invalid address family in selector");
-		goto out;
+		return -EINVAL;
 	}
+}
+
+static int verify_newsa_info(struct xfrm_usersa_info *p,
+			     struct nlattr **attrs,
+			     struct netlink_ext_ack *extack)
+{
+	int err;
+	u8 sa_dir = nla_get_u8_default(attrs[XFRMA_SA_DIR], 0);
+	u16 family = p->sel.family;
+
+	err = verify_xfrm_family(p->family, extack);
+	if (err)
+		goto out;
+
+	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
+		family = p->family;
+
+	err = verify_selector_prefixlen(family, &p->sel, extack);
+	if (err)
+		goto out;
 
 	err = -EINVAL;
 	switch (p->id.proto) {
-- 
2.43.0


