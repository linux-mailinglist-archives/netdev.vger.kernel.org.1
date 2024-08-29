Return-Path: <netdev+bounces-123366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4549649FD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D85B282133
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764641B1D72;
	Thu, 29 Aug 2024 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ItGVR7pC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4851AE854
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945276; cv=none; b=QpbS0kW4R74o909haebyOB3P8hOz442d0vw8y39OOL+3ZZOOHYtqbp5lUfmvT3rOpAmQB9VnME9hdgEEav0u1Uw49hgXhngBAY/dGGKp8dwZ66yy1NX8RFAbyLDDUGRic9T4M4Ufyo1LWdcxhvzMAtUZsf2cWwBQZo2LWVzCr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945276; c=relaxed/simple;
	bh=tRokqt+GOmx9sDn8JqOLZjGmYY7taAR7cm+0h+E3h+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwo/PncGtu0qqE1lSyrY2N1oLGL6O4UKwyZSTBiyxK1U++QTX8aFmuIPr8zZXpaqLTJFDSojd4Pmsa2Kbb9S2IOXKeuYyuOQjXOCPOK6iSktbEMPdvAvonMv2j3jt4H4Z4UiW+5u50GHdCus4M8yYJSCCoRd02orFO/oBXb3c+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ItGVR7pC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8696e9bd24so103691966b.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724945273; x=1725550073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2jct9mt2CfCfjn41Js5/oCqYM+gziBIReSZS4ygZQg=;
        b=ItGVR7pCBfCPrIdhzDjYAe6unXRhn5balCFeFVqhfXAIsBh6sdVYykSOwK3QsYmFyx
         3pZoOrvELjniMWD7PECil29EfM1fA8hc/eEU0NoKV1mZHURNpErvm3I5em/yW5JZ1tjb
         soE3Vq8TnAuOvwj7KJsXteeXkxeD8UdnAjozp/Gjf0+KortgFDYSk4agXu0u5wATVzUJ
         aPu2btp00wVJz+oj9eZ4ujrQRJgTrLIW6Vzn7miRBoWuHZSHvtKRS2K90wAdpHLjkE7D
         RzFdmQ+OmSSyDYkFlnN1qSjDw7iY+53PzMCa0cSMpgRWs7jD4knWac6nrOzUz2nM1U66
         ZT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945273; x=1725550073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2jct9mt2CfCfjn41Js5/oCqYM+gziBIReSZS4ygZQg=;
        b=GAW4YGRefSJmqmlgWKgsUvO+UjZ+rer6SXiT6PKbXRpwKoOYSs8n9QWrvgSUSlFbkV
         lF78pt+CblyaaATvEKxBv+Jqda6uyryc9AE57xQiKhN2qMcW5z4KYDefaYgPDQTtdhfY
         5oJLQd7K5qFnvTg67Sk3CJEOb+luOtIw+WnS7dRLlwkl0H3ZP4z5q1faIOSvsq+F61Lk
         ThoggGHucCM3NSomQx50SnZJ6p+uxrZ5WTo92/eRGAN9XoXRVDUJ6vCgSeawJE8IF80j
         hnsX2nXFHUP8z6+ARypFqg4e0/ZL9oCI2w3v2W02od7W+BmJ2VpaVtp/8fwVnuUsauH/
         Okfw==
X-Gm-Message-State: AOJu0YwepNpig1T2KGIjFnmx+bieFCMaCaGKvQSew9KX826l0C0Hn4Nu
	FhNggqGIAJNEP+GdMjfiKpa3UXVVYiKpZeaXjPJOp5FgPZMmzX1dPrThJKzgsdY=
X-Google-Smtp-Source: AGHT+IG6CE4bRBHCFzW4p/RUhNwgsV0732Dtt34yk/Rn99V9FPbCrXpW+wHJ7f/oZsADu/vxvtc5Mg==
X-Received: by 2002:a17:907:9485:b0:a86:a41c:29b with SMTP id a640c23a62f3a-a897f78cc4emr285884366b.8.1724945272288;
        Thu, 29 Aug 2024 08:27:52 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891963c1sm90381166b.103.2024.08.29.08.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 08:27:51 -0700 (PDT)
Message-ID: <5347c7b2-cbd3-4fc2-9794-6dcad4b9aae7@blackwall.org>
Date: Thu, 29 Aug 2024 18:27:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] docs: netdev: document guidance on cleanup.h
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew@lunn.ch, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20240829152025.3203577-1-kuba@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240829152025.3203577-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/2024 18:20, Jakub Kicinski wrote:
> Document what was discussed multiple times on list and various
> virtual / in-person conversations. guard() being okay in functions
> <= 20 LoC is my own invention. If the function is trivial it should
> be fine, but feel free to disagree :)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/process/maintainer-netdev.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index fe8616397d63..ccd6c96a169b 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -392,6 +392,22 @@ When working in existing code which uses nonstandard formatting make
>  your code follow the most recent guidelines, so that eventually all code
>  in the domain of netdev is in the preferred format.
>  
> +Using device-managed and cleanup.h constructs
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Netdev remains skeptical about promises of all "auto-cleanup" APIs,
> +including even ``devm_`` helpers, historically. They are not the preferred
> +style of implementation, merely an acceptable one.
> +
> +Use of ``guard()`` is discouraged within any function longer than 20 lines,
> +``scoped_guard()`` is considered more readable. Using normal lock/unlock is
> +still (weakly) preferred.
> +
> +Low level cleanup constructs (such as ``__free()``) can be used when building
> +APIs and helpers, especially scoped interators. However, direct use of
> +``__free()`` within networking core and drivers is discouraged.
> +Similar guidance applies to declaring variables mid-function.
> +
>  Resending after review
>  ~~~~~~~~~~~~~~~~~~~~~~
>  

Definitely and strongly agree.
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


