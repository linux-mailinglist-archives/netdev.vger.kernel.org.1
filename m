Return-Path: <netdev+bounces-242328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C64C8F40A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AA504E7DE7
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E0296BC2;
	Thu, 27 Nov 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0F/8lGzb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D806254B19;
	Thu, 27 Nov 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256826; cv=none; b=B1AwBuzyNWOOwu0sl72JhRke1zQQN9Z/ubRyjIwq9Mv1J3pAhPfrRf+dLtkXA4iabnj0TO6Npozw6/wetJ2p9emtbeYFUTp2hvMOjTVuu509Lj4znKUxjBqz+8NKVK43xHgGQ2t326N8zaIjEURU4NtXQL7YuEvEyqoVoe5eeag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256826; c=relaxed/simple;
	bh=xqRunuevmmfFKidkTCWnTlY5sOaxP7ZKZklDajSh+OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lauN3wWQCtW/ckdyG4u6rghqZ73bZ/siTqOcEXZHwWR2oJKHbqM8ZM9OteCsKscd/ohK/EjBCwKVUDwLaom4bD36536qYWEVKX7MoVL9+dBt54r2ImH2w90G2dneX6rJZjBtzCQVHEl/LGRicQKiZr6tOfTQJCdlXEfWFmkr9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0F/8lGzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C741C4CEF8;
	Thu, 27 Nov 2025 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764256826;
	bh=xqRunuevmmfFKidkTCWnTlY5sOaxP7ZKZklDajSh+OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0F/8lGzbC9PyxV1j6N95sbzvghGCGLCXOUTkmkhql0IYICyC/xwRC+JNwziycD0Sq
	 akXMyMpRWeXmUfuS1RGS9tu/LpYjupw5PhczQ2SgpNwaR1PdyURXLVTVllijFNvlv9
	 jBN3iMsJeYU2+KniP3gKdmTaVkz+zyFdNx4jzhKQ=
Date: Thu, 27 Nov 2025 16:20:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: ssrane_b23@ee.vjti.ac.in
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Arvid Brodin <arvid.brodin@alten.se>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
Subject: Re: [PATCH] hsr: fix NULL pointer dereference in skb_clone with hw
 tag insertion
Message-ID: <2025112706-deafness-agreeable-2e34@gregkh>
References: <20251125210158.224431-1-ssranevjti@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125210158.224431-1-ssranevjti@gmail.com>

On Wed, Nov 26, 2025 at 02:31:58AM +0530, ssrane_b23@ee.vjti.ac.in wrote:
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> 
> When hardware HSR tag insertion is enabled (NETIF_F_HW_HSR_TAG_INS) and
> frame->skb_std is NULL, both hsr_create_tagged_frame() and
> prp_create_tagged_frame() will call skb_clone() with a NULL skb pointer,
> causing a kernel crash.
> 
> Fix this by adding NULL checks for frame->skb_std before calling
> skb_clone() in the functions.
> 
> Reported-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
> Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
>  net/hsr/hsr_forward.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 339f0d220212..4c1a311b900f 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -211,6 +211,9 @@ struct sk_buff *prp_get_untagged_frame(struct hsr_frame_info *frame,
>  				  __FILE__, __LINE__, port->dev->name);
>  			return NULL;
>  		}
> +
> +		if (!frame->skb_std)
> +			return NULL;
>  	}
>  
>  	return skb_clone(frame->skb_std, GFP_ATOMIC);
> @@ -341,6 +344,8 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  		hsr_set_path_id(frame, hsr_ethhdr, port);
>  		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
>  	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
> +		if (!frame->skb_std)
> +			return NULL;
>  		return skb_clone(frame->skb_std, GFP_ATOMIC);
>  	}
>  
> @@ -385,6 +390,8 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
>  		}
>  		return skb_clone(frame->skb_prp, GFP_ATOMIC);
>  	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
> +		if (!frame->skb_std)
> +			return NULL;
>  		return skb_clone(frame->skb_std, GFP_ATOMIC);
>  	}
>  
> -- 
> 2.34.1
> 
> 
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

