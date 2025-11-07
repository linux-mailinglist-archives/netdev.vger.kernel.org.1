Return-Path: <netdev+bounces-236880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AB9C41561
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 19:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED0DA4F0837
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 18:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2593429BDA0;
	Fri,  7 Nov 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="N0LOkB/f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5B62C2377
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541149; cv=none; b=ENC/RsjrmkpqCp9UnmtN1vz/AIPLkWOER0jO3GKh7IipU84c4WbDe0+hJWHG8FVGpppj8MYBdF7IpXX+FfBhO5RU9W2pNo8v3SLXaIwJHHPlSMvbywV/issndiO9UGczjMvVI0YfOoU8wm8td4ZO4EtmAwFhWdipThZEFz0zT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541149; c=relaxed/simple;
	bh=IpOcJwi4odl7I9uBwxN3mR/eQRs3W8qd1HLFXvuUk0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHTi1bIWHQQTRoLmoeRYrv4DPLtHsudlg4RUhBHJfuHvyPm26CG/qiEXDED/DykoAl2FcHhDkm2Hx5L+nVvV+siU3fz83C+oXPXTbpFlng1ndLj6WfC+UUfjdfZPzCu2L9xQ+pnNznsuQQrv3YD6YbLMSCM/q/EPLUPa/eGvOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=N0LOkB/f; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-470ff9b5820so756075e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 10:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1762541145; x=1763145945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q58M4w05uwYwN00qNHdqWtlLGaXl76yqb5C4qIFszWE=;
        b=N0LOkB/fLf4bvg1pIZGEPDiEJ1z0LnwkZfjr5G/5MzP7kXdgYMvyLJhMj9A/gAjvmU
         hqWR766+5VgOJ+RkfVPTaqwhuep6vBT+FIVjN/4iqdcQwKrU1LV1Isr1YC4uPpvb5Hya
         jv/WqA0OOXPA50lcoi8Bj7EWOJmwhRqbeUe/dds61Y+8B5RdaMId2KGMpXNXiz8Impzp
         9HkptrPGprNvXlAb7jE4w9aeZJbiFLkUwt0tK3IYGU5nBtKS3OmueWN/sty+MFjUR+Ii
         hJZqDLwbqdW5E6UJVFRnbliE/TpeUViv6At0wDh5Ndw/Kop/IwQxe4pv++3xm2kiPrqE
         B2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541145; x=1763145945;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q58M4w05uwYwN00qNHdqWtlLGaXl76yqb5C4qIFszWE=;
        b=hMKba4DF2JQJ99EZT8XZPXBEAPh68RvMS8z8m1woqDwL8RZXvijsCI47JKtqgiCGPs
         Ac3SDmGa3yOzz8WVeq7ZNANyvKKSG11GygsAUg5rqDy5y6tYmL3nARdnQiMT462/EK0J
         /rbseOEnFOBK9y7c6C/CqbGpeuWwxiikzJs0GHXzO6Jb6QUVjMyohqp5M/VBdBKEE6va
         TYYomYDpBeAIPLhVY9R/Uaf+dOYtr4dMIrJcR9S7ber9nSNLebDIuBmEl7rz3bvFbgR4
         IFo/z+fjitn+N/kmq0r/MO45fF9ynsaAfoQNfFK127n9td7EyCEva5eU09ut1VJNnP1c
         MCKA==
X-Forwarded-Encrypted: i=1; AJvYcCVbHo+pldFgiAERg0Gq4C0xdqMtQp7sl8wRt3Pa3i/X4BV9VGA0pp66yp3O+HgEIHKxFEYpYbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLheb4Ut8wpBUbakC4mF4mXqevo2hfyvqqhcElhi0s7mZ37ns
	duzRERt51Z4wnBMQeA3+eSuKo5C5T7/6+BQID+tYH7fJ6s0U75bdYWFU9C1a4jkLe5I=
X-Gm-Gg: ASbGnctUn4p/rDX0Ug8CP4azHvwItjMn0Km2prWsLQYDMOIW05hwLrMj45fRyKZ1bNy
	ys6EqueclPfAZHwp1AUZCNb9O3rmx3hM+v5TbmxloNv3DxmGdfpFoip1Ai4R8OOhRvz7c7N+10w
	wzFhJ82zy4rJ1acPh/y5eO1pyNEheAYXgNNAcGndkxTd55/YFSLpizpddSNEmdgDx/Gxg/68jxK
	ISC/IpUzpAAeDZElqiE+3+jKboISvUnnBsk7C62nPLES4XmoMKopOTD8c1oqKceNH4rKNFwHxUM
	XvaLbW3tOxljd246LbogKxpfdj2cZaAUcuPo9k0FWp/1N9PTfhtG54eHWmvS/tm6+k02dspQDeF
	wvjzH3KutrCBGTCWTvOdzQ4rdOiI8wIIjpRnP8Ekz+Tg7ROiBP8IflMfTOPKZRJwUv+oaD+bhHk
	SDrIcQ8KCQr5/uBUkvG3J4sPBEvHW97YummL69wb6oB2YhD1F5vG5r
X-Google-Smtp-Source: AGHT+IHUk7raLzZoC/8pxjltpJ+mcySTk5tVy9T/46uZzB/VmI1Kp00V7fZbiJXcZKcdfRuCa2OGvw==
X-Received: by 2002:a05:6000:400b:b0:425:6794:77fd with SMTP id ffacd0b85a97d-42b2dc1826emr2934f8f.1.1762541145517;
        Fri, 07 Nov 2025 10:45:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e091sm6922786f8f.15.2025.11.07.10.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 10:45:44 -0800 (PST)
Message-ID: <bf8366de-107f-4204-bd96-31f8dd8114fc@6wind.com>
Date: Fri, 7 Nov 2025 19:45:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] bonding: fix mii_status when slave is down
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org
References: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
 <7a6372b3-b170-49b9-ae62-eb0d1266bd6c@lunn.ch>
 <80576ce0-7383-4b46-bd3a-3ecb0837007e@6wind.com>
 <fbc92957-4cf4-4687-bc2d-ed09cedf8572@lunn.ch>
 <a249ba44-a339-4f67-89a0-af08f9464c05@6wind.com>
 <2e184a78-c02a-4395-8e18-a72a8330db46@lunn.ch>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <2e184a78-c02a-4395-8e18-a72a8330db46@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 07/11/2025 à 18:32, Andrew Lunn a écrit :
>>> I agree with your fix, but i would also like to know more about the
>>> interfaces you are testing on. We should probably fix that device as
>>> well. What is it?
>> There is no bug. It is manually put down by one of our internal tests.
> 
> Are you sure?
Hmm, ok ok.

> 
> admin down should cause the link to be dropped. You want the local
> device to drop the carrier so the remote device knows you are gone,
> etc. Also, dropping the carrier saves power. For a typical 1G copper
> PHY, that is 1W. For a data centre connection, it can be many watts.
It's a virtual interface, a tuntap.

Nicolas

