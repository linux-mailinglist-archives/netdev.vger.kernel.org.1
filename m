Return-Path: <netdev+bounces-41384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740977CAC5E
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5A42810D8
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9982C266B7;
	Mon, 16 Oct 2023 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="08pEtaXT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/SJFTM2f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1628DBA
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:53:42 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A221AB;
	Mon, 16 Oct 2023 07:53:41 -0700 (PDT)
Date: Mon, 16 Oct 2023 16:53:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1697468019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYxGWux4bz1oifYiW1ESfMnhECuBhrHUbAQIAzCsCdk=;
	b=08pEtaXTRgkjC5/In32LsLPPD1O/UMtjzGU3yQbKnybq0ffF1HWcJJSjJQ+e+jU1a4YlW/
	hknEptlxGFu/DVVItuh+hgpEowWjIuqGuAFBS9l11L+oIXHjXHbr/CPA41RXSGWV89ub9B
	2ak0ggP3XdjI/CAUsOpxtigupxXn5Fv1/aWYIEhjtfnJNph9b0uv3iW4YRB/3sV8kbxOHM
	B6ybeDJzvdvMWesGxnSc6ZJP0FQzJE1BgWh/K5wI5BO7NeBIcQ+IR4zMusGe/we0rPycts
	JgGZq+iDpVNIR3adchWnrgFHRwey5pFMbJ3CUbGOAy61nQdoimv6G7XIGp8UYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1697468019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYxGWux4bz1oifYiW1ESfMnhECuBhrHUbAQIAzCsCdk=;
	b=/SJFTM2fCbawcyZjIS46roZClWxcsl/WYkcyBiBYwergMh5/z2qQ9OQLjwxZJx1Kmb7PIU
	jhFqf5qDSa1ocgAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>,
	Wander Lairson Costa <wander@redhat.com>, juri.lelli@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Come On Now <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231016145337.4ZIt_sqL@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
 <20231004154609.6007f1a0@kernel.org>
 <20231007155957.aPo0ImuG@linutronix.de>
 <20231009180937.2afdc4c1@kernel.org>
 <20231016095321.4xzKQ5Cd@linutronix.de>
 <20231016071756.4ac5b865@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231016071756.4ac5b865@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-16 07:17:56 [-0700], Jakub Kicinski wrote:
> On Mon, 16 Oct 2023 11:53:21 +0200 Sebastian Andrzej Siewior wrote:
> > > Do we have reason to believe nobody uses RPS?  
> > 
> > Not sure what you relate to. I would assume that RPS is used in general
> > on actual devices and not on loopback where backlog is used. But it is
> > just an assumption.
> > The performance drop, which I observed with RPS and stress-ng --udp, is
> > within the same range with threads and IPIs (based on memory). I can
> > re-run the test and provide actual numbers if you want.
> 
> I was asking about RPS because with your current series RPS processing
> is forced into threads. IDK how well you can simulate the kind of
> workload which requires RPS. I've seen it used mostly on proxyies 
> and gateways. For proxies Meta's experiments with threaded NAPI show
> regressions across the board. So "force-threading" RPS will most likely
> also cause regressions.

Understood.

Wandere/ Juri: Do you have any benchmark/ workload where you would see
whether RPS with IPI (now) vs RPS (this patch) shows any regression?

Sebastian

