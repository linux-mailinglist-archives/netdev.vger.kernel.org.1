Return-Path: <netdev+bounces-234656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887CEC2544E
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 14:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4CE3BDDB4
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1134B411;
	Fri, 31 Oct 2025 13:29:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D7D2FB;
	Fri, 31 Oct 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917391; cv=none; b=CqZHO6n4m3K4+srhvZIk1r2zVszUg4poPNtmJvJe54PIvWVfz2d4RGisJhzC1cZpgvsXf+Z6g3iSiQn27QAW9Gi4PTkI2QoQ8+Jk4avRnUehZD1HD34hQ3etavgiMJSt1TBZ/fjaJbyh0d7JG7Jg47nfC5OSu/K7N69KyRv4hsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917391; c=relaxed/simple;
	bh=2+PgWQ9PdjBLHdFl7BQ8/dlijtSQu9Lg/oJLV5+43iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neZxDqnNTRCqh1zGXNhZGeUphdTZCZAsIrjAm0OFcW+2ZzHd6z2PFlJvcecqIlNJIcXXPlpUapmP/ySe9bX1QYdvjFtUoO5ymctkUigWPC+NwVbqYs2PQY8Blc8q//GvC7eeSDfS+WtimDVtRnBOZBJHfi5otTQq1v0Hsl/vFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.109] (unknown [114.241.85.109])
	by APP-01 (Coremail) with SMTP id qwCowAAXfWe0uQRpJJbBAA--.7539S2;
	Fri, 31 Oct 2025 21:29:24 +0800 (CST)
Message-ID: <729fc508-0682-41b0-8582-b1388f31e08d@iscas.ac.cn>
Date: Fri, 31 Oct 2025 21:29:23 +0800
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
 <ee49cb12-2116-4f0d-8265-cd1c42b6037b@iscas.ac.cn>
 <c180925d-68fe-4af1-aa4f-57fb2cd1e9ca@lunn.ch>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <c180925d-68fe-4af1-aa4f-57fb2cd1e9ca@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowAAXfWe0uQRpJJbBAA--.7539S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7Xr13Zw15KF43CFW5GFg_yoW8ur1rpa
	yaga4vyF1jyr1vyFZ7Zr47Xa4j9395JrsxCFyrKw18Xrn8XFyrCr9rKF47C39xWw1kJr4Y
	9ws5XF93ArsrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 10/31/25 20:43, Andrew Lunn wrote:
> On Fri, Oct 31, 2025 at 03:22:56PM +0800, Vivian Wang wrote:
>> On 10/31/25 05:32, Andrew Lunn wrote:
>>>> [...]
>>>>
>>>> -		emac_set_fc(priv, fc);
>>>> -	}
>>>> +	phy_set_asym_pause(dev->phydev, pause->rx_pause, pause->tx_pause);
>>> It is hard to read what this patch is doing, but there are 3 use cases.
>> Yeah, I guess the patch doesn't look great. I'll reorganize it in the
>> next version to make it clearer what the new implementation is and also
>> fix it up per your other comments.
>>
>>> 1) general autoneg for link speed etc, and pause autoneg
>>> 2) general autoneg for link speed etc, and forced pause
>>> 3) forced link speed etc, and forced pause.
>> Thanks for the tip on the different cases. However, there's one bit I
>> don't really understand: Isn't this set_pauseparam thing only for
>> setting pause autoneg / force?
> Nope. You need to think about how it interacts with generic autoneg.
>
>        ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off]
>
>        ethtool -s devname [speed N] [lanes N] [duplex half|full]
>               [port tp|aui|bnc|mii] [mdix auto|on|off] [autoneg on|off]
>
> These autoneg are different things. -s is about generic autoneg,
> speed, duplex, etc. However pause can also be negotiated, or not,
> using -A.
>
> You can only autoneg pause if you are doing generic autoneg. So there
> are three combinations you need to handle.

Oh, that is what I had missed. I hadn't understood this part before. Thanks.

> With pause autoneg off, you can set registers in the MAC immediately,
> but you need to be careful not to overwrite the values when generic
> autoneg completes and the adjust_link callback is called.
>
> If you have pause autoneg on, you have to wait for the adjust_link
> callback to be called with the results of the negotiation, including
> pause.
>
> phylink hides all this logic. There is a link_up callback, which tells
> you how to program the hardware. You just do it, no logic needed.

This makes sense. I'll look into using phylink.

Thanks,
Vivian "dramforever" Wang


