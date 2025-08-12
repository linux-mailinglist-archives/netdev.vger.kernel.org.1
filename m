Return-Path: <netdev+bounces-212841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1804B223D1
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB21507D01
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533AA2EAB72;
	Tue, 12 Aug 2025 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxyiJVIS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB32E92C7
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992569; cv=none; b=TGihHQbQlwLgeNBb8oFwM+amjeAYZVlmJFU+LiN+OqJXOKf+qibYo7zKr+JOIrDn2fJfEUZkYhAgphu78u7AeIJJv/m0OrjIXfSuBjrczgckN1hiM4pY0x8W4O0TmPdTPuFv1m+rO+0W0DDem17v7Nep6fN/NlEDEd8Zkw0CmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992569; c=relaxed/simple;
	bh=HWb3xi23hSoBArVmr8OBU1OUlFYK/4KX8UidlJ/V7tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TP/093E3lHpfGaYW0+LJNKYTxNQKiXoN3w75wkWu4yn5PGcLU5Ylee6MF9vZ119NCvaMT3syykov3G0K8LZZT/3LlbYwd3ncr8jDCyTmuHAd+TiKvLcuJO3tHtPvRR8ZFh868N0tFUUPdMNw0cKVx9hnDnQ+0Yf6VPxL2g2gvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxyiJVIS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754992565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcroCdbDdLAJtbYY5wsUtVmzj5oZXmeQISjQCT4Dk2o=;
	b=DxyiJVISkTztys/xfImxpy075tSj+a25iDPOt1esnn7qhq67CCpPoMKCpK3k/8insacH4c
	3w3DsHEXh4AnCWJP+oZ6Y7FmI1TOT1XaGVYwPZ6yvFHEV4UjoW32C6z1IufhZAKK9Rsgmj
	8u6pesqLm7E/mQsfYIyqBEzfwVkcGhY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-W2SzE5SiP1OKAEquBOJs9w-1; Tue, 12 Aug 2025 05:56:03 -0400
X-MC-Unique: W2SzE5SiP1OKAEquBOJs9w-1
X-Mimecast-MFC-AGG-ID: W2SzE5SiP1OKAEquBOJs9w_1754992562
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-458f710f364so34898635e9.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 02:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992562; x=1755597362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcroCdbDdLAJtbYY5wsUtVmzj5oZXmeQISjQCT4Dk2o=;
        b=Fql1EPh8Z7ej6XMS4oLrTAbQztFtxw6Hm/VS/uIYDYjWiGRHSWrMdI/PBp6ebPbJlO
         s6LcpbldVR31THUMAFM6/ARE0QjDeXF5BWvqCX7RMOx1G6pYUIojZjtmmeFZAFvIjEKO
         5StoTUU6jhqzKPAqKmgCZzJpikcHeEdiheh2Rs/FM0jnAFnpFbV8FWWnA1QLh2vURO44
         wqra6h6ljq7Yu2sWYzE168DXZSKmMS8hesJwtopp2Gu44I2iGSpU9bWgMfPa7qHf8e+9
         NhoNC1Zh+imeQmYYvaS4GtAZdtltdb9J/49J4LwHwUoS9aiWiKrfoSykbO2iaMAHkue5
         ntZg==
X-Gm-Message-State: AOJu0YzsT2Hc4hzoYQevCHJIqsfw/sdplSdx9jadHc6E50tNBTLqycAi
	YhRvQd4YsRFjwyU9rF2ocMjRIA//9p4O2zXlOZlEBZNZf72+Xd02Opl3C6gxRwNqPY+U3DBiPJs
	B1GE97ETaSjsmQgCz5uQ55aPPr779LkWLaUxo6wtZqa8FxilB5b3z0/+y6A==
X-Gm-Gg: ASbGncsmW5Ks6zYeZ7cjJWg2Mw3qm3QglY4vZGABW065732CVB+H3xKENiK2Yw0RZ36
	Yl7fwTR2t854Hyh9XzJXPPmsIXL1o4qriqoqHUAyvWxkMjQmNs56ghWoUthbBvPS95PVyuNHFvE
	/ne+o7eLInebay4UlfSJUh4CfgZ950VLzXw7ImuCZ+0sQZdO9WKZZ37PxCGMIT4FfE8TwR0G24V
	zd4lYm1Vs/jjHK5x0VX5LwRipuyrVQKuRaXCxorbwlIw5lMdnJeDjGAq1zqomsC2SXVUqPZRbiM
	Jg6uU5xBneC9woQEEzrhZlpKDlO4px/qwoARdXw8UoI=
X-Received: by 2002:a05:600c:b99:b0:459:e20e:be2f with SMTP id 5b1f17b1804b1-45a10baf6ecmr26694045e9.14.1754992562231;
        Tue, 12 Aug 2025 02:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENRzAL/VjP3UDkzezzv7O+gqQzDoC3ydmDX+MYqXmh2wK5sVfHxPNITbIdTaggEZYdNUateQ==
X-Received: by 2002:a05:600c:b99:b0:459:e20e:be2f with SMTP id 5b1f17b1804b1-45a10baf6ecmr26693745e9.14.1754992561823;
        Tue, 12 Aug 2025 02:56:01 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm43629578f8f.47.2025.08.12.02.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:56:01 -0700 (PDT)
Message-ID: <a45afc9e-f508-4f87-9462-112f3439f110@redhat.com>
Date: Tue, 12 Aug 2025 11:55:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] phy: mscc: Fix timestamping for vsc8584
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
 viro@zeniv.linux.org.uk, atenart@kernel.org, quentin.schulz@bootlin.com,
 olteanv@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250806054605.3230782-1-horatiu.vultur@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250806054605.3230782-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 7:46 AM, Horatiu Vultur wrote:
> @@ -1567,6 +1592,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
>  
>  	mutex_init(&vsc8531->phc_lock);
>  	mutex_init(&vsc8531->ts_lock);
> +	skb_queue_head_init(&vsc8531->rx_skbs_list);

The aux work is cancelled by ptp_clock_unregister(), meaning the
`rx_skbs_list` could be left untouched if the unreg happens while the
work is scheduled but not running yet, casing memory leaks.

It's not obvious to me where/how ptp_clock_unregister() is called, as
AFAICS the vsc85xxx phy driver lacks the 'remove' op. In any case I
think you need to explicitly flushing the rx_skbs_list list on removal.

Thanks,

Paolo


