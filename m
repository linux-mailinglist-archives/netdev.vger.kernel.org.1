Return-Path: <netdev+bounces-223908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3FB7CFB5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1005821D7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB2A2F7456;
	Wed, 17 Sep 2025 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K0CKpcQJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aGmtl/eV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K0CKpcQJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aGmtl/eV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D42D59EF
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098160; cv=none; b=oGJJAnaAh6aDRKdwdbQfFYjHnpOFZn3mIX+amnUxKUISdLYFciJx6+QjPRaRzX0LZakGXiFXWLZb1GJXARjxUsb27clVBj1kH/Z6qJ5BKH9JZPsG8g4oHZr+ZTT1SzH3VpwzsGRGLYlSutTLFt5qvu5TcwZyZqgbDuKyeohoYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098160; c=relaxed/simple;
	bh=ofO0Q8oMta1PRDwIhLkYMub7GGndR7KtZQUqeFBiVPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCmu0jN+NZsPkomnRfECT8y7Ma0s8Z8EZgTvYwmB09vIH4IS0NEwKMCh7FAEQHUvkwmQEtB4P/7jisIWtiIjp/AxMNfLqkFp3V3Pp2CTHwaoYWja00LdqnF52uFA4KdjGeeomhMeZRpJRCB6zBKu8TBF1JYa8zCvbnQ3yByTSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K0CKpcQJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aGmtl/eV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K0CKpcQJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aGmtl/eV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F73A1F79F;
	Wed, 17 Sep 2025 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758098151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BasLqjHtVshfjdyLg2J6q/oyQyWJ9sPXGwCbgbGkmqs=;
	b=K0CKpcQJHVMxSJ+0OTFPfYcV2OQ3IS7jig+x8ob4XXEYr/va3BZ90Lw30tMgFKMxGbQsRe
	wWJgOOxdyvKIkGPA+QLwucu4EJLL2mBYylcaol6HmYxdEMQDGiMcoHTqSItojZq/0sEJVs
	NlB55PNYrKpbGroyNlKHypEvgErFWrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758098151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BasLqjHtVshfjdyLg2J6q/oyQyWJ9sPXGwCbgbGkmqs=;
	b=aGmtl/eVV6qvZej9Irm87pmJC9gTjqhA4sHTtOsVXSk0BcUzvZreilLZGDZCGSUx9rhB8s
	W7+K9XDbHa/fxCBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758098151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BasLqjHtVshfjdyLg2J6q/oyQyWJ9sPXGwCbgbGkmqs=;
	b=K0CKpcQJHVMxSJ+0OTFPfYcV2OQ3IS7jig+x8ob4XXEYr/va3BZ90Lw30tMgFKMxGbQsRe
	wWJgOOxdyvKIkGPA+QLwucu4EJLL2mBYylcaol6HmYxdEMQDGiMcoHTqSItojZq/0sEJVs
	NlB55PNYrKpbGroyNlKHypEvgErFWrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758098151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BasLqjHtVshfjdyLg2J6q/oyQyWJ9sPXGwCbgbGkmqs=;
	b=aGmtl/eVV6qvZej9Irm87pmJC9gTjqhA4sHTtOsVXSk0BcUzvZreilLZGDZCGSUx9rhB8s
	W7+K9XDbHa/fxCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 158141368D;
	Wed, 17 Sep 2025 08:35:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GcU6Bedyymj4CwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 08:35:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B774CA0A95; Wed, 17 Sep 2025 10:35:46 +0200 (CEST)
Date: Wed, 17 Sep 2025 10:35:46 +0200
From: Jan Kara <jack@suse.cz>
To: David Hildenbrand <david@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>, 
	syzbot <syzbot+263f159eb37a1c4c67a4@syzkaller.appspotmail.com>, akpm@linux-foundation.org, chaitanyas.prakash@arm.com, 
	davem@davemloft.net, edumazet@google.com, hdanton@sina.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com, willemb@google.com
Subject: Re: [syzbot] [sound?] kernel BUG in filemap_fault (2)
Message-ID: <s5pl5yhhxyz7dn4r2v6c4ll53ejboe5xa5226ytgg7kjirgmh5@tofyas4lp4uy>
References: <68c69e17.050a0220.3c6139.04e1.GAE@google.com>
 <80840307-942d-4e7b-849d-2ca9bb4bbefa@arm.com>
 <lqzgi7abe2onda3faavn5ays6gdw4syiu32hmrfaibrh6cmozs@pjf3llvnnefk>
 <7e338491-0c6b-4b65-93b7-df0af8b2fd87@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e338491-0c6b-4b65-93b7-df0af8b2fd87@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	FREEMAIL_CC(0.00)[suse.cz,arm.com,syzkaller.appspotmail.com,linux-foundation.org,davemloft.net,google.com,sina.com,kernel.org,vger.kernel.org,redhat.com,perex.cz,googlegroups.com,suse.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 17-09-25 09:57:19, David Hildenbrand wrote:
> On 16.09.25 15:05, Jan Kara wrote:
> > On Tue 16-09-25 13:50:08, Ryan Roberts wrote:
> > > On 14/09/2025 11:51, syzbot wrote:
> > > > syzbot suspects this issue was fixed by commit:
> > > > 
> > > > commit bdb86f6b87633cc020f8225ae09d336da7826724
> > > > Author: Ryan Roberts <ryan.roberts@arm.com>
> > > > Date:   Mon Jun 9 09:27:23 2025 +0000
> > > > 
> > > >      mm/readahead: honour new_order in page_cache_ra_order()
> > > 
> > > I'm not sure what original bug you are claiming this is fixing? Perhaps this?
> > > 
> > > https://lore.kernel.org/linux-mm/6852b77e.a70a0220.79d0a.0214.GAE@google.com/
> > 
> > I think it was:
> > 
> > https://lore.kernel.org/all/684ffc59.a00a0220.279073.0037.GAE@google.com/
> > 
> > at least that's what the syzbot email replies to... And it doesn't make a
> > lot of sense but it isn't totally off either. So I'd just let the syzbot
> > bug autoclose after some timeout.
> 
> Hm, in the issue we ran into was:
> 
> 	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
> 
> in filemap_fault().
> 
> Now, that sounds rather bad, especially given that it was reported upstream.
> 
> So likely we should figure out what happened and see if it really fixed it
> and if so, why it fixed it (stable backports etc)?

Ok, ok, fair enough ;)

> Could be that Ryans patch is just making the problem harder to reproduce, of
> course (what I assume right now).
> 
> Essentially we do a
> 
> 	folio = filemap_get_folio(mapping, index);
> 
> followed by
> 
> 	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
> 		goto out_retry;
> 
> 	/* Did it get truncated? */
> 	if (unlikely(folio->mapping != mapping)) {
> 		folio_unlock(folio);
> 		folio_put(folio);
> 		goto retry_find;
> 	}
> 	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
> 
> 
> I would assume that if !folio_contains(folio, index), either the folio got
> split in the meantime (filemap_get_folio() returned with a raised reference,
> though) or that file pagecache contained something wrong.

Right.

> In __filemap_get_folio() we perform the same checks after locking the folio
> (with FGP_LOCK), and weird enough it didn't trigger yet there.

But we don't call __filemap_get_folio() with FGP_LOCK from filemap_fault().
The folio locking is handled by lock_folio_maybe_drop_mmap() as you
mentioned. So this is the first time we do the assert after getting the
folio AFAICT. So some race with folio split looks plausible. Checking the
reproducer it does play with mmap(2) and madvise(MADV_REMOVE) over the
mapped range so the page fault may be racing with
truncate_inode_partial_folio()->try_folio_split(). But I don't see the race
there now...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

