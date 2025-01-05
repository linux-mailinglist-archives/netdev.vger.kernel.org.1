Return-Path: <netdev+bounces-155254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E13A01875
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 08:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2FF3A265A
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390CE13A25B;
	Sun,  5 Jan 2025 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zVgiNUKv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A3C80027;
	Sun,  5 Jan 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736063178; cv=none; b=hcFnjvQ9+g7w+q2dtUgNVhh+wIMnl/NoeJJsPWQ+ZOKM3PQRJYtzNmEDzJYCZjPvJqnVmcOrwAw9cuPbZhMlP3i+zoz9biCubsHYpxgOmPvXnWn0Av+HAui3v/mEBKtxQDKSosCwm+YVkW7/BAsxmGuz6qIDuWcGsJ6Ez8+QJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736063178; c=relaxed/simple;
	bh=x2AKfZF9mrKKNFRFVOUAHFWR0s/hhv0GEwZQqQfLOqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT5nK0EdfELiISghCX1V/SmwoixHMO6gPafzlw2ybI36Xte7qd3Swy6SU2+pG2lNETRm/tkVuAteNFLwBMm3s69xKvT+pT85cLhaLFYKjt6LrST9+BfO07FroDEpZqNaEL3F6NV6YRHhjiRwhWEMGQI8QTxjChaWtJaZqDqzB88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zVgiNUKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B775FC4CED0;
	Sun,  5 Jan 2025 07:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736063177;
	bh=x2AKfZF9mrKKNFRFVOUAHFWR0s/hhv0GEwZQqQfLOqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zVgiNUKvJMR+r/EtkmnaHaUM6FnIXm8uAb7Y2C+/VmQVO4x+AXaWVa5EPVIFJ7+OQ
	 E7tIVKKiW6uh/xyJDP8qGVvFUhoe+Dk4aGG3ItswzpzRFAGeIQGeRTwNEhWUB6yrPh
	 dPKvECiXerAuTsR63Uyp3gaHqpvkUbs1dEZyYpSA=
Date: Sun, 5 Jan 2025 08:46:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Foster Snowhill <forst@pen.gy>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
	Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v4 6/7] usbnet: ipheth: fix DPE OoB read
Message-ID: <2025010558-lining-paralysis-e618@gregkh>
References: <20250105010121.12546-1-forst@pen.gy>
 <20250105010121.12546-7-forst@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105010121.12546-7-forst@pen.gy>

On Sun, Jan 05, 2025 at 02:01:20AM +0100, Foster Snowhill wrote:
> Fix an out-of-bounds DPE read, limit the number of processed DPEs to
> the amount that fits into the fixed-size NDP16 header.
> 
> Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
> Signed-off-by: Foster Snowhill <forst@pen.gy>
> ---
> v4:
>     Split from "usbnet: ipheth: refactor NCM datagram loop, fix DPE OoB
>     read" in v3. This commit is responsible for addressing the potential
>     OoB read.
> v3: https://lore.kernel.org/netdev/20241123235432.821220-5-forst@pen.gy/
>     Split out from a monolithic patch in v2 as an atomic change.
> v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
>     No code changes. Update commit message to further clarify that
>     `ipheth` is not and does not aim to be a complete or spec-compliant
>     CDC NCM implementation.
> v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
> ---
>  drivers/net/usb/ipheth.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

