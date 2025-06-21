Return-Path: <netdev+bounces-200001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B93FAE2ADD
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D931175807
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2ED21CC7B;
	Sat, 21 Jun 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMoVCDrh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB514658D;
	Sat, 21 Jun 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528535; cv=none; b=rIwyx8bcftWC3J4HrMUjJInlaOanYXJU2NaLI/AXj6+hbXFDfY97z1C4710OCnUGhe7S3m3C91YQ0Eyot1NlVekXCyN30CDfDCAT60J5K+DXhusHnjAhE0K45smC6JXXz4w8eoY2NJ6fyzQw4m9j+5Tp4xZEku6modSq2GKS7wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528535; c=relaxed/simple;
	bh=MfFmP+RjjG/lcbVBsU+iTsjxzE5q2c5PYihsFvbNLq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0bCUdHpEC9kNMddJ35nRJUHkvvgTQph8H30axI/XKKMgnbo6Mj7ZJ1SifCLTaQuHlna7jS78kGoHWGpf0btBMAr47gk67BlW+u58qd6T3P5SUG0v+SZBzGGAUbtj3DzfMfPBtktq/uVAc6Vei+OFZnwCIBYHOntgZW+19O/0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMoVCDrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A358C4CEE7;
	Sat, 21 Jun 2025 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750528534;
	bh=MfFmP+RjjG/lcbVBsU+iTsjxzE5q2c5PYihsFvbNLq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMoVCDrhJUFekzFXE86d8mYA7Fe8SiJpz3JzdYQOc0iUMJNywRlRutjCX6P5D2X/2
	 wpzQgyPDzlqr2PkRfk+VZ0I8TeKbOtq8Lh9s//Ez+EGuZYINHZHUoeTtnPf8KprLKK
	 9NbH1WUWwPRP+AArPLEz8TqpT2hKTlA4Ef3Ilano+/Iy8CjXvJJ1MtFcMnxhpdNjjp
	 GfxIKhOiZimO8UJtTkQ4OSBXD77bk9s+VJhfHFQ94LPMFlqFJK7NeRefel/eEXowvC
	 wlF4GGpvqXPeoBARgLHfES/HfT3nV7vYohX8M3ISs4xXnbiRK7TfeqBFFTwoYubGNh
	 O2Y2VX8uGOW6w==
Date: Sat, 21 Jun 2025 18:55:30 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] net: netpoll: Initialize UDP checksum field before
 checksumming
Message-ID: <20250621175530.GE71935@horms.kernel.org>
References: <20250620-netpoll_fix-v1-1-f9f0b82bc059@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-netpoll_fix-v1-1-f9f0b82bc059@debian.org>

On Fri, Jun 20, 2025 at 11:48:55AM -0700, Breno Leitao wrote:
> commit f1fce08e63fe ("netpoll: Eliminate redundant assignment") removed
> the initialization of the UDP checksum, which was wrong and broke
> netpoll IPv6 transmission due to bad checksumming.
> 
> udph->check needs to be set before calling csum_ipv6_magic().
> 
> Fixes: f1fce08e63fe ("netpoll: Eliminate redundant assignment")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


