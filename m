Return-Path: <netdev+bounces-163509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16606A2A804
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 13:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0153A62B2
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 12:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0015A848;
	Thu,  6 Feb 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUEMmY3V"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD4151992
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843223; cv=none; b=EngfWdeRyEt5CDSUWm8VEifbLxdmC7z1/F6gWXFc24lBoQEw1lWCpvAW2GHWcTDY4O/bLdZCFeuW3KEc2X0udPjxXdbwepkBGKoce6IT2gUwSv3w5pRFuZSeyBIjg6uyuNiy7lu/h2LE6FzyTkXYP486df4zdOZSxPPSU9+bM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843223; c=relaxed/simple;
	bh=aMq8QdMtEDft/H1MqnSfu8bzUd1W2Z7V3nzCdx4RJLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNobhx69CvEh06ci81pm0SJ1X44vZVnA8vC/2lGIw9Z532rf2f6WkS/sa3tH3x8wtJIS+VyVN4sV2da1tj92kqjW5hOrOr4/ImbTyGR7ZAUKWyAWsxm6GZrs5S4/iE0havWSl2LrqFMGrSCCxwLkEddC4lq180DNiDzpjXURv5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUEMmY3V; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id ED1ED138023C;
	Thu,  6 Feb 2025 07:00:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 06 Feb 2025 07:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738843219; x=1738929619; bh=0HaTXLcx0wisjv2WBo8e4LQhSvrpnEiRDzb
	/ofXw4pc=; b=DUEMmY3VP1MTnBidlPAug+jwps014YEwxmdIVtPe19DQBPYGtVt
	/iSgw40dqv6x8bJDu87rSYkhyMuKz6iVFPtfzchsBbnfLVvevH6Z6UruJ7ikcSGL
	TDuV7yHPSLVwBaa3csPcEe4vGxa/OxqBV5+tdIcFlMtscXuvSafQYK0AfzyyrGLg
	0Hr3rlJeCOAb5QJDX/hWdKtH+QyrOsk9eeMTk5AAtE7yTLT9pZXzcPlE4hcn3j4x
	2sUtCx4sapf2RsrMZ/Dp+2ylaDF/tDLu9uTsGQZ/F9ioBAF8tI7dKYo9+UVXkvKI
	0hYMoU5ViZwNAWAMQbYy2hFlmBiIbifMGqA==
X-ME-Sender: <xms:U6SkZweHGhUOeECliLtPhvPVlODwXt7ICPaGkB1HM7bEvUCwSXH4iQ>
    <xme:U6SkZyPkBab7EbVrv3rHXxtzGNDyTCc0wWs5gsPYFjHt6m0pf2bX7tZSAsHuh5LpF
    jGPL9ZL-Pay4-I>
X-ME-Received: <xmr:U6SkZxjtHZ3PMo1AMqDrXAYHRKqkxObvct4mm0AQ5UXeQsbGWg4TbiUplHhnpjiTptuPDAdiVU9P7kerOVrO-tRE3Dg7kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsg
    gvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvrhhi
    tgdrughumhgriigvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:U6SkZ1_vxG-p71gRe7LipvpF4TdiZC-brpY5wZ5KlzkzD_fXaY5-wQ>
    <xmx:U6SkZ8sJwc_3wK4O1Lmp0-I6jA29zAnaFvEwSHJO8jWKycZLhjiVCA>
    <xmx:U6SkZ8EpCHZFgtwa2ngfoN5dH_aucoRr7NC55J-qowgPPPXxksPJxQ>
    <xmx:U6SkZ7O-huU-7IAl-Nkh7nkDdDvlD1Cs71jIxCvpHs0w3fXuB49Qyw>
    <xmx:U6SkZx-9jKUtpS0uz7N7OaLB02apuZS_cXy1g5vlj1bLSCqxyHhls2EZ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 07:00:18 -0500 (EST)
Date: Thu, 6 Feb 2025 14:00:16 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net] net: fib_rules: annotate data-races around
 rule->[io]ifindex
Message-ID: <Z6SkUCO1oFzoExkz@shredder>
References: <20250206083051.2494877-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206083051.2494877-1-edumazet@google.com>

On Thu, Feb 06, 2025 at 08:30:51AM +0000, Eric Dumazet wrote:
> rule->iifindex and rule->oifindex can be read without holding RTNL.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations where needed.
> 
> Fixes: 32affa5578f0 ("fib: rules: no longer hold RTNL in fib_nl_dumprule()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

