Return-Path: <netdev+bounces-246606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5EDCEF1DE
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 19:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA239301357C
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEC428725A;
	Fri,  2 Jan 2026 18:00:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A991A254E;
	Fri,  2 Jan 2026 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376843; cv=none; b=qs0csQPvpwX9gUlVsBI+Vk8qeCSCR7mwVn1RicS8ZQ+bX3xgqWtgWK9cWGoPRCoWFxOhvAe3gCSy3dnUz0ToN25ZSv1LaABaB1xjpwkT67Toj637ByOBiBjcU7OZCQFVOpMjTqYVdIK+d0YoyKjM8asJn7L11KkmbKVKXRocy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376843; c=relaxed/simple;
	bh=3x53OnimHTrS42jrlSe2t1jfzA4DYBzS9IKybzVCXP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgAkSMwrFRkv5NqJrJXP+Qd359vn9hhlXZb8Ru0NtTE3ZsysyLdeYIzl9X4kGYLtgEue7sXeJXVjVALY94rbgld5ro/vR/L3gXRdUX7BhA3Gt1I/P+WdInzAAWzcE9khP9o7cw6SgZEDgaq11ZeLem/IfnO31kASKwRI+d5y+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id ED0E0BB91F;
	Fri,  2 Jan 2026 18:00:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 805C52000F;
	Fri,  2 Jan 2026 18:00:29 +0000 (UTC)
Date: Fri, 2 Jan 2026 13:00:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Leon
 Huang Fu <leon.huangfu@shopee.com>
Subject: Re: [PATCH net-next v2] page_pool: Add page_pool_release_stalled
 tracepoint
Message-ID: <20260102130044.56bba268@gandalf.local.home>
In-Reply-To: <2a8dcd09-fc28-4fbc-b8f5-a4f89d05a30a@linux.dev>
References: <20260102061718.210248-1-leon.hwang@linux.dev>
	<20260102104504.7f593441@gandalf.local.home>
	<2a8dcd09-fc28-4fbc-b8f5-a4f89d05a30a@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ytooad7ccyewx4ner7t9s79dzy156stf
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 805C52000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+L49aI8fDGyGSqZDNb6jH/bFmoXO0Shos=
X-HE-Tag: 1767376829-705135
X-HE-Meta: U2FsdGVkX184+LR1W1fDTm//FcOaPWw0i+TlxcZA9mlAGfhEXZavgg89wtN8Pa5vkCfTb0m9zSCajtRPCEBdp+GcYyQmZzxuuv1vY67yqDAfYyJJyCDRcePjAVXeO9sQja7kLUqtD2AJo/wGMUS0qNLLl36HSavkiuFpKY9qbNl/hp/UxAtRUDrcC0ywaKv1VujCSU7PNgqAfl2y3Ojuby5SDjvfFepOlgqPQNRVihZ4U08GBQlKmO5g4+MKWcBbxG4pTSZV+fEFevZacRuheLiGs4WUeQ3HpWOS1LN8L/zgNduN/9Us5HBLHs9y16q2N3+4CQ+BwZIZYDry/bqYTmK8yLCJ2kHqWFrfENKo4yRX59aUIvzNAw==

On Fri, 2 Jan 2026 23:54:20 +0800
Leon Hwang <leon.hwang@linux.dev> wrote:

> Thanks for the review!
> 
> I realized the id should be printed with '%u', so I've sent out v3 [1]
> with that adjustment.
> 
> Links:
> [1]
> https://lore.kernel.org/netdev/20260102071745.291969-1-leon.hwang@linux.dev/

Feel free to add my r-b tag to that one as well.

-- Steve

