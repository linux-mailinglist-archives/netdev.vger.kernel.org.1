Return-Path: <netdev+bounces-215423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B5B2E98D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E9E1CC2A9F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 00:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EAA1B2186;
	Thu, 21 Aug 2025 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B55qTNNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853881917F0
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737123; cv=none; b=f9i9MJqec5Yd2Vhv0Zbul9NjX6uTgDrk+PI0Wwp6dTrvIFkKq64+/d7a6orVcN22lhaBBqFxnMY/luDEDg0JaTVBPQbJrD0GrtC9Wjz4ngQih8Nls4zgRTt2vlrS3a3YNBtxceiJLCCUbC80iw9/RwEMOiDmms4ijhx/dnb9j5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737123; c=relaxed/simple;
	bh=Lw9YDP10paoS9kglYlQmGCYm/re96Lbg+P98QZNBQGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+NZKeWUsXnqlbk4myUrR4GYnyBaou3BYs8jUE+KQZob4q+72RNCmxNnyOUn5dJabcH5KTYko/6oUEK+g+XmiR+DVV7t4nlmYg3YrhGTJv3aQw4LIsz2UYezbGvPuDyJ3WjGzrmTfbLJL5NrhL6Cabrfe/VZ47jLNQIaWXyDP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B55qTNNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F1C4CEE7;
	Thu, 21 Aug 2025 00:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737123;
	bh=Lw9YDP10paoS9kglYlQmGCYm/re96Lbg+P98QZNBQGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B55qTNNN/cuBaRpF8A5Rkr73YqX9aEAPYr/GfLd4m6fVz+Qqz9yMUefiIeylSFG/k
	 CT3U67tjTEtfkr+g7qMJ7yOuJSg1viriWvP1SMuPNICTV95uIZiCr3PDqJQztVAkHt
	 q4USFivHNA/3Kzi8OPDNq4ZoDS8U6TsOAeyQPGcTM6n5EWkYHgU9Gt3vSWLLeyLygy
	 +9XjONxX/5Mpu5OVa1VTVzBsBHS4PYAqztlCzQZ8kxv7aY1UM0dcEgGf/qdn8a4laL
	 7y6sUHxsKbLFtr0GqqSSp76nPzagd69RDBvCWG9xmJNhboynRwm58ecYA9LaDMRwo4
	 JT35riSwEyB8A==
Date: Wed, 20 Aug 2025 17:45:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, tariqt@nvidia.com, dtatulea@nvidia.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, alexanderduyck@fb.com,
 sdf@fomichev.me
Subject: Re: [PATCH net-next 12/15] eth: fbnic: allocate unreadable page
 pool for the payloads
Message-ID: <20250820174521.41251949@kernel.org>
In-Reply-To: <CAHS8izMEwmcMQ7Z53Z6uV6NJyVQ40ew+CMmCBMHjwYNC3QtdMA@mail.gmail.com>
References: <20250820025704.166248-1-kuba@kernel.org>
	<20250820025704.166248-13-kuba@kernel.org>
	<CAHS8izMEwmcMQ7Z53Z6uV6NJyVQ40ew+CMmCBMHjwYNC3QtdMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 16:33:18 -0700 Mina Almasry wrote:
> > +       if (page_pool_rxq_wants_unreadable(&pp_params)) {
> > +               pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
> > +               pp_params.dma_dir = DMA_FROM_DEVICE;
> > +  
> 
> Although I'm not sure why the dma_dir needed to change specifically
> for unreadable.

Driver defaults to BIDIR AFAIU to avoid having to reset the
datapath when XDP is bound. But BIDIR is not compatible with
unreadable mem, and for good reason.

Will add to the commit msg.

