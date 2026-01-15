Return-Path: <netdev+bounces-250167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44072D24756
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0B933019E16
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE0E395D97;
	Thu, 15 Jan 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiENxgGm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNhczbnX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC939447F
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480013; cv=none; b=RdBthqlHy0bo/vQakyZzQrA3Ok8zgJvB0ujiqnmMcrDAV/Gd5tF5gHhL9DZdToMGyeASd0OwX5xnaAy5+PcL7sl+2m2liil9y0JNHqCxNd4UdZ+iHeFOaoWfrk9g5sG6dYwDckLVps4QvkSa4TSsiUATbi1sGd11mGptLxORMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480013; c=relaxed/simple;
	bh=Yq5vpI/d/y4NRU9P2+aVKf5RFOa4W3Y9orH/MRQobz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH9mpMOtxrJmyOWfnndSDuNvDexeE6PykE4j4rLX+2gJm8mTg8K4dlC2CDzcDzOfIHjFdHel5l6fHVlk/Rd3LUrVoH3/q3EKE2OF0cdH0RE4sjzZmBhx85BRmDIXwWidjoT92WM6uVenH6uX7+ds1kMtP41+Ssjo8iPzI/lmyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiENxgGm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNhczbnX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768480010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGv9MHSU6a8Hwc4ePCKZ0lAw4KKwpWf9ybCPoSs7ryM=;
	b=GiENxgGmgyg2lDBk7uDFndHKCt/aSW1PvUPsuqdNpL/L14/hP+S9EKTyO6wZiWDtAbKR5J
	tiS41ZCPLRI1TUwCV78MfepHBby8I7KiXjsgBek3jTOZDT07AX+7RHoTwsmD/N8rQ+o9fT
	r4x4NGLr3Zzdzh0z69sG3XWvt8ZynUk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-vd0bju6BNQOa6IoX8c-Oag-1; Thu, 15 Jan 2026 07:26:49 -0500
X-MC-Unique: vd0bju6BNQOa6IoX8c-Oag-1
X-Mimecast-MFC-AGG-ID: vd0bju6BNQOa6IoX8c-Oag_1768480008
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4325cc15176so1085451f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 04:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768480008; x=1769084808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGv9MHSU6a8Hwc4ePCKZ0lAw4KKwpWf9ybCPoSs7ryM=;
        b=iNhczbnXVtqT8plrD//9qOxY5s3Bys2OzOpGDcoNx5V2+jGRfVMEVFE0lR+c6KSpaA
         nlv/aKZTLth0gIrCoXvUapDwflI3d6ZAcX5r6ml8n5650pc04SMb+75hBYAeNicrQuLG
         6oEArNtRecGflLL81HKtyHfIg156XXB4vzbjE+9xntPG5TY0oxbZSsW9HVN1yFf8+MJG
         mFSFqljtyeZxOhxsemW8Pz+oZw9ZSzJJnvOCKBQlbPasFyVg7p5gBpEM9MbVFTSGNDZu
         tDTW9bMvx6S/LCbxJCuOTLGBySlrNQe9VODyUN6g4RVGeeEsH26pWLpLO5RPs7LK9cz8
         zuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768480008; x=1769084808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGv9MHSU6a8Hwc4ePCKZ0lAw4KKwpWf9ybCPoSs7ryM=;
        b=Dgj+F5UjXJyZK9ZtHJ6PKSJOUAf/1iGwfV/+GiOCTbJ0bp4XpaEHetZmn+3sHX9N7/
         binUYDitk///PFvPMMYfi9B3wqPztIb9szkpXzyE/RCLq2q4Elnwe+hcpL4qxpr0faDH
         sBMgyl8foMU1OxenzxwF2n2d1xcxapFkHlSED9qcmHF7CJxW+jODR3nXQ1UKsPwESVQ2
         1LlTjvOXhAOn70SfqGZfmvPqaPThlbt91R0vwFjPYYoCDGDk85lMA1R/BVYO7u57e2SC
         3nVF+/qJpMdh/166zMtIhZ18HTw6SFlKXvCXZGDRon9Nx1UH6JNjIQg8ktm+HO8q3NdA
         A4rg==
X-Gm-Message-State: AOJu0YxTDLsi9f204K4pyxG8XfbWEKjtaZ+eBdZ9ZfcnDM31elimBDaM
	3H+Z0ZBpzdvJqGweCdU6dCfFNSDK9wfc91GWhDlHiKMU57AN9BqR401A+vbcTEpd1TVGzsBGn0v
	xcDkQQ687pHlU1Aqa0UBf2ygMx1K+4fPkTdGJd5GNwMlmS6+QgysZFeZAFg==
X-Gm-Gg: AY/fxX5d4+L60IX0wI1xe9C22D7lA3NDOUnGOrhN9vAmS9MhxnCjxe99NZp65aGeM34
	1gaxU9jUzapiwToXYSe11pRbdpMBtir0Y553iDhjI0Bc9OU2BXVsb/NERVpFfz2giaTD/HbfDly
	rH5sMJ4CONSVj8wZrVnJ2qHPElto53ny2CIkTNRSDQa38mL54PmkZcEK1QonimtCgftAPWtiQeF
	6m8swKG4Hb2o72/4ZRuPE4094ym3d9b+QrzQL9a0if9P5bFWPPV2dO03wuopMX7NVmMzExJhd0T
	VGw0WNxwZFiH7noVYGbZ4ii9azRipvKT0wtCpzBgmqcB37bnJGwQ3PbiMFZRE7QIi2uIvt6jdgj
	124tEnd+YsAfxhg==
X-Received: by 2002:a05:6000:1446:b0:431:35a:4a97 with SMTP id ffacd0b85a97d-4342c5575dbmr6634592f8f.59.1768480007836;
        Thu, 15 Jan 2026 04:26:47 -0800 (PST)
X-Received: by 2002:a05:6000:1446:b0:431:35a:4a97 with SMTP id ffacd0b85a97d-4342c5575dbmr6634570f8f.59.1768480007468;
        Thu, 15 Jan 2026 04:26:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6fc8fbsm5424324f8f.39.2026.01.15.04.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 04:26:47 -0800 (PST)
Message-ID: <a315b18b-a9d5-4925-9e59-1b1596c28625@redhat.com>
Date: Thu, 15 Jan 2026 13:26:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] can: raw: instantly reject disabled CAN frames
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Arnd Bergmann <arnd@arndb.de>, Vincent Mailhol <mailhol@kernel.org>
References: <20260114105212.1034554-1-mkl@pengutronix.de>
 <20260114105212.1034554-4-mkl@pengutronix.de>
 <0636c732-2e71-4633-8005-dfa85e1da445@hartkopp.net>
 <20260115-cordial-conscious-warthog-aa8079-mkl@pengutronix.de>
 <2b2b2049-644d-4088-812d-6a9d6f1b0fcc@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2b2b2049-644d-4088-812d-6a9d6f1b0fcc@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/26 10:18 AM, Oliver Hartkopp wrote:
> On 15.01.26 09:59, Marc Kleine-Budde wrote:
>> On 15.01.2026 08:55:33, Oliver Hartkopp wrote:
>>> Hello Marc,
>>>
>>> On 14.01.26 11:45, Marc Kleine-Budde wrote:
>>>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>>
>>>> @@ -944,6 +945,10 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>>>    	if (!dev)
>>>>    		return -ENXIO;
>>>> +	/* no sending on a CAN device in read-only mode */
>>>> +	if (can_cap_enabled(dev, CAN_CAP_RO))
>>>> +		return -EACCES;
>>>> +
>>>>    	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
>>>>    				  msg->msg_flags & MSG_DONTWAIT, &err);
>>>>    	if (!skb)
>>>
>>> At midnight the AI review from the netdev patchwork correctly identified a
>>> problem with the above code:
>>>
>>> https://netdev-ai.bots.linux.dev/ai-review.html?id=fb201338-eed0-488f-bb32-5240af254cf4
>>
>> Is the review sent exclusively in a direct email or available in a
>> mailing list?
> 
> No. I have checked the status of our PR in patchwork yesterday:
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=1042268
> 
> And I was wondering why my patch was marked "yellow"
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20260114105212.1034554-4-mkl@pengutronix.de/
> 
> The AI review marked the patch as "yellow" but the review result was not 
> accessible until midnight.
> 
> A direct feedback to the authors would be helpful.

The AI review is intentionally "revealed" in PW after a grace period to
avoid random people sending unreviewed/half-finished patches to the ML
just to get the AI review.

I insisted to raise such grace period to 24h to align with the maximum
re-submit rate, but I did not consider carefully the trusted PR cases.

/P


