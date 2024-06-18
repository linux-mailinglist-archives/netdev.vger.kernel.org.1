Return-Path: <netdev+bounces-104354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B4490C383
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31CB282A3D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E153BBD7;
	Tue, 18 Jun 2024 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzHTbPFf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A3D3A1DD;
	Tue, 18 Jun 2024 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691858; cv=none; b=WzZTJRdequm5v31SzAvL+znJIB26pq7YCUx8GV1aJin+WeXxQGVn+WtRSRixOIACSwmgSJOph8yTQI9FaEhiTM2jWSs7v3l/Z0YtguZglzW0Uz3U9phMUw+hHPxxr3Mk1ILXWu2OJjEovNUfEg1RMhUj7PR9MFHwkPtrAZByE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691858; c=relaxed/simple;
	bh=Pfy2h/fLnj/pbjC1iNg4x7JakIdp/BscD/OkbXbt+kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kH+2y7VQ0B6+T1zuQb4QMRI8poYxHA7KOK8LnUiZ7zLQEHnMrQ0Ofq6oV2gys+MQTEalA5lFAvUY3xLoz9mZ1V0H5cWpcE17Y4BDOVb++FUqt9hOmMuk89gmD0Pk9EzSJwPxQ6C+nV1k+79SfYOEKuOdxvIfl/uOFXz0b+hwEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzHTbPFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65814C3277B;
	Tue, 18 Jun 2024 06:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718691858;
	bh=Pfy2h/fLnj/pbjC1iNg4x7JakIdp/BscD/OkbXbt+kM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SzHTbPFfjjV1x5MIvbTUkxqDLYYDDZ6xtf+e91nTr67/4UYDmSaPTt7leMQQrt6rk
	 WmFx7RW8qLSesBHJ9V8+W7MD65ZRHRVWEHIUAM2J59h0dBzm5QlaSoPUnBFvDjobgK
	 Ad1QpG0sHoWIC8EwI0AXgpOO2Nshastj7J05pzUpxZU7wmiY6y/pcw5sJikeE8FzVR
	 Lt6fpuAPARMGnOowKPq/tNLdObWKdERQiSWLx2Gv+KggOzRb+9/y4SUDUVUyXxv55Z
	 v2OywoDY4a37nJHBqUK8NzyAidb7tZa7LOqd74v5XfZINoUO/HgZPxAFUBpHLHUSmo
	 3fOCMs0YtMUrw==
Message-ID: <90a32e35-ba88-4e39-b7a1-fa3792199ce7@kernel.org>
Date: Tue, 18 Jun 2024 08:24:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 7/7] af_packet: use sk_skb_reason_drop to free
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
 <5c336e8da85ce9940e75b9090b296cc7fd727cad.1718642328.git.yan@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <5c336e8da85ce9940e75b9090b296cc7fd727cad.1718642328.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/06/2024 20.09, Yan Zhai wrote:
> Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
> socket to the tracepoint.
> 
> Reported-by: kernel test robot<lkp@intel.com>
> Closes:https://lore.kernel.org/r/202406011859.Aacus8GV-lkp@intel.com/
> Signed-off-by: Yan Zhai<yan@cloudflare.com>
> ---
> v2->v3: fixed uninitialized sk, added missing report tags.
> ---
>   net/packet/af_packet.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

