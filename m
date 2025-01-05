Return-Path: <netdev+bounces-155236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D747A017C1
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7856A1883873
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C063A9;
	Sun,  5 Jan 2025 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRPbgO46"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80328184F
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736041314; cv=none; b=MjvTQoSwKCyubpyU7gLY2s7iOjozuRdipo3pZxXqU/TT2KrxwR0IvEhcSmJrKANLsKd5njB0gFNSkathbAvk0L4ZxrXdNe7RBNuYiCEvbu3oaKdfoIPfOxzvJHoysWppJpDCjOkTx1s4tTYfgzBQIFbHtg5wHJ9pHv/LZv2nRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736041314; c=relaxed/simple;
	bh=wnuOmQrE6xZce8avs957ZCFh1Ot5Mti2VV+3VjMbLFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmJGq9rUHaaGTTtb5xpZQdK6+PZPMMmDa/K763T8KLec2DuQynkUxz/SkRZY4EJq4TlbYELry2mgTaUjJUgcN2B7wSrvokvxcGn3uxDffVDq/dlbfR7OeIdyCgQMO1KLahmEOJU22T/S7xcVh5LdKH5AAxG6WDCyw6xA+oAOqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRPbgO46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE095C4CED1;
	Sun,  5 Jan 2025 01:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736041314;
	bh=wnuOmQrE6xZce8avs957ZCFh1Ot5Mti2VV+3VjMbLFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gRPbgO46XF8bmTG+/4IjM8pGEILQURogThTfFV2dkdcov9ETml4QwMfbjtwj68rzi
	 LSrFn46FoRj4ZIH2VpLF13ie8cufG8nFDG6ILrfRKwhO7E6lgGa8l3AVPxOlxhpXvr
	 0+DUYHytGp7RkMeURmPwyYlwu4qy8ktQdXxD6DCGRSm4g7YnZEkmZrZ7B9It1ALq9u
	 Sr8t/NZucp19cIltvL8kfDitcD/VdjVte0YFzx3/KVLiYiPYLdCvA5AcU4ApUrcPG2
	 hb4QZarJYl/MtYZsNPNyQJtGzTQ4OM+4AdfLjxyuErKQLQbkUz4AvrdScG2M5GqzjJ
	 oip1vGhRHhnDw==
Date: Sat, 4 Jan 2025 17:41:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next v4 4/6] enic: Use the Page Pool API for RX when
 MTU is less than page size
Message-ID: <20250104174152.67e3f687@kernel.org>
In-Reply-To: <20250102222427.28370-5-johndale@cisco.com>
References: <20250102222427.28370-1-johndale@cisco.com>
	<20250102222427.28370-5-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jan 2025 14:24:25 -0800 John Daley wrote:
> The Page Pool API improves bandwidth and CPU overhead by recycling
> pages instead of allocating new buffers in the driver. Make use of
> page pool fragment allocation for smaller MTUs so that multiple
> packets can share a page.

Why the MTU limitation? You can set page_pool_params.order 
to appropriate value always use the page pool.

> Added 'pp_alloc_error' per RQ ethtool statistic to count
> page_pool_dev_alloc() failures.

SG, but please don't report it via ethtool. Add it in 
enic_get_queue_stats_rx() as alloc_fail (and enic_get_base_stats()).
As one of the benefits you'll be able to use
tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
to test this stat and error handling in the driver.

> +void enic_rq_page_cleanup(struct enic_rq *rq)
> +{
> +	struct vnic_rq *vrq = &rq->vrq;
> +	struct enic *enic = vnic_dev_priv(vrq->vdev);
> +	struct napi_struct *napi = &enic->napi[vrq->index];
> +
> +	napi_free_frags(napi);

why?

> +	page_pool_destroy(rq->pool);
> +}
-- 
pw-bot: cr

