Return-Path: <netdev+bounces-104353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C0490C380
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD62841CD
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887F13BB59;
	Tue, 18 Jun 2024 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShTFK2ky"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95761FCD;
	Tue, 18 Jun 2024 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691753; cv=none; b=ASD67Ee3jy5Xek40ljzwki1f5d5OnRM6XTHcEYnFpFtg0Mu3SbSjSO6r/ee9PMWsiJO0TocEQym5igmZvFdtkQAu0hSjwHebMAIg8KTUKRbH/ZljyklJxCcLo9bVCeM+sEV+VKDpsw6rCTQiK7FI1SvDc98C6JPmioBFfttcBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691753; c=relaxed/simple;
	bh=pDX//bLAcHAg6HmQwDE7e1+KuMUVWxAU5Qjmk/rLAd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmtxhcKtpFCeXzcbM+AfY0x3gI+91lRo+GHK9Syl/rmTw/fIpouQgcpD7Yi4oJYu7qdHga3QsJoC2vO1cMNDwfYRbn099XesSJeq7ELm5Fidv5us3NuRklRRcfvGLDIwys5OgZbHUXrv3QT8SflZDopi/PD5nX3NwrdDRyAbsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShTFK2ky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83627C3277B;
	Tue, 18 Jun 2024 06:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718691753;
	bh=pDX//bLAcHAg6HmQwDE7e1+KuMUVWxAU5Qjmk/rLAd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ShTFK2kyHyzgBzZFR+lwExVy3lssmtDosQdA4uekjXuhiIeyAAG0j0g3X01T3v40n
	 468F30pLbmy7o+8OBM+HN3ggALhPX/dtn5HkpNeLAqZoTc2AF7gs/Ay+JeSa1PgLuY
	 A/xXFphj+GGtjaRehnAlUq4BSGv296Sjr74rSL+qYEtanBsCluwx7WDxskVV1wLYFA
	 AaegAsmG6/lJAEteBBYkZw9lSlHFVIE4hPzLlzFUuhAlEZIBDhWk73v/oYdK3BZ9og
	 rJEHN/i74HFLEuNSAH9FiJ/v0ws/h5gUDIMJF6UKrCotVdlOBDREuu4YQ1E5Kltn7C
	 b0GBUfJgOqFFA==
Message-ID: <550206ce-6b8e-4733-b7c5-bf1593644400@kernel.org>
Date: Tue, 18 Jun 2024 08:22:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/7] udp: use sk_skb_reason_drop to free rx
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
 <0dca67a158f2a3bed1a2cee3bc3582b34af70252.1718642328.git.yan@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <0dca67a158f2a3bed1a2cee3bc3582b34af70252.1718642328.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/06/2024 20.09, Yan Zhai wrote:
> Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
> socket to the tracepoint.
> 
> Reported-by: kernel test robot<lkp@intel.com>
> Closes:https://lore.kernel.org/r/202406011751.NpVN0sSk-lkp@intel.com/
> Signed-off-by: Yan Zhai<yan@cloudflare.com>
> ---
> v2->v3: added missing report tags
> ---
>   net/ipv4/udp.c | 10 +++++-----
>   net/ipv6/udp.c | 10 +++++-----
>   2 files changed, 10 insertions(+), 10 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

