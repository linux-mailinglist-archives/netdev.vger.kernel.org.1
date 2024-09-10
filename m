Return-Path: <netdev+bounces-127034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD02B973C4F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CF91F25FDE
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E7419E972;
	Tue, 10 Sep 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJRk/7Ta"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9A219E837
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982662; cv=none; b=mvhTumjpfXQAKegXOtM6t8P+XzY5QRsr2uXexc5ewFvfH4/4rQQmYzG7Gh0MHzfkhKhHO7E5u9C28KNFdQUg83pLnW3mXApp0n9AFZaT2ZYssdfQswrwrTYoHTXCJxN2htqLDisXl4kisFHZQAkJtnfk2c4sFA6KIdt52G3BtpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982662; c=relaxed/simple;
	bh=8H5/pVvtE8js+xbGqz3EtiubkdUFXND9lgTzxGHbmDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgalc6Ey+/chUjebl7T1fFjlp3awBIHQUgPN9BTTvNfKYYO1IMGSny3YQ+dH2dojIInq0BRANfAXsuCI/uqYR5hKQbB1zQ0RZCjDHVS7WDqwRiuPza6nOoLVUDf3oqQu/VOexL0CnD3wU5gBHbXpYE2zHR9KZmBB9hdFvrXeF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJRk/7Ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B1CC4CEC3;
	Tue, 10 Sep 2024 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725982661;
	bh=8H5/pVvtE8js+xbGqz3EtiubkdUFXND9lgTzxGHbmDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vJRk/7TavdxXCe5ChbvEa/v03waUXEDuVNyGLTB1VPQ4SNFWTyUypY6R10wZki8u9
	 IiWd/7q1pUKvZEhv59FSUcMzLmp4CLVaW3E//6c70T5ouID6S8S7gmcFVFJgRqtnsw
	 lyAtHiRZn84NuvlvlFPei0a91HcTv1DYZFMxNFgEbtNukBMU2+hPm5J/6Srqx2NpP1
	 swiBpiQBG5tfAglRwR20DTiq6AjraGl+N3FFRqcNG8zvFiOaDDmvBgVin1bDTTGLYF
	 TV+LWMvTWjgvSC41B3GM26vhwJ7UvlPXl5coTFUDWRv3A2IlgStwKE27NlI3+nJUwB
	 TJ9ayCngt5hLQ==
Date: Tue, 10 Sep 2024 08:37:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, jacob.e.keller@intel.com
Subject: Re: [PATCH v2 net-next 6/6] sfc: add per-queue RX and TX bytes
 stats
Message-ID: <20240910083740.37d5a305@kernel.org>
In-Reply-To: <81f76aa1-bcdf-f38c-615e-2aa6ed57581b@gmail.com>
References: <cover.1725550154.git.ecree.xilinx@gmail.com>
	<fe0d5819436883d3ba74a5103325de741d6c3005.1725550155.git.ecree.xilinx@gmail.com>
	<20240906190344.2573fdd2@kernel.org>
	<81f76aa1-bcdf-f38c-615e-2aa6ed57581b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 16:03:04 +0100 Edward Cree wrote:
> >> + * @tx_bytes: Number of bytes sent since this struct was created.  For TSO,
> >> + *	counts the superframe size, not the sizes of generated frames on the
> >> + *	wire (i.e. the headers are only counted once)  
> > 
> > Hm. Hm. This is technically not documented but my intuition is that
> > tx_bytes should count wire bytes. tx_packets counts segments / wire
> > packets, looking at ef100_tx.c 
> > qstats "bytes" should be the same kind of bytes as counted by the MAC.  
> 
> Well, even if we calculated the wire bytes, the figures still wouldn't
>  match entirely because the MAC counts the FCS, which isn't included
>  here.  We can add that in too, but then one would expect the same
>  thing on RX, which would require an extra branch in the datapath
>  checking NETIF_F_RXFCS and I didn't want to take that performance hit.
> So my preference here would be to keep this as skb bytes rather than
>  wire bytes, since as you say it's the packet count that really
>  matters here.

Right, that's fine. But just to state the obvious - adding / subtracting
FCS bytes is relatively easy for user space to do (assuming RXFCS
handling is correct, as you mention). Converting from LSO bytes to wire
bytes is impossible, FCS is fixed size while header length varies.

