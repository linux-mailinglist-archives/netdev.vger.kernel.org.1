Return-Path: <netdev+bounces-111755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B1D93273B
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30237280A82
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C7C19AD58;
	Tue, 16 Jul 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckdySIkp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AAC1448ED
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135684; cv=none; b=e8S+optfKfr0i4KGHRKUSJqKMfaqPdD59yW5aVF/P57lcZFdP2W0CssNz+KSRV0FvvQTuY1bYYwmjp5rEDLEuoWacthbofgaITFi3IwtK4OzvwlcEDwL1/Nc8g5hADnYgotskvgh+1bSoAt6OG7FG6oAXnlztiJIh203PLefYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135684; c=relaxed/simple;
	bh=6dRbIrshTheomuibRAqbFDbRKbFnbPCmtotF4+QiYF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XYn7RSZdng/dqfzZSTC51pV9oXNC5EhIV+8lW8bRXPMv1PwupBuRRR0hISTwxYlbfTNDKesWZ7Pxxw4pEYQR+3A1OMr5K6PJLfoqIreNBCE5N4PNEwyFg83SBCisHtoVw+Mj5kS/+/DcKJTKe4xp5XFLaqbdOyAvETAIwh1LyW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckdySIkp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721135682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LEDQDLQ3briFZ7Dh19M97K7riFuoWHHeSMgTzHc0b0=;
	b=ckdySIkph6ahh7DLsKqCcMbaY6ZZHzZx8p24C9nHseBNWVWAECS+yb2b5/vseN2KVlcYWX
	p78LwELPZNaemZyaLmEF4FHuWDMsmjnX5JMSoV2kUAIbUue4b5WhL667Zle+EKX5kh7C5o
	MFG9TED7h9CAFqETTkdV8OM8emOOSqs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-OM3-fGSkPIGtR3rGpEBuMg-1; Tue, 16 Jul 2024 09:14:39 -0400
X-MC-Unique: OM3-fGSkPIGtR3rGpEBuMg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4265e546ca9so4125435e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721135678; x=1721740478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LEDQDLQ3briFZ7Dh19M97K7riFuoWHHeSMgTzHc0b0=;
        b=auMv7Tx1bTAYO0rsTaN3qckzPW9zoVQk9xfoaEbfDdAPmiiXPC+UkpGjyCO5HjLMA/
         MsnM+ByeDGCo4lcawFTajNZWKKPQlbc8seU+YLu90og4zBCWkDFgAx5pNDZ+d9szV3Cn
         SQvTtwRJwQjNcL7IjGo+XhFbH3NDV8lsVAoKia1y9lhDEzjvEk/r2kN9/zlVfO9m+7jF
         ZdNIQScdnfcrOeYOsgD8gxT35Ar1Zgfha9hhRXCVvE5dRCYEztkgZ1tP3tPRRrS1ysgl
         xo8YeFLK0A+HSPhz5z01/lBLcSSfm4oCgzWcniznIfoQZkifSNcJYu4esnJtwjWVkRfs
         lUrA==
X-Forwarded-Encrypted: i=1; AJvYcCWNZJmb5MRvy6P3urZOrkL6ue5EWZCu2NhEKiJj/Trjhv5lp8rOGCqiEqoddPBtqJYMsGeW9GxFj0flToJPaea3Ur48Dtss
X-Gm-Message-State: AOJu0YxvR3U6GrAzCdqPSO+3275pBgxDKBgQro9vorNqe1zFPeFnKV+t
	L2ZkloJ3zBqai1R8kQ5CiyIAmkQzDACKS6B4CCSnJ9VAbNzL7f2KEp5S810URIK1bB8k1b/mRG+
	TFj7+ikGamKoqlOZlw/57UkCXDRtDjIDWWdOfnc11jkStTciSJt4zTg==
X-Received: by 2002:a5d:47af:0:b0:368:4c5:b67 with SMTP id ffacd0b85a97d-368240c5cecmr1297771f8f.8.1721135678528;
        Tue, 16 Jul 2024 06:14:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUbkZufXxQmRD68YJ0BeYGsi3kx+leKWXkuE2NaNvjicZkL5J0TGrRmp7vSDKiJutaHe6Utg==
X-Received: by 2002:a5d:47af:0:b0:368:4c5:b67 with SMTP id ffacd0b85a97d-368240c5cecmr1297756f8f.8.1721135678126;
        Tue, 16 Jul 2024 06:14:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210::f71? ([2a0d:3344:1738:5210::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e93c92sm129511955e9.22.2024.07.16.06.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 06:14:37 -0700 (PDT)
Message-ID: <e5603fa0-0755-4b49-ad5f-9f999e8d4e3f@redhat.com>
Date: Tue, 16 Jul 2024 15:14:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next] lan78xx: Refactor interrupt handling and
 redundant messages
To: Rengarajan S <rengarajan.s@microchip.com>, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240716045818.1257906-1-rengarajan.s@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240716045818.1257906-1-rengarajan.s@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 06:58, Rengarajan S wrote:
> The MAC and PHY interrupt are not synchronized. When multiple phy
> interrupt occur while the MAC interrupt is cleared, the phy handle
> will not be called which causes the PHY interrupt to remain set
> throughout. This is avoided by not clearing the MAC interrupt each
> time. When the PHY interrupt is set, the MAC calls the PHY handle
> and after processing the timestamp the PHY interrupt is cleared.
> Also, avoided repetitive debug messages by replacing netdev_err
> with netif_dbg.
> 
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>

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


