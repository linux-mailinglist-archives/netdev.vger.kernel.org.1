Return-Path: <netdev+bounces-115825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5543947EDC
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81611C21D6F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78B15B99D;
	Mon,  5 Aug 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RCXywq9t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1015B995
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873569; cv=none; b=Tgs4J1TCkcot1P4jYoSfexBzbYYG6TWEZe9o2b2L++tnGZ5zHOQcphTVTj6rj0wA8h6TKYzn1D+0ybquAv0DYKS1hQ2GxjYv1j6O2gSIl5zLUg6U4NDnZZ+VRWF4uNnBpKaKuFa5w0f0EAyX1I4E2agRRHtM9OxNsSJ7sTuaUDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873569; c=relaxed/simple;
	bh=yyFHHJLs5XMnsATcmDV5xwsL/52ewonO/mr4v7WU8VE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VuoS6IQ7G3t+b9frFqGBuBKvii967uXNTj0hQbRXZW3TU8JR5qqrJygFuJkavMLiHmvrAavR+cCKEFwkpj2QEZrFtYewTzwdPHXvGSviW4RXT9MtTNvKm3PxziLWTAoU/fEaDT37glYoDQqlHld3tUur4Edq4tn7Fd7jAJ0wW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RCXywq9t; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so1309097166b.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722873566; x=1723478366; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Dblc/r7f8uhc3yu/sQ/4f4uPAPMTaEkolU/TBHtbGk=;
        b=RCXywq9tZ+wR2Qe2U2hViTTQ8bpolSIUjHXjThypEaCXefRucyvrX2tmjoLBk5wokL
         VSn9kIoPMoRVNomvDNONJXC6EeXv0OBQNH3hy9JU9E/RWRcte/AejDWhcpAPH3SaE4lF
         ZCa1L8sXM0IYLWDiBhCSCYaf9pPaRKWfpEqVEz6r1sUItyLGhTVc7zcYbY9oO0iGwOk1
         GTt02sUxATr8rPGWkGjEUzKLqNK1fzZwxwaugxgxRjbTEY/29VfiVejP8JmeL98WPBhB
         VAduHK+cnfkPbWfGd8ppN4CawyzLIuAvHczmmrzjd2CPuBB9aK/bfoQZPkSjF7m/8Umi
         OCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722873566; x=1723478366;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Dblc/r7f8uhc3yu/sQ/4f4uPAPMTaEkolU/TBHtbGk=;
        b=rD4xW4RKOAn9OIXrDy16ej+cb9urUwfqM5jZkVpaavwQnuKw+as1V5YySXSKeVPulC
         gn1SPs4U8IhnjV0Oa9dpb8r9l5yeLH02MhF1ReJed/6Kqbj1MFrT1b6QtfQfGzV8aRTj
         jaVQh6ocz9ZHQnRuBiL5RQ2rAAGrTYz1i7bnYHpKedruqlq8XELAHU1Umzb3X6SFn9PD
         vdLAk0rfe9N24Zwp41c/e8z81QaDwjnQ785bo2IZY/H89Xt9AfzsrHCw9bZbpB38MXN0
         zuMZxOpRFsF6mwGFb4Lnb14s1O9Ah38C8mje5kkp3zi/vW7RcPCGSRYsAJpnQt/y43VZ
         h6Lw==
X-Gm-Message-State: AOJu0Yw9S02Wngb6XsBDLKWNq89JLgC8vwaim820hNTc8u2fXen768dj
	YfzveJxSucgQyePHX1ohXhkA0rJjhdV3KREIR4W94iNxDuI2qsj5xhvoQbN88Ks=
X-Google-Smtp-Source: AGHT+IG/NaSvZzKXJ84M/pgzNsoZuPet3t04ozqaaREZpA5iXl0iehAG+8uAWAzWMZXZlMmgIcSt4w==
X-Received: by 2002:a17:906:6a11:b0:a7a:b43e:86e4 with SMTP id a640c23a62f3a-a7dc4e68c0fmr924194466b.27.1722873566093;
        Mon, 05 Aug 2024 08:59:26 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c61575sm467111766b.92.2024.08.05.08.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:59:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,
  kernel-team@cloudflare.com,
  syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 1/2] gso: Skip bad offload detection when device
 supports requested GSO
In-Reply-To: <66b0e0d3c2119_2f5edf294c1@willemb.c.googlers.com.notmuch>
	(Willem de Bruijn's message of "Mon, 05 Aug 2024 10:25:23 -0400")
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
	<20240801-udp-gso-egress-from-tunnel-v2-1-9a2af2f15d8d@cloudflare.com>
	<CAF=yD-JaeHASZacOPk=k2gzpfY7OzMwDPr99FMfthMS0w9S7bA@mail.gmail.com>
	<87ed73z3oe.fsf@cloudflare.com>
	<66b0e0d3c2119_2f5edf294c1@willemb.c.googlers.com.notmuch>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 05 Aug 2024 17:59:24 +0200
Message-ID: <8734njyn8j.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 05, 2024 at 10:25 AM -04, Willem de Bruijn wrote:
> Jakub Sitnicki wrote:
>> On Thu, Aug 01, 2024 at 03:13 PM -04, Willem de Bruijn wrote:

[...]

>> > It's a bit odd, in that the ip_summed == CHECKSUM_NONE ends up just
>> > being ignored and devices are trusted to always be able to checksum
>> > offload when they can segment offload -- even when the device does not
>> > advertise checksum offload.
>> >
>> > I think we should have a follow-on that makes advertising
>> > NETIF_F_GSO_UDP_L4 dependent on having at least one of the
>> > NETIF_F_*_CSUM bits set (handwaving over what happens when only
>> > advertising NETIF_F_IP_CSUM or NETIF_F_IPV6_CSUM).
>> 
>> I agree. I've also gained some clarity as to how the fix should
>> look. Let's circle back to it, if we still think it's relevant once we
>> hash out the fix.
>> 
>> After spending some quality time debugging the addded regression test
>> [1], I've realized this fix is wrong.
>> 
>> You see, with commit 10154dbded6d ("udp: Allow GSO transmit from devices
>> with no checksum offload"), I've opened up the UDP_SEGMENT API to two
>> uses, which I think should not be allowed:
>> 
>> 1. Hardware USO for IPv6 dgrams with extension headers
>> 
>> Previously that led to -EIO, because __ip6_append_data won't annotate
>> such packets as CHECKSUM_PARTIAL.
>> 
>> I'm guessing that we do this because some drivers that advertise csum
>> offload can't actually handle checksumming when extension headers are
>> present.
>> 
>> Extension headers are not part of IPv6 pseudo header, but who knows what
>> limitations NIC firmwares have.
>> 
>> Either way, changing it just like that sounds risky, so I think we need
>> to fall back to software USO with software checksum in this case.
>> 
>> Alternatively, we could catch it in the udp layer and error out with EIO
>> as ealier. But that shifts some burden onto the user space (detect and
>> segment before sendmsg()).
>> 
>> 2. Hardware USO when hardware csum is unsupported / disabled
>> 
>> That sounds like a pathological device configuration case, but since it
>> is possible today with some drivers to disable csum offload for one IP
>> version and not the other, it seems safest to just handle that
>> gracefully.
>> 
>> I don't know why one might want to do that. Perhaps as a workaround for
>> some firmware bug while waiting for a fix?
>
> I doubt that this is actually used. But today it can be configured.
>
> Which is why I suggested making NETIF_F_GSO_UDP_L4 dependent on csum
> offload (in netdev_fix_features). I doubt that that will break any
> real user.

Sounds like a plan. If we're talking about simply disabling GSO_UDP_L4
whenever either NETIF_F_IP_CSUM or NETIF_F_IPV6_CSUM is "off", then that
is straightforward. And the NETIF_F_HW_CSUM dependency is clear.

I could even piggy back it on this series, at the risk of additional
iterations.

>  
>> In this scenario I think we also need to fall back to software USO and
>> checksum.
>> 
>> Code-wise that could look like below. WDYT?
>
> Since this only affects USO, can we fix this is in __udp_gso_segment.
> Basically, not taking the NETIF_F_GSO_ROBUST path.
>
> skb_segment is so complicated already. Whatever we can do to avoid
> adding to that.

skb_segment is a complex beast. No disagreement there.

Keeping the changes down seems doable. We can drive skb_segment to
compute the checksum, when we know that's needed (because IPv6 extension
headers are present -> ip_summed is CHECKSUM_NONE) by masking off csum
flags. Thanks for the suggestion.

[...]

