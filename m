Return-Path: <netdev+bounces-79318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F290878B73
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 00:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF751C20BE5
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 23:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3008158AB9;
	Mon, 11 Mar 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO0jIfPv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924C58AAC
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199206; cv=none; b=uR4lBYDVuUheby/04pPexQ6SBX2DKbIetouUUVJXJt4dm5q9vA39KoRLWIBnHvh5NnJ+Mlncl/wxSz8M6uoHTg9fJXmPPO29L2ZRxCOnvFL8vvU8YEhmsSt3eaIM6oA8fuRfTgfqavDNShDInsyfuhN/dsiJPVqafvh+FLZJjvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199206; c=relaxed/simple;
	bh=IbBZ1ill7oXGlNPAar3DqvVmnFCQBGb3pO4nt/R/sQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXZqlHr63KNF4CMuU1dnFuo2wKZ3RivvStYMZhOP5/V82glZG/OHyYXedb/Zl/pA1FTnFA7lNjuimkHPWWeF5lIf7eY0yGnZsLoseuy2camJO+xUz9HCFUN4V7IXMIEK2W91vJlTYtjZXcfYLU3S4JzwVtsxa9PUYOsN0xrZ6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO0jIfPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74438C433F1;
	Mon, 11 Mar 2024 23:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199205;
	bh=IbBZ1ill7oXGlNPAar3DqvVmnFCQBGb3pO4nt/R/sQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pO0jIfPv3vOCBlbpdH005IraQYbH27aXSDk0CMTlpnBFwP8d0ojeRLdSVswCyH5Fh
	 +ByliuLphzw3l1YeWPkE/yzX7gFnKccWqHhXXPAZt4cNORWZnyYXqd2o0lOhNmqfFz
	 YY3sXCb47ycwWESxukGz4/p6X6mgT4yKFwAauXhM0z5in6kwOecIOEE+R4zRHh2T/b
	 Gvn53t4IlpKVZeYTTOon6WcT+JiRpRE2H3I8tvQL9/dGmcThRocbcwwD060Waq6R9c
	 1IGUxIppgMkh/+PaJR+3J7iiylW5V8wMMiy1WfHzQp9TP/Ff2Jb9qfbOFiiVbukkVo
	 eHI/vJolOtZeA==
Date: Mon, 11 Mar 2024 16:20:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v5 net-next 0/4] net: Provide SMP threads for backlog
 NAPI
Message-ID: <20240311162004.2322cf84@kernel.org>
In-Reply-To: <20240309090824.2956805-1-bigeasy@linutronix.de>
References: <20240309090824.2956805-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 Mar 2024 10:05:08 +0100 Sebastian Andrzej Siewior wrote:
> The RPS code and "deferred skb free" both send IPI/ function call
> to a remote CPU in which a softirq is raised. This leads to a warning on
> PREEMPT_RT because raising softiqrs from function call led to undesired
> behaviour in the past. I had duct tape in RT for the "deferred skb free"
> and Wander Lairson Costa reported the RPS case.

Seems a bit risky to apply this last minute, could you repost first
thing after the merge window? Sorry..
-- 
pw-bot: defer

