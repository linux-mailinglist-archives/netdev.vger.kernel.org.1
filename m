Return-Path: <netdev+bounces-104716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22C90E175
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF1C1C22776
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465EE208AD;
	Wed, 19 Jun 2024 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8yEnALN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D1288DB;
	Wed, 19 Jun 2024 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762220; cv=none; b=lqAbeIYzf1sSJ5cVXJ+oXqvUVb4lW4DXDEwepsOdplwW5oThV+5CIRFMyfW7cJ3TCsndtJV4NeRx5aiTFybjVU3Ru+VQAd3jLaU2GAju9Sw5pOPp90dMAB+D9iNJah88A9KUFcB++OpuMdKo31a3Es8eIinWpHdAixrRBYsQAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762220; c=relaxed/simple;
	bh=qM9g82aAhHcHWHHDXwq112jmtCMvM2Ed7Rh0QLbeGA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYQnddcSQv4oVc2OXlH+w2GTS8kRA7l7BT5cJm1apOor39hcrgy3stxmSNfeCHyWLVZ55Z/7y+OB26VUSC+ExdkxJ62jINr4slHpibSPiTOhFZFwL9YZf1xA2sUE7vSL2a+q+YMxXWY4D8JpmvVHP80YDvJlYf8e4+ef41WAftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8yEnALN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E2BC3277B;
	Wed, 19 Jun 2024 01:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718762219;
	bh=qM9g82aAhHcHWHHDXwq112jmtCMvM2Ed7Rh0QLbeGA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A8yEnALN77pk70UrvY9lkBYxSaeNngaLlYSuGWoYFo8isFTQkvJ9UYJeAty34XdHs
	 l+3ALNkjZcnCMJ+gb0b8aeUB3NZ1fQMBfmi66QP9QjRIY/f4o5tVg5FloD7+MhUpbd
	 xmqTr7DXQoEaGDwJTe/HFYLHxXZaeacASGiN6VHMNhAtXo+TEyVvmGylDUiyxmZJ1v
	 uh7SZJBy8itlGYRqoTZwX9kDfMIBAA8/sGTH5jJGVmwHs7vyguf2GOMq9Q43SZ5Jjl
	 Por0H1R69QStXHze2xAYQFqhOf7ADG3UHdpE7aRTfGkP5IPJXwu++0sQog+P2bq/XR
	 ZxiHovdwPCFrg==
Date: Tue, 18 Jun 2024 18:56:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Daniel Bristot de Oliveira <bristot@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>
Subject: Re: [PATCH v7 net-next 00/15] locking: Introduce nested-BH locking.
Message-ID: <20240618185657.32929506@kernel.org>
In-Reply-To: <20240618072526.379909-1-bigeasy@linutronix.de>
References: <20240618072526.379909-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 09:13:16 +0200 Sebastian Andrzej Siewior wrote:
> Disabling bottoms halves acts as per-CPU BKL. On PREEMPT_RT code within
> local_bh_disable() section remains preemtible. As a result high prior
> tasks (or threaded interrupts) will be blocked by lower-prio task (or
> threaded interrupts) which are long running which includes softirq
> sections.

Trivial conflict on patch 8 but enough to make the build bots give up..
Please rebase?

