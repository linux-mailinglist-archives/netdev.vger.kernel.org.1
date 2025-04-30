Return-Path: <netdev+bounces-187090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC14AA4E04
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5ED4E4368
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B642512D9;
	Wed, 30 Apr 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvgqftpJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1427101E6;
	Wed, 30 Apr 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021727; cv=none; b=gYTyWExmPwACgjGNZvKc1chXBJZM+SUjUDd8MNGyh5T6b+hOvbWpIYqgfeKdmMAolxF+mKjLxo9ML5is2PErUfMcfceY9j414+cbkx3913CAgLtVDBL107Gjls4uMDYYJe0I3TxbVIaxsdY/lyVzPi/EqFocaAxpeBUqa3eA5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021727; c=relaxed/simple;
	bh=NAsBTwFVPS7juHrtzSxt4siydlB9BQ3vucA7U6SK+vA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJ5Jqq3j5bPg2KDblZBq9ogSH0A7pqoqg7JIQj8n/C//uHHZCeAyvRRzXA2ySG5MIHQbZRFaY7/y0fXW1iGR3iCY8QgHOSt8VFp3wqfnT3JirZeyjPmfplaecMpt8kmTiFXNER7L2LjfXd1uzRasnimOIlVcnYnZmrxzz/fdYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvgqftpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE96C4CEE9;
	Wed, 30 Apr 2025 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746021727;
	bh=NAsBTwFVPS7juHrtzSxt4siydlB9BQ3vucA7U6SK+vA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvgqftpJMvJpu9PJtUkOaSz8xWn3mKJstUFpQ3lxq/kDq1xPACnGu4abv2xmw1Z9W
	 +8xXHHWbzag+YinvB5rN84JlkZ0fNDE6YHyapOC8PO/bwOFvtEK+RZZTA31yUQLhFI
	 pbXhaZRqE2U2HAzyODxwfEX5LjxIwe9gp6rxfqWwDXFMbJa6POzYZG2K0HmkG6AnvE
	 BqMdV9BLN52W2PFWamzRT2N2rn+pL5ZPbcKc3VZICvrTHDQPBxYn8Ui0e98IbzmJl+
	 PmTOXzpmYuKqA2ocqFtVusfUyfhQpyy9enUDHurLPpxULTkOiLFzuiboze+85o1qhc
	 hB/M6J25SjLEg==
Date: Wed, 30 Apr 2025 07:02:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, minhquangbui99@gmail.com, romieu@fr.zoreil.com,
 kuniyu@amazon.com, virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio-net: don't re-enable refill work too early
 when NAPI is disabled
Message-ID: <20250430070205.09a4ea5d@kernel.org>
In-Reply-To: <20250430012856-mutt-send-email-mst@kernel.org>
References: <20250429143104.2576553-1-kuba@kernel.org>
	<CACGkMEs0LuLDdEphRcdmKthdJeNAJzHBqKTe8Euhm2adOS=k2w@mail.gmail.com>
	<20250430012856-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 01:29:06 -0400 Michael S. Tsirkin wrote:
> > > @@ -3728,7 +3731,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> > >  succ:
> > >         vi->curr_queue_pairs = queue_pairs;
> > >         /* virtnet_open() will refill when device is going to up. */
> > > -       if (dev->flags & IFF_UP)
> > > +       if (dev->flags & IFF_UP && vi->refill_enabled)
> > >                 schedule_delayed_work(&vi->refill, 0);  
> > 
> > This has the assumption that the toggle of the refill_enabled is under
> > RTNL.

Yes, this line of code must be under rtnl_lock to be correct, since 
it is also checking flags & IFF_UP. I was thinking of moving it to
virtnet_restore(), AFAIU that's the only place that needs it.
But that's more of a -next change.

> > Though it's true now but it looks to me it's better to protect
> > it against refill_lock.
> 
> Good point.

Sure. I'll wrap the check and the call to schedule_.. with the lock.

