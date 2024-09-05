Return-Path: <netdev+bounces-125495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA50B96D610
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091951C254D5
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B491990DD;
	Thu,  5 Sep 2024 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZaBWKp1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518D19882C
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532071; cv=none; b=R29rMlpNrqeWOFuQekvLh9JK6v/lVidXX+6LYyeyQsaRUcN6XLovolab7Afh3uaZ8VCpp033Y1INMP4kaaqTrSkpkejo6otmBtpQZUi3WtcZjpNeC30VEI2ZQ4KLlmAaSPDiW7GWbn3vcPJ/6PloKO6Dhl+IV28wdsQjPCKieeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532071; c=relaxed/simple;
	bh=fLnaSEMwTToqbULVT0rbA5FWXK2jDlM8vTXItsk0pPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7zSsiGzQZppsiOOyvE8dmWuCaaYPE5y/Ib+/EVmCRzib4o43g0iyHfarc2RyXQ0zv/nzgNWcd5u+YZWkPxsuHRvrVZaOJn+UsthhnCwLtJf1dfOxGE7Xvo0pQd4nJU6bL7EbfwTh5fvHPnIOvTkzPjUudjF0/HmgTftveQBCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZaBWKp1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725532069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPZY07hdzZVf0G40Y7mAQP+lGDT6ud+TjaZvwKM2DVk=;
	b=PZaBWKp16+fLU7nyaaOc46GUgQrZ8Dch+zHGjDu8Yn4RxiqgQodDtrtXrj9njMujD2Uz2U
	doJ4r4fafnxpj8VMVwk3P7wRW4cA91LdPWD/gR1oZWXsmLeHjjf7ki+CFkdu/fWqPsAd1O
	xfPsCmlJAW0zt+TDab/sjDkPV3y/FBw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-rGFcjGHhPJqjSJci0j469Q-1; Thu, 05 Sep 2024 06:27:47 -0400
X-MC-Unique: rGFcjGHhPJqjSJci0j469Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c32158d0so402009f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 03:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725532066; x=1726136866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPZY07hdzZVf0G40Y7mAQP+lGDT6ud+TjaZvwKM2DVk=;
        b=k6YKhmTMTVteuWTd5x/6nlDtsNSyVBl847ccODn038Vqc7zF+SQcwafAb/dq4uWKeW
         ScqtP4u1lK4s1NvldgWHhwU/4MsKwGOwaPtYuLR8fvI0auvNrvhn+pZyFc8ZRjIzxI4k
         5ldnerva/bhwEIW9ygnAreBsg7f/U3XpOQNlBOrttURPt/Y/EMUXsU7LX0OARyawplCo
         BZCb8rdRdnLAwQh+/X2uPyRW+MINmNq6xbpjs0j9/V/542HdnC1IX6A6PkucgDc0VxYw
         tfFdTuwTNlhqJU1wukS0pXfqT8RlpYZ8p4cqd/zLhJGBg7WFfo/CxWQDIEyj3x1TlTob
         bkFg==
X-Forwarded-Encrypted: i=1; AJvYcCUKDSGFpC6yn9WvzGb/BrLcwUjJrUh22H+9bHYrXSb6v+JZZs+Buskrg6/zqTIjS27/gV3TqwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZla2sDzojTnXRcX8rqjsk1Z8yJAGx05Ndb89eNQ2Z1P+9fIw
	f8cNwUnJuD5SM5g1E2eG8PFZkMmz4kezKm3EysTzsbhiYUv6XxG7mduVtZZ4msX+Y1gFv+7UVfV
	PVN7afsI9B2rNVcMW5QPiTLdpLZ7DC6JNkWuZ0YbHWGrUx7Q4QDaoMw==
X-Received: by 2002:adf:db4b:0:b0:371:9149:dc54 with SMTP id ffacd0b85a97d-374bce97a6emr11563791f8f.3.1725532066630;
        Thu, 05 Sep 2024 03:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELrkDTki7RK2Sj/ftb+YWjMBHGRyt5865Zm3SuZ0YuC1n53erV/zIV711siGKvaK8a5Qowxg==
X-Received: by 2002:adf:db4b:0:b0:371:9149:dc54 with SMTP id ffacd0b85a97d-374bce97a6emr11563768f8f.3.1725532066073;
        Thu, 05 Sep 2024 03:27:46 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ba593876sm15319716f8f.5.2024.09.05.03.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:27:45 -0700 (PDT)
Message-ID: <8fe1d9da-40cc-4537-80ce-6a2855c2dec4@redhat.com>
Date: Thu, 5 Sep 2024 12:27:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 8/8] net: ibm: emac: remove all waiting code
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 sd@queasysnail.net, chunkeey@gmail.com
References: <20240903194312.12718-1-rosenp@gmail.com>
 <20240903194312.12718-9-rosenp@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240903194312.12718-9-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 21:42, Rosen Penev wrote:
[...]
>   static int emac_wait_deps(struct emac_instance *dev)

Possibly rename the function to something else, as it does not wait anymore?

> @@ -2419,26 +2397,25 @@ static int emac_wait_deps(struct emac_instance *dev)
>   		deps[EMAC_DEP_MDIO_IDX].phandle = dev->mdio_ph;
>   	if (dev->blist && dev->blist > emac_boot_list)
>   		deps[EMAC_DEP_PREV_IDX].phandle = 0xffffffffu;
> -	bus_register_notifier(&platform_bus_type, &emac_of_bus_notifier);
> -	wait_event_timeout(emac_probe_wait,
> -			   emac_check_deps(dev, deps),
> -			   EMAC_PROBE_DEP_TIMEOUT);
> -	bus_unregister_notifier(&platform_bus_type, &emac_of_bus_notifier);
> -	err = emac_check_deps(dev, deps) ? 0 : -ENODEV;
> +
> +	err = emac_check_deps(dev, deps);
> +	if (err)
> +		return err;
> +
>   	for (i = 0; i < EMAC_DEP_COUNT; i++) {
>   		of_node_put(deps[i].node);
> -		if (err)
> -			platform_device_put(deps[i].ofdev);
> -	}
> -	if (err == 0) {
> -		dev->mal_dev = deps[EMAC_DEP_MAL_IDX].ofdev;
> -		dev->zmii_dev = deps[EMAC_DEP_ZMII_IDX].ofdev;
> -		dev->rgmii_dev = deps[EMAC_DEP_RGMII_IDX].ofdev;
> -		dev->tah_dev = deps[EMAC_DEP_TAH_IDX].ofdev;
> -		dev->mdio_dev = deps[EMAC_DEP_MDIO_IDX].ofdev;
> +		platform_device_put(deps[i].ofdev);

I'm likely lost, but AFAICS after the patch, on success 
platform_device_put() is invoked unconditionally on each deps[] entry, 
while before it was called only on failure?!?

/P


