Return-Path: <netdev+bounces-108997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9820A9267D8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C926D1C217F2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A529018628C;
	Wed,  3 Jul 2024 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZRmmUp+y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F5F9D4;
	Wed,  3 Jul 2024 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030285; cv=none; b=kVQefD1gbCeGMWDe8s+TU4AGUS16pOd2zFb/8QIL06z5siASmxYYhF1jBjSjnWzSYk1i50GtMBwu7GdCz9nqNfMtRfDEgcc/q/Dc2C2mMpJauOI4g6tUK2VNXJGL1fW46Gx8fpwk9ur9UuYyW5rxWaB4cM2jMwm34mdw9HBQpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030285; c=relaxed/simple;
	bh=jMbdZCqb2xj39Jt2FZtd0/bUiZqytApbTjMfDgh7J1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N06srUaVYfxYknIGHkXG9/ytke36aW5xfKWi0650xoygE3VUv04K5gZvowLDsPdqZVBIjf40Icpw+lXFoj5pnDJV92sUZ0RncsDTSu6/20RtWI80ssES+eUFx/mJVHt/iEkurZ9H6Q9YJnidkvmpJg2v0enoVGy+ZwTkBH9zgmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ZRmmUp+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB1EC2BD10;
	Wed,  3 Jul 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZRmmUp+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720030281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxP95z8H/D5jQ1acVpMchUAdQN8JTrhlX7OCXvz9kwQ=;
	b=ZRmmUp+yHoawM9i6CE4ye6v4+uhrw5XL1V05sJWeH8bJ/BFb28hVJYr8s42ypVo6hLtbE1
	f2Lb+p++NVADqKpyDm9yUuASkqsTIjXFbJv4F+oyM5hDzpg/YFBrk9r7BjP+/VuxaGi3Jx
	0/4hlTNikRoAD/60UEWeTujua408ac8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a2dcc16d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jul 2024 18:11:20 +0000 (UTC)
Date: Wed, 3 Jul 2024 20:11:14 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Helge Deller <deller@kernel.org>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH] wireguard: allowedips: Prevent unaligned memory accesses
Message-ID: <ZoWUQho7noWwAqrF@zx2c4.com>
References: <ZoV6Q6lWgVRqe7eh@p100>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZoV6Q6lWgVRqe7eh@p100>

Hi Helge,

On Wed, Jul 03, 2024 at 06:20:19PM +0200, Helge Deller wrote:
> On the parisc platform the Linux kernel issues kernel warnings because
> swap_endian() tries to load a 128-bit IPv6 address from an unaligned
> memory location:
>  Kernel: unaligned access to 0x55f4688c in wg_allowedips_insert_v6+0x2c/0x80 [wireguard] (iir 0xf3010df)
>  Kernel: unaligned access to 0x55f46884 in wg_allowedips_insert_v6+0x38/0x80 [wireguard] (iir 0xf2010dc)
> 
> Avoid such unaligned memory accesses by instead using the
> get_unaligned_be64() helper macro.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
> index 0ba714ca5185..daf967130b72 100644
> --- a/drivers/net/wireguard/allowedips.c
> +++ b/drivers/net/wireguard/allowedips.c
> @@ -15,8 +15,8 @@ static void swap_endian(u8 *dst, const u8 *src, u8 bits)
>  	if (bits == 32) {
>  		*(u32 *)dst = be32_to_cpu(*(const __be32 *)src);
>  	} else if (bits == 128) {
> -		((u64 *)dst)[0] = be64_to_cpu(((const __be64 *)src)[0]);
> -		((u64 *)dst)[1] = be64_to_cpu(((const __be64 *)src)[1]);
> +		((u64 *)dst)[0] = get_unaligned_be64(src);

Ahh, right, in6_addr only has a u32 member, not a u64 member, so that's
potentially unaligned.

> +		((u64 *)dst)[1] = get_unaligned_be64(src[8]);

src[8] is not correct, however. (This crashes; did you test it?) I've
fixed it up and put it in the wireguard tree:

https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git/commit/?id=ad3d9eef8e1b304b243e63124581f97c88ce7ff9

I'll push this up to net.git soon. Thanks for the patch.

Jason

