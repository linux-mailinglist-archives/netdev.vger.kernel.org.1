Return-Path: <netdev+bounces-120303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E84958E1C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F053283B26
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1531494CC;
	Tue, 20 Aug 2024 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/RskYZw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50F1494B4
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178930; cv=none; b=Tz4/phbyj3wDA9tZ8Eq6GtGGO90N+ZvfBqcQ7kjyC4bypu71GE6bor/JRNmlEoKHG0+fnA5f5QTDEuo7eV82qUUPgG4ZWChqH1qyfGHJ607GGAXXpuq9ZqavnE9ta36GYer8J+X7QgYY8LMjjQXLKZy8JLmBBLggMoF4g81Ecug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178930; c=relaxed/simple;
	bh=fwthy7BB5dxa8SKc0UDPmEaOflsfU4V24LOpnyfDXi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehOVn9m/6B2tOM52fmL47/bLi36aIvGkw4zMH8tsfGqwIy2casHJ8lVLXbWoEJEVmEZx7WudxuICO9XPOuAaP9nCiAFTgOw7Hqccz7cIu66RZ1YzXQhtD1LW0juVKyNi5Nt11a0keeo9JpknoGsUY/ZCGZmQQ/PCgZ/X8u9/o5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/RskYZw; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so5109757a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724178927; x=1724783727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpWMUGRyI5v8Hfwzk7yfVoP9CspO38+rhnNZRg36wfg=;
        b=r/RskYZwjn/qEXJYRmlfgquSAaHf94Wxo15k3vxbnKY8+7DigzOvhaX/LJGfUNhJV1
         Vq87fkaFD7TSWzx0GoYSL4NzuIZxZSqABEMstcxi4NLvfYxAspvGUlliI2ln1+MIk+sQ
         971rjxDOU+b5/LmYuv70RZARs3bbh1ZGYjN2shShtRBZhgpJpcdwiBdSebNiiLzLwfMG
         JZWKPWJpYR8D6YdvAbIOer5Sbee2jmEMZokZT+MH03raoLGdM6ALMywFi+jjZSb1Kj9v
         SvXRmH8ZepOHe/Q4I3DoEmhuGBtopeOIRO6+R1P4gW8g7F3tXdWA3fm3DlDip7BvqxyY
         bdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724178927; x=1724783727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpWMUGRyI5v8Hfwzk7yfVoP9CspO38+rhnNZRg36wfg=;
        b=af8yU7KguRxnH/Ewm3tYrAAmxdsaGzD6ZYtyg9FeLIvaI38XNmmv0W1QUjom/fRCqB
         R2CvQYEgRWVm0XTJ07lZRkBsC5MYgYlgacoe9t1j67VRZaeQirr5gWLu7SsEoASJR0fC
         5OXI6Ht8TyiBdHlG2tvtU4NZp5+VGl1NE4VJgj+TKrPrjKe8eNm47k0+nzUFF1/LguyN
         /phx1tz8jHhfbR/qZTtkhp4kKpUGqP8e7YVNZoQGQbs4yKq+9oRVrEtOOlH4f48+t2EL
         k7DtKRsS67+lu9PgJKQHW24uZekaaYKQ+xGt/TiIGeKRZqqwZJot8OJWN+rKyQ6plrcm
         ufhw==
X-Forwarded-Encrypted: i=1; AJvYcCWRneW6qBEIdX7SgIG3RktMlqwwI2rSnFN9boq0ngcU43e74xkg1QYi3Cq2ehWZQd3zqQVtHDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+6JfptA+WTtUQJQSrHhmUjIZCYZd3LpX6xLs++tXzt55tPk9P
	O33djzb/ipqtJn6PFqlsEV9vWXWCfeHsz1UAzmdLz8zr23KyjaS5328hfdmkWhzZz98x+Qupq+f
	IYKtUUdCjsPCI/iC0dLUKimCsVXuRkGtQH1fG
X-Google-Smtp-Source: AGHT+IF4PovtuKb2ddr8G2aj1oC060aIyWBbKEhG/j49nl75wopJVXOlIG4Spz8Q1Z+GnPhUuz+ScR6ApF9fqgKjnqs=
X-Received: by 2002:a17:907:c897:b0:a7a:c256:3cb with SMTP id
 a640c23a62f3a-a83929544femr1067516666b.39.1724178926521; Tue, 20 Aug 2024
 11:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819124954.GA885813@pevik> <CANn89iJgK-_xgFSjpH4m0qmcgwEMaTse7D=XbG-2qi=Gnej+xA@mail.gmail.com>
 <20240820153840.GA977997@pevik>
In-Reply-To: <20240820153840.GA977997@pevik>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Aug 2024 20:35:13 +0200
Message-ID: <CANn89iK6Zr4bTaMOevGkNZ-KYHGFaE-8x5y95UgJ5+AwJgdwJg@mail.gmail.com>
Subject: Re: [RFC] Big TCP and ping support vs. max ICMP{,v6} packet size
To: Petr Vorel <pvorel@suse.cz>
Cc: Xin Long <lucien.xin@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 5:38=E2=80=AFPM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Eric,
>
> > On Mon, Aug 19, 2024 at 2:50=E2=80=AFPM Petr Vorel <pvorel@suse.cz> wro=
te:
>
> > > Hi Eric, Xin,
>
> > > I see you both worked on Big TCP support for IPv4/IPv6. I wonder if a=
nybody was
> > > thinking about add Big TCP to raw socket or ICMP datagram socket. I'm=
 not sure
> > > what would be a real use case (due MTU limitation is Big TCP mostly u=
sed on
> > > local networks anyway).
>
> > I think you are mistaken.
>
> > BIG TCP does not have any MTU restrictions and can be used on any netwo=
rk.
>
> > Think about BIG TCP being GSO/TSO/GRO with bigger logical packet sizes.
>
> First, thanks for a quick info. I need to study more BIG TCP. Because I w=
as
> wondering if this could be used for sending larger ICMP echo requests > 6=
5k
> as it's possible in FreeBSD, where it's done via Jumbograms [1]:
>
>         ping -6 -b 70000 -s 68000 ::1

I guess ip6_append_data() is a bit conservative and uses IPV6_MAXPLEN
while it should not ;)

Also ping needs to add the jumboheader if/when using RAW6 sockets

With the following patch, the following commands sends big packets just fin=
e

ifconfig lo mtu 90000
ping -s 68000 ::1

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ab504d31f0cdd8dec9ab01bf9d6e6517307609cd..6b1668e037dae3c88052c50f02f=
319355baf4304
100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1473,7 +1473,7 @@ static int __ip6_append_data(struct sock *sk,
        }

        if (ip6_sk_ignore_df(sk))
-               maxnonfragsize =3D sizeof(struct ipv6hdr) + IPV6_MAXPLEN;
+               maxnonfragsize =3D max_t(u32, mtu, sizeof(struct
ipv6hdr) + IPV6_MAXPLEN);
        else
                maxnonfragsize =3D mtu;

