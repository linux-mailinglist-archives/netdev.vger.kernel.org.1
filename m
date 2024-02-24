Return-Path: <netdev+bounces-74669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3359C8622A2
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 05:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8C9282C0C
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 04:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C757512E51;
	Sat, 24 Feb 2024 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtLbvK7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A110F4
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 04:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708749608; cv=none; b=Jy4WX/ydkUn+MdhpePT6rIK1aL1Ea7WBAZX4MSwDCquDbjhzuJTXjdZXXMR9ucx4R8lexx/ShnkokelOpR7sTymUNDgOmCKEdPtJ1OS8M9+wqJitrtUXhmSosWVv3rBI6Sffa18Nk4T7sMYo/T1FDmcdXh4IwkzgVcs0xflCpnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708749608; c=relaxed/simple;
	bh=/3UDeDZdl0uSd0huhvhaI707O2i+NcZGHwJVCKMecgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsLcKaofWiKMpmuVNhCPWzJTc55Zd5sktfhSrcUXFUcIbjL0wr8o3p70v485AioGopSjhS9rWLH/JhCl5LJXNAlTlC/WzGbdKN74cRslTBuYAqTRYnWWJCoHaX/b2ar52Gji+L6Q9LI1JVvs6qvR2BTvvPXQns4uJO95val+C9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtLbvK7F; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74435c428so1067333276.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 20:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708749606; x=1709354406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6vrHsc5oWm3Q0FDCiscINMCIZUzOtgHWTe5t95yu4o=;
        b=CtLbvK7Fzi+EHeGwqzUGUP8ZaXdiUDfoFcLDzlKvsBOAkI+SDrTg8gJkhJFKWft0RO
         GxFENBt9p3nv++GJAXblpZXI7EcRwwCaCb/R0M04DICWJ5XaocfAZiW/zGRmhIapIST/
         nbILjAbjVCldQlawxb/R5jUNC8sn+F7oYBwezOFp9o8lsx2cv0rQRKLG9uol5b0ILRMt
         KCHu9UP/CZtgqzfon7tfFxMNDyaKoVBMxXXfAszg1/eQEdxqC3EprNUQ3WWOXH7Q3kIV
         t0pgtaZoycvDjW9fJBF5P5cpk4JcwJ8gc/vVKxq5Rb8g+YGjs4suE3cIt2OH/BFy3eGX
         78BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708749606; x=1709354406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6vrHsc5oWm3Q0FDCiscINMCIZUzOtgHWTe5t95yu4o=;
        b=Om0616OmFz1IuLm2iB6BrZrWrOiS24NNqlihjMJ3sy/ZagHIBczRT0KxAYr3GhIRYK
         NjEiFg9JSCefBt8N+EgMbzj3qhLy0/rLmpQ1t1eBrzEwWJakCnlq7tp71NLED8qJwXAA
         CfKVSusmPN57YSYBhibR7Mx82fGwMgm8F/G5QzrAf0mJCzr/ArGvGx+amC87FFTH8TZY
         g0s1IlYVP1kuJP8hCGKtXVEwPnOYRSEKzBVpJ5Qv6naNB2Og0DudMCREAEKugd9I8xrW
         kdp0dhFLHIpZCRFly75Z8JdtTtjwmDFiapsblZ+kuMAR+mzILII50qT0zXZTKj2jj7xS
         5QnQ==
X-Gm-Message-State: AOJu0Yyti4Gm58cNGq9wglQbTGF3jBwZr4NneYCtoTlMqp2GeW2JXZcU
	jEBAuqdO2iqT1VuH9+P4FADmPPcxgQQnfpXFEYPuviAxYrSBsFjS
X-Google-Smtp-Source: AGHT+IGabSL8UsfkzblOrNGE5njYZdkzhORdLEWMqlXH1uWJNiCRtSukVaxesGSJMXN4ZT/5xbUw9w==
X-Received: by 2002:a25:db4e:0:b0:dc6:d2d3:a57c with SMTP id g75-20020a25db4e000000b00dc6d2d3a57cmr1581717ybf.59.1708749606020;
        Fri, 23 Feb 2024 20:40:06 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:f349:a51b:edf0:db7d? ([2600:1700:6cf8:1240:f349:a51b:edf0:db7d])
        by smtp.gmail.com with ESMTPSA id v128-20020a254886000000b00dc701e0bdbcsm77339yba.44.2024.02.23.20.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 20:40:05 -0800 (PST)
Message-ID: <bba650ea-54b1-45ea-a8b0-2b30f1af17c2@gmail.com>
Date: Fri, 23 Feb 2024 20:40:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a test.
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 kuifeng@meta.com
References: <20240223081346.2052267-1-thinker.li@gmail.com>
 <20240223182109.3cb573a2@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240223182109.3cb573a2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/23/24 18:21, Jakub Kicinski wrote:
> On Fri, 23 Feb 2024 00:13:46 -0800 Kui-Feng Lee wrote:
>> Due to the slowness of the test environment
> 
> Would be interesting if it's slowness, because it failed 2 times
> on the debug runner but 5 times on the non-debug one. We'll see.

The code was landed on Feb 12, 2024.
It is actually 1 time with debug runner but 3 times on the non-debug 
one. 1 time with debug runner and 2 times with the non-debug runner 
happened in a 12 hours period.

