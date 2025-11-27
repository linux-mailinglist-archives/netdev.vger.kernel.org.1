Return-Path: <netdev+bounces-242323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087DC8F2F2
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19BE1353EEE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E39335067;
	Thu, 27 Nov 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izeMkxUc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4p5nSWA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19028A3F2
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256137; cv=none; b=e3HI9lvmbg9aomSpEDpYbZsKloHT0ZVpVF2nB7ADiM6zLI6gfHyaTRFsEd/isn9Ou2bhwvU7Q1/skwsPJrOgeT4CyLL4w/J7k3hLz4w5ppodbmBCznDMa2pS8uPUmtxTILmbvyGPwW1v7XDrV/YpVJu1/JaosuR96pmUEXfR7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256137; c=relaxed/simple;
	bh=r4ZzWf622tsNVtnWwIdu20nyqNsXO5bOWbpImO2ygDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTEsMS+oDWvvQ0c43OaOfZEVEGgzYHBKbJRo+P9/Yu2kb2q+6q5qCBQLYADJvw20gNjcegrw9HcI/4cNkHy5M15XWggTd3o5szu2rcHfIWLvMqIKSVF1OKjHQ71tkK+Ph9ikM2GKrO9B6xYOqnEkcN7YBZubx+BdukyLvDAZo0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izeMkxUc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4p5nSWA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764256135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=975phbBgu5VyA1MivZ3ZkCvdliAL8o8g367hqsGdYL0=;
	b=izeMkxUcEpi9N2BZ/ZRKCw3A8n/LBtjZ1oriu7joYBpRVZ1AWhqG3Jr/DmUnq4SxOShRyR
	hgASRRI0x9TZsVZvrp+7AMOiCZuU0zGf91+TCyVCisVDRYzMMBalQG7QVRLClyF6mQzTdJ
	Vxc/0+WiHGL8MQoPJ4XH+30oF7eeLrU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-0MeI-0xGM6e-Zxq9J0g_hg-1; Thu, 27 Nov 2025 10:08:53 -0500
X-MC-Unique: 0MeI-0xGM6e-Zxq9J0g_hg-1
X-Mimecast-MFC-AGG-ID: 0MeI-0xGM6e-Zxq9J0g_hg_1764256133
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b71043a0e4fso90399066b.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764256132; x=1764860932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=975phbBgu5VyA1MivZ3ZkCvdliAL8o8g367hqsGdYL0=;
        b=E4p5nSWANwxuXM8zq0rhGoqCVu6E6wrGVYyPMolnMCdFHSm2SKcji8uTCGMxMgN/3U
         3mHa5sfewNpy5Xy3jfBbTPTSRzVacaAFqSNyyTeZyJ8iQhdhPq11pkJGKO9FxPGE/7vu
         jsTHo5QIDeYNEAkSTW5BqFYs6IUXIGUUqpHkJB5dYZTpIYJT05We0FxHO7vJc1fEi676
         CP4eN3deWXznE2e+ilxFWkbZPoXnV3F6SvnOakuIzJKZDKsyAEYfk616WlnMbttdMB77
         1tV43w76464HznRlaf3zNAL2AD8U0eeoscXnMuxlG6QX4kyMlB7FXzl/QSDgSImyOTt8
         QP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256132; x=1764860932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=975phbBgu5VyA1MivZ3ZkCvdliAL8o8g367hqsGdYL0=;
        b=VB5dSsH5srVwmLrzMvDU9aDm8pD3frIM0UDdWr2IEPPAkKJBznqkO25e+K3Rdu7zLT
         iJOGHQ4JuJD3wItdRl2HlrwixnjakTBeovETltaschDTArSbx0cgRgb8N5vFpAm36n+0
         +qs3NsSNeE2vsEZduZ+0DU1pEqofp9Sm2kkAHeuIdyeiu9IUdJSIQUKWEzMWFDkoayFc
         n1+sAHBTIMrcburAcfOMgx0s4QInAe7z7twrPbFCcimEYS6k48jt5qK5eXwJTClHH9cE
         ELt990w1am13YsiWjKvBRIZjRjHm7KKUpesoMvPJaosTWxB0aHv4oOrJRxvs8B7b0Gkm
         a1Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVY/E3LK+Gn0nKIIMSDmqt6ER4z3L4JVG1aBFbnJYnNCUQrsb9QYjkUoTIF2uadRnXU3QN17hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQJEiiaUo6VKVXPBXqi73mnx3DzlJ+LbM5hBH1wil2mogTJUs
	rrwUMvOecGnr620aKsDt3HvCtuSXQrpRRDT3AozZPlJ6bDjo6MhQvmFVAWDTvJ138afOYR/gX0L
	5MTNBN4vY0o+Bjfh+LyRKX9K4lVtU6miJKAVMtTv66tODpGKZkd54M9Om3g==
X-Gm-Gg: ASbGnctRUAVz3gYhcZX6EcX2Ov50CJDu06MgPhbJWq3N2GgJ8gFNOka81BkaC8OV639
	LePAa5Ql+s31mLK7idvPefMfkKi38c2QIRqIDJ0SmAh228Tp4K9MNd7BdqcoTvNKLBqglxlE3DQ
	8b2Y55SgSX8ffqxV4XwpPtgW4QxKtzl0sHpJ32U6coPjUI1nP6PvT4+pkawihRqZLMh1qY+Tc5E
	J36fg5yq42fEcDTaOEyYQ1YdEV/EBgR8Vkbf9NX6ea9JYDsgArqp8qBNVwfkQc3h8MBxS8w2IwQ
	2DXCxfts+kwfzx4Msxhe9oRiNdPWBLHu8W/KT3h8xLocLwygMtqLM9Ft93G+76HzK+dda1csMMy
	xd4ndYMmYn4gTlA==
X-Received: by 2002:a17:907:1b0c:b0:b76:3dbe:7bf0 with SMTP id a640c23a62f3a-b767150b850mr2168751866b.2.1764256132443;
        Thu, 27 Nov 2025 07:08:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb4ULpaNMWei1hmL/IxRSlagWdzmISZEpog2WtfT3XFsalNSmZPmRvV9TSFmgMpjPfhmMZ7w==
X-Received: by 2002:a17:907:1b0c:b0:b76:3dbe:7bf0 with SMTP id a640c23a62f3a-b767150b850mr2168747466b.2.1764256131941;
        Thu, 27 Nov 2025 07:08:51 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5163903sm195890366b.7.2025.11.27.07.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 07:08:51 -0800 (PST)
Message-ID: <4362bcbe-4e82-4198-955f-e64b3ff2d9c9@redhat.com>
Date: Thu, 27 Nov 2025 16:08:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v2 00/16] Netfilter updates for net-next
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, fw@strlen.de, horms@kernel.org
References: <20251126205611.1284486-1-pablo@netfilter.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251126205611.1284486-1-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 9:55 PM, Pablo Neira Ayuso wrote:
> v2: - Move ifidx to avoid adding a hole, per Eric Dumazet.
>     - Update pppoe xmit inline patch description, per Qingfang Deng.
> 
> -o-
> 
> Hi,
> 
> The following batch contains Netfilter updates for net-next:
>  
> 1) Move the flowtable path discovery code to its own file, the
>    nft_flow_offload.c mixes the nf_tables evaluation with the path
>    discovery logic, just split this in two for clarity.
>  
> 2) Consolidate flowtable xmit path by using dev_queue_xmit() and the
>    real device behind the layer 2 vlan/pppoe device. This allows to
>    inline encapsulation. After this update, hw_ifidx can be removed
>    since both ifidx and hw_ifidx now point to the same device.
>  
> 3) Support for IPIP encapsulation in the flowtable, extend selftest
>    to cover for this new layer 3 offload, from Lorenzo Bianconi.
>  
> 4) Push down the skb into the conncount API to fix duplicates in the
>    conncount list for packets with non-confirmed conntrack entries,
>    this is due to an optimization introduced in d265929930e2
>    ("netfilter: nf_conncount: reduce unnecessary GC").
>    From Fernando Fernandez Mancera.
>  
> 5) In conncount, disable BH when performing garbage collection 
>    to consolidate existing behaviour in the conncount API, also
>    from Fernando.
>  
> 6) A matching packet with a confirmed conntrack invokes GC if
>    conncount reaches the limit in an attempt to release slots.
>    This allows the existing extensions to be used for real conntrack
>    counting, not just limiting new connections, from Fernando.
>  
> 7) Support for updating ct count objects in nf_tables, from Fernando.
>  
> 8) Extend nft_flowtables.sh selftest to send IPv6 TCP traffic,
>    from Lorenzo Bianconi.
>  
> 9) Fixes for UAPI kernel-doc documentation, from Randy Dunlap.
> 
> Please, pull these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git nf-next-25-11-26
> 
> Thanks.

The AI review tool found a few possible issue on this PR:

https://netdev-ai.bots.linux.dev/ai-review.html?id=fd5a6706-c2f8-4cf2-a220-0c01492fdb90

I'm still digging the report, but I think that at least first item
reported (possibly wrong ifidx used in nf_flow_offload_ipv6_hook() by
patch "netfilter: flowtable: consolidate xmit path") makes sense.

I *think* that at least for that specific point it would be better to
follow-up on net (as opposed to a v3 and possibly miss the cycle), but
could you please have a look at that report, too?

Thanks,

Paolo


