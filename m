Return-Path: <netdev+bounces-68895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3EC848C38
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 09:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06020283F4A
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4B11712;
	Sun,  4 Feb 2024 08:45:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3609214282
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036321; cv=none; b=ivGsfu2rzXt4p4WbnRp9C0ynICYi4cvO0y49DtmbFk5Cgn23DlEM32iA/Qc/YKuCj4WLBUFe95iwpW+8+B9jlLT8pW/SMYlZZnqPHeKpE5QTSl3ALP9h0b+VBUkYNFUmORyrAd6d7m+s77PjWkL2BbTobURmJcrYomppiqJPNYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036321; c=relaxed/simple;
	bh=TJ7me4UEeJF6ltmE7yJHvpNai0aRFFXwsR7ws693GV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHhXHGECB0Ry3Dwz7I+wbQDStYKcyDGC6Ij5pKdhAlBkEfpzHCrUX4yFepsI35nhCQqS//zuW/P5a6BvKTh41boaES+LKy5M97Lf0zGsYhH8gUIRWAs7KKuNZ9V0we25zRnPzFI7XPpBiZ3qEys3MkXTwnEac9g+dF7NySqeM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.18])
	by gateway (Coremail) with SMTP id _____8CxrutOTr9lDowKAA--.29954S3;
	Sun, 04 Feb 2024 16:43:58 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.18])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc9KTr9lfEUvAA--.47874S3;
	Sun, 04 Feb 2024 16:43:55 +0800 (CST)
Message-ID: <b5c1111b-6f09-4194-a04c-b52dfc39c26b@loongson.cn>
Date: Sun, 4 Feb 2024 16:43:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 01/11] net: stmmac: Add multi-channel support
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <a2f467fd7e3cecc7dc4cc0bfd2968f371cd40888.1706601050.git.siyanteng@loongson.cn>
 <20240202123034.GO530335@kernel.org>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240202123034.GO530335@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxDc9KTr9lfEUvAA--.47874S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArWUWF4kWw43uF43Jw1kWFX_yoW8CF4xpr
	WxAayYqF4kK3WUGan2yw1fXry5ta98trW293y8Jw4fWF9xCasrtrsIyF45C3ZrJr4fXF12
	vw45Zw1fZFn5tFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2024/2/2 20:30, Simon Horman 写道:
> On Tue, Jan 30, 2024 at 04:43:21PM +0800, Yanteng Si wrote:
>> DW GMAC v3.x multi-channels feature is implemented as multiple
>> sets of the same CSRs. Here is only preliminary support, it will
>> be useful for the driver further evolution and for the users
>> having multi-channel DWGMAC v3.x devices.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ...
>
>> @@ -116,7 +118,7 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
>>   				  dma_addr_t dma_rx_phy, u32 chan)
>>   {
>>   	/* RX descriptor base address list must be written into DMA CSR3 */
>> -	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
>> +	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_CHAN_RCV_BASE_ADDR(chan));
> nit: Networking code (still) prefers code to be 80 columns wide or less.
>
>
> Please consider running checkpatch as it is run by the CI.
>
> https://github.com/linux-netdev/nipa/blob/main/tests/patch/checkpatch/checkpatch.sh
OK!
>
>>   }
>>   
>>   static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
>
> ...
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> index 72672391675f..593be79c46e1 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> @@ -148,11 +148,14 @@
>>   					 DMA_STATUS_TI | \
>>   					 DMA_STATUS_MSK_COMMON)
>>   
>> +/* Following DMA defines are chanels oriented */
> nit: channels
>
> FWIIW, checkpatch also has a --codespell option which can be used to flag
> spelling errors.

Sorry, I forgot to change it. This typo has already been commented in v7.


Thanks,

Yanteng


>
> ...


