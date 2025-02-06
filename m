Return-Path: <netdev+bounces-163397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E805A2A207
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF291882349
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EC92144A8;
	Thu,  6 Feb 2025 07:22:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95522489F;
	Thu,  6 Feb 2025 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826554; cv=none; b=oMea3cjMMUFDgvS5CGvq4xzeSTEYvnJB/CwHgilgI7L3ws3Po64KbegCdPPdDRmjlebE+XodjtECMdDljuK+VCYzlFUGHfxsDa/dgaeowpMUWYL1QAb8j7+hOs4cH3fcTknz7QPMuXXwil1BLxoSfo/OKe2TBsDLRoP0hYfbXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826554; c=relaxed/simple;
	bh=PIReiWdXlYUy1wBtRiyRHjKZJRr/o828LS7N/1Gp7ZE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r7tmuCbwW1eLfwUXzmsbcb27KcuPCBPxabCc9EwIO6RuY5bizIt7xFQs/amaPj4gMSrzwEzFcSrRd48h30E7sofemPWkCUJ71SnqEOe500Ip7Cl7dLyJgy7GuAQwQTips9k5ixTsoaAZtuODqsNIS5+1SXUDe+QIOedTRg64Ix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Dx2uEzY6Rn8x5tAA--.20169S3;
	Thu, 06 Feb 2025 15:22:27 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxHscwY6Rnm7MBAA--.397S2;
	Thu, 06 Feb 2025 15:22:26 +0800 (CST)
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
To: Yanteng Si <si.yanteng@linux.dev>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chenhuacai@kernel.org,
 fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
 <4787f868-a384-4753-8cfd-3027f5c88fd0@linux.dev>
 <7073a4e9-2a6b-a3e9-769e-5069b0e9772c@loongson.cn>
 <b77ce124-af98-40e3-84bb-b743cc6f5f92@linux.dev>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <c5abbb5b-97f3-2b34-26db-06e0dc82be84@loongson.cn>
Date: Thu, 6 Feb 2025 15:22:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b77ce124-af98-40e3-84bb-b743cc6f5f92@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxHscwY6Rnm7MBAA--.397S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1xJw47KF1rZFyxtFy7urX_yoW8ZF1rpr
	sYk3WUKFn8Xry0y3yjvF4rZryjvw4ftwsIgF4Dtr48J3s8A3WaqrW2qFZF9wsrZrZ3Wr1Y
	qrW7trZruF1Dt3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==


在 2025/1/22 下午4:53, Yanteng Si 写道:
>
>
>
> 在 2025/1/22 09:31, Qunqin Zhao 写道:
>>
>> 在 2025/1/21 下午9:41, Yanteng Si 写道:
>>>
>>> 在 1/21/25 16:25, Qunqin Zhao 写道:
>>>> Loongson's GMAC device takes nearly two seconds to complete DMA reset,
>>>> however, the default waiting time for reset is 200 milliseconds
>>> Is only GMAC like this?
>> At present, this situation has only been found on GMAC.
>
>>>> @@ -566,6 +578,7 @@ static int loongson_dwmac_probe(struct pci_dev 
>>>> *pdev, const struct pci_device_id
>>>>         plat->bsp_priv = ld;
>>>>       plat->setup = loongson_dwmac_setup;
>>>> +    plat->fix_soc_reset = loongson_fix_soc_reset;
>>>
>>> If only GMAC needs to be done this way, how about putting it inside 
>>> the loongson_gmac_data()?
>>
>> Regardless of whether this situation occurs in other devices(like 
>> gnet), this change will not have any impact on gnet, right?
>>
> Yeah，However, it is obvious that there is now a more suitable
> place for it. In the Loongson driver, `loongson_gmac_data()`
> and `loongson_default_data()` were designed from the beginning.
> When GNET support was added later, `loongson_gnet_data()`
> was designed. We once made great efforts to extract these codes
> from the `probe()` . Are we going to go back to the past?
>
> Of course, I'm not saying that I disagree with you fixing the
> GMAC in the `probe()`. I just think it's a bad start. After that,
> other people may also put similar code here, and eventually
> it will make the `probe` a mess.
>
> If you insist on doing this, please change the function name
> to `loongson_gmac_fix_reset()`, just like `loongson_gnet_fix_speed`.

Recently, it is found that GNET may also have a long DMA reset time.  
And the commit

message should be "Loongson's DWMAC device may take nearly two seconds 
to complete DMA reset,
however, the default waiting time for reset is 200 milliseconds".

Thanks.

>
>
> Thanks,
> Yanteng


