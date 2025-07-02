Return-Path: <netdev+bounces-203091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E8EAF07E9
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B021C07027
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D646145FE8;
	Wed,  2 Jul 2025 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAFl5gD1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F82F5E;
	Wed,  2 Jul 2025 01:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751419580; cv=none; b=FUeUTOv3PHN+hLghSktKMhgVTUQ31XimouaVo6mg4dYz3ehQYLkYptMa15KHm8vc/nJO4zC3X657NoDAIgZxHSr6TkWXIlbpIqblO01QDZhs6UTcl0WNe1obEMl4hVrZ9YTKFOPeshbVptuvSz5bSQKjPyNI/6s16aXlxdoVbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751419580; c=relaxed/simple;
	bh=kpNeMrG3Dt4hd8A0for0V8nnG/pC3jvPKfmzTIld6sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UunxqCgobFGG7gavkiltuLXJ/XgbGeXluLVCGftdZCDiBv6slrow1SGkiZLVKAcYVAVcz/vu+I1Woxb/pX/xviTcRzvZeFghngRt4yK5qbtISLwdMmag5/8cDAvZBZ7KkSqtkrPOWu05wgBvq8KY9NRRwmhzHkp756P3EWXCbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAFl5gD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D41C4CEEB;
	Wed,  2 Jul 2025 01:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751419578;
	bh=kpNeMrG3Dt4hd8A0for0V8nnG/pC3jvPKfmzTIld6sQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JAFl5gD1wB3U8t6EiLCi29YJ/X5QLu0Z63y6SqPAmuc/N2fMiP16+u7BL47rUV4Rp
	 vAlrSI6DVvVoOCceeh1E4Be/ZN5Br36iRp+779w22nlcJglSBB7RDOxPZ1fwGsv/iN
	 Vkoo7bjUwPWrxSmym682JDot3LKIiYXIYzXNgtq++Mq1EtGC7uQgSgIsiJB8mUa+Og
	 LLXcj2Xn8YETjw6lJN035doe3udvvTukOV12jWnyOvj00q73roMS0NSv2lgYoAVR5y
	 t2ov+K555lNCDDStMC5g6BO/C8ke7Lm5Vqc0YjCvUUDIFldczSu2Bb1oScjO7DamBv
	 WkFe5wl7tiNXw==
Date: Tue, 1 Jul 2025 18:26:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "Peter GJ. Park"
 <gyujoon.park@samsung.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: usbnet: fix use-after-free in race on
 workqueue
Message-ID: <20250701182617.07d6e437@kernel.org>
In-Reply-To: <ebd0bb9b-8e66-4119-b011-c1a737749fb2@suse.com>
References: <CGME20250625093354epcas1p1c9817df6e1d1599e8b4eb16c5715a6fd@epcas1p1.samsung.com>
	<20250625-usbnet-uaf-fix-v1-1-421eb05ae6ea@samsung.com>
	<87a7f8a6-71b1-4b90-abc7-0a680f2a99cf@redhat.com>
	<ebd0bb9b-8e66-4119-b011-c1a737749fb2@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Jul 2025 15:22:54 +0200 Oliver Neukum wrote:
> On 26.06.25 11:21, Paolo Abeni wrote:
> >>   drivers/net/usb/usbnet.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> >> index c04e715a4c2ade3bc5587b0df71643a25cf88c55..3c5d9ba7fa6660273137c80106746103f84f5a37 100644
> >> --- a/drivers/net/usb/usbnet.c
> >> +++ b/drivers/net/usb/usbnet.c
> >> @@ -1660,6 +1660,9 @@ void usbnet_disconnect (struct usb_interface *intf)
> >>   	usb_free_urb(dev->interrupt);
> >>   	kfree(dev->padding_pkt);
> >>   
> >> +	timer_delete_sync(&dev->delay);
> >> +	tasklet_kill(&dev->bh);
> >> +	cancel_work_sync(&dev->kevent);
> >>   	free_netdev(net);  
> > This happens after unregister_netdev(), which calls usbnet_stop() that
> > already performs the above cleanup. How the race is supposed to take place?  
> 
> That is indeed a core question, which we really need an answer to.
> Do I interpret dev_close_many() correctly, if I state that the
> ndo_stop() method will _not_ be called if the device has never been
> opened?

Correct, open and close are paired. Most drivers would crash if we
tried to close them before they ever got opened. 

> I am sorry to be a stickler here, but if that turns out to be true,
> usbnet is not the only driver that has this bug.

Shooting from the hip slightly, but its unusual for a driver to start
link monitoring before open. After all there can be no packets on a
device that's closed. Why not something like:

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 9564478a79cc..b75b0b5c3abc 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -896,6 +896,9 @@ int usbnet_open (struct net_device *net)
        int                     retval;
        const struct driver_info *info = dev->driver_info;
 
+       if (dev->driver_info->flags & FLAG_LINK_INTR)
+               usbnet_link_change(dev, 0, 0);
+
        if ((retval = usb_autopm_get_interface(dev->intf)) < 0) {
                netif_info(dev, ifup, dev->net,
                           "resumption fail (%d) usbnet usb-%s-%s, %s\n",
@@ -1862,8 +1865,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 
        netif_device_attach (net);
 
-       if (dev->driver_info->flags & FLAG_LINK_INTR)
-               usbnet_link_change(dev, 0, 0);
+       netif_carrier_off(net);
 
        return 0;
 

