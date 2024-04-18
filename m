Return-Path: <netdev+bounces-89093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E948A96DA
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027E61C21F79
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A73015B15F;
	Thu, 18 Apr 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGYPGkGW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F215B157
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434315; cv=none; b=Uryw4w8YI1JZrGG+R7RCuJ+BdmKVO3ISEZLyb3lh0U46OEYms+Ins3zmxVGawrk5iKv1/JeM2OY/3Zu5FRWPcbBBX1S4fHDUbUwnuURabRYD4h71zo/bKXA5EidaONFHpowmk+pWBQBO+z1JTLU+tvJaMWUWdU5rX0gsj3pjU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434315; c=relaxed/simple;
	bh=7VoUoXHNNQl8FiEiNtnZJrVsPSETNT4fnLQoDM25RwI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dh127aVnRCuyZQeI3dSNhAyZIsEE9ulTExvwJXZO1paH50ln2fZ6mkr21DAyUudWO83ZAuwoWbysGAg7SUzXnaV9b2XHjFMYnsy6rZenHk5Rj2HNntclvXULM1SCcV4gVIGMqRtHkZQDltgV3x6y1sDa1269yAHlNCE4DFUf0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGYPGkGW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713434312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TLoWIMIf7TVj1eFcoz4K8BVjpAzxaCleUKL1MxyV07Y=;
	b=bGYPGkGWWYclNeWI8Uu0kN4+4iywdKP64O67NFY/2DKFFCEDDfX27/TzP4tpQyTwpryeny
	DqonUbu1V97+gLCDWmNzvyfntd3YDthMn8iKnHanozVvHMI2glx4kCW2vu3RWyYRTjGhJ1
	Vs11izaiusFz1p0JpT3gHSa4z/04bB0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-hutvNuNZOYykX1YHbTRTCw-1; Thu, 18 Apr 2024 05:58:30 -0400
X-MC-Unique: hutvNuNZOYykX1YHbTRTCw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3457b0dca26so63022f8f.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713434309; x=1714039109;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLoWIMIf7TVj1eFcoz4K8BVjpAzxaCleUKL1MxyV07Y=;
        b=ZN0uvDFzwAZ/t8WDU7GSFm3LWv69ip0xn6pgoZRKIhFtXea1UH33oDIMlabDBhnpsd
         EnXg3ROeYb7wvJzOy2jWQFM9Aw1SsD1Ms776otwErXsTEthKSeKh8+OWaVVguEF4ybtU
         SAk3pemfN93iHIgkadjcgNWYQsbRLnJHsFdiz+jHvUNwzOYIrlekwt8DhdB5txDcPsKa
         OVcG7ZnWRXotTtjhNBijUSG2B5k0bFlVCAekH0HItZF0RuBdtVWeH0a56D6lYB0EVHia
         JgYj1Zn/pcMeLNrPK/Q679aJAwzmW5ZoHRISgYpYR9KIetD5Xrx3ZRb6TxZCWHU/EIaF
         zjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxa2G6zU2vW+Jgj2rYCkNPiHqftoXNhYvNDgRVjg736TSPQ4tg+GhwOlvvCPKp/OiyJeBzJ9ZpeSXDrxDfZlOSbqe3Pare
X-Gm-Message-State: AOJu0YzNONHdjYc8FSudKHJmRZj9XYKyAxBhZELf94RWHuYnIYKCA5YT
	iUEs3CPvOxRCWh3WfZVMULYIX9/1RbdInmFqOgI+Io5vnqvHXFvmOW+gh1JI2AGXOvvbbwSuDWG
	KGT5Ub4NEYuWrR+lLJE6NhM+EcGu7CftqaqXMWwyf34Ps31wFP0afXA==
X-Received: by 2002:a05:600c:3baa:b0:418:1303:c3d1 with SMTP id n42-20020a05600c3baa00b004181303c3d1mr1684504wms.3.1713434309388;
        Thu, 18 Apr 2024 02:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt8DqBDh9uzLXvBfQ7CQL8B4vHsmNa2qKDnYFsz4qD+WWGDyqJCZ2pKeQDoPeUCBRh5uegKg==
X-Received: by 2002:a05:600c:3baa:b0:418:1303:c3d1 with SMTP id n42-20020a05600c3baa00b004181303c3d1mr1684481wms.3.1713434308998;
        Thu, 18 Apr 2024 02:58:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-143.dyn.eolo.it. [146.241.236.143])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c3b8600b0041892e839bcsm2130625wms.33.2024.04.18.02.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 02:58:28 -0700 (PDT)
Message-ID: <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error()
 from tcp_v4_err()
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  netdev@vger.kernel.org, Neal Cardwell
 <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 eric.dumazet@gmail.com, Maciej =?UTF-8?Q?=C5=BBenczykowski?=
 <maze@google.com>, Willem de Bruijn <willemb@google.com>, Shachar Kagan
 <skagan@nvidia.com>
Date: Thu, 18 Apr 2024 11:58:27 +0200
In-Reply-To: <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
References: <20240417165756.2531620-1-edumazet@google.com>
	 <20240417165756.2531620-2-edumazet@google.com>
	 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
	 <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
	 <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-18 at 11:26 +0200, Eric Dumazet wrote:
> On Thu, Apr 18, 2024 at 10:03=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >=20
> > On Thu, Apr 18, 2024 at 10:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > >=20
> > > Hi,
> > >=20
> > > On Wed, 2024-04-17 at 16:57 +0000, Eric Dumazet wrote:
> > > > Blamed commit claimed in its changelog that the new functionality
> > > > was guarded by IP_RECVERR/IPV6_RECVERR :
> > > >=20
> > > >     Note that applications need to set IP_RECVERR/IPV6_RECVERR opti=
on to
> > > >     enable this feature, and that the error message is only queued
> > > >     while in SYN_SNT state.
> > > >=20
> > > > This was true only for IPv6, because ipv6_icmp_error() has
> > > > the following check:
> > > >=20
> > > > if (!inet6_test_bit(RECVERR6, sk))
> > > >     return;
> > > >=20
> > > > Other callers check IP_RECVERR by themselves, it is unclear
> > > > if we could factorize these checks in ip_icmp_error()
> > > >=20
> > > > For stable backports, I chose to add the missing check in tcp_v4_er=
r()
> > > >=20
> > > > We think this missing check was the root cause for commit
> > > > 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
> > > > some ICMP") breakage, leading to a revert.
> > > >=20
> > > > Many thanks to Dragos Tatulea for conducting the investigations.
> > > >=20
> > > > As Jakub said :
> > > >=20
> > > >     The suspicion is that SSH sees the ICMP report on the socket er=
ror queue
> > > >     and tries to connect() again, but due to the patch the socket i=
sn't
> > > >     disconnected, so it gets EALREADY, and throws its hands up...
> > > >=20
> > > >     The error bubbles up to Vagrant which also becomes unhappy.
> > > >=20
> > > >     Can we skip the call to ip_icmp_error() for non-fatal ICMP erro=
rs?
> > > >=20
> > > > Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv users"=
)
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > Cc: Dragos Tatulea <dtatulea@nvidia.com>
> > > > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > > > Cc: Willem de Bruijn <willemb@google.com>
> > > > Cc: Neal Cardwell <ncardwell@google.com>
> > > > Cc: Shachar Kagan <skagan@nvidia.com>
> > > > ---
> > > >  net/ipv4/tcp_ipv4.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > > index 88c83ac4212957f19efad0f967952d2502bdbc7f..a717db99972d977a641=
78d7ed1109325d64a6d51 100644
> > > > --- a/net/ipv4/tcp_ipv4.c
> > > > +++ b/net/ipv4/tcp_ipv4.c
> > > > @@ -602,7 +602,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
> > > >               if (fastopen && !fastopen->sk)
> > > >                       break;
> > > >=20
> > > > -             ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th)=
;
> > > > +             if (inet_test_bit(RECVERR, sk))
> > > > +                     ip_icmp_error(sk, skb, err, th->dest, info, (=
u8 *)th);
> > > >=20
> > > >               if (!sock_owned_by_user(sk)) {
> > > >                       WRITE_ONCE(sk->sk_err, err);
> > >=20
> > > We have a fcnal-test.sh self-test failure:
> > >=20
> > > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2024-04-=
18--06-00&test=3Dfcnal-test-sh
> > >=20
> > > that I suspect are related to this patch (or the following one): the
> > > test case creates a TCP connection on loopback and this is the only
> > > patchseries touching the related code, included in the relevant patch
> > > burst.
> > >=20
> > > Could you please have a look?
> >=20
> > Sure, thanks Paolo !
>=20
> First patch is fine, I see no failure from fcnal-test.sh (as I would expe=
ct)
>=20
> For the second one, I am not familiar enough with this very slow test
> suite (all these "sleep 1" ... oh well)

@David, some of them could be replaced with loopy_wait calls

> I guess "failing tests" depended on TCP connect() to immediately abort
> on one ICMP message,
> depending on old kernel behavior.
>=20
> I do not know how to launch a subset of the tests, and trace these.
>=20
> "./fcnal-test.sh -t ipv4_tcp" alone takes more than 9 minutes [1] in a
> VM running a non debug kernel :/
>=20
> David, do you have an idea how to proceed ?

One very dumb thing I do in that cases is commenting out the other
tests, something alike (completely untested!):
---
diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/self=
tests/net/fcnal-test.sh
index 386ebd829df5..494932aa99b2 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -1186,6 +1186,7 @@ ipv4_tcp_novrf()
 {
 	local a
=20
+if false; then
 	#
 	# server tests
 	#
@@ -1271,6 +1272,7 @@ ipv4_tcp_novrf()
 		log_test_addr ${a} $? 1 "Device server, unbound client, local connection=
"
 	done
=20
+fi
 	a=3D${NSA_IP}
 	log_start
 	run_cmd nettest -s &
@@ -1487,12 +1489,14 @@ ipv4_tcp()
 	set_sysctl net.ipv4.tcp_l3mdev_accept=3D0
 	ipv4_tcp_novrf
 	log_subsection "tcp_l3mdev_accept enabled"
+if false; then
 	set_sysctl net.ipv4.tcp_l3mdev_accept=3D1
 	ipv4_tcp_novrf
=20
 	log_subsection "With VRF"
 	setup "yes"
 	ipv4_tcp_vrf
+fi
 }
=20
 ##########################################################################=
######


