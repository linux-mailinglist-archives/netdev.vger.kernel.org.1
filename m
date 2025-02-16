Return-Path: <netdev+bounces-166762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83693A373A8
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 10:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9981C1890DE5
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF40215539D;
	Sun, 16 Feb 2025 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhHeIoQN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12A8172A
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699409; cv=none; b=IyYg6RAMB1s60cgugoAW8XNw/7rME5Vn3iz+sMLMxClUnPj3h7Y7bPFvRTn7igxI+c1CH9zTEmw7NMnNHjx4SLgZKVJxukXFzJRpfEBZpOjqZLhNYAdnfeXv8t4ynvfc6DkTHnQBxJ/nI0leoA4DJd2K6jMAr32EK9gW7hxo6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699409; c=relaxed/simple;
	bh=A9fKlxByrlgV+CFbNfA7tfyCpeSSt0sCylcfX/iXexI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTemoOVg2E3eFRA4DqPrzEAVPDMYZqzaRjEaaxoD2mV28pvbgHd9lFiQog/65y96+bE7cACJadOnmvcetsfZYwC8nMX7WN9q8Ea+KS22uaNXqfHzShXpQGIOqDAdXehOzBu/s1NPpF3jIXVQlXDVEcAYVECyTYuH/FXb3dSsQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhHeIoQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675FCC4CEE7;
	Sun, 16 Feb 2025 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739699409;
	bh=A9fKlxByrlgV+CFbNfA7tfyCpeSSt0sCylcfX/iXexI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhHeIoQNBdBsjW8Va4thBMxHFzVJg8jQG+wAYEA1dSJOnwETL6q1VtqxmJDj41YFT
	 j5U/rWxEYjCCLCLFObFajnBkqIrBJcfFj+1206KIrAvj2y55SqWSwPvkqXy/XMiP3B
	 sgpZjPIzqF8NbUB8ch7zLWmlNqsKjBkC38fsp56aPl+8f34bpyZUMOKjij1zItTwvV
	 OPfiY2D85Csr5qAa7Z2gs9Njh+I01Fiw1gCcbHWJgsl33GdrfktwhqQKOuB3jeVH/T
	 0y990fa6gOWpea7IS7GW5Ejg0Yi1yzjxLZ4UQR7d1pT0jI30yHqFdkJu311MvmdyxE
	 +3jlRkjaDSnxg==
Date: Sun, 16 Feb 2025 09:50:05 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Paul Ripke <stix@google.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/2] ipv6: fix blackhole routes
Message-ID: <20250216095005.GC1615191@kernel.org>
References: <20250212164323.2183023-1-edumazet@google.com>
 <20250212164323.2183023-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212164323.2183023-3-edumazet@google.com>

On Wed, Feb 12, 2025 at 04:43:23PM +0000, Eric Dumazet wrote:
> For some reason, linux does not really act as a blackhole
> for local processes:
> 
> ip route add blackhole 100::/64     # RFC 6666
> ip route get 100::
> RTNETLINK answers: Invalid argument
> ping6 -c2 100::
> ping6: connect: Invalid argument
> ip route del 100::/64
> 
> After this patch, a local process no longer has an immediate error,
> the blackhole is simply eating the packets as intended.
> 
> Also the "route get" command does not fail anymore.
> 
> ip route add blackhole 100::/64
> ip route get 100::
> blackhole 100:: dev lo src ::1 metric 1024 pref medium
> ping6 -c2 100::
> PING 100:: (100::) 56 data bytes
> 
> --- 100:: ping statistics ---
> 2 packets transmitted, 0 received, 100% packet loss, time 1019ms

Hi Eric,

Sorry to nit-pick on something that is nothing to do with the change
itself. But could you reformat the above somehow as git will cut off
the commit message at the ("^---") above. Which amongst other things
means the patch will end up without a Signed-off-by line in git.

> 
> ip route del 100::/64
> 
> Reported-by: Paul Ripke <stix@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

...

