Return-Path: <netdev+bounces-269713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAh9KbSAvGnfzQIAu9opvQ
	(envelope-from <netdev+bounces-269713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:03:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F13F2D3F5B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0659730BA395
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CE3BA24F;
	Thu, 19 Mar 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="h7cbnCF1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HaRz46wS"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D837B3F5
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961386; cv=none; b=VJRpGg64EGtDnTsy+E16FTy0Y9DJ/3Meg/1hEJNwEmwS2KLru0WRvCVnfNJZZ5JPj0dp63SZNvuGDIvRxm7Pl3CdPuOndfw8LqeOnsQj082RMd6Xd4/94PuVhnXf2inGqya3EgehwcpRDYHLWW3mPWYjcuoVnmVCqkpEoi8smvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961386; c=relaxed/simple;
	bh=Iy9N+/3gSSQuX5jxzLCkpcVOaCqmVSoqMmk7T5Zq3z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W14i4aoOqMrw2WnjhSVQQ+x2S7ASBWZ52E6RP5I175Q0EU4/bJs2WStaglU/kvZdvSc6DmE6FNUEZbgHACFIs27VpI7m3+zChQYMqKa2Ivtdn29mwDpBkqYVBi8b8qHOooFn1vcTqaQNh2z93FLr4a9AdT2sSsf+mQcmv4EBZ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=h7cbnCF1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HaRz46wS; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BB4421D000BC;
	Thu, 19 Mar 2026 19:03:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 19:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773961383; x=
	1774047783; bh=fS77O5ykV5KFOv7Y92L8XacNeBpCFKLA0SxAzgM1E7I=; b=h
	7cbnCF1rHVmR9CBlhPIgHWsNyIWJB3lrebdoEnLNRsRyHOujnHkADpeFYmb7OTz+
	7gD/ojUzSRdx/g2dZ6rOFDYjGMXgsOjg/L+UaK5tdQHvUbM/TyW+kIJ8AVm9nLWe
	+tGMbN85IWkqdsszSu5pIP+O8LjbzC1426RVwIEeWLhVD5Oqb1uKYxVCOVLDoZOZ
	98cgCPAVqL/u5GfYRs1mxFTdz1QjGZyg6Ji/I7mwyr/ldGP0amzKlfpIFWhWQqD+
	qWyqIdlRVLD5yAwM6wZsLOo2KXE9KElXOkT5Iz+/v8l72eVf/erE34Y+lotfonnP
	3Plnq05+FZYE+bAjcQ62Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773961383; x=1774047783; bh=f
	S77O5ykV5KFOv7Y92L8XacNeBpCFKLA0SxAzgM1E7I=; b=HaRz46wS+pXvZzih6
	vOeIA6nCB6JSqNNnlnDmSGIze0Yj9Qt8R7kgLuLaRlHexPsO873azwIBUgJvZ3tl
	biMD4ennq3KZ/13ru9h3IOS/j8MTh6YWYN9RlC/birZrVFRTUsY1FKrB9snZJOck
	CsgG/EktxJxXDLkPO5Oa9LQnWhB/5lAZkLdLU6ufY57/eiIyLhmxhExBEfbvI9Ti
	TdfHuvJ86g3D74vOGA57glu6Mbpwctyl0iqQ0Yjxu74obf1X8lZ0ljvpaBUSZxJ7
	lR0JBO0Riv2nuALwh90M3fT0Zw56/4Z0FFuhK3gPkFk9zFm/oYSwRaKXKsmV4Jas
	XB1TA==
X-ME-Sender: <xms:p4C8aUQHSiaJKyvIQ5ZInhdkaDv6LpaiNlWz0U320UEMUBJ9pttjlQ>
    <xme:p4C8aTRaXQBaRQoEC41fe7EJ3pU-Jp2430S7bAG2v5oVeCLZA8QJDaL1iH_nT96uw
    6A80-uZhSedA9dJoBPCVPfWi5CWxj4pqYQGrIol5Sd22m2Zl30qs-Q>
X-ME-Received: <xmr:p4C8aR7dz3tnRULw5lpC6pbCmLrp-mFmpcKOy-C2ancFRC2DbOdew2aBh6ci>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphht
    thhopehjohhhrghnnhgvshdrsggvrhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplh
    hoihgtrdhpohhulhgrihhnsehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtphhtthho
    pehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:p4C8aX1zzleROIcLXRU2WJPpmwn-6Oqtb1X_VkWoSU6XjE98U5DtxQ>
    <xmx:p4C8aUDCHhKILGP-JTFUvjEba0o3Vd2vol3jq00temOCAtIjP3MOiQ>
    <xmx:p4C8aaN2D-QMmu5V5XkqLcUULMwmQs43HP-M8mONbHIbZrfRToC13A>
    <xmx:p4C8aRZQMwDt_h9fbPqNrCGe1Z9Ri1C_LL9J3B7AxdzPJr9Gtc9v0Q>
    <xmx:p4C8aSpcytVD42jw9W_T1YDFgoThq7kgORzkIn7ox_iMatGkGyyUZey0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 19:03:03 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: [PATCH net v2 1/2] rtnetlink: count  IFLA_PARENT_DEV_{NAME,BUS_NAME} in if_nlmsg_size
Date: Fri, 20 Mar 2026 00:02:52 +0100
Message-ID: <0b849da95562af45487080528d60f578636aba5c.1773919462.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1773919462.git.sd@queasysnail.net>
References: <cover.1773919462.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269713-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,intel.com,oss.qualcomm.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.939];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 3F13F2D3F5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
added those attributes to rtnl_fill_ifinfo, but forgot to extend
if_nlmsg_size.

Fixes: 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/core/rtnetlink.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

v2: add nla_total_size, spotted by Sergey Ryazanov
    fix Loic Poulain's email address in the CC list

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index dad4b1054955..0fe279432d82 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1267,6 +1267,21 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
 	return size;
 }
 
+static size_t rtnl_dev_parent_size(const struct net_device *dev)
+{
+	size_t size = 0;
+
+	/* IFLA_PARENT_DEV_NAME */
+	if (dev->dev.parent)
+		size += nla_total_size(strlen(dev_name(dev->dev.parent)) + 1);
+
+	/* IFLA_PARENT_DEV_BUS_NAME */
+	if (dev->dev.parent && dev->dev.parent->bus)
+		size += nla_total_size(strlen(dev->dev.parent->bus->name) + 1);
+
+	return size;
+}
+
 static noinline size_t if_nlmsg_size(const struct net_device *dev,
 				     u32 ext_filter_mask)
 {
@@ -1328,6 +1343,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
 	       + nla_total_size(2)  /* IFLA_HEADROOM */
 	       + nla_total_size(2)  /* IFLA_TAILROOM */
+	       + rtnl_dev_parent_size(dev)
 	       + 0;
 
 	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS))
-- 
2.51.2


