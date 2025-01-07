Return-Path: <netdev+bounces-156062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B0A04CB6
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49521887250
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C401DFD9C;
	Tue,  7 Jan 2025 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NOV4be7Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4F190664
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290538; cv=none; b=V8n/sdQyXJlXbk2/ST4A1FNAwWMJZJFO1JvVUGnN4Ga3eNNUe9toowpJa2XC85ay8G1RvLRlszi10AXqqeGYNPB+bRNKiWjHyNhfeV6bRmUHhp13GXTts4/tfG2RtitJ2cwC9iR5i+7rlU+HihopQ8xE4yfThPS77PV+r3FG/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290538; c=relaxed/simple;
	bh=scD61U4NtcIVBykeAAq12T+T5C1R3U/A+2bjxqSQ3Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLeeu5QBEOnFoKBgCP3aN1XcwJWgUUNwBnCHSU07I2ku+rFRWisv+M/C1wP4EE1jCE4A0+Y/2OtsnM0RH9Z25hpJtYkbpNe4Ogfw1wpeWX+R/qabqia71wMSrtB3GGoDyGqHRKUbLE8iRkXbBsLElGRpdF8Qot7VE1QwGfLWefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NOV4be7Y; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a8160382d4so50700845ab.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 14:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736290536; x=1736895336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xb8/W2KjJs6qbSff2lYsx2mlOIKGJeA9nQUzVaILs00=;
        b=NOV4be7Y/CzWvwbZFx11w5GiK13UVVYSpC1uZMwOd7B+nY+VQcQztCoYgvQDu2x9SZ
         PLymm9YkPee0p/pLIUDtLANphIYRFJwLf2rQq/wzOQn+s0DtZcgY/y4wWfnWFLPj49Jv
         7N1JPVHydlK6sIirC0mj8+lFiyxW1ks3Im5vn+bCq8OF7E6M09CChTnyZna2yu6t8upM
         AOdNjlLW41SPG/6Poxhzd16Mr9afOtl/VaD44fpkXM0yGinAKKEbv0G//hS3Owy3/Da/
         t5jCC7yVSEjXBBnfLnnDSgzUFj6iU4cC8IMOxvtr55dE0wXax23wKobOo4FwNiDABcHP
         p0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736290536; x=1736895336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xb8/W2KjJs6qbSff2lYsx2mlOIKGJeA9nQUzVaILs00=;
        b=KgdX9osvfPy8rUF77ov2rzBeHEyIw3a2uLWupZ17kiVAQb7kjjO066Eqg7lQWhyHcM
         qmx6LLMMBvpCD0e4x3Cwzi6vAkLLjZVpCvbsP1kfQDog7hBWVk9gGgNG0AZ6gBfDLPuR
         9x+MTtmNtPVZB2jibiUSaYQkAbAZNkR+yyvuvoMtRXsyDbxxR65CBoHl2Uich+3MYaoZ
         Cy6IKdv0jEO58UOzF4p9kRYelXQDm9qic8lH3j6bTcEWrelE7o8dKoEwIfhCSPrppJOH
         4Jugi4en0L3hQqKwysNspxLa7sq/pXjsjZO2RVTNCRm/pYYLKCZjncKeg9RC2/N6Ua0i
         ZltA==
X-Forwarded-Encrypted: i=1; AJvYcCW/eZD2ARe8WaYhPHp2/wd/cQTOfil3g1rglW9T7JG8cGl2OHu0LbYIFwf12CuicNYmKBspSBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygNUVbWLYj75nA/tMAUDkEh0weuwP3YvsFamAWrUIMVa7lLs30
	3jhFmxOWeBjbEkyLJY5s9dgmK2OrKTwJGdi+mODvauiM6RPIGaEGTe0TaC7d0Go=
X-Gm-Gg: ASbGnctsRQvni4sXP6daR+ZFYFo291CljegoNNxPXAMiaZMl8RU3JNeD1TObarHcLHu
	fOE8kTLiBoyVImmNotB+LWMF1qXxhS0OH3Q68thBhX9B50pDMBtvlBhnuHT6V9HFmGfliTWoxq1
	sWZz/a18TKQcFwOLyXzu//TxQd19fUblnqwuMYEqBdIdUD8kA08JvyfXmaxzedLsWCi9H1hAt+h
	EmuGOgIrlE464FvJhVFFuSJWwWmTOOTj+8h3uqTLpyorXL1/3NRmg==
X-Google-Smtp-Source: AGHT+IFzHZUa/KrmFEIXt5DPU2zt1/FIIRDWX2HGrtuT6m2o+bVoDB17pRfRC9ozqCMRefpJZ/EpWA==
X-Received: by 2002:a05:6e02:1d8f:b0:3a7:91a4:c752 with SMTP id e9e14a558f8ab-3ce3aa76a9bmr6944685ab.23.1736290536022;
        Tue, 07 Jan 2025 14:55:36 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c1de6b0sm9907884173.134.2025.01.07.14.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 14:55:35 -0800 (PST)
Message-ID: <64df3d49-1173-4078-a834-7eccaaac67fd@kernel.dk>
Date: Tue, 7 Jan 2025 15:55:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] poll_wait: add mb() to fix theoretical race between
 waitqueue_active() and .poll()
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Manfred Spraul <manfred@colorfullife.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>, WangYuli <wangyuli@uniontech.com>,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250107162649.GA18886@redhat.com>
 <CAHk-=wgvpziaLOTNV9cbitHXf7Lz0ZAW+gstacZqJqRqR8h66A@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgvpziaLOTNV9cbitHXf7Lz0ZAW+gstacZqJqRqR8h66A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 10:38 AM, Linus Torvalds wrote:
> On Tue, 7 Jan 2025 at 08:27, Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> I misread fs/eventpoll.c, it has the same problem. And more __pollwait()-like
>> functions, for example p9_pollwait(). So 1/5 adds mb() into poll_wait(), not
>> into __pollwait().
> 
> Ack on all five patches, looks sane to me.
> 
> Christian, I'm assuming this goes through your tree? If not, holler,
> and I can take it directly.

Same, series looks good.

-- 
Jens Axboe


