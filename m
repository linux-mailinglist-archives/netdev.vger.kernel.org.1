Return-Path: <netdev+bounces-38808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE27BC8FB
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A7F1C20837
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF6D31A86;
	Sat,  7 Oct 2023 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEMFqg5h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7Sxfo5o"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447FB2E63E
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 16:00:01 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B51BA;
	Sat,  7 Oct 2023 09:00:00 -0700 (PDT)
Date: Sat, 7 Oct 2023 17:59:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1696694398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35TTRveXU2Ka7eoxo3UirDZ5E25/uzkse4gLA2aaRG4=;
	b=SEMFqg5hGSJNguDX9id9Wo/3ADKEUNIAazqz0QWmfUT1VUAk426yEbYBuuu2Bsck34Rxvr
	JBi6/IuLmVvwtOb9YRX7mMc4aDb80Hju6TUdLWsdEoh6WFePS6Fqv1zMmxjXWOtOQ/yPLI
	ANFhdYIkd6HTERjGJhCPHkKLNAK9mrw5oy9w7VQEBOvZ7jOmJk5NVIBFoOTR8YIUKnThqq
	+2alK5zWoRgyvDZrV+oq3aKZKRKuPIRKUbABrm3PK1nhVfck/BGxxv0Z6eGvBH1DPOoRqD
	gwTCdeNtJktA0Z0MyZHITjpFnERhuXaL0xvRSOgoAhwvrHcdA33Tv2I0VOVWfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1696694398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35TTRveXU2Ka7eoxo3UirDZ5E25/uzkse4gLA2aaRG4=;
	b=v7Sxfo5oPzPYHqoTaT2fz2jGOvxx9dP2ovpzBpe0JfddaRFWxWMUYP3UKiMF2bZldMd4FH
	kibF+uyqJjeMANAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231007155957.aPo0ImuG@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
 <20231004154609.6007f1a0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004154609.6007f1a0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-04 15:46:09 [-0700], Jakub Kicinski wrote:
> On Fri, 29 Sep 2023 18:20:18 +0200 Sebastian Andrzej Siewior wrote:
> >    - Patch #2 has been removed. Removing the warning is still an option.
> > 
> >    - There are two patches in the series:
> >      - Patch #1 always creates backlog threads
> >      - Patch #2 creates the backlog threads if requested at boot time,
> >        mandatory on PREEMPT_RT.
> >      So it is either or and I wanted to show how both look like.
> > 
> >    - The kernel test robot reported a performance regression with
> >      loopback (stress-ng --udp X --udp-ops Y) against the RFC version.
> >      The regression is now avoided by using local-NAPI if backlog
> >      processing is requested on the local CPU.
> 
> Not what we asked for, and it doesn't apply.

Apologies if I misunderstood. You said to make it optional which I did
with the static key in the second patch of this series. The first patch
is indeed not what we talked about I just to show what it would look
like now that there is no "delay" for backlog-NAPI on the local CPU.

If the optional part is okay then I can repost only that patch against
current net-next.

Sebastian

