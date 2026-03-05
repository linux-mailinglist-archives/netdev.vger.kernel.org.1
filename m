Return-Path: <netdev+bounces-264585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IysCDkVqmnFKgEAu9opvQ
	(envelope-from <netdev+bounces-264585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:43:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E003219712
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9110C30626F6
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B63A36682D;
	Thu,  5 Mar 2026 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="BKOA4TMZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psx8sWtf"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E235E92F
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753755; cv=none; b=Yas98e3SQfVW1lP0GD0ZV49OuswEcnlPlWqVkX2t2eIVgCQpmrAZqQHYyMQx0EXDC5/i+D2Fy9PccKktuSHQ6qLyxxhvZBxigAU0woccLakcw6YMM/jug/Dg3gYy6+5WU0uP0+suw/TrFY3A5d5ly9Hex+nDnyDGS/BBDh4l4WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753755; c=relaxed/simple;
	bh=7dV6zIm+VyKpTqme8SIk6n180zI5ZrJ7dj52LjWmJ8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrkKafRmQmb1jpbUgfLcdZpcJ9fRPpvfEcOVZ+zpzMrEi3nwcckO1WajhbKl0Omns4Mq3VWvdxV2qZvKboqqBUJ5ieg7Qf3UdNhMa28muTtbB9DML/5dIsW3uoXZAYgb0xQqdefuaQCnd3WfJ7Rs7bCTOJvikMULaeWrVwDzz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=BKOA4TMZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=psx8sWtf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BBA2E1400216;
	Thu,  5 Mar 2026 18:35:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 05 Mar 2026 18:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772753751; x=
	1772840151; bh=2MV9TK97mI1wOM6Fo8ANFO6I8Skot00TLPVQS4bte2A=; b=B
	KOA4TMZ/2oWYDek6x1AJsN0cJPkUtF4T7t5oeAGgx0CUr7SSSzHpIjbO0/Pcy6zY
	3jFQazNWO2CjCGaulZTWME0N6p9INVi/HuiHmPMUZSXfa4fKahGuxdDIF6wbciL4
	xz9Qgzu/p5IdyGAa8RGLK2JnAsK0awvaqoItYAmLRBo0YP9qOBfCLgVgxPS6862u
	E4QX/TqWjV9tB536f2uZUmNzej0WWvAYK8M1Fg703tuWm8s9wpYJWe/o9DpBkcdZ
	ShOoXIjw3z6V+J1CPkq77bRZWA3UvxWOb+rZbawa4KLAfvrafE13sBnvuvsRB0SM
	/ZrsbFh+YUy0vYEVCwXKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772753751; x=1772840151; bh=2MV9TK97mI1wOM6Fo8ANFO6I8Skot00TLPV
	QS4bte2A=; b=psx8sWtfEFb6O/kQizuOolp12K1EpPhJ9P6DOl2c3JtDESkJjA/
	yAYTNvglqnFDYTmvXAU7zUWFcVFogc55lMhMusBJGM1hTNXBp9UsbXi5ai2SnLJM
	iWeclp6l3ncpJt24N6mCx9dv13O6r0/IQJ/x2x4nh01+xoKS3xDjUKl6kWAfz7Ji
	tBo/Yp7T81J2krkBxEBQpxarjUshQaRTqFX4x8yFHHC3okqp7OikAGrnSpv/vlhy
	xnxVJZUiruU5Csf2ZHhnhOO0hNDH4DqQtd9/+MkOAwcqLNC1H3nytz6qiwJgW14c
	Ah+Fwt9yOAQMmGl0It+S7QnBt+Fu2UXFZyw==
X-ME-Sender: <xms:VxOqaYxwTIkJ78soNYBwM9VUwuzSSK8UbertHz169bkkR7N72GveoQ>
    <xme:VxOqaY2ahcOeP6wqkm0gkMTWCh6GGZ4ITroHIhWx7iBntJUu0fflezrC-pVN77vPg
    eltz5_ZyCi3V1pDOKc9JwqITyUGIfPMC1v39OXP2o_CAkX0pDGkR-c>
X-ME-Received: <xmr:VxOqaey0X3xzjSVEsvYCqGr574185l0kqMnor8kCm1HAJikAtIlCprihXHAN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehi
    mhhvgegsvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmh
    hlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhulhhirgdrlhgrfigrlhhlsehinhhrihgrrdhfrhdprhgtph
    htthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghpthhtohepnhgrthgvrdhk
    rghrshhtvghnshesghgrrhhmihhnrdgtohhm
X-ME-Proxy: <xmx:VxOqadURUZM8VEDqdsSL5Th7V4uIb_mzNak_rAGitguCGJfGDSUVwA>
    <xmx:VxOqaa_NAxJZSxtTqubn4Xz2DzfVOf2ra4m5TeJKZi-mdBO0nALixA>
    <xmx:VxOqaQtFwE5JETQGITo7aIAH_npUeC096NUB4703e2BXUEZfz6vqQQ>
    <xmx:VxOqaa2wyQldAxVODTngR_26CtrOiO7F5aC-rU9ZVEPDdUWcSAdu1A>
    <xmx:VxOqaVeVMEkRItXrD_5xbF-qpx19yTP-JtyNME4CEjCU3YUCvDgCOFKi>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:35:50 -0500 (EST)
Date: Fri, 6 Mar 2026 00:35:48 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <aaoTVMhnY5FKMrem@krikkit>
References: <aZgpkyTDU3aXe_V0@v4bel>
 <aZyMejqTbkI7o_VM@krikkit>
 <aaDATohaW62X_pxk@v4bel>
 <aaYY6UiXSppOig9Q@krikkit>
 <aaY-TbPsNxo6toSr@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaY-TbPsNxo6toSr@v4bel>
X-Rspamd-Queue-Id: 7E003219712
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264585-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Action: no action

Sorry for the delay, I wanted to think about the race condition a bit
more.

2026-03-03, 10:50:05 +0900, Hyunwoo Kim wrote:
> On Tue, Mar 03, 2026 at 12:10:33AM +0100, Sabrina Dubroca wrote:
> > 2026-02-27, 06:51:10 +0900, Hyunwoo Kim wrote:
> > > On Mon, Feb 23, 2026 at 06:20:58PM +0100, Sabrina Dubroca wrote:
> > > > 2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> > > > "strp stopped" is not really enough, I think we'd also need to reset
> > > > the CBs, and then grab bh_lock_sock to make sure a previously-running
> > > > ->sk_data_ready has completed. This is what kcm does, at least.
> > > 
> > > It seems that this is not something that should be handled inside strp itself, 
> > > but rather something that each caller of strp_stop() is expected to take care 
> > > of individually. Would that be the right direction?
> > 
> > Agree.
> > 
> > > It also appears that ovpn and kcm handle this by implementing their own callback 
> > > restoration logic.
> > 
> > Right. I tried to look at skmsg/psock (the other user of strp), but
> > didn't get far enough to verify if it's handling this correctly.
> > 
> > > > Without that, if strp_recv runs in parallel (not from strp->work) with
> > > > strp_done, cleaning up skb_head in strp_done seems problematic.
> > > 
> > > From the espintcp perspective, how about applying a patch along the following lines?
> > 
> > This is what I was thinking about, yes.
> 
> In my opinion, it might be cleaner to split the espintcp callback restoration work into 
> a separate patch, rather than merging it into the strparser v3 patch. What do you think?

Sure. But once espintcp is fixed in that way, can the original race
condition with strparser still occur? release_sock() will wait for any
espintcp_data_ready()/strp_data_ready() that's already running, and a
sk_data_ready that starts after we've changed the callbacks will not
end up in strp_data_ready() at all so it won't restart the works that
are being stopped by strp_done()?

It's quite reasonable to use disable*_work_sync in strp_done, but I'm
not sure there's a bug other than espintcp not terminating itself
correctly on the socket.

-- 
Sabrina

