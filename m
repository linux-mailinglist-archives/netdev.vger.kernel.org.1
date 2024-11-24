Return-Path: <netdev+bounces-147112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7229D7914
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0AC28212F
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD8714F9F7;
	Sun, 24 Nov 2024 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E/LBmRPE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eDTlwgv5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E/LBmRPE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eDTlwgv5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDE2500C0
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732489645; cv=none; b=uff/OkYt/FFATszz0Kz8GbEYy/xLmH4qo5V2pdzFi7Ct5njWrWnyr2gdbyb/Z4aTh8Ai2dwfzDbb/UElH030DeDeqo4At6Bzo8tVbo48PFMEA31uP5wEYDfrSDLdZAX8iZ3uURhqXTEoeYGm78gtzQ5wLu5IgztDaMhPT80YtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732489645; c=relaxed/simple;
	bh=nPTzD2tXuq2VXHv6SdFrtrCbIt1M/C+zqWmitwJ7+lU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=h2201wLI6FIEupTNEay6nxxtpyLvniMqNe7vYUyWwk4sjyTQUAKJ5fR9XfkRV0oYdfDjFzBhuQwP3ivL8kN9LufZDhzp7DR5Kfm4NTdJBRG9iB4yH8GEmWZn6ec5Ul69ovhpxf92IUfw1ADr09XFtr0P7bJMAMW637eEmSy7RXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E/LBmRPE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eDTlwgv5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E/LBmRPE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eDTlwgv5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 760C02118A;
	Sun, 24 Nov 2024 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732489641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R26htpGF8naS2mFP9NnePcLoVUFYcMTGm90X2HlA/I=;
	b=E/LBmRPENcJ9SgdEfit+M2WOKGgO+o2UTa+D5V9ALOZn4h6RcetoMU6u6xRSmfEOhcgkKs
	IzzmngcFPVjqx3LD3KBeLDhSDwqqFN5mviKXj1XJtq256wRw4VKmjgp9JnBoJl7th11Kii
	bOJpGIgxfqNxrfDzSZaDULLvTW46j80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732489641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R26htpGF8naS2mFP9NnePcLoVUFYcMTGm90X2HlA/I=;
	b=eDTlwgv50fy6dIDPwGJ7/bYDib0OloVfv10HwE8Et0DnUXfIaftIk814OecJG2o1xNoJb+
	HK7FwpkIp1/hoYCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732489641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R26htpGF8naS2mFP9NnePcLoVUFYcMTGm90X2HlA/I=;
	b=E/LBmRPENcJ9SgdEfit+M2WOKGgO+o2UTa+D5V9ALOZn4h6RcetoMU6u6xRSmfEOhcgkKs
	IzzmngcFPVjqx3LD3KBeLDhSDwqqFN5mviKXj1XJtq256wRw4VKmjgp9JnBoJl7th11Kii
	bOJpGIgxfqNxrfDzSZaDULLvTW46j80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732489641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R26htpGF8naS2mFP9NnePcLoVUFYcMTGm90X2HlA/I=;
	b=eDTlwgv50fy6dIDPwGJ7/bYDib0OloVfv10HwE8Et0DnUXfIaftIk814OecJG2o1xNoJb+
	HK7FwpkIp1/hoYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93D6813690;
	Sun, 24 Nov 2024 23:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tiDyDaexQ2duPQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 24 Nov 2024 23:07:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>, "Thomas Graf" <tgraf@suug.ch>,
 netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
In-reply-to: <lm4aynuzpvsnurr4kzkecwantceebugrija2hxjrwou4r4u7ea@xxtncggxnbk2>
References:
 <>, <lm4aynuzpvsnurr4kzkecwantceebugrija2hxjrwou4r4u7ea@xxtncggxnbk2>
Date: Mon, 25 Nov 2024 10:07:15 +1100
Message-id: <173248963527.1734440.16500857468413237164@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 25 Nov 2024, Kent Overstreet wrote:
> On Sun, Nov 24, 2024 at 09:01:26PM +1100, NeilBrown wrote:
> > On Sun, 24 Nov 2024, Herbert Xu wrote:
> > > On Sun, Nov 24, 2024 at 08:25:38PM +1100, NeilBrown wrote:
> > > >
> > > > Failure should not just be extremely unlikely.  It should be
> > > > mathematically impossible.=20
> > >=20
> > > Please define mathematically impossible.  If you mean zero then
> > > it's pointless since modern computers are known to have non-zero
> > > failure rates.
> >=20
> > mathematically assuming perfect hardware.  i.e.  an analysis of the
> > software would show there is no way for an error to be returned.
> >=20
> > >=20
> > > If you have a definite value in mind, then we could certainly
> > > tailor the maximum elasticity to achieve that goal.
> >=20
> > I don't think there is any need to change the elasticity.  Rehashing
> > whenever the longest chain reaches 16 seems reasonable - though some
> > simple rate limiting to avoid a busy-loop with a bad hash function would
> > not be unwelcome.
> >=20
> > But I don't see any justification for refusing an insertion because we
> > haven't achieved the short chains yet.  Certainly a WARN_ON_ONCE or a
> > rate-limited WARN_ON might be appropriate.  Developers should be told
> > when their hash function isn't good enough.
> > But requiring developers to test for errors and to come up with some way
> > to manage them (sleep and try again is all I can think of) doesn't help a=
nyone.
>=20
> Agreed, sleep until the rehash finishes seems like what we're after, and
> that should be in the rhashtable code.
>=20

No, it shouldn't be in the rhashtable code.  It is a work-around that
shouldn't be needed.
The rhashtable insert code mustn't sleep as the caller might hold locks.
Currently the caller needs to release locks, sleep an arbitrary time,
then retry.

The rhashtable code should simply insert the new item when it is asked
to.  The failure is a deliberate choice that can easily be avoid.

The only case that is at all difficult is when a "nested" table is used.
In this case the table of pointers is allocated incrementally and the
target slot might not yet exist in the "last" table and an ATOMIC
allocation might fail.  In that case the new entry should be inserted in
the penultimate table, and that might have some interesting locking
issues.

NeilBrown

