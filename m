Return-Path: <netdev+bounces-209749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FFDB10B33
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3421CE383E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E025DB0F;
	Thu, 24 Jul 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8WRy26c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E34400
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363100; cv=none; b=bPJ+5DAHz/cY5BWu93bfIkAU8eHISGRaBq6tuH+RdTDOopymb/qRlFrDAyEnKAlXXLSo+NyRZb/vNq9PlpjzQBpepr5Vs4tPXY3rHIcmVnHI16Hz35W+VrLSop8cg0pJvQjbkUDMe4OCc/qNgIgCXp0qynCxzX1hvDktrftcc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363100; c=relaxed/simple;
	bh=p9PHuysKHYE6gQcvpNhmKjw80H/IMtWHDDZ2b1PZcrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfVvD3fUBL1bIGpVn8cl1CIfmns7LNAk3wbIH9N+01GkZyoM8XS4okKju1fwXW5enRNgb1jj8XYWDYqgt9Q4fZ40uYyRv08HR/Jy3rT540tdde0sP49w5o2GnO72tn4GTjJVdZ4oph2FIdNR+fN4PCTh+Be6pedoTtBtaTqwRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8WRy26c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753363097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Zir853Q+AH9rM27mpaK9jLPnB6hCNvFvh3scpEE9oI=;
	b=M8WRy26cYRu63ZGz5MOvtUXy6YdILsDiv5l6Iew2iwjePoHT53T6lMozOSSD0nBGprK0SL
	OmI/F4ZDnslv6Zs8At9i7ptvdJAsGwMMxYpx8UCOLXE0xROS6qlz/w/uhVJmCzWrrDVxuZ
	QWdRkRUZ7Oli48tTGsVMeHs4eUC0iFo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-j6IwuAv5OqqnPg9HOfYJ0Q-1; Thu, 24 Jul 2025 09:18:15 -0400
X-MC-Unique: j6IwuAv5OqqnPg9HOfYJ0Q-1
X-Mimecast-MFC-AGG-ID: j6IwuAv5OqqnPg9HOfYJ0Q_1753363095
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d30992bcso7038635e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 06:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363094; x=1753967894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zir853Q+AH9rM27mpaK9jLPnB6hCNvFvh3scpEE9oI=;
        b=EoniQN/GXUlIZndJ8Zf/omrqpXiXvEWgLvtEyeMJ2kVe6au6vFZhdUU1al4aXLUhT0
         b12fzqpcEwqBbY1gS2Q3mGo6CHv4lcLLC5RtiPU0mpkXRSK2gB2EfcPvBRSkzHq3YNUa
         mFGj0Mg5MoCyMjsTS/plSkBFHuW2PY4pUUYNUaOORc6Ff1wB3OdI1xKEU+liP5wBT11Q
         hqdBV2xPT8H4tEYCGaKXPlnBBYritKnkoOF0Bup96eexEDR7/2a2gqMHMokJAeaKn0fO
         OuDQXP+umY0/HSwzAizHEE2z0Trei69ClxhzUC5YFRFqnqAxACpQGQvtstR7tL4i7ZC3
         xwuA==
X-Forwarded-Encrypted: i=1; AJvYcCXg/pu3pCVAq3CiP34duiqMDvl6ZvMDmRr1XiGsuL+Dccmhc4bXJVhH4+tlmlFcrpJyYYLnOCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLZ18Qv/0yqpKnwtOGZqty+dPRKxYi+QOjG1aH4O4x2e9Kgbm
	dblGMut4hldhDrgLp8jC/fMoPgTROjntcmhvzwg8duHbiriTVlcU8ik6TmLoJgrlFWMFAB7KEGD
	Ap3FGq/hYom9lurLPlvIEqF+eo6IjbdJNYOU8KbbR3MvfFpl4WPF7wtPLDA==
X-Gm-Gg: ASbGncuJQXVZQmEY76QbZKbW6OoyIaCSjEB09pHHXpm0ylpq7jOL+UZmi1yT6iBp1Pc
	MdEK5A0zsIH36dfbLUvoiE9kHObH0xYB+XTx155a3wCSH/dxxgCJtlYBVuUzxr6arxB5C0U0jS2
	rGsh0Jw78ujLH74viK1PqThY/dHoD0E3bd7+2zxmHAe5whHmS3qmX6q/RXY+7jS4NnXWAJGey7w
	kAAJniLBD3Sy3g4jslZZsprOci9wS313tGitiaig/MZuEPtgNuplaOHnJT/YGs8l4ZEvmTTYeX9
	QPFYFjsMwANqcNnGRC52yeYKma3WrVwMdvuajmLTHugH0qJyBAv2Gf9qVLyT2cfy/W6pBllSxcy
	ogAoPf0GEiSU=
X-Received: by 2002:a05:600c:1d22:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-45872668487mr1039835e9.30.1753363094506;
        Thu, 24 Jul 2025 06:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaiFpjr0YIfdZU52GqGnXaqUm6ZUahQ0zDXkRYrovz+WCQayV0LuXZ73IZP10xmofeJYgTaA==
X-Received: by 2002:a05:600c:1d22:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-45872668487mr1039445e9.30.1753363094010;
        Thu, 24 Jul 2025 06:18:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bcbe8sm21647345e9.17.2025.07.24.06.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 06:18:13 -0700 (PDT)
Message-ID: <2e49ee3e-bd77-410b-b367-d16e688d8a40@redhat.com>
Date: Thu, 24 Jul 2025 15:18:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] xfrm: hold device only for the asynchronous
 decryption
To: Steffen Klassert <steffen.klassert@secunet.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
References: <20250723080402.3439619-1-steffen.klassert@secunet.com>
 <20250723080402.3439619-2-steffen.klassert@secunet.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250723080402.3439619-2-steffen.klassert@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 10:03 AM, Steffen Klassert wrote:
> @@ -649,18 +650,18 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  		XFRM_SKB_CB(skb)->seq.input.low = seq;
>  		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
>  
> -		dev_hold(skb->dev);
> -
> -		if (crypto_done)
> +		if (crypto_done) {
>  			nexthdr = x->type_offload->input_tail(x, skb);
> -		else
> +		} else {
> +			dev_hold(skb->dev);

Side note for a possible follow-up: plain dev_hold()/dev_put() usage
should be replaced by the tracker-enabled variant
(netdev_hold()/netdev_put())

/P


