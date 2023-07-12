Return-Path: <netdev+bounces-17260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBBA750EB5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B75281ABD
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F914F73;
	Wed, 12 Jul 2023 16:39:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F311FCF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717BEC433C9;
	Wed, 12 Jul 2023 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689179965;
	bh=k8GGEKyGtTizvlzKcz2cYIOJibPG0QzEDyGItCmD5oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqVy6+MBRaLQ+CT6RhF906zPEzT8zIKMMLX/+a9OvH90uVauwYkj+cLy4okFWihWG
	 fSrphTswhdn1M5Q3GYr38bF0CjKCeKjqDs4mwsDtFG+bPbdVwVFGh6p1KgvFxqRf7u
	 6eudH1Atx5XQEDROI32UWKIrCV4dA7JTEhxk+6T4=
Date: Wed, 12 Jul 2023 18:39:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Oliver Neukum <oneukum@suse.com>, Enrico Mioso <mrkiko.rs@gmail.com>,
	Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Ilja Van Sprundel <ivansprundel@ioactive.com>,
	Joseph Tartaro <joseph.tartaro@ioactive.com>
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
Message-ID: <2023071222-asleep-vacancy-4cfa@gregkh>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
 <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr>
 <ZKM5nbDnKnFZLOlY@rivendell>
 <2023070430-fragment-remember-2fdd@gregkh>
 <e5a92f9c-2d56-00fc-5e01-56e7df8dc1c1@suse.com>
 <6a4a8980912380085ea628049b5e19e38bcd8e1d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4a8980912380085ea628049b5e19e38bcd8e1d.camel@sipsolutions.net>

On Wed, Jul 12, 2023 at 03:00:55PM +0200, Johannes Berg wrote:
> On Wed, 2023-07-12 at 11:22 +0200, Oliver Neukum wrote:
> > 
> > On 04.07.23 08:47, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 03, 2023 at 11:11:57PM +0200, Enrico Mioso wrote:
> > > > Hi all!!
> > > > 
> > > > I think the rndis_host USB driver might emit a warning in the dmesg, but disabling the driver wouldn't be a good idea.
> > > > The TP-Link MR6400 V1 LTE modem and also some ZTE modems integrated in routers do use this protocol.
> > > > 
> > > > We may also distinguish between these cases and devices you might plug in - as they pose different risk levels.
> > > 
> > > Again, you have to fully trust the other side of an RNDIS connection,
> > > any hints on how to have the kernel determine that?
> 
> > it is a network protocol. So this statement is kind of odd.
> > Are you saying that there are RNDIS messages that cannot be verified
> > for some reason, that still cannot be disclosed?
> 
> Agree, it's also just a USB device, so no special trickery with DMA,
> shared buffers, etc.
> 
> I mean, yeah, the RNDIS code is really old and almost certainly has a
> severe lack of input validation, but that still doesn't mean it's
> fundamentally impossible.

You all are going to make me have to write some exploits aren't you...

Ok, I'll put it on my todo list and do it before submitting this patch
again.

thanks,

greg k-h

