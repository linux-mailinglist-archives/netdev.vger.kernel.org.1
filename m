Return-Path: <netdev+bounces-200430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 473C5AE5812
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B69C1BC73B7
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077E22D9ED;
	Mon, 23 Jun 2025 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqGJuc0x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C209229B12
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721755; cv=none; b=Md4PcIK8qV8AL3EnOTDbKwfeWw4PbbcERtBicqSMAN3gX6QXw3PGlJ/UdoW8AljcwuSnmK4aYrZEYlnY/ND4xMCHJS/IRlS2HtOZgmcr4CP9DkntrV67q1XOCfioeSQgqKTYmsmAyU+14VMzuAiGgBk3YrQFJRje6r/cREGWc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721755; c=relaxed/simple;
	bh=pMImxZNf/oufFGq7dbFRwQrYWncAL+Egp/rCbr65EUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSshdJgzuOzCr1qVaqtAQNySuzq3nqshVHsRQ/mBxMw1yiJYApc8NJKQyjH8JzUsUv7yBpx13std8TcGrtJ3zuQnSaKqdvbrkilBfMBcTN9GRbtWjRtGJ5f/x+kvpezR8n8jXruVFKbJ54qp9g4w/OuXBWqoM8XzWL9+DJGSHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqGJuc0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7661CC4CEED;
	Mon, 23 Jun 2025 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750721752;
	bh=pMImxZNf/oufFGq7dbFRwQrYWncAL+Egp/rCbr65EUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EqGJuc0xydkVaxagZ3bUIuKne7WZ2BypUWSv8W5jUsxFMiolAd7IS1yMYqqm9PT8E
	 ldVMPQSW5AZ4gb13sFOXyS3WMltx2jfITdl398O7+KWAj4ghZNEQJ8juZPRiRs3vKu
	 e9WX9/9KBUb6/tQi7Z2dpwXV2Z51Q4RD3jWuSCdZDlRvGLMfVnvksE9V1i7L3aCaxO
	 4gdq06bDeyQ+0L7kPVIGuhgSZZmPINIm0/dW1CtlyvW2WQJNw03n5Ssjm+jfgETMAT
	 c5SJiC+NlYR6xlBtXoCrS2kEb0wMRrQM2BCPTZ8ue2lBdgKSMwdX4F1PwLybc6YHEM
	 ADnL+BQqA6ZMg==
Date: Mon, 23 Jun 2025 16:35:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: jbaron@akamai.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v2 3/3] netlink: Fix wraparound of
 sk->sk_rmem_alloc
Message-ID: <20250623163551.7973e198@kernel.org>
In-Reply-To: <20250619061427.1202690-1-kuni1840@gmail.com>
References: <2ead6fd79411342e29710859db0f1f8520092f1f.1750285100.git.jbaron@akamai.com>
	<20250619061427.1202690-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 23:13:02 -0700 Kuniyuki Iwashima wrote:
> From: Jason Baron <jbaron@akamai.com>
> Date: Wed, 18 Jun 2025 19:13:23 -0400
> > For netlink sockets, when comparing allocated rmem memory with the
> > rcvbuf limit, the comparison is done using signed values. This means
> > that if rcvbuf is near INT_MAX, then sk->sk_rmem_alloc may become
> > negative in the comparison with rcvbuf which will yield incorrect
> > results.
> > 
> > This can be reproduced by using the program from SOCK_DIAG(7) with
> > some slight modifications. First, setting sk->sk_rcvbuf to INT_MAX
> > using SO_RCVBUFFORCE and then secondly running the "send_query()"
> > in a loop while not calling "receive_responses()". In this case,
> > the value of sk->sk_rmem_alloc will continuously wrap around
> > and thus more memory is allocated than the sk->sk_rcvbuf limit.
> > This will eventually fill all of memory leading to an out of memory
> > condition with skbs filling up the slab.
> > 
> > Let's fix this in a similar manner to:
> > commit 5a465a0da13e ("udp: Fix multiple wraparounds of sk->sk_rmem_alloc.")
> > 
> > As noted in that fix, if there are multiple threads writing to a
> > netlink socket it's possible to slightly exceed rcvbuf value. But as
> > noted this avoids an expensive 'atomic_add_return()' for the common
> > case.  
> 
> This was because UDP RX path is the fast path, but netlink isn't.
> Also, it's common for UDP that multiple packets for the same socket
> are processed concurrently, and 850cbaddb52d dropped lock_sock from
> the path.

To be clear -- are you saying we should fix this differently?
Or perhaps that the problem doesn't exist? The change doesn't
seem very intrusive..

