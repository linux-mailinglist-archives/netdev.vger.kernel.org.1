Return-Path: <netdev+bounces-82353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0B188D689
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 07:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8531B2294E
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 06:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66BE2869B;
	Wed, 27 Mar 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+tCX6Wm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039591F606
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521455; cv=none; b=IJ3S9mSEGhYJkFkkSOCmveObLHIJJI1RrRm7KWvTdMUPqSdyU4zS7a5MCYlAN4gQgunLcOMb5XAuEaF9V+j+PvW+cPFlkx8kTLju7e5bXuKlGQAsWXVxfi2Rr0W+BavEI4ZkUenCl6Bdcio4COLsds4sQRvzCIRfCxzCSFdbVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521455; c=relaxed/simple;
	bh=ZWpTg9av0SEb4HtERx+D+t/XDE/F3v78YQE8wYgnGXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTsb4ZeUdiTlAv4jNVu10Y5aVKfBcQsaqCVjgDrI/nNEuPrDvxvh8FiCyXBIz1dbsuh4y413RvU+qNopK9oCvOR6K92OZBkezZrEIJTci3gYVDCnTtJM92+vCF8YERxMUfrYj9IRLqSAvQtRWuJtTA7ydQzqaZ7CXQ5ENIGNrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+tCX6Wm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c3260a714so1223251a12.3
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711521452; x=1712126252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MCni5ORcQgGWL1BPgy+Fgj3N1BFFhzKz1CLiEdYrnOs=;
        b=I+tCX6WmkLKyRuapubG4QUzVR/i+thN4ih2Os09cpRMBzsKfHZbGCP0Irt62aky27d
         mpOhE3wdSNFUnptIwG/TRYbQ2M/RrP7qqhBB2zSMmQSdVkuVAQJ7rQR4PlySsDhqIUag
         5C7tXlrvL5mk6z2A+hkHwLIFRLJb0Q7mIGR8i4+CzgkFnwWkZRXvCXdLkwYDDH+T5Kd7
         dnDYqejSj0IlxzOBYFm1bri2JzfFibhsD9ySHghxtE9B7eNXlYCz1d8YV+gy0hSmNkDQ
         389l4cUH6qUczLaWdGOPx38NYG1geMybSj90ws1KJvd7tXEuLzTRYclTfibTH61hmg6J
         l7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521452; x=1712126252;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCni5ORcQgGWL1BPgy+Fgj3N1BFFhzKz1CLiEdYrnOs=;
        b=XUKPJjIXmaOqS4pvbNosvV8QSGYCvgrlQgb4PJwWB/lyPZ8FBhebwUDg7PYX2itbd0
         1ya2Od7z5otQxbJqXzB7B+CbFR+kFUsIy3NmYfNP2AAUOYLVk9A1hClmgKOu2oFiB1fk
         jq/xlBVGXSax/epFJB3cuqhO34JXjznUd3BwLhThPslLYAg5yHQK9RVo8JWYzaq1KqF4
         iGSNCY2SWdzVEA2SGxh629W9dM5Ax3LRz68DdNM3B9/XwPy3rWjmKysvGNNcth38W83L
         +4b9JQB0AvPy9c4kZTRWmVkhvIwVxKum7jpot3VcTVzu9giB0a2jWBodMaZPzWMHS2UG
         h+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjUdOtibnvM5jqe7axV7zHBtLbVFuTM/KcBAzQS8EBC3XMU49ruascdx1YpawdzfkrKN9CsYSfS3BafhP05zv7LSPeMRhM
X-Gm-Message-State: AOJu0Yx1HsC2qvnQCFLkGmad4l/TV1XPuiMuFRGr4lM2iMknic/rXfvM
	1u2JCAlYcLGHf9b+y4XF/kmM4R6t+cWqQCQg8T7Qz+/C0Agv4qeM
X-Google-Smtp-Source: AGHT+IH+ypU3zqfL2SGKiwOwwdx8gnoelxLkaO4/BeG0YepyaXKhinlYgbAWTAB9SaNwMq12puWCxg==
X-Received: by 2002:a17:906:46d9:b0:a46:faa7:d014 with SMTP id k25-20020a17090646d900b00a46faa7d014mr1249237ejs.9.1711521452060;
        Tue, 26 Mar 2024 23:37:32 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7b87:a500:218f:b5de:97a2:61d5? (dynamic-2a01-0c22-7b87-a500-218f-b5de-97a2-61d5.c22.pool.telefonica.de. [2a01:c22:7b87:a500:218f:b5de:97a2:61d5])
        by smtp.googlemail.com with ESMTPSA id ao11-20020a170907358b00b00a4a377ee13asm2897808ejc.218.2024.03.26.23.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 23:37:31 -0700 (PDT)
Message-ID: <ade53d2b-193a-4f78-b2d4-186919359103@gmail.com>
Date: Wed, 27 Mar 2024 07:37:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DRY rules - extract into inline helper functions
To: Atlas Yu <atlas.yu@canonical.com>
Cc: davem@davemloft.net, edumazet@google.com, hau@realtek.com,
 kuba@kernel.org, netdev@vger.kernel.org, nic_swsd@realtek.com,
 pabeni@redhat.com
References: <146be1ba-c0fb-4ed2-8515-319151b1406b@gmail.com>
 <20240327021541.6499-1-atlas.yu@canonical.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240327021541.6499-1-atlas.yu@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27.03.2024 03:15, Atlas Yu wrote:
> On Wed, Mar 27, 2024 at 4:29 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> cond like conditional would be a little too generic here IMO.
>> Something like rtl_dash_loop_wait_high()/low() would make clear
>> that the poll loop is relevant only if DASH is enabled.
> 
> I don't know if cond might be reused later somewhere, so I am thinking of
> creating both dash_loop_wait and cond_loop_wait. And specifying them to be
> inline functions explicitly. What do you think?

It's about replacing a very simple check in 6 places. So we shouldn't
over-engineer the helpers.
It's discouraged to use inline in source files. Kernel standard is to let
the compiler decide.


