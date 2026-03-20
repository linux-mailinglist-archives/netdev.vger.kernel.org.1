Return-Path: <netdev+bounces-269815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPOeLoz2vGkt5AIAu9opvQ
	(envelope-from <netdev+bounces-269815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:26:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6342D6959
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7DE4307720A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE771FECAB;
	Fri, 20 Mar 2026 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="oxkG1np1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5l9i2T7z"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5A346AF0
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991428; cv=none; b=dSQfm34U0zN+c99EK8kTJM6dUAJK6rcDjsa0w1V43ozFd//IJtFGfJspeHjDG71lt9zDDSwUpD7fufh9oW4pOEL6ksGRiuFz1DSa2rj/fnnoyrH6iiE1IyMTOl89HVnxfFjtlzgRUUn7ZlfUvp0G8eEDBU7H6qaqr2WrShTASLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991428; c=relaxed/simple;
	bh=Y9OVeBeeN5Q3PsVNqTcmhtkG6LF1hCye0tFHmCw/Svo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3pZqKdbxqaW+Ccq4BxXDUOCfODe5Ib0CYVRNEOJONTQCxjOYM6uFSg0p1QVCMRy/7iUk9fMhnuBOQHVgknrBk4mYxpVfQbuClurAQ/vNU1mfAPJXpVZxgaUJDXf+TJXsaNlljTqXjikrf2PmrxlhnJP5aW0kSefeNCFVY3gMUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=oxkG1np1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5l9i2T7z; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C14C1D00192;
	Fri, 20 Mar 2026 03:23:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 03:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773991425; x=
	1774077825; bh=m4jyU1+JxgeUKMr0Gw6YvLM9rurXxcaOQ2rHtLirRZw=; b=o
	xkG1np1xk5BXK3AchAPsC5AkHs9M08UyPNnhhhbTKPf/xs8F3iyMlE27/4fygMHD
	7QWVa3mWHli6/EX03ufzYxVGrqLF0iwiXrGbCD2TOKRedzabcJnhHoqOOZppMc5W
	3a4FubcoBheXC8LDa+lTsdR2xhTi4/w69QuPIlz5kcON3daa8W9BvwYsG+RGxcT+
	j1nrRx+k2n9zrLQJw3HXyE75xji+Vq0xC8Y4InMemg8lJZ1unR1wGkdvx1vCtapY
	bjSwj733N/xmzCcHKnM4KAtMaXrgM+mgFdSlp3ugOoXsrOWhpplSHUMvVIuIzNv7
	p2zvjgxM6TPSJiw295rLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773991425; x=1774077825; bh=m4jyU1+JxgeUKMr0Gw6YvLM9rurXxcaOQ2r
	HtLirRZw=; b=5l9i2T7zEXtzetBppWF4x+99eJv1OAK9Fgttvr7EyG9ykwGAwSz
	KADh7nf/W24D6W+SlipUB4i2RyxbtODuYoWWSD2nbfmScBrL5TR7SUkU5nRBF2XG
	zwNuJlc72T5FLIUJTPd5opWvP5UYdhOO+wLLp/FEHQwgLUVqLz8oJySJYGB5XSj2
	rrS1iwFhPQoscZSEKGOYFNPsyC1PKA2F+QtgEGTMgXqCcuhOkzvvK2NSdY7cR+kb
	Dhk73VcZzGKD/yRfZuQBeCEoeAgjNTxsUgb3LEXdnmV33b69fkEYtFr+nPVRneCA
	t1isE5P/CAR3biIA0PRBrq8ieTDYybJ7KUA==
X-ME-Sender: <xms:APa8afPAXKee7LoqIofWzutHkYyOEUGkmY3-yzz8k7MBBmdFIRhVGA>
    <xme:APa8aRZxruPNMrcY6JRc6tz6o2AScWE3PvZby7GtgD1duO5MugDFvcnzmEjhE96dc
    51ZzJv3lHdJeseb3fDsmXPIlnvCS_T49VEMLu4r0RGuX5fWNX3Q4w>
X-ME-Received: <xmr:APa8abrypTN9UiBaiNte_IRETAtcHpjj3je5GkGPoprz7p1OGYKU77LZRR98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khhunhhihihusehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:APa8adb4_Q288KlXBu5_7WK5nO9b1IJqKIF2NBOhLGC5Ty1LBpwJog>
    <xmx:APa8abSyXIaqRtClbPWSttS_MRBeGDc4R36_VbXO7oUIYPhmLilR-Q>
    <xmx:APa8ac5Ph15ek6yGEfRvrd5YUAQZYPtPeVIpt0muwRs-Cial6mf46A>
    <xmx:APa8aYwYC3XwoErVUn6r1z5A0Ug1La-0ZqMQjMs_vloMfAjNEOQctw>
    <xmx:Afa8aRC-S-JoJ6XA-fXAB9I5jD4X4QDTgPdxaZruf2cqDUO9AArSL6rq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:23:44 -0400 (EDT)
Date: Fri, 20 Mar 2026 08:23:42 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net] rtnetlink: fix leak of SRCU struct in
 rtnl_link_register
Message-ID: <abz1_nbd2ep-RL6Q@krikkit>
References: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
 <20260319170541.27c75eac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319170541.27c75eac@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269815-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 2B6342D6959
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-19, 17:05:41 -0700, Jakub Kicinski wrote:
> On Wed, 18 Mar 2026 17:15:15 +0100 Sabrina Dubroca wrote:
> >  	list_add_tail_rcu(&ops->list, &link_ops);
> >  unlock:
> > +	if (err)
> > +		cleanup_srcu_struct(&ops->srcu);
> > +
> >  	mutex_unlock(&link_ops_mutex);
> 
> Does the cleanup have to be under the lock?

Right. I'll send a v2.
(OTOH I don't think we'll ever have to worry about contention on this
lock, but we've probably said that about many locks in the past)

-- 
Sabrina

