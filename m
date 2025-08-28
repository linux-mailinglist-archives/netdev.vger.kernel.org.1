Return-Path: <netdev+bounces-217623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788CB3950F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF38B3A6EFE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5447125782D;
	Thu, 28 Aug 2025 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AE9zGshK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00202905
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365867; cv=none; b=q1AplWruCupJZ0L8zfT/bC03/8Yoo7bWVSMUEJF0WKzKoeQJAKxM/xfw1KHKu/kvyCCWA8Fj1fQa0NqceB1rvKyk8yS4Id5a4eVOQ71wZxdDQrQJP+sOnRGtx4s9sk/xuEvvMn4a3Y4L/bx03gQZdQ3VtYna/JTTNEotza9ETLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365867; c=relaxed/simple;
	bh=J7uUeWCM9kIi1DO4ms4r5uJMDYBgE3A3eXLTFPHBEBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyJ8FGqib8iz+96pEEICACC7g1zFSO3OGahutzYtFIKoLP4kZbCJdjrRiDYLyA12pl7x0WFfhmllNnNI4IQUWvWWNQqgzkUdYShB0ADJia/vEMGbEZXYVvL5OzIe11ZpuCGYk0kwUXGLvbUX63V78kUF3SEEpz7klM4u0JatGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AE9zGshK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756365864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIR1zw390cgYTtX2NX433kPJFGlwKkihK2GJLW5eSFY=;
	b=AE9zGshK4ENA0l3kvNMW/OwY2wnvaKbkvZoWkf+lzjZSzjCdJjcmZ1hABCPz5lSs1wJ9es
	gKm0mku0z/w3LhqIv20Si1w5n4L5sYTeeQWyIJRvaBWXxwG+RCH/LCMyTbC+8z98IIR9VA
	Y2vFP4HH4xQeElWmVCLY220oA1tvYlY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-BjaaX0OQObaGAQEeF3hzHA-1; Thu, 28 Aug 2025 03:24:21 -0400
X-MC-Unique: BjaaX0OQObaGAQEeF3hzHA-1
X-Mimecast-MFC-AGG-ID: BjaaX0OQObaGAQEeF3hzHA_1756365861
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7fae3dffdd5so28023085a.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756365861; x=1756970661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIR1zw390cgYTtX2NX433kPJFGlwKkihK2GJLW5eSFY=;
        b=dhIizWBogKKKe4RGfANrea0UM1bgfMJjHrGlYIhKoQKkgJVkhbTpPzzB/kqZXZkd/A
         tLW+1CCP0cKS+uqYyKEj1qDN2013khHXnBCjVMWpYa8xsGQbiAPpaRvLyTqhzF5eyjeg
         zZTSO77nVOGAv2T7hBcAFmP3cIx9Q7WvEKIKeeiYEh/Qi9T/W6uIiZzqOY8DZYN96JOB
         FibgSPawle3oqwWyKJx/Nf0vbfUrSSKQ31i0Zzpic2dUYYK6RPjb2FMQSh+mNhuqL/JT
         4v3BoyHI43s8NBZBAOxUVBEUpHMjMQNI5i0p/I8JuO+RQPpLau0eNwMYCjwG9mNdYVVr
         eGQg==
X-Gm-Message-State: AOJu0YxETcLYX1iBZEGckjzNpJ5EqDGSBr/2gtO3SETak+2pEJ5BV6Ut
	5H8f5+SJgOkXAiQCEK2+b98eZIHYGVUQ6uY8t04Zt2IZc2X5gc2T9ySWoKyE5Q1u4EPf4YTltJL
	MvgED9TSoA1tepCnfmdlEJh11wEvDfDkq+ndwrZG55t054hh0Ke8WqtrvQA==
X-Gm-Gg: ASbGncsXfax6sQ5ib3zP+0KfTdoNB+K1SMaW7mt5qvFNq1tSqCVF4P4LIuTTWcQ3bT4
	g/CPAlX9LnGRfcm5YwfJEbgEy6/MxA0/1bKzLLB2T+z30IgKS5wi1+UumkjjqT9jBWSU99ehYXN
	LhjCunnmnR9N4+2AFkcN56SnGMYYOWYf92QRW9N9ChaCP88Rc15V3cT5iFvGRHk0xQamQNa4DM8
	h7jVMduNwEBmuzTLNDVfffVFs6wAPyJWKKYZH6QWpBA6lJI8zhXcYleYzdssnXvjLLT4MexXnHs
	KHIxhEC1JxL0bIlua5UnZqZOW75hC7cR1elyP+xbb4CU0OPyvjyF+exkm7YDR7VdVaiE6u6rkAT
	brdPC48LXrO4=
X-Received: by 2002:a05:620a:319c:b0:7e8:7eee:7d66 with SMTP id af79cd13be357-7ea1106939bmr2934884485a.40.1756365860738;
        Thu, 28 Aug 2025 00:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp1cXuDbg+76UtB0I0QKS7x0PTyew3GjzbR0Qln5uscmVCmSfUeQdLjlZYLQmSpwwnsixrew==
X-Received: by 2002:a05:620a:319c:b0:7e8:7eee:7d66 with SMTP id af79cd13be357-7ea1106939bmr2934883385a.40.1756365860375;
        Thu, 28 Aug 2025 00:24:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b306eb3110sm335911cf.7.2025.08.28.00.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 00:24:19 -0700 (PDT)
Message-ID: <646c6431-274f-4923-ab9d-bf0116645745@redhat.com>
Date: Thu, 28 Aug 2025 09:24:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] microchip: lan865x: add ndo_eth_ioctl handler to
 enable PHY ioctl support
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822085014.28281-1-parthiban.veerasooran@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250822085014.28281-1-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 10:50 AM, Parthiban Veerasooran wrote:
> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> index 84c41f193561..7f586f9558ff 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -320,12 +320,22 @@ static int lan865x_net_open(struct net_device *netdev)
>  	return 0;
>  }
>  
> +static int lan865x_eth_ioctl(struct net_device *netdev, struct ifreq *rq,
> +			     int cmd)
> +{
> +	if (!netif_running(netdev))
> +		return -EINVAL;
> +
> +	return phy_mii_ioctl(netdev->phydev, rq, cmd);
> +}
> +
>  static const struct net_device_ops lan865x_netdev_ops = {
>  	.ndo_open		= lan865x_net_open,
>  	.ndo_stop		= lan865x_net_close,
>  	.ndo_start_xmit		= lan865x_send_packet,
>  	.ndo_set_rx_mode	= lan865x_set_multicast_list,
>  	.ndo_set_mac_address	= lan865x_set_mac_address,
> +	.ndo_eth_ioctl          = lan865x_eth_ioctl,

It looks like you could use directly phy_do_ioctl_running() and avoid
some code duplication.

/P


