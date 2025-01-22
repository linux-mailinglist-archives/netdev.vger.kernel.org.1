Return-Path: <netdev+bounces-160162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC8A18990
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 02:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC8A169B40
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E34315A;
	Wed, 22 Jan 2025 01:34:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427217591;
	Wed, 22 Jan 2025 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737509680; cv=none; b=YJ7taib638oAYTG336b/WIBPGw4KbZ8ejGNwgtORGU8VOD4FBvec3xVhRckUN7XUYXSa/FW7Ux82dvfhVN7kp5ioMUl7g2dCCFJPrQlsMbRsHMUWNcZhYhvka4dqX62YEd8pcuGY5C+ERDgR9ePjcz3oBxBazBprjYmsAwTCnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737509680; c=relaxed/simple;
	bh=LnXf2khRp7Y04bpwCwRJ9vbFc/iOFS9a/f+33mSND+k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VIfiqg3CVIKxNQMdxeMe3efG42ZYMwXtqdDwtYsGPcY0iwv3lfJtN/QA1t7GQToLUKoO/dXzHutFUQqUhzz4PlNxJu82hcaL705+LsHQtSCs8NanPxyJHf7Y6bGg5WTQEXAVyNo3btJ67+69w0afHhZVRM0oqLfsb5MXNFMlzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8CxMK8rS5Bn7QFnAA--.45971S3;
	Wed, 22 Jan 2025 09:34:35 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMCxFOQpS5BnMiQqAA--.21670S2;
	Wed, 22 Jan 2025 09:34:33 +0800 (CST)
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Huacai Chen <chenhuacai@kernel.org>, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
 <CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com>
 <e49da678-3bed-47e0-9169-67a777edd700@linux.dev>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <11cef8d3-2da6-190c-d00e-761d171cd9d5@loongson.cn>
Date: Wed, 22 Jan 2025 09:32:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e49da678-3bed-47e0-9169-67a777edd700@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxFOQpS5BnMiQqAA--.21670S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUmjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
	xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4c8EcI0En4kS14v26r126r1DMxAqzxv26xkF
	7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6r
	W5MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU8l38UUUUUU==


在 2025/1/21 下午9:47, Yanteng Si 写道:
>
> 在 1/21/25 17:29, Huacai Chen 写道:
>> Hi, Qunqin,
>>
>> The patch itself looks good to me, but something can be improved.
>> 1. The title can be "net: stmmac: dwmac-loongson: Add fix_soc_reset() 
>> callback"
>> 2. You lack a "." at the end of the commit message.
>
>> 3. Add a "Cc: stable@vger.kernel.org" because it is needed to backport
>> to 6.12/6.13.
>
> Then we also need to have a fixes tag.
OK, thanks.
>
> Thanks,
>
> Yanteng
>


