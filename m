Return-Path: <netdev+bounces-179633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92AAA7DE82
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76AF16A8B2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C924BCF9;
	Mon,  7 Apr 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dn9atQZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WrABPWEV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24715382E
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031237; cv=none; b=Q7zHZuxKDDCK5yR2AgO9XDdKKpesdLF5WNT9BhoPrjw7/A0Vc6yIKYoUfseWaHdrHjanlxijNUq1nnsvJu3xQKfFy2kNop8y0JH8kATLksjHcM49CU665pGTV6YMaEaFYs1TpFXu4DW0XyK81PsKIOC3BrhdBSPzS2bpnZtMg88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031237; c=relaxed/simple;
	bh=qLRSL2DCgQiGtlIJDKWABCEGoSUzkLHXeqejttMgI3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsORE6WCvBmtHbGFVi66GMIVabzseBOxA8m2wH6gyTMJrVtAAIs/M/s8Rfdqd1bEBhQ1/kG1IFOgibuTJMJmi3dMy76X27JU+vQu3M5+MWqvcofPUPhmq54F9PFXpufERdcuCx5YYC6gjDbkVVRZzQyv533jULCvP7mxbO3Sd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dn9atQZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WrABPWEV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EA131380073;
	Mon,  7 Apr 2025 09:07:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 07 Apr 2025 09:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744031233; x=
	1744117633; bh=Dz2oiJHXYIg14MzMDL3LNHU+nT2d0wOBZhB1v0XkQ5s=; b=d
	n9atQZSps9fI6El6nRl/aCjiZ6Z2d+/D0mEGv4g5I/timJbekdKSOSw7xysj+KxR
	Wq8FlxY/prfNHlF11j4GJnrNUzsPmBiU+lu4r3tyzy3fBq/JH2BOyGtVYOsQgLRc
	XnTOG2wV18LFz181UlHwg69PU712NjpJQv8fzqAChjS6v4VENVO7OPlczKGvczjk
	BZ6pl9oqcx3KXc/G5ArimAOCOd6KMWdDMFrBxPRUarcSA3eWXMCOu4iQo18kKMHV
	VkmJPQo7g19/n5gGhwT67HCt93SDQcQgxu1DKtvlGq6xH3JdzeYW5DpkHuEFgfAL
	GQ0jkrttH3jcUQ8/NO5gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744031233; x=1744117633; bh=Dz2oiJHXYIg14MzMDL3LNHU+nT2d0wOBZhB
	1v0XkQ5s=; b=WrABPWEVfQo9qdi9nNf1JSygjqe5Ijo7eGvHXLdyvqb2hD4nfIr
	gripAXWgfPMJYCrylBniSeifwWxcv+NsThVOMynPeCvxZgRCeO3G0Vm2w3e4dfc2
	Wfcy89obTwIdEbvuz8fU4cozv7gKoz1S+9biWAPqZXMqnyIzTUwXnu6I+HefAZcL
	dfv2nbv5FdQ1wHRhFmEU0Kk23XDXkhxZFh5To98DpDThd/+rN4nFHzJV8usHT8/F
	vaaVKJ2WsQMAMrLhZ4qh1C/BdaDZXxv5FJHcwXrYb/eRIB8wZMifKBsg1AB4VZMA
	1m6mvdwKM8UxPyd1U/+cm57nDZMJezkblhw==
X-ME-Sender: <xms:AM7zZyaqxmrn7W38EaXFRQcuHOUMze7YQNtyeInaLmUjSgNerxI77A>
    <xme:AM7zZ1aycgqtBtv3233TorNlbW_BYI5UgmooRs_8AVPGNFBFDTEeI9k8S-Mn0eL3x
    V_SusiwYoErmnABhPQ>
X-ME-Received: <xmr:AM7zZ8-Kt3FKc2TPnptUHek8kcJoWr9yiGsyJl8PoKgSsY5Jk95YHWohkoIJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgs
    rhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeghffftdevudfgkeffjedvieeilefhtefffeefgfehvdevhfejjedvkeefleeggfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvg
    hvsehluhhnnhdrtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhhnh
    drfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AM7zZ0qAkw9U7OHuurMJ5TjvFJsXG1iXTEX6vN-GHTqbdlDbP0aY2g>
    <xmx:AM7zZ9rfi9O4xhNESne8C6mn2cxLycy0Pfumwuw5xCOo8ixZ-QSTLQ>
    <xmx:AM7zZyTIiqfETik_10YaoWkZD07gTpCOhbLsqDZC6xMfop0rakwTJA>
    <xmx:AM7zZ9ogtTFNrLw-4-7hkH-Z5ppn0d-vA4t95EGfc3Fs8CFr7IOMgQ>
    <xmx:Ac7zZ2EG1xKy52fJ8NM1GwxylM2FocoXKNAQZKDzsFObSeJlMR-rcayE>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:07:12 -0400 (EDT)
Date: Mon, 7 Apr 2025 15:07:10 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net 2/2] selftests: tls: check that disconnect does
 nothing
Message-ID: <Z_PN_iBsuMvkoEck@krikkit>
References: <20250404180334.3224206-1-kuba@kernel.org>
 <20250404180334.3224206-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250404180334.3224206-2-kuba@kernel.org>

2025-04-04, 11:03:34 -0700, Jakub Kicinski wrote:
> "Inspired" by syzbot test, pre-queue some data, disconnect()
> and try to receive(). This used to trigger a warning in TLS's strp.
> Now we expect the disconnect() to have almost no effect.
> 
> Link: https://lore.kernel.org/67e6be74.050a0220.2f068f.007e.GAE@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

