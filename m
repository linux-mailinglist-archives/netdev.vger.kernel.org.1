Return-Path: <netdev+bounces-150395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA49EA16E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E901637AB
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 21:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D819D8A0;
	Mon,  9 Dec 2024 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0CoD4E7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152A19D89B
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781187; cv=none; b=V5IyyxxxFjFrsm2jQL3eKT4ZiryHHNqZSU+nDWdssA0RipwaZmICEa2+X47956s66oWZg2Qr6EG0OGZcjbrPFY60Iw1AiMXGbewTlWgz4pJ9Qrpa3yQ5gGKF2hnMBQzxIgWSIIb4IVqEW2o0FABZTtOAacznuZVJaM2EL/lKP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781187; c=relaxed/simple;
	bh=cI1DgdJ30N5skcwufLsR1wZRUPZiPjGuM1bDPZAW464=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+jogqGm9OSAOZ6r9ioc6tdLwu0yOrAIavuQzvAfU0We2AOfVNcKQLHwCqkvDwKjvo+K7f/Z+yJCRQF7udit2fg/2c1HXLfd7zJ6rrs1vUMWp9rm4tPE0onsWqdIOA5FRe77GVNZd+yUZK1KrbPDNsjnuFxzHuPf9qEFDnOuCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0CoD4E7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1116FC4CEDD;
	Mon,  9 Dec 2024 21:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733781186;
	bh=cI1DgdJ30N5skcwufLsR1wZRUPZiPjGuM1bDPZAW464=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0CoD4E7hKRBFoWobarcGp+9Fw9MWXBw0SYcbH3zMHctnVzJ+i61LCbJomzHPFcIR
	 DUu69EihbrupyzHsumJJw3RSW11ZOzM9MCGEYuduFj+AdIftAHnbJ2iqBzhvS6tZ78
	 AHqlHSBShj2eRZ1zLQUWY0w41IMndKeAXDExjeAgVoRwJy/MFMK3zfhnhBgrUzl8H/
	 9swo19T38xQ+UoUs6tA1vVe1m2T2X4EdbgjhBmksocfDydCmeZdZofoGoJY0+Y3+Y6
	 4J6ovnKPqTk5yWfxNjhdBXBEq3WgkFAta3/v/9ciK69VFkj9UNDVG0FCY/dGKTOV1j
	 XwPH827uaMAuA==
Date: Mon, 9 Dec 2024 23:53:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: steffen.klassert@secunet.com
Cc: Feng Wang <wangfe@google.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com, pabeni@redhat.com
Subject: Re: [PATCH v7] xfrm: add SA information to the offloaded packet when
 if_id is set
Message-ID: <20241209215301.GC1245331@unreal>
References: <20241209202811.481441-2-wangfe@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209202811.481441-2-wangfe@google.com>

On Mon, Dec 09, 2024 at 08:28:12PM +0000, Feng Wang wrote:
> In packet offload mode, append Security Association (SA) information
> to each packet, replicating the crypto offload implementation. This
> SA info helps HW offload match packets to their correct security
> policies. The XFRM interface ID is included, which is used in setups
> with multiple XFRM interfaces where source/destination addresses alone
> can't pinpoint the right policy.
> 
> The XFRM_XMIT flag is set to enable packet to be returned immediately
> from the validate_xmit_xfrm function, thus aligning with the existing
> code path for packet offload mode.
> 
> Enable packet offload mode on netdevsim and add code to check the XFRM
> interface ID.
> 
> Signed-off-by: wangfe <wangfe@google.com>
> ---

<...>

> @@ -728,7 +730,27 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  			kfree_skb(skb);
>  			return -EHOSTUNREACH;
>  		}
> +		if (x->if_id) {
> +			sp = secpath_set(skb);
> +			if (!sp) {
> +				XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +				kfree_skb(skb);
> +				return -ENOMEM;
> +			}
> +
> +			sp->olen++;
> +			sp->xvec[sp->len++] = x;
> +			xfrm_state_hold(x);
>  
> +			xo = xfrm_offload(skb);
> +			if (!xo) {
> +				secpath_reset(skb);
> +				XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +				kfree_skb(skb);
> +				return -EINVAL;
> +			}
> +			xo->flags |= XFRM_XMIT;
> +		}

Steffen,

I would like to ask from you to delay this patch till this "if_id"
support is implemented and tested on real upstreamed device.

I have no confidence that the solution proposed above is the right thing
to do as it doesn't solve the claim "This SA info helps HW offload match
packets to their correct security". HW is going to perform lookup anyway
on the source and destination, so it is unclear how will it "help".

Thanks

>  		return xfrm_output_resume(sk, skb, 0);
>  	}
>  
> -- 
> 2.47.0.338.g60cca15819-goog
> 
> 

