Return-Path: <netdev+bounces-170479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE237A48D87
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94C018907AC
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADC1C01;
	Fri, 28 Feb 2025 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAm/ZNwx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13DC748F;
	Fri, 28 Feb 2025 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703761; cv=none; b=bcJRa6V1JTMmlLS+Gneoxe21O505hwx7k0ljHb+N5RZCxRPdch4l9ELZXTipcW+udBtEy25JOblEn8xnEtNXsVorZcsUjQ6pWDL/hziQo9fMBmbVMCFvQ0sGJ03HbcAq+4sLqx/FlxFm1N9mUPQOMNoyVhM+VfOF47sFv5Xmguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703761; c=relaxed/simple;
	bh=izlwuzlpwkPfJtmpLdNckvzl/Yrix0fHSqdWSI0vuc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac4vgHKt6UAHF75Fc2tXTK8h/PAV603jd+fkBbbnCUTfIIg12e/+9l10FXXnYLEMDCv7oz/6J8eLOIbcltSTbrKUGqIo7/dDmCFJNCyosDZCYdyJJznSFx4N+O2IPOpppcD8QrPMJzKPL13sgVyYq4t2QNkxkgDUj2qHlaWCe2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAm/ZNwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2528C4CEDD;
	Fri, 28 Feb 2025 00:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740703760;
	bh=izlwuzlpwkPfJtmpLdNckvzl/Yrix0fHSqdWSI0vuc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mAm/ZNwxFpX0pQTSn41oSDn4PCELjeNyVZ48PxPkBuI8ZHAcGpVOWcj+nWBQa7U8W
	 dxtJElC7p7kKzRvqIjq8EPE21cEhxeoWlDeJTuwD9o2F0RosPYkyxYrzk0ZQi7lkGr
	 RZRvuY5oBRzTiy8z0q3MzTSwKRgf0eJ/hOQ8F5bRVYpUgqDtDQURGqwWvmFNr0EQcU
	 IY95PZ2vcqJ8x5gae4JPNrDgHXM8wObCRIUK+YN8LJQUm7XfQRulfbRmvxD2UlFwOj
	 hN4+vb8ETecPn3veSKI8VdaMk0vq+TGkrUtn01rzzQJ9vZnHSq4hh3EPWQLg/xt62+
	 b74r0bN3ObsbA==
Date: Thu, 27 Feb 2025 16:49:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brauner@kernel.org, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/15] afs, rxrpc: Clean up refcounting on
 afs_cell and afs_server records
Message-ID: <20250227164918.3b05d94e@kernel.org>
In-Reply-To: <174068405775.1535916.5681071064674695791.git-patchwork-notify@kernel.org>
References: <20250224234154.2014840-1-dhowells@redhat.com>
	<174068405775.1535916.5681071064674695791.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 19:20:57 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> Here is the summary with links:
>   - [net-next,01/15] rxrpc: rxperf: Fix missing decoding of terminal magic cookie
>     https://git.kernel.org/netdev/net-next/c/c34d999ca314
>   - [net-next,02/15] rxrpc: peer->mtu_lock is redundant
>     https://git.kernel.org/netdev/net-next/c/833fefa07444
>   - [net-next,03/15] rxrpc: Fix locking issues with the peer record hash
>     https://git.kernel.org/netdev/net-next/c/71f5409176f4
>   - [net-next,04/15] afs: Fix the server_list to unuse a displaced server rather than putting it
>     https://git.kernel.org/netdev/net-next/c/add117e48df4
>   - [net-next,05/15] afs: Give an afs_server object a ref on the afs_cell object it points to
>     https://git.kernel.org/netdev/net-next/c/1f0fc3374f33

Nice job pw-bot! Turns out the first 5 patches were already in the net
tree with fixes, and now they made their way to Linus. So let's discard
those from v2. And even less of a reason for this to go via networking
:(

