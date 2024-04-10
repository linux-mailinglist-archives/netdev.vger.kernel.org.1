Return-Path: <netdev+bounces-86459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B1489EDBF
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6892839A4
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB8114F113;
	Wed, 10 Apr 2024 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="FoYyOSdp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6913D607
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738253; cv=none; b=gMMztzApfSIlMrjr4fTLaDv/hlA6L9zq2Ak27Npcn3QMSy4Sinava9nI4fvB8l7ZEhpzSwASOLC4jNqFib/5sjBz8doSib29dVDTe9nKxSU6BilDCmyxbA86nLZsWes2oC0ATtc/Rxhu5ae6vXnoSVWhSE4rGzBrCel3W5oN0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738253; c=relaxed/simple;
	bh=FYAo2/dIeQdn2ZanZzlG930Vpz+rf/Q5KdpGZ7ZWSb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjDg5noDuzuRjbpRdkaAoho68UjfpR3WkVD9HcHVunlu6vOsOcBLQ8UKSNTRhHvgh1zHjmVT+x7zm04w3HOQMhKH6jJB2pqKRCGnmGuykHTexbURLtdLXn3HwGiJ4UPUAyhAwiK4v8zOI4WyDWQtgSPDPLbhXs6y+lr7A75qoAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=FoYyOSdp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-416b66163a9so13130265e9.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712738250; x=1713343050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=99G2ssJEZsbhsIji5LLAb7rBxLp1dxN5cU7ZF7Ofo2E=;
        b=FoYyOSdpSJIs0ooXFh3CJNPeiZc8cTIgsIcxWjkUJXz9F8pXPZi7b6wN4ltC31IzbA
         wHGsCHsv4zbyoNx9q4ZEkO3D91SiEO3EMAQJnmroeOTmkQriAwHdQvXXvtxNRqIwwQOk
         g9BzTaylN01no0/hg3FnNCxOcbfzAGCVzuEKpW/lA2swYU2aJsrZ04L9yPvkafauDpVl
         8M2OzkcQxwtjIXhmDBU3yhc+hD2lrqhjMeTvvNBUkUaIsM0ystymregtPgiA4ADr9dPe
         pjW7/koslOjT+3nl7mueSFtoZyR179vEMzC71Vwyv9mJbH6BECI0jeKUP0yx/Z0R+Gef
         WNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712738250; x=1713343050;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99G2ssJEZsbhsIji5LLAb7rBxLp1dxN5cU7ZF7Ofo2E=;
        b=G9K0CZXhI7WTkA1Nn4wNZfB/B19tQkdkur/jZ+IKuS/T7dst4Jq/6tm2153pfR5wSo
         0R5D8P/PwnvYv7CJ8GDGzpdgsj9XWmr9+eQy1P//conUYXcmP18nyDvqXR84Sbw6Wzk0
         H0zQlyDxGf3OLt8NsOq89zHRjgHyXRsCdVpUQcOhBU5UoSkIN0CPg3z9VbYXyOZfNm/9
         8SedT3CVWoGZcKS4c5WiBQXi5aaQvU3NDWLZP4FP2gDPlEIrCTat4OIfjI/FVsddn08z
         uCkcyNEV3C97ZJ/dwGEnwGEO65g5Y2TkP2xzJb5SNFzZykWJDL6DTYoA5h326p/xiejR
         vQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWB/DcOKP/tJuY4RTxbiP43GqKq936kl8WHLyoublbjg88QeKfbDSQWZ2xQtnGW4OS/c3rZQmj2MxZLpDhVFHOipCkw0rRl
X-Gm-Message-State: AOJu0YyERrN05ViFuvj1DpOQY+aIFbsVtQ58SzL8WxmS4slaHX5rnSqC
	280qGItVSebLL/knYLyTS0YyHgWfeBDbSQ9pyNdx7iBNs2jvqePtOWIto74U6eM=
X-Google-Smtp-Source: AGHT+IFKUvThV9mqYvSlZmF7R8A0q41osKTYthm4fPbWcaDCaOMpjuEkcaIpFo3COzoaVkCbC/eMDA==
X-Received: by 2002:a05:600c:1d83:b0:417:240e:9ac3 with SMTP id p3-20020a05600c1d8300b00417240e9ac3mr928977wms.2.1712738249833;
        Wed, 10 Apr 2024 01:37:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:51b5:9a7a:d2c:9ae? ([2a01:e0a:b41:c160:51b5:9a7a:d2c:9ae])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041663450a4asm1560021wmn.45.2024.04.10.01.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 01:37:28 -0700 (PDT)
Message-ID: <1909116d-15e1-48ac-ab55-21bce409fe64@6wind.com>
Date: Wed, 10 Apr 2024 10:37:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com> <ZhY_EE8miFAgZkkC@hog>
 <f2c52a01-925c-4e3a-8a42-aeb809364cc9@6wind.com> <ZhZLHNS41G2AJpE_@hog>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZhZLHNS41G2AJpE_@hog>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 10/04/2024 à 10:17, Sabrina Dubroca a écrit :
[snip]
>> Why isn't it possible to restrict the use of an input SA to the input path and
>> output SA to xmit path?
> 
> Because nobody has written a patch for it yet :)
> 
For me, it should be done in this patch/series ;-)

