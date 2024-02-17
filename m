Return-Path: <netdev+bounces-72608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8209858D00
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 03:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05491C21320
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 02:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5622A12E78;
	Sat, 17 Feb 2024 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bRsapKWx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA22CA7
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708138360; cv=none; b=EnsPzUS1UqG+NB91CFbZJpY8M46CDXHznmDEVYsCyuF+ceyqRbcDu+5pOkhsc9hDJ+3UXW4XBjGbY70PjVBIWTliqELHnWWWKS5ldS+zpyX7IkeFcw2Hw1AI4G4fvdfFatYD0e6mYjg+E7vxG4j199iAmWd3Enqr0EkSICgCLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708138360; c=relaxed/simple;
	bh=F1nuZPp+nv3k/HkLXTKDgpweDjvF7iE8250zHGkyFtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXU9CjVOnngl/U93S4xlhs26OYQB1hd9KtoaYArjWkLR10zh3t9FT1YNypN+3hba+9KT9ythpRQSgoSpdqTGu1zsU+TfyPxzQ2hk9GW3iE7UoOhtes45NATZbYVb5GtXynrbbfYvo1ZfnB2pSAKf5msCfW7qmdFmxBgLnv7AgJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=bRsapKWx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d51ba18e1bso28013835ad.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 18:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708138358; x=1708743158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NP2KTtF5lD4gpHsrutGea9pOtPpXIo8zNJIqPVBXSuA=;
        b=bRsapKWxaesmhN4jQPzihA9tq9as7/+dZWvJd1QFGXbSoXlKAPXUC/bnT43ZW/kIcB
         55ZPUZCtKVNXtjfec7bqagznSHWf5uMmzt8D377ce1YxHdWe7ls3hog8KJu61u8tW2d+
         T8Yue+GUvab0uVprUBB/AZ4UdGismOf43gD3y/RGME8X+8fo9l2IR6pkwIu83nUXCsM6
         1nAGZ9XJxrZdOGUzFy5BC5gQTM2lCxB4apuX9coby8sKO/ufOZpxuqMjQAatrVuf9fzp
         B3AxDBKzBPfDdG1R5caVGmocS3VSmYR9xvSKpTzM4zYisHTeIx+PyG7XO12570zTI+fp
         Gt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708138358; x=1708743158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NP2KTtF5lD4gpHsrutGea9pOtPpXIo8zNJIqPVBXSuA=;
        b=JuUGX/EAyrzv+VifKMkrHhmuQgSFnPHETnpO7DTHGjCtzrUXQys9zXmTTYdhhzouLd
         7jq81m+98k7BIMOUCUHH8GpPLA85cfce3r4zMX/1c8Rg1EDuCvm8N1ndyH3734fJ1TP7
         kNd4xPBtAmTySjc1AV6NlJVG5U9JA0MMnZ0FuWswkBSJhzMBA+U5zNmfBlcdYSSVear8
         2Pk6xNMticasI6goJu7v9tqVNA3qMma0p+98kx20hfD9QE7rt8z9/mTsxBNw1xdns2He
         wNW7cpFg39V0Dl9uDcVx+DZopxRxPv2ZZlKnV/x62xx4XzZY/CaH9YqtO68SXe8kCCER
         dKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvRS7gJktUU3s+x9AE5qEkdNLWHjvC2wgkGTLy54PzoZrt0QDBXyfMaEm7emwarrjMrC6OgCDOL/NQxPAKfj840XLKAsR+
X-Gm-Message-State: AOJu0Yz63JOtC74c1xjN02IHcJarqV04Fzga/BwlXa/DIAN2uA7JQT4P
	QXV9YAa5cpLPxBNsIaVx9IyR/f4EOHogNhGNpi1ZVahBmaartx4gpQz2Bwnw5zA=
X-Google-Smtp-Source: AGHT+IH29YCEbDjfqXQIauWvVpcsK5OvpfLXI+8JkndGNDcMGlJJUpPtLgOVEQYSbaMlTVoVoP5wog==
X-Received: by 2002:a17:903:11c3:b0:1d7:5943:21b8 with SMTP id q3-20020a17090311c300b001d7594321b8mr9134170plh.16.1708138357985;
        Fri, 16 Feb 2024 18:52:37 -0800 (PST)
Received: from [10.1.110.102] ([50.247.56.82])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902e18500b001db499c5c12sm509452pla.143.2024.02.16.18.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 18:52:37 -0800 (PST)
Message-ID: <17df4023-6b03-4e95-b3b5-eddbda229386@davidwei.uk>
Date: Fri, 16 Feb 2024 19:52:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/3] netdevsim: link and forward skbs between
 ports
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20240215194325.1364466-1-dw@davidwei.uk>
 <ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
 <cf9e07d6-6693-4511-93a6-e375d6f0e738@davidwei.uk>
 <20240216174731.5dce1a43@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240216174731.5dce1a43@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-16 18:47, Jakub Kicinski wrote:
> On Fri, 16 Feb 2024 12:13:42 -0700 David Wei wrote:
>>> this apparently causes rtnetlink.sh self-tests failures:
>>>
>>> https://netdev.bots.linux.dev/flakes.html?tn-needle=rtnetlink-sh
>>>
>>> example failure:
>>>
>>> https://netdev-3.bots.linux.dev/vmksft-net/results/467721/18-rtnetlink-sh/stdout
>>>
>>> the ipsec_offload test (using netdevsim) fails.  
>>
>> Thanks for catching this Paulo. Can I sort this out in a separate patch,
>> as the rtnetlink.sh test is disabled in CI right now?
> 
> Looks like the code needs fixing, still, so please tack the rtnetlink
> fix onto the v12

Okay I'll add it on!

