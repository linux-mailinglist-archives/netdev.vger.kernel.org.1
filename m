Return-Path: <netdev+bounces-165687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C0A330A1
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF731889869
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF3920103B;
	Wed, 12 Feb 2025 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtdnYSKp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41A200B99
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391552; cv=none; b=bt1hgTHkJ5b/ZqL5mmjAWRapJLBxwrE4lwbqV3HZ05o6CI0ssUMYR0EL1/VOcPDiUFdGVHYXwICEDtDH7u6OhoNCdilMiSsJsmzQQOo00HjqPArtS9FQ4nO/f2P7bPkVuidxfhGqtFUmUyZsQ3nZWGSvsbFxttUfJlRgNHdNMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391552; c=relaxed/simple;
	bh=dMVqM910/4bbLi/eahTQPA3WJgvEnnkSIGXcWE5qgvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7SvDz9Ezj0sBgtKJnfiJMpJ+bT6NoJ5HY+dlGXXuq26A8rXtVbvVw1PCHCC3EKcigeB+9MEUsm43CMC3opqfjbSvyb5hTI730OWnaQb+Guy6Az6GD7CA8T9ce2PvtRcJ51486U1LjuTie1i320XQENNTqDf/dFoezB51pfFyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtdnYSKp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso817243f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739391549; x=1739996349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lFGAIRUJ9rl/1zx2uS5K/+14c6cyexGuZ8eUNxfrKJI=;
        b=KtdnYSKpnR3E3tsZ9N9HoAb4TibixA9PNVLqg5uVxUCVSkO0bScPB5OQvzGZyuFq1u
         rtlTRgVqJujYgYV5GQDonORc388lX+1H5/m/2MUrQ/cVQOMotoovVH7UPTqCKdZf9+tx
         yt2nlBj45oGXLCfgah03r5OW6m6BIp7o2d6vW529jf9WN/ZqvqaBe4nyGTiQNqCeJgjd
         7bUN8TWnQm7TQXrBnqZn3uB4cM5PLFj5lVfibLjOwNkjXRnPTcyiUugeq4Rra4f9F7b8
         OyQBcdn6czBPS073bnu3SDCa80+Bc+03NkprQNG4uYInZHy++B1zNhyKG8KYn9XJbeIM
         5T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391549; x=1739996349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFGAIRUJ9rl/1zx2uS5K/+14c6cyexGuZ8eUNxfrKJI=;
        b=Ehzil3YcqAPf9Mo4iFt1ogrXmjY0aXO0fDbTFecyhin3hXuTvhGEir4SCBue2zh35r
         i7xU2rBe1/5DTdfAVyGB9EJg2q7p+F9ZK25Ms/ji21T75NbNXbBpg9Magm03yrwrtKqS
         J0r+OgDi3hk929QyDUV9Hpj4kSAAqf9Lo6MAgvPrwzr8+j0v11QJy0fo/Qhs7AGE0oN7
         0wpkHBDTxopMkNX8+I0Oyuq+89KKCedzV8WI0670ErRTlisZs+yf3iLYnfy93Mk9g4R0
         0pan9vIttltNFUu/EqL3GQtIV7YNpmbgNdg1RFQV4CafIGJBKIp6o7xeXIcHMXcuV2zu
         zeyg==
X-Forwarded-Encrypted: i=1; AJvYcCW4OIbgYL1jRboMSSRGtWWJ8rA+OVN1DiZWlF88EClsIWAEitI1pZ5dleUQxgTDal59H7OM/rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQaHIpcJmlHETe/b79H69w3mQRqwlC/y9lkTxBQrbdVk/BCJI
	YSPbS1rneVAMv5bQU8VdeOQyQZT2VKVj7617p1XTXuydui9A5rmA
X-Gm-Gg: ASbGncu95k8Ub6fej12qJeUK98gFbYwUAcoUD45wLZrQZEGgXjUhThpzsNQHXN5Znor
	pL/WBqj2NTnzGBgnrmcB83m8hpRx7BK5r1TXUNhNKlL4MUAr1luf/y917IeVAWvub6jhQKIZYMZ
	fImnNQ/TuVJkLx923Msmky46j+0ltzTuBY87ckJ1x6LYALLfSpyF5jQMzfU0+reLAK0O/NqoTU8
	yq9DUx4R42ABYYgY+dIUTGUnI22or7jG77R6mNKycrKVpswbfxUs7YstnSJ/s+mGy8F9hPLjtTr
	bI4UGKB6AbfiLYXbBCfBk+9PlRZaIwL6bw==
X-Google-Smtp-Source: AGHT+IEoTtMqXkAZj+eJGXSW6GGMOheYlzTommxgqoff4yfuCr2qzRFgChXGqHR4z3w8PRotbx9T7w==
X-Received: by 2002:a05:6000:41e8:b0:38d:d533:d9a2 with SMTP id ffacd0b85a97d-38f24d1012emr316415f8f.13.1739391548825;
        Wed, 12 Feb 2025 12:19:08 -0800 (PST)
Received: from [192.168.0.106] ([77.124.90.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcb781bdcsm15114197f8f.23.2025.02.12.12.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 12:19:08 -0800 (PST)
Message-ID: <eae73b75-52f7-486a-9f98-91c9ca6f6611@gmail.com>
Date: Wed, 12 Feb 2025 22:19:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] Rate management on traffic classes + misc
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
References: <20250209101716.112774-1-tariqt@nvidia.com>
 <20250211193628.2490eb49@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250211193628.2490eb49@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/02/2025 5:36, Jakub Kicinski wrote:
> On Sun, 9 Feb 2025 12:17:01 +0200 Tariq Toukan wrote:
>> This feature extends the devlink-rate API to support traffic class (TC)
>> bandwidth management, enabling more granular control over traffic
>> shaping and rate limiting across multiple TCs. The API now allows users
>> to specify bandwidth proportions for different traffic classes in a
>> single command. This is particularly useful for managing Enhanced
>> Transmission Selection (ETS) for groups of Virtual Functions (VFs),
>> allowing precise bandwidth allocation across traffic classes.
>>
>> Additionally, it refines the QoS handling in net/mlx5 to support TC
>> arbitration and bandwidth management on vports and rate nodes.
>>
>> Discussions on traffic class shaping in net-shapers began in V5 [2],
>> where we discussed with maintainers whether net-shapers should support
>> traffic classes and how this could be implemented.
>>
>> Later, after further conversations with Paolo Abeni and Simon Horman,
>> Cosmin provided an update [3], confirming that net-shapers' tree-based
>> hierarchy aligns well with traffic classes when treated as distinct
>> subsets of netdev queues. Since mlx5 enforces a 1:1 mapping between TX
>> queues and traffic classes, this approach seems feasible, though some
>> open questions remain regarding queue reconfiguration and certain mlx5
>> scheduling behaviors.
> 
> /trim CC, add Carolina.
> 
> I don't understand what the plan is for shapers. As you say at netdev
> level the classes will likely be associated with queues, so there isn't
> much to do. So how will we represent the TCs based on classification?
> I appreciate you working with Paolo and Simon, but from my perspective
> none of the questions have been answered.
> 
> I'm not even asking you to write the code, just to have a solid plan.
> 

This is WIP. We'll share more details soon.

Tariq.


