Return-Path: <netdev+bounces-200366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC4AE4AB9
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EC217D691
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B695299A87;
	Mon, 23 Jun 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="ngdv2pGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921D28ECDE
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695495; cv=none; b=oWZryVV9Tg18YJa6uGvbvjHsvI8pNATuSjP83tqKyiKt4ZQTAgfBV0nvdJjQLeAcEd1PRyO7TeOPYzLLHwLFeIfc3S1sYw7T3coL35IV8Uqtt/bHWC3qOM4aVUe0EAR1qvZVIDq4mYYjQlaMHJXj0DCN3AGIFMZOf89gDTlU3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695495; c=relaxed/simple;
	bh=xOMzG1FX23M3d31kPYpV8HaBnyVBn7S3wyyV5oXXlCc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k93/u7aaYyMDLq9aZQdCS8Ji7VZbwlS2cmTyucdYcLEaUHvosonyfGOL84CVlyony3nzR9BnNU7rcr3tqjeRWiWgNWgyt0IamcVfDhtpI3zkL8FAL7lns0z/XBKijMw0ZD+e32zaoyGqhQpyd3MLMoVJNYkT6U7hCwAEvAHOToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=ngdv2pGr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607ea238c37so8672575a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750695492; x=1751300292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=08GIWol905Tz9t1Y5KR/Px/0Bj/EghmvZQXSpfLZ3xo=;
        b=ngdv2pGrB8cTttQJIM6zP5bclIG3e+4z/WrmyJaL8sOru4Byd31dZYi6WJV5iiECSE
         10ffemdd55gvB2Db8lk10NtSKNUz6KoKgXAi6ugjpjRlyKgFJao+Y0qnrZqZ0nXnOJLu
         YX/Edm5+C4hwP1V20M/KE+E+Jm0UKHqa3D4hnWT6zaMIMECo1kJT8InHsTFRheK8ZvGN
         gYKcWIY4lCWbAKKS4DY3KjpjwT7C4s6En/1aGg4bJkxh5QpjCR1yc4m8cx/QU4JtjeTs
         umm8rIgAPOVzp06UBBBONjOb67cgu5W1ani1oN7oRfBfbYTYnV9Rx9vTbf7ujHTmQYVT
         sVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695492; x=1751300292;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08GIWol905Tz9t1Y5KR/Px/0Bj/EghmvZQXSpfLZ3xo=;
        b=pcLQnn/hYXY7bVOE1nUfc0qkzyVVk+ze5vFcdJlfAFZWDdnrSNdpnaIM+MdXJQuRn8
         2o+kVUARaSb/paoKvgWvzDGSNYiyFFsqWeavPhUKoQG594KrAW8fsTCdrMCJzPKZ7l+P
         o0pIj65WcWeG3/gZBP7fzikxl7+gc5oeMsWvLdIT47l81tFlO3fL59VlexrWBFsM2Nl6
         Vs0MBlhgYMF2Qz4cL3lu2xVGTsOP+62N6NtB3DUFSRMuFCHoMIj63uPA5x8VgWwfrRCU
         rt7wuoNzwcO6TXLCtlt9qXHrDMAXtJlhQNHO8wAd22PR9u4yEVfUQv/ar+9uRY0Kn3e7
         P5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUztOqs1xf9um1pwPTbFj0VShowZAF4+xM3lbN6zu3iKEI90PjNnyWovhl6K8P5FitLeI7qANY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuGluUuyTj/BtS/rOH4k6+U/zwQ512RUUB9a8PMRXvXS3yz3hU
	uV8Eebl0FAfiqs82fWVz/D1O2yM0HUHTz0KaIukap5jL1ue+FpHLhbVtHOgUuX5ZPg==
X-Gm-Gg: ASbGncu6e7qk1qbbbAH+CV+5NLkog4ukwf8CpaINLDm0wn1OW+ahbJtGbDnDqBGg0UF
	p3hxl3x3Tq4CL1zo9vPg/ZqbE7Gc2vbT0cfc56hnff5+qjyKsJQVW7sL6z4k5CU1xz7iwThRfaL
	UpFFLb8j9wP5dbzAtJxkOvbNBRZ28/l5slw4fo4bAxGqlQ2fLBXjV9rchJkrytRWKs+kFQo3WTt
	CTOuSYw1YBinFd1pKa4crfksHqfB4GXl0jG5si6C0R8X+Ax/Mk1dhJvEPYAgOXP4ITeijtmDibu
	oKw2sHUONgf0F/IYBTNlJQeI1Y5Iq06JC5wU4jrN1xrN0Y6ntlAyPiHsseK8jUPA
X-Google-Smtp-Source: AGHT+IGKSt1ZPvM2yYVioJCPzIyELNHZzrEHQ6g9+s79wuGsECQkKe80vWV6dvdNE+yByyUw8mwsHg==
X-Received: by 2002:a17:907:7250:b0:ad8:8e56:3c5c with SMTP id a640c23a62f3a-ae0578f3e81mr1200596566b.11.1750695491746;
        Mon, 23 Jun 2025 09:18:11 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209ad2sm741886666b.148.2025.06.23.09.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 09:18:11 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <8538df94-8ce3-422d-a360-dd917c7e153a@jacekk.info>
Date: Mon, 23 Jun 2025 18:18:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vlad URSU <vlad@ursu.me>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
 <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>
Content-Language: en-US
In-Reply-To: <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Vlad,

could you verify that the following patch works for you?

> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
> index 8294a7c4f122..01696eb8dace 100644
> --- a/drivers/net/ethernet/intel/e1000e/defines.h
> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
> @@ -637,6 +637,7 @@
>  
>  /* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
>  #define NVM_SUM                    0xBABA
> +#define NVM_SUM_FACTORY_DEFAULT    0xFFFF
>  
>  /* PBA (printed board assembly) number words */
>  #define NVM_PBA_OFFSET_0           8
> diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
> index e609f4df86f4..37cbf9236d84 100644
> --- a/drivers/net/ethernet/intel/e1000e/nvm.c
> +++ b/drivers/net/ethernet/intel/e1000e/nvm.c
> @@ -558,6 +558,11 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
>  		checksum += nvm_data;
>  	}
>  
> +	if (hw->mac.type == e1000_pch_tgp && checksum == (u16)NVM_SUM_FACTORY_DEFAULT) {
> +		e_dbg("Factory-default NVM Checksum on TGP platform - ignoring\n");
> +		return 0;
> +	}
> +
>  	if (checksum != (u16)NVM_SUM) {
>  		e_dbg("NVM Checksum Invalid\n");
>  		return -E1000_ERR_NVM;

-- 
Best regards,
  Jacek Kowalski

