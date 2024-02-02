Return-Path: <netdev+bounces-68570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7B984741B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CAAEB2975C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AD514900A;
	Fri,  2 Feb 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpLXpxDw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC84149007;
	Fri,  2 Feb 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889688; cv=none; b=cjpFB4mCUqIU3vptIJpdw5ChFxmUB0TrEGirGwLoG7P+40ekMgdix9QRT8BsluuX/FlyRRiu64PHAmaPgiMNhvqBGc5q10vnFAmspluhJCz2PicaSNxODXopBtDwVIQZz0h8ZPo6disqBc2vSznKif7TqKivVRda/ixAz28InDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889688; c=relaxed/simple;
	bh=eoBN1Wb1GGsJI8q71EDc3lzyPtxim3bTNPH5cqQ7Kmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYXqqrBVOMJXbmtXyaNUY+7Whm5ztU841f9OZp4xl3vP/CLttzcp9hKLv1MnvBnbGSPFey9LyxdxKCnxWbhNW72yK1w5swOlQRNrhZ8QVdHSbh5wYsMlifRntKZd9HnaFaSJ67fjQzDgoOryoKHggsryLZgz58mTZjlGRBTkcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpLXpxDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F731C433F1;
	Fri,  2 Feb 2024 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889687;
	bh=eoBN1Wb1GGsJI8q71EDc3lzyPtxim3bTNPH5cqQ7Kmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bpLXpxDwW5hYNz7LABf+rzr7A4J1YM78JAx7+QG5qQZauGWSoYqz6/mYyznNatHwV
	 q2WdIR5oCqIT+fpytq5X4WIIJ83L7oJVdVjALoVAN9P0n/onuPRK5an+t9+vR5Tfao
	 1RPGRX16HCChd+cDKh1KZqwBtQRQXGExG97nLQLsiS43wVfLT4u2fI+v3I1nciqGbE
	 Y+rD1gEUA7AnuGpu2onoCnv9N3DmpeyXo8VdE3EbnmuZKcWHU04MB1iV2kzeNxM8RH
	 YeYgokNLO9DuzgMqXj5D+KIp0BnovXofiVo/h84yoHEPh5FxHV3SbymkYhNX4E2AXw
	 It0bpCwV/1Caw==
Date: Fri, 2 Feb 2024 08:01:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>, Daniel Jurgens
 <danielj@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "abeni@redhat.com" <abeni@redhat.com>, Parav Pandit
 <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240202080126.72598eef@kernel.org>
In-Reply-To: <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
	<20240130095645-mutt-send-email-mst@kernel.org>
	<CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240130104107-mutt-send-email-mst@kernel.org>
	<CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240130105246-mutt-send-email-mst@kernel.org>
	<CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
	<20240201202106.25d6dc93@kernel.org>
	<CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > Can you say more? I'm curious what's your use case.  
> 
> I'm not working at Nvidia, so my point of view may differ from theirs.
> From what I can tell is that those two counters help me narrow down
> the range if I have to diagnose/debug some issues.

right, i'm asking to collect useful debugging tricks, nothing against
the patch itself :)

> 1) I sometimes notice that if some irq is held too long (say, one
> simple case: output of printk printed to the console), those two
> counters can reflect the issue.
> 2) Similarly in virtio net, recently I traced such counters the
> current kernel does not have and it turned out that one of the output
> queues in the backend behaves badly.
> ...
> 
> Stop/wake queue counters may not show directly the root cause of the
> issue, but help us 'guess' to some extent.

I'm surprised you say you can detect stall-related issues with this.
I guess virtio doesn't have BQL support, which makes it special.
Normal HW drivers with BQL almost never stop the queue by themselves.
I mean - if they do, and BQL is active, then the system is probably
misconfigured (queue is too short). This is what we use at Meta to
detect stalls in drivers with BQL:

https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.org/

Daniel, I think this may be a good enough excuse to add per-queue stats
to the netdev genl family, if you're up for that. LMK if you want more
info, otherwise I guess ethtool -S is fine for now.

