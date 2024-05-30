Return-Path: <netdev+bounces-99450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E38D4F20
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDEEBB2189A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5834E182D07;
	Thu, 30 May 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf/MlNxV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D217624E
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083120; cv=none; b=WFEsU0Gef6r4Y0qbw4gPkJqiADZpCB+Sg5thxMjRXrawmVvHdrFepjlrhB2ZfmRhDkoiaOX+p+afyXRcIaYc+XQMsgIf/qWDNz0jPK1PLiPcWOjNeTubjgrKDzleZ4y214LYaQPHGAX5de+4DTSomJXoAfHuyHVh64yuu+Y+w8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083120; c=relaxed/simple;
	bh=ySKPgds6JhciB8Xb2QG83wZnoGR9dhxQMdGZKY3KwDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GC6gR8UY22LoEX65uVUjoqd0UcCt/slqw+RBsOiPn7t2y0zNLueUkybPEVXnl2uuQupUf+c1b8aiNgvR4/FeyRkxoDABbfhn97u08padTbdNooxFt5FpmbJ5XBM1u48pdOegiGHykwKukDaeC9oWDV8W3mZl5TpAmYJEp9Gsgow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf/MlNxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D39FC2BBFC;
	Thu, 30 May 2024 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717083119;
	bh=ySKPgds6JhciB8Xb2QG83wZnoGR9dhxQMdGZKY3KwDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zf/MlNxVZb9ZTH7DClT3aEmqccFsuzJYOU8iwn8wJLbr61i2cTSj79btP9bESh/FY
	 YTKC35JKo1WNsvP35KTn/hDE454P0wwjt8Yp66mlnFkV6YqK4/rXxaFXgJNVzi8lYD
	 l3q0zOwpj6iXCq1oXhLun0BJ8oj+XHzgIGgd6AcMo2KFf0sw2wYMFgfnllPLMOCxfD
	 tN/bG6+6lca9BxZQS8hC/+7WzfhDgYf9N5nxVqqHNNjL8t2g036jSQxNbmHx8o3m73
	 IKximAL8srNuLgrjb139f6QxvKG/tfput9ZgXRWU6Lo4G/+BRqSnyBnqP9b2a3CYPV
	 aajXrfBm3qKUg==
Date: Thu, 30 May 2024 08:31:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 11/15] net/mlx5e: SHAMPO, Add no-split ethtool
 counters for header/data split
Message-ID: <20240530083158.02ecfa5c@kernel.org>
In-Reply-To: <ZlfzR_UV9CcCjR99@x130.lan>
References: <20240528142807.903965-1-tariqt@nvidia.com>
	<20240528142807.903965-12-tariqt@nvidia.com>
	<20240529182208.401b1ecf@kernel.org>
	<ZlfzR_UV9CcCjR99@x130.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 20:32:23 -0700 Saeed Mahameed wrote:
> On 29 May 18:22, Jakub Kicinski wrote:
> >On Tue, 28 May 2024 17:28:03 +0300 Tariq Toukan wrote:  
> >> +   * - `rx[i]_hds_nosplit_packets`
> >> +     - Number of packets that were not split in modes that do header/data split
> >> +       [#accel]_.
> >> +     - Informative
> >> +
> >> +   * - `rx[i]_hds_nosplit_bytes`
> >> +     - Number of bytes that were not split in modes that do header/data split
> >> +       [#accel]_.
> >> +     - Informative  
> >
> >This is too vague. The ethtool HDS feature is for TCP only.
> >What does this count? Non-TCP packets basically?
> 
> But this is not the ethtool HDS, this is the mlx5 HW GRO hds.

Okay, but you need to put more detail into the description.
"not split in modes which do split" is going to immediately 
make the reader ask themselves "but why?".

> On the sane note, are we planning to have different control knobs/stats for
> tcp/udp/ip HDS? ConnectX supports both TCP and UDP on the same queue, 
> the driver has no control on which protocol gets HDS and which doesn't.

No plans at this stage. The ethtool HDS is specifically there
to tell user space whether it should bother trying to use TCP mmap.

> >Given this is a HW-GRO series, are HDS packets == HW-GRO eligible
> >packets?
> 
> No, UDP will also get header data split or other TCP packets that don't
> belong to any aggregation context in the HW.

I see.

