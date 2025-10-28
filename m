Return-Path: <netdev+bounces-233511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16C7C14A32
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C28582D7B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC47306B0C;
	Tue, 28 Oct 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/AO2EjB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC72C15AE;
	Tue, 28 Oct 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654754; cv=none; b=d/1rHTi3Jdf2X8EQN15P4Yf+ti9KowL2lcxj7kqC/v9kd3zsKzMrZWEDxKCSau1zcO+oODTwGIOfgObQksnHD3Esds6ThylMbAhg9nX5iNphOcAhDYpJgPpk5afZcm59SgYH1clovSkg4Vu4Q2FFVHidRk2S5R+D0H0qiW/EDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654754; c=relaxed/simple;
	bh=2A7U/X5bLGA6vGpMY0H0RP01Pafks7/ACnaqbh4msvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5ITYMXX05w90IhUu3c/DNmjB7XK1ZAgdVDcFUXCwos7Ng1+WJlWsMsy6i0Y+bFJkRH80dFYs3j+kmhx02gM6q+SeyZfAL+mvAkVbWsaCSzA1ZsNISxMUhVnWA88Nu2/D96P8wymMU2WTBkwNM19k83qpdwxP/vWRLZXGXTFxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/AO2EjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9A1C4CEE7;
	Tue, 28 Oct 2025 12:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761654754;
	bh=2A7U/X5bLGA6vGpMY0H0RP01Pafks7/ACnaqbh4msvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/AO2EjBDdD6gU1Al30ZhJgdqArLSUE1GQM9Qq1GmqLdi0GFH0LacO5Q0lEDq7X5D
	 Cphkdqw7x+iz/xNRGByikfeXX2EPUFNpOwEbToHhF+g2xXK0uZjfY8Z4bHPezTcNHb
	 mFmjAkEE+AW2dVhrSAZeV00RWGEyPNrtEWokM2JwTTiv4+tFGugD5l8YUCCtdJE4IZ
	 x0LDu5gIsFPPdgGsZz36Hv3VtMef7jcKdZfXBboPYsss6tTKr78VIXBetLxo80q3PB
	 a3T6f2SWkWRNv/lDCacUQhuC1w3UBjfThbff8dcE3+SJBUwewiOIhIoV4+/tR4xy/k
	 s4VUtDyTGZkOw==
Date: Tue, 28 Oct 2025 12:32:31 +0000
From: Simon Horman <horms@kernel.org>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] isdn: mISDN: hfcsusb: fix memory leak in
 hfcsusb_probe()
Message-ID: <aQC333bzOkMNOFAG@horms.kernel.org>
References: <20251024173458.283837-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024173458.283837-1-nihaal@cse.iitm.ac.in>

On Fri, Oct 24, 2025 at 11:04:55PM +0530, Abdun Nihaal wrote:
> In hfcsusb_probe(), the memory allocated for ctrl_urb gets leaked when
> setup_instance() fails with an error code. Fix that by freeing the urb
> before freeing the hw structure.
> 
> Fixes: 69f52adb2d53 ("mISDN: Add HFC USB driver")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Thanks,

I agree that this is a bug, and that it was introduced in the cited commit.

I think it would be good to add something to the commit message
regarding how the problem was found, e.g. which tool was used, or
by inspection; and what testing has been done, e.g. compile tested only.

> ---
>  drivers/isdn/hardware/mISDN/hfcsusb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c

...

> @@ -2109,8 +2108,11 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  		hw->name, __func__, driver_info->vend_name,
>  		conf_str[small_match], ifnum, alt_used);
>  
> -	if (setup_instance(hw, dev->dev.parent))
> +	if (setup_instance(hw, dev->dev.parent)) {
> +		usb_free_urb(hw->ctrl_urb);
> +		kfree(hw);
>  		return -EIO;
> +	}
>  
>  	hw->intf = intf;
>  	usb_set_intfdata(hw->intf, hw);

I think it would be best to follow the idiomatic pattern and
introduce a ladder of goto statements to handle unwind on error.

Something like this (compile tested only!):

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1921,6 +1920,7 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		probe_alt_setting, vend_idx, cfg_used, *vcf, attr, cfg_found,
 		ep_addr, cmptbl[16], small_match, iso_packet_size, packet_size,
 		alt_used = 0;
+	int err;
 
 	vend_idx = 0xffff;
 	for (i = 0; hfcsusb_idtab[i].idVendor; i++) {
@@ -2101,20 +2101,28 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (!hw->ctrl_urb) {
 		pr_warn("%s: No memory for control urb\n",
 			driver_info->vend_name);
-		kfree(hw);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_free_urb;
 	}
 
 	pr_info("%s: %s: detected \"%s\" (%s, if=%d alt=%d)\n",
 		hw->name, __func__, driver_info->vend_name,
 		conf_str[small_match], ifnum, alt_used);
 
-	if (setup_instance(hw, dev->dev.parent))
-		return -EIO;
+	if (setup_instance(hw, dev->dev.parent)) {
+		err = -EIO;
+		goto err_free_hw;
+	}
 
 	hw->intf = intf;
 	usb_set_intfdata(hw->intf, hw);
 	return 0;
+
+err_free_urb:
+	usb_free_urb(hw->ctrl_urb);
+err_free_hw:
+	kfree(hw);
+	return err;
 }
 
 /* function called when an active device is removed */

