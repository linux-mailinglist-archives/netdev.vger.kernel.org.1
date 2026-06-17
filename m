Return-Path: <netdev+bounces-300112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OoB1Lwp0Mmrw0AUAu9opvQ
	(envelope-from <netdev+bounces-300112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:16:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB2C69866A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:16:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="Q QWRis/";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=O3iwMR7g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300112-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300112-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22CF63044E5A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5373D2FFB;
	Wed, 17 Jun 2026 10:00:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B739F162;
	Wed, 17 Jun 2026 10:00:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690439; cv=none; b=l+nSJ926lCIoQX3bE4qxIGGhFA7AbNEEuHuB3pXxLQc/hi7hzHTt64TWcYOHgY758UgBiy+KG/mSwBibcPYWg0h/XryvZb2EgtDw/OtzHbOkJ+MCyuGNpcgWw6Jx/6Jl0L/2DUkU4FcZcgMpr6+5OoMslnUEVFd9IhVshK8jPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690439; c=relaxed/simple;
	bh=vFePy412tZrj1pquGV7Iqax3UX1paocgmjl5R+aD3ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ6p98KMG/Li5AwFGad+mn45k9OwgvWzZYjwiOw2WfmEnQAtFI4BYYgd3fwdxpBhs9FjOnCbtCE103cQ+JfEkA1qIlGEKF/STwrSlkJeOpdbQtBftlsg6a2AUNV7BLdCsrKEfvLxzlooSI9YEXFCeyPBzgJxqa0qH8qjRpu3V/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=QQWRis/R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O3iwMR7g; arc=none smtp.client-ip=202.12.124.145
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 031091D000B5;
	Wed, 17 Jun 2026 06:00:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 17 Jun 2026 06:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781690434; x=
	1781776834; bh=Iitia+nm4SEU8NOqdpm1cv3/pVeEmHmNmKX2zgwhAks=; b=Q
	QWRis/ROh1JFz9l2Q79JCsnOXJz+NO+iOAUs361Ttmzf3Ag6ealOuA9k8dulvlaM
	JNK6Npbgp9quyvpdYcC0ZJzJrpvcLRu+aANa/iplPofx3ooo9Kl3I9IESpJojNUp
	bogiM6+E7aAK5X1DGeeMsqQCvqRGCQZoTiroFyoMzH4kmFlNs1iSYziR9sCqaFVU
	mieHW28W1cNmgwNLKo9c5r0vZ5t4m1BoL4qrg7B8QVA/nYYfxDdAHtDMsO9MuJyo
	VZGrkEu4hnp+ziIECBapv41lOQDiiZWG0N9I+EceGFSbNTrUC/DEnQX5VdzylhuZ
	nG6ANeShj62Z56HHcG3vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781690434; x=1781776834; bh=Iitia+nm4SEU8NOqdpm1cv3/pVeEmHmNmKX
	2zgwhAks=; b=O3iwMR7gBaXTkFNLR6nkMcGdoJstDx9gjykgpJJOxI7LJTLbAbi
	jWVx7mtYlFFYuFdTbpGyIrrHEoGBSbVVqkSDUOd1pHVdhXUbr4elu7UfivLUQeNz
	uASLFw1jQtb5ikN0zw/uGLr226NCs0+VKnjDtgoPN3fa26EG9Fx8LrDumiGEeRNQ
	lq/bjvHzivuDgt544AOF0t+yxDdKE2ZAnVuQQx53gD8dsRQ8zxQZXBtioKxgLGPy
	DaGdSrS9qxdXKaSwVUjAxO86LPXcGHCRk9KfAmivI6Evv9sODjyMPwWTGAxf2e4T
	r0z5he/SR1T5gATIllVxxJFIx1R6ZeTunHA==
X-ME-Sender: <xms:QnAyavvSg2oqsXAniyFd9VK9sUGAYUVdizMer9JgBATtKDLa7jb4_A>
    <xme:QnAyamfOFMyJLujgh6w-uLCgdxNsSoCCnqrOWDelRHEjkA5WFlUQlybd5cOrb28Fn
    ZCb8NCD-BwnyIoZIypMghG3MdD8usIwGN2k9YfpmQ0DKpWbxDNfLw>
X-ME-Received: <xmr:QnAyatnUAMPyiPpUgbmlUhE1cHQRphVbFFb8a_5S3HzOp56SuY8u2r4I_T8tCCPAGyinlBm5DyP-EPyXDBDqIcw>
X-ME-Proxy-Cause: dmFkZTFzZPdHrXtsdAZHUBxb7Zy6lBmBdO6Jhk0EUHgTJOXZ4Kin/PP7fYFwr90S70K0ew
    kjp29eJi1sVn/IajN8AAo2Bu/g7mF890tQwE6w7rEYV4XpVv2WSyywdsAfDbfYkyGj2HPL
    M2CPpT8W0KTyjvsB2iUTFB5Yk3o0uyGFHbfnTmzOs5OU5PRqbg4cVheu8oGXPowgJ3ZJwP
    ZMC4/sMtF+B7xPUSxmRl/Qz+lQM6aWzRufFwFutfM+lLgZI0BnC5EjFOBTyUZNyP+pzRy1
    yOB4Nwd1OpLJMr5crXw8D3pWHnrUBi2Mkeg0rSlGOaCBdEHj0hVmZaw4pQfnxiTsHKllom
    WGiQC3estGvBo3rmNHIkAF8OokHeyvHsyG910BFdQFw2cANXOAPiSLRyXDzV057rCAdTsR
    jlj/5pHAJE3YuwH154zbfEQ0IhBeM+iZNzQwGnqXD4vjl0oF6TAKkwq0cQv1PQLZW6Nco3
    eyfJJi8iNpv6wtc7cTCqfnmKtocSWtXpPVdNuZ8aY7FAUNnoDcrjuf/bRBi9a3FzSpsSJg
    FIlK+6yYpIfG9WsQ9F6s1fikHWVjfLnPcT5UyJHPx8hEvuiMUlbQIEFNHazNIgXVcFc+L4
    vjjRzhFO8D9cDbRKcAvjYdy9taQKkNymjewRLVUWt16lgx2iUXH9gXjIJGRA
X-ME-Proxy: <xmx:QnAyahCnE-8MQC2rIshXOrr4hx1yzcRteLWr8B59rrBYS8BlxjH3AA>
    <xmx:QnAyavNDsd8psWA1nGqFh5E7g9GDXACBpBFHOp_fn8bZr2_APuYvHw>
    <xmx:QnAyaoPGAkKxk4eucfQ_WWfLulyhzhm9G1ydllxaBNPLNlkZPCF2wQ>
    <xmx:QnAyanl7misnariz7y2VaJBqMHjP5LA_CspkpXlAO6E9qjOxKLHpRw>
    <xmx:QnAyagpTMaThk_FSL738n35z3GQPdGIpwTaua6pxbh7bdAYkzEYOJxjl>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 06:00:33 -0400 (EDT)
Date: Wed, 17 Jun 2026 12:00:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in tls_err_abort
Message-ID: <ajJwP14SWmdwwFYg@krikkit>
References: <6a315d48.b0403584.28d0ff.0002.GAE@google.com>
 <ajFpejsl1ukTbG96@krikkit>
 <20260616082816.4dd0f035@kernel.org>
 <ajG5hg9oJvyxPplG@krikkit>
 <20260616142359.43300727@kernel.org>
 <ajHENGWdBcbQUpWS@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajHENGWdBcbQUpWS@krikkit>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300112-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,queasysnail.net:dkim,queasysnail.net:from_mime,vger.kernel.org:from_smtp,krikkit:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:john.fastabend@gmail.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,redhat.com,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cca46a9d1276f38af2ae];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDB2C69866A

2026-06-16, 23:46:28 +0200, Sabrina Dubroca wrote:
> 2026-06-16, 14:23:59 -0700, Jakub Kicinski wrote:
> > On Tue, 16 Jun 2026 23:00:54 +0200 Sabrina Dubroca wrote:
> > > 2026-06-16, 08:28:16 -0700, Jakub Kicinski wrote:
> > > > On Tue, 16 Jun 2026 17:19:22 +0200 Sabrina Dubroca wrote:  
> > > > Don't we depend on it being set
> > > > to avoid further state transitions once we hit a crypto error?  
> > > 
> > > I kind of thought so too.
> > 
> > In which case the question is whether we should try to remove 
> > the sock_error() instead? (stating the obvious I guess)
> 
> That would make sense, but we can't prevent sock_error() being called
> from some helper.

Actually, getsockopt(SO_ERROR) will also clear sk_err. If we want to
prevent further state transitions, we'll have to use something else
(probably a flag in tls_context set by tls_err_abort()).

So I'd go with 2 separate patches. The 2nd one will be a change in
userspace-visible behavior, but hopefully not one they'd be upset
about.

-- 
Sabrina

