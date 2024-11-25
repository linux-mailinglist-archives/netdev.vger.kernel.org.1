Return-Path: <netdev+bounces-147293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B6C9D8F36
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 00:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F78B2813B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 23:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19BB18DF93;
	Mon, 25 Nov 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P0qX5Wbg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PN2l+HV8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nq64tEWR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eCZR7dTd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA381E480
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732577902; cv=none; b=F44fFxHGASvnhhkfrMar87ykmoLz2wQf9viXrGBXEJHLDBI0KzgwvTkT1RV4Vr0UY+ABGbICxe15YLycG19LrXRoFO1xlOqKxEYQ29hnt4HAI/z11Qu1vQoxMHuKBcYQyLy3leKo0qBSQGhaxDRAuapXGROPt1AYSMt+WTQ1oy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732577902; c=relaxed/simple;
	bh=V7oWraZNU3AaLoMNGx/ug4AY9gQNvL6uy9PwNRiNH64=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jLTQOTeEXDp3THCupc+zcZOOlnTQ2X4C14hOkmZX/AxaEWv9joJ53WvYW6CIU8RPGcOlCUi8nwhaa3X58QRKVBXfASeswpyCtx205kaD5vlhPAK1sTrz4YeUjZ+vKSMXRvhDK6zNKhfpJJHSuCu63HXz5BqPMavtPE8CZoZpiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P0qX5Wbg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PN2l+HV8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nq64tEWR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eCZR7dTd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 283FB1F456;
	Mon, 25 Nov 2024 23:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732577898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Byu26wNVMX1SCb/rg+HxMDb4m0VYX6tjiZAZqYTFyk8=;
	b=P0qX5WbgnNHbkL5SInd9bAgw6XpNzoj6vkiVdOPr0U7Q407tz5GvZ9n0I+I0EXPbh+VKtK
	6zToADyIxmMcyYVZ2VcbbYQ/n2ZWhfmVARli9HJpYVH7OTK4lpNmoYgwBwxtlhWC83klzk
	7vp5YHfs/+8bH4U00acXPAwhej4FDow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732577898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Byu26wNVMX1SCb/rg+HxMDb4m0VYX6tjiZAZqYTFyk8=;
	b=PN2l+HV8RUoxc8qcgbhZfjEwgTY4x7EbuwHXrOsWZqtk3kI4fFmbZKJ+SbUr75ns5N3o3g
	riPcF4+JjSMtbuAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nq64tEWR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eCZR7dTd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732577897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Byu26wNVMX1SCb/rg+HxMDb4m0VYX6tjiZAZqYTFyk8=;
	b=Nq64tEWRJ54TF/4aqzFo70oDnE9SqFAf6V4BVpIYbVQ+tLcSOyp6d0BrcnGasEdaBWZ7GY
	IMJjb7iTwsj2ToEUmcyJ0CaPJlMM+LbhPCD4nJmU2EWsR7Z9TEhTQ1oEPKL46FiwfoJS2K
	xqjmxtlsOtoUctuBisHmLsBKMllWwY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732577897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Byu26wNVMX1SCb/rg+HxMDb4m0VYX6tjiZAZqYTFyk8=;
	b=eCZR7dTdygOnXmbeIJWkuVwMU9kocEAWFw1mKzUhE482lQMeMmgr1rUbtlr9v0fG79qVTB
	froigNDT+m0kJ5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A135137D4;
	Mon, 25 Nov 2024 23:38:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8MplN2YKRWdgawAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 25 Nov 2024 23:38:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Thomas Graf" <tgraf@suug.ch>, netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
In-reply-to: <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
References: <>, <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
Date: Tue, 26 Nov 2024 10:38:10 +1100
Message-id: <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
X-Rspamd-Queue-Id: 283FB1F456
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 25 Nov 2024, Herbert Xu wrote:
> On Mon, Nov 25, 2024 at 10:43:16AM +1100, NeilBrown wrote:
> >
> > So please turn it into a WARN_ON_ONCE and don't allow the code to return
> > it.
> 
> You still have to handle ENOMEM, right?

I'd rather not.  Why is ENOMEM exposed to the caller?
The rehash thread should *always* allocated the *whole* table before
adding it to the chain and starting to rehash into it.  Until that
allocation succeeds, just keeping inserting in the existing table.

rhashtables seems to have been written with an understanding that long
hash chains are completely unacceptable and failure to insert is
preferred.  I accept that in some circumstances that might be true, but
in other circumstances failure to insert (except for -EEXIST) is
anathema and long hash chains are simply unfortunate.

Now I could write an alternate resizable hashtable implementation which
values predictable behaviour over short chains, but it would only be a
tiny bit different from rhashtables so it seems to make more sense to
add that option into rhashtables (which already has several options for
different use cases).

So I don't ever want -E2BIG either.  Either -EEXIST or success should be
the only possible results of "insert".

Thanks,
NeilBrown


> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 


