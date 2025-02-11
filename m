Return-Path: <netdev+bounces-165238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A3A31378
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D911887A80
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA9A1DF997;
	Tue, 11 Feb 2025 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhX8LCNW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7517C91;
	Tue, 11 Feb 2025 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296169; cv=none; b=OtnZFPw4SCSYD9mWvYSIv4Q4EBoPyH1pWHAFp/Ur08XqPTmR4pHj0rY4QafIpqg4Oi5+lgwLHCpetjoyPNQ7Y+zmwl2kwHvbervSSTMu2HkNEKZ4hGRLzXMs8SK8TOja8p1DHgnUosdt8e63AbUUtJTHxR+PpUUuRQg4AnbLZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296169; c=relaxed/simple;
	bh=hBM3qEWuCBL66wdrUKj7M9a2AATgh8I6a+M8Txmi/k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6FFlWG5VcTp5/204u+Qb4WQCFd+0SBQsdW3252SiMiT5HyyUEzkprcdDEvToV0+NT47vRS1MUuv1dgnucp4/PcgjN3brvuxno5wSmKXATuhA1+MKqOSd0jk8wfpElYTMVZwXE2tCq31VMmNDjK9zdAbV6TfVgHS8kPaVWaHwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhX8LCNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D375C4CEDD;
	Tue, 11 Feb 2025 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739296169;
	bh=hBM3qEWuCBL66wdrUKj7M9a2AATgh8I6a+M8Txmi/k8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EhX8LCNWRFQgX/XJXsERVrxEBjMe3shJhxvueQo43z8HAzWhg0b7edderCgNa0mxK
	 S7b+4Cs8dOSL2GLsDk31hyZS5DxRkPha6kcWIc36WtrRXeM8daC3n8x+tZut17TL0i
	 cTIsyeKxlyc89BUTzRx9s4HyL5udXxOzmfLNd+3TSs4YYGiahAhIQSBzrsPjxwJzCr
	 Hq0omcguxlpAJ2vRTVaq9fisdw2rnMz58gOKnqBogFahzyVfiay8lfYKjYwm/nJAVm
	 SwHw7IaOlPN4jvRi0usNvrZ/4NgQSKkOqOc7+CskKxUlL1312XMa9m6J+oivTIvZiW
	 memKCy4aVbwCQ==
Date: Tue, 11 Feb 2025 09:49:27 -0800
From: Kees Cook <kees@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tariq Toukan <tariqt@nvidia.com>,
	Louis Peens <louis.peens@corigine.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, dev@openvswitch.org,
	linux-hardening@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next] net: Add options as a flexible array to struct
 ip_tunnel_info
Message-ID: <202502110942.8DE626C@keescook>
References: <20250209101853.15828-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209101853.15828-1-gal@nvidia.com>

On Sun, Feb 09, 2025 at 12:18:53PM +0200, Gal Pressman wrote:
> Remove the hidden assumption that options are allocated at the end of
> the struct, and teach the compiler about them using a flexible array.
> 
> With this, we can revert the unsafe_memcpy() call we have in
> tun_dst_unclone() [1], and resolve the false field-spanning write
> warning caused by the memcpy() in ip_tunnel_info_opts_set().
> 
> Note that this patch changes the layout of struct ip_tunnel_info since
> there is padding at the end of the struct.
> Before this, options would be written at 'info + 1' which is after the
> padding.
> After this patch, options are written right after 'mode' field (into the
> padding).
> 
> [1] Commit 13cfd6a6d7ac ("net: Silence false field-spanning write warning in metadata_dst memcpy")
> 
> Link: https://lore.kernel.org/all/53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org/
> Suggested-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> [...]
> @@ -107,6 +101,7 @@ struct ip_tunnel_info {
>  #endif
>  	u8			options_len;
>  	u8			mode;
> +	u8			options[] __counted_by(options_len);
>  };

I see __counted_by being added here (thank you).

> [...]
> @@ -659,7 +654,7 @@ static inline void ip_tunnel_info_opts_set(struct ip_tunnel_info *info,
>  {
>  	info->options_len = len;
>  	if (len > 0) {
> -		memcpy(ip_tunnel_info_opts(info), from, len);
> +		memcpy(info->options, from, len);
>  		ip_tunnel_flags_or(info->key.tun_flags, info->key.tun_flags,
>  				   flags);
>  	}

And I see info->options_len being set here before the copy into
info_>options. What validates that "info" was allocated with enough
space to hold "len" here? I would have expected this as allocation time
instead of here.

> diff --git a/net/core/dst.c b/net/core/dst.c
> index 9552a90d4772..d981c295a48e 100644
> --- a/net/core/dst.c
> +++ b/net/core/dst.c
> @@ -286,7 +286,8 @@ struct metadata_dst *metadata_dst_alloc(u8 optslen, enum metadata_type type,
>  {
>  	struct metadata_dst *md_dst;
>  
> -	md_dst = kmalloc(sizeof(*md_dst) + optslen, flags);
> +	md_dst = kmalloc(struct_size(md_dst, u.tun_info.options, optslen),
> +			 flags);
>  	if (!md_dst)
>  		return NULL;
>  

I don't see options_len being set here? I assume since it's sub-type
specific. I'd expect the type to be validated (i.e. optslen must == 0
unless this is a struct ip_tunnel_info, and if so, set options_len here
instead of in ip_tunnel_info_opts_set().

Everything else looks very good, though, yes, I would agree with the
alignment comments made down-thread. This was "accidentally correct"
before in the sense that the end of the struct would be padded for
alignment, but isn't guaranteed to be true with an explicit u8 array.
The output of "pahole -C struct ip_tunnel_info" before/after should
answer any questions, though.

-Kees

-- 
Kees Cook

