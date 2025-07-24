Return-Path: <netdev+bounces-209591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A25B0FEC4
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 04:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACED4E7531
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 02:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4F215ADB4;
	Thu, 24 Jul 2025 02:26:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C42E63F;
	Thu, 24 Jul 2025 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323969; cv=none; b=cFhu+I7GmSyI6aVcW5VA0eGfG65zK96beVpHYueLxxYIwCiBcwGRnYQOqb3CGe6MzHtcZJhjRq7P1lYYr4I4MLefc+j5mGK+DBst5bcAvHqbTXbXiWuLflJjb2wQ79XEnJrlOdCFsG19ahm4+qcTMCo/cDRoaaBvBymmXEJU7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323969; c=relaxed/simple;
	bh=p4vGVQbo4qPBddbJJfavou8U0tZPJ07MzYIWo1+iCfQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tUhCUFkVHF4548g/gz4srmQ5F4l/MjChd1KFhAj2O+UUHyIpE5tQKKJZUoF9+OZjViaXmnn3xEjzqC8Yg1sQ1WrlqHbozK+3uyo8Z2hkaEC2meFqu+gS940jWicHaY/D7QwFDlkczOqFvuze5u8i0QiSxoy6i+6+UcaPXn2sldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxG6y7mYFoGdAwAQ--.58115S3;
	Thu, 24 Jul 2025 10:26:03 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxQ+S4mYFomxIkAA--.55020S3;
	Thu, 24 Jul 2025 10:26:00 +0800 (CST)
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: Return early if invalid in
 loongson_dwmac_fix_reset()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723100056.6651-1-yangtiezhu@loongson.cn>
 <20250723100056.6651-2-yangtiezhu@loongson.cn>
 <f65deb0d-29d1-4820-95e9-f1dd94967957@lunn.ch>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b98a5351-f711-ecb1-75fa-68c69263e950@loongson.cn>
Date: Thu, 24 Jul 2025 10:26:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f65deb0d-29d1-4820-95e9-f1dd94967957@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxQ+S4mYFomxIkAA--.55020S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF48GFy8Ar4rWr1kuF1rGrX_yoW8trW5pr
	W3Za4293sFqryxXwn0y3yDXFyru343KrWkWFZ2ywna9an3X34Yqr1jgayjgr12yr4UKF1a
	vr1Uuw1ruFyDGwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUU
	UU=

On 2025/7/23 下午10:53, Andrew Lunn wrote:
> On Wed, Jul 23, 2025 at 06:00:55PM +0800, Tiezhu Yang wrote:
>> If the MAC controller does not connect to any PHY interface, there is a
>> missing clock, then the DMA reset fails.
>>
>> For this case, the DMA_BUS_MODE_SFT_RESET bit is 1 before software reset,
>> just return -EINVAL immediately to avoid waiting for the timeout when the
>> DMA reset fails in loongson_dwmac_fix_reset().
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index e1591e6217d4..6d10077666c7 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -513,6 +513,9 @@ static int loongson_dwmac_fix_reset(void *priv, void __iomem *ioaddr)
>>   {
>>   	u32 value = readl(ioaddr + DMA_BUS_MODE);
>>   
>> +	if (value & DMA_BUS_MODE_SFT_RESET)
>> +		return -EINVAL;
> 
> What happens with this return value? Do you get an error message which
> gives a hint the PHY clock is missing? Would a netdev_err() make sense
> here?

Yes, I will use dev_err() rather than netdev_err() (because there is no
net_device member here) to do something like this:

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c 
b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 6d10077666c7..4a7b2b11ecce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -513,8 +513,11 @@ static int loongson_dwmac_fix_reset(void *priv, 
void __iomem *ioaddr)
  {
         u32 value = readl(ioaddr + DMA_BUS_MODE);

-       if (value & DMA_BUS_MODE_SFT_RESET)
+       if (value & DMA_BUS_MODE_SFT_RESET) {
+               struct plat_stmmacenet_data *plat = priv;
+               dev_err(&plat->pdev->dev, "the PHY clock is missing\n");
                 return -EINVAL;
+       }

         value |= DMA_BUS_MODE_SFT_RESET;
         writel(value, ioaddr + DMA_BUS_MODE);

Thanks,
Tiezhu


