Return-Path: <netdev+bounces-203523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A63FAF646C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9FD170A1D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC32241122;
	Wed,  2 Jul 2025 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKYC5LkU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168CE23D2B4;
	Wed,  2 Jul 2025 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493338; cv=none; b=CkI+k05WzKhoYb+sk2b/yD4wstKWaCsWwpTXRfXEkhI7fm6Bzj2mxWuuc4RH3hRFiX3WAnKlDQys3HyslbAFxyqhuA2DerK1cWR/KJQ9ysLzTGX8HtibNXfj1BUWjTNshtQbxJ+atUnpdoZ7x6Yp5PzSEb6ondE5sm4XJCnsHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493338; c=relaxed/simple;
	bh=TapG3+JaLlTv1hF0CipdWOSnkgSHAbCyu7aPQb1n74A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gu3Dj6Ipr3A4G1ncd06N5sBWO+EYj2QJ82SlildvWQKuHbamiRAXVi5dbVBtMjRx7kt0uIWgTTGy09oMAU5DFR9vURG6GuFA0cI8wjRUnimA0ELrTB8qbO1LM/YY+5r/dWMePaSVu47PUazxjzhGTNFSGnuRW4V9JKxsfZn31Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKYC5LkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38196C4CEE7;
	Wed,  2 Jul 2025 21:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751493337;
	bh=TapG3+JaLlTv1hF0CipdWOSnkgSHAbCyu7aPQb1n74A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aKYC5LkUwDX0ykRw+wH6my9oyimuCO1OZjbJt0g8xasmWSinrremCDfRc2DC+KQnc
	 ZqXa2IwgSqZUIU54nNFmTdIapgPZhD9uJxZ4xPC+r7daG7LYS4xuenzz/sW2GSc325
	 alyftUM37JYPz4yikS6b4mjQLui/IbNF7scw/0uNAnlk388mAGj4cHjvaG+wFcggOy
	 WpNqE9PHCzX8xZNBhcnUZYWuVfWGwl3efgYL5mHblAf9PPt9RGRW27E2RKqhun6hBL
	 m0Y7gMibVBcxTaWk51ndRl4JQswWfXTZhhqDMEYyn1tBq8b/txyBTRxaNwbvgdtDuy
	 aCXL1GaiZZ0Cg==
Date: Wed, 2 Jul 2025 14:55:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ptp: remove unnecessary mutex lock in
 ptp_clock_unregister()
Message-ID: <20250702145536.08a6aa7a@kernel.org>
In-Reply-To: <20250701170353.7255-1-aha310510@gmail.com>
References: <20250701170353.7255-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 02:03:53 +0900 Jeongjun Park wrote:
> ptp_clock_unregister() is called by ptp core and several drivers that
> require ptp clock feature. And in this function, ptp_vclock_in_use()
> is called to check if ptp virtual clock is in use, and
> ptp->is_virtual_clock, ptp->n_vclocks are checked.
> 
> It is true that you should always check ptp->is_virtual_clock to see if
> you are using ptp virtual clock, but you do not necessarily need to
> check ptp->n_vclocks.
> 
> ptp->n_vclocks is a feature need by ptp sysfs or some ptp cores, so in
> most cases, except for these callers, it is not necessary to check.
> 
> The problem is that ptp_clock_unregister() checks ptp->n_vclocks even
> when called by a driver other than the ptp core, and acquires
> ptp->n_vclocks_mux to avoid concurrency issues when checking.
> 
> I think this logic is inefficient, so I think it would be appropriate to
> modify the caller function that must check ptp->n_vclocks to check
> ptp->n_vclocks in advance before calling ptp_clock_unregister().

Please repost this and CC Vladimir.
-- 
pw-bot: cr

