Return-Path: <netdev+bounces-114824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EADF94454E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6353B20CEF
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 07:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06C1581F0;
	Thu,  1 Aug 2024 07:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F614264A;
	Thu,  1 Aug 2024 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.59.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496783; cv=none; b=uB674EFQ617ZMz5IqVMsY0KHQO3TL76MDFYlWkL2laKsKkSAbj2T2ueBwUgHvqWe3eoI9H0ODoQI2iFkIThTjk3VLzzGCfhyHPur8fFdNRlC9+QyJTjf8XfmCJBHEuof2qtXx0ViRvqsojxvd/HYkY1axOoojayvnCBNCXGAGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496783; c=relaxed/simple;
	bh=/2gJDhm9jZu4Ci0H9owy318v6GlC5uHyDuRZvjOljxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=feCTQ6hdl3HKQ+QseTStyt3nWsZwapkddgx/q7BSTi7Wd43S2X4MK31Vf2O8UUffrqPrKSg+g7ynWyj06zR1X33BFNcAYoJLRdPepdf3gUi3/dgfdSGh/E46kLhRi83bM0mymCKsm/mSy96GVw3mjR43gJRQfR4pu9rc4ikNUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=80.241.59.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4WZKpM35cdz9shY;
	Thu,  1 Aug 2024 09:09:31 +0200 (CEST)
Message-ID: <17deb48c-6148-4e3d-aa0b-6c840f55302d@denx.de>
Date: Thu, 1 Aug 2024 09:09:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: mtk_eth_soc: use prefetch
 methods
To: Elad Yifee <eladwf@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>
References: <20240729183038.1959-1-eladwf@gmail.com>
 <20240729183038.1959-2-eladwf@gmail.com> <ZqirVSHTM42983Qr@LQ3V64L9R2>
 <CA+SN3soUmtYfM_qVQ7L1gHMSLYe2bDm=6U9UwFLvj35odT0Feg@mail.gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <CA+SN3soUmtYfM_qVQ7L1gHMSLYe2bDm=6U9UwFLvj35odT0Feg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/24 20:35, Elad Yifee wrote:
> On Tue, Jul 30, 2024 at 11:59 AM Joe Damato <jdamato@fastly.com> wrote:
>>
>> Based on the code in mtk_probe, I am guessing that only
>> MTK_SOC_MT7628 can DMA to unaligned addresses, because for
>> everything else eth->ip_align would be 0.
>>
>> Is that right?
>>
>> I am asking because the documentation in
>> Documentation/core-api/unaligned-memory-access.rst refers to the
>> case you mention, NET_IP_ALIGN = 0, suggesting that this is
>> intentional for performance reasons on powerpc:
>>
>>    One notable exception here is powerpc which defines NET_IP_ALIGN to
>>    0 because DMA to unaligned addresses can be very expensive and dwarf
>>    the cost of unaligned loads.
>>
>> It goes on to explain that some devices cannot DMA to unaligned
>> addresses and I assume that for your driver that is everything which
>> is not MTK_SOC_MT7628 ?
> 
> I have no explanation for this partial use of 'eth->ip_align', it
> could be a mistake
> or maybe I'm missing something.
> Perhaps Stefan Roese, who wrote this part, has an explanation.
> (adding Stefan to CC)

Sorry, I can't answer this w/o digging deeper into this driver and
SoC again. And I didn't use it for a few years now. It might be a
mistake.

Thanks,
Stefan


