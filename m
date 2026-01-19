Return-Path: <netdev+bounces-251171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A098AD3AF80
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95673300722A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D114435A955;
	Mon, 19 Jan 2026 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="u4iPjZmL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdYfZQRs"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61326D4F7;
	Mon, 19 Jan 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837674; cv=none; b=lyjKAHAQ03Mx39XhIVuMgtCDI/d2K8fn7+OgkKNWqRn6zCTxisKbySdiiWDmYBlM56W+6m8O4GFsUQmy3lJUdrh1AH21MqfWwZIoIH0dMhgXtXKxKtHOKopTqS+sq4g/NAtZEy+dwBnxTKdBqiAOacunDJTG3mnPrAV36e50j0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837674; c=relaxed/simple;
	bh=3n+aMrybGK6RbNqVpIj099xwp6WPmN9y4ds7bG9BiP4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uU1TIZHT5rDbw8TCqzAFtOMSwcKVqJstAnQ5VbwcYrwd+6/9vW0oqKz0EyF5dO8qBOICHYvR0o3hSeeB/6BlZYjXvU7Tq0Be1DH6X7NQ9q46X9SCFWWAvYZKgOSup+4KlGq/R1A9mzDnNFNohRtcqAY7t0lN9hPbrMxgvwktf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=u4iPjZmL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IdYfZQRs; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50F6514006A0;
	Mon, 19 Jan 2026 10:47:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 19 Jan 2026 10:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768837672; x=1768924072; bh=3n+aMrybGK
	6RbNqVpIj099xwp6WPmN9y4ds7bG9BiP4=; b=u4iPjZmL1QDl7xZyv+fdQDB1Eg
	IzvRHv5sbZ1qPNaUPAjjLMsRQX/cwcNvu3I0TVJe5DpUaGBmUppb/nmoXsGVPL5k
	kdfVeIIDBnLwCiouiT8Y203tWuhgXbKxW7dFes9/U19XqVAzvlAzQyIPrW21Mc/y
	9g09tGRgoigJCVLzcv6uTtzm6g0Girqpx1fNWTlcymdmh1E0+Zotkac659HhJOJy
	sXHdQZpSUtTEs28wiFu9Xarg2f94d8EsTbbQRtkEtrCNtjDFOjXu+P8O8nCoALJr
	U9f6buROq3ZpBEQv3C85TCHXZ4TNwe/fAVCb9RmSKFWcN+8twEHqEQmJeUOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768837672; x=1768924072; bh=3n+aMrybGK6RbNqVpIj099xwp6WPmN9y4ds
	7bG9BiP4=; b=IdYfZQRsLpGglcz/caQBojI+VEFw5YbjXPhSolcTRGNqEsFtM6W
	BkPKlugCY5kVkqu+9MOpK4CQOK4d849hQ1RujyRQH7nrBNK6FmxiZHA8jUNc+hTE
	TJKpOXOqE3k6ASW8vwB0OWe2eBG3+ZVZsafLEdstJvMW7/8JeHiVrtrrgetg6MlB
	gIKeaxYu3pNAS7V9tAOhQGgEUin/CpXy+aqX25iAOg6QC2Ojy39fW3zqqbpy/MhA
	gO3+p5EvXbw0C1HVS7LTON5FSWeQLCavJ67eV1gRvQOw0emyEL+B6YrvhbW+dOkw
	wZ7piTaj7kpX4lYYcIMHHoAh/AV8DtHa33A==
X-ME-Sender: <xms:J1Juad-XLh-t0xdjx5wbiUjfA7ZJfvhj3tfzpY-zx2J79ZBTKA16oQ>
    <xme:J1JuabshxvuvPJdUFFSMWZCqISjVjnKUTdCaMLnBhA-r8GsPfuCcwHOv7NahMF82p
    Y-qORom58yYdmN4rLzEpeT9ycRi_5f4QMXFdqEtvfSX2DmMdbFwa60>
X-ME-Received: <xmr:J1JuaRrtTKDwwdRgbiXa_wssM-jh9HJcmCPYyGV-9jK1GFnvd3vtI-aDFDuK0121Xo-CAmbgCEr-iecqLwBOcUyMNaOtJr4jfcRf0rbp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefpihgtohhlrghs
    ucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrh
    hnpefgvedvhfefueejgefggfefhfelffeiieduvdehffduheduffekkefhgeffhfefveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtoh
    esfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvghrihgtrdguuhhmrgiivghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuh
    gsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:J1JuafpNdl7LOYjOLyoFoyka_osWPf3U485Mpap9Web_27258dSznA>
    <xmx:J1JuaQYgqbMjpiaA7TL88ktFtfx7aCpQyDo-MgIUF2hOC2AVGXooqg>
    <xmx:J1Juad_mA168yElqmp97nQWFl7MHUp-4IYEvJ_UqffI5BLNEOVw95A>
    <xmx:J1Juael7x0e5nAutEY_KkNn2dhrsrYsWi9f8oFwjsxDtIx0e3BjzKQ>
    <xmx:KFJuaW9jMi7Nvq2R-NJ4O48E6Cbg2P2JfpMvqGiVjqQr-d9B7Qt-jwfX>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 10:47:51 -0500 (EST)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 2C21014FCB7F;
	Mon, 19 Jan 2026 10:47:51 -0500 (EST)
Date: Mon, 19 Jan 2026 10:47:51 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: David Laight <david.laight.linux@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Eric Dumazet <edumazet@google.com>, 
    linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
In-Reply-To: <20260118225802.5e658c2a@pumpkin>
Message-ID: <681985ss-q84n-r802-90pq-0837pr1463p5@syhkavp.arg>
References: <20260118152448.2560414-1-edumazet@google.com> <20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org> <20260118225802.5e658c2a@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 18 Jan 2026, David Laight wrote:

> On 32bit you probably don't want to inline __arch_xprod_64(), but you do
> want to pass (bias ? m : 0) and may want separate functions for the
> 'no overflow' case (if it is common enough to worry about).

You do want to inline it. Performance quickly degrades otherwise.
Numbers are in the commit log where I introduced that change.

And __arch_xprod_64() exists only for 32bit btw.


Nicolas

