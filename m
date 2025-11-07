Return-Path: <netdev+bounces-236886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 886E6C41797
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 20:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DAF53509D1
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8357732BF55;
	Fri,  7 Nov 2025 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEQrSQBT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6132AAAC
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544951; cv=none; b=EfKsbX/p4R4OcZzspUrCdGlcz2IYEmAxQqXVXfrbmBnwjmxKf43OU0cIS8NZSx0Ma41Mf53U18Z7X7I4ENupBYIa1uLHR9B/ccyzvv6qIY2SGeAL2pjVOay+wUC4gyiRpju/lPKXxFBbz/EKV6E9VWy+dx5Dv++9/1KCELmjAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544951; c=relaxed/simple;
	bh=J4wZUvXi7BlP1+Ww/G+19x0mF6vC2xky7wV/+fkku8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VA2fC1jyiIGBwhrT9pAPu0F1fQtlxzNJpVwUKz7LozAZrcta8v8xujHJEiaSSTrqOLNjdHGEJrLHmaBVh/Lr6vevo7EAa8aMF5gcfByIQkRhE5YSG9gKfhUEXgsb0roXzi9GzOgSLvTcc57bOoswpe46/ww7Bh0rnLvOE60dykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEQrSQBT; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63b65530540so111482d50.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762544948; x=1763149748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpMh/mSxXtjLHlF/+Q/QfN7xTlxrTVnWklcGRRkugvw=;
        b=cEQrSQBTJKHEdRLeVj0p1tOF43+NDEfHF/o3bsc0OUXzwPgf+b866E14JMyARHhccu
         AH2wi6J1QoshIeolyymQannrox6HGoRRjKfxp9Hu62SZpRI2A5yWT6XaUbyuPUFw6kKh
         NaAysFHW+pTer9LHs8XJK3j1YDqF0mPXFH2HzNaePCN+czkiE5iw2YBcjhD98wi39U2c
         1tfmGS5/EMTBxOSyDVBbQ8h4UxevwpndrXC5dqr2+VLpbhcXmChDRZqooNXhxAe8UnOb
         zqvjY1DlcAc9zr7O+B6/HT59ByLiubaCsgobeM4Kv9/Wfc0feL3MJxvgDPN238tyRUuT
         Ccww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762544948; x=1763149748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SpMh/mSxXtjLHlF/+Q/QfN7xTlxrTVnWklcGRRkugvw=;
        b=Vw8TPZwpjOWpmdp/XsPh09rJiT4FIPR7Ql1eQcP86aNMzYZUC9d0mHcDaHOnHQjd64
         XYLMjFhzxOXYnDu0aj1De8XVHtv/Uv2etW71QsreIwzkjZKBCtPTS1iEjfR1351BGjSf
         iSLgAcAqozqqcuV8AhsTBbvcaCP04+0mL7zKAQ8Aqy7dprZfSH6R/8/tOrujaVaiTogt
         2A68LDNVyWCiiRL/kIMrZDfXWe/g9DyiqNd3G0NFi3YtadjQZ/5zzgrWp6YpjybF9oKk
         uAa1G2a34ZESYVyLWtTY6KzTtUM9BB4r4cKO8zA0yrlLbt9TuC+2x9kS5Ew88iH1rHMN
         n+2w==
X-Forwarded-Encrypted: i=1; AJvYcCUdJmRRYcCuPbq4taXSY5nzt7rFXAIXnjS7Ctf1CTxhaEpH1mUFG7bKtk2KoY63YukpiY6ren8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PuUh/tYuTBqydIAjUM/a7kbDeudLP6Rmil/FMoVEwo+hWbQE
	VWWzWAEs72atb3PFtejs7aJNybi3erklLssEiJ8srBWo0T8xph/HvCv6LzHayHIBpkgA8u13Gfs
	a15zoObUVjk13l53YvzvsmV9V1O3BZvg=
X-Gm-Gg: ASbGncs6WyWADnKOoKDP5sncuJnjPdsopRjeI8YRJdpPafL3X1ydYnbB02AyII0T5LT
	b4GjXG5NsXRAH4vM54GbX2HHWActJC1LY01yl/bmIMzljWf73y2FrRSfLwxC+4BZ1oMBXk8l0IN
	sKEMQQL2Gmp3HSRYVlIaEBm32ubRhISHFI3s1ew0gJe3aq7DzoPQPTM9q6LSNDIkbmGMxOb8c5g
	grWAkTUWYNTf4BusylCSsos9U4wmZ+r/FVAuXrjzRNZOIgnwI9DQZ5PxNXWVmL/CipOPiIgdr4t
	jNpR8NFSHeA=
X-Google-Smtp-Source: AGHT+IHsyPGiBPpWGTmfAzt0nLOcnLYu1Vx+IbU42YfuoVbWUugKdmDuL5485A/o+78TaJSGduCD14DMWercRrYK3d4=
X-Received: by 2002:a05:690c:4391:b0:787:c976:4dcf with SMTP id
 00721157ae682-787d544111dmr2749227b3.8.1762544947835; Fri, 07 Nov 2025
 11:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
 <20251105-netconsole_dynamic_extradata-v1-1-142890bf4936@meta.com> <s6zjlx2geyjlfwgp2rvw2qolgu6vnsstv5y2rdihxwkt5i45nb@y6jzzo5pvgge>
In-Reply-To: <s6zjlx2geyjlfwgp2rvw2qolgu6vnsstv5y2rdihxwkt5i45nb@y6jzzo5pvgge>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 7 Nov 2025 19:48:56 +0000
X-Gm-Features: AWmQ_bk-gLlNX4oNGxsyxs2m_1vD8UMLpvR4pfZztJHvTMRqknJxZnS1hzE7vEw
Message-ID: <CAGSyskWFhLKBE3f=rcPducGXwcUx8sFK5RuU-BLobV7wg8X8KA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] netconsole: Simplify send_fragmented_body()
To: Breno Leitao <leitao@debian.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 12:15=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 5d8d0214786c..0a8ba7c4bc9d 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -1553,13 +1553,16 @@ static void send_fragmented_body(struct netcons=
ole_target *nt,
> >                                const char *msgbody, int header_len,
> >                                int msgbody_len, int extradata_len)
> >  {
> > -     int sent_extradata, preceding_bytes;
> >       const char *extradata =3D NULL;
> >       int body_len, offset =3D 0;
> > +     int extradata_offset =3D 0;
> > +     int msgbody_offset =3D 0;
> >
> >  #ifdef CONFIG_NETCONSOLE_DYNAMIC
> >       extradata =3D nt->extradata_complete;
> >  #endif
>
>
> extradata could be NULL at this time if CONFIG_NETCONSOLE_DYNAMIC is
> unset. Basically extradata=3DNULL will not be replaced.
>
> > +     if (WARN_ON_ONCE(!extradata && extradata_len !=3D 0))
> > +             return;
>
> And entradata_len =3D 0 for CONFIG_NETCONSOLE_DYNAMIC disabled.
>
> > +             /* write msgbody first */
> > +             this_chunk =3D min(msgbody_len - msgbody_offset,
> > +                              MAX_PRINT_CHUNK - this_header);
> > +             memcpy(nt->buf + this_header, msgbody + msgbody_offset,
> > +                    this_chunk);
> > +             msgbody_offset +=3D this_chunk;
> > +             this_offset +=3D this_chunk;
> > +
> > +             /* after msgbody, append extradata */
> > +             this_chunk =3D min(extradata_len - extradata_offset,
> > +                              MAX_PRINT_CHUNK - this_header - this_off=
set);
> > +             memcpy(nt->buf + this_header + this_offset,
> > +                    extradata + extradata_offset, this_chunk);
>
> then you are going to memcpy from NULL pointer (`extradata + extradata_of=
fset` =3D=3D 0).

I believe passing NULL to memcpy() should be safe as long as count is
zero (which is the case here).
However, what I didn't realize at first is that we would be doing
pointer arithmetic with NULL, which is undefined behavior :(
I will add a check if extradata is NULL here.

Thanks for the careful review!

>
> I got this my vim LSP that printed:
>
>         Null pointer passed as 2nd argument to memory copy function [unix=
.cstring.NullArg]
>

On Fri, Nov 7, 2025 at 12:15=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Wed, Nov 05, 2025 at 09:06:43AM -0800, Gustavo Luiz Duarte wrote:
> > Refactor send_fragmented_body() to use separate offset tracking for
> > msgbody, and extradata instead of complex conditional logic.
> > The previous implementation used boolean flags and calculated offsets
> > which made the code harder to follow.
> >
> > The new implementation maintains independent offset counters
> > (msgbody_offset, extradata_offset) and processes each section
> > sequentially, making the data flow more straightforward and the code
> > easier to maintain.
> >
> > This is a preparatory refactoring with no functional changes, which wil=
l
> > allow easily splitting extradata_complete into separate userdata and
> > sysdata buffers in the next patch.
> >
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > ---
> >  drivers/net/netconsole.c | 73 ++++++++++++++++------------------------=
--------
> >  1 file changed, 24 insertions(+), 49 deletions(-)
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 5d8d0214786c..0a8ba7c4bc9d 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -1553,13 +1553,16 @@ static void send_fragmented_body(struct netcons=
ole_target *nt,
> >                                const char *msgbody, int header_len,
> >                                int msgbody_len, int extradata_len)
> >  {
> > -     int sent_extradata, preceding_bytes;
> >       const char *extradata =3D NULL;
> >       int body_len, offset =3D 0;
> > +     int extradata_offset =3D 0;
> > +     int msgbody_offset =3D 0;
> >
> >  #ifdef CONFIG_NETCONSOLE_DYNAMIC
> >       extradata =3D nt->extradata_complete;
> >  #endif
>
>
> extradata could be NULL at this time if CONFIG_NETCONSOLE_DYNAMIC is
> unset. Basically extradata=3DNULL will not be replaced.
>
> > +     if (WARN_ON_ONCE(!extradata && extradata_len !=3D 0))
> > +             return;
>
> And entradata_len =3D 0 for CONFIG_NETCONSOLE_DYNAMIC disabled.
>
> > +             /* write msgbody first */
> > +             this_chunk =3D min(msgbody_len - msgbody_offset,
> > +                              MAX_PRINT_CHUNK - this_header);
> > +             memcpy(nt->buf + this_header, msgbody + msgbody_offset,
> > +                    this_chunk);
> > +             msgbody_offset +=3D this_chunk;
> > +             this_offset +=3D this_chunk;
> > +
> > +             /* after msgbody, append extradata */
> > +             this_chunk =3D min(extradata_len - extradata_offset,
> > +                              MAX_PRINT_CHUNK - this_header - this_off=
set);
> > +             memcpy(nt->buf + this_header + this_offset,
> > +                    extradata + extradata_offset, this_chunk);
>
> then you are going to memcpy from NULL pointer (`extradata + extradata_of=
fset` =3D=3D 0).
>
> I got this my vim LSP that printed:
>
>         Null pointer passed as 2nd argument to memory copy function [unix=
.cstring.NullArg]
>

