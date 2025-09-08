Return-Path: <netdev+bounces-220981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3863CB49BD7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 23:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43A73BDB06
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3232D2DF14E;
	Mon,  8 Sep 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYqNc3fM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5792DEA9D;
	Mon,  8 Sep 2025 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366779; cv=none; b=QCcttvOQQWHqzMQtSAnsVfOAhzUsAm2lXADURudNeb2A8OAidmsBPbxTH2VWMk9cZYDKyjRddRcwf0VH7v/GFHoC5lN8ZRtvPOQWBhWeAYpOu3tEPRnNfVo2ITXo9WWxtotA80bcMlm3P39B9y/+h0dQvRQjZIy1GnLtzZx4bYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366779; c=relaxed/simple;
	bh=UUB0veYH+bqWgzPjNZuJN2TZDYzF0MN3JD4GfWNivrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5NobOfECBtnoVUBsgwL2r4/qFgFu4AHjFnjZpcnqhYp7kKqqL0+siNlA2uNbjkuewARTJkm/X3YKyqrcJK+yDmk5Wiv7b22zfjxTPa9HfXjrNb5DtZ61ECyNGiwqzswCr5muZfPQMu18cWxwu0uSVA70j5YYmcYRqxx6erkJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYqNc3fM; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7459de59821so4312461a34.1;
        Mon, 08 Sep 2025 14:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757366774; x=1757971574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUB0veYH+bqWgzPjNZuJN2TZDYzF0MN3JD4GfWNivrQ=;
        b=hYqNc3fM6z9yLObAgij1RqwaBczAw/nX9nnV65RWi0wwGUS3OwykKgAQuE2uEyPshd
         iwLvkE+2erCo0t9Q4ysf0FK14lLJPTO7JDhUbQZbILBdJdumZjSS5ooXmsESa61Y2ziD
         HmySC+MmOooLbq/tk4BaZiGMGBq9KDGlWvLfuDWZsSy/bWZWGTLmtSzopw6kkIq0Z5er
         Q6QXz5GysLsBLirE65evoa0QezR5ogYV4dIWfeCQUECKYsNx64vU+3oyM2V+yPMFb84I
         lDGTo/AvcEM2iEal27xJzZp2SKWutZ0bRIOtmDKyzn3p4wuA/C0BWsb0YrRvKgijE9/y
         q+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757366774; x=1757971574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUB0veYH+bqWgzPjNZuJN2TZDYzF0MN3JD4GfWNivrQ=;
        b=wgK3DkjmJXxIW3LYdm8xz1KcPutJ46NzG7dtFAc5UqLGbQMgb8J7ySqzoEvhAbNkfQ
         yWHgM6M/DAJBzXSAtRq8ZByHJ0RwapAdTZiEopAols9G+b/lmt6cW0md/+cC1WTKOcaz
         nGdcDd0K8z8TewT86EXMxCa5nKPpcAJaAfJm5JfbNjgBjJF5G1bzrlF1ab9F9elypjaw
         N5iCNPdt3Ewe9ofN5oVAen+KkUCp/rctpPG9oVMkFwMgQOOUoCjLMEpVr1d+gPKiK2XX
         DKBWae2h8dD7k7k4WdaJTjv76UZU/wf+r25OQZWrEZ1wtD1VKxS6grOTaa87X0SwkYSd
         2ahg==
X-Forwarded-Encrypted: i=1; AJvYcCUrk6ZmaKdsrU85CuuABV+cN6geIy0hfVVjdrfUNeqnQPhwYrXUZdmjAnB2S/phASYpBQ59aI0zmDVFfbw=@vger.kernel.org, AJvYcCWaWuxhzlNF7cBGblWjyB/kRZ2W3YVQHqRZec8Kftioyf2S8UuJg6W8m/WSynX5T5b+lhQhboFd@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcXZpeCTsEguDcjC7EGChOFGJHIqanZ+vUt0H1jp9XZTTrC/H
	ryQCnsQO4b3OSp3B1nXk3dMY6I9//CarLgSf4EvsGQesb3R3GwdMNpqr
X-Gm-Gg: ASbGnct7QNAaR/wLunEarLjayb/PULaIM+RSb50Jsyy3SygiCXi3q92PRciGbw+jgyY
	18zGUrO6XVe1LkzpW4OtdULVpfbDyKqrovwCd4PWRn1VBBc7vXUEOTX8ZBPsLbFg4CGi8lLTGRH
	Z2mbV/wk9CRNtqf/6TlmA8BFmNpAiD7eRwuH5CyCTlU99KVcuK7iYmg5WAAXmomKxg98FMx9g6/
	6ZhSqu2k9L3K65aS3ZEtE2BcDVftlpFe8AisgrFm1CpAn68xwWn5OknhjFBlgxXWqpJn3z6/t0z
	Zpiw3K7F7WLS8bUThUWcCrA1VF6zA3wLbdA4jNdooVSS8S34QnheeLDibewg3/YH85fhXYXmU2z
	wAnZ7AMAWaRuNU1YMYigFjplZmRz6F5sbMwl9J0wEHGzTRzRYzw4SlPbkvaUNOOZN3gejxTZrBG
	O1jT/fBQU=
X-Google-Smtp-Source: AGHT+IFhzU2T4sRDSRif0/yx0zNydnoyQ32oyYbgQvBRk2gH0BNEAEY7tq1f+nM+nEQwHvF7FCm/ng==
X-Received: by 2002:a05:6808:2205:b0:438:3a9c:af62 with SMTP id 5614622812f47-43b29b04fffmr4225487b6e.41.1757366774567;
        Mon, 08 Sep 2025 14:26:14 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:de8e:bfef:ceaf:b2c? ([2603:8080:7400:36da:de8e:bfef:ceaf:b2c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-438383d04f1sm3767120b6e.13.2025.09.08.14.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 14:26:13 -0700 (PDT)
Message-ID: <49b975a6-25ad-4c11-a221-952b466d267e@gmail.com>
Date: Mon, 8 Sep 2025 16:26:12 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from
 counter to jiffies
To: Hangbin Liu <liuhangbin@gmail.com>, Carlos Bilbao <bilbao@vt.edu>
Cc: carlos.bilbao@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sforshee@kernel.org
References: <20250715205733.50911-1-carlos.bilbao@kernel.org>
 <c9eac8f6-8e7f-4ed0-b34d-5dc50be8078f@vt.edu> <aJIDoJ4Fp9AWbKWI@fedora>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <aJIDoJ4Fp9AWbKWI@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Hangbin,

On 8/5/25 08:14, Hangbin Liu wrote:
> On Tue, Jul 15, 2025 at 03:59:39PM -0500, Carlos Bilbao wrote:
>> FYI, I was able to test this locally but couldn’t find any kselftests to
>> stress the bonding state machine. If anyone knows of additional ways to
>> test it, I’d be happy to run them.
> Hi Carlos,
>
> I have wrote a tool[1] to do lacp simulation and state injection. Feel free to
> try it and open feature requests.


Very cool, thanks for the effort! If you’d like to run my bonding patch
through your new tool, I’ll be happy to add your Tested-by tag.

>
> [1] lacpd: https://github.com/liuhangbin/lacpd
>
> Thanks
> Hangbin


Thanks,

Carlos


