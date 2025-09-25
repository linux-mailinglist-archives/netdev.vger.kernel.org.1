Return-Path: <netdev+bounces-226251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D615B9E84B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037E74A5193
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7012D7DD1;
	Thu, 25 Sep 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvrQvBfR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215E2874E4
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794106; cv=none; b=gQ4r/25Nzi5FfnfwaXlAcMOyi35K0kWZboihtsD+JrI5XQoWRJPq9bxEZhUI/uYtm3hUnmzYjYKeo5EzqfX3lOPcVXy8wDsj2XWNcKXFV1bwM4UoaFvV9ThPJnLMilnBZpWK4uBTrLnQ0gDfPkIF1lWjvhQR+exzlcjxVes12UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794106; c=relaxed/simple;
	bh=gYz7iV05DSw4pVhAWjhV3Q0zzhj5V+j80F263wxEhK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tth+8QOm4Q1g2dwS5puUq/fbHoo2qNzixMakRDBaJ3oI6TNfayLY9seSefIASxzCdKR8wyeYX4G+XXzaUJuV9TXqNJunxDQRIf+A98u8J3wPt8VDSm+GPDr9pd5+6AAr7Pv27wx1uQU+5vkHXLJ4WY4mHCh9xosGAeWcGK1uiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvrQvBfR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-633b4861b79so91521a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 02:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758794103; x=1759398903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6dvovCLm5rvYDjRuqlZ0v6O+tZDtYwybR22eRO2w/w=;
        b=CvrQvBfR60pjYrt0JNov/JUzBIu7LqSKR/md3Vk/16C2BVFDFidGXudncHq/2Ns5d1
         iQioOLx9l0wtXcnHvsuBg8DIiHKBFus7lnQhgdGTZZo3ibU3LNyoOI60TEJoONJ2V+3/
         z9btmhvZnnbvl3TYlEKOP7BE9e2juxFDHABQe9IJ/KACOsO22CCr2zx4ho0Q0WNSqjqw
         QoC2/NUuoftjd9OiJbTJxykezYo2T+MQDH9EyMtt1tnNT9PAh64bqeA3QQ8c8zGu6tCm
         NcyC9Jli7v+vPVunCHe6KAOr3QHyjhfsGtQRcPoOm83Kc3LqmcGPcot4rzpInR237yYM
         BChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794103; x=1759398903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6dvovCLm5rvYDjRuqlZ0v6O+tZDtYwybR22eRO2w/w=;
        b=k93Qr/TtKnasOApM2yYfK2RyH5Z4ZGSgqLTIEm1YhBA2wdjBabmlFo2Tp92iFxKtJu
         jCTznBzxmCXjcFwNsEqagRlPKI/y8/lObKS8+rst/e1T1/UBZlV1kf/AO9ORm49QUJyA
         45UdA6JFumikvIvXaUq09Zjpt4dScdmiKpz/QEFBOBNgucY43Upw8I0piYLUAH0LlBdO
         OGAxRU73sJYh399HyN3qfZbWmf407Y1Q8GF0vtFnTPz4v50UuEupAoNBjHyDSl0TxV2S
         4yh1RwxZ9LwPS91HU23DUF0KF9I5ohb9opsGplzBI/5ojOlA8VbpefvphwuZ2mCpLAar
         f9hg==
X-Forwarded-Encrypted: i=1; AJvYcCXFbBIOa4ygO+hiTafb70ydPh9IGQtpZkAsCr4ASIu+CAknGMR/4sq904Yrl7Yfvb426ChRfGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSg9Z38sn2zpbJoCVkIEMnd7+XhX+u7X6uz31/pAtzfZTwaCx
	LjRzYZbBSRo4YYu14wFvdXtfCLDfVBxzE6exE638SpwbgG8lKiFwLUNy
X-Gm-Gg: ASbGncv+plbY50tcvH3eJfFWVPF2z4oP/IN/XO0bR+AKF+flk2EYf/ACydT58lbpiAA
	WWQvgcPrJVBjruEUBlss0SOCFmk7L/wooTvmbBFuV6PEQgC2xnjI5WS1usUPobfe/hKOMHoNNwu
	DY6d5/P5U2GftrnojZHs6s1Kmjk6WzT53tx1z1xTsNMBdLW5MrvSs37H6shguOPbQzlgV9HOEQt
	Z27y09KFKmfRDXW1jaTqNlZIpuOvxLQVGOgFTrAVcWZpVSmDk3QKbNqQSoKLyVBncU/aVp4NJVA
	HTz9BbCI9h04XGPSAUNTHfeE34p8DajSSARyrg9O+k9dGGhbzhhAfoDPlJzipx0O6xx9h9DOEjw
	gE3PhWtDm5/35LLQ4kAxlv4Y5pQZ/YjBu8UXPJJNutIs=
X-Google-Smtp-Source: AGHT+IFTuGy+/aqTWUBxQswnc2Pa/G9YhWnP1H9BAmagYPQwBxO49Up+XtOmxAKd1meYws/OfWOHBA==
X-Received: by 2002:a05:6402:239a:b0:634:9e76:9997 with SMTP id 4fb4d7f45d1cf-6349faa4975mr860990a12.7.1758794103190;
        Thu, 25 Sep 2025 02:55:03 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae31cfsm919842a12.33.2025.09.25.02.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:55:02 -0700 (PDT)
Message-ID: <0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com>
Date: Thu, 25 Sep 2025 11:54:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, andrew+netdev@lunn.ch,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, matttbe@kernel.org, chuck.lever@oracle.com,
 jdamato@fastly.com, skhawaja@google.com, dw@davidwei.uk,
 mkarsten@uwaterloo.ca, yoong.siang.song@intel.com,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org, horms@kernel.org,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
 <87h5wq50l0.fsf@cloudflare.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <87h5wq50l0.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 10:43 AM, Jakub Sitnicki wrote:
> On Tue, Sep 23, 2025 at 10:00 PM +01, Mehdi Ben Hadj Khelifa wrote:
>>   This patch series is intended to make a base for setting
>>   queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>>   the right index. Although that part I still didn't figure
>>   out yet,I m searching for my guidance to do that as well
>>   as for the correctness of the patches in this series.
> 
> What is the use case/movtivation behind this work?

The goal of the work is to have xdp programs have the correct packet RX 
queue index after being redirected through cpumap because currently the 
queue_index gets unset or more accurately set to 0 as a default in 
xdp_rxq_info. This is my current understanding.I still have to know how 
I can propogate that HW hint from the NICs to the function where I need it.

Regards,
Mehdi

