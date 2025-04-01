Return-Path: <netdev+bounces-178618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B30A77DC4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3F13B0555
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F14204C1F;
	Tue,  1 Apr 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zpLBVqoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0336204C1E
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517763; cv=none; b=C+TAtzu49w3l+d6x0slusq6w9uTl8DvDIEog6RvUgtQd9aImoBtIpAXhY5S2LzG55eTbK4caQehQ/Td5jF6LpbWr0ysaBEE/myMVJSJTN9x5zFd4D8ZoEzFCujUJbVDXWcqx8pcdVAecAqtsO5cYaFUVuR0iWEsLOxDNK4Imn8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517763; c=relaxed/simple;
	bh=XX6oOUemsawBL+SQdwNjm1O0/5SaihaOSkbclmz4J4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkItEDH2jfduONIhEDnFreW17V74I8ATGqxv3NNqSe/1GJBH8HDQpEa4vHILU+uKNGMa1cnNYDKWqabG3GNzsg3M9REsHSxmSeiGdnrrpwRtSoYD4AsaDFnyZ50eU2/3ihu2Kvq+7dyC+zu3oJeVjqxeajmmlacze9W2VgEZ894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zpLBVqoX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227aaa82fafso107761815ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743517760; x=1744122560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6BkKDZgFevCmNfmsTeyIWH988WzbqqfzHgPc2ecmlM=;
        b=zpLBVqoXsnYHhlLLSwIo8MwhAY7HXcLKKEDtBpTCECwck663RV9JC3A6pKTTgUKE/V
         YxrzvNHJ3cj0vEGHMsXKf++Z2lV0gzc6kWJpHwe8Emdxf8GdZTZp89mTxn3fwqm68tNd
         DQ5nBpDMYKhMuGdt+OHq4kTFQExBJ3UfM7g+xGMqUAGPMk+gnO6IyW4MoHRJWKkPGwsc
         ZYyDrnfqgklpQbCLjwT708X6pvp67ggKlAe0FhEof97asm50/FZHUcaTet7DOM11js0V
         KH7DRJqQGaixFCnN2KkkOkQYQVfjl+IZI9lcJ0qRaU6IKpcmufPCanWMVeEVB0IOm77m
         aBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743517760; x=1744122560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6BkKDZgFevCmNfmsTeyIWH988WzbqqfzHgPc2ecmlM=;
        b=Tuh0ognGm3h1knslhaTm2j2Bu/dQIgdetbAVIcjFilwsBgSTD+3Xt/ZV2RLdtGjf0k
         AoHVm41M3eWA1Hh3asMscfXt6B/Nnh4LBoiki2rAW0gYsZiqzPIQZ8oSOC8Kgh75u7IS
         xM3balKvC8RlSRX0p1EvdSJlMJ/rd5b7bTBs7pVMMiMOT5MzjcXX0+OZQEzRiznDYaYq
         GJX0nPgM/zjy1ioiEIfAah5+JD3C4sv/ee3QQw7PoJjzcO5I5eRtLsuptnvzj+ge5yLP
         osgHYrpnmJqv5ro3b2vjl6woF904DOFAnr275lJ7kO4WOrHr1Z/TrSzXTAMtHkL6o2gX
         1xZw==
X-Gm-Message-State: AOJu0YxCjuYwLkKzV4rK0H8eRDl/Wh7e1E/buEVg2twenrumXPuVYlxf
	6e/D8nUJ9E3GnAPGXYF5ZtKib0pdQG8TaLe6J7YdH8Jg8TL+g0OTN6PlGMX66g==
X-Gm-Gg: ASbGncvdTlK3sWNJMLSNNjI0DQCAH5fHGpnv1s5axvJ8mk4tAtaTOJ8/hoJPCFZIhpf
	AjgIygGYCSRgdT0B8tkL4wm9p4u7SjMtliYAvN5wsTZTwg+72Tv5FnUzgKEQswlOd7wT6wpAyDo
	Uquv/XZ6XfK9IE+X6ZAgQ4hSIWF79c8ezr0P69RhhamSABh1s9uVrUHN5qwk42ozAoXbGA9dukm
	6MAk7h6+RWDJmGejAc3o0URTC446z/zlqdjbv4LXQnmq8AxSLBW9ncr3BtOK3bgkx3w81zJd9nf
	z1a+yK2KXTHrveQkDTQe2xcZfENtHZ0lobkPU7l7EnxmycU9CnDPXMhki26qhCIO
X-Google-Smtp-Source: AGHT+IFpBZsmg7PjdBnd0C9b5R1nD+BfWySEnglDXheprt5qViicZNJCWLtqLXYmefKJWINu74z1aA==
X-Received: by 2002:a05:6a00:3927:b0:736:6ac4:d204 with SMTP id d2e1a72fcca58-739803a62dfmr18569914b3a.11.1743517759743;
        Tue, 01 Apr 2025 07:29:19 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970def16esm8949518b3a.5.2025.04.01.07.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 07:29:19 -0700 (PDT)
Message-ID: <a32b8916-616f-4e50-848f-c657bb7494b4@mojatatu.com>
Date: Tue, 1 Apr 2025 11:29:15 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: tc-testing: fix nat regex matching
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250331195618.535992-1-pctammela@mojatatu.com>
 <20250401095349.GC214849@horms.kernel.org>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20250401095349.GC214849@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2025 06:53, Simon Horman wrote:
> On Mon, Mar 31, 2025 at 04:56:18PM -0300, Pedro Tammela wrote:
>> In iproute 6.14, the nat ip mask logic was fixed to remove a undefined
>> behaviour. So now instead of reporting '0.0.0.0/32' on x86 and potentially
>> '0.0.0.0/0' in other platforms, it reports '0.0.0.0/0' in all platforms.
>>
> 
> Hi Pedro,
> 
> As a fix for 'net' usually a Fixes tag would go here.
> But perhaps that isn't appropriate in this case for some reason?
> 
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> 
> I am assuming that you are referring to this fix:
> 
> - [PATCH iproute2-next] tc: nat: Fix mask calculation
>    https://lore.kernel.org/netdev/20250306112520.188728-1-torben.nielsen@prevas.dk/
> 
> If so, it might be nice to include a reference to it in the commit message.

Will do, thanks!

> 
> And also, if so, this change looks good to me:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>


