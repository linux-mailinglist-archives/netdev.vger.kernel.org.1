Return-Path: <netdev+bounces-80984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E9D885685
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 10:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200721C211B5
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653F4AEE0;
	Thu, 21 Mar 2024 09:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0581641C73
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013404; cv=none; b=lMI9B0Jrr3sj2dfylAkj67jSrS9vE38bq5obSMoSIhWOyvsg2TUJ/uYyDFPiQ7Hc+h2LvFTM9xFt3t/8e3jhA21rtTQ9BzqgieLmqEd54UbkFj1o0AdhtJGfqDnCWzQWsOgp2dZTr+a5r0J2g6OXs823+t7rlwLVn6HCErrKy8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013404; c=relaxed/simple;
	bh=53bnfzRQ2/FIK9SEac0zgwF4OyZtz4kxA4cbNu9Dbck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAuNagpVLHpQy4oGs02Ok3Q6xoPsVb1DhfdRwZMCv0THV9L2YI7O1ZGhyrtuqLe4jguRBD/gXz4L8GyvMenIisjr5uqkC+rwmB69o7XalLNeORmW0co9YesSfnKILcD9WujTZOVapvIjVf1Iy6NLWPwoe8ffW+QpokX8jtl9a8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8BxVfEV_vtlA8MbAA--.1102S3;
	Thu, 21 Mar 2024 17:29:57 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxbs0T_vtle8FfAA--.52681S3;
	Thu, 21 Mar 2024 17:29:56 +0800 (CST)
Message-ID: <a9e27007-c754-4baf-84ed-0deed9f29da4@loongson.cn>
Date: Thu, 21 Mar 2024 17:29:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
 <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
 <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxbs0T_vtle8FfAA--.52681S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrW3KrWkXr4kCw45Wr4DAwc_yoW8GFW5pF
	WfZanxGrZrGw1Sga1xGrs7JF1I934rWw4DCry8Wry8Zwn8Cr4SqF1SqwsYgFyUGrn7CrWY
	v392kasrZa4kZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUUU==


在 2024/3/20 01:02, Serge Semin 写道:
>>> Due to a bug in the chip's internal PHY, the network is still not working after
>>> the first self-negotiation, and it needs to be self-negotiated again.
> Then please describe the bug in more details then.
>
> Getting back to the code you implemented here. In the in-situ comment
> you say: "We need to use the PS bit to check if the controller's
> status is correct and reset PHY if necessary." By calling
> phy_restart_aneg() you don't reset the PHY.
>
> Moreover if "PS" flag is set, then the MAC has been pre-configured to
> work in the 10/100Mbps mode. Since 1000Mbps speed is requested, the
> MAC_CTRL_REG.PS flag will be cleared later in the
> stmmac_mac_link_up() method and then phylink_start() shall cause the
> link speed re-auto-negotiation. Why do you need the auto-negotiation
> started for the default MAC config which will be changed just in a
> moment later? All of that seems weird.

When switching speeds (from 100M to 1000M), the phy cannot output clocks,

resulting in the unavailability of the network card.  At this time, a 
reset of the

phy is required.


BTW, This bug has been fixed in gnet of 2k2000 (0x10, 7a13).

>
> Most importantly I have doubts the networking subsystem maintainers
> will permit you calling the phy_restart_aneg() method from the MAC
> driver code.

We are happy to accept the opinions of the community.


Thanks,

Yanteng

>


