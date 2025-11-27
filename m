Return-Path: <netdev+bounces-242195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA3DC8D442
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C7614E2898
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E209320CB2;
	Thu, 27 Nov 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Oo58HFaP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0317A2E0
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764230345; cv=none; b=pDFdjcvZqt0kPuA+zfqPLdbs+Z0ghpblNcTTjKpd8nskL2ZEcqATUVgX01jwc0jNRYPaU7Au7LzI1w9haLIY9VVHIRoXvRJJfpUX8R6xZsHfiiTl4Hcs464E4wJWgKNl+d/5jkDlAKaDpcGoyZt3gIoqvs/k/2FP2PK4fuOS6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764230345; c=relaxed/simple;
	bh=tqljtGE5B238dZGReX0+7k1vzaHqZU4bJnLehMvgzHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBbI60hU8/6mfRiDqn93xIB/8tycZ1qYd/TNTEaT59zYYQLqD1dQ+tUTT2j7XCK8cni6U3lHjwW0Kxvy08gxtn+WGb1xdxJChj5q7t9+39Fv9uHotVJMgh3WeX1EMDaGYQmCCMIEolIeSnc+oAbB4U6nLjvUedS/rWmdrqkneNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Oo58HFaP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779b49d724so1036205e9.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1764230341; x=1764835141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IC6r7dvxIHdFiqDGdZe/rUbTNedqAFDjHodaBhbYkjk=;
        b=Oo58HFaP4kGrmn2BAx+Q3mi8ds5SKZsaa/1yi8qyC/4Dx2X484MIKdl559g2cOJKNp
         LJx4K5MxrVmbbV3BpCgmkkJH0zfGokqh2TSJ/fCWgWrOGr8iRWwK7haa03yDcRwgF/Re
         3kSkgRlq0oCRS0lY9WvPcpGDfYQDY6ibcBfUGVm+SJi7EUMgZapqSF6Ivc3Ck/ig9KJ0
         Vn4woembmUd1Y/H9rOwdWjcQi/74+yiCtUCoAgRwLKhjYbobsWYP/+vuJaXPTNI7+QkQ
         jL2yUCjgKty7qrGSNm1SHNRdxiKx2zfD03QXLDXjKWfEEng9NQfDElOA2CgawNBWDkTv
         xV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764230341; x=1764835141;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IC6r7dvxIHdFiqDGdZe/rUbTNedqAFDjHodaBhbYkjk=;
        b=aD2IG9xrdxhy5KTgbkgsHwGiYSCE9ICSTX0qY6fmnSFXepsaka8gFuYrRIY6EKlyGP
         g6R2rvhYYS0pEtRNBMcRNMGXxOueKLNvkzCzAhGMAodwAXKV4jv2YCRqqElKOgmooRHt
         4+ATH+Ya6NMSykjcnweXUQa2MqSgeeSLmrD81V9xYx8WUWkiDxgarY2z8t4d0e2tbcvn
         /5fT/GGQeQCuPvVNpFUBOlnyQA53NPuSuxRGSAo0Xnp9RFniz8WRkKhNeNAUryuqLsDx
         m2XdnkewoSuSBRMBwre3WDwr1GWncC8bIMY0SojLdEWSKOPyaI/v1tBVLgsgK8DDVj44
         49uA==
X-Forwarded-Encrypted: i=1; AJvYcCWpvu9EYOC2EWOGjwO/iSio/D7wprwvxd8fmFQ86jA+DjCSkrsdA/gkMtXOzxDzsFb9AqpxU08=@vger.kernel.org
X-Gm-Message-State: AOJu0YynPhYhsxTlwHUgurWoNT/WgqvktMZBKFq4fYQKYJ89eY3nFZD1
	x8zhqdlvICcACman6eIAgXF3UnhHOTJQ2AhjYepMQWDG2k4aofIOLJY/pNHahSgnhsU=
X-Gm-Gg: ASbGnctWU9VqY3eClkcX7wSneUKgFvsijo8YjfKbPGxnTi8uXAQrA8N0ESN7XMnLADJ
	xuR7t2/68+tgARFi1zOQCwqvG4bfbqF7Lk94AmiywElgm19RB2ZIYeZtQlGiYYleICNrVbWViTG
	x3R7TYjTyVG5CItX0wtTg71AFckhUnWyfQk21eAnrIZ6bkqljwdQZuIGZLfji1hZIP9KC/6DB5Y
	ptZviwGrXVqDXSFt9OlhuTtPFUe3Jm1FQf59/KKsq6ve5DkGdQu/uOySYTau9ITRzKQW6Q4cldU
	nSFnKIV3gpWFpI9XDw/3kOZe0o79/QVKoHPrTJHlIpDnwULLNJtZvQklZTCaz8skUfhkws+4e05
	8YpjeTn2mFfkkqRGAnoi0tZnlZYJoPLHS0KNqzAUaSgu9lprSrAc86cTt02RJt1B58Tzko6FV4k
	r4yDn+FFtXcwReqSetHr6Nt0bUH6SOog7ALYGUg+/t
X-Google-Smtp-Source: AGHT+IGCuW7fhPZNIhVhoI26R/7bcDeIOuDbws0lOhscfLHry+/gKKnsLgrISLmXFapbuj8WecAOmQ==
X-Received: by 2002:a05:600c:4443:b0:471:1387:377e with SMTP id 5b1f17b1804b1-477c01ddc08mr131115565e9.6.1764230340681;
        Wed, 26 Nov 2025 23:59:00 -0800 (PST)
Received: from [172.31.99.185] ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164ceecsm16953305e9.14.2025.11.26.23.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 23:59:00 -0800 (PST)
Message-ID: <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
Date: Thu, 27 Nov 2025 08:58:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
To: azey <me@azey.net>, Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
 <20251124190044.22959874@kernel.org>
 <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 26/11/2025 à 18:51, azey a écrit :
> On 2025-11-25 04:00:44 +0100  Jakub Kicinski <kuba@kernel.org> wrote:
>> On Mon, 24 Nov 2025 14:52:45 +0100 azey wrote:
>>> Signed-off-by: azey <me@azey.net>
>>
>> We need real/legal names because licenses are a legal matter.
> 
> Apart from this, are there any other issues with the patch?
I still think that there could be regressions because this commit changes the
default behavior.
As stated for v1, having device-only multipath routes is already possible via
the nexthop API.

