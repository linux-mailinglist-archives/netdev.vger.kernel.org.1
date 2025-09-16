Return-Path: <netdev+bounces-223537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43932B596F1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB3B18855A7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64EA3101BF;
	Tue, 16 Sep 2025 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m8uZ4vnQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oPCGfQyg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m8uZ4vnQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oPCGfQyg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF972F6592
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027918; cv=none; b=KBKBTeOO6UzfV+aSMJWM1aFttew5CkSStzGJmjS5yf6eoBvsLh8HiX77CmjtpMJbYIhrWfnnyE/HolYvpX+aGmlXVjK5qy5Su1p7TNM44oj00jnXCi+B9m9FULINVFg0B4XhBRgsQcbFlWNwo6AfV3yRHDeK7yDAgzD3rrSysso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027918; c=relaxed/simple;
	bh=r5/fVGUqR5HFq3vZ6jzZGnPxFTJWkyAAbjkTFFzkg/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srWqXyEJAIadUYi61J+RWtrCFXFnsUI2gbn+sG4uqLqig2VPIfNFcZqK6ZaNw0evKty+fk/kypN3eH9Lsnyo2olBsDTXNKPLnqrR5hMU0AjLE9dW/mnB2EIj5dGHMXp5oWMcTrwznN4YyTqeFvrRZX+4L0PapWBSNDGm7k9HOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m8uZ4vnQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oPCGfQyg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m8uZ4vnQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oPCGfQyg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35D5A2285F;
	Tue, 16 Sep 2025 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758027915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9A36b/S0SgJ3ZG9RQ8biclrjxz+wbguqohO1hbWIE+g=;
	b=m8uZ4vnQE1zjwjbdlDny+v1H3oz4YmrTFGp6HpHPSf5CboZShTGyHPnPBUpCB5jSggp9Oi
	//XJLJe2XQvYRxXajkl0SrUSDnPxZUmkpg3CopZ2VIf/xIlmWJZtG/mTxCwViYi45O984C
	SH2n4gq1xeUD6nckgNH910cUkIEUChY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758027915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9A36b/S0SgJ3ZG9RQ8biclrjxz+wbguqohO1hbWIE+g=;
	b=oPCGfQyghRK4oZdMQzenU12tiuFL6w91f1jKeOpG7gchJFVCaG+gA0g0qW7Xciy5GETPVP
	gEnzfcVHGzB7qxDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758027915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9A36b/S0SgJ3ZG9RQ8biclrjxz+wbguqohO1hbWIE+g=;
	b=m8uZ4vnQE1zjwjbdlDny+v1H3oz4YmrTFGp6HpHPSf5CboZShTGyHPnPBUpCB5jSggp9Oi
	//XJLJe2XQvYRxXajkl0SrUSDnPxZUmkpg3CopZ2VIf/xIlmWJZtG/mTxCwViYi45O984C
	SH2n4gq1xeUD6nckgNH910cUkIEUChY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758027915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9A36b/S0SgJ3ZG9RQ8biclrjxz+wbguqohO1hbWIE+g=;
	b=oPCGfQyghRK4oZdMQzenU12tiuFL6w91f1jKeOpG7gchJFVCaG+gA0g0qW7Xciy5GETPVP
	gEnzfcVHGzB7qxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CFDA139CB;
	Tue, 16 Sep 2025 13:05:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id biARB4tgyWgLCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Sep 2025 13:05:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9D3CFA0A83; Tue, 16 Sep 2025 15:05:14 +0200 (CEST)
Date: Tue, 16 Sep 2025 15:05:14 +0200
From: Jan Kara <jack@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: syzbot <syzbot+263f159eb37a1c4c67a4@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chaitanyas.prakash@arm.com, davem@davemloft.net, 
	david@redhat.com, edumazet@google.com, hdanton@sina.com, horms@kernel.org, 
	jack@suse.cz, kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com, willemb@google.com
Subject: Re: [syzbot] [sound?] kernel BUG in filemap_fault (2)
Message-ID: <lqzgi7abe2onda3faavn5ays6gdw4syiu32hmrfaibrh6cmozs@pjf3llvnnefk>
References: <68c69e17.050a0220.3c6139.04e1.GAE@google.com>
 <80840307-942d-4e7b-849d-2ca9bb4bbefa@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80840307-942d-4e7b-849d-2ca9bb4bbefa@arm.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[263f159eb37a1c4c67a4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,linux-foundation.org,arm.com,davemloft.net,redhat.com,google.com,sina.com,kernel.org,suse.cz,vger.kernel.org,perex.cz,googlegroups.com,suse.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,arm.com:email,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Tue 16-09-25 13:50:08, Ryan Roberts wrote:
> On 14/09/2025 11:51, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> > 
> > commit bdb86f6b87633cc020f8225ae09d336da7826724
> > Author: Ryan Roberts <ryan.roberts@arm.com>
> > Date:   Mon Jun 9 09:27:23 2025 +0000
> > 
> >     mm/readahead: honour new_order in page_cache_ra_order()
> 
> I'm not sure what original bug you are claiming this is fixing? Perhaps this?
> 
> https://lore.kernel.org/linux-mm/6852b77e.a70a0220.79d0a.0214.GAE@google.com/

I think it was:

https://lore.kernel.org/all/684ffc59.a00a0220.279073.0037.GAE@google.com/

at least that's what the syzbot email replies to... And it doesn't make a
lot of sense but it isn't totally off either. So I'd just let the syzbot
bug autoclose after some timeout.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

