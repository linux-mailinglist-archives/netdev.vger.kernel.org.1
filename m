Return-Path: <netdev+bounces-247807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D0DCFEADF
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 16:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D13305574A
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F538B9B1;
	Wed,  7 Jan 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYK6Iwmc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4048A38B9A6
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800643; cv=none; b=i7+ZoorAyT+gQ6+0yVFshfqy04goPi1y27CdIEyqJ6kdRBxtokQ+Nh48BvawvVE/t+IuyjBGsUKwOfIpQL7r1IuLCwnntGqokOYlBDIYngXEQPwjFsbwJ5ad6kocU3FiIPB4hTkKuWAXVh8Q5bevylmLPmK+1/cX0f8WJ2M1ksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800643; c=relaxed/simple;
	bh=Sa9ZWzE29qrQrBl4qGZ0Nd3XS5vjlGNg1hHVfusfLs8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o/PXZI5/g5PHradBeJcbKaODS/GEgDN1S99JetZ3ioDR/M3VbwS/VNBaylHqe4pUi8Xlc3/i3TQeWr/l0L2jRXpRN3YDVRq7iGCXElUkACRZjtSr6erA/8LkOS2k5ogndrManB0V+s4cv29Cmc6mi4Ac2lWn5bTyN/I5NtSKGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYK6Iwmc; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fcb465733so24625547b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 07:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800641; x=1768405441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8f04eHjfvnkHYorhM7bm3sfteEWTpTlDP3O4cfOEtM=;
        b=GYK6IwmcojGLrztPFveLuzWlGrMp6NGim1Vg9jN10zpn4RHToNAv0cFK7z1Ecr08Za
         AfTpOn5HXIl5A5D8J3H/3JOC1R5MulBsNizKuEdu2we1Z2zQPsIQY3YuWtJ45edOBkI6
         CR9WBzd8ebWNyi8TCmf0+0bDE9NFGFGI1x91xYYOsmFIrG8Ua1xfGee9kKZvlhh+wP3f
         lD9L/aI5eFxc+Zg5Dgx3iGj3gURyLO091qDAruyp5smOg+OS6FnJg41c2SboY8AEv1ax
         02kl7BIwWgtMmmn/A+YJPZKroW4da3P/r/z5NfQozaulTT5oW8r5jID6w44TWexhrn5W
         bjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800641; x=1768405441;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8f04eHjfvnkHYorhM7bm3sfteEWTpTlDP3O4cfOEtM=;
        b=l6iCDsJ8CsCxhqpfzFQutKDpymnT3TAAfTxSH8ysSJoGxbW3tJHBbBRu/OaBUSb7Gq
         DNflqmMmlG/tA0YjemcaVd91EPXI92k+3cmVYt/mLYGqtuA9tnAuKOIowKeH+84QGSTJ
         EPsJV/6J83ljB+guhsJx5DOGr9cMS2GYlBK1vzw9hwD3+zDUFAVEjqDzsebwmuKcLXqm
         eR4hsVeVsrw1RTh0hKHvs64pztBsz+nIU0YrcC3hUJdDWXneYnTQmcA2y4rMsZvTzo7u
         O9i4m5eiazwNJCCp8aaJE9MBfRUGpfj294AsJR1atE04Hqj48+Tu2oW5M5IoZfz1eC8A
         c6mg==
X-Forwarded-Encrypted: i=1; AJvYcCUqECPBiGGv6qu/BS5l2pDZyIeOjKcWrGJzfm7oF4qCRBUIVG4bVX1gZzSMMwbc+JxHYx1+XV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1V5Joj+oisF1GJMfdF7cFh0qtZuGCyUOTDwmHTRG3+O1KFNP
	9vCKoH9ySAI2fdT9R1q7VRclGQ5+yIDRJ3eWxS2ZVrw9Hq41I8w8ASR43pdEDQ==
X-Gm-Gg: AY/fxX6QVb7slbDECm+PNGEmAvqD1vKqFvr6hK2+QFOk+S6N7C7s0jBI4G0fGLqfqPR
	ww3t8tCbcDVgicp8WsXjtMfLUfBUFope2BGwvj/Dlup9A3Icku/AMhBuC3molJMrOfKNrzc/ZA2
	oAKPeC+Lsi8M9Vl2gFY9HnaIQg/mSYTpc1RoP/W3KKW6PsJMOlvHxy4uujptIaw/RNHfLZklHbD
	l7INbi/qMEziGnvNs4PAE3g4+M0TvbgN9IAt48f9u8LgFGK3CFCXPGulPcMjDPMk7FXojcn3xb7
	Y+y+bnT2fKRao3Kmb2jlt6OAAsGc6u0zSJVJfm/VwkUYQbGwAFdK5OAb0/n650HjsLiDblnAnlS
	qWzHu22p4jYx54vIvgr9OSnlJ497UAeo9TUIjFL9FWZWawjkVBtQvNiBBLDxkh66PRpWFm6Tqdj
	vsoA8Rg1D79o1R4yLCIe4O62grxPJ/Jhf5VUYy1yvn0Ghy4xtifKpCVYnl7Dk=
X-Google-Smtp-Source: AGHT+IEFFSiNXKDV1HnAD3Zg/sQPsGaeIN8FIPZnBaaRsTUeL+P2OUb/fto4XbVbM+NqywPmBogltg==
X-Received: by 2002:a05:690e:1202:b0:644:ca2b:b659 with SMTP id 956f58d0204a3-64716c89b6bmr2570788d50.64.1767800641000;
        Wed, 07 Jan 2026 07:44:01 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa670b21sm19793267b3.33.2026.01.07.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:44:00 -0800 (PST)
Date: Wed, 07 Jan 2026 10:44:00 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>, 
 mahdifrmx@gmail.com
Message-ID: <willemdebruijn.kernel.368719d33bc5@gmail.com>
In-Reply-To: <20260107141541.1985-1-kshitiz.bartariya@zohomail.in>
References: <20260107141541.1985-1-kshitiz.bartariya@zohomail.in>
Subject: =?UTF-8?Q?Re:_[PATCH=C2=A0net-next]_=5F=5Fudp=5Fenqueue=5Fschedu?=
 =?UTF-8?Q?le=5Fskb=28=29_drops_packets_when_there_is_no_buffer_space_availa?=
 =?UTF-8?Q?ble,_but_currently_does_not_update_UDP_SNMP_counters.?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kshitiz Bartariya wrote:
> Update UDP_MIB_MEMERRORS and UDP_MIB_INERRORS when packets are dropped
> due to memory pressure, for both UDP and UDPLite sockets.
> 
> This removes a long-standing TODO and makes UDP statistics consistent
> with actual drop behavior.
> 
> Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>

This is addressing the same open TODO as the patch under review

https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gmail.com/

It does so in the single basic block, as suggested here

https://lore.kernel.org/netdev/willemdebruijn.kernel.21c4d3b7b8f9d@gmail.com/

But these updates are expensive, so better to batch them as in the
other patch.

> ---
>  net/ipv4/udp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 9c87067c74bc..66c06f468240 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1794,11 +1794,16 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	}
>  
>  	if (unlikely(to_drop)) {
> +		const bool is_udplite = IS_UDPLITE(sk);
> +
>  		for (nb = 0; to_drop != NULL; nb++) {
>  			skb = to_drop;
>  			to_drop = skb->next;
>  			skb_mark_not_on_list(skb);
> -			/* TODO: update SNMP values. */
> +
> +			UDP_INC_STATS(sock_net(sk), UDP_MIB_MEMERRORS, is_udplite);
> +			UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
> +
>  			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
>  		}
>  		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> -- 
> 2.50.1 (Apple Git-155)
> 



