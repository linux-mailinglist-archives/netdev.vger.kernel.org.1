Return-Path: <netdev+bounces-245496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97ABCCF192
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB88230138D1
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6B2ED84A;
	Fri, 19 Dec 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4jOVjbE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6XSYBI1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923F2D1916
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135879; cv=none; b=LS90ucmKWa90E/ygKV+X8pDpovw5SC8/s40JhVM6xdCAEvno37euvxtgeQxgWgRqdJV/WPMTKmHtFvIgTesJGyIZN9FXTA2x2fY+0wHSp536urh1WWj4cuSF9ZxS5fvE0Bf2XLH2x/j4X8yU1Cq2Auulqf8u1SeOqIGfAZolziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135879; c=relaxed/simple;
	bh=wUk1tnZgbnjZ3ZMP1xsK51Ay5IftVX7qgDTDsIHncc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5B/23VxbzgZpz9fecWj18MF2EdBWFpZANYepi620EvOpev9ZaXM2PgnjvkPPluR4OmR1X1qa8Pdinhjps9MQKS29knCljVtgDhaLM4I/1ka2BhX7gIWkose6GGOK/bPlCJGtvKdXzvMQoV4hLAr3dYKOt14rZSzWrOsM26jowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4jOVjbE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6XSYBI1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766135877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOrqOC5iQbPsgw0GDAF8bS1t4BrrEVQdYEt9Qz67A0o=;
	b=g4jOVjbEmK9XEuspXciVHvTff7vW18gG4zsAK6UmVadgZkJvfTEeinxOs/EkCVs2UQ8u2O
	qJ7rnSB08Vw2ZSw9njkajDPiU/7lrmPrh0gjy5unukPfun5qXWlZlExZkFfkS+RgXQuVVV
	UyYmfAFtGZcE9do6PHZiPI5NlkOjSjg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-HCN_WXbxN3Wb_3c4PLJPpg-1; Fri, 19 Dec 2025 04:17:55 -0500
X-MC-Unique: HCN_WXbxN3Wb_3c4PLJPpg-1
X-Mimecast-MFC-AGG-ID: HCN_WXbxN3Wb_3c4PLJPpg_1766135875
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fcf10280so997097f8f.0
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 01:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766135874; x=1766740674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOrqOC5iQbPsgw0GDAF8bS1t4BrrEVQdYEt9Qz67A0o=;
        b=K6XSYBI1xJeLbP9hmT/P7VCyC7FoY8satWHDNxj4R8J/dkh1XgOrEgb5wDZnAEzOgW
         dOBYaM1olidh1BmSL4N4wO0eCLVzjEyOTuTS455W5gS+kDfzjrIEMQBIblHbBksFewE6
         SMFK9C4avdILX3ZUyTAK9FaMRffdNC25KOtjSX1DZomCa9PlLuIGgcaqjOL/lqk4FMdL
         TG/9W4FO5EpnCDd9KNihvc3ujCqk8Sz/So93Fvm9vF9doYhEwgXduqdsAOzIHsDDeMA/
         5y5+e6fn3vZUaQy6UGlxX3gxbburK/iFgNdI50QIM+V+drm0p/4PUMxxEioRaAl4VJjF
         qgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766135874; x=1766740674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOrqOC5iQbPsgw0GDAF8bS1t4BrrEVQdYEt9Qz67A0o=;
        b=wHDWfLbxO8mF+sPzjwFgP8NxaDkiM/fRr/+pg+SYxn6yqYiNFxIa+saKIY/NoaDRft
         DPy8HmX75c9tUtbowWGpgwquqL/O1GeXMIFolabLPlhYdYOy0xcS2JEs5A98KpJZPjir
         5BexqETirbLtIoRwp+e9uYnMkhoQjPEKhXs7BsP5y8msfgA3s6ERNS2Ceb/Av+zKEcXI
         k/OYBuasVvYb5xy8O4VgM+4KIXjRrJwvs7HAoJ1kF9H6ibHh+s59PEd0MDbgZzL+3Tt3
         tUG91rQcnUJoH/v+lsnpD3YvU7fzNnBi91Xp9tkIvbsQNSE/xpD5hwTXP7HjEevLwhMf
         B0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeboAbT9EXhNP+5FruIe78y9/vVk45+WqMx6xCnVq2pM4N+DJ6pz38Qw6zB4i6BD/AupaL+vY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6p1duugMv3C42zylt51yQyx9J2qEYwDdIGnyWFh+TNgeTj2qs
	0DCwug5Yg3M4Op12GnY7SkVVuIyJRRFkvetSgIdwv4eADuN9ZsOTn24nZTZ6ewPnd28F+SPCab8
	BkCCYJLwSFymG/rrNAOVftNwceHXf4acfPl5sONqnjfc9k40zxofPfWBp/Q==
X-Gm-Gg: AY/fxX6UwsiZ32+creS/9HISF2Oh6xoh98rex4836fUBEkd375WchgRtpaNo0sh8jHA
	WdBIB31RTL8R+BQoDf4MwyfuwUcGmVOzkbJZu7UA0Eq/QUILafr4Oxf5ZCFFkXERor88BU+lJvl
	WVPWpFDpPMPGbQCaBeVX+st+jCnsOrIf5d+ye9fhAqj2QFNK9WXpPLX13pNv0yPTm1zMHwBQhDP
	LCavwIVDvLemsT/hznPQ0ipPKkzl+OoTQ6HaJs4nRXOhpXZa74Vp46NEPodGoYt+g3/WZOoBLi6
	M2WwPV3M9USWG0wI+gmEIZHzK56bp0GvEv/WR6we4Sx6YTY8zckc2+DRSugkprgmZJpRCcZ2t0B
	lr4LtQcMsNwgH
X-Received: by 2002:a05:6000:178c:b0:431:104:6daf with SMTP id ffacd0b85a97d-4324e709ab3mr2628691f8f.54.1766135874633;
        Fri, 19 Dec 2025 01:17:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgrjQPRHArCAjoq010AgJgcm4Stpg3HSOJLPvFxNuWXO0HKkDXVAQ+3nly1Bi0al/c+unpYA==
X-Received: by 2002:a05:6000:178c:b0:431:104:6daf with SMTP id ffacd0b85a97d-4324e709ab3mr2628669f8f.54.1766135874255;
        Fri, 19 Dec 2025 01:17:54 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227casm3924193f8f.15.2025.12.19.01.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:17:53 -0800 (PST)
Message-ID: <3c72a0d9-88e2-422a-9f9b-900ca7867091@redhat.com>
Date: Fri, 19 Dec 2025 10:17:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: dwmac-rk: rename
 phy_power_on to avoid conflict
To: Lizhe <sensor1010@163.com>, heiko@sntech.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-kernel@vger.kernel.org
References: <20251216150611.3616-1-sensor1010@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216150611.3616-1-sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 4:06 PM, Lizhe wrote:
> Rename local function 'phy_power_on' to 'rk_phy_power_set' to avoid
> conflict with PHY subsystem function. Keep original error handling.
> 
> Signed-off-by: Lizhe <sensor1010@163.com>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.



