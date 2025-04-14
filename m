Return-Path: <netdev+bounces-182364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE917A888EF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAB918823E1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B827B4F8;
	Mon, 14 Apr 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxEzMLk/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51217D2;
	Mon, 14 Apr 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649480; cv=none; b=oEMj1Yc9eFPiKEPgGINRklASLpGu7t6N/nlJJ9DPQV4AEFHVnFRFnQaeatD+dneU21J+Kv5aKr16TKLHoU8gGiB8LfMOduAcN1cwV2pMZF95sVjnF/L7XdHFFUzuDyKm/QqM0G1/ICtW+mT/EhJ5Mz9HOliBmmhS9N21NuWhvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649480; c=relaxed/simple;
	bh=o+wzfibnavHMC7J2lEVyyjq8baNIRWdQcvmecfP/e3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nstMKZo6jSZDhCh8yY76cQcAPShZq6OPuybVHZEaeKL1y5aw9vmAVz8qfJzWS4vWsIq6l+TbzrrqoS4ZQVFdA/EZaVFD/9drv6/7bfV0MeIiUPMoeL1QSe2JJ06cGvLWBTSismhKRCvJwJ3u2BIq6XpK2JPp7ki9GEP9xb7pGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxEzMLk/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7398d65476eso3616405b3a.1;
        Mon, 14 Apr 2025 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649478; x=1745254278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loEmrCXlDHvkJcHT8n6886+X5mxbYdBpBzNFyNbvBHE=;
        b=PxEzMLk/HR+//cb6PJ3Sh2zNQJSZSM+WqwWX54qXiuCfE7r9CpjwLwuf9aOkLK7rzO
         miR4xGGcNUC6M+XLOSIj2BfQbCa35niCJl1SNr8XoAuw5AU5ieIYjQWVFnjkBOIGofqh
         R9fQACtVpIerlOCwiaVBuEiwA6X32/M6B/sKUjaHNw94s1tvQ82Mo03x0hRGSOYrVflF
         kn3J+guwEIVruhybcypeenqOW7eH61sddDvai7okwa8Ad3+Isv3Lt68hbGpPSEUUc8ro
         nFt4rptJQHYP1SvWeL6bsUgjz8i/ucAMuTc2LkeKJUIxRk0Q76SysWZC9j3dNlWywnfj
         s34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649478; x=1745254278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loEmrCXlDHvkJcHT8n6886+X5mxbYdBpBzNFyNbvBHE=;
        b=ju9j/B2hzK6qK6hSEMQExYI4bJoEbxFpWYluVGpM9zUs1+jdwN3hxIF1dDLlTzI88r
         atV60KGBipb4OcaRT8kgJw+nKm40dnnV0M3d6TX5X9+UQgfgI4lTFGW7/UH0wid8rYxR
         j0EpXKkjphH6+LVyImtXgEXj15vyRFELjHjdizq49GYHC8rPPkmyohN7F20r6ClzYjIK
         Br9z5ErH2NkPf3bEturzqSLdFiHCSXiC7x7y1kkTJ4aUxV/ZwZJFz9Vfu1heRO1i7/Vx
         NQ9zu6jUYkPHQjsLCfvw4yGY0dVs9ksubuefSmkQUqjH2gW6oxbRq7jVDOqiUcppsInl
         rn2A==
X-Forwarded-Encrypted: i=1; AJvYcCVWaEoPoqdEyF6qjCjc5k0BQLAoRe3FrSl/cWoceumm7IiTM10rqvvqMBAUYek1OrifEw+LgdPs@vger.kernel.org, AJvYcCWvvtQ+pCusZ3t9z8yJ6CMuApb240t7J5EME+bxswh/as8wcbG9Ye3hfgYFOrStGP0LrD9n8X8REZ9aOfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXISYpFX89gKnWeov+lmrEYvMN+rAZsw4CuPhaocd04gMJfB6R
	+uPR5UQSt2LmuzR+ixCQLQiOL+1nYxyww2D5wzvBwcrELzxkvvQ=
X-Gm-Gg: ASbGncvRc8rJ0i6q3Zq9OTaSAqGzT/xyB7azCBN8Osu+aRLyeM0uG9nikJQBNfyRYiK
	zs9v1MZnadikwL7hw7rjOlsFK6k6N4RATcFOzhKE3S9Gz9LlgSPDySuejIY4nVFQ/44mt9qj6qg
	vVISerCd+IdT7qaZQcAr2iZyUaN99Tyh33o/elUS9d4Ks+iZR0ZeaQvH4r4grV8UcGN7zX9RT/P
	x87ShmYCM0Hr6SZpw1iUOM5xYa6sSfx61JWJtXtjJHrUd6nV3Id5VGyzYBClMMSC+mSxNzBr1Bb
	eSoh7txesrEDBRjJwKN8mWKJecNjgXh0HT2GfyqIFI/eNNuaDhXzsw93DOwZH0YXCIhe9M0APnm
	y+ae0EGL0tXrIppGgY63M565XHDQ=
X-Google-Smtp-Source: AGHT+IFWF+LX4ypZexKPnyQu+tljsinsEoWsXd3Gz59DBlhrO+4E3isX1zqq/GKw1lArNb5tNIva3Q==
X-Received: by 2002:aa7:8e15:0:b0:732:56a7:a935 with SMTP id d2e1a72fcca58-73c0c9f7219mr198972b3a.12.1744649478227;
        Mon, 14 Apr 2025 09:51:18 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:7c7f:9279:7925:2f16? ([2620:10d:c090:500::6:5817])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c3216sm6832023b3a.49.2025.04.14.09.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 09:51:17 -0700 (PDT)
Message-ID: <a944aa22-5d29-45d1-b93f-79f18551d245@gmail.com>
Date: Mon, 14 Apr 2025 09:51:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ncsi: Fix GCPS 64-bit member variables
To: Paul Fertser <fercerpav@gmail.com>,
 David Laight <david.laight.linux@gmail.com>
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, npeacock@meta.com,
 akozlov@meta.com, hkalavakunta@meta.com
References: <20250410012309.1343-1-kalavakunta.hari.prasad@gmail.com>
 <Z/eiki2mlBiAeBrc@home.paul.comp> <20250412102304.3f74738c@pumpkin>
 <Z/xAHeYXfFAUpxbR@home.paul.comp>
Content-Language: en-US
From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
In-Reply-To: <Z/xAHeYXfFAUpxbR@home.paul.comp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/13/2025 3:52 PM, Paul Fertser wrote:
> 
> Many thanks for chiming in and correcting my mistake. Hari, sorry for
> misleading you on the last iteration.
> 

Good morning, Paul. I've completed three versions so far, and the test 
results for v3 are clean. However, I'd like to confirm the next steps to 
address the incorrect GCPS structure. I believed v3 would be the 
definitive fix. Could you please provide guidance if that's not the case?

