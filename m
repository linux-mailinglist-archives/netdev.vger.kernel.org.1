Return-Path: <netdev+bounces-198253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE3ADBB10
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EED3A9351
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E81728A1EB;
	Mon, 16 Jun 2025 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1L+5YqC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403820E007;
	Mon, 16 Jun 2025 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105106; cv=none; b=IC9mj/YJuizInpVQaNkzWn+w6hgG5pHyurcHxqBc9mQkmI2jB9NuN0B3S27H+58sABDl07tlrI+YJ1RVjfRKq07gUvVImewutUnTWuyxn7p+c/yyqAk67hf4nIJqp8QlaKvCbtm/PK8cEHei62SvGr9mXhmAw7nBNzZsqFepOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105106; c=relaxed/simple;
	bh=/MZXgXnlklMlun1yRXTlVVqUOti5H5p9f/tFG3NnfAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rt9jCyoG7RGCa5vMQ5AjmdFUW64m6yPoZ8aTXjG/8W5GorvBpbMmSqPzqRaj4x9lOPsdPZzvKPyWHRK5Rzi2Y0iruFiU4QPIkQx5afbCCAgQei0q7NyR94VTjZsHuxseWpXxJsgaMOrLTR/MaiTrngJ+Y/VyrJapVhZBqzeODWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1L+5YqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04310C4CEEA;
	Mon, 16 Jun 2025 20:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750105106;
	bh=/MZXgXnlklMlun1yRXTlVVqUOti5H5p9f/tFG3NnfAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q1L+5YqCUVTRb+sOuaFaGlDkz9czU/kPnX3LPHN2U1saqAO6c8YetXiqAzlcKYTKC
	 Q4YjUimfqO8SMT3VKuIlka4XfEQYrzO4qsWMP+r87oXMW0PicD7o1mWuRIERfQXD0R
	 mA65oZ82F5pdSY3CMBhAVOYfqJwjgn4NiNasnoAIQlhMGGpAnLZY7UJR/Tye8finGg
	 IHAxdN0qeUHBXXflfJa4hJxCSBM8QYv1ZdueB1vxq0zF+s0Jra/Ls/FVi4TDfeXyqy
	 xWVyPtx/Ni+UWM3uASdVV4J7GFMsbysREi9C6YBQlaQeoPJiHJL9uznUL+ODLALw4O
	 AYxNt4FX9kXMQ==
Date: Mon, 16 Jun 2025 13:18:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Simon Horman <horms@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH] net/tcp_ao: tracing: Hide tcp_ao events under
 CONFIG_TCP_AO
Message-ID: <20250616131825.65e1c058@kernel.org>
In-Reply-To: <20250616144718.4e8e12bf@batman.local.home>
References: <20250612094616.4222daf0@batman.local.home>
	<20250614153003.GP414686@horms.kernel.org>
	<20250616144718.4e8e12bf@batman.local.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 14:47:18 -0400 Steven Rostedt wrote:
> On Sat, 14 Jun 2025 16:30:03 +0100
> Simon Horman <horms@kernel.org> wrote:
> 
> > I agree that the events and classes covered by this #define
> > are not used unless CONFIG_TCP_AO is set. And that the small
> > number of TCP_AO related events that are left outside
> > the define are used even when CONFIG_TCP_AO is not set.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>  
> 
> Should I take this or should this go through the networking tree?

Weak preference towards networking tree. We'll apply by the end of 
the day.

