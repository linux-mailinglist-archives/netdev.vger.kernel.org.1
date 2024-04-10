Return-Path: <netdev+bounces-86370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 922F889E7F1
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39C81C21186
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33F6138C;
	Wed, 10 Apr 2024 01:48:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51B01C2E
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713729; cv=none; b=tEgu/fsoQHFss2qhwOwSSZ51KyiH3Jcio4cfxoCltR7mAtXcZg8MaDMb4s2vGcjrgk8oaQq9Gau/B7vIhujc2oJ1UWUgL/jVFJvkMMgwVQs/rkPvCyqCvKhb40cAf14Kii2kJo/DJdd1iCVxstTnDjKSCpLPhPoAK/W6iQS90MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713729; c=relaxed/simple;
	bh=Yvfiqvd8YHfu/BKoKTGgFpO5hNj/nnaa8Q2DucEAzMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtenLe0j2asVfxc24tHKMjH7aZ13UM8eb7AheELOmXMK3Qh3U9ih1R3yy39bRGWONXNpAQRAFvF1l8w9glm/ctNyn2fFXg8K2bbEGhFL8jiX7FQEL9Ml1iIxIExuyUrsij/QHnY0+Wvyo7Ea5YTEP3yRznWKraosjDaYNIcU5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8Cx67r87xVm3AwlAA--.3884S3;
	Wed, 10 Apr 2024 09:48:44 +0800 (CST)
Received: from [192.168.100.126] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx1xH27xVmCw53AA--.21591S3;
	Wed, 10 Apr 2024 09:48:40 +0800 (CST)
Message-ID: <0524fb13-6698-47d2-830e-277398f440cd@loongson.cn>
Date: Wed, 10 Apr 2024 09:48:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 2/6] net: stmmac: Add multi-channel support
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 siyanteng01@gmail.com
References: <cover.1712668711.git.siyanteng@loongson.cn>
 <2c3fcab1f5bfa0afc7dc523cf5d8f2f7e3520e79.1712668711.git.siyanteng@loongson.cn>
 <20240409185508.GM26556@kernel.org>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240409185508.GM26556@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx1xH27xVmCw53AA--.21591S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryfCr4fAr1kJw15Aw17XFc_yoW8Gw4rpw
	4kZa4jk3WkJFnrXan7Xw4rZF98Kay3tFW293y7A34a9F4DC34aqr90qrWjkF1UZr13XFy3
	tr4Dur1ru3Z8J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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


在 2024/4/10 02:55, Simon Horman 写道:
> On Tue, Apr 09, 2024 at 10:00:02PM +0800, Yanteng Si wrote:
>> DW GMAC v3.x multi-channels feature is implemented as multiple
>> sets of the same CSRs. Here is only preliminary support, it will
>> be useful for the driver further evolution and for the users
>> having multi-channel DWGMAC v3.x devices.
>>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ...
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
> Hi Yanteng Si, Yanteng Si, all,
>
> STMMAC_FLAG_DISABLE_FORCE_1000 is used here but it is not defined
> until PATCH 6/6. This breaks bisection.
>
> I expect this can be resolved by defining STMMAC_FLAG_DISABLE_FORCE_1000
> as part of this patch.

Sorry, this is to fix some LS2K2000 and some LS7A2000 bugs, in v11 I 
will split

them to 6/6.


Thank you for your review.


Thanks,

Yanteng

>
>   


