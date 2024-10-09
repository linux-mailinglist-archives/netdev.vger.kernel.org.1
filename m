Return-Path: <netdev+bounces-133715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28374996C5F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9951E1F21B14
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5A197A97;
	Wed,  9 Oct 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="COSgkBfp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TEcH5P3y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="COSgkBfp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TEcH5P3y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A316F0E8
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481177; cv=none; b=mxfGJiCFBEJqBWfpaidPFdkgXZopdYLVM96kL4TnbcrbxBMhybuzBxoCePT3TIT0ZtAe79gDBzwgqDLpHfnklCTi70cftfm5bRQrNSMjGDNf/iYnyTkueEtXB38Z0qPszH4snaoPUnE00c+cbLlOG8v3wT0s9YIQpmYiWE/dfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481177; c=relaxed/simple;
	bh=5/NExU6bQv6+nWqvtNc+xL5vIZX03Kd0+mRkQDRaesI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhRqa1L9DNyQYNTwsuPnlPQl3dpjbYW6UOnZ9lmQiqsJ4qva3JyJ+/u8WEUVY2J4+ayx/kHCJstkSaipSpTQXNNKXNaesGWq6ThBAS2CLMhlLRaYyaO7t3ojhzdjkoMNsxoLkXoaLLA3XARyuqxKaHBeyZAy/NmhDFyYfqbBD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=COSgkBfp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TEcH5P3y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=COSgkBfp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TEcH5P3y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C944921F73;
	Wed,  9 Oct 2024 13:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728481173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tP/mvF2GvsSUaMK1QQ0PWZm6xx0ktzAB+8LhZ+ceEI=;
	b=COSgkBfpAtJaLYmXqChtZ2ZF1IYNi0MicBeQwglOmyLS4yZiQCwvnq3Cm3mtyaDr/WEyXT
	xFSqZka8TTYMRb/EujgGLpLuzpTyVe/p+xPmrzuyFQRr3bllVdhkSncyDK6upAuCMGWDsz
	QpWaZ7JcT2o7DAa7WuPDcYzoYjgWJLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728481173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tP/mvF2GvsSUaMK1QQ0PWZm6xx0ktzAB+8LhZ+ceEI=;
	b=TEcH5P3yqE8YO4+ZTbYyuasnt45GbY7NJxHyzN6ORE8FwK90c2X68wmDFNfxEPXskh78sU
	lOqihBJasV7V+yDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728481173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tP/mvF2GvsSUaMK1QQ0PWZm6xx0ktzAB+8LhZ+ceEI=;
	b=COSgkBfpAtJaLYmXqChtZ2ZF1IYNi0MicBeQwglOmyLS4yZiQCwvnq3Cm3mtyaDr/WEyXT
	xFSqZka8TTYMRb/EujgGLpLuzpTyVe/p+xPmrzuyFQRr3bllVdhkSncyDK6upAuCMGWDsz
	QpWaZ7JcT2o7DAa7WuPDcYzoYjgWJLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728481173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tP/mvF2GvsSUaMK1QQ0PWZm6xx0ktzAB+8LhZ+ceEI=;
	b=TEcH5P3yqE8YO4+ZTbYyuasnt45GbY7NJxHyzN6ORE8FwK90c2X68wmDFNfxEPXskh78sU
	lOqihBJasV7V+yDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDF3213A58;
	Wed,  9 Oct 2024 13:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0ERWLpWHBmf0MwAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Wed, 09 Oct 2024 13:39:33 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 6CD2BB3338; Wed,  9 Oct 2024 15:39:29 +0200 (CEST)
Date: Wed, 9 Oct 2024 15:39:29 +0200
From: Jiri Wiesner <jwiesner@suse.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH] ipv6: route: release reference of dsts cached in
 sockets
Message-ID: <20241009133929.GA3765@incl>
References: <20240930180916.GA24637@incl>
 <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
 <20241001152609.GA24007@incl>
 <CADvbK_cmi_ppJyPwmh77dHgkm=Lh52vtEWddwSAFNhZpmmev6Q@mail.gmail.com>
 <20241003170126.GA20362@incl>
 <CADvbK_e_Etot3nzMC=FEt-cqoWfnER4SVOC5dOm6aH43iME1iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_e_Etot3nzMC=FEt-cqoWfnER4SVOC5dOm6aH43iME1iA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Sun, Oct 06, 2024 at 02:25:25PM -0400, Xin Long wrote:
> We recently also encountered this
> 
>   'unregister_netdevice: waiting for lo to become free. Usage count = X'
> 
> problem on our customer env after backporting
> 
>   Commit 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). [1]
> 
> The commit looks correct to me, so I guess it may uncover some existing
> issues.

That is interesting. It seems possible to me.

> As it took a very long time to get reproduced on our customer env, which
> made it impossible to debug. Also the issue existed even after
> disabling IPv6.

AFAIK, the reproducibility of the issue hinges on net namespaces being created and destroyed often and TCP connections timing out in the namespaces. Traffic rate does not seem important.

> It seems much easier to reproduce it on your customer env. So I'm wondering

It takes roughly 24 hours but sometimes much more or much less to reproduce this.

> - Was the testing on your customer env related to IPv6 ?

Yes, it was. But I don't think the customer can disable IPv6. Their product is based on IPv6.

> - Does the issue still exist after reverting the commit [1] ?

I will ask the customer for a test.

Also, the issue is not reproducible after e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev") was backported.
J.

