Return-Path: <netdev+bounces-149568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2D9E640F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 03:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9594D284686
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA414A4F9;
	Fri,  6 Dec 2024 02:24:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DCF20309
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451896; cv=none; b=Ai2M1NM5nJhl1XmL5XKZZcC5WGaE0TWtzT5IPbmlPBalSpmC40QNtFxJa/NDpeg547r1AGvEQKjEn++bj2PSSm9sXXjuE7GimW8M9Ivg06uFEzpnA5fbtin+RepdCWK11z5SYI3mLzjJBAkhviOCy+iVice77bPXOyUJ0eYupZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451896; c=relaxed/simple;
	bh=ZcZ8ZxNUnrbLdMduJgoj3uWv+kKWhntd+HAILEWm9YQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LVWFeIRlhGBQRvKEatjclX9xAnIOsSvhYKfMS8RD9Qbt12Fzj1WvgUnDpr7YcPzkHCMrJWKTCuxO40JWO/cIok7GBLuS59o5uDE2yPNu9LmPhJBMKBF9CN9saAZ0St51xsd60l+jXTOT2AkafF78pMcpQlRaoHkT0fJu/LjLEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y4FQb60XFz2Dh81;
	Fri,  6 Dec 2024 10:22:31 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C5C7C140136;
	Fri,  6 Dec 2024 10:24:50 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Dec 2024 10:24:50 +0800
Message-ID: <b9db6fe7-6d0c-4f05-96c5-242112e4fc2a@huawei.com>
Date: Fri, 6 Dec 2024 10:24:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH RFC net] net: hibmcge: Release irq resources on error and
 device tear-down
To: Simon Horman <horms@kernel.org>, Jian Shen <shenjian15@huawei.com>, Salil
 Mehta <salil.mehta@huawei.com>
References: <20241205-hibmcge-free-irq-v1-1-f5103d8d9858@kernel.org>
 <20241205205511.GF2581@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241205205511.GF2581@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/6 4:55, Simon Horman wrote:
> On Thu, Dec 05, 2024 at 05:05:23PM +0000, Simon Horman wrote:
>> This patch addresses two problems related to leaked resources allocated
>> by hbg_irq_init().
>>
>> 1. On error release allocated resources
>> 2. Otherwise, release the allocated irq vector on device tear-down
>>     by setting-up a devres to do so.
>>
>> Found by inspection.
>> Compile tested only.
>>
>> Fixes: 4d089035fa19 ("net: hibmcge: Add interrupt supported in this module")
>> Signed-off-by: Simon Horman <horms@kernel.org>
> Sorry for the noise, but on reflection I realise that the devm_free_irq()
> portion of my patch, which is most of it, is not necessary as the
> allocations are made using devm_request_irq().  And the driver seems to
> rely on failure during init resulting in device tear-down, at which point
> devres will take care of freeing the IRQs.
>
> But I don't see where the IRQ vectors are freed, either on error in
> hbg_irq_init or device tear-down. I think the following, somewhat smaller
> patch, would be sufficient to address that.

Thank you for reviewing the code.

But sorry, it's actually not needed.

I discussed this with Jakub and Jonathan:
https://lore.kernel.org/all/383f26a1-aa8f-4fd2-a00a-86abce5942ad@huawei.com/

I also add a comment in code, But I'm sorry, maybe it's a little subtle.
  /* used pcim_enable_device(),  so the vectors become device managed */
  ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
  			     PCI_IRQ_MSI | PCI_IRQ_MSIX);

Thanks,
Jijie Shao

>
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
> index 25dd25f096fe..44294453d0e4 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
> @@ -83,6 +83,11 @@ static irqreturn_t hbg_irq_handle(int irq_num, void *p)
>   static const char *irq_names_map[HBG_VECTOR_NUM] = { "tx", "rx",
>   						     "err", "mdio" };
>   
> +static void hbg_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
>   int hbg_irq_init(struct hbg_priv *priv)
>   {
>   	struct hbg_vector *vectors = &priv->vectors;
> @@ -96,6 +101,13 @@ int hbg_irq_init(struct hbg_priv *priv)
>   	if (ret < 0)
>   		return dev_err_probe(dev, ret, "failed to allocate vectors\n");
>   
> +	ret = devm_add_action_or_reset(dev, hbg_free_irq_vectors, priv->pdev);
> +	if (ret) {
> +		pci_free_irq_vectors(priv->pdev);
> +		return dev_err_probe(dev, ret,
> +				     "failed to add devres to free vectors\n");
> +	}
> +
>   	if (ret != HBG_VECTOR_NUM)
>   		return dev_err_probe(dev, -EINVAL,
>   				     "requested %u MSI, but allocated %d MSI\n",

