Return-Path: <netdev+bounces-220844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5863FB49116
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D0C3AC0E5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1D227EA7;
	Mon,  8 Sep 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="gWkdIikO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1H0UAT8"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E411A2387
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341134; cv=none; b=WTECC/8cg/cxZe99qDVAqFBT8o0k869j7i9UvFYnVb5mpJOna/D4dERSeVSqqdRqsD6bAKmQ4itJSUcnBa5oKH5YuEQ8XMVFAgyxYb1ITmvTfv6/SdopEV/1twPpyWxIZeQ3QcKtFeBFycbdrMGbr5/LMLpH8cuAHEXGjiuFuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341134; c=relaxed/simple;
	bh=JPAXFUeH60Ubya0Ucz2DMhVHV51jK+X+sr724DiZLVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5tKCVzzzzyJRjQMrToVmWLiKDWcRUy1JkRJtRlbltjONI/v0VtjsWiOShVrvdPcY2Z1+726HtzISgYAR159/LXX9KNwnFR74YMz3fn2N3t7YhN3Y680+chHAErk6PGyZjJBPsxpUshKIiYIBAZK95G+3oRMiWhC1Ozpco+vFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=gWkdIikO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1H0UAT8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 06D927A003A;
	Mon,  8 Sep 2025 10:18:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 10:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757341131; x=
	1757427531; bh=JdhU01WHKgLZJi1xWWbcXnL00gmrpQKENTdptqePATc=; b=g
	WkdIikOmtPFNlOK3qQ9th69FEgWlkZyGYrqkEatYbdPjO6V8WwJVSFz5eyHuziKu
	b0UPHWurINGIDmDs6UmC2y23XCMawG0sCXXeQsOH8N2MWSSmySRijLM1leQ8v0G4
	J/n+blggeseujEET6O7vN87t2VBULRrEdpGKyaRJCd9Bl4Ncn63cypGIsXjH6Q20
	IJLKEsP33OcSFylp7ZRawgQQxFAdvlnMi1W1LOC36767QTV49J7DDmpOEMsocV2x
	ORfibVEQRHN7otF4+32KoRyv0uO+CUrWw9fhIQ3J1bwPAVV2x9tDNKlFRail9pmd
	aq8bKQ+0ry9E4GGf0FNiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757341131; x=1757427531; bh=JdhU01WHKgLZJi1xWWbcXnL00gmrpQKENTd
	ptqePATc=; b=Z1H0UAT8Jn3sY1Jgz3a3w/Uv6/nZtU7rgoK5bqM1v7issXl+3Ku
	Wm6jlRli5259hnFXfcfPMSF7ZTolMUDpM0czlxxx/0CwM2/hUiX+3iXhJbBnzQJ0
	fALzI2CW9ikg0XpZ+FBCRMKe+7KS+xtKC52AwNodcBCqff/4Yg4/Az6xxy5lMARm
	7oOqwIOAyL9jnL0cKo5By2RPyxU6RZMu27Hy74pJQW7nj/OsVhJC4FQ/WC5q7KO8
	M3cL3AecwtgrhAL8//hV79VPUobSlEzUv+5gTQ0Ygk90xC6nvXen4Wl/8A7harPm
	FjSrqhqIYMfz8Rbg5KTAUrh7BbPlUJ5ztmg==
X-ME-Sender: <xms:y-W-aO6hgWH2n0vh6ip5vpPbRzYuwkDvrJQgIdisbjO3eg7d7GCzhQ>
    <xme:y-W-aDn_uxpe0xgecQirHaIfvM7DUVG8kpNGVNVev9Ei9E-r2ABb7t8Zf2jnmJmMr
    f3V_DvT6cWHpkKEHhU>
X-ME-Received: <xmr:y-W-aJ7iWTA3EshgsWri87EU7D_BILGqQsGL8o3LfHUD28QDPORcPHHfH6Qk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhh
    grthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmihgvrd
    gsrghinhgsrhhiughgvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrgifrghlrdgr
    sghhihhshhgvkhelvdesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:y-W-aERJpaFXsdsdcBCx1WxlRb4jZqoHnOOT_XMqhCCFCgqZI_Y3RA>
    <xmx:y-W-aHzB5a4X8WOxK0PZCncUopCzFYfZ87d74C6neknpWOfLrz7igw>
    <xmx:y-W-aMoyuV3gFIOTIhFBSacOOFdfyztmzyQzoWpCoP5Qa7CNlpxJ8w>
    <xmx:y-W-aK0sJgzMqOTw83PKM0fkstPKUUjdCTcaeSW0kL7VPaotEXdYyA>
    <xmx:y-W-aLcY_0-FtRsiBwBXbpuUqK_UbaKZIGPdvN1jU5wvlHn_-i5SwLhK>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:18:51 -0400 (EDT)
Date: Mon, 8 Sep 2025 16:18:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Abhishek Rawal <rawal.abhishek92@gmail.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 9/9] net: snmp: remove SNMP_MIB_SENTINEL
Message-ID: <aL7lya6xuGnVxkiY@krikkit>
References: <20250905165813.1470708-1-edumazet@google.com>
 <20250905165813.1470708-10-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905165813.1470708-10-edumazet@google.com>

2025-09-05, 16:58:13 +0000, Eric Dumazet wrote:
> No more user of SNMP_MIB_SENTINEL, we can remove it.
> 
> Also remove snmp_get_cpu_field[64]_batch() helpers.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip.h   | 23 -----------------------
>  include/net/snmp.h |  5 -----
>  2 files changed, 28 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

