Return-Path: <netdev+bounces-132380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E08B599173A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD11F22525
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D85214B94B;
	Sat,  5 Oct 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="BWSpi+sS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1501804E
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728137465; cv=none; b=KxKSR2Cb86F5nzWF151DP1yrAvlkMgFgbM58sWjuwlkpIxqqt1uBADGZzZZ30uIGi3ay/DqPgyZ/RQAEpt6aWbzLdbuWiIOQLuvx/AKEkuZ5ufykg2geUqYxc3cP62OkST3iMnEjk1ZRBQPdQU/GdajcmV05li4rjIIZEn6Y//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728137465; c=relaxed/simple;
	bh=M7K1x9mbx0z8l3xJIQ6lfzlZpNcGUcFPb5NyQQpKoE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewDvU42jvUSItRhdvZf9bhiGm9Xtiw80W8GOFjbPsF2Qc9ChWHfuiU3n/gsqbj/AJhauZvgTNLhOA6cpqRe71zS9to7QMcHTK6/fDyODdX9yd8ZlLXRdsDc8I8k0mLHYzt0PTWTTYBZQ8PgYpDqxClFPkqu03xd21XL+FJ5MPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=BWSpi+sS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99415adecaso42477266b.0
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728137462; x=1728742262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3pJUxDzwXOiX/FMBkP1kd8J48tnWSd84Vg5xmTtT1I=;
        b=BWSpi+sS3fwd78LpAmhRi9hBup1Md3gly2hPtbeq4ccAkGW/S2qJpuneAnILRc5CpP
         6ht4d5oLPyLd77RJIVD9NN/q9ZfZemN6BksgU8MXmsS9ZuUfJSXMtmuBsRhjtZ2hXLLI
         gKBI836eTytYg3L/WLsl+pjeuwlPKcYsSpDF/6/QhIt7LeqDTqCFofZwbXr90EWuetVq
         D0f8a1WBSRNwSri3REphKPj2bw486GGWdH6ME38zxviGtYjqos5PfOuA/cNV/iXez5ck
         mFi3tFxQcfpjX5vZTLapfGJpJC0JOhazyqbuo33uoHl+PL3bnbv1r2/YYaxNTB9kZT+A
         MyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728137462; x=1728742262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3pJUxDzwXOiX/FMBkP1kd8J48tnWSd84Vg5xmTtT1I=;
        b=ZOR1HEOMsRl9ZLr4FWhhuiBxNUYTJ8ZUb1uZ2khp9lLXZVcyR06+ilfb7ifX6EwkMf
         7NiyxNBKMFnpYt2Sm1YsVaFd/YT8R8rcx8PJDTfpcXVEXelue2XveeqnaTo21rs35r9p
         aDkvSMSDoyXrKcNqbsmwE8kRK9QMvYsPUDRLygZtuNAl4K5o5Uw6hq9PtJ8Dxs+BhoBp
         O/mQCl+j+wwFC7OGa91R4JhnpKrpewTOPMEOBCZ5YOzIIN/knCfxHiFMAL46QOno7oLM
         3wMZhQYMnv6w/64NgJLhzoi0LpRA2b4LuvVCKxvsndTv5lMY1BpMxw7YRYKpGn+ctIsD
         1GbA==
X-Gm-Message-State: AOJu0YzztVa1VctEwsGwEDD48AttPENfCOmPFa/r47cPi81zAiAbDACe
	o9oWW0uZYaV8ZcYbBp99dD1cYe0KQx4ay4Jvi6/BJ1M6yRNNwE72+DDP0XC1yXWcnq946OE+3PK
	fzwtH7g==
X-Google-Smtp-Source: AGHT+IGBABKIvyK6ohXjB6IECMzQRRHEBlFZUwbn2ueKZVHeXRLBROEnxIeBxbpl3HVeYxpTImRyAA==
X-Received: by 2002:a17:907:9303:b0:a91:1699:f8eb with SMTP id a640c23a62f3a-a991d003859mr592277266b.28.1728137461899;
        Sat, 05 Oct 2024 07:11:01 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9943ea4936sm28936266b.174.2024.10.05.07.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 07:11:01 -0700 (PDT)
Message-ID: <0a34c5da-0d77-423a-85cb-36f5047d920a@blackwall.org>
Date: Sat, 5 Oct 2024 17:11:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] forwarding: bridge_mld.sh flaky after the merge window
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20241004121116.1b9a2e5e@kernel.org>
 <20241004121240.45358881@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241004121240.45358881@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/2024 22:12, Jakub Kicinski wrote:
> On Fri, 4 Oct 2024 12:11:16 -0700 Jakub Kicinski wrote:
>> Hi Nik!
>>
>> Looks like bridge_mld.sh got a little bit flaky after we pulled the
>> 6.12 merge window material (I'm just guessing it's the merge window
>> because it seems to have started last Thu after forwarding our trees):
>>
>> # 240.89 [+21.95] TEST: MLDv2 group ff02::cc exclude timeout                          [FAIL]
>> # 240.89 [+0.00] Entry 2001:db8:1::2 has zero timer succeeded, but should have failed
>>
>> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=bridge-mld-sh
>> https://netdev.bots.linux.dev/contest.html?executor=vmksft-forwarding-dbg&test=bridge-mld-sh
> 
> Hm, maybe the merge window is a coincidence, the IGMP test had been
> flaking in a similar way for a while:
> 
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-forwarding-dbg&test=bridge-igmp-sh

Hi,
Thanks for letting me know! I'm traveling over the weekend and will be able to
take a look next week. I'll see how we can improve the test, IIRC it has always
been problematic.

Cheers,
 Nik


