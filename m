Return-Path: <netdev+bounces-236597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053CCC3E3C4
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 03:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E853AADCD
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 02:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F262BD035;
	Fri,  7 Nov 2025 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LT5zpok7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJJ8yukO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C5228D8F4
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 02:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482132; cv=none; b=G2f+3GgAGwxk/AfoM53EUMjthjjdbv85K9H0PWkQ7Ww4515O3no9E3YseRSYVXDkf4MpGxRHuMRJrp1DENnbktSBFxWZ4kY9ohMQ7f7ncpikYTlp3Hg1yh6g3x0nTSETGj4kWAXbSQNg9hB/yFwBbUH2DaEHpm3R8+9Jx9pV0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482132; c=relaxed/simple;
	bh=eiI4RKVF+XpJdnWRY2/y6Pec9+uJCgwdIuA1y4j7C2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhohiU6UGl7ljO3RU0RNE/JbqQAGK+8dqxEGQhXFJ7F782T8wAQp9KLk3ZM+vSaArrzQlSjNi3O+v6x8Oz7yoMO9r0vnyfr7kvxp8+7q06n6NUFd72gzMtr9A5kbzvMv0UkzH/GMUWDUgDBmvZTGkLZBT87DcQxlFLBNed5t1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LT5zpok7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJJ8yukO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762482129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmfewvY3TIZVqOYMciv4wS6LQJa6kLXl31utpCfsjYw=;
	b=LT5zpok7sTOo4rxAPnQH3xvabcZVlu5x1Hvfy4SGTE7l2llNrVHwRP4vcOzkOa9uE2VLyD
	hb8iD53o/odR5jECTWCKEogwY8WvAIs92lKfRvsnmclsTf7me6hODbkecerxVU9jXikLDK
	8JO3YjunOUkJA354sRSyn1NnbQuM1t8=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-9G6_yULbPTied2dkyMx68w-1; Thu, 06 Nov 2025 21:22:07 -0500
X-MC-Unique: 9G6_yULbPTied2dkyMx68w-1
X-Mimecast-MFC-AGG-ID: 9G6_yULbPTied2dkyMx68w_1762482127
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-935183381c7so132020241.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 18:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762482126; x=1763086926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmfewvY3TIZVqOYMciv4wS6LQJa6kLXl31utpCfsjYw=;
        b=fJJ8yukOYBLu/qK+93onmgZYnphaZ6lxuMwoCyldCcjUtKhmnMJGnQNkp+W/4fxM2r
         BwZcHG59s1vCfKLRC0qv7gMShtEC4HtWQ/Elm+o+Rw42O/mMzD/uDx6Xg7Qz5duntzDg
         WcRIkULfyDfN+K+zW7oWhEH0N+HSmmsCT6u+9GPWrXmGtdfguyIaTL5nbrIX+ID/P89Q
         9On5dnbyBePOkCn51EwKN/Tr2RMeu0+llRsyiAZ/7IqsYP4GDUYRnOAjMRz8gOx0Hc9n
         qJt+3sOPFIFMz5yH0jqpqU8OuRFmHYaLdD1N+h9rL9vX6TL8oRPyK43RRyrLskL3Nlsg
         X4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762482126; x=1763086926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NmfewvY3TIZVqOYMciv4wS6LQJa6kLXl31utpCfsjYw=;
        b=aZThK3iO2HmdIWuDLfZYW/JstTusw7XqsEbPo8Nl5+TO95E9DmW4oncvkUCt/mbHne
         VHaIuoDUpBJj7VjBqQYvkxLHrxncXKRy8v2rhTku5j3sLycuSo11pzskNsIdtzFNYAB9
         m+5CtBIOFU5/bHQKFGpEPfmObNFxx2jkBwqbqYM3S/snME2Fw1aQaFOQ9+eYwweE4vpt
         +I6ICsO+bwJ+LnsoHlQz4jgy4PVmNNvhWKLVN/4xfj7hgzPoY/FW+7Ohnde4yhde1Bnt
         xVtvAYmlaEiRhzGsoWKB/y/YVuAB+v7Pj9F5bVLcebY2dNMz1VsuxHoj6+CpVqm3unR8
         Cybw==
X-Forwarded-Encrypted: i=1; AJvYcCU3gbQemfZG7ettSu78fkbMdUcAClppTKt56U4AsZRjJZca6IyXTsD2Vg+AjHS54GgJ4rhrI2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zPNBMMJ49W8rW2RMAsN85iXZq5RqXUrmpDNh6EETWOnF4ZY1
	uUselCkvPl8Ekav4i3ub/ndathWDR0MSP9jU7/63WmlodndXP1rtG4/s2S9kXXf3Wocy3FMRKGz
	uFKB+EffN37DPdpCrWDdTXtf8bJGoSwRzn5VojmG9VhVCGyelhCKHZi8WI7cmd1aSxv5Sv3cd1H
	Olqz2aA7xxRtN3GAWl6whzi3SM0l26Gwgz
X-Gm-Gg: ASbGncvzXjYg6cuYVWMhEUbffMYbZJuwbDYTsXg3Ey1C2EIXgcAKRBiKjRxcZCEyzoc
	QchtiPP+Cugn3gnnQU8YCrP1EaPQPIVzm+946b+2KKhEG2af3miZTthEGrywkSb2Dsf31rL8Ptl
	2pXKqlG3JGtpUoaEoJnvTn72an7jPlRYm2h9upCqNCzgJQ/9NFkK9LPSho
X-Received: by 2002:a05:6102:5088:b0:5db:ce1d:678b with SMTP id ada2fe7eead31-5ddb2262982mr529358137.23.1762482126538;
        Thu, 06 Nov 2025 18:22:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQTgCIR2yZlyIRsjR+uBaJ9KKVZE3VbDYLFEq7FC0HdybQ70nBT/Rf27Y/CrpLSHwuhhdFyvK8RLF+GsdDVVg=
X-Received: by 2002:a05:6102:5088:b0:5db:ce1d:678b with SMTP id
 ada2fe7eead31-5ddb2262982mr529351137.23.1762482126071; Thu, 06 Nov 2025
 18:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106155008.879042-1-nhudson@akamai.com>
In-Reply-To: <20251106155008.879042-1-nhudson@akamai.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Nov 2025 10:21:53 +0800
X-Gm-Features: AWmQ_bkNLb92dFLG4-4esFms4Eqjl550eytSJVRszH74gOThR-8BQOC_V694_EU
Message-ID: <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
Subject: Re: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
To: Nick Hudson <nhudson@akamai.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:51=E2=80=AFPM Nick Hudson <nhudson@akamai.com> wr=
ote:
>
> On a 640 CPU system running virtio-net VMs with the vhost-net driver, and
> multiqueue (64) tap devices testing has shown contention on the zone lock
> of the page allocator.
>
> A 'perf record -F99 -g sleep 5' of the CPUs where the vhost worker thread=
s run shows
>
>     # perf report -i perf.data.vhost --stdio --sort overhead  --no-childr=
en | head -22
>     ...
>     #
>        100.00%
>                 |
>                 |--9.47%--queued_spin_lock_slowpath
>                 |          |
>                 |           --9.37%--_raw_spin_lock_irqsave
>                 |                     |
>                 |                     |--5.00%--__rmqueue_pcplist
>                 |                     |          get_page_from_freelist
>                 |                     |          __alloc_pages_noprof
>                 |                     |          |
>                 |                     |          |--3.34%--napi_alloc_skb
>     #
>
> That is, for Rx packets
> - ksoftirqd threads pinned 1:1 to CPUs do SKB allocation.
> - vhost-net threads float across CPUs do SKB free.
>
> One method to avoid this contention is to free SKB allocations on the sam=
e
> CPU as they were allocated on. This allows freed pages to be placed on th=
e
> per-cpu page (PCP) lists so that any new allocations can be taken directl=
y
> from the PCP list rather than having to request new pages from the page
> allocator (and taking the zone lock).
>
> Fortunately, previous work has provided all the infrastructure to do this
> via the skb_attempt_defer_free call which this change uses instead of
> consume_skb in tun_do_read.
>
> Testing done with a 6.12 based kernel and the patch ported forward.
>
> Server is Dual Socket AMD SP5 - 2x AMD SP5 9845 (Turin) with 2 VMs
> Load generator: iPerf2 x 1200 clients MSS=3D400
>
> Before:
> Maximum traffic rate: 55Gbps
>
> After:
> Maximum traffic rate 110Gbps
> ---
>  drivers/net/tun.c | 2 +-
>  net/core/skbuff.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8192740357a0..388f3ffc6657 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2185,7 +2185,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, =
struct tun_file *tfile,
>                 if (unlikely(ret < 0))
>                         kfree_skb(skb);
>                 else
> -                       consume_skb(skb);
> +                       skb_attempt_defer_free(skb);
>         }
>
>         return ret;
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6be01454f262..89217c43c639 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7201,6 +7201,7 @@ nodefer:  kfree_skb_napi_cache(skb);
>         DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
>         DEBUG_NET_WARN_ON_ONCE(skb->destructor);
>         DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
> +       DEBUG_NET_WARN_ON_ONCE(skb_shared(skb));

I may miss something but it looks there's no guarantee that the packet
sent to TAP is not shared.

>
>         sdn =3D per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + numa_node=
_id();
>
> @@ -7221,6 +7222,7 @@ nodefer:  kfree_skb_napi_cache(skb);
>         if (unlikely(kick))
>                 kick_defer_list_purge(cpu);
>  }
> +EXPORT_SYMBOL(skb_attempt_defer_free);
>
>  static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
>                                  size_t offset, size_t len)
> --
> 2.34.1
>

Thanks


