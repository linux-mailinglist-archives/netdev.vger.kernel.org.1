Return-Path: <netdev+bounces-201794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C01B0AEB16F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795DC1C2357C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6964225A3B;
	Fri, 27 Jun 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMXpKx5S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F021CFE0;
	Fri, 27 Jun 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013441; cv=none; b=TX81B8K47XYrMPd9yI9DV3Xul3Mzoa6DUpAD2X/twEsP8zd43EXj38irjzvJlO3F+4gfwf3W30ZPsMD21Zg6U3OGB2/UvVhFql3opmYfhH21fR1TVD5y73dXds6MK/UCr/+RvLMcGogjIlpdh4OBD2IoYPuV6qjFQXyv5ka0HvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013441; c=relaxed/simple;
	bh=sJAHb2TghzUXHygjM77alYZglQXhu4YVpw3AD+a2Q+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQ48BWVW01VH9yHQaMc/F4CjHff3C7Pi/A+peAVFprXP7/yfeMIsvNoiQujpnB/KVi2nIpFinY6VUrzSXm5L9uELRJoMZA/BOMaSpyQx9gIDw2qHKKCDPXGj46G4FklOs1iDtVdEsYTDtU1BstosN6hDBTSxK3F/T5TqtctlAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMXpKx5S; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23633a6ac50so26962975ad.2;
        Fri, 27 Jun 2025 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751013439; x=1751618239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejUiegE2X3ukRwPFKZGHBtzJZ34aWQ3nvB8dmcBQbUI=;
        b=kMXpKx5SR18gvv2jEdkeumG5ULb5hgKVSUeOOIeJvzMZ+Dn5Nc65I3z4tfAifUaWWl
         cZH4qmNShJ4VaHBM6MXNiUFCygQ2flrqY2YkuweZ/TphgeMe6fOKjOjBtypx5khe7aV/
         IYnGPKCJKHfExVcHc8cYvrr+66ePLL8gJxnk7J5XVnT0P3WRieTnWWvmZ8kCFny4EW/l
         6yAf5Q5ONlNNZBGs7C+KNuSR3YCRGrj5dqHw2wxmprCRnNZrkbKuRkjuOyF2xmcMbncY
         yC2yF/s5xMuzDYrqmn+nqaYeU0l4MciPdpmr+XIDiQDG2F94N0Vk9Evg7r9jh/Lt/ATq
         tr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751013439; x=1751618239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejUiegE2X3ukRwPFKZGHBtzJZ34aWQ3nvB8dmcBQbUI=;
        b=j54JA0DiPBFD2xqUbp3G0uFtDh9DyMO1Ct7yckYAa30DruJzj39oqJdRAcMDvZY36H
         Vg5HiDwooHMya21on/HwazE42kfBWFgSXiBVrY2oLTXsMjAM71DVNaBxmXGsSvhvuIcc
         T1u+z7U3JnPKh86eXohcZB51cSmFFdcFDcz98h9GjMcXswKxe4WB/bw84nDfaxZNC4GG
         kCbcLrdVdoaUClJY2Ks/0vVOqAvHYH5y1g6rFbHmssphZH4/0iieptHCIxL2UERJxI7Q
         IYLepJO7Y9XxlQxfq4n0O5r26aKTDy3h6360aywnHfpL1OYex5ZalpT06KP4WN1sG+48
         p2Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU19HuY1y8ezWYisIscyrmsU16EVVLACrg3yT93iAFXh4sbH9lJeR0gwOro+RdbwSZvjP42S2MYuv7UhAw=@vger.kernel.org, AJvYcCXBGVM/F9iy/4/efsuvhOHH3yPhSmHwbnfqHuvgUaXAzePuZu59BOSmpRZKUm7AatvcPfAnDBy7@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPSq+pGe4UeWac5O0qT/aoH3F2HvcIu57VhVgxKzWygOINVWe
	xkmdO9p1whfoRdJtvDwuJxKoD+cHS0VZW2L1qlnSumgAehl6ah+63idF
X-Gm-Gg: ASbGncuuPgV+HkKsxsME1Z9tFqemFmbw9lzGv8CYac3k6zyH8ynY0P5eiDh/m8NWaMs
	J8PTo+JLXJMzaII6t/nQ1zUFb8wZKD7BeOEQfuUFiXbBsH8t/MPoa0/JuuqrCXAX4x8YtTpBwHR
	sFiHJo+8pRDKerlcSb5Nywj6s6yh4k4GofZtHZimOdZQH1UBL2PTF89jbY1RwfANna2NPjjsnIT
	AsXMG9HD8i78hWZ0diaVebne74+u++CNlfsJAjKh8PA+OcLisz0Hzp6CPPg8JTxVCxvwzJJhKrD
	qPPJ4UKMJ9+W/bfgpw8LJwuJfV4PqjpWVz9QuuOt468dMHeshYhz8O1RW+j6XJaFE0UO3X9rTUh
	aSe+AMG3080+2tH9G9thVtxOM2vsUpa9W
X-Google-Smtp-Source: AGHT+IEGtQrXJSAqTgXcyZmdLvoa1U8J4o9PDfUogJp/ky+ptAnoKyDdpvNTf9PiKFC/aZRM3P964g==
X-Received: by 2002:a17:902:e54b:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23ac4627df9mr38520265ad.32.1751013439399;
        Fri, 27 Jun 2025 01:37:19 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c8948sm10870785ad.235.2025.06.27.01.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 01:37:19 -0700 (PDT)
Message-ID: <57be9f77-9a94-4cde-aacb-184cae111506@gmail.com>
Date: Fri, 27 Jun 2025 17:37:16 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/13] docs: parser_yaml.py: fix backward compatibility
 with old docutils
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
 <d00a73776167e486a1804cf87746fa342294c943.1750925410.git.mchehab+huawei@kernel.org>
 <ebdb0f12-0573-4023-bb7f-c51a94dedb27@gmail.com>
 <20250627084814.7f4a43d4@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250627084814.7f4a43d4@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[Dropping most CCs, +CC: Matthew]

Hi Mauro,

On Fri, 27 Jun 2025 08:48:14 +0200, Mauro Carvalho Chehab wrote:
> Hi Akira,
> 
> Em Fri, 27 Jun 2025 08:59:16 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
[...]

>>
>> opensuse/leap:15.6's Sphinx 4.2.0 has docutils 0.16 with it, but it is
>> python 3.6 base and it does't work with the ynl integration.
>> As opensuse/leap:15.6 provides Sphinx 7.2.6 (on top of python 3.11) as
>> an alternative, obsoleting it should be acceptable.  
> 
> Thank you for the tests! At changes.rst we updated the minimum
> python requirement to:
> 
> 	Python (optional)      3.9.x            python3 --version
> 
> So, I guess we can keep this way. 
> 
> The 3.9 requirement reflects the needs of most scripts. Still, for doc build, 
> the min requirement was to support f-string, so Python 3.6.
> 

Sorry, I was barking up the wrong tree.

An example of messages from opensuse/leap:15.6's Sphinx looks like this:

WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno -export ./fs/pstore/blk.c' processing failed with: AttributeError("'str' object has no attribute 'removesuffix'",)

The "removesuffix" is already there in scripts/lib/kdoc/kdoc_parser.py at
current docs-next.  It was added by commit 27ad33b6b349 ("kernel-doc: Fix
symbol matching for dropped suffixes") submitted by Matthew.

But I have to ask, do we really want the compatibility with python <3.9
restored?

        Thanks, Akira


