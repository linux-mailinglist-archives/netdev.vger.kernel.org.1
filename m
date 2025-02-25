Return-Path: <netdev+bounces-169350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4B6A438C2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94006188FA1B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43892661B5;
	Tue, 25 Feb 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B6wq9Mq3"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB76266190
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474055; cv=none; b=rzmduwYpTEHDWCy61UzmJIX2HM68MozZUJNcWK9ZGJRS9KME0V1cfgdZHW++4uAqq0B+3AX4/BG2Ko4pWpKNfJlORlRMaZD32WBpHFqmal0h6IK/cGR2+AaGn/7BN+safSXI2pooUeiNW2C2F8svhwVB/tm7fUvT9o6XmGxqQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474055; c=relaxed/simple;
	bh=PJqWQ/02kk6J61XSsGKz1EvoWTK5P+BFQ4HcbBAmqcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzatIRAXsGehP72UH/CvjpFKCzix2pU3CQ4a3xqSzBRYumqCpZr0ha28W2kEFody4nlK52mZP+vPB2rFJkZaB/fis/DYXlc2Fztw3EE77jjl87x+Ipv108gn0JFHhKJsOQBBSATM1IjhI14Gdb+JpIRFSBmDTYbmbyv1CH9nSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B6wq9Mq3; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9cf9c128-9f66-488c-bd43-3f1752ec4eaa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740474041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyvddXJudmim1yoVeF2sZBvah7MinIT5ZBHD+XI91UM=;
	b=B6wq9Mq3uylr8OfT/MoCcqJNqcVngx4TPD6UK0+RB4M0sFWDXL91l5ukvrfU6ywvlsS3ml
	4qvMg0EmJFYFbI40yubALIDts/0glf0WXptuRXkY5cLq9ITuCrPkKo6uc9rNTFW00PilKj
	b0A+ABQ+npLY2eBgHx6CdEK+gsDCmcw=
Date: Tue, 25 Feb 2025 17:00:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/4] stmmac: loongson: Pass correct arg to PCI
 function
To: Philipp Stanner <phasta@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yinggang Gu <guyinggang@loongson.cn>,
 Feiyang Chen <chenfeiyang@loongson.cn>, Philipp Stanner
 <pstanner@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250224135321.36603-2-phasta@kernel.org>
 <20250224135321.36603-3-phasta@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250224135321.36603-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/24/25 9:53 PM, Philipp Stanner 写道:
> pcim_iomap_regions() should receive the driver's name as its third
> parameter, not the PCI device's name.
>
> Define the driver name with a macro and use it at the appropriate
> places, including pcim_iomap_regions().
>
> Cc: stable@vger.kernel.org # v5.14+
> Fixes: 30bba69d7db4 ("stmmac: pci: Add dwmac support for Loongson")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,

Yanteng

> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index bfe6e2d631bd..73a6715a93e6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -11,6 +11,8 @@
>   #include "dwmac_dma.h"
>   #include "dwmac1000.h"
>   
> +#define DRIVER_NAME "dwmac-loongson-pci"
> +
>   /* Normal Loongson Tx Summary */
>   #define DMA_INTR_ENA_NIE_TX_LOONGSON	0x00040000
>   /* Normal Loongson Rx Summary */
> @@ -555,7 +557,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>   	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>   		if (pci_resource_len(pdev, i) == 0)
>   			continue;
> -		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> +		ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
>   		if (ret)
>   			goto err_disable_device;
>   		break;
> @@ -673,7 +675,7 @@ static const struct pci_device_id loongson_dwmac_id_table[] = {
>   MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
>   
>   static struct pci_driver loongson_dwmac_driver = {
> -	.name = "dwmac-loongson-pci",
> +	.name = DRIVER_NAME,
>   	.id_table = loongson_dwmac_id_table,
>   	.probe = loongson_dwmac_probe,
>   	.remove = loongson_dwmac_remove,

