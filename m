Return-Path: <netdev+bounces-109036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8B926968
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6981F25713
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64542A1BB;
	Wed,  3 Jul 2024 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqKmwWVV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292C136E3F
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037706; cv=none; b=u82b7bNoGt39HZ/RKDD6KCG7dRAzDORU4jFfiGhu8nizGqDaaEJpqUR5xkFU0nHoHHBxssAwWqtxmbuNyldzaTGnyIzuDlqkBuzVtsWtcUg/jW6tOA2mMvsLcKZi4wMi81DCbEdfb2ngHcYlqzi3QA93AsQxK9MgOT5AkQskD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037706; c=relaxed/simple;
	bh=CX6EpB+8zF2oozz+uP8cnGpfBXYiKld+cOHtUJb/xv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJihtmIHe5C+kpU7HI9z+cRD4hX/MbBfXgECc4zuo1UVb7mf5zMTwJ0ZH95CSxVLMscYYARcFUe5QItRIB8OscMwhVeHHvlDYoE0KxbZX7zLcD7taiJUHS2rARJo7hsbRjSS1ef9ECyyB+tKBQL+rB83dp9xbpzcx9i9bDm8c88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqKmwWVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC23C4AF0A;
	Wed,  3 Jul 2024 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720037706;
	bh=CX6EpB+8zF2oozz+uP8cnGpfBXYiKld+cOHtUJb/xv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqKmwWVVGqFy64xTWOYBQP7JEafqw4CeMFWGXl9EM/F69gosNj3tChPrriwyM/pvm
	 e2wQ+3xeuGQRT/k6by/FaMjL+hbkHMSICjS/d1IUbDXmFiiXt7/RRMZpnoUkrH1dHv
	 N1+oqrbnGvhw//i6KGHzH0aYScPwXPU+RECi1tT150qEH3JAz28MdqmIaXvntcFigq
	 XE5FeP4kaa+Ga6B7CanQg7LXFHk20JAoilAqj1knF7wkgAHrHmuLDSvtGa3S3jBBUI
	 wXiX7WO0kKaQ0gVYYpOrdYpGPTOGj4ZgNwG1RFCiMOFMZ9HRfWkMbtFoS1whxQhAvf
	 ulF0YG0wIu66g==
Date: Wed, 3 Jul 2024 21:15:02 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, kernel-team@meta.com
Subject: Re: [net-next PATCH v3 08/15] eth: fbnic: Implement Tx queue
 alloc/start/stop/free
Message-ID: <20240703201502.GS598357@kernel.org>
References: <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
 <171993241104.3697648.17268108844942551733.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171993241104.3697648.17268108844942551733.stgit@ahduyck-xeon-server.home.arpa>

On Tue, Jul 02, 2024 at 08:00:11AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Implement basic management operations for Tx queues.
> Allocate memory for submission and completion rings.
> Learn how to start the queues, stop them, and wait for HW
> to be idle.
> 
> We call HW rings "descriptor rings" (stored in ring->desc),
> and SW context rings "buffer rings" (stored in ring->*_buf union).
> 
> This is the first patch which actually touches CSRs so add CSR
> helpers.
> 
> No actual datapath / packet handling here, yet.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

...

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c

...

> +void fbnic_fill(struct fbnic_net *fbn)

Hi Alexander,

Although it is done as part of a later patch in the series,
to avoid W=1 builds complaining, it would be best to add
a declaration of fbnic_fill to this patch.

> +{
> +	struct fbnic_napi_vector *nv;
> +
> +	list_for_each_entry(nv, &fbn->napis, napis) {
> +		int i;
> +
> +		/* Configure NAPI mapping for Tx */
> +		for (i = 0; i < nv->txt_count; i++) {
> +			struct fbnic_q_triad *qt = &nv->qt[i];
> +
> +			/* Nothing to do if Tx queue is disabled */
> +			if (qt->sub0.flags & FBNIC_RING_F_DISABLED)
> +				continue;
> +
> +			/* Associate Tx queue with NAPI */
> +			netif_queue_set_napi(nv->napi.dev, qt->sub0.q_idx,
> +					     NETDEV_QUEUE_TYPE_TX, &nv->napi);
> +		}

It is fixed in a subsequent patch of this series,
but a '}' should go here.

> +}

-- 
pw-bot: changes-requested

