Return-Path: <netdev+bounces-214134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEF1B28564
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BAE97BCF0E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE09A317710;
	Fri, 15 Aug 2025 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjhCuRKI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AA3176E8;
	Fri, 15 Aug 2025 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280227; cv=none; b=p22auQ8GmAJtPv1nHarxjEZwvsrEkQNGkuLHB97MEnzfCYQKZUBPKtvkqcy682h18Ftq5+PS/1m6Y8pCDdLEekWURNU0hg/2Anupt5KDqHrsN6pWNXDfSAhZ0rRLWTqjC3Pzt9p4moYj6Cvl299K8snKhjrKjBgh+4/qEJonj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280227; c=relaxed/simple;
	bh=ShySkzoJxzQQw3dH/QWTegzh6v6tEvZKEswR5h16SrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZWtUBoh+I8uUA0UhSun7IP1E6n5zMu6+M2sGwQ2tQCZglaXWzXYAbDcUzZEq/EsVPuZT1GSkfn8I2D+8mhhZEYa0O/Ca+hDc2am6xjPrqAK1UzKKGqCZ64nv33znpaWu4kHNzE4hYaxpPre2VmOWLUpmNmh9gpGc+2hjIXgbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjhCuRKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA31BC4CEEB;
	Fri, 15 Aug 2025 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755280227;
	bh=ShySkzoJxzQQw3dH/QWTegzh6v6tEvZKEswR5h16SrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NjhCuRKIeutbyuuNGx2hxxZc2ymXgptnIr2+l907lNe80aq2Y9VGiAD3JWB8H6NvW
	 5ACGwDj6kI80P2rFnrhgLgH+iFwVxtektvvKOh8bCZybpJY60ofneWipAeR7mtV4az
	 3nElWWWMi3FpIhBYiEer+34Bk3u13VAnHjkomjo0a+u+PXBrDkfDs1xWqZPRsMu7zY
	 71r0P+kEv/xs2TV3fgATCEaV/XF7cnRldffYvTK/h73CrFCvacU2LBhl+yQbkGk5CC
	 dauh/icgq0Da2Y4VmXrC8L9QOmBuO0XJzgS0RCxOhhBL9hYF6+ApgR0jcaHO7VP20I
	 WHkWJH97ucF2Q==
Date: Fri, 15 Aug 2025 10:50:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 2/3] nfp: flower: use vmalloc_array() to simplify
 code
Message-ID: <20250815105026.04912f25@kernel.org>
In-Reply-To: <20250814102100.151942-3-rongqianfeng@vivo.com>
References: <20250814102100.151942-1-rongqianfeng@vivo.com>
	<20250814102100.151942-3-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 18:20:54 +0800 Qianfeng Rong wrote:
> -		vmalloc(array_size(NFP_FL_STATS_ELEM_RS,
> -				   priv->stats_ring_size));
> +		vmalloc_array(NFP_FL_STATS_ELEM_RS,
> +			      priv->stats_ring_size);

This generates a bunch of warnings on gcc when building with W=1
-- 
pw-bot: cr

