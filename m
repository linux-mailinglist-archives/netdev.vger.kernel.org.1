Return-Path: <netdev+bounces-243524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 751BDCA2F89
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 10:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E0F730210C4
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D3F333421;
	Thu,  4 Dec 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ia7jK7KZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOVSIOye"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E033032D
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764840315; cv=none; b=Zv9xEhxYaJAFkuGyynN3k5FSK25BUV3ndGADwVq5PF1ljs77Ey3UyFbzgfyMkYBmX8LQJkK8yoWr/aj4DodfzRc+/am4JCwP5gs4nToWjY9H51KA0hIFKcB1jDHS6A/D2Fw/YxsJu2CdlMC5o0UNWIv2GAQBrHOSdt3D3r2hr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764840315; c=relaxed/simple;
	bh=j5esf63xn1fFUsqmJ7HKrO7rH17nmE7cmM+3N7VS5AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J++Dfe4AdTpPNYqdrbgwLW3lEedPxCFrFRRT8h3rS2TOY4KfIJuAC+zPAcEEL0oreDWyIpH0Q8Sxjo6suOZR5iMb6PoTwFrMPYgrILki8GOWMzTw1hYZMPeQXhY34/QD03MPhZIfqUPzyYnEAbz9/JE0OBabgxzbuLlFjwGYb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ia7jK7KZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOVSIOye; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764840312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcV0ei5qdE7A9DKITUM8bd6drauNXBLY6Q2f/9Ll4N8=;
	b=Ia7jK7KZzQcBapOgcvYTz+Fxw18/+wzE8N/35EQ3vsXKSltU5Zkrs13LasafPLkiKPY/0y
	qXVZ0vsRvgrbRkBZGwrdD6qwn2Z8pOrcGRHWv2JE/UmnI7ZM1YFGN9NZp/UIrqKWtdknrP
	ZVjKlUZrK9jWVvExf3R+N9mUWl/x2uc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-pYqboMbJMNmWQ7JhvWi7_w-1; Thu, 04 Dec 2025 04:25:08 -0500
X-MC-Unique: pYqboMbJMNmWQ7JhvWi7_w-1
X-Mimecast-MFC-AGG-ID: pYqboMbJMNmWQ7JhvWi7_w_1764840307
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42e2d105358so443954f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 01:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764840307; x=1765445107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VcV0ei5qdE7A9DKITUM8bd6drauNXBLY6Q2f/9Ll4N8=;
        b=eOVSIOye4Q0+8MBZo9YTsTm1cwj5uFABQhIBN83Qq1En1nl2UBq28ahG/Cph61MKXz
         J7aDpcsLbp5PLUYT+cBvTZxf4N4sbgtqozZVMcaemBAAaBGdmVvKXwQ6OmTDAQEbWV/k
         MMK136QGEfi85d222KCKHwJZMmVA7Cd1q461/cm8iHGuZn+YmXBZwndB6zHEypDawxTb
         mQ71Xo6kCbBmKTyqFUMUxWf/BMXfwp0Sj1Rcn6qYs8wWRvElzluJPpuwOnhCD6yzna9t
         EWEDh7FAs81E6tug6k0zFgkZie/rPGzaKsSZBIgimoeiUUwxBPtbEmuiO6T6vehLN+Ce
         YPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764840307; x=1765445107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcV0ei5qdE7A9DKITUM8bd6drauNXBLY6Q2f/9Ll4N8=;
        b=ednyBsCvlurEainDFFjKT1WuNKXVfETbKeBopQJOdJSWkh/2fQVoCekWRGqQ4CXCyV
         cyjk+qZ2kSGpyrKK5+LdvaJ7BNmCJRIfE+bpSIu+tSGcguMXGv8BYzIpo2oyscwAfjpK
         i47mlXAg0dn167WKy2flu18CQd74VSvTHrGu04auk98f9g+FzW26Xd7xLP4lCKwCy2na
         hJ+OTw3yr4pdabe2YXMrpPPFLfnX3JMqOINPN/qzusrygAOFlt/NiiTuK2g9n/1o1Cbs
         TFiufB9AoqY64vLmJFUYjNMxOz1I5eHKznZWuJsuP1RhSqlpSHoqF//MWB5z41jE9hMu
         5PFw==
X-Gm-Message-State: AOJu0Yzos+zb4G0zBo2SsgFtFuj3OWeTyMT0yt6Rs92boZONfNpVWmaV
	4b6ny8LETIp/6MPM3tbvUrktW5WW1HkWRqPtJlpwhho3uEgLIycvd+twCPewVgt6E0rJS92XVw6
	v4QDSU+OG/ov6a3GMtTXH5ig6roHEcJIgx58fuVLh0ycT1PGpeUuznzafLw==
X-Gm-Gg: ASbGncuOvgr0IqUJE7bwB5tFFWetOL7hLUBMWW/9kwxVhPSrmD6Ueba5NASykbBhH6E
	kN5hfysgwZ681ug6VIULoY2UZNV5wd3l57bBThuU1w4R5590YTrM2Qmue/bsHshzX7L2C4uCUYw
	SdZmE7AxB73h8UJcD4J5FV97e8JJ7siJADtHBjCq/KHJw50YTeZR4ec+cwT6x2KV8ufqiAmsfII
	3Wbz7XvQABQC7oMslwiqFR4kj+/57GAV8Y+ui04az0pPY5ySCRPyfw4IbL6WwrvSeFAPGDNLe2E
	pddciwdSP2RY8Ef+Qdq9yTRGROAP4GJVtc0Dlxh5AI1p8F/+NrECGMWI37caC+vubVM+mle3v15
	yy511ZyLvJUPS
X-Received: by 2002:a05:6000:40e0:b0:42b:3d9d:c605 with SMTP id ffacd0b85a97d-42f731c8442mr5415671f8f.49.1764840306831;
        Thu, 04 Dec 2025 01:25:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHjvJVp3Q6NIJehYvKFw1+VG08krfj0o2zOuN0+0X29DCI8T/sHlFf0MSXLhEUByimYbuJ3A==
X-Received: by 2002:a05:6000:40e0:b0:42b:3d9d:c605 with SMTP id ffacd0b85a97d-42f731c8442mr5415628f8f.49.1764840306405;
        Thu, 04 Dec 2025 01:25:06 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe8fe8sm2153754f8f.2.2025.12.04.01.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 01:25:05 -0800 (PST)
Message-ID: <1b9ade5b-bfa9-4bcd-9bc4-6457dffcd887@redhat.com>
Date: Thu, 4 Dec 2025 10:25:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] net: macb: Relocate mog_init_rings() callback from
 macb_mac_link_up() to macb_open()
To: Xiaolei Wang <xiaolei.wang@windriver.com>, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, Kexin.Hao@windriver.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251128103647.351259-1-xiaolei.wang@windriver.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251128103647.351259-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 11:36 AM, Xiaolei Wang wrote:
> In the non-RT kernel, local_bh_disable() merely disables preemption,
> whereas it maps to an actual spin lock in the RT kernel. Consequently,
> when attempting to refill RX buffers via netdev_alloc_skb() in
> macb_mac_link_up(), a deadlock scenario arises as follows:
>   The dependency chain caused by macb_mac_link_up():
>   &bp->lock --> (softirq_ctrl.lock) --> _xmit_ETHER#2

I'm sorry, but I can't see how this dependency chain is caused by
mog_init_rings(), please extend the above info pin pointing the
function/code effectively acquiring the lock and how it's reached.

>   The dependency chain caused by macb_start_xmit():
>   _xmit_ETHER#2 --> &bp->lock
> 
> Notably, invoking the mog_init_rings() callback upon link establishment
> is unnecessary. Instead, we can exclusively call mog_init_rings() within
> the ndo_open() callback. This adjustment resolves the deadlock issue.
> Given that mog_init_rings() is only applicable to
> non-MACB_CAPS_MACB_IS_EMAC cases, we can simply move it to macb_open()
> and simultaneously eliminate the MACB_CAPS_MACB_IS_EMAC check.
> 
> Suggested-by: Kevin Hao <kexin.hao@windriver.com>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Please include a suitable fixes tag.

Thanks,

Paolo


