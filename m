Return-Path: <netdev+bounces-280378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAecLHem6GmZOQIAu9opvQ
	(envelope-from <netdev+bounces-280378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:44:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C35444DFA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8C0530387DC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9408A3CD8CA;
	Wed, 22 Apr 2026 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="uEw11Ere";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VkDnfR1T"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DC3C277B;
	Wed, 22 Apr 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854619; cv=none; b=Mm1KHdu0TJNn7wSYApovG2bb1LrdXqDZQ2Zkx3n4GE+CYjcD8GhHoOd84sD7q75VAPq2Qv18b1Jm5jWqdATzzNEZbmgZMZ0CB0s3XL3hT3uacixfufLuYfpO6aLEFOxEeBwPUHiejquIvTwCPP65Kp4JentAs67ae8gzocm+gB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854619; c=relaxed/simple;
	bh=uM1m22NQCJC6W6RjzJbd6hba2pmg1Gp2U5erA96FCJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtARE2fUVxMN/imlOjVX4noDW9/hYI1G23qm5gd2GfhFIrp5CkD8oixzi9jZ4K8p5RwCW+Ifwd5OAXwv1GvYfmTASNRzOOGZotUbA9vXCLsFHJ8xX6IXp7zqfMYmDvmeiRPEYgwTacqQn0ATkMcn2qyjvPvRq//r5hga/jEbOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=uEw11Ere; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VkDnfR1T; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38B6714000E4;
	Wed, 22 Apr 2026 06:43:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Apr 2026 06:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1776854615; x=
	1776941015; bh=abmoqNblxfuAVDr9rChyocYxcejJ84mZ8H9MflgsjCU=; b=u
	Ew11EreFFNLlLqsYtfzP0GgKeZ2Sx9qaSIjq3TuuIKmdYK7FDPwZH/aPmQPaWo1t
	r7CJx27SCVjplvbzbwkVBgZpKY4r2J2YEqSFBURmZJWC/SBDOdRnpAoIhvBK5w/7
	upBwD0JjOiYsS4urhR2RIrkzS7MJqaSzcYsJ7U6wOvS+Tu5W631Z8POdAW74FDUg
	rxJG09JQkWVAwH9lTLAIQtZkOEz/sYWDGJdfZ3xdcOLRDEttjyn7eijuaVjR8Nkn
	Ngbk3XE4aSHact/zrPQCiE13obvt5KsdoYvDVFm7GqfoJ1RR8Y9iLMCw0d5XH1GS
	7+LcHnJJRrSC5azfamhJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776854615; x=1776941015; bh=abmoqNblxfuAVDr9rChyocYxcejJ84mZ8H9
	MflgsjCU=; b=VkDnfR1Tzp6v7lLd4fXV7kfa6v4sMTq67FXSbr69EmO+AzKlR4B
	xh3IyIckEye6hbXwYIGEDTbZdxWRK0aiwfU/mGsxk6DGWZxQ9NsiMIPR0RV2UdWi
	lZJuotMmJIy2ckaiGN/dbB0gjfbXhdo/hp1o67dgn9rEvxc7oqg5lyjXbtjUnt8s
	gJr3lsp6PobZ+UWlsglFP/1XggWhhsmqUip44xbZOS0Sp7sjyeURVeHR0HdTu/5t
	byx8roVHNLSTTX5S9wOMpDqH3C/sCoZeEY0lhKAmiuEWo3JkF/jXKHV8CWZn/9Tx
	ohiYYE6vrT7XgviqWOtaVGCfXahuwNbkdcA==
X-ME-Sender: <xms:Vqboaac5e0q0c1kjg2EFkW7QkhSycDERUIQwnAbizoJcQWVlxj9hgg>
    <xme:VqboaZJLxHHl64aGT8WX6V71nHSUifG7dc1LQN_esXGorgzdi4AKGB2lpC7xnetou
    lrYqba4k_AMYj7Qtya-qOhrWxZ2zfke3xTSC7fBWocj9963Uk4lghk>
X-ME-Received: <xmr:VqboafyIkZQx2zYekB55gPTbux-pFnoaDvRhxSHAvYOnFgzI9KA52USJUGo->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhilhhinhhmrghosehkhihlihhnohhsrdgtnh
    dprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohep
    ughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmh
    hssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VqboaXtx--QqrM0uz3fYDmDloxouxuOznzH5l08cj6u8nPgNsyJo9g>
    <xmx:VqboaaDPbnedMDXNAkjEDKn9h9O3SizquM5uh54swheWS742YpfYfg>
    <xmx:VqboaREOBAiMeg5FYAGLZAg-zjdZiaFao-1e3UK_XGOhdK2iP29M2A>
    <xmx:VqboaSB8rzeF5g5AARdtcMHtnMJssE59ViFJqqqm5e3M2udAaWCkww>
    <xmx:V6boaRygc9dKZPh5ZVepxeoT44jiDfOBhL4CQg0UOL22syODzkF7UqmS>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 06:43:34 -0400 (EDT)
Date: Wed, 22 Apr 2026 12:43:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: addrconf: skip ERRDAD transition when
 address already DEAD
Message-ID: <aeimVEuF6Sn8l0x0@krikkit>
References: <20260420032842.1063277-1-lilinmao@kylinos.cn>
 <20260421075033.1110816-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421075033.1110816-1-lilinmao@kylinos.cn>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-280378-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 53C35444DFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-21, 15:50:33 +0800, Linmao Li wrote:
> addrconf_dad_end() transitions ifp->state from DAD to POSTDAD under
> ifp->lock and releases the lock.  addrconf_dad_failure() takes
> ifp->lock again with the spin_lock_bh() following the
> net_info_ratelimited() duplicate-address log.  A concurrent
> ipv6_del_addr() can acquire the lock in that window, set ifp->state
> to DEAD and run list_del_rcu(&ifp->if_list).

You're pretty much saying that the ifp->state check we did in
addrconf_dad_end before dropping the lock is not valid, so it seems we
should just skip that separate check since it's not doing anything
useful, and move it under the "main" lock we acquire after the
net_info_ratelimited(). There would still be a problem with "we
dropped the lock in the STABLE_PRIVACY block", which your patch
handles.

> addrconf_dad_failure() then overwrites DEAD with ERRDAD at errdad:
> and schedules a new dad_work.  The work calls ipv6_del_addr() again,
> hitting the already-poisoned list entry:
> 
>   general protection fault: 0000 [#1] SMP NOPTI
>   CPU: 4 PID: 217 Comm: kworker/4:1
>   Workqueue: ipv6_addrconf addrconf_dad_work
>   RIP: 0010:ipv6_del_addr+0xe9/0x280
>   RAX: dead000000000122
>   Call Trace:
>    addrconf_dad_stop+0x113/0x140
>    addrconf_dad_work+0x28c/0x430
>    process_one_work+0x1eb/0x3b0
>    worker_thread+0x4d/0x400
>    kthread+0x104/0x140
>    ret_from_fork+0x35/0x40
> 
> Bail out at errdad: when ifp->state is already DEAD. The existing
> in6_ifa_put() releases the reference taken for this invocation.

Mentioning "the existing in6_ifa_put()" is a bit confusing since
you're adding a separate unlock/put/return path.

-- 
Sabrina

