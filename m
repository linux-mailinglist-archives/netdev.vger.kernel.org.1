Return-Path: <netdev+bounces-132962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5047D993E61
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 07:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040191F24818
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19C013D2B2;
	Tue,  8 Oct 2024 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eILcyq4a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8D12C484
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365775; cv=none; b=MHYF90I0SoqyjUkxAwvvg0jrFlEPlD/tCnIzRxdaEY2ndhh6IBAed62YalRogE2JlGgzqZ6+rM/03HflPPDQn6Pco+WHMGzeQG3S0naeB7zdCESW4hXJbPVfBZNPGfT682hdep+qPYuIpTiRgv8hFor+5R81ZM52uVCxDXnzLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365775; c=relaxed/simple;
	bh=cF6P8Fub97mIM1E5Ohpi/qIOFTxeiG5Gs8tt3n6x7mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFqsvjUk1sJqDn55nWesKpRBkhyZl/0AS+cHhI5ypvJlKSdUIs3+5HPp4ByDY1YFPV9dXKrHRdVcsX+/SDWfWd/AOQEkt7E7Qbwgw0Hww5ymO87Z7TYRLBYo0U/FY0ZdwZ+M3Xkb7AErO13d+Y2thHC28yKHRbrYoE7n8I3kDMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eILcyq4a; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a994c322aefso345699366b.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 22:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728365773; x=1728970573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KO9ub1w5nNAwM24Y01DXsSHGRVZN0QGQs8COT5dKa/4=;
        b=eILcyq4aRR91IdDSaGRhQ86o+E0DWSKWYmC3EwRoFElqsWw5kBb3OL5yXlUj05qR5A
         4TRnZqt3/+aReriS004fuH3pNU7h13u6hOVSOiXV+62W4ja51fvGLNoU3yG4fgIsW+Kp
         uhKwTt0cS40SkgWRHDb/wDoGkyuI18l8n5ROTXcq9fOJG8ve2NlpOwSKH/i7ZUKYhKV7
         zoE/zauG9mxMPr323qiFp3Oq1GphAlFJGRVwszcNgS7EFml+8dT4aBx6LLDumIjqmQS3
         V47onZtRFM1tw7tEYPWh/7BLpMnAvzmRGmQbLj4kuP+rAnMEW8yEzuGJum+sBqw/34EC
         q/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728365773; x=1728970573;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO9ub1w5nNAwM24Y01DXsSHGRVZN0QGQs8COT5dKa/4=;
        b=Nd+y8MWOlUSVyt21JtRCAUddpYrQQ1rw0joqdRHes6kkeWgvwlHleyt2Zwbs4cv83K
         e8w4YyIaiwXItSwEB54+8J5PC1kOsN5EpdhyBDl82TT5bfqoqFPC/KQxWM8dRN0RLH/e
         52ATWU+qzegRVNGD6SD85D3bqxTvN0sggd8dL1gA1KFkCQAzCyV6aG6OsctHJBLkDtsB
         Iv+PqFiEhb3rY32uQufNzEbBuQqtEHRyis7mJiBwafll/W+ItYImqZKroJ5LRywmxnC1
         oNft+F+D42xw0/ES/jtCzSDt3X1RyodTU3pgtRLxEnjuMHDhlCQbjOiWxxfLNIyyV1KM
         /0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpIFUzFspYF2QkvZYFTJ8P0S4H4K34yw+UWD8PYa8ZTLDC8CCzo621L+r2VKk138p1L8Mq/Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBFLG1IwehaVkfHMwsNUErYtHYJkNXgERZUYh0AmEeVw/tGf9b
	ZtvxqqNB5Jf9B6uXrDBN8nmTepHmDNLUMXlACpjebo5IWwMlMWcV
X-Google-Smtp-Source: AGHT+IGJzvZVGBgXNZYoQ+XYo1gRz3ywvx/ROoUqU87WuUeqeFCSpz5138rRhcN/SEhKqARrNIQmqw==
X-Received: by 2002:a17:907:d06:b0:a8a:7884:c491 with SMTP id a640c23a62f3a-a99678d58a9mr181369066b.17.1728365772638;
        Mon, 07 Oct 2024 22:36:12 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a123:2000:60c6:f284:744e:80fd? (dynamic-2a02-3100-a123-2000-60c6-f284-744e-80fd.310.pool.telefonica.de. [2a02:3100:a123:2000:60c6:f284:744e:80fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e7d4d9csm462107466b.182.2024.10.07.22.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 22:36:12 -0700 (PDT)
Message-ID: <5e2c4d3b-4637-4418-9139-ad8f93061e55@gmail.com>
Date: Tue, 8 Oct 2024 07:36:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: add tally counter fields added with RTL8125
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <248a0f5f-46d8-42aa-971c-d7a410c7ba62@gmail.com>
 <20241007174714.548f2efc@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241007174714.548f2efc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.10.2024 02:47, Jakub Kicinski wrote:
> On Mon, 7 Oct 2024 20:42:23 +0200 Heiner Kallweit wrote:
>> RTL8125 added fields to the tally counter, what may result in the chip
>> dma'ing these new fields to unallocated memory. Therefore make sure
>> that the allocated memory area is big enough to hold all of the
>> tally counter values, even if we use only parts of it.
> 
> doesn't seem to apply

This version of the patch is meant to be applied to stable kernels up to 6.11.
I think I should have sent it to stable@vger.kernel.org directly.

