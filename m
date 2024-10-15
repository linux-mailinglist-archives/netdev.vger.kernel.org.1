Return-Path: <netdev+bounces-135767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD8F99F256
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F816281219
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2621E9096;
	Tue, 15 Oct 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BncWv6f8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E091CB9EB
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008595; cv=none; b=SLhcya84K/sQ+xQ/UEEZYi/eawyq3/G9D/xbg1UhX5R5qgAJPVTsxbTCC+N6B5JAr9oB9lQZIaDB7KSx2gc5GGnf6zqCi5YW6ad7esdQZWrwYrF6lkSqfg2Ize6McpEJjWUOF9QdcKUkzXfaHNJfaeZJ9WkxCqs0VqPvY5vrpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008595; c=relaxed/simple;
	bh=uiNbKZymrQtXd06YpQ4Y9UYqOaQxvSWTKDoL7yi1U34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fg2tNKf2n0lbQsj8OhJWRLocRSDLOuq+lRYuRSzMILaAdfUnB4h5Gyzc8HR2XJ8zOBBcFe/j9dv1Nu98C3TIJ7lN7FfQn+KqOy6oFvj2JZbWruoxJ/u3K5732h+FBPgz/KWvgtYDxgcu3MXC1IWZ6zkM9DeZlsdJm/mrBktW7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BncWv6f8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D34EC4CEC6;
	Tue, 15 Oct 2024 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008594;
	bh=uiNbKZymrQtXd06YpQ4Y9UYqOaQxvSWTKDoL7yi1U34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BncWv6f8nxxYbDxv+zumwT4cANZa+684oDXRaD2IKtNGVbffbdzwl+u95lBOk+7Lh
	 +RWHXZaqRcjbnYDkqsMbWeiOC6JEqF3SfUADHxqheYhVX8Y9awqxN9mh3F5ZK6peuY
	 spR5K/DOCyvsjeKfkQ5ieu8CbFtXiweJIyhNrkjTXzam2hwQSb4DwkTL+YpOkPhVW4
	 u5Fqi5E22kTdGnz0uLxaDsS7wrTwL+s4vOpQiVxB4H8EwzeyjQfcKP4SIUAc/KXs7b
	 egkcbMZhXxiljEMC6KuFUh44o6CTQbAx8ZTMtLeIqzTGvkvbUVAWFnshhVmwCEfauz
	 4T1PmY3V+ddvw==
Date: Tue, 15 Oct 2024 09:09:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH net-next v2] net: airoha: Implement BQL support
Message-ID: <20241015090952.6bcb5856@kernel.org>
In-Reply-To: <Zw6QUxpdnJtorc_e@lore-desk>
References: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
	<20241015073255.74070172@kernel.org>
	<Zw5-jJUIWhG6-Ja4@lore-desk>
	<20241015075255.7a50074f@kernel.org>
	<Zw6QUxpdnJtorc_e@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 17:54:59 +0200 Lorenzo Bianconi wrote:
> > Oh, thought its called on stop. In that case we're probably good
> > from BQL perspective.
> > 
> > But does it mean potentially very stale packets can sit on the Tx
> > ring when the device is stopped, until it's started again?  
> 
> Do you mean the packets that the stack is transmitting when the .ndo_stop()
> is run?

Whatever is in the queue at the time ndo_stop() gets called.
Could be the full descriptor ring I presume?

> In airoha_dev_stop() we call netif_tx_disable() to disable the transmission
> on new packets and inflight packets will be consumed by the completion napi,
> is it not enough?

They will only get consumed if the DMA gets to them right?
Stop seems to stop the DMA.

> I guess we can even add netdev_tx_reset_subqueue() for all netdev
> queues in airoha_dev_stop(), I do not have a strong opinion about it. What
> do you prefer?

So to be clear I think this patch is correct as of the current driver
code. I'm just wondering if we should call airoha_qdma_cleanup_tx_queue()
on stop as well, and then that should come with the reset.
I think having a packet stuck in a queue may lead to all sort of oddness
so my recommendation would be to flush the queues.

