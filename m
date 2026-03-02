Return-Path: <netdev+bounces-262945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEJNEVoZpmmeKQAAu9opvQ
	(envelope-from <netdev+bounces-262945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:12:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9328E1E6642
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53217301468C
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E73242B1;
	Mon,  2 Mar 2026 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="vsTFM2Pw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y0FTGXLp"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D8E320A24
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772493040; cv=none; b=j8RDG3doqbauot5WvsF8jjHHj36AMreg5kB4djYsou31FegifAjJyHQ8r7eEjMNp2l+8kVbExNR64UfYSv2cb3EL0KmsGS6HerY7PuchnhQYf+EIIwy0dVxTQkKpOBAXej0QMcDx5BcZvcmRR5CNlAwXON5+/62nntYbfQT2i+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772493040; c=relaxed/simple;
	bh=02gCBRYaWQlYwxHoiKkNwYL9LacOTkCYPTHqtEX+yWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fatn69hZVJqVadX4TQeb9wV/HVBuT6LRggW/CmPXE8lbu6/fkC+j/uOQb2ouIdRFNwnjPbNV76+icVMZP2sNBnMcM9O1WeBPf12oSUttmQzl8v8lNlCJrTD+xMyhIWl0FiDWw1MBPbEe3tx7QToO3up7so0AJxuLjaskByOzQOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=vsTFM2Pw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y0FTGXLp; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B267F1D0024F;
	Mon,  2 Mar 2026 18:10:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 02 Mar 2026 18:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772493035; x=
	1772579435; bh=DZduqcPpsaRBEcwyysHlY2Q6cAizvxFsjtpDxUHnXpk=; b=v
	sTFM2Pwu/GEaRVjmW7P4/fBYXYPVwh/JUMgOpd2fdGhsR3PomIfh9KYfjMYttgmf
	/cUQ/zQmXs4yA4pdZY4T5/k7EVdFMl1dVf0+Tkt9n1MsVpN4Y1amLc6w2s5/82TH
	qSqnn5PXqgiu32jQg6f92DFHe9N9mphaS4KL3n2Ekqj1eYxvELD4bdjCGgyEXHeH
	uByc0XvjULLPyDde1PwNXGuXIBGbHuMVr8hp8xItEgKe2O1kn53YXEl9nQHgtIp0
	t3DJalxh2RfLYubpaKdKAs4Bk3THs7o9oXtXG/m1IJihEAwck76EexgtI2Xo214Z
	XVYYth2MBKmnBYahrYgDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772493035; x=1772579435; bh=DZduqcPpsaRBEcwyysHlY2Q6cAizvxFsjtp
	DxUHnXpk=; b=y0FTGXLpaOG5haTv20DV/VicpNWioN8AEAELqjEBY30HFl1xB5S
	qsqCzLtQHsgRkM/yQSwXPEGzmVQ9aeDhZ/Rcc1dIjRd7GrNcowRhJ1KDF3GwCKOg
	q7obxu+vgcO+e+vGXQdvLooCJGXfeOUHsCdtvmQPnNbEQ/lYUUEg0BBjuSbdYu+2
	GSv9U+cmIQPCcoVugP+PRPN2Fa7KPNzQ6boZ+nGYVCKtQfabJLRwSlPCk8cUDpFK
	7cRJnuVpLpVbn+qwtbmqJl2ypYDB7carDzDZT2iCF62BiOWyAUK1rU0pSrDO0osI
	MSkC/kVn5FiPPW8F0Yq547hRn1nXkTLp4TA==
X-ME-Sender: <xms:6himacmmQ9ti2iQhhLp9MEiPSnxpGevN9xWAVcGsQ6Dy7uGXmrwXGg>
    <xme:6himaYaAvqrtymzkN2fJ-mGltaQh7-y71r-DtxZsHeJhqV832r3L1SByivupvRIx2
    rg2pKYQiL_B5kvKJF4VNxdD7fwb94D3xNeS2lyGyMtsrQzcsTOxCg>
X-ME-Received: <xmr:6himafFVw_1_N664069yIABmANH2Ifc8OUgYjcgWyJLM4tG0TVUj7d5dTwuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekleejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:6himafYeA_TcE7D-X59kQ9HN13yDmWKiyLKkY-emMsq-gzvLlujOeQ>
    <xmx:6himabwKC-4A3lTsr-5G7w0nusNsI-wcv288VU9gMsClXxeJ-LcfRA>
    <xmx:6himaZTxqgwTesF-LUmCktLsLW-2HICli5RMLuq6yWbI5PIGw9phVg>
    <xmx:6himaQI9BJrq8hGs6xCC4JgU1F3hfEm9V-6BIJRM__aU3eIYsDAQjw>
    <xmx:6ximadw2httO_28vZ-RnlzHczTT0n_M3UXJzxMolpw1QdlmpcuauclIQ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 18:10:34 -0500 (EST)
Date: Tue, 3 Mar 2026 00:10:33 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <aaYY6UiXSppOig9Q@krikkit>
References: <aZgpkyTDU3aXe_V0@v4bel>
 <aZyMejqTbkI7o_VM@krikkit>
 <aaDATohaW62X_pxk@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaDATohaW62X_pxk@v4bel>
X-Rspamd-Queue-Id: 9328E1E6642
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262945-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-02-27, 06:51:10 +0900, Hyunwoo Kim wrote:
> On Mon, Feb 23, 2026 at 06:20:58PM +0100, Sabrina Dubroca wrote:
> > 2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> > > This issue was discovered during a code audit.
> > > 
> > > When strp_stop() and strp_done() are called without holding lock_sock(), 
> > > they can race with worker-scheduling paths such as the Delayed ACK handler 
> > > and ksoftirqd.
> > > Specifically, after cancel_delayed_work_sync() and cancel_work_sync() are 
> > > invoked from strp_done(), the workers may still be scheduled.
> > > As a result, the workers may dereference freed objects.
> > > 
> > > The following is a simple race scenario:
> > > 
> > >           cpu0                      cpu1
> > > 
> > > espintcp_close()
> > >                            espintcp_data_ready()
> > >                              strp_data_ready()
> > >                                if (unlikely(strp->stopped)) return;
> > >   strp_stop()
> > >     strp->stopped = 1;
> > >   strp_done()
> > >     cancel_delayed_work_sync(&strp->msg_timer_work);
> > >                                strp_read_sock()
> > >                                  tcp_read_sock()
> > >                                    __tcp_read_sock()
> > >                                      strp_recv()
> > >                                        __strp_recv()
> > >                                          strp_start_timer()
> > >                                            mod_delayed_work(&strp->msg_timer_work);
> > > 
> > > To prevent these races, the cancellation APIs are replaced with 
> > > worker-disabling APIs.
> > 
> > I'm still not totally convinced by this patch. The comment for
> > strp_done says the function expects to be called at a time when
> > strp_recv cannot happen in parallel:
> > 
> >     strp must already be stopped so that strp_recv will no longer be called
> 
> OK, I understand.
> More specifically, it seems that an issue could occur if strp->skb_head is 
> accessed under the following scenario.

Yes.

> ```
>                  cpu0                                cpu1
> 
> espintcp_close()
>                                          espintcp_data_ready()
>                                            strp_data_ready()
>                                              if (unlikely(strp->stopped)) return;
>   strp_stop()
>     strp->stopped = 1;
>   strp_done()
>     disable_delayed_work_sync(&strp->msg_timer_work);
>     kfree_skb(strp->skb_head);
>                                              strp_read_sock()
>                                                tcp_read_sock()
>                                                  __tcp_read_sock()
>                                                    strp_recv()
>                                                      __strp_recv()
>                                                        head = strp->skb_head;
>                                                        ...
> ```
> 
> > 
> > "strp stopped" is not really enough, I think we'd also need to reset
> > the CBs, and then grab bh_lock_sock to make sure a previously-running
> > ->sk_data_ready has completed. This is what kcm does, at least.
> 
> It seems that this is not something that should be handled inside strp itself, 
> but rather something that each caller of strp_stop() is expected to take care 
> of individually. Would that be the right direction?

Agree.

> It also appears that ovpn and kcm handle this by implementing their own callback 
> restoration logic.

Right. I tried to look at skmsg/psock (the other user of strp), but
didn't get far enough to verify if it's handling this correctly.

> > Without that, if strp_recv runs in parallel (not from strp->work) with
> > strp_done, cleaning up skb_head in strp_done seems problematic.
> 
> From the espintcp perspective, how about applying a patch along the following lines?

This is what I was thinking about, yes.

Thanks.

-- 
Sabrina

