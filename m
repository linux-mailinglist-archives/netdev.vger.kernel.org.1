Return-Path: <netdev+bounces-86901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8622F8A0BB7
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC841C21569
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E628513FD8E;
	Thu, 11 Apr 2024 09:00:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08862EAE5
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826021; cv=none; b=OMtVFZ7rgnzgk82j7z6WpG7nrC28K+bDCeLFKgXZ4xdU6pfU4y7opFLzSmvXzWGCfcd8laCxC63Rx7erHTYRs+I/mWW5ckHggTggmN4YN3KcrcfGPDXkTZMVZYjyvEIEeiloxKs+XKDlCpqYp1D7ZGL1tkBe45LknxnwWMwS8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826021; c=relaxed/simple;
	bh=eDKSLQfrGq/KzEcmmIPthyEiFr6qBL20kJan7RqxxfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trVzjNfjYE5m0PVsDogM4Pvve9++nTnFcnwKAbCaoGolLvzCNVn0d5C7B7BmYukJ565ojmaufuz+24tD1EHnX3ZmsYgcTY74KjVmL6VFmhCVZXD5sp9PNKb8xqk7D5AHK0pIwus0d8SJEjUeEKc5ya8XdCi3Hsri6Bif3iUvGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8Cx2uidphdmr8IlAA--.1296S3;
	Thu, 11 Apr 2024 17:00:13 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxSRKYphdmqfN3AA--.23071S3;
	Thu, 11 Apr 2024 17:00:09 +0800 (CST)
Message-ID: <0f83f238-d52a-4304-9b57-d76b07bd8767@loongson.cn>
Date: Thu, 11 Apr 2024 17:00:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/6] net: stmmac: Add multi-channel support
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 siyanteng01@gmail.com
References: <cover.1712407009.git.siyanteng@loongson.cn>
 <e293a30532ef3e567e6236f6b643430036ea7e09.1712407009.git.siyanteng@loongson.cn>
 <6fd50d0f-862f-5aa1-700c-a2a4fe01854f@bootlin.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <6fd50d0f-862f-5aa1-700c-a2a4fe01854f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxSRKYphdmqfN3AA--.23071S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jr15CF1rAr43tryrXw4fJFc_yoWkWFX_Kw
	42vr13A3WDJa15tr45K3y5Zr9Y9a4Du3sYqr18Kr909a1xWr95XrZ8Wr92yFy8G34rXFWD
	Cr1xAa1Sy34IqosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7pnQUUUUU


在 2024/4/11 15:26, Romain Gantois 写道:
> Hello Yanteng,
>
> On Sat, 6 Apr 2024, Yanteng Si wrote:
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> index e1537a57815f..e94faa72f30e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
>>   		return 0;
>>   	}
>>   
>> +	if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {
>> +		if (cmd->base.speed == SPEED_1000 &&
>> +		    cmd->base.autoneg != AUTONEG_ENABLE)
>> +			return -EOPNOTSUPP;
>> +	}
>> +
>>   	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>>   }
> This doesn't seem like it belongs with the rest of the changes in this patch.
> Maybe you could move it to a separate patch?
>
Yeah, I will move it to patch 6/6, because it is a bug fix for some gnet.


BTW, The issue was also discussed in v10, I will send v11 today, let us 
continue to review in v11, thank you.


Thanks,

Yanteng

>


