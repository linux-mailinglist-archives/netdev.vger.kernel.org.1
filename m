Return-Path: <netdev+bounces-146618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BB29D4980
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B320A1F21081
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348601C9DD3;
	Thu, 21 Nov 2024 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpr72xmJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BFD15B14B
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179927; cv=none; b=omggN0XKTyLywlRsX9dyCZpTWT6sw8+z9AYSj39XLLxdHVU8RLQ2axi5WR1Lbbpe+IRuJNu0X0DzgT1l0MhswpG8Pyv+lDe7SAGZNZAy6q9QdhaSW4PPba0k6qy+E4fiDVCGQMob375nJtyp5ZWt+rjNvTpODnZe81ezvUdem2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179927; c=relaxed/simple;
	bh=Ec0PNPCT7vpIqSyOhlssm4h8cf3lK37nCX8sfZhiKy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HG8Hr3R8wmFgIUKsb6NsfI3tP02LPSheptERPcLvOwgYipux8mQeu0x8XRQlwAplVCHywgy4tZW2FmCpKn1NoeS8aeTwQsRr9F+Q9tqz9GIeJrlJFo3x9HRGRV7vQqlNdWen1InJLdtlqUgOPDrbM52PUqu5pGN3wL8IUZYd66I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpr72xmJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jT2ebk9bTCy+GMyYLiRI2aU7X3nKaeJdtYR39sry4I=;
	b=hpr72xmJuPvZ0tiL6lnJAZYtiNHY6JRidV0O30GBj9FRr08b5187zXSeeOYAoODYZSC9IL
	txo/sPUK4Y3b7H9rVp8dZphXZPOWdT9VxXAt3ID/KlwhH9qV5HscVEqCVH7wb+1RyvbwAX
	reXh2C25YNtNhFix/gX9ulCeZ5cjyfE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-ZPqqkejbOfCFmyAO7m1NSA-1; Thu, 21 Nov 2024 04:05:23 -0500
X-MC-Unique: ZPqqkejbOfCFmyAO7m1NSA-1
X-Mimecast-MFC-AGG-ID: ZPqqkejbOfCFmyAO7m1NSA
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e2971589916so1088125276.3
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 01:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179923; x=1732784723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jT2ebk9bTCy+GMyYLiRI2aU7X3nKaeJdtYR39sry4I=;
        b=DRcU9oxiI4SL5nQlY/573hd6Qaw/WJlbSfyH34MSdjuTq4vPas3NIcMObYz4MEf0ib
         jrvTaNF6BKZElP1eU8KmfbZWOzTtY5SDNlVZCBpA1EbS4N61UFN9SwFqfHUEItI6UoSf
         gGCBX81MIY3dYMOispFgUl1wE4XpbQkPb6M4ajqw0HMApmYuwRILK5IqIDSWjQGJhsA2
         kzE+vRkqSNv8MgXsuFT5GYP/mNaGjtJLQukBe1H008gnKUpXsz0dUQ3YBGKQDx2IrRZc
         2o9oQHx9mkcg5VwvFXbf0xJ7H8DeK5HQ0kyIqphj+vKKpf4e81A0sX5fjLlzVxfkFpDt
         ZweA==
X-Gm-Message-State: AOJu0YyjYz82z5qWctNqHDitmFotKy06km56qU0ZBZNK5ayxgAni0ceW
	LY/xZI/i5KiTYuFfXJNY1iKjjBm2m2LKjl6oeWvt4wLAodocckKGEhkhRDB5f52e9SYubIIvt9j
	n8ryh9VGNewtxeYNCtX4Q7E0IeX/HZgth7nDAia3H6eO9MOE7YdNpeQ==
X-Received: by 2002:a05:6902:1610:b0:e38:87bf:8e58 with SMTP id 3f1490d57ef6-e38cb56ba22mr6905585276.13.1732179922919;
        Thu, 21 Nov 2024 01:05:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgNQGUoxvn+fRAAKmpRVafqPIYLEdd+RINB5HIuZpbv8uIGcrt+3Rzpz8YR7Bx2YLroylcGA==
X-Received: by 2002:a05:6902:1610:b0:e38:87bf:8e58 with SMTP id 3f1490d57ef6-e38cb56ba22mr6905561276.13.1732179922630;
        Thu, 21 Nov 2024 01:05:22 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46467fd76e2sm19569991cf.12.2024.11.21.01.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:05:22 -0800 (PST)
Message-ID: <c3856743-344c-46a5-8b42-567ebd7b6796@redhat.com>
Date: Thu, 21 Nov 2024 10:05:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: wwan: Add WWAN sahara port type
To: Jerry Meng <jerry.meng.lk@quectel.com>, ryazanov.s.a@gmail.com,
 loic.poulain@linaro.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120093904.8629-1-jerry.meng.lk@quectel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120093904.8629-1-jerry.meng.lk@quectel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 10:39, Jerry Meng wrote:
> Add a Sahara protocol-based interface for downloading ramdump
> from Qualcomm modems in SBL ramdump mode.
> 
> Signed-off-by: Jerry Meng <jerry.meng.lk@quectel.com>

Process note: in the next submissions please include a short changelog
vs the previous revisions after the SoB tag and a '---' separator.

Additionally:

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle






