Return-Path: <netdev+bounces-154628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C0C9FEEFA
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 11:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626F416237C
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3001946A2;
	Tue, 31 Dec 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCkjp2/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3818BC0F;
	Tue, 31 Dec 2024 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735642614; cv=none; b=NUcPQOk/kqJcEBVdZyvyvUapOu4k+BHMZbGnZCdB5Iq01MaxM1EEvF6Viz8qSrO7dAvcv7mUyTtVp+9t382BNMV8+1OafWywSMaehlYnlBlshk8MiuQHBDz3ZSU382FHigJKYoFUYIdlIkYsq47mP7MPUXk83bq0HLNdx1l2erQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735642614; c=relaxed/simple;
	bh=6IhOFFBGVlGon7xFcUmHUtcry4bDwU0DjD7sRV8cVeY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IDgoqYyhE7nkKrwTx/ksyPnjydJAJ76CJmIbfXPO+Jns32BmZAJSAt1xv2T2GuViq6mcgxnKjwxYCCM9s6rqpoX2ceG9Qzw21dZmXfbPn+BW002mOFSM87tcSptddszBNEQQGsopCTM+eXK1zPZkr2kYt4/oRnNsW/WXl6Kvb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCkjp2/v; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd15d03eacso90061086d6.0;
        Tue, 31 Dec 2024 02:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735642611; x=1736247411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVf9BtSaYL/ucUiPbEF/cspxkDHYtLRGbWK/7ik53dg=;
        b=iCkjp2/vMhQsyT3Thp53DR1HExahzmSBxVCx3s41pYZq6ttQGjVkmeHNyIHUIOPgn3
         0U81gfL6S7GMKkxo4KP6P9Wov8Fp081mWHxJJGjl+rxLa4CnNr7m5jmumtDcmZ+Dm0FK
         BuEQasaUrkSGF5b0qyNuXJx10kPDsuBv/3V6oouvtnyhAZFzoKNAS/4rCh5gPO99PW1m
         EIC6E/BoWPOKKxCxY9jwIiJy5CHsa5OlNRVWdUMUHMw0xs3dEkkg5Rpqi14TjlR9eysk
         joo40vz/2IHAPeKG+kfxihVVEaIhhHC1Zng8Po/i2/Vxdl8OaWcTPShCjPCMfaN1Pr6a
         3SMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735642611; x=1736247411;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eVf9BtSaYL/ucUiPbEF/cspxkDHYtLRGbWK/7ik53dg=;
        b=m3wk8NO3HtDAIWQUMkct+vUMgZnYwZERVMHvBX/ahANtNQqyd+dwWwxj7tg+YylIq5
         OjaWhbastKFpqOwqs7/xBJ8EunX2vT1RWRJMAL57kgbLOxPj23rhqar9UG4BYoCqPEAD
         ta64taVfa+S/BAGquFlpWx/vz5AVgD8UvI1UB3m3KCDGNWVzEV6eJvk0kOXjCRmcwT1Q
         BWxjooPWSVZdVkMQj1bx+pBqDBy0zOwploHt3ISFsbFxd07nSDTVvO+viUfdLNIROgN3
         Wk+YahcZVpQG7V8eEvm+o+eKIbtPT81qXexDr5o6ju4xWJgRr4BAbKv8csOg7sm06f4I
         ncYA==
X-Forwarded-Encrypted: i=1; AJvYcCU1GrT7MgFoQlV1bcfKlt1btlscNU/j14BwB0oaedQvqLJ2CyUK9gDdJbiJH9bzhw0wx6NHW9TD@vger.kernel.org, AJvYcCUDnv2HWoX7kh2rTyHl8yyTPK7qNCciRuhR+WdpIOOPM0/c870AiQDxGLyP04V2O3mSiMZIYKNie50m5h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcgD1UJIQfXT4ayIQXCaj1M2LC1jhHc46UfnicS49DTxcmp2w
	Lx3Jtk9RTgrCmx3XbLDPyEiQ+f0e/vLOjZKtXqushx83YYHxxNbS
X-Gm-Gg: ASbGncseJmLieZyVCCfQcrmDgP6r5HXQANMR61RPpVm2WamdwPU1LizY9vQY4tD5Eem
	ksA+LyBx2Lczq5ey61m/ViMXI9biJOpvWAFMWrYeVb0ayW7zvahSYkwKAUBHmn2dhzFj1gU9gJf
	qu5KoeIp5FUdpSwCG5GdkNVqHDPdD4Wqc/pWoXlppB70z1kWiugxPv/On0CXLhDS9aBN/tud0Mg
	Z+niryLcYejgAYsLtflg0hZ1rO6AI9u3CBEuPQ9ube6rqQ2/P7CGwuC2WCp7h3oHuhU63dMU8IT
	PLtQLjUPHvBsvCvNtSoxxxbqVreM0qyNug==
X-Google-Smtp-Source: AGHT+IFzmfVvlz56sdEQxjptOgpGuRk6qpG8s4MK0r22Cnh9LPdGmkP2V0xeiEAI234ok3HBHGgFpw==
X-Received: by 2002:a05:6214:2586:b0:6d8:8283:4466 with SMTP id 6a1803df08f44-6dd155d058fmr670574456d6.18.1735642611609;
        Tue, 31 Dec 2024 02:56:51 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d5638sm110263246d6.117.2024.12.31.02.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 02:56:50 -0800 (PST)
Date: Tue, 31 Dec 2024 05:56:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 =?UTF-8?B?QmVub8OudCBNb25pbg==?= <benoit.monin@gmx.fr>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6773cdf25a15a_534e22946f@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iK1hdC3Nt8KPhOtTF8vCPc1AHDCtse_BTNki1pWxAByTQ@mail.gmail.com>
References: <5fbeecfc311ea182aa1d1c771725ab8b4cac515e.1729778144.git.benoit.monin@gmx.fr>
 <CANn89iK1hdC3Nt8KPhOtTF8vCPc1AHDCtse_BTNki1pWxAByTQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: skip offload for NETIF_F_IPV6_CSUM if ipv6
 header contains extension
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Thu, Oct 24, 2024 at 4:01=E2=80=AFPM Beno=C3=AEt Monin <benoit.monin=
@gmx.fr> wrote:
> >
> > As documented in skbuff.h, devices with NETIF_F_IPV6_CSUM capability
> > can only checksum TCP and UDP over IPv6 if the IP header does not
> > contains extension.
> >
> > This is enforced for UDP packets emitted from user-space to an IPv6
> > address as they go through ip6_make_skb(), which calls
> > __ip6_append_data() where a check is done on the header size before
> > setting CHECKSUM_PARTIAL.
> >
> > But the introduction of UDP encapsulation with fou6 added a code-path=

> > where it is possible to get an skb with a partial UDP checksum and an=

> > IPv6 header with extension:
> > * fou6 adds a UDP header with a partial checksum if the inner packet
> > does not contains a valid checksum.
> > * ip6_tunnel adds an IPv6 header with a destination option extension
> > header if encap_limit is non-zero (the default value is 4).
> >
> > The thread linked below describes in more details how to reproduce th=
e
> > problem with GRE-in-UDP tunnel.
> >
> > Add a check on the network header size in skb_csum_hwoffload_help() t=
o
> > make sure no IPv6 packet with extension header is handed to a network=

> > device with NETIF_F_IPV6_CSUM capability.
> >
> > Link: https://lore.kernel.org/netdev/26548921.1r3eYUQgxm@benoit.monin=
/T/#u
> > Fixes: aa3463d65e7b ("fou: Add encap ops for IPv6 tunnels")
> > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
> > ---
> > changelog
> > * v2:
> >     - patch against net instead of net-next
> >     - clarify documentation of NETIF_F_IPV6_CSUM
> >     - add link to thread describing the problem
> >     - add fixes tag
> >     - use vlan_get_protocol to check for IPv6
> > * v1:
> >     - https://lore.kernel.org/netdev/0dc0c2af98e96b1df20bd36aeaed4eb4=
e27d507e.1728056028.git.benoit.monin@gmx.fr/T/#u
> > ---
> >  net/core/dev.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index ea5fbcd133ae..8453e14d301b 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_buff *skb=
,
> >                 return 0;
> >
> >         if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> > +               if (vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6) &=
&
> > +                   skb_network_header_len(skb) !=3D sizeof(struct ip=
v6hdr))
> > +                       goto sw_checksum;
> >                 switch (skb->csum_offset) {
> >                 case offsetof(struct tcphdr, check):
> >                 case offsetof(struct udphdr, check):
> > @@ -3646,6 +3649,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb=
,
> >                 }
> >         }
> >
> > +sw_checksum:
> >         return skb_checksum_help(skb);
> >  }
> >  EXPORT_SYMBOL(skb_csum_hwoffload_help);
> =

> =

> FYI, this patch broke BIG TCP over IPv6.
> =

> [  239.698598] Oops skb_network_header_len()=3D48 skb->len=3D67210
> [  239.704122] skb len=3D67210 headroom=3D162 headlen=3D94 tailroom=3D0=

>                mac=3D(162,14) mac_len=3D0 net=3D(176,48) trans=3D224
>                shinfo(txflags=3D0 nr_frags=3D3 gso(size=3D1428 type=3D1=
6 segs=3D47))
>                csum(0x1000e0 start=3D224 offset=3D16 ip_summed=3D3
> complete_sw=3D0 valid=3D0 level=3D0)
>                hash(0xadf29e31 sw=3D0 l4=3D1) proto=3D0x86dd pkttype=3D=
0 iif=3D0
>                priority=3D0x18020 mark=3D0x0 alloc_cpu=3D46 vlan_all=3D=
0x0
>                encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0=
,

I'm looking into the following fix

+++ b/net/core/dev.c
@@ -3642,7 +3642,8 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 =

        if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
                if (vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6) &&
-                   skb_network_header_len(skb) !=3D sizeof(struct ipv6hd=
r))
+                   skb_network_header_len(skb) !=3D sizeof(struct ipv6hd=
r) &&
+                   !ipv6_has_hopopt_jumbo(skb))
                        goto sw_checksum;

