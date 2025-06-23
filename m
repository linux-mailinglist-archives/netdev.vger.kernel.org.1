Return-Path: <netdev+bounces-200326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7590EAE48C8
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977354441C5
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7B7263F;
	Mon, 23 Jun 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tiMXeZPl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7C1F94A
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692678; cv=none; b=FL2Spmz/UbBG35iMf8XQAoz7Dvkjsv7vPadmRJCCJEjxfVTku4fs6S5vtaKqhpO6qDrdKl0dxsEMpMZytK+n72z/LILaWeufVTH/xk2bwl94aIKmSe0Tjvbfdx4StI6dnlWZ+AsozUv290ax8SOlf7uvTNzNnPM8HeFkYFGQZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692678; c=relaxed/simple;
	bh=NWHWM1Pqtucp3gHEnFGY8WYlqpvbr3XTI0ZgdMOHlN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYYcVO2mWHLdinNbwM3qUcvBEuoKllgftn7bPXG+1ifJ0yoeemdU8DgC8itCIz2LY+BoaYRqdhx5I9S8AcOVV9alhrE1QPhFw9ErS1z38R7zaUQTwtBoOK77tNSV64j/KT/XtlvqjdFWWaAgKSVEuSSZjgNmplJmmjWcrNLih10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=tiMXeZPl; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73972a54919so3421532b3a.3
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1750692676; x=1751297476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0VvDc4304WGjFcUlx/oG+C/ew9wZgd54Tg0KTE1+xU=;
        b=tiMXeZPlq+vysyahDDimM4oQidELfJRbUfCBEzw2XDr+X6n3lgwqc+bdM6hIPHgW7M
         f6wA7VcOaMWlCLJor/TWxM+9mklzKT4QPYy0DH82DX/YZKZ9OHoWuCwRggg5SJc3bILI
         QWfbjljMBCnqrj1kOhfCWKFRDO9gkeoQRV1dKBkafTfuXxi1zle5plM5ANBLxU3R6Q8f
         nqkjs+E3qtwEzzP7DlDgJEbZudeqLEcph15+pHqgO8p9FVIRKUbHs3deMcJu1FKYK0ln
         GuY2LnHR2NogglRx4GBYviVvKwAL7R1ptrPBOaXkTaZS/N/YsNZXbErTriXcD6gazMHG
         ZoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692676; x=1751297476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0VvDc4304WGjFcUlx/oG+C/ew9wZgd54Tg0KTE1+xU=;
        b=unu0mdMEnTXiPqLOQe7SsDRQU/tM09VZjqMnQ2pkoZrETFzk236SVcWbJ/d1UTiF45
         9jNNBp1XPCORg1TwNV889qE1xsZrRllp3pK7ksqYpjFvwxmEG1Kj8PvaX02+YePrSuAP
         /dXo8n3k6K7hzURTXi+2DbIW8otcVz9epshM1cQy3zKXlJwczM9wT52084Cm0ohbwKR5
         1jqmw9Cys56f/LmpF7BbGK0IF3TD8E/c++0PgmXgXbaoNR7pbs4ORDaU7wUFX7/L8pMZ
         ZGO8DoGu3LetSafl6rx0n1kCXODshbhrolXShu899EHPjfk3JGDQZpH8+bILQWVnzgaJ
         aEqg==
X-Forwarded-Encrypted: i=1; AJvYcCVQR75oTnqvT1OgEhNfBmA5qK3EOoK0Sa7JqlaiNAQMgSWql/8v37udbNlxZWdVOFUoVCzwFpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUHuxgb8NzX03rTAN6MC52ehzY0lVXzO+FB2xvv+WdErLwKZE
	F8b/6Tw8W/igAdUkFPf2+vzmFMhwH1YJUrHCa3w4ssHCP/ByJGLDj8T8G19heVU9lw==
X-Gm-Gg: ASbGnctdynDF7TGMCmclLz3soj47Lq4ibykOevH6jTRv114BibH9TkHjxT2doZVvqqG
	+FhnDhfmYyAFxZVh9ga2fJI/tNHI2TTgW42TSDuMGNrJswSFPV5fl8SyCIV85CX/tVY4EEwMccs
	7EXcFPvGLVXhkVw5ti+GusCBXMgbjxpe3Vn4zHpyhnCLHBYwX5kYloqpg9Pk2ry5023APFEyTpf
	9hglK5ThigvcpWFZKE+IBNqE3a+YAATrGOrqrAar9oa9M/z0jVJTXqwrzu5XpwrwnIS8HO6/8rR
	KNRYuWOgqNgykPllfyDnrPKUkXoGTvCQoVTpB8vtNm91l7Kw1VVbAyuHV7Ih/yoLZNnsRz68Jhy
	FFygaAB/OvrGMDptta9zvc9C0r6xrvi1o
X-Google-Smtp-Source: AGHT+IF9wkdbm4qnQuOhFd8BEdA9RVR8VmLuOV9a1Ov1JbOfqMFzXdk1W43wj1mT9jgwVxlhWx2omg==
X-Received: by 2002:a05:6a21:328c:b0:215:f6ab:cf77 with SMTP id adf61e73a8af0-22026f66c17mr19788421637.23.1750692675799;
        Mon, 23 Jun 2025 08:31:15 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:b5c6:e4ec:de92:7d9d:474b? ([2804:7f1:e2c1:b5c6:e4ec:de92:7d9d:474b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f118ea01sm8211969a12.5.2025.06.23.08.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:31:15 -0700 (PDT)
Message-ID: <574038c3-7013-49a4-ba72-2b40fcec9e5e@mojatatu.com>
Date: Mon, 23 Jun 2025 12:31:09 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests/tc-testing: Add tests for restrictions
 on netem duplication
To: William Liu <will@willsroot.io>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pctammela@mojatatu.com,
 pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org,
 dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org
References: <20250622190344.446090-1-will@willsroot.io>
 <20250622190344.446090-2-will@willsroot.io>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250622190344.446090-2-will@willsroot.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Ensure that a duplicating netem cannot exist in a tree with other netems
> in both qdisc addition and change. This is meant to prevent the soft
> lockup and OOM loop scenario discussed in [1].

Can you add a new test case that checks for netem duplicate in 2 different
branches? Something similar to what test case "bf1d" is doing.

>  [...]
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> index 3c4444961488..e46a97e75f4b 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> @@ -336,5 +336,46 @@
>           "teardown": [
>               "$TC qdisc del dev $DUMMY handle 1: root"
>           ]
> +    },
> +    {
> +        "id": "d34d",
> +        "name": "NETEM test qdisc duplication restriction in qdisc tree",
> +        "category": ["qdisc", "netem"],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$IP link set lo up || true",
> +            "$TC qdisc add dev lo root handle 1: netem limit 1 duplicate 100%"

It would be better to use dummy instead of lo like the other test cases in
this file.

cheers,
Victor

