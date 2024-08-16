Return-Path: <netdev+bounces-119169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9399546FB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE0D1C236CA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E59197554;
	Fri, 16 Aug 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTdvBD+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E135413FD66;
	Fri, 16 Aug 2024 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805644; cv=none; b=LHYPRrGQxoqQNtC3Sr5vloue1gSCVvlyajwe9Sj28g7FE7tPR+H5V2vg5hyj2GBz1gl1UHvHsiaxIXqqGHUuq9JrQlpmnRa4qauGugEZoTeTSSA64mgz4bojYeoGxZcf1ze4/C9zXApE98V6SLF1jEnPhQ31qwkl+GtElDsnecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805644; c=relaxed/simple;
	bh=z8KAd6oGpQtM5ZxhmLPomGG+old40kpeYuvpDVxvokw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm0rZ/M8B3/YyEAWmOOuvSWDGclo4PjPWE9UTpfMIxz7CRhnmPpGkEkcjaDspIDznJOq3A0wiPedjFLimhr49FfcbLtLta4K6bcv+K9Qo+LJNylw7kuxjMsuLPDJa1NYp/6luVNpm0ATpejMSq97i0FikypWrdi9McfBgigGUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTdvBD+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B2C32782;
	Fri, 16 Aug 2024 10:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723805643;
	bh=z8KAd6oGpQtM5ZxhmLPomGG+old40kpeYuvpDVxvokw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTdvBD+iKvXlkUY8GPWtkJ098FmWvm78kfw7LSZo9mQ2KW6pTSRGN6wBduwWLmvT2
	 BxxO/pUmXv2m4837aBipi0C5LIND9MpI4GlOFkQacnQUEm2UwRKWA3v8lSiTbSIWBK
	 AYojbE2S6HDkDAHpJnqTBWBbTVhgRal45PDGMF9fjPSYYYFjaq09aO9EJDG79Iqutj
	 XsLQiGKHdhl3TLW40UX4lj+P73VxYy439DKgfoWAUnsjG4jsD2ywNoVM98nPRIb2xE
	 Qmti+h1+e30ncGgrRLjCZQHsRof2VelaeI385yvmEW9t+GEeSInWwELeRYYlQ+ArKt
	 LmWIyPIyuA4Ww==
Date: Fri, 16 Aug 2024 11:53:57 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 3/5] net: xilinx: axienet: Don't print if we
 go into promiscuous mode
Message-ID: <20240816105357.GR632411@kernel.org>
References: <20240815193614.4120810-1-sean.anderson@linux.dev>
 <20240815193614.4120810-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815193614.4120810-4-sean.anderson@linux.dev>

On Thu, Aug 15, 2024 at 03:36:12PM -0400, Sean Anderson wrote:
> A message about being in promiscuous mode is printed every time each
> additional multicast address beyond four is added. Suppress this message
> like is done in other drivers.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - Split off IFF_PROMISC change

Reviewed-by: Simon Horman <horms@kernel.org>


