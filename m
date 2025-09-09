Return-Path: <netdev+bounces-221269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15F5B4FF7D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E8C7B2912
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD132252E;
	Tue,  9 Sep 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CjTMvVOG"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F9C3D6F;
	Tue,  9 Sep 2025 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428360; cv=none; b=ZSJbw4pPnPW+s2x4NOx0qfZAdS+FUhYpDhTYkML3uIj/qTk0EECoFqG84eI4VhTmgDF/LiBhoneYgJsL/hBChd51igeKTwsNDcHkevV+CZkwoM9RKjtFmqZaNQnlkWClEeh0f2fo+6GOeNcxP26HPR6TO9u/yAxcKegPRy3KSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428360; c=relaxed/simple;
	bh=uEpeLMtA+nt8my0EDQ4Co7+OdONko3/KLIe5wrgdqBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LkJNQIeAR9tEMieF1YOkyl3dbJgeaS4VIMx34YH4/QtOtyx69CzyECFig0ECA/lG82XyaBtw8m9Q5ruhUcZwWEPL5tafMSQ4+ni+j/GjFM2R/OVvQ9HSPmUxlvVGxYbX4TFbs/6z4W+jE8HGULBe3j1ej5mdPwbBfeDfwpaCLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CjTMvVOG; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589EVjYJ356867;
	Tue, 9 Sep 2025 09:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757428305;
	bh=vykbjnLzz8rpOz9CYESVqRDv7BiXG2bRuVLyRjDYwak=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CjTMvVOGPgw0ugbauj/vW5ePOLo5FNRisZUjMHPKmlHLU5nF4vvScIxn4r/ch5zgM
	 7zbBCeGRjORVmzpT8nFtNnwcs5an86ZReIVzCgBrJJc8nTTYW+kQFFDFJP9r1afBvE
	 KLd3bMPXJSpctbegkLg23Q50xYmH+mz2ut+ke2s0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589EViKD424810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 09:31:45 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 09:31:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 09:31:44 -0500
Received: from [10.249.130.74] ([10.249.130.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589EVYIi2475049;
	Tue, 9 Sep 2025 09:31:35 -0500
Message-ID: <548eb7e2-ebde-464e-9467-7086e9448181@ti.com>
Date: Tue, 9 Sep 2025 20:01:33 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 5/5] net: rnpgbe: Add register_netdev
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <danishanwar@ti.com>, <lee@trager.us>, <gongfan1@huawei.com>,
        <lorenzo@kernel.org>, <geert+renesas@glider.be>,
        <Parthiban.Veerasooran@microchip.com>, <lukas.bulwahn@redhat.com>,
        <alexanderduyck@fb.com>, <richardcochran@gmail.com>, <kees@kernel.org>,
        <gustavoars@kernel.org>, <rdunlap@infradead.org>,
        <vadim.fedorenko@linux.dev>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-6-dong100@mucse.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20250909120906.1781444-6-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 9/9/2025 5:39 PM, Dong Yibo wrote:
> Complete the network device (netdev) registration flow for Mucse Gbe
> Ethernet chips, including:
> 1. Hardware state initialization:
>    - Send powerup notification to firmware (via echo_fw_status)
>    - Sync with firmware
>    - Reset hardware
> 2. MAC address handling:
>    - Retrieve permanent MAC from firmware (via mucse_mbx_get_macaddr)
>    - Fallback to random valid MAC (eth_random_addr) if not valid mac
>      from Fw
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---

> +/**
> + * rnpgbe_xmit_frame - Send a skb to driver
> + * @skb: skb structure to be sent
> + * @netdev: network interface device structure
> + *
> + * Return: NETDEV_TX_OK or NETDEV_TX_BUSY
> + **/
> +static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
> +				     struct net_device *netdev)
> +{
> +	dev_kfree_skb_any(skb);
> +	netdev->stats.tx_dropped++;
> +	return NETDEV_TX_OK;
> +}

The function comment says it returns NETDEV_TX_OK or NETDEV_TX_BUSY, but
it only returns NETDEV_TX_OK.


-- 
Thanks and Regards,
Md Danish Anwar


