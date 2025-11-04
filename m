Return-Path: <netdev+bounces-235498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F6C319A5
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37166188F110
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA5632E159;
	Tue,  4 Nov 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DoS7/k/j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mc+0O2JL"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF23325487
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267390; cv=none; b=ZHAJZs7CY7dbMAqvgIGjVR4V3I++UskpWkAax/7Aq7k/Yak8K+Kev1ZeRhz8tO1v2SOQ9fw6Wn5ahfHxX11AZFI09Zd4kvOgIJShxgx7EleRFI9fyAErHICLJoKNPcVUAzd5zZT7Gbh3jkVpKJe5R31rctMANHmGKSTb5hEP2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267390; c=relaxed/simple;
	bh=jhguX79C9RY3QvJzWJC9tvIaqpB9tcuB3Ydkrhow7Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyZTayXIuw/kPYAjFr+MJvXMOQWMEQW+N5DfCoqwShlXYLafpPoP/DL1ZeLnPtiJ7dyw4MePlheaJQFj0T0FKnzINJs6nEOPPe8s4NnTLEI9EsPyWmtsibmc/iDXzVXlA8o5DQ7J9JWP5LPcc7VaS0HS6mizTIoDsQmVxkB+nxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DoS7/k/j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mc+0O2JL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 92CE7EC021B;
	Tue,  4 Nov 2025 09:43:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 04 Nov 2025 09:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1762267385; x=1762353785; bh=TpbeBaBfW6pAOxCvGLRslUuy+5l3AuXh
	hbUwHmHAmP8=; b=DoS7/k/jTFGCSH0vSqHWFX38Ck3Z+bz5wrToXHuqlqvzbgDP
	bXCCAZ6VDcsmVoYiK/rb4nxEpkAWdShagV8o7E1SnMuUgbUnwjH2CVqc15bolM0N
	YpKHXYHmUTixPQmIBZQ7yjHp7twCEX6P8+crrSrOsMhqs5w25/7noVcmvxjOJV25
	NMAEm4S+8Zi9p9+JSX0zvMa3C2sPTke8cVL2XE6KHjms/bTGjFXkRd0qwwy3jaTE
	w3SeoDaEugsJ0ZrpxSITBFD2b8ceXOUDttVmFUenO4M+VuQC64txl6ZYfyLDuHI/
	el+togRF3shgNb+kPiVWDos+KFXzchml7fsBqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762267385; x=
	1762353785; bh=TpbeBaBfW6pAOxCvGLRslUuy+5l3AuXhhbUwHmHAmP8=; b=m
	c+0O2JL9k4De3+J3oI8kSfbXoPUl6WHsZUV1KWwSe1DzgSPdbma7GUtjsiWduS0q
	fp7PrsLdsoOy4xREQbT0SvspKbmj834pVHnJSyFQL9C8r0ZVl4tLkHpSu3W2zMT1
	8I6D72L/s+OwuizFsRxvdt9eurIm3AE7tdZZSDI0Wyk8c66FAY1nnZuoFbqAlxJS
	HBXJgCnuEgLMkdjExsdRh1iJd8i+Ch5Ozdr3F8CNMm3ItLg/3j3I00vSUc1OnalT
	u1j1rLksDuUvQ/TKxzEMq9FqtcLisM870ASlGEXtQcIaJika4GZurypKWqfbh7Ml
	LV7ySo3CseOt2DOoTK5fQ==
X-ME-Sender: <xms:-RAKaUcBkRWvcYyBVn44MlP-HXSnrt0xut8JbUZOxN0DqYrsdAtDmg>
    <xme:-RAKadpMKecN56upq9uiCEq_eIlCc_WGrDArlk1_Wxt3ouiJ1vGugktYCpESStoWX
    6iq8piNm7ZoPFMichQmSO9WwTb07tXq7xFeEjZqN0L3HqmtOrl0uXg>
X-ME-Received: <xmr:-RAKaS6dF6H7a9zihjdvWt9lJ0Ibo8caWl9jRKw8rO0T8csk99hvTIa95GN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeduvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehnhhhuughsohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-RAKaTrEd4GzO6fbaZxn2DlxcsLhg_zhMMEwaL7vUa3f5s-VuagPGg>
    <xmx:-RAKaUgkJFY8lfz1eu6pVbDXyQdtW1Z449ZOWvGoDTXj_Oeh8EU8cA>
    <xmx:-RAKadKj7RJHykGEKipKiYjMOV9lWeBUPJfSBGiErluf8uVjASoZ8A>
    <xmx:-RAKaUB2yB_hKjrdqVX9Tin9-GB2eZgdS-Yz5DtjD2Y93g9HLAwS3g>
    <xmx:-RAKaaIhJed2cwoeRD7isWn232wd_hcBki3RBgPfFAzFSmq19_cZp-uN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 09:43:04 -0500 (EST)
Date: Tue, 4 Nov 2025 15:43:02 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "Hudson, Nick" <nhudson@akamai.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: skb_attempt_defer_free and reference counting
Message-ID: <aQoQ9pEKia_8Uuzi@krikkit>
References: <E3B93E31-3C03-4DAF-A9ED-69523A82E583@akamai.com>
 <CANn89iJQ_Hx_T7N6LPr2Qt-_O2KZ3GPgWFtywJBvjjTQvGwy2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJQ_Hx_T7N6LPr2Qt-_O2KZ3GPgWFtywJBvjjTQvGwy2Q@mail.gmail.com>

2025-10-31, 04:43:19 -0700, Eric Dumazet wrote:
> On Fri, Oct 31, 2025 at 4:04 AM Hudson, Nick <nhudson@akamai.com> wrote:
> >
> > Hi,
> >
> > I’ve been looking at using skb_attempt_defer_free and had a question about the skb reference counting.
> >
> > The existing reference release for any skb handed to skb_attempt_defer_free is done in skb_defer_free_flush (via napi_consume_skb). However, it seems to me that calling skb_attempt_defer_free on the same skb to drop the multiple references is problematic as, if the defer_list isn’t serviced between the calls, the list gets corrupted. That is, the skb can’t appear on the list twice.
> >
> > Would it be possible to move the reference count drop into skb_attempt_defer_free and only add the skb to the list on last reference drop?
> 
> We do not plan using this helper for arbitrary skbs, but ones fully
> owned by TCP and UDP receive paths.
> 
> skb_share_check() must have been called before reaching them.

Do you think it's worth adding another DEBUG_NET_WARN_ON_ONCE check to
skb_attempt_defer_free(), to validate (and in a way, document) that
assumption?

-- 
Sabrina

