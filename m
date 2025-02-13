Return-Path: <netdev+bounces-166070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9A9A3454F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D967A1B51
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98926B0A5;
	Thu, 13 Feb 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jlb8sWMg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91B26B096;
	Thu, 13 Feb 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459668; cv=none; b=HoJdx1iW2LjHt4aWT7DanosN4hnwb1ocoiNoW02rs2sm0XvFZXYH1WYuyyFUstRqeY+Z0u4qPZ3eeNJh4ZVNInOdUsB2UktdxuFhaKvd4QbsxxSmbCjf4lKG0SJgmDjRh8h/ZG6coLyvFH9t6wTGpw8ePh2z+gD1qBN1sGbUzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459668; c=relaxed/simple;
	bh=gMdiIVUMcHjZUDzR7lF3FJr6ZBcIC1aeITxPEs6sI7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCtcTbqsosVD96UGYF76STqvd4d7aUlOqNoD5bveIbnS1yUqsqADlwlKMDwc2TvF1cZY7KjXYhCtwgp9UXTAja5sgbbsMJx2Cw6SZsxAdYjUqQFJNVAxhiVDvanE851LrNQqkSDs6uZbS0kAIZ76ELFprZk3MxEMJtbU508SYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jlb8sWMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304F9C4CEE4;
	Thu, 13 Feb 2025 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739459667;
	bh=gMdiIVUMcHjZUDzR7lF3FJr6ZBcIC1aeITxPEs6sI7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jlb8sWMgH44PTGqFMBYMw9Y8Tt9z/EOPEO3jWLywlSYxAxaoKlZ/eyuEclbhDLuYM
	 Edtmr/J4lPP0Ikl4nb58U29ZhuXGKW8SMGyPnU/+6dz3BekR1SiJQ0Ea/+ubtAT/46
	 HhEMfJ5Ck0CR+/ncSVfAlk9lIn0RHJ61AJc6ojF7A62aap5WHzL6bY5vAbjs20TLLH
	 MK7WMqx/Ss0TxnVJoygreN6OOoJcgu8zKwfpxBJUmHjsoKW5FeLRzlI984E8AXlQ6c
	 vzazyc3/qAM/pzwxKuVkMQbs0WcFxUeq7iAQFfAwYk84okB2/QzCGOX1cPe8SMKk2I
	 TgAmYr1wFHTLg==
Date: Thu, 13 Feb 2025 07:14:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hayes Wang
 <hayeswang@realtek.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250213071426.01490615@kernel.org>
In-Reply-To: <20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
References: <20250212174329.53793-1-frederic@kernel.org>
	<20250212174329.53793-2-frederic@kernel.org>
	<20250212194820.059dac6f@kernel.org>
	<20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 01:58:17 -0800 Breno Leitao wrote:
> > Looks like netcons is hitting this warning in netdevsim:
> > 
> > [   16.063196][  T219]  nsim_start_xmit+0x4e0/0x6f0 [netdevsim]
> > [   16.063219][  T219]  ? netif_skb_features+0x23e/0xa80
> > [   16.063237][  T219]  netpoll_start_xmit+0x3c3/0x670
> > [   16.063258][  T219]  __netpoll_send_skb+0x3e9/0x800
> > [   16.063287][  T219]  netpoll_send_skb+0x2a/0xa0
> > [   16.063298][  T219]  send_ext_msg_udp+0x286/0x350 [netconsole]
> > [   16.063325][  T219]  write_ext_msg+0x1c6/0x230 [netconsole]
> > [   16.063346][  T219]  console_emit_next_record+0x20d/0x430
> > 
> > https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/990261/7-netcons-basic-sh/stderr
> > 
> > We gotta fix that first.  
> 
> Thanks Jakub,
> 
> I understand that it will be fixed by this patchset, right?

The problem is a bit nasty, on a closer look. We don't know if netcons
is called in IRQ context or not. How about we add an hrtimer to netdevsim,
schedule it to fire 5usec in the future instead of scheduling NAPI
immediately? We can call napi_schedule() from a timer safely.

Unless there's another driver which schedules NAPI from xmit.
Then we'd need to try harder to fix this in netpoll.
veth does use NAPI on xmit but it sets IFF_DISABLE_NETPOLL already.

