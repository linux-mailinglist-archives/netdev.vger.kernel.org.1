Return-Path: <netdev+bounces-57032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FBF811AA5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E721F21958
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D93B282;
	Wed, 13 Dec 2023 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSiKCg/x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79CC9
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:16:51 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d2eb06ab11so31732345ad.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702487811; x=1703092611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFnAfKNrjXCR5x/wWexh4dw6Ec4XwcEWg3d5fSGyhn8=;
        b=mSiKCg/xFq8auiLQAfCxp2iu5xWDhAlkLA+UwtgOd9P4YMw4LZVtjZpx0lqhh3465F
         W9wOsanES1KrzP2YWsj6iroZi0zot7AXaM5THLavaB091oUuWqYvsQUbQ5/JYeaUyg4X
         GxOatO5uF6mznwqBmOGa4nEN/PXrr+YPpKMH+601fO3jmDAHPgDwbIbIUl7NOlNoPMW/
         O62Z5Bijv2CS6AAGm8MSYEK1Gb5f7Po6qR2akQvIIDIH9QjmbbWe3OIyXPbhzSVyGNgy
         C4HRavIZ7X3UVcsUeO775/byJkOyKIDVq5scK3PuFJVmqVBmZ8RuA/YGiFo18ysTEXyB
         fbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487811; x=1703092611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFnAfKNrjXCR5x/wWexh4dw6Ec4XwcEWg3d5fSGyhn8=;
        b=pmLTr9fLC0lKFrSARErMj1IcaRfC++JKX0L/UfrzIwkUd4A+M5gocHEJSPJG69NG3d
         u6oVCebIk7Mmc+Bl2gPpnym10X/XvFwK2wXdexo3hLUoi4iuIbUkpcwJUQE5240yg+Pq
         SY1n5YoVUSm4NS+ZkA4KXSIRh3EfGGSozMGqMhjf7kqIWmMOpbQRyGjO4rrLklZ3HJNw
         Df979CZRnXZszoAn7u1Y4YbYOrfC6QW9zao20aiwdPtNC6eROQdKW2YCKEGLiGaj37d5
         xEzNLaUHF9w6JbGiRKhnwWpHZd6zskYphowdBDl9AiDFR9opHIPTsXA6+45OuHDDmdb0
         XOSw==
X-Gm-Message-State: AOJu0YzaSYNEqzg0yJRa58ecG42CAuy/SwYx3+CbRK4sbcnSHDV8AC14
	+0NJdBy/njoBUDIBvHoPydiomR5reBc=
X-Google-Smtp-Source: AGHT+IHZiUJkIiPx28X5KhWKQTMSj+7ecoW3zc6jQ2TPHttDKQGxTfRxfeStGP6QlZRSEIHuM1C83Q==
X-Received: by 2002:a17:902:c20c:b0:1d1:cc72:be2e with SMTP id 12-20020a170902c20c00b001d1cc72be2emr4174345pll.73.1702487810832;
        Wed, 13 Dec 2023 09:16:50 -0800 (PST)
Received: from [10.20.85.164] ([72.164.175.30])
        by smtp.googlemail.com with ESMTPSA id ja1-20020a170902efc100b001d36225c865sm276678plb.226.2023.12.13.09.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 09:16:50 -0800 (PST)
Message-ID: <8368c084-6092-455e-8011-9d5bd4f2699d@gmail.com>
Date: Wed, 13 Dec 2023 09:16:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ss: Add support for dumping TCP
 bound-inactive sockets.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>, gnault@redhat.com
Cc: edumazet@google.com, mkubecek@suse.cz, netdev@vger.kernel.org
References: <87947b2975508804d4efc49b9380041288eaa0f6.1702301488.git.gnault@redhat.com>
 <20231211141917.42613-1-kuniyu@amazon.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231211141917.42613-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/23 7:19 AM, Kuniyuki Iwashima wrote:
>> diff --git a/misc/ss.c b/misc/ss.c
>> index 16ffb6c8..19adc1b7 100644
>> --- a/misc/ss.c
>> +++ b/misc/ss.c
>> @@ -210,6 +210,8 @@ enum {
>>  	SS_LAST_ACK,
>>  	SS_LISTEN,
>>  	SS_CLOSING,
>> +	SS_NEW_SYN_RECV,
> 
> I think this is bit confusing as TCP_NEW_SYN_RECV is usually
> invisible from user.
> 
> TCP_NEW_SYN_RECV was originally split from TCP_SYN_RECV for a
> non-{TFO,cross-SYN} request.
> 
> So, both get_openreq4() (/proc/net/tcp) and inet_req_diag_fill()
> (inet_diag) maps TCP_NEW_SYN_RECV to TCP_SYN_RECV.
> 
> 
>> +	SS_BOUND_INACTIVE,
> 
> I prefer explicitly assigning a number to SS_BOUND_INACTIVE.
> 

this is internal to the ss command; explicit value is not relevant.


