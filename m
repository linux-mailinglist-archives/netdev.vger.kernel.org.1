Return-Path: <netdev+bounces-225002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24435B8CE93
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 20:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB161897488
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA84306495;
	Sat, 20 Sep 2025 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKlSoGWR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898451F2B88
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758391861; cv=none; b=GsySoyoKOO7U6dWkWKKkX5Bron8wyCP+wR7Rj4ptpJZBf4FjxYEdTNjXzwjIHN8lqIo3L0VWlCScKGhFftIXhE05/VJmfLgt/dxapizGp0ml2CXCP48wkdlTejKS7VCtKY6bXcetye/I7/aN4X1uRi4zoIOju+QRI+8mrXmeFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758391861; c=relaxed/simple;
	bh=tRmmTJXL3Xwh7JS5EltUsrjIDcovLf+PQZHmwC0Ht2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IznmKMWwut2lue6U1mp7D96kWAnS3GGK2fI1tGdXs8B2G7ec/bvLEfoi93sOnM4PE1ZofGjZX5HjuYmjoLH2k3jMybF0eAlahxdKfLoIDtShdgIFPmVmRj4eaZHclEAD3nq+2KNXxhcPBhgKfGCTIP/9mSKMu/UGBbyGrq3le+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKlSoGWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F62C4CEEB;
	Sat, 20 Sep 2025 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758391861;
	bh=tRmmTJXL3Xwh7JS5EltUsrjIDcovLf+PQZHmwC0Ht2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MKlSoGWRES3TMX/djvRIoLsXLtnhESXy0pZWlYeeb5iI4pMajpdmaifR7QCv27bVp
	 4Wm54j0AtFMlbxwoblcLM0g92y75FWCFuTAbgVEBzpbK6VAHI+fETB/MkDyLBdP9pR
	 /ZX2yss6haHdhFAP43Jg3JQDgEXQjgaGIY6x/SWuW+eINne1yuf7o0SarzTmwBvAN6
	 mR9c8aO36rULibmVsZelvWpipB5cbmXDF+BGprNULHR+Aezt2fuA82+AXiLc7AZWhS
	 WURhV1a0UIkM/ZE1FQKYYgooqKYTrg0vjDeRjqM7TKQcvQmvcuuCqWlCNwwdFL2j6O
	 slCNc+F1m3tzw==
Date: Sat, 20 Sep 2025 11:10:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next] udp: remove busylock and add per NUMA
 queues
Message-ID: <20250920111059.500c2b8f@kernel.org>
In-Reply-To: <20250920080227.3674860-1-edumazet@google.com>
References: <20250920080227.3674860-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 08:02:27 +0000 Eric Dumazet wrote:
> busylock was protecting UDP sockets against packet floods,
> but unfortunately was not protecting the host itself.
> 
> Under stress, many cpus could spin while acquiring the busylock,
> and NIC had to drop packets. Or packets would be dropped
> in cpu backlog if RPS/RFS were in place.
> 
> This patch replaces the busylock by intermediate
> lockless queues. (One queue per NUMA node).
> 
> This means that fewer number of cpus have to acquire
> the UDP receive queue lock.
> 
> Most of the cpus can either:
> - immediately drop the packet.
> - or queue it in their NUMA aware lockless queue.
> 
> Then one of the cpu is chosen to process this lockless queue
> in a batch.
> 
> The batch only contains packets that were cooked on the same
> NUMA node, thus with very limited latency impact.

Occasionally hitting a UaF like this:
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/306342/3-fcnal-ipv6-sh/stderr
decoded:
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/306342/vm-crash-thr2-0
-- 
pw-bot: cr

