Return-Path: <netdev+bounces-160689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D0EA1AE04
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 01:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C1A3A59AC
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 00:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F61B5ECB;
	Fri, 24 Jan 2025 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW0M/6l1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154982CA8
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737680155; cv=none; b=n/BZZ1Gwx6le42pXgOQYPqAgbJcbR3fm0moNo78Vh4ozM1GXPDcQ+Fs8kyAET5Z5BKrs267MniccLznVS8EeUcqSutF2lXimwahMPfOSGJ3AncZph91HDpvoWs5dekHzlEYwNPV+9Pgt1iEu/rnKbiSKtzLcSVKcNfUdlAbCbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737680155; c=relaxed/simple;
	bh=GgZ1OxoHl4YMgWSNjg9SGIkm1qHOsolXI+fJrenYJto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r184/X8keL3owOpMD7YXrze6SGnwk3ab1EgnYB+GEk+IX8sXSz/chBGr7pZ3kgLn/ftRD8MWg1fk4MUVkbzVQN6iysPUCCK61iAVRxzloYgZPw/QOvRffiC4EYLJXVsj2CVxQEysLl7Gm2pDwuqWyKDLOIGUnPyyBRB8+chKMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW0M/6l1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1EEC4CEDF;
	Fri, 24 Jan 2025 00:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737680154;
	bh=GgZ1OxoHl4YMgWSNjg9SGIkm1qHOsolXI+fJrenYJto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FW0M/6l1ikWQB72zrDw8ULysyNZGblk8ZxfacKTFR8JurNrn4j9dJjv43dnrF9/gN
	 bXFgqthvCxLRYfb0Pp/btRu/hb+SBJuDvPvwQ5Gqd6SPvIOHVJJFdlzrtSl9CgEy5r
	 KZC0APjYyF05QtmpOKRlyXjkUH1tPDlszWRZL3gn0sw9XnyjLXi6drh416l2wYNbmO
	 N1njF7STrJW2+S39X753olzlz1Nklxw4FfF4Se4NjDHPY3lXWnIV3hCzJ6dRNPBNIf
	 +ihXhNKs7e5pCPn4+h8j9T6IaPZyRabEDY7LGofd80ghRGYO0FsSlcgXWPJQr5Fc3j
	 2HqEG9kkea2Pw==
Date: Thu, 23 Jan 2025 16:55:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [net-next 10/11] net/mlx5e: Implement queue mgmt ops and single
 channel swap
Message-ID: <20250123165553.66f9f839@kernel.org>
In-Reply-To: <Z5LhKdNMO5CvAvZf@mini-arch>
References: <20250116215530.158886-1-saeed@kernel.org>
	<20250116215530.158886-11-saeed@kernel.org>
	<20250116152136.53f16ecb@kernel.org>
	<Z4maY9r3tuHVoqAM@x130>
	<20250116155450.46ba772a@kernel.org>
	<Z5LhKdNMO5CvAvZf@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 16:39:05 -0800 Stanislav Fomichev wrote:
> > > What technical debt accrued ? I haven't seen any changes in queue API since
> > > bnxt and gve got merged, what changed since then ?
> > > 
> > > mlx5 doesn't require rtnl if this is because of the assert, I can remove
> > > it. I don't understand what this series is being deferred for, please
> > > elaborate, what do I need to do to get it accepted ?  
> > 
> > Remove the dependency on rtnl_lock _in the core kernel_.  
> 
> IIUC, we want queue API to move away from rtnl and use only (new) netdev
> lock. Otherwise, removing this dependency in the future might be
> complicated.

Correct. We only have one driver now which reportedly works (gve).
Let's pull queues under optional netdev_lock protection.
Then we can use queue mgmt op support as a carrot for drivers
to convert / test the netdev_lock protection... "compliance".

I added netdev_lock protection for NAPI before the merge window.
Queues are configured in much more ad-hoc fashion, so I think 
the best way to make queue changes netdev_lock safe would be to
wrap all driver ops which are currently under rtnl_lock with
netdev_lock.

