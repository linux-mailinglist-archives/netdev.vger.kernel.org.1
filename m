Return-Path: <netdev+bounces-104351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E6E90C379
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38563B20EC2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE291288BD;
	Tue, 18 Jun 2024 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBBV/Sgf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1273FC0E;
	Tue, 18 Jun 2024 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691702; cv=none; b=Zt1Jh9020ZQksktpaRwzSogmovUkhp962iCCcqKHT1K2/l7ZVebbi5P6B7LaaWZxLSzcdJ2vRv+puqfMDA1eXnTkCN5liAnOn0stZH3TUgkyNrRDWtvEZTu1UX+obu1UVIB05KgsEanhy74QdZ+w2za5XtLIowm1dQdbeylkTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691702; c=relaxed/simple;
	bh=N5xX8FWgiQuVKn4hXY2q65aXLG46YOAIRaccl2TMTRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iot7/vlt36pxw4zUuZjJdUXIEm730gHxa16p9ga4xklkgpFg0xuRcOIc48zFeeWQvkB4w0Y0xBr34BODxCxcpcMxeEPggHybyMGLSOXs3WKfhbSMR2Qtn9TQwEkDYSnv7jgkoWMReuquIwL213/826/PlaivBq5Kn1l1Atm/geI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBBV/Sgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B9AC3277B;
	Tue, 18 Jun 2024 06:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718691702;
	bh=N5xX8FWgiQuVKn4hXY2q65aXLG46YOAIRaccl2TMTRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JBBV/Sgf5T3q3av88XVG4MmH3+KX9AKTxpBZqCdg7PRRvn7qaGGE6F6CawAKwBkLz
	 i1+lAUKRucccjWI3HHoy3XFVekBF2ikvG4AWQbRMOxpixyPFDccPF7kaE3lTc0hFck
	 RKAEFreGCZ4NIdggxowG7MbADkU7XXUioO4099EFFaaYuz3LwFr+mnrtBlx3JL7Es5
	 AzWr5N6qVZA1S7nbSgKETFxvDpbFpTkGNT9QlIEM7Qwn36QigAkPnOAlojxoi6fjKg
	 hl8x0XPd8r+GgiAjRDRx3Za9HBpp+sjKA9O1bNZeasKzPHXnI4L67U72R7k9yBKyQg
	 L5VurwIHadtxQ==
Message-ID: <4bf3e406-4e7b-499b-b53e-22c52f9f2029@kernel.org>
Date: Tue, 18 Jun 2024 08:21:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/7] tcp: use sk_skb_reason_drop to free rx
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
 <f1ba64da683281a4c015095b3afd7f7153d1d034.1718642328.git.yan@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <f1ba64da683281a4c015095b3afd7f7153d1d034.1718642328.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/06/2024 20.09, Yan Zhai wrote:
> Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
> socket to the tracepoint.
> 
> Reported-by: kernel test robot<lkp@intel.com>
> Closes:https://lore.kernel.org/r/202406011539.jhwBd7DX-lkp@intel.com/
> Signed-off-by: Yan Zhai<yan@cloudflare.com>
> ---
> v2->v3: added missing report tags
> ---
>   net/ipv4/syncookies.c | 2 +-
>   net/ipv4/tcp_input.c  | 2 +-
>   net/ipv4/tcp_ipv4.c   | 6 +++---
>   net/ipv6/syncookies.c | 2 +-
>   net/ipv6/tcp_ipv6.c   | 6 +++---
>   5 files changed, 9 insertions(+), 9 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

