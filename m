Return-Path: <netdev+bounces-79561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E57879E25
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010431C208CA
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC42A143732;
	Tue, 12 Mar 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ITB2grNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2816FF3B
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281103; cv=none; b=cMT2mOJH3biHIK5UsWoJjQTd46cimZRiGpMpJvgZEYPy1DxwJm4qLt8+aNDLBHPLeVXoduNhMta94cP2kLaDpuf0r9StMCdp39AO8RKQs1rae9GL4ZlTI28kJ2Opb8815ZtYX97NqOLwVIj2MkYNlry6O7cJUdjOAEYuqTYCsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281103; c=relaxed/simple;
	bh=/PoB0RRVuC6fI46h4yzJnWSx0Jrl1UtqVAvu8WCoLKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PL2dryNotWw9q/BbcRKyVlJdyugb0mP5gaQ8607GZUAj55uUNcAI8IFtTq+1SH1+nuh6Ia5j69gK1W5CMWxkcx50won4Plzsa1robifDtbUAdewwtzE5O2vPmqNxl3cCgsQMyA3803dVLmsmmu/dT/VzLf+aMebsCUzPIJusCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ITB2grNF; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a19de33898so277251eaf.0
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1710281101; x=1710885901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wuc2v1ew0Tr1mD+CMcQ2s2sj7iFWQgYVx8fv+jAZi7g=;
        b=ITB2grNFdeXQSAO4YApvttgHr1jqCrEWk5p1D+W4E+LpcKlB9gnQoKYSpB++9IDR6z
         xPVejBwaVQJdeXQPc4mchthmK1ypi7fW8a/cK3JBKjUNtc9brxBe9PrlSa/PG9Fd5qfU
         C9yNDC347ChxAX2zrcLTxsw3ca77ZfHGl1TSw09UPagmkqBtD9wJV68A7hi6k36lrZB3
         hv2Jf99AoFDaSjFYyUWrLqsXaCcJQb4RrPelrzNABhH509kEyGy1uSwVUjxv5SXVA9iJ
         hDuaHJjxFG9lkBo+zJGAiP8pMm9DsgK+Oo2MNvFtOyedzeq/+ZkFZ8jXhRUIwGTWCg6l
         Q/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281101; x=1710885901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuc2v1ew0Tr1mD+CMcQ2s2sj7iFWQgYVx8fv+jAZi7g=;
        b=dkwGoZjv1DEx0SHIiGAlMHrtQ/uWdNkzIYIcysfo4+caJ8hg1xSF+Kq9gl58EZatY7
         48A0XZ3bduq5/qN0rmzmipaAvqQiE2XlfR/VU3SIxZbOW273DVs+1EdZIu8wUMShXU4I
         eGJgQ8uRm+m5gM+MtOpf8e//flWkd4VTef5yy5IVTbGh/l6uM/Ve9ytg9h5ssYVnfk1U
         MUVs/VAFihD/7bJs/EWkmZX4Ev7zhIOPM/5/juWscgF3qgFzNQW0LvxUciIIfRnF2Ux3
         uUCP7yvbLkEBl8SeEO0//vWxAk4HHFDuWYlo3RpafYeO0TZ4ewBd5MrFypRhN5UW2Tce
         SpeA==
X-Forwarded-Encrypted: i=1; AJvYcCXiQSdeo6LxHTaagg8jl0H97CuDjMZM8CJtzvLNXmp0bM63QBwF6ysvLJhRp4DqMLUOMFnxpGJbsYbcO+UHIOjlEEydHhBZ
X-Gm-Message-State: AOJu0YyA4wS7JM2WmAQqDRPL2Ux4jXk5R4NYjnhjurvU0uLf3ksrZlbD
	KFR9fDdUTSKwMCci5E2UFKUFyIMsZeg0XA9guOnNdgEDRDSvSjarI81x4iwMfts=
X-Google-Smtp-Source: AGHT+IE5K1+U+OtrBj9WPxI9SBLKISMj6BcI52gCOjXEINy6PfJyLdT0n0aGdbv/DI4lVZTyNG4eEw==
X-Received: by 2002:a05:6358:63a7:b0:17e:8a04:3fb3 with SMTP id k39-20020a05635863a700b0017e8a043fb3mr3621774rwh.12.1710281101437;
        Tue, 12 Mar 2024 15:05:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::6:d1e3])
        by smtp.gmail.com with ESMTPSA id cl12-20020a056a02098c00b005e438fe702dsm5679966pgb.65.2024.03.12.15.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 15:05:01 -0700 (PDT)
Message-ID: <7b1abd98-ee3c-416a-b929-ed4cc9d646b1@davidwei.uk>
Date: Tue, 12 Mar 2024 15:04:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] netdevsim: replace pr_err with
 {dev,netdev,}_err wherever possible
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240310015215.4011872-1-dw@davidwei.uk>
 <20240311130706.09f35fdd@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240311130706.09f35fdd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-11 13:07, Jakub Kicinski wrote:
> On Sat,  9 Mar 2024 17:52:15 -0800 David Wei wrote:
>> -		pr_err("Failed to get snapshot id\n");
>> +		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to get snapshot id\n");
> 
> We seem to use dev_err(&nsim_dev->nsim_bus_dev->dev, ...
> in quite a few places after this patch, how about we add a wrapper
> 
> #define nsim_err(ns_dev, args...) \
> 	dev_err(&(ns_dev)->nsim_bus_dev->dev(dev), ##args)
> ?

Yeah SG, I'll define it in netdevsim.h.

I'll re-send once net-next is open again.

