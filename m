Return-Path: <netdev+bounces-176393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBEA6A07A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FAE3B61B5
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FAE1EBA03;
	Thu, 20 Mar 2025 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuHbQ5Z5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB041E231D
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455961; cv=none; b=C/jtSg19oQpn7RYp2qVrKkMcNahg4SokFpw29qbmDw6hd0ICQzvH0ChRECmxOqz9GC8n1A3FSxEvB7pa/ssbcUbpvmJre3WABoQ3qB2O9cb8+VSOys1xhFK9aE27//N9vwvvsqBXw2vwZGmdieH3lEiKd6qOFtMiHzp4m8Cscfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455961; c=relaxed/simple;
	bh=daCIASolwaniAtlLhEH0RTBjEHd2HnK/n/ru5jYx7p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfAI1s9+SCFR4v+0SX4DcrZi7Pam3R8fou80D2dVYXt48o1zjlBFNPBUMiiP9L1kGWLL4qSXvMcUJBZCd0aeu5fg79pucdbMqA101CK4SCnWhPJzbSC6VvYbvzBVWkT88Cv3BY1vajWS2RdzAPwhKjnq8YgSmociR1XNbQ8QGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuHbQ5Z5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742455958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8IycAQW9i+7nWsPxtTuBjKHqYQioy6WPT76GyNxAUE=;
	b=ZuHbQ5Z5hBpMbc9d5Ixq+EiUK0m5lnl9fvIeWirKwstQkyhQTFYaWGflsMtSw+9QSZ7mYF
	FLZlTJV1Z/9ib57EFlzyLoi7zWyDk93G93x08P+FRNRjTRZconldAV+VKtXyEnzMRKa1e5
	lga9GJhgTuUfloRE+ivX9SATLpe9WyQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-8JEsqd-ZNTaa3DmJiNVgXA-1; Thu, 20 Mar 2025 03:32:35 -0400
X-MC-Unique: 8JEsqd-ZNTaa3DmJiNVgXA-1
X-Mimecast-MFC-AGG-ID: 8JEsqd-ZNTaa3DmJiNVgXA_1742455955
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912d9848a7so781991f8f.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 00:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742455954; x=1743060754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8IycAQW9i+7nWsPxtTuBjKHqYQioy6WPT76GyNxAUE=;
        b=mi87W3fz7OUD5AP212aX/2NihSiNHIq2xb56P5BDY2s1wdff525kSX/feqxntbq//r
         JEJ84FDhKGf3U83gDNdFZzcq218Dta/4mx4hf7SXy10ht78xn+ayWkWZZqdHxRxOinQU
         cdAEZVehwW1xpP54X1tAR97WdKZi8DD6YRhQVFxMA4gmzuXLceCi/bQFC3jAL0WDR3Yw
         9/OvKh1C0MM2l+ChzEeBLEe8b5UqlmADGIJmU4j5QmUGJVqINd1U0h55bvq4Rv4qpmdW
         2wNJwMXIkD+MMDHmnhSH1P+dv0TwKk61+riXwDXEBNvvB+EFswjFA9o3dl0LnuP3AEE+
         amlg==
X-Gm-Message-State: AOJu0Yxyqiq0SWXKxR0rcv8E3DKou9FBw8NN0M+CiHgMDhBe9pAT08ag
	dkUV4lm7FpjVw/MLmyXNMSvAbIN3FYLG07s4KQ4F9X3Keqp30ICe6JnfGCz8hda4M4/+0+l2sAY
	lUA3PunxtzS9gEUed2VYneTTgoU23Ww2oTaz8DYY4KPpfoXNuA0adEg==
X-Gm-Gg: ASbGncs2btCWbXbnXNDEEjKbuX5Q/KHgPHsvKdsFR3C6OTbGq4sBnBGtqXWeDgM25tI
	4eotRlexwWdw3LdQ1FX6iU/NMvK2JEKAYfvL+w5IJjfOgsq23t1S877hh6mKh/U8YrWe2mDXUn/
	adlDrTVaXqMjA1MfU1s8p7y9Vw0+lDnm1iJQTul01EJJJadtVsnk6TtBRNqRR8Mhc9uoTOnDt5S
	+9D+8mn2SJqaVyVeyAPcX6OC0LZ8IQerMe/cySgjI9BJuMId4plD8pCQZHzN6cJxa8ri/ZbERZx
	J6dPOOxaZViWYdvca1769CleiVni3Km8W4PpQc0gklrd5Q==
X-Received: by 2002:a5d:59ab:0:b0:391:2884:9dfa with SMTP id ffacd0b85a97d-39979575675mr2027695f8f.13.1742455954529;
        Thu, 20 Mar 2025 00:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHes9FMepiTYsK7aF5+u8D4vg7gko5a63whfVo02JMIIfCg1WVHhXudNJPsojMmvl2UsjsWkQ==
X-Received: by 2002:a5d:59ab:0:b0:391:2884:9dfa with SMTP id ffacd0b85a97d-39979575675mr2027664f8f.13.1742455954106;
        Thu, 20 Mar 2025 00:32:34 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df33aasm22593068f8f.2.2025.03.20.00.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 00:32:33 -0700 (PDT)
Message-ID: <e90db88f-05d6-4389-b5bd-5e4146bdfbe8@redhat.com>
Date: Thu, 20 Mar 2025 08:32:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/5] Support loopback mode speed selection
To: Gerhard Engleder <gerhard@engleder-embedded.com>, andrew@lunn.ch
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, ltrager@meta.com,
 Jijie Shao <shaojijie@huawei.com>
References: <20250312203010.47429-1-gerhard@engleder-embedded.com>
 <ab02f08f-d294-462e-bbda-bb6909781ce6@engleder-embedded.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ab02f08f-d294-462e-bbda-bb6909781ce6@engleder-embedded.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/25 7:26 AM, Gerhard Engleder wrote:
> On 12.03.25 21:30, Gerhard Engleder wrote:
>> Previously to commit 6ff3cddc365b ("net: phylib: do not disable autoneg
>> for fixed speeds >= 1G") it was possible to select the speed of the
>> loopback mode by configuring a fixed speed before enabling the loopback
>> mode. Now autoneg is always enabled for >= 1G and a fixed speed of >= 1G
>> requires successful autoneg. Thus, the speed of the loopback mode depends
>> on the link partner for >= 1G. There is no technical reason to depend on
>> the link partner for loopback mode. With this behavior the loopback mode
>> is less useful for testing.
>>
>> Allow PHYs to support optional speed selection for the loopback mode.
>> This support is implemented for the generic loopback support and for PHY
>> drivers, which obviously support speed selection for loopback mode.
>> Additionally, loopback support according to the data sheet is added to
>> the KSZ9031 PHY.
>>
>> Extend phy_loopback() to signal link up and down if speed changes,
>> because a new link speed requires link up signalling.
>>
>> Use this loopback speed selection in the tsnep driver to select the
>> loopback mode speed depending the previously active speed. User space
>> tests with 100 Mbps and 1 Gbps loopback are possible again.
>>
>> v10:
>> - remove selftests, because Anrew Lunn expects a new netlink API for
>>    selftests and the selftest patches should wait for it
>>
> 
> Hello Andrew,
> 
> The patchset now does not touch any selftest code anymore. It now only
> fixes the 1Gbps loopback, which requires a link partner since
> 6ff3cddc365b. tsnep is using the extended phy_loopback() interface
> to select the loopback speed. Also the phy_loopback() usage in tsnep
> could be simplified, because thanks to your review comments link speed
> changes are now signaled correctly by phy_loopback().
> 
> I'm curious about the work of Lee Trager and I will definitely take a
> look on it. I will take a look to the netdev 0x19 talk as soon as the
> slides or the recording is available.
> 
> I did not get an answer from you to my last reply of v9. That's the
> reason why I decided to post v10 without selftests. How to proceed
> with this changes? The development cycle is near the end, so maybe
> you want to delay this change to the beginning of the next development
> cycle?

FTR, I reached for Andrew off-list and he is ok with v10. Given the
large PW backlog and the upcoming merge window, I'm going to apply the
patches possibly before his explicit ack on the ML.

/P


