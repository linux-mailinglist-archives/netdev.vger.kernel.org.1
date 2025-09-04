Return-Path: <netdev+bounces-219840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B2AB43629
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFC51659FB
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C162C11E7;
	Thu,  4 Sep 2025 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="eJkOdaen";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QzgioWJh"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6262264B1
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975419; cv=none; b=dG+8LNHJJLQcUc1FH5ZpelMbtnBFtJIIL1nOZqv/Q4nigCTlJc6kdAVCAN9RiN1kocT7UBpfFIg3cAj13MzoLpiDbtav8KrplHUHJ09zcKfRuomyx3NIoMJk/V5bT+qELp2ppvcq8ugm0EkihX8TlvtUxC3LYrahB8q+Z9vDKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975419; c=relaxed/simple;
	bh=lMAwGBMVdITi69l9/4tOSgk/tb5DbL9ahuVnYH0xghY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiYdzIH26BLD+PNb31HC1Y2a+rLiVagmzxWaPQMHFHi+V9WxXVRwP5B2LMiKeMeDTQSPb16MMrcr8LbPA5mJKQz0hz4im6OBj0pPByUW+Rs0zHNKbCQ7WdamxfKk83V+uWLhnkVaLU8ET2YlmPO2bu3HVP1UqRVCAmGLSbCHi8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=eJkOdaen; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QzgioWJh; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3FFD140023D;
	Thu,  4 Sep 2025 04:43:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 04:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756975414; x=
	1757061814; bh=JIMOZ8XkDuR3Hl2UoArTyKkO0dU8OqeYk59fUfFyOpo=; b=e
	JkOdaenyQTRvsQOxd8q+86q45IXcZwmxbzryjVjSnn019BdvMbIGQs+mKWodlf26
	lOUHlXenYl1WOI0JEeLLnSdBVkLwm7p0c8yzvafvTiLqQt0/z+KOZJlSTtpCpbw4
	uooSgKmnoKMeKQw9/NwFlqrTDUdmMTdaljxThSUwDyQRJs/BaLknB8QZaCct7X+k
	3v4iyjWtimiJZRhqtoBVNR1nchYk12pEZelSAfh7hxd7gZpakOEMNqgmlLoq9ATd
	7AIMRfx1pb1rDpGD54DtAIGISUL6e1XFbu6nCkM2JyimW8VvLr1PQHYm2Bv/zqX/
	hlkVU/mjVHmMwYTeVHjuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756975414; x=1757061814; bh=JIMOZ8XkDuR3Hl2UoArTyKkO0dU8OqeYk59
	fUfFyOpo=; b=QzgioWJhlT5SZe0z6dBk7itLhrA13XIKRfVTqWGG/AGttUlwXAL
	IsBAU6r7A4Dp33HQD2fCha97K/vNz/XesV50qxPbjzz9geY43D6srrFH163OROIv
	tqPlnLClP+e3+40pqDbXUw5Ina9uWUFbw6HrPMJc/ou7VIHNwlSpwhQc9F/MPwmP
	KqCl0Rgm+8yTW04TtP90fOo+xb3DvSKjEUOPphv7HKuHx29yBQtlDXmAw3v2KP0W
	BMDgKcNemp1FVyaR7+K1En2uOgXasBnRG0eVWc6GvMRUH5hrbzYGHRWXlaprO7Nj
	H5yqzkxLHJGpy1t+OAIteNrnNhFUXO8qrmw==
X-ME-Sender: <xms:NlG5aB7Rqn5zc4Ym5sWtpzgUYqQll-_FjZyuA2lEhwSpaFJ68ecSdg>
    <xme:NlG5aL270MUNilgAtzcC-ON14BbOm3PvhZE4IJm6SfcqDUDvBy9_K1lA607u8anxX
    LVbj_PT-LaUQqJJxBI>
X-ME-Received: <xmr:NlG5aEHbsC9sdbqQUBsR464jWMH2Lrt3PfRlYbA0mHxyu814ZcEp0124oY4Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    ejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihs
    nhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfe
    fhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnh
    gspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrd
    hnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprg
    gsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggv
    vheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NlG5aChPdNk27NJmMYASSqVr9coaW_5zbHWu7aBYFHsedQukVjrUAg>
    <xmx:NlG5aPChO5_KPwQZidlEBsdtgwQFOMsEgWLAAn8TiYnskkek9JXMlw>
    <xmx:NlG5aMTj5EtqfCaXLYqjPQK29AStAj2P1YD_mY2575ja1nIm1C4mVA>
    <xmx:NlG5aMXyehgi65PgTLhq-7OonFnChUXLNRnaG5iAh7y5HWSvjV0MIQ>
    <xmx:NlG5aA7ckvcRh8t6bqlofVQlzgOJ3FbC9IvL03fbA4cRGBa7udrIj99o>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 04:43:33 -0400 (EDT)
Date: Thu, 4 Sep 2025 10:43:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [PATCH net] MAINTAINERS: add Sabrina to TLS maintainers
Message-ID: <aLlRMxAAW0TAtLDn@krikkit>
References: <20250903212054.1885058-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903212054.1885058-1-kuba@kernel.org>

2025-09-03, 14:20:54 -0700, Jakub Kicinski wrote:
> Sabrina has been very helpful reviewing TLS patches, fixing bugs,
> and, I believe, the last one to implement any major feature in
> the TLS code base (rekeying). Add her as a maintainer.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks Jakub!

Acked-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

