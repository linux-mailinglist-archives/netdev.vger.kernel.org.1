Return-Path: <netdev+bounces-28756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2C7807F5
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937B81C20AE4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCD417FE7;
	Fri, 18 Aug 2023 09:03:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4BE15495
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:03:47 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D485830E9;
	Fri, 18 Aug 2023 02:03:18 -0700 (PDT)
Date: Fri, 18 Aug 2023 11:03:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692349397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQkP0pemHtODz4ZTwfs9hNzhoQAZlrY+GIvOT5+K/D4=;
	b=KCAYm42tCBcBewe/qz9VwI0+j8bTKggVcI7qA1kaPqkzZG1KxydgLobI6P/Tx1ppSVIfc4
	LDsXSTyv66abg4fTjBK8NpNix0STW3DBgQm+84uHoRYQwKJj9W1Cu/N6qvF0LmfWe0vXpP
	IduLGOLq70Jyxio+0HaqpXd/WAzUjwjVak98g5hQATYXTlHcS+z3vaR5Am3CPUX9uyXAdA
	b6ATUpBU9SSpR2Lk3ksj/b1gDAQPkkDjiZENanUmcptjjLoPwK+j5sI79B79S8hocyLFak
	F1CncGvfUNNGXfb0IPs++YkYjJcv3AI6uSukeGJnqbh/8YZhN13pbKEqqN8CHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692349397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQkP0pemHtODz4ZTwfs9hNzhoQAZlrY+GIvOT5+K/D4=;
	b=m5tDM4DS+C9nPRCnWFyYbh2PblvK7fEaQGpLNC3yiJIzY87YPXXw7INeCkFG6JgKG56AD1
	kpDhCFP/+PCkw5DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230818090316.jxj-rd8f@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814112421.5a2fa4f6@kernel.org>
 <20230817131612.M_wwTr7m@linutronix.de>
 <20230817083025.2e8047fa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230817083025.2e8047fa@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-17 08:30:25 [-0700], Jakub Kicinski wrote:
> On Thu, 17 Aug 2023 15:16:12 +0200 Sebastian Andrzej Siewior wrote:
> > I've been looking at veth. In the xdp case it has its own NAPI instance.
> > In the non-xdp it uses backlog. This should be called from
> > ndo_start_xmit and user's write() so BH is off and interrupts are
> > enabled at this point and it should be kind of rate-limited. Couldn't we
> > bypass backlog in this case and deliver the packet directly to the
> > stack?
>=20
> The backlog in veth eats measurable percentage points of RPS of real
> workloads, and I think number of people looked at getting rid of it.
> So worthy goal for sure, but may not be a trivial fix.

We could separate RPS from backlog but then we still process RPS after
backlog so not sure if this gains anything. Letting veth always use its
NAPI in this case would probably do that. Not sure if it helps=E2=80=A6

> To my knowledge the two main problems are:
>  - we don't want to charge the sending application the processing for
>    both "sides" of the connection and all the switching costs.

The packet is injected by the user and softirq is served once BH gets
back to 0. So it is served within the task's context and might be
accounted on softirq/ system (might as I think it needs to be observed
by the timer interrupt for the accounting).

>  - we may get an AA deadlock if the packet ends up looping in any way.

Right, forgot about that one.

> Or at least that's what I remember the problem being at 8am in the
> morning :) Adding Daniel and Martin to CC, Paolo would also know this
> better than me but I think he's AFK for the rest of the week.

Sebastian

