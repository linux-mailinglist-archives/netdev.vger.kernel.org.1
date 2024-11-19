Return-Path: <netdev+bounces-146179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6329D231F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F01F21DE5
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8177E1C1AD1;
	Tue, 19 Nov 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAOMoBgM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A2198A35
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011144; cv=none; b=mfOXynu+wwMMFadQwGp20GG4+VK/bOCHAQeazQlTlO2uVxWVbh3pseYtidD4uWj0CLq42LE4ZCBp/PN/LhUkSFofKVRl9BVAOsG71qLrwNa5fMru0G6IPXyMDlXqoBACsxN2dVLGaeQQja6MFvIZPY/5oDoeXHV3zAZhcgHpSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011144; c=relaxed/simple;
	bh=RZKQppqR9ulv5+UY512XsPJDhRPR3ltZNrET/GxkkTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me3hTd2jIP3L4y2/9ip0nRpqJnmf+Ip5CSIH8hq52hofo0QgQzD4rONBW0kfKpxwSZKFHb5QRUdT1D8NsRr1s7fNjDGpO86vNSMPyC5PYTfJ6Ngpfa+9j58rBWt+6yNfg0yEUezla5+uNnz2A0ci8tDtR9DT3Q0HHxI5StzAvUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAOMoBgM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732011141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/ll/h4cIcHRULNe5533lZjrqgLdazs+/VxZDeHMmso=;
	b=eAOMoBgMKSK4XhOwf+UNI2cXqdojeWeKoNEJ5kxR5OcgATAqvX7Ic/GtnPv32uW3y3HVNg
	h4XEkX8NbHpgXCNrvzswOMx9+8i0S/bqd6oCQfAS88dHRyTwADYq4z3houk0NzaczdTmPO
	angdoWu71Ji0Gl94KroFouQzA27Xb04=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-70SlRvb7Oj-lR1KDoB7Izw-1; Tue, 19 Nov 2024 05:12:20 -0500
X-MC-Unique: 70SlRvb7Oj-lR1KDoB7Izw-1
X-Mimecast-MFC-AGG-ID: 70SlRvb7Oj-lR1KDoB7Izw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-382342b66f5so1774392f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 02:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011139; x=1732615939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/ll/h4cIcHRULNe5533lZjrqgLdazs+/VxZDeHMmso=;
        b=fxExBLk5v6dT4nfVEKC93zMmLnloJdlai0a4SXdaDy67P9shR/FqRTVISug9MnRi1n
         dDo9aqX/Ujraef0AaE8sfK70SkE4KKl8inWS1/ns5ZB9unUc9zBZIOpBkZVoH776MDJN
         XC05/MbOu6jM7qlIfGhK0BusNoXZ1jjl5fedEVq1Aj8a1jzHR4FWjnaQhM5GFvxmkklV
         +QRWzM3+c7XBjsGh2f0rUT2mt9J9M4Gf6NyIjcM87EtDcp8KrvW6HINAwPeND70im4Qv
         tGVh48ZvCjJQrZOhEjmHjKayEBfotCX4R8j47ll0qxYgOVlHrfVS5hDFIFZzlDNMeQol
         rFrA==
X-Forwarded-Encrypted: i=1; AJvYcCUdVxyyQsQalatTpcYthwPcMj/PCcynF47sSJ4y/OOeNhVdBh+/YBCSeKe8Y8LeXsp0mV+m0QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaf70Qq8kHqF4SOZ5u2xiYoFXCihE8Adwdofzsd4ydeTvOJ18S
	AW8PgvRBNA44dNtKTWfMg4YRYGkcVfK/hSAOLi4uKUYelsdtloQ5u2ki5U8ThDpnRJ1WnVBWzhB
	V8o0XvvpdARBhf0R5ZWP+u0A7J6SBGj4ZO8YAb8ihROd+okuhF7mYgw==
X-Received: by 2002:a5d:64c8:0:b0:382:2d59:b166 with SMTP id ffacd0b85a97d-3822d59b4c3mr9274035f8f.31.1732011139222;
        Tue, 19 Nov 2024 02:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsZiTehmq/TGAqmnasd9Ezz+OKagNClXCsAKRt9ii4MiUiLKopP3o2dTpIdkPJjOhag9LPew==
X-Received: by 2002:a5d:64c8:0:b0:382:2d59:b166 with SMTP id ffacd0b85a97d-3822d59b4c3mr9274006f8f.31.1732011138858;
        Tue, 19 Nov 2024 02:12:18 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38246b7db13sm5907061f8f.91.2024.11.19.02.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:12:18 -0800 (PST)
Message-ID: <554d8684-7eec-4379-9a21-0b4a562358be@redhat.com>
Date: Tue, 19 Nov 2024 11:12:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] selftests: nic_performance: Add selftest
 for performance of NIC driver
To: Mohan Prasad J <mohan.prasad@microchip.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch
Cc: edumazet@google.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, horms@kernel.org, brett.creeley@amd.com,
 rosenp@gmail.com, UNGLinuxDriver@microchip.com, willemb@google.com,
 petrm@nvidia.com
References: <20241114192545.1742514-1-mohan.prasad@microchip.com>
 <20241114192545.1742514-4-mohan.prasad@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241114192545.1742514-4-mohan.prasad@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/24 20:25, Mohan Prasad J wrote:
> +#Setup:
> +#Connect the DUT PC with NIC card to partner pc back via ethernet medium of your choice(RJ45, T1)
> +#
> +#        DUT PC                                              Partner PC
> +#┌───────────────────────┐                         ┌──────────────────────────┐
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#│           ┌───────────┐                         │                          │
> +#│           │DUT NIC    │         Eth             │                          │
> +#│           │Interface ─┼─────────────────────────┼─    any eth Interface    │
> +#│           └───────────┘                         │                          │
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#└───────────────────────┘                         └──────────────────────────┘
> +#
> +#Configurations:
> +#To prevent interruptions, Add ethtool, ip to the sudoers list in remote PC and get the ssh key from remote.
> +#Required minimum ethtool version is 6.10
> +#Change the below configuration based on your hw needs.
> +# """Default values"""
> +#time_delay = 8 #time taken to wait for transitions to happen, in seconds.
> +#test_duration = 10  #performance test duration for the throughput check, in seconds.
> +#send_throughput_threshold = 80 #percentage of send throughput required to pass the check
> +#receive_throughput_threshold = 50 #percentage of receive throughput required to pass the check

Very likely we will have to tune the thresholds and possibly make them
dependent on the H/W and S/W setup (Kconf), but overall I think it makes
sense as a first step.

Thanks,

Paolo


