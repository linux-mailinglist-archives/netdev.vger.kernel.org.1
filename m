Return-Path: <netdev+bounces-112716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA393AC03
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 06:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47101C22467
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 04:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7242421D;
	Wed, 24 Jul 2024 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OGGscUPj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E84A35;
	Wed, 24 Jul 2024 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721796402; cv=none; b=HfVmIa1tAdvRInwfa7+XFmAFR/DvXHamL1Iy1oDj1lNfAjxVTjKJfF8BUhu9uIkqeaU/CHUSI65bZHPkA/BDEl+RRQcrt7uwE0Rd+CSy6IoefKwY/I/RW4u2o3k3ijQjLNbWylXMZCu+XvRIVLxw5g9TlymIVEIeJzAXtNg4jkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721796402; c=relaxed/simple;
	bh=dd8dMxMcSNia49oSuAPjZ7+AGLNZdMhtCcNuGyypI8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGG08Hi0R4gHQ681oqbx1FJ/cZKCUdzcLoN2YOiT/zu4bwLrDdhvZFfFmWcqGkJrM8eQP6GUx/U28shZoCOPC8UZCpRz/OXiDR+QwBQOexoO1qPU/LtXC2TY6YmBr9Nip9VNDJwH+oHzvoi162Q51ymizpWFe+bTfpudov0faR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OGGscUPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C1EC32782;
	Wed, 24 Jul 2024 04:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721796402;
	bh=dd8dMxMcSNia49oSuAPjZ7+AGLNZdMhtCcNuGyypI8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGGscUPjiaC27BvRamKWP+qtNrxmyNPkBnZKsSha//5brV2wZUEDMxvh8UsMJzx3R
	 Vra5R3kygN8L9vaSJQl9Jr8e4e+4NJ8bVCxMCRyNzjQqVPNBh+5nrbuKg1iqJ0hBoz
	 LkMi7nDOuWshiMnpm8q8v3nPZjuuo68+AjoHQkG4=
Date: Wed, 24 Jul 2024 06:46:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, liujunliang_ljl@163.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: usb: sr9700: fix uninitialized variable use
 in sr_mdio_read
Message-ID: <2024072426-limping-recycler-5c29@gregkh>
References: <20240724011554.1445989-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724011554.1445989-1-make24@iscas.ac.cn>

On Wed, Jul 24, 2024 at 09:15:54AM +0800, Ma Ke wrote:
> It could lead to error happen because the variable res is not updated if
> the call to sr_share_read_word returns an error. In this particular case
> error code was returned and res stayed uninitialized.
> 
> This can be avoided by checking the return value of sr_share_read_word
> and propagating the error if the read operation failed.
> 
> Found by code review.
> 
> Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the subject as suggestions.
> ---
>  drivers/net/usb/sr9700.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

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

