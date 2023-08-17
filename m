Return-Path: <netdev+bounces-28517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC4877FABE
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3E7282068
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCFF154A6;
	Thu, 17 Aug 2023 15:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AC1548B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F0EC433C7;
	Thu, 17 Aug 2023 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692286227;
	bh=RzylO7MvvVlMSQpaAlr4pOqtI76t6JtBAKrRlm7mOm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DoARQyMEf9wimmENTwBMe0b+tGXmPNuD/rLpEKj/LmSRBg76hsUqiXtcyhlY5MMaI
	 1VkO+92+CekUEAPG2pzYW8pw1D+DjE+RjeCDYSrvkX4L3VG3Ou9bUU2EB0ykltqiEX
	 C2gqKeEPtz4pDcX6l/x25QJZjGhcWCKGgbdCLV5BZSFGNrMjWiQEcD7GFvIcvasT3u
	 mylBTQVmNbXe4C8W1qUCdATr9aNpEu4QrfFokigKbiAcBgkggw7yohCXEvt5A7YWad
	 F9uYI+DzdNDL6JP2VVEv/l3riB+a/tWHc3hWcXZAbJIqiU9XkXdXXSdIv8dfTMlDDV
	 rOCahxRqfgyXw==
Date: Thu, 17 Aug 2023 08:30:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Wander Lairson Costa <wander@redhat.com>, Yan Zhai
 <yan@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230817083025.2e8047fa@kernel.org>
In-Reply-To: <20230817131612.M_wwTr7m@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
	<20230814112421.5a2fa4f6@kernel.org>
	<20230817131612.M_wwTr7m@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 15:16:12 +0200 Sebastian Andrzej Siewior wrote:
> I've been looking at veth. In the xdp case it has its own NAPI instance.
> In the non-xdp it uses backlog. This should be called from
> ndo_start_xmit and user's write() so BH is off and interrupts are
> enabled at this point and it should be kind of rate-limited. Couldn't we
> bypass backlog in this case and deliver the packet directly to the
> stack?

The backlog in veth eats measurable percentage points of RPS of real
workloads, and I think number of people looked at getting rid of it.
So worthy goal for sure, but may not be a trivial fix.

To my knowledge the two main problems are:
 - we don't want to charge the sending application the processing for
   both "sides" of the connection and all the switching costs.
 - we may get an AA deadlock if the packet ends up looping in any way.

Or at least that's what I remember the problem being at 8am in the
morning :) Adding Daniel and Martin to CC, Paolo would also know this
better than me but I think he's AFK for the rest of the week.

