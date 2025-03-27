Return-Path: <netdev+bounces-177985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5DA73A26
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 18:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED50188CF0A
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B45C15F306;
	Thu, 27 Mar 2025 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce4DHQuN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67463F9FE
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095335; cv=none; b=brEokt2CzaTlf/jd03TgvXtoIEl7isU/ernlsVaLZ7ZkskTdiVuPlpVe8F5st6zUq3L7XofKNtM9FDNEZselqL6w2NF8AzFgW2MApXCvstvKai7qUnSrajDZ7nbPmaShss72slS6b9WVjxhdx3/3zoZxVHNIGvps8A/dHIGekNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095335; c=relaxed/simple;
	bh=liOfZ/kDgmZDCaBiAWZo8Gm23d4TFhcnRESDbheLmeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdljEVz4POm7mYFTt7v446oVJbg2jp6pIltB0Rd93RDDDtnVkhfBtyD52f4c7MHUDldwNQqg7TxpjHk87WgEbtgM38aPri5K7DBDMX6YpiifMV7rCxCDy4Ao4T0GV3Z6Ci0qEq1xA23PoKgEI95ZRuFd9hIU5UixnnFQrhZVXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce4DHQuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541F8C4CEDD;
	Thu, 27 Mar 2025 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743095334;
	bh=liOfZ/kDgmZDCaBiAWZo8Gm23d4TFhcnRESDbheLmeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ce4DHQuN1LPZLaSxJR+pbdvcwKrc+QolG8cAE25Mc5LkPcIxeGxZWKovBiNh0JwGd
	 RyeenkCeoLntZfz8cVpr574Jp4W9bje/Q+wAtQ4YlmlmDjlMgx+8XNiBCVzL22ym9W
	 hAGzMlq7FhqdXIMTrCrstinpD8JW9vOfODksRIEMFZEoDWRJ0wdWlzEYUu6whjjQjo
	 RG2tTlzs/XUiQc9t3HezY7W+X6Ux1lqwDnTL+1dJb0NxYoNIyyLY9Bwd3HuEpGRt5L
	 77b/tL0bASDLTASN/jozE9QwKE6XYMhn6tB6bkaT4PAWTYUVD43lMIa48w8dekzSP8
	 B+FF1MVZs8x9A==
Date: Thu, 27 Mar 2025 10:08:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Samiullah Khawaja
 <skhawaja@google.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] Add xsk_rr an AF_XDP benchmark to measure
 latency
Message-ID: <20250327100853.14bfce4f@kernel.org>
In-Reply-To: <Z-SAgPijHtVP6S3n@mini-arch>
References: <20250320163523.3501305-1-skhawaja@google.com>
	<Z-Hdj_u0-IkYY4ob@mini-arch>
	<CAAywjhTzmupd=ehmve=iDtK638=6_yKyi9WOM9L=tG2CM4n=oQ@mail.gmail.com>
	<Z+R9d55KFikYXGm0@boxer>
	<Z-SAgPijHtVP6S3n@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 15:32:32 -0700 Stanislav Fomichev wrote:
> > As you said it's benchmarking tool so I feel like it should land in
> > https://github.com/xdp-project/bpf-examples where we have xdpsock that
> > have been previously used for benchmarks.  
> 
> I don't think it matters where the tools live. I'm more interested in
> the general guidance on whether we want to continuously run those tools
> on NIPA (on real HW) and track the numbers. Unfortunately it's gonna put
> extra load on the maintainers in terms of tracking and acting on failures,
> but it feels like it's a good direction in general.

I think we should try. Mina is working on merging the page pool test
AFAIU, this is even easier cause it's just user space, no magic modules
to load.

