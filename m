Return-Path: <netdev+bounces-236859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B3C40DBA
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2635D3A6AED
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC352765F5;
	Fri,  7 Nov 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUu+6LYY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFEF265620
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532474; cv=none; b=lm+VsLRSBOiNo32YS0GI9GD3rB5/oRoCeYPPQd9f2kU4P/wDOL53BrvtX0DRXj6yekD5XTkoWyEE4kn1XwLLn8gfMD0L7PBkZAV4FnrYn4J0SQ0WwQYf5NQ4tnQSP5RKiyCclU92xxMCAw26M+CO+l/uGiWPXMK8I/3fVV3UgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532474; c=relaxed/simple;
	bh=NietJe/QJAm9Cs5ArMPH0M7Xx6Anhz03iWfpigwIuug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbKkI078RpwgxBy0lehQodWmsm/9KIl0KZJCSwtDVTqnhN6i5//hG6qYP8pDxfSMY0qWGkzKHCqBCwwLMHG1ovt6ZLI0SFZ7+0PNbED+VHAjNIqnpH2rtTkN+88b44w48ARfnVwAjvx8f3cuFObXFdnTdoOFJJ/CMQtN45Wz3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUu+6LYY; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4331d3eea61so6823965ab.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 08:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762532472; x=1763137272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NietJe/QJAm9Cs5ArMPH0M7Xx6Anhz03iWfpigwIuug=;
        b=SUu+6LYYb/vdLY0oxkEFd4TRi+2P5DxG5ioGwAgkt9MRVxTsz+k7XwUWVEYp2t2KIq
         7K+1KTNJk1ZypwrgyYwZCp3lIBRgvKY9Ahk9d2LNHtBrYHNDQwrs5ETJg6vTV/YBLVeD
         3pZp10cb/5sLxyBsOEZdoKWjdgCI06ia/T5EiTWcgPo6k08typO8/tLO+zOa2lrxUMcY
         rnM0Mpz2TLfhGy+4sWud7SSvPTHTG9mzjBNO0LXBcNl7C9GFLq6otZWdIOiuo0oGXCBv
         cZxeUP+sftIfOwAJSm61gO5tsyjmVVuAmuU+WB8zAFvhrbacISzd2fWOY7qsP5O3EhjM
         +KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532472; x=1763137272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NietJe/QJAm9Cs5ArMPH0M7Xx6Anhz03iWfpigwIuug=;
        b=PMyHGzkfOZS8ZggPUqDrNyHOXOhMsUwE1qwGotcNVZfSlsp+Le8HMyJzU1ojKFpH9f
         b0WaBYODGFEC55QWNiisZ1MUS3SjhAHr8cO+hbyBXowgokhqZNwOhqbr1v0N8FQcVaPq
         aapwicjo0XhoBFydiISpYxu6LflD0DPXkjg/McMSKLmoBovPUD30L/sMZroGKeCTu1MB
         bu8iUWKl59rOVFstM6+seju4/h6MLIySfuq9LSN6H1Cjrm89ujw9bJqvrADFasXEAupP
         2nAAu5BNqM2yYxptHB7AWCezoO1XgehYCMOZLiaNL5pzk+G9+98HCyRIgvyHCfU0Cdn7
         AtLg==
X-Forwarded-Encrypted: i=1; AJvYcCWtE7BwSwhyWR8mHMhJD8XdJ0UKu5yyY9dzjGg3csmk00Z8mcAs8/aJ4vhnpODvIsiNHx9WqwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaD7snp2QDcRft3WKZcd/YHWVTclifEBwLeLu7PdtKy7Wh3m5b
	a7P/wXxep5lVs1vZ/ZPOw8z6cUlt/pWEmWfzEZgVLxWIM43n/jUVR+B1j28cGRqHpZvp/Gbtf9x
	3OCSoMqLFZ2nRNWLsx7iE6EyWtxc5GQk=
X-Gm-Gg: ASbGncsZoe4k1Qzk8jJDxAEPz+1kP7vTni6kmaq2VsM6SYFOPXxlV0aHrqn7NC4ofLM
	PhjiBqjgV7X4ya+Nej4r7rGAEen3yCcp1UYUycH9fMp9Qa+zczSYaIp9+1O/13lDwrcwV3AuKze
	+PDOvigmurqvKVjNjfal0DcP1FnL9x4Ypkbr3RrL86skkc104wapX4nO4KSkWxez6y9VrkwlHHO
	t53e8E1Q4tgmwJJ2Dy1/qEX5SP5E8g+KFB27XnEHr6E1O8u4gCoJeb0LG97E1E=
X-Google-Smtp-Source: AGHT+IE0hT62qP07k2vNOOD2/mRHqWSlYdd2BmE1WyLhoqtosjqz1nzBNV//FHz2CBfs6S5IJY7LDklpVJVSsGWMXRA=
X-Received: by 2002:a05:6e02:1fcc:b0:433:2e0d:42bd with SMTP id
 e9e14a558f8ab-43367ddcf71mr691575ab.1.1762532471624; Fri, 07 Nov 2025
 08:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-4-edumazet@google.com>
 <CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com>
 <CANn89i+fN=Qda_J52dEZGtXbD-hwtVdTQmQGhNW_m_Ys-JFJSA@mail.gmail.com>
 <CAL+tcoBGSvdoHUO6JD2ggxx3zUY=Mgms+wKSp3GkLN-pLO3=RA@mail.gmail.com>
 <CANn89iJcWc+Qi7xVcsnLOA1q9qjtqZLL5W4YQg=SND3tX=sLgw@mail.gmail.com>
 <CAL+tcoCmpzJ_z4DCvcoWok2LrR9vL2An8j3zi5XHOjiSity3jg@mail.gmail.com> <CANn89i+4OKrAq6DPZ_=MeDhGmEXDn6k-dRrEyzO8pmy=hN6VwA@mail.gmail.com>
In-Reply-To: <CANn89i+4OKrAq6DPZ_=MeDhGmEXDn6k-dRrEyzO8pmy=hN6VwA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Nov 2025 00:20:34 +0800
X-Gm-Features: AWmQ_bnGxeK6RWoHSmI4qltraVyn43xAst7uWvCvUihcd8I_h82pN24dQ9W0wWg
Message-ID: <CAL+tcoBkzggvE=3Y4jeeY9BnnBkNTFXjxN1H1ceKkDGg1ktzAQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 12:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Nov 7, 2025 at 8:04=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Sat, Nov 8, 2025 at 12:00=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Fri, Nov 7, 2025 at 7:50=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > >
> > > > On Fri, Nov 7, 2025 at 11:47=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Fri, Nov 7, 2025 at 7:37=E2=80=AFAM Jason Xing <kerneljasonxin=
g@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 7, 2025 at 4:30=E2=80=AFAM Eric Dumazet <edumazet@g=
oogle.com> wrote:
> > > > > > >
> > > > > > > skb_defer_max value is very conservative, and can be increase=
d
> > > > > > > to avoid too many calls to kick_defer_list_purge().
> > > > > > >
> > > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > >
> > > > > > I was thinking if we ought to enlarge NAPI_SKB_CACHE_SIZE() to =
128 as
> > > > > > well since the freeing skb happens in the softirq context, whic=
h I
> > > > > > came up with when I was doing the optimization for af_xdp. That=
 is
> > > > > > also used to defer freeing skb to obtain some improvement in
> > > > > > performance. I'd like to know your opinion on this, thanks in a=
dvance!
> > > > >
> > > > > Makes sense. I even had a patch like this in my queue ;)
> > > >
> > > > Great to hear that. Look forward to seeing it soon :)
> > >
> > > Oh please go ahead !
> >
> > Okay, thanks for letting me post this minor change. I just thought you
> > wanted to do this on your own :P
> >
> > Will do it soon :)
>
> Note that I was thinking to free only 32 skbs if we fill up the array
> completely.
>
> Current code frees half of it, this seems better trying to keep 96
> skbs and free 32 of them.
>
> Same for the bulk alloc, we could probably go to 32 (instead of 16)

Thanks for your suggestion!

However, sorry, I didn't get it totally. I'm wondering what the
difference between freeing only 32 and freeing half of the new value
is? My thought was freeing the half, say, 128/2, which minimizes more
times of performing skb free functions. Could you shed some light on
those numbers?

Thanks,
Jason

