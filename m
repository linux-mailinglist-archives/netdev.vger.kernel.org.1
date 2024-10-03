Return-Path: <netdev+bounces-131581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BB198EEDE
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352CF1C21117
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D64E15E5D3;
	Thu,  3 Oct 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="oNdV4DMF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE313D245
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957614; cv=none; b=lbY4v7xw6eS0UJjQIlDO/xdgbLJ1qD9D7drTam3BDXwek/EvozcGt4BdjTLlBPaNMe1iGboroG9opbJvcvL05oNfQoE7MesG093OgXmXBoLIN0kuBw+Ua1pIwCo93ZGsKSQVcGxsGCOIkfRkOoum2HngopA++vhYzRdWEG0IUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957614; c=relaxed/simple;
	bh=0JRWiIm1wsUzGMnRVIEwuvITvoPDex1LR0Zl3qSdduY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J79WH+ceLxLH8LuyUhejvDNOqZ8MEmW4hCMxXdARc2ldd6nfuatN0W7lZbCicbtUyp4fooLljp7Ncml9O9z1I4nXgX2qj8NjZtudXwMRLTt3rIH+YNqidkRokWBYB3UTmir0oE8b9unN50MmIlOIAe/uhr4uOKcQ0RzXUFI+hCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=oNdV4DMF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso12164911fa.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 05:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1727957611; x=1728562411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b97+BR5G8ZkUORarwRJeakZJao5ZnHod3R7d7TH968g=;
        b=oNdV4DMFS5A6LYvvbdmZ1SL+02Nov5rZFGTPCGlcq4qf95P/USLDY0CCmWIqgFkUnP
         iakep66vRUW1vf2feArkDE3jNtFwYQzDnxl2LMISMoXuz8xew6qygzpmW+HBEe4ODIRS
         rhQ7meA+f7G1jgkhh8UaX1h+EddYTk9mMDKUzNTanhs0CPISFlvdbIvEB/E69PMe7mMq
         f6Q6eRbkMZCGqwYOjXw9JvWWpVlfw0KTqcmW4tpg+7dfqgmztedOk5b48xn5u5iaKjyW
         P+yv+K6DBfMVRDKuPavqfDGSttyPOVsisG8/iat7QJgZn4y9Us/I1NxxAL2o6bA4RC8+
         l22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727957611; x=1728562411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b97+BR5G8ZkUORarwRJeakZJao5ZnHod3R7d7TH968g=;
        b=JKJIyuN6jWMID3Yg5cju6vjLCddeTDHbgRizZGhy1HcX++RlYDQCpqiwAWNwXGHDU7
         c135+nw0HLs6hBN6E0TBxRGWS+Z6NlpM20vKGkFA62Us/WHJBiWjOe4Q2+2IogLkaWD1
         48CXp/7hkFj7+e30Svd/FTHNWfm2DWxROXUWA/Z2JnT6ErO20gnmsTblwQsvCNXjaqPu
         C8I1ZI/z/X3RkXdwL3CSruaPaxbpAeHlw2XLUcZquSfAh3r0i/zlBtRzsuQOi5hpZm7+
         APXXDOjqjEnvqmGuN177g0SgaeSSItjudp6aRn9FmtA3AJccvEsvSlUMQTcGTVqoEERF
         Jl8g==
X-Forwarded-Encrypted: i=1; AJvYcCXZwnYuftIgif33tbTWBCMU1b8twep2pjJc5F96KpVeLanpdVHSB89aYcZ8j9G2xZtcx7nffLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMwMU2dPjWF2dmtWqibAIEvgjslpasAdewwFha/VpUuoLono1
	2S4Ha8RojRwILWXRw58wqj2eqRpBwtEQm4BWSTXVfJIHK77b/ULaV7XSXQDnXjKAEH0sWTcBwre
	+
X-Google-Smtp-Source: AGHT+IFOZQM6odLRrQlPtdJ6oDdY9Rge1x2xyjlrwcLKcNHV6Kz9E8k8/XHrs1r2nWjWt4MRhV8ThQ==
X-Received: by 2002:a2e:b8cb:0:b0:2fa:ca00:80d2 with SMTP id 38308e7fff4ca-2fae0ffccc3mr46567761fa.2.1727957610717;
        Thu, 03 Oct 2024 05:13:30 -0700 (PDT)
Received: from [192.168.1.18] (176.111.185.181.kyiv.nat.volia.net. [176.111.185.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faecc6c18dsm2024991fa.97.2024.10.03.05.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 05:13:30 -0700 (PDT)
Message-ID: <139a3e30-c5c3-4b9e-8e33-ec348fb33197@blackwall.org>
Date: Thu, 3 Oct 2024 15:13:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: add regression test for br_netfilter
 panic
To: Andy Roulin <aroulin@nvidia.com>, netdev@vger.kernel.org
Cc: pablo@netfilter.org, kadlec@netfilter.org, roopa@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, idosch@nvidia.com, petrm@nvidia.com
References: <20241001154400.22787-1-aroulin@nvidia.com>
 <20241001154400.22787-3-aroulin@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241001154400.22787-3-aroulin@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 18:44, Andy Roulin wrote:
> Add a new netfilter selftests to test against br_netfilter panics when
> VxLAN single-device is used together with untagged traffic and high MTU.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Andy Roulin <aroulin@nvidia.com>
> ---
>  .../testing/selftests/net/netfilter/Makefile  |   1 +
>  tools/testing/selftests/net/netfilter/config  |   2 +
>  .../selftests/net/netfilter/vxlan_mtu_frag.sh | 121 ++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100755 tools/testing/selftests/net/netfilter/vxlan_mtu_frag.sh
> 

Always happy to see new tests, thanks!

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



