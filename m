Return-Path: <netdev+bounces-234574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A55C2389B
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 08:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E816D4E477B
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830C0329377;
	Fri, 31 Oct 2025 07:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8425DAFF;
	Fri, 31 Oct 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895418; cv=none; b=MPCKLl9aLtH3UMsa7ALS+Vaysaf8ImchW3ODRCztKwcqOLlGpfmWsodSqPYOEW8PlaWLLIEJA0+V7vT6ggFkz+9t+oZ3bVDzLUJYRb8AmRvIs9pAYtFZV4boQ+Svb2/H+DGrblVqHyx+qx5S/aiQTzWVn+HFgi9tiK2ZmDOdLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895418; c=relaxed/simple;
	bh=ipp8VzrDOvVxQ1hBoLStaLTuFg60IyRgnAEoxUY7aws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpalMkeqcAUIQFlTUSbiZvPTlBV6ZmGTYwmK4ceXzi3/MWV222ibj1HAdQbiGiD/SfosqcsCBdFxjJNFh706PbFKpxyI+KwfH/o9rOJP0h2cb9tlWfEeCmklfZOWCGnfeSHfKpgL3ZMICLeTtGlOtmyfJZXVc8vYazR3TDsiloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.100] (unknown [114.241.85.109])
	by APP-01 (Coremail) with SMTP id qwCowAAXf2nRYwRptSe8AA--.1032S2;
	Fri, 31 Oct 2025 15:22:57 +0800 (CST)
Message-ID: <ee49cb12-2116-4f0d-8265-cd1c42b6037b@iscas.ac.cn>
Date: Fri, 31 Oct 2025 15:22:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: spacemit: Implement emac_set_pauseparam properly
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@gentoo.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251030-k1-ethernet-fix-autoneg-v1-1-baa572607ccc@iscas.ac.cn>
 <2eb5f9fc-d173-4b9e-89a3-87ad17ddd163@lunn.ch>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <2eb5f9fc-d173-4b9e-89a3-87ad17ddd163@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowAAXf2nRYwRptSe8AA--.1032S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyxZFyUZFykCrWrCrWktFb_yoWkJFcE9F
	yqyanrJw17Ar4UA3y3KF15Ars3C39Y9a4UArykKr1xZa4rAFWxXF1kCF1xGa4fJ3y5G3s5
	tFWFv347Gwn7XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 10/31/25 05:32, Andrew Lunn wrote:
>> [...]
>>
>> -		emac_set_fc(priv, fc);
>> -	}
>> +	phy_set_asym_pause(dev->phydev, pause->rx_pause, pause->tx_pause);
> It is hard to read what this patch is doing, but there are 3 use cases.

Yeah, I guess the patch doesn't look great. I'll reorganize it in the
next version to make it clearer what the new implementation is and also
fix it up per your other comments.

> 1) general autoneg for link speed etc, and pause autoneg
> 2) general autoneg for link speed etc, and forced pause
> 3) forced link speed etc, and forced pause.

Thanks for the tip on the different cases. However, there's one bit I
don't really understand: Isn't this set_pauseparam thing only for
setting pause autoneg / force?

AFAICT from my testing, forcing link speed and duplex from ethtool still
works, so I'm not sure what I'm missing here.

> I don't see all these being handled. It gets much easier to get this
> right if you make use of phylink, since phylink handles all the
> business logic for you.

I'll look into calling phylink next version. Thanks.

Vivian "dramforever" Wang


