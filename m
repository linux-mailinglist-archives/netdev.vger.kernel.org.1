Return-Path: <netdev+bounces-218175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B781EB3B690
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329DC1CC092B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B412D8DD9;
	Fri, 29 Aug 2025 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="fIcqONeh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oFDvY5gE"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE62D3750;
	Fri, 29 Aug 2025 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457874; cv=none; b=bCNJq0cOix12C3BcDj+ZCHvPwHy/22jYS6mNtIwEEZqkkkxRyzkhx+a+eJLVMUbhRlm7Lrtg8e5CA1Ms7Wu0Au8JW0RDSTipWEy5SzeKC9ZSgu5Xm+rTEwLpW4Ugcj/cE32+jyJaI7EPbu6l+z8syP3NSxymu7lAEHKccl2lZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457874; c=relaxed/simple;
	bh=9P/H92Zq3tWc/nK67QqBbF5rswRjgtYk8nJz1Bo1mrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/fByHnb2aE+gxWcSWi6Xs0lc1cZVfd6hiEOzgIx6Ijj1ZnSkmBOvdfDphm3eIBziSPW+O4x3fQ3tpz/6sZhkMVsyYSFRQlu8fLk+IcXIW7tfDW2TKAv4lN2PTN6dc+pSF5wZA8Di2uPjFcl61wCIfI5bW5GWFJXANKjoDcgBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=fIcqONeh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oFDvY5gE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B406EC0070;
	Fri, 29 Aug 2025 04:57:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 29 Aug 2025 04:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756457871; x=
	1756544271; bh=AeyJNnmTbCnIfTacHepLOWEs8+Q2zlQFEe2naiEqz/Y=; b=f
	IcqONehxL+o5jfLDQ2OLhc9h8xnlCQo6xwXoPu8w0IPPesbCvV9loo8W+wH61Gq1
	ASA6jGVf1AwaokYpI/LShx6VtbvthBi6JgMO7IhYCkXHWNbA648JdEZQysj12fQr
	sPnoiq39BJlk333DIr8FZRXN/mJpgHwiQfKTmMumvdXFZPIljom8FhMNcpCK5Rca
	t/EW6uMrwLFWl5gaUaqbse1lL4cMAE3kT1kTUBiGIKp5pd5UfzinllvIDnDhbO99
	+T8+x/CPcUYnu8kJFpqByMafvOl86vMUdV09R09+BlNK+cOPxvCEDTPyAgeCA8UZ
	KDiJJetkYmDIl1kipD++Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756457871; x=1756544271; bh=AeyJNnmTbCnIfTacHepLOWEs8+Q2zlQFEe2
	naiEqz/Y=; b=oFDvY5gEiOnL9czrxuM7BoSTz6sqYWV7BwWIeSSq1bK6P8ERILh
	UTpX9XvAwrS8M/0TpSDbJGkupwynjs2Gica0Gko0/Pf/dHmi6NWVYePoAbvUJ33R
	XwToJAOOKbDn4zCu0t+LmojGBHumCxpB7xpko/FXRp4mXJ24lGW8bFpyKle7NO76
	Y9JLxln76F3xiza4URLQzB5tUdcni0Se71pRKN2Fw2N2tUAjWNSd5t+tVS1FZPSV
	JOqFVEshrxa0477p7OXZ2ZLXpgtfEMXMRWBVOXb03xWAalYzr1Q+hKSf64wpu78E
	+hEwb/2vC3DePo6IkHWqHUr53kWkNlNTyYQ==
X-ME-Sender: <xms:jmuxaL3YZnMMG2ZKp5aCev0xNQK6VGLPzmpbIHgSxzI69lb48xcS7A>
    <xme:jmuxaBVkNwUwbgu2at8z_SRGSy-PK9JrLV5888ZaA4bwuxcas89BRdM3LmZntfEqY
    7_zfEsuy1LBrzXuS-8>
X-ME-Received: <xmr:jmuxaGzCXKa3pkDaxYNvHS2uwHMNnZ2Rq7k2-MefA56DovRhK0m3mSIXAtwy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeefgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvnhhguhhinhdqkhgvrhhnvghlsehiqd
    hlohhvvgdrshgrkhhurhgrrdhnvgdrjhhppdhrtghpthhtohepshhtvghffhgvnhdrkhhl
    rghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohepshihiigsohhtodeiie
    egudgriedufhgvtdgvvdgvkeelrggvkegtheesshihiihkrghllhgvrhdrrghpphhsphho
    thhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvg
    htpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:jmuxaAxYJi-muA_0Dbq9EYhWvBQzwgFHAW_U55o5iY_8nLCeRIs20g>
    <xmx:jmuxaD2EnLfb7PvjwEu5rzIsmCSYe8RKArpbEmxnJvqsE30Avo1X7g>
    <xmx:jmuxaGqvKn2C5w-AWYC4tDD-eE0H0yGe7gc0-YPkvlNBZew57ilL_w>
    <xmx:jmuxaBBsXoeltXd9YBAxuZAD0k1WO2x_mugnWMoxQQvLsksKDLMr2A>
    <xmx:j2uxaKRjrGqWpLlSnpCKpA2W8d0k97yi8cHOVECbR3VH8NXepw1oD9g6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 04:57:49 -0400 (EDT)
Date: Fri, 29 Aug 2025 10:57:48 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com,
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
Message-ID: <aLFrjEYwiEhaO5hK@krikkit>
References: <6888736f.a00a0220.b12ec.00ca.GAE@google.com>
 <aIiqAjZzjl7uNeSb@gauss3.secunet.de>
 <aIisBdRAM2vZ_VCW@krikkit>
 <2a58b0b4-1c67-46d2-9c2a-fce3d26fc846@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a58b0b4-1c67-46d2-9c2a-fce3d26fc846@I-love.SAKURA.ne.jp>

2025-08-28, 20:06:29 +0900, Tetsuo Handa wrote:
> syzbot is still hitting this problem. Please check.

Thanks for the ping.

syzbot has found 2 different bugs that need separate fixes (but with
the same symptoms, hitting that WARNING, and coming from the same
patch series). I fixed one (syzbot confirmed the fix), I'm working on
the other one now.

> On 2025/07/29 20:09, Sabrina Dubroca wrote:
> >> Hi Sabrina, your recent ipcomp patches seem to trigger this issue.
> >> At least reverting them make it go away. Can you please look
> >> into this?
> > 
> > I haven't looked at the other reports yet, but this one seems to be a
> > stupid mistake in my revert patch. With these changes, the syzbot
> > repro stops splatting here:

-- 
Sabrina

