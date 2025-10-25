Return-Path: <netdev+bounces-232818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC48C090FA
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEEA3AB4DC
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5E22FC037;
	Sat, 25 Oct 2025 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QX7xhbq5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IumrjpHO"
X-Original-To: netdev@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DFB2FB0BF;
	Sat, 25 Oct 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761400079; cv=none; b=Q2ZPr7twmEyrjHkyHNNtdcAO4j+LZfxlesXQE4Dvqaka0dZhtnp9DVSMWl1uIWDgqOXtf0NMF6kXgFT8JpRgwujRIWjEwI4BSKH45LdUe12Fv7PjyKK8aMFiZd5m+vRKG1L7bIUYDYK5fSc+Vojpe7p+FB6eS7QTSc+2QNfFVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761400079; c=relaxed/simple;
	bh=m9Qhp3ifSVLBXG8cDlSUUUR+q1d9Ly+/i8V8nymRsNo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FIz99XJpbGmZGpMjrk83rhSrkRs8L6VV2C9gZrU9wE2Ty7aBV6B1G+5S2Jzs+pJFY8wP3Wjh0kOjhXAVOUCcChfr5HI2WFrHZmffpEm/Ml0n5NrBkBXGgu8/TgkOcgqU64x51qvOqGGTlAcVsCkKExvMJyFFK1+0Oi2Svj9A2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QX7xhbq5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IumrjpHO; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 7B10B1300167;
	Sat, 25 Oct 2025 09:47:54 -0400 (EDT)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-12.internal (MEProxy); Sat, 25 Oct 2025 09:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761400074;
	 x=1761403674; bh=m9Qhp3ifSVLBXG8cDlSUUUR+q1d9Ly+/i8V8nymRsNo=; b=
	QX7xhbq5dOGJ6uF+O+NUWCWru5dkK+YvgWNo3bh9S8QPKvr50BjBwWi7nsj4rH07
	F7Ns+tbGhdjh10YDr4YtWeRYeCda684P9EPYHFiJ3x/DU2Yxw2vx22XMdNgOS7jx
	2Adz8u0x9X/wtjFKbW19FbvSu9l1y7Ppvn6p8j2iBNRW1Ydyfpl9fX8Lefv43XPu
	qPM0RQekdXqrh2tmGI2mleBEqVgXuzPMpTwtDhMlHmOPQmdIY6/QYogVCkR7VC4J
	UTgAbXGfQw0MvgOwPIesbegKd5XbRjGWmGeJScbAiLAjx92sY1nLnIT0tQWVtGjQ
	LwBQhfwRXf+bS3xwBl+SAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761400074; x=
	1761403674; bh=m9Qhp3ifSVLBXG8cDlSUUUR+q1d9Ly+/i8V8nymRsNo=; b=I
	umrjpHOgH8ZhpW78Eh2DAc9IzxA147mFtNBUXkpLthwBCr/Gm3jmbU1W+FUuo+ax
	OAd0nAfD3MAGyGMPuKdqWnorALabuMS685x2948gAKU2qWGN+KAcybxVHWtF/p0X
	VLGYoY6blQG1ppTzpYuNCiZ+V5QpkMGf5ZELGo3kfiuJJ6JzL0fOfcpukR5e7+Wg
	fLZNeEBZZA7g6Ma4viE8Ik+YXL8hATjzZWU6W2xBZrF6EVs2iro9DWGj9hjBw6+L
	tihVoHAdNjhAjdE9w88P9vYQO/lhDooJM03kFSc9ZkDcG1gCKbGJBsB+CFmHnlaC
	6HUesLNKi8vViHkuy6YJw==
X-ME-Sender: <xms:CdX8aDrvSOwQ6t5EtIc2k4Nm4PR6fAvfEm0Xb33NkM93uPYFEJgaPg>
    <xme:CdX8aIfLAtPr0Oo6KANBJy_tesFAf4y0tDgtX-W58hbdWj8UoqxPq2sYxVmi2jMQw
    1CFCcNduqZq6kvqaUmpD9UUERSl2f5-hgkB8IwJhKrcabNmeJxSES0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdgjihiihhgvucfuuhhnfdcuoehsuhhnhihiiihhvgesfhgr
    shhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefgveegvdefteduteelffdvhf
    etgeduiedujeffjefgheegvdevudekheeiheekkeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsuhhnhihiiihhvgesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoheprghlvgigrdhgrgihnh
    horhesghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhm
    rghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhsshhinheskhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:CtX8aGuYavhHIqgANEkaxL-KkO_CjzgE3vmHacSBkJDeOm68mbnzaw>
    <xmx:CtX8aL56oQqMKuk-s1Mnal__bDS0EOqSvZTAySekHbCjgkGck_2ljg>
    <xmx:CtX8aBhnE-eydeofEUBirk854eAy1REDlT_8sEdhG_VZeP-8iT0n_A>
    <xmx:CtX8aNlElAIUUNrszUa-IYb5NhefIyG-R7MTAoKrV-i280nI402fBw>
    <xmx:CtX8aEbFwLe5tDsFNweyFhbndKJfa6BzqZcQhqpVEjHo6drkj_rkgCaw>
Feedback-ID: i1736481b:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DA064C40054; Sat, 25 Oct 2025 09:47:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Af90A_dFOI9Z
Date: Sat, 25 Oct 2025 21:47:20 +0800
From: "Yizhe Sun" <sunyizhe@fastmail.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 tmgross@umich.edu, netdev@vger.kernel.org, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <6d94833b-4529-4095-925c-63e2e2ba7b04@app.fastmail.com>
In-Reply-To: 
 <CANiq72mfjbiJDSz=n3BR1quNwbzYB1ZZhADDU5P3b0bDmGEk7A@mail.gmail.com>
References: <20251025124218.33951-1-sunyizhe@fastmail.com>
 <CANiq72=d0zXWAryVXHUKLUkcM_dPoC_uPM2drMXAVB7kh1YSjg@mail.gmail.com>
 <68b53c52-9834-41f9-8e40-ad27f00436a4@app.fastmail.com>
 <CANiq72mfjbiJDSz=n3BR1quNwbzYB1ZZhADDU5P3b0bDmGEk7A@mail.gmail.com>
Subject: Re: [PATCH] rust: phy: replace `MaybeUninit::zeroed().assume_init()` with
 `pin_init::zeroed()`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks for the advice. I've fixed the issues and resubmitted the patch.

