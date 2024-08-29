Return-Path: <netdev+bounces-123006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003179636EE
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA8C285749
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5E1A955;
	Thu, 29 Aug 2024 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqunpwd3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A392AD23
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892076; cv=none; b=RL40m1kQxfIBEieqArGcaY31qw3wSt2GIdJF9a9GqOe3I29RPAS2ovKdOHpSbMEXqdrXblZZVwZrkHhz80tc0tM++7F3EItf1BsqYKHeOHwx3L45a801n0Lb53/JXtT2vtDGZApeswFXX3EDWNoqSlBg/vQoiZDmAJ+Ynq/Qkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892076; c=relaxed/simple;
	bh=TuAVAyq+pB4h579EBZLlUsS+wZtyTrfDoy7ZY7P2N8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivgDPqfdUAPXet75b/anH72vRDRd/WoKJ2EIrOqpWAmc9cBfDGlUgFPE1Mq9rq2OysbBMr+24oFkcaoDy9vjm27AQ9daIpHPDrDRCFLiTkJKFU1sTj0wsrLxbydfG+6dUqs3mpP6bLx0hyTbhqipjOJ+/vPJmndmV6mkdAQJPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqunpwd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E172C4CEC0;
	Thu, 29 Aug 2024 00:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724892075;
	bh=TuAVAyq+pB4h579EBZLlUsS+wZtyTrfDoy7ZY7P2N8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kqunpwd3ypcb6Ad3VLu1Wki3Vm0H8D7HOZSdPTDLlydcfKhOlhIyk8kmMvIbW5pxp
	 XmLEo3qMmmfZSm4VXaJCh47YRpA4vgXogXO2tVOGdmrki8hme5lne0r/8UKXG86xMO
	 kcGMwwASGo3pqj/cdKXG7uc8JXVQZGp22mirHbLN88VlnSnvIMBnvdKqyfilfW6qFo
	 iJAJpHE5jFPlgZzzin47TjnguwKQ0eW2jmsRJ3eMlzG+N2bJv+NzUnMm9nw+Wrg0W7
	 mwkARidoaibrz3gY+ADTeBjDbEIL2KA+0L94pax+XRP3aRAMkQVNKpGBqQxvVyIpxJ
	 rHIPUfHU8u0sQ==
Date: Wed, 28 Aug 2024 17:41:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <edward.cree@amd.com>
Cc: <linux-net-drivers@amd.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next 2/6] sfc: implement basic per-queue stats
Message-ID: <20240828174114.412e4126@kernel.org>
In-Reply-To: <54cf35ea0d5c0ec46e0717a6181daaa2419ca91e.1724852597.git.ecree.xilinx@gmail.com>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
	<54cf35ea0d5c0ec46e0717a6181daaa2419ca91e.1724852597.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 14:45:11 +0100 edward.cree@amd.com wrote:
> +	/* If a TX channel has XDP TXQs, the stats for these will be counted
> +	 * under the channel rather than in base stats.  Unclear whether this
> +	 * is correct behaviour, but we can't reliably exclude XDP TXes from
> +	 * these stats anyway because in EFX_XDP_TX_QUEUES_BORROWED we use
> +	 * the same TXQ as the core.
> +	 */
> +	efx_for_each_channel_tx_queue(tx_queue, channel)
> +		stats->packets += tx_queue->tx_packets - tx_queue->old_tx_packets;

We haven't had to deal with shared host/XDP queues in the other
drivers, yet. But talking to Olek about his stats work it sounds
like he's planning to add support for reporting XDP queues. 
At which point it will be relatively intuitive - if XDP queues
are listed - they count XDP packets, if not, and XDP_TX happens
- the queues must be shared and so are the counters.

IOW let's not count dedicated XDP queues here at all, if we can.
XDP traffic on shared queues can get added in.

