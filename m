Return-Path: <netdev+bounces-212102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B52B1DED8
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 23:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91962188E1B1
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9AA2459E3;
	Thu,  7 Aug 2025 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0RVu/tP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098D4430
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601856; cv=none; b=Jd2RRGbdLrddVvfceMPAF0fI5k2ZJQBHklphHiwLL7XhJWy/PvZ1Sqpvzgt6V082S8l2QnOZTX+HEUjI3Mc4eK7MWeI6+tzQlcG+LNqQ24cWsW6Q/yl+GwV1y4GwIKg+gu/UtCs7guujISxRZZj60uyL9tjjIF51JfMtQV+hrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601856; c=relaxed/simple;
	bh=RAgIs4cxwD2bUtvRwVCcwRHSprjCKKADXdYyOCP8prw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjFfFuKFk/A3gPjAaNp/X5CtzHQLJoYLc0THTNzVui6FLIqvxWF7mAQ0wM1qHgGhg6L0EBAfEYVcxs/sSgLyGhGizcPrlYg/YAb+LH0M9YvFp5D3S+5Wwr5Rs75vENcm/6lNJVuR8TqN4y9XIUgWw0t87yqKT3IpudYXVB1LFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0RVu/tP; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b42348bae1fso888297a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Aug 2025 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754601854; x=1755206654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4mqmDrnMT7N7suSY0JjehM0twwV9p1yCQtEBzLNajQ=;
        b=k0RVu/tPrSGVkBZ2uB4Ccp+TKX41IqqwX5DyjJBVn1ZNJdR493uaCqI0LxGIey2t0T
         0A0d5TXebXaV8qlW01onxzYLHl2cxe4YxB9oG5O2J7H97QRjaveWpSnNU/6HJW0fEMuR
         Il/sj4S25+wn3cPPa0Dtwx1FeHAB9ihQVXROYVzCp1riEc6TfIEwcwylP9tL1aFupOas
         mQUvx6Uxokn0DKVzIBAT2o5iwS/Oypq1HqBwBi5qTPdq5Mc7WZHhbkbUh+BUt5W1W18Y
         8nxv2UeEdfW8psIS2HKdbR7np4aVEnSop/UzkgFP1iwM/vBZ1C2fzJOTkz+LGhOgc47K
         loag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754601854; x=1755206654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4mqmDrnMT7N7suSY0JjehM0twwV9p1yCQtEBzLNajQ=;
        b=AwuMkumAyDAF4cQTZF7uGbxRvM6VU2NH5Hjh22c18MO4QeWitLr+rs8WDRmu4yDRmu
         cS33URQV1S4fV3lvTp/J2Ptq2HTOfuQumY9GmX9lVmDlsCsBNVivH+G0vPak/uom9jV9
         oAfycLcNbksDeQ28waTPkOpCukqOlROrpu0Myi799kMPLMuUO73cQo4An/9R9oyYHyiK
         B+eoXlIRhLf3ewxoDZiQ2K8dnrxKLQ5rqRFcHqa0bubHvLH5UZD3IVb5a12/BNhS/lBo
         52BCaMZ+DcdWM1S92KckuToDHYoMOKftArbovZh/0Es0NLRrjkqiuiYQyZXIghvjFblf
         Egfw==
X-Gm-Message-State: AOJu0YzHjkBLJT5OTXwGl2bOOgqwABNUgabUZ1r7IU4vu5rhCNAnnoy1
	nmVqDFuGvbHxOxSnwfj4Qco7FcqVx8bQantRJZC6FDyjZo+lJKLPAMGC
X-Gm-Gg: ASbGncuJpNcYHYhhLVM4yjJhd8RtuDpHsB57bmUqmXBn5J1JDE1CIdL9A5/YBQqKk3Y
	LPzTghXIq0L0ejC92/0sysCkcI5s50aFErTZho7RRftUqQ+BSO+vtEiI2ABtqx2JiEluLVtuNLh
	m8g8NWP2HW3CsJPSt1vO+BFJ0FqzrMkG9l1RTivij0Qq8Q2dgWX6U0U3lSq/VWcgmoUvF0aDvn3
	QtiZhb0kXbfqd2w4h5Pf07tfD0x7/TLa5SK4DrtuG4LBBT4at1Mlf3n568mboNDj/Uj1B/3gwtQ
	Yl5cCM1d0MWlu+ivoERoaKr9sn+bO+4h9dxVoFR7M2jRJtLc6JGU1J6UgtcQuOZsVnWhIHgDsEX
	dOkt1wK1RcH6v3ANOADA8MXQ0gEq382cOS0X6D/1d2dQFs3A40p2bnC3H336CH0K24/akk7FbUv
	0=
X-Google-Smtp-Source: AGHT+IEOeNFEVZzBQA122R9LVuIZox1guk+74+2ywqbXodzsFuK/dGMRqn/SnDojkrUETJ+4aANJSg==
X-Received: by 2002:a17:902:d484:b0:240:99e6:6bc3 with SMTP id d9443c01a7336-242c204cc8dmr6625285ad.20.1754601854480;
        Thu, 07 Aug 2025 14:24:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:ac:1a3b:4cc3:615e? ([2620:10d:c090:500::5:1df4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef7557sm191965775ad.19.2025.08.07.14.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 14:24:13 -0700 (PDT)
Message-ID: <a5b3f56f-a7f8-4fa5-8cd6-de9c836db2ac@gmail.com>
Date: Thu, 7 Aug 2025 14:24:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] eth: fbnic: Add XDP pass, drop, abort
 support
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, alexanderduyck@fb.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jdamato@fastly.com, sdf@fomichev.me, aleksander.lobakin@intel.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
 <20250723145926.4120434-6-mohsin.bashr@gmail.com> <aIEdS6fnblUEuYf5@boxer>
 <d47b541e48002d8edfc8331183c4617fb3d74f8a.camel@gmail.com>
 <aINUysHmm9157btU@boxer>
 <CAKgT0Ud-QVX=xn8QZN-MBkVwHdcxE8FDz_AzhW-vdZJyLrLTkQ@mail.gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <CAKgT0Ud-QVX=xn8QZN-MBkVwHdcxE8FDz_AzhW-vdZJyLrLTkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>> Hi Mohsin,
>>>>
>>>> I thought we were past the times when we read prog pointer per each
>>>> processed packet and agreed on reading the pointer once per napi loop?
>>>
>>> This is reading the cached pointer from the netdev. Are you saying you
>>> would rather have this as a stack pointer instead? I don't really see
>>> the advantage to making this a once per napi poll session versus just
>>> reading it once per packet.
>>
>> Hi Alex,
>>
>> this is your only reason (at least currently in this patch) to load the
>> cacheline from netdev struct whereas i was just suggesting to piggyback on
>> the fact that bpf prog pointer will not change within single napi loop.
>>
>> it's up to you of course and should be considered as micro-optimization.
> 
> The cost for the "extra cacheline" should be nil as from what I can
> tell xdp_prog shares the cacheline with gro_max_size and _rx so in
> either path that cacheline is going to eventually be pulled in anyway
> regardless of what path it goes with.
> 

Hi Maciej,

Appreciate your suggestion regarding the micro-optimization. However, at 
this time, we are not planning to adopt this change. I am all ears to 
any further thoughts or concerns you may have about it.

