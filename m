Return-Path: <netdev+bounces-168296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40AA3E6D7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AAB3BE345
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249626738D;
	Thu, 20 Feb 2025 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5g8mPoS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA7265618;
	Thu, 20 Feb 2025 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087684; cv=none; b=BCgAasHJmfOgnV/3ZGpDPGta3b6ZjiqHwyYQO3eXyUIB/PXFqgwH1DzOz2KnKgr8Q7MEOvm1LnkhhpLt0dyd24Y1eBdKRZd2S79AM8Uk5isJPnwB+3bnXI/rCQmCT2VsFdo9D0hlJTF0PF9NeJFu3s/dJF8Ht8cOGrJD3wpckNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087684; c=relaxed/simple;
	bh=xWbxlZ8XIxmQMglo4Z3hjYDnL1wvVtzyKy5JwkqNqFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKHzoVH7cc6ec6dq/HSP2sYQcYNlR+L+Gtk0dmtiwVJWxPxbhKCjWTaLjdMW56M62HTpnzx/qPiNVmRQ7zSHG7Nkdt8dpg/jli54Y/R3pf9jmg+amJ7+ev00WRAxcJHdT+y4u30eKwt6sWSTqu0Nikxt+HrFPCxPHPwcZGZqw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5g8mPoS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so9329835e9.1;
        Thu, 20 Feb 2025 13:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740087681; x=1740692481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+giesiVLT36I/TxJJnVR5ILSFrF2c0TN+SNJ1iFY2gE=;
        b=C5g8mPoSIHkgTv0JGCcXTxk9jhMo1kTyrDi5Vphk+7dlcRu37wWmDRowfeSLI320/n
         lFBnUjxjJY/wCv5eck89Lo/DasNNGaq9ODZ4eMR05BuO587r/2SoYYF+QbFcO5/es5wG
         /+EMhhGxbdDvVgHRpb4//5EDdt+umHpEBJCUfXZbUpZriFpwRZcRRx0VkN+PV1abAWnW
         qw2kmD7UhnSmCX/IqZnX26LteRr11kgCsyhWT8DxrCTwaUk7s4wfjhwJS1/iF1vXqifG
         GjTTGsm1oLBJqbqR2tx2tnTw1dcNl+0L1bKutAsNu6nup0uGoyvFqnofkzsSTT7wPPDQ
         7hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087681; x=1740692481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+giesiVLT36I/TxJJnVR5ILSFrF2c0TN+SNJ1iFY2gE=;
        b=xEQgYfwRTJPL1mw50MpipMKdFAttdGuAugGU0Em+wGAq2D34Kv1dH0ByouzdiEvJgx
         cvcPGo0TRd67d2zSj3M7q9jxhYKqeFnmypvDqyvlTnfka8n6RESF2TAKK5fE07mh0uj2
         pgNN+yhGbSQgw+M0KlfCAHZ/RniGL2pCibrOjqv3jDCGeshqlfw3HxTtK9OKP9SS8AVC
         TbAepQBPRj+9Z+P65iylh6ftNu5dAp9oFm+9zWeewhwwHUa8OmBDokhdC14r5gaNDN5n
         rdgjLoTK0u2Oo1RggOku0gsqYRtfS+EDrugrTvWoBHlAlCrwsYxAxJdi/1HFvLGNroe9
         NQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuinYuHQMkl7MXVki1BqGSDfh4cL1hIkL987sV4RRrTbY6qhtPFe/I2if874UTmSq5QxP0QihaKy3r7e0=@vger.kernel.org, AJvYcCXnB61rSAX4XTgHNnmMtZuvm/1+plFObrH0xYMQAFbnKTbLIrp8El5ZndVJeuy4ZsokJuZL6fCt@vger.kernel.org
X-Gm-Message-State: AOJu0YxRl8NvI5jyg1ooX/B/lSF8xBzDUy2RvcjW56b8jYkXLWeDInLH
	8BBjBRzkqY4SOQhL5apHA8GHbIUDL1dwsT+ajI6wA5Lt9L/KLRj2
X-Gm-Gg: ASbGncs2TvJAtbzUXwq9rN+e5j9FN6wzjwyRsv6fGxtu3A4liW33VqdakqgHsELzhnC
	L5pka14J5V5I5jEWuQENA2A4tF7b8GdtXKLa3EhrgU39OSNdtsJT4blG3LzZ0F+PlECefnnSG29
	Pu7MRMVgomvj5+WSlDFLOxZvrHBDbJl5XL0pNupGgUV/UEg0tHU1YOPa2xYliCwTB3Mzbxi/qEd
	K13zl/o426wgtgTTgXrhBKAq+yJDyehHsZjsmYVzgCUgdzhw0K5Hx/C5ViVmaEkwHEiy6Fu2DyT
	PhoXKqvMQGW6fYNONG3bm9FOP0GOV7hKgP3DO4uH6hqLQoux6BrT3Q==
X-Google-Smtp-Source: AGHT+IFzQRngn7s9Mpcn2XZuZWypBnuCbNZE3ttI6rpb6j4WfyEJdbDxfCKJ6sMhsrzeHDLKSXQGAg==
X-Received: by 2002:a5d:59a4:0:b0:38d:e6b6:5096 with SMTP id ffacd0b85a97d-38f6e95f30cmr679865f8f.15.1740087680862;
        Thu, 20 Feb 2025 13:41:20 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddba7sm21923734f8f.38.2025.02.20.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:41:20 -0800 (PST)
Date: Thu, 20 Feb 2025 21:41:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: Dave Marquardt <davemarq@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, nick.child@ibm.com,
 pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
 senozhatsky@chromium.org
Subject: Re: [PATCH net-next v3 2/3] hexdump: Use for_each macro in
 print_hex_dump
Message-ID: <20250220214118.72f4c2bf@pumpkin>
In-Reply-To: <4c424cb6-3c2e-47a2-aa75-98fb20d805c9@linux.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
	<20250219211102.225324-3-nnac123@linux.ibm.com>
	<875xl5y50q.fsf@linux.ibm.com>
	<4c424cb6-3c2e-47a2-aa75-98fb20d805c9@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2025 09:49:04 -0600
Nick Child <nnac123@linux.ibm.com> wrote:

> Hi Dave,
>=20
> Thanks for reviewing.
>=20
> On 2/19/25 3:54 PM, Dave Marquardt wrote:
> > Nick Child <nnac123@linux.ibm.com> writes:
> > =20
> >> diff --git a/lib/hexdump.c b/lib/hexdump.c
> >> index c3db7c3a7643..181b82dfe40d 100644
> >> --- a/lib/hexdump.c
> >> +++ b/lib/hexdump.c
> >> @@ -263,19 +263,14 @@ void print_hex_dump(const char *level, const cha=
r *prefix_str, int prefix_type,
> >>   		    const void *buf, size_t len, bool ascii)
> >>   {
> >> -	for (i =3D 0; i < len; i +=3D rowsize) {
> >> -		linelen =3D min(remaining, rowsize);
> >> -		remaining -=3D rowsize;
> >> -
> >> -		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> >> -				   linebuf, sizeof(linebuf), ascii);
> >> -
> >> +	for_each_line_in_hex_dump(i, rowsize, linebuf, sizeof(linebuf),
> >> +				  groupsize, buf, len) { =20
> > Several callers of print_hex_dump pass true for the ascii parameter,
> > which gets passed along to hex_dump_to_buffer. But you ignore it in
> > for_each_line_in_hex_dump and always use false:
> >
> > + #define for_each_line_in_hex_dump(i, rowsize, linebuf, linebuflen, gr=
oupsize, \
> > +				   buf, len) \
> > +	for ((i) =3D 0;							\
> > +	     (i) < (len) &&						\
> > +	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
> > +				(len) - (i), (rowsize), (groupsize),	\
> > +				(linebuf), (linebuflen), false);	\
> > +	     (i) +=3D (rowsize) =3D=3D 32 ? 32 : 16				\
> > +	    )
> >
> > Is this behavior change intended?
> >
> > -Dave =20
>=20
> Yes, for simplicity, I wanted to limit the number of parameters that the=
=20
> macro had.
>=20
> Since the function does not do any printing, the user can do ascii=20
> conversion on their own
>=20
> or even easier just ensure a \NULL term and print the string with the %s=
=20
> format specifier.

That just isn't the same.
The hexdump code 'sanitises' the string for you.

>=20
>=20
> Also, allowing the user to specify the ascii argument makes it more=20
> difficult for them to calculate the correct linebuflen.
>=20
> For example, rowlen =3D=3D 16, and groupsize =3D=3D 1 with ascii =3D true=
 would=20
> require a linebuflen
>=20
> of 16 * 4 + 1 (2 chars, 1 space/NULL and 1 ascii per byte=C2=A0 + a extra=
=20
> space separating hexdump and ascii).
>=20
> If ascii =3D=3D false, linebuflen is very logically 16*3.

But the buffer only need to be 'big enough', a few spare bytes don't
matter.

You can't change the behaviour like that.

	David

>=20
>=20
> - Nick
>=20
>=20


