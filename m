Return-Path: <netdev+bounces-131698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF798F4B8
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197E21C20A23
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526771AAE3E;
	Thu,  3 Oct 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r5tSARF1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ur7ebvpJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r5tSARF1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ur7ebvpJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A71AAE22
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974894; cv=none; b=Ml/50fi3b0T16S5EhVe8hLRDVxNoHrtYivZEGVYRX1SLUaxn40nj4gbvUykQCA1qeLwbE+4nGjZ8hvnh0F+HRmPJIldyEy2ZN1P/WlmgEtptmMafKlIYD4/y4ipqeDOJsayVI8ocC+w7vMeTyDg3X6Ba0QuIuezbSnd150/EHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974894; c=relaxed/simple;
	bh=ZH9/xvczyxGO/KzhLt0DC/8ZDsqNWNcJW8TFtmNg80c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onKY7YJh/2EYytUz2nytCfi3ibpJYTqG0/vgDxSFHfRGPv4mGzLefiyRdd7JQQ931SzLaBxTasrIRd3K/enSOY7K7dSMeAPAwN2yZEkfhMJV+zCYYWX85yz4am2lpOv2n2DYBuLZGBnQx1BQnGbI5Z1GVHxob/8p9F8n4HZWpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r5tSARF1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ur7ebvpJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r5tSARF1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ur7ebvpJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC3E71FE0D;
	Thu,  3 Oct 2024 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727974890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJZWdu51ctOQG2yIYUdXBgVnJ/n/J33UfeMA/XPjr94=;
	b=r5tSARF11RnHTCUcOG5ESMZ3dq7igZ44eNRsaNnmu+rgmXPZh7ykvKlQE7XMKrlQO98cdx
	bdedUIlvdXuhMfCnRHA0YocLNxdKlE5VrBdN9XqZjrp6971btgy+QKR8qOxiy/61mAm0oY
	/5I4p668don6+1Vd78a91EFnf0l3VzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727974890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJZWdu51ctOQG2yIYUdXBgVnJ/n/J33UfeMA/XPjr94=;
	b=Ur7ebvpJVwNTWv4p3UQyIYQfFWfoP+Wzf0TF/P5CG3CBJK1G7zrpw965YVELLhjZj+8AJM
	Lz5lRrHn9IE3xfDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727974890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJZWdu51ctOQG2yIYUdXBgVnJ/n/J33UfeMA/XPjr94=;
	b=r5tSARF11RnHTCUcOG5ESMZ3dq7igZ44eNRsaNnmu+rgmXPZh7ykvKlQE7XMKrlQO98cdx
	bdedUIlvdXuhMfCnRHA0YocLNxdKlE5VrBdN9XqZjrp6971btgy+QKR8qOxiy/61mAm0oY
	/5I4p668don6+1Vd78a91EFnf0l3VzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727974890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJZWdu51ctOQG2yIYUdXBgVnJ/n/J33UfeMA/XPjr94=;
	b=Ur7ebvpJVwNTWv4p3UQyIYQfFWfoP+Wzf0TF/P5CG3CBJK1G7zrpw965YVELLhjZj+8AJM
	Lz5lRrHn9IE3xfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A284913882;
	Thu,  3 Oct 2024 17:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m4SrJ+rN/mYsfAAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Thu, 03 Oct 2024 17:01:30 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 5D2EEB2042; Thu,  3 Oct 2024 19:01:26 +0200 (CEST)
Date: Thu, 3 Oct 2024 19:01:26 +0200
From: Jiri Wiesner <jwiesner@suse.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH] ipv6: route: release reference of dsts cached in
 sockets
Message-ID: <20241003170126.GA20362@incl>
References: <20240930180916.GA24637@incl>
 <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
 <20241001152609.GA24007@incl>
 <CADvbK_cmi_ppJyPwmh77dHgkm=Lh52vtEWddwSAFNhZpmmev6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_cmi_ppJyPwmh77dHgkm=Lh52vtEWddwSAFNhZpmmev6Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Oct 02, 2024 at 04:27:55PM -0400, Xin Long wrote:
> On Tue, Oct 1, 2024 at 11:26 AM Jiri Wiesner <jwiesner@suse.de> wrote:
> > I am afraid this patch is misguided. I would still like to find the source of the dst leak but I am also running out of time which the customer is willing to invest into investigating this issue.
> Is your kernel including this commit?
> 
> commit 28044fc1d4953b07acec0da4d2fc4784c57ea6fb
> Author: Joanne Koong <joannelkoong@gmail.com>
> Date:   Mon Aug 22 11:10:21 2022 -0700
> 
>     net: Add a bhash2 table hashed by port and address
> 
> After this commit, it seems in tcp_v6_connect(), the 'goto failure'
> may cause a dst leak.:
> 
>         dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
>         ...
>         if (!saddr) {
>                 saddr = &fl6.saddr;
> 
>                 err = inet_bhash2_update_saddr(sk, saddr, AF_INET6);
>                 if (err)
>                         goto failure; <---
>         }
>         ...
>         ip6_dst_store(sk, dst, NULL, NULL);

Thanks for pointing this out. 28044fc1d495 seems to be an interesting commit as far as the number of Fixes is concerned. The commit was not backported to the 5.14-based SLES kernels, for which the unbalaced refcount bug was reported. The commit is part of the 6.4-based SLES kernels so I will have to see if all the patches with Fixes tags have been backported.
J.

