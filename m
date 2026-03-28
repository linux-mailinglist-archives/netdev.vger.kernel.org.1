Return-Path: <netdev+bounces-272787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDAYLbkDyGnugAUAu9opvQ
	(envelope-from <netdev+bounces-272787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 17:37:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC14E34F303
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 17:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C341F3013196
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025703A450E;
	Sat, 28 Mar 2026 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carlini.com header.i=@carlini.com header.b="hKqofFqA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RmisDd/6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AB33C18B
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774715722; cv=none; b=HdEM/pW8F0U9C9uGnfWSoFFvxNkwqzinPv7GtD78KJhaRF3cNBrBcN5AiMiXv21WIv+cwpL41F+ZyF8b8vA1gKD3iHzB5QjEJTasQr3mnsY4dE0UnrUSPjrz+poJKLLYzdaNcaFjfeTWTLLRa27SVS/3KiviPZQXHYAauPXPkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774715722; c=relaxed/simple;
	bh=GJoaATxqiThJHB/A5Vfgd30jzdOLGmOmiL7NJRuKzjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c72zkdHZSRIgJ0fNMLUESep3Q1UAj3frDMleHnJeNBHgB20gBfi2HBzKHopnW2VxKECXA7SHVPZz4UnkM+oZPLZMErHCc2H2g+fNaZVa4qHaQTCvDEWWmSCmA8oCcc9SHLp7vk55gdRzzN6gt3EwcUXZemMKdIRuFyvUrbMdAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=carlini.com; spf=pass smtp.mailfrom=carlini.com; dkim=pass (2048-bit key) header.d=carlini.com header.i=@carlini.com header.b=hKqofFqA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RmisDd/6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=carlini.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlini.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA32C7A01A6;
	Sat, 28 Mar 2026 12:35:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 28 Mar 2026 12:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=carlini.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1774715719; x=1774802119; bh=90YPRoRWWuassmQHsRnkD
	goaHXeFk8zo0icT/ORYCy0=; b=hKqofFqAXoNjQdN1ssZ+te63ERKofsKZM4JXl
	JCPTP/1RZPvC9kdY7vIy7hGH5deYQAPwlpgyVjYuUwW+B46jXntewlg799gOjzLh
	6w8bl4PauB0kfxuT+5reytMZ++zm94Yod0EWwi2zmFAy6T+vqqZQh3qOHKna7Dd5
	//d9kjCm4znT/yuRk7Ktlo2ePA+m49PSLGIXEqwgGXjeaRF+XlUVBj/qjwQso1eq
	AsLAN00Kp4kECl4n6QSORrcAO+aXnBKc0GNAJTNj9D5eozNIL7IGvbcvR8zic6jO
	aAPo9Wcc9cW7p3/SB1qy3UggldRVNOSWWeHMwV0QHK8e18H6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774715719; x=1774802119; bh=90YPRoRWWuassmQHsRnkDgoaHXeFk8zo0ic
	T/ORYCy0=; b=RmisDd/6NFq7wOVlkZQUAoPKwqW/DqGw5WHIn1ZgFS0R0PVpz2e
	KfDNhTzfPP8rv3c/UYa9IRYhwO8/POEfCmbFkX6PqfcVHUkwcyQLhjkBuV0N3SAU
	mlECFo89TvbnV0pfE7dOoGSm3lF5WskvIoANM/LiZjw6/2qfMPvaVYS7K5zWTjpK
	NvbIAkJVQbj/cG75ndnbp8u9Ln6iW1o4Vw4XFIcjij2Wp23RGp+fKgCpjLcQyeNB
	BtB9lEFWx0eKoArKNvCqJB+kw+6CxE3szrpPS6bBL+uf8rhjkWZyRZN6C4pd9qE3
	77x7TNSpRSuHq4JFUVvdK68abn7CrrXtVhA==
X-ME-Sender: <xms:RgPIaWsMXEjDwe5GDqeqdJUk_iaNECekVf2C_eULmv4_ErlqNB6YtQ>
    <xme:RgPIaWaKLU4nNY8lT254ktUYcGeYa-CT1I_KQD8KY5IrIbLnIah-rTXmcQz4b4ezC
    OX8G8GNzh-5b6nNMtVCKWPU9oJhVNiheVLsloJRcSsO3qsbiRE8QP4>
X-ME-Received: <xmr:RgPIaQwIzEuB1T6A_Rik-Rm67EeweQn0qzCsbZFswLs0LcuakbqmUBoVwnHnv2HkBY_IEybffFG5GAGKj23y7WxkOUnI_fGmamf75FaMvvAnx3pc023z5Ii5IC-kJSZoPo6xnWSA2TBuwKChMrLUhFRfYcJbsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeefieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepnhhitghhohhlrghs
    segtrghrlhhinhhirdgtohhmnecuggftrfgrthhtvghrnhepjeelfeeuieduheehheefje
    ffvdetvdefuedttedvheefteffvdefveelheffgfejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghhohhlrghssegtrghrlhhinhhird
    gtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvfh
    hfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopehhvghr
    sggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepuggrvh
    gvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehsrhigiihrsegrnhhthhhr
    ohhpihgtrdgtohhmpdhrtghpthhtohepnhhitghhohhlrghssegtrghrlhhinhhirdgtoh
    hm
X-ME-Proxy: <xmx:RgPIaWg5-GZ05TYgZ1d5a7BUOSAnSpUo6BPSc6JdZ4umOxdKEp_F7g>
    <xmx:RgPIaUm9Z-IfXEfxwrd60h0XTDXprFZRL9cQhNDGCWGQSvr8LEJ-1A>
    <xmx:RgPIaUicNvaK6xi9jZkWWV3XXqQl62tcwt1Lgg42FpVG29nFlHXWEQ>
    <xmx:RgPIaQ0Pvq_nlpmT0fsba7xgmUEM1C8oIAyzZYasZ4v28s3Md30TZA>
    <xmx:RwPIaTgJmQT8nBa9_S5kcPrUgwl_xQtqhlCbO1OGfsdNoQnNLAw-U9T1>
Feedback-ID: i78b949e2:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Mar 2026 12:35:17 -0400 (EDT)
From: nicholas@carlini.com
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Milad Nasr <srxzr@anthropic.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH] xfrm6: fix slab-out-of-bounds write in xfrm6_input_addr()
Date: Sat, 28 Mar 2026 16:35:16 +0000
Message-ID: <20260328163516.2111971-1-nicholas@carlini.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[carlini.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[carlini.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-272787-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[carlini.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicholas@carlini.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[carlini.com:dkim,carlini.com:email,carlini.com:mid,anthropic.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: BC14E34F303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nicholas Carlini <nicholas@carlini.com>

The bounds check guarding sp->xvec[sp->len++] uses == where >= is
required. When sp->len has already reached XFRM_MAX_DEPTH via prior
ESP processing in xfrm_input(), the check (1 + 6 == 6) is false and
the write goes out of bounds into the adjacent skbuff_ext_cache slab
object.

An unprivileged local user can trigger this by entering a
user+network namespace, configuring six transport-mode ESP SAs plus
one MIP6 routing SA, and injecting an IPv6 packet with six ESP
layers followed by multiple Routing Header Type 2 extensions.

The check was correct (>) when the function was introduced, but
was changed to == during a refactor in 2007.

Fixes: 9473e1f631de ("[XFRM] MIPv6: Fix to input RO state correctly.")
Reported-by: Milad Nasr <srxzr@anthropic.com>
Signed-off-by: Nicholas Carlini <nicholas@carlini.com>
---
 net/ipv6/xfrm6_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 9005fc156a20..a958c08589d6 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -246,7 +246,7 @@ int xfrm6_input_addr(struct sk_buff *skb, xfrm_address_t *daddr,
         goto drop;
     }

-    if (1 + sp->len == XFRM_MAX_DEPTH) {
+    if (1 + sp->len >= XFRM_MAX_DEPTH) {
         XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
         goto drop;
     }
--
2.39.5

