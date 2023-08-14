Return-Path: <netdev+bounces-27434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325ED77BFB8
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EA72811AA
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08695CA57;
	Mon, 14 Aug 2023 18:24:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ADAC140
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 18:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4621FC433C8;
	Mon, 14 Aug 2023 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692037462;
	bh=mTsh7sEfcY4Xi6rqdzYQ2cR/F9LjcZ/p4SiMZsPCS6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gLK/rc3Url0zWUdgLDCCDxZ4ECT2Q1IbZ2RAqHOxGpPW8T2x6d8t9s0JwyHngNoem
	 7UOdSNe5W6eCl2iloAwQgxIS3i5/LSjEuAjVzwvxuFSzXlpZW2eCYrp/RA5N0WZ5Df
	 uOPMnGPWWEodskE/GQCKoXPwcPJA8jlIixWWG409LfX5IJPIGNEnpNtXCtsiVDDCjY
	 Xv4VrJ5qt+fAAns6JDscC/GidtXYH2kXPXQMI2T8TuYKXLx8694FhZylhhtr4bH2Fy
	 iokx4Y3ctDfBmVee65Bhdud84ikHNGNmxjgBcdvnXeB17WJv6UBZcJHjGn+OcGQEVf
	 CMBXgSOJu9WcQ==
Date: Mon, 14 Aug 2023 11:24:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230814112421.5a2fa4f6@kernel.org>
In-Reply-To: <20230814093528.117342-1-bigeasy@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Aug 2023 11:35:26 +0200 Sebastian Andrzej Siewior wrote:
> The RPS code and "deferred skb free" both send IPI/ function call
> to a remote CPU in which a softirq is raised. This leads to a warning on
> PREEMPT_RT because raising softiqrs from function call led to undesired
> behaviour in the past. I had duct tape in RT for the "deferred skb free"
> and Wander Lairson Costa reported the RPS case.

Could you find a less invasive solution?
backlog is used by veth == most containerized environments.
This change has a very high risk of regression for a lot of people.

