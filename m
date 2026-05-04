Return-Path: <netdev+bounces-283885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HGsNkSy+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:50:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD94C0134
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DADE930F526F
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0643E0231;
	Mon,  4 May 2026 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="ZyT34O6U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FAcRtxgF"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22434202963;
	Mon,  4 May 2026 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905062; cv=none; b=rArVq+9K5bk3uN89DUR+M+gCspIGwzPvXHrmtI1DpBxGn7jAPIG3bIUyzErtw/f6jqQXZtP0c4VUuTyAQQ02OxHxez6yZpks11jMfiUdhRb0mZ2FxymNnm1Pjo/QpUhWvgZY4zRm9kqL4kAg7EzjaZ8pVuAUV5SHfjj0qZw5GEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905062; c=relaxed/simple;
	bh=nZoBjIez/Vl2E5L1bHRv5PYHbPJxJ30C4EztBDlQ694=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ctpUecSXOiQO9SQTkjXKCaEckqmhsMQEYggsTbCMUcFgUOYHwEOVA1RwD2vwOaOKOKwLOaV9ZYBPMoMw70ydlhPQgy3QsTRcOg+9+KSQbtWFeUdvZugaY2AKLd9lLcYA7ZQVgYujjL+swgtqvTqbskMOiy45AjoVqNEMDU3cm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=ZyT34O6U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FAcRtxgF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D689F1D000D0;
	Mon,  4 May 2026 10:30:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 04 May 2026 10:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777905058; x=1777991458; bh=WuazV6TJ6v
	iKYbAxIlD1RDkT/kBkM0+QnMk1N1i/atA=; b=ZyT34O6UlXvgeDU11g090OIrdo
	SqXpJ709Xz4Jr2GPl4YtF23/KJbRH0XhvWF/eS1suGlqG4IanIp4CAsRtPW/FCu2
	SyfpMNa2GN6hiIR00zjCIi+57N5zDyl8owzjNAY+otr+c4q8Ji5yG85Jfz55IR2Q
	Ys1R4+BglsF29yhKEb5VbWdcWMHUNW+6K/K0BO0/+Qjl54oMXHtjR4yOczfL5Fi/
	cyLQIEyNavMs7Zl6Uzj46yTpNWPfErocb0YM0y9Yz2yKRcEIT03kmzryoNCcAjoP
	zZBKD8GwoySVIXSpbJ1V4sKYVYp1nFILUtElaAzmfHJUXXWTL0PF9l4/mv3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777905058; x=1777991458; bh=WuazV6TJ6viKYbAxIlD1RDkT/kBkM0+QnMk
	1N1i/atA=; b=FAcRtxgFUTBUOifh70JiNb6Tblxum3Wiwe9DJOGajy3n5MKiFDK
	qBfnh89tx64OjTNQZEtttYYTKIVsCsmlm82hx765q9n7Q5qVxTxKV8TgISa/tgW+
	KucWh6D13PMbHSi/78tAZgFZDSwGflgbUl/KKq3Y27E5gSskS4IYbkkuxQOI4s5A
	SGu/AEyP1ihp46zaz3D5z6SWwrxjB57OCrCUO/PI06mrqiKxwmra0XvDZ6qvDi2B
	kRH0PXDN1M2cRhMiXH5lOpkW9ZMyWqwN7+1a4XGuhAzbLx2EG7xfdiUHp6Ul5UV+
	jW3QWSmb/SWghRL1qvJyvyG2/WpFYBs8lRQ==
X-ME-Sender: <xms:oq34aXz0YFgCVbV9x0MwLjSmkjhHYnUQQhnw5pCooIFJy0XMTvF15Q>
    <xme:oq34adgGuAkbpOuzPNvYVdE_uqvb_wmvezqEK3wzo0JJdq5_ZXhQYsoJPqzvUIRbM
    Y8u83MrIV4Jhw4zM9A56zJFPY5rAkrjDrANLFpTTnuMfQH3Lj3X3w>
X-ME-Received: <xmr:oq34aao97w8iP34C-bumb8hRjd8bwEsLW31CmxAh0tGbtN0QAYxS3qpWba1ThfOR_OPygZG1urV9mulrhgtZYGoqBQJGHipkRp2idkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelledtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfggtgesghdtreertddttdenucfhrhhomheptehlhihsshgrucft
    ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepieduffeuie
    elgfetgfdttddtkeekheekgfehkedufeevteegfeeiffetvdetueevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrih
    hspdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    uggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvth
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    hriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hrsghmsehsuhhsvgdrtghomhdprhgtphhtthhopehfmhgrnhgtvghrrgesshhushgvrdgu
    vg
X-ME-Proxy: <xmx:oq34aUjQ4PVlIOmtWqao7bOcQ6-uMcYPaT2AdwvuYGwRbHwoQN7lPA>
    <xmx:oq34acN5BO7SO-vu79-AAJCwojKsHRSMEzt9JAF-aTZUgff0NAsWgg>
    <xmx:oq34aex0QnQHgTiQYy4MJz8TE3qf0MlrMK8IV0i3cR0mYOQFI6U6cA>
    <xmx:oq34aeoJOW-EPpKdcKsf2o65YljDZLbwzZZsade_BdN1AAvVzFXi7Q>
    <xmx:oq34aY277pOWuTyXEREkpAsbJV7NJpna7MZ5bWhnzSBqTC2frasLgPPw>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 10:30:57 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 4DC267E81A08; Mon, 04 May 2026 16:30:55 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Fernando Fernandez Mancera <fmancera@suse.de>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Ricard?=
 =?utf-8?Q?o_B_=2E_Marli=C3=A8re?= <rbm@suse.com>, Krzysztof Kozlowski
 <krzk@kernel.org>
Subject: Re: [PATCH v2] ipv6: default IPV6_SIT to m
In-Reply-To: <5f676587-fcdd-4704-9523-07a7fd98455a@suse.de>
References: <20260503192515.290900-2-hi@alyssa.is>
 <5f676587-fcdd-4704-9523-07a7fd98455a@suse.de>
Date: Mon, 04 May 2026 16:30:51 +0200
Message-ID: <878q9zdz6s.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: D9AD94C0134
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[alyssa.is:s=fm2,messagingengine.com:s=fm3];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283885-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alyssa.is:email,alyssa.is:dkim,alyssa.is:mid];
	DKIM_TRACE(0.00)[alyssa.is:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[alyssa.is];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hi@alyssa.is,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Fernando Fernandez Mancera <fmancera@suse.de> writes:

> On 5/3/26 9:25 PM, Alyssa Ross wrote:
>> This basically defaulted to m until recently, since IPV6 defaulted to
>> m.  Since IPV6 was changed to a boolean with a default of y, IPV6_SIT
>> started defaulting to built-in as well.  This results in a surprise
>> sit0 device by default for defconfig (and defconfig-derived config)
>> users at boot.  For me, this broke an (admittedly non-robust) script.
>> Preserve the behaviour of most configs by avoiding building this
>> module, that's probably overall seldom used compared to IPv6 as a
>> whole, into the kernel.
>>=20
>> Fixes: 309b905deee59 ("ipv6: convert CONFIG_IPV6 to built-in only and cl=
ean up Kconfigs")
>> Signed-off-by: Alyssa Ross <hi@alyssa.is>
>
> Hi, I am not sure about this. IPV6_SIT was already defaulting to 'y' for=
=20
> most distributions (except for ARM). Sure, if you had CONFIG_IPV6=3Dm the=
n=20
> CONFIG_IPV6_SIT was defaulting to 'm'.
>
> Hm. Maybe we can aim this for net-next tree instead of net? I just don't=
=20
> think this is a fix but a change in behavior. FWIW, it makes sense to me=
=20
> to have this as a module by default.
>
> Let's see what do others think.

Yes, it appears you're right.  I had only tested on ARM.  In that case,
perhaps it make sense to instead set this to m in the arm64 defconfig, to
preserve the previous situation, but I can also see the value in
reducing platform discongruity by letting it change to y on arm64 too.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCafitmwAKCRBbRZGEIw/w
or0EAQDFdUqaDgVAWzQCvBcq5MeKTpoMcu8P9q0+TsR4I249TwD/XWXc+Y1bp3To
BCuHzMnUih5DCohtUAXHZ+cz+O1N0gM=
=uL/Y
-----END PGP SIGNATURE-----
--=-=-=--

