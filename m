Return-Path: <netdev+bounces-82328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8A288D4A9
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 03:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8931C24B7D
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 02:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA3B219EB;
	Wed, 27 Mar 2024 02:42:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A101FA6
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507332; cv=none; b=mmxj6UemUN4SQZLEWYzwBepcjxSvJVW4XYzn2kia+qUqZ5yxOL+J6tUIXqOBIaOZr2iyupSpeHBUs7ovemDIXDWuIzCnqPXsys0H6+HWgeK5kJW/cx5E/QS/uTsdeShlXydnHmi6T5c8iLyHDIKwE8+9Y271g6nwkU/jpac5JFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507332; c=relaxed/simple;
	bh=FWtxJD5CqAgS4kwI3RKWd7Y+aENXIlVoEQGRFM26IV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pj2CYVCu9WSfEBos4bIFLH1VkHMSVtOC3Xe+vfgTw4Jku7BVdM+lsM2zyGn/wn9qadmYGE3U5xHKsdgFQrJAzvBqSgchC5hhmMbFENxx8+CFxeWs1n5FvY+gbpwVgjdA2t9cmod/ev1nVNRZ+9r5z2MDWpsyA7sORLzVvWFl5fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8AxafB4hwNmHqYeAA--.7000S3;
	Wed, 27 Mar 2024 10:42:00 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxihJ1hwNmaaNpAA--.928S3;
	Wed, 27 Mar 2024 10:41:58 +0800 (CST)
Message-ID: <8d6eed68-0719-4a30-9278-6faea3174d23@loongson.cn>
Date: Wed, 27 Mar 2024 10:41:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
To: Andrew Lunn <andrew@lunn.ch>
Cc: Serge Semin <fancer.lancer@gmail.com>, hkallweit1@gmail.com,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
 <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
 <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
 <a9e27007-c754-4baf-84ed-0deed9f29da4@loongson.cn>
 <3c551143-2e49-47c6-93bf-b43d6c62012b@lunn.ch>
 <5aad4eea-e509-4a29-be0a-0ae1beb58a86@loongson.cn>
 <593adab6-7ecf-4d8f-aefb-3f5eea24f3fc@lunn.ch>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <593adab6-7ecf-4d8f-aefb-3f5eea24f3fc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxihJ1hwNmaaNpAA--.928S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFyrArWfWw4UAw1kJr1fGrX_yoW3CrXEkr
	yrA34kG392yF4DCF4DKw13Ar9xJFWqgF9aqr48Wrnrtwn5ZaykGryDGw1fZr18GF47Jrya
	kwnI9FW3WryYkosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==


在 2024/3/26 20:21, Andrew Lunn 写道:
> On Tue, Mar 26, 2024 at 08:02:55PM +0800, Yanteng Si wrote:
>> 在 2024/3/21 23:02, Andrew Lunn 写道:
>>>> When switching speeds (from 100M to 1000M), the phy cannot output clocks,
>>>>
>>>> resulting in the unavailability of the network card.  At this time, a reset
>>>> of the
>>>>
>>>> phy is required.
>>> reset, or restart of autoneg?
>> reset.
> If you need a reset, why are you asking it to restart auto-neg?
Autoneg was discussed in patch v1, but we may have misunderstood the 
description from our hardware engineers at the time. The root cause is 
that there is an error in the connection between the MAC and PHY. After 
repeated tests, we have found that

auto-negcannot solve all problems and can only be reset. Thanks, Yanteng


