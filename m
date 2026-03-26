Return-Path: <netdev+bounces-271937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPCfNKv5xGmC5QQAu9opvQ
	(envelope-from <netdev+bounces-271937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:17:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FA433222A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97058316121D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179D36B047;
	Thu, 26 Mar 2026 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="jjI/xIsg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hCrhXgzo"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09356377EB8
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515560; cv=none; b=eFXY0n4YWM1IYwnGC7F4QlzRvpL4A7twqB8DqCApZbtvdzaFaElouLGlyAuQTce7BNjY9pSlRO+0Dsdivr5Ncei9EPUovMOkQcAuUuaj72AZNsXZRhIcv3GxOD+/eAhe/6Li5LKdYSp4h+YTs7e8311Jf2SmWZemeCEQeMHBvpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515560; c=relaxed/simple;
	bh=t/VfX5jtoOH2eu7a5//RzMmx9sFhmdFE2NAx60AXS7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5abtGEeiBUBg6Y+mxtd0FdnJSpXdIgOAOlDLUpcvaGxY/UjPM7PwTvVJ4O0O8JmwaNqNUawmTN1i6HhLEISR8cVO+KI5FVyZhnmBQzlu8eui7rCRsCkibb2G/58ZWxDgCINLbOFPIOcKzAbq5BvCJZY8zUiREng2INVJGmwBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=jjI/xIsg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hCrhXgzo; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E5FA97A0258;
	Thu, 26 Mar 2026 04:59:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Mar 2026 04:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774515555; x=
	1774601955; bh=iwrgke0RUOWsMUihjCBwqZr4DRWvE8pmLmjvaz/6ge0=; b=j
	jI/xIsgI7rly1l4ziTnINjvEWDTvaFXo+PBIgcg4Zb4+a7zhLZY6JPxELe8MNEwx
	glciZTnvR8VbB26mTB/YxyrzV9oBjfXpTOo37S0YCPqGeGOf0h5wzEYoLew1O60A
	j+4iasEDnkp7L508k6MUCOHsQr9Xn6qdL6Z3Qv6xxfQpGY2Pj4I8GZIVf5cO+QDn
	31OI7difexUqqB6R63gPht9k9qT7oc2wA2jDw3L1klCxgVkSMHZ0TH80MvQdJ9aC
	I3ANDUWnnslEQLIfADxVmA22DBwJ55Xs+cIwPF51OYlrPgryjrE/8KZ+8HG8eJkc
	W+GHq3f5x2sDktwjByv4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774515555; x=1774601955; bh=iwrgke0RUOWsMUihjCBwqZr4DRWvE8pmLmj
	vaz/6ge0=; b=hCrhXgzoavDKiRc/P+M47MqRzcint43VZeUQgj6OGG/RvFYgMh1
	mnM0uvM1j+mMZULvIWgt6sO/RYolkeA87A38A+775QrGoFVT7moLhqZEIaOc52FC
	kvGM2iNvhGFSzfA1CLuTzJm67hzAE0G44XP1B7qjMq/heI8It2hoMAhVBctXY7cx
	7E4ljzMGD79IltqOtK2IFqx0e/jeNTS05ctk52NcjOpj5oaDCEspDW3fys2TSV5e
	a99YcAYVJXHe2NYmHqADVUvxFpwJo5GPK466EXaKEmH5/3rFz7A1tp9GxXsUN1tE
	2oR8UCbO6VAl973y70fbyuVwBlBv3tQNKCA==
X-ME-Sender: <xms:YvXEaVhsv_Nh3CMc2zFpSqlG5AKezBwChUeLqQFhjMauOAQ1B_pabw>
    <xme:YvXEaaufp4MGRCH8ISEkO73XSiVTiXBukDuOeZDE4FOZMEMtbHbK9sL-KdSjGCUR_
    __Tn45SFt4Pg7UXZcwhlc2ndSoGLIoW5miTe-JNQCd9C5ls5qdDZ8E>
X-ME-Received: <xmr:YvXEaTRyK2tPRkX4KmjhU67h-u4hO3V_0jiSg_kQK6KI2TZ98V5GdKgsjKDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
X-ME-Proxy: <xmx:Y_XEae23V1zsXnOuvvo0sRf4THuIY50Ye2KsiaYYchsFDwF6-itRjQ>
    <xmx:Y_XEaYuZ7qjHXSbdHKt8ELnEvUcGcLRsgO1-YlWST6kDDltY8Zk4vA>
    <xmx:Y_XEaUg9F_C5KBwDAp0Muq6yaHv9DUs3GAfsaU2Oy6Dl3kNI_S8hQg>
    <xmx:Y_XEaZ-F4Jz7Opn1PwVajRkZVhmhNtaxX-QR50nmGjK2yeiWPMHB6Q>
    <xmx:Y_XEaUbZWbHmsLhxw3J23V4aPN3iDGxPLtEF-FHQKiES5wHwUCOgTg7k>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 04:59:14 -0400 (EDT)
Date: Thu, 26 Mar 2026 09:59:13 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH net-next v5 6/6] tls: Flush backlog before waiting for a
 new record
Message-ID: <acT1YXwDNbU73qHb@krikkit>
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
 <20260324-tls-read-sock-v5-6-5408befe5774@oracle.com>
 <acK5Qj-F0wGFLUhj@krikkit>
 <66157d87-2cb8-4cd7-b8cd-1e2086825995@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66157d87-2cb8-4cd7-b8cd-1e2086825995@app.fastmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271937-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 52FA433222A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-24, 15:07:00 -0400, Chuck Lever wrote:
> 
> 
> On Tue, Mar 24, 2026, at 12:18 PM, Sabrina Dubroca wrote:
> > 2026-03-24, 08:53:28 -0400, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> While lock_sock is held, incoming TCP segments land on
> >> sk->sk_backlog rather than sk->sk_receive_queue.
> >> tls_rx_rec_wait() inspects only sk_receive_queue, so
> >> backlog data remains invisible. For non-blocking callers
> >> (read_sock, and recvmsg or splice_read with MSG_DONTWAIT)
> >> this causes a spurious -EAGAIN. For blocking callers it
> >> forces an unnecessary sleep/wakeup cycle.
> >> 
> >> Flush the backlog inside tls_rx_rec_wait() before checking
> >> sk_receive_queue so the strparser can parse newly-arrived
> >> segments immediately.
> >> 
> >> Fixes: 20ffc7adf53a ("net/tls: missing received data after fast remote close")
> >
> > How did you pick that Fixes tag? That commit mentions FIN/connection
> > closing, which doesn't seem related to the local backlog.
> 
> 20ffc7adf53a introduced the sk_receive_queue check inside the
> wait loop (then called tls_wait_data(), later refactored into
> tls_rx_rec_wait()).
> 
> When lock_sock is held, incoming TCP will segments land on
> sk->sk_backlog, not sk->sk_receive_queue. The sk_receive_queue
> check introduced by 20ffc7adf53a doesn't see backlog data.

But without this check, we'd go straight to the EAGAIN/sleep cycle, so
things were even worse before?

(btw, you don't need a Fixes tag for net-next patches. if you think
this is a bug, the patch should be extracted from this series and
submitted separately for the "net" tree, with the appropriate Fixes
tag)


> >> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> >> index 8fb2f2a93846..84c4ae0330d1 100644
> >> --- a/net/tls/tls_sw.c
> >> +++ b/net/tls/tls_sw.c
> >> @@ -1372,6 +1372,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
> >>  		if (ret < 0)
> >>  			return ret;
> >>  
> >> +		sk_flush_backlog(sk);
> >
> > Do we need to update released when this returns true, like callers of
> > tls_read_flush_backlog() do?
> 
> Good catch. v6 will do that.
> 
> 
> > I also wonder if we'd want to update the
> > caller's flushed_at to avoid bypassing the "smart checks" in
> > tls_read_flush_backlog().
> 
> The flush in tls_rx_rec_wait() only fires when the loop finds
> no ready message, which is the cold path.

Right.

> The redundant flush
> from tls_read_flush_backlog() on the next iteration is wasteful
> but harmless. I'm not sure the additional complexity would be
> worth it, but if you believe it will add some value, let me
> know and I will add it.

No, that sounds ok. But probably worth a quick mention in the commit
message about this wasteful sk_flush_backlog() when we've already gone
on the cold path, and we can revisit in the future if needed.

-- 
Sabrina

