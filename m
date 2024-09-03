Return-Path: <netdev+bounces-124512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B4969CA2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929741C239EF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067F21B9857;
	Tue,  3 Sep 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTinp3ZV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554401C7686
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364762; cv=none; b=h3iY/7fzuuihXC3lckn+oDr3dGnpBR1M8AvxBiAnvYaS+ZZYiU+kD97mSdByZWFMaALodoLq7eG1CJ36NSUGngFXB1kdAPxn/p6NN0hJPRCJ+0YqvRCUrxDDIBOUmNNtAy0uNft9TSbIYNqDkXVgysv4F2DCxGatdSZG0YcIZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364762; c=relaxed/simple;
	bh=9an5SNRHHUgCW2mocC01A8ucW7OL3399L2FiMAVZGFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGZpDQkw5jduAxD729ME5NGmrvXfSNri0JvLsweC7ioJvY7b/KBVwOC4Rnoclbn/GVGXrV5D2kU6Ac7fzo/+pEIc7kAGeWzw4jXMwd1W+NCna42Q3+uR4kcqGTN4mBDRlG5y3XF9hjW8PtRSkxbiEdG8dLkDKW5xFx0bsG2OPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTinp3ZV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725364760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW+oWF8uHdYs0IDc0sGYHwMXdGVR/s8ug84wPArmDAE=;
	b=gTinp3ZVx7hhLDlnAWgWWFOfQxrRhQ4ErB3mU8YC1S0aQwD5XSgdImpKm6ipaTc46Ldh/M
	aoZ8C7g99tYMDib7zBJRGxymd77ZhlYvuXFplge0BWsbNggVcUNLBZERB3UVe88pOLFlvP
	fhDwJylrwBZhIKDKpFfG0kY1tDx+YyA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-qde0rqaWMHCWYQE6MJ1D4Q-1; Tue, 03 Sep 2024 07:59:19 -0400
X-MC-Unique: qde0rqaWMHCWYQE6MJ1D4Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374bacd5cccso2499867f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 04:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725364758; x=1725969558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eW+oWF8uHdYs0IDc0sGYHwMXdGVR/s8ug84wPArmDAE=;
        b=bJQPQccW1c3fzIGEKDmERPVb9zvq6GPcmFyNz5RafdVhdM0dCUpPflXwI75QOKyFZ8
         taUV21Loi3+TGEh8FovqlpBlt5l1dUw0u6vRQmdtpq7Y7GS4Xs9LFgFBYUNWOXhuLwmA
         4/VC9PfGJ60S9vg0ytcGlrmeYTdlenUHl51MBVXpoyw6ypUa42l3KX3K7zfbsXkhu2c6
         BqlR3StF/Y5yzOOcSq7NPdtm7PVfQQnSU2kU1Iu5+EJBTgc4HPb1sKzm1M5VJP2GSC92
         gI/9ApxUaNbALUVUNBVzEgwoF5dtY1Udfuv6YUyX7SQ9KJXGitJ5v8C6osuXohXTQK81
         UQOw==
X-Forwarded-Encrypted: i=1; AJvYcCWSZTbgVPsxTWNiT3hQPyI59sAACXWlL3vV/XpLn2jFjh6+g2DopC4rE8xQ1JYAiUbjjoK4cW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyPseKwt3ab5MX7nc1YKtjw4ZO23ApufrGbIdTt8TqPSYCaUM
	8+HNCbxpWQlV+QwH5dxHlA9H0ULB30FNSbsvS1VjsnNC9e0EZVcUk/p3rqdb5svR25JDVAtEST2
	6zJk/w+rjv6s+Vk0G8/kgvHRjcL3b+gniCkdaImkBbLjdX427gwjlFA==
X-Received: by 2002:adf:eb8d:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-374a9565a7bmr8232171f8f.17.1725364757757;
        Tue, 03 Sep 2024 04:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErj+70bDHnbAELAam4llo41z/vLKYkI6hm7wHpiadIT4BVcszal3LrlvsIb+49NfmX0fZ6bw==
X-Received: by 2002:adf:eb8d:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-374a9565a7bmr8232145f8f.17.1725364757224;
        Tue, 03 Sep 2024 04:59:17 -0700 (PDT)
Received: from [192.168.88.27] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df100csm168343265e9.20.2024.09.03.04.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 04:59:16 -0700 (PDT)
Message-ID: <0ff20687-74de-4e63-90f4-57cf06795990@redhat.com>
Date: Tue, 3 Sep 2024 13:59:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-4-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240830121604.2250904-4-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 14:15, Jijie Shao wrote:
[...]
> +static int hbg_mdio_wait_ready(struct hbg_mac *mac)
> +{
> +#define HBG_MDIO_OP_TIMEOUT_US		(1 * 1000 * 1000)
> +#define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)

Minor nit: I find the define inside the function body less readable than 
placing them just before the function itself.

> +
> +	struct hbg_priv *priv = HBG_MAC_GET_PRIV(mac);
> +	u32 cmd;
> +
> +	return readl_poll_timeout(priv->io_base + HBG_REG_MDIO_COMMAND_ADDR, cmd,
> +				  !FIELD_GET(HBG_REG_MDIO_COMMAND_START_B, cmd),
> +				  HBG_MDIO_OP_INTERVAL_US,
> +				  HBG_MDIO_OP_TIMEOUT_US);
> +}

[...]> +static void hbg_phy_adjust_link(struct net_device *netdev)
> +{
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +	struct phy_device *phydev = priv->mac.phydev;

Minor nit: please respect the reverse x-mas tree order

Thanks,

Paolo


