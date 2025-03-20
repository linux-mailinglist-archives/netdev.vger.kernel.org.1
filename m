Return-Path: <netdev+bounces-176565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FB5A6ACF6
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4080C188D953
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45388226520;
	Thu, 20 Mar 2025 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gh8KwOI6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177D22687A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494468; cv=none; b=SL2cG2kato3AJcr3Wdcz2DFCynV5PzNfktWixzg/KnvnCguvzc0QijjsJBG8RoYtfGGTJbzjGWfCVd47So9WLseix2AFbpO8p6Cmzu46KswLnHYLK2DfeB5up7EveTINxGRjA87FzH4JIC/KBfjQ6xx0znt7NcvyUW/TqcDyrjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494468; c=relaxed/simple;
	bh=Ht7zg/lWp2RtKVAOnAyINtSO3KgxIs/HQKGzi5epFRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTWqjzYsQ3rAmy3Rf20vzqZnqkGuUNeZxDKpRgW5WnDRtuFfSnedI1i1wdzx5AyB7VHltWlKAe2f29JjvachWMtdy6M//511j/fot9oNYpkGDz8DO+8ohPgPvKvFubGM9sslw61VZtj0ISy3/Isssw2anDR2YRqGwwD0gWBFcks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gh8KwOI6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742494465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9d9DJ0ZVtXpP1JTgzvhnXYbMlGyLyzfODhvv2JqqC8=;
	b=gh8KwOI6hpskJC1oZ0xWSjI1/e7mEuAmvo1CnxRjQ9+9Ew3Kjn6q9ahw7p/tuF7snGUTgR
	XTpX9J6xZ3ifKjVGBaMnIemyWdO5nwwg6TdkErS2kow/H18TSshwTOJlPW7j4ZjhfKNQXc
	YpXYzmFp0BYpSDrudwXUN67vRuqdd3M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-R3vRmYWcMaatWO3LVPg1TA-1; Thu, 20 Mar 2025 14:14:23 -0400
X-MC-Unique: R3vRmYWcMaatWO3LVPg1TA-1
X-Mimecast-MFC-AGG-ID: R3vRmYWcMaatWO3LVPg1TA_1742494462
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso5819805e9.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 11:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742494462; x=1743099262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9d9DJ0ZVtXpP1JTgzvhnXYbMlGyLyzfODhvv2JqqC8=;
        b=E8h+dJRNNLll8oZmjo66WFVo/Zq9XiAFYM6nkkqnvoRJhrT3nQdkQlLcXdH1uev7+6
         A8kOWMSd1JcEe8e+ehh8o5R4qPR3M6YLRdigO7GOOyQJqer3Fls1K53bAV3mM95P4khz
         LA921NpTqAjdkcrNmNayHHkdlEl4SIfP+e0O9nMGuLLd2sNxfKuzk7S5q/XyfhI8KloP
         rSjZXUzu+Wkf0OrdPAe3O6rAzJLR1ubbNLyPjQ3bwU+ftzYDgWancYRECpg52EslDq/4
         aySFvWnzq8LyzIiiU3nzgY8C8HJaCRzZLyVA4PpHU+c8mw/z+6P8G25OdVK3TAxC5v++
         seSg==
X-Gm-Message-State: AOJu0YwhCQhQTm4RyUZtNmOF9KPM+MendGk7Up8ou8agoCO4N0givlVp
	ZGduoup8NNTizv7pDu5VIfghBaFs2/JOm/nFPPQnTpEvPTV3jIXdmjsR+cuYnNxmnu/ocVnze5+
	iXuadB8bgSRHk2ATRxCr4YrjPkVvzKw8td8QTfsmy2HuBUYEZcfy9Sh1FQjiCmQ==
X-Gm-Gg: ASbGncs+x54ivN/WnAxOoLwMwWvGofkhMF1/ZxCBR5liwOiQjxQqlY8Ko4qxv6VPchh
	HfsJYcoJM0t5mhhV54TYpapb9EfhJyepX+byGNmRVYLe+P0RF3wWVTjMELybYMcfN1m1pmEBlVY
	D223BgM2Xtz5m0qiEXct4rfJyc8MYYw7tdeMRaGbftXXmRUC1yC3nxGEjZeMmw3WmAGIO9vhX/B
	QoTh/XRJIhS8hWf5kN1qL5KPO0iR5n5Oovd9jTt8fkaV5XgULa5nigF/y3dli+KJdPQfzulVmnm
	sGExqVt3cUHzHmsjUm0MzmMkEtr7JTG7I6qs78DiDhZ4xA==
X-Received: by 2002:a05:6000:1f82:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-3997f95960emr416434f8f.50.1742494462047;
        Thu, 20 Mar 2025 11:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0bJR7we2wPyrCmbzCTXMZ6xkag9BS5KgqWOoYUWgJZukJr4kWJcPQKQKwzDhae7G/5w5uRw==
X-Received: by 2002:a05:6000:1f82:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-3997f95960emr416417f8f.50.1742494461659;
        Thu, 20 Mar 2025 11:14:21 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b5b8dsm256093f8f.59.2025.03.20.11.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 11:14:21 -0700 (PDT)
Message-ID: <3c2c0087-ff79-4a1a-b1a4-7d4d4100bdfc@redhat.com>
Date: Thu, 20 Mar 2025 19:14:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: introduce per netns packet chains
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
References: <2b6ce88cb7da4d74853cc36d7de4b1b11a7362e5.1742401226.git.pabeni@redhat.com>
 <Z9wuVAyFYcziY4-D@krikkit>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z9wuVAyFYcziY4-D@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/25 4:03 PM, Sabrina Dubroca wrote:
> 2025-03-19, 17:24:03 +0100, Paolo Abeni wrote:
>>  /**
>> - * dev_nit_active - return true if any network interface taps are in use
>> + * dev_nit_active_rcu - return true if any network interface taps are in use
>> + *
>> + * The caller must hold the RCU lock
>>   *
>>   * @dev: network device to check for the presence of taps
>>   */
>> -bool dev_nit_active(struct net_device *dev)
>> +bool dev_nit_active_rcu(struct net_device *dev)
> 
> I guess that would have been a good time to make dev const? (same in
> the new wrapper)

Makes sense. I'll do in v4.

Thanks,

Paolo


