Return-Path: <netdev+bounces-197977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D982FADAB42
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89417165A7F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448AA27057B;
	Mon, 16 Jun 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="YwRM5GTf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D4238C25
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064275; cv=none; b=hBfVXZfQ5lMIA/TQVSWin0gIxl3NON8xx5vQzkn1hEJlSWmTahZSnzsVsxII5LklKBtO90IqA3ZwLomT8I55zNPSexbey+jfuBx87R8HZ/JO2pzrW7LUKUdWrW/yc+TtAl35U4kp9KZG809NL2msdKI9RicM4GCWurlAgq6JdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064275; c=relaxed/simple;
	bh=+IPAfg6aAqYRP8oAvmOk5CsoR1Af8EK74nzQSwWug6k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RouJc6h1deKY7J3zchzOMQVBA8YSJ9RSZ6pFEc5y7557Ztllf0pISyomLkzj3TQMdN8h2DPexo0PdIS4AtaqU4fSag0FeTx5s27DofpbVT90TasfKqIREUBwlpEd1/9qJjhqNKu1CCFmQBMp5DZ/CZuIUUdZ8EZhiH/a/wW5Hsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=YwRM5GTf; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af6a315b491so3863771a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750064273; x=1750669073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q/n0U9exPbWsNzkq0vdSb2AGdr6wYxr3WV2bDA6SXZs=;
        b=YwRM5GTfpMziHx0C8dYxA353iKUrmdZKMaGniTzq6Y4fAxWEaPm4+fbjkdy36aCCiq
         EADy0WB6ORoQnYAbSh1uevjI3iMjMK5U+vy7x9wrRi8ndSU0OFq81jwVyf1A91MCIw6Y
         NRSvEOiPV+SuTa1Q2nQg6Qd4aL9PiG3pwRsBaQOPsYXELVcKtXCsSDlOv1vQJbzwgSqE
         b+CpyohNk/XPNcTIG2XG1khwNWCmE0x7hXGmgTRZhAqWAwHNIaOLYit948rK8gYZjH63
         7MMsZ666s4QntmI0ROv9ZUBXwGUPJfwJXzK/b+ZyYqTufaX7V98rUVvHOcqC8RZXAWu+
         eD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750064273; x=1750669073;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/n0U9exPbWsNzkq0vdSb2AGdr6wYxr3WV2bDA6SXZs=;
        b=kfyMn1axjD3OqPTHLY21hy2CoMvxWhmiRiSHHWNGNgOyxuRPMpdsCVP4Q8l6vNPWpi
         u5Za5f8knLb2FdAYj+TxQvTSwUnPs/IQg3lCvX2PM5uJW5n/+jUvQwlJCn08jsx5Nby9
         MnQhPtjHlCnBqawecof7xtnY7l2lCupJ+DmQbbmJS4mbwL0Bdv4vqr9BKxEOJwPgNb0x
         bmfpfzUkHlTPvPF2obYx84apsplgXY2f2VVCdB3VX79Vu5wHRUamvuBrkQwkMiUzgPIF
         7Y1Nei8wcYRUpGFF3JmhDvphE8ZwRFm0IUjVqDVBjbLS39tFlrqAXP99gAVYiNapKeM4
         +9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW8QYoCtb36iPI+Kz5Cep2f5htigHsRosfx0gdR8NZ8Vkb9hDRhFCEznnavnqTubgdx3v5q5Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1dVp9Tf5XZlTZDFieS6+lRKjZayvm8fk00ypYosDczgWoaYN
	H6Nb/v+rMzLV3zAE9v9zOvMdJrOgbyQDIxxR9jUZtKe8XeEYYcIvLqE3bFSQT5UtaWk=
X-Gm-Gg: ASbGnctiZSaNvL7rCHxPNBY4bXmIJqO9ZoMIVxYZs7YB6NmNL/WKheEcDX6WGRpgLLX
	5PGOr2FgKcHAAQdWffpLaw6Tq6gCDgITkhUEvR7fXkyekKAzNevlIEqnErnkxuhNhf8bbi4lPkp
	NP7CzLTDoSDHU5of1LcLm9N04QZRs/Xr8gzpH9uY4a17MuGK2C7eF9m/+MyRvSXanDQMwjj8FFJ
	BiUgt31a0Fw1R3AknLz/29sbcTar2skaXWnazatvuPONwyqo7qrZ1BuhxSUjN8uYpICH7io38qL
	KxwgYFWbSjFgPXfZY90yAFrKOLcjjBrS1J67gXO9y/1bjwaWFLF3Z3oDocHYrgwynfTkgDxaadG
	TBKbboVKSqOYpMWQv7FpHRhw4
X-Google-Smtp-Source: AGHT+IFWSYQvoI0ryp1m5h0aHR5kVcbkV4vQPc9xPqR3DhhU+GIF5pbUCi3HTP0QLN+zBLruCqQjkg==
X-Received: by 2002:a17:903:2b05:b0:234:de0a:b36e with SMTP id d9443c01a7336-2366b1773f6mr134102255ad.49.1750064272893;
        Mon, 16 Jun 2025 01:57:52 -0700 (PDT)
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp. [133.11.54.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea9259sm56628675ad.157.2025.06.16.01.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 01:57:52 -0700 (PDT)
Message-ID: <ebf8e65a-9907-4ecf-a411-7002f11b9d1f@daynix.com>
Date: Mon, 16 Jun 2025 17:57:49 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH RFC v3 3/8] vhost-net: allow configuring extended features
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <960cefa020e5cfa7afdf52447ee1785bedea75fd.1749210083.git.pabeni@redhat.com>
 <0497f70f-3c6a-4ecc-97e9-4487b3531810@daynix.com>
 <78d97778-06ec-4080-a9c3-19a754234f78@redhat.com>
Content-Language: en-US
In-Reply-To: <78d97778-06ec-4080-a9c3-19a754234f78@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/14 16:27, Paolo Abeni wrote:
> On 6/8/25 8:16 AM, Akihiko Odaki wrote:
>> On 2025/06/06 20:45, Paolo Abeni wrote:
>>> +
>>> +		/* Zero the trailing space provided by user-space, if any */
>>> +		if (i < count && clear_user(argp, (count - i) * sizeof(u64)))
>>
>> I think checking i < count is a premature optimization; it doesn't
>> matter even if we spend a bit longer because of the lack of the check.
> 
> FTR, the check is not an optimization. if `i` is greater than `count`,
> `clear_user` is going to try to clear almost all the memory space (the
> 2nd argument is an unsigned one) and will likely return with error.
> 
> I think it's functionally needed.

The for loop tells i cannot be greater than count, so i < count will be 
false only when i == count. clear_user() does nothing except incurring 
small overheads in that case. i < count can be safely removed.

Regards,
Akihiko Odaki

