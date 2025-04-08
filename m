Return-Path: <netdev+bounces-180241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C57A80C47
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3007B8DFB
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7197190470;
	Tue,  8 Apr 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fchfh7Cx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A8EADC
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118963; cv=none; b=nAXe9ZLcgLmUMFNwY1WfrEist6g6cquJy6SEA0dCgRYUc0FoaZeykYNu7pSgN6SexsIWEDw531zzkM9/FFxh0pVSNUoMWMn1EAz8C8FWwXwMSia3dZEkGFMbH+dq7MnJ2Xlg2xh1Jk2bMncf/IJJGu++lZry4Q7kzBDPqwb92Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118963; c=relaxed/simple;
	bh=3pOUYj6JIOLbe1ljngk//BXwsbh+xpYpSEW8R94B+kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZhwUvh2Y69UB73JG9Mv2pDX4puLlgSM7FlhLr7JoIaxXcROmL8ar5ttYgDAxiNASQKXYExerlbtkUKVZ5OeXGevWZ/mPSKFF3Czlup8P8/rRQuuVBtBihXB01HXb1sIrPyKPRv349bwrQDogdwAz8+PXFsQw34crngWDoSCy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fchfh7Cx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744118959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBHxE4o+poP6p/ofYoEMxQF6RNUpC2hi/3SExaAVHuA=;
	b=Fchfh7CxL4BW5G00aZPhmFSqEEYWKO9uO2ME6OGUCP9VAyEFtZNxH9z6eOM+vTEab/bbj1
	cPSPg1IYmE8gy9nVhccca9+WJPepGXwXvrN9ER0qL8qE7uTLd4GSxceQ89D8roc+5mNVMp
	ldv8bL3ZNHen3rJfRooroMqTpRcmszI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-y3paXQi2N7mVmRsz8TR5vA-1; Tue, 08 Apr 2025 09:29:18 -0400
X-MC-Unique: y3paXQi2N7mVmRsz8TR5vA-1
X-Mimecast-MFC-AGG-ID: y3paXQi2N7mVmRsz8TR5vA_1744118957
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so3323047f8f.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 06:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118957; x=1744723757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBHxE4o+poP6p/ofYoEMxQF6RNUpC2hi/3SExaAVHuA=;
        b=rzPaF7h7xtmy2tiyuGkL68nkMgRjFihrIhnpgjVxoN5a2YN2++rnHavAQ4x1U44MND
         ypQAHN/xn6nyfNHOlRA4fLhZmIfs8dwxFQ3i2IC2ceKEMNVQwDVtRjYS3xyuEmgN94Lf
         8D4mocDCGOziV+y8jS6nqBWYTUbVcU6QXr7/O12+bDojoiDhtUslsU4v+W1v3UTpIiBq
         VX4LbmIoO11KiXscKpiK3LY7fKoTFEG5Tw2GIUS8Wx6HZV2l88j4UDnI1FuuBizEabhX
         HUbBhRWTCspbUN+DJJ9fpL+T29WGvfIG0+f5QebMS7zVy/AGxSY/FCJqEVwIBH6DMlvi
         UPVw==
X-Forwarded-Encrypted: i=1; AJvYcCUdLszQHbV6lOLJJ4w7wiwcRxtJ6KXwSht+JZ5naB3t2X5GlTREVQAV/7PXeW8zHECOxSW0eDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBfUzuHgh5G8AshFnsHhmyw0GMye2PXfKJ66/Jy6UpTI95jvqD
	RqDOBKlDE+6nnvbGjcitZCv0ybGhvsJC++ooXtijyI1NmN8BwuwTKRg7XJ6e0RsFX7TzPIiwHdG
	pvfBc7M6MInfQDu7W8OMv5LjQ5YIpyPLpqnbJcRwNJAKC25JKAXlqkLvNr91pcw==
X-Gm-Gg: ASbGncukFD7hc0TPQuTQ8ushGQSgbtmxvXDpoPBy6TwnaMttgqGTlYsEyAXufsqiM1A
	3VmV6o/Rvfb7ZnqAfAlfCiMu5kSGJI1SNHPltUriIhFXLVdRau8xXTKE1zwwor6k/y5ZAJ/xfuE
	gJTSzrNp2B+pfb7//WyPrqCNIQk1FJMgRfQIBthNhXIMbKsuHEKBNbE/FgyvTSMNbM86Ee2ORGp
	ZogUUt9VuL1iJRGM00dl6zgP3buX8ZW9Wt2aeBfjdgJtNW2bNWVJsvLuZgS7QHpLhun2hUqG/pg
	kCgXC/95PDL3Uy1phtNHJ4fp/WBxMikdQbNC8gLeUa0=
X-Received: by 2002:a05:6000:1a8d:b0:39c:1f10:d294 with SMTP id ffacd0b85a97d-39d0de28a44mr13769254f8f.26.1744118956984;
        Tue, 08 Apr 2025 06:29:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1HpRnEm/6M6CXH6msdauscTzQ/uB3jUvfgXW4D2EwTpNq9WLAloBhZWMlPFT2ix4Lmb7tOg==
X-Received: by 2002:a05:6000:1a8d:b0:39c:1f10:d294 with SMTP id ffacd0b85a97d-39d0de28a44mr13769230f8f.26.1744118956594;
        Tue, 08 Apr 2025 06:29:16 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f0e5e8dfasm26993845e9.27.2025.04.08.06.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 06:29:16 -0700 (PDT)
Message-ID: <d5e03a72-bff3-4df1-91ed-6916abaaa0ec@redhat.com>
Date: Tue, 8 Apr 2025 15:29:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH REPOST] usbnet: asix: leave the carrier control to phylink
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
 netdev <netdev@vger.kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>
References: <m35xjgdvih.fsf@t19.piap.pl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <m35xjgdvih.fsf@t19.piap.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/7/25 2:08 PM, Krzysztof Hałasa wrote:
> [added Oleksij - the author of the phylink code for this driver]
> 
> ASIX AX88772B based USB 10/100 Ethernet adapter doesn't come
> up ("carrier off"), despite the built-in 100BASE-FX PHY positive link
> indication. The internal PHY is configured (using EEPROM) in fixed
> 100 Mbps full duplex mode.
> 
> The primary problem appears to be using carrier_netif_{on,off}() while,
> at the same time, delegating carrier management to phylink. Use only the
> latter and remove "manual control" in the asix driver.
> 
> I don't have any other AX88772 board here, but the problem doesn't seem
> specific to a particular board or settings - it's probably
> timing-dependent.
> 
> Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>

Does not build:

../drivers/net/usb/asix_devices.c:1396:19: error: ‘asix_status’
undeclared here (not in a function); did you mean ‘si_status’?
 1396 |         .status = asix_status,
      |                   ^~~~~~~~~~~
      |                   si_status

/P


