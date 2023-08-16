Return-Path: <netdev+bounces-28127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2477E4F5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870BD1C210AB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7D156E1;
	Wed, 16 Aug 2023 15:22:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76E10957
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:22:25 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2D01BF8;
	Wed, 16 Aug 2023 08:22:20 -0700 (PDT)
Date: Wed, 16 Aug 2023 17:22:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692199338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7IUEQHzihCH8EQTTWoAYq9Za5pGutJky5EpXbKbfMU=;
	b=hRaGhTAqOqQipkzJSecPXLeVPOVhZMn4h3tA6BogOquSru5AXq2M/eBDB2TpZejeIPKoMR
	nvfPEZqJp6o/cQGoLCmJ+uYHWS+hMS4gMs2NoZ+pATGoxho+S9KRJHxfUJNNik6HEmzGwq
	3ZbUyYEbMdSaSoKTSOJQ+ALwR802pYXFu5mDdcxore7FSI+HsYz2EKZfvDzdoFbagItnwA
	vWi/FAWQFWE6EILqyY5mMK9WOM3ewcwWL3ax8Ol3L7DgYFrY7gZ5TDwYwuC2PicOjuKm4V
	h8hylgWKXpUImrDkeilSfuHyF7XyCyNPkW3mx6QQMGfCjuYYSN/SWXOyqo3r5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692199338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7IUEQHzihCH8EQTTWoAYq9Za5pGutJky5EpXbKbfMU=;
	b=5UAJOfScB/u8xi02CM776lXg6xRl/nTPYpsAF9Ppg/arFnKOqazgFXW8zEOuBtoF8AgPHI
	zwqiTQO83nBSgaBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC PATCH 2/2] softirq: Drop the warning from
 do_softirq_post_smp_call_flush().
Message-ID: <20230816152216.Gc_KwqZq@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-3-bigeasy@linutronix.de>
 <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
 <d1b510a0-139a-285d-1a80-2592ea98b0d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1b510a0-139a-285d-1a80-2592ea98b0d6@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-16 16:48:56 [+0200], Jesper Dangaard Brouer wrote:
> I'm no expert in sched / softirq area of the kernel, but I'm willing to help
> out testing different solution that can regain the "overload" protection
> e.g. avoid packet processing "falls-of-an-edge" (and thus opens the kernel
> to be DDoS'ed easily).
> Is this what Sebastian's patchset does?

I was going to respond but didn't know what so far.
Can you figure out if you are using backlog or not. If you do, could try
my patch. If not could you try to enable napi-thread and see?
Either way I will re-read it again.

Sebastian

