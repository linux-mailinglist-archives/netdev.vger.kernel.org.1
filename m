Return-Path: <netdev+bounces-258646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDR5OwRYj2lqQQEAu9opvQ
	(envelope-from <netdev+bounces-258646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:57:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103EF1386EC
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F0C4300690C
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C924B34FF41;
	Fri, 13 Feb 2026 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fIdFrDq9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4A299A87
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001854; cv=none; b=pnqoyOgMNc6+kK3I1m0Nc6u8oFCOm25D4IKvbgAUH5a+1Ta1fuetP8rfrp3xaMwmXNygoORKOoQmB+QsI1AE6ZKFjwraFWfLgZn+OLJsJcI/LE0J5QqHnFnoE+ViGj3m3RAtVf8+qInNdTC7l3R8lm8ZFXQP0v4V6TzLBwjUDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001854; c=relaxed/simple;
	bh=ZHtx23E+ZSL9bEg+4dgJjINpioxVsODP/Xcrg9pdvus=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=YCwN/0z/Q6hrLekBGCXMwGu4b+X91ObGfn/HNLT+v1pxxcE/8UvcF7o9a6ij2Q4NEAp3gzFknvziF1YPYDn4KyLF+r/GBJwUKckpEtcjd9/5E4zcDVNqjGdZVjtgHlIn5qHBKrOP63qaQE6JJI9FIg81D50zHNJwFd7U7xz0Elc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fIdFrDq9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A1D1E4E40D3D;
	Fri, 13 Feb 2026 16:57:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6EF3B606BE;
	Fri, 13 Feb 2026 16:57:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A2FC10368EF5;
	Fri, 13 Feb 2026 17:57:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771001842; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZHtx23E+ZSL9bEg+4dgJjINpioxVsODP/Xcrg9pdvus=;
	b=fIdFrDq9DTIwos/hewZKvcd/Gdk4UTNYTWULMwmRIFlUTSGOVtF1gacl8BBBo86sj7Gljt
	afFPkE80qna5nltaOAJaAUPvS0hOqv5CDsdYNKR3YRl9Rh1c7mxZOEGViQnhpdJJxyKJLN
	32UxdDZrRPNhfXKILOY0fiBn72OQTRf+ZdZarx4+wpXfncYXq8oxSEFtVrbsw9eXmd2kgP
	dk5SNRvKhDdEz+P985G2S79dUmwgEoRgji9WZeXeXuMy3SzpAso2/lPH5Kq9vTwW7iFPpC
	QJbJuPq2FqQoSHI0McoUQ4iHhMbyLiHk1VYHLKryyMcveYJOjOjGjHIvQIpj+A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 17:57:17 +0100
Message-Id: <DGDZR8L3E9WI.2MEYVL01KQ2YN@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 0/8] net: macb: Add XDP support and page pool
 integration
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115222531.313002-1-pvalerio@redhat.com>
In-Reply-To: <20260115222531.313002-1-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-258646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Queue-Id: 103EF1386EC
X-Rspamd-Action: no action

Hello Paolo,

My XSK series (based on top of yours) is ready.
I won't be sending it while net-next is closed, of course.

It starts with a few cleanup/rework patches that have no direct link to
XSK and touch code you add in this series. They could be appended to
your next revision or even squashed (with the right SoB &
Co-developed-by trailers) for most.

Some contain bug fixes, mostly related to stats accounting. I expect
some amount of discussion as well, mostly regarding the page pool DMA
direction.

Patches don't have the proper Fixes tags, sorry about that.
I'll send them as reply to this email.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


