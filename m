Return-Path: <netdev+bounces-132332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBF991421
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 05:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203D11C22010
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 03:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8591C687;
	Sat,  5 Oct 2024 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRHIBbAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E41CF96;
	Sat,  5 Oct 2024 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099605; cv=none; b=cQBPjJkAKymshO/dlVdrAUytPEnL+AG+T2IHQwUVqYvnJX1RGlVBVCDYjBcyUFPXWUWRlT6WvCtMeQ9s/zeXonyhiKIVPqeeaNX1s/G1Ql1HNZkhCu95lsPml0vA6Cs6ykIvolLD3MSWJgENxjBguEOkFc9i6NVisGuQOY67pj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099605; c=relaxed/simple;
	bh=W/AxWDdVdu3PuPkGjP18PC1LDVs6lDtOrGrao1IOIXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oB1Aff8er+oFw1mlVs7vh+GGj/0Ro+TqETdHJ5g9YgQTzhgGpzyJD7mcIj/Iw5RWnMytzPbcYErZeIKAiPpROLPmcWL6W37si3ZOYFpQeANmKsJGESsnGKg7UxF5Z9Ba2Ec64JBrXT28CsC5MYR5iK2glmG/mcJfwjvhq/b7hCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRHIBbAJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2238374a12.2;
        Fri, 04 Oct 2024 20:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728099603; x=1728704403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk8JsieFA5fhfGm6unKmwwNDAcDANR4pe1DK+IwW6y4=;
        b=cRHIBbAJvYb8m9DoIUBk5On0S4ga8lYJrc/RsfzRrjt4K6vOBloVXULPWgDWP4L1UL
         2AsBQyRDKSptzynLM3up7rmcmXgDgHTh29WwruJPujF8qLbMc82+xcG9MqOqpxure0tq
         GjbKx1NrnVAt1QItCfdXjYKkrnYufJrsmRyunBnHh+S3Dh/mra8jjY3Qd2Jbzb1M0cko
         wTkyttTXKZFkw+/tAvoov0mYXpUmPsp7Y7MdUQQrhVEEzMARo4k2kzykjiOdEqHNwB7c
         NaJVOvUy8pelE7BvNjk1ssfWcqObXTnaTS0cF99w7ZFqWptf9cP2YCkim7DaBHEvohWa
         HrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099603; x=1728704403;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pk8JsieFA5fhfGm6unKmwwNDAcDANR4pe1DK+IwW6y4=;
        b=iRJJVesEZR7ihTbIHCzbOpVxtwc4DfNVsLuNL5kLixdLcpOGU+5yz4WWwOCnAjKrCT
         x9K3cX1KkI+24ql+Bo0U5Z5OoVC/4GD235NYHAdruWSCdZ2Ee66VJxjOzD8L+NkrnG63
         ZBlhskhGELY8oM9c1jXhJGaRSHDSmfLb9RZtyX9piNdlSjz1ONRAdJG7elPrtAWe/IWb
         mnJlcsI38LidEdS304LBKFDjo2BvuHc/BxJenoUSc9WhESADNgk/kbzq315CCTKcaDPI
         hhhPtD9O2I89qDMSbl+Q76g77iAZGfM1K8aMbbJkEdVJDIt/98GmfDGsuktK9X4/oiI6
         5MTA==
X-Forwarded-Encrypted: i=1; AJvYcCU3ac6GKo6QbFft4OtDp9ZtTUz85MjCCfi+KzNP7zTmNcrVq988TeQHjshsSafvt6oQvJLwAZ9N+ysacoU=@vger.kernel.org, AJvYcCWCrz0eNqAxdKbaVB3snOyt7JM4JoSauelIPSiaB/dU8g5fM/5gBQFIDLGhZNzGML/BByap7rlf@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+GH5ca69AOi2+xoAs99EantR7YOrh5m81pez5zFjEoQYVO2l
	tJeW9nZGLpxQ1lxaqhkGZgV9Xc7LKKhkgEnbHXBtu+nbb7o4tr80
X-Google-Smtp-Source: AGHT+IHAF3FuhJX/MpkPhmhTSsCpsxQra7gntYdrWJ86sTlVFIqzvK0Cv9SU8Wsnaj5j6tW7Ar42AA==
X-Received: by 2002:a05:6a21:328b:b0:1d6:e765:4d48 with SMTP id adf61e73a8af0-1d6e7654e1dmr3521104637.34.1728099603227;
        Fri, 04 Oct 2024 20:40:03 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f68393desm634051a12.53.2024.10.04.20.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 20:40:02 -0700 (PDT)
Message-ID: <22d78c1d-8490-461d-b1e7-dbfa02a1218d@gmail.com>
Date: Fri, 4 Oct 2024 20:40:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] net: dsa: b53: fix jumbo frames on 10/100 ports
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Murali Krishna Policharla <murali.policharla@broadcom.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
 <20241004-b53_jumbo_fixes-v1-5-ce1e54aa7b3c@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241004-b53_jumbo_fixes-v1-5-ce1e54aa7b3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/2024 1:47 AM, Jonas Gorski wrote:
> All modern chips support and need the 10_100 bit set for supporting jumbo
> frames on 10/100 ports, so instead of enabling it only for 583XX enable
> it for everything except bcm63xx, where the bit is writeable, but does
> nothing.
> 
> Tested on BCM53115, where jumbo frames were dropped at 10/100 speeds
> without the bit set.
> 
> Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
 > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


