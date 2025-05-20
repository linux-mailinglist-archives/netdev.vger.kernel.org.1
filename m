Return-Path: <netdev+bounces-191796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E6ABD46B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA038A5086
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF5267728;
	Tue, 20 May 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6oMAB6/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB62676F8
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736452; cv=none; b=Rc58STZ1+us4R7r+s+rOlW+HPnuMnlzJDf8Y//THbgfdMZc91AVhzjiusXXGOvF99pclZNoXGIuVxo8M4YcL2hSZsL3u+18g44FbxSc5WZ5Ixx2A9niIxskXEjrjQ/6IA7Ey1a8Y/3PByWxORBEBNikvL+aVH1pWNDD4zb4Wprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736452; c=relaxed/simple;
	bh=77UNksR7PpwtfqbXK9+IGapmVvay+FGcbzq/Ejenpqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFOyaU8gJ79gnow7wmpHMOfDJt75PzvDR/+1sN7P5sPs9iuNAoqUT5RK0hsNOfZ/urv2zwy2JHRzJxf6mBgQsImYCGS4GAsgF/AlFLlnFWfIHcA/iL6PrdG/EAvmAwMWn2YpJ0xicx3pMNCzA4eqwUowdRiXrbngDxFceWivdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6oMAB6/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747736450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fDO5mSCROcWSo73vNWGfLBQFgLKwON8pGdIHty93oQ=;
	b=b6oMAB6/wAPvsEesCvjGxJRDG0lopKAwavnwbnEfiwwkbUlVfQeKomnK6rtSscoA+QBCV5
	7LlyoINyAGCTERgFvQZDBVpnz8s9C1Cwa3Rf97jqIlhtgGIzhmCuJJTIrmQacFI3hUymd7
	6v2O5EL4Sb8QK3cElAFiBrxmh/7K71E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-hOVpUYEINcqDKUuqD9Ks_g-1; Tue, 20 May 2025 06:20:48 -0400
X-MC-Unique: hOVpUYEINcqDKUuqD9Ks_g-1
X-Mimecast-MFC-AGG-ID: hOVpUYEINcqDKUuqD9Ks_g_1747736448
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a3696a0ce6so1118567f8f.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 03:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747736447; x=1748341247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fDO5mSCROcWSo73vNWGfLBQFgLKwON8pGdIHty93oQ=;
        b=LKmFfGIELmP6DWuO+bI2kLp8kmJnlGO78L4QvBzpDlrwMnA7Wq7S7enUCFwFsV/4vm
         QvuPk0qGku837/UPTWrz1PGg+CdWSlAv708DBbEGwG9YWJqC05hy3Y2oedg2ELM5DCUk
         SLa7CqM/2cRFBx/aw5KNdCY0/P8oxh42lQKjnb4v5NZyjFaMPBIlWFrr4Z0of+bD2s6N
         ULRRv/ad0x/s+J5UVn5PUxqBCJYGjGHMQsUlgd56lFBCavoh5f1vslyhxy+NhhGdVlHy
         kWHGskOlsh7o+2dPudufEmY2M36aWmTS/D9UvCgclxEw17P7HwMhSTXrZsMexjQq83Fd
         /lvw==
X-Gm-Message-State: AOJu0YyVPnRoxae/vnqnVOLXETtdnQ89u7iqS0c7mHKA3JPRBAbtY7I2
	ZhovhHMKdbeRcLs12+Bq9AVLvwnOJTddb8HrKucaSqDcptLf0nE13rx7/fwMubTWWHJYU2cUvb3
	cRM3GJud41iXWEZJM3FO3JmIQ7e1uIyfjYvy6fRLJoHolnLTYkZJfJ66MGA==
X-Gm-Gg: ASbGnctfhsCsECBowTQoS1YZcRrUgMpBm+QIJD8k1PpzYEwIg3QyqRp1LxLZ2dYyg/Y
	PNRoUgltQ3zmzEJ989QABWuO5dbBuuuBJQCwjJFl81mwgFyGachJ5X6RC9UOp1EFBHeVvpVd4yG
	FPel+ixnCPH1humHKqjCW3p6+drcawWUi3IUKVrmGO6ytVR8FgHoNkTbobwO2omLEh1OYy1iVpW
	q+cuNJOl9I4DM60BNBYv07LHUBraGnUBFKQ1w033KzhzlyMbicVtzgrIzEyDhLqDredmH/kocsB
	zEHj3taG5v21QqODgTghIqyK7IfEE09yNq1MfGNMZTbD+aV9SaM2pY61MHs=
X-Received: by 2002:a05:6000:40ca:b0:3a3:7387:3078 with SMTP id ffacd0b85a97d-3a3738731c1mr4930501f8f.4.1747736447655;
        Tue, 20 May 2025 03:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqobZOZSkuqHKlD0nO8+4YucXqJmdGhVd/4fKpbET1Jpt8udawMbKa/WqB5cRSFXwJHX1f6g==
X-Received: by 2002:a05:6000:40ca:b0:3a3:7387:3078 with SMTP id ffacd0b85a97d-3a3738731c1mr4930476f8f.4.1747736447331;
        Tue, 20 May 2025 03:20:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a87fsm15561568f8f.29.2025.05.20.03.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:20:46 -0700 (PDT)
Message-ID: <7ba9aaf5-5391-43fd-a01f-c019b783751d@redhat.com>
Date: Tue, 20 May 2025 12:20:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: phy: make mdio consumer / device layer a
 separate module
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <dba6b156-5748-44ce-b5e2-e8dc2fcee5a7@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <dba6b156-5748-44ce-b5e2-e8dc2fcee5a7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 10:11 AM, Heiner Kallweit wrote:
> After having factored out the provider part from mdio_bus.c, we can
> make the mdio consumer / device layer a separate module. This also
> allows to remove Kconfig symbol MDIO_DEVICE.
> The module init / exit functions from mdio_bus.c no longer have to be
> called from phy_device.c. The link order defined in
> drivers/net/phy/Makefile ensures that init / exit functions are called
> in the right order.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Makes sense to me, and I think the best path is merge it now and allow
the bot to crunch some possible weird/problematic conf I could not foresee.

/P


