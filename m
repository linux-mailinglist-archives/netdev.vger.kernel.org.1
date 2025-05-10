Return-Path: <netdev+bounces-189483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE0AB2536
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 22:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801DD7A13F9
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 20:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78331F09B6;
	Sat, 10 May 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E65LeBfr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44A91553AB;
	Sat, 10 May 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746907712; cv=none; b=Qk7uNg0ToUV1II0yGI4kqYvCPTnY5rdWd2SUw+cDTVsskWkzkZaucSqrkQU04SILiuhO+km/Q4WB7ypm8ileDiIa3rHzEhA8s4YqMObRuT64l18297zhCVxK/k+RuWyAjdG6StUbzBiXDuRchrHyfFJVYXxg8LivKwU24w5IfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746907712; c=relaxed/simple;
	bh=5+cONwOXDuyB77cnnwA6m8Ya5JRWtd0jAWyuzfxRgk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBhkFmD6s2eaUHprzdRmSZif2f8DnlKbRirppPxA0SdGbMzX+IkaUXvCC4mjDl1g2l7+r1rrkqcNRnkheuUprGRbv8sbtiA4QkXo6SxkKJFi+QwLHCjo/dr1jirgvPYzC0eN0UsNaI6DDs4fQ3n+cXRrqQYxsKdbnf6/D+Jj8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E65LeBfr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a1d8c09674so1382405f8f.1;
        Sat, 10 May 2025 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746907709; x=1747512509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lc/ZdqzlArTaC/lydsj336svhWx1Nn8oj/k5ev0NFtM=;
        b=E65LeBfrK8ReMu/SQrWIxRtsWJ/eBbRMBTBBKtItMI4TIrzxat0CeVAiJ8vo0Rc2n+
         9fJr7y/Xj8tBIGoTJRdG+ccSN7ryD1nbA9S6HInEf5H9Gq+DLDIxEIzY9WcCc+S6xJT9
         OdQfGR3z/RxglS3iTiQcR0bc7AHN7zxxWD7R0aIjQ0iW12bH5v09+7wQcU1tRaFdOPEi
         yAh3JHWcpRzIXD5/2CT4/s6PLKeznNSqTJK55MHQP81jKTupKjwn5rX428dZhcQKdYiW
         3itwZiCfX44kTKPuBDsMaA0UdUCVHscrwg9U3Dt/9ZKhnpjsExAXI77GqSuCkh1sECED
         P6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746907709; x=1747512509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc/ZdqzlArTaC/lydsj336svhWx1Nn8oj/k5ev0NFtM=;
        b=H2P1paOEhanAEqtsqrRME6MBgQ9kbh8fcw+stry2dHFXZB+Tb/Rzbr4dcfNpr+vavM
         32ftSIdQEmOH8bwqOnu/AG4Y0aBkS7oRko1aIoKzbqGNLHufmt4iTU8yQ91+uCNdCYx0
         e3xXHcvLc3/OB1EPVB4kwC8IDFLj4J7HxdKS7LPf47Lhdai33Ob4yT4lR1SlGg2BstNm
         tyUE98Rvvf0qgIxOZvEdP3hbjDrtsLoGO+dIlFpyNmZWzExEEI8n+NTI3SC7u/a3cKFE
         jx9d4brN1JzfCY7oMXfuSBj9Pg//DWIHR6EcYo7auwE5MJsPMhOiuQKss9hMoFLrsOQm
         8Ohg==
X-Forwarded-Encrypted: i=1; AJvYcCWGHdUKYPR2U0DIU6SPBwGC90oaytSiRIM2cHsg1ELs0g+n7bbxaDsZuY+DJ2Iuc13QD+nsTEcV+iI3TlA=@vger.kernel.org, AJvYcCX7pRSYBu+FE1bOG8t6KUs7hgupRpbbV5h/2R2HooVOSaqjZMz/XJzSGZq6pTPTtZQXCtpLcUbP@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQVZ5R13CRWCaGeOqSPzDx040WRXPIVYxmP3KidEDaP97mPZj
	jKeteG/BbFeIRkFjmEUZ3J9vUU7MJiF0uceneZ2R7ulYA3Q3pxQh
X-Gm-Gg: ASbGncuz1oaADhsvWnSb1QtdJTth0hRL/zd0+rlFHcergdrRPVI0jiVbOGwNLiIoq+C
	/+WTj7hkvLbslDPu4a9guq1Ir2gl8VuOYodwNNUJJBE5WtyMxaUZBTsuD5H5hzbWDs3FsowCMi1
	1C7+ZxkrTq0NVCxDR3PssSWvr34ddmIb9Hy+nOKpuostjH5cgON8kQIi3R3lh1cKIDV3rcD8fBv
	CzRjjBLD/Tm5w9UWu5lVg5RaBXEb4+bG40tSL7LGDSw9JrcVwZCu8JHbQCSYGKI5uhid9uED5Sw
	poRX7KiGRGGMd68lPKMmxtR0AeHmslKkXfpsuo1rGcjRo8cJynML6uK6XkWrxmLmv+L3irEk5qS
	uZV4wT8eI8dpbF5bFdxA5Idm8k4eXLSqHmZ65kdVSBSRPiRy5ccyMlFMcvlie6KsQIy4L3nMl3X
	1za5EjB8Q3Tdnkbt8bYo8AMmTZ/EFc
X-Google-Smtp-Source: AGHT+IGKyqgiqH79FzzP8TFAECw82E2cAyMbweCROyTDwZ2p185qPMtWXu14SsEV4oFbL+wR5DmN6Q==
X-Received: by 2002:a05:6000:1a8a:b0:3a2:453:77a0 with SMTP id ffacd0b85a97d-3a204537856mr325912f8f.57.1746907708892;
        Sat, 10 May 2025 13:08:28 -0700 (PDT)
Received: from ?IPV6:2a02:8388:180a:cd80:ae73:baa1:6de4:2169? (2a02-8388-180a-cd80-ae73-baa1-6de4-2169.cable.dynamic.v6.surfer.at. [2a02:8388:180a:cd80:ae73:baa1:6de4:2169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57dddebsm7193743f8f.3.2025.05.10.13.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 13:08:27 -0700 (PDT)
Message-ID: <10106e65-3e38-4a9d-ac7e-2b5819bb3613@gmail.com>
Date: Sat, 10 May 2025 22:08:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: microchip: linearize skb for tail-tagging
 switches
To: Tristram.Ha@microchip.com
Cc: quentin.schulz@cherry.de, jakob.unterwurzacher@cherry.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20250509071820.4100022-1-jakob.unterwurzacher@cherry.de>
 <DM3PR11MB8736CCEC9ADD424FEE973E1DEC8AA@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jakob Unterwurzacher <jakobunt@gmail.com>
In-Reply-To: <DM3PR11MB8736CCEC9ADD424FEE973E1DEC8AA@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.05.25 00:18, Tristram.Ha@microchip.com wrote:
> 
> I am curious about what MAC controller are you using to return socket
> buffer with fragments?

Hi, we have the KSZ9896C connected to gmac1 on the Rockchip RK3588, dts [1][2] 
says:

	gmac1: ethernet@fe1c0000 {
		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";

Thanks, Jakob

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi?h=v6.15-rc5#n1811
[2] 
https://www.kernel.org/doc/Documentation/devicetree/bindings/net/snps%2Cdwmac.yaml

