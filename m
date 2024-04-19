Return-Path: <netdev+bounces-89517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F948AA8D2
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21E01F213C4
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 07:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA443B298;
	Fri, 19 Apr 2024 07:02:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EA33BBFA
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510132; cv=none; b=nQ1697YtZGahCfagl67ScTEWx7I5hM1dvIpbk9uHOwxDPELz2KALgdUsyJgMDDVPhs2SyvDsvhMmEzlI5OpfwfN86CQ0dyB4RN3osNavZf27KKOUC20r7Uq9nRkYXkU06xsxogK8WwXf0tC4MLVMaVUzW55giCFRteBLHB3gIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510132; c=relaxed/simple;
	bh=lrJj40sZTKvFTEtP/Lirec6LHx3PKjWPptmpZFVmwlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Angtb1dqI02lvnjcLZq4UGiNKPf/nIGnGGk+D6upTrXjjz6xOvAIC4JPs1oUbIoxjliG5WOom/pdedKdCYBZBvQNO8KamfhIZe7mJnHDLLLzeSv8zVclBQtGnfmO5BwM9ZuofrUjsqdHwmqReG49Ima+l0aYBRHvE45FTinDGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8DxebrqFiJm3awpAA--.13226S3;
	Fri, 19 Apr 2024 15:02:02 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxWRLlFiJmS_V_AA--.35882S3;
	Fri, 19 Apr 2024 15:01:58 +0800 (CST)
Message-ID: <147324d1-7c2c-464c-8b76-c692c54c6afc@loongson.cn>
Date: Fri, 19 Apr 2024 15:01:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/6] net: stmmac: Move all PHYLINK MAC
 capabilities initializations to MAC-specific setup methods
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn>
 <zrrrivvodf7ovikm4lb7gcmkkff3umujjcrjfdlk5aglfnc6nf@vi7k5b4qjsv4>
 <83b0af5c-6906-44b5-b4fa-d7ed8fccaae4@loongson.cn>
 <nfv3ejamjpi5zv7uzbxhqhce4myceicauoh5okjkxd3zpcewvg@ogkpkjh6detv>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <nfv3ejamjpi5zv7uzbxhqhce4myceicauoh5okjkxd3zpcewvg@ogkpkjh6detv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxWRLlFiJmS_V_AA--.35882S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWDXrWDJF45ZF47tFy7Arc_yoW8Jw15pF
	s3ta15Zrn7Jr17A3s7Ka1xXF1Iga1rJr9xu3W5CryFqw1DXr1avrWI93y5uF1DWrZYkFya
	qr1ava4kt34xJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==


在 2024/4/18 17:53, Serge Semin 写道:
> On Thu, Apr 18, 2024 at 01:02:28PM +0800, Yanteng Si wrote:
>> 在 2024/4/13 02:32, Serge Semin 写道:
>>> Just submitted the series with this patch being properly split up and
>>> described:
>>> https://lore.kernel.org/netdev/20240412180340.7965-1-fancer.lancer@gmail.com/
>>>
>>> You can drop this patch, copy my patchset into your repo and rebase
>>> your series onto it. Thus for the time being, until my series is
>>> reviewed and merged in, you'll be able to continue with your patchset
>>> developments/reviews, but submitting only your portion of the patches.
>>>
>>> Alternatively my series could be just merged into yours as a set of
>>> the preparation patches, for instance, after it's fully reviewed.
>> Okay, I've seen your patch. I'll drop it.
> The series has been partly merged in:
> https://lore.kernel.org/netdev/20240412180340.7965-1-fancer.lancer@gmail.com/
> You can pick the first three patches up into your repo to rebase your
> work onto.
Ok, I'm using net-next.git trees, I've seen them, that's why I started 
preparing v12.
>
> Two leftover patches I've just resubmitted:
> https://lore.kernel.org/netdev/20240417140013.12575-1-fancer.lancer@gmail.com/

Okay, thank you.


Thanks,

Yanteng



