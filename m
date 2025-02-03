Return-Path: <netdev+bounces-162124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524FAA25D47
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D836816A978
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663CA20AF61;
	Mon,  3 Feb 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jakemoroni.com header.i=@jakemoroni.com header.b="TAYuZSXV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePwkN892"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5A520ADFA;
	Mon,  3 Feb 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593296; cv=none; b=BYAJfOKd/jbOqgjed6qXgNSTRnWAMLSh0tJY5Bcy53JyW6ZpVMVnve/R6tpUJOPQNvCLJvQDLTJ6x7fNCmqmy2YrWofxcJ+ZYpTS3XoSm0vlZsCbsiz07q244HVgPPjREI90G/2sdVjEIv65KeMEOT0JgUH9XYlmDWA7KCcEYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593296; c=relaxed/simple;
	bh=1E3pxPAJYhWiMdzSHrs517J4qDoMDIW+VKdv+Dv3IZo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Nrl3tjZ7ooq27cAIfklBmMBZEcxpv0jPxEeBgOuSFcPQTP+HzJjytFgOdQpqU4yr50EcxmmWEvQvvR6WSuaYrmY6wBRtp3xiqV7mhNiuTfjCkVsU2rkM1ujEv+j55ANnJxA+BbWmgTHhNdVBYkxvVnjT1XzajoJaAev6/eadyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jakemoroni.com; spf=pass smtp.mailfrom=jakemoroni.com; dkim=pass (2048-bit key) header.d=jakemoroni.com header.i=@jakemoroni.com header.b=TAYuZSXV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ePwkN892; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jakemoroni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jakemoroni.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 16E7B1140127;
	Mon,  3 Feb 2025 09:34:52 -0500 (EST)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-02.internal (MEProxy); Mon, 03 Feb 2025 09:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jakemoroni.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1738593291; x=1738679691; bh=1E3pxPAJYhWiMdzSHrs517J4qDoMDIW+
	VKdv+Dv3IZo=; b=TAYuZSXVFCbB4BnrA2KtTjkhMaqaVPkm9P+wbAz3XAcaZVff
	FgEIpVIlZ89UTHJ/wLfzQhtw2oJ39bTiiwj93FCN0Xj2WYbNrOFpExcP0/DGkTk5
	nUf/S2juw91wuBzUvwOdkchQAsoYt53Q9vZ9Yxf8VUQ0w7DoEMguiQgkQ3PqrhxJ
	qzvSScn9rxOzbp6PmdpcXx5G6X4hSj9BHeqcmEBwuyiWnN/Zl2eR4NKxgmcCwzBI
	LwWLE3vokoPgLamQM7+mtP/zdvZ01Mr0Ycro+SqEb6XmljnigHWrWyQY382ZXdV2
	hGRORriikJxEx16tgYl/FmfpplRInpu1J7LDFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738593291; x=
	1738679691; bh=1E3pxPAJYhWiMdzSHrs517J4qDoMDIW+VKdv+Dv3IZo=; b=e
	PwkN892jOXvpNCc7D4O8zYC0nlDS7r7GdzPi3ZnRvpEEfG2Fiqc7XqORDe8IL5wi
	u/O8GzpYn2Yci1IJsZ3MzncklP1XqqSC+BrHn7BoIVhfAV3ZFKVFhArkyxwbucaI
	+mGImWClRtmGrX5AXq05OohKrDOF6dHnkWezn2KRceBEz9bBC5DUCs6Ko08paNyt
	38tLPLSZeNq+KxNIPHRtm/ACelAwzfxeHVJ1WA5je2VeRZkMomuFDVjICPKYCSBz
	X1suqRMHVxj0h7bFdPhz9Ovkl5IpjkkgggkSF0yvo6G6wYtl8wvvQ/A5tqi0Nrio
	pxIR546xUBAR4qkoMrJLw==
X-ME-Sender: <xms:C9SgZ6afau2eqdoLUlLJKNofjIs-qolj3wuIaKdQCc457FmR7JeUtA>
    <xme:C9SgZ9Y500perdaVOjFyU6CVU_dG7rtMpNBVqRtRNAfkYe3aZoWghJXQRt1ZMozk5
    Hy5yemWNIe3A6-tzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdflrggtohgsucfurdcuofhorhhonhhifdcuoehmrghilhesjhgrkh
    gvmhhorhhonhhirdgtohhmqeenucggtffrrghtthgvrhhnpefghedvhfdtfeeggfduhfev
    ieelvedvjeduvdehteetvddvhffgkeejtddvkefgvdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghilhesjhgrkhgvmhhorhhonhhirdgt
    ohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivght
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughr
    vgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehirhhushhskhhikhhhse
    hmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C9SgZ088jn7DwNBZRLaxkaJtQR4HVfx49suGcFud0FA6Un5SZIn3HQ>
    <xmx:C9SgZ8oTdgwOm19Ipj1ezQ1Q6aGjpc9DZRvCyLiZvtI8kwmThYFvRA>
    <xmx:C9SgZ1qtiQomgtbGobm8XYpQpsRIgDrfQHlYQmDyzxArL_l4nMPYMA>
    <xmx:C9SgZ6RHPIqsEgKHhh7d1gOgfsMk5YHrJ2EULdOwsPf4rypOZsFsmw>
    <xmx:C9SgZ5fWEGounURrBt0xMewrFY15fSj-iWTjFT6PwZEFOuORVQ_g8VPn>
Feedback-ID: i17014242:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4BC423020083; Mon,  3 Feb 2025 09:34:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 09:34:30 -0500
From: "Jacob S. Moroni" <mail@jakemoroni.com>
To: "Simon Horman" <horms@kernel.org>
Cc: "Igor Russkikh" <irusskikh@marvell.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <fc757ba1-1f34-4a13-b7fd-e3dee7fd0a16@app.fastmail.com>
In-Reply-To: <20250203100236.GB234677@kernel.org>
References: <20250202220921.13384-2-mail@jakemoroni.com>
 <20250203100236.GB234677@kernel.org>
Subject: Re: [PATCH net] net: atlantic: fix warning during hot unplug
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

Thanks for the feedback.

> This hunk, and the removal of the err_exit label, seem to be more
> clean-up than addressing the bug described in the patch description.
> I don't think they belong in this patch. But could be candidates for
> a follow-up patch targeted at net-next.

Makes sense. I'll send some follow up patches to clean these up.

Thanks,
Jake

