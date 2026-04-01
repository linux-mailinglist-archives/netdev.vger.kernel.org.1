Return-Path: <netdev+bounces-273887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDrsLJ2lzGm8UwYAu9opvQ
	(envelope-from <netdev+bounces-273887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:57:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D015F374C66
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 578CE303677B
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 04:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63EB3009F6;
	Wed,  1 Apr 2026 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carlini.com header.i=@carlini.com header.b="GB9ECgQo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n8+rMTzQ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961971862A
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775019418; cv=none; b=qI2yk8asyW852HX4F6MNHJmAiXcr3D4EkvRIszWvLjBImQUiCIskOTaQt/RREM1hiDwQLo7Kty25ljGn/OXAw3DcFCaY4Oqq3+360MiauNZz+gG4qMwm2nVTuVieT7OYfGRKq1Fj//aO+h6790t5zBcsx1UWvcpTg4sSpkZ8Z/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775019418; c=relaxed/simple;
	bh=UUA7GacbjsInflq4mYX9EdMrtXAaYpnYF7mfHQyK9EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQ6HHmk4EMwUpSnaO7y8lg/d+Z9IFXRMIA8KGIHGY8J6w0+TjBN7i6oc88sXsuQfMoN233y3hDJG7+OuPmnDBFy1s7r/k2eU+x+xqhp9U0toBAKGePvpzMhvQ52gQZXToVtZlkSukATrgbN/mBUOk5iUpJaXaSWL32+ADQiGYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=carlini.com; spf=pass smtp.mailfrom=carlini.com; dkim=pass (2048-bit key) header.d=carlini.com header.i=@carlini.com header.b=GB9ECgQo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n8+rMTzQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=carlini.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlini.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5B381400207;
	Wed,  1 Apr 2026 00:56:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 01 Apr 2026 00:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=carlini.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1775019415; x=
	1775105815; bh=SWvUfw3K7/C0FlAV070D0WtXd044jQNowWlL2yxyQ4E=; b=G
	B9ECgQo1pACfj6hgognU/HHAaHUm+Ea+JrARVcl/uxFFmBiMZWiRlsjronsqhT2I
	xOSRFwiz2t7SS8PtUpALw5bDdRL/Sq05VnmnGdAykXG4sfp8Mu3gfits9D3SQddm
	EgUQrNQInA0MIOl62mKwnaCiN7rPj+0zTF+9RkRdviGIo29oem+ic84FbEw0JkXM
	v17kmvvs1s7k0DKTstVNo/ZQtLd144J4/GumgMvCXLLqvUhZJXmGOBR5gJ0m2AQg
	KWsKvsVsbJ6Xk663KVznfwBjng088OLwZA4QI+3IUxFsGeJFq6U94jp0ZL3jhUDb
	bIdxsVNpEFe1BSCk/23fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775019415; x=1775105815; bh=S
	WvUfw3K7/C0FlAV070D0WtXd044jQNowWlL2yxyQ4E=; b=n8+rMTzQTtujD2vcP
	C0Og88lkm4jP6phfKhiNOwpElJWwgw0Vsp7qmJVTLCsg3F5UIGM7o2XSCi/4qEx7
	ATdAd8ZomqEPZJghQSF6xPippjmI7VGdbB3WNKUaFjYQZ4TD70xPZQX2kd1SpSq/
	YhBIYmDacYaeJB+i2667rI9u/rROQDjiVOMG8h4eZ8QBXxkTjxk4sMO7BcSNsCvy
	b98fu/HOEbeLewHnAc+wCzWowiw4q8lxrFehKVkTywDJFKgfyfUKPI0SP3cdi0ns
	0oAxFJBWYJuhOdxqLUegNP4pSfKyTcXUUXE9pm9tR6XML0Tr4KW8wt+e5e0+j+gs
	EVOMw==
X-ME-Sender: <xms:lqXMac4jhT0GxD13j4Xf6-VkWjdvzwiDLKc8Ruzdnd4xvZalteIrXg>
    <xme:lqXMaY1x8wS62aT1ONC1c6tHRh2Q8LbJJ1VGvUZHd0pR9cxiXQssdh_8bj5jDJdL8
    VqywwRFa-6cldFoZ_nRFMEGOCgjX5LKjMClBPvHpvZ_ab9afCER5Zk>
X-ME-Received: <xmr:lqXMaad9sNX-5u8rP6Z3M0fY4HD3kF8U61Fn4BE_36M0zvZtaylh69RjCmIWHSUNNE3CNhCtNZgaAXb2lXMBjUTGlKGfX81awlg1zHVYwi0N9hQa60wo3wM8xJth8YEnPYy25wdSdjZ90OUOXJBlrv0YtP7dsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepnhhitghhohhlrghs
    segtrghrlhhinhhirdgtohhmnecuggftrfgrthhtvghrnhepudffvdduuefggedtudeltd
    dvkeelfeeiteeugffgveduveeiffevudeuieefvdffnecuffhomhgrihhnpehkvghrnhgv
    lhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehnihgthhholhgrshestggrrhhlihhnihdrtghomhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggt
    uhhnvghtrdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnh
    grrdhorhhgrdgruhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtohepshhrgiiirhesrghnthhhrhhophhitgdrtghomhdprhgtphhtthhope
    hnihgthhholhgrshestggrrhhlihhnihdrtghomh
X-ME-Proxy: <xmx:lqXMaWeOyzMagIbzcy1U8ZG0iuOBoZbpoa-CP78DSxhusGfO-3o_Pw>
    <xmx:lqXMadwH1HPbL8XjpdMOjiDkb2HksUZEGRvcPh0qKa_6ViXgRdJNKA>
    <xmx:lqXMad9u1mVSX5TJSzwmd-CqUl3dkJdokSUMNc_gPjmcZWbBHJQPAw>
    <xmx:lqXMaVhjMuPy_YBDc3rm3RZgbJPXbvmCNKEZ3RCYceHJu2p5vHfRlw>
    <xmx:l6XMaSddgdQpsTbLsZjcccgVfNQAP6Rst-U1PAkblMDa9RVLy0f3g6Lo>
Feedback-ID: i78b949e2:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 00:56:53 -0400 (EDT)
From: nicholas@carlini.com
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Milad Nasr <srxzr@anthropic.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH v2] xfrm6: fix slab-out-of-bounds write in xfrm6_input_addr()
Date: Wed,  1 Apr 2026 04:56:52 +0000
Message-ID: <20260401045652.1807999-1-nicholas@carlini.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <act8zZGYpN9DJ4-w@secunet.com>
References: <act8zZGYpN9DJ4-w@secunet.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[carlini.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-273887-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[carlini.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicholas@carlini.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anthropic.com:email]
X-Rspamd-Queue-Id: D015F374C66
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
v1 -> v2: fix whitespace (tabs), rebase on ipsec tree (Steffen Klassert)

v1: https://lore.kernel.org/netdev/20260328163516.2111971-1-nicholas@carlini.com

 net/ipv6/xfrm6_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 9005fc156a2..a958c08589d 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -246,7 +246,7 @@ int xfrm6_input_addr(struct sk_buff *skb, xfrm_address_t *daddr,
 		goto drop;
 	}
 
-	if (1 + sp->len == XFRM_MAX_DEPTH) {
+	if (1 + sp->len >= XFRM_MAX_DEPTH) {
 		XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
 		goto drop;
 	}
-- 
2.43.0


