Return-Path: <netdev+bounces-227362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23941BAD1B9
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 15:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC46E3C6A00
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CAE239E67;
	Tue, 30 Sep 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B9gonMAe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7C01CA84;
	Tue, 30 Sep 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240603; cv=none; b=Mc/ZzWnenfsIrUHigimLHSi2XtQ3f4yDuEYonujmxcHcd2t6Go92xGO21D1c98WSRFsR4BAKtBEx/Ie5HLYE2MUWx9RNr6vxVujWDrg9DPJcsEWMOUB7kZRMa43ju3Mg9g6xfn8BPZrqRsLqOaZA/B/RnSw7kPt9Molmn8llkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240603; c=relaxed/simple;
	bh=TP6Oq2U6AKFnwcT/5zuCHKSTlZBlk5VG/u3nYGA/P0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtQA6rWC2LKGEOxUVnVYFCgxp2XsA6WyTHTHx/3bhmhr68189oxH7LdXRz7ac0My96tkYTndTMDmNImhw00SNBRn7QB+6rVmRsvGm4MUqeX2PQrgu0hhtEiZpqtjPVwBHV1Hz6e37rK/0DkJ5/n08tN2c7g7Y58hCBkm6HItNbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B9gonMAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4422BC4CEF0;
	Tue, 30 Sep 2025 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759240602;
	bh=TP6Oq2U6AKFnwcT/5zuCHKSTlZBlk5VG/u3nYGA/P0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9gonMAeWq6OgRaTq7yvEz9/mWGQdHrdWR16/jBi8dkJwmIOAmnbNK4SNyo0pKmiS
	 lgBHbx6BIoDi5ybEZcoOEp3aStHhXzWFDom8QwnTlkRTT6WdWeZg6MKJbsgcAZOM3W
	 KBkHcTq4KJs9CXkkVQSvK7GLHcUUE59FYo9skucc=
Date: Tue, 30 Sep 2025 15:56:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Brownell <david-b@pacbell.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] rndis_host: Check for integer overflows in
 rndis_rx_fixup()
Message-ID: <2025093055-awoke-facedown-64d5@gregkh>
References: <aNvOh3f2B5g0eeRC@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNvOh3f2B5g0eeRC@stanley.mountain>

On Tue, Sep 30, 2025 at 03:35:19PM +0300, Dan Carpenter wrote:
> The "data_offset" and "data_len" values come from received skb->data so
> we don't trust them.  They are u32 types. Check that the "data_offset +
> data_len + 8" addition does not have an integer overflow.
> 
> Fixes: 64e049102d3d ("[PATCH] USB: usbnet (8/9) module for RNDIS devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/usb/rndis_host.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

David has passed away many years ago, odd that this was sent to him
given that get_maintainers.pl doesn't show it :(

> diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
> index 7b3739b29c8f..913aca6ff434 100644
> --- a/drivers/net/usb/rndis_host.c
> +++ b/drivers/net/usb/rndis_host.c
> @@ -513,8 +513,9 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
>  		data_len = le32_to_cpu(hdr->data_len);
>  
>  		/* don't choke if we see oob, per-packet data, etc */
> -		if (unlikely(msg_type != RNDIS_MSG_PACKET || skb->len < msg_len
> -				|| (data_offset + data_len + 8) > msg_len)) {
> +		if (unlikely(msg_type != RNDIS_MSG_PACKET || skb->len < msg_len ||
> +				size_add(data_offset, data_len) > U32_MAX - 8 ||
> +				(data_offset + data_len + 8) > msg_len)) {

Nice, I missed this in my old audit of this code (there's still lots of
other types of these bugs in this codebase, remember the rndis standard
says "there is no security", and should never be used by untrusted
devices.)

But will this work?  If size_add(x, y) wraps, it will return SIZE_MAX,
which we hope is bigger than (U32_MAX - 8)?  That feels fragile.

Then we do:
	skb_pull(skb, 8 + data_offset);
so if data_offset was huge, that doesn't really do anything, and then we
treat data_len independent of data_offset.  So even if that check
overflowed, I don't think anything "real" will happen here except a
packet is dropped.

or am I missing something elsewhere in this function?

thanks,

greg k-h

