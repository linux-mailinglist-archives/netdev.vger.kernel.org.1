Return-Path: <netdev+bounces-104346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F080190C366
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D82B22E88
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541C91CA9F;
	Tue, 18 Jun 2024 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir5nyWS+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480E1C2A8;
	Tue, 18 Jun 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691528; cv=none; b=JLzuxZ91EkWS6p7TythN1E2S0WcInp3Y68IfEvKjbR3SDgfNs3ZXqtriU1aMtjbGBbWIX66cdedU6JEJu2qLsjXLB71I8yVMIyFZH/2Tzki2nCGX9bYuGnI83w9h0A9bbP2kSWmpbsdTpBnjVUGJ/sHAeVAmY7GnaGBlfo68iCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691528; c=relaxed/simple;
	bh=kbllykrcxB7X3VfffLCQJ1493vNgA9J8ctVO7kMB7TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgLkaatWHWRlrRLotAnO9DlmzQt+2ARsug4FaoEIjpOso66r05m87oYk3w6vU71jAG9EVPWi7tEFTh7xE7soEQlGVQv7qGO2TXIxuQcZ/LOFLJV6SAhuK0M7Za0optNrDPSZA23PDytgO3QVXTrNi39VklNqvpYaQ0bUAhIVc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir5nyWS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0446FC3277B;
	Tue, 18 Jun 2024 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718691527;
	bh=kbllykrcxB7X3VfffLCQJ1493vNgA9J8ctVO7kMB7TM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ir5nyWS+JzMaOpsFPP407oKl4hddjF0tXzZYzLE5xK22VnIlqLdh1rxLrf5C/eKln
	 302o4YMFVZB2Sw762KMS4pOsSpcZDiSmYuSfOCdF6dmGNiJYrHHfMw0ORWZU6n5izG
	 XbT9wGPSSKpxOAlMRaAlv6zlPwY2nYKAT/i5gTnZ8+yJHEiJjcSzMWt54PRxaVb2QX
	 qDUSmr1JL9xWUOONWKddkB/mPr0l5DmZb0H+jnQ6gGGu0QkAqiiHVLO0dzyh/h+PzV
	 zOzddRsmqQXKmhCDPAd06alwtyW1p43qxZdniw1Jx1Zsy7//UoRSU/HUfHiN7Jx/Ov
	 WG37sx5eaTBWg==
Message-ID: <b05ad9b5-f072-4faf-b6f2-2ec341917742@kernel.org>
Date: Tue, 18 Jun 2024 08:18:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/7] ping: use sk_skb_reason_drop to free rx
 packets
To: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Neil Horman <nhorman@tuxdriver.com>, linux-trace-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <cover.1718642328.git.yan@cloudflare.com>
 <3b6f00440b880559fa3918504d85521702921e3b.1718642328.git.yan@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <3b6f00440b880559fa3918504d85521702921e3b.1718642328.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/06/2024 20.09, Yan Zhai wrote:
> Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
> socket to the tracepoint.
> 
> Signed-off-by: Yan Zhai<yan@cloudflare.com>
> ---
>   net/ipv4/ping.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

