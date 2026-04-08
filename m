Return-Path: <netdev+bounces-276674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAuLFcSa1mmyGggAu9opvQ
	(envelope-from <netdev+bounces-276674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:13:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE103C0335
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01480301DA44
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3D3D88E1;
	Wed,  8 Apr 2026 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="jx5O8buR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IlJBgQ+g"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF737F8C2;
	Wed,  8 Apr 2026 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671995; cv=none; b=jFNds57/AbE2vqL8R7L78L72gTWpjHnUI006OnKCwpRdKg/L7s5blc/0CHZrpWYmUsdWR6GDdpgy+YvETQQ76j8VDj3WeygJrLuOXeH+IF7LtxQF8wn8imoJQZvAoqqzbw71Qupv/JVCLJ6uTUr5KATzV0DCgL2FXOpr/YH4OVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671995; c=relaxed/simple;
	bh=EO9uR9gL4zxJdvZ7GrFE5nq6nH0pJjGS6mVLzWge/No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI0VotDETAPsvQ2+U6ExRBK0pcmufZci0AXQLRU8ExUzAF6SsTQWi7+a2cfw/BqRRQ43jD19kX3jererIc2So4DAVTgiuhVS8RulYwtFKahUIgbw5x6sLMOLWdhpXQvQBdF6WT8oYRi6C1yDl0gFrdmBF6YjBnBPsA8LNaMR5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=jx5O8buR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IlJBgQ+g; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 546EB1D001C0;
	Wed,  8 Apr 2026 14:13:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 08 Apr 2026 14:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775671991; x=
	1775758391; bh=aORdmq9g0FRGST1ZNQjnQoqdkV9zAZInE4Lq25KYBuk=; b=j
	x5O8buRNsZcBQOaLVqc2LV5s3W5EAhLYGpkJ339wZbe0m+9eqrmerR9Vjql6KO/9
	YrXjQ8Y4NPUEmokKHLOEQMgMiY5NiFMO3Xdyz9HcFzmAWVYyfd+PzOYr981SNo6k
	Kgy74pxHxB530mNv0FuEmglHdvxCpjIvgWrzamTGyoNumbaYYTyGy50esOSu3IIj
	KUHC2EMX9piyupZ/gew+TMuZFS0d5UOKU85CdvybgX+9hvTCV4Hh/f7ODMjmVT/w
	dk6n7koaXU9kDjrWenFl0FEyCIYRdf8F2Csc+xmbt2q+i2csmfeHg5U1x1U9KYKG
	dGo3FUsvIPFl4tWwbuR3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775671991; x=1775758391; bh=aORdmq9g0FRGST1ZNQjnQoqdkV9zAZInE4L
	q25KYBuk=; b=IlJBgQ+gMlvgv/EPomRc3VzxsBepyypHnAzUm3D+qpAi5DAnwup
	aO9gopZp3vT1nKyQTaANRmstjB5LH0KLfS/wT2wXuXFPh588Pf2VOF0ORZzHuYm+
	7L2rL5WyNbW2WfRI+3nWeXEPAbfPkgy+Y6Q0xZR7hJef8F/kW83gpBG9izxSao11
	HUrnze+klLch4BRUqLNpyzmZcKcsqL4rvRQcI448V5no5y0JKP5cdfDyTSbWXAAx
	80qsHCmw540U+jtPp1QzmT1rD4Ym5AvJKDxBGfTrZ6phfNacBI5j1ZehiRmlWjw5
	swKW4wpZUMsIgvpxbTcdHuV5zB+my3Ujq+Q==
X-ME-Sender: <xms:tprWaX0tOK2GHw3ON0FZXy0p8dQEcq06a9JfSCnB-JLH41wsAppZ9w>
    <xme:tprWaclLc_TRTzFlsVeuwiCB3D81DZJDwRi5I1MH7q5rR_lBkM5EppFYWolQIJ-Ki
    iB1EQEQN5fp87tqKLv4LWF5u4HDyeETkqjA3-CkUKnloAWYPbwWAhM>
X-ME-Received: <xmr:tprWaV7lY2-eWHVEFVvFWt6bAX-dFt-H9eVUPvLGO3cksPL7W13ihyTq3CPx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgv
X-ME-Proxy: <xmx:tprWaflo7THvUrkAxAG00RNGC_TzV5jl7LUGJAC-hCKvnNL2PGMoCw>
    <xmx:tprWaQVL37srs6kkCfroQWpSgoZizI_VZymSGyh3sX8xRcKVhi9rCQ>
    <xmx:tprWaYRi27eyLqxbNIJgrCYnypzE11z28qRs-Insm8mpFlETLmHsvA>
    <xmx:tprWadDXEnQlWnqT3GZbyn7_JCNPgDut68gHF5LNxXI2ZHrZoXSCbg>
    <xmx:t5rWaQXkJ3jss2oQGBEgELzXLCPARJwfS7I_MjiGYE1Wd6MDorAjjhIx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 14:13:10 -0400 (EDT)
Date: Wed, 8 Apr 2026 20:13:09 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, David Wei <dw@davidwei.uk>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v8 2/4] nsim: Add support for VLAN filters
Message-ID: <adaata9aKxijN09c@krikkit>
References: <20260408115240.1636047-1-cratiu@nvidia.com>
 <20260408115240.1636047-3-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408115240.1636047-3-cratiu@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276674-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim,queasysnail.net:email]
X-Rspamd-Queue-Id: 0AE103C0335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-08, 14:52:38 +0300, Cosmin Ratiu wrote:
> Add support for storing the list of VLANs in nsim devices, together with
> ops for adding/removing them and a debug file to show them.
> 
> This will be used in upcoming tests.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/net/netdevsim/netdev.c    | 65 ++++++++++++++++++++++++++++++-
>  drivers/net/netdevsim/netdevsim.h |  8 ++++
>  2 files changed, 71 insertions(+), 2 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

