Return-Path: <netdev+bounces-194621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0CCACB86F
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 17:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44324C6A27
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86015221F39;
	Mon,  2 Jun 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZIMvn2m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7312C324F;
	Mon,  2 Jun 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877625; cv=none; b=kjrIBBwLwJPkt1M+jsqr4l/p08TuExAycC307UmBkaYOYKu8xkLVFnYPpfX4fEgisOzdSSCzQpM3+NTEYszp4u6K1Evn/lAzIBR/a6voLNLD2DF0jjGEs3gJcf+tbiwhRV+lbCWVKXiCGPNiS77/qjeYRltjopY9CU0Q140uGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877625; c=relaxed/simple;
	bh=LBvVJzBurNPCarKvFZHqCf5wBt/aqypiHh6rcfLGFjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK0ZGgbgj6i1CLG6m5uQ6dgeS3AvEjCh9SWwO59hgBx7/iv7spAEBYss628IMbKNDavwVsvA0CTFASOCxBFP5hWZL0QeLnjTESvstlEqOzNj6BzDMa6gjAVTl/dvGU3mjaUDq43q8G0/qDNaCi1Cee2Gg5VY1WJXjOgR1pc3b1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZIMvn2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A560AC4CEEB;
	Mon,  2 Jun 2025 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877625;
	bh=LBvVJzBurNPCarKvFZHqCf5wBt/aqypiHh6rcfLGFjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZIMvn2mcWNwwcQ3IRcFXLfSbxIHZXrkZ7tcYsMWKpP5tuS/WHaHLN2jO+A51/mB0
	 F4cfsJzjTTpblwHkAAe4G12Ld26VjyifNb1RxFGg/70eRTMYnx3hqgcv19AXsJcG5C
	 WOs9qkkvyuSCcy5WDbkmF1GEQ3O6ebrSObH/AfY4=
Date: Mon, 2 Jun 2025 16:07:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	keescook@chromium.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net: randomize layout of struct net_device
Message-ID: <2025060239-delirium-nephew-e37c@gregkh>
References: <20250602135932.464194-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602135932.464194-1-pranav.tyagi03@gmail.com>

On Mon, Jun 02, 2025 at 07:29:32PM +0530, Pranav Tyagi wrote:
> Add __randomize_layout to struct net_device to support structure layout
> randomization if CONFIG_RANDSTRUCT is enabled else the macro expands to
> do nothing. This enhances kernel protection by making it harder to
> predict the memory layout of this structure.
> 
> Link: https://github.com/KSPP/linux/issues/188
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  include/linux/netdevice.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7ea022750e4e..0caff664ef3a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2077,7 +2077,11 @@ enum netdev_reg_state {
>   *	moves out.
>   */
>  
> +#ifdef CONFIG_RANDSTRUCT
> +struct __randomize_layout net_device {
> +#else
>  struct net_device {
> +#endif

Are you sure the #ifdef is needed?

thanks,

greg k-h

