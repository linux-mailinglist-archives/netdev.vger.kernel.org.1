Return-Path: <netdev+bounces-94252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C28BEC7C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 21:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044A728A185
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C74816D9B4;
	Tue,  7 May 2024 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmvBoEdZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFF6CDC2
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109711; cv=none; b=X0wVmD+JLzOcI/nP/jsmj+1DEyzsaBuNgLA4La7KMRINz2sN5cm/2T/88nxNNyqIcqRaxqBn+YLtYSe3n8thoiyfCdbA69034hdLjEmQdTpz4GLozp42rZAiIlUs9Qhd0Izk16QwI2W1HSluWRii9NoLCFueaylS9rInnxKd0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109711; c=relaxed/simple;
	bh=QzWD6Sclv+mVopwstfR1LKukKHl969UIt0guEcvc6XA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAu/gPp3N+M3tVHd2Egwdtb9+NwMW7aKCAf+ElI9Vgtng9QkF0Ije79TH6I++jTqV+qZU7NTvH2EQgviMYGaE2zZiZpcFXopApMSdZAdPVSXN77k95rxlOQ7MYrOJnW+WSvbGGDmefHubNqZ5MDaFd/RHq1J/rkx2azFu+Mc4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmvBoEdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB40C2BBFC;
	Tue,  7 May 2024 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715109710;
	bh=QzWD6Sclv+mVopwstfR1LKukKHl969UIt0guEcvc6XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmvBoEdZZG/7CwyIbbdFtL92Mx5ej2vbm+e3KOVdho5H2WSqyHNXEEw+ucCHfqnf9
	 d5Wgnv2kqsF0ParhtgXVw431M5FMy8jGiCnEw2Ddx0I2o6bl2DL5qn+Imz+/S4csgA
	 tceIL55uX6pfmdYpz4A3WZ/7Af9xgXjZTXu/X5MSaiMXhDMOdn0i17AQn5I57+DFuB
	 jVWYms2IicTe+7mrdxDciMMcAjoS0kcnLCVocVUv/pNFp3C74HEXMxd5x3vMlQgFrx
	 lR/GtTejKnodxvh2tSkAIeeIVJk4xwl8rjoKmm7FMQQefVtiyxPDCyWRYVYeC19g8F
	 3A/MzZ3I86XJg==
Date: Tue, 7 May 2024 12:21:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: David Ahern <dsahern@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Andrew
 Gospodarek <andrew.gospodarek@broadcom.com>, "michael.chan@broadcom.com"
 <michael.chan@broadcom.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, Willem de Bruijn <willemb@google.com>, Pavel
 Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Shailend
 Chand <shailend@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Message-ID: <20240507122148.1aba2359@kernel.org>
In-Reply-To: <CAHS8izPu9nJu-ogEZ9pJw8RzH7sxsMT9pC25widSoEQVK_d9qw@mail.gmail.com>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
	<20240506180632.2bfdc996@kernel.org>
	<CAHS8izPu9nJu-ogEZ9pJw8RzH7sxsMT9pC25widSoEQVK_d9qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 11:17:57 -0700 Mina Almasry wrote:
> Me/Willem/Pavel/David/Shailend (I know, list is long xD), submitted a
> Devem TCP + Io_uring joint talk. We don't know if we'll get accepted.
> So far we plan to cover netmem + memory pools out of that list. We
> didn't plan to cover queue-API yet because we didn't have it accepted
> at talk submission time, but we just got it accepted so I was gonna
> reach out anyway to see if folks would be OK to have it in our talk.
> 
> Any objection to having queue-API discussed as part of our talk? Or
> add some of us to yours? I'm fine with whatever. Just thought it fits
> well as part of this Devmem TCP + io_uring talk.

I wonder if Amritha submitted something.

Otherwise it makes sense to cover as part of your session.
Or - if you're submitting a new session, pop my name on the list 
as well, if you don't mind.

