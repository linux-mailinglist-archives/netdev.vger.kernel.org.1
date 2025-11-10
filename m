Return-Path: <netdev+bounces-237273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4122CC481E4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1C043417D6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4530E0F1;
	Mon, 10 Nov 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYLUIqPT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1028642B
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793074; cv=none; b=dfXEoQha2UlRTVxQBjE/hCylTn3eeV8L/RXqwIkKH6o0dHzX0L33TO3PqrrHeCG5JQN5q/h1XzUX4BUcM3qChuw2raw9vUt5orylYDthjREv8Q0cLoHVszcdArFukxNWE7wN32/pkKnwPC+Q+siXpsEoAzEW3n4D28wgIDVOAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793074; c=relaxed/simple;
	bh=H3rg+bLE58X0l5ndlQN9ibafKxCINobeJYzKJIbJkyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNy2Dz8vlBnuco0PZZkaYtGT7l7ZEIsF/tSRIwLC9NSioBcgWaL14mNl7onamny305x2VQCCaObzyZ99AQFiCa8GDWo8LXwUYHFeJ0XrnhklSobJqAac9eHJIv3zdgXVN6FrEtsgZ4wSTV3EbnLMzcxXahs61sKJQ0Aku7/NfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYLUIqPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147F3C4FF58;
	Mon, 10 Nov 2025 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762793073;
	bh=H3rg+bLE58X0l5ndlQN9ibafKxCINobeJYzKJIbJkyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HYLUIqPTYatyIh4FxO3vxGMoSs/hiigiMYtRZhMVoSR0hOBcTZAutP8MzhQzi8P4z
	 bejTwi3eeCF5/mpjake+0hX9YVUQ+9oyI2UknoJCbdiTwo/XK8wn/gzX2OTS8pw96j
	 GUIZE7NaEvNyVEpuAxZRcxIt/aI8C38A6vIjgFTas3sNfN5Io7/T9d8b+DxrJeiJXQ
	 LC6e3UUMsj67RlPYILUSwCAH/yd9D/ngxgrYKkj2kv6xlzM+8auZlGIem4CbDJTy/u
	 SITbsKkFYiEVUagcE5gben2kz+Eu48SN9lDmc2VUXfj91sWG5SEkyjcu9Dith1r+F9
	 UzOI32u3VmDFQ==
Date: Mon, 10 Nov 2025 08:44:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?="
 <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 00/10] net_sched: speedup qdisc dequeue
Message-ID: <20251110084432.7fdf647b@kernel.org>
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
References: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 09:44:55 +0000 Eric Dumazet wrote:
> Avoid up to two cache line misses in qdisc dequeue() to fetch
> skb_shinfo(skb)->gso_segs/gso_size while qdisc spinlock is held.
> 
> Idea is to cache gso_segs at enqueue time before spinlock is
> acquired, in the first skb cache line, where we already
> have qdisc_skb_cb(skb)->pkt_len.
> 
> This series gives a 8 % improvement in a TX intensive workload.
> 
> (120 Mpps -> 130 Mpps on a Turin host, IDPF with 32 TX queues)

According to CI this breaks a bunch of tests.

https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-11-10--12-00

I think they all hit:

[   20.682474][  T231] WARNING: CPU: 3 PID: 231 at ./include/net/sch_generic.h:843 __dev_xmit_skb+0x786/0x1550

