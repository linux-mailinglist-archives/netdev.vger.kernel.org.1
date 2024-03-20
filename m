Return-Path: <netdev+bounces-80771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846D881045
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E7C1C20DB6
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2C29CEB;
	Wed, 20 Mar 2024 10:51:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EDE38F96
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931914; cv=none; b=EWDiV3ph402IR7PvNNygb9dxWzEXvG7Zu4Vw9lmeguD3zQwDYyP+OgsgWYAmZgJt4MPJGKplNH8jpUcL6Pm7iySM0jiMuwQu2w3pYrexhhmp55078dnXfPyYuPx2TnUNi3WZl9wd+tKnPken8b7Wy58tjE3REjTerRETDdheOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931914; c=relaxed/simple;
	bh=NglWa/4Ql7qpAGKsiD9NA3/FthotYHvf2w26wpap5D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyTmDnIQWi5hS2ENdOM2xiM614A2MCHWSujL5bs3hbCBphu5I63rviZAIfKPaCU8uib8/k82gTwmc1VOKsXwWqPR3RyW01txM4KRZK6KtrdISFTz7kHhCuTPyav/062FsgJNq7v/XGmhj0IKIEg3UHvCjXJT8hRXXWr9P/lb1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8Cx2ujEv_pl0DkbAA--.45524S3;
	Wed, 20 Mar 2024 18:51:48 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs_Dv_plwFdeAA--.50108S3;
	Wed, 20 Mar 2024 18:51:48 +0800 (CST)
Message-ID: <fe30d071-bd3f-4b06-af95-7b3e41657a36@loongson.cn>
Date: Wed, 20 Mar 2024 18:51:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 01/11] net: stmmac: Add multi-channel support
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <a2f467fd7e3cecc7dc4cc0bfd2968f371cd40888.1706601050.git.siyanteng@loongson.cn>
 <bhnrczwm2numoce3olexw4ope7svz6uktk44ozefxyeqrof4um@7vkl2fr6uexc>
 <673510eb-21a8-47ca-b910-476b9b09e2bf@loongson.cn>
 <yzs6eqx2swdhaegxxcbijhtb5tkhkvvyvso2perkessv5swq47@ywmea5xswsug>
 <ee2ffb6a-fe34-47a1-9734-b0e6697a5f09@loongson.cn>
 <034d1f08-a110-4e68-abf5-35e7714ea5ae@loongson.cn>
 <3djgq4zsafxdiimb236gvbipwkgedqvubhuyorgvgpz7gqf7ae@4xjsdtrvg4hj>
 <Zfqyeebvr0B3GWpo@shell.armlinux.org.uk>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <Zfqyeebvr0B3GWpo@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs_Dv_plwFdeAA--.50108S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2
	Ij64vIr41l4c8EcI0En4kS14v26r126r1DMxAqzxv26xkF7I0En4kS14v26r126r1DMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==


在 2024/3/20 17:55, Russell King (Oracle) 写道:
> Please also trim appropriately your replies (that goes for both of you.)
> I tried to work out whether you'd provided any content apart from the
> above, but I really couldn't be bothered to page through the message.

Sorry, I will.  I'm sorry to have caused you trouble.  I just saw this 
comment.


Thanks,

Yanteng


