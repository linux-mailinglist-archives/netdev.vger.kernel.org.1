Return-Path: <netdev+bounces-86349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82389E6DB
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5547283DF6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533D387;
	Wed, 10 Apr 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7L4C9W5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511437C
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709030; cv=none; b=IDSHM6V2oqBkTWQBbq1uBVjZSGJ+mLPKFegtRg8NofSvXtVLBpHEIADpQh289Z+F94pljEscEh7S/kKjv+Z3A/CQwaan7Gaq1gI3EogO6LqIc6HGhGQkH11mscI/CzW8JAeQwe2OPd7VFc+SrN5L/aUOd+hOJ7Iwf4zEjJene9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709030; c=relaxed/simple;
	bh=a48+8ZKh3QhgevDww7G2yhFb++nH8beceaD0y9XlnrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fk6ee767fUvGJtlUjZtcj0tUWP/lDcy0h0UvWrGIxID9mENANI5Le5PdkDvFbqLWWNOFvZX7xpl7ebxiLmMmasI9GmBp7mKvIoNd23KfT89w1ZozsXJEp6g1s8R0jwuZU/Izw2XBPpHXufPMCIp1MKzD+FwHzmH14K7bEKfjMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7L4C9W5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EA50C433F1;
	Wed, 10 Apr 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712709030;
	bh=a48+8ZKh3QhgevDww7G2yhFb++nH8beceaD0y9XlnrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O7L4C9W5jJWAKN0k/O7kDnyo9cM0oUF9X3EDv4XI5BuhEFsVKk8qHlHZtxcZ9eGv+
	 7/fvVzvhwWP9rvmgF36GWx//Dqb3dRt+xwOX/QDyDQ3BqAknx7GpELinZDYd3GWKWQ
	 iMjUK59Buunl0E2ZRMTs68l0E9yxuqa7p1uvpCprIFD1glVkwinUKUOK6Fa3T5kW6s
	 AP6R6JkL4TAwNR2OjL9IXzy/ZWGGEMciV7NnW88Qk57NXGoJDDIaXH0QeaTY157ayJ
	 SQbEaCwRmPr3Y6REywbGZG/muQQSfoE7cWoI/efWimNKDoEmSmSgQDAmTPeAfrfRXI
	 4IqYGEgvfMsiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70981D60313;
	Wed, 10 Apr 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: fix race condition between ipv6_get_ifaddr and
 ipv6_del_addr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171270903045.7096.13589832911072928239.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 00:30:30 +0000
References: <8ab821e36073a4a406c50ec83c9e8dc586c539e4.1712585809.git.jbenc@redhat.com>
In-Reply-To: <8ab821e36073a4a406c50ec83c9e8dc586c539e4.1712585809.git.jbenc@redhat.com>
To: Jiri Benc <jbenc@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org,
 edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Apr 2024 16:18:21 +0200 you wrote:
> Although ipv6_get_ifaddr walks inet6_addr_lst under the RCU lock, it
> still means hlist_for_each_entry_rcu can return an item that got removed
> from the list. The memory itself of such item is not freed thanks to RCU
> but nothing guarantees the actual content of the memory is sane.
> 
> In particular, the reference count can be zero. This can happen if
> ipv6_del_addr is called in parallel. ipv6_del_addr removes the entry
> from inet6_addr_lst (hlist_del_init_rcu(&ifp->addr_lst)) and drops all
> references (__in6_ifa_put(ifp) + in6_ifa_put(ifp)). With bad enough
> timing, this can happen:
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr
    https://git.kernel.org/netdev/net/c/7633c4da919a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



