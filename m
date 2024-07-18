Return-Path: <netdev+bounces-112032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B54934A73
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AE41F2822D
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33A7D07F;
	Thu, 18 Jul 2024 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHg093T5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62877107
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292706; cv=none; b=SWEkJ+fLcIGFzb1Et5Q1F2KZTa0B03uIKcWozc80K7UDgmgXYQgmjZFWF4KHtvuY3ddovdhUcFDKdnJUyynC+X2e39ixc6k3Sv3pWjusIKNaaWhpn4uUvk4Sr/8g+sdI+y+KaAn11Yz+7Aeivt0vGdUtUL/HU3L5Q/LIp+e1BxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292706; c=relaxed/simple;
	bh=MdeHswIBPPTtwRUeCgb+BphChAYeCJhMEXm/d0726Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HH/eQewhcOKoBhsNcQZCeITbyJv4lX7MkB/BxqjJXiQIYYIbXdI+5grszdqRvRzbMXRIjEueoYDUB9+Jegox+daAV488+nNuh/T7iNRWWzAXjpjyRFQMKnY/tQKG+hSGf6wiOYmdSl0MXXbDwSbWC6K4wMWYNyYSDOeRxxyS0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHg093T5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721292704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20Tnlq0OUegCOEQmFC5wwha5OhmQWY424U+1skg1sa8=;
	b=hHg093T5abzsCIJ8izR9KWbMPrvrFs81tZnc9eSlENVdC1KugRRCGblQoZbWTAjLgEnkiJ
	9ipwg4Cr710Wvdgr0WfchmVlcBc3IzVjifWZty1vFW1dAotrKmygsljJynD/qsfFyGKElf
	sgT5s5SwSwF/e6o3p5uXsqFbFAJx/AU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-fNwrpeBVMEy_PuzrmHEHqw-1; Thu, 18 Jul 2024 04:51:42 -0400
X-MC-Unique: fNwrpeBVMEy_PuzrmHEHqw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4266a2e933fso49155e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 01:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721292701; x=1721897501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20Tnlq0OUegCOEQmFC5wwha5OhmQWY424U+1skg1sa8=;
        b=AXNqM23duxtwr5Fbzu6D1fYHNd2cH18dbOvhqh46EfXlhp2GoyTq0X25zhq6olhdK7
         UfC6Xmjl6UzMfdgmi5gJ34GePqgImdtjvyhi4sCCa6jW6tG8TFC8wvE7443oZCB3tt/I
         re6BtTuag0PPLfWuYECbMrYEW2yZVvTLbHGzhFETxNoPGqArjcLzvVLNWmc/XKpzcv0Z
         /7EYwh1fVk3ivW/smU9WHps/Mz+ekz+UBecK7aClGupUiTgZ3fsY9MdcZBbYm+vVlWpW
         h//1hAMTqRwglubcis6/4I1ImFfAPI/SYkZ1Vm6NBB6FPUr+mp8hwnnDJlLt8YLsNcOu
         ALzg==
X-Forwarded-Encrypted: i=1; AJvYcCXxP0JhHqEPNuwRxq6ovtynOMTJ/SJaYKHqwJfbJe8b7PJuLRuqA4wN2rcDHpqFRNQsA/UjyOra45LRxwBvQPkC6yijEybI
X-Gm-Message-State: AOJu0Yzam2BcItm7JP3Q7psg9CoRNyJYLwCivI8ZX7veIew4aLyCy2ZM
	XRNkVe/X/IL6uxjLAdWeQmhYzTFdZvHGXRtJ7CPGgOUK/iZZQIEVtQ9wT7J/O9Ap6xso5Gitl3Z
	fRrUdgR8JnzyjYcF7Iw0I+YaLKTQXsYK6f5pP2yCCJfciZFYP1Uom+A==
X-Received: by 2002:a05:600c:1ca9:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-427d2aa0b2dmr877445e9.3.1721292700849;
        Thu, 18 Jul 2024 01:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxtLbmObFnfSZwe9VmhP6oYhoC+mtRhM6m+a7WDr+smmx4B7pfpnsPJJZX3d4B15Kuce/eLw==
X-Received: by 2002:a05:600c:1ca9:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-427d2aa0b2dmr877365e9.3.1721292700497;
        Thu, 18 Jul 2024 01:51:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24? ([2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b317f1sm1589565e9.45.2024.07.18.01.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:51:40 -0700 (PDT)
Message-ID: <f026cd7a-d461-40eb-9e30-1bd76684b7af@redhat.com>
Date: Thu, 18 Jul 2024 10:51:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: micrel: Fix the KSZ9131 MDI-X status issue
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
 horatiu.vultur@microchip.com, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
References: <20240712111648.282897-1-Raju.Lakkaraju@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240712111648.282897-1-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 13:16, Raju Lakkaraju wrote:
> Access information about Auto mdix completion and pair selection from the
> KSZ9131's Auto/MDI/MDI-X status register
> 
> Fixes: b64e6a8794d9 ("net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

@Andrew, @Heiner: the patch LGTM, any feedback on your side?

thanks,

Paolo


