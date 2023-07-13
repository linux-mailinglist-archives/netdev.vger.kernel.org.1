Return-Path: <netdev+bounces-17413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CB07517FC
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AEB281B71
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8553A4;
	Thu, 13 Jul 2023 05:21:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335FA5660
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D6FC433C8;
	Thu, 13 Jul 2023 05:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689225696;
	bh=wQyN/phaMAVOufua/AruswFV26dN3USZ1Q3/Ucif1mA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hwpk+OKSW6E3452BnVFbO2AWkzxQJJLV+ONr+xTPIjLIzuKalVaFMxWF/CKKfpjKU
	 bk1+eQpIS139fe2KkkwWXtqct7iu30cY2yj775yhuQY/CRyY0NC3BplUUiKZdX29Wn
	 5ECNjy78cmEVX8vTFRq3Ff8kzdamfdkJV8oHSe61T5B1EPLZ+EMuFEgk/VXYqM0Szg
	 BABdEpyK9CatPJMdo7X1m5Qk5qO8AXokY3ayWZjpUqgR3pnx9mAVKaXMn5goHGk7yt
	 iy4qR+JDPx7L9rnYm+kCulQwSC2nOXGDbtds2LNbCXLcflYkywa1/qcnlqb1x8Mxxh
	 6C+ma5mH7MEZw==
Date: Thu, 13 Jul 2023 07:21:28 +0200
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Enrico Mioso <mrkiko.rs@gmail.com>, Jan Engelhardt <jengelh@inai.de>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>, Oleksij Rempel
 <linux@rempel-privat.de>, Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=
 <maze@google.com>, Neil Armstrong <neil.armstrong@linaro.org>, Andrzej
 Pietrasiewicz <andrzejtp2010@gmail.com>, Jacopo Mondi <jacopo@jmondi.org>,
 =?UTF-8?B?xYF1a2Fzeg==?= Stelmach <l.stelmach@samsung.com>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, Ilja Van Sprundel
 <ivansprundel@ioactive.com>, Joseph Tartaro <joseph.tartaro@ioactive.com>
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
Message-ID: <20230713072128.4f4bd9cd@coco.lan>
In-Reply-To: <2023070430-fragment-remember-2fdd@gregkh>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
	<n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr>
	<ZKM5nbDnKnFZLOlY@rivendell>
	<2023070430-fragment-remember-2fdd@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 4 Jul 2023 07:47:31 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, Jul 03, 2023 at 11:11:57PM +0200, Enrico Mioso wrote:
> > Hi all!!
> > 
> > I think the rndis_host USB driver might emit a warning in the dmesg, but disabling the driver wouldn't be a good idea.
> > The TP-Link MR6400 V1 LTE modem and also some ZTE modems integrated in routers do use this protocol.
> > 
> > We may also distinguish between these cases and devices you might plug in - as they pose different risk levels.  
> 
> Again, you have to fully trust the other side of an RNDIS connection,
> any hints on how to have the kernel determine that?

Kernel may not know but the user does.

See, when doing a security risk assessment, one needs to evaluate the
risks, the costs to implement mitigation issues, and the measures that
will be taken. Sometimes, the measure is to just accept the risk, as
either the chances to actually happen on a particular scenario is 
very unlikely, and/or the costs to mitigate are too high.

In any case, it should not be up to Kernel developers to do risk
assessment, as this has to be checked case by case.

For instance I usually disable several the security options on my
slow test devices, as the risk to run untrusted code on them
while I'm testing a new Kernel I just built is close to zero
and doesn't pay off the the extra hours I'll be wasting otherwise.

In the specific case of untrusted USB devices, the risk of having 
USB untrusted sticks connected to my desktop machine is very low, 
and if a criminal breaks into my house to be close enough to plug an
USB device, I would have a lot more to be concerned than just my PC.

Granted, the risk is higher on laptops and mobile devices, but
still it might be acceptable on some use cases.

Maybe a compromise would be to add a modprobe parameter and/or
a Kconfig option to allow enabling RDNIS host and RDNIS gadget
support at the security options to let the user select what 
kind of risks he's willing to take.

Thanks,
Mauro

