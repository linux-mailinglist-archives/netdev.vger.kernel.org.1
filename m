Return-Path: <netdev+bounces-161588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267EDA227BC
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 04:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB6B1885883
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 03:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD02A15C0;
	Thu, 30 Jan 2025 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckCTExm2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7372881E
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738206208; cv=none; b=CFSuskZl/9MFopbfNWESNkpEOvPoLAWjYhtOAKBMpOxGE071SOG2id1PkhD6SADhDZRS76Rd4u2ShfR0kKYb+BITWPvQrNOx/XOboWp4tTCxw8vKLgB6s/bK4YHM456vLk/e6EZ+7mx+Z7x594LD5ub/hfVsS7sBgmTjsbSb+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738206208; c=relaxed/simple;
	bh=Ei/x6t8UvigoJzIiBaxRyF4AkXw5bxG01u13S2sdQoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMA3/tKyeNnZUvH1hhsSO+io4vFQC6nHtCFdjISnI4mjPFRe941rstyZh+hL78RFWpSm6nC8dQFhfFf2fs4UQuv6egqTLQiAOkbnyoQOvPTbAL7ofte2nRG69fzYyWe1F9IlLslKqTw1RJw41PirUIBmBeW/7BL0JwNdOPXVPAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckCTExm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E14C4CEDF;
	Thu, 30 Jan 2025 03:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738206208;
	bh=Ei/x6t8UvigoJzIiBaxRyF4AkXw5bxG01u13S2sdQoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ckCTExm2Squc6vl+kJtbByVGzziylt2pNfYVTmd6L5/pTzSVpyFWYyV0nwZDftEw0
	 ADz28uf71zCkjI9w0pIfkZvVfxGaplCv8R/dZ6tA+dMmbdnNf673JsKRvybwLum3A2
	 fSsd08wEPkHEPFx16LMwAh9lBV99CiTyMabC4dl0OfU7jD+uSR9oM+BDo2AjwUuRk4
	 dYmcWcAXjEo/e7TbTBZl55y37S/KHFICaHN/CxCxV2P3LSkW3aFfu8ZWz6WZLWAmFV
	 eHG/0Aj9B6UG1qLOaQ4rYdE4O0J4z1vYibZw5nH+dL6RuXneCorxWJSOB4jG+48xQb
	 FoDtkUuvCgp2g==
Date: Wed, 29 Jan 2025 19:03:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
 <brett.creeley@amd.com>
Subject: Re: [PATCH net 2/2] pds_core: Add a retry mechanism when the adminq
 is full
Message-ID: <20250129190326.456680c8@kernel.org>
In-Reply-To: <20250129004337.36898-3-shannon.nelson@amd.com>
References: <20250129004337.36898-1-shannon.nelson@amd.com>
	<20250129004337.36898-3-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 16:43:37 -0800 Shannon Nelson wrote:
> If the adminq is full, the driver reports failure when trying to post
> new adminq commands. This is a bit aggressive and unexpected because
> technically the adminq post didn't fail in this case, it was just full.
> To harden this path add support for a bounded retry mechanism.
> 
> It's possible some commands take longer than expected, maybe hundreds
> of milliseconds or seconds due to other processing on the device side,
> so to further reduce the chance of failure due to adminq full increase
> the PDS_CORE_DEVCMD_TIMEOUT from 5 to 10 seconds.
> 
> The caller of pdsc_adminq_post() may still see -EAGAIN reported if the
> space in the adminq never freed up. In this case they can choose to
> call the function again or fail. For now, no callers will retry.

How about a semaphore? You can initialize it to the number of slots
in the queue, and use down_timeout() if you want the 10 sec timeout?

