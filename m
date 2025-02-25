Return-Path: <netdev+bounces-169353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C497A4390B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE60B3B2B46
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732E266577;
	Tue, 25 Feb 2025 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RZU30Skk"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D325C6EA
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474384; cv=none; b=AN8OtEGApaf60AEH9TlSyvhmx07BdXTa7w6cJydlIu+dDQ42m0i+BgnCVogYl/OI44AZv29t+Kc3x8ljNz5UH7KmuFUtQv0hofY8/JhxLWce3K6hHqZ294SYpjG2jkKiYTVaxIoysQ+jvYN0Wut2tzIvHbxJmlPYLiG5D8oivSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474384; c=relaxed/simple;
	bh=ox+Zccyizc77wujMxUpnfK7HMNZIB9RLj2gYBoEYimw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP+W+ofJevpPjRbzG2owGC/3xfipuxsYJUBt3iawOryqXbUwUQIZmgDQtHcHLQ6j8Lp6pOhrHRIkqbC+ovxNCI6v80k1BmyOJ7TRWbM9Ueh4+NuDJrz+JmLJ48qhIVgQKScqN4tpWRSohuLY0dKOWR+yj1pBndFmKMsGn/Va+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RZU30Skk; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <437d4fad-6cd4-4f90-a1bb-07193d015cad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740474378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lV30hEBZWC7S4rSDYnKgsoznUoPxWCDHm7ubHwj+3ww=;
	b=RZU30SkkWMDPf0R4W8ZcMdFVMAMhESLDuqfrOaBfZ2FhTz1FNYwNnhjHcyhSE7ivfaLIMv
	GAaE7ySpqQEbYPn6gyP79F+9JJPtUwG1C/mOK6wHF9a18rdSVPQLeMNpU2+mwVzZm1RCuD
	KhxroJ3p9YDVD3jJd4qYotSalUSgK+k=
Date: Tue, 25 Feb 2025 17:06:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 2/4] stmmac: loongson: Remove surplus loop
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
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250224135321.36603-2-phasta@kernel.org>
 <20250224135321.36603-4-phasta@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250224135321.36603-4-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/24/25 9:53 PM, Philipp Stanner 写道:
> loongson_dwmac_probe() contains a loop which doesn't have an effect,
> because it tries to call pcim_iomap_regions() with the same parameters
> several times. The break statement at the loop's end furthermore ensures
> that the loop only runs once anyways.
>
> Remove the surplus loop.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

It seems that the fix-tag has been forgotten, next two patches as well.


Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng

> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 73a6715a93e6..e3cacd085b3f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -554,14 +554,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>   	pci_set_master(pdev);
>   
>   	/* Get the base address of device */
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
> -		if (ret)
> -			goto err_disable_device;
> -		break;
> -	}
> +	ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
> +	if (ret)
> +		goto err_disable_device;
>   
>   	memset(&res, 0, sizeof(res));
>   	res.addr = pcim_iomap_table(pdev)[0];

