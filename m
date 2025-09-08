Return-Path: <netdev+bounces-220842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A99B4908C
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C42340A7F
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D270230AD14;
	Mon,  8 Sep 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="jN8EQCOC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eeag1BON"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A7219A89
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339929; cv=none; b=Ng4ALhIOrYv/JGJbq4YRKk09l8J4cxfRcmkcjRPPge7VTRFjq9QxIlhYJzU7vF+GtcfuVQ2OHMvzlZxYXSToKaHlduNIsxE41fRVhk9LFySwt6xbLauNPlHHvb3i8KhSVHAcYsgNtwbBsciqXfGXpge+RNtpuq+mH7l+yYfyiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339929; c=relaxed/simple;
	bh=7T/5Vm2GSLmxS4MfbLT/PrCMRegiAQQR0DbkEMSFG8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic+vMw6rUPHxG+aTDIMqYf258WVHxEdsSBCFHhnxd7Qk0KBWg8Y472GoybGmf2/Vf0C48HF1TQuPhhmlpPKdPdENG0cYbQU18IA+fFOl3uTv7o12zYxHzR5DVoQlLNWATZNekKLch5q7781RBxVMsYcd6kVhIvOE1gy/Rfpmc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=jN8EQCOC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eeag1BON; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 30B671D00038;
	Mon,  8 Sep 2025 09:58:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 09:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757339927; x=
	1757426327; bh=X1pGXCkc1si8BrIRakIKtaX8JymneSQdxBB8E7bIdcg=; b=j
	N8EQCOCUC8505D7CGJyXFVJlkpFDcQy0YoXIZa4y9/MGH/XEhp5e7JwXpN+VZYkn
	zJ9qFkERIlE5EERmhIgEnbEyHyUG/sVG4h73NzdgRWMzvaWZI1b6vPlFdnyUL8zP
	XgyRyhpu8zQmMkPzXCjyuUY++hT76eW4Wfi/jTbcmtAA3YIrFGQluTYbyOnBDKRr
	lCY3EEupJLnezp6gqzhqDCTqyJHasXKZkP1MOLqdaMX2lVgQvFx5wJ5J1aNMWtQB
	YmtnxGnl33No8ysaoGKuQPEtX6fLCx32i25tfMSJ95LH+7RD0zqAIHrM1jsYUe5i
	MiABUN4big0QupcFovLYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757339927; x=1757426327; bh=X1pGXCkc1si8BrIRakIKtaX8JymneSQdxBB
	8E7bIdcg=; b=Eeag1BONRPPs5fiiBfxF8kFmfTDOYugbHnhTav8j6kzuJ+KmC6H
	BMyh2BbQavF3CaREr8+Gi/gWYxMxg0sY5DK/+tFHLOdpmiQL6FX1/mjhHWRsK7sV
	Y0xjIA/MPLNDNTgo5eU5IvD7/T+FMDkp8VdmyxOjYei3OM8vwo1M233ISSjslK01
	CVISBOUKCl4ywek0zDSRRXT9ZEJAVazJeE/og9UcR56mDgHspwgzPVgg/x9lkiIP
	fq54AWJTCul8Z67d+YZnIgI6+nxdjJJEaP3PqxQlPHjCLFB5brgbJq8yDHuldVac
	N1tH554a7NV2AkwddM3lc8IdEVC8AVE9N/g==
X-ME-Sender: <xms:FuG-aPFbCFxe_gasyCsRFBCkV-XosXJcGfudu3NkTci01-9vnLJmUw>
    <xme:FuG-aMBt0PvguKneGgFZiy8Xf9L7kU7n3NAduFyYoLsbqvDFyGmk_V5gLTDNLwXb7
    jLKE01UTCw3nuOE3ZY>
X-ME-Received: <xmr:FuG-aMzA0YkHRVpsQBh5yk7avoGczmSpaC_OJQvcw11I3e27JzUZPQyDDBpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhh
    grthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmihgvrd
    gsrghinhgsrhhiughgvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrgifrghlrdgr
    sghhihhshhgvkhelvdesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FuG-aI6i5Lwyo84JRdNpoL7cWFt7MmMUAgAv8bZWEZHxooQcHss3Wg>
    <xmx:FuG-aFydMc3iEROrNWuBQ33VxB7KZdCoz7iYtuwTy3lzPQTszWFq8Q>
    <xmx:FuG-aEfDG5rWySG5-DVBUhIQu5QEblCkjQKqF4WCxE2q7Fyav46dOw>
    <xmx:FuG-aCBa6eNjl6B89-a9i98zarILYrPo_uczAu0pY_eIK6ceqjmLPw>
    <xmx:F-G-aP82ARTIEqYGgQsUYD9XKS6rfHT__atfTwcX5ujpJ_mzQfTsiLfu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 09:58:46 -0400 (EDT)
Date: Mon, 8 Sep 2025 15:58:45 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Abhishek Rawal <rawal.abhishek92@gmail.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v2 net-next 7/9] tls: snmp: do not use SNMP_MIB_SENTINEL
 anymore
Message-ID: <aL7hFRpBXmIS2-8k@krikkit>
References: <20250905165813.1470708-1-edumazet@google.com>
 <20250905165813.1470708-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905165813.1470708-8-edumazet@google.com>

2025-09-05, 16:58:11 +0000, Eric Dumazet wrote:
> Use ARRAY_SIZE(), so that we know the limit at compile time.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/tls/tls_proc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

