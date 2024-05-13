Return-Path: <netdev+bounces-95952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A63B8C3E5B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF265B20A59
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD96148826;
	Mon, 13 May 2024 09:49:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B48148311
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593757; cv=none; b=shdCQ2cGgpZhJ1/cF0NkGJUML4cvg/DkWe+iuseOVFk6rlRPS/mBRrB3leSnKqZpYBnmv9/DtQGffELbDUrjEIHB3pvza8vHq6EtmRWappy3qHos4kgsUpyRCgPzU0HPLK+m9L+18scLDZLhXv1+kPyBMCglGSs4g8uHnzxjoUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593757; c=relaxed/simple;
	bh=IrHMZ9hxJ8BGwsPzD9flLDC3qL+MXtQdkLuucWRZl+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwgnnIiURa2xqhRDQP+D/y2HCLp+qUy9NxKxSlZGZqJDJAuo2E94Z80D70VO1H8ebaLvx+BoKYyDC3QNTk6T+9kmX1oWTWAmnzwtJH2FcHCeBpXw6eqwMMaIvsLaQUW4U1AaLuIJ/ygEF7azpHB/oSgZOhhZ1qvP2ETXyFV/Vt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8AxY+oZ4kFm8CAMAA--.17560S3;
	Mon, 13 May 2024 17:49:13 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxLN4W4kFmL8scAA--.51565S3;
	Mon, 13 May 2024 17:49:11 +0800 (CST)
Message-ID: <f2ade097-5f4c-4de6-a7f2-9f3d026f95e7@loongson.cn>
Date: Mon, 13 May 2024 17:49:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 02/15] net: stmmac: Add multi-channel support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <5409facf916c0123e39a913c8342cc0ce8ed93db.1714046812.git.siyanteng@loongson.cn>
 <zbs5vkzyuoyte5mr2pprf7xxahhuxlinvxe24h4oc6jeshwii5@ivqr45z27ef4>
 <33ee7998-df36-492c-9507-a08c3a6dad9b@loongson.cn>
 <o7l4klg25pjx3glv7wg65l24uxe4tjdhz3cwd7dxegt46ytxfr@o7ofnqdovgsp>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <o7l4klg25pjx3glv7wg65l24uxe4tjdhz3cwd7dxegt46ytxfr@o7ofnqdovgsp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxLN4W4kFmL8scAA--.51565S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3XF13tr18Zr48Ar18tryruFX_yoW7Zr1kpr
	Z7AayktF95JFn3J3Wktw4DXFyrtr15tw1UZrs5Ga47CanF9ryaqrWYgayY9FyUCr4xCr42
	qr4UJrnruF1DAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=


在 2024/5/13 17:45, Serge Semin 写道:
> On Fri, May 10, 2024 at 06:13:40PM +0800, Yanteng Si wrote:
>> Hi Serge
>>
>> 在 2024/5/3 06:02, Serge Semin 写道:
>>> On Thu, Apr 25, 2024 at 09:01:55PM +0800, Yanteng Si wrote:
>>>> DW GMAC v3.x multi-channels feature is implemented as multiple
>>>> sets of the same CSRs. Here is only preliminary support, it will
>>>> be useful for the driver further evolution and for the users
>>>> having multi-channel DWGMAC v3.x devices.
>>> Why do you call it "preliminary"? AFAICS it's a fully functional
>>> support with no restrictions. Am I wrong?
>>>
>>> I would reformulate the commit message as:
>>>
>>> "DW GMAC v3.73 can be equipped with the Audio Video (AV) feature which
>>> enables transmission of time-sensitive traffic over bridged local area
>>> networks (DWC Ethernet QoS Product). In that case there can be up to two
>>> additional DMA-channels available with no Tx COE support (unless there is
>>> vendor-specific IP-core alterations). Each channel is implemented as a
>>> separate Control and Status register (CSR) for managing the transmit and
>>> receive functions, descriptor handling, and interrupt handling.
>>>
>>> Add the multi-channels DW GMAC controllers support just by making sure the
>>> already implemented DMA-configs are performed on the per-channel basis.
>>>
>>> Note the only currently known instance of the multi-channel DW GMAC
>>> IP-core is the LS2K2000 GNET controller, which has been released with the
>>> vendor-specific feature extension of having eight DMA-channels. The device
>>> support will be added in one of the following up commits."
>> OK.
>>>> @@ -153,7 +155,7 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>>>>    					    void __iomem *ioaddr, int mode,
>>>>    					    u32 channel, int fifosz, u8 qmode)
>>>>    {
>>>> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
>>>> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>>>>    	if (mode == SF_DMA_MODE) {
>>>>    		pr_debug("GMAC: enable RX store and forward mode\n");
>>>> @@ -175,14 +177,14 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>>>>    	/* Configure flow control based on rx fifo size */
>>>>    	csr6 = dwmac1000_configure_fc(csr6, fifosz);
>>>> -	writel(csr6, ioaddr + DMA_CONTROL);
>>>> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
>>>>    }
>>>>    static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
>>>>    					    void __iomem *ioaddr, int mode,
>>>>    					    u32 channel, int fifosz, u8 qmode)
>>>>    {
>>>> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
>>>> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>>>>    	if (mode == SF_DMA_MODE) {
>>>>    		pr_debug("GMAC: enable TX store and forward mode\n");
>>>> @@ -209,7 +211,7 @@ static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
>>>>    			csr6 |= DMA_CONTROL_TTC_256;
>>>>    	}
>>>> -	writel(csr6, ioaddr + DMA_CONTROL);
>>>> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
>>>>    }
>>> Just figured out that besides of the channel-related changes you also need
>>> to have the stmmac_dma_operation_mode() method fixed. So one wouldn't
>>> redistribute the detected Tx/Rx FIFO between the channels. Each DW GMAC
>>> channel has separate FIFO of the same size. The databook explicitly says
>>> about that:
>>>
>>> "The Tx FIFO size of all selected Transmit channels is always same.
>>> Similarly, the Rx FIFO size of all selected Receive channels is same.
>>> These channels cannot be of different sizes."
>>>
>> Should I do this, right?
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 33d04243b4d8..9d4148daee68 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -2371,8 +2371,13 @@ static void stmmac_dma_operation_mode(struct
>> stmmac_priv *priv)
>>                  txfifosz = priv->dma_cap.tx_fifo_size;
>>
>>          /* Adjust for real per queue fifo size */
>> -       rxfifosz /= rx_channels_count;
>> -       txfifosz /= tx_channels_count;
>> +       if ((priv->synopsys_id != DWMAC_CORE_3_40) ||
>> +           (priv->synopsys_id != DWMAC_CORE_3_50) ||
>> +           (priv->synopsys_id != DWMAC_CORE_3_70)) {
>> +               rxfifosz /= rx_channels_count;
>> +               txfifosz /= tx_channels_count;
>> +       }
>> +
>>
>>          if (priv->plat->force_thresh_dma_mode) {
>>                  txmode = tc;
> Seeing the shared FIFO memory is specific for the DW QoS Eth and DW
> xGMAC IP-cores let's use the has_gmac4 and has_xgmac flags instead:
>
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2371,8 +2371,13 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
>   	if (txfifosz == 0)
>   		txfifosz = priv->dma_cap.tx_fifo_size;
>   
> -	/* Adjust for real per queue fifo size */
> -	rxfifosz /= rx_channels_count;
> -	txfifosz /= tx_channels_count;
> +	/* Split up the shared Tx/Rx FIFO memory on DW QoS Eth and DW XGMAC */
> +	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
> +		rxfifosz /= rx_channels_count;
> +		txfifosz /= tx_channels_count;
> +	}
>   
>   	if (priv->plat->force_thresh_dma_mode) {
>   		txmode = tc;

OK.


Thanks,

Yanteng


