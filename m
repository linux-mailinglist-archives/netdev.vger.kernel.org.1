Return-Path: <netdev+bounces-202834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE0EAEF2F2
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 11:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E324480F8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E26260585;
	Tue,  1 Jul 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUd876Yr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7F4245022
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361340; cv=none; b=OpRhckE/tp9CiPaajiDcZ81+oXjBHO7kIPPO+VsrTPLjrPy7gk8OL2e7uKHDwSplQbxwXnhE+x8MLL1w8zYADqIjLaAqcjqzdb6XmSG6K4xP1fGsB3tlGUG6TXXu6aL0VpnjHBwHe6GtOnOlkY9f9miw1qbqkbGISoz1sqY0ooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361340; c=relaxed/simple;
	bh=ezfXSHuhu9Sfb5a0gaNDiCPb89N/ZDg7kI93quY/1HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNdjW4yNGS7hRvXbXKGycJBNARGJPDZOQvCtHBiSYqwsCn05ClTuCSY/uO9vVHzw8os4WkFP4zcxD0a0qjnXFe+ywUHtYylqk2EKkSL/EqxPbGSf/0QjPIghWF2MBbjPN4xoRNm/hH+eEk/7b+68ibC9WMaQCn1/JjxX6tRajNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUd876Yr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751361336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jan/Z3DTLxwVO5Mfsu41/us04DIzAuMZQLApYN5eBrM=;
	b=NUd876YrwR9mWkm0DVW+ceExeAE1aGAJE3UF+R8ej9wTW6O55LXUy14uOb0tDyeRD9HYUX
	W3DUl439i5GXwX/5TcMDngRqPOrQBxD2MTu8gtgh20iTK1S1n8vBUUCfHs0afiP1WxF/wL
	NbHQCDbqn0pdySoDSISwKt3Glajx/Fc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-nahXXR3WMBauH5Elfac87Q-1; Tue, 01 Jul 2025 05:15:33 -0400
X-MC-Unique: nahXXR3WMBauH5Elfac87Q-1
X-Mimecast-MFC-AGG-ID: nahXXR3WMBauH5Elfac87Q_1751361333
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so26049645e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 02:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361332; x=1751966132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jan/Z3DTLxwVO5Mfsu41/us04DIzAuMZQLApYN5eBrM=;
        b=K0DTIW89bpt9evQMQ6KnOid8ogx5NHoNy5qznskGcNUrmzGk1uHgcHzp4ONIYYM1fW
         1eMzTayAm0FZ62OURFFQSTGLsUqieNf47tGGv5dsqmWRt6FoG/ReM1qK7jtimGynZdQh
         Hk15Ahb8E6bW3az2rsotkY5DfeYGsgFoZYpsaQiy0kKPbX2yWtZ0SzRfJGk7t07TKQ0S
         Tv5mpHQO5yiD8WvA69oCq2XjxbErVimDwMoD1eQ3gKc9ejYz+5CAS+gRxZ//6yZ8XSAP
         dT0L4llY8rnDl5t5IQoHcsoMPe5fHtEq5MiJxjJ/ko3LFLMNiENsBGkfm1k6+/Chrduo
         qAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRyXgJgPyOR4ZHK0Me4P6b0Jw37N/RCYiXE8g4NI1wLY5j0OozOHmNR4oWwjg2K4LvJN2Yo/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNB90eD4T4c37udVMdNbiq2+ygcBXYqTW3R/mXXf6U2m55vm9
	bkhYziLGZlGDlY4CINsDWzovFSWe8HPFgsePQTdbYEeNs6Mga2tDQALqFsaJamqS7DPON6y9rD/
	ZBNJQcDT2AcEEdpcohrsIlrvyzXcaW3P/zAtRDqQsAqqXUnVvuBI9BgX//Q==
X-Gm-Gg: ASbGncsBAB/Pmilq0k+t/0hK2En2mPlj+lmoxmeYeDl0FT7Qo+RCffus9+TkyeBbg4G
	ojb1ZYE0Uiy1S8/T/r5oRGU8vFN7Bale507ENb9FGP79vDcrNWLg+J0pm9ADkQWZx1coCTY6qs2
	N7hDF6KAhexterLxb6lHziJB6NFrU/jD97YktPUdNNoN0gCbrBHYR1piFR1yDAVlZoivUBlD0sL
	FObwZc04p/j4yd80XOidyUJph0a0USJNbGX50HNopalUKcLS0RHRx7K5sYtyZPuOIc3KzldX5XH
	QFxjkPF8YgmYThPI/GlhBsuueNwK08VKV8eqqj521CLanVb2JfqrnI/crAY/IfSzvzUwgg==
X-Received: by 2002:a05:600c:8b6f:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-4538f9b3107mr143524935e9.6.1751361332474;
        Tue, 01 Jul 2025 02:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1+hhiGD2TdhbjM5rCKiCBttXAuLX4uPrW3umLUj3ZjRQ1AlwZwCo9b7DK/NCeCb3VsFrpgQ==
X-Received: by 2002:a05:600c:8b6f:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-4538f9b3107mr143524595e9.6.1751361332010;
        Tue, 01 Jul 2025 02:15:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453a85b3d44sm11486255e9.0.2025.07.01.02.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:15:31 -0700 (PDT)
Message-ID: <7c9c7be7-af3c-4f40-80b4-5b420ebbfca3@redhat.com>
Date: Tue, 1 Jul 2025 11:15:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: usb: lan78xx: fix possible NULL
 pointer dereference in lan78xx_phy_init()
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>
References: <20250626103731.3986545-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250626103731.3986545-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 12:37 PM, Oleksij Rempel wrote:
> If no PHY device is found (e.g., for LAN7801 in fixed-link mode),
> lan78xx_phy_init() may proceed to dereference a NULL phydev pointer,
> leading to a crash.
> 
> Update the logic to perform MAC configuration first, then check for the presence
> of a PHY. For the fixed-link case, set up the fixed link and return early,
> bypassing any code that assumes a valid phydev pointer.
> 
> It is safe to move lan78xx_mac_prepare_for_phy() earlier because this function
> only uses information from dev->interface, which is configured by
> lan78xx_get_phy() beforehand. The function does not access phydev or any data
> set up by later steps.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Looks good, but this IMHO deserves a Fixes tag - yep, even for net-next!

Could you please share it?

Thanks,

Paolo


