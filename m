Return-Path: <netdev+bounces-165788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0927CA3365F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB57A167DF1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B25142E7C;
	Thu, 13 Feb 2025 03:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqbAIrOu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472E4A29;
	Thu, 13 Feb 2025 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418502; cv=none; b=Ejd89nGGlHNr/+fp24PxoFizbH7+1qmJYHWlGONAhjNE6qfvAgNSmKNy0WnJHSz98cBkro9slAlAZKTviakj4helOxt5HjquZ7FtorwKeeT4dyxjHBumYQj48KBqfr/U3X7NEYYvjxcvKwYOFzgU//tr5jziFOxru8/hIJ4coLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418502; c=relaxed/simple;
	bh=GA0qV9ScdfUpucwXntMDv7QChc9NisjfStRZOqMTEgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co/RjyVlXpZBZZQBbVLD3MKGfZ5ur5qpVx/ynNRYbzcZ7H+IWjlCAg9CCzBWz5f5FfrH/aRmIwfoHPhssJ/PYIucX7WpN4qRI4Ks2t0qSRta1KiII/5x03cl1Udwm4icVi3sjzIwbAU5PVR6XsvvVFFZGiaVOokENJ5M1IA1tXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqbAIrOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF20C4CED1;
	Thu, 13 Feb 2025 03:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739418501;
	bh=GA0qV9ScdfUpucwXntMDv7QChc9NisjfStRZOqMTEgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VqbAIrOuqfNW0ruiapd/qgHvDhQTf9O0n7ShA9oqmjLzQQ+oIVhy7OnOWiNdHOwwv
	 VRayIblIq9s98okMoSEsXZvn/MheaS+GaEj4nL8VNafU0pPyGTM9e1sNwbmGdQ1mPU
	 udMoZMe4dgDSsz04VR4T/Fo7So4unmyoPaZhQXK2hMX1mVN9ZCTC2sGqTULLGb/Gqi
	 j7G8XB77+nW7FaDANP+czAPhL3NREawi3U6LGdvVIwO00Zf4hPz8bCkIOa2a4WVqls
	 AwVdkm4XfOqOehFtTtZouftCdSGCDNSY0q35S/3A/i+vO+HwX6xImfMAZw1f3wP22/
	 J4YRWGfNlQpzA==
Date: Wed, 12 Feb 2025 19:48:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long
 <longman@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250212194820.059dac6f@kernel.org>
In-Reply-To: <20250212174329.53793-2-frederic@kernel.org>
References: <20250212174329.53793-1-frederic@kernel.org>
	<20250212174329.53793-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 18:43:28 +0100 Frederic Weisbecker wrote:
> napi_schedule() is expected to be called either:
> 
> * From an interrupt, where raised softirqs are handled on IRQ exit
> 
> * From a softirq disabled section, where raised softirqs are handled on
>   the next call to local_bh_enable().
> 
> * From a softirq handler, where raised softirqs are handled on the next
>   round in do_softirq(), or further deferred to a dedicated kthread.
> 
> Other bare tasks context may end up ignoring the raised NET_RX vector
> until the next random softirq handling opportunity, which may not
> happen before a while if the CPU goes idle afterwards with the tick
> stopped.
> 
> Report inappropriate calling contexts when neither of the three above
> conditions are met.

Looks like netcons is hitting this warning in netdevsim:

[   16.063196][  T219]  nsim_start_xmit+0x4e0/0x6f0 [netdevsim]
[   16.063219][  T219]  ? netif_skb_features+0x23e/0xa80
[   16.063237][  T219]  netpoll_start_xmit+0x3c3/0x670
[   16.063258][  T219]  __netpoll_send_skb+0x3e9/0x800
[   16.063287][  T219]  netpoll_send_skb+0x2a/0xa0
[   16.063298][  T219]  send_ext_msg_udp+0x286/0x350 [netconsole]
[   16.063325][  T219]  write_ext_msg+0x1c6/0x230 [netconsole]
[   16.063346][  T219]  console_emit_next_record+0x20d/0x430

https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/990261/7-netcons-basic-sh/stderr

We gotta fix that first.

Please post the fixes for net, and then the warning in net-next.
So that we have some time to fix the uncovered warnings before
users are broadly exposed to them.
-- 
pw-bot: cr

