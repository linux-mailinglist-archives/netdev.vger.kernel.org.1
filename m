Return-Path: <netdev+bounces-124130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E14968340
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683E61F23385
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F228F1CFEC1;
	Mon,  2 Sep 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYY+ay3P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE67F1CFEA5
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269531; cv=none; b=rhrwOSQJ/5V2+1S2c9R3F9uwNwunv1mz1q4r5jF7pUWwS4j/O5O2TG3A/EYEsE419CfP2K7NfPBd09+8mprlEwdDv2LX1Snaocyfi9xdvB0aggKG96lxOjj5fDne4wejnjVQvbLtmhWtwyn3fnJeBfjrjCW8I4pwY67y6Ae3BhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269531; c=relaxed/simple;
	bh=F0cEXCMnd9eNvuUo2ScKsTrMD22S8gB+2+H6USohzMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnW/LUGbffDrGYEMbIbzuhrYLtmLm+9s9XFU2yLY+kS3wcu+Khim9uDzkPqhZ2sx+vHf1hEiX7GNcJblO5/GXir/491vCqQDaOrwFJqPIiDM0i478Ss3vwJbRKa4YzLQejfa5tH50CHA+oGvt/uqip/aFZfXtgsWmTLZTFtR6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYY+ay3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5088AC4CEC2;
	Mon,  2 Sep 2024 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725269531;
	bh=F0cEXCMnd9eNvuUo2ScKsTrMD22S8gB+2+H6USohzMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYY+ay3PtCE5sDRCLRTs5KfZ/QtvDftsN//RDLv5KYGAkxAJdPLZOnYld6xM0SGMk
	 ZNobMYTH3uJ6vEJszmEDMVtz7DwEr0d4WPSHGLmqyDH8IvYQBgATGo57sthSks2g6a
	 r6PtjbxadzQ4Uh3d8FpNXBTfnhyIvIEmzA2Yi2Dlg4GNiqr3RNHG1r2f1M02JTgZeP
	 J8YQtyrYhW1vkMFGTKbXDj6QC3sIih3naZAREAzuviCqASLz4QhIXqO0guVJcuZB7o
	 KM/Ld0DSla5w9vnWfuoOe3b7QOwVOj17o4GHKVrAE1hLu23m6Gx8hdiS/s4f4DNnuD
	 7x3EQWlIdFHlA==
Date: Mon, 2 Sep 2024 10:32:07 +0100
From: Simon Horman <horms@kernel.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	dsahern@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec 1/2] xfrm: extract dst lookup parameters into a
 struct
Message-ID: <20240902093207.GG23170@kernel.org>
References: <20240901235737.2757335-1-eyal.birger@gmail.com>
 <20240901235737.2757335-2-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901235737.2757335-2-eyal.birger@gmail.com>

On Sun, Sep 01, 2024 at 04:57:36PM -0700, Eyal Birger wrote:
> Preparation for adding more fields to dst lookup functions without
> changing their signatures.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

...

> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c

...

> @@ -277,9 +279,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
>  			daddr = &x->props.saddr;
>  		}
>  
> -		dst = __xfrm_dst_lookup(net, 0, 0, saddr, daddr,
> -					x->props.family,
> -					xfrm_smark_get(0, x));
> +		memset(&params, 0, sizeof(params));
> +		params.net = net;
> +		params.saddr = saddr;
> +		params.daddr = saddr;

Hi Eyal,

Should this be: params.daddr = daddr;
                               ^^^^^

daddr is flagged as set but otherwise unused by W=1 allmodconfig builds.

> +		params.mark = xfrm_smark_get(0, x);
> +		dst = __xfrm_dst_lookup(x->props.family, &params);
>  		if (IS_ERR(dst))
>  			return (is_packet_offload) ? -EINVAL : 0;
>  

