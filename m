Return-Path: <netdev+bounces-132381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7579699173B
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6BE282E9F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58514B946;
	Sat,  5 Oct 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="dP2I432o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633331DFE1
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728137573; cv=none; b=geDyS9pz22ic0FeBtw4j/uVRDAkkYBaanryI+N0rv7zXn8oM4reQD0HyQLen2ri6EDEf8VUx/KtMsxGzuZjyYQ0ZHUwtx1u9C6QDtQISDnKcj34OSM2EX3gpeSIcvD4D8X2ALbSV4XRNaPGK0CEw43/pDA+O9+GnUCkmN/IbQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728137573; c=relaxed/simple;
	bh=c5qhGBgpvXA3HVtbvT1naUaXK5CeXNXhCvdf+EzldBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPBUW7/7jayecfKe/ksSLHVgCcxgpj1TNUiNqu0YGiwlHxlW+j2Hgdwv4Aa8wtmSBKgOrYdGqb5pPIh2cP5R1mLmczsFAb6yBtPduJDfcIlamBCsJ06Fb2WvRFJ0Da+OhR1FOw8YrttC0NOcsTFK4Q9Ckg95e7dszro8gpEIA08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=dP2I432o; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99422929c5so32902566b.0
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728137571; x=1728742371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAx91HabVu0Sy/zrAbJKZCyHJns0uGqh4/pEpeqAmzw=;
        b=dP2I432oJqsJKdRxsARGfOZ4/XScYKwPFF8UR0PmHXHbZoKiMOoqecDRtAefnXeRJ4
         QXbNROc1gb1HxvzsVLZV3ZF8wvvezY7qD+Zv73oU8nmLUxLLpTlGbZ3v7meerRtBqnuc
         F9PEhzm2VUpeEw9NU2R2qk2mxlyoqB0O7k/Ouerg7Lx9rRfCDjSWHoHGCFfXFiC0drPd
         vlEI5RkNwzj6e5N+5flFLjG1LwCKTrJhlcO/2GrH3FkPjTz8yee1ZKj0ydbYuG/FO/MB
         lGDncj9Ios/UQJ4HeYuV/TrTnX2hdcg/c2k24RlkFJnW3gNfG8Y8jzI5YKNn/5wV0xqF
         NHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728137571; x=1728742371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAx91HabVu0Sy/zrAbJKZCyHJns0uGqh4/pEpeqAmzw=;
        b=Vs8Jun4VQ2IX29woi4smT9E38g2wRNTnXwHWuPKBiEokHkaH1JqEJszbjGxoHRiXc6
         EbHQd8DOXH1M+LH8NPoINLIGsilkr6qfrt6cQfZxlXX7fj6o0AnXgpH1BNcQjMmuq2fo
         8d2S1rEqKyowAxWC2+yyTYigZ6/X7LVo41q6scUcPWaXuat+sFQ3NvNixhprrGaOOsmc
         bThgu5hR0JYTJOR2G6qIAWIvjwt6Jbr/2rXxZK09ghnjHRw/sjH9j7veB8wqw4/35DLU
         2WCLb0fAJfz6Rn3nGxuhHB/ihVj/u/JLjtoKGzztd1f6pACsSKy+l15C2z451EUzu/1d
         jsMw==
X-Forwarded-Encrypted: i=1; AJvYcCWmNd3l+ojFSvSZtNPj696NNCiVpfTnsVFMoK6AYC3ExqE6kAKzrKfaM4bPfNguiSTjC41+PjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkp6IGWcnvedjcdAPZvZRLQKs1kx9xzAzh6fi+XQj4DoZiz4y
	xnrZcvIv2CShLOf3eWDrLpQONvC8e0LEZnT94jEVwLcl3qyhk+bqNSyDku2JsvE=
X-Google-Smtp-Source: AGHT+IGOTjpbbwAcnG7FU1jl2+V2ayx9rzo8J43dGMn0b30mw7Hj1LTHmk+wm9KHs0Z75F/MoexuPA==
X-Received: by 2002:a17:907:3e13:b0:a99:3ed0:58ad with SMTP id a640c23a62f3a-a993ed0b560mr157226666b.64.1728137570569;
        Sat, 05 Oct 2024 07:12:50 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7b0ee9sm136938666b.155.2024.10.05.07.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 07:12:50 -0700 (PDT)
Message-ID: <1e739ce3-162f-4cdb-80b4-161e3c9583d8@blackwall.org>
Date: Sat, 5 Oct 2024 17:12:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/6] vxlan: Handle error of rtnl_register_module().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>
References: <20241004222358.79129-1-kuniyu@amazon.com>
 <20241004222358.79129-3-kuniyu@amazon.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241004222358.79129-3-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2024 01:23, Kuniyuki Iwashima wrote:
> Since introduced, vxlan_vnifilter_init() has been ignoring the
> returned value of rtnl_register_module(), which could fail.
> 
> Let's handle the errors by rtnl_register_module_many().
> 
> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: Roopa Prabhu <roopa@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c      |  6 +++++-
>  drivers/net/vxlan/vxlan_private.h   |  2 +-
>  drivers/net/vxlan/vxlan_vnifilter.c | 19 +++++++++----------
>  3 files changed, 15 insertions(+), 12 deletions(-)
> 

FWIW,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


