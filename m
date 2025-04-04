Return-Path: <netdev+bounces-179367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9504A7C1F1
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0063BA580
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7C020E33E;
	Fri,  4 Apr 2025 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aLMUIjik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE820A5DD
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785961; cv=none; b=rYJbLgBzvj8+HABrofRupzE40+LBmxfJykBisPbcCR3QuWWceauZzRKcesQDRbcX4WhhZ1mWXG966XIXi29Z0cwP2wMtMjmcEM6DY2Zlk34crbGPCg2rvBeTosmpUr1/1uNr+SJa/lOm/QotKpfVQCDZdXSNUMQl4KLR9OE8S/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785961; c=relaxed/simple;
	bh=6orBf0tWjAN0h2ap9fCQ3kxW1mVaVeuLLEcN16Pq4ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWieUVfkAkZWWp/F8HCK9mIaonHJsHIPQv1F7T13uSsWXG1w76E73VUaZdHa7tovlYhfvJmvOvR+D5XByzMPCg9T/FUZ7eBWQ6ahOdp5doAGlmFmEAPwXnSeO1yrLfHS/gniYVY86FvG3Zv+cJ04PZW31gyQUKMiKtFNgSLlrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=aLMUIjik; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7370a2d1981so1971613b3a.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743785959; x=1744390759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EJkZ+5p0OwMKFxcZxiu0Ugp/tGhgERzNtbTP090Mfo=;
        b=aLMUIjikRKZd5HktOPK30ndcXVp+ZLVGOZ970oSvvch6FAerMeN6ztGpE3T0yBI8p5
         GsuGXzq0ZmaVc83p3K5ViJkIS5DT/fRMNXvRy5KcEL+kpOV7bvxf2r7/xptDOlqL5nal
         CgpM7D8fCCnZxWAdTGw8Gi2wmOUnMr9pyTFGlZD4ANJzUzJm1058S4u2ORRN7Fz34TU8
         ts1ixybG+7rWqZeCU2MSmYifVYW8wRxZpm+k+iOfZQTeVe55yjnOHEf8YMyiAftifAoL
         ad9tu4kRg0kawQ5iOq9fTYfluVdJiJ2XLG1wv4SFXVhwjc+3wV0H6k1Ea3kdHAHAI6u5
         fonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743785959; x=1744390759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EJkZ+5p0OwMKFxcZxiu0Ugp/tGhgERzNtbTP090Mfo=;
        b=DVespcz8tANnCYAZz/E1T7Va5MhfpXKf9aWcHXEq2Z4mH+8xU5tQFsgWrw7u9YLLst
         AfgtQHq/XJUbmmRYuvhpBP+/zANkdWzQJKAWuWizMEJlSiNyJSW9IG2z2d75yIg8M+hq
         nM14B4COwkFUVdcPtETxehpY3OwJ3k0um0jZQ0CWsiOZzkE32uYRu9K2o/LhG+WHA2m8
         SzIQzR/+ZJn1qYoxkE38bjOlj59K5FPCrlmn8lr7MkjonlzpyG14z2d8SB/lho1Enf8+
         nx9Jp5BvgtozIs8bNerXVLqYoWrezO5/5Y0XfLAtdZ60IRL+vwFwFW2+pJKI0xgucUNr
         o74Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/H4o4OVQjzJx4AYDfTOZX3zJfOlFvP/0OugC6nJKHkd0QHD77Qts9s2OqatBQcH8NyuvRCRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxErIFiHNt4+XapQmvZAHXFtYp2IWfjeNA7eQbKZWlNtTV5iHr1
	0VrYQMP308wyBJwNgtrRz5NFDuXumvhTwUZGVjU5HyvocQVQxPmYwKRu0D/iCg==
X-Gm-Gg: ASbGncspS1N14cH+zvAPTtUC23kT76i6+ypo6W9rufmUbsdUTLtVNqsaa+6nHm9E4BW
	J6MG4PyGNlmt6OCO2Zsy6KdNEtyUSLe4/67LlaACF485nLOsOPjK2fC2fFJEktczrjR/GX76tXt
	7yn6zAdMmVcQuK5mHBbgVWob2NwaKlN4vj79d6OKKVHFGyUR3hchXQf7gS8dKAuNGpx2+2FoKs1
	Vjzptcuu/EbDBATJvm/Co7F5N5tZ8+RT3k5Pvfq5F6sXB/b2x/ozEec0K+Q88P1n3/sU2CIGSqR
	QzCA3FmrcdSkz3bS9526cQtUJ/UyY7XN9AhURpEGToVSxfpPS2lTxhGnP/A6NDOeqP7llGAgbgG
	sc/SP8wUvrHQ0QVU=
X-Google-Smtp-Source: AGHT+IGwt2wf5AhWsNM3K0g2AHJYist8vPSx3XFW+21NhWuwn0/ttNf00vhqt3vUodA4PCDEusOKjA==
X-Received: by 2002:a05:6a00:1489:b0:736:7960:981f with SMTP id d2e1a72fcca58-739e4816ed1mr6333263b3a.8.1743785959412;
        Fri, 04 Apr 2025 09:59:19 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:8485:ad62:3938:da65:566f? ([2804:7f1:e2c3:8485:ad62:3938:da65:566f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b4869sm3715484b3a.138.2025.04.04.09.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 09:59:19 -0700 (PDT)
Message-ID: <ed620812-fc0d-4bc3-954c-df43cbf4f179@mojatatu.com>
Date: Fri, 4 Apr 2025 13:59:16 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 10/11] selftests/tc-testing: Add a test case for
 FQ_CODEL with DRR parent
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, Pedro Tammela <pctammela@mojatatu.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-5-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250403211636.166257-5-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/04/2025 18:16, Cong Wang wrote:
> Add a test case for FQ_CODEL with DRR parent to verify packet drop
> behavior when the queue becomes empty. This helps ensure proper
> notification mechanisms between qdiscs.
> 
> Note this is best-effort, it is hard to play with those parameters
> perfectly to always trigger ->qlen_notify().
> 
> Cc: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

