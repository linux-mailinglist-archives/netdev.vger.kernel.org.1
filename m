Return-Path: <netdev+bounces-236974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F83AC42A0C
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 10:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAB8188CB46
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 09:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633DB2E0B47;
	Sat,  8 Nov 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VEXqEaiH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dsnGCQtj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VEXqEaiH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dsnGCQtj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BE12E8881
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762593084; cv=none; b=KT/JUxp1LJC/vycNfwkdeonb8wvxWJ2okYNoQray1HakZinczD6xisuJHTxyofunZIJWssQWFlAUUIfZgxnSC84lA4LPGxmOuJrSDOmYBj8p0sJbWRutEFDqj7dqu1PwMrK2Epe4wQZa31WvxTYHVjOwDd0wgYSAHuGdDJY2Xok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762593084; c=relaxed/simple;
	bh=zulggbQ9C+sfhABO3XdhEKdaWpkBF7JTTQpkPFyR3sQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDiIC7+m7qfB2ItJWxRZ9pM2YaFxoohdIjGc1GyGnVA+L6zYvXb44edSVAZ5O89wUtU0AuUlmp0BLMl6v2qv9vFkXaQ04UCaI1JFYkMckH+ooJM2MTcVEuruam+x8eef2FC4AJuPpyijW7bNEkQDB3rys09SnNeyLcuIQtc0ZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VEXqEaiH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dsnGCQtj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VEXqEaiH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dsnGCQtj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA96C1FF8F;
	Sat,  8 Nov 2025 09:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762593080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyPEC34QD5BJvwLcoZhQkmhqMSp26TfjdL7fKVEwOg4=;
	b=VEXqEaiH+M8wBuf6L8At9YVraFTRw7fkZTAZCTDKqOrVxSYjiWsCUVnnPPbUgDhjdT66VS
	b1o+9A+f96E8an02iQYmzIQbQ2cNyRJugwtind6jadPdteboq3dyRLEHqoA/PylFPXZbDv
	RTdCXWFgymBB1bt5X1s2GpWC3S0Ul/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762593080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyPEC34QD5BJvwLcoZhQkmhqMSp26TfjdL7fKVEwOg4=;
	b=dsnGCQtj31jQosQNPui7DGi2tdwv+nsOOxgFDEi/PJ4BALRn4SYQsjDxBELw1l6DaxYYyD
	zZ5RjmcLexyrePCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762593080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyPEC34QD5BJvwLcoZhQkmhqMSp26TfjdL7fKVEwOg4=;
	b=VEXqEaiH+M8wBuf6L8At9YVraFTRw7fkZTAZCTDKqOrVxSYjiWsCUVnnPPbUgDhjdT66VS
	b1o+9A+f96E8an02iQYmzIQbQ2cNyRJugwtind6jadPdteboq3dyRLEHqoA/PylFPXZbDv
	RTdCXWFgymBB1bt5X1s2GpWC3S0Ul/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762593080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyPEC34QD5BJvwLcoZhQkmhqMSp26TfjdL7fKVEwOg4=;
	b=dsnGCQtj31jQosQNPui7DGi2tdwv+nsOOxgFDEi/PJ4BALRn4SYQsjDxBELw1l6DaxYYyD
	zZ5RjmcLexyrePCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B856132DD;
	Sat,  8 Nov 2025 09:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jVyiFDgJD2liNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 08 Nov 2025 09:11:20 +0000
Date: Sat, 08 Nov 2025 10:11:19 +0100
Message-ID: <877bw0rirs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	linux-kernel@vger.kernel.org,
	pmladek@suse.com,
	rostedt@goodmis.org,
	andriy.shevchenko@linux.intel.com,
	tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	mchehab@kernel.org,
	awalls@md.metrocast.net,
	linux-media@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
In-Reply-To: <20251107161130.4418562992d2477c4accc6ef@linux-foundation.org>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
	<SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
	<20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
	<20251107091246.4e5900f4@pumpkin>
	<20251107161130.4418562992d2477c4accc6ef@linux-foundation.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,outlook.com,vger.kernel.org,suse.com,goodmis.org,linux.intel.com,perex.cz,kernel.org,md.metrocast.net,davemloft.net,google.com,redhat.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Sat, 08 Nov 2025 01:11:30 +0100,
Andrew Morton wrote:
> 
> On Fri, 7 Nov 2025 09:12:46 +0000 David Laight <david.laight.linux@gmail.com> wrote:
> 
> > > I wonder if we should instead implement a kasprintf() version of this
> > > which reallocs each time and then switch all the callers over to that.
> > 
> > That adds the cost of a malloc, and I, like kasprintf() probably ends up
> > doing all the work of snprintf twice.
> 
> There is no need at all to optimize the performance of scruffy once-off
> string pasting functions.  For these it's better to optimize for
> readability, reliability.  maintainability.

Actually this scnprintf_append() helper was my suggestion in another
threads:
  https://lore.kernel.org/ME2PR01MB3156CEC4F31F253C9B540FB7AFFDA@ME2PR01MB3156.ausprd01.prod.outlook.com
  https://lore.kernel.org/SYBPR01MB7881987D79C62D8122B655FEAFC6A@SYBPR01MB7881.ausprd01.prod.outlook.com

Basically its use is for filling a substring with s*printf() inside a
fixed string such as a field in a struct.  Through a quick grep, there
are many kernel code doing it without bounce checks, and it's for
helping those.  So it's a bit different from what you assumed with the
re-allocatable buffers.

The most merit of this API is that it can just be a kind of drop-in
replacement without extra variable to keep the offset, as found in
this patch series.

Though, it won't change too much to introduce an offset variable as
the API David suggested, which looks nice, so I myself don't mind
either way (it's a bike-shed topic, after all :)


thanks,

Takashi

