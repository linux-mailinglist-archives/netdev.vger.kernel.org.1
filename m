Return-Path: <netdev+bounces-111756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D15932748
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE523283857
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD36B17CA05;
	Tue, 16 Jul 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwHb91dz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A541CD39
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135844; cv=none; b=JpnCTcJwIR5xHTzHZRaK3dpGpYq3uREYhnIUoMTWktdGaUBRgaGVrtZOwj/hwHy4a8Q1GljVfj2I9GNQPBqLH+BHu8Z7buMkNw8B6+DUsGMKIbCsxk7X0PXScHetmhXO6gkd20XLkHZO6uwjPH4KnAE9G1BI1nCgiHUTAOgcGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135844; c=relaxed/simple;
	bh=Eg/lftqubvyEX5Bd60Ucs7ETOpklpI3/xFJ3osyU9aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/Mc0o0KOL/zYPJewzNCEzjdTztVGxRi1KTiQIhlPhmJ5p/K3ES0zV+mGYOGY3jwRh8/mINY41bBg6MfDxScLAPQen8R3vVayFMp4VQzMcWjQInE0CCkJxdcmbe2PVAmfHtPCBBRkBERrIUk49CblBf3mQFEhuXKrE90n+x4FEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwHb91dz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721135842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeViZGApj3eElsFuZdKIKlgTMa1oEImto5Da5j+IQyc=;
	b=YwHb91dzTKu0wXjDrHVdSLAhMkoHwucctngwrZ8/PCDbzDbp/rzaQvoFbwmNnamLAWn5cs
	24cCX3PWn/G1bWcd0y2FFimbrVEx94GPbq267Njsg2YUqo/53YPXkb9+NViZvptjChmDIB
	Y13rbgxOZlapLfsd0MsKH6HCqSPPa+o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-PCx79L_NMOW9N5SQwF8MaA-1; Tue, 16 Jul 2024 09:17:20 -0400
X-MC-Unique: PCx79L_NMOW9N5SQwF8MaA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3678c35e69bso97552f8f.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721135839; x=1721740639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeViZGApj3eElsFuZdKIKlgTMa1oEImto5Da5j+IQyc=;
        b=aBNBwECllQwa+VY1nU9z+HuwNXx6GIRE7qreu7U9UK2p/zAqffT43FVtG54MQ4wrAJ
         ASb7na1UVNO02BKYJlEQSF7ULi+vNuOJ9VICoiPd6AmBAqL1Ib1Idunv7UVilakM4GuU
         X0c4Wy0XiJ9+0ZVA9JUMJN22jyfBEo7T482kYFA7irSYjS4ki0kg4rSZDOoUomVm6tc/
         0JF5Ejzx1lhKUGpseDBmgrsiwPZdexL0HiScHwGbZxOkXoJqJaIF+Zj979wsIsCKmCCl
         j3aHUVxnaXmPyJKDCx8YVuI7FPTk+8v9CGOk0FlRNoPsywKWKuJ5dLU3vjs8F+tpSMDJ
         oJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7YQaX8B67LbYVp06hGNtSOGCsmNy5UMCeqcpnu0/XLgvTpoVnU8j8KIQzs6IerGB0UUMHgAj8opUxiQYs8jFV6UXHC47S
X-Gm-Message-State: AOJu0YzPV//h9BPGpoEqW8Az2DSwzmGLnBdd/rrA4ku7D5M9OcqHqjng
	+aHtqT6GHEYm8noQvYWyu/qSRjGp60Zvu7zeVEFthSsB9hyBw7ziK7lQkgdUY8H7BM4JpM/DZx0
	rFjY+VaIRJ/59KD4ttlY2O8Undiwj0xuZmPLkzbk3USxPcGvtqihatg==
X-Received: by 2002:a05:6000:2a4:b0:368:4c5:af4 with SMTP id ffacd0b85a97d-368240cee04mr1382611f8f.9.1721135839664;
        Tue, 16 Jul 2024 06:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElLoSdJ+xIm3/ZPGhjV3ZWalyIbR92kQEiDTKB7VrzFAGFDpH1fCFbmAZ+FYNryODygsdaFw==
X-Received: by 2002:a05:6000:2a4:b0:368:4c5:af4 with SMTP id ffacd0b85a97d-368240cee04mr1382598f8f.9.1721135839228;
        Tue, 16 Jul 2024 06:17:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210::f71? ([2a0d:3344:1738:5210::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db049f6sm8947213f8f.113.2024.07.16.06.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 06:17:18 -0700 (PDT)
Message-ID: <5f5f9d5e-6c2f-496a-b795-bc609cd1137b@redhat.com>
Date: Tue, 16 Jul 2024 15:17:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 0/4] Add support to PHYLINK for
 LAN743x/PCI11x1x chips
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch, horms@kernel.org,
 hkallweit1@gmail.com, richardcochran@gmail.com, rdunlap@infradead.org,
 linux@armlinux.org.uk, bryan.whitehead@microchip.com, edumazet@google.com,
 linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 13:33, Raju Lakkaraju wrote:
> This is the follow-up patch series of
> https://lkml.iu.edu/hypermail/linux/kernel/2310.2/02078.html
> 
> Divide the PHYLINK adaptation and SFP modifications into two separate patch
> series.
> 
> The current patch series focuses on transitioning the LAN743x driver's PHY
> support from phylib to phylink.
> 
> Tested on chip PCI11010 Rev-B with Bridgeport Evaluation board Rev-1

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


