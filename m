Return-Path: <netdev+bounces-197870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CFBADA179
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4961B188FFD5
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B831263F41;
	Sun, 15 Jun 2025 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="fwHJ5W9q"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB59322A;
	Sun, 15 Jun 2025 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749981259; cv=none; b=bsqh2Pt0SwRoHNAvwoOkDgEnQeklySZBi9yipsT7PCYsUFEbyk6+3+SEAPBQvoGBwwoWiXjmO9En4ZDYYtPqCDjE52uuqojkaEj3xmC0UruIYs7iMq6K/sBLCiEP9ZLMoWg/5Bukmip8aEZ03LKHGRogGHa8W8eTB/cQpJzp3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749981259; c=relaxed/simple;
	bh=8rrS+or7l6CfX8D5YgB8ofUfRZo0S5lNd/tMNkLoMOQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LGhKKVqxGpOtjt2+SVX5ckdvZ3HSSudYkglUxlKO1cQEh5wUiLVFNMqx5uZSFc2phbScgfnyRaGU8Ggi4Owb8NmAAl25UrRdPDYjWxYMY//y7qffUwmdyvTvNDV82evLKTebxUExk08QmrsQkmE6KcMl6yiD5B9rKqTLY87RAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=fwHJ5W9q; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id 2F25E1005FD;
	Sun, 15 Jun 2025 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749981254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qR3qMDQo9TdMbJqkibA/Cdr7B5FwdnAlAIEIskS1oHs=;
	b=fwHJ5W9qptWu4Q4AAnsMj141YfE9G8B8ltvngjlidjrkzljURVbuJo4fi7hwgqv6eHmayJ
	vqfgII+I9Uq6rxYaZltp9jJpziEj+L+5tTASyh1NGH/5jkCcAhPYsmrMWc0/C+lhDfNnmr
	xDhpCPZcU9v6AAf4iFIJ3cZGdD0FN2E=
Received: from webmail.hosting.de (unknown [134.0.26.148])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 5862A3601E7;
	Sun, 15 Jun 2025 09:54:13 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 15 Jun 2025 11:54:13 +0200
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Golle
 <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank
 Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2] net: ethernet: mtk_eth_soc: support named IRQs
In-Reply-To: <aE6K-d0ttAnBzcNg@lore-desk>
References: <20250615084521.32329-1-linux@fw-web.de>
 <aE6K-d0ttAnBzcNg@lore-desk>
Message-ID: <d4781d559e3f72b0bcde88e6b04ed8e5@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 8416b7ea-d84c-44e8-bd86-b50db1b64538

Am 2025-06-15 10:57, schrieb Lorenzo Bianconi:
>> From: Frank Wunderlich <frank-w@public-files.de>
>> 
>> Add named interrupts and keep index based fallback for exiting 
>> devicetrees.
>> 
>> Currently only rx and tx IRQs are defined to be used with mt7988, but
>> later extended with RSS/LRO support.
>> 
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Hi Frank,
> 
> I guess my comments on v1 apply even in v2. Can you please take a look?

adding your comments (and mine as context) from v1 here:

Am 2025-06-15 10:57, schrieb Lorenzo Bianconi:
>> From: Frank Wunderlich <frank-w@public-files.de>

>> I had to leave flow compatible with this:
>> 
>> <https://github.com/frank-w/BPI-Router-Linux/blob/bd7e1983b9f0a69cf47cc9b9631138910d6c1d72/drivers/net/ethernet/mediatek/mtk_eth_soc.c#L5176>
> 
> I guess the best would be to start from 0 even here (and wherever it is
> necessary) and avoid reading current irq[0] since it is not actually 
> used for
> !shared_int devices (e.g. MT7988).  Agree?
> 
>> 
>> Here the irqs are taken from index 1 and 2 for
>>  registration (!shared_int else only 0). So i avoided changing the
>>  index,but yes index 0 is unset at this time.
>> 
>> I guess the irq0 is not really used here...
>> I tested the code on bpi-r4 and have traffic
>>  rx+tx and no crash.
>>  imho this field is not used on !shared_int
>>  because other irq-handlers are used and
>>  assigned in position above.
> 
> agree. I have not reviewed the code in detail, but this is why
> I think we can avoid reading it.

i areee, but imho it should be a separate patch because these are 2 
different changes

>> It looks like the irq[0] is read before...there is a
>>  message printed for mediatek frame engine
>>  which uses index 0 and shows an irq 102 on
>>  index way and 0 on named version...but the
>>  102 in index way is not visible in /proc/interrupts.
>> So imho this message is misleading.
>> 
>> Intention for this patch is that irq 0 and 3 on
>>  mt7988 (sdk) are reserved (0 is skipped on
>> !shared_int and 3 never read) and should imho
>>  not listed in devicetree. For further cleaner
>>  devicetrees (with only needed irqs) and to
>>  extend additional irqs for rss/lro imho irq
>>  names make it better readable.
> 
> Same here, if you are not listing them in the device tree, you can 
> remove them
> in the driver too (and adjust the code to keep the backward 
> compatibility).

afaik i have no SHARED_INT board (only mt7621, mt7628) so changing the 
index-logic will require testing on such boards too.

i looked a bit into it and see mt7623 and mt7622 have 3 IRQs defined 
(!SHARED_INT) and i'm not 100% sure if the first is also skipped (as far 
as i understood code it should always be skipped).

In the end i would change the irq-index part in separate patch once this 
is accepted to have clean changes and not mixing index with names (at 
least to allow a revert of second in case of regression).

Am 2025-06-15 11:26, schrieb Daniel Golle:
> In addition to Lorenzo's comment to reduce the array to the actually 
> used
> IRQs, I think it would be nice to introduce precompiler macros for the 
> irq
> array index, ie. once the array is reduce to size 2 it could be 
> something
> like
> 
> #define MTK_ETH_IRQ_SHARED 0
> #define MTK_ETH_IRQ_TX 0
> #define MTK_ETH_IRQ_RX 1
> #define __MTK_ETH_IRQ_MAX MTK_ETH_IRQ_RX
> 
> That would make all the IRQ code more readable than having to deal with
> numerical values.

makes sense, i will take this into the second patch.

I hope you can agree my thoughts about not mixing these 2 parts :)

regards Frank

