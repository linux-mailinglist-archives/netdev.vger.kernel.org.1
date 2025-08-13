Return-Path: <netdev+bounces-213515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA78B2575C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 01:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C1F1C248EE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1A2D0C80;
	Wed, 13 Aug 2025 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clM17nEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0847301490;
	Wed, 13 Aug 2025 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127123; cv=none; b=tz1ktKgbBQ36UcPIKFTAMXRgVu2A2e/39VJhhkf2hq5Q9v9R/HL13B7A45XmYAVmRPVmgsRObBdBHTq9h1VrEftBVRxMYLBhAtD8Vhlz01NY6WWMuqcmUDzQW6F9Ja2cf8gvKBAqezZiYncObQRfkX9Z3WMm1tceKuRioHs7zQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127123; c=relaxed/simple;
	bh=lhIQxzr3DuEkga2iHGADkHZ7fFBhMHQcFKPR3xyRtN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jh8ux1w7tFY+6qx5KLySXPp4r0d/ugiAUcX4P283S+eLKyQ0FrzoO6OXug9ib74gpzbOamHi2qH9ui+K8QGAAfJtfeW/eW/OZ8k07i7fI/Qu8GFhJVxNNJmmE1LyIuR2e4q7V8bV3JOcBYDreyKIBBKsIwjp75IviZ5g0O8nxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clM17nEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90B1C4CEEB;
	Wed, 13 Aug 2025 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755127123;
	bh=lhIQxzr3DuEkga2iHGADkHZ7fFBhMHQcFKPR3xyRtN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=clM17nEV7nTHsfRaLcq+fHq8MfMT9FYqgVgmEJYTkXn0qMtkRcOgGh94JEJR8y/JX
	 zOAdS9iNrVv9yfc0HNhvitIvdaNKx3bSReyDGYK+/VGYK6GW9gGX+Y059mP35h65Fu
	 B0iWp5WaUcVMbHU/ryyrwCouG10Gdn3W6TGTuFurKWN5ScHsxZnu/q1OtbUAynZYqr
	 +6n8W5P6UU+jDcXZvyjdaRd/0EU+nM6OwjNJL2cwBCAvIW+FPE0xob8fnErZNXwnQy
	 UGOOedsZbHstbNa6qdpq4gFlmz6oqq1BIveEecNi+9K2G34uiFjbpLiMJtBDJxqcUo
	 J9GeGHi4LMBhA==
Date: Wed, 13 Aug 2025 16:18:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Jonas Karlman <jonas@kwiboo.se>, David Wu
 <david.wu@rock-chips.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Chaoyi Chen
 <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH net-next v2] net: ethernet: stmmac: dwmac-rk: Make the
 clk_phy could be used for external phy
Message-ID: <20250813161841.04f5ff73@kernel.org>
In-Reply-To: <20250812012127.197-1-kernel@airkyi.com>
References: <20250812012127.197-1-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 09:21:27 +0800 Chaoyi Chen wrote:
> For external phy, clk_phy should be optional, and some external phy
> need the clock input from clk_phy. This patch adds support for setting
> clk_phy for external phy.

This patch doesn't seem to apply to net-next/main, please rebase &
repost.
-- 
pw-bot: cr

