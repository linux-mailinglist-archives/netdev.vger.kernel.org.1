Return-Path: <netdev+bounces-131922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E787398FF1B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA791C21C1D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236C14036E;
	Fri,  4 Oct 2024 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="humaQc4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3E13D2BE
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032130; cv=none; b=dQcnv/oxthwizCL5ozyBrzwJHA5jluMu1d5b+lFEwZ6WkaLkvHAVY/j6IurkVrXVGmSOAAdjJYDHKoUpVeBDLTV9dh7yqoKU0mKibV6Dz16haRaCs7cEMywvS+CYdtDCJPGiHkJ9wLdVC8sZhjRAu7mzTBvDbemCe637TMNgqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032130; c=relaxed/simple;
	bh=G4NOQYUd6lbAZrqBMu3K3LRuuLXb8ndFNWXjGjfThWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6DdbzaxakhRUID53/PbJ2/bZMK3jik48G52LmjbPy4UP9GEf0THReNa/cCmNkRxrpnanqtqQzqozZ90h3Vj5hkK8u7hQ3evHa4mXd88LFa1F9OIBQ58JvVpIRw1M09OTNx90nUP9dRsTkiVgqdgGSJJwbQvLAz+SvsjPQ+sNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=humaQc4M; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2facf48157dso20835481fa.2
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728032127; x=1728636927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APHihkRJ426qI6C5wVNLcGdq46sW64PqDR1x8Iq4k5k=;
        b=humaQc4MtqhNrQg2IcqU4fsW6Uv1V40uVNxxwWDhibF0H9N18tGvWMXie7bWeWeumh
         MRFpK/k8OtUbx/8h39u+zrnMvfRCT5fHj83grBq5pycQdWuKztcGpUwb+FnJg6IQLXY7
         vEXVxxA8ViIFGmIMeh0f5Gf93JqP0rf77GaGd6PYbu1d8FSJkLKLWoNgxpaDerKSCyhX
         t7Qj+t0AS8xCy8AISCSusBvbSlpc2tjsxY9XufZxMWNAWizF3xpMQZ9tjX0Lm7bHhGQr
         HS79eVHRl0kWTnkgCpvHDuxCfa3FzFRp9hRtLb7xvdHueHvRdtbKM+/wd0ejCbPt2ozA
         +n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032127; x=1728636927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APHihkRJ426qI6C5wVNLcGdq46sW64PqDR1x8Iq4k5k=;
        b=ty7AtswXSU1CjNakyYmAIQ1jJNbdMsCUGbPXfyDfjz24E/5lOulMfL3J7kGch4nQAh
         z8grJTQHQepAZ7XJO2PQV67KsXL/K/0BXmCS9hAnOWbATMFuicxKpCRGtcW5w3N2i53p
         e+ZXGrnd1yKjNkLThYqs2JudLbGf1ooOoUdssbqkV6pS+4H5pPmgmisPSUVU0eT7vzCk
         b72ndSYbMuP6j3bJmawMZ/hVhSbAsslvLTBnFFJQ1dH6rpFKnlZblNUqBUt0VGfgf7ZX
         Apn/ZZp7bYC8rJ4o3sqwQIpOPlvB7BJMVlsi+VkYcAUIIxxDde1IXKDHD3Jiyv+UWDc7
         YvDw==
X-Forwarded-Encrypted: i=1; AJvYcCWfYVgv3aNMUsZOCmGNRznev5ef2aBiTTsyQvQ6k0naalmWqyHCrnxaj+ofgDKZz1b4iMJxuEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOAZUAPajub4nD1bsCvnkImnYS7atQLL8fJ6YTXEnpx9wCj4c
	J0GpiuP5tUkza1nX2qZn4Ijj5UqavrDPvm2T9N59Tw/3F+5BdkprxOTIUWIwG8CgOqII1dmnsnh
	PNnV9Gb9Sp3uLFZhOGbFH0H5I0ppg/JDOr1cw
X-Google-Smtp-Source: AGHT+IGTqyJALZax478RwJ5kw0jUBmZiI4PXZFZPCOQh2NZNXGF5/4paa1kJ4psKYCjn+3Xprn5TVs/ZIHHKuAqKKg4=
X-Received: by 2002:a2e:be90:0:b0:2fa:c9ad:3d17 with SMTP id
 38308e7fff4ca-2faf3bfffc0mr11399431fa.4.1728032126561; Fri, 04 Oct 2024
 01:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003170151.69445-1-ignat@cloudflare.com> <20241003215038.11611-1-kuniyu@amazon.com>
In-Reply-To: <20241003215038.11611-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 10:55:12 +0200
Message-ID: <CANn89iKtKOx47OW90f-uUWcuF-kcEZ-WBvuPszc5eoU-aC6Z0w@mail.gmail.com>
Subject: Re: [PATCH] net: explicitly clear the sk pointer, when pf->create fails
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Thu,  3 Oct 2024 18:01:51 +0100
> > We have recently noticed the exact same KASAN splat as in commit
> > 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket
> > creation fails"). The problem is that commit did not fully address the
> > problem, as some pf->create implementations do not use sk_common_releas=
e
> > in their error paths.
> >
> > For example, we can use the same reproducer as in the above commit, but
> > changing ping to arping. arping uses AF_PACKET socket and if packet_cre=
ate
> > fails, it will just sk_free the allocated sk object.
> >
> > While we could chase all the pf->create implementations and make sure t=
hey
> > NULL the freed sk object on error from the socket, we can't guarantee
> > future protocols will not make the same mistake.
> >
> > So it is easier to just explicitly NULL the sk pointer upon return from
> > pf->create in __sock_create. We do know that pf->create always releases=
 the
> > allocated sk object on error, so if the pointer is not NULL, it is
> > definitely dangling.
>
> Sounds good to me.
>
> Let's remove the change by 6cd4a78d962b that should be unnecessary
> with this patch.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Even if not strictly needed we also could fix af_packet to avoid a
dangling pointer.

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a705ec21425409dc708cf61d619545ed342b1f01..db7d3482e732f236ec461b1ff52=
a264d1b93bf90
100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3421,16 +3421,18 @@ static int packet_create(struct net *net,
struct socket *sock, int protocol,
        if (sock->type =3D=3D SOCK_PACKET)
                sock->ops =3D &packet_ops_spkt;

+       po =3D pkt_sk(sk);
+       err =3D packet_alloc_pending(po);
+       if (err)
+               goto out2;
+
+       /* No more error after this point. */
        sock_init_data(sock, sk);

-       po =3D pkt_sk(sk);
        init_completion(&po->skb_completion);
        sk->sk_family =3D PF_PACKET;
        po->num =3D proto;

-       err =3D packet_alloc_pending(po);
-       if (err)
-               goto out2;

        packet_cached_dev_reset(po);

