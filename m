Return-Path: <netdev+bounces-199804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2909AAE1D60
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CE71C21BAE
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9D928A703;
	Fri, 20 Jun 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QQleQUxH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6B26A08C
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429892; cv=none; b=gLv5wP+/Fc8om3FrTN4SIEetj4n3QEBCrTPfrIWlilRHextGeE+Xt8Z+BmX5Tuo+LPGO25LmLteUIkPsF0KwYBKxWTn7n4jITPJrv8gwiiiBZw287ucL/2GZOJzb1BIUn3Bf+UIIL82P8p28FJ+1X3XNskxDFU0JY9TaHItcIwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429892; c=relaxed/simple;
	bh=myfNPrpp+Td/Pu0vz/rZVBPOZTX4bO93UORciB2daFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVnHAxNBo3dijmP1e0T5aZHnvv5lLzn1R1s2rqdSU1Jgk6TKzZahZFfVLgPgDGyPDa4HkSlxh6Jk+NeiucKxbaTaWktwYzCJ14wMQmC8RDCErVHLVJdLyMEl0+SASp6coIj8bd/p0NL7gESyAy78YehTAhu+QxiMPk1I+WW/hRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QQleQUxH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748764d8540so1886937b3a.0
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750429888; x=1751034688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPissv+SzLajMZJYbP5O1wQ7Fk0qymzOwUfYk9eGlXw=;
        b=QQleQUxHnsFGB7nFB/udqmS8BB0qXlV7igURW9lM82c/iIRXPu3PtwhrlKQP5iWano
         l0NoWCe6uQQFzM3w7ht8LABzXjPGInaN8ZoEYWihADy74sj4rZaGHJ7N7Usvt871cwQ0
         joNfUzIDlISdrCW62EN24b/+zvLvXASOKqDWPPGS/xJG6lThjNbCLGamUJboKGJOlQ5x
         pUSS7FRlBPzwtzo6cXlFIQ/WYwoeKUpPEyBlJlPsmMYMvIkeZsO/oNncEPkfszSTQizr
         0qqo1QJnvmcVZb2Z9HKUkdg3/oKZWTuXksgXbBGrHFnqvdWVBQ8qcE/eFHMvdflmojc7
         4OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750429888; x=1751034688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPissv+SzLajMZJYbP5O1wQ7Fk0qymzOwUfYk9eGlXw=;
        b=fFOMWwQsqMR1YaQcqk+s9gTorShndPSVnvobn+eb/xfZoxOvFDWYUjqecwlmKERey0
         2eJdeRDjk8o8XVoMFKxRGJTy9+nNgVEaS7B6i+NFUOfVEZbIHXuGsyPn8JPe7HGY33ZJ
         57voyi7ILkwOrfi4H7jmt8Jpi62SgOJIcFewSFKSXy6HTENHHyVrmJGCS5PKO+CNaamQ
         uSb21YbO60tPQ2KqefQ6YcCmElHgXJfncPGlg9Z/lIBTGD/S8P8FKGjSLpCkThZWb6oU
         YI5Iph6XnDQFdgd4/G7IZ4HeVkhQf7Ntob9rZAdbcz7egBLFvdufxtx/HI85EtItvY+D
         YOCw==
X-Forwarded-Encrypted: i=1; AJvYcCXlshnvnpMhsHQKg/nsR0VV+yLkgw3aOq96U3q1Yw4SUzLNMYjL5LG4NTHGfKSB5rt+a4Dsw9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrhMqirW4sBvDV4m4wy2o8Ce/X87vravc0TM6bxitYoWOE0e0w
	kSxO67n6t0C3m/TQ1TaM3PfDGU9kJkBZG2XE9kKZW8mciXRivAaRJDPVGNtzdbo1EUA=
X-Gm-Gg: ASbGncsUZWapFHr264CAUVRj5SU1s9bcoKl/SxUS3pH3G8z/WD8T8PEI1l4zhsUY873
	zf5ccmall/fdmFX/qV6ydyTNLXLhjDhNFGR7xJaaRbqhPHwxEk4KHbP35LF1tobHRfEQIC/sklq
	9R3qR54BWdPGDoIXZokrK5reRBnafQ9OhAytZwG6Xw/l4cYIRs+i/su8FoxP34AMT0dfuyCHGKk
	uUszXOn9425n3/smhkctktzbG4zl1L0dsGoOn6STErtr4I5XkB/et33BrDxdcaeW6ifCp44umlG
	j8JKBbCXIjSmK/gYifsgSZw2Ca2Caup28HYYVO05xFZDcjTHEDBQQyhlZ5J6IPIPd0JXinjiDYW
	2fehn3o/RkgJGvpBGZFnYl25/zQy7
X-Google-Smtp-Source: AGHT+IHxr2om9jVWGFaQjjJHWMDX0OVhrO+Sp8ob/UBVdmaz5aFhQ700apz5Br9rUh1gx9zJRLiliA==
X-Received: by 2002:a05:6a20:4326:b0:1f5:8622:5ed5 with SMTP id adf61e73a8af0-22026d33a44mr5126355637.3.1750429888039;
        Fri, 20 Jun 2025 07:31:28 -0700 (PDT)
Received: from [192.168.11.150] (157-131-30-234.fiber.static.sonic.net. [157.131.30.234])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f126b6fesm1835692a12.71.2025.06.20.07.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 07:31:27 -0700 (PDT)
Message-ID: <1fb789b2-2251-42ed-b3c2-4a5f31bca020@kernel.dk>
Date: Fri, 20 Jun 2025 08:31:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] io_uring cmd for tx timestamps
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jason Xing <kerneljasonxing@gmail.com>
References: <cover.1750065793.git.asml.silence@gmail.com>
 <efd53c47-4be9-4a91-aef1-7f0cb8bae750@kernel.dk>
 <20250617152923.01c274a1@kernel.org>
 <520fa72f-1105-42f6-a16f-050873be8742@kernel.dk>
 <20250617154103.519b5b9d@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250617154103.519b5b9d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 4:41 PM, Jakub Kicinski wrote:
> On Tue, 17 Jun 2025 16:33:20 -0600 Jens Axboe wrote:
>>>> Sounds like we're good to queue this up for 6.17?  
>>>
>>> I think so. Can I apply patch 1 off v6.16-rc1 and merge it in to
>>> net-next? Hash will be 2410251cde0bac9f6, you can pull that across.
>>> LMK if that works.  
>>
>> Can we put it in a separate branch and merge it into both? Otherwise
>> my branch will get a bunch of unrelated commits, and pulling an
>> unnamed sha is pretty iffy.
> 
> Like this?
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git timestamp-for-jens

Branch seems to be gone?

-- 
Jens Axboe


