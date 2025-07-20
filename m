Return-Path: <netdev+bounces-208405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F7B0B4F0
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 12:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F313917B5E4
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049A112B94;
	Sun, 20 Jul 2025 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8CW69PX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF279CD
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008345; cv=none; b=osNajXWFw8lfcYpHMZLN/GCzwPV+JjSMp9jBaJ3lWqX7zNBvTG5p2ciJzxjKMjvOYEVt469JXmMvQi8SN/lNdpfbsWwQ2KeGuxLcUtD5p12V49X6X/OiV5PPMKWpP7x2J6zI1P5Y35NdRSm3vCk5L85Pq7wTkYfMkZEnMYNaxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008345; c=relaxed/simple;
	bh=DN719qsScgBppgUAmwXoJ0mGKLQSOt3EtG58RyMWE1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na5bvoibTufwWJa2M2z9/dmnK+MDqXAJd+wHSyVrwcagnjRw5/3MJOMJg0hM/TX/710jIyf20b2UFos6j7Inm8O6tMQdnEEe4IEZwWJ5rAb6Mqi2pMd66tOI7GZsfw3VkEI/+fywGxU8Vyy+gEy0Ch/ekSkhntYwDhZThZrgXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8CW69PX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8F8C4CEEB;
	Sun, 20 Jul 2025 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753008345;
	bh=DN719qsScgBppgUAmwXoJ0mGKLQSOt3EtG58RyMWE1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8CW69PXm+6ZCGN76xnQDueS0cH1fryY85s0KlBaStVCvi0NV98J/SMFGaxsWy7RK
	 v6QwQ/Ius9t3jjCKsTCzHdmWg4REwZ4YZKACkIUqbGirbdGtfNWfuOChLBMnrct0cE
	 rq6YiiE+jKZU0L22y/On5JgeqCUZFaH5N9HJi9T83UoTL1VGJWOxuOcESdX2wh2d8E
	 VYbRa6hrMXEF2rPOW1lT+d7F7/s7I3OsT/U/zUh9Z0E9L86hWC0LZBXdRfnVK5qZR2
	 uOojWuKW4IqJ6LAm/i2gZnVz3FkCyuBQRXMrk2v8MnFP2khwBge7Z02zziLy+rmyen
	 UhlyFRpZG3qdQ==
Date: Sun, 20 Jul 2025 11:45:40 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
	ricklind@linux.ibm.com, davemarq@linux.ibm.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2] ibmveth: Add multi buffers rx replenishment
 hcall support
Message-ID: <20250720104540.GU2459@horms.kernel.org>
References: <20250719091356.57252-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250719091356.57252-1-mmc@linux.ibm.com>

On Sat, Jul 19, 2025 at 05:13:56AM -0400, Mingming Cao wrote:
> This patch enables batched RX buffer replenishment in ibmveth by
> using the new firmware-supported h_add_logical_lan_buffers() hcall
>  to submit up to 8 RX buffers in a single call, instead of repeatedly
> calling the single-buffer h_add_logical_lan_buffer() hcall.
> 
> During the probe, with the patch, the driver queries ILLAN attributes
> to detect IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT bit. If the attribute is
> present, rx_buffers_per_hcall is set to 8, enabling batched replenishment.
> Otherwise, it defaults to 1, preserving the original upstream behavior
>  with no change in code flow for unsupported systems.
> 
> The core rx replenish logic remains the same. But when batching
> is enabled, the driver aggregates up to 8 fully prepared descriptors
> into a single h_add_logical_lan_buffers() hypercall. If any allocation
> or DMA mapping fails while preparing a batch, only the successfully
> prepared buffers are submitted, and the remaining are deferred for
> the next replenish cycle.
> 
> If at runtime the firmware stops accepting the batched hcall—e,g,
> after a Live Partition Migration (LPM) to a host that does not
> support h_add_logical_lan_buffers(), the hypercall returns H_FUNCTION.
> In that case, the driver transparently disables batching, resets
> rx_buffers_per_hcall to 1, and falls back to the single-buffer hcall
> in next future replenishments to take care of these and future buffers.
> 
> Test were done on systems with firmware that both supports and
> does not support the new h_add_logical_lan_buffers hcall.
> 
> On supported firmware, this reduces hypercall overhead significantly
> over multiple buffers. SAR measurements showed about a 15% improvement
> in packet processing rate under moderate RX load, with heavier traffic
> seeing gains more than 30%
> 
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> Reviewed-by: Brian King <bjking1@linux.ibm.com>
> Reviewed-by: Haren Myneni <haren@linux.ibm.com>
> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

...

