Return-Path: <netdev+bounces-125279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE4396C9B5
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA58E1C22693
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 21:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15065153812;
	Wed,  4 Sep 2024 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM2vOyr/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3C14900B
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486521; cv=none; b=NW1py8VUa2Ev+/pGcN5W0XpaE6armtWG6bxuTkCiy+m8gUgdtjTvaPaoY/N+HwRzAYQPzCVG2Ue2zt1frDij+OgUPb15bDyyxGhPJjJ5S+J090Ln4v6gBjfDlnaob0tNlLKytMwuyx/hhWO1UuPyOkFmXbS56N3hrryKazCG+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486521; c=relaxed/simple;
	bh=8Y6nVt6LIe8ySXfo5T5WTDS7TlWvAwCCgggoC7by1+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6OAhmx50tQptEchcKLLaSq78Gmcg2hz/YX9YDUmgY5lCZTyzmo25nq0H0AKEbfrcmwL6LtZ8JugklL4tS5vMiZzbKvR4ON3p5P0leOCjjpZNVfS2szR3Fpk5HnZuTUY1yEDJq3LaOPnDXRRDNX1Ch1QjnoeBuIotnu4dYQ1RD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM2vOyr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6B4C4CEC2;
	Wed,  4 Sep 2024 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725486520;
	bh=8Y6nVt6LIe8ySXfo5T5WTDS7TlWvAwCCgggoC7by1+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EM2vOyr/EMAffV3NrpBf+f+8gDpDa8PjMT13r+G5eH22uRQpvfijUulElQhCJVm/v
	 FvEAOz/NckHs4AGw5L+WnXUwcyh6nmY7ESm+8vVe+0on/i1wqOQhXLkupA4MNLVai7
	 z1/sjn2REEDAc96Ts1v9n8nGh7XvrLtDRRbrPZqA8z9rICQQVJz57wGhmE+06DMC7m
	 h5J5UjAms1oQc02ihaA+usIMcaoGg6pHTkeNQeeddWINkTX2EaN+UNw5odJKORHYtm
	 jJYAgJr2ViQpAJxtfmRT5O9/bhcDZ4ryQjQi+Dx2RNT2eoTt0I6y3a+5L2Q1zv67Il
	 wfg50hKzF9hoQ==
Date: Wed, 4 Sep 2024 14:48:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Martin Varghese
 <martin.varghese@nokia.com>, Willem de Bruijn <willemb@google.com>, David
 Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
Message-ID: <20240904144839.174fdd97@kernel.org>
In-Reply-To: <Ztie4AoXc9PhLi5w@debian>
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
	<20240903113402.41d19129@kernel.org>
	<ZthSuJWkCn+7na9k@debian>
	<20240904075732.697226a0@kernel.org>
	<Ztie4AoXc9PhLi5w@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 19:54:40 +0200 Guillaume Nault wrote:
> In this context, I feel that dstats is now just a mix of tstats and
> core_stats.

I don't know the full background but:

 *	@core_stats:	core networking counters,
 *			do not use this in drivers

bareudp is a driver.

> After -net will merge into net-next, I'll can convert bareudp to either
> dstats or tstats, depending on the outcome of this conversation.

Sure.

