Return-Path: <netdev+bounces-226410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED8B9FE30
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1CA7BAAA8
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5F29D293;
	Thu, 25 Sep 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5LSZTpa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608FD28C014
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809414; cv=none; b=DkYQQd+Z5Syum22dXrqBp9xNVyXnbxvMzYIwp0VZdhndaSnTafUUgSXwEbkaJ0F1mmZ3ziaXj9BxCyTB1OQlOr0SBJUewmBSZp5xdocK6Rwy403aD4ki0skR87LbGlqOUfnYIcN/mVr7K/ESXrBkJ3KImzezdKzr8uqKMZFDVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809414; c=relaxed/simple;
	bh=88WQDb2uDDLB4TX8nppmkiPEB/5yg+bD+VP79AtmRTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WypYR2P9BC4xUssiznjoyfasac7QrHrmoQxZ77Var9RwZPXglBl+2pH9lE9mItDXdne9OAsez0OVP7Wz8EIUph3CohWWhr6sZpamNo81KsHFOM5FSjCf2AJ/r547HEED+Yyq78q8hlZIfvzXMYH9tfkNE9j4Hz0qmKMdXJOPWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5LSZTpa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758809411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqDJ105k9ytfsUpfCq/5nB+VbyvkiiU59Jhg+y8Z6hg=;
	b=H5LSZTpaQmvPKHjG2zDww9d1CkhclVv3UnEwmXyBQnqkG/467I0YSH39Sq12cIDSNUqYbg
	5o8xRAR+ID+GaBAqc8VWFngYhUNFZ3TQvf2zUIZs/AUBToThox0xamdm5pkYdteIRGoeiH
	Gz0v2nyiti74P4JfLl2n0tmLXPnyDRE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Zc5k5PvcOziQ5tnK6jnaLA-1; Thu, 25 Sep 2025 10:10:09 -0400
X-MC-Unique: Zc5k5PvcOziQ5tnK6jnaLA-1
X-Mimecast-MFC-AGG-ID: Zc5k5PvcOziQ5tnK6jnaLA_1758809408
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee888281c3so830650f8f.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809408; x=1759414208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqDJ105k9ytfsUpfCq/5nB+VbyvkiiU59Jhg+y8Z6hg=;
        b=fJH27Z7QJeJakX4z2p8latHM5SeHm0u1H0jKAUHrWf8te9/8COczsyGrZUbIkx8rxv
         z4u/75PXi683rscPQQPanEqp/5Xg7UwnJy5cdG9zT31wJR+YW5dbxpvrnX1+lyIaD5oO
         ONMQ5nb5n/0h6vHE24xigwZI4r22wDst6X8NLJwaJxaiHQfdkkNvaygNELhMtmXrzesM
         An1hhnLZw6Z0iL+yAfrGotnZJstq18g2btPFx/2f7S1cxvAcrsAeZiTich1oRH5pWN01
         h/EPMWGxaacB6T4e9eQebP/Ipqez7VasPhOwuWrUeCptMFfXB5i2aIned3MHwecEkvKE
         G+Fg==
X-Gm-Message-State: AOJu0Yy3Ul8jgQHykgrDWNp6HtR1fesimdPtvGcP897J+kD4Begcn7un
	VK2is9HtM1DvgYV5sTHvNTh8Qwy7UqsNBCfsxLuvX+QhHMvOYZDjPdfy8/CeOQ7TLeBXnWxWaGb
	d/8D+KEeOfjQyf6Fv8uvCUeYNi0skx96q5Jb84ON1o7rP6Sv1lUaVKfS7UkW8w9EagQ==
X-Gm-Gg: ASbGncs29EwcR60WEkktEqUomQUgal56Ay52ZkvPN2klyqz4EJYpOA5slLAGDgGgQ1B
	I9W2z66LYDmsg3jpEbGb7m0o2p23PhP0CU4BNbxbFkaENZV+H7lZjwBBYLiHniPGit2EW/kzRoJ
	RvGucd9nph8RdWhudsfDUiV7TfdW12GdMsChDp/jBSk48h7Y52PICDysRf+MyVqLUNd7Du8eM6f
	1rp587ZRpXCx+w/YLRXlZ5b+WyijcRzL1x6SSQST0fILJaGj9OtdFC4KefRL0cGFv81SMeprWy7
	Uwqjtdut2jO8Ki4sRgQeet+uNLwVFxWSVn8NUWj7MLz8s/I2Wlvh1uycgrz7/6dP3TdHX0/ihmv
	D76HUV3vNhKZr
X-Received: by 2002:a05:6000:40cb:b0:3ec:e277:288c with SMTP id ffacd0b85a97d-40e4b850cbamr3657582f8f.31.1758809408029;
        Thu, 25 Sep 2025 07:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxQnSf/wmNw9QVSRuO+fc/7H0gFOf6L520OLVpKLvQdp1rL/LDYdNZmqCjtxNvnww/CfwyEg==
X-Received: by 2002:a05:6000:40cb:b0:3ec:e277:288c with SMTP id ffacd0b85a97d-40e4b850cbamr3657535f8f.31.1758809407486;
        Thu, 25 Sep 2025 07:10:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9c32734sm3308186f8f.25.2025.09.25.07.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:10:06 -0700 (PDT)
Message-ID: <cab41522-7f92-4354-984e-2eddaf921698@redhat.com>
Date: Thu, 25 Sep 2025 16:10:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/17] udp: Validate UDP length in
 udp_gro_receive
To: Maxim Mikityanskiy <maxtram95@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tcpdump-workers@lists.tcpdump.org,
 Guy Harris <gharris@sonic.net>, Michael Richardson <mcr@sandelman.ca>,
 Denis Ovsienko <denis@ovsienko.info>, Xin Long <lucien.xin@gmail.com>,
 Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
 <20250923134742.1399800-15-maxtram95@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250923134742.1399800-15-maxtram95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 3:47 PM, Maxim Mikityanskiy wrote:
> From: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> From: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> In the previous commit we started using uh->len = 0 as a marker of a GRO
> packet bigger than 65536 bytes. To prevent abuse by maliciously crafted
> packets, check the length in the UDP header in udp_gro_receive. Note
> that a similar check is present in udp_gro_receive_segment, but not in
> the UDP socket gro_receive flow.
> 
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> ---
>  net/ipv4/udp_offload.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 1e7ed7718d7b..fd86f76fda2c 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -788,6 +788,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  	struct sk_buff *p;
>  	struct udphdr *uh2;
>  	unsigned int off = skb_gro_offset(skb);
> +	unsigned int ulen;
>  	int flush = 1;
>  
>  	/* We can do L4 aggregation only if the packet can't land in a tunnel
> @@ -820,6 +821,10 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  	     !NAPI_GRO_CB(skb)->csum_valid))
>  		goto out;
>  
> +	ulen = ntohs(uh->len);
> +	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb))
> +		goto out;

Possibly consolidate both checks in single, earlier one?

/P


