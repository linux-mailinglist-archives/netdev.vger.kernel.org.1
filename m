Return-Path: <netdev+bounces-242348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F81DC8F870
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B17C342F3F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673BC2D8DA4;
	Thu, 27 Nov 2025 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdDj0skW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2C5DMv4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E72D7DC8
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764261299; cv=none; b=W0DhfIhfzmNDh2Jr/FjiZVn83mtxCiZEAowb8vemhAk7eViFY+D2Jx/RiQa/J8L58F/I6lyNWVkZ0VAgpYuc4GJNT9EtHC84Y4DhOAG44lpNi/Kor0NmgiZzhgAbqN/tBRLJnViiUcNeDdyE9vxWDBPm/JQfwhgcNVilRK47jtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764261299; c=relaxed/simple;
	bh=qbwQQeYnhh5Jp+VwwIUbFfb16SXJjHTfT04dLegf2aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOAzwMgdh10ZQRGYGoDjfwAZgm/EbYuL4sc32osadm1J4C/aruf2TerxPGcyvRslhCCVpM1ji8uPKYkkRuWBv606c5BN1Rk1szn458yUIRegAVOSIRfCNHVWkuHdyl1D2R/nKHNrwsyVAYLMCMMrFYloV63lGKV2iCqDj1gcfOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdDj0skW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2C5DMv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764261296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4iwbs1h8WPfjtCWRn3LxmIB+8Vn4N4Td3zMk03YVIE=;
	b=AdDj0skW0TwKsfnJ1CukLQiFEjyq3EOpb1nHIU11LUzxZRWBPB4QpN5M5B8w4tnlfHNI3Q
	yxBZYYmxhl5W19j8sPlUTWd67FAwy5xWvxo8hDNODFrs7QW3Qq1KXmSfSt8wmH67A7MI0e
	jd7EoqDv+BZOZpKlzBV60mJFNDvxhTM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-r_INma-MOSKLCvRGrF0IHA-1; Thu, 27 Nov 2025 11:34:53 -0500
X-MC-Unique: r_INma-MOSKLCvRGrF0IHA-1
X-Mimecast-MFC-AGG-ID: r_INma-MOSKLCvRGrF0IHA_1764261293
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c521cf2aso824775f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 08:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764261293; x=1764866093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4iwbs1h8WPfjtCWRn3LxmIB+8Vn4N4Td3zMk03YVIE=;
        b=N2C5DMv49YAmipiVLj942vrUXgAqs8MW/pqT4xpbd2xp7SNzLOsxY5xE9E8ofIetrM
         FnKxyvQTqNbUKB7X4HDCj2i/QBomZ7bXVlYdX21Q6VWjI13LirRLYiY3Xcir1SiCkZ8U
         qTsI5oBcjc8k3Kd4piiaWHCiw+7bzTlvgpfc02gxn3WFmmqKWhA9wNVNzqos/gTzzpv7
         sDKE4qh/4WQ9dXak5jbdLyD1MhGqNqzb1AEbE64sxOgF9Hl5JGaQr26bIgIXic9bHrR3
         BNoiIgD8xLj7aep8mTK5byHIfcCZaQydHYr+BxFiX59iXqPvC3AcO9klq/JQgldDlkfC
         ySPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764261293; x=1764866093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4iwbs1h8WPfjtCWRn3LxmIB+8Vn4N4Td3zMk03YVIE=;
        b=B4as6QqkVzya47Xq5yEcyLGYZuhowOPxueWYNYx99d9lHHdrRRO36GnQ9HL7NgeCgi
         8U/JRQMNekHtMkqcot6z3vgwrKM20A9zBlInkPnniKCoF/kn4ijju5Tc8pS6b79BpD4o
         k/tPC7fuQQf9GyqRwPUyecEaBlR/ZNqOxPNYgpcQUnZX/tHz7YF3Om1EIDS4s/lYS9YV
         jSKM3O7EFO93lHYPVS96GTh3a5lMoTq26KSKbYsJOmgaXJNjKB91NMYpNlSUTuNhcdpB
         6lF+Uz3VjtcVoKg7kaAjbh+APTr9Gec+AX+9TpChw3Axtdmwygy8ewcnKNb6OrpaU9JS
         BG1w==
X-Forwarded-Encrypted: i=1; AJvYcCWMXU9hqkfoPIa1RN339/n9AcU1eSfSTuBZNi9PK5dQme4amwluRjhvqZqNH8TxCLtzs4HuiR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5k43WpBCVS8xO/W4zZYjLpGewOqSMuG9z7DGn4fXJjPN6fBl/
	9kjwofv0tbL5BAwPaylaOxl7yXWuV0csH6v+ZwY+l6IBtvD124nBJH7ZxbRWXrQJf7ZxG10kURa
	APZY+U8VbDqkpYYXkwyimV9sv/vk1Dkn7pFuaIhoGRLTjHgzMKoo1g/QSTQ==
X-Gm-Gg: ASbGnct9gG3PxThClDm6GoeOssF9VkxFoA/1Ofo4HkvkvboR7qX5Y0tQB8pcX356X4w
	dYiuKk3Dzyj0Y/GhK3SJhyHFA2ZEPWea/qUb8R5S4kjcVNdLQc+w7bYKukgjTr/vKsbUk3cZWZ+
	p60EnAACs3tLcu8L2px5Hhn0vMjsOukJmOHVOkPQVfhogbhYFH0LrSvm/bYnYk5gBA8cTGWYJbM
	R5jIhJ01dLtKsw8/1M0XK0NgFU9+C8euMvFL+m8o+Wj3T0LmqUngrtA7zJTJxyr0bJuQqoghXMY
	0c0QPwJVcAvM1I2UOqWLXJwOR5FndtSFytg9bVImVi+LeU74FwSZoef7GaZtJwuquya05UGCnRm
	80/TECTDvQ/hCoA==
X-Received: by 2002:a5d:5e01:0:b0:42b:3131:5435 with SMTP id ffacd0b85a97d-42cc1ac9de0mr25419565f8f.2.1764261292596;
        Thu, 27 Nov 2025 08:34:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBjcdBlqLKajPU/sQcGkGD00QWIR2/Z2jTb31o5tzKYhK4fsXo5kSSU+5/YPOKYslbkKRh+g==
X-Received: by 2002:a5d:5e01:0:b0:42b:3131:5435 with SMTP id ffacd0b85a97d-42cc1ac9de0mr25419529f8f.2.1764261292099;
        Thu, 27 Nov 2025 08:34:52 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3c8csm5641761f8f.2.2025.11.27.08.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 08:34:51 -0800 (PST)
Message-ID: <3dd5c950-e3e4-42b8-a40b-f0ee04feb563@redhat.com>
Date: Thu, 27 Nov 2025 17:34:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: define IPPROTO_SMBDIRECT and SOL_SMBDIRECT constants
To: Stefan Metzmacher <metze@samba.org>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Steve French <smfrench@gmail.com>,
 Tom Talpey <tom@talpey.com>, Long Li <longli@microsoft.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-rdma@vger.kernel.org
References: <20251126111407.1786854-1-metze@samba.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251126111407.1786854-1-metze@samba.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 12:14 PM, Stefan Metzmacher wrote:
> In order to avoid conflicts with the addition of IPPROTO_QUIC,
> the patch is based on netdev-next/main + the patch adding
> IPPROTO_QUIC and SOL_QUIC [2].
> 
> [2]
> https://lore.kernel.org/quic/0cb58f6fcf35ac988660e42704dae9960744a0a7.1763994509.git.lucien.xin@gmail.com/T/#u
> 
> As the numbers of IPPROTO_QUIC and SOL_QUIC are already used
> in various userspace applications it would be good to have
> this merged to netdev-next/main even if the actual
> implementation is still waiting for review.

Let me start from here... Why exactly? such applications will not work
(or at least will not use IPPROTO_QUIC) without the actual protocol
implementation.

Build time issues are much more easily solved with the usual:

#ifndef IPPROTO_*
#define IPPROTO_
#endif

that the application code should still carry for a bit of time (until
all the build hosts kernel headers are updated).

The above considerations also apply to this patch. What is the net
benefit? Why something like the above preprocessor's macros are not enough?

We need at least to see the paired implementation to accept this patch,
and I personally think it would be better to let the IPPROTO definition
and the actual implementation land together.

Cheers,

Paolo


