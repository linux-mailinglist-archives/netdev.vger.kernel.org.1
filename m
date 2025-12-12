Return-Path: <netdev+bounces-244505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E8CB9152
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3799E30056CE
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844782773C3;
	Fri, 12 Dec 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAdfjk2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26784224AF7
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552682; cv=none; b=WZjmVT7fe5c4T8NhgL9gcmcun2rUY7kdgjzXlDV5CE2ZCLEKatwg44DyPdRcJc3mZ34Klpfven2RKxrNhwZBnzGImYRuGVkjnBy3QJAMpd22pLH4NvL8QKWR/zbE2ykhWTPR25msB4aSSFi1euacjYtaqiGzj0gmxPztKkQOYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552682; c=relaxed/simple;
	bh=ZUnJGigN0uay7O/PPWrjrh8k8H36qaMfLReyX7pstCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBJPRKJl71hZFozoShOGjCPHAVI5zjO8sbJLBom9FxaF5eHcmhltVEDitF258Q3jLZMwhAkPpj1oelX3Vqqg4xDz2J7Ho1LlkVrMluYhQ8pzPmOKyfWOsSvYf7UWCWGYGEHKARN3C0Nqox/1EC4NID4C7kAnuTyKCcxjWINT3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAdfjk2r; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34a8a5f3d44so1476539a91.1
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765552679; x=1766157479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZZlSe/3yKyozwh1rDWKvHDaKkFzdQL8XOOUdf58mGc=;
        b=NAdfjk2rHux+L2XjIzij7WgEjqetocn/0bBqCtEoecFmcm0ZseV81gj1pohzXbd2Av
         Ikab/rT/3fSt72X9eJzLCkMXciq/xKW45juvJaUz6LS7iBynnwszSWRqu9CGrHb+q3TQ
         aCrZ2iuoWJuDEmXABnkR4oqArzPb2mZPyYYhmjaIWLoZfIoN1/exHfVUhpUxT0sCXMzP
         Ojq/XBbimYcvvyos0BkJ/vRgVYIjCOFzUZK4WrZriO2WV9Q+P2GChiy3rY0psf4nje+e
         jd/UBLPuol5M8I6JkpFvMmtfsmq3imfq1G2kMOLjnLaf1ywwgIyBx6ZngQRcc+hbvW5C
         RfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552679; x=1766157479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZZlSe/3yKyozwh1rDWKvHDaKkFzdQL8XOOUdf58mGc=;
        b=t9NM6WIDwGD26T05XGKSgSDbGb1hW0hlK5eW9axBBFUyc57asdhU6BWAA9mfRMfNIo
         CHk2qcVGyTqKV3dEVWONToVn6rWwZQ3NA1Hxfa4XjlmkatuWDlFnMY2UHTl7pyj/8sc7
         CfYrnzHcOoBCrgW1X0Oyud1ybNgoSesLN2+CuYm6Lhao4c1YYXM5Acu3pqUUdd252tDn
         90v01irFwIbh5zPRv8HnDZB9PTgfLacFmjfP3DKMdYgnsP8IxBazSRVRDrvv1vATHu1O
         /FIh4Rh1g+MllZ0ODzIWWDejkUKO5fu8gzt7nc947GPTmPo3Vf2hlJPTAiSrGVCmmeY7
         MzEg==
X-Forwarded-Encrypted: i=1; AJvYcCU/qtg/4xhFlrGXv/BaMnUF10LUDjCEW5/tyQTMO/7v85PiOacobfDM05z8gj0sqzWOve8Z8kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY4GtqFI2IXp34Md/rUHgDQPWcwvb+QNq6LL9yAvS6JtLTKARD
	YPfCTMhojC+lz3qlNIHzOmfsxHzwj1k+KM2ZBF0pbm+yfmjU/l38dk0W
X-Gm-Gg: AY/fxX60g1OF1ssHTJpYlCiYMd1mwfW7kSCjfxuuArKZv1LWZiyn1WNgU6wPPMcBbAE
	rxaz3MUY1iCYpqQdyW1TDpgf48JQ9OOcaSn4G9/74kFb17a9E/gdUCJZmLs8AjK4+wj8cMMT48V
	UqvhPSyokhX2AmcejAmnvHSEVjQwYUUcICEc5QQD3Vpa7d2KEOM/DjCVJaiX+CV6k2mcBQE5wGG
	fL+Ea7Fjc7h3dqdI33VZav/w6hVs1orqqm5mpdYfAVmmZcWWVyss+kqj1ETiylQJTzT5PHR5XNM
	nF0awM7JItffM3T7aZu9e6mJ05Yat6ftBJhuL3FrrgxLiHLyXSD6ilHvhczvE8pv9sm9gPYioS+
	mK348SeUcoQkVO2yd8c5XMwlSC2zbuzmd2reaebhP/bZHTj8BY/7LjbqLh5c9oBc4GTtY06OBw5
	jqWFAvl4JPIlIcbHr8A7pl/u22Q+AbpckHEAVbEbtZLOta+1xcVBT7RshjH9hmxtzZne4=
X-Google-Smtp-Source: AGHT+IHrvLPpg3t6kLMu9Eotmoa5F7KrFBIMW9dOWUNDKq6rC38YS04nLcFdp7xPAIwZ9NkCD98ftQ==
X-Received: by 2002:a17:90b:2811:b0:340:bb51:17eb with SMTP id 98e67ed59e1d1-34abd6d35c0mr2361730a91.15.1765552679329;
        Fri, 12 Dec 2025 07:17:59 -0800 (PST)
Received: from ?IPV6:2405:201:2c:5868:7bc2:74c9:dfb4:ddb3? ([2405:201:2c:5868:7bc2:74c9:dfb4:ddb3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe1ffde5sm2278443a91.1.2025.12.12.07.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 07:17:58 -0800 (PST)
Message-ID: <81d4181d-484a-458d-b0dd-e5d0a79f85d9@gmail.com>
Date: Fri, 12 Dec 2025 20:47:53 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net/sched: Fix divide error in tabledist
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: xiyou.wangcong@gmail.com, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <f69b2c8f-8325-4c2e-a011-6dbc089f30e4@gmail.com>
 <20251212171856.37cfb4dd@stephen-xps.local>
Content-Language: en-US
From: Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <20251212171856.37cfb4dd@stephen-xps.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/12/25 13:48, Stephen Hemminger wrote:
> The whole netem_in_tree check is problematic as well.
Can you mention the issues. Maybe I can include that in my patch as well.
> Your mail system is corrupting the patch.
I will resend the patch.
> Is this the same as earlier patch
I have just moved the check before the values in qdisc are changed. This 
would prevent the values being affected in case we bail out taking the 
error path.

