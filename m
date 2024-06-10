Return-Path: <netdev+bounces-102257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3189021A2
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 796F4B20A25
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2157F7E3;
	Mon, 10 Jun 2024 12:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08B7E767
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022585; cv=none; b=ByaHlZSfTyFgffZoBjzJCFerZpzUg9Ccpru8/aMm4VCJlgDtLwouAM2m7msh2SzDoKbzNH0IGocPJtnU7pXQZnkx7KN4OEYWclj8hQiz+Sz6xdpClfpT/S0OIGzP/YGD9T3Y1VXexRAEmi37f1QPAtl/lii7r423iMDDV+glAfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022585; c=relaxed/simple;
	bh=Z06PtoWJwSghefvo3QLCMIRXna4VRBWzpTxSIQu85WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSBTujz9Ot4yBkTdg0w8mfDJawaM3K1nq4ANOylM1+fWjTjzIeJDdeNDv5d5N80Mst4uu78whJUcZpzXv5lxSv/sXn+KclFGieCzJ4GtRRS2RxnO2BkWfqKel4RAm0PBWfvTMj4PK+x4sGbNp0HtWr+qNrsTOaYQkuaaeJe6dB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75B3D67373; Mon, 10 Jun 2024 14:29:39 +0200 (CEST)
Date: Mon, 10 Jun 2024 14:29:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>,
	Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240610122939.GA21899@lst.de>
References: <20240529160053.111531-1-aaptel@nvidia.com> <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de> <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 03, 2024 at 10:09:26AM +0300, Sagi Grimberg wrote:
>> IETF has standardized a generic data placement protocol, which is
>> part of iWarp.  Even if folks don't like RDMA it exists to solve
>> exactly these kinds of problems of data placement.
>
> iWARP changes the wire protocol.

Compared to plain NVMe over TCP that's a bit of an understatement :)

> Is your comment to just go make people
> use iWARP instead of TCP? or extending NVMe/TCP to natively support DDP?

I don't know to be honest.  In many ways just using RDMA instead of
NVMe/TCP would solve all the problems this is trying to solve, but
there are enough big customers that have religious concerns about
the use of RDMA.

So if people want to use something that looks non-RDMA but have the
same benefits we have to reinvent it quite similarly under a different
name.  Looking at DDP and what we can learn from it without bringing
the Verbs API along might be one way to do that.

Another would be to figure out what amount of similarity and what
amount of state we need in an on the wire protocol to have an
efficient header splitting in the NIC, either hard coded or even
better downloadable using something like eBPF.

> That would be great, but what does a "vendor independent without hooks" 
> look like from
> your perspective? I'd love having this translate to standard (and some new) 
> socket operations,
> but I could not find a way that this can be done given the current 
> architecture.

Any amount of calls into NIC/offload drivers from NVMe is a nogo.


