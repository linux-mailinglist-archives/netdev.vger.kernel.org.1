Return-Path: <netdev+bounces-190865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0769AB9256
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45357B41F2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3499F288502;
	Thu, 15 May 2025 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e7/+hjz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91118284B4E
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747349010; cv=none; b=hKqukX1mWUhPU9zx/WTUAAsfE1LRsovSbre0ra++HKzSsyv7PPpoJYFlabXpTnfcMv14+ouwYmpLAN3VtebBV/JkNgR+oEdhkOPhl5z/OnB1EJTQU/svFUDQFe2ZOG7HVF4DuD/6L30UqwelJWSkI3arPiUfCahsX0uwn1daLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747349010; c=relaxed/simple;
	bh=hKiR7RV6uF/39RKWwVIWw4hF9BrdPsn8YkMi2gjQQRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/07oi5az/0vEHZzUN0zm74Cw400+cceyXPK2A+ePSAxPZ+4fTr2AMbYNXl2ojGr5CFIZV+vmTOgXDyCqfjml1ig2SzyaWc2nKZE1Z42tv7CvWCHGyaxtZ4t45H2hnJcnrjQCrlbPJSUpdQtBC1SN2zY3H0PB9we0Med0ata6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e7/+hjz2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so1396901a91.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1747349008; x=1747953808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaMLZYYSkXEElFDIyZkF1bOxINyZfDKxXfSZoEJkwnI=;
        b=e7/+hjz2qyKmdXhd5LR+UWsaoyiDu0BZ3OYBcNKfjXzli4mrkkWj665aj3JMTRzLK9
         2K9+qqIko0uUaC23mJ5OuxGCXE0D+87SNwEO7LCPxyQEx5aDvW5mxCbQb/rt+OnK4rtT
         h2kA9/4JuEPHqzOOh9TFeuY2Kqcx7oA1zNAKfJBlv3t1hihPwZmt8Kph0wzH35rkfZNL
         j+28bMJ0XHj1BEHU51eABrA8uAJdzXcy6k/qCDcoYaWtyD0mE2W7gMoY2kCc9MfDCRjl
         Iijm3lNxfNwNfM8CbnSvxVS0NENWse4gIy9T7uUVIkhKev12YEz/sUwlR+77U4hNixRK
         IFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747349008; x=1747953808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaMLZYYSkXEElFDIyZkF1bOxINyZfDKxXfSZoEJkwnI=;
        b=IRIWrfI1sD3B1p3eAIRpQ75r6hh5AIK45ZISbKaR6huj53qP8+2pixxjIjxtZ3IL9j
         ySf3oMP69L5gsalrIxu1UIahFdYEBUyWVza21HsX5ANWnvCx+cWiXsH5oWe2B0RPcuMz
         MVZEMZ7+IRW2QzsHxaEzNmCmuIh+aFkaoMPXEtw9NoTGEJw3HU7aE1NnxGCIvWFO6O7S
         iCauFPabGIZb0USE5qFBbwVdV7yW6qfgzJ8A/wvnrzcn70yYF2W4kUOC2bD2asg3Y73Q
         jZlYaS4dIaVKNwXk2Vlor2281WOMT1038ax9IYJcq3IS8mVNjQzZSrOQcW70Is7Tt+rV
         CMwg==
X-Forwarded-Encrypted: i=1; AJvYcCWga/BZ+OiTqBoeI5A55MLYhitBG1BGXSicSE81Ks2FgiFLulK2bO2ceyvh/0jcCDW5M6QXGcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbeWcmFR/ZaCNNYKGVigza+xOBeen/5VmN5yOQUZZlSFbAvgv4
	2cW0GI755aE2EHnkyquw3SAQ0CZWFc9i+A2KBKId0MPGlyFgwxKBVUdOyj01B+4FVxw=
X-Gm-Gg: ASbGncsS2akCd31/MKCNEki45t3ZvBml13jKMRf9UJl459TtF7cFExqiHisU0m0Vqgj
	IPgpsl/1/jovaS+a7ASJDtkg2SRlDNrI9xH7WCO3HPXFm5UTNVqlW/R/DnULaH6N/H2vrF/nUma
	xx/R7HK0E7Mr1IsZLEswgPU7YnnUk1Fz6/21dq9MkWQUtg8LnuW8sM7RfmaVTjS/8kWGZiOfbtA
	V0X08A4ZHN7JlGJTvtDuTSB/YeqE26n09+MpodTLFJMFdKVsYzEFX4dFwGfnMECGRhI24kHsu74
	drZva3/Pw56GjeNioeLbbMosdjlBpCjzfnYlWdI1CZcB/7gUCi9WWdxLtu9g
X-Google-Smtp-Source: AGHT+IFsjlad/fVowsBxAXBdcK0wIxdL3PSQuWQ3zgVhlWFTcAm7/XTsYHYk9L2yGj6UqC8Q/wKYKA==
X-Received: by 2002:a17:90b:2587:b0:2ff:502e:62d4 with SMTP id 98e67ed59e1d1-30e7d5d9185mr1165499a91.32.1747349007629;
        Thu, 15 May 2025 15:43:27 -0700 (PDT)
Received: from [127.0.0.1] ([104.28.205.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d4aa8a5sm333422a91.26.2025.05.15.15.43.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 May 2025 15:43:27 -0700 (PDT)
Message-ID: <1f726c87-c39e-4818-bc92-295ec1acf106@cloudflare.com>
Date: Thu, 15 May 2025 15:43:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 0/3] Fix XDP loading on machines with many CPUs
To: Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com, aleksander.lobakin@intel.com,
 przemyslaw.kitszel@intel.com, dawid.osuchowski@linux.intel.com,
 jacob.e.keller@intel.com, netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <20250513105529.241745-1-michal.kubiak@intel.com>
Content-Language: en-US
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
In-Reply-To: <20250513105529.241745-1-michal.kubiak@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/25 3:55 AM, Michal Kubiak wrote:
> Hi,
> 
> Some of our customers have reported a crash problem when trying to load
> the XDP program on machines with a large number of CPU cores. After
> extensive debugging, it became clear that the root cause of the problem
> lies in the Tx scheduler implementation, which does not seem to be able
> to handle the creation of a large number of Tx queues (even though this
> number does not exceed the number of available queues reported by the
> FW).
> This series addresses this problem.

This new v3 series passes all of our tests. Thanks Michal (and Intel) 
for the work on the patch, and thanks to the hardware team here at 
Cloudflare for testing!

For the series:

Tested-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>



