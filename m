Return-Path: <netdev+bounces-225719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FBB977ED
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92BF19C6A72
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1120030BB89;
	Tue, 23 Sep 2025 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="p2RpSxy1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjYOQ1x1"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAC330B534;
	Tue, 23 Sep 2025 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758659286; cv=none; b=VBmK48UGepQ5+LAMtbVEd71L4rxYeJwdxjSUaW9Ghwwf6tGiQyr0tl79l9VHD7tu/tAyWhT6X1yKx3KLtO2/SYtYirmURhfnXsjunGDkT3abasEmJRd0NRpX/WNtio9QiiTxhimzTKa0kXRv7jTaPjg2jgMJjhsCPKSTR2cPkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758659286; c=relaxed/simple;
	bh=ZDi3YhpgKNuiA8C2o6Aww9+GP/AQl7UZ/GJyo6QlrLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieow262auTV3xTRrWn+UM4LlN06ika5eGAff50Me57ZvHlFjrxhp0/GwgUW8/ilwG959j+6RuRMXMw3Pv+qDWACYwusE5MT1nrzR/SoyuBsZLvDLujjE0c8jTZ0OI/OK+P6ovvAlFsDA/L/pLJWZCrroiNTdlRZmerw6Dne1DmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=p2RpSxy1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjYOQ1x1; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 543321D0032E;
	Tue, 23 Sep 2025 16:28:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 16:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758659281; x=
	1758745681; bh=TAjwu2nTa1m1E7lea16+hYCBQe7X9QJZoSoAAakz5Qo=; b=p
	2RpSxy12FwYvIlO8s7l9U1plKdf+JfOL/b2JsA8vP20FQgz6J3MvfkGmpvECdJqB
	YxJk7lw4B+NoBSDdOVD+fMj0mpPlEwPdOA0UU4ugJLpfPlmSzdZxT3dTsFdZI78h
	lWpVKZurNDeJ7LmD0X+E/IBLGocOLeicF3hjL7zOmw2LLsBiWaLFZ98EmpMtU4j6
	tQyJpMMdomuzrHl8+M2QpqfJ22Ih9KoTw123lhQMYJQWmxa/YGKglfw2nWd8SYVE
	xk8D24WwRzY0/WOz+vPZvWKrZdQK/qelYGhKTN8jXS43ChDk9x4FRjO5vt0Z1W2u
	Vs+4wF0qpryvLokXMaI7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758659281; x=1758745681; bh=TAjwu2nTa1m1E7lea16+hYCBQe7X9QJZoSo
	AAakz5Qo=; b=BjYOQ1x1PXxzCHMYNha5rFMKdbSDyZcwGYkVpdQC0oaQ1f9aHbp
	+h+hN1nga4bn1PUQldfg3Axb0KD/bVgPy0FLxKsljeZH1B5Z0xUU8cIN/EzFZKE3
	Rd4vq1hvDME9Cv+uiq+9RfaYdLztQEyKBPLjPjyaauCqSdUU1XgyGtOEWTWrDlC0
	BCMnXKOqb9RWp0OBuO0Mtci79XH3VfHjQ1HwNn3U4anXuOsCMK8Q2PCInbUuNLat
	LAyysDQcgcxGHV7q1CxqE/tpJCFVPmZT0T08V9zI3J8aWW5Cb/s/fOxdDynmztI2
	UsTkhtr6J7CVNXolDoAIx1Ej35tbJ5NNAgA==
X-ME-Sender: <xms:0ALTaG8k1On13dYK0bM456ecQhYwstoYLkR_v8FJv-Mb2bKt6YLT7Q>
    <xme:0ALTaCkQSPc5GxskB4WIi0qTvEhCJ6gpIk5qoe__B8iy1LFLPBM4imu0W9LXQPWQ0
    yFBXzKfCvl0WQnviyfBSwVTiwyhL-jGgFsxszwlqMh_MeKMQ5-hFEc>
X-ME-Received: <xmr:0ALTaJDSykt--mvZfLnqGAltZ5M3cVtCZqX57ZsEg2EbEHVqJyh_dU-qCRTa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehguhhsthgrvhhosegvmhgsvgguuggvughorh
    drtghomhdprhgtphhtthhopehguhhsthgrvhhorghrsheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghv
    vghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    hhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0ALTaDVyejjspvjPx0W5uK5pLqwub9OaiSoN496QSyHzCIi38UfyFw>
    <xmx:0ALTaP936xUOruTSnkqBH14D_GogcNCFTSXGOF0aaft7xrNq5U-xcg>
    <xmx:0ALTaNRu09bcksrAergZiclF21QvspxNj_5XcJLQ5p00L2MrS8dVcA>
    <xmx:0ALTaMQ-k7f0TKsYp0GHwzWnhRxiLuSGNqKKKVMtnaD5E0cCnThXgw>
    <xmx:0QLTaAIyFO9F61PYAGpNTwly6T8T5pWhHPEZR7W69B5xla1vYPCPVvg2>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 16:28:00 -0400 (EDT)
Date: Tue, 23 Sep 2025 22:27:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tls: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <aNMCznixxL2veGxK@krikkit>
References: <aNFfmBLEoDSBSLJe@kspp>
 <aNFpZ4zg5WIG6Rl6@krikkit>
 <c9cd2ebb-ecdb-4ba9-8d54-f01e3cd54929@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9cd2ebb-ecdb-4ba9-8d54-f01e3cd54929@embeddedor.com>

2025-09-23, 11:37:55 +0200, Gustavo A. R. Silva wrote:
> 
> 
> On 9/22/25 17:21, Sabrina Dubroca wrote:
> > 2025-09-22, 16:39:20 +0200, Gustavo A. R. Silva wrote:
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > getting ready to enable it, globally.
> > > 
> > > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> > > 
> > > net/tls/tls.h:131:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > 
> > > This helper creates a union between a flexible-array member (FAM)
> > > and a set of members that would otherwise follow it. This overlays
> > > the trailing members onto the FAM while preserving the original
> > > memory layout.
> > 
> > Do we need to keep aead_req_ctx in tls_rec? It doesn't seem to be
> > used, and I don't see it ever being used since it was introduced in
> > commit a42055e8d2c3 ("net/tls: Add support for async encryption of
> > records for performance").
> 
> If this (flex array) is not going to be needed in the future, I'm
> happy to remove it. :)

I don't see what we'd use it for, aead_request.__ctx contains private
data from the crypto code (all accesses seem to be through
aead_request_ctx defined in include/crypto/internal/aead.h, see also
the kdoc: "Start of private context data").
And we haven't seen the author of a42055e8d2c3 in a while, so we can't
ask about the intention behind this field.

So IMO, tls_rec.aead_req_ctx can simply go away. Would you send the
patch?

-- 
Sabrina

