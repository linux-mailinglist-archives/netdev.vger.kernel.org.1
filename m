Return-Path: <netdev+bounces-209288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B32B0EEA6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E0C961648
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8E284B3A;
	Wed, 23 Jul 2025 09:42:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022EC284694;
	Wed, 23 Jul 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263775; cv=none; b=A0CkfSRzby1M4e6miQvQLBbTGoN5DShxYZtv4vMAMk/kvChUhRI9UqeM0oxCzed48sAwQfzWIf0Rbx6Exi3b6HaibfNQj6ed0QwL0omdOmBWRCGD7PdHmUEufU4A9KKEUZ0WWMqB6QwrFljdFdr37Pv8C7natP+xr9mkh35K+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263775; c=relaxed/simple;
	bh=BTH6PslU5u9WuXBq8wCWsWzECi34i72Wj3allMZ5Z3A=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JXL5cL7FhxPAvHtleqXhbxB8LGgU48KzuvEYFvPlBQbY4oljkIIfulMTrnxcVpfIuHJWjKfUNP09WnXH3hISTOX9AvLVYbOPV2pZBiuX8JtlH/mniIHsVx5RYMvlou11ePVZslamgokq3SQcbkOC5JLrIAnm0rUid7W9kQUww14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axx2mYroBoETcwAQ--.63210S3;
	Wed, 23 Jul 2025 17:42:48 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOSVroBobAEjAA--.50282S3;
	Wed, 23 Jul 2025 17:42:45 +0800 (CST)
Subject: Re: [PATCH net-next 1/2] net: stmmac: Return early if invalid in
 loongson_dwmac_fix_reset()
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250722062716.29590-1-yangtiezhu@loongson.cn>
 <20250722062716.29590-2-yangtiezhu@loongson.cn>
 <20250722144802.637bfde0@fedora.home>
 <2fea78e7-9e0a-4c6b-9d86-6433e4c28e5e@loongson.cn>
Message-ID: <cccf48de-9987-2ea5-bd38-a8e660004039@loongson.cn>
Date: Wed, 23 Jul 2025 17:42:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2fea78e7-9e0a-4c6b-9d86-6433e4c28e5e@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOSVroBobAEjAA--.50282S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1DKr1UXw17KF13Ar4xGrX_yoW8Xr17pr
	4Sga17JrsrXry8ur4qvw4aqFyayrn8KF95X3WkGryjyws8Xwn8Jr1xKryjgFyxZws7Kw1U
	tr4vqFW3u3WqkagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUU
	U==

On 2025/7/22 下午9:10, Tiezhu Yang wrote:
> On 2025/7/22 下午8:48, Maxime Chevallier wrote:
>> On Tue, 22 Jul 2025 14:27:15 +0800
>> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>>> If the DMA_BUS_MODE_SFT_RESET bit is 1 before software reset,
>>> there is no need to do anything for this abnormal case, just
>>> return -EINVAL immediately in loongson_dwmac_fix_reset().
>>>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>
>> Do you know when that could ever happen ? I'm asking because this logic
>> for the DMA reset is duplicated in several places in this driver, maybe
>> this could be useful for other users as well. I'm guessing this is to
>> avoid waiting for the timeout when the DMA reset fails, but that is
>> usually when there's a missing clock somewhere (such as the RGMII clock
>> from the PHY), in which case I don't think the RST bit will be set.
> 
> To be honest, I am not quite sure the root cause but this actually
> happened on the test environment, I guess there is a missing clock.
> 
> You are right, the initial aim of this patch is to return early for
> this case to avoid waiting for the timeout when the DMA reset fails.

With the help of hardware engineer to analysis the ‌device‌ of mainboard,
the root cause is that the MAC controller does not connect to any PHY
interface, there is a missing clock, so the DMA reset fails.

I will send v2 later to update the commit message if it makes sense.

Thanks,
Tiezhu


