Return-Path: <netdev+bounces-225414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91F9B938E3
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919DE2A8512
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557082797B1;
	Mon, 22 Sep 2025 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P05cvPA/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2D26E708;
	Mon, 22 Sep 2025 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583110; cv=none; b=rhhnJ2MNp5fV3D5ilc8JAdsqEQja0lid2Cli5lNHTgkbMCqBNETnUJkFobS3t5OApLTUv84mfMMp64YnaJaDZUyWP4gZqC27QV7GV05iNcwwjIgaoHgIDNPyDa+RUfUhYh2rfVhFOxpE3Q73STEm2T7UuZoZrWHXDT3Oorvk2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583110; c=relaxed/simple;
	bh=QV9vCYaQNSbKXoqYJD0H0GTtH4u6s4//8ot+8KssKTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqT31a9+zmeVif+yb7zcRjMShp7JbJkdZD3+xlB4llKuh1rKHRLpD9VJbZXLPwgz4V014NNQsSQdGTkNTqiW+Ws18OQvq2m2y5M5dyflPr4vh+5yHNt7FYiLOG9Oh3kQO4jsgmF//4UQWgSuudNw5KjPv/2mNguro+/Lfm2oJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P05cvPA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF898C4CEF0;
	Mon, 22 Sep 2025 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758583109;
	bh=QV9vCYaQNSbKXoqYJD0H0GTtH4u6s4//8ot+8KssKTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P05cvPA/EtvXvZZp7CJzTCU0fhYZrRfPvHyvMiy8f4c0kCrrwAqTYWJ9O0NSig161
	 nWPgVVu2jBtJFwwNZRX6gXPXBfUU1C9dUJJnRRLwUN96PMuz3iOWb08sssbAcBDTeD
	 eC6Iq9/48DMZmOgGS/7c8iUQQX4CgXmyFg5xJXrVZi5nEd73GD9cko8t4tkAvE7YOI
	 bMESEjFVTnqHbZ6NU5hl7kwnAYR8wX7VbSuzUgQvOOJ42jYPzGiVp6FRDKCsDhjCxi
	 7qA28Aug/zwr+0XdNN8nTXuy4pXNJgGDB1/md7OkNU/BE14iE0jud6lHdj2GrERKqF
	 pjABlUezz8aVQ==
Date: Mon, 22 Sep 2025 16:18:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next] page_pool: add debug for release to cache from
 wrong CPU
Message-ID: <20250922161827.4c4aebd1@kernel.org>
In-Reply-To: <muuya2c2qrnmr3wzxslgkpeufet3rlnitw5dijcaq2gpy4tnwa@5p2xnefrp5rk>
References: <20250918084823.372000-1-dtatulea@nvidia.com>
	<20250919165746.5004bb8c@kernel.org>
	<muuya2c2qrnmr3wzxslgkpeufet3rlnitw5dijcaq2gpy4tnwa@5p2xnefrp5rk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 09:25:31 +0000 Dragos Tatulea wrote:
> > The patch seems half-baked. If the NAPI local recycling is incorrect
> > the pp will leak a reference and live forever. Which hopefully people
> > would notice. Are you adding this check just to double confirm that
> > any leaks you're chasing are in the driver, and not in the core?  
>
> The point is not to chase leaks but races from doing a recycle to cache
> from the wrong CPU. This is how XDP issue was caught where
> xdp_set_return_frame_no_direct() was not set appropriately for cpumap [1].
> 
> My first approach was to __page_pool_put_page() but then I figured that
> the warning should live closer to where the actual assignment happens.
> 
> [1] https://lore.kernel.org/all/e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org/

Ah, that thing. I wonder whether the complexity in the driver-facing 
xdp_return API is really worth the gain here. IIUC we want to extract
the cases where we're doing local recycling and let those cases use
the lockless cache. But all those cases should be caught by automatic
local recycling detection, so caller can just pass false..

