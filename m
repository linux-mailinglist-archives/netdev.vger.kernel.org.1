Return-Path: <netdev+bounces-245493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5766CCF173
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C44F2300AFF1
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE22EC095;
	Fri, 19 Dec 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0CBcPzP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFt7u+yP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B32D061F
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135684; cv=none; b=BP/hmkHjzY+xoo0PZEk8cgbZI/ptYeLTx7sQyGY9PiLWAqI14o64xytFtLfDyewD5QzPVWuhUS0sFMb4WAxZzNFr+J232RM0/ycdRB4/mvBCshycsbXFE7lqQbUA4EvSWa5l6vNPJRqokr1/owJCsPU7Hw6nXJZtJY76We4JnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135684; c=relaxed/simple;
	bh=qkqdwHaf7hTs9hzjYqt+YueecBYdustTqR9xSUlb4Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+haU3G/QYSDcP/7hmj5eEgfft1XzQZ/rAq82VqOdGJemGa1Vd3frONDHqYgFP6SL7TIf86xuik/rIOGE6D22tHba1eLfvZ6rvsdLwhebgmYTxJNHtWtxmhi9kAD1Git43Q6QlI5gfQaK8zF0nFSRVJ0f3PwHLJcwYvVNeRcQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0CBcPzP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFt7u+yP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766135682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtZeuWsFGRFZQTkfeQbbC+bMUQB1i6DXrYKzdcUszIc=;
	b=Y0CBcPzPCWGh/GLkCS9EtjSJ5iIrK7uphlIQGHOMgntczsuosJRARWAJiBCu7VMWgUKpid
	XR5ZleGarPlYizB4Yg5JdeRZuwuvmjb97CU6BhKvJhj9KlEHnxrLLbrhBwSEc+dmBfO1so
	KxBIelv5Jwrr+bylAnSE5yQSY/WHs28=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-R4WQT3vmO8qBBVS_74YoUw-1; Fri, 19 Dec 2025 04:14:40 -0500
X-MC-Unique: R4WQT3vmO8qBBVS_74YoUw-1
X-Mimecast-MFC-AGG-ID: R4WQT3vmO8qBBVS_74YoUw_1766135680
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so12668025e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 01:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766135679; x=1766740479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtZeuWsFGRFZQTkfeQbbC+bMUQB1i6DXrYKzdcUszIc=;
        b=XFt7u+yPAZxex/YOcHsZQqQ9zRdyX6j9EiFntsoXtsn87H1rwmDmPHpuwKe2dXPw4d
         w/kNReWeo4XxBydG1ABXe3Vb5m1HHyDm6W7YRJL5klKpnraiTRD7jAT1Kixs2cpdbgBo
         +9PEM51cHSE9zohwYgn4arUeLCPsbAEVgJnMpLiqw5Kd/XBm6TeZsBbt5ZPDEFZOn0VT
         7dZuCRx8sicE33DCVV2IAUpc9xm7ac1RKvpxZz6oX5LAS9jd353hT9A/ojHZWYUYBTIk
         VNHO+6dJtClwVV4KAZLFt4WYXZ2ufDQZXIrL2hhhHCJ0pyYiUJbOzQTf8xaVBOdH1N98
         5L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766135679; x=1766740479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtZeuWsFGRFZQTkfeQbbC+bMUQB1i6DXrYKzdcUszIc=;
        b=juAfrpneWxb7DZ7lIybqkVU3K4XGz3S5YbUdxBbzfNYfplrgB6y9fzDQ1LkDK/GbEf
         hfZXpCaOGX/RsLqHK0OlMPUFvvhpGkk7MCz+hjQVONVwUxvymkxc+dS3udWX4OAWlXrk
         zFQJOd1c0vZLPjapfLTwe2B0A9f543oRGphEpBt3mpEslskoRq92BVYg5H1Ahhn59Fmq
         m1KbHp3dv7VjqT+FZzUeb+SqwlCs7LZCUCf5Zr5T4rFj8uy6YWeXOlyLOleO/UWBgBmr
         SK9H6uNp0kn9DPfnYPS+T4J+RlQKSFr1FrrvGg+DFI7modw0eadMcHbtn+Z1HM4p+CvY
         hn0Q==
X-Gm-Message-State: AOJu0YyPdzuNtpDjluzOexuv2320qmgmB1MwdGKwrfeqTnZhT0f78ytO
	DqbcYBPZ3IBbNKSmqFmYA/R9v5ADIovZtwBEZDOWZw0BY6n8eZkTiH8CH6pL7a2wn9uQ6tWUouc
	+EOA33A5srQxhlsqx76Eji/2Tfyj7QXFsbDEZpL4e4KLGMZYn5NAHAoZVFH6/IU93Zw==
X-Gm-Gg: AY/fxX5R5wHXOg5jKgYlGV4GSJ/VCK0PD4v3wmIfIsukCpUP9YuuRSbBXjPvvOIoUpP
	w1M7ryAnWk1FutZYArXB6yuNYeAauU3XoAdAf0UrY/5+qVmwbVavOQhVedpMCE0dUPUe1oEs057
	3xP7U1pJOq+j1Zjs3C45ysMu0ICY6N/JU5q5bdCkC8azYPVQU/8Upu+/s8XoWG30e4E2T1wma2h
	ujLCkK6o4FJu408vtfKPv9OzNxpUPLTgZV5LDzw6JapUht9itQf6h2VPVEJlgWkyRW6IPTFzI2F
	h479gkkuyicFc5Hqd1zP0y+BdV8q92gMcOytw5uYwmmIFqH1sY9v0A11o9uR7EBO9ryxd9JKSlJ
	EZDmWH1AXCh7U
X-Received: by 2002:a05:600c:1c89:b0:477:abea:901c with SMTP id 5b1f17b1804b1-47d19566d65mr20213665e9.11.1766135679033;
        Fri, 19 Dec 2025 01:14:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGJW7UckHYKmla5ga8QTMeIpxM9WcC61w0X0piI1hLpkPikukzkLITpmwSQPf8zc7gAG/JDw==
X-Received: by 2002:a05:600c:1c89:b0:477:abea:901c with SMTP id 5b1f17b1804b1-47d19566d65mr20213285e9.11.1766135678651;
        Fri, 19 Dec 2025 01:14:38 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d1936d220sm36668115e9.8.2025.12.19.01.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:14:38 -0800 (PST)
Message-ID: <982376c5-ad72-4923-9653-7f01c1e608a2@redhat.com>
Date: Fri, 19 Dec 2025 10:14:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: brcm,amac: Allow "dma-coherent"
 property
To: "Rob Herring (Arm)" <robh@kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251215212709.3320889-1-robh@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251215212709.3320889-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rob,

On 12/15/25 10:27 PM, Rob Herring (Arm) wrote:
> The Broadcom AMAC controller is DMA coherent on some platforms, so allow
> the dma-coherent property.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

I assume you are targeting net-next here? If so, please be aware that
net-next is currently closed due to the winter break up to Jan 2.
Otherwise feel free to take it via the device tree.

Thanks,

Paolo


