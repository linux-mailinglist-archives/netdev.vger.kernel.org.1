Return-Path: <netdev+bounces-187808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D3AA9B47
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0075218935F1
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D997026F451;
	Mon,  5 May 2025 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Q0pgeGa0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6709E26E173
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746468777; cv=none; b=dWRDr3MOMbpyRc5Joh0UmGo9FdJJCKk3ZObKPrO3wWgFhfRdCwj2xTE6iCtC0QEgiGDIuM7zShB29jDBjtTbQ+3a1VWfNz18xGLmoF0rJbyIeF9C3tUCTjek30wDqtFisSPnqXaxsiZJs3m+8hYUkypX7Ky7J92CmsPm4MhcL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746468777; c=relaxed/simple;
	bh=r6zL691xyXDc/NYPMzcgtrOHkUdYXfPK6zMjb7J4m50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHWAv825ZRg05YdlFIkzMwH4042VUMIeNjFItY4CVttkgcvBMELMVytxfgcX9U8HCDQGk0r1fOCfsAwKKZxl6jlI51xaCRtaWP5DX5l56vomaAExCcFL3XAk+bk/G/8jYfYdj4YI9LPloN+02vpGiudSFzZWtqqZB7aT345BWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Q0pgeGa0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e09f57ed4so44411785ad.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746468774; x=1747073574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kn/zibkomLWdf7PKFOzDAAA5I89jlaYGeX44MmTKrlM=;
        b=Q0pgeGa0T5kG2YxFOEwmRQyN+ikX5zbkAf1Pw7dFZs4ad2sG5TXbekhrrOl1Mr/bMm
         vkAd3B3SuFl08jJfcmRUwfObgGLDMSS6H8KekWNievh98rg98CBmtxRVTTe/CHaiMeOc
         cvxp/556Qvc/kpMMBxMYD9cgqQw6TT6nkYJHLpiLKycWUYh3Ol+w2ODq3kjqVHiOP0AT
         Kop+T4i0nImzsrgJ2xX241Red7YdXN3CyXTJ9IwuqBuEaA9FbLohCkkpf7evYUpiw2z3
         BuytWeZEYDmJCkSYHPt3Ta/OKdsXEkV7AQN42PrhVC8s7sc/+TNBlqlX5v6d+1zrIPv8
         eaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746468774; x=1747073574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kn/zibkomLWdf7PKFOzDAAA5I89jlaYGeX44MmTKrlM=;
        b=eeTuQF0aWmnzM3ELNWx4bg7Solm1JaMtONg+CQqPlPIwP0AVpE7+icuWRwBpxSEDHX
         B7okNEUT1fApt34+9chPO/KepJ5zmV79my5mPvHTUBfP9UMv/uM9ljC/kJaduouNtnKy
         4QB++WJ84ghlQGEPTGfGr4N2vXLIE618yeMiHekYJ2FrkG82yk2bbHe3QRGE2F/z0rHq
         qvyH+pTe7oVZ6gZDsP3UprnazS/SD1NHa2tmh+lL7zya+nIcxFACU4p3YhYBHas/Wch9
         WaiDNxOVB9UdLnnf0uzgLn+4WY4I1fNdRm7/ishpJ4nqoDPwUr9KlIXX9oQGaI8/C3uT
         z5RA==
X-Forwarded-Encrypted: i=1; AJvYcCUL6PZkQE/OMgVB6tar/FnokLpbScw0E7Ti2dnMq4Q4h+7KlmI2opkq46+AzrV4b6/7wFjBGgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcbrrqwivm7O0uyQFqR7u5II2p2B+ZaYEnEVaqSqNpUtBnEnHI
	xgRGb18ik7qfrjlgDkBvAeg2aDzIWPtOKVAusAvMmbJAgxHCfTDbW8eDNWz6NaU=
X-Gm-Gg: ASbGncsAnBPLZKdLr2a6iKVYzeOMQB0QocUUQxDbwPmdv0SvLGv1evUC7Sm4PNUF6Nr
	W8t0kZ8Jdnrl9QxKOOj34K5y31ubOmLMdXxiC0t37hqc5eo5K2+L/XWhlQxj/ue+xYZoOSRPtq4
	Tv3vw/deu2Viw/jpNJCqYtpgmmkrR4s6Q7EgYoaPuFPyN0gL9f8A2tOReU3tSmS8/BTx9oVqgrQ
	2PQXC3T3mzLKUncJxIjiqvGkEbVCXaDqPxg0K7BjfqUZVGMa9wFmgc7rtGmayfwwjKWSXJf/CTM
	5KfeER8zCbIkzqIfD3DOGjNWfkgd+VUDBRpd4zbC8wyqP2XMFsSYBNEImeZtx5HKui967Fl0TUZ
	RtemKhiFc
X-Google-Smtp-Source: AGHT+IFcDMpZFbSC2cA6HXuHWJG/1gn3lj+yUO7wc1CEnrvnUO+JYcSjzB8buk5n0CphdfJMlqY/jQ==
X-Received: by 2002:a17:903:19cf:b0:215:6c5f:d142 with SMTP id d9443c01a7336-22e327e57b2mr5750795ad.20.1746468774651;
        Mon, 05 May 2025 11:12:54 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::4:906f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522054esm58324445ad.118.2025.05.05.11.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 11:12:54 -0700 (PDT)
Message-ID: <39a3d71e-2463-494d-9530-80fcaad0b208@davidwei.uk>
Date: Mon, 5 May 2025 11:12:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] selftests: drv: net: avoid skipping tests
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
 <20250503013518.1722913-3-mohsin.bashr@gmail.com>
 <0db1b7f0-028c-44e9-bf98-81468dee32f0@davidwei.uk>
 <20250505104701.10d3eb14@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250505104701.10d3eb14@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/25 10:47, Jakub Kicinski wrote:
> On Fri, 2 May 2025 21:54:11 -0700 David Wei wrote:
>>>    def _test_v4(cfg) -> None:
>>> -    cfg.require_ipver("4")
>>> +    if not cfg.addr_v["4"]:
>>> +        return
>>
>> What if cfg.remote_addr_v['4'] doesn't exist?
> 
> Not sure if its super pythonic but it's set to None in the lib
> if user doesn't provide the config.

Ah okay. I'm concerned about the next line:

>         cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"]) 

If cfg.remote_addr_v["4"] is None by default then Python will complain:

   >>> a = "foo test bar" + None
   Traceback (most recent call last):
     File "<stdin>", line 1, in <module>
   TypeError: can only concatenate str (not "NoneType") to str

