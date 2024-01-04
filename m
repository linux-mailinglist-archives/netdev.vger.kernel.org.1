Return-Path: <netdev+bounces-61426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEAD823A58
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A761F2613D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4950A15D4;
	Thu,  4 Jan 2024 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrpF2S5I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098B4C60
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA3FC433C9;
	Thu,  4 Jan 2024 01:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704332972;
	bh=1v9px0aeHFVj8v+28K+zorNVMhrw6ynuHLj/tsZsQgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nrpF2S5IxJNmQjCON4OSAv/I5nAoTEFC5qNbny1PFvVeV7KgcgsyOydMR1gJe8It+
	 FV6WB8lyHhduxk9E24+cmGdUulf6332rUKJOCX0mB5ga6/EahxQfZ0/DwIpHoVOWaB
	 h7xz9KqGK1cWMJImEOsm0zdq2xn2FRBj1wmFfMINBf5TQdn4Yxv0czPkyzJ3OJjvmQ
	 TLd7MQOJ9Frm6enisydZkfFM4rPHAqoWQppUdbUHZDcsxGLWB3qd8doAQUr69HFLIq
	 3Km0dGOEeDkGbN8XCVZglZGYG2Ipj0s0YMq5YVjODn6RMnyuCG+FJF9PRqI3a8vgVM
	 n8hxTzU+yBwVw==
Date: Wed, 3 Jan 2024 17:49:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: vladbu@nvidia.com, Xin Long <lucien.xin@gmail.com>
Cc: Tao Liu <taoliu828@163.com>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, paulb@nvidia.com, netdev@vger.kernel.org,
 simon.horman@corigine.com, xiyou.wangcong@gmail.com, pablo@netfilter.org
Subject: Re: [PATCH net] net/sched: act_ct: fix skb leak and crash on ooo
 frags
Message-ID: <20240103174931.15ea4dbd@kernel.org>
In-Reply-To: <20231228081457.936732-1-taoliu828@163.com>
References: <20231228081457.936732-1-taoliu828@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 16:14:57 +0800 Tao Liu wrote:
> act_ct adds skb->users before defragmentation. If frags arrive in order,
> the last frag's reference is reset in:
> 
>   inet_frag_reasm_prepare
>     skb_morph
> 
> which is not straightforward.
> 
> However when frags arrive out of order, nobody unref the last frag, and
> all frags are leaked. The situation is even worse, as initiating packet
> capture can lead to a crash[0] when skb has been cloned and shared at the
> same time.
> 
> Fix the issue by removing skb_get() before defragmentation. act_ct
> returns TC_ACT_CONSUMED when defrag failed or in progress.

Vlad, Xin Long, does this look good to you?
-- 
pw-bot: needs-ack

