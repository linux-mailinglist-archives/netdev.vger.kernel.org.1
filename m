Return-Path: <netdev+bounces-161160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60DA1DB32
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CC13A4DF0
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 17:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86618A6A1;
	Mon, 27 Jan 2025 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5++vB+Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727047DA6A;
	Mon, 27 Jan 2025 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998530; cv=none; b=A6ekg5bRA5875whnUkLs8FDBD+gZAy0QyW+cE5WyyuZwJ3meVDnuVe84PvRI6F80AmBmTnwt3lUYM7MLmvR+/fmjhxVkoMlgC0bZbtD14Id/JnkveHjUf+Hfi5j/aQIqKI8eSPINxocH4CyQEnAAE7ynSuv3talbIFVKD4CSaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998530; c=relaxed/simple;
	bh=mrZmHn8gYvBAa1pogmPoSVIvDb56urYXqEbpxL/haQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JenHe9BDC5NoHkFLQDIUY9XOPaItmBO4idlDCH8+gQLfPdHldYKU1pFD87XYmOCvVmNHbxYy7JlWR4IOhRTdb5s165hGnBepF3aDe/7AzpAY6mNVOLMxl7aMYHpWNCPj2g+oD/O9uLMfJ9tuk0vF3WxMzNRHfyHaqYRKjvGuVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5++vB+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365B9C4CED2;
	Mon, 27 Jan 2025 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737998529;
	bh=mrZmHn8gYvBAa1pogmPoSVIvDb56urYXqEbpxL/haQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5++vB+YfofDGMBASoQqAa5FsW92l6zQPz0TN+neYcvDIFWiO/CWfpG0/GdoBFPBV
	 m9jr7XP9btbcDMVZlCorfZvYam4laj6Wzv8GhrpO6wNNNKpk+U+aCahKyoSMPJV2na
	 RxkEuxYtOsvxdpQzGwXoNHDFHSVmuImjdo9BeuGTTQj+dqW2iPS9rnxlIZSrMMKP4u
	 XjFbJZGqZMTzWEfsf/ux1v4M78CytjeGS0oF8SY/eQ6BaE2DAgFpVNI7EdLz0gglF4
	 WF5L3Qh456mjxXGL2rKZSmiwL8Zf7Srf1huY2Cgk7L68KkrdM/1jz97NrvufSFnKM2
	 SM3JwLsRgSqKA==
Date: Mon, 27 Jan 2025 17:22:05 +0000
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Murali Krishna Policharla <murali.policharla@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arun Parameswaran <arun.parameswaran@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] bgmac: reduce max frame size to support just MTU 1500
Message-ID: <20250127172205.GF5024@kernel.org>
References: <20250124191404.3721128-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124191404.3721128-1-florian.fainelli@broadcom.com>

On Fri, Jan 24, 2025 at 11:14:04AM -0800, Florian Fainelli wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> bgmac allocates new replacement buffer before handling each received
> frame. Allocating & DMA-preparing 9724 B each time consumes a lot of CPU
> time. Ideally bgmac should just respect currently set MTU but it isn't
> the case right now. For now just revert back to the old limited frame
> size.
> 
> This change bumps NAT masquerade speed by ~95%.
> 
> Since commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
> page_frag_alloc_align()"), the bgmac driver fails to open its network
> interface successfully and runs out of memory in the following call
> stack:
> 
> bgmac_open
>   -> bgmac_dma_init
>     -> bgmac_dma_rx_skb_for_slot
>       -> netdev_alloc_frag
> 
> BGMAC_RX_ALLOC_SIZE = 10048 and PAGE_FRAG_CACHE_MAX_SIZE = 32768.
> 
> Eventually we land into __page_frag_alloc_align() with the following
> parameters across multiple successive calls:
> 
> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=0
> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=10048
> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=20096
> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=30144
> 
> So in that case we do indeed have offset + fragsz (40192) > size (32768)
> and so we would eventually return NULL. Reverting to the older 1500
> bytes MTU allows the network driver to be usable again.
> 
> Fixes: 8c7da63978f1 ("bgmac: configure MTU and add support for frames beyond 8192 byte size")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> [florian: expand commit message about recent commits]
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Change-Id: Ie70d714cb4f00e45a34e9a015d0eb4bff60fac6e

Hi Florian,

I think the Change-Id line needs to be dropped,
but otherwise this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

