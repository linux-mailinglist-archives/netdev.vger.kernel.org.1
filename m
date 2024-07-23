Return-Path: <netdev+bounces-112648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D793A50F
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD21B21501
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B6D158211;
	Tue, 23 Jul 2024 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uzh2iFxa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391217BD5;
	Tue, 23 Jul 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756401; cv=none; b=GFFfwCR1jnToEIPBEwIu7q/NKTN8msqpbkZYiasPmjok3RhrC5WckxmY1OXfW2X1mRfbOxscXxHK3kb1W26eWyH2C8Sl1olfIIjH45O4eUZlWuZfAJ+uxN/WC/xkO9yUknAXnLPAOMzPeiGfbqbHk8fzru4uVIicB9eVnMLtO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756401; c=relaxed/simple;
	bh=k62VeAoHH8lCF5hx8/k4n/zp2H8BcrDm5gJHwtb0jgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5kdPvALsZ5b6CQaoL+zxUzAgCDGSYk6VtTan8ieZwng1qStZ76/JOxe/mt2jeoxi98y4Mqgqg+PaWdUt4T2mmvhGyckJZmIBw3JcYmxhVf3OJH5RJWGODHVJ77vvaNrOp8a0v4rVHaaEWshjUC32zaBsKlchiOSeeCUDEDa3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uzh2iFxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D789CC4AF09;
	Tue, 23 Jul 2024 17:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721756400;
	bh=k62VeAoHH8lCF5hx8/k4n/zp2H8BcrDm5gJHwtb0jgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uzh2iFxatpm53y4VThRuKF64ODiCWyx+pcc/TNxvkxc8qh+sTkJZkgwfoIpKwMnRd
	 eFixgOBDb8oOXQFYIPyFHkajBiazpNN0aciYUg41ljHAABJYFRS6VDZsab+zm35wnm
	 pvpQPfvj8lQh0OnhVyCvabYOB5/ePB6FJw+oATNQySvJqdRx7YhCHVjpyQYqsNx+lM
	 ZFzNvtMW1hfBNMS/ZON47LeRq2mtwfibuaDcfpWU8+At5zdHHW9ZmuMc6Xw7wxGiqP
	 xEwEJYx05F2HBWdyKXfSNN1+eaUo1+SpnTWGuEJQPwGSizuB07TAmwfnjmUCH+tA9q
	 HizOj1auiZrdA==
Date: Tue, 23 Jul 2024 18:39:56 +0100
From: Simon Horman <horms@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, liujunliang_ljl@163.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB2NET: SR9700: fix uninitialized variable use in
 sr_mdio_read
Message-ID: <20240723173956.GA97837@kernel.org>
References: <20240723140434.1330255-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723140434.1330255-1-make24@iscas.ac.cn>

On Tue, Jul 23, 2024 at 10:04:34PM +0800, Ma Ke wrote:
> It could lead to error happen because the variable res is not updated if
> the call to sr_share_read_word returns an error. In this particular case
> error code was returned and res stayed uninitialized.
> 
> This can be avoided by checking the return value of sr_share_read_word
> and propagating the error if the read operation failed.
> 
> Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Hi Ma Ke,

As this is a fix, with a fixes tag (good!), it should probably be targeted
at the net tree (as opposed to net-next). The target tree for
networking patches should be included in the Subject.

	Subject: [PATCH net] ...

Looking at git history, it seems that an appropriate prefix for this patch
would be net: "net: usb: sr9700: "

	Subject: [PATCH net] net: usb: sr9700: ...

And, skipping ahead, please do consider reading, especially the bit about 24h.
https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  drivers/net/usb/sr9700.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
> index 0a662e42ed96..d5bc596f4521 100644
> --- a/drivers/net/usb/sr9700.c
> +++ b/drivers/net/usb/sr9700.c
> @@ -179,6 +179,7 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
>  	struct usbnet *dev = netdev_priv(netdev);
>  	__le16 res;
>  	int rc = 0;
> +	int err;
>  
>  	if (phy_id) {
>  		netdev_dbg(netdev, "Only internal phy supported\n");
> @@ -193,7 +194,10 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
>  		if (value & NSR_LINKST)
>  			rc = 1;
>  	}
> -	sr_share_read_word(dev, 1, loc, &res);
> +	err = sr_share_read_word(dev, 1, loc, &res);
> +	if (err < 0)
> +		return err;
> +

I agree that this fixes a possible error condition.
But I wonder if there are not more similar problems in this
file. E.g. the call to sr_read_reg() which seeds value
which is used at the top of this hunk.

>  	if (rc == 1)
>  		res = le16_to_cpu(res) | BMSR_LSTATUS;
>  	else
> -- 
> 2.25.1
> 
> 

