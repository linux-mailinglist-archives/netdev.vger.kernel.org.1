Return-Path: <netdev+bounces-68295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E98466F1
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 05:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF87B210A7
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD0DE54E;
	Fri,  2 Feb 2024 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbNdoAo1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23694F4E7;
	Fri,  2 Feb 2024 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847671; cv=none; b=M2ATB4HJdsYkVydWR8BHt5Xc58Ja95ko7mLxibhysI8bgZR1BV+ga6snChnm50PBceKzSYHcSWytKXpy7olzDDQNJE1sVMagAn75mf38IfPzgwSfbK6Dhp+vGQdfvj6DXzu5SVW4pj5vf8IeIExUpXVzBRCJS0omDA9OvX1oS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847671; c=relaxed/simple;
	bh=0RrbYZlil+2Rq7txKyM/dpb1QYDaxYKi6nYOwsf2hc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnAzsIQuAkBqX7ugWGitx3GpKOI6FdUyiO5GQ9FFHJr1wOPJgglbm34XRw6zfckDpEPNMY8GauSpU4H8nfRK0GkcgHdNedtmq795NhhKztB9eNtTQkViZuha0i97ORdUACOrp5Bmg6U/TPWQb3YuFwYsQht+/PnCJN/r/beGjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbNdoAo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1C3C433C7;
	Fri,  2 Feb 2024 04:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706847670;
	bh=0RrbYZlil+2Rq7txKyM/dpb1QYDaxYKi6nYOwsf2hc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QbNdoAo1Q3F0oGU/Fs/Wr3L5DnLagcedj5uEk1+E6ns5J6f65eGd+9DbO8rWbLmub
	 WW0xVzvwnEYcW1/re71n+muAyJZL9/jzFiYNzf7fT8Q2qVjF2n3CGMK225lmRP70Sa
	 aCfRIBQvyXPid/ngFBzZvvH0Ati5vvkWPVQTRDhPpMCM/8HdFC6LQ3gg4v1a580ayR
	 V1Oq3MSTNR5W7CFMTpoXUE5EENjc9s1OridNPIPaf+mMGfNiGQaTF9HFEdzlC1phsm
	 J9qxmumfxiqjrEOAPYsgIU2BZZOk14shtIOdgYHv5B0WckgjNJB+WHQ8toUFxOOMXX
	 SGc3cdiga11GQ==
Date: Thu, 1 Feb 2024 20:21:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
 <xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240201202106.25d6dc93@kernel.org>
In-Reply-To: <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
	<20240130095645-mutt-send-email-mst@kernel.org>
	<CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240130104107-mutt-send-email-mst@kernel.org>
	<CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240130105246-mutt-send-email-mst@kernel.org>
	<CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:54:33 +0800 Jason Xing wrote:
> > [danielj@sw-mtx-051 upstream]$ ethtool -S ens2f1np1 | grep 'stop\|wake'
> >      tx_queue_stopped: 0
> >      tx_queue_wake: 0
> >      tx0_stopped: 0
> >      tx0_wake: 0
> >      ....  
> 
> Yes, that's it! What I know is that only mlx drivers have those two
> counters, but they are very useful when debugging some issues or
> tracking some historical changes if we want to.

Can you say more? I'm curious what's your use case.

