Return-Path: <netdev+bounces-186082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A8A9D06A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 20:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246921BA01CC
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CF216E24;
	Fri, 25 Apr 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY3ucggx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31CA215F7D
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605298; cv=none; b=AYsnz7W5RCM4r7W1U49aT++luNmRdnTZQug11VGf1fJiO/qoDziIW2yxYJ1dLpA4M7XZl/5xtzkzU93lQ5xDS0RX89Yn+iQ50iBtZtTVB6KesKZ1rUqyaLrt34qKupmdZU8UsCGYhkO4m1lQ9ChSZdcuYdj4AQ8PQwjkuaJ5yW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605298; c=relaxed/simple;
	bh=2i5FFhOfipWfsWPkvXg+CMH8K7/9ZtnG17LAaXQexJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRaP1Y6FUs1Oa0YBcbXQpOFDbtKhUKHoMqB+3MA0P9+DaeJKFpc+35MMisXZAFd2jQ83O4qMsCdB8cSG33mg5f9q5qMt5Ydc0/U31Abd9nspNlG3RQ5yuK8lWcIiv9cJT0BmGnoX9/wT4xRs9ty8iQQksWeK4EqNbyLTcAEBmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY3ucggx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7376dd56eccso2809936b3a.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745605296; x=1746210096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ur8muLi7zGPzRtb6JrkGeogWP5lIpOTeNOi1PX0I0M=;
        b=QY3ucggxDgsE6svIwBMJQNOYOpMPb0mLyNhsfvPkG9TMuZp7gv7hh2+s/0bt/pgn80
         Q7MtAKcHssL+ZRqrcv8sLoxmaE0Bn5jIwUHwYXbj6CVCcnsHdPlA7ky6z8uHX7wIggbh
         6QZfBszzUYtsa3vQpw2wyLP4XHVt/paTCejHWVEL0eWlupjhcDQ/ZYT2U1NCGJRGX9f3
         iCHHGeIHkQej8ch4OUfj7jowzGxtVvRsLGtJl/cFv2nriV1JqOZknx8HaBC690bkOvG9
         zLeRBk4Z2p39EJqmMl79ExnU1mOCMxpoiCIgsxB2bXFgEnIWwSdma+ILCpaHHewXebo/
         ZZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745605296; x=1746210096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ur8muLi7zGPzRtb6JrkGeogWP5lIpOTeNOi1PX0I0M=;
        b=pzH6bCdDetVkx6Vz00j8GLsiGJQvKsCYhigPBhqQ44rxDDS9bjgZtG96jwqlD5x57P
         m8Aw6V7K/E71Xa95TO9MXbLPTxp62Qw+XqYsOmiSY7KG1BFIRodruvgyK4S4WQzRcBXB
         5dl5dSTSKf3ib9twzGccPXvcFokjb1zRa8BS46bOj2Hz9E3j5v0Jg0O8mzODRfmRmxfK
         b7EEi9v4EslWyBGMSWJAljVNE8ccmAE3O6kvtx4xBLLZlhmogO81kJ0LZ0yLuO/ypZTN
         I7a/hs4E7+eqPPb7qRaGttvg25k5B4ztoNjkSMvaO6EgsDCA2QzajxMZOlbveWGqDsDc
         lLVA==
X-Gm-Message-State: AOJu0YxFnanz2H6tC69KzGkOOZzmv9mvlDSvCUx+CZaMTwqI7ck3k6/b
	9umWRHdQd5o8DuOgZkpAK45YECX6XzkxzI0cIPSxPrXMEMnv2sea
X-Gm-Gg: ASbGncvm5sVUCkID8bI33UTQV1eSo/6jNgZhPgOwUkC2INnaMK06KCb1h6SiKKL3veq
	2nVKbD3TLd5LC7AEt0/nK7DAnfBkY3rwyD0Yw4CQOXDm0lnx6UCeGGKVJSN2polSEFbBRXVK63c
	63Fm6CSh73OqDJCIoazFvrpf7ncHbEtuN0bHye+Kc83Fi+RbtxPM1n6Qz4wBmuugiYXW4QYrfnb
	NC7GMt/QxGspT66vFnIUCIZW6LOMzBsYRV415SGf7XySqn4tUquxKCvlMdnUnADnbnRyJy8bHZK
	fmqLmF+IZImRG+O3xiqn9AeSKXTfnE5M6kK428Dnh1qgv5fQVFP97qQ8JQl4AmRnze0=
X-Google-Smtp-Source: AGHT+IFbKlOtRKrh9QjUkxxAGQjfWqWAIuRI1Cutb14WIv+ACkkgNfUlwkQxYg2Kvx4+UCyXet4uzA==
X-Received: by 2002:a05:6a00:1807:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-73fd6fddaf3mr5394304b3a.8.1745605296041;
        Fri, 25 Apr 2025 11:21:36 -0700 (PDT)
Received: from [10.20.85.130] ([72.164.175.30])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25a6a420sm3598256b3a.107.2025.04.25.11.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 11:21:35 -0700 (PDT)
Message-ID: <c1266298-8833-4bef-9ac5-6c61ba4dd0c6@gmail.com>
Date: Fri, 25 Apr 2025 11:21:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [question] robust netns association with fib4 lookup
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, Ferenc Fejes <ferenc@fejes.dev>
Cc: netdev <netdev@vger.kernel.org>, kuniyu@amazon.com
References: <c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev>
 <aAvRxOGcyaEx0_V2@shredder>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <aAvRxOGcyaEx0_V2@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/25 11:17 AM, Ido Schimmel wrote:
>> Is there any other way to get the netns info for fib4 lookups? If not, would it
>> be worth an RFC to pass the struct net argument to fib_table_lookup as well, as
>> is currently done in fib6_table_lookup?
> 
> I think it makes sense to make both tracepoints similar and pass the net
> argument to trace_fib_table_lookup()
> 
>> Unfortunately this includes some callers to fib_table_lookup. The
>> netns id would also be presented in the existing tracepoints ([1] and
>> [2]). Thanks in advance for any suggestion.
> 
> By "netns id" you mean the netns cookie? It seems that some TCP trace
> events already expose it (see include/trace/events/tcp.h). It would be
> nice to finally have "perf" filter these FIB events based on netns.
> 
> David, any objections?

none from me. I was looking at the code last night and going to suggest
either plumbing net all the way down or add net to the fib table struct.


