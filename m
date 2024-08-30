Return-Path: <netdev+bounces-123842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A3C966A57
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FE3282825
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EF01BF335;
	Fri, 30 Aug 2024 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhhT+UFg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC714831C;
	Fri, 30 Aug 2024 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049274; cv=none; b=L67PH6QTR1sZfVBHgmh7NYMm5WSAkZnUSj1rKzqPTuuoecgYOhhC4/lnNaj5iwLoumjAsJ/g7SqNJRd/Reap1Em/cYpdee4IJjLUdll0vECFocoobensEGoGM8Nqe7QFm3c1TVLA2GdMMucp3g1ewHBifoPScS04OF+LTm5ADIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049274; c=relaxed/simple;
	bh=3npiygDDDjM2HFZ1hLpnGimK41cWVNYUjSNwPPZXRHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scZvAT498KQynkJw/WcWmO3NZ+aEEHEmQd+L/jJsbWIK3yNYie4T09jMJGsfyydR04cXM3DOJumWEWea7hDkly3mlnMEAN9HIa4M2XD9tlw0jJ1IWS7sIiMcezJfOsT+/xhzFBnroc+K/6A18SvNz6NToLfCRtj6YapoA2QStmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhhT+UFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3108CC4CEC2;
	Fri, 30 Aug 2024 20:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725049273;
	bh=3npiygDDDjM2HFZ1hLpnGimK41cWVNYUjSNwPPZXRHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jhhT+UFgWcjrZ28t2i/llFTY//uHBVCeoBbM+B+nQewVwzijnJRNndrSum+DrU+Ms
	 7Y2uaEuA/6l0tPullwz5A85nGO1TNFl8I+glWEOGz11UZHnpGVCKfbEdxNNhNxGTz8
	 izBYVOKnCfd2XReHoXPP2T3XtThpRnzAa+7qmt96XIkDAfC9tgeZjhQ118izsmwu6P
	 iK5wF1bzJa96Yl04fx2J3HVObaOKTm5ACuuKihwWfmYUuo15CjcNZ5Olq4p5R7Hm9v
	 PFpxmimEgesn9mkoIGbQai6lBnWWlCkqHPw1LXuX5wX6X8xbxGdVBrxwzZZ2friuuH
	 jHVCw7Xtq8ARA==
Date: Fri, 30 Aug 2024 13:21:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
 hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com,
 skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Breno Leitao <leitao@debian.org>,
 Johannes Berg <johannes.berg@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] net: napi: Make napi_defer_hard_irqs
 per-NAPI
Message-ID: <20240830132112.0ee08109@kernel.org>
In-Reply-To: <ZtGNgfXZv2BWbtY3@LQ3V64L9R2>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-2-jdamato@fastly.com>
	<20240829150502.4a2442be@kernel.org>
	<ZtGNgfXZv2BWbtY3@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 10:14:41 +0100 Joe Damato wrote:
> Otherwise: I'll make them static inlines as you suggested.
> 
> Let me know if you have a preference here because I am neutral.

No strong preference either, static inlines seem like a good
middle ground :)

