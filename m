Return-Path: <netdev+bounces-248131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466AD04282
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB453174DEB
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46691C2324;
	Thu,  8 Jan 2026 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="SWsPUE9I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pdk+3aEB"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA2500967
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886922; cv=none; b=UO3vBWRtopnoHbPhEkosOK0UaUouFZxQXmfjRTiWJrKktQpdAuzddcHvCTzTlLfUyR210ja0F2545bhZot8mFNoVPjcVKfp+1BduiesaB4ZJyUIFdumBmURuFo49qa5QgIlo0flm5PS08ahA8maNlnguEDV7Ae/fkEbo3Q9Szuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886922; c=relaxed/simple;
	bh=YNfhz7J/JCOKs9MdHhsbHE5FDZz0yzGVxx+/D4ERjJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUQq0W98O0yBmN4YzBuXQjRko370dz9rzFLis+3xFScvHLdZyMF/Cp+8YgM3N4jo4fBzjCEyGJlkhp2NP0MZxv5T+QaXZd+pu7by1oWQDB+F4lL2HALZiuc4cIuGhJYtq2dk143izGLpMVI5fX5weqDed5wcM0v5EGGvWMWAF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=SWsPUE9I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pdk+3aEB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A943140005B;
	Thu,  8 Jan 2026 10:41:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 08 Jan 2026 10:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1767886918; x=
	1767973318; bh=2yxKiX7AZg3x23P2C7kVl6/Va64tTlWpce229PC12C4=; b=S
	WsPUE9IcsZkkf5Mw6bJYsfMycLn1MAC1fMZv/2ozsFPbFvw5iw83xvofOjU79gW4
	1MyEFCRPkDmvuEL8rkWRAk6x2dD9U/ewLeS42BtlNBQjYCefD06P6ByPK0W6mZ68
	R7G4p+bZiHDp9uYvXn0doE9DZVJAGRQ45hH6pLG8lf3hzYLFBGjfEYOe2NtF1HZI
	nz2jGm411AiOWMneSCk7UGG05q+F3W/3yg9PeulrZ2H05fVgeTQ5IraGFy2tpPxQ
	fkTvbIrGQpUy/lnsWv04w4EdQ86XJ8DvW3PQ1WSwKF4W/QTy9V+UOpiQpzslIDc3
	PT0bkKOQbFZc8kwevPbSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767886918; x=1767973318; bh=2yxKiX7AZg3x23P2C7kVl6/Va64tTlWpce2
	29PC12C4=; b=Pdk+3aEBohsGS/sgE7lLQU4qjx5WTP2mW7dAAIDoY/nnzqyieRu
	8cPD+LoZz4+V06QBHlNXtY0aM7nj1JlmGuXCmd+lIlasj5oOiWfqLl+9i7+EJmBZ
	ZW5vmNyeAK2JQj5alc3Hv0howPwXOaWDcrZDpn1Z0Ayw2siS/QVD4a2HeyOTSfb4
	vzu/KQYZKzud+p+cHQ+xTr1jgMR5vUBRJJQlhFZAsnHNmzKJWT1mig0kxy1yX7CU
	czTK6YoHOJNZdHUKBnRsip0F5HxqiteGHycYYxfOO+jjLENjXvKGkoCDqYb9A7ut
	EV576/t0ch6O7Y4QWd7h2lVwMoaYlY47MGA==
X-ME-Sender: <xms:RtBfacxgFSI0kak6fT3BTPdRP4umYVzPipAUTFXs67nd4y9N55IPdA>
    <xme:RtBfafV5imoUlRUU17lCmAZPlrpYN_2IOqODwDNHxVnyl7qKHV6F3xKZgjaan_hAQ
    572724cB2ER3YONXP4Hm9x5x197DzIlUIpkEy6ae8iUuMZGADm5icUZ>
X-ME-Received: <xmr:RtBfaUjJ8D0BUZOHiUJnEdmFM_EajBuEv6fLCttOY_-VyutQuGqlnVEDj9DT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvght
    uggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RtBfaXCBpSdeE5-Ke-q0YQ18olYro3UTXIx53Ii9EIZkOOslJSZPXQ>
    <xmx:RtBfaStLQS9Uygf--f0A86n9R39N1STRfWV_BMVCrDMeA3cFv3EUJQ>
    <xmx:RtBfaTehsT7V1K7x2jV0B6ay0YIPbQFNC7m8b4qXKId910tpWXNzSA>
    <xmx:RtBfaf9e8Bvr2TRqWVD_f6qK89_ApKrMA9rXd7RD8jFqnrHaRrncPg>
    <xmx:RtBfaZLLHSMbzxGaZUO2XGjC6aFmkGY1pu-B9JWDiSEfgaOpV-j22Phw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 10:41:57 -0500 (EST)
Date: Thu, 8 Jan 2026 16:41:55 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [PATCH net] MAINTAINERS: add docs and selftest to the TLS file
 list
Message-ID: <aV_QQ959hkQS4IAV@krikkit>
References: <20260106200706.1596250-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106200706.1596250-1-kuba@kernel.org>

2026-01-06, 12:07:06 -0800, Jakub Kicinski wrote:
> The TLS MAINTAINERS entry does not seem to cover the selftest
> or docs. Add those. While at it remove the unnecessary wildcard
> from net/tls/, there are no subdirectories anyway so this change
> has no impact today.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: john.fastabend@gmail.com
> CC: sd@queasysnail.net
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

