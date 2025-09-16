Return-Path: <netdev+bounces-223628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E70CFB59BF4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E561BC7F88
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B947341AA1;
	Tue, 16 Sep 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkUUav01"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAD1C700D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036057; cv=none; b=Kzus5+jFx6tZKGX8mp0gWqrgWEPDk4u6oh+tvmNJGPoZE9etMhk8WWN6Hv/e2ZEEBp4UVpkIeHVXAUCE/YyyiIDU4TnPBvnZxSbH7o7YYopHlhjM4NvG+h18WkrQp3rp71KtBpUQ8N9PPHvlxw/bufcT/NG3Ex3oEiG0HJWEhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036057; c=relaxed/simple;
	bh=ESw1vFpHv7MXh6wDrZu1yv/n/9tn15nkfvDI8n+u9Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZtmNdYdMDrnvEqxYn9EU5/fGXcJZeIArMG18WWVaHcpuy1NdEsOCie/5HPGfmKgOcHqdXw8cdfAi6eFCF5Zk/M3cw49X2uqG0WLlPwEwg9f+2Vcye+E5U62ZzrLzirpjdYy1y+2MuaJYgKiv5BPeuQPcoEPTv4h/gYx8jZpdUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkUUav01; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3326d9ee5edso1817685fac.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036055; x=1758640855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTXRv6xQrRpLuyBqfQ0FDWexYwsFjBPKVjl1jrNBrL4=;
        b=VkUUav01AskVzTL8ePqfMLSgt8orbqYj2ZWpE7hfduamvL7SZIUB1zOE5lo+H/unqK
         o23NfrwxoBMH5+m/WYFAPTH6Wp1uAwY5+4s5JLPNZr71zSnNFqNyV88Ga+1mJBA/vklk
         4MZqFiPAHlhAl2Il1Dlo8v1aW4sRI7SOLFCY8hzqPU3KgupQuMbfqZpH7jZ2MTEFdCnK
         vFs6IdlGBk3+1HIRD3z5QNsoZJFsTn9TgJkJsDQkWVuoQdioM5q4+4X/1pNPD4yYe4FI
         O3z7z5mXvhX0GxFrC6o07nl1Z3L8tIrPVTtbn/uBveXa7PvEKaEwCEes9EkQSllLp5Ew
         OOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036055; x=1758640855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTXRv6xQrRpLuyBqfQ0FDWexYwsFjBPKVjl1jrNBrL4=;
        b=f5r5tYqWddER2Iir4KdS3L6sEWH4VqSuHziD6YH9tcqCN0439uZXWSILarVnlG+UfE
         WokT0b1iCE6YQSJnQrSQVpECfYS4EEe8vAhxMmJ+ntmJ5rKoiwDW+eo3O2fGM+kGl2OQ
         +2RAfnQBJvikqlPh1zLOGyxDFN/XUAbdNrmJCDuBVh2uOi9olxbZmiOc4/R/fRQG/Atd
         OYil+4U9Qp0fZq6RrW6MxosaikaP54ZWHOiG0TNxW5NpNaAS/ooLyrGxjYOsVDg3HbeH
         7ooEZiaXPtlIvB+U7sEcRmP26N0GIZgN1kAPnb9yBU4jVPqAEK8XJHehBjAejE97bjKR
         45hg==
X-Gm-Message-State: AOJu0Yx9sgHf0xjhhDf3Y5fDasyuAm0qY4j5N4WkgcKmJlfRE3TtweSw
	64ZTZRghC8H0dtuL6OrARz56pkZMxUm/JUhJ84qBkAQbiN+/r8ScBmsbQe5eSA==
X-Gm-Gg: ASbGncvAYtjTM3vSJfBrEsrDBBr5ypk0BuK5VqSON5xuqYZCZrpeSARsxJZqoiroI2x
	AccnRB5ocUAEDHEW5+I9wus7uRV4w8IKEn2IjPlBDNjOJtQNNi2PsbtsMjLjc8H+dBBiHVztXnk
	aWAQ482B6MyeOwBDSroG6BVJ5KzPGxwfcfdpsxfIQ4z9yDb9/SsLnAeXTUI/Az5/eqM7EQbYCvk
	wPhL3J6GYlwUNGYFtHZ3ghNL43pM1+PFr3Ec8zzJPO5vwZxXQ3wZyBQ2o8+D/D5+lU3x17sXhRT
	JjHd06/wfChwGPw9VcIMjjIwpE8BBsRaVuWy9xX2sJ5EyMIIvZkG0zezkzrZQLcDbffg/Idv7Os
	u9tTJtHTBI29wDwnI8p1Oa0NRKnXTUQXPL7QRMsx92kVa0T/4UsAssBVCgB5bSinMAnuzc/Uitv
	+JDNNX81hH
X-Google-Smtp-Source: AGHT+IHdHTQsojrHc/+/OeOoaUJOrCy/fzFIra2qaew8vXBn2xI7y4CCegiIDJP7TBpD2knvCFNxBg==
X-Received: by 2002:a05:6870:8919:b0:321:2772:dd7 with SMTP id 586e51a60fabf-32e567c45d8mr7128370fac.18.1758036054878;
        Tue, 16 Sep 2025 08:20:54 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:a4da:effc:65ff:6899? ([2601:282:1e02:1040:a4da:effc:65ff:6899])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-32d32d57474sm4827043fac.4.2025.09.16.08.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 08:20:53 -0700 (PDT)
Message-ID: <e18eec60-2f15-4725-a2eb-9a0ab04e9401@gmail.com>
Date: Tue, 16 Sep 2025 09:20:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 1/2] scripts: Add uapi header import script
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
 <20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
 <20250916074028.1e161f5d@hermes.local>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250916074028.1e161f5d@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 8:40 AM, Stephen Hemminger wrote:
> On Tue, 09 Sep 2025 15:21:42 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
> 
>> Add a script to automate importing Linux UAPI headers from kernel source.
>> The script handles dependency resolution and creates a commit with proper
>> attribution, similar to the ethtool project approach.
>>
>> Usage:
>>     $ LINUX_GIT="$LINUX_PATH" iproute2-import-uapi [commit]
>>
>> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> This script doesn't handle the fact that kernel headers for iproute
> exist in multiple locations because rdma and vduse.

rdma and vdpa are not synced from net-next.

