Return-Path: <netdev+bounces-301168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hP61KI1mOWrorgcAu9opvQ
	(envelope-from <netdev+bounces-301168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:45:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 004ED6B13B3
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:45:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bKqsuRg2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301168-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301168-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2DDD3003607
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130352BCF4C;
	Mon, 22 Jun 2026 16:44:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF06175A85
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:44:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146699; cv=none; b=Y5Cb1XNChmSS1Sl46uiFO13lxjNU3uyWlVf8levFcuOGgrYLJn9vkE0SjOt3tm6j7IWQwK+uKzLwdtFeCqR8PA+Mh2p6rul5pacc0AzF2TXc31z1F3I5FW/1jGAtnbZs4+DzKOSEXBRErEo36t5a2eFf3wFueg4BT10HJBiiHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146699; c=relaxed/simple;
	bh=52okT5bt09/zEjfuJg57RgAQ9s722P7n5z2k6Vageuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivz+hvevy+0FAvh8xfG2whAid7Jpex076uMEXhD69HIBY+qtQ7238Yp+88gbY03iYo/f1MFZz8UKO+8erxOPjXF4FSUvfb8h9pa4DiVMYW16xBuLxFosZAEVer0jp6YwqLhmbe+6DHn3VC/DonGhQTjTFgTHpQsRUwTKZzAmxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKqsuRg2; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4924593f45dso29832975e9.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782146696; x=1782751496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbhX7NYq6NAwLggkmVvi+rfcNAqAVuZT3BPCddDjjeY=;
        b=bKqsuRg2aNUGuM8WGf53lFWekwt2WtZWy5+OFJFByYWnpSdRC+h5tSrhhbSBFgivbY
         8KalttBbiKxIriBw4F1m+kh88+fyOAnk96nJWjCyONASOo47oN/euj01lGgYYz2IrD5r
         TTapykk6cRLm4k9AWfQ0kPvnRRFZ2CWuAw1R38sounNfaleEgIiIliNVC+3jGleeqKpM
         RwbePOey2vpaHMnrANvSQvF20ZIHgo/zNP4qJ6IyCPqJ7OyeMu1fw27KwWGrCSVFvvv5
         ArdgTOKLn7Wai0cdcMEC5iQEr7a/NEfsZjGztexSamqohaOiRHiplql7HVGNifcOTc/m
         p2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782146696; x=1782751496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbhX7NYq6NAwLggkmVvi+rfcNAqAVuZT3BPCddDjjeY=;
        b=HfUgEX1yTEzIrhjf3LdhVhVt/RDRwmppHpy+ZnYjHqEy0lIt93lf8RbaICvVXot01Y
         XluUDKVvv4l+I25OexQ7s+BpjInhnifDQo3L+hU7yCpF6DglHKhMs6T0Zr84UF21zjD6
         QQL6UChePEISA1rixi0Fl3rwl0hqN4x2dqyghE0r8Pi8KDxDzDQUSmqU7+LU0HDwIKiK
         RvAWGq25DfpTnvNfXRRSaVxOekFHBZJRKktxCUtiN/F98g0utD9X5rBXt8GrQ62N2bnS
         7IdnDpPvbO+xHZHp2XrnisMR0Moi5H3TZnTAM8gDyRzw8nI4/MOamF3aNLHtNNTopA1Z
         +mKw==
X-Forwarded-Encrypted: i=1; AFNElJ/XKNXQFnEwQaZBaV65IpjtdaB9HM7bxqvOPQKtjDowGqWxjafGMtwOPMkN3faNGeV0Qb9HH80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6nx83KoYL8dyGwjxIJLieQ/L66UvEygzmviLLtUZ2rngA048
	b1JGG/uQi7lzb0zA7Bhv6fpTHTqgaPctw3JHfIj4B1k30+MjVql+sr91FT+4XBoE
X-Gm-Gg: AfdE7cnTrP3VNU2B/faqu19KrKsrFkdrJL9X1P5ecvPA1g39eKd6tTHj5V7gFz46dyD
	vKHssWiBHEoUd/pmq9EEdjqKauRej62Ij9vzuFmYcTRTNpsPT5/1RPdlN8tSSKQIIabfUVb14NW
	Zhsv+aWVDnB6KylpueZgZGP8bMuozoxZx7wABPe788S46L9CrsMiVHLFQOSt/L5KUmN2iK7KgIa
	dlf/7weTQbHSKY1qiI3Mi8v7YWe0hJyXQaZ4D1pFvpBe+wzw95Y6smXKbjex4N9eRYmx0fruS4v
	j+YBwhoLEzCoLqwsv/2OlL9p2WDtO9siuYv2/lDtsPB+/Bo3TKNJ2dtr45XpWFtrPvWDVgcQy0N
	C4nTp6lQ4qRXCQpSfk/CR/Ib0gKFoMxSIjz9/HmFdS5rddvV3Vaej41Lz5O0453s1wKRZ4PPREZ
	HLU4TqQVYmhJO4pFBjO1/rbcSWHfBQ1DW9Ueflfo6OOPHCC/yAww==
X-Received: by 2002:a05:600c:1c09:b0:492:4d56:d5fe with SMTP id 5b1f17b1804b1-4924d56d644mr181368975e9.14.1782146695650;
        Mon, 22 Jun 2026 09:44:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57a0esm25841842f8f.27.2026.06.22.09.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 09:44:55 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:44:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Dmitri Seletski <drjoms@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] "ip help" wrong output, exit code.
Message-ID: <20260622174454.576b3580@pumpkin>
In-Reply-To: <20260622075700.27806286@phoenix.local>
References: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
	<20260621082105.1196ef72@phoenix.local>
	<069b13e1-f689-410b-bd40-b5e5831b67e7@gmail.com>
	<20260622075700.27806286@phoenix.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301168-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:drjoms@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,networkplumber.org:email,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 004ED6B13B3

On Mon, 22 Jun 2026 07:57:00 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> On Sun, 21 Jun 2026 22:48:59 +0100
> Dmitri Seletski <drjoms@gmail.com> wrote:
>=20
> > From 0805e07105cd15c5b94271a4706e50e3c65dbde5 Mon Sep 17 00:00:00 2001
> > From: Dmitri Seletski <drjoms@gmail.com>
> > Date: Sun, 21 Jun 2026 22:12:43 +0100
> > Subject: [PATCH iproute2-next] =C2=A0"ip help" wrong output, exit code.
> >=20
> > Changed output of "ip help" from standard error to standard output. And=
=20
> > Exit is now 0 instead of -1. "ip help|grep bridge" - now gives bridge=20
> > syntax instead of flooding user with everything from "ip help".
> > ---
> > ip/ip.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/ip/ip.c b/ip/ip.c
> > index e4b71bde..4627b61c 100644
> > --- a/ip/ip.c
> > +++ b/ip/ip.c
> > @@ -56,7 +56,7 @@ static void usage(void) __attribute__((noreturn));
> >=20
> > static void usage(void)
> > {
> > -fprintf(stderr,
> > +fprintf(stdout,
> > "Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }\n"
> > " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ip [ -force ] -batch filename\n"
> > "where =C2=A0OBJECT :=3D { address | addrlabel | fou | help | ila | ioa=
m | l2tp=20
> > | link |\n"
> > @@ -72,7 +72,7 @@ static void usage(void)
> > " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-o[neline] | -t[imestamp] | -t=
s[hort] | -b[atch]=20
> > [filename] |\n"
> > " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-rc[vbuf] [size] | -n[etns] na=
me | -N[umeric] |=20
> > -a[ll] |\n"
> > " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-c[olor]}\n");
> > -exit(-1);
> > +exit(0);
> > } =20
>=20
> Your mailer damages white space.
>=20

The output also needs to depend on whether these is a 'usage' error or
if 'help' is requested.
Code code is correct for the former - except it should do exit(1).

	David



