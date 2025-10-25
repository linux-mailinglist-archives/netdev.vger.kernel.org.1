Return-Path: <netdev+bounces-232810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61C4C0908A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 14:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9641AA7F4E
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83F2E0939;
	Sat, 25 Oct 2025 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rzvGIrvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVhyyA4x"
X-Original-To: netdev@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B81419A9;
	Sat, 25 Oct 2025 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761396644; cv=none; b=FAxS10xPwGg8Y9tL6aiP8o1URYcpdH8gK9UoeM7JRKXhisKOLeMKtX6GY3zjULeOryEdBNw18AaxI0w7ZQwdareeySFHBomQN2zFMcpfwqUcF3+CfJmBhrtYlJkwHdEJzZ19Z72AhPL7MX40NBbxxjz3ONT07cCPDD+3TWkN4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761396644; c=relaxed/simple;
	bh=yG712vw414D5AtL6ZYP5lsIGRrMPveLDAiLIP/Pt66s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kXlZ90NaZvrlhQL/lpZ7vf1RRiJCVDSHUVsWOLbLBob3jFym2SIkbDsBz1YqkewNGgNhcNdXfKWWB4nuZqXbdqmt5TvVNoatlnzRq95GiEhnxUVTlxm5EGePKsbkLXPMY1CLAU9dx5DN4iI+isp5zTtT8Ny+QwMTmVuynuYCLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rzvGIrvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LVhyyA4x; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 4559913004BA;
	Sat, 25 Oct 2025 08:50:41 -0400 (EDT)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-12.internal (MEProxy); Sat, 25 Oct 2025 08:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761396641;
	 x=1761400241; bh=yG712vw414D5AtL6ZYP5lsIGRrMPveLDAiLIP/Pt66s=; b=
	rzvGIrvFDc/cPLlWYsZx3yPRoR4GoW7sDqdwuammobq7uVloJcs/98+RmhfnPw7o
	ZjvCxxzOpH212G6vRv3MdNJo9yspgERsj6bLLVMPh9GEZdav56X8OfPuqqq1uA7Y
	CMdLiidLF0Hr0P/tjLsLtc4n6fhlALOWVspd6XHkbbny9odqthggzEGbNH5+8bId
	FN4m/EK6hq0/i+lg9+dx0vNYcLOCedd4QO9q/yXrn+j3AEa3phb4hXeijsjNgWbN
	SKnecYV7C2NuFZ7gvPPiUf/TvIhx8b52GqtCWxKFB7SkusMfL3w14oau/CsWEFvu
	Mv+7z4jBTsC/l3+83gniyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761396641; x=
	1761400241; bh=yG712vw414D5AtL6ZYP5lsIGRrMPveLDAiLIP/Pt66s=; b=L
	VhyyA4xfMCU0jWBKv+LfGxDfEG0/Z6oTDql2qnJhZYm5KubETPNB5I0wGHupjKpp
	KEaDDZC+gDajD4Eao6fL+Klmr4NQ4XHAg1w4ZLaeIahIKknuFzTKOp7HO9N90mt5
	SogY2Yym8WKdXPX37igS9EwIkNWjyE2Yd0ZrhpJw3Y7jA+BxHeG25W1jlrJgJIDy
	w+7HdEmav8rSsndpZOX1eMp0QxDhE8nRPtQb+Y6R/iGTQ3ujLEWkVWlMzXVFtajw
	daNXJgrs2KuYTVC3CXMkUn8PxiaDPvf7buiq3bF/8BdWhJ3xDIIVYYykH3D3fl0u
	dhs+F1iQ3kNXBxvFH/fog==
X-ME-Sender: <xms:oMf8aDLHRZJWt96F8JUlxxrjnsdsN1hdNc-u2lEM7nF_upeZihTMsQ>
    <xme:oMf8aB-QU9Lse_ezumgpIMoP489z3288BJZaZvUYSipVNEoJQHaXOT27_c-2fgYZH
    CjnP0meu-L17RfG0UHaN6YvtVfRR7iR1_Mdbg9ARXywrWtjB5nkZy4p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvvdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:oMf8aCMRQ8CdgaXO8qKWnvkPNgipwEIwhMSSoOna2MCWPGswqHwHmg>
    <xmx:oMf8aBYx4ned-pknjqt_kU6w8p8jBPWQsgAzyKUUO47x_CvD5aPfsQ>
    <xmx:oMf8aJAalPjV81FQGXXSGont4yVCob03Uo0hIxkPyZjBhr_dqD_0fA>
    <xmx:oMf8aPF-PpoQMxoP6b0kv4aCld2yVmg5VcllDDbcCBsCYei3erv94g>
    <xmx:ocf8aNSzPTMrfYcsX3JI0wl3YOL9ZI1I8OKVqlQIE34rY5qBq2r-iET->
Feedback-ID: i1736481b:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 79ABDC40054; Sat, 25 Oct 2025 08:50:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Af90A_dFOI9Z
Date: Sat, 25 Oct 2025 20:49:43 +0800
From: "Yizhe Sun" <sunyizhe@fastmail.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 tmgross@umich.edu, netdev@vger.kernel.org, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <68b53c52-9834-41f9-8e40-ad27f00436a4@app.fastmail.com>
In-Reply-To: 
 <CANiq72=d0zXWAryVXHUKLUkcM_dPoC_uPM2drMXAVB7kh1YSjg@mail.gmail.com>
References: <20251025124218.33951-1-sunyizhe@fastmail.com>
 <CANiq72=d0zXWAryVXHUKLUkcM_dPoC_uPM2drMXAVB7kh1YSjg@mail.gmail.com>
Subject: Re: [PATCH] rust: phy: replace `MaybeUninit::zeroed().assume_init()` with
 `pin_init::zeroed()`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> This looks wrong -- is the Git commit under his authorship?

It is. He requested to have his patches re-sent because he didn't have time. This is my first time participating in kernel development, so please tell me if I did something wrong.

