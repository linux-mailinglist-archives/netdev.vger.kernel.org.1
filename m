Return-Path: <netdev+bounces-147113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB769D7915
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B06D282125
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EC516BE3A;
	Sun, 24 Nov 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eIQkbVSB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NLJaV5pA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eIQkbVSB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NLJaV5pA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6913D246
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732489792; cv=none; b=UZZgVqes/ztETgGTtuNMCrf46fdlOxNuYTwSa2qqmO1R59Y+ClgyZ8D+blGoYhR9W79tw9NLX+x0zQZy8ZELg1mzPps7jfPDlyDxGqmfBGRtHtHFNxBLSwJhRlKCEc/sEoZOnHXGNy8tgxcjjuIDdl7r9U4x6qh2DipIQZAdz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732489792; c=relaxed/simple;
	bh=VccwTb6czkrngAgDI0+C0IA/6CER4BdwnCEw708pHX4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RQ/eE9NLuW0IRnuFd3oKonDGn8Z5n57lJK4/ZLidOpdLx1Fi6ZZtjFyo0lT6fP51YDn2rUwtAOE0IttTy4TS7D3VO1Is939o+OwghZQ2ClfKl4OWGI3ZsQCv85RY7hUVw6GWoK6fKrkR31rQXZ/dKszc4gDn2YCjdBRZo7oppgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eIQkbVSB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NLJaV5pA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eIQkbVSB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NLJaV5pA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 085C82118A;
	Sun, 24 Nov 2024 23:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732489789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w/SBKJIc975MakO1EDocOI3toqKROY8puJI7zc4L8c=;
	b=eIQkbVSBXCMGgm/DxYANtFhKvSTzYFV9Ye+7NS0wtmJ0CWgtbcIVOxIXnTYys872EiszyT
	ms7I3IP3LAdTp51yCPM3UuDHAG+xg/eZofHpCRQWGRuqlgijBCbcpFXGxaehvB42gtcEh3
	XNtaRjYraExZBP6IJ1TcICT8vJC8C40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732489789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w/SBKJIc975MakO1EDocOI3toqKROY8puJI7zc4L8c=;
	b=NLJaV5pAZCyN89J5Kq1MzEWOHtBDGeMcPD7S+BY94/bQ0AbbGU8cGQ8nCLmOcN4xuJS7m2
	cLs4Mzy5tyogR/Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eIQkbVSB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NLJaV5pA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732489789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w/SBKJIc975MakO1EDocOI3toqKROY8puJI7zc4L8c=;
	b=eIQkbVSBXCMGgm/DxYANtFhKvSTzYFV9Ye+7NS0wtmJ0CWgtbcIVOxIXnTYys872EiszyT
	ms7I3IP3LAdTp51yCPM3UuDHAG+xg/eZofHpCRQWGRuqlgijBCbcpFXGxaehvB42gtcEh3
	XNtaRjYraExZBP6IJ1TcICT8vJC8C40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732489789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w/SBKJIc975MakO1EDocOI3toqKROY8puJI7zc4L8c=;
	b=NLJaV5pAZCyN89J5Kq1MzEWOHtBDGeMcPD7S+BY94/bQ0AbbGU8cGQ8nCLmOcN4xuJS7m2
	cLs4Mzy5tyogR/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2651813690;
	Sun, 24 Nov 2024 23:09:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XciMLjqyQ2cKPgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 24 Nov 2024 23:09:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
In-reply-to: <Z0L8LQeZwtvhJ2Ft@gondor.apana.org.au>
References: <>, <Z0L8LQeZwtvhJ2Ft@gondor.apana.org.au>
Date: Mon, 25 Nov 2024 10:09:43 +1100
Message-id: <173248978347.1734440.11538643613787576556@noble.neil.brown.name>
X-Rspamd-Queue-Id: 085C82118A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sun, 24 Nov 2024, Herbert Xu wrote:
> On Sun, Nov 24, 2024 at 09:01:26PM +1100, NeilBrown wrote:
> >
> > But I don't see any justification for refusing an insertion because we
> > haven't achieved the short chains yet.  Certainly a WARN_ON_ONCE or a
> > rate-limited WARN_ON might be appropriate.  Developers should be told
> > when their hash function isn't good enough.
> > But requiring developers to test for errors and to come up with some way
> > to manage them (sleep and try again is all I can think of) doesn't help a=
nyone.
>=20
> If someone can show me this occurring in a situation other than
> that where multiple entries with identical keys are being added
> to the hash table, then I'm certainly happy to change this.
>=20
> But so far every occurrence of EBUSY has turned out to be caused
> by the insertion of duplicate keys into the hash table, which
> is very much expected, and one where a solution has already been
> provided (rhltable).
>=20
> If this is genuine then it can be easily proved.  Just make the
> EBUSY code-path dump the keys in the chain exceeding 16 entries,
> plus the hash secret and the total number of entries in the hash
> table plus capacity.  It should then be easy to verify.
>=20

I don't think this is a reasonable position to take.

When writing code I don't only want to guard against problems that I can
reproduce.  I want to guard against any problem that is theoretically
possible.   Unless you can explain why -EBUSY is not possible, I have to
write code to handle it.

NeilBrown

