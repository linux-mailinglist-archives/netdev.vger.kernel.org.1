Return-Path: <netdev+bounces-173938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F12A5C4C8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF27E7AB90C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D9725E83B;
	Tue, 11 Mar 2025 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKzWgS0P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502C25EFA5
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705575; cv=none; b=LKQncO8e/Qr1fmhirOFQtsD3C0PxLcmdgOJFZdqx0fm1ZvHrQXnu8sT2CIXQdsUxf4LRJR6ZG0UrqfAsJE3EdohNLTiXl9UewhTsBK6QdATzpkxCVbysgUX29GPfxd+ZroD5oMfjBPiHqskZeNHaz47bKTXbCGgBOndtub855zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705575; c=relaxed/simple;
	bh=MrSARWYowUlqxQNAfZb8zvNKral/fR5mNXrI8qUG+zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URUzaMK8+U611zwdcMwy9xHl/b9XI2VfBvmVq0/YAJT11fo37KUFMqk5USWHoZObo5bxNShTlqWJCdhku7AdJuCpO1TtWt3JiT7HlJYpEIysSIj3jVb/lMSiPOI7XIm0L/sa00b9FhrNwbZRhkH8ObMwbmXYKmdlfZGf6v+sjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKzWgS0P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBOsng8EBCgkOAM3Vciw5jQTda8DWvz8kQYjd7HB9wM=;
	b=GKzWgS0Pk+yINTPnN1V4FajLHZiPmDSQMSijQMZ2OC825cpEgh5/cfGH0EVL9SCmwh+tV/
	vGciV3Q4e7KeOTl9/tHcywlqNONd4hcu6io6cS+lqb7IRwyuXceuuNY/FDQ+EwjPNbLXgD
	19HvM5crw8po66GvSJqOgqZpPH+mUGE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-ucf5DwZuMreRhV7VltPp0A-1; Tue, 11 Mar 2025 11:06:11 -0400
X-MC-Unique: ucf5DwZuMreRhV7VltPp0A-1
X-Mimecast-MFC-AGG-ID: ucf5DwZuMreRhV7VltPp0A_1741705570
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912539665cso3037263f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705570; x=1742310370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBOsng8EBCgkOAM3Vciw5jQTda8DWvz8kQYjd7HB9wM=;
        b=D/XXyHJ2U4X6+MnoCcetE5A2loMuDx9yTU/de5a5yJdoWKRIHfDSp2nbfo6rLyj/0l
         UTd82XAnqvGk6nm8NXaOsPm70IuyDDk0JkoBvWB6s0ji6pon/nECbPmhG0yOQASPTovm
         9/+RxzMle16USlVCGuabCuZjeEElegnzZZHbSrLs/YYUa/JtzFowkLlx1eG8UHFS3kqK
         wyY3HZz2YK/w/HMSvNo02M445oRGU25LL4qyaZy9XxDDD/0mTQ5SDjXwwG//YY+5mOcq
         aoRjgiRFXVa3svOyk1hFvnSayx9VQ63uAEg54L57S+PRIUGL5eH19jNr0aJG/Hj9jkGv
         d15A==
X-Forwarded-Encrypted: i=1; AJvYcCU/qwReRMJXg9BmLptRV2x3IE05Oz9LRvA1djWN/Kc3TebTH3dcr5tSykZYLQKKwRb11T2jmKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI1vqzEBglDzjvqLp/cbjGIC7pfsm3Ff6CxNdFp6I+48S2frRX
	/yXlR+DfLXUp9q3mPRJuR1EVRnhEhzqlMwJoaHie3jGhFZxRJPbgfDfwwRdaUJ0qAyMFLDPAZ3Q
	5rzyGaIPcwBWr5LEirRFfin0NfzyS/uRhxOAMfsujRqrqgdb2PAuJ05ljV0HM8A==
X-Gm-Gg: ASbGncvkdQt5bv+sWbmJQGhcj/l8NGWpNKBoKQnZdsOKz3UcLQHhgL/hM24fQKSxq4O
	EhEoiHuZeui2G/9EMl6W2cwu77/XlH0jRXH+6+gOQABBQWEIGk40DtPwtqrnyighqyDsE+dl5KX
	fdiXWmP3pS1uKqBc8xgj9/9LeQaVw8JC3tKyBxcochQ/V428tPbI/+Xb0vMm4zsxNJV+0QN8Xhl
	UtPzIArFeqj/QLsyjE8JOpEQj+qExjEHspFK5PtRkAATTVAO4dG001bFwvYB0bjipl8KBy5ENm+
	ac/+T3gQqsgFF77QEavOF/2yckiVzYleiOfRgq101uiRlw==
X-Received: by 2002:a05:6000:1fa6:b0:390:ec6e:43ea with SMTP id ffacd0b85a97d-3926c97ae30mr5053825f8f.15.1741705569904;
        Tue, 11 Mar 2025 08:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE3LPY7V+G9pbEb2Drb4dFlpLdtSRacBovR2XotQNM4FSMIHLrLMAX1EnBRCJLVAUO3sXMQg==
X-Received: by 2002:a05:6000:1fa6:b0:390:ec6e:43ea with SMTP id ffacd0b85a97d-3926c97ae30mr5053770f8f.15.1741705569493;
        Tue, 11 Mar 2025 08:06:09 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba83csm18130478f8f.6.2025.03.11.08.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:06:09 -0700 (PDT)
Message-ID: <aff86ba3-6a74-4cca-9fda-ce5026948080@redhat.com>
Date: Tue, 11 Mar 2025 16:06:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 09/14] xsc: Init net device
To: Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org
Cc: leon@kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
 przemyslaw.kitszel@intel.com, weihg@yunsilicon.com, wanry@yunsilicon.com,
 jacky@yunsilicon.com, horms@kernel.org, parthiban.veerasooran@microchip.com,
 masahiroy@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 geert+renesas@glider.be
References: <20250307100824.555320-1-tianx@yunsilicon.com>
 <20250307100845.555320-10-tianx@yunsilicon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250307100845.555320-10-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 11:08 AM, Xin Tian wrote:
> +static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +
> +	/* Set up network device as normal. */
> +	netdev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
> +	netdev->netdev_ops = &xsc_netdev_ops;
> +
> +	netdev->min_mtu = SW_MIN_MTU;
> +	netdev->max_mtu = SW_MAX_MTU;
> +	/*mtu - macheaderlen - ipheaderlen should be aligned in 8B*/
> +	netdev->mtu = SW_DEFAULT_MTU;
> +
> +	netdev->vlan_features |= NETIF_F_SG;
> +	netdev->vlan_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
> +	netdev->vlan_features |= NETIF_F_GRO;
> +	netdev->vlan_features |= NETIF_F_TSO;
> +	netdev->vlan_features |= NETIF_F_TSO6;
> +
> +	netdev->vlan_features |= NETIF_F_RXCSUM;
> +	netdev->vlan_features |= NETIF_F_RXHASH;
> +	netdev->vlan_features |= NETIF_F_GSO_PARTIAL;

You must additionallys set `gso_partial_features` to some non zero value
to make the above statement meaningful.

Thanks,

Paolo


