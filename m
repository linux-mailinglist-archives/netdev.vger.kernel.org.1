Return-Path: <netdev+bounces-17659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B975293F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55178281E81
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874AB182DF;
	Thu, 13 Jul 2023 16:57:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A5101C1
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3911AC433C8;
	Thu, 13 Jul 2023 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689267468;
	bh=1U0ZApqiqBJyYb9F7YTTl2VWqVGIrbvAyt5SJ/N5UeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gNHYUQTLWWGxDhkxQy/gad2QxsFLJin7GlOhdFTKBWpWTLxYwc9mgVt3jrjY/62Ey
	 ecezQTdRweCO0ohUX4Gb0RzeUHBNrfAlCXqYo/3nXOA9xvFk3IevAAXSv4Z6iN/Zmh
	 vbTn3Qxla3CBL9pqLAjHb+Yct8AlA00mniRah1/41TUckc9NnLwzCGJ2ejUyJo9NzJ
	 8lZ7eo01eroncxURfMzj7FLp2XD4I4ri9SL20Z5P18eAyc8x8i6UZb/L46P/4WoHKn
	 aOa8E5LzzJgtghUzkU3wm3FvZ8PkeV/QPTIgt4G4XmFgYYsxHYTyjo1CizuHbpUEgW
	 KwJcrDBg+dtkQ==
Date: Thu, 13 Jul 2023 09:57:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: Ivan Babrou <ivan@cloudflare.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, David Ahern <dsahern@kernel.org>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for
 tcp_listen_queue_drop
Message-ID: <20230713095747.580c2b0a@kernel.org>
In-Reply-To: <CAO3-PbqtdX+xioiQfOCxVovKVYUgXkrmsfw+1wTYoJiAq=2=ng@mail.gmail.com>
References: <20230711043453.64095-1-ivan@cloudflare.com>
	<20230711193612.22c9bc04@kernel.org>
	<CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
	<20230712104210.3b86b779@kernel.org>
	<CAO3-PbqtdX+xioiQfOCxVovKVYUgXkrmsfw+1wTYoJiAq=2=ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 21:43:32 -0500 Yan Zhai wrote:
> Those are not unnecessary calls, e.g. a lot of those kfree_skb come
> from iptables drops, tcp validation, ttl expires, etc. On a moderately
> loaded server, it is called at a rate of ~10k/sec, which isn't
> terribly awful given that we absorb millions of attack packets at each
> data center. We used to have many consume skb noises at this trace
> point with older versions of kernels, but those have gone ever since
> the better separation between consume and drop.

I was hoping you can break them down by category.

Specifically what I'm wondering is whether we should also have 
a separation between policy / "firewall drops" and error / exception
drops. Within the skb drop reason codes, I mean.

