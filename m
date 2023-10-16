Return-Path: <netdev+bounces-41373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68067CAB31
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA932814A4
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B228DBB;
	Mon, 16 Oct 2023 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG1OvhCS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC471CAAD
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA46C433C7;
	Mon, 16 Oct 2023 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697465877;
	bh=vG5dUiaoYpNcLFNAh/ByVOdSrpjZW8Cfq1lBFKNYtSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UG1OvhCSuO7NSxwdw0CmsE1JEnaiDqPvtIVyLV80H9TWBhu4m5CfiNjJSvimHtQDk
	 +eApjR4jM5WrRlLF1CcsOS/92VdHmG4jnLeCL3vjCO4cSiS0l25t4BltBT8H+R4X93
	 YXFzyCRJ6hEkMxY01yr0oU4iqZnoH+e9rfD5hmMeQdy8lnWE04cNRedphcowScEtJ7
	 pywA0opOpQvDGxpUdHScmTXRZg6hfI3nA+jaDAwAwEA2lIsiosYicYr8+33x3Rxy3n
	 qwTzL659/tp9VrDSPsUXyDIWz2rf2Qw5atk7IFtkEZDsVJ5D6YIez/dXPURd7ksxIT
	 ZEphC9JVXNpEA==
Date: Mon, 16 Oct 2023 07:17:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Come On Now <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231016071756.4ac5b865@kernel.org>
In-Reply-To: <20231016095321.4xzKQ5Cd@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
	<20231004154609.6007f1a0@kernel.org>
	<20231007155957.aPo0ImuG@linutronix.de>
	<20231009180937.2afdc4c1@kernel.org>
	<20231016095321.4xzKQ5Cd@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 11:53:21 +0200 Sebastian Andrzej Siewior wrote:
> > Do we have reason to believe nobody uses RPS?  
> 
> Not sure what you relate to. I would assume that RPS is used in general
> on actual devices and not on loopback where backlog is used. But it is
> just an assumption.
> The performance drop, which I observed with RPS and stress-ng --udp, is
> within the same range with threads and IPIs (based on memory). I can
> re-run the test and provide actual numbers if you want.

I was asking about RPS because with your current series RPS processing
is forced into threads. IDK how well you can simulate the kind of
workload which requires RPS. I've seen it used mostly on proxyies 
and gateways. For proxies Meta's experiments with threaded NAPI show
regressions across the board. So "force-threading" RPS will most likely
also cause regressions.

