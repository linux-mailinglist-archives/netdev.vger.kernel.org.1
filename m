Return-Path: <netdev+bounces-186998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06918AA46C6
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D271892003
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A221B9F6;
	Wed, 30 Apr 2025 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b="YrF6d4MF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F6220688
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004610; cv=none; b=EyB4Gbijb6zeN4qJaHhGYdMHOLLQNosxy66B1vKTDAI6QWvGzRSauPyBjDjUFmjwnzZ9atkvBpyFK0DG0Be3/nGDRSs5HoPOYrml8U4TlN1xsvjYOuzMGW2Tsj93b1OOYrrIGvnEmqHGBV2dvkOyTuFOG1Vpxe2c6kgs/+hCCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004610; c=relaxed/simple;
	bh=BevedQaQvBBiX06J3pCcK0pE+p6oQauzPpWiXiQ4MHM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=AmKCE11Z01LutEBsT/+U1ZFAB9ifI1vCDCMp1Fi+nH8niqrOLW/4Vm54dzRpB/SWLKmIXFkCccyS+LiYQryMqY0g7ojb3WHzhQWUQM24DxYHFEcoZCZFN9EdcJvEA5PeW7vVe3ltHCtzanXSSZe1NdLtkD9PpHUmBduMwuTXV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com; spf=pass smtp.mailfrom=deepl.com; dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b=YrF6d4MF; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepl.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso66988891fa.0
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepl.com; s=google; t=1746004605; x=1746609405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA46efbq59rSlpszzI4OCPZsjnfo4xMXGMCSysDJ0i4=;
        b=YrF6d4MF1Q82S8oSLGqGG7k3i+tKmp9nEKTF7wnQ5z4YjQVhxoIompkWUQccVfhodC
         dOetOCfmH8u45sd9eQit7WXMgJfUOVeF0bzKeMacHQQwa5AttjK0UlUG2Q8j8GMBfKzt
         QR/E4j6yRu5Z/LcHxmvFlqOagR7pXhVeWaw7bwMUXm4q7pfjhjgbnt7iS3BP1s/TNE2c
         8ikcN6m009XgQDfNVuzmjagvwDFaCWMRbCQMNcDW7JuJGuvMtUkJ784oFTxy7GpJvQ12
         JxjtsHFXaZ86KuE8fqU9mOLZLHLt930JWgl6iql0xZVdGJJAycYbju/w25qkiW25gLES
         uPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746004605; x=1746609405;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WA46efbq59rSlpszzI4OCPZsjnfo4xMXGMCSysDJ0i4=;
        b=WZjDbGrtbg1nDguCNHviJHNfnLZ5VNBv7/KnMB5Kr9PFzzU3J+Au0SkXw/88EE0dru
         vU4WDd+o9Gl/xcGuOEcktgcrnK8GQrY9t8GOccXk2CLquhU4G5p4jca8Z0enO1hG1KaV
         yvqBrQPnbBCiLw/siUZzubi8PeclQ/3/Lw+IEK3ZFL2TlK37gcfomk0uNXbtl6yAd0ox
         J98dMVjHOzECNMHf1O05Pl0YKNFHjLupBl53j9SHyDbTB6l1V0zXbtL6nvanT9D80lyq
         UdTJF/VHxPGJDLZFxY/8IgV4cbT3nf0d75GTY3Q5TWdDM+EtVS0XBFC9IbiHcFqde+HP
         PwBQ==
X-Gm-Message-State: AOJu0YzxzWCedmSntPCZqEiaTbbatvU0XqFf7yqIecwdlDaxqqXpne9m
	coNK7EChoBvXZYdBDS4bRVa885kAM5YcrSUfqW2vOCgaD48MO63jG4d9KyU1CsRlRiWO9O0no3O
	C2uE3qg==
X-Gm-Gg: ASbGncsx7+D5q/sGQtiOuBvqZ5zTc8BBOzV6QjjHtQB5Ls40HbKyhhOf8jk3JNYdott
	qJulPLGenK56V9jrUF/fdGS9hMHk3y4cAL53Kgmi2FGrclOwnHtNIL7/vXTALmEPeSDEw4n7/jc
	bC1I+hwTCPreyr6rBaDG7hVn6dT/a/scXwK3QhptrvdMXou9n5wLIRzWIOG9V36NuD83GFeFp1Y
	7OEFFiHlxpg3E5xRfWmW21sEUvfXxJWafJ+5G6HYNiI+3J9B9vjbS6ZBfR6pPROFeD4SG3ggpMi
	Xm6IVdBERQ9M/CrVzFiMG3moLv9uxCmZRcW3u3lwV+3kOs5jm9lW+yZshkq+fAv4EFyrvXaPuWZ
	KNOK8yYHRfaYTdxdtEj0E9qaIQBbahg==
X-Google-Smtp-Source: AGHT+IHx3VYhA2aMrwNs8vQTpI2UgqHUPMkPns3e2BzwS2z1Mhcnx7mM70ON5gnnTZcJrWhXRuWpIg==
X-Received: by 2002:a2e:a5c2:0:b0:309:1fee:378d with SMTP id 38308e7fff4ca-31ea328b924mr6203821fa.19.1746004605027;
        Wed, 30 Apr 2025 02:16:45 -0700 (PDT)
Received: from ?IPV6:2a00:6020:ad81:dc00:46ab:9962:9b00:76f8? ([2a00:6020:ad81:dc00:46ab:9962:9b00:76f8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-31e93f8323esm1796001fa.13.2025.04.30.02.16.44
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 02:16:44 -0700 (PDT)
Message-ID: <f5f8a9a0-a590-467e-81ad-81e1feea3b79@deepl.com>
Date: Wed, 30 Apr 2025 11:16:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible Memory tracking bug with Intel ICE driver and jumbo
 frames
From: Christoph Petrausch <christoph.petrausch@deepl.com>
To: netdev@vger.kernel.org
References: <06415c07-5f29-4e1d-99c3-29e76cc2f1ae@deepl.com>
Content-Language: en-US
In-Reply-To: <06415c07-5f29-4e1d-99c3-29e76cc2f1ae@deepl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, my mail client fucked up the format of the commands how to 
reproduce the issue. Here is a corrected version.

On 4/30/25 10:59, Christoph Petrausch wrote:
>
> We can't reproduce the problem on kernel 5.15, but have seen it on 
> v5.17,v5,18 and v6.1, v6.2, v6.6.85, v6.8 and 
> v6.15-rc4-42-gb6ea1680d0ac. I'm in the process of git bisecting to 
> find the commit that introduced this broken behaviour.
>
> On kernel 5.15, jumbo frames are received normally after the memory 
> pressure is gone.
>
>
> To reproduce, we currently use 2 servers (server-rx, server-tx)with an 
> Intel E810-XXV NIC. To generate network traffic, we run 2 iperf3 
> processes with 100 threads each on the load generating server server-tx
>
> iperf3 -c server-rx -P 100 -t 3000 -p 5201
> iperf3 -c server-rx -P 100 -t 3000 -p 5202
>
> On the receiving server server-rx, we setup two iperf3 servers:
>
> iperf3 -s -p 5201
> iperf3 -s -p 5202
>
> To generate memory pressure, we start stress-ng on the server-rx:
> stress-ng --vm 1000 --vm-bytes $(free -g -L | awk '{ print $8 }')G 
> --vm-keep --timeout 1200s
>
> This consumes all the currently free memory. As soon as the 
> PFMemallocDrop counter increases, we stop stress-ng. Now we see plenty 
> of free memory again, but the counter is still increasing and we have 
> seen problems with new TCP sessions, as soon as their packet size is 
> above 1500 bytes.
>
> [1] https://github.com/intel/ethernet-linux-ice
>
> Best regards, Christoph Petrausch 


