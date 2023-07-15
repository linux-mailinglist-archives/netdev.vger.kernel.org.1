Return-Path: <netdev+bounces-18040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118257545B9
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 02:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0836F1C2166A
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 00:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427E628;
	Sat, 15 Jul 2023 00:54:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E996A44
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 00:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25593C433C7;
	Sat, 15 Jul 2023 00:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689382455;
	bh=E92TG6wGz/uVgp29/yWysElC+LAaZKfcIwe4e0tyPMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mg+G/zx2uw4kYBD61PCx2Wu1KZjXc2fhD/FmdaA0AETdQQpOdZKcLdFoW1FbmZ35Y
	 2VGrO4SKE8x+JjibY+TPy9nuMRd+oiDrAPjC8r+rYEmjBqRbXhsM2dNXliBIa97o+j
	 hCm9xrd+uU9CBeAz7qLKAN/ZZ6+GP4W4JPucGnT4Ri05fK/3F3GXjT0Jh+GlDtvZfW
	 WOwFlBj2YPAhGu/T7HTWtGQJPI66JCkKnnzGF6zMlIzDkeEglGE+5GFg13QlJSeXOZ
	 pEgfie586fWLlEMTZWxjMJ7PhWbFs1VNZKZKWlXQtVWUvDAQUJE3MXvZ/Xumo5F7Gm
	 V0Kk9LU0RqMYg==
Message-ID: <e64291ac-98e0-894f-12cb-d01347aef36c@kernel.org>
Date: Fri, 14 Jul 2023 18:54:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Stacks leading into skb:kfree_skb
Content-Language: en-US
To: Ivan Babrou <ivan@cloudflare.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/23 4:13 PM, Ivan Babrou wrote:
> As requested by Jakub Kicinski and David Ahern here:
> 
> * https://lore.kernel.org/netdev/20230713201427.2c50fc7b@kernel.org/
> 
> I made some aggregations for the stacks we see leading into
> skb:kfree_skb endpoint. There's a lot of data that is not easily
> digestible, so I lightly massaged the data and added flamegraphs in
> addition to raw stack counts. Here's the gist link:
> 
> * https://gist.github.com/bobrik/0e57671c732d9b13ac49fed85a2b2290

I see a lot of packet_rcv as the tip before kfree_skb. How many packet
sockets do you have running on that box? Can you accumulate the total
packet_rcv -> kfree_skb_reasons into 1 count -- regardless of remaining
stacktrace?

> 
> Let me know if any other format works better for you. I have perf
> script output stashed just in case.

I was expecting more like perf report which should consolidate the
similar stack traces, but the flamegraph worked.

> 
> As a reminder (also mentioned in the gist), we're on v6.1, which is
> the latest LTS.
> 
> I can't explain the reasons for all the network paths we have, but our
> kernel / network people are CC'd if you have any questions.


