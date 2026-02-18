Return-Path: <netdev+bounces-259344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O5gMPMAlmlHYAIAu9opvQ
	(envelope-from <netdev+bounces-259344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:12:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54015893D
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DDD830011A5
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31155346A05;
	Wed, 18 Feb 2026 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="zc3x9YVy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OTP6aIlW"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39D0346774
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438314; cv=none; b=KxyS5Bh8sJQtCJnqEV/yBhLOowzamYUdGlceY0G11CV8BNEmuwDlDXySeShyNBMhxsoP+swNmJIYuPD/SHhjY8d02p4T7Fwdou+aAlfPV7bAPjU8b8PGeRcMqRe2C1SQcKe2JIZXA85QiaCkf2icCwk9q2dBfa+fmGYFmV7/IWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438314; c=relaxed/simple;
	bh=cbGs+EDJvUrqEkGtFcalHSHNJv6biaGOv5JlK9zk6QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0yYQbBFc7Nq6ih0ciYoeWzCV60kTwB1WpGEA8y5pf/vTmSFl29LIxlzpnW+K2CjJdDBxfVmEE/NwgNHM9s6O+N3j1RkSeurD4g9eX0Op81NxkOTXn9gfsVVU+/PY7fgwjLhkG70Y1MYYcXfBTr9dYMlN1bu/Iznh/SZl2JB+80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=zc3x9YVy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OTP6aIlW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D9EF5EC05AD;
	Wed, 18 Feb 2026 13:11:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 18 Feb 2026 13:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1771438309; x=1771524709; bh=QtQ+8xOqTbSwxU2vvHTk91LQ1jQ12Feo
	zPFpc2kz5Wg=; b=zc3x9YVygZxTgOLDRggpkIgzM0vwAdiKqky0f+LoaRqcsyAf
	kIR9Lurfet/GpBr2DShHZFRwPveAcydtVjmRpWQQIYws8lS7WSiOWth4vGjWrI/0
	LsbRQv22XqwQzKDoq9kxPzLQq4FQTNaOzdRSawkidPm5UixqtVR/ZH6spF5izAhK
	WFHu7mRqfxCQ7vPqg2hwmYj4Hx1KSoPlyU1I/Rzm6Z1a8ngI9VBrJFdIgj2BpcNj
	fdlLybFHHMlzSPhoRtRwfws9SCZcLY/p2L4GWRukNqw/Kc2p5bx2xrJHgQDZ6VNX
	NfslXSK6CkIG166fgx2PjV/z960EEfKPbPMwuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771438309; x=
	1771524709; bh=QtQ+8xOqTbSwxU2vvHTk91LQ1jQ12FeozPFpc2kz5Wg=; b=O
	TP6aIlWYpud5vTbMt5etvJfs5s7+e593X+hTVKNx9BXMktFcHsepOhKKaPlkEs8I
	mPh1ijgKxQOZukjeHBbe+z45gi+xu82lOULVkXBDZZWaHftzaDvkzhP/Ts0CINy2
	OSXl3qtBNJ2qGe4vbqtbMbc3VTNCrA6RqR381BvDZJEf7E68zBTtTaTo+ZsbIQeB
	1noPxekVIoCLEkjV+DFhY+ctn3FpgznGzS89dW2Wi8cUJqCIZI0f+u502YyFOVdK
	BgkIp2u7ghQaGEiNNGG1xS6zzeyMQZDVvdatO/QuylwKOzH/GkfDqyjvPDwrBTci
	WAT9rjhhX3r8xk1Eh2SEg==
X-ME-Sender: <xms:5QCWadN7jP3E4Yhh5Z-5f3gSIik2GcHyuXzPF6Q_h1Krv_PNfdZqQQ>
    <xme:5QCWacgxYMSRcgYWkft8RD_8RmN0WNVwWR1vrpTioBhkB3Ki3Fs-x4SRWFS4znXbo
    rdlymwD0wimPzSc9GeqxsWuRm-env6S9nfOm7zByREI6zkqZYJOIw>
X-ME-Received: <xmr:5QCWaQsbtdHGlmO-n5SuWs-AtVLaviHfwXrsFY3WShDAwGwBrnfoubPvz0xP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggr
    shihshhnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvgeeitefffedvgfdutd
    elgeeihfegueehteevveegveejudelfeffieehledvnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvg
    htpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ihhmvhegsggvlhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsg
    gvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehnrghtvgdrkhgrrhhsthgvnhhssehgrghrmhhinhdrtghomh
    dprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghpthhtohepjhhu
    lhhirgdrlhgrfigrlhhlsehinhhrihgrrdhfrh
X-ME-Proxy: <xmx:5QCWaQhnAakW7qjgBcxUXYg2yP-P-5b1kdIz8h7mVz_JMS4jcLVyRQ>
    <xmx:5QCWaWbmp3__pvDYNGsgjnVA5Cz1E0fn3B7mQLo_YOGI2YlHo75a8g>
    <xmx:5QCWafY0h-ZfMESjCKZab-pVyoKhyNSd2minziHeyK2YB-cbSGG-_w>
    <xmx:5QCWabz5rluk4vX84C4wUvCXYnTJJcbGhTz7hKdOJLHAripC36S-dg>
    <xmx:5QCWafbkDf76ErniS0o5dH5ISn4fTSVrRsO4U-A4H3r5BqC9LtTKi_wq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 13:11:48 -0500 (EST)
Date: Wed, 18 Feb 2026 19:11:47 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, nate.karstens@garmin.com,
	linux@treblig.org, Julia.Lawall@inria.fr, netdev@vger.kernel.org
Subject: Re: [PATCH] strparser: Use worker disable API instead of
 cancellation in strp_done()
Message-ID: <aZYA4wrC_HtJdSUq@krikkit>
References: <aZLn2Faeg1FB7XOf@v4bel>
 <aZSxxdNWGLGBj1lD@krikkit>
 <aZTFXZcPiu8GBAY7@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZTFXZcPiu8GBAY7@v4bel>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259344-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: BF54015893D
X-Rspamd-Action: no action

2026-02-18, 04:45:33 +0900, Hyunwoo Kim wrote:
> On Tue, Feb 17, 2026 at 07:21:57PM +0100, Sabrina Dubroca wrote:
> > 2026-02-16, 18:48:08 +0900, Hyunwoo Kim wrote:
> > > When strp_stop() and strp_done() are called without holding lock_sock(), 
> > > they can race with worker-scheduling paths such as the Delayed ACK handler 
> > > and ksoftirqd.
> > > Specifically, after cancel_delayed_work_sync() and cancel_work_sync() are 
> > > invoked from strp_done(), the workers may still be scheduled.
> > > As a result, the workers may dereference freed objects.
> > > 
> > > To prevent these races, the cancellation APIs are replaced with 
> > > worker-disabling APIs.
> > > 
> > > Fixes: 829385f08ae9 ("strparser: Use delayed work instead of timer for msg timeout")
> > 
> > That's the correct commit for msg_timer_work, but not for
> > strp->work. No race was possible when msg timeout was using a timer?
> 
> Of course, the race could also occur when the message timeout was 
> implemented using a timer.
> 
> > Your second scenario relies only on strp->work so I would think yes.
> 
> Using Fixes: bbb0302 ("strparser: Generalize strparser") should cover 
> both cases.

Ok.

> > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > ---
> > >  net/strparser/strparser.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> > > index fe0e76fdd1f1..15cd9cadbd1a 100644
> > > --- a/net/strparser/strparser.c
> > > +++ b/net/strparser/strparser.c
> > > @@ -503,8 +503,8 @@ void strp_done(struct strparser *strp)
> > >  {
> > >  	WARN_ON(!strp->stopped);
> > >  
> > > -	cancel_delayed_work_sync(&strp->msg_timer_work);
> > > -	cancel_work_sync(&strp->work);
> > > +	disable_delayed_work_sync(&strp->msg_timer_work);
> > > +	disable_work_sync(&strp->work);
> > 
> > The change itself looks reasonable.
> > 
> > >  	if (strp->skb_head) {
> > >  		kfree_skb(strp->skb_head);
> > > -- 
> > > 2.43.0
> > > 
> > > ---
> > > Dear,
> > > 
> > > The following is a simplified scenario illustrating how each race can occur. Since espintcp_close() does not hold lock_sock(), the race is possible.
> > > Although cancel_work_sync(&strp->work) does not appear to be easy to trigger in practice here, it still seems better to fix it as well.
> > 
> > What about the other users of strp? Only espintcp is racy?
> 
> Any subsystem that calls strp_stop() and strp_done() outside of 
> lock_sock() is racy.

strp_done() has to be called outside of lock_sock(), since both
strp_work() and strp_msg_timeout() need to take lock_sock.

> 
> > 
> > If strp_done can run concurrently with __strp_recv, it seems we could
> > also end up leaking strp->skb_head, if __strp_recv stores a new one
> > after we've cleared the old?
> 
> I am not fully sure about this part yet, so I think it should be 
> discussed separately in another thread.

Maybe not, if it's the same race condition (same code running
concurrently), just with different symptoms.


> > > ```
> > >                  cpu0                                cpu1
> > > 
> > > espintcp_close()
> > >                                          espintcp_data_ready()
> > >                                            if (unlikely(strp->stopped)) return;
> > >   strp_stop()
> > >     strp->stopped = 1;
> > >   strp_done()
> > >     cancel_delayed_work_sync(&strp->msg_timer_work);
> > >                                            strp_data_ready()
> > 
> > In this order, strp_data_ready will see strp->stopped and return
> > without doing anything.
> > 
> > (I'm confused by the "if (unlikely(strp->stopped))" above though,
> > maybe you meant espintcp_data_ready -> strp_data_ready -> if (...))
> 
> Sorry for the confusion. I accidentally mixed up the call order in the 
> strp_data_ready() path. 
> More precisely, the scenario is that espintcp_data_ready() → strp_data_ready() 
> runs first, passes the if (unlikely(strp->stopped)) check, and only after 
> that strp->stopped = 1 is set.

Ok, thanks.

> > > ```
> > >                  cpu0                                cpu1
> > > 
> > > espintcp_close()
> > >                                           sk->sk_data_ready()
> > >                                             espintcp_data_ready()
> > >                                               if (unlikely(strp->stopped)) return;
> > >   strp_stop()
> > >     strp->stopped = 1;
> > >   strp_done()
> > >     cancel_work_sync(&strp->work);
> > >                                               if (strp_read_sock(strp) == -ENOMEM)
> > >                                               queue_work()
> > 
> > Here the problem would be if we enter do_strp_work after all the
> > socket data has already been freed? Otherwise again the test on
> > strp->stopped will make do_strp_work return early. (this would be
> > unexpected but should be safe)
> 
> If the worker is scheduled after the cancel call, then during 
> espintcp_close() → tcp_close(), the sk will be freed and the ctx 
> will be freed as well. 
> As a result, the kworker will access the freed ctx->strp. 
> This access to the freed ctx happens before the actual worker 
> handler is called, so the problem occurs regardless of the 
> condition checks in do_strp_work().

If we're lucky:

cancel_work_sync(strp->work)
                                        queue_work(strp->work)
...
                                        do_strp_work
                                        strp->stopped
...
free(sk)

[anyway, doesn't matter, seems it could indeed happen as you say]


I'm thinking that all those races are not very likely to happen in
real life, since syzbot has not seen them, and it's usually pretty
good at finding races. (which doesn't mean they're not worth fixing)

-- 
Sabrina

