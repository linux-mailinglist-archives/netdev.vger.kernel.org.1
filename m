Return-Path: <netdev+bounces-147948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DDA9DF39A
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 23:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F13B2079A
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C5A1607B7;
	Sat, 30 Nov 2024 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="wne0II/e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06915A864
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733007585; cv=none; b=B1PuxgdjmDGY2onE51g+18Ci5vO9xudYoLhBqUwSzO4W/53pJUlqD9mz7WKjmrkCpe87yhtyLBeHagXeypqSPEPHz00+1mFeTskMYF41pLSQPmitD99dknPmRXM12KlzYI1h02tybPVnRfyD/KYKmGw1IOHh8M82q7gXpaljU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733007585; c=relaxed/simple;
	bh=6k7mLC4kA33FcxZWMnMueyX+wy13od8KKIpTrv70N+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqeJ6x5I0enXKkRkTk43JkrdHU5oBDG/1wDnvY1ZEk4HzW4XnSJheW8XPYZ0e6KyP0CMecVrAOW3bscNjqry7QQzEqHaLa52+h7QUsoemw3/WcL7SO1iKJSo4h4PieGhwAIWucGpiiNm0Eo0Ax3u66EjLhSGfbCln6OXALiVE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=wne0II/e; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2142214abd2so24211645ad.0
        for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 14:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733007583; x=1733612383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXiZf24JxhP8ou5NHiPugKJGx/AjkR4iHTEWX2K7i0Y=;
        b=wne0II/e7KvCoQbIkfSsnbPKroQinwsoGKGB5pKXHjmtk1Vt02nSXAgpzZhi6y+HX3
         1PSryy5RL0ch2jR2qCgGYU4Jl5wWdjvBvZcETi155RWrLJB1jLL4lVzhkHkauIq6scwg
         rLXIw4RKjcyU7ZndRH72I45aoNHQbiS7qJsB8QTfX5OaEMcvH7UD89xFfnSXw5ODKdPx
         tdtuRP4TdkiE2+Ckuc0JC94pfI7ZElJwWS6BcMQvyHhkx01ZFGeFtING0zZqRFUSLF6T
         F0UwDmX4pK6ZojsqaZBydJHcdrHo+loOXPsOsKv78ZCDOH5nc+QFNbnOK48ihIITgACN
         8JGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733007583; x=1733612383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXiZf24JxhP8ou5NHiPugKJGx/AjkR4iHTEWX2K7i0Y=;
        b=hir/Gux9WGPkPb68Rj9lM9lTxN8uySLyguqIgtzlmORtnbSJfm0u33K4jE706of/Sx
         oJov3n02McMzwCdR/Jt7jiQMml+YhdCD01vy9m7wajesLPXWVWkE1JvOYIAhg0cdw7G8
         2KGrsNDnPDCz+VX08RnK07AAt7cwgw01ESKqRLcjB+/uLH+BVORBHLZXCY5v/okshBWb
         +CguNC51qMWM/u65mmjm1zkjGxDPUNOHji6epGDpTZe+99R5BdAiJ5EE6ngPO1+QbVC1
         juoZ21Quxwz9qKVfW5GZ8DG7ERnHWltBMh1z8ACWLg4XKoMr0X9kmCGy+TLx4Yi7tV8A
         49fA==
X-Gm-Message-State: AOJu0YwRb61xAOe+K9JiTmNzG43NrxNhwn0fSijFmgpXWE+vnumf/aH3
	htlFEjPXx0wjJS8h6VA/EEvlH3lGMKojum6oH0MZuAh5Km01zIpqzZ9teqZKQkVlv7clY+YOLuf
	c/yc=
X-Gm-Gg: ASbGncueuNf5ItA+gOXb7/opnAdaockJiD1ics4lFfNXGSfkKJ5osjrzrKzQG7HA6ER
	cPbYVpMWDItGk60GDUSg1Fd5/XO+AN2u9cYGrxtNW3TVS4oBo88WLUScvg07o6T1zbDJkE1D2+0
	GomHghJHBpnGA5j82MCMOMsEJwlq6gJ67QMjWOuH7kpR/lg9hCWzsDcPdJXAIaHR4HT1HO+A7bl
	2P+kG8VunqN/6sNDkTS2b2K69Kedu8Zvo9xfL32edrS2RvbZBESZtP4
X-Google-Smtp-Source: AGHT+IFo2NK9DjW+rQvUWZgyjIVjJ1b12XEgghjxJsDOPmRsTg+76nlN47yXnh7TwrSPYUH1x71smg==
X-Received: by 2002:a17:903:283:b0:214:f87b:c154 with SMTP id d9443c01a7336-21501087636mr234657855ad.5.1733007583268;
        Sat, 30 Nov 2024 14:59:43 -0800 (PST)
Received: from [192.168.1.12] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219bd669sm51127105ad.246.2024.11.30.14.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 14:59:42 -0800 (PST)
Message-ID: <60edc790-1485-457c-b024-0314514dced8@davidwei.uk>
Date: Sat, 30 Nov 2024 14:59:42 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20241127223855.3496785-1-dw@davidwei.uk>
 <20241127223855.3496785-4-dw@davidwei.uk>
 <20241130141531.6fd449e1@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241130141531.6fd449e1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-11-30 14:15, Jakub Kicinski wrote:
> On Wed, 27 Nov 2024 14:38:55 -0800 David Wei wrote:
>> +	if (bp->flags & BNXT_FLAG_TPA) {
>> +		rc = bnxt_alloc_one_tpa_info(bp, clone);
>> +		if (rc)
>> +			goto err_free_tpa_info;
>> +	}
>> +
>>  	bnxt_init_one_rx_ring_rxbd(bp, clone);
>>  	bnxt_init_one_rx_agg_ring_rxbd(bp, clone);
>>  
>>  	bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
>>  	if (bp->flags & BNXT_FLAG_AGG_RINGS)
>>  		bnxt_alloc_one_rx_ring_page(bp, clone, idx);
>> +	if (bp->flags & BNXT_FLAG_TPA)
>> +		bnxt_alloc_one_tpa_info_data(bp, clone);
> 
> Could you explain the TPA related changes in the commit message?

Got it, I'll expand on why the TPA changes are made in the commit.

> Do we need to realloc the frags now since they don't come from 
> system memory?

Yes, frags now come from head_pool instead of system memory. The old
head_pool is freed and a new head_pool is allocated during a queue
reset. Therefore the old tpa_info with frags allocated from the old
head_pool must be freed as well, otherwise the driver will attempt to
return frags back to a different page pool than the one it was allocated
from. When the frags were allocated from system memory using the generic
allocators, it didn't matter since they did not have their lifetimes
tied to page pools.

