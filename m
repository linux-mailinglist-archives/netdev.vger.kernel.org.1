Return-Path: <netdev+bounces-146245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254E79D26CD
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F181F22FFF
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318B1CCB49;
	Tue, 19 Nov 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCcv8bqB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4DD1CCB3C
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022812; cv=none; b=QBNIYSRHKGzttNu8I7DEzIndirifID8Y3aRorAr376ZB240CdBgJ+KVYXpxpNKxXX4nMZ8Y6/eCSWGQNZrK1vsflQxRC73bbbUxpKI59QQ6YEu3XvJ9Sai0UFtkDqkQX+K4MfIaK7+LxcpW5ZRBE+aPYUZKfIhvuKaAGqcEfGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022812; c=relaxed/simple;
	bh=dHzqkeXyGZxoyEER89dgFvalpys9/u2EZB4Kf1NdMAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyJ9MHQv/SzmytyeyMn3QEAjgxZA5r6Xs8UgFCydI6OaTnHs+Jbig64nEOHwnYSXGDYMz8DDCOdc9/jGzyWVn3azfALxCJhXZDA1Shj8ziyfj8TB7R1THffqj8GT3UwxbLFtAgnttVPWWj3OO04XVHIN36Fa/52sZxPq4BM421s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCcv8bqB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732022809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o6U12McX0gLRso4X1EBn+6q4cTylPrsJWbZXzRtzWis=;
	b=iCcv8bqBGJRkdwX1/z9V1ZOkSswn1YwbQKoLn+gGouSoO+efkwxm2hwbwYfbALK0hykwpQ
	sP9IhHAgy7UjxdM4wXZvQigrJ1pUXxYP0Nju0JtHj4a4r5WMEdt4uVCuUWmwx8285fuMVl
	UKWWOsjvf8n3oM5ixXALFp5LsPj2zv4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-uWuivdmuOv6KeDvs-h8yZg-1; Tue, 19 Nov 2024 08:26:48 -0500
X-MC-Unique: uWuivdmuOv6KeDvs-h8yZg-1
X-Mimecast-MFC-AGG-ID: uWuivdmuOv6KeDvs-h8yZg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431518e6d8fso23470165e9.0
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 05:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732022807; x=1732627607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6U12McX0gLRso4X1EBn+6q4cTylPrsJWbZXzRtzWis=;
        b=U/fhhQVeSfWZ5iO75OjUV5NJX6cytX5g80xTsmajOMJJRar/J573t+z/yFeQgXWm9j
         fJocC+C8ExeifbbkGePr5cFYMyjb2e5kO7CWBXBBmVpt2iOuzzLtIvXThHHtKWuho7jT
         IBnucAiAKXj3iw/xNULsWWLzLHj8s6lOduP9nw1RAfDuVRTbkdNePEi0pVPKZKcfp9jA
         P2K7kiDxg2uVPv6Ck5ODtfGX7XgtfPAL9mJQph9i2CtWFFu4P1B61EMiDy9mYacpBab6
         PKNQllKDhemRQ1kW79Nz9N2SlkWTXjVla+PYIWivfZ6nMkBGtbKzNZQWrP32ypirS7yu
         aP/g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4L7AcIsIto/xzqQzao4U1HUg60FLZEuuWWophGwuigC6tE8EjpJhkZ4RwOCPQy/EEvJe8z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6D3wQ8JpNofX13quO7/WWcxdj7TyjGzt3hlv6UneQ3l5eTPZP
	7EWl8q13bkqBwTCezfkrJ1uEtTJndF8h+N77RRBPQ/pGD+EwKInyYmAFc+u9Wl3HOYfbpQlrmKu
	1rRID+rzrB49sQY3zWo5E6lKxWGYTwQ42UQlWpoVlrq2JNjrLyEyj/Q==
X-Received: by 2002:a05:600c:a06:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-432df74ebdcmr137446305e9.19.1732022806941;
        Tue, 19 Nov 2024 05:26:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/k+jIPt/dDGdVaALFmmUrMT+C/DcK08Oar0xgRAdR68ilXIx+aM6j48Xg3ytlxudYqX9m+w==
X-Received: by 2002:a05:600c:a06:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-432df74ebdcmr137446145e9.19.1732022806610;
        Tue, 19 Nov 2024 05:26:46 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7220asm191372055e9.6.2024.11.19.05.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 05:26:46 -0800 (PST)
Message-ID: <2f3ccc2c-6cb1-46c5-a462-9489e1c4471b@redhat.com>
Date: Tue, 19 Nov 2024 14:26:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/4] net: ipv6: seg6_iptunnel: mitigate
 2-realloc issue
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org,
 David Lebrun <dlebrun@google.com>
References: <20241118131502.10077-1-justin.iurman@uliege.be>
 <20241118131502.10077-4-justin.iurman@uliege.be>
 <1bc6fbd9-aa04-4bed-b435-262edd8f2d37@redhat.com>
 <5dfc336e-d7e0-4219-af1e-6284facbdd94@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5dfc336e-d7e0-4219-af1e-6284facbdd94@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 14:07, Justin Iurman wrote:
> On 11/19/24 11:47, Paolo Abeni wrote:
>> Also the code would probably be more readable with:
>>
>> 	struct dst_entry *old_dst = skb_dst(skb);
>>
>> and using 'old_dst' instead of 'skb_dst(skb)'
> 
> Ack. How about "dst" instead of "old_dst" (since it's the current 
> dst_entry), and "cache_dst" instead of "dst"?

Fine by me. I guess such option should also give a smaller diff, which
would be a nice plus.

Thanks!

Paolo


