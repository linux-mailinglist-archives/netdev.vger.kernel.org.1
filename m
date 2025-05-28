Return-Path: <netdev+bounces-193893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8852FAC631F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB22B1896BFE
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B45244678;
	Wed, 28 May 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cI/Cm0Ma"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77320DD4D
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417729; cv=none; b=Lg5hxdsN5FF4uGC53jJvflAxifVa63wjXFGlvrcdigSkhKlIl+ta4oY5fqmD+giysMDxbLjZb0sBnhMc2V71OKpyvhTrqPnQWE3JPLT71cdccvUO1fp9InCdSLRVd6l/kKa3vb0zpqQT5xApZPCEKwywimeMUj/uJGHGhY45JOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417729; c=relaxed/simple;
	bh=fDwGHUEhDn+rwyiBU7Dn6/p/hT6B9pKkn2lAsUYU6Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMGdv1+ooIO3cDOc2LgWLgpEOIymizmgu3Y9DoAzfnNoymiYgdVo1hsEeXdkuOWkbRY4jyciqVkgXG2ZG2XxdWTKcktM1X30S3zwPhuHRbl1d89SfJf0/f1hyVrQX3E0ZlPU4BNv1pAtSQA6Ar8x0kpIKWplBcqX7wZG9vVLVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cI/Cm0Ma; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748417727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2SUhQMNlHoU0/BLkm57+5UXwM9CYep2ONiXXIDvKa4=;
	b=cI/Cm0MaQM0IZqBqdRVp2NMlX06nvOMYNdqNjraavRnTJ0QTeEc8sgeoiSRpakUgb5ySlJ
	7EKpewf2ibChPqXdBFuURfrNRG63PnULWlQaMGNjhhQS0bCdGGwCa7qxjHXGHBdMy7J1GE
	0Aok0xtUAm+6xhJNfBR9z0p6f+cnauY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-UQKM0_kqNf2VFLJo_HDeWw-1; Wed, 28 May 2025 03:35:25 -0400
X-MC-Unique: UQKM0_kqNf2VFLJo_HDeWw-1
X-Mimecast-MFC-AGG-ID: UQKM0_kqNf2VFLJo_HDeWw_1748417724
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4e1c6c68bso1160001f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 00:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417724; x=1749022524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2SUhQMNlHoU0/BLkm57+5UXwM9CYep2ONiXXIDvKa4=;
        b=XhnToWKMymV2mg0p+h9qIl18k8AcW/q5QmxcTKOiSc/TaoasG0oKBwzxTv4OHZ5Ged
         iyhr9Joq+0V3KdnQ/7a8otrUuPdkcOPLHNT6hYMHRiVItPwC4rjsLkfeWxs3EsgMYnq/
         V9pQz9tzvW+aJcN64Yv+Vmtl76oSObGLrWqSpySMihQtJ3XF1+ObvkQtwOx+kmUT9JTl
         7lmgdUKMTzqjv52MJitSFEdqPRquJb4ChWgOXII8Sm+GilHfaabOKiWl4Rsejsecq+y9
         4ip1d8AfQ3fgy3MwLhm2nZ54kc589SxsucdRZGr5PU/klJ5f3Z4X0jsBTZ+uoLszSGdV
         PFbA==
X-Gm-Message-State: AOJu0YyNobTt/FqRKpNxkv7ZbJsDF3EzwdMbyof7/e+lGMiIbSY9v2G0
	lYFmmxB0n4lhP0Ht3Nl5W/vhEUGzK1k4pWzLerweF7wDHV7kxAap7HNhGqRYCgqX/+yQrOaq4XO
	m2Ircax+vB+wZ2FZwZowHdOHUZU1N2FhHnZMrDoLbRAR3sbYXQqExmYv4MA==
X-Gm-Gg: ASbGncvFJNGjlxvZ4ONyXmUDguoIGKwtn+EBTYzQQogYknVpf7+Z4QSdDA6JfBGHNzV
	fBxoJEKxIrHsPhUEDINZpKg78KPJqkL8v/ua+HdIcjFzPbWqibMSq7pAbkdm85HcibIHkUKWN6n
	rrqumk6OyJ1EQjRuuz8TyMXWXpVo1kRGLCQ9pKgzKuxE0P4GEqhgxnUa/q7ehwudBVUNLzJLcbw
	aRUBTzaSZNLbRTpVjshgNQ5v6LovJr/pyqk0OhnFmE5ekcOFYDbcAB4/qCvX/Xmcpj3UWuJroRq
	ixWc0Osbck8nIfKA6LA1AmkP/VhvJeYbNcH4m7Sr/QQQBLKUpOtUTPfEMEE=
X-Received: by 2002:a05:6000:3103:b0:3a0:b539:f330 with SMTP id ffacd0b85a97d-3a4cb4281e5mr12848492f8f.2.1748417724316;
        Wed, 28 May 2025 00:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZrWVbGbnBLDh8iiWb8iF0ldW5txeJpMkEk4vQC32hRl1Asd3+SO3mBLBiz6uJg/KXwU3/vw==
X-Received: by 2002:a05:6000:3103:b0:3a0:b539:f330 with SMTP id ffacd0b85a97d-3a4cb4281e5mr12848460f8f.2.1748417723892;
        Wed, 28 May 2025 00:35:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac6ed58sm709540f8f.8.2025.05.28.00.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:35:23 -0700 (PDT)
Message-ID: <70e3a8e2-7428-4105-a964-ea9d3e2fdec3@redhat.com>
Date: Wed, 28 May 2025 09:35:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: assign default match function for
 non-PHY MDIO devices
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <87b2628b-c87b-4fef-9a29-41a4331d38f8@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <87b2628b-c87b-4fef-9a29-41a4331d38f8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 9:39 PM, Heiner Kallweit wrote:
> Make mdio_device_bus_match() the default match function for non-PHY
> MDIO devices. Benefit is that we don't have to export this function
> any longer. As long as mdiodev->modalias isn't set, there's no change
> in behavior. mdiobus_create_device() is the only place where
> mdiodev->modalias gets set, but this function sets
> mdio_device_bus_match() as match function anyway.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

IMHO this deserves an ack from the phy crew, and but it's now too late
to fit the upcoming net-next PR; please repost after the merge window,
thanks,

Paolo


