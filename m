Return-Path: <netdev+bounces-132901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61091993B2F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035161F22153
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE5A18CBFD;
	Mon,  7 Oct 2024 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiWflQ+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA345143C6E
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728343725; cv=none; b=efAWA86kdgaQGdVKvyxXOg4qvpgn0/mE6jRauouaLmLAb6wMB6poZae0wdvN45kK5ANBHTEvXbn9FHu6wBCP8dITukjjLfbsFvcbLqGvye55SmXN1MhkTRxJfmnVbPvqlLPPP98GoypOQCC91JD9t+YA1xIfeBWnpe0FsxkkQig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728343725; c=relaxed/simple;
	bh=JgyASx+KHWPoGyB3IxqRYyR5G7I4stoeyUoicQwyv90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGSKrgZbuoaZ35youG1uM5Qt2eRn0TCo8RUK6NiKHP24vkKl1qV/9JyGZBsDUvpVhVZNEbA+GClaBOYG64DjH2jEirjl7Tyy+mC+1gaf2hXYiSgI+3ZHq5/K+tA7O6IW/f34AhAxl4YAXBkch+iSMsp4ncPsBZktWnDx2LNf8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiWflQ+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A85C4CEC6;
	Mon,  7 Oct 2024 23:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728343725;
	bh=JgyASx+KHWPoGyB3IxqRYyR5G7I4stoeyUoicQwyv90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiWflQ+pIkVgfy9nI9fhZnKxKb9CR3STjohRY2IarGSKwPASNHg10diRM8GyRj/NK
	 f2reotuXjxxHOjK39nujsymAJI7OZst3/j8EegN6VrvNw/chdrEoxzQMf4NrZHk+HV
	 Ru9Txqgf9MRlWyViKzfWND0HpoGj9e7zOOg7n+vDJhw8s8/e1bCp8/axY6mJF0R8TH
	 7KrC+IZe1H0I8+8kpWiNWMofBqHclAY5SdwJor53XegQAffVsnd+Zb/sUF8qdMcv3+
	 WfhqmXLVWH9bP490QoOYA0yr7UCKfPPCxbVV+FORLp2J/BD6gFD2itQcrplwGFdRhx
	 Z0GUJgnhVe+Sg==
Date: Mon, 7 Oct 2024 16:28:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 0/5] tcp: add skb->sk to more control
 packets
Message-ID: <20241007162844.7114835b@kernel.org>
In-Reply-To: <20241006203224.1404384-1-edumazet@google.com>
References: <20241006203224.1404384-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Oct 2024 20:32:19 +0000 Eric Dumazet wrote:
> Currently, TCP can set skb->sk for a variety of transmit packets.
> 
> However, packets sent on behalf of a TIME_WAIT sockets do not
> have an attached socket.
> 
> Same issue for RST packets.
> 
> We want to change this, in order to increase eBPF program
> capabilities.
> 
> This is slightly risky, because various layers could
> be confused by TIME_WAIT sockets showing up in skb->sk.
> 
> v2: audited all sk_to_full_sk() users and addressed Martin feedback.

I think this patch set is causing crashes like:

https://netdev-3.bots.linux.dev/vmksft-nf-dbg/results/804862/2-conntrack-vrf-sh/stderr

I haven't had the time to investigate in depth and before the next run
someone else posted a broken change, sigh.

