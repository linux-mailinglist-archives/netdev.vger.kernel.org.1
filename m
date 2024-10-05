Return-Path: <netdev+bounces-132423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F536991A9F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 22:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68B11F21843
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 20:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E5158A3C;
	Sat,  5 Oct 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="PxAVFCL+";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Er3IpQBT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GL02L8lH"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD112132122;
	Sat,  5 Oct 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728159997; cv=none; b=un5rdnjOf3k+OHXPCgwNI3UVsT5oTeZttYuGI81b9nI7WICeg1PdKLOiv63NVvFFVoxlvvWSndnl1R2nAfqFHdciELhdIx3jrcAG6H5wyUOtGjp3poUR/SNRMBjV3HKJpEl+z2JjjMNm01vwqdIYbpx1+sU0CTBcN2NeAw9Iciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728159997; c=relaxed/simple;
	bh=tSEwjcwVLGLRfCY1ex/2k4KFLkjnzDkgnIbzz2hBvwQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dJkmU3xsg/rc+MvoCU+BbEDof5TQmj3QWaa2JvNFFbYqse0Bw2TZUJWIpGS6HPQRepHRPUs83IHdS3x/qZCO8proxhnsZ7GOWk8Cv+UrIXWNBvBBXT3rTAJc9elXOW/d4H1ClOR1k7wm8Ob1qgZDPHv6/lFLVabBoh+r0uwi/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=PxAVFCL+; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Er3IpQBT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GL02L8lH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E667C13801AE;
	Sat,  5 Oct 2024 16:26:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 05 Oct 2024 16:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=2016-12.pbsmtp; t=1728159993; x=1728246393;
	 bh=/UZxPW8Kqb/WScJ0FkGUZbyQA/dvB0fXrs/OgWTOcuA=; b=PxAVFCL+WjZQ
	cToHxEu9QA9lGVJnexuSqrdurcscq9Et8B5+nNIn8Ui32fO3QHD09WFsW1Yv/YWU
	aKdZIW3L+K3571qtdwNQ5V4eDlVPW9DdCWDjWVSwvr5LoD3LLfZ9uT9Y+3AiQeWu
	LpXqb7d9t1FZBqrvkWW6S3HI91t78fo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728159993; x=1728246393; bh=/UZxPW8Kqb
	/WScJ0FkGUZbyQA/dvB0fXrs/OgWTOcuA=; b=Er3IpQBTGScG3QGqm+ywC/m/Q5
	gQqWbEn5n4cueUcTkByT+NNgg//RXC2gb8aoX37THU4IDnvQ8A18V6gORINUKmob
	gfy5JjQg93mcn9jnV3/B23OaGr7jPvzjIyTceUR9an/zJiUcxYlAwsx6oqB+HZGz
	Mj0g1qZ+Gt7Ff6SgTlc4aySDoIbY0JlAHiqxvUnn2Bv7e28ySpwxoLFDnQht4oTY
	cfg4ewIbn+1qRDLXHh/BAd7T5AKscWIUSLehcVjkeaqQIRAGJJHGka17unb0WIyo
	My8p4gXW505wYhYDVx6WRbKAayNCHnTqx4+YdWBgNEuYB/bHNLUiVXlmtqcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728159993; x=1728246393; bh=/UZxPW8Kqb/WScJ0FkGUZbyQA/dv
	B0fXrs/OgWTOcuA=; b=GL02L8lHqUIQbVzDWN9uv8IBYOjGufbSy+WOy49lua9T
	N250UW9zHRFZ4sktJSyeepDIS15joo7eu4++PVAypr/O7YcJmbgXb5UrxMLwG0Oh
	GS2OEfsBTBp8PBdVdRZa2S2yKgcJeOkAHaPtZH/7uNnrj8D7Gj6l5WRcdbOKhQQi
	WI4rLQVIvV7fZyEICMv34v+qzpIBrN0ftTGXV+kzTNNCpowyUhb8Qa2y2LbW9gf2
	Vx6vD0bG9D7P1oHA/gDYB9QYFTtSIR25JOoh/l5SkBGC7mM9irMs2Dc9VaKy6m9N
	nSPbw0bXTE2+L+XiNFLW1HCbIWRj2R05HI/whWWHHQ==
X-ME-Sender: <xms:-aABZ9SpOpwLsye0F2RtsV827l5GbMJ3Xlv7XLlh7Qtsubdkt6sCFw>
    <xme:-aABZ2zj9Ogn6Yn9GUZBodlH34CCM4UQSHmFodAszX8dVK6r-B83VtNqTK_DzWDAm
    ChYQFDObdL6AI8oYv4>
X-ME-Received: <xmr:-aABZy01iHs1SfFuGKzoCBwD7Uiw64oZBl2dygJT0TXnGfwYzVVwIeeZH3n9MzXKJ1bB6lckYUTqmHzmA1sq1SZzHGcuj4vchXHAZU-JgQqhGjuwIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvhedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvden
    ucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnh
    gvtheqnecuggftrfgrthhtvghrnhepkeevleegteevkeelgeekleffveelfeelvdeljedu
    gfekgfehffffieefleffgfdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtohesfhhl
    uhignhhitgdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrohhgvghrqheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehgrhihghhorh
    hiihdrshhtrhgrshhhkhhosehtihdrtghomhdprhgtphhtthhopehvihhgnhgvshhhrhes
    thhirdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:-aABZ1B-JElfXgkTkq1HmMoSvLl-ByeX8TZl7Up_qHzbqgT8wKin3w>
    <xmx:-aABZ2hsCfwjL4kSOpKrUf05yx8Qdaq0mUMk5xuXqcTQBuuKQVz2mw>
    <xmx:-aABZ5o0L2gCsnP3-SYc7ZH592Z6xaXiwXfWnrKJuoxxOa-HoWAONA>
    <xmx:-aABZxhT8UGtSrqIVykzk0-1za6XGsyfKaAjUz1pPDJgexrqtllKAA>
    <xmx:-aABZ7bow8DzlozBVSa0DCsVe28hL1Zob2sk7cJEdRqFLxAlaD37vEGJ>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Oct 2024 16:26:33 -0400 (EDT)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 60CB1E4F517;
	Sat,  5 Oct 2024 16:26:32 -0400 (EDT)
Date: Sat, 5 Oct 2024 16:26:32 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Roger Quadros <rogerq@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Grygorii Strashko <grygorii.strashko@ti.com>, 
    Vignesh Raghavendra <vigneshr@ti.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: avoid
 devm_alloc_etherdev, fix module removal
In-Reply-To: <f41f65bd-104c-44de-82a2-73be59802d96@kernel.org>
Message-ID: <500r48s9-6s4o-ppnr-4p2q-05731rnn9qs6@syhkavp.arg>
References: <20241004041218.2809774-1-nico@fluxnic.net> <20241004041218.2809774-3-nico@fluxnic.net> <b055cea5-6f03-4c73-aae4-09b5d2290c29@kernel.org> <s5000qsr-8nps-87os-np52-oqq6643o35o2@syhkavp.arg> <f41f65bd-104c-44de-82a2-73be59802d96@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Oct 2024, Roger Quadros wrote:

> > If you know of a way to do this differently I'm all ears.
> 
> I sent another approach already. please check.
> https://lore.kernel.org/all/67c9ede4-9751-4255-b752-27dd60495ff3@kernel.org/

Seems to work correctly.

Still... given this paragraph found in Documentation/process/maintainer-netdev.rst:

|Netdev remains skeptical about promises of all "auto-cleanup" APIs,
|including even ``devm_`` helpers, historically. They are not the preferred
|style of implementation, merely an acceptable one.

and given my solution is way simpler, I tend to also prefer it over yours.

But I'm not the maintainer nor even a significant contributor here so as 
long as the issue is fixed I won't mind.

> > About the many error cases needing the freeing of net devices, as far as 
> > I know they're all covered with this patch.
> 
> No they are not.

As I said yesterday, I do still stand by my affirmation that they are.
Please look at the entire return path and you'll see that everything is 
covered.


Nicolas

