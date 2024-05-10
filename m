Return-Path: <netdev+bounces-95506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037ED8C2718
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7791F24EA8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D101708B1;
	Fri, 10 May 2024 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="oGics2Se"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599E12C539
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352346; cv=none; b=HWP6PayImjccrLTj6sD1wJmY0iGm8HaCBqRLC3nUnvktS2jYkuMfQiC2M0OA8udMlXZ37c8f7h44R/ePrsaOAZjAeSHndX5qn5ZYpLC1ZukAdRyhBspJR1LGLAImPNu7cYDeROxLiQyJfdQbx7UgciGiyiB/FBFpnk8jc266orY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352346; c=relaxed/simple;
	bh=bgGaF1JxqzX3PvKOyaBObd6LPLWEXbJKPEK7K1ZZ7cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFi22WGA8eDVF4cSNpL6Ia2AvMsTOZ2eZBZBWpm2o30J+YfwZIMyNYaLZNXU7EwY0XVf2rSGV16Gn7ElX5NDUyNO8UYqejXi0jkw2mUmiSemGpMfrT98bfgcub7dw3Jj2VYWwr81+U+s9Z13YpQrACi2NAKCDg3e5xqjUNWdB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=oGics2Se; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59b097b202so504423966b.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715352343; x=1715957143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLuxgxpPKE2Uk9zYmvQ2j8u2IlrYb10ZL2RscJYrYYE=;
        b=oGics2SekLlJahSaIKLEZJKtPpDCwwPccALBeNOxacaodpDG3mEVkexwTXoBfEXV9/
         hNHF98EyOY2FoSSluQbdI4LdJN7fhJANGrOohxT6t5wdUT8vjeSHrSPD8PH9cjI2Sc31
         uOpdxRiNIVNpMxj/KtfZ7msAHPIUBlNm9BP3Bc79kwMrhEDaWGUY5gBS/ZFxBiV29bXG
         g56xzKAZuUW26mT1bhLVRVzapn9uBXMT1ZhfRPI+jUvwr7FaGDk3UxxfP2zId6H5snKe
         KuZ5FbwjaNkJh8WUzHRX+DYJmJI1awXXaocOTzgD2NGZ2LOnSkzocz29QJ2DvTMXTElf
         0HPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715352343; x=1715957143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLuxgxpPKE2Uk9zYmvQ2j8u2IlrYb10ZL2RscJYrYYE=;
        b=j+iOdGiqg1TDa6d/nbMV8Bz7y3COI8OHZkDgHmyyR/08D7qxmENO4wH2Sf9hyKS4C3
         Gz9ryYb/u5THTJKngdssW4jyhANyDISEWojfTtEza5P5ljsB8QIVfXUS4oGJXuDXmMt2
         mpHsG66VaH/CFmZjCtLcoJ97pc+o4TsYfhpjfvhpQxf9NiOMA0tO6InpMPLFipr2x+1j
         OPEB76eMlfnW8XYS8QDvyXSwYGAneXLza6WxxvWkwQXHrtdNCpqTfPr5gZdu1YizhClA
         RLcQgyqahkzrXGIhNOlYNuDAWlziQiTlhq0RIp+ip7A5YZS8DFOXqSsdDslqzovnOa2L
         wpow==
X-Gm-Message-State: AOJu0YwajnJbi1K/Dz4+lG9yUUPBE3tLvyvSG+B02MxN62RiRU2Sy2Nv
	14yV7KIAx8GuNPcooVY7LjXj5Jl5FVTAVhPOy3zlD1aiwEjDZ214kg4p4m05UYg=
X-Google-Smtp-Source: AGHT+IHy469eZIeYZMiE42M99CYYtoinh4IqkT3OK9uOKSkrlUGgX0fUuIIpuee1GBJ4uGA+yQODsQ==
X-Received: by 2002:a50:8e55:0:b0:56f:e5dc:e6e8 with SMTP id 4fb4d7f45d1cf-5734d67ea3emr2050764a12.27.1715352342581;
        Fri, 10 May 2024 07:45:42 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea659dsm1892036a12.18.2024.05.10.07.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 07:45:41 -0700 (PDT)
Message-ID: <6de8eb78-53d6-4347-9a5b-ec4285b96723@blackwall.org>
Date: Fri, 10 May 2024 17:45:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] Flake report
To: Jakub Kicinski <kuba@kernel.org>, Florian Westphal <fw@strlen.de>,
 Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Jaehee Park <jhpark1013@gmail.com>, Petr Machata <petrm@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Davide Caratti <dcaratti@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org
References: <20240509160958.2987ef50@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240509160958.2987ef50@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/05/2024 02:09, Jakub Kicinski wrote:
> Hi!
> 
> Feels like the efforts to get rid of flaky tests have slowed down a bit,
> so I thought I'd poke people..
> 
> Here's the full list:
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&pw-y=0
> click on test name to get the list of runs and links to outputs.
> 
> As a reminder please see these instructions for repro:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> I'll try to tag folks who touched the tests most recently, but please
> don't hesitate to chime in.
> 
> 
[snip]
> bridge-igmp-sh, bridge-mld-sh
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> To: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> 
> On debug kernels it always fails with:
> 
> # TEST: IGMPv3 group 239.10.10.10 exclude timeout                     [FAIL]
> # Entry 192.0.2.21 has blocked flag failed
> 
> For MLD:
> 
> # TEST: MLDv2 group ff02::cc exclude timeout                          [FAIL]
> # Entry 2001:db8:1::21 has blocked flag failed
> 

I think the problem is the short timeout on slower (debug) runs. Perhaps increasing
it from 3 to 5 seconds would be enough to cover the 2 second waits for setup and
the verifications being done. I'll give it a go and post a patch.


