Return-Path: <netdev+bounces-120080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0D69583A6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BB61C241FA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF87718CBE6;
	Tue, 20 Aug 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WktwnWSl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0FA18C935
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148490; cv=none; b=Lf1Gts0xKhBp8lzQOcFYd0raL/UdNAKsWCIcTYNFiQxcYWnGs6KhJrI20KX5HvqVaI+Vd1mN+lNzBUIFiPsgkBJdloGO9DwcT2V3153uVPGi7aGV/4p7xI5p5ym/AA0FdUx5DsEna6UBeUEgXl1Z6U1/TpD6UxhzVOOLdAj4F4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148490; c=relaxed/simple;
	bh=xUNoB3mnoowLOxfgP9COqnZISq2/PEpJliW8VCfKfAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyBAf91ThHGuDtwBjPh0zXLX6y4rwb9nlxNgZr0BvJtCS1T9HXoDUrwYR1crjTHXsTdzUizM9hnF2pFHyWW+PC6dwBXK4VyY5V4BVUXJCZrx3weHE5Wnd6C0kmkCzEk8jjy1ZXRwxkSshOFdpvNCcP3uYqcG5p2IKuNzjd8JEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WktwnWSl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724148487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kg6MBJLuAz1F5H33Agwi+o2BMA7KI9dO6oIsDSYPZds=;
	b=WktwnWSlfsBHUK3qB1pwPu8I/EiiWy1oZfaQZpC73GqNlaUyquV87qJDc1omdkIC7m0Pgt
	82Pwqb6Fdm/TESYVbYj85nhAlyAaZHA+cLUm74P++gUHdhxWpt9yvCqoo05OhnFNg4vCuT
	9g8UZISO1gCUumPLEiq11tfrEkVsJvc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-4gIFgDULPSGe_ZWNkE_XYg-1; Tue, 20 Aug 2024 06:08:06 -0400
X-MC-Unique: 4gIFgDULPSGe_ZWNkE_XYg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428086c2187so9991915e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 03:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148485; x=1724753285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kg6MBJLuAz1F5H33Agwi+o2BMA7KI9dO6oIsDSYPZds=;
        b=QAIJNQy+viGkOyyfCNDHrFDR7OfJXBvuxydl/AwKGvJT5uv64OSuAvHKGiKbl3D5j8
         d9Do6oDo8v3KD3e59uyPlv2Gve7JnVfHowgB7HUTd3hJbo5tkOWQkTKOOx28piuFgy2I
         gbLlsrJEN52GuPrez9yD8pgxPN/yLjV+57VylXWF6F321YHq15WL4g+BHGQLJrRAlyJv
         UFopMkh9DU9o9bSlyupVZ3EpB/4embMdljpflVUr7lv8eGO7DW6PpI5c5so1x62PLXdJ
         Nq3uSDmU1A1IiYIcELqaB5AKgRT8PKacSr9zZ5GrLbYECDpm8/pXUNAzWhRG3GhkCr0x
         UyIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSyuPEqCYRGr8pucc48+eLCF/5u8uEdDPlSQOoAtekb+eUznQkdSXC8xGwcd9oM6nfSStGN00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3PQXOyvix+42EBUeip24U+D1yg2y9cXH/gIorzzPRyzAgMey
	trTm2rQvNU//TheQm8fvY9PifMTP9z+283ULxDL1pa/ebfcBk1qtbL8J6l53O0/S/OKWcb71eCV
	KX6zZ2IWvtGRDhHgcg9gn6DCeTPxIltKFFUgKlwAdAd7459lskF8VUg==
X-Received: by 2002:a5d:5888:0:b0:368:4c5:b69 with SMTP id ffacd0b85a97d-371946cb74fmr4807593f8f.10.1724148485256;
        Tue, 20 Aug 2024 03:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxNLeZFO1Uv/pPE3b9y321MUVwgdiGoYWbFgv6tEkAM4vtfLJhOrQdUw8dyfK8ViRkHxbB8g==
X-Received: by 2002:a5d:5888:0:b0:368:4c5:b69 with SMTP id ffacd0b85a97d-371946cb74fmr4807580f8f.10.1724148484763;
        Tue, 20 Aug 2024 03:08:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a6ddsm12723699f8f.58.2024.08.20.03.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 03:08:04 -0700 (PDT)
Message-ID: <9bd573ff-af83-4f93-a591-aab541d9faac@redhat.com>
Date: Tue, 20 Aug 2024 12:08:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
To: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815022014.55275-1-Tristram.Ha@microchip.com>
 <20240815022014.55275-3-Tristram.Ha@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240815022014.55275-3-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 04:20, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8895/KSZ8864 is a switch family between KSZ8863/73 and KSZ8795, so it
> shares some registers and functions in those switches already
> implemented in the KSZ DSA driver.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

I usually wait for an explicit ack from the DSA crew on this kind of 
patches, but this one and it really looks really unlikely to indroduce 
any regression for the already supported chips and it's lingering since 
a bit, so I'm applying it now.

Thanks,

Paolo


