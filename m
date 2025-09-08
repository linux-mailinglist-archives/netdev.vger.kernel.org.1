Return-Path: <netdev+bounces-220838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D460FB4907B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E58F166BC7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA792FE05B;
	Mon,  8 Sep 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="pbsm7LRN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BEcAbj+V"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C7309F1C
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339793; cv=none; b=mEcXPQ70j7R6dJIiw8lIG+xMIUdj6ujExkgUUrO2Pyp3tZzLpTMGBlr+thSxzqI2K/kDtZC79AV7jxvPB7THqcEU4fXlRoXi8+RnVv+RKQYt3EoJODigi/BQNlWiUlhb5Pmeau1YMW1HmHPMKZVR5sKTzsnRzOqqHNK00yvBYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339793; c=relaxed/simple;
	bh=P/Qp4PMJwQkKN7dvHFRn1VOoG9Jm6FArrpJAhlDl7/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGROidN8QfKRTPhil6spRA9PGmY/FHmHPNdwe1zNXTDllFrfI/d8m5gtc9LwQfYmNCL/Wzl0+ohkYkBEZ70VVGL16m4Upp3WOfinYzONFUZNgU0vJySNcJtTB9EvXGOvJ8btIkldqS5FkoSwoXX9NpXrwdUiklB6QM7SjzlDw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=pbsm7LRN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BEcAbj+V; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 015BA1D00093;
	Mon,  8 Sep 2025 09:56:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Sep 2025 09:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757339789; x=
	1757426189; bh=5oulMqZLQDHxyTha4NZUhen15SlcCC9UlTmBBxW+VtY=; b=p
	bsm7LRNJOHRDFenpY2d/lSNBjvJpxIs3j6UkfYRKsSZQI1+eV78rRcRLBl20FHRV
	wwKEyn/+O8UnkPN+Bz2Z6sfqb3VJFFcXn+oe03qP1OMJ1jATHpxTObVhVQTzSdmJ
	J3Mcyy0Xg4J6Digw0XLjTvuTs8PCLbZlHt3gMbNtTjKHkdXo7dUpud2nyFwB3cgT
	aCcf9RzIpU0/Ynnyt3HMrqIT18bzBcn82u4Gfjdeg94qcuVWBx9r25eqLW2/b6gm
	U1R0ukXahHBZZNaih4FD19uIEUHMicpDTqJSr5NcXap47LJs5Y1XLBoP/7OkcZzj
	26HTMDgoW3ScngRSgHP+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757339789; x=1757426189; bh=5oulMqZLQDHxyTha4NZUhen15SlcCC9UlTm
	BBxW+VtY=; b=BEcAbj+Ve3P5nstLS8NLgfR8/ojRY8cWt3qNLlQqN9m3sX19Oir
	bvDYZbTRzh8vfQrC7UozYS9MeqT4mCjFzTNPU4Q7gOQIkAY715NMbdsYgpJ3eUQD
	Q/WsCLhu4WRXBoUGN6nPvCgmF0QtFiqjXro/0O6HSE/ktFWwc325bWsiyAZy017w
	x/RMCcThGhqZt/WTAMxhxTaywYR8z26iClLW0Ik9JhIe6wk6dGoW8iEWFUsxcIDZ
	ctY+bTcWiwPT/nWUWfPavIvbCxm0I0m/osiy8em9XxxqFvgPDcp/QNZP9mf0+bW7
	W6o5FuUP4vqBpWLpR5I+/w4EVkzckvl5OTg==
X-ME-Sender: <xms:jeC-aDaE8ubDPY4kKj0W8Ocli9czgJp28-P5JsH3icUFXaTpPwKzmQ>
    <xme:jeC-aGwIJLaeTkw78V8IHDE6Iff_blemBVO5qpDEeWENbDM-_rgznQbZGoT8u3erI
    OKfEbHyq6PdQBsQ1sc>
X-ME-Received: <xmr:jeC-aD3bJosSXyWyISsVCrTb0-H-kP1_aMLkdN8CBrNIl1Ks3TKy6fvYOqjn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhh
    grthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmihgvrd
    gsrghinhgsrhhiughgvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrgifrghlrdgr
    sghhihhshhgvkhelvdesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jeC-aHm9SnGSVLK5uz-Z8ryUJXCCXSA_zENU_-R-j5Erv_1S76QBag>
    <xmx:jeC-aC80mCdG01nmGWMgC7sMetYNyLyApCAHjLrwxT9hiVn3sHrcjA>
    <xmx:jeC-aNJ_nUF0VeSRaBv7EVwCk2Z1rQpIbM3MegR1cSX6KWUt3NcsjQ>
    <xmx:jeC-aPiW6LRmdU5xmiWhQu53iX89y8Ng-A8BB7mR0GS61o82TwCnNA>
    <xmx:jeC-aGkzAGreqVutBA-Zmmqy7vgaYbXW6AICUl_otvYHWqinFH2j_sti>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 09:56:28 -0400 (EDT)
Date: Mon, 8 Sep 2025 15:56:27 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Abhishek Rawal <rawal.abhishek92@gmail.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH v2 net-next 6/9] sctp: snmp: do not use SNMP_MIB_SENTINEL
 anymore
Message-ID: <aL7gi8PVUX7bNOU3@krikkit>
References: <20250905165813.1470708-1-edumazet@google.com>
 <20250905165813.1470708-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905165813.1470708-7-edumazet@google.com>

2025-09-05, 16:58:10 +0000, Eric Dumazet wrote:
> Use ARRAY_SIZE(), so that we know the limit at compile time.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/proc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

