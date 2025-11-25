Return-Path: <netdev+bounces-241533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6203C85551
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D200C4E8BD8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78623254AC;
	Tue, 25 Nov 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZblAaQVt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFCA3254A8;
	Tue, 25 Nov 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079793; cv=none; b=M0Vn9fjRknrQJdaF55o6xNFC7u8+/7AIYrbw9BjV5AsujjX2NKKpVVQ3XIH9XKjYreltuk2vKVMGQBfKmX9XFZ4IS15ousSYQglqhE0T/OTMvPJttF1ENzttTmuruexMAPU8/eaxawo7avlUKlLtHPW5v6eDSCEjHDt++3qzzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079793; c=relaxed/simple;
	bh=afVh423ui7yB/V7mzigBb34cicCu5XJHvqdn+PvzHsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=javRf+DX7MD2oxFwPSUa7CNrcm47hKFC1IT3h17i6bbZyUo3vpKS0+09bA6NjBXli4qs/O84BwFAq85jluRP/4J+7oH9S0UICENIA26PjYEQiUrU6MAsQ0PPQ/X/gq+Od5BqhwuKj5oiq/HZhrZ2cR+9g0e7AlzbYa5YVo6Z1lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZblAaQVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F46C19423;
	Tue, 25 Nov 2025 14:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764079793;
	bh=afVh423ui7yB/V7mzigBb34cicCu5XJHvqdn+PvzHsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZblAaQVtYY+Xlojfrzv0AKUOwrRbpTmmBkL1CY03Wnj5TTzSgKp+z9u8ipBYE8I6i
	 1TVEuqUDj2gV5QufPCh2xZwRzxoQa6rsYdzXPfEwbuQtT8/Ir7uel6yKeKF49UGVkz
	 7Bz4NVX4aDl9Vtwmp2BcQVsWxTPNJfbf+Bj44cdTppztxSyj51LI7zemaFvygVTtaB
	 ow0V0vnSMDfazxbKrELT65LCQsqhhuhOYjS/4NruMqnF0Djb5bER2IQaQWMYK0Jkjg
	 8EoYCg8aDZxIC6di3GNoii+QqgdTvzIra/X8IQT1hqm7XNb81jUqUxZBN7R8Gs9g22
	 V4Vd7Ij22vpFQ==
Date: Tue, 25 Nov 2025 14:09:49 +0000
From: Simon Horman <horms@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: lan966x: Fix the initialization of taprio
Message-ID: <aSW4rWMipK3Qg2iU@horms.kernel.org>
References: <20251121061411.810571-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121061411.810571-1-horatiu.vultur@microchip.com>

On Fri, Nov 21, 2025 at 07:14:11AM +0100, Horatiu Vultur wrote:
> To initialize the taprio block in lan966x, it is required to configure
> the register REVISIT_DLY. The purpose of this register is to set the
> delay before revisit the next gate and the value of this register depends
> on the system clock. The problem is that the we calculated wrong the value
> of the system clock period in picoseconds. The actual system clock is
> ~165.617754MHZ and this correspond to a period of 6038 pico seconds and
> not 15125 as currently set.
> 
> Fixes: e462b2717380b4 ("net: lan966x: Add offload support for taprio")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> ---
> v2-v3:
> - start to use the define
> 
> v1->v2:
> - add define for system clock and calculate the period in picoseconds

Thanks, I agree with this analysis.
And believe v3 addresses the review of earlier versions.

Reviewed-by: Simon Horman <horms@kernel.org>


