Return-Path: <netdev+bounces-105372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE33910DAE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8281C2092D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED11B3F14;
	Thu, 20 Jun 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyJDeUbX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC01B3723
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902484; cv=none; b=B2jzS6pXgezaJjL8ySEdQa97V86/+jQ2J82eRBxxWAAG3URmw9hhN2oeTcGrYWxD4PZWLvWZUTYEa2UZr6Xi4QtjCnEj8UbQtXFcZAoicVX2ZLtcinKnjUkFNxtiUBb8aoCiRdXZFxBLjQitJtXquehgw+sgcf3dsi+n6g3yK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902484; c=relaxed/simple;
	bh=8hM1D0x7jh1m7mKcWw9zgf9F6+LPw0LMDdXyH+Evroo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nie6x2j5sh5mxPRrGL6j5xu7MKWy2Yjw4jyCMJ1QQNT5V0g5mLuKcXENb7myxtSzrb8V1yd/Di4Lq14qnnx9yzYwScdcoOU7U7QKaFkE+8PwnN2V2PUDsiA8CICxwATJ7T0YqSnop0YmnvKvK33VUDmw09qnpqS0DmbDYAwVwLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyJDeUbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BF7C4AF09;
	Thu, 20 Jun 2024 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718902483;
	bh=8hM1D0x7jh1m7mKcWw9zgf9F6+LPw0LMDdXyH+Evroo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyJDeUbXZ+nN7+9ceqOt6fzJQn578wRR9d2dqsPtTzhPQ21uwUJ3Bo4bzGkg402sp
	 uQU3ggUri5Gz05HSQNwy6YG9ybJ7QZal237EDkCVK6J5uwDuCsDIJTtZ4v+CmPv2zZ
	 OAq/ee3MWl9aBKbyUHhJIG/qrpqE9PdoMNPIk1LtcjcTAxNNorcSgixYoHhmCZ86VA
	 TxYepi6r2VNy1DI9lBPkpJP81rnjVaK2x9UomEvY19xHAgXNGCR5v5sY+21dLdZKr7
	 Lwyj5W7XpOD/4qyARlOl+3gTjR3kk+l4+vorTt6e9O0ljfy+RCXKay51xzd36ZH1/E
	 UVvOzdwwMUQow==
Date: Thu, 20 Jun 2024 17:54:39 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/2] bnxt_en: implement netdev_queue_mgmt_ops
Message-ID: <20240620165439.GN959333@kernel.org>
References: <20240619062931.19435-1-dw@davidwei.uk>
 <20240619062931.19435-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619062931.19435-3-dw@davidwei.uk>

On Tue, Jun 18, 2024 at 11:29:31PM -0700, David Wei wrote:
> Implement netdev_queue_mgmt_ops for bnxt added in [1].
> 
> Two bnxt_rx_ring_info structs are allocated to hold the new/old queue
> memory. Queue memory is copied from/to the main bp->rx_ring[idx]
> bnxt_rx_ring_info.
> 
> Queue memory is pre-allocated in bnxt_queue_mem_alloc() into a clone,
> and then copied into bp->rx_ring[idx] in bnxt_queue_mem_start().
> 
> Similarly, when bp->rx_ring[idx] is stopped its queue memory is copied
> into a clone, and then freed later in bnxt_queue_mem_free().
> 
> I tested this patchset with netdev_rx_queue_restart(), including
> inducing errors in all places that returns an error code. In all cases,
> the queue is left in a good working state.
> 
> Rx queues are created/destroyed using bnxt_hwrm_rx_ring_alloc() and
> bnxt_hwrm_rx_ring_free(), which issue HWRM_RING_ALLOC and HWRM_RING_FREE
> commands respectively to the firmware. By the time a HWRM_RING_FREE
> response is received, there won't be any more completions from that
> queue.
> 
> Thanks to Somnath for helping me with this patch. With their permission
> I've added them as Acked-by.
> 
> [1]: https://lore.kernel.org/netdev/20240501232549.1327174-2-shailend@google.com/
> 
> Acked-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


