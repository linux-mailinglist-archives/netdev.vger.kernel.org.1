Return-Path: <netdev+bounces-147632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182F19DAD67
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 19:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803C1B21348
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6F20111A;
	Wed, 27 Nov 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZO/UdHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837620110E
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733538; cv=none; b=q1WGD1RNo7K+4gyi4n6ySlJ2hgomHrJuc9YT/g+33JRHzVxt5XHvoPjPEN8PN62CMzLGdvK0HgeLSkpthDY7KuDhFyuIz8t76NfmwUFS+3CcIY0J71d3k5x6ULiaR4Yru4Lm5YebbbC691j9YreGYNCA1eq8pPa6SnsBewX5klY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733538; c=relaxed/simple;
	bh=tS3+m5GUD/wuQVxGJwaHYpX12WxR9ByyddQqAxB8iXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3olVFVIgYS2tjgmzUI2+wAtOVRtIhqekVb2CLebPGXly0WmlKx/1IivPHUJBmDmL8sfERKQGYnJjag09wh/GgJOB4XVKwfiPZ2obMpVxV2Bx9DnERVYlOzS+PldsxBKSLubTbWyQuhWCvuYqVu26Ugf68DWlCQtqzMNxjawpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZO/UdHE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso720141666b.2
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 10:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732733535; x=1733338335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoXsuOT6Weamem/Dtoqf13zt3xkAgm8Du7FLVT6rUq0=;
        b=pZO/UdHE/WZhtTk8KIH4kbhzIZDn8qzuqp7L5++KdwbHGrO//fTL0+vbIyEdJKykQ4
         RnlN6092eyLW/alwjSizJZbt+QDwouXzaqbrDZ1mDzCD9fUYd5FqI0kgxq/Ex6Ibde/K
         TOx7aCbDngM0oajlE6GQ9u0tTECFYIv0zLS5mFG2Kk7lO3OYyUPxlWIYMBMCTmuQYQgN
         dD8RZ1XZAyJB8GJYmmexY/Fatyoa5l2VBrx7fflvVAIXZeO7sO79p/Heb1xtYGf4TyvT
         fI8XIsbh+G98DVPcTHOwzLh+xwxGJz1adBdQlIHx7qKd8wTNlkJP2sihrav39VwTTIRS
         1cUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732733535; x=1733338335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoXsuOT6Weamem/Dtoqf13zt3xkAgm8Du7FLVT6rUq0=;
        b=waqkU7qVY/M+rBzkZk86c8WHUoyUoP5rSUZ4xTYEdS+Ry0V+8U8CQe0a0hsa16uSdd
         4wpQnbLmP0qZ4QTw88lCa4AqJGRJHV0dWDKq4BFTxgw7IOiACGAGgVz96l62rvcNuAHe
         ZwGOwD0qpsRXRo6AtOEYSmDYSXC5yKiMDWWfBI1eERC5vAwRqUtR2TJ8+O6B21fihRkg
         xcpNgSmC1C+4N/HbuzmBqniGfDMD8gPpVCaMb6uU6FcLoGjZLddbBV6BSTb9tCSakL8A
         LFLUjPKD6StHfcmakUGcGLnN58/PxCEwQMw8joUx4IpYtT8qzq/WVsAwbraT6cDjM9eS
         d/rg==
X-Forwarded-Encrypted: i=1; AJvYcCW21uCHN3PmBj0oOWOXAjMLnQCgAQbd62TsOUsp/htViAdiHFunZvJuXgrh23AgxTYRqMYagnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKp9svESjuDnQsHYI0hfGeD3ZvW4+pHm5AAKIfAmkfTJb0+6E
	wXqUjThbco6Od3/ffitn00BmiPcuKgyENFaP27+SXnrlPQv/FTn8WTaR+Id7YKwlEn5/Yvsby4x
	1+Efp9XQ73Xj4RDH3saxRT5ERoh9Z1uRwlL/G
X-Gm-Gg: ASbGnctiK4s46tofSTUowyqh8EP104A294OyvjBmqlZ2GZN8IQ8hVn9tsXqpZOHuTRK
	uAWI322U15aHvlhH33t7yxN1yAhCwAWGit6Tr4d/y5LZgkCg15dFeJikBhWj4bX/xUg==
X-Google-Smtp-Source: AGHT+IFJuWgJIkexVXLds3NvQZ7lr/z/atKIkNUPhMJ2y69QxSJkGyqHqKEepWm2ZkANFncV5SqfUnHRQ7rCpxCVoaU=
X-Received: by 2002:a17:906:2191:b0:aa5:c28:6eb6 with SMTP id
 a640c23a62f3a-aa580f52fa1mr413400466b.27.1732733534476; Wed, 27 Nov 2024
 10:52:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127040850.1513135-1-dongchenchen2@huawei.com> <40d6550a-3246-490a-87ac-1f8e3eba3d98@kernel.org>
In-Reply-To: <40d6550a-3246-490a-87ac-1f8e3eba3d98@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 Nov 2024 19:52:02 +0100
Message-ID: <CANn89iLfQVBFp1h17qqiCM7qBAP8cd9APSA+RdR2GEp954wZiA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: Fix icmp host relookup triggering ip_rt_bug
To: David Ahern <dsahern@kernel.org>
Cc: Dong Chenchen <dongchenchen2@huawei.com>, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, herbert@gondor.apana.org.au, steffen.klassert@secunet.com, 
	netdev@vger.kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 4:50=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 11/26/24 9:08 PM, Dong Chenchen wrote:
> > arp link failure may trigger ip_rt_bug while xfrm enabled, call trace i=
s:
> >
> > WARNING: CPU: 0 PID: 0 at net/ipv4/route.c:1241 ip_rt_bug+0x14/0x20
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00077-g2e1b=
3cc9d7f7
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:ip_rt_bug+0x14/0x20
> > Call Trace:
> >  <IRQ>
> >  ip_send_skb+0x14/0x40
> >  __icmp_send+0x42d/0x6a0
> >  ipv4_link_failure+0xe2/0x1d0
> >  arp_error_report+0x3c/0x50
> >  neigh_invalidate+0x8d/0x100
> >  neigh_timer_handler+0x2e1/0x330
> >  call_timer_fn+0x21/0x120
> >  __run_timer_base.part.0+0x1c9/0x270
> >  run_timer_softirq+0x4c/0x80
> >  handle_softirqs+0xac/0x280
> >  irq_exit_rcu+0x62/0x80
> >  sysvec_apic_timer_interrupt+0x77/0x90
> >
> > The script below reproduces this scenario:
> > ip xfrm policy add src 0.0.0.0/0 dst 0.0.0.0/0 \
> >       dir out priority 0 ptype main flag localok icmp
> > ip l a veth1 type veth
> > ip a a 192.168.141.111/24 dev veth0
> > ip l s veth0 up
> > ping 192.168.141.155 -c 1
> >
> > icmp_route_lookup() create input routes for locally generated packets
> > while xfrm relookup ICMP traffic.Then it will set input route
> > (dst->out =3D ip_rt_bug) to skb for DESTUNREACH.
> >
> > For ICMP err triggered by locally generated packets, dst->dev of output
> > route is loopback. Generally, xfrm relookup verification is not require=
d
> > on loopback interfaces (net.ipv4.conf.lo.disable_xfrm =3D 1).
> >
> > Skip icmp relookup for locally generated packets to fix it.
> >
> > Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
> > Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> > ---
> > v3: avoid the expensive call to  inet_addr_type_dev_table()
> > and addr_type variable suggested by Eric
> > v2: Skip icmp relookup to fix bug
> > ---
> >  net/ipv4/icmp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index 4f088fa1c2f2..963a89ae9c26 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -517,6 +517,9 @@ static struct rtable *icmp_route_lookup(struct net =
*net, struct flowi4 *fl4,
> >       if (!IS_ERR(dst)) {
> >               if (rt !=3D rt2)
> >                       return rt;
> > +             if (inet_addr_type_dev_table(net, route_lookup_dev,
> > +                                          fl4->daddr) =3D=3D RTN_LOCAL=
)
> > +                     return rt;
> >       } else if (PTR_ERR(dst) =3D=3D -EPERM) {
> >               rt =3D NULL;
> >       } else {
>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

