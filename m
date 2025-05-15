Return-Path: <netdev+bounces-190586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5513AB7B68
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDB417B092
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1BB277808;
	Thu, 15 May 2025 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuoUFVv2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773052690FB
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747274959; cv=none; b=Z9GcFnIbxuSKS11Pp3QZnHg8L/is3lcpEJpd5VobJapiHDyxMt1nRUtKPNYRqplLfXS2oP3G6tAbUPvgBMVEhuz3KjGfn+s1pOxM9P5tRyDj7uHuaiZktdhrQmF91uYnOoH/ehXVqjtkEqxY7q2EXxLATHOSBpo5s1k9+9cGMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747274959; c=relaxed/simple;
	bh=9JLt0pzyhfvU1pbbM+JOpnBKps/nmijZ8yFfJ1YHDWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wo/Rl2hZH/maGUpV/beVpeyz3/Geko0LcbmoOsEIHDrVo+O8azATUq1iSQMtHy9WwFr5CemgrKn98aF7ij/DPjMD4V/5KOw8jdF3apxnWs2IHF5DpqvzPc2QKPL7ednWDsu5T6aeqwmBu7324lYPTRdoa8UcBM2zfrJhPujEoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuoUFVv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9F7C4CEE3;
	Thu, 15 May 2025 02:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747274958;
	bh=9JLt0pzyhfvU1pbbM+JOpnBKps/nmijZ8yFfJ1YHDWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cuoUFVv2xlfrKtpuWX9A+DndNJWuO5Hfhrzhf9UvU/kUdxx+zhDuSZXHNYyGwloQa
	 uEnz1djkPQnldoc1YbxIveuqyB9Qj53FgTTQX/MX3jL1ffuYX7JOROQPgcA/I2nWtC
	 KSIwuHpyRPV7BWbW9c+bdvwUKBjp3mzEwD45/OT6zMf4puv2D2wHShyqU/4vUPIAVZ
	 puKwkdryhfHaKu1mRH6/5LhUJ5jCDJoXbvzgepf7RfxcXNrbIeEJ0sB09IgLju3u/6
	 yNY8tL8Ovps/7NAqZOXSh718ckMfUaV1AxqeZJ2XldLBcq5Xw9DpvdRzZvz0s5L1w/
	 QLy/LuzJWovvQ==
Date: Wed, 14 May 2025 19:09:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix page recycling in
 airoha_qdma_rx_process()
Message-ID: <20250514190917.4b0ff404@kernel.org>
In-Reply-To: <20250513-airoha-fix-rx-process-error-condition-v1-1-e5d70cd7c066@kernel.org>
References: <20250513-airoha-fix-rx-process-error-condition-v1-1-e5d70cd7c066@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 18:34:44 +0200 Lorenzo Bianconi wrote:
> Do not recycle the page twice in airoha_qdma_rx_process routine in case
> of error. Just run dev_kfree_skb() if the skb has been allocated and marked
> for recycling. Run page_pool_put_full_page() directly if the skb has not
> been allocated yet.
> Moreover, rely on DMA address from queue entry element instead of reading
> it from the DMA descriptor for DMA syncing in airoha_qdma_rx_process().
> 
> Fixes: e12182ddb6e71 ("net: airoha: Enable Rx Scatter-Gather")

Missed your sign-off.
-- 
pw-bot: cr

