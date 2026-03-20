Return-Path: <netdev+bounces-269803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOzCHsDwvGlA4wIAu9opvQ
	(envelope-from <netdev+bounces-269803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:01:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F92D6647
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC6B306742D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20D1F92E;
	Fri, 20 Mar 2026 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No7KoGAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5E280CFC
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990072; cv=none; b=MUEBUl1X/Rvl9UZm3AB+0xcnSTSdd1tfYkmT5JQQ+wzOclUDGe3K9Jj0sVtoQ6ue1rnaEttmswaNS9Z3FRXhlJBsJStxGun1iOBZnbDOqe5GSlUNuQavtoSCU+7J93V4LDwEkAa3VukvGtiVgvs6gqB5NzNoXFbjG2XI3ljYJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990072; c=relaxed/simple;
	bh=3HF9wgnRG9yrpxXbSCc0igBYuNphX33rgEIqvI20pYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSBTVdKDb+rPSB9WYQVMUvwN4UyaMUa1cWHnhGpQqxSHj+P0XZ2XyfVm8rGOofBy/TVr6mL+d+NuxwDQ13Oi+wX/+rlXYHuGIT3FnIhcs55ZpF+ibp0e3VC68yqs8LBegFLApX3JCjvYWDzuxBHqtIaNZpz/sTgbhK78xwgfNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No7KoGAV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b7c2788dso131787f8f.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773990069; x=1774594869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXy5aCVESxJEjgT7Xr2omfnlovii5NJdao8pF0up7LY=;
        b=No7KoGAVpPgt/J8W5pK8ZpvRNSVpDErQbLblFhimui/3AnqkHENW8gSxo62gfrau+q
         77t12KELp0sj3hVTp7jdxljWM3bGPnBkWdc0QTRVCgyoIfSO7vaoFnxC5kJwszd+WCQt
         qYAotPupFoO6/Eq8xTzZ8lFEI1jd2qIMHbSPpVZxnmhAS2Rpl+JoylbD/XF1VrgmT6rV
         +iKBDbACxz35yr3VoZANfOSFJRKK2SIZC5QumofIcT4YBGL4lidtdkBOFnSE0P30MPvy
         UNgY00SMv/ISVAYV/A9x9fHi2CZpuPdUJqX+xgl5xwYKbs6LocJ9A5GhHeE+usPqy51j
         Nz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773990069; x=1774594869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXy5aCVESxJEjgT7Xr2omfnlovii5NJdao8pF0up7LY=;
        b=dNOT4QS55BW/tuGlhZdAl386Zi0iSMrRrJI30AF1PlPjbStt2qs95KgDStegQRKo9E
         usFQr5rnx5oteNFT8dTlEseu2/NwZNKLajLJ6zUufPYl9rxB6c8ROWlwoeadgpQQXlkX
         uyFrB6tsS/Hk9uefwiowjw6rr917wF7vA7houPl4G8ibgy8CA/R8LnFDIECEeL6Ek4V3
         dVzHgrlypHR/pPDwdlKicI/pVIyO1Sb8SNhWHkREgz9VPfrYZIcSvZjtUvkqdJmo5+7A
         nMA+Dfme8cpxvuYDgt4bdUOOCCcZ658x0V0hg5XcqSIWUISdG22+llF6tliUusrA3PR+
         iV2g==
X-Forwarded-Encrypted: i=1; AJvYcCUDxalMd+uyVDj5mgacvu/De/8cr8dS1CiWiyNYwAH2lUKqwRgZ1S1ZUHgCBzfLuNF6LfwYCr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyhP2pJhRq/JRp4TY+KDvyCnIgWdELXaIc7FhwDA/vZGQEfPJL
	B9z6SbcJRMrEj5w0zyuzh5lKQxNv7roX7q3xoJEGeQ7oDke/8Vd9ChWo
X-Gm-Gg: ATEYQzwbMBQzV0+V4tDMUWIl3rDUIND4q7e11LKOVm1fd8pu6O/aFqf8tK8fRhno3h7
	AY95vDGaI5dnxUnsvtV5Rh+NlmND7gkVqcrsLUzB9lMyJO74F+r20lZgdGiT6ccB4cTaBAT/4Cf
	iLs59DstLLJ2pBxtaK1wbtOdDTVRGw90q10dFgHVSq+OnjDnUHLb/SmU6jVQ2T5q2+i4mOfmwBs
	n4NSOTQkVf4APEOydL+yxbjXiUPNE8HxoJcJOWZ0zs8A8f0AZGnzUihWUEJPqRRdtm8E1BDFtx0
	i5Jh09V8XCdlBNlo6KzoksxwD3PHO+AmmA3oAzhiYv44/GqDfBpTBDzI79+uN2BOVqnZV93m0Kl
	QBCz98johGGWkts9g37n2jPdhHfOazImF5Im3dN2HJlZ46H2fK3uYQh/HvlF5LmafMCFTvtkRdj
	WbhYtxtI6Bfs86g/q5Bac168hthCHrcxwm1113RapsWQlPFJ7OEqbzJ0tpTgTv0TnP89rSbrlA2
	WR/CgPTI+RPL1heWJJIKqUQ/2Uoq8oviB3xwjHX0dUCRXotwbT6e44Md2YdgyQSmg==
X-Received: by 2002:a05:6000:184d:b0:43b:45f5:f02 with SMTP id ffacd0b85a97d-43b642429e1mr3218902f8f.6.1773990067717;
        Fri, 20 Mar 2026 00:01:07 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f29:d400:ad48:a70e:f06d:ba53? (p200300ea8f29d400ad48a70ef06dba53.dip0.t-ipconnect.de. [2003:ea:8f29:d400:ad48:a70e:f06d:ba53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647120a1sm4209742f8f.30.2026.03.20.00.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 00:01:06 -0700 (PDT)
Message-ID: <e273efe0-a66b-43c6-829b-aa158eb82fba@gmail.com>
Date: Fri, 20 Mar 2026 08:01:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: Discussion on implementing RSS support for r8169
To: Javen <javen_xu@realsil.com.cn>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <1ce3478d571f4d26a45e792c4c84c429@realsil.com.cn>
 <e063ce5f-1789-49d0-880c-e4b6a40da9e1@gmail.com>
 <86784e19c4504c3ba49a9299701a2c1f@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <86784e19c4504c3ba49a9299701a2c1f@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269803-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.976];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD2F92D6647
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20.03.2026 04:22, Javen wrote:
>> On 19.03.2026 09:56, Javen wrote:
>>> Hi, Heiner
>>>
>>> We are now planning to implement RSS support on r8169 driver. This will
>> require significant changes to the existing driver architecture, so we want to
>> discuss it with you.
>>>
>> Thanks for the question.
>> I also once considered this, but decided against it, as I didn't see enough
>> benefit justifying the significantly increased complexity of the driver. Even
>> with a N100-based mini-pc I can easily saturate a 2.5Gbps link with the driver
>> as-is.
>> Any specific reason why you consider adding RSS support? Would be good to
>> see a performance comparison as basis for a decision on for which chip
>> versions RSS may provide a significant benefit.
>>
> 
> The primary beneft of adding rss here is to reduce cpu load per core.
> 
> Since I currently only have one RTL8111ep and one RTL8127, I'm going to do a simple test.
> 
> Based on my iperf test from RTL8111ep to RTL8127:
> 	1. With rss: cpu load is distributed across 4 cores(1% ~ 2% each)
> 	2. Without rss: cpu load is concentrated on a single core(7% ~ 8%)
> 
In sum it's the same, so we don't gain anything. More the opposite, we keep
more CPU's busy and don't allow them to transition to deeper power-saving states.

> If test from RTL8127 to RTL8127, especially on platforms with weaker cpu, disabling rss will easily lead to cpu overload. 

I could imagine this at a rate of 10Gbps, but still would like to see some
numbers. However, question is how realistic are use cases where a 10Gbps link
is used (and fully utilized) on a system with a weak cpu.

> That's the main reason we consider adding rss support for RTL8127.
> 
> I will show the result from RTL8127 to RTL8127 when I submit rss patch.
> 
Yes, please.

> Thanks,
> Javen Xu
> 
>>> Based on our vendor driver which can be fetched from Realtek, the key
>> modifications will include:
>>>
>>>       1. Enable msix and updating the irq allocation mechanism
>>>       2. Support multiple rx/tx queues
>>>       3. Register multiple napi and update new interrupt mapping(isr/imr) for
>> multi-queue
>>>       4. Implement rx msix poll and rx interrupt function
>>>       5. Implement ethtool callbacks for rss configuration
>>>
>>> Should we submit the changes above separately or submit them all at once?
>> Or do you have any other suggestions?
>>>
>> As Andrew already said, please submit the patches in smaller, reviewable,
>> chunks.
>> Best tagged as RFC.
>>
>>> We want to align with you on the development and submission approach.
>>>
>>> Best regards,
>>>
>>> Javen Xu
>>
>> Heiner


