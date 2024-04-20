Return-Path: <netdev+bounces-89796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D6A8AB935
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 05:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F03B21E7B
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1315883D;
	Sat, 20 Apr 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNwsrogw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B62563
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713583537; cv=none; b=Hx/kJmGBumUKEHT+4KUQKxAgc6L4t47mEdnkAKgIKWSm8CbpC23jqhkbLHsRr0hscrcQFzrStdq6VvbYxJgJ9AKBf3GGSqUijyUExnHH0HiDaRfzYo3FNRqsP1zVsJfokLvxOafYGRfqGttkmeEhnTxJQuuub0h22ZIS2Q8qmho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713583537; c=relaxed/simple;
	bh=g1O27Bq7G0LcA9XW/HZGo2PrUBu4rhv9VXjV8nCL9AA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhdjmVCGPCqVtgNFpWkCnfLACQAxSxD42vUw1L7XlEsOUw0GOdE6MZHEHMLQGt1Ly6a0lTq8EkAPACuq1htxZtcjuQ+noHCf9EpcARL+yxKLbM09bZKSp0qtPlUhayca7VlJnhzMJRv9Rux3jzyqrjOa/OfOw0cGb445q5bu2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNwsrogw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1753C072AA;
	Sat, 20 Apr 2024 03:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713583537;
	bh=g1O27Bq7G0LcA9XW/HZGo2PrUBu4rhv9VXjV8nCL9AA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNwsrogwMYVrFShmzlGT+jDJjJZiPZK8AKaGY2r7d/Qt22rJqxDWvFYP73VcPo9jV
	 ELPsCeks8LJ0Yq4abFhwz7bEzZc7B1bS/DhTovATVVQbM8eJUxCsQNgBS1Xvg5yOp7
	 bG3A+b9Kc+9sGP+rv53FurI/AIG8dr68wI6na54LRZfa41DQZViDZPOG0S8IFxTXIj
	 ygeHMWjcKoR8NH2T626MGOelY4MWCVm9Hk6DWfSZWJukeH2988pSCMyqCte+bwxL6Y
	 wyh4SFjmF9/qj60aHk/OOrp3u5hywUnHICnXWD8QsTlJiUlJpVMjX1gcyudfBursxF
	 DpAsfWn/vUZ6w==
Date: Fri, 19 Apr 2024 20:25:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 willemb@google.com
Subject: Re: [RFC PATCH net-next 9/9] gve: Implement queue api
Message-ID: <20240419202535.5c5097fe@kernel.org>
In-Reply-To: <CAHS8izO=Vc6Kxx620_y6v-3PtRL3_UFP6zDRfgLf85SXpP0+dQ@mail.gmail.com>
References: <20240418195159.3461151-1-shailend@google.com>
	<20240418195159.3461151-10-shailend@google.com>
	<20240418184851.5cc11647@kernel.org>
	<CAHS8izO=Vc6Kxx620_y6v-3PtRL3_UFP6zDRfgLf85SXpP0+dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 09:10:42 -0700 Mina Almasry wrote:
> Currently the ndos don't include an interface for the driver to
> declare the size, right? In theory we could add it to the ndos like
> so, if I understood you correctly (untested yet, just to illustrate
> what I'm thinking point):
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c
> b/drivers/net/ethernet/google/gve/gve_main.c
> index 7c38dc06a392..efe3944b529a 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2579,11 +2579,16 @@ static void gve_write_version(u8 __iomem
> *driver_version_register)
>   writeb('\n', driver_version_register);
>  }
> 
> +static size_t gve_rx_queue_mem_get_size(void)
> +{
> + return sizeof(struct gve_rx_ring);
> +}

> @@ -2709,6 +2709,7 @@ static const struct netdev_queue_mgmt_ops
> gve_queue_mgmt_ops = {
>   .ndo_queue_mem_free = gve_rx_queue_mem_free,
>   .ndo_queue_start = gve_rx_queue_start,
>   .ndo_queue_stop = gve_rx_queue_stop,
> + .ndo_queue_mem_get_size = gve_rx_queue_mem_get_size,
>  };

I don't think we need to make it a callback, even, directly:

const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops = {
+	.queue_mem_size		= sizeof(struct gve_rx_ring),
 	.ndo_queue_mem_free	= gve_rx_queue_mem_free,
 	.ndo_queue_start	= gve_rx_queue_start,
 	.ndo_queue_stop		= gve_rx_queue_stop,

> I think maybe if we want to apply this change to mem_stop, then we
> should probably also apply this change to queue_mem_alloc as well,
> right? I.e. core will allocate the pointer, and ndo_queue_mem_alloc
> would allocate the actual resources and would fill in the entries of
> the pointer? Is this what you're looking for here?

Yup. But thinking about it again, this may be more natural once we also
have the open/close path use the queue API. IIUC for now the driver
allocates the queue resources on open, without going via .ndo_queue_*
If that's the case we can keep the code as you have it here.

