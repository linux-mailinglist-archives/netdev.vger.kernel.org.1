Return-Path: <netdev+bounces-82796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7409888FC6A
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996A91C224E8
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A76753E28;
	Thu, 28 Mar 2024 10:08:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE852B9C6
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620526; cv=none; b=VuHPZPEq6EFfhn7wRaDNQrhbb8JGgPE/lSBLe7NkPLH3a9rNpZmm/AsiDeTzUDn66DW3i8ZaKh3jAxLR7QkgWfG5rEwJ9d01zhX/dloiBX4L7K+WCjUp7mHy/iID+RPodJbbHQ4w/6DU6uy8VaUH2th7Qp3WPCPpOKUGqmrFm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620526; c=relaxed/simple;
	bh=yzWZ0eMhkXrNt/v1ITbObBsltsTJXdf6npnVv8MPiYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihVEXC+gFRkquIda0ulMLt4k86L5cP40ITfd+B6M8N+nX5dULjHf3k+yafOEYtZ6ViRQAIc5ORSFnwBL89vvxnzi6Fp53uaeAkToyCFGEnFZ1ZmpN7XMvQaTPWInxcFNFECoQtd8A7bewZpaZjGQb2N8KVFcQhPN1aSP995KfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8CxWOiiQQVm8v4fAA--.54985S3;
	Thu, 28 Mar 2024 18:08:34 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxihKeQQVmzdhrAA--.4174S3;
	Thu, 28 Mar 2024 18:08:31 +0800 (CST)
Message-ID: <9e985b73-9ac6-4bc2-b102-18c0891a0d9b@loongson.cn>
Date: Thu, 28 Mar 2024 18:08:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
To: Andrew Lunn <andrew@lunn.ch>
Cc: Serge Semin <fancer.lancer@gmail.com>, hkallweit1@gmail.com,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
 <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
 <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
 <a9e27007-c754-4baf-84ed-0deed9f29da4@loongson.cn>
 <3c551143-2e49-47c6-93bf-b43d6c62012b@lunn.ch>
 <5aad4eea-e509-4a29-be0a-0ae1beb58a86@loongson.cn>
 <593adab6-7ecf-4d8f-aefb-3f5eea24f3fc@lunn.ch>
 <8d6eed68-0719-4a30-9278-6faea3174d23@loongson.cn>
 <234e3ee5-ff39-4691-943d-c46dbdfde73b@lunn.ch>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <234e3ee5-ff39-4691-943d-c46dbdfde73b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxihKeQQVmzdhrAA--.4174S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuF4DXFykWr4Utr4rWr4UAwc_yoW5XFyxp3
	y8GasYkr4DC3WIyFs7ta1DZF1YyrZaqr45uryDGrWYyrn09FyftrWUKFsF9Fy7Gr4ru3yY
	va12vayavF15Z3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2024/3/27 20:47, Andrew Lunn 写道:
> On Wed, Mar 27, 2024 at 10:41:57AM +0800, Yanteng Si wrote:
>> 在 2024/3/26 20:21, Andrew Lunn 写道:
>>> On Tue, Mar 26, 2024 at 08:02:55PM +0800, Yanteng Si wrote:
>>>> 在 2024/3/21 23:02, Andrew Lunn 写道:
>>>>>> When switching speeds (from 100M to 1000M), the phy cannot output clocks,
>>>>>>
>>>>>> resulting in the unavailability of the network card.  At this time, a reset
>>>>>> of the
>>>>>>
>>>>>> phy is required.
>>>>> reset, or restart of autoneg?
>>>> reset.
>>> If you need a reset, why are you asking it to restart auto-neg?
>> Autoneg was discussed in patch v1, but we may have misunderstood the
>> description from our hardware engineers at the time. The root cause is that
>> there is an error in the connection between the MAC and PHY. After repeated
>> tests, we have found that
>>
>> auto-negcannot solve all problems and can only be reset. Thanks, Yanteng
>   
> So calling phylink_ethtool_nway_reset() does not fix your problem, and
> you need some other fix.
>
Sorry, it's my fault.  I was stupid. Let me explain the whole story:

First, here is the original code we got:

  if (speed == SPEED_1000) {
   if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */) {
    /* reset phy */
    phy_set_bits(ndev->phydev, 0 /*MII_BMCR*/, 0x200 /*BMCR_ANRESTART*/);

Although the comment in the code is **reset phy**, the actual operation
is to modify the autoneg bit. This method fixes all problems.

V1:
if (phydev->speed == SPEED_1000)
  phydev->autoneg = AUTONEG_ENABLE

After discussing with you, see:
<https://lore.kernel.org/loongarch/be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn/>

v2 -> v8:
if (speed == SPEED_1000)
  if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
   phy_restart_aneg(ndev->phydev);

Subsequent versions have been using this method. In recent days, I 
accidentally
conducted an erroneous test, possibly due to the network cable not being
firmly connected, leading me to mistakenly believe that this did not fix all
problems. After conducting sufficient testing today, I found that I was 
mistaken
and that calling phy_restart_aneg() directly fixed all problems.

At your suggestion, calling phylink_et Athletic_nway_reset() also works 
well, but
it will report an assertion failed at drivers/net/phy/phylink.c in the 
dmesg.
So let's continue to call phy_restart_aneg()?

Finally, why did I reply you with reset?  It's because I first checked 
the original
code, and the comment in the original code was /* reset phy */.  I 
thought it was
reset, but today I found out that it was actually autoneg. I apologize 
for my

carelessness.


Thanks,

Yanteng


