Return-Path: <netdev+bounces-209808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A3B10F12
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B825A1882BFA
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8265D1E47AD;
	Thu, 24 Jul 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBnUbObK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CCAEACD
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372044; cv=none; b=WbJp5lIbKz2eDlzjo9Nll2CXPoC216QZ51dHz+l0oe+/6vO0fpFt+Z/p/uMeJPJMYk7JC5e1kp02OIP8BvS14p8Kfz9RKUZLmkEHbNAZQRafDM7wx4n/9beEWOIv6/alaiYSFK0xi4DtQxMkeKb2ZWXEJdo5uWRFotY5KzkeeLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372044; c=relaxed/simple;
	bh=UTp+bZbYLe0cPvtzRSaVSyBonIYg/SLOiDeqa4BCnA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hb/wJl5j6wzHLzuBfn3A51wxIrc4A+uzuzRPModUr0I43UPQTaICoTHgl3QIo+14QFIF9OJl1RvEbxJFYlDmOZByxWY2s+DJQbJyD/E3FzoWdaPs4qdj6tqc77v4Q9uFXDfiROJLTlKSSah/frbYIOCyE/hVgXm91KA1wWJMd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBnUbObK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2353a2bc210so11366985ad.2
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753372042; x=1753976842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LC2U6gqcSo39befy8EKz8ineQuPhRaY6mg0kqHV+YxQ=;
        b=cBnUbObKmffalD0nMO0hiHquasYtzA4wwUG1GUYyg5ejhqNL2EtzloiyZrxw9xD7R+
         MFSXLmQ56CG5sgqQbTj47V3/jhAmzqCqJQBOza1RMfXvlhfC5Qpiaab0V5h25g+aTBMJ
         jfJcbwkzYKcrp22TIFij3FrXxv91nV/kAApzR7WrpuG+V1gC7yXFeOfVG6E/A6DMQIhe
         yn0dMMEiE+iLOVJS/A/2kJ86rkQo0myYPiWmfEv8EblyzgLqJ8eCmixWJcGwQWVoL72N
         +ljtT8Xt4dP9UUVvKcvIuF/EzrEIffJxbFw9e2UO+YyljIfZSvunv3bJLebiMd6bldUp
         Jeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753372042; x=1753976842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LC2U6gqcSo39befy8EKz8ineQuPhRaY6mg0kqHV+YxQ=;
        b=OiPA0uQZpqvQZhuLf68KzsxwmJUMq2JafJkhuIjb0ojXWcNyHx1LVy5ZiKl8Q8yogL
         kequNWB5Rcwm3OeVT/03Y8Qh3PY19vhXuCuApPWsrIlk7fl6/ZCRH8fQPD94fR8UDlk9
         Wzfete99E3LcVqLDIOX+m++e2TK5rgofUtrWgoivWGj73e1tV3CmAcQ58kyHU4fINmDn
         luLv2wyYhTLPk2MVnvaSkN+1QvtNayLs1ra10I0SgRCykm5sgdAElOFkTZi73jXQqmom
         qkKOe2niOyXUr2kytVofh/JcPt7QL+7piRjXmda5dnP7D3FSO51Brbqx4ITN4z9SXLF3
         WRww==
X-Gm-Message-State: AOJu0YxZ3eXezlcfZ5kCyKBiXSt/+q//PLVz8/TOD5+qLcokC19YQ/yI
	nDfjMO6cmiaCj+Q5wR8e1RxU4GK6OnM8OaqiouBuqeALkNFbiXwK3S3f
X-Gm-Gg: ASbGncv8Y5aFe4fgH7G+EMCHgAnKVW2Z+K5HtyHAhkENpzoI5VSiFZA8o18p6NCREI9
	6oGZkReFZLwIZMEQu771lOoBzgI7eOjYhcxhB+qvrVuJwkD+Q1TzG6unnL83ClCk4yt4VciYhpI
	7nvM7vWDUFrpWfCY9vW59l4sKdxkcfyCKnrwEqzSc7FPsXkRiRp47ZB5s046cmKLQTY/G0ycSuH
	Wr2XCXV1dbcDbHZb9MGfHOdPBO3tjnhJmuPIemPSJFCKcUfrsBMiJZ9nQtUPmswDrfVU7dCRkCg
	pS0KHBwtzRnkL1NidT58ZZBGqjue0IrdoCvqTYxDlYkLpxuxWmLyfl8Z1uYXWx801PLeW3z3XXI
	AzrO2sp1nmRszrPm/nVffN7KM22cHFU0YTJ8pseuy6zV5Ehx/
X-Google-Smtp-Source: AGHT+IFY6rj6GEUWVD4OFUSW1bkkufZ0Ybg+Wtmu6G7NksMyTcUon8kQ4/jI5qNrgf5gltZEfi7/Bw==
X-Received: by 2002:a17:902:fc48:b0:23f:8df8:e7b1 with SMTP id d9443c01a7336-23f9820d012mr113402355ad.32.1753372042261;
        Thu, 24 Jul 2025 08:47:22 -0700 (PDT)
Received: from ?IPV6:2601:646:8f04:30::d7f9? ([2601:646:8f04:30::d7f9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48fd0d8sm18423615ad.178.2025.07.24.08.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 08:47:21 -0700 (PDT)
Message-ID: <3b1f10aa-49a2-465b-8b11-bf5e92a6bf8f@gmail.com>
Date: Thu, 24 Jul 2025 08:47:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] eth: fbnic: Add XDP pass, drop, abort
 support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, alexanderduyck@fb.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jdamato@fastly.com, sdf@fomichev.me, aleksander.lobakin@intel.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
 <20250723145926.4120434-6-mohsin.bashr@gmail.com> <aIEdS6fnblUEuYf5@boxer>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <aIEdS6fnblUEuYf5@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

	goto xdp_pass;
> 
> Hi Mohsin,
> 
> I thought we were past the times when we read prog pointer per each
> processed packet and agreed on reading the pointer once per napi loop?
> 
>> +
>> +	if (xdp_buff_has_frags(&pkt->buff) && !xdp_prog->aux->xdp_has_frags)
>> +		return ERR_PTR(-FBNIC_XDP_LEN_ERR);
> 
> when can this happen and couldn't you catch this within ndo_bpf? i suppose
> it's related to hds setup.
> 

Hi Maciej,

It is important to avoid passing a packet with frags to a single-buff 
XDP program. The implication being that a single-buff XDP program would 
fail to access packet linearly. For example, we can send a jumbo UDP 
packet to the SUT with a single-buffer XDP program attached and in the 
XDP program, attempt to access payload linearly.

I believe handling this case within ndo_bpf may not be possible.

