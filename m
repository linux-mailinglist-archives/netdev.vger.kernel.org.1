Return-Path: <netdev+bounces-204913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18CAFC7EA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D676A1AA30E6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3EF26B09F;
	Tue,  8 Jul 2025 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="freOrkbw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B026B74B
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969226; cv=none; b=FO7woP+9r567vTCptlh7va6nxeV4dheIF35h1+4lXFRnut3t6Yi9uDBexr2ex3blMgdSrUbv+H78i+N3rGCBm5xU3wvd08CGswpdu1BKpaKftrbFUbs3MyhpkjBbbQizmoOiQuP70AFwUjnYK8ahURzB3eUBunDXSjIp8tgtyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969226; c=relaxed/simple;
	bh=fYyHl23C7iOML4Y3XMKrYo2vQEq5oT1hriKpsmH1Ugk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EILeVuHaJ93aVEQC0hax0F0E9gROoQO9QbQcGihVz9/dIcpHR7E3xks0PAbtJlxn/NkB6jn60Pnw0JMTB4PFn4BkupevHv0vn5LkmmcPVEVolYHbnBccMTTzVOoI2DqO33p4xYwId6NXb3FILxlpjIcol1jUkk+t6ebj/AQpkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=freOrkbw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751969223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58D8nthEMttD8EOjkycPcqwbL7GCEdeTDZ0Fg2Jn8PI=;
	b=freOrkbwKv7La195Q1fK8fA6gKnwc7hmLTSnFoiN7nZ1AqkMaxtRB94LwscZf2rjp/4LvJ
	i7Gx8Lc7H1/3pzCo32mK3so58ee9H+K9DfQ51xGrG7ASi2AKafqiRhQfcr/D2VxzRYiXQg
	FrTllqqRRcdWoHCJlqbNEdKPG9bbySY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-tb0Jnk85OemUi6E4DqJvXA-1; Tue, 08 Jul 2025 06:07:02 -0400
X-MC-Unique: tb0Jnk85OemUi6E4DqJvXA-1
X-Mimecast-MFC-AGG-ID: tb0Jnk85OemUi6E4DqJvXA_1751969221
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a503f28b09so2377238f8f.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 03:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969221; x=1752574021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58D8nthEMttD8EOjkycPcqwbL7GCEdeTDZ0Fg2Jn8PI=;
        b=fYdXR9fJ4taW1i/ch+ZpLZkOeK35pYMFS7is+jHu/UMzr52vmKMQXlOK0TC0Sr5Z+K
         SQWj+R17gSGe9NzVJDBvTFYyhpvLA6TdSe4F1wA+JfuSDn2gNKW98PmhHTb6Q+BI9skc
         zgMPpDkrt4xbEK26BPKZqAAuVeXuESljjdW+wMsxZ+wJLgp8xa1qKNo4hTMpulpVuQhA
         5fnuKHHr7eAyFrVO/RxsG/7SlpYMmeCDtEF/z4FW6N9YFmCPepS1PtTpZOV9htAJzLIc
         CJ+sacMEiawq/A8iKIhU9Ds89uJxMz8h46xXWBQnEkaebScK7zg9xHChWAeMg32oqMF+
         LJAg==
X-Forwarded-Encrypted: i=1; AJvYcCXXFkNk3IDHvVw3RucTwN9xBXa/VTGbXCX0NUQfvtFFlLtL5jZfuWF/elIHBEmAaQgY6puERcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwd7RJCP+57B5kQ0UFmJ6CrRJpi2psyrRl3Q6drN2KlRIpQFED
	pfjkj8soLHiThreXgR+6oMzK7kZPE2U9lVazLdNy8uc25uBf/QhxmbNCobhs832GvOfQnNf/S+9
	DGCHPYQbqL4YrVzhKxa1DXEqlVjy3zpGl3RMKdPmD3ysO+qovdZqpZBylKQ==
X-Gm-Gg: ASbGncvXvSvTAUoXwRR1OggxRKlRmZG9IGM+x0trr7RfzCcLStM/HNWgmkf+e6d+MJU
	qZW0XK3j3xqKmF6OyTLFRBypjCkSWLj4cJQHx5IUq0Es3OzNRXCL9E6ldE+or8t8MROH8Z0eOnW
	I3BPGaToBHmmS4cb5JGoyt2UMhssy1ig8ogwPIZqyqLRmN8jJ7OjEaNMbQKuIlMjgG/pHdF9smX
	zZO/faG72ikVvI0asI0Tiy48QPbeA1wawve+EpcOQg2xKnk7Bsu6zd3NYO3qtaJ94X6z0OGMTUP
	vLkJZB527uxlb9wthyOz2KsWRZ0n9KDQmGyp68ntINN2QObCvp65HiTXYK/p2UeLc96ORA==
X-Received: by 2002:a05:6000:2303:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3b5de020c32mr1949620f8f.24.1751969220737;
        Tue, 08 Jul 2025 03:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtcYA73nlyPh3UUGiVwYijbG3S+DSKY5ccoYHAENjNZ6YmMjCSlj1e9xUsxHKnSmrtDCa3pg==
X-Received: by 2002:a05:6000:2303:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3b5de020c32mr1949573f8f.24.1751969220180;
        Tue, 08 Jul 2025 03:07:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd2e7e89sm18221965e9.0.2025.07.08.03.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:06:59 -0700 (PDT)
Message-ID: <b68a06a1-076a-4345-bbb4-7dda1cd73591@redhat.com>
Date: Tue, 8 Jul 2025 12:06:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v14 04/12] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250701114957.2492486-1-lukma@denx.de>
 <20250701114957.2492486-5-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250701114957.2492486-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> +static int mtip_sw_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct mtip_devinfo *dev_info;
> +	struct switch_enet_private *fep;
> +	int ret;
> +
> +	fep = devm_kzalloc(&pdev->dev, sizeof(*fep), GFP_KERNEL);
> +	if (!fep)
> +		return -ENOMEM;
> +
> +	dev_info = of_device_get_match_data(&pdev->dev);
> +	if (dev_info)
> +		fep->quirks = dev_info->quirks;
> +
> +	fep->pdev = pdev;
> +	platform_set_drvdata(pdev, fep);
> +
> +	fep->enet_addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(fep->enet_addr))
> +		return PTR_ERR(fep->enet_addr);
> +
> +	fep->irq = platform_get_irq_byname(pdev, "enet_switch");
> +	if (fep->irq < 0)
> +		return fep->irq;
> +
> +	ret = mtip_parse_of(fep, np);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "OF parse error\n");
> +
> +	/* Create an Ethernet device instance.
> +	 * The switch lookup address memory starts at 0x800FC000
> +	 */
> +	fep->hwp_enet = fep->enet_addr;
> +	fep->hwp = fep->enet_addr + ENET_SWI_PHYS_ADDR_OFFSET;
> +	fep->hwentry = (struct mtip_addr_table __iomem *)
> +		(fep->hwp + MCF_ESW_LOOKUP_MEM_OFFSET);
> +
> +	ret = devm_regulator_get_enable_optional(&pdev->dev, "phy");
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Unable to get and enable 'phy'\n");
> +
> +	fep->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
> +	if (IS_ERR(fep->clk_ipg))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_ipg),
> +				     "Unable to acquire 'ipg' clock\n");
> +
> +	fep->clk_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
> +	if (IS_ERR(fep->clk_ahb))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_ahb),
> +				     "Unable to acquire 'ahb' clock\n");
> +
> +	fep->clk_enet_out = devm_clk_get_optional_enabled(&pdev->dev,
> +							  "enet_out");
> +	if (IS_ERR(fep->clk_enet_out))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_enet_out),
> +				     "Unable to acquire 'enet_out' clock\n");
> +
> +	/* setup MII interface for external switch ports */
> +	mtip_enet_init(fep, 1);
> +	mtip_enet_init(fep, 2);
> +
> +	spin_lock_init(&fep->learn_lock);
> +	spin_lock_init(&fep->hw_lock);
> +	spin_lock_init(&fep->mii_lock);

`mii_lock` is apparently unused in the whole series.

/P


