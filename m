Return-Path: <netdev+bounces-148293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76339E10B7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1870B22474
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 01:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3F718B03;
	Tue,  3 Dec 2024 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="aMxtg+jE"
X-Original-To: netdev@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF858F6C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188741; cv=none; b=OU/+RezuY66v55qFkh5mRjvZA2RdmEfZv3dz25bHV5ymlQLRzSyTgFr/5K3/MVgu0BGcOcNW4KRB8d93pFtn891DCbwFr+K7Y6sZ9iyRVjF1nauLgxweDRu7SjHboxZ0XaBOtG6yW4dS0kqi5uPzXdzfs/v/uvkZdsAo7fJAdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188741; c=relaxed/simple;
	bh=nFoODvfRNK27hduHJ3EejOGVFGhgYYnWL/dj8jJTvqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDC/guZm9N9x/NaUTU872d6tQt1Kswk2KHPGnpGVAf3RN2Z4k8LNJXas7SSulql7moNMhm1q25n++NtFO6JFlBYi3+mwi9rDfCWm8JRbmxCc2t7++lgumSCQC/4PUa2rdpByYD/zJfkWAIzFrHCQlVmEV84e6mMjWmHZ8ZTqKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=aMxtg+jE; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=aMxtg+jE;
	dkim-atps=neutral
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 532E1356
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 10:18:58 +0900 (JST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fc06d0af36so1910900a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 17:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1733188737; x=1733793537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUK3lIjW2mtu9OdkpcRaNahDpTzb46cHX8u8XAHNwXk=;
        b=aMxtg+jEQurTcZTP0kn8QF4NiJo+MDA2dIFOzfW9lCQWIKc/vWGuvHQNS1mlIVlHuS
         h54zK3TgsnW+DPNieV0aVsnUt3Y+F3fNYaPov6QrciYlJdsTDUhQcdFoDf+OXz+gUtx+
         Jvv4aN/IDeHms2PaSXCcEG5f9UuJq8QDU2fzEbUm+j+bfkGX4i6LkmSJa+/lbs7FFbwL
         yUxVkEtOetl34cHRY3Mi4j+u4zOYazpQHoUnbbeZDPt85deq8LV76EM0rz85iig1Avwm
         8vi17wyWWMkHmECMl40AisxR/ZrNdlBdt+GcJJzAceEcaWKkYQgcYO6wsay8mOs1h4t7
         rkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733188737; x=1733793537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUK3lIjW2mtu9OdkpcRaNahDpTzb46cHX8u8XAHNwXk=;
        b=baqvRWkHYgu77TDqh8gGRs+VfThHdXJgZtgUPbAkBdZlfLj7wSNNLDz4QMorISz7Ep
         AV7swmasjj9I9KJWrgr7gSqP8WOtI+zZmN3b0wel+yv6O9UtFFbJgEYiiGzCmqlgBMCi
         +UYi3oqC2SM66cGj9JBr6la5FxvjIfB4oprK6G/qJZlUnTk/OviBUyVIvfM0dvk62rAq
         bLZyPdu7o57rSXujiFtrS+keXOyFBXBxxw/6F5Wy8X8BgCLUxvXO5/tOm9MDfCo7HEyL
         xQMUBobb0gq6KmLhR80dcetsG27267xL4tFmVGiNVoYl1t0X93/cbkMKY5j4Ybz14idj
         bxZw==
X-Forwarded-Encrypted: i=1; AJvYcCUCGvmYepKVTDZQY7wA66mTXv1c2SeqLErUPcc25s5nRuPrYN04IVEiFs3B9WcY/w9BCGOP70w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1T5o0m9rntKmj3i8aSpLMUlFfh3GUiil75wZOWWy+juJhNyfn
	DKzaWNSMVLtikPgetVv5yJHh7BR40IV5ANPVoBA2a/7gqTqFIWIOu57yfA3hPOxKf8JKgOPWo+R
	WX+5RP/0LnmCbj8gqaXqNZL70CyWuayGs5nIGWeITUfE9KxFj2eqvl53SVpt4oQM=
X-Gm-Gg: ASbGncv+VgNlKKzyJW3UAlDnw0/7+wKkMGcqAgu94eVhVZKOx4+mrkzAF0TRLk7YjnR
	+Kei/95ijrrrnBvTFMIS8r2mP9T2CULvCrcCIbEV5MPzg2D3Rzzu7pvJY5Q01LZN06auTl5a31T
	bRifaypItRybWvuRfAxRyoqY2Fg7yUaRv1qQg1m6j6ZbSVn3MozKP+jWq7bSfwaHCKpBEbBagli
	O3cO6B6Iq1BHAW5Z6y0/Key7wyxCZaszkhYXOzzY/jjh4CIMDAV13WfqaDMb6z86al2R7Fq/Zga
	MMxXRZvaDY1EWw1O2d2IbdJldlkIcj69Vw==
X-Received: by 2002:a05:6a21:1805:b0:1e0:d533:cb38 with SMTP id adf61e73a8af0-1e1653a65efmr1177253637.3.1733188737352;
        Mon, 02 Dec 2024 17:18:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ6hs8UpOjhz2kjqcAkXmQbvgV9PZitR1HJ6l2YpZhktvKaCMIF4HXVFScoqYtpnuvt6ctZQ==
X-Received: by 2002:a05:6a21:1805:b0:1e0:d533:cb38 with SMTP id adf61e73a8af0-1e1653a65efmr1177225637.3.1733188736991;
        Mon, 02 Dec 2024 17:18:56 -0800 (PST)
Received: from localhost (145.82.198.104.bc.googleusercontent.com. [104.198.82.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2157597c2f6sm36224225ad.204.2024.12.02.17.18.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2024 17:18:56 -0800 (PST)
Date: Tue, 3 Dec 2024 10:18:44 +0900
From: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Laight <David.Laight@aculab.com>,
	Oliver Neukum <oneukum@suse.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <Z05cdCEgqyea-qBD@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
 <Z00udyMgW6XnAw6h@atmark-techno.com>
 <e53631b5108b4d0fb796da2a56bc137f@AcuMS.aculab.com>
 <Z01xo_7lbjTVkLRt@atmark-techno.com>
 <20241202065600.4d98a3fe@kernel.org>
 <Z05FQ-Z6yv16lSnY@atmark-techno.com>
 <20241202162653.62e420c5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202162653.62e420c5@kernel.org>

Jakub Kicinski wrote on Mon, Dec 02, 2024 at 04:26:53PM -0800:
> > My problematic device here has FLAG_POINTTOPOINT and a (locally
> > admistered) mac address set, so it was not renamed up till now,
> > but the new check makes the locally admistered mac address being set
> > mean that it is no longer eligible to keep the usbX name.
> 
> Ideally, udev would be the best option, like Greg said.
> This driver is already a fragile pile of workarounds.

Right, as I replied to Greg I'm fine with this as long as it's what was
intended.

Half of the reason I sent the mail in the first place is I don't
understand what commit 8a7d12d674ac ("net: usb: usbnet: fix name
regression") actually fixes: the commit message desribes something about
mac address not being set before bind() but the code does not change
what address is looked at (net->dev_addr), just which bits of the
address is checked; and I don't see what which bytes are being looked at
changing has anything to do with the "fixed" commit bab8eb0dd4cb9 ("usbnet:
modern method to get random MAC")
... And now we've started discussing this and I understand the check
better, I also don't see what having a mac set by the previous driver
has to do with the link not being P2P either.


(The other half was I was wondering what kind of policy stable would have
for this kind of things, but that was made clear enough)


> If you really really want the old behavior tho, let's convert 
> the zero check to  !is_zero_ether_addr() && !is_local_ether_addr().

As far as I understand, !is_local_ether_addr (mac[0] & 0x2) implies
!is_zero_ether_addr (all bits of mac or'd), so that'd get us back to
exactly the old check.

> Maybe factor out the P2P + address validation to a helper because
> the && vs || is getting complicated.

... And I can definitely relate to this part :)

So:
- final behavior wise I have no strong feeling, we'll fix our userspace
(... and documentation) whatever is decided here
- let's improve the comment and factor the check anyway.
As said above I don't understand why having a mac set matters, if that
can be explained I'll be happy to send a patch.
Or if we go with the local address version, something like the
following?

----
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 44179f4e807f..240ae86adf08 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -178,6 +178,13 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 }
 EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
 
+static bool usbnet_dev_is_two_host (struct usbnet *dev, struct net_device *net)
+{
+	/* device is marked point-to-point with a local mac address */
+	return (dev->driver_info->flags & FLAG_POINTTOPOINT) != 0 &&
+		is_local_ether_addr(net->dev_addr);
+}
+
 static void intr_complete (struct urb *urb)
 {
 	struct usbnet	*dev = urb->context;
@@ -1762,13 +1769,10 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		if (status < 0)
 			goto out1;
 
-		// heuristic:  "usb%d" for links we know are two-host,
-		// else "eth%d" when there's reasonable doubt.  userspace
-		// can rename the link if it knows better.
+		/* heuristic: rename to "eth%d" if we are not sure this link
+		 * is two-host (these links keep "usb%d") */
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
-		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     /* somebody touched it*/
-		     !is_zero_ether_addr(net->dev_addr)))
+		    !usbnet_dev_is_two_host(dev, net))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
----

Thanks,
-- 
Dominique

