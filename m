Return-Path: <netdev+bounces-213014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED798B22D6E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D0F3A5A42
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9802F83D8;
	Tue, 12 Aug 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CiHLg19D"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB5F2D3EDA;
	Tue, 12 Aug 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015640; cv=none; b=VYykaMQE6ejXLgbZB09c13x787ciqg9BoW+HmVISyPJcAiZ49WT5qYqndHbsJ2dOE4xHNEqABuuK964pfGtM4un5nDga4ewjSqfiuccHzZnS8fF6UPWdVVewDZE0/InEJ0pJD+xer1Tkmfi0/dy/4wYhfe+2JXvwWQ6ZNtadShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015640; c=relaxed/simple;
	bh=a8RsEM5cYmkWvV76N8Mj/XRaSPQJUNkXMG3yEYXHLiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YfWD2sXFapYD5ECrCsaFF0UoRHMc3jqD5GfpznXcONi/TsHcXcwUFUH/a+eAR2oZPXoa0MuCcibzRyGQn3nggYe1Av75GSIGO0cDYttAaJzNp9vlhUfbReqablrl4IDjB9/Z88Qt1uk72k6GoFEmlwkUd5jovVwJ0KMlNjBJXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CiHLg19D; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CGIGHF1445231;
	Tue, 12 Aug 2025 11:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755015496;
	bh=02Re7MIJiL2qY0CtMd4OubyD1VsXaz8WSJJYPw6D+DE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CiHLg19D3DRIAS8i64paLqBHwkFyq2fK6l5AhOiJOD+Xu+oSXv2KFllWDaTIcnGCY
	 NOK4EWqjprN1qS6ePFrcfzPpmP+NDIPBI/kJOKOeNo8lrZGiJV9wSQvbO2hLS8jbGQ
	 6nJH7VWSlWpSwr9mK3KaKWM/F8+ju123rp1G6rlo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CGIFdM348340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 12 Aug 2025 11:18:15 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 11:18:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 11:18:14 -0500
Received: from [10.249.130.61] ([10.249.130.61])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CGI8oB929076;
	Tue, 12 Aug 2025 11:18:08 -0500
Message-ID: <5528c38b-0405-4d3b-924a-2bed769f314d@ti.com>
Date: Tue, 12 Aug 2025 21:48:07 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] net: rnpgbe: Add build support for rnpgbe
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <danishanwar@ti.com>, <lee@trager.us>, <gongfan1@huawei.com>,
        <lorenzo@kernel.org>, <geert+renesas@glider.be>,
        <Parthiban.Veerasooran@microchip.com>, <lukas.bulwahn@redhat.com>,
        <alexanderduyck@fb.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-2-dong100@mucse.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20250812093937.882045-2-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 8/12/2025 3:09 PM, Dong Yibo wrote:
> Add build options and doc for mucse.
> Initialize pci device access for MUCSE devices.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  .../device_drivers/ethernet/index.rst         |   1 +
>  .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +++
>  MAINTAINERS                                   |   8 +
>  drivers/net/ethernet/Kconfig                  |   1 +
>  drivers/net/ethernet/Makefile                 |   1 +
>  drivers/net/ethernet/mucse/Kconfig            |  34 ++++
>  drivers/net/ethernet/mucse/Makefile           |   7 +
>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   8 +
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 +++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 161 ++++++++++++++++++
>  10 files changed, 267 insertions(+)
>  create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
>  create mode 100644 drivers/net/ethernet/mucse/Kconfig
>  create mode 100644 drivers/net/ethernet/mucse/Makefile
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> + **/
> +static int __init rnpgbe_init_module(void)
> +{
> +	int ret;
> +
> +	ret = pci_register_driver(&rnpgbe_driver);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

Unnecessary code - can be simplified to just `return
pci_register_driver(&rnpgbe_driver);`

> +
> +module_init(rnpgbe_init_module);
> +
> +/**
> + * rnpgbe_exit_module - Driver remove routine
> + *
> + * rnpgbe_exit_module is called when driver is removed
> + **/
> +static void __exit rnpgbe_exit_module(void)
> +{
> +	pci_unregister_driver(&rnpgbe_driver);
> +}
> +
> +module_exit(rnpgbe_exit_module);
> +
> +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
> +MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
> +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
> +MODULE_LICENSE("GPL");

-- 
Thanks and Regards,
Md Danish Anwar


