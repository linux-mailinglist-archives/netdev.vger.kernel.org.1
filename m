Return-Path: <netdev+bounces-17015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2090774FD19
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 04:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60282816A0
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B0375;
	Wed, 12 Jul 2023 02:36:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069F182
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 02:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31D1C433C8;
	Wed, 12 Jul 2023 02:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689129373;
	bh=VYr7MuBjRdIhnSEWu/wTQUTN1+a4AfWfJ0ZfmkkFI08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sjsuANP96xKKQMLvqafjbftM4PlZqLC15IbHO1zlGlRmW8ed/QEKj5cYI/1Yu14PL
	 XqcJeZf/NuQ09kqrnjBmI9q8cmHv3Z6TQNmXdJ2eTLW2IqcuS7d7rqcjL6C68XgKFN
	 u91sQZKvXYfvIVWTGtAf29oW5BOsLKyud52WBAwwJ3+4qQ57uoosbmnZHf+1vPDBMN
	 NRq/W0Usk9+oczI8uOj6oQmQwmEJdwxlE9+vy6wTOWkQ1CrhMOJ9zERtbZ4SMiaO0S
	 nVhC2GgHoqTbBPaKu1Aca3JDIPn1/jNNXsTCgKqIlmTd92CSOIIR9szT4vERNY44Tn
	 73preDOI8+uug==
Date: Tue, 11 Jul 2023 19:36:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Babrou <ivan@cloudflare.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 David Ahern <dsahern@kernel.org>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for
 tcp_listen_queue_drop
Message-ID: <20230711193612.22c9bc04@kernel.org>
In-Reply-To: <20230711043453.64095-1-ivan@cloudflare.com>
References: <20230711043453.64095-1-ivan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 21:34:52 -0700 Ivan Babrou wrote:
> There's already a way to count the overall numbers of queue overflows:
> 
>     $ sudo netstat -s | grep 'listen queue'
>     4 times the listen queue of a socket overflowed
> 
> However, it's too coarse for monitoring and alerting when a user wants to
> track errors per socket and route alerts to people responsible for those
> sockets directly. For UDP there's udp_fail_queue_rcv_skb, which fills
> a similar need for UDP sockets. This patch adds a TCP equivalent.

Makes me want to revert your recent UDP tracepoint to be honest :(
We can play whack a mole like this. You said that kfree_skb fires
too often, why is that? Maybe it's an issue of someone using
kfree_skb() when they should be using consume_skb() ?

