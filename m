Return-Path: <netdev+bounces-201920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9088AAEB6D5
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E6D1C60229
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D91129B8EA;
	Fri, 27 Jun 2025 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIjuLCQ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BBF1DDC1E;
	Fri, 27 Jun 2025 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024913; cv=none; b=icWggSSpywnhMzei8Pqqw0jIlx0pM3lTgePSbSVU2uTKMw1Vk9+x8oChGML7HpntAo0pNoIrwhsG5rK5XBWFs4lDYEU3U8KiH0r+ROpuebz6mjB0EwCasO+e1DI4s0xFCbPJZKDxeCc03RHd42ZfR9kmgt7I5TGUDpaQh3rePtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024913; c=relaxed/simple;
	bh=Tz7ZazmH8VZpU3H9X18vpBaQvz1SlkHxHCwJEZz0pl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkP2wGfMIj7qZxFJThqxQjHVMYaDdg/hLg0YjmyHRF3LtexVK9oLRsU16RVYn1Vdd1/8AlJRSSQsphApt5kmwQ/E6twdq1J73flVIzppytFFV4MAN94f6OUpENRus0t45zVN49y+BF+jA65rpQCaaIV+CqbTaFaS9o/DbTwMRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIjuLCQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEC5C4CEE3;
	Fri, 27 Jun 2025 11:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751024912;
	bh=Tz7ZazmH8VZpU3H9X18vpBaQvz1SlkHxHCwJEZz0pl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIjuLCQ2krFbQld+sSWXC3gVvkcJLU3xoWCZGxguLJ4cz7RLvuFyrokM9tAFdTlxM
	 Zeb22B51PEfT0A0Zx8xC8TLc6r6pKh5tVty9ry2SJNgan6NO2XNa1jqohXY42yHDab
	 3gpsGZzGzbZU6QwxkSlM6xDQQE99jmypEVC2x/l54bLsrHIrOaNkgaZvbF5aDjZceH
	 6M1i5O28xmHo7uvpWMkTytrtgBWoFgkssCNDsNwEQVXuC+xblzYdAA4Ya4WmD2luux
	 BXS4I136knZKZ/UBOihepf08WzBGpA8F2Nnyw8D12+v+IOc1yL7O88+Q38J38t1ImU
	 BdP85Fk7Ud6tw==
Date: Fri, 27 Jun 2025 12:48:28 +0100
From: Simon Horman <horms@kernel.org>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dpaa2-eth: fix xdp_rxq_info leak
Message-ID: <20250627114828.GA1776@horms.kernel.org>
References: <20250626133003.80136-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626133003.80136-1-wangfushuai@baidu.com>

On Thu, Jun 26, 2025 at 09:30:03PM +0800, Fushuai Wang wrote:
> The driver registered xdp_rxq_info structures via xdp_rxq_info_reg()
> but failed to properly unregister them in error paths and during
> removal.
> 
> Fixes: d678be1dc1ec ("dpaa2-eth: add XDP_REDIRECT support")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---

Thanks for the update.
I think this covers all the bases.

Reviewed-by: Simon Horman <horms@kernel.org>

