Return-Path: <netdev+bounces-193878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED1AC621B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C035B9E26FA
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 06:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97668244670;
	Wed, 28 May 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCvGy1Og"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2089242D95
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414350; cv=none; b=dUc68M/lFOiHyYhINnQJkGYedYjGW0aVdEKkTiUyxqoBephtILjwtLcPIZbZmC7CQI8Eqm2dntJNzjH3Rq27aB79B6otsi53WB0W9CieOf3IQ8oCLgs88+fsAJdPuSMVOROZ8J0l3HsuIBfeTXVByMw7SZZ2AXg1xxl1hOmwi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414350; c=relaxed/simple;
	bh=gKxZtM2RsybLrwR9NhsRR7K4MEQrNOopxm0Lakjpmyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3ffMh7CheWb2lifvXC1hncrG7cvrupdShXxffFXzI1SR22fGGE3mTdMwkBlTao5rvFqROigdHYwyrgXFp34DNsTERNMHJD0R9or0ZcxVPhLwfRDxspJNm9TRoitHiGKjrjO+E6cN5D8ZR4vop61KMH+T+nEfA4ARBXUm2WFjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCvGy1Og; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748414347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y83gWE54sjopf02gb9Jn0ZFbpZy+x6yg9HnmmuAIgsI=;
	b=aCvGy1Ogwkr09bGh+j2k9rUAreMvGjL+xWTJnJEKJxrXKxdV4wpyKCKK99vMCvSHyUimrb
	HVshMzVq6CPeoutK7GeR12IZRohoMC4Mlm56XoNfwNxiCMD0ft19VMsMxtfsA3CiPQ2cuv
	1JaUrI0o+eTn2jFaBG+81ii5f4GbKig=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-QWqWOPjbOYuML5KySQDeSQ-1; Wed, 28 May 2025 02:39:06 -0400
X-MC-Unique: QWqWOPjbOYuML5KySQDeSQ-1
X-Mimecast-MFC-AGG-ID: QWqWOPjbOYuML5KySQDeSQ_1748414345
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-440667e7f92so23384185e9.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 23:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748414344; x=1749019144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y83gWE54sjopf02gb9Jn0ZFbpZy+x6yg9HnmmuAIgsI=;
        b=YmbKffRBbZO9NiVrBxnTjcmNUpwcY02njIOKk/mzo58ABJWbslJ2hP/UYW8tDR3lE5
         YV4XKhzxzwOl2lezTdIxxODoXvygyQ7Y0oX/D/LZrK5buuOzGVSpDnzF48BV3D9ZczDm
         IovHd39dTqgEGXlqAp+AqXbEaTR8D0I6MiPVF8p86q644ZKNffezK/yirp/VIecBz+kg
         N+PkbKRBNlrJ8LD0g/DC8tSVlUyDJ3q8o/9IpDMnIzhK82AdK/rbmN9oNkDrWPrEMA2q
         oof2ctoWtSrprgrvU9rEFPVCkD60Uay6cEBCSFvdfkdazjj8AEd0bAlWoqDXY44+6XOj
         4+3g==
X-Forwarded-Encrypted: i=1; AJvYcCW4vs52aulTVycsgNKkERvzVufSDFtGbOplcOmXIzK+qg0kN4cZpByDMYejf7gQMoNAbp2jPks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtDDteLqw8FbqPfQFL5cRCt9Qz5KQRREsm1Hw7klMSQjWi4YO
	n54S3YWcDGT89JfD42Op21PPGS0g77If07FyT7gPPqGlx0+VQ5KGViYq+1QgYbqb2CodtXlylf7
	RrwIFpHV8npPQbGFsQoFPtSHvfz+S8XijD/hnJBRqQcmzwMp6+GzWHV9qoW1rQy7pwQ==
X-Gm-Gg: ASbGncvdI1GSHd1O4H2LMhj3bha1e8g+TCFkevw/NFuIOncr9AwINDqbGWkgFABQg71
	Ont8MW0QfWgo8S9gV+ukvZRUPAH2j2Okw2tuXPxDwxxXN3QScbXrjaWd8QVWgv9R2NYwNUN54N2
	sSkHDSIoynLB5IXBKmPnGcb9TIuA3fNg5rfToWMlB46+GsHxpnUGFQJzmVLBekvK8/4m67xELN/
	fF8xFubD9VpyYkyC2BwT4HHXBaS77Vbvx7lMKnx90RFtID+eMNh3o5cGWYg0mpFD/EhIBpoiQXd
	rvzCUSJsr9XYEt6DRj/PynKHscl3MZR7hNA8ShXh+51ngp2/tFq5CzeM9bU=
X-Received: by 2002:a05:600c:4e0a:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-44c91dd158bmr143267455e9.17.1748414344515;
        Tue, 27 May 2025 23:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFebeHfdnPr4dJOQZ9VixDBdJXpVXO2UovDVjBqg/ZlweZ9KcsOSm8oJeP85V+9uQtnHBZ4HA==
X-Received: by 2002:a05:600c:4e0a:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-44c91dd158bmr143267245e9.17.1748414344098;
        Tue, 27 May 2025 23:39:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4500e1d3db3sm10769035e9.27.2025.05.27.23.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 23:39:03 -0700 (PDT)
Message-ID: <4a7d32c2-1ea4-469f-bb7e-74c9ce21ab81@redhat.com>
Date: Wed, 28 May 2025 08:39:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: bonding: add bond_is_icmpv6_nd()
 helper
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250522085703.16475-1-tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250522085703.16475-1-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 10:57 AM, Tonghao Zhang wrote:
> Introduce ipv6 ns/nd checking helper, using skb_header_pointer()
> instead of pskb_network_may_pull() on tx path.
> 
> alb_determine_nd introduced from commit 0da8aa00bfcfe 

The patch does not apply cleanly. Please rebase and repost after the
merge window.

> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index e06f0d63b2c1..32d9fcca858c 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -29,6 +29,7 @@
>  #include <net/bond_options.h>
>  #include <net/ipv6.h>
>  #include <net/addrconf.h>
> +#include <net/ndisc.h>
>  
>  #define BOND_MAX_ARP_TARGETS	16
>  #define BOND_MAX_NS_TARGETS	BOND_MAX_ARP_TARGETS
> @@ -814,4 +815,22 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
>  	return NET_XMIT_DROP;
>  }
>  
> +static inline bool bond_is_icmpv6_nd(struct sk_buff *skb)
> +{
> +	struct {
> +		struct ipv6hdr ip6;
> +		struct icmp6hdr icmp6;
> +	} *combined, _combined;
> +
> +	combined = skb_header_pointer(skb, skb_mac_header_len(skb),
> +				      sizeof(_combined),
> +				      &_combined);
> +	if (combined && combined->ip6.nexthdr == NEXTHDR_ICMP &&
> +	    (combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
> +	     combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
> +		return true;
> +
> +	return false;
> +}

No need to put this helper in public headers, you could use
drivers/net/bonding/bonding_priv.h instead.

/P


