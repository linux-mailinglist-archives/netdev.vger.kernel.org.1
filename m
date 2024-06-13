Return-Path: <netdev+bounces-103076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59A590626A
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 05:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E780B1C21A66
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DFB12D1F4;
	Thu, 13 Jun 2024 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIAndfv2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035612CD8C;
	Thu, 13 Jun 2024 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247935; cv=none; b=nhjAa+Ojkvp0PZhmQ4Q2lzjsi32U52VPiT31mz2qKK7zwhqNcUTm3BqEiC9i516sqGeMutGfTn8qClcwJBcEPGsBNUJjB6WTTveG6LHQ55OOEYwqhvS9B/YOYGJ1G07PP1I0ZUMy/+OG9rKtTrf0Nazi+gUjwVO49gOGCXp71G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247935; c=relaxed/simple;
	bh=4/qP8iALJ2CgmtztzTTE52P6OmpNtjaTkKxP969Ql0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOgR1Xfypk5L+MMXBW7PTmxoP9X4aktMze0r6sAHsXpNZ02uui6itIw+/je5Lynb6P+hhP0jcbp5d+r4FiKCncmhzeWPKkE92TYe64qpD8bFmRSSCNZAlRnOHJGVk/KAaQa0U2m5/jyNxjTn6vuMaU0HDI8DG7CDcO5Pa567C/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIAndfv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADF9C116B1;
	Thu, 13 Jun 2024 03:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718247935;
	bh=4/qP8iALJ2CgmtztzTTE52P6OmpNtjaTkKxP969Ql0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIAndfv2ZIidRa65O52I4HSr4r8H/g+BFE/EF6QsC9dVxzBl1iFCW5zRvkRnVMuyv
	 kx4HEi6GaRS7ZzL7lkvaeMhd7or24QGINZTZzVmYgPlVsFL3u8EEJ3hFvNPRV5rAoK
	 NRTWWD20N2/v9Aiuy+azJISDH10vhOefMCndLitusHCxoMK0f7S+6G5U5+7tjt1f62
	 TWiCkzmwllU/4j5WQ1B/4ZXCp+XOhz5a9uAHF9aHqqa+htgc2mfreuOtgeSfMsRZvu
	 JuyuicE2bafavvKEzILB4tZI7uBVKPDhNCnn7AbnF9pmvuyO+tayKQClWhF8Nl4mGJ
	 3zIuOIGtbmhjQ==
Date: Wed, 12 Jun 2024 20:05:34 -0700
From: Kees Cook <kees@kernel.org>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
	mw@semihalf.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v1] net: mvpp2: use slab_build_skb for oversized frames
Message-ID: <202406122003.E02C37ADD1@keescook>
References: <20240611193318.5ed8003a@kernel.org>
 <20240613024900.3842238-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613024900.3842238-1-aryan.srivastava@alliedtelesis.co.nz>

On Thu, Jun 13, 2024 at 02:49:00PM +1200, Aryan Srivastava wrote:
> Setting frag_size to 0 to indicate kmalloc has been deprecated,
> use slab_build_skb directly.
> 
> Fixes: ce098da1497c ("skbuff: Introduce slab_build_skb()")
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> ---
> Changes in v1:
> - Added Fixes tag

This looks like similar updates like commit 99b415fe8986 ("tg3: Use
slab_build_skb() when needed")

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

