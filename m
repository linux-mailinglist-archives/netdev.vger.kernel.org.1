Return-Path: <netdev+bounces-181760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E99A86626
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BE21748AC
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB775278178;
	Fri, 11 Apr 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqiB2ID6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B70258CFD
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399180; cv=none; b=bSdFTd3hiw1d1i3VVyJgaBDK2/qlh/WanbtHiUGcatP6CHVvze4NtQIE8Tw7vmg0OEZWHTKkzjhm0iaKzffhbAT1MCfJoIUwmxVvV6oyoTNPXDevCkYL1LOlBOk0P0xU6OkglqSIdPevzDllhYE4fDIGvKJF4wyCu49NOEBGuOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399180; c=relaxed/simple;
	bh=9Y15rTW2VSOUk8bOlguRZuDu9ioANCbUlgWc4+05hLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxkwH+0McD3esH8YAfJu5L40DT1fejDYkj7/v4YkhnPbQsvc6RDu3pAuf8dQQwmxqMRyYFo1Pr+BuqNO8wcsXe9E0md8fNMbkDF6ruJAfOgT7hHxj34a10WudBSd8cUI30CDZ7wvqH0VZb7Ngt3zrArS6+wtiTNxmEB2YVbqdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqiB2ID6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5943C4CEE2;
	Fri, 11 Apr 2025 19:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744399180;
	bh=9Y15rTW2VSOUk8bOlguRZuDu9ioANCbUlgWc4+05hLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LqiB2ID6SEMFT4mRC4UBulwwtkJ2E04sH1EK695ZQUUEvkFzJXp/x5JEfweRoO6UC
	 UqUPcQhOCiSOOlGRZ/Nee7UjVaYBi5M6yjSBOmhhr2qcX97P5KtN5+chWPNHHJ6Hb0
	 eowA0STMMq/Co47gi0qkpgZhUw6+G5bFvIY16AqzoLILkdjNINcM5RxRoMjhoI2inu
	 WdzLMa6SE4T4vqXKACYrw85DaX49PHCJClAd/85uGhgjj6okJfLbmDGtl9Ok8EiQ9D
	 E6yXeH2QFDejileVB8dgXbg/1txpmDiqHTsICPPJux+dFdUQqSdozTwhSELw7qsrP9
	 P8VkWV39BWCXA==
Date: Fri, 11 Apr 2025 12:19:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: sdf@fomichev.me, Kuniyuki Iwashima <kuniyu@amazon.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, hramamurthy@google.com, jdamato@fastly.com,
 netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 6/8] netdev: depend on netdev->lock for xdp
 features
Message-ID: <20250411121938.0afae1b3@kernel.org>
In-Reply-To: <Z_lUZgRc9JYhjnIG@mini-arch>
References: <20250408195956.412733-7-kuba@kernel.org>
	<20250410171019.62128-1-kuniyu@amazon.com>
	<20250410191028.31a0eaf2@kernel.org>
	<20250410192326.0a5dbb10@kernel.org>
	<Z_lUZgRc9JYhjnIG@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 10:41:58 -0700 Stanislav Fomichev wrote:
> > Ugh, REGISTER is ops locked we'd need conditional locking here.
> > 
> > Stanislav, I can make the REGISTERED notifier fully locked, right?
> > I suspect any new object we add that's protected by the instance
> > lock will want to lock the dev.  
> 
> Are you suggesting to do s/netdev_lock_ops/netdev_lock/ around
> call_netdevice_notifiers in register_netdevice?

Aha

> We can try, the biggest concern, as usual, are the stacking devices
> (with an extra lock), but casually grepping for NETDEV_REGISTER
> doesn't bring up anything suspicious.
> 
> But if you're gonna do conditional locking for NETDEV_UNREGISTER, any
> reason not to play it safe and add conditional locking to
> NETDEV_REGISTER in netdev_genl_netdevice_event?

Just trying to think what will lead to fewer problems down the line.

Let's me think it thru. So we have this situation:
 - device A - getting registered
 - device L - listens / has the notifier
with upper devs our concern is usually that taking the A's lock
around the notifier forces A -> L lock ordering (between A's instance
lock and whatever lock of L, can be either instance or some other).

If A is an arbitrary device then L has to already be ready to handle
its REGISTER callback under A's instance lock, because A may be ops
locked. So as you say for generic bonding/team changing lock type
is a noop.

If A is a specific device that L is looking for - changing the lock type
around REGISTER may impact L. /me goes to look at the code
Ugh there is a bunch of drivers that wait for a specific device to
register and then take a lock. Let me play it safe then...

