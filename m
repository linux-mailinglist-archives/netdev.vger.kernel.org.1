Return-Path: <netdev+bounces-211352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E2B1821F
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E982B1756CF
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0E2472A5;
	Fri,  1 Aug 2025 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="l6VvVs2i"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F523B611;
	Fri,  1 Aug 2025 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053485; cv=none; b=FWi3eS2SvgIoUI1aHlexFvWFUKDWJa4C0CXDWxlaIHKlSBTTfhv3JbVj1rmSefYOOkiVKei1WfwKlNKXXQLIBPSiqIU3TGmIwebNTzKgv04xKPrrxhbzNmeW3kjz3L6YsRXJWjCks2+voULAZSSHHQrx5j1tbVfTkp9bAfBkfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053485; c=relaxed/simple;
	bh=aYl1QhqEmpOLgi8VZ2bX/1UFtuzJMhkXX+iiC5Jlw/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m/zB3i6gXkwxV+QL1BrQUSTShfQNz8ww21f5Nt3tg0OU6lcwuRcIo0d8Yzq6n8L666K7zKZ7a+9bv/hHd6D2spqJpeBmnlyAq0Lt9kdLMNvwdqs9JGFq4cN0N/cROkfwL2cHhBo+G8JmSoPhWXS7/9F9zFTKllceTSePsO0RTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=l6VvVs2i; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B750CA0A8D;
	Fri,  1 Aug 2025 15:04:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=vuuCUbfqt4x45Bee4k7s
	/8tQWFwPYbWJe+4a/dGtm4U=; b=l6VvVs2ilY38iEpd526GqUQtUyHpCOH7T4Qu
	qz2+HDoKnX3Oaia2gy/v/zWAYPLriflIRXIz0vuswLxtmrVUTjvCFfYMCIeaVSge
	L0tBcugP5tdawUGobooJ6OoHNmDwas96NVkB6lYek01zmlwQpkB82RYD+j/u8V1r
	OO9RCFn3ITnia4L+DrIY2ur5FriNpqREezI3mNM5L+fxJnYyTX5XWh0TyW9rTymO
	8nUc87WbS1e3QUsX097NAfB506iPqsaHs+jSPzpv/WP0Da3l9ouQpsE99DDzYrPF
	5vB4jH1SuofuOw44AciMJAl+gHb2gHjwIt2Q+wsaZc86b9lxm+abBydAY2sa26Us
	wRx7rLkipE3hrDifN8PIsY9NMCXcne/Xxh/oXZCOwaCnHikkmiSgDmj6Yz3f6Ztk
	xtxuCL1cPfZ7OTa7R1uZarDvgaJrStaIrv+zJJy9craWmgGiEoosB9ZJUfybo2k4
	04x78LSlbBDLQS1DbarjcdPZN7uWyxRsxe3Vml5jESFc28oDtDsRLZujGq5o1TdY
	dvQkT7i8jD5yvmPbRNXAN4VqDSmaNthaU80xyJFEmOVSfvY4BBemNKaFkQ5xxOCM
	2fMamksH/JvZHTyefOwaniVOZHK1NziTZA709qUnns5S54X1RLdF4adiv48m5NBc
	15nziEE=
Message-ID: <86bb6477-56d9-415a-a0ad-9a5d963a285e@prolan.hu>
Date: Fri, 1 Aug 2025 15:04:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mdio_bus: Use devm for getting reset GPIO
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Mark Brown <broonie@kernel.org>, Sergei Shtylyov
	<sergei.shtylyov@cogentembedded.com>, "David S. Miller"
	<davem@davemloft.net>, Rob Herring <robh@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Dmitry Torokhov" <dmitry.torokhov@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Csaba Buday <buday.csaba@prolan.hu>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250728153455.47190-2-csokas.bence@prolan.hu>
 <95449490-fa58-41d4-9493-c9213c1f2e7d@sirena.org.uk>
 <CAMuHMdVdsZtRpbbWsRC_YSYgGojA-wxdxRz7eytJvc+xq2uqEw@mail.gmail.com>
 <aIy0HqFvCggTEyUk@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <aIy0HqFvCggTEyUk@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E677C65

Hi,

On 2025. 08. 01. 14:33, Russell King (Oracle) wrote:
> On Fri, Aug 01, 2025 at 02:25:17PM +0200, Geert Uytterhoeven wrote:
>> Hi Mark,
>>
>> On Fri, 1 Aug 2025 at 14:01, Mark Brown <broonie@kernel.org> wrote:
>>> On Mon, Jul 28, 2025 at 05:34:55PM +0200, Bence Csókás wrote:
>>>> Commit bafbdd527d56 ("phylib: Add device reset GPIO support") removed
>>>> devm_gpiod_get_optional() in favor of the non-devres managed
>>>> fwnode_get_named_gpiod(). When it was kind-of reverted by commit
>>>> 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()"), the devm
>>>> functionality was not reinstated. Nor was the GPIO unclaimed on device
>>>> remove. This leads to the GPIO being claimed indefinitely, even when the
>>>> device and/or the driver gets removed.
>>>
>>> I'm seeing multiple platforms including at least Beaglebone Black,
>>> Tordax Mallow and Libre Computer Alta printing errors in
>>> next/pending-fixes today:
>>>
>>> [    3.252885] mdio_bus 4a101000.mdio:00: Resources present before probing
>>>
>>> Bisects are pointing to this patch which is 3b98c9352511db in -next,
>>
>> My guess is that &mdiodev->dev is not the correct device for
>> resource management.
> 
> No, looking at the patch, the patch is completely wrong.
> 
> Take for example mdiobus_register_gpiod(). Using devm_*() there is
> completely wrong, because this is called from mdiobus_register_device().
> This is not the probe function for the device, and thus there is no
> code to trigger the release of the resource on unregistration.
> 
> Moreover, when the mdiodev is eventually probed, if the driver fails
> or the driver is unbound, the GPIO will be released, but a reference
> will be left behind.
> 
> Using devm* with a struct device that is *not* currently being probed
> is fundamentally wrong - an abuse of devm.

The real question is: why on Earth is mdiobus_register_device() called 
_before_ the probe()? And mdiobus_unregister_device() after the remove()???

Anyways, in this case we could probably put the release of the GPIO into 
mdiobus_unregister_device() instead. But this inverted logic should 
probably be dealt with eventually.

Bence


