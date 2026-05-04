Return-Path: <netdev+bounces-283850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9YBFFzSg+GkgxQIAu9opvQ
	(envelope-from <netdev+bounces-283850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:33:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A23154BDECE
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE5B3007368
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651993D75BF;
	Mon,  4 May 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="BhWlE1Zp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oOiqHwnX"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79813D5642
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901616; cv=none; b=DOi4oF/R7aWVhFRex1zIrDqwCE9rwFDpT4siCsIJ6QqCxzdfX70isj3QUTjKyYxRGYU5avl4XrY68Kbo4LmqizKs2i+pj5oOAL8oEt0Iki8yNPmVBqmBB8Z4TRyOnhYTVVhWFwmlC78F9bt6QVa8lT3v8Ps8Ey16QCyXd+zyW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901616; c=relaxed/simple;
	bh=17hTDSvaPtKhuQVLwIiqwqmRRNL4ReFrnXooVhB5+Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etX43LLf29Xj1Ft1aAoxH8XxeCoG2DJtDvhr3pIeOSQ6BBCWf/ys/Okqk763XYAFcYYdcH/6GwZFknYEzwlrsEA6iz3WnEPUP4MwbEh5lUbg52788bd0Myt/8yN7kgk6Z0YtNfhkkAgHVBa2DBDKszkaKvBRHwvqQJeT/oeRv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=BhWlE1Zp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oOiqHwnX; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B54FB7A0065;
	Mon,  4 May 2026 09:33:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 04 May 2026 09:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1777901612; x=
	1777988012; bh=YVKA7BH3EoRCoupsBSXH71xVJ9Wcy7+XJR3rBZAUCe4=; b=B
	hWlE1Zp0mq8iLF5JDXn1rN7qtUrdTXnMFedwIdACrq8yEMMJ1smrHShdvNGBS/IM
	Ssn2oKjZGo3kmHvbyEHarbzoisRWUPMGhNmK+6inucHD0fHtfn7c2BrMIkCb2tVt
	klR+tBwuwByJcPaArkKH52xZHg95MjQUdV5rs0eVlgiZpOZzZEnXO1jF6dQ2t0Oh
	CKT5qzIh8BSL1Aa593XhnuAAuz865S8sZAEdYd7+ps9RYqPKgq9nbIKf6mzy2zcg
	hT9kt+dxL7sp2qybtwi3RGi9t/Sj+wG6SZHCziy2DSgK1CesH4aOetf0xDbr7zjU
	mbiZXx9nTSPWTMYsIuXaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777901612; x=1777988012; bh=YVKA7BH3EoRCoupsBSXH71xVJ9Wcy7+XJR3
	rBZAUCe4=; b=oOiqHwnXxEBjlsS11UqePNt0MN5BLcOgVeV4OI+2hp9aSKW3R6q
	3YO8qK71rL9laROZ4Vv7M/+lGzLWGMHtvf+r6/DV9QEcnq+yMPsV4nj5a+4gNPFP
	FEZWB/rElESwQZrmOENRhvXZvklFqHOxf4Rhi6Cm4w1t/ext29SifkfjwCS9Ha1s
	550HFOTfdlfmuK1PGDNvgAxca6I8a9/Lv3z2e/haRLX453qNgNHFT6WbFqWKNexJ
	m6ZZy3Eme3czQQBdPE+GcPOLvKBa/qYsK9SaOfzFyOyngxSy/uhe+WkZhsHOAp7h
	HI8cptoxWrmtizU5QMAmEEkCX0WQwmMpVfA==
X-ME-Sender: <xms:LKD4aaCvYfOmsZAz1nBhuAR9jVmIAPL7E0u1IJ2dKs7UiXSR4lUFaQ>
    <xme:LKD4aSwNWm6F6KA0DLNY0mUaEwNuQBFgM0Op77b70AqKnCvjvjktyO8gp5-0HyroB
    W1ZU4DadJdBans8L5DsZtBMwjM7ejpqZFm23yr0wZtqs7hPJhP4HMU>
X-ME-Received: <xmr:LKD4aW5nCyho3jzLjQEugLN-uQHvQIlgcKi-Nzwde3HsP3X6ucUxGQfJOUPD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeejkeelveelkeefgfeuheevjeeukedvhedvueegvdekleeghfelgeeiveff
    tdeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghs
    thgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhs
    qdhhrghnughshhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptg
    hhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:LKD4abywFAD-EPV_UCFXQRdCci1HLBBLDc2Y2ZOHcJg8KxDamtUW8g>
    <xmx:LKD4aSdDs2Q5ohFVh2LErB-zNwpyQu539QGklRLlRY5yQGNjVF5kiw>
    <xmx:LKD4aYAMzmVoIFmmSxbv6mtBmS-kACKTQdLsrK0m5G41nto6FglH9w>
    <xmx:LKD4ae6LR8aBlW9AuerfTxd50Vkk8WxObYlDhIzy0HdLzt3o16g4Jg>
    <xmx:LKD4aREnKRztkNTYpJO_hpKasvsFjoESxgTQ64PjbUi5aXSAP7rEWRO9>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 09:33:31 -0400 (EDT)
Date: Mon, 4 May 2026 15:33:29 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v9 0/5] TLS read_sock performance scalability
Message-ID: <afigKenambAyKkhu@krikkit>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
 <20260502180415.0b0bf12b@kernel.org>
 <2d2b5da3-3bfc-4882-8886-8f20b61254e3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d2b5da3-3bfc-4882-8886-8f20b61254e3@kernel.org>
X-Rspamd-Queue-Id: A23154BDECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283850-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]

2026-05-03, 21:34:01 +0200, Chuck Lever wrote:
> On 5/3/26 3:04 AM, Jakub Kicinski wrote:
> > On Wed, 29 Apr 2026 17:48:07 -0400 Chuck Lever wrote:
> >> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
> >> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
> >> this to Hannes, he reported a few performance scalability issues
> >> with read_sock. 
> > 
> > Meaning, this series achieves.. what right now?
> > I mean - the headline is "performance scalability" and there's no
> > performance testing result in any of the messages :S
> > Patch 5 for instance "seems logical" but how much difference does
> > it make?
> 
> The cover Subject: line has not been changed so all the revisions of
> this series can be located easily.

(not to bikeshed, links to lore also do that)

> The cover letter makes it clear that the series is now only a clean-up
> series. Since async_capable is set to false for TLSv1.3, there is no
> performance benefit to these changes, so I don't intend to post a
> motivation for it based on performance.

Maybe I misunderstood, but I thought there was a somewhat noticeable
benefit to the "suppress spurious wakeups" patch (not +20%, but at
least improved behavior for some users of kTLS), and maybe the "flush
backlog" one.

Patch 2 may still be beneficial (though it's now mixing 2 separate
changes), and patch 1 is a very reasonable code cleanup.

Patch 4 does feel like a pretty large amount of churn if it has no
observable benefit.


> > FTR async support is a major pain and we'd rather get rid of it
> > (and switch away from cryto API) than extend it.

(the "don't use crypto API" thing is news to me, that seems to be
trendy these days)

> That would have been nice to know three months ago when I started work
> on this series.

I remember discussing this with Jakub, but I don't know if that was
on-list. There's been a lot of bugs in that code.


> We'd really like
> to get TLS KeyUpdate working for in-kernel TLS consumers, so anything
> that can move this process forward is welcome.

But net/tls doesn't need any changes for that, right? net/handshake
maybe, but that's a separate "component" (MAINTAINERS entry).

-- 
Sabrina

