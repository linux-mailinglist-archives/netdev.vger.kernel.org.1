Return-Path: <netdev+bounces-278127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBIpMBwV3WkOZQkAu9opvQ
	(envelope-from <netdev+bounces-278127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:09:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 315523EE5E2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878B83025916
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D922A7F0;
	Mon, 13 Apr 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MhbQ+wZt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HYDNK+iY"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E348221D89
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096124; cv=none; b=V3Re+8utS45jk0CpMxsJy/SPafAt8BRDmf5sxWlC0Lr9QbIapfVQvOu9K1GyeMExa7G8agDpktdtE82YIVnVDbWzd/NKdJb1teUiSQdZKjcz0PrJObo8nj3aIw26gREYapBf77+58BLpp4gs7wNKh3vTp5t5XTYsdsWi/Rqp8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096124; c=relaxed/simple;
	bh=zHsqQR7BRJaPVSGfOUy3T7YB7eOzTGGF84yZTiUMzGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP+DrOY5PGENS9x5sztAUeqc2U3kjnEgBmiMKO0eqB2QVs0pMt9o3tspmIqUP1NSt4pw9a4r3wposYxMhQJ9m2HEu4fSBj6vfX03c4ueJQRoZVOR4tF7QInTvh3oJti/9lD1dNbjIV20x8DsZFi9upj4MzJx3eaDx+dCQLaFGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MhbQ+wZt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HYDNK+iY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CED0414001F4;
	Mon, 13 Apr 2026 12:02:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 12:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776096122; x=1776182522; bh=UtdgojWu0Y
	Igq91sl/gba1frRjQRw1kPe3jIIkdrIoc=; b=MhbQ+wZtVhwU0wrmlXjFjx9ILv
	vTUkGL3wqKqmlAxy2tuy7xbGiQPIwPR5Srd6La3vUktWZkoImYUfF0l1ktNEPzlC
	hkn2K4P6tTV96oDvWr+/AV+23BmdofU7pizGnB1mNAF6b8Ps7/DR2+jpy83DnUxB
	VoQbVkh20EZQiKssVrYtRIAWpL/OJXFxBEYGPC5XNpsk6Eg7WUjEHnacumbJM/SQ
	4wBZyWAve7+RdvN8wAN+c5Pe7OoCmGqOtinkuCdHsRZ8wuEjltYgJDG9nZ3H1COB
	Nvh3DbU7jyEjEBhMzYiNylsCuuVpOY2mM1wwQsdnemdcdYHACd0yr5ilaCbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776096122; x=1776182522; bh=UtdgojWu0YIgq91sl/gba1frRjQRw1kPe3j
	IIkdrIoc=; b=HYDNK+iYSBB62dz1jL1NYqfYtUX5hM6lFfan32cQFaBLQtK1jjZ
	h3i5LvpJEwMfagNyj3aXr7WL+5z7gowvjeREqrn8Azl361YJnP8RA2YbI9SV2clr
	gbgxW6w57t8xH+NHeW+zrgzNrTt5V48/rEkStfIgT3hFN8lMVcAEaOhN/c+8tVu8
	+4w7SEPWg3ajn+ZglNANS/OCXe1+3NrkQ1ssaNwNdzTjg6qREaZxbMDhpz2id/kY
	+Kk2jDvSfz864qA18zEWcWL4rTDRCtIqFfxz1vzk0iWk8TSJADd3+rX2I3GPsHwb
	22aVxmZib3pSTBbFXQ4RHy6NJX2bfmu56RQ==
X-ME-Sender: <xms:ehPdad3Wqcbb3SaEi1QgAhqcU0SO73jzVqN50d-C7JUciJj28QaCNw>
    <xme:ehPdaaGpqr8KuMFTCpnOS1bVRoEE8I2PZwjLPKtLkMTfFOy4rvtFLhDQDePPyXsNO
    rGeaL5GZBoV8S2n9Hb-C54q1jGQkjcwvvOTMjmaRaHZg01GP4vKTHM>
X-ME-Received: <xmr:ehPdabjVxSIrTKFHefHv4PdAQFIQl-HKjoMwqeM10HwK5GTS_wjjd6sZHZWjO-9DuhhDmeFzU3_RprM6UYgefPrim4lOQNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefluhgrnhhluhcu
    jfgvrhhrvghrohcuoehjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeifeekhfeihedtgfeufeeivdelkeektedthfetgffhvdejgefhheduvdeu
    gfevtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegufiesuggrvhhiugifvghirdhukhdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ehPdaV-YuUlf7l5dZpP1CUepcTe_HnJxZPX0z-rNF168iu5sZE4Fyw>
    <xmx:ehPdaSq4ReZsZsDuKZu33i8eQneqY033feFFNtne9GBvyYSrYqa6_g>
    <xmx:ehPdaU8RdX-m4h-pBY1KoGwKX4kJ_9lOkCnfSa0F0ulJjJnfH113Sg>
    <xmx:ehPdaWULzsSNhEiQgB_pWFcyeeIa54edKTZyJZXng_2rE2AjYk6Axw>
    <xmx:ehPdaak3ooOy5YhnnEXQxKlASEZrd_xJ5HZWWP84vvVEK9oRUdFlPPcJ>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 12:02:02 -0400 (EDT)
Date: Mon, 13 Apr 2026 11:01:59 -0500
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 5/5] selftests: net: add rss_multiqueue test variant to
 iou-zcrx
Message-ID: <ad0S9CPmtPgICDf7@jlhe0197-mac>
References: <20260408163816.2760-1-juanlu@fastmail.com>
 <20260408163816.2760-6-juanlu@fastmail.com>
 <d3777e86-2859-491d-8071-77871df13c08@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3777e86-2859-491d-8071-77871df13c08@davidwei.uk>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278127-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,fastmail.com:dkim,fastmail.com:email]
X-Rspamd-Queue-Id: 315523EE5E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 03:26:54PM -0600, David Wei wrote:
> On 2026-04-08 09:38, Juanlu Herrero wrote:
> > Add multi-port support to the iou-zcrx test binary and a new
> > rss_multiqueue Python test variant that exercises multi-queue zero-copy
> > receive with per-port flow rule steering.
> > 
> > In multi-port mode, the server creates N listening sockets on
> > consecutive ports (cfg_port, cfg_port+1, ...) and uses epoll to accept
> > one connection per socket. Each client thread connects to its
> > corresponding port. Per-port ntuple flow rules steer traffic to
> > different NIC hardware queues, each with its own zcrx instance.
> > 
> > For single-thread mode (the default), behavior is unchanged: one socket
> > on cfg_port, one thread, one queue.
> > 
> > Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> > ---
> >   .../selftests/drivers/net/hw/iou-zcrx.c       | 81 ++++++++++++++-----
> >   .../selftests/drivers/net/hw/iou-zcrx.py      | 45 ++++++++++-
> >   2 files changed, 104 insertions(+), 22 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > index 646682167bb0..1f33d7127185 100644
> > --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> 
> Please make all changes in iou-zcrx.c in a single patch. Then patch 5
> only changes the Python selftest.
> 
> [...]
> > @@ -397,12 +410,36 @@ static void run_server(void)
> >   	if (cfg_dry_run)
> >   		goto join;
> > +	epfd = epoll_create1(0);
> > +	if (epfd < 0)
> > +		error(1, 0, "epoll_create1()");
> > +
> >   	for (i = 0; i < cfg_num_threads; i++) {
> > -		ctxs[i].connfd = accept(fd, NULL, NULL);
> > -		if (ctxs[i].connfd < 0)
> > -			error(1, 0, "accept()");
> > +		ev.events = EPOLLIN;
> > +		ev.data.u32 = i;
> > +		if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[i], &ev) < 0)
> > +			error(1, 0, "epoll_ctl()");
> >   	}
> > +	accepted = 0;
> > +	while (accepted < cfg_num_threads) {
> 
> You're using epoll here but it is still accepting a fixed nr of
> connections. The server should be able to accept an arbitrary nr of
> connections, dispatching them to the server worker threads.
> 
> Also with multiple queues, connections must be dispatched according to
> their NAPI IDs to the correct server workers.
> 
> > +		nfds = epoll_wait(epfd, events, 64, 5000);
> > +		if (nfds < 0)
> > +			error(1, 0, "epoll_wait()");
> > +		if (nfds == 0)
> > +			error(1, 0, "epoll_wait() timeout");
> > +
> > +		for (i = 0; i < nfds; i++) {
> > +			int idx = events[i].data.u32;
> > +
> > +			ctxs[idx].connfd = accept(fds[idx], NULL, NULL);
> > +			if (ctxs[idx].connfd < 0)
> > +				error(1, 0, "accept()");
> > +			accepted++;
> > +		}
> > +	}
> > +
> > +	close(epfd);
> >   	pthread_barrier_wait(&barrier);
> >   join:

Makes sense, I will re-work the patches and address the epoll & NAPI
id feedback. Thanks!

