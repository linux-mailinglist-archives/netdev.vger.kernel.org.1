Return-Path: <netdev+bounces-85177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E382B899B2E
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207AC1C209F0
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B421649DA;
	Fri,  5 Apr 2024 10:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D681607A2
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314105; cv=none; b=COMmDqBdLuFqHLONUXp+RWCcYcXB8dKpdNkGJ0VoimZKGc4evoByQbix/VJrE44vQByarxb1/k0n3hj8zhtK8B5mMYb/Ihb3r0qAlCPZd/nfGnYcvQcBQH6Ms1/T0XA4DiSjOZK99i8yTyrN68aG6COphYrSDI5GNCIjymWllNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314105; c=relaxed/simple;
	bh=cpuazZjK1YswcYl25hHPP8o0LSz42IeMSO4CZ3DYYik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHvo0Lyi4/+5rXTrDWbZoE5cV+2uKqnbgMBzI1x2ytSlpYMJX7Q7jPA0sfB4ozT6T7vSvJLPWua3+DTBbluTlfHzuRDRSKf/NSHX3DtUbv7QVICvzEfVu6hICv8fXeVIOSSwxuVw5eZfmaSQYFlfnSw5qqzFfeUjUSx5rTif2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8Dxurry1g9mhIMjAA--.638S3;
	Fri, 05 Apr 2024 18:48:18 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs_w1g9mHMVzAA--.25258S3;
	Fri, 05 Apr 2024 18:48:17 +0800 (CST)
Message-ID: <441106d2-08dd-45e7-b37e-3c19734ad546@loongson.cn>
Date: Fri, 5 Apr 2024 18:48:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
To: Serge Semin <fancer.lancer@gmail.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com
References: <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
 <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
 <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
 <cd8be3b1-fcfa-4836-9d28-ced735169615@loongson.cn>
 <em3r6w7ydvjxualqifjurtrrfpztpil564t5k5b4kxv4f6ddrd@4weteqhekyae>
 <Zfq8TNrt0KxW/IWh@shell.armlinux.org.uk>
 <fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p>
 <Zf3ifH/CjyHtmXE3@shell.armlinux.org.uk>
 <jzapsbgrdbpv7ei7uoet5aqxgvnpdqsjpm7amlvbveqnfk2bao@ck5q63hks3zz>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <jzapsbgrdbpv7ei7uoet5aqxgvnpdqsjpm7amlvbveqnfk2bao@ck5q63hks3zz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs_w1g9mHMVzAA--.25258S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cry8uw4Dtry8JF48tryUCFX_yoW8ur43pw
	4UAayrZFsrXr43Ga1DAw48ZF9Yv34ftF4j93W8KrWrWFnFkr93Kr1Y9rWUuF17Cr1kW3Wa
	qrWjgFnru3Z8A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7BMNUUUUU=


在 2024/4/3 20:37, Serge Semin 写道:
> On Fri, Mar 22, 2024 at 07:56:44PM +0000, Russell King (Oracle) wrote:
>> On Fri, Mar 22, 2024 at 09:07:19PM +0300, Serge Semin wrote:
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 25519952f754..24ff5d1eb963 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -936,6 +936,22 @@ static void stmmac_mac_flow_ctrl(struct stmmac_priv *priv, u32 duplex)
>>>   			priv->pause, tx_cnt);
>>>   }
>>>   
>>> +static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
>>> +					 phy_interface_t interface)
>>> +{
>>> +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
>>> +
>>> +	/* Get the MAC-specific capabilities */
>>> +	stmmac_mac_phylink_get_caps(priv);
>>> +
>>> +	config->mac_capabilities = priv->hw->link.caps;
>>> +
>>> +	if (priv->plat->max_speed)
>>> +		phylink_limit_mac_speed(config, priv->plat->max_speed);
>>> +
>>> +	return config->mac_capabilities;
>> Yes, I think your approach is better - and it still allows for the
>> platform's capabilities to be masked in towards the end of this
>> function.
> Sorry for the long-term response. Thanks for your comment. Seeing
> Yanteng is struggling much with this series review I'll convert the
> suggested change into a patchset (taking into account that the change
> implies some fixes) and submit it for review later on this week. After
> finishing the review stage, the series could be either merged in right
> away or Yanteng will be able to pick it up and add it into his patchset.
>
Couldn't be better! I have already started to re-split the patches, and 
then a series

of tests are needed. There are some network card parameters that I need 
to confirm

with the hardware engineer. Of course, I will pay attention to the email 
list before

sending it out. If I don't see your patch set, I will pick it up.


Thanks,

Yanteng



