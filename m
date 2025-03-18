Return-Path: <netdev+bounces-175609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A50A66BF8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679623BCF67
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 07:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298CA201000;
	Tue, 18 Mar 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MV1sjgCN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664281EB5CC
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283424; cv=none; b=RfTevqZ40yUqzm/rpiZBjtrfFJvD6K2Pbk0b333m4ZVP6eKitg3TYYApUFboCLENFwhsWvNB6X4mp3oqpbV2vAyd/6lrhzt+ac0wx1YnArSnUBYSADpG594TZ4l2CIwg429cbHd0sN+u/uQ1ximAu5i3xczw/t661lLO3BQtl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283424; c=relaxed/simple;
	bh=lNZiMRL/KtuCJTDp+dxz+A31936lctZdVcKTBYjxWIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JccQQ5KZnunKMzcw+HEpx1aXXUh9vE+AFWTlut/cJ5yuYf9HBuZCJX89lUhj4MAEcUd6XFSpyBpYWP5VML2YlLVsRxsnNUXz69lMvMQ4Ehb55V1j4pQwOxhBGtA4oo2pxlPRxLUufsN2odkQalMJw0kWIKICKXEbADqByNCaRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MV1sjgCN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742283421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuwSkGFuQ9PYTH04qYS2caVrm8hJvYFBtjYS3q+XiXk=;
	b=MV1sjgCNQ9yaicSYz03E32tHXooJP/Otezj/TtCUa/uYOLlkZ3VQ4EBHwlGlFJZ8Ckzl8W
	sHixw8fV6rHxY2DyTpxktpV2gl139YG1WsBCrSwwDYgXZvFKmMkroBeXFfaXnBo/cm/N0W
	mkrPe/qE9iqo52JLqDHbJP2LLgrbZHQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-t57s9aHTMNuuEkgiPXWU7g-1; Tue, 18 Mar 2025 03:36:59 -0400
X-MC-Unique: t57s9aHTMNuuEkgiPXWU7g-1
X-Mimecast-MFC-AGG-ID: t57s9aHTMNuuEkgiPXWU7g_1742283418
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so15921065e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 00:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283418; x=1742888218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuwSkGFuQ9PYTH04qYS2caVrm8hJvYFBtjYS3q+XiXk=;
        b=Dvgn+crKx4ECDWdnqvnigzYF/vxflML4ta6sepimIi8kYCH4Ui3/p+RQBQUfoL4Aii
         Jtsx3Ah2K1LVsGkS0RWSyheXsnMsC94nstKzlesrofcA1ymzxLG/0VQMoA/TQdeHbhRU
         4n32iEy06ilx9DiWNkUY+ok3+9DymwZuuqxCorqnZ8Zz3ie64b7HZvUz9mAYZgZvcI7I
         m1VRsE2Fvw2OmimImZ2sSkvG9f2zqJGcFyuDpeRVaTFF440TIi1fjprrh3F/LMTnBa7R
         vk1A90cyYLxj8aCiy59QYD5yZuQEarzSm1KcCv9jTpkBR0Z1x5thooQOka804k232QzM
         lLzg==
X-Forwarded-Encrypted: i=1; AJvYcCVFLxGVGIpCVBETbmUKX55OBoIN7rfnIcbWH2z9+DFzqv/wOlE4+iYsg246B5uzw6WAj+tn9oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2qGVMADsMfAe7CLnZsLkvgrWGuiTqf63IP7Z7rAr1oRWAgF3
	OaD+MKFZ2q9PyluvJfmT1luXBMsKmX+wuyB/x4sT1gc/pGDeaAjXyrgN7sDZFI7CHXjwm5zPY0k
	TD+njEaxyj/3XS9qN3IY3SLtuKwD+CTMQhfjsDqCV3h/+MHzHSpAMrw==
X-Gm-Gg: ASbGncvevMIeecDU8Qi51Ef9XDy7K4vAqUQZyk651CIDQb1RPjF1nYtlJRgyJFHc911
	xDbgopvjqOBKJrmns9RTr/VY9bG+mKEIozZkZO0D1QOIuiXPgl+BEfLHZMi5vl1msSvXgdsRZA0
	gweufzDSg5CdXalfcFLi/Pw1gCwTXGaRgF+ch7uz187omnAXz/LwEg+OtkV1CwOXgSspaLaidOr
	fpOgyqVS23nzlRILHyPWUaRO3f6i2ZxlC+1ovJjA943rK6AMEVi9kSoufpgy9llbkfVxN8D8N4S
	W9qYVO76iJVLgh6AMMocBY7Znk4iq+GIADSkK3Vnlp9e9g==
X-Received: by 2002:adf:c08d:0:b0:390:fbba:e65e with SMTP id ffacd0b85a97d-3971e0bf383mr12447807f8f.32.1742283417893;
        Tue, 18 Mar 2025 00:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb3LZOLOKi/T4T42PWCNaP9JVSbcDVK+VGivaIA4skwK7mEqohCRPCdXaEW5et6m5LbCPE7w==
X-Received: by 2002:adf:c08d:0:b0:390:fbba:e65e with SMTP id ffacd0b85a97d-3971e0bf383mr12447790f8f.32.1742283417573;
        Tue, 18 Mar 2025 00:36:57 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c255bsm16931803f8f.23.2025.03.18.00.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 00:36:56 -0700 (PDT)
Message-ID: <9af06d0b-8b3b-4353-8cc7-65ec50bf4edb@redhat.com>
Date: Tue, 18 Mar 2025 08:36:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: Block setting of symmetric RSS when
 non-symmetric rx-flow-hash is requested
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250310072329.222123-1-gal@nvidia.com>
 <f7a63428-5b2e-47fe-a108-cdf93f732ea2@redhat.com>
 <9461675d-3385-4948-83a5-de34e0605b10@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9461675d-3385-4948-83a5-de34e0605b10@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 8:28 AM, Gal Pressman wrote:
> On 17/03/2025 22:19, Paolo Abeni wrote:
>> I fear we can't replace macros with enum in uAPI: existing application
>> could do weird thing leveraging the macro defintion and would break with
>> this change.
> 
> I couldn't think of any issues, you got me curious, do you have an example?

I guess something alike the following could be quite common or at least
possible:

#ifdef AH_V4_FLOW

// kernel support AH flow, implement user-space side

#else

// fail on any AH-flow related code path

#endif

Cheers,

Paolo


