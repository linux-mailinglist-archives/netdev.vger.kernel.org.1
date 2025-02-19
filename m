Return-Path: <netdev+bounces-167800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8CBA3C635
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF0A16D75B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0ED2144CE;
	Wed, 19 Feb 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaRkLUbO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109A2144BE;
	Wed, 19 Feb 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986124; cv=none; b=Ej2flpGPH3DouTzq82L6Jnviygnl07XssT6d/i6SSjVHNQ5CZaZpaFugg6BUfV66f81cssgmaJwExr1V+/PLHEiDux0554SA7XcYwMc0byxeaxBOVTPWFMK/ERrjBOH8qh6Eb828zLr5mISl9/DIMF+mB0TAjpgi8c0JiZOPpGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986124; c=relaxed/simple;
	bh=590C91s6oK+BlK/su2/lek/MtII/RpQUTZ+/nYe7SqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NO40E0Lvrjy4DRj60w1z2qXgd5qkRy8y3MscPCeLFL05RNI8SkVp2KeX4Y/+3xaC6OZbYlfIb/XN4/BQi8a+PngwVx9II2vo/7B27claWmzTbqn0z7MX26uAa/TpZYKZPBN5+6iItBwTrtipeFEo8aPpXY0G5kUmIraDguqmrug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaRkLUbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CC3C4CED1;
	Wed, 19 Feb 2025 17:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739986123;
	bh=590C91s6oK+BlK/su2/lek/MtII/RpQUTZ+/nYe7SqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaRkLUbOS92qCDzLmaaKCsStfK/xsLFqX+A11EK/adP3RwzTAfjaMoiNuT/2zrkM3
	 bh6SopCfSJKdrsqagOwvDhIagPSw12X8AMa2Nr7azp5x8hQvmnw4lg0c3WA27Q8yom
	 NL3S+o0se22F2sv3CsZ3hGR+pR9ysBDXYk7rT18wmQ1RrBcTYBOKwfMjDSurPRXDlI
	 WMw68UcUDQJJBJzwcWDUmX1Dmu3HL5awdF8HJ7jmcdXlQF7Oc2xbNY1G6dklz7NaBs
	 4ut4c+IE/UMwYmV6rLPQYIko9JQNS0HieiiEFtNOIPzQDBFeEpigAeqfxO5QaHRuZu
	 OL04MX0ExzcVQ==
Date: Wed, 19 Feb 2025 09:28:40 -0800
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
	linux-hardening@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v4 2/2] net: Add options as a flexible array to
 struct ip_tunnel_info
Message-ID: <202502190928.D2C5927D0@keescook>
References: <20250219143256.370277-1-gal@nvidia.com>
 <20250219143256.370277-3-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219143256.370277-3-gal@nvidia.com>

On Wed, Feb 19, 2025 at 04:32:56PM +0200, Gal Pressman wrote:
> Remove the hidden assumption that options are allocated at the end of
> the struct, and teach the compiler about them using a flexible array.
> 
> With this, we can revert the unsafe_memcpy() call we have in
> tun_dst_unclone() [1], and resolve the false field-spanning write
> warning caused by the memcpy() in ip_tunnel_info_opts_set().
> 
> The layout of struct ip_tunnel_info remains the same with this patch.
> Before this patch, there was an implicit padding at the end of the
> struct, options would be written at 'info + 1' which is after the
> padding.
> This will remain the same as this patch explicitly aligns 'options'.
> The alignment is needed as the options are later casted to different
> structs, and might result in unaligned memory access.
> 
> Pahole output before this patch:
> struct ip_tunnel_info {
>     struct ip_tunnel_key       key;                  /*     0    64 */
> 
>     /* XXX last struct has 1 byte of padding */
> 
>     /* --- cacheline 1 boundary (64 bytes) --- */
>     struct ip_tunnel_encap     encap;                /*    64     8 */
>     struct dst_cache           dst_cache;            /*    72    16 */
>     u8                         options_len;          /*    88     1 */
>     u8                         mode;                 /*    89     1 */
> 
>     /* size: 96, cachelines: 2, members: 5 */
>     /* padding: 6 */
>     /* paddings: 1, sum paddings: 1 */
>     /* last cacheline: 32 bytes */
> };
> 
> Pahole output after this patch:
> struct ip_tunnel_info {
>     struct ip_tunnel_key       key;                  /*     0    64 */
> 
>     /* XXX last struct has 1 byte of padding */
> 
>     /* --- cacheline 1 boundary (64 bytes) --- */
>     struct ip_tunnel_encap     encap;                /*    64     8 */
>     struct dst_cache           dst_cache;            /*    72    16 */
>     u8                         options_len;          /*    88     1 */
>     u8                         mode;                 /*    89     1 */
> 
>     /* XXX 6 bytes hole, try to pack */
> 
>     u8                         options[] __attribute__((__aligned__(16))); /*    96     0 */
> 
>     /* size: 96, cachelines: 2, members: 6 */
>     /* sum members: 90, holes: 1, sum holes: 6 */
>     /* paddings: 1, sum paddings: 1 */
>     /* forced alignments: 1, forced holes: 1, sum forced holes: 6 */
>     /* last cacheline: 32 bytes */
> } __attribute__((__aligned__(16)));
> 
> [1] Commit 13cfd6a6d7ac ("net: Silence false field-spanning write warning in metadata_dst memcpy")
> 
> Link: https://lore.kernel.org/all/53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org/
> Suggested-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Thanks for these updates and the pahole output. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

