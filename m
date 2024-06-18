Return-Path: <netdev+bounces-104349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CEC90C371
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB73C1F20F9C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52350284;
	Tue, 18 Jun 2024 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfNRQvN/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D051BF38;
	Tue, 18 Jun 2024 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691579; cv=none; b=MCbX3He2LEcd/O8o+tHkLuRffmBywT8R0cPH2Gh6MeFSKlxYW5Y76PB/ZbNsotCjlbRwjR4ye5ibIlGY2QLjuUpDthvaCsZmYsnXMTg3TjuwVtbZmEZ0QK38TVgoqSbaxaqsu0jqUt4Ul6GZV7FVRGyKScVEu4pbcsu5qoBGMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691579; c=relaxed/simple;
	bh=TaxCc2kuVzHcn7jCGFXbdu1A/KPAE4+1fk25XYQ5b/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJgxo5QVO6iIZ4BkRBTaPpGEqjNe8cP0Ive9+wu4ayL9jEDCoGNTCUC1I7Et0IGJlCrkWD+Rv0SXpxlRXMDAtEwehFNUewKqQ0KDJX+SXJ/qOSAB2cZOmPDFQTrERdNvPp1ZG8w0SYoAAlJBYu+1dVPNa8/On+tIoA4UFB24U9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfNRQvN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0349C3277B;
	Tue, 18 Jun 2024 06:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718691579;
	bh=TaxCc2kuVzHcn7jCGFXbdu1A/KPAE4+1fk25XYQ5b/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UfNRQvN/Q3g2KNCM4rT4wkOnS6uXnhBLpctYUxKhnzdg5kh8Jx70GJLHiBQVUHDeb
	 uCtT9A/M42m0DkOI4XrmugkOTl9ibRJnl2PZ/ntA1Ylic0+6m+CQBzhi52V9lali7E
	 L5qKVIqxc+bZqahgYzwkPxULLGLawlT4V9Z6zzTxh3NI9evP4vWz/m5NLH1iRdKwG0
	 g7v7O7c4gd/h9vilcmNvbE8a/yB+cCGb+/0sAckzIjtJT4dAr5KVz6k+4OH3ID5F5Z
	 +SyallfVSG5njXCSzLPxxNfKgIWB2mdkwELqcp+q/vqUUC0Xt5Gw3lkyp0sYyOZ1lk
	 POD5W5odaqHFg==
Message-ID: <bc52b5f1-362d-463e-bbd4-5acaa5fa5d5a@kernel.org>
Date: Tue, 18 Jun 2024 08:19:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/7] net: raw: use sk_skb_reason_drop to free
 rx packets
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
 <ecc59c738bbe913aa031c7b37cd78d9fb06096fa.1718642328.git.yan@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <ecc59c738bbe913aa031c7b37cd78d9fb06096fa.1718642328.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/06/2024 20.09, Yan Zhai wrote:
> Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
> socket to the tracepoint.
> 
> Signed-off-by: Yan Zhai<yan@cloudflare.com>
> ---
>   net/ipv4/raw.c | 4 ++--
>   net/ipv6/raw.c | 8 ++++----
>   2 files changed, 6 insertions(+), 6 deletions(-)


Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

