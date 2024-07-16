Return-Path: <netdev+bounces-111684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846E9320CD
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931451C21A40
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 06:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8EE20DCB;
	Tue, 16 Jul 2024 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPJa2SUv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E11CD32
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113055; cv=none; b=iuFCt9WjYs8IUUkveJEyJsuidcfHHhmwkgzRj9o+ge4Nwyy4wLlzi3Cafnpa1L5ea15rLhSNvkueq7RxMajzroBVbrpgXZIA+H7Kdj3/U4T/GfJoWALrfH6165XYcCWLzsnIvhPNbYnU4G6oTYvqJc/owNq6JdtNgWpBAzGnYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113055; c=relaxed/simple;
	bh=JB9Pv2h1psRdzQ/YW4887hnS91Q24NPBG1tUu6X+V4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQrHohLKjKQ4TFWt5JwyJ+46AK6xd23cM7X1sIFSvdV3RH1ifDlF7vy4pBF87P9k2OvK0HlMebIQhIuocjCPNAXZ6oJjYJA8gJ6JD6DSMgDHGc/QK3D0KvGkaW6QvTzThpgrjyXVpY/9Z5q6FnDCqdc3+jE0zVQOQ6AOV8+3n5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPJa2SUv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so11283a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721113050; x=1721717850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB9Pv2h1psRdzQ/YW4887hnS91Q24NPBG1tUu6X+V4Q=;
        b=XPJa2SUve+0A1PUBIgmdIl+Et/lIDvnR+i4MeBU+RAY+1nCLSRWsmh2FL6DkfTrU/M
         +xk0a/JT8QfEAhTJa8Xtp8f5ZiDqvr1si315Ns08n0S2RfhG7JjYK/EQ9djiFMTTJbPi
         0wMfE+DZ0LsZaawVGUbpA+XhcQxvMMNXWD3veQVFPId0tDP5NJ365xDvmHrAtAa/gMLA
         pGrQg678/rYMdFTBLEixTN+Mp0Uoilew4wYXAyrFwo6UVVIneneUYpQwBNbMJcjKSOS3
         pKVxx5C3KozlDgANevUL5tEqXZ0/ilEVbcLL3p5H3mTxF+/WvHWL5qkX5MVPWwRJy6av
         NPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721113050; x=1721717850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB9Pv2h1psRdzQ/YW4887hnS91Q24NPBG1tUu6X+V4Q=;
        b=pKKYqJlW6A8INLALoe6FKy6or4W+T2Z4/ogSL5DzIPNyyWxy0E4MEbnI39VzFKpYRV
         4ID+QGs58CkFk3kOV/HXro6OGL8ZSKm5TZpn3TYYD7kUYN+tuVY2wrwRPk/1JW8/Lc+d
         dBJ/ZTOkZZJmlrY48ZADHZOwJZKkDt+L0Iz1iy7oxx2M/SUb0fDe/N3OuJIaCvjvl9Dd
         +izi4m48iT+hKw7UyNLgmFSmsr7Vb9bPZHChnf2fwyAC+KAVVFGE74+LK5WJgk+eAd8d
         6DDB+Z1uqKeeYMPoyKYCIqODj7rrZFYYy9tHSZTgUVq+Z8SX3kq8bphYemBNhFnr12ou
         qOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPxnFk0s7FVaIaJN+/rVZu14wB7KBVKbZl8PnSptoPAsRg0nBBN/TTUXbGGHOm7A2yPccxI6GLFxh1hpZL3HqVMPlCVblf
X-Gm-Message-State: AOJu0YzCtT8DX/V2zaPmrJBBTL5wWFHV+SUrT07Z0ZAjjGRCElvIn21W
	IZdwS+9CTEJ3pUSPXngoJlxrPBg2BkwzORNdvvm23N04ecGzh0aLuWRpLCPzS25ePWJCiL5KHJN
	sjbyWJXSek6Vg2bvvZcgPoBT186hg24btCxWx
X-Google-Smtp-Source: AGHT+IF24QVyffBOqoZd93yJUI88r1sq9n2dD0oy22z8EHISv8yLzDwTl7WmIzMu1W4WD9gPpjuqvi7GL8RoNLv9Vjc=
X-Received: by 2002:a05:6402:4304:b0:58b:e3b:c5d8 with SMTP id
 4fb4d7f45d1cf-59ec2942b3dmr189268a12.0.1721113050118; Mon, 15 Jul 2024
 23:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715033118.32322-1-kerneljasonxing@gmail.com>
 <CANn89iLXgGT2NL5kg7LQrzCFT_n7GJzb9FExdOD3fRNFEc1z0A@mail.gmail.com> <CAL+tcoA38fXgnJtdDz8NBm=F0-=oGp=oEySnWEhNB16dqzG9eQ@mail.gmail.com>
In-Reply-To: <CAL+tcoA38fXgnJtdDz8NBm=F0-=oGp=oEySnWEhNB16dqzG9eQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jul 2024 23:57:15 -0700
Message-ID: <CANn89iK7hDCGQsGiX5rD6S29u1u8k5za-SOBaxY59S=C+BgaKA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce rto_max_us sysctl knob
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, corbet@lwn.net, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 11:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> Hello Eric,
>
> On Mon, Jul 15, 2024 at 10:40=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Sun, Jul 14, 2024 at 8:31=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > As we all know, the algorithm of rto is exponential backoff as RFC
> > > defined long time ago.
> >
> > This is weak sentence. Please provide RFC numbers instead.
>
> RFC 6298. I will update it.
>
> >
> > > After several rounds of repeatedly transmitting
> > > a lost skb, the expiry of rto timer could reach above 1 second within
> > > the upper bound (120s).
> >
> > This is confusing. What do you mean exactly ?
>
> I will rewrite this part. What I was trying to say is that waiting
> more than 1 second is not very friendly to some applications,
> especially the expiry time can reach 120 seconds which is too long.

Says who ? I think this needs IETF approval.

>
> >
> > >
> > > Waiting more than one second to retransmit for some latency-sensitive
> > > application is a little bit unacceptable nowadays, so I decided to
> > > introduce a sysctl knob to allow users to tune it. Still, the maximum
> > > value is 120 seconds.
> >
> > I do not think this sysctl needs usec resolution.
>
> Are you suggesting using jiffies is enough? But I have two reasons:
> 1) Keep the consistency with rto_min_us
> 2) If rto_min_us can be set to a very small value, why not rto_max?

rto_max is usually 3 order of magnitude higher than rto_min

For HZ=3D100, using jiffies for rto_min would not allow rto_min < 10 ms.
Some of us use 5 msec rto_min.

jiffies is plain enough for rto_max.


>
> What do you think?

I think you missed many many details really.

Look at all TCP_RTO_MAX instances in net/ipv4/tcp_timer.c and ask
yourself how many things
will break if we allow a sysctl value with 1 second for rto_max.

>
> >
> > Also storing this sysctl once, and converting it millions of times per
> > second to jiffies is not good.
> > I suggest you use proc_dointvec_jiffies() instead in the sysctl handler=
.
> >
> > Minimal value of one jiffies makes also no sense. We can not predict
> > if some distros/users
> > might (ab)use this sysctl.
>
> Okay. If the final solution is using jiffies, I will accordingly adjust i=
t.
>
> >
> > You forgot to update
> > Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
>
> Oh sorry, I forgot.
>
> > This means the location you chose for the new sysctl is pretty much
> > random and not reflcting
> > this is used in one fast path.
>
> I will investigate its proper location...
>
> >
> > I suggest you wait for net-next being reopened, we are all busy
> > attending netdev 0x18 conference.
>
> Roger that. Thanks for your suggestions.
>
> Thanks,
> Jason

