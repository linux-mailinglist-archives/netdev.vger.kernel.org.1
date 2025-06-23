Return-Path: <netdev+bounces-200409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE35AE4E2C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 22:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4ADF179D3D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7FA2D323F;
	Mon, 23 Jun 2025 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRIBPKPz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144F01F582B
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750710814; cv=none; b=luLFFCDPS5+jI4xDgpUniX0Id0XkH2xW7KldIn2aejAZMT5KIeRfzWn/U0KpDwHvXmoJATHC5TZmQNpYAt5L5JTvYJVt5F49M+sX5VvJhHsc6WDyQPF/uOvLeywZCijAmVSRcBHyeObau2Mhv4wofCNhrYm/V33deMbY0Y3W0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750710814; c=relaxed/simple;
	bh=eeZQ9txsgusfWOsErazUXDVuY/9V/wPXMVUis9f31h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fa9bF7byOxfb6utdl0hJ4Ev++qCaM7jyht5yKLsnrFrwRFdHRH9h368ie552jYYktd41Lt873svPD/ZQ1Gdbl8hSU+lb8I/yDF/Z1AnAqbuo29evByTYx/qX7OUOfyw9KQICxHcWEKAoXAcw54o+6UXSDec2HeU9kzx/O8GKHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRIBPKPz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453066fad06so30401935e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750710810; x=1751315610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shvkGBHHPpsRBuu77CvQh2VwkgPu0KbPqm9TUN+Sl2k=;
        b=RRIBPKPzNr3Bi7h9jdhw0n7ij4lwnCHIY3XdamaOIZUp5DoFGsHC5wJKbudWMvTA/W
         vpMzB3bm5GiejKVD3fRpMs/FT61XGzOFCa3Ldj24jI0cD/8Z0fzC92wjQVEmg7xZs/0C
         31c6BhUOUDGrUbeQNwNsGrSFaapQHeVngp/Qslafq/uh76jZD7uolxFMVTNtsygcRO5j
         6bKMH6Du1LMWYDag3ZESEMcj6x5/lSbU7JSEAgpRyaWFKWUl71bLMHezczEnfoqY73HH
         axXBbKgv7JfWL0zdQ8BDI73b+shEJrSX9qZJxnz+NMEtUAXqxYrP2yyvRffqEV33VAef
         xhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750710810; x=1751315610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shvkGBHHPpsRBuu77CvQh2VwkgPu0KbPqm9TUN+Sl2k=;
        b=Rn/7+6C85oyzPUuxdwpkRCzEv1xMxv1rTk8BR3u4ctFfD28j9PWXvCG9LNq2vgjPYv
         TCd8AAX1fX2xsKpRW5O3Qb4yQurxZwATqnxeoiBBnVq+UMAqchY9q7F4z7tJxy8IETfU
         VTALOzjfT3F+l6/PcygfOJDbZS+481IfJUl/N23ooGuOGXU/KXsB5h35b0yD7hSAxHIu
         ocP8vvzAxFaz9VGJoTNjDb7fNxKxr1xIII4xaJ4/z0Fg2JxWgBmVPxUh8f8wXmyC9BIG
         rFVGgGH1veC+9k6eoXKeUXRAIdOlKcjHrR6EAUuZvAWKs6rdSK2ouzYZSfbu8WuakJpo
         D5pw==
X-Forwarded-Encrypted: i=1; AJvYcCWU2qX8WnkhAQHeLHmKHN5Pc/KazryuPc7I5FFaW6w4f5jQKya95Mi+qAVCGr+qAPrE+QzFMW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9+kX3yMXvveK2V/flDcsP/BQ9BfYhHPVaoRoHI+1wFeF6mVEl
	E9I5z5++P5itG3oUWeoIbcGQGAGBxswSPnPuR31gv+mTRkjwPPbMRO9R
X-Gm-Gg: ASbGncvr2vrG96vZU4vbt8HkrDLr9hsrtq8fDeGkAKZQqLn+hV5AstdrZNkRg/XYsFd
	BD4JIclohsf3LlKQF9Kf2IS2YWKV6X8nr6V71SPHttpMhuf7UhXdZ+Xv0eA6sNT8IDG5zJkr8s1
	mZcSXAIOmtR5R62UccmwsiOYxqN3GlcHNZRvEMOfDHQ9dvx68hM3p0rMJOMSLnPfGssBH+ST49y
	Rvhg/GS07YsVl8szZNQdADU5Y2yoCMXLd/uJGBV/bWzCIZn7f1380Oddq+lZpkix/QLDxr3fpw8
	QL1MkB+90cM7bbNqZEkl2jsmbD7eVHpMCu31NlCLABFHFu7oLOBYhhzlmrPViq77ng==
X-Google-Smtp-Source: AGHT+IFnVtm8AG4ZufI/H7LbpEHfQvTxf/vQoWdgvbVwZ2mGmd05twW1q4zhRydW1YBPuk/lm38PDw==
X-Received: by 2002:a05:600c:468e:b0:442:d5dd:5b4b with SMTP id 5b1f17b1804b1-453656bab67mr140678105e9.31.1750710810072;
        Mon, 23 Jun 2025 13:33:30 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646dc66fsm118727915e9.18.2025.06.23.13.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 13:33:29 -0700 (PDT)
Message-ID: <010253fd-cff2-4d4d-9f44-579dc4311bb8@gmail.com>
Date: Mon, 23 Jun 2025 23:33:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] net: wwan: add NMEA port support
To: Slark Xiao <slark_xiao@163.com>
Cc: Muhammad Nuzaihan Kamal Luddin <zaihan@unrealasia.net>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 David S Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Abeni Paolo <pabeni@redhat.com>, netdev@vger.kernel.org,
 Qiang Yu <quic_qianyu@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johan Hovold <johan@kernel.org>
References: <7aed94ce.2dca.1967b8257af.Coremail.slark_xiao@163.com>
 <4D47E70F-D3F3-4EB6-8AE0-D50452865E58@unrealasia.net>
 <1127dc09.55cb.1968040ac46.Coremail.slark_xiao@163.com>
 <85e7ddb.97b3.1976899efc7.Coremail.slark_xiao@163.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <85e7ddb.97b3.1976899efc7.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Slark,

On 6/13/25 12:23, Slark Xiao wrote:
> Hi Sergey,
> Do we have any updates about this feature? I didn't see any new patch or review suggestion.
> Seems this task is pending without any push.

You are right. I've missed this case. Let me finish the updated patch 
development as suggested by Loic. Will send in couple of days, I hope.

I'll send it as RFCv2. If it will be Ok with your driver changes, than 
fill free to (re-)send it as a complete series: NMEA port support in 
WWAN core + your patches for the modem driver.

--
Sergey

