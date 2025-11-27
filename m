Return-Path: <netdev+bounces-242320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D182C8F001
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8D43B6BED
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99694334688;
	Thu, 27 Nov 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO6uO4Ov"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C4334682;
	Thu, 27 Nov 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255290; cv=none; b=WuQ0mxXMZyIitp9godKSFSSsNbf3udbqnxO7F+lId1fl0wABW68+o/+66IKr7NXB/pBRu332wjZUzADJz2GegZqJiw6+mbD6vXFd7Ux5e3C4bAFqPaEl2A3GKU1hk1qnMQfIQ7i6iVrDjoOqB3jUmdypUqlux7hyGaGi/QpiAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255290; c=relaxed/simple;
	bh=0omifDIQ9EQQ9hAte5EAHzlbV87m/Usi07cZUQL4yv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZXCTfiTx+2UdZKQN4GI+1yERFhKFTUWXpE7dNcrnJTiEc1+9oxcPEaJWfyF6SGEI/mZV9ZHdXmVjdmqiDfRVttmp+Ny8PUuoa60tXwc7twT1esGuiGnj+FcH6RCof+T1xqI5htOyOkdCxHvt5+W34aLJ7BdQVi/C/fXAiqIdU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO6uO4Ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABFDC4AF09;
	Thu, 27 Nov 2025 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764255290;
	bh=0omifDIQ9EQQ9hAte5EAHzlbV87m/Usi07cZUQL4yv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XO6uO4Ovm9hKNa2MtDJa9+NN4aM3dtpSBNjrizD+yapUB2fJPJN2qCLuFamMJJ8rp
	 Jngm+vt1zFp5CbAbGh3Gvwb+pg+id6wHvamoOBmbfcWTHC7GXEnbpS6ozZbFfyjICD
	 LviKrsUGAdTEtrFQCkhkqeSskUusBESFKqI7C5YK+cyimEc35H8hyvGT1YnPh7ZuHS
	 3Qvzdk3uZhvXF613V0KfPXgnO3X8ZqJgry1h8T6w8/JRj+TRfsqCgpA4xfTG3wPMYn
	 NsZJbLwuvRkjdTLtklvJvB4J74qTnIuBXMXOWoNxgGKpXsiWgXsMOz7ZqplO32bBAT
	 UpBdSDfGQawoQ==
Date: Thu, 27 Nov 2025 14:54:44 +0000
From: Simon Horman <horms@kernel.org>
To: ssrane_b23@ee.vjti.ac.in
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Arvid Brodin <arvid.brodin@alten.se>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
Subject: Re: [PATCH] hsr: fix NULL pointer dereference in skb_clone with hw
 tag insertion
Message-ID: <aShmNNgam3bJ2yMO@horms.kernel.org>
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

I think it would be worth including the trace reported by syzcaller here.
(Say, up to but not including the "Modules linked in" line.)
I can see it at the link. But maybe the link will go away some day.

> 
> Reported-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
> Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

As a fix Networking code present in the net tree, this should be
targeted at the net tree. Like this.

[PATCH net] ...

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

I think this can only occur if __pskb_copy() returns NULL.
So, for clarity, I think this condition should be moved to immediately
after the call to __pskb_copy().

>  	}
>  
>  	return skb_clone(frame->skb_std, GFP_ATOMIC);

...

-- 
pw-bot: changes-requested

