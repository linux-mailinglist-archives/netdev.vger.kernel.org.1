Return-Path: <netdev+bounces-237692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEBBC4F034
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3A734E20A1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191F536C584;
	Tue, 11 Nov 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL/G8kH8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9717A2FB
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878183; cv=none; b=D7avGs3fLpOFX9yuZjaKvm2OViBZnjbFLkqBFr1zyT2yiOOUL2DNBrKfeu1Ry6EbO0ZYVPhOkMHHMf/gVjB2uI5F24HWZLkh1kSbWZgLeVD1OGLsPTPIXaDJyIbSXBHcQ+c2RMbmM4Slp6p01l95PS39ScrndOKZQZTJnl8YzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878183; c=relaxed/simple;
	bh=C0ljOlhWjxilin5kH+KEY/abTrp4fy30VKx1w09jdUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kqqw9rGsTYl7A3GtpGwdGeiVYgiZceCA9W84aY07IgdkWnFyUri1Arpk1J8B46T5MpvjcEHPNM6sWZghNGK4uS/MBXelBpwlWDVwdhS5veV1Ik4qE6zIUGIZpc62XiFqmlZSsfkTsNfhB0esHwT2bj2fNEyoLMiZhMu6j27rXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL/G8kH8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2958db8ae4fso37375475ad.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762878181; x=1763482981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0ljOlhWjxilin5kH+KEY/abTrp4fy30VKx1w09jdUY=;
        b=iL/G8kH81/IVaSdfe7lXOFWjh9H4zjgAEAoxS76cOnW6kGhhpZqTUbkxRjmxoO2kRQ
         iNu6hnMTSPicDUPPK9/LM8OG+IovhjVYHfJA7zi+7czQUeL5sPEug4sw+iJ686cNXNCJ
         SOqYcm7Zbfl8jeY0pye58C9ojZf9Tn4OaxwWFpI1jCArPuvs60534LRLL9suYx2w+el6
         UYNuIrPiWVKLXO7/oAjtPgVPgOWLRT6wdOJWf5rjJpXBh+rLHQ53J6/kbnoqcTOsVgrr
         SgiCGejzYNEyR40HeQHOem++GcRtbbCxJUEM5GwnBhKP6ngCh59/jA/b8qJCtTDBDFe8
         eXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878181; x=1763482981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0ljOlhWjxilin5kH+KEY/abTrp4fy30VKx1w09jdUY=;
        b=HufLVovFX7YLWyrmvptNP2jXWSM6p3Hqp3urHGbN10aGcp1Ui/Wgy0n0af0s9pGyte
         oIY1Y+NPQmf2YHeMdsBQ1evr5MlPDzG5COCkcnuvWuY4HzwxV+UYFmJQSj7E1I6FwfP3
         AAbPRSgaiMGCdHYofjZpNH5tA9f37rl3vvjB/pzROkk5nM42Yfrdtd7wx466JZTO9BMa
         3GQyrvBj06Swn+NAUN25p34WpKfhQUkca+OZLpsHcZKxVuv5ytTv1bMq09GIWq2yi9qh
         MjvQirhdj5g1fyedw7i5i1ZS2+pOGWs8zJfKJFfD7P4VdWM+jiYAg2pm4klv98Xxfhbq
         oKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhqee5m2BCBa+BMhtZgBmfN0iHWCtsbCEeNUtHLdp7i0/m1XTA7mMCiid4migfIRI4uS4OH/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx75yMktrOTJ7BC0jVqEDuYKsgRQ04wVZhJSC5l2EU8K5c+aIJQ
	8YBZtHIFihbdiiDXinUk9hH9bjXfk2vSg1qBl2qjglqMCcuCZjaBmCdM
X-Gm-Gg: ASbGnctcp6q24QwdKcNuZ65XUECDHlDYHCLSFvzBL2aQtgrbgqyoFY+gAPmdLwmzXDy
	duT29rTndpQdgp0bpshghou4GNC/6aCVUadI2lMbvREiQcVkz1882TrSmOll6OQJhGZbHn60oom
	HWVmusuTnx1tTz9hzkaZ2gCbBAsApw67KyjEjbDmwDcUPCUSozF+nPo9VF2w43EGY24QdFvej5V
	+nZ3+pKdK/b96WJOZHRWmTXaiAIC2JMAnTZ7CtT90n64s9fiRbdS0DIf0NMqT10GBVm+HfeETnR
	korP7G2WzmR8yEjYTpvRf5Fn7X1+rf09a0na/e7A/EkXETga7vEG5h6/3fupeuQQHDBc1b8d5m8
	OmxrQz28OwxXAliQKSaQDpxrvlnHRmuHgTsHSSau+ALAwMVJt5pGZJhExSfEigR532a079DbK1R
	Bppg7qUY96dhVm6E/pa5rM3PE=
X-Google-Smtp-Source: AGHT+IEIxU6B/C+/gaE5krPsjCGJbHME9xr/mVp0iRWSOeqny304a0jPzv72fNDwODfJiyMz4oZbcQ==
X-Received: by 2002:a17:903:19cf:b0:297:db6a:a82d with SMTP id d9443c01a7336-297e5668a96mr169381405ad.26.1762878180793;
        Tue, 11 Nov 2025 08:23:00 -0800 (PST)
Received: from [192.168.1.3] ([223.181.109.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf54e6sm1713765ad.37.2025.11.11.08.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:23:00 -0800 (PST)
Message-ID: <fc82ba95-2c9c-454b-9d32-8f5639671822@gmail.com>
Date: Tue, 11 Nov 2025 21:52:50 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fealnx: fixed possible out of band acces to an array
To: Ilya Krutskih <devsec@tpz.ru>, sdl@secdev.space
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tglx@linutronix.de, mingo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251110134423.432612-1-devsec@tpz.ru>
Content-Language: en-US
From: I Viswanath <viswanathiyyappan@gmail.com>
In-Reply-To: <20251110134423.432612-1-devsec@tpz.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/11/25 19:14, Ilya Krutskih wrote:
> fixed possible out of band access to an array
> If the fealnx_init_one() function is called more than MAX_UNITS times
> or card_idx is less than zero

The code already validates against the >= MAX_UNITS case and card_idx
can never be less than zero at those points under normal circumstances, making
this patch unnecessary.

However, card_idx will overflow with enough calls and that is something
that should probably be fixed


