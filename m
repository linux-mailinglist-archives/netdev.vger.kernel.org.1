Return-Path: <netdev+bounces-205463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9A8AFED47
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8B81C81CA6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9DF2E5B1D;
	Wed,  9 Jul 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JxDcqEzv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0tTVn46"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB472E5B08;
	Wed,  9 Jul 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073818; cv=none; b=YuuSTYAWC35CZsLl8k5SfezyhztRbOzJSsmRzXdRLTI8hp38QaceF5DuEPtyH24S4nPUE2vTMUdJ9LLNWhb/0eMrOSraON3FaCfUW+J1mKgY6H4Kay48GdGJABWtyv/Ddr1py5RUm30vCUdKMs7tId2Zsq0cY6X+6pCp84P2lMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073818; c=relaxed/simple;
	bh=6KPk9gX0N4g1y+kXe40vt25i0WR5nIQPtF5P+dXsACw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=agoj2mqAhpTRAgnfjK8SJjpLuVdsgTGEkv3geC5Q2pTAoPcIITF0NUXRFJOH52P9Weqi/85jy3tuB4CdDabpvdF8mZn0oJlhluUT5Pqs5jUTP0sHCjrZM1ko9V1OuiiAyMfc5pdNapKKed2cIgD2RrQcV+l7Bk1qcy/YPoCt4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JxDcqEzv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h0tTVn46; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 116AB1400231;
	Wed,  9 Jul 2025 11:10:16 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 11:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752073816;
	 x=1752160216; bh=ozW881If3k6V+hBTaaiOBieSoQJ/HAlXo8Sf0TRMG7A=; b=
	JxDcqEzvNdURgBp39sLI36MaS6e/V9LBtWwom2U622I+rv/LrjLPu9qnyUjezK+T
	73SuD0lTNoZYa0Y2hrCR+Butrensr+czxuR8M9A5MbYLAycpllqG00oCxBE632EQ
	AtAiv1y9fSQrTRcI1upMBXlrHYXUFYU8kKPa1thMxuJwhZJ/HQNo5ED37iUfAEsa
	HB9zbo5SzgkbsJi3jekDbaPa9bZHDpr5wOfcXzmV95dyWJJEXNvjX2t/cAnXpXBO
	cru6qBkrukc06Xl00AIVLdRKRd4h6uf2piyygjE+8r5cXcY3lxjmjVwgyqV8EP8E
	Dv9oCyAfTLgVntQja8g3vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752073816; x=
	1752160216; bh=ozW881If3k6V+hBTaaiOBieSoQJ/HAlXo8Sf0TRMG7A=; b=h
	0tTVn46qDf05YjXpQzSQEGCvOGzb9Mt/YF/tN8nHG+rd2HZT4ZBp9IDtXfrKqsbz
	4VjI6s2VjhYhYpVOF4J114KJJycYWlxo3nTMT4gL7+2DyDJNtyhTlcEg0nuegqTO
	Cps3ciec/uI1kgnu45SnmZXaft+vxdyDTzPcHPW8AEcKnrexav4wPo7s4fuPyP+3
	YTITAyL3LXgXHeHXYcEH8znQ8Rxg5Xft+XC0CvY7wA2zxouqYtm/vjirxNLyr7Ym
	0Vm6gAI7CNBERz6J/1/Xn3DivWRPHaGqWPQ5Nxt9qm8Hmm00zQ/UmXKhKLKfnpNY
	eRyQzqlTcgupVqie/yMVw==
X-ME-Sender: <xms:V4ZuaMb1vGqVW9Golg7WYtgzNrLaQ7HwqaaWqVisMteTEcpTjpEe4w>
    <xme:V4ZuaHalwsUoBNsebFmUAk3CJwIPdLginlot0r0La81mdTjaJZOXvLSr4n8Xvqhwf
    p9J9aEMOwQuVjFBgyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    hjuggrmhgrthhosehfrghsthhlhidrtghomhdprhgtphhtthhopegvughumhgriigvthes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhriigvmhihshhlrgifrdhkihhtshiivg
    hlsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghjuhgsrhgrnhesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:V4ZuaOPoHEzuGUC3Qk6rtzvsS8DjjfPHtT1UBQyyd3d22d76iZsmSQ>
    <xmx:V4ZuaL4f-oDAx22YyzK_8Gyz9N4eYdWqZz2TQgGY7-fsiF7--ArvcQ>
    <xmx:V4ZuaBWr1t1O62xwptB5nL8p3MJWbPFVT_QCwq6u1LaRUiwt_PHz2g>
    <xmx:V4ZuaCMmW6CeiEYTRQ7chXGG5jMQuEWdQvodN96qSeQU3OZv0SmPmw>
    <xmx:WIZuaPYFlY_2N7dudKCZ3TVcycm93R33Br-XNXoGC23OVJsHI9ob-bqs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0F9E9700068; Wed,  9 Jul 2025 11:10:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T23b105cc3acdb42f
Date: Wed, 09 Jul 2025 17:09:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiri Pirko" <jiri@resnulli.us>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Carolina Jubran" <cjubran@nvidia.com>,
 "Tariq Toukan" <tariqt@nvidia.com>, "Cosmin Ratiu" <cratiu@nvidia.com>,
 "Mark Bloch" <mbloch@nvidia.com>, "Simon Horman" <horms@kernel.org>,
 "Joe Damato" <jdamato@fastly.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <2d415391-82fa-4cf6-bc9b-ce845596a535@app.fastmail.com>
In-Reply-To: 
 <dugteasq4zxwqww4hepsomjga4rxpyk76p5eudk7yrs74ub4vl@cusxvnvgmmtz>
References: <20250708160652.1810573-1-arnd@kernel.org>
 <dugteasq4zxwqww4hepsomjga4rxpyk76p5eudk7yrs74ub4vl@cusxvnvgmmtz>
Subject: Re: [PATCH] devlink: move DEVLINK_ATTR_MAX-sized array off stack
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 9, 2025, at 12:05, Jiri Pirko wrote:
> Tue, Jul 08, 2025 at 06:06:43PM +0200, arnd@kernel.org wrote:
>
> Isn't it about the time to start to leverage or cleanup infrastructure
> for things like this? /me covers against all the eggs flying in
> I mean, there are subsystems where it's perfectly fine to use it.
> Can we start with frees like this one and avoid the silly gotos?

I had so far resisted learning about how those actually work, thanks
for pushing me to finally trying it out ;-)

I've sent a v2 now.

    Arnd

