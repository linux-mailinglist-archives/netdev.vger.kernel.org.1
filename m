Return-Path: <netdev+bounces-134971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED599BB4E
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C4D281827
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275F214A098;
	Sun, 13 Oct 2024 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="UFatiFfE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90481149E17
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728848336; cv=none; b=rfLPyCZ39d3JHax860tMZIWIXyD8pGXcOZwShXJMfGOoMUrpCGMSXS+YAmxqZp7MnoIzfeHZ/IiPulQhA+G8oqITo56RUT+Uohodh1S2ds8PadSuAQSaJZviRWOgkJGfu3PpTK3GXebpVSEIw4dOmiqZuJOvoB7lfXni2FM+418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728848336; c=relaxed/simple;
	bh=Rn4LuLno1J6JnL48cDT1UwWv0Syqc0ZUWDyqGBgfgnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHzAOCkq+uNtX2LJZOcw96mSP6xXpk/sz5FQP1qj8WuKehG5pSbm6NeEbc6vvFlU25FcKqnJJoB2sPYHN3Ii1Guzcio67j+j2gldcs8GbWOHsE+OpIZpN0TwqfHRdRT+8905BYmcivxrGOKS98tTI7Jgqk0hiOZ2teZV6MuJ8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=UFatiFfE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2c2a17aa4so727368a91.0
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1728848334; x=1729453134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeRJ7jTyoUmJqEEnMOUpJazUGBODRoEG1ZhWDyHmXKY=;
        b=UFatiFfE1KeFQcLTRX6UighJ+zCnbvW9YOiYDmoMFqFtj+ru23iuEr5SZe9wb7Hv63
         U5RyLtNX6JDq89C/H00tR93Hfk8gzgGg8KcMiROOdnCruPEdJwkSHG0C9Qawu/lIuQp1
         ykLYKHvAknkwzmabj+ZMxfoAsC9snG/0jmS3+nXj9clvbGCVwZKCR6Mp4UUeJJOgiKz0
         6os50/zJpSIlCflrLmBpO1ZJGCPoRNr4Um/wsNv5N3bS9AY/9YbTuxi1+lk6TC77HwjZ
         Wsw4EKzfJFAtJ3nmCWs55A77XFgpOXWYnvEYBgAf5sdl4zMknNLcjh4LUeCRVrVX9/D9
         +SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728848334; x=1729453134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeRJ7jTyoUmJqEEnMOUpJazUGBODRoEG1ZhWDyHmXKY=;
        b=UuuB9bMQL4eYa84wa1KT8USF0waQGX9SXdFkwvLEUBLYqu4IW+wTjLf40JXJJwGwXv
         /3kQS54xXi3mbyGqOLoVEhDtOOgbjqh27f9xzyBZnsz+P5DvudJVvZ05OPClwcKNZS8p
         V3n4kEgzCoLlHuxfxwGcYgRT6HjgUNocebH68RMmuNKFcTplYJJXXgAxDpD46d6G41xV
         pKV/e1LmqbNPG2eowAlUw3j+5V7f9rP8FWjjEyGUO4AGp5IKVq5H7zqm63qfwTMs3H66
         /JeAZfINEmvEzjowfMsCBClD2JfDlM9JjFP/ygMINtwalM5UcHhEPoFzZ9xOC0dluBKd
         58xA==
X-Gm-Message-State: AOJu0YzE/IuTLMdHkXwYDqVN9FY9GSOWHe9JFFrCcV7O9mymdP3SluWE
	oUAJoyPNnGKzQxMXlLZvIQd38Ik6TSpeg5h76maesPLQPLz2gf7Ncq/+i9tqUX0=
X-Google-Smtp-Source: AGHT+IG2pcVYBkzbQ0xeaMbvUcS8mZPkd2Yjrph0r8OTX3YfDn/sMoZQfByANkrIj+RRg8YMFU44dw==
X-Received: by 2002:a17:902:db12:b0:20c:876a:fdac with SMTP id d9443c01a7336-20ca1320237mr56741575ad.0.1728848333744;
        Sun, 13 Oct 2024 12:38:53 -0700 (PDT)
Received: from [10.0.0.211] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e7620sm53162185ad.140.2024.10.13.12.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 12:38:53 -0700 (PDT)
Message-ID: <3be1961d-d451-4038-9cf1-5bcd44550346@shenghaoyang.info>
Date: Mon, 14 Oct 2024 03:38:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 2/3] net: dsa: mv88e6xxx: read cycle counter period
 from hardware
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
 pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
References: <20241006145951.719162-1-me@shenghaoyang.info>
 <20241006145951.719162-3-me@shenghaoyang.info>
 <9b1fe702-39b2-4492-b107-f1b3e7f3c2a9@lunn.ch>
 <1c768936-9306-4bb9-8a2f-1e21e09e4b56@shenghaoyang.info>
 <f33e48fd-b8fe-4c7f-9180-fe6d23c1e48a@lunn.ch>
Content-Language: en-US
From: Shenghao Yang <me@shenghaoyang.info>
In-Reply-To: <f33e48fd-b8fe-4c7f-9180-fe6d23c1e48a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 14/10/24 01:01, Andrew Lunn wrote:

>> I've looked around a bit and this doesn't seem possible - the common
>> timecounter code in time/timecounter.c and linux/timecounter.h has a
>> dependency on the cc_mult and cc_shift fields within the cyclecounter
>> tstamp_cc.
> 
> Ah, sorry. I did not see that tstamp_cc was a timecounter structure.
> 
> Maybe have 3 const struct cyclecounter similar to you having 3 const
> mv88e6xxx_cc_coeffs. Assign the appropriate one to chip. mult and
> shift can then be dropped from mv88ex6xxx_cc_coeffs?
> 
> 	Andrew

Hi Andrew,

That might be a bit hairy too - the cyclecounters need way to reference
the chip so they can access the hardware counter in tstamp_cc->read.

That's currently done via a container_of() on tstamp_cc itself in
mv88e6xxx_ptp_clock_read. With only that single pointer available
sharing doesn't seem too possible :/.

Thanks,

Shenghao

