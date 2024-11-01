Return-Path: <netdev+bounces-140839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9899B877D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A041C20EB7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43937B;
	Fri,  1 Nov 2024 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwIN34ml"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AD3224;
	Fri,  1 Nov 2024 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419470; cv=none; b=eIUu+NHSJ1qVuqOlCA3W0XXpUwpd/zybiHd/i1eVA6YAsPFflja7J9e8OuhcWcZu4C+ZXEwdBQzj7PzOdQIJJkaveQUccQzwjR2FrQV1UjES5n/1bYV9maIsJQwBkp8vaSstUh/AbDPc2T9qY5PAvc1lh/lKM0HZiHRUHwhaokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419470; c=relaxed/simple;
	bh=5EIuy6X4D4fkJiwOgPsn6cbZt+cCjkpuJdNK+pbCoWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HC3ZWI291J5p+94RT11rIBB47Gceq8cP0k+lCwIIg6Tf1jOlV07Fh3Vz2Rd4RUQm91dpfyrVjQBMiZAEcH/+ix1ggmIIp3oLKQ4ywUqDGome3wPqCGFMYB0pwj65+83a5o4BinOs/f5GSZd/9GuxNujQjTY3O2fy8ab/sTrnvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwIN34ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA8AC4CEC3;
	Fri,  1 Nov 2024 00:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730419470;
	bh=5EIuy6X4D4fkJiwOgPsn6cbZt+cCjkpuJdNK+pbCoWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwIN34ml1q4mjRNWon0RI01TNb0vikJmaeuNbl9uB3bj4ABqYcNx3fJmxhG5zN+Xq
	 WqmPirnAPprHdjM50pkY5HKEj667cU07SjiltpHMxaYy/kTxNxd1goTnQNd+pH0ijb
	 WFARvv/KQvwhB+gdv3t6BQyr4spgRYk9l1XMfxZtqpsb7J1vVnAVuBATf5CDmn32Le
	 bY8x6D92LU8iIVdNdDbY8K+u+tATl3OZCclsTKEaZ7yQq+tuotybytQ3NZh5sM4kN/
	 4qPprUclXSzv1M/63sv/zYv6LKDFXHj6R6OEzMqb6iqZqauiSOqGklnZ2gkWRFRq4S
	 AhwHI8SUzf+hA==
Date: Thu, 31 Oct 2024 17:04:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Akinobu Mita <akinobu.mita@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, kernel-team@meta.com, Thomas Huth
 <thuth@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, Steven Rostedt <rostedt@goodmis.org>,
 Xiongwei Song <xiongwei.song@windriver.com>, Mina Almasry
 <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241031170428.27c1f26a@kernel.org>
In-Reply-To: <20241031-hallowed-bizarre-curassow-ea16cc@leitao>
References: <20241023113819.3395078-1-leitao@debian.org>
	<20241030173152.0349b466@kernel.org>
	<20241031-hallowed-bizarre-curassow-ea16cc@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 02:41:18 -0700 Breno Leitao wrote:
> > Should we mention here that KASAN or some such is needed to catch 
> > the bugs? Chances are the resulting UAF will not crash and go unnoticed
> > without KASAN.  
> 
> What about adding something like this in the fail_skb_realloc section in
> the fault-injection.rst file:

SG

> > the buffer needs to be null terminated, like:
> > 
> > skb_realloc.devname[IFNAMSIZ - 1] = '\0';
> > 
> > no?  
> 
> Yes, but isn't it what the next line do, with strim()?

I could be wrong, but looks like first thing strim does is call strlen()

