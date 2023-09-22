Return-Path: <netdev+bounces-35690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52B47AAA34
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5E344282F74
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD00B18040;
	Fri, 22 Sep 2023 07:26:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BF8179B6
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 07:26:21 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A17DE6A;
	Fri, 22 Sep 2023 00:26:19 -0700 (PDT)
Date: Fri, 22 Sep 2023 09:26:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695367577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6gtB/j1aJ/v54tV0PTQ7LW78TWmuTnW88E+MNr8Zzbc=;
	b=zAUpq1Z6lwsBmAdroV/pNRDfHu6BTjZHV09Fy6xTJusAK3k7MO2EJvsNjmSiv3KmzrqYW0
	U7pxSAkcHEXMuNJJcmUsezuKhRg79S/9/g9tVXUSGTQNaNLyDfyj599Tk0EoJmQ+PaO0Ej
	xJKVkXU+UlFHTLcHkwWgatqf3GURoLkZ9+3lwyExyXwh/C0dYvyJKJskNaCUXB5iXjOeyc
	zcL9n+IK6RpvdCZfNljxykIJxZ6Vu4v8nH0z6FO0ZaEKsREOCq//KbohzBzZd/nNFx77de
	FNJd8noV/kI9Vbv3LYyZ6EMm7hibZKlCVIp3dmteJ88uOYPqWwhMmEtGCsIDgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695367577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6gtB/j1aJ/v54tV0PTQ7LW78TWmuTnW88E+MNr8Zzbc=;
	b=7Bc/A7kODDY2eUV5JhgyXJ+mE5qj9cz/GAe83+rGVd7TroDCdTEyh1lyIJeJCu04Wxkny6
	Sein6bbaGP37xBCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ferenc Fejes <primalgamer@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230922072614.aT8vDgAy@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-2-bigeasy@linutronix.de>
 <0a842574fd0acc113ef925c48d2ad9e67aa0e101.camel@redhat.com>
 <20230920155754.KzYGXMWh@linutronix.de>
 <2eb9af65d098bb54ed54178d7269e7197d6de5a0.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2eb9af65d098bb54ed54178d7269e7197d6de5a0.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-21 12:41:33 [+0200], Ferenc Fejes wrote:
> Hi!
Hi,

> > If we could somehow define a DoS condition once we are overwhelmed
> > with
> > packets, then we could act on it and throttle it. This in turn would
> > allow a SCHED_FIFO priority without the fear of a lockup if the
> > system
> > is flooded with packets.
> 
> Can this be avoided if we reuse gro_flush_timeout as the maximum time
> the NAPI thread can be scheduled?

First your run time needs to be accounted somehow. I observed that some
cards/ systems tend pull often a few packets on each interrupt and
others pull more packets at a time.
So probably packets in a time frame would make sense. Maybe even plus
packet size assuming larger packets require more processing time.

If you run at SCHED_OTHER you don't care, you can keep it running. With
SCHED_FIFO you would need to decide:
- how much is too much
- what to do once you reach too much

Once you reach too much you could:
- change the scheduling policy to SCHED_OTHER and keep going until it is
  no longer "too much in a given period" so you can flip it back.

- stop processing for a period of time and risk packet loss which is
  defined as better than to continue.

- pulling packets and dropping them instead of injecting into the stack.
  Using xdp/ebpf might be easy since there is an API for that. One could
  even peek at packets to decide if some can be kept.
  This would rely on the fact that the system can do this quick enough
  under a DoS condition.

> 
> Ferenc

Sebastian

