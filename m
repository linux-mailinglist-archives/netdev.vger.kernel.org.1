Return-Path: <netdev+bounces-194177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7CCAC7AFD
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C377B1271
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B8321C188;
	Thu, 29 May 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2EhOtIE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514A217F2E
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510767; cv=none; b=rwgMIPJ4HZ31Nfjtv58ja+I4m0Rw29XkvydtGeNn9+YvrqXmLHfYPjTtdEqSfxbw9g3mbDVluoQa87UAH5Nja6qWraaJUKrXrRtd1dh/dUgDpSIoTXMJv48tkevemAjXMl34qAa5Epn553vXUrX6WPQJxOAJmQ6d8bGJ51vV3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510767; c=relaxed/simple;
	bh=uQKT9Zt2p6vsNAcT/iTYI9MyAZhsyU46c0APGzmxB/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTPczhhyDRYA53h7tnOQg87bcwOeyrjGmPtXo+izMQTJ8ycrjjxNxGNpUNSj5Ux+yo/1TRNrvw43tvLha86yAjTkpLCvhY68d7ljSYWw/0Sdis2wUkOaTPYLjrvYisQpYQXTFZzOjEiqNB0L6c+C0WkpKgV0uOb/N5fslPBm6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2EhOtIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748510764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QtQ5kmfQFaVoCR5uxEg+A1GPgeyz3eUhLYTLdj+RYqQ=;
	b=O2EhOtIE5NVbcjctsgG9x+2tQ5FsEi3i5HXvat70GF2mBaBLLfzRQDdAhKvzhAMZ8BN2XV
	UAE1mRSp2LOMf6fM+F4AkGcSdORGEvn0pqQMO/dwQ43pnuxVt8ZbPRWitdn7ooXJV4astZ
	pT6TrfNJ9/2FBW/DfZLrRRqwAFtvmtE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-VVHhB_FUNkW1VPiIHz2A5A-1; Thu, 29 May 2025 05:26:02 -0400
X-MC-Unique: VVHhB_FUNkW1VPiIHz2A5A-1
X-Mimecast-MFC-AGG-ID: VVHhB_FUNkW1VPiIHz2A5A_1748510762
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso308377f8f.2
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 02:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748510762; x=1749115562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtQ5kmfQFaVoCR5uxEg+A1GPgeyz3eUhLYTLdj+RYqQ=;
        b=nB9Zi55LOHNVsUUPx1rohcrpVoZffJV6VJV31GlLP6JZcet1c3IthGPNuoM5GMdIwr
         ZeuFa5z6RdmjVTtRHiKfayiDiOrUBSL6ZdXLO4z3tSYuFo78q0CHNNnEzY8RKc3Hend7
         LxIS0ZHAtUcAFwnAAUR/yV6gV6Sgjim0CbQ2tjFTbnu0kVA6mhUifa8oO6r7qlYFROaP
         ntG5F1dve00C0bo5RYWupD3858r3OzKQFXX8WdZqXhb6EFfi5MDkOEjtp7NnrroKq2zy
         R5bggWXkQt/OotRCkr/V/q5Nk6QNzFp3Tyk8nw8NEPIwTyE+68R9bEEkwjBwb9YgEEoS
         /kBA==
X-Forwarded-Encrypted: i=1; AJvYcCWajnXLtdjeq8/2evq/ny2ajHtH4wH+/3DA9f0Zds+qF2SXBRHS5pUAa65yyYw2BXfd99w3CiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmYApKRrdlYaXleyxmngw0JlRWFsOtfAjqtY2aJe8ApMhr5aQ
	JQEqXa+yWUmo+4SfMzM4OdZOxYV6Npf6vgWPc9jIDqiGRwYaA4L3NwL5sRdyPr2Qnp8FUL/Xpz6
	qt9/0X8tJwHrmM5DkMc/o81AZgOy1+L4bbhr2bc7vr+GZXssq33kyHlZA+Q==
X-Gm-Gg: ASbGncsxlcshDMrymYZ0U8pYs2lzATfOv+i4R+yiiA6Rpg+QmHmh0oNCcBXSsonau5V
	l3IeYYFI97qdoX72f6Qy5MMZNTxQDIxkIrhf3aOyJuFwP15BuLiGFUIHsEAc4ipkZD1gSIt82wS
	IunRLVRG63S7m9+6ySrs7/PEwCtR3Rc/X42mm8hYSlpEAf+GA/ZJT/K74byEF5dCUzKw+Uz0YTX
	RDc5iGn4UA4bcI/JAngIyx5htS3bI2bDY5+cjOad6y0dAD7hA79aTPHKMch2MOAmacuWxQaxaXE
	5hIO2zhDnc+vP1I2eLAAsp79m5eXSheGGfXmsS+kFu01+iWmgUzDSr07zCg=
X-Received: by 2002:a5d:518d:0:b0:3a4:f2aa:2e32 with SMTP id ffacd0b85a97d-3a4f2aa2f27mr1031616f8f.44.1748510761671;
        Thu, 29 May 2025 02:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG30NBXV+biVnfIaSs44Y/SXM3AyBczxVTo9f/1k8Vx2q2U1bLuQhfXw7c8PML2Ex0Z2WPEkA==
X-Received: by 2002:a5d:518d:0:b0:3a4:f2aa:2e32 with SMTP id ffacd0b85a97d-3a4f2aa2f27mr1031601f8f.44.1748510761295;
        Thu, 29 May 2025 02:26:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b854sm1448296f8f.11.2025.05.29.02.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 02:26:00 -0700 (PDT)
Message-ID: <39ca5468-733b-49c4-a00d-27c2ab85b795@redhat.com>
Date: Thu, 29 May 2025 11:25:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] ovpn: properly deconfigure UDP-tunnel
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20250527134625.15216-1-antonio@openvpn.net>
 <20250527134625.15216-2-antonio@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250527134625.15216-2-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 3:46 PM, Antonio Quartulli wrote:
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index dde52b8050b8..9ffc4e0b1644 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2900,7 +2900,7 @@ void udp_destroy_sock(struct sock *sk)
>  			if (encap_destroy)
>  				encap_destroy(sk);
>  		}
> -		if (udp_test_bit(ENCAP_ENABLED, sk)) {
> +		if (udp_test_and_clear_bit(ENCAP_ENABLED, sk)) {

Nothing should use 'sk' after udp_destroy_sock(), no need to clear the
bit (same in ipv6 code)

>  			static_branch_dec(&udp_encap_needed_key);
>  			udp_tunnel_cleanup_gro(sk);
>  		}
> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index 2326548997d3..624b6afcf812 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -98,6 +98,28 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
>  }
>  EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
>  
> +void cleanup_udp_tunnel_sock(struct sock *sk)
> +{
> +	/* Re-enable multicast loopback */
> +	inet_set_bit(MC_LOOP, sk);
> +
> +	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
> +	inet_dec_convert_csum(sk);
> +
> +	udp_sk(sk)->encap_type = 0;
> +	udp_sk(sk)->encap_rcv = NULL;
> +	udp_sk(sk)->encap_err_rcv = NULL;
> +	udp_sk(sk)->encap_err_lookup = NULL;
> +	udp_sk(sk)->encap_destroy = NULL;
> +	udp_sk(sk)->gro_receive = NULL;
> +	udp_sk(sk)->gro_complete = NULL;
> +
> +	rcu_assign_sk_user_data(sk, NULL);
> +	udp_tunnel_encap_disable(sk);
> +	udp_tunnel_cleanup_gro(sk);
> +}
> +EXPORT_SYMBOL_GPL(cleanup_udp_tunnel_sock);

IMHO the above code should not land into a generic tunnel helper, as the
tunnel scope always correspond to the sk scope - except for openvpn.

Also IMHO no need to do udp_tunnel_encap_disable(), it will called as
needed at sk close() time. Yep, that means that the stack will have
transient additional overhead until the sock is not destroyed, but IMHO
it's not worthy the extra complexity (export symbol, additional stub,
more files touched...)

/P


