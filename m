Return-Path: <netdev+bounces-283659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGxeNzCh92mQjwIAu9opvQ
	(envelope-from <netdev+bounces-283659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:25:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FC4B71E5
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3076C30073CA
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491343876DE;
	Sun,  3 May 2026 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="Mq47np6+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="khcXLXqb"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC235DA46;
	Sun,  3 May 2026 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836332; cv=none; b=eGHxTUxjJiW4t69FxDxSYYj2AWIrU6S9eBV8+NBGLRmEXya/zD4VhkHLU4N12ymesSVGtjG9g1e2Bd++j+XzdYwLa5TAEJFn6hr6z8PD1ConIujUK4HGyFfeOK8P0XgMxWlp97HX4x2FwQSrMTMrc7kAOmV1O356iMZA4SmWUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836332; c=relaxed/simple;
	bh=x/wOzfKy6Tv1YrzEMjVzowsos/hDExwprVUESKdpS7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pL1zUuHnJFx1RyqSxXJhi3X46ldz/MxlXbHbsvK/zrS7jr2SMmqFyTEFu917zk4iMILTE2bIbct+Dvu8APACsddqXgStQnfxtTR7vXTEmPF7mKqk1BDsroUhQ/1q/8dSQINUVhrfXsBX0mWueZFgWNHPdtA8NrKxDXFpgLtSodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=Mq47np6+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=khcXLXqb; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 62FBEEC0136;
	Sun,  3 May 2026 15:25:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 03 May 2026 15:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1777836328; x=1777922728; bh=XV9Ma9YmSNclWXwR8NgoE
	70luGvmhGEBVVi/JFPH2SI=; b=Mq47np6+IcE4AK1cZ2v0P05UjlPP8ZbwE5U1A
	88DZYBxjMHceQ7uS6z/4cdo12tJmQZLGidVqM5+VgNXxdzW+Ch+ogycf1IehL4Nw
	XPQeQI2p8CNoSyacmeUC70jOYH1njkjXTfR7+ipcgyMJjmGuduG9sc3KqfZmfALd
	ZrtoYfuro+YTs1by6pJWSzN25r9Z7sh+ssUynN1ViWClhFN7cj84no3hN+cpW5EK
	az/KX4pvX02sQwDoByhn4FkDDjwylg1fgQ6JvS8dtdDrYUqUnnSnn2uOMT/I18b8
	OZ2BONBnNT1YdMCOEH2fe3INJN/rx0WVxoZlW+l5IKgdUVB5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777836328; x=1777922728; bh=XV9Ma9YmSNclWXwR8NgoE70luGvmhGEBVVi
	/JFPH2SI=; b=khcXLXqbXGQc73FnKe9fN9+6nTjqr2sOwe4XXP+N85ge+8aZl+x
	knpePEVTMsCw1hyz1HQg/DTQ8esRluPzMbsLhl5G32oBou2VzXu+FOv4IAwMGwxu
	o3bywXMsss6SftDPRioMO0YXnSb9w0DFJG6mCZ/WgvWSvKvVFIP1/oEQQOXQA4zp
	3E4XQ/R3Tj6lzGGwxWLwDup0iKED9h/Xd/wVs8HaNZeTCuI4+cPjD8MuoEtPZrdE
	XFc8veEvdwy4gJcGIO9vGat7DIDW2pbSEfOZS/NNjP118YJVTaJC3VA63dKIaLeA
	la1aSQ6TImEeWBr5tSCwmpsQR6Bde6V+SJg==
X-ME-Sender: <xms:J6H3aSUHklxzstRczS_-QIC6IFw7kg9h11HDvY_HK_ZBpyau34SlCg>
    <xme:J6H3ac3OLKudP3_0uIqBW0Jl9Z0AGi4W5qJCbxvGHqbWIRR1sqYWxCVWAtl97UCBD
    tOt02vbKBqL4LnDKNRNcB9Gn9Y0OazlRxA-xgQKAf0b1UR7LPvGlWw>
X-ME-Received: <xmr:J6H3aft-KoYYmDAJm9WYUP7GR9VbWuUb74Ql6QwdOmVE2Zf3guOGL7WVddctq0wAYajkDDUm2J9ftApmrFS2RZNV0lPV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelieejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcutfho
    shhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehkefgtdevte
    dtkeduudeguefgudejheeugfelgeettdfhffduhfehudfhudeuhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
    dpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
    rghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    iikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprh
    gsmhesshhushgvrdgtohhmpdhrtghpthhtohepfhhmrghntggvrhgrsehsuhhsvgdruggv
X-ME-Proxy: <xmx:J6H3acVldv6HATcL4L255UmTKKV2z-9RFS62Qc_uT40BSXrrJON3hA>
    <xmx:J6H3afxtPy-0XLjZ3w3ksNtYGL93HIIuVvjzo42aW-pqyD-cJ3fGww>
    <xmx:J6H3aTGnU8ROaZLW5IALQaod4rW1iU0cfKYBoCId-1jf6xoAfLCL1g>
    <xmx:J6H3aUtvUSdbetNUPbt4rneOrVFidvgL2ULZtlm4F-872u1ikr3abw>
    <xmx:KKH3aWKZp6s0bd0mFXRK70A-w-iti8VAYnssT5MqfsAbXbabJaDTmQDx>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 15:25:27 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 5950C7E6B068; Sun, 03 May 2026 21:25:25 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] ipv6: default IPV6_SIT to m
Date: Sun,  3 May 2026 21:25:16 +0200
Message-ID: <20260503192515.290900-2-hi@alyssa.is>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 268FC4B71E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[alyssa.is:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alyssa.is:+,messagingengine.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283659-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[alyssa.is];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hi@alyssa.is,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

This basically defaulted to m until recently, since IPV6 defaulted to
m.  Since IPV6 was changed to a boolean with a default of y, IPV6_SIT
started defaulting to built-in as well.  This results in a surprise
sit0 device by default for defconfig (and defconfig-derived config)
users at boot.  For me, this broke an (admittedly non-robust) script.
Preserve the behaviour of most configs by avoiding building this
module, that's probably overall seldom used compared to IPv6 as a
whole, into the kernel.

Fixes: 309b905deee59 ("ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
v2: update help text as well

 net/ipv6/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index c024aa77f25ba..c3806c6ac96f9 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -164,7 +164,7 @@ config IPV6_SIT
 	select INET_TUNNEL
 	select NET_IP_TUNNEL
 	select IPV6_NDISC_NODETYPE
-	default y
+	default m
 	help
 	  Tunneling means encapsulating data of one protocol type within
 	  another protocol and sending it over a channel that understands the
@@ -172,7 +172,7 @@ config IPV6_SIT
 	  into IPv4 packets. This is useful if you want to connect two IPv6
 	  networks over an IPv4-only path.
 
-	  Saying M here will produce a module called sit. If unsure, say Y.
+	  Saying M here will produce a module called sit. If unsure, say M.
 
 config IPV6_SIT_6RD
 	bool "IPv6: IPv6 Rapid Deployment (6RD)"

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0


