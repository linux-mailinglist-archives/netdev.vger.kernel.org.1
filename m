Return-Path: <netdev+bounces-203400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62134AF5C73
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90578481B27
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7A2D375D;
	Wed,  2 Jul 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="hgj7CF5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FCF2D3759
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469287; cv=none; b=J/UaelI/BF+eU2oIdX10iCK/ITWvQqgOcIRfONBShmermgaHHG9tg+QkE7WPknQSbt07+WHkbwI7KDLq/u8Qkcf9RNiV7WW9NTcaHP3yZjDBlKSihfDCtk/Qbp8iMP8QyVnlBFL7KPCakqi0Ee6qqLV185NjdaS0tK0XI4ppRUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469287; c=relaxed/simple;
	bh=yaVBx55pkpJNbZV76DxOYDdkdg83DTB4UJfRN30uAUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE5xQc1aejsIMs0KL89poq3sSxlfz2vcAmk28mgycwLN+yYvAQvbVopYhqOESxfBVtouDeBscs0TidS3RBSSapVKOlY7uTVmlyq/5Qwl4JdoveX1UsmcK9L/5zO6/9dfTSa/6aSneI27i/dxEq2MV/hgmnbX0k7abkcphGv1biw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=hgj7CF5X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45306976410so2830095e9.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751469284; x=1752074084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UEoVGeWwa967fvIBUVo89T5bXVjlB0iBy8jqhf/tJrs=;
        b=hgj7CF5XM/KkjRz2zeqbsKGjecfDV6rgAUAqvMUjJnQQ+Ik20mq+aMIMnhmeF9ynPv
         hqk76fVLs8p8tzlUIz0j0x0V9jpFxxjtNAgs7mxVfhlJfHZWmh2q39ZX7DjZlB1QtvfQ
         UJSioHVgOc9HvQngqscbJPXWrX0YH/nDJ176Xo67USXuuh9HStoiusVBrd5b8UoJwHku
         8Vvw0xXYvUVgO+xPQYxPfqB2TeeqxVS74IVo/CnQpliuTsRvGQ/QrMNaWNampRPB7jhQ
         dVU6kP9eegKJF+iGo91AyWJ4nV5Y3IoyIzHZ46K5WHkpGiib3+HmVx/TzPjSPQVizJ6D
         iYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751469284; x=1752074084;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEoVGeWwa967fvIBUVo89T5bXVjlB0iBy8jqhf/tJrs=;
        b=Q91ydyFzsh1YHhuxFtixvmivECkrEy0MzFTLQcqUMksTAVF9YLPji0vebKKbIWopRz
         rHX2Z5TC3o6+6FFE+HxBxO9QtibJfcerJC2TTT1eonmWRMLNKP+4aeljo6oGWHMZRGBa
         LqcV1mkpGB653S2qv5ma2WcwkeZfOdQ8Sw6QfCCygvXFqr2+O/3TRFtuJkpZrhKatoUN
         iMdAmwXUsOkv9EpaenLXhCGqhzQB5WVe4B8vjKwhn+Mv6z98TZS3hxf3h6Pj+istdaeg
         NDWsIlwUiF1u34YC2sGXKOd7s3rhj5XfOQlfGA4Wj39P9iI8YB9hL3hvDAb+OWqQLrdD
         yuhw==
X-Forwarded-Encrypted: i=1; AJvYcCUN2gW9zGVHIPr8IbmpUrz5WLBWQ/CybUK7xBrHiiExA2FInMDduVELlYq/0SaBN6XI7kNrrYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16iawmgVd4hItMJxlFVUUvk23UhHqI1aMaswJDTjKKJGn2jcP
	p5hRoCoU+ahWabEjFGzmA8vqdD3S+zhnNsRsDHNse0K2lWrBrm/na0TeaHV/poWyt/I=
X-Gm-Gg: ASbGncsUE4s7BtiM5IgbbPZCTAzn79d9KJ6wArdlS/RjG1ycXSc6oO9pMxnWS9rTlO9
	qfD6gsdmkOgr4Ne0MrD6CIyMUfZb8Slz2VOkOm25RG8sgp4Ob4wBa88ZmE2sgROAPP5+G4qMBbp
	EX1rBKD/5ENodsPy9k+1K0NMeUE6kzigstKXKIwQkZtDNmdhu6GXqv0BeqKoW8CwhPRFedcHHJa
	3gHHJthGyuQlU3Wi6SCIaXMpnfC2m5jzz8Q3IoAjbSBOcTowxj1hIEsfbEsGqqLiodSTpbPHXqE
	3JCgC8bJ87uL+VBHgZLQq9jGHILonP8cKjQU1bt3ufDRyojNeklAZ3TkLrA3PalKd6wJQspNApc
	kxkd6/iTqJuETcVToKufsEqvoFnINhsDWr3GVrak+fe/18327oA==
X-Google-Smtp-Source: AGHT+IFuleqdyS0khXY7Uz8FGznztsWK0eHC3JXALUeyVBqdO7v0cvafSoEuAYV4iYOGyHxNKvOhVQ==
X-Received: by 2002:a05:600c:8685:b0:442:fff5:5185 with SMTP id 5b1f17b1804b1-454a4ebf6e5mr7212645e9.6.1751469284075;
        Wed, 02 Jul 2025 08:14:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:5568:c43d:79bc:c2ec? ([2a01:e0a:b41:c160:5568:c43d:79bc:c2ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e78e8sm16736852f8f.19.2025.07.02.08.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 08:14:43 -0700 (PDT)
Message-ID: <7c47cfb6-c1f1-42a1-8137-37f8f03fa970@6wind.com>
Date: Wed, 2 Jul 2025 17:14:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: Jakub Kicinski <kuba@kernel.org>, Gabriel Goller <g.goller@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702074619.139031-1-g.goller@proxmox.com>
 <20250702073458.3294b431@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250702073458.3294b431@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 02/07/2025 à 16:34, Jakub Kicinski a écrit :
> On Wed,  2 Jul 2025 09:46:18 +0200 Gabriel Goller wrote:
>> It is currently impossible to enable ipv6 forwarding on a per-interface
>> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
>> enable it on all interfaces and disable it on the other interfaces using
>> a netfilter rule. This is especially cumbersome if you have lots of
>> interface and only want to enable forwarding on a few. According to the
>> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
>> for all interfaces, while the interface-specific
>> `net.ipv6.conf.<interface>.forwarding` configures the interface
>> Host/Router configuration.
>>
>> Introduce a new sysctl flag `force_forwarding`, which can be set on every
>> interface. The ip6_forwarding function will then check if the global
>> forwarding flag OR the force_forwarding flag is active and forward the
>> packet.
> 
> Should we invert the polarity? It appears that the condition below only
> let's this setting _disable_ forwarding. IMO calling it "force" suggests
> to the user that it will force it to be enabled.
Not sure to follow you. When force_forwarding is set to 1 the forwarding is
always enabled.

sysctl | all.forwarding | iface.force_forwarding | packet processing from iface
       |      0         |           0            |        no forward
       |      0         |           1            |         forward
       |      1         |           0            |         forward
       |      1         |           1            |         forward

> 
> Nicolas, how do you feel about asking for a selftest here? 
> The functionality is fairly trivial from datapath PoV, but feels odd 
> to merge uAPI these days without a selftest..
No problem, let's do it right.

