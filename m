Return-Path: <netdev+bounces-114186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276229413FC
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980312840DE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA231A0B1A;
	Tue, 30 Jul 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfjPHw0p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B261A0B07;
	Tue, 30 Jul 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348635; cv=none; b=u/mNmEDaLn4oVe2DTv6zihCEQxtE/qclYc+98aneovRNrmhy1zax5vCC7bcCssViAqI1MQxwtBriMq6dWoU8CbI0Qm0kbc2cKaZPZHY6XG9YYwNMoiDvSm+9HqakNeF8N7gLGHzJpoRhrylFIDePmOF+SY4H/33zDZkoyb/T8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348635; c=relaxed/simple;
	bh=wrQ7oIFb7ZfWpq1LFWJSkHq5ZgJ2T0LLjTR5jUjr0ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lm74t9jY/A9s06BeUaUmYiXpX+r/b0PnEthO+PNJIZmd8gnZMGuG33+47G6snF+cRBoh/Tj8Dhn2a65TqsPo9KRKajT2ry8Aw2+GMKISdo7t8fdt2NNnCxZGxC2xgHVU731zL2dlajFwCj/Pa9LwOdcM9xOr98OnWsyPrbmbkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfjPHw0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFC7C32782;
	Tue, 30 Jul 2024 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722348634;
	bh=wrQ7oIFb7ZfWpq1LFWJSkHq5ZgJ2T0LLjTR5jUjr0ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bfjPHw0pL09+R7mfHFQhZYRMSSt9sUYb9wP0nvhEExJz60wTIaPvlZNsDc8mI/T+J
	 pV1j7cW1gR/K0ugMGgfX2/FbGN9upBjYMJmZZVQawV0IWZu0qjdUKPOt9JfiqnbUyy
	 lOo0qTbsj9NSnVrhOgrOXOEXAuGSzk+Dl2JYINRW/HkG+60qoJ3+5pnDySFV5MwVDi
	 WCaSKkHDXr2aDkYe607FS3k+6ail/IZpiyH++MMclMXqFzZnBOfsrPLXIL6HBdPAju
	 zeSzWJfAtKOWJ01t7HaQ7l8hvJqWJuGN9v7Blc8nebujA8AJQbQDWZBnTu5R/UfMZ/
	 a5/1JYjPp3xZQ==
Date: Tue, 30 Jul 2024 07:10:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, Breno Leitao <leitao@debian.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, leit@meta.com, Chris Mason <clm@fb.com>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref
 when debugging
Message-ID: <20240730071033.24c9127c@kernel.org>
In-Reply-To: <c61c4921-0ddc-42cf-881d-4302ff599053@redhat.com>
References: <20240729104741.370327-1-leitao@debian.org>
	<e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
	<20240730105012.GA1809@breakpoint.cc>
	<c61c4921-0ddc-42cf-881d-4302ff599053@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 13:15:57 +0200 Paolo Abeni wrote:
> > If thats the case why does it exist at all?

+1

> > I was under impression that entire reason for CONFIG_DEBUG_NET was
> > to enable more checks for fuzzers and the like, i.e. NOT for production
> > kernels.  
> 
> I feel like I already had this discussion and I forgot the outcome, if 
> so I'm sorry. To me the "but is safe to select." part in the knob 
> description means this could be enabled in production, and AFAICS the 
> CONFIG_DEBUG_NET-enabled code so far respects that assumption.

I believe the previous discussion was page pool specific and there
wasn't as much of a conclusion as an acquiescence (read: we had more
important things on our minds than that argument ;)).

Should we set a bar for how much perf impact is okay?

FTR I suspect there will be no measurable perf impact here.

