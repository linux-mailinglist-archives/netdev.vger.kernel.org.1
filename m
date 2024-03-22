Return-Path: <netdev+bounces-81218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D95886A7A
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74655B22975
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32403335B5;
	Fri, 22 Mar 2024 10:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47A20B27
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103787; cv=none; b=fd4O42PGoQmaURFJ81b2P2l/I61RYpMTmN2FpNOlLbYpk9hRCoLnJyuGiFtaFc3ZVxfozkTRw4UzH1ZBC9gx11+stt50R2JMMObN1A9e/z4g1nUp3ccfP4yqJ4W3Ew9bAsLeky7z+IfezzZIzd6MjxrPph4LlvQDYOXTxUm4pAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103787; c=relaxed/simple;
	bh=KKyLD52sMTp3ny2o7pvQh8vk7BFUnV1+/Cq1IOtzYCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdUKwDn22O/86RKNyHDfVO6M85an4r3PCHPg2RH+NzBr5MQjiZhbEtYaMhW0MMdS1HIeJoZSnSXUqlphYoKQlGe74BTfNyYKuUmYszlC1WXYqtRBAc75MTFOGjIrDhL4Jt8AFHPGI8+uvxakTuBR+GapOjoky8nJMTFm7eUG6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8BxuvAlX_1ln20cAA--.2124S3;
	Fri, 22 Mar 2024 18:36:21 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhMkX_1ljvFhAA--.5820S3;
	Fri, 22 Mar 2024 18:36:21 +0800 (CST)
Message-ID: <e57a6501-c9ae-4fed-8b8f-b05f0d50e118@loongson.cn>
Date: Fri, 22 Mar 2024 18:36:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 07/11] net: stmmac: dwmac-loongson: Add
 multi-channel supports for loongson
To: Serge Semin <fancer.lancer@gmail.com>
Cc: hkallweit1@gmail.com, andrew@lunn.ch, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <bec0d6bf78c0dcf4797a148e3509058e46ccdb13.1706601050.git.siyanteng@loongson.cn>
 <eqecwmi3guwda3wloxcttkx2xlteupvrsetb5ro5abupwhxqyu@ypliwpyswy23>
 <e1c7b5fa-f3f8-4aa3-af4d-ca72b54d9c8c@loongson.cn>
 <f9c5c697-6c3f-4cfb-aa60-2031b450a470@loongson.cn>
 <roxfse6rf7ngnopn42f6la2ewzsaonjbrfokqjlumrpkobfvgh@7v7vblqi3mak>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <roxfse6rf7ngnopn42f6la2ewzsaonjbrfokqjlumrpkobfvgh@7v7vblqi3mak>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnhMkX_1ljvFhAA--.5820S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArWfWry8Wry7GF18Ww47KFX_yoW8Kr4DpF
	ZxCF43GrZrJF13uF4qvanrGr1qvrW5ArWxWr1ftw4Dua1qk3srXrnrJa1Y9FZ7CrZ5Ar4U
	u3yvkFZ2gFZ8JagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU

>>>>> +{
>>>>> +	int i, ret, vecs;
>>>>> +
>>>>> +	vecs = roundup_pow_of_two(channel_num * 2 + 1);
>>>>> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
>>>>> +	if (ret < 0) {
>>>>> +		dev_info(&pdev->dev,
>>>>> +			 "MSI enable failed, Fallback to legacy interrupt\n");
>>>>> +		return loongson_dwmac_config_legacy(pdev, plat, res, np);
>>>> In what conditions is this possible? Will the
>>>> loongson_dwmac_config_legacy() method work in that case? Did you test
>>>> it out?
I need to wait for special hardware and PMON for this.  Please give me 
some time.

> Then those platforms will _require_ to have the DT-node specified. This
> will define the DT-bindings which I doubt you imply here. Am I wrong?
>
> Once again have you tested the loongson_dwmac_config_legacy() method
> working in the case of the pci_alloc_irq_vectors() failure?

Yes!  I have tested it, it works in single channel mode.

dmesg:

[    3.935203] mdio_bus stmmac-18:02: attached PHY driver [unbound]
(mii_bus:phy_addr=stmmac-18:02, irq=POLL)
[    3.945625] dwmac-loongson-pci 0000:00:03.1: MSI enable failed, Fallback to
legacy interrupt
[    3.954175] dwmac-loongson-pci 0000:00:03.1: User ID: 0xd1, Synopsys ID: 0x10
[    3.973676] dwmac-loongson-pci 0000:00:03.1: DMA HW capability register supported
[    3.981135] dwmac-loongson-pci 0000:00:03.1: RX Checksum Offload Engine supported

cat /proc/interrupt:

43:          0          0   PCH PIC  16  ahci[0000:00:08.0]
   44:          0          0   PCH PIC  12  enp0s3f0
   45:          0          0   PCH PIC  14  enp0s3f1
   46:      16233          0   PCH PIC  17  enp0s3f2
   47:      12698          0   PCH PIC  48  xhci-hcd:usb1


the irq number 46 is the falkback legacy irq.

> 	
>
>>>>> +	}
>>>>> +
>>>>> +	plat->rx_queues_to_use = channel_num;
>>>>> +	plat->tx_queues_to_use = channel_num;
>>>> This is supposed to be initialized in the setup() methods. Please move
>>>> it to the dedicated patch.
>>> No, referring to my previous reply, only the 0x10 gnet device has 8 channels,
>>> and the 0x37 device has a single channel.
> Yes. You have a perfectly suitable method for it. It's
> loongson_gnet_data(). Init the number of channels there based on the
> value read from the GMAC_VERSION.SNPSVER field. Thus the
> loongson_gnet_config_multi_msi() will get to be more coherent setting
> up the MSI IRQs only.
You are right!  it works well.


Thanks,

Yanteng



