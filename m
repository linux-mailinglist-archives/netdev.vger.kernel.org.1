Return-Path: <netdev+bounces-174562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E41A5F43F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7556619C2192
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414D92676DB;
	Thu, 13 Mar 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYTlV8iM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CA266F09
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868699; cv=none; b=RVyERIPspMHSAECde21RnQwVi+Bv6VRfmmWoQQJAIvB/FjxY/KNYtxdPwgUdlHJU3U1PgdjiXMWiLNk6Fy/wst3kXGG/p0jp6oLrmVXmQJMYNrjT98x39neMH0TBIwv5HfHpaY2JGsF8eCsArBNUdIfMsUW2Hml+YQ/YeAh0MYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868699; c=relaxed/simple;
	bh=3piGY6Mos9lWEASypJlgl6NU89/tZvm07nsj0xWexd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqPOYtwaerhTBw+QZ9kz4ThhIo/hMJRTpktJRycJJT1RKXwt/ar3+JLEw5s/T01K6Tu+T6vWO6V+Uq9trhOu1G0oyea1F8mwQUdPv9UBflrJTuWvn8XKS5mYm3AN9KS0zQHaebCfiBBaMr3zPuZ2gaPPkWdtVdXn4kqbrpr1d1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYTlV8iM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741868696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41pRJjFSQunsUf3a0XIIQpPveoWhQuMHRR8nqruq92Q=;
	b=SYTlV8iMBX/OFZegE5Y5fCvF4+QCbUHOJSVYYkd0RJKNCrom1IXQj2CoxUl/Gz1R1O2flx
	GIJU4HZypKYE3bxIG45jvgRXW1XHW3Q2TUR6a0UFPI/A94RnYaQx/IDlN7fb0XNut2Ib7W
	h5K3HJpcb9pqT0RMdGjCUvwBu8MCppg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ocsOEouFPRSrhfTj1ROZ5Q-1; Thu, 13 Mar 2025 08:24:53 -0400
X-MC-Unique: ocsOEouFPRSrhfTj1ROZ5Q-1
X-Mimecast-MFC-AGG-ID: ocsOEouFPRSrhfTj1ROZ5Q_1741868692
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf446681cso4583985e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 05:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868692; x=1742473492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41pRJjFSQunsUf3a0XIIQpPveoWhQuMHRR8nqruq92Q=;
        b=tRhAbih+6q3V4LCGpA7JBYBiycDGx6asF629T1GOcrrHH2FoGvvJ5ado62w0oKtjZi
         axoSC+MKPYv90DRNAFmuhMLiziB7UrGoxC4DcKdwDJEWDS/34Fvb6EvawW4MG7Pl/sw2
         qdk7yBr5UB8+rSrTrCkfEMzHPzMZEuvbJe0F7iwK5ewwLSIq4IWsJOI75IWsQRSypt2W
         4r/dmWnQA9cKcf6Fy/XUHGscFDquorqODGvFqnOcKewT/sPzm5MgJwKZEo7PGILFnpwz
         qWrBDQh+ZCoRvs/yxXa6b9+SolC0aD2Gwx+PNFdV0EYHZpaLpxxYSw/HS+fr4fNahDLo
         ckFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn9ndg5gAveUX+9vQVOLxgThNzqO9a9pBz7LsfxZm1nimFqOIS+cflfYai2aEMP4WkmAoMCgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7XZRmhS/vulzXixjvAYjCLf75PWNPla/iyiYWiA9o6JWBbdb
	iWKOvhhWmhQ488jm/h/t3x7+jQs5/+fJrXJqA2ik2LwrabTakN6ZqxRZ42FYt6p7dNirt8HO5/K
	hjfa9npLk8W6rlTqOWBnyIpEe63jwAzVhzkDw01yzK9o2ibLgVWexUg==
X-Gm-Gg: ASbGncsMrO7St5wJ+Bx6WEIJz+Un2Ni+MmWxx+LGnv9Efr41dtWE5yCwP2M/rrFrQiu
	UC4fF06gcDLWYaGzxQGiqmptHT89wX+o/HaEqvPtA3DqkJa6KJJeMyT403tifTYy/jaON4rZXBV
	T8cPb280YDtnn1+39h5i0ofWe7S6SI5VT/KEfmnDjDYrb+XgB7LdykwbRCdlr2GqQ3tD0WofBMB
	iKLZ1vzugI4iYQgmMgdaO7B2RdpWZmg3iKXSeSzFKqUaRA80lf/Vhm/+PolywVQDaiVgXsQX7IT
	s4XwgsmeIPRAOsGyyS4hc4owtkCy5WwIzKzDq8ZI
X-Received: by 2002:a05:600c:3545:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43c5a600909mr210437635e9.7.1741868692009;
        Thu, 13 Mar 2025 05:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTta66vARQNmkgMsRaEzJLNRUO1YbSPiH3Ss6xOHBxWgJdBqQI4Hnl8PBkX5FvrFzJP6jwiQ==
X-Received: by 2002:a05:600c:3545:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43c5a600909mr210437455e9.7.1741868691619;
        Thu, 13 Mar 2025 05:24:51 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a7310e1sm52414735e9.6.2025.03.13.05.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 05:24:51 -0700 (PDT)
Message-ID: <932f543d-8fa4-4891-a804-f58a55356ab9@redhat.com>
Date: Thu, 13 Mar 2025 13:24:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rndis_host: Flag RNDIS modems as WWAN devices
To: Lubomir Rintel <lkundrak@v3.sk>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250311091035.2523903-1-lkundrak@v3.sk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311091035.2523903-1-lkundrak@v3.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 10:10 AM, Lubomir Rintel wrote:
> Set FLAG_WWAN instead of FLAG_ETHERNET for RNDIS interfaces on Mobile
> Broadband Modems, as opposed to regular Ethernet adapters.
> 
> Otherwise NetworkManager gets confused, misjudges the device type,
> and wouldn't know it should connect a modem to get the device to work.
> What would be the result depends on ModemManager version -- older
> ModemManager would end up disconnecting a device after an unsuccessful
> probe attempt (if it connected without needing to unlock a SIM), while
> a newer one might spawn a separate PPP connection over a tty interface
> instead, resulting in a general confusion and no end of chaos.
> 
> The only way to get this work reliably is to fix the device type
> and have good enough version ModemManager (or equivalent).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

This looks like a fix for the net tree, could you please provide a
suitable 'Fixes' tag? Also next time please additionally specify the
target tree in the subj prefix,

Thanks!

Paolo


