Return-Path: <netdev+bounces-84266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 786298962D8
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 05:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C38B21157
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372BF1C280;
	Wed,  3 Apr 2024 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="uQ2Pv3DJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DB3D76
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114118; cv=none; b=eN1FtHg+QgD7pSrsNVj3TibXWHGV55nWRqR8Ay10mYMe9xWuslcTe+/yv9w20wcEY4ocNt0iUE3bQTgC0dXMS5BaL6cn7A1NHXt3ePXfOAR8JdcZfdJVs+VMIwHaK/nvQ3f0dQVT7YumVNAApNqbzXicE+Bc+rtbDT4HwAGApZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114118; c=relaxed/simple;
	bh=rhItZwN75G6oWQNepD5zyIUv+JWDuJV8/Z273pSQfwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jI71wGYiaAv9Ry9asXsQnzG3ygId+V1LL4htYVyn+Y5dURDSzJTb00q8u3Wrcpdccy9LEpn+zNxVYmiCr5zkk5RbibzY7bP89lgbPLnZKMoZbmGoO9sD4CX6kMR2HAMzVoWkTJz467G02aVTrkJEdGMVC2YArukAAN3DnBWD4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=uQ2Pv3DJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6eae2b57ff2so4726416b3a.2
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 20:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712114116; x=1712718916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSfJ301mdLGN+rxQsT8MrWigdeMuMrF/VMl49aqsrKY=;
        b=uQ2Pv3DJhqqB+QQRQY6xnH9v9erZf6xUdseNjd9Z38/eV6V/eNzqJIkaKazpphaVuA
         EQxHCH/LSyZLiIwHmLh4lEwo9b7eOpz+7DxRu5+a7emFv0rT9NBh6MRpAr66BB6udshL
         c8cCVms94zhd2pzPhUpVfTZIxeie08JA9w0e999dFRT4SU317Viq8NCtYRzwjkkjp2QT
         axTJZ5nkTL2//FjXg1KdoE967+Wd82JdNOyencJNjy0i5pKrMm7l+Ay9PNsO1B4CDftl
         28pArbQJrUg5MZpbI2EAe3hy6xzf6ZVQHr4EgoK1Fz6IbCzCy82zQr68wTufIN/RKtmk
         eCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712114116; x=1712718916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSfJ301mdLGN+rxQsT8MrWigdeMuMrF/VMl49aqsrKY=;
        b=v7tHyBnTAsZhXCUF28gSfhLG/MCqa1BODmua49TqqTAmsRhX15pEiOSEjaZWVxm4Pi
         Z0DuwnKDWq7O/ub61zTOUPgrWoZ5W4BZf+oLhiUYU14TRsqYi5GTeSsXj4wotxU99fll
         0nNzEtaGn16fNexTPm+6gvS1mCt7dWSY67R9/wIbbfqmvxN6crNN9GClCOfiQW6B0eRD
         gr9wch145r2NY6qUzTzHA4yGHzoZJWRST1VW4yM8fwYVjt/jAqB6Lyogf1JwRCgw0HR2
         BEp45cJR4GcVtVhWXSilN3odxAMZ0CyBaHWvEUMMxBZrFL1MY5PLAdoTGmsC6TuH0Rcs
         UPrA==
X-Forwarded-Encrypted: i=1; AJvYcCXe5fqHVjjM+rdZqTVthqEiYWpDGo+9Ov/nxpMYzuIhxbjbc61fc7igmiIBBfBRKxwBg0gBCw149psWFl4UNnyJOqcpddQv
X-Gm-Message-State: AOJu0Yznqw/yZVSmBrlitNtIBybbzLBf0fXsUKQCc61cOtreLbkRY8td
	Pat8zHbyE9tfakQrfgTqxvCFQrvVihd8D4mv5PmMpzmur8Xig433NOmAuBK6ChM=
X-Google-Smtp-Source: AGHT+IH/yYkuyr+tosUb1a5Dd/qiahiL2LUEmeGr+PadGMpw/EkJlFtCF49+F9WxhkW9igYZrKHk5Q==
X-Received: by 2002:a05:6a20:8410:b0:1a5:6fde:7f28 with SMTP id c16-20020a056a20841000b001a56fde7f28mr17648723pzd.55.1712114116148;
        Tue, 02 Apr 2024 20:15:16 -0700 (PDT)
Received: from [192.168.1.26] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id lm10-20020a056a003c8a00b006e6b180d87asm10610784pfb.35.2024.04.02.20.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 20:15:15 -0700 (PDT)
Message-ID: <d98d058f-f933-49dd-93ec-f5e76f4215a4@davidwei.uk>
Date: Tue, 2 Apr 2024 20:15:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, sdf@google.com,
 donald.hunter@gmail.com, linux-kselftest@vger.kernel.org
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-8-kuba@kernel.org> <87bk6rit8f.fsf@nvidia.com>
 <20240402103111.7d190fb1@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240402103111.7d190fb1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-02 10:31, Jakub Kicinski wrote:
> On Tue, 2 Apr 2024 18:37:44 +0200 Petr Machata wrote:
>> Yeah, this would be usually done through context managers, as I mention
>> in the other e-mail. But then cfg would be lexically scoped, which IMHO
>> is a good thing, but then it needs to be passed around as an argument,
>> and that makes the ksft_run() invocation a bit messy:
>>
>>     with NetDrvEnv(__file__) as cfg:
>>         ksft_run([lambda: check_pause(cfg),
>>                   lambda: check_fec(cfg),
>>                   lambda: pkt_byte_sum(cfg)])
>>
>> Dunno, maybe it could forward *args **kwargs to the cases? But then it
>> loses some of the readability again.
> 
> Yes, I was wondering about that. It must be doable, IIRC 
> the multi-threading API "injects" args from a tuple.
> I was thinking something along the lines of:
> 
>     with NetDrvEnv(__file__) as cfg:
>         ksft_run([check_pause, check_fec, pkt_byte_sum],
>                  args=(cfg, ))
> 
> I got lazy, let me take a closer look. Another benefit
> will be that once we pass in "env" / cfg - we can "register" 
> objects in there for auto-cleanup (in the future, current
> tests don't need cleanup)

How about a TestSuite class as a context manager and individual tests
being methods? Then running the test suite runs all test cases and you
won't need to add each test case manually to ksft_run().

