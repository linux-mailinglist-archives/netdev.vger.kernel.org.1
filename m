Return-Path: <netdev+bounces-171426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B85FA4CF9D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD241896778
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35D42111;
	Tue,  4 Mar 2025 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5+2RKW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8CC2D1;
	Tue,  4 Mar 2025 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046637; cv=none; b=rEbdaBNMQasaxJudbWmFeaorLrhuaAN8tUPegRSaB3c3JfhlErM6XBvh91BbhZg/XiDcjfYrJTTX/Z1ab6qThmyaxlgnCB+q/HUtJuoSoOWTKTZDCeayzV6WVj9zywqlGzaJwEibCe8umKL/vkT2HU4o1rInoFgC2kwlFRm0EtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046637; c=relaxed/simple;
	bh=PodGSYAN2PRqPznGy1o8bGNv8tT3sasFzN7rH8DbDzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8+kggRpZLg53aLg2vGhWOlMwRZhrphgp/3G9m1cRcS9SAOVaFAG7ru1IIxUKzKy/gig9OzPDwNZQAq7dklv+voS6RNJ+54fNHDmMhk658XRJ2/LWdWxlET8ZXuS4i73ccQO81pDEWj0mgUMSoh1KBN2iy1wpm6fO09cELKfn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5+2RKW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD89C4CEE4;
	Tue,  4 Mar 2025 00:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741046636;
	bh=PodGSYAN2PRqPznGy1o8bGNv8tT3sasFzN7rH8DbDzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u5+2RKW275a+1qk3Btczy9vu4F6fSXqzr0EAFRS1d7exuLigQNzYleSDbBi/IXbsT
	 L1HsXBng2OdDAYfXnknoWHQgp5zahNu96V1MlqGXbhGnKQAtMMqqfThugjTtnF8Bhn
	 zAdJP9NATi+KyhcNlReKbCeqL78HRE6lb4Ak/mOlgMzRPQl/yOvUsX2BNcjCEtJMxn
	 3EW07GrYaEXAmlxAiMuGQ6xExLHdAsqZSc47J5qDfNJRtgYwxkmSxm0MAdXICruF3Z
	 rZkl3h3Ip+j0sfViQ714aKMyI/QQnV1ddrfxvPawVaJiKcbAS+3TL2pviJ1oWuIBx5
	 Ooy619yCHvFNA==
Date: Mon, 3 Mar 2025 16:03:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
 gerhard@engleder-embedded.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "open
 list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <20250303160355.5f8d82d8@kernel.org>
In-Reply-To: <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
References: <20250227185017.206785-1-jdamato@fastly.com>
	<20250227185017.206785-4-jdamato@fastly.com>
	<20250228182759.74de5bec@kernel.org>
	<Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
	<Z8XgGrToAD7Bak-I@LQ3V64L9R2>
	<Z8X15hxz8t-vXpPU@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:
> > > @@ -2880,6 +2880,13 @@ static void refill_work(struct work_struct *work)
> > >         bool still_empty;
> > >         int i;
> > > 
> > > +       spin_lock(&vi->refill_lock);
> > > +       if (!vi->refill_enabled) {
> > > +               spin_unlock(&vi->refill_lock);
> > > +               return;
> > > +       }
> > > +       spin_unlock(&vi->refill_lock);
> > > +
> > >         for (i = 0; i < vi->curr_queue_pairs; i++) {
> > >                 struct receive_queue *rq = &vi->rq[i];
> > >  
> > 
> > Err, I suppose this also doesn't work because:
> > 
> > CPU0                       CPU1
> > rtnl_lock                  (before CPU0 calls disable_delayed_refill) 
> >   virtnet_close            refill_work
> >                              rtnl_lock()
> >   cancel_sync <= deadlock
> > 
> > Need to give this a bit more thought.  
> 
> How about we don't use the API at all from refill_work?
> 
> Patch 4 adds consistent NAPI config state and refill_work isn't a
> queue resize maybe we don't need to call the netif_queue_set_napi at
> all since the NAPI IDs are persisted in the NAPI config state and
> refill_work shouldn't change that?
> 
> In which case, we could go back to what refill_work was doing
> before and avoid the problem entirely.
> 
> What do you think ?

Should work, I think. Tho, I suspect someone will want to add queue API
support to virtio sooner or later, and they will run into the same
problem with the netdev instance lock, as all of ndo_close() will then
be covered with netdev->lock.

More thorough and idiomatic way to solve the problem would be to cancel
the work non-sync in ndo_close, add cancel with _sync after netdev is
unregistered (in virtnet_remove()) when the lock is no longer held, then
wrap the entire work with a relevant lock and check if netif_running()
to return early in case of a race.

Middle ground would be to do what you suggested above and just leave 
a well worded comment somewhere that will show up in diffs adding queue
API support?

