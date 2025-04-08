Return-Path: <netdev+bounces-180378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 905B7A81286
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81077A8DC4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875B22D795;
	Tue,  8 Apr 2025 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="a0Gr3wTr";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="GVwFZI2F"
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09B2D600
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130267; cv=none; b=mKUWCx8lQ1i1BM5oAD4xbXTHW2t8ml4pGZX9To0JaHTgpSY7DxlCbEJJeihDEhk4ctEHJ/1jPbp2L/KUeO9qSEH7feugeE4sA/p2XPd/SCxnukIktB/QsRqJd2/1L+sFNwahXQSJlOMP3LuoYkbhTe229WzJ+M9KO8gRkmnYksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130267; c=relaxed/simple;
	bh=oubJ8IQkh+iy6BOT4io5LhcTE8knv84F3KLX4HHzPOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujjIc3QT06DtVa21RNCvGMk0I60+gfaoSLjNObCO12VAQAGVs9JEg7kourc8Vjbh7LVJgPtGqACD6rk3JGm7GDRE73A/dCnIzVneBBqANng1C0UzAC5SUhGNSmcpucs2206faMM4GHMplNpF539XEJyJPDN5TNFG1FmtMlAwZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=a0Gr3wTr; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=GVwFZI2F; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id E02D86055C; Tue,  8 Apr 2025 18:37:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1744130262;
	bh=S0lJjgIsR2Nj+QQEAG6VqpYG9UU+9VDQNZtx/t9shsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0Gr3wTrcHQ6JMC0/5eUCTj0DGyb266YEYX5Ty4pZrOWyQLdqyo4w2YMDryXEgdyo
	 MhrCkEgeZYMEH4DA9G80jPCUMyv8VPRtLto0tciWYcsDzmGOg8Rk0FJ27o8g5y0pjW
	 arQzPYtcvBYpv+6UzL7qjHPI9tBjJ291L0R0tN+3sTcJM5J+R7I44ImHKTpjzMcfUa
	 8jxARk449cfBFcR5/zU0lT9Z0UZSiLEjMRGhM0om5gYfxDqrCfhABetUV6GPSeA4EQ
	 Fc3U4huXDxOdc69N7HvTGEV1riU6OZry/MU55GoNwXm56c5zJuEBkBHzejxDZ1O63W
	 y8acSm5CKmqBg==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id CDD1D603B2;
	Tue,  8 Apr 2025 18:37:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1744130260;
	bh=S0lJjgIsR2Nj+QQEAG6VqpYG9UU+9VDQNZtx/t9shsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVwFZI2F5isOuELBL0iInJijdwXRoy2PAs3onNlgrfAUFZOFtaT9Oaobz1qdviJzy
	 70mW+/TnxRa5c3nMHmRR8jlpt7XO4LCrZLRorXGUFS0URjZnIq4+QLeUxJB/3juabR
	 o29W+6sxdReOL+czzq/dVrYLLFtM5cqNCSb5wRqD8TdH4lGJ2a1SLX8gS8qc0zAm1j
	 c/JJ3rNp6rHhUr5KNPzK2gmtHLnAtfHxWzop+6Mb/Zz8x32QBeqwabH691Uv3A6iJA
	 SjOftxY7WMqAdEgesncpibsTz2AhzdJwLW1n7y0S8SFQ8ichQhJ3GOWQt4hpf/xom9
	 JiRxwRcTcDJPQ==
Date: Tue, 8 Apr 2025 18:37:36 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 2/4] net: Retire DCCP.
Message-ID: <Z_VQ0KlCRkqYWXa-@calendula>
References: <20250407231823.95927-1-kuniyu@amazon.com>
 <20250407231823.95927-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250407231823.95927-3-kuniyu@amazon.com>

Hi Kuniyuki,

On Mon, Apr 07, 2025 at 04:17:49PM -0700, Kuniyuki Iwashima wrote:
> DCCP was orphaned in 2021 by commit 054c4610bd05 ("MAINTAINERS: dccp:
> move Gerrit Renker to CREDITS"), which noted that the last maintainer
> had been inactive for five years.
> 
> In recent years, it has become a playground for syzbot, and most changes
> to DCCP have been odd bug fixes triggered by syzbot.  Apart from that,
> the only changes have been driven by treewide or networking API updates
> or adjustments related to TCP.
> 
> Thus, in 2023, we announced we would remove DCCP in 2025 via commit
> b144fcaf46d4 ("dccp: Print deprecation notice.").
> 
> Since then, only one individual has contacted the netdev mailing list. [0]
> 
> There is ongoing research for Multipath DCCP.  The repository is hosted
> on GitHub [1], and development is not taking place through the upstream
> community.  While the repository is published under the GPLv2 license,
> the scheduling part remains proprietary, with a LICENSE file [2] stating:
> 
>   "This is not Open Source software."
>
> The researcher mentioned a plan to address the licensing issue, upstream
> the patches, and step up as a maintainer, but there has been no further
> communication since then.
> 
> Maintaining DCCP for a decade without any real users has become a burden.
>
> Therefore, it's time to remove it.
> 
> Removing DCCP will also provide significant benefits to TCP.  It allows
> us to freely reorganize the layout of struct inet_connection_sock, which
> is currently shared with DCCP, and optimize it to reduce the number of
> cachelines accessed in the TCP fast path.

Netfilter parses skbuffs, in that sense, it is a middlebox. Main
concern on my side is that it could break rulesets, even for people
that don't really see dccp traffic ever, ruleset could stop loading.

I would keep the netfilter bits aside by now, based on your netfilter
updates, we can internally discuss how to phase out dccp support to
get aligned with netdev maintainers, as it seems there is a wish to
reduce debt in this front.

Having said, this Netfilter does not rely on any of this socket
structures, I think it should not be an impediment for your tree
spring cleanup (IIRC we have no hard dependencies on CONFIG_DCCP).

> Note that we leave uAPI headers alone for userspace programs.

