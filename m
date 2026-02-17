Return-Path: <netdev+bounces-259120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDiyCtCxlGlbGgIAu9opvQ
	(envelope-from <netdev+bounces-259120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:22:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7614F053
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 616663009558
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5136E497;
	Tue, 17 Feb 2026 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="JOlzXKG8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDBj1lde"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0636C59B
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352525; cv=none; b=LbgDedOS4m3Fuh7hkHB9ceafqEbBp7SfrgUV9C3kAuL03s2gD+iStT7mDASqVRTQV9Tf7dm79A+3DXXldG5lEC5ADOrPyXRyRpGKc3KJ3rybLp3rFw0+PQX45ZSWAIV5F/7rfys4HA/LI9y3EqZ4pTHvpHPiS6NfOOlXdPLxX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352525; c=relaxed/simple;
	bh=3cODNmrDc+V6CnI9ACLWrEZy5byvM2aUGYtq+5+AhIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuRdfEcV3opFqlbjSK9T9kXZ9/KjDHpA5c5yJQSEqM9eDeDyZ3W5hswLZltRHejCjGdPRBDNHObDEDNa9nL8dzkkJriMaoFVo4a8wOU1I8jPmoqmiNYW7Px+g2GVd/dYuGMc7Zr31Yq7IcR2OJDHYcqsBn1jDqzZJhCFS/6CUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=JOlzXKG8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDBj1lde; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D2D8140012A;
	Tue, 17 Feb 2026 13:22:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Feb 2026 13:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1771352520; x=
	1771438920; bh=xeTAXDKnau0wtprxCHYPgn9Fjs2QV1a5JsYUOzCDu4I=; b=J
	OlzXKG8Bh6RHEqoNVB0lfL0ukAAWV9ZPkpvOFx0fZR3SeEcuR34id6fWTzx/pvtJ
	9foAxK+0D8ZFPhROTCbn3lPG6KGjP33n2Od/blAJ3ugWE3GbF8/A50PVjzSxPnv4
	6o5R8CGQGNtZi48qqOB4ByokCGB6AIfQFeRaepqjvEUYx7Ogkj5SnIrstH+b4moM
	lZQHtvmGf05W4NrmGSsx/cNKlWIq0o9D5TtxnqDON/MpF5b1hcwQDFNsBE4GVP+F
	fRJC27ZC5Z4Lt+S7AY02vajTtomupjBtJtmSvXIeBitD5K9y2aom6MJr3u9StC64
	xKkuwSWYNv5+JutFBRZzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771352520; x=1771438920; bh=xeTAXDKnau0wtprxCHYPgn9Fjs2QV1a5JsY
	UOzCDu4I=; b=QDBj1lde0G1I0BHB6/ANmWhHaJS4GLmh9I7DpJt/tbPqTJVXgYd
	9UXA8z7LjntjA94AjSoK+hMrpzNN++NmA6b9Wt5HT7t1cCQCCoUbQA75RNZnVnjx
	AeBqKXH+iTVh808sU18UlVD8MwRxtzq3A4Rbee+wF7O2DKlvUqh5ngVbuE7ouo4C
	A+NrR9MMzbVvld9B5/4VRsB8O2/ZEncDoD66iv0ocLiNKVGEJ3AeXBy8GpNBgPBf
	wuEHusekfeVBS3rpg3EMapf34A++Zj8jKPmtBt6ny0Dth1OuK5nMTCvu706fOSzd
	XbP7vL3Chj+vkK/oIjIvCB+uRtL0yKLaugQ==
X-ME-Sender: <xms:x7GUaXRMsbAm_ihvvm6EXb8f2VvVSe5ow1DklYvr6NHu046tZ3kz_w>
    <xme:x7GUaVWs6RDxsjpHHDS7_AhZ9peAAohjUqX3xyITDSoOtkNyo7ciWJTQ7lwa_FDiu
    ck48SpmoqhKGpY45afY66-Bv_sWASOzx-_yjwbUOCnSd028Zc0psqri>
X-ME-Received: <xmr:x7GUaRT3VCwv9NHGmlUa_Vtaadjy-djM0huwxTLPPP0LDRGEhV9JazBgFFeB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtgeejucetufdoteggodetrf
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
    rhhgpdhrtghpthhtohepnhgrthgvrdhkrghrshhtvghnshesghgrrhhmihhnrdgtohhmpd
    hrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrghdprhgtphhtthhopehjuhhl
    ihgrrdhlrgifrghllhesihhnrhhirgdrfhhr
X-ME-Proxy: <xmx:x7GUad0sDoUxRtAFssORBuTP8t12GH8TZgR5RGHzBLt3Hh9uXeykQQ>
    <xmx:yLGUaReAMcEVVzuePRkLl9Itbw9YTK7QHby3ybJ8tpIIShSJYCSFfw>
    <xmx:yLGUaVOrXpvxNfm1qq84EYR4UytxEWfGP2b0RbcnFCgIq003yr-QQw>
    <xmx:yLGUaVXtf7M2gVEFeFBXyc7xSuqpSET5dI4RJlm3gYdr4Sd0czatJg>
    <xmx:yLGUaX_b7i7CCX6bJyvScJ4ujMpyfSTaQd8ripDLV8sPBtAXhGTizvsL>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 13:21:59 -0500 (EST)
Date: Tue, 17 Feb 2026 19:21:57 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, nate.karstens@garmin.com,
	linux@treblig.org, Julia.Lawall@inria.fr, netdev@vger.kernel.org
Subject: Re: [PATCH] strparser: Use worker disable API instead of
 cancellation in strp_done()
Message-ID: <aZSxxdNWGLGBj1lD@krikkit>
References: <aZLn2Faeg1FB7XOf@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZLn2Faeg1FB7XOf@v4bel>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-259120-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73C7614F053
X-Rspamd-Action: no action

2026-02-16, 18:48:08 +0900, Hyunwoo Kim wrote:
> When strp_stop() and strp_done() are called without holding lock_sock(), 
> they can race with worker-scheduling paths such as the Delayed ACK handler 
> and ksoftirqd.
> Specifically, after cancel_delayed_work_sync() and cancel_work_sync() are 
> invoked from strp_done(), the workers may still be scheduled.
> As a result, the workers may dereference freed objects.
> 
> To prevent these races, the cancellation APIs are replaced with 
> worker-disabling APIs.
> 
> Fixes: 829385f08ae9 ("strparser: Use delayed work instead of timer for msg timeout")

That's the correct commit for msg_timer_work, but not for
strp->work. No race was possible when msg timeout was using a timer?
Your second scenario relies only on strp->work so I would think yes.

> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/strparser/strparser.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> index fe0e76fdd1f1..15cd9cadbd1a 100644
> --- a/net/strparser/strparser.c
> +++ b/net/strparser/strparser.c
> @@ -503,8 +503,8 @@ void strp_done(struct strparser *strp)
>  {
>  	WARN_ON(!strp->stopped);
>  
> -	cancel_delayed_work_sync(&strp->msg_timer_work);
> -	cancel_work_sync(&strp->work);
> +	disable_delayed_work_sync(&strp->msg_timer_work);
> +	disable_work_sync(&strp->work);

The change itself looks reasonable.

>  	if (strp->skb_head) {
>  		kfree_skb(strp->skb_head);
> -- 
> 2.43.0
> 
> ---
> Dear,
> 
> The following is a simplified scenario illustrating how each race can occur. Since espintcp_close() does not hold lock_sock(), the race is possible.
> Although cancel_work_sync(&strp->work) does not appear to be easy to trigger in practice here, it still seems better to fix it as well.

What about the other users of strp? Only espintcp is racy?

If strp_done can run concurrently with __strp_recv, it seems we could
also end up leaking strp->skb_head, if __strp_recv stores a new one
after we've cleared the old?


> ```
>                  cpu0                                cpu1
> 
> espintcp_close()
>                                          espintcp_data_ready()
>                                            if (unlikely(strp->stopped)) return;
>   strp_stop()
>     strp->stopped = 1;
>   strp_done()
>     cancel_delayed_work_sync(&strp->msg_timer_work);
>                                            strp_data_ready()

In this order, strp_data_ready will see strp->stopped and return
without doing anything.

(I'm confused by the "if (unlikely(strp->stopped))" above though,
maybe you meant espintcp_data_ready -> strp_data_ready -> if (...))

>                                              strp_read_sock()
>                                                tcp_read_sock()
>                                                  __tcp_read_sock()
>                                                    strp_recv()
>                                                      __strp_recv()
>                                                        strp_start_timer()
>                                                          mod_delayed_work(strp_wq, &strp->msg_timer_work, timeo);  
> ```
> ```
>                  cpu0                                cpu1
> 
> espintcp_close()
>                                           sk->sk_data_ready()
>                                             espintcp_data_ready()
>                                               if (unlikely(strp->stopped)) return;
>   strp_stop()
>     strp->stopped = 1;
>   strp_done()
>     cancel_work_sync(&strp->work);
>                                               if (strp_read_sock(strp) == -ENOMEM)
>                                               queue_work()

Here the problem would be if we enter do_strp_work after all the
socket data has already been freed? Otherwise again the test on
strp->stopped will make do_strp_work return early. (this would be
unexpected but should be safe)

> ```
> 
> Best regards,
> Hyunwoo Kim

-- 
Sabrina

