Return-Path: <netdev+bounces-238389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE04C580A5
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E48EF34EBA9
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53A27FB32;
	Thu, 13 Nov 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBU2qE3l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjY43W67"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F42324634F
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045423; cv=none; b=L/ZKxunp2X1zgqyn0mQ08MbhIIWHqRuyNiCKAt6ZkI6M2PDAxxcV5KDojlnPM/Mygpt/18sUma76KReG6/ad0wc06A7o4nFwIUCTjt/HZ8aSo8jjT1uX2HQ4BXM1qIsgpxcff5AX6VpJYhmRsW+mqoKPh+qKUzXD2Epmu58fxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045423; c=relaxed/simple;
	bh=8sn+1gVfv+/0ejEVwbJvhBy3kmgLgBs0jIjZ3GlTFwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqcvSfYBJMbGc4ZAJ+HnJBPJR3cdXP4nhkC7YqV4N0kUdvyaEIvEoM2OS0XFOBQzhm2a/Kr0/dZfpeFAI5Rgeo8vvJ4UY0nAKTvAlegXwO/d9i8MdHWrVla2Cc18M+MIqKK4goySVvOE8vYXawwOVnbOl8GlSH/G9/OuXLORAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBU2qE3l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjY43W67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763045421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccPBcVEYfv3CKsEVYsFhFk4zVwAZCORA96fhkulkBm4=;
	b=GBU2qE3l40J1fmw6BBqCEusdI51ErNn8DwBmc3K3K5/Fxqp7Gle5LGEld4RHY7Mx64STOe
	gT63vr/TC+gijL4vOMb4NxKN+snRWnVFheLHHALFVzpeOByy0mNgJN/FSqquJOT6oKqN24
	JE2vn32l2T7Yhyq7/HDpCwEmmIsoZts=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-D0nwLUQSPJiW_Sxg7kmAfw-1; Thu, 13 Nov 2025 09:50:19 -0500
X-MC-Unique: D0nwLUQSPJiW_Sxg7kmAfw-1
X-Mimecast-MFC-AGG-ID: D0nwLUQSPJiW_Sxg7kmAfw_1763045418
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b70bca184ccso124024766b.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763045417; x=1763650217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccPBcVEYfv3CKsEVYsFhFk4zVwAZCORA96fhkulkBm4=;
        b=BjY43W67uY9+SzJYMTsCGqWZXl3psgt+G7sOs053zqngnOvzdwbuEt2VOWTArcHcd8
         4LS2TSsGi9sQaM90xePgtijcihVXimIvGlE0Hk70eqYNhy8Pb7EHuzdyIpP2VAsi8w2l
         40Q1+IlgplMuhNDtcfF+wGj4xdSTx9flrU3d95TSMGHukDO1tqegPrTMFPr45we1SdmM
         yP+9NDxAFFv378q3sm4CY99drrIhCeUXNwGQmDNJ4Up36kVF/oLXeMfrrPHDofr9FUhV
         DGz/rV4pGb8H5cFzpVIU1QQ/oRSYErMIEL9S3sb7dR/53CzTmDmwDCKPdUI8DWgL5Nuk
         raWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045417; x=1763650217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccPBcVEYfv3CKsEVYsFhFk4zVwAZCORA96fhkulkBm4=;
        b=IHAJo1rZSNzdYPmgVFONOvjV46snBn+MqsJGWwJhedWVGiMTCbhVQ/4diY+CyadjpS
         0D/T+URm20Am9cODhCq4rIIGRJ7mJQP6N78AwZPbLUh9oIhk0siyD0QnjqC/BbJTIZxd
         ANZPhgg+8YBC6MuZBPShM8v/YcNy8p0Fkmp6/zaHYnzVLON+NSzXCIHwOQ442ciWbpWG
         GZSRw6LOZRTMh59tQOGNhQo/vROVwHH/8A+PEayYnFfn7nrj3di5m87TV7XjC1pYForJ
         UpAynjxNcYccL1rKn77Y7g/yGWx3hX494DU5t6wyVznYfm2URKO70bNfRRDz4dWrZ2WS
         78RA==
X-Forwarded-Encrypted: i=1; AJvYcCXd3nAp0w74QjM7xDcmpLMAp9uGMHw6BJjsoPqpQYcN78bDDZpTPlBYpOiMMFWSACE9y0LedpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjXVFeAcMzs82+7eeg3BBOdgWG9ZbIZV66Y69MKt/cHKFGvmf7
	Yq6s8FMhCNe90yCEDoIUEPNl5Q9rHTv3bxAGgBkjPFz1bREHrVOY13SfKl92YXoYodf7RCBmyjh
	V2HHKAIJo/ppaJcFGFT79VHv7cOAjKEECB/cobMlKVTnWXAypuyJ+WOE5YQ==
X-Gm-Gg: ASbGnctB69T3gndQ2YY7lxMyQte4E/oVKofYLsQlU/jvaW8yILTu1EeuhNIr40Dxg0u
	nscxPptEGkR2KnRc/rflSgbF4YyZA8GAD+v42IqX0yoApxhBvieyp0a4bTNneki+BSoWEklXTbw
	Q6mtLkvt04MoQ408szoZqJMtAbVEdy03ddV4WfYzLtj5x2lMT0AmDs5YGWCsDlJTAzQnW8UpkjX
	GVH9oCxPUUOlSUXr9zfc7J3YJPUgWK6LH3qZUw25lu/UBwrvQnv8xnD9wnJAWfUA6Vw9Ul4AVms
	IhQpvZm0UHoE157+ZsO+x+JpiNGoks9n5HRqPCVXKWr24t0Axk/oOSo8S8Nr2w1pkH1UXZJoadQ
	zGLDd+5NZlS34
X-Received: by 2002:a17:907:6092:b0:b6d:62e4:a63a with SMTP id a640c23a62f3a-b7331aa9775mr765258166b.40.1763045416543;
        Thu, 13 Nov 2025 06:50:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd5TszTx9Ftbc+1tpBg2R5bDY4Ip4/CQe2Mmx4GrIHNGWKqsCGbjONvF+Dgw0TZ/pVKl41bg==
X-Received: by 2002:a17:907:6092:b0:b6d:62e4:a63a with SMTP id a640c23a62f3a-b7331aa9775mr765254466b.40.1763045416035;
        Thu, 13 Nov 2025 06:50:16 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734ff36ac6sm175932366b.74.2025.11.13.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:50:15 -0800 (PST)
Message-ID: <f79bf201-c4fe-41a9-9ccb-b93271d83183@redhat.com>
Date: Thu, 13 Nov 2025 15:50:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>, linux-um@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
 <20251111111212.102083-3-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251111111212.102083-3-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 12:12 PM, Xuan Zhuo wrote:
> The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") introduces support for the UDP GSO tunnel feature in
> virtio-net.
> 
> The virtio spec says:
> 
>     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
>     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
>     all the headers up to and including the inner transport.
> 
> The commit did not update the hdr_len to include the inner transport.
> 
> I observed that the "hdr_len" is 116 for this packet:
> 
>     17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
>         192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
>     fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
>         192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796
> 
> 116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)
> 
> Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 3cd8b2ebc197..432b17979d17 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -232,12 +232,23 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  			return -EINVAL;
>  
>  		if (hdrlen_negotiated) {
> -			hdr_len = skb_transport_offset(skb);
> +			if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					       SKB_GSO_UDP_TUNNEL_CSUM)) {

I'm personally not a huge fan of adding UDP tunnel specific check to the
generic code, did you tried something along the lines suggested here:

https://lore.kernel.org/netdev/CAF6piCLkv6kFqoq7OQfJ=Su9AVHSQ9J7DzaumOSf5xuf9w-kyA@mail.gmail.com/

?

Thanks,

Paolo


