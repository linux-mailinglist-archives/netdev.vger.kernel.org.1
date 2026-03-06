Return-Path: <netdev+bounces-264724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCAbHcmoqmnIVAEAu9opvQ
	(envelope-from <netdev+bounces-264724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 11:13:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE4921E848
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 11:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9290930104A1
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 10:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE1B35F17F;
	Fri,  6 Mar 2026 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="eeZETnzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="idn/Ra19"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEADE359A97
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792006; cv=none; b=RyZ9LhGk1T3DnVVx5dCgDrT/iHVI0w8OMF79AOHpraORnAljqR4yVdgzZraimAKJq5CRfdlRLTWDrdDq1u5eZx5Wwu7P+t+3HtDw++ZiqHiKVzGE0rEdyXvz9/ND3HpSiUqEwS1AF2DGQaDWEJX/OI+B8sxNDWt+hp2Myu3gK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792006; c=relaxed/simple;
	bh=8iUlFMCBwG1DcpDGPk0dI4+F9rsSor1oacl3ahu8vmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKaU6prKn1UhOORSDeFQuGie7mbZsl9q4cXsO9t5IetGjomiz7PgjiiK9imGVindveKPy1Wzjfl5YEs3Szf0nUcoaNTfj2lSSorDF66LNh36rM+e/dZ043jLdZxRsrLgK1qZDuhGbt437p40/4bOLDuegb7MEEl5VoqEygiGH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=eeZETnzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=idn/Ra19; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F3F18EC0308;
	Fri,  6 Mar 2026 05:13:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 05:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772792001; x=
	1772878401; bh=i2BMcW6q5XjQq2zKyCDAwZpe2VVOKvd3c+Wqr5PNqnY=; b=e
	eZETnzYlqqiHGMfcT0gkgWe/PjiDot38OQKl4y1TZiE2byJ3XQ1TkEv1IBXFSnJP
	sp/8ULfI6sDn5xIzj6Vlt0HhalOPm0evPlG7VEt8XYV4B1dW4tW9rMtAyp4mOiHY
	rMbxaBLnWad2ajp8K9BQmRAXhVxwVCjEWU3XNnii+xglIBUiodRCoPbjg1mtM9RA
	iG9p4quPzymx0oV7MUmickTk0zEsEja1OlScgnFuj0O6V4YTQF8s+Ttdis9I3F80
	5D1OIX+NV4i2J4NmMuGI3ZkfZ9sXyJTDBr/3MRJGS7t+6ZPDUXTQcuXtJkEFgQCO
	J2ez3bzTiWenzSoIlMMJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772792001; x=1772878401; bh=i2BMcW6q5XjQq2zKyCDAwZpe2VVOKvd3c+W
	qr5PNqnY=; b=idn/Ra19p1hhii9uBw/Y8tKNoHayXeTZCv88fIhrwSI01IsQbGT
	UNn+QkcckilHBRiy/hhwILp0rPcg5OXzZieQGA0yK5R0pSJWspGLp73ac+BvNg4c
	ZLbTpXi0dvIj5Z+lBr71SZUW0C2pkNWicVXYAtBwAbWaCPt8oz+FJqFuQEpws30x
	r5Xk7JD19Lgwv9wHVIgB9N0DFemaL7KhgFtwBzmxgNl6iiI8S8uQcKEu4bw1ZD3I
	FF5SIgnzrtcL1XHbjyEDI4mbL7XSdar9aXl9tTKo9jQTkxUuvcOA4sc5AsW0lWj/
	jnGH4lm8E2WhlngiO/oIBOPrTaB64aXbUZw==
X-ME-Sender: <xms:waiqaTL5l5f7rcavfyOKl2jpYUprgTYNGyRQ-TINRUwhlq0_5lFEbw>
    <xme:waiqaTvte6OHUhV9kVPYMkwFCt7Cp6T49BBqIOF-c-IXj6b-H_pHVqbbdmy4Oxj7N
    78nGVsMCaFq9MP0_r9dVZP6s1u7qMZZD3lVbW4r0Fz_zFNFO5q4g-gY>
X-ME-Received: <xmr:waiqaQI98ULjHckXgg0_kQ7H6RXvcqXyEe1UedKN9C3FMpyfQwLM6G2N1GPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeltddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:waiqaTPH02dr6BTrKFf7u6cAz_-bNRDiysmy2eEezm1r6Nnr_RBelQ>
    <xmx:waiqabV6RbP5eFTdfsmtPrLAnLw0Y6CwE-gw_BUmZBesexL5LuSIpA>
    <xmx:waiqaZlUsq7pdaU6Vti7XFAObarq7bWbjt7VPMAZ0AsRUwji1TZj_g>
    <xmx:waiqaSPku9hHXXHODE3heH1LiMQ-9PnK1mvNcfWdBwhBBq1_kPINoQ>
    <xmx:waiqaW3sO5e-2GkWaLfKDjo5E33De65Gcdwy8wVTcqDPusDxw3hix59u>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 05:13:21 -0500 (EST)
Date: Fri, 6 Mar 2026 11:13:19 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <aaqovyrmd5pJtZKq@krikkit>
References: <aZgpkyTDU3aXe_V0@v4bel>
 <aZyMejqTbkI7o_VM@krikkit>
 <aaDATohaW62X_pxk@v4bel>
 <aaYY6UiXSppOig9Q@krikkit>
 <aaY-TbPsNxo6toSr@v4bel>
 <aaoTVMhnY5FKMrem@krikkit>
 <aaobmK6d_xd9ZXGj@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaobmK6d_xd9ZXGj@v4bel>
X-Rspamd-Queue-Id: BCE4921E848
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-264724-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

2026-03-06, 09:11:04 +0900, Hyunwoo Kim wrote:
> On Fri, Mar 06, 2026 at 12:35:48AM +0100, Sabrina Dubroca wrote:
> > Sorry for the delay, I wanted to think about the race condition a bit
> > more.
> > 
> > 2026-03-03, 10:50:05 +0900, Hyunwoo Kim wrote:
> > > On Tue, Mar 03, 2026 at 12:10:33AM +0100, Sabrina Dubroca wrote:
> > > > 2026-02-27, 06:51:10 +0900, Hyunwoo Kim wrote:
> > > > > On Mon, Feb 23, 2026 at 06:20:58PM +0100, Sabrina Dubroca wrote:
> > > > > > 2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> > > > > > "strp stopped" is not really enough, I think we'd also need to reset
> > > > > > the CBs, and then grab bh_lock_sock to make sure a previously-running
> > > > > > ->sk_data_ready has completed. This is what kcm does, at least.
> > > > > 
> > > > > It seems that this is not something that should be handled inside strp itself, 
> > > > > but rather something that each caller of strp_stop() is expected to take care 
> > > > > of individually. Would that be the right direction?
> > > > 
> > > > Agree.
> > > > 
> > > > > It also appears that ovpn and kcm handle this by implementing their own callback 
> > > > > restoration logic.
> > > > 
> > > > Right. I tried to look at skmsg/psock (the other user of strp), but
> > > > didn't get far enough to verify if it's handling this correctly.
> > > > 
> > > > > > Without that, if strp_recv runs in parallel (not from strp->work) with
> > > > > > strp_done, cleaning up skb_head in strp_done seems problematic.
> > > > > 
> > > > > From the espintcp perspective, how about applying a patch along the following lines?
> > > > 
> > > > This is what I was thinking about, yes.
> > > 
> > > In my opinion, it might be cleaner to split the espintcp callback restoration work into 
> > > a separate patch, rather than merging it into the strparser v3 patch. What do you think?
> > 
> > Sure. But once espintcp is fixed in that way, can the original race
> > condition with strparser still occur? release_sock() will wait for any
> 
> If the espintcp callback restoration patch is applied, the strparser
> race should no longer occur in espintcp.
> 
> > espintcp_data_ready()/strp_data_ready() that's already running, and a
> > sk_data_ready that starts after we've changed the callbacks will not
> > end up in strp_data_ready() at all so it won't restart the works that
> > are being stopped by strp_done()?
> > 
> > It's quite reasonable to use disable*_work_sync in strp_done, but I'm
> > not sure there's a bug other than espintcp not terminating itself
> > correctly on the socket.
> 
> That said, the _cancel APIs in strparser still appear to carry some
> structural risk, so it might still make sense to switch to the _disable
> APIs for the benefit of other strp users or potential future callers.

Not really. Every user of strp that is open to the strp_recv vs
cancel_* race is also open to the strp_recv vs free race, so switching
from cancel_* to disable_* is only a partial fix.

But if we took and released the socket lock in strp_done, we would
solve the issue for all users even without resetting the callbacks?

@@ -503,6 +503,10 @@ void strp_done(struct strparser *strp)
 {
 	WARN_ON(!strp->stopped);
 
+	lock_sock(strp->sk);
+	/* sync with other code */
+	release_sock(strp->sk);
+
 	cancel_delayed_work_sync(&strp->msg_timer_work);
 	cancel_work_sync(&strp->work);
 


 - strp->stopped so any new call into strp_data_ready will not do anything

 - lock/release need to take bh_lock_sock so any existing call to
   strp_data_ready will have to complete before we move on to cancel*_work



Or maybe the requirement should be that strp_stop has to be called
under lock_sock() (or even just bh_lock_sock), but again I can't
figure out if that's ok for sockmap.


> With that in mind, perhaps the direct fix for this race could be handled
> in the espintcp callback restoration patch. For the strparser patch, I
> could instead adjust the commit message to reflect that it removes a
> potential hazard by replacing the _cancel APIs with the _disable
> variants, and resubmit it in that form.

I'm not going to nack a patch doing s/cancel_/disable_/ in strp_done,
but it doesn't fully solve the race condition if the caller isn't
doing the right thing, and it doesn't do anything if the strp user is
handling the teardown correctly.

-- 
Sabrina

