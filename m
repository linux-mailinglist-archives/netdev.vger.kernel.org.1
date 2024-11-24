Return-Path: <netdev+bounces-146947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78689D6D72
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 11:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8932C28136B
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F63185935;
	Sun, 24 Nov 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y3QjUFxP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IJVxCt8l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y3QjUFxP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IJVxCt8l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6318859F
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732442500; cv=none; b=c1m5gUKYUFovPFb2OS3vcmrPHS1RCLMcZDz41jtjQOhHmgXOHwi6mx4mJhscAyBXw/ssSRHVFUIU5NLatGonPLEkngl/Exwo+7PuOiKCBGnb6t08sa5emaXZbo5/R1pWl0nU8UoHYZ6MlxKp8a5gY/jM1AnrGusJl8EZslpzgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732442500; c=relaxed/simple;
	bh=SABrXsP0oe2bqj6bbQ/I6rkAc6DAQsiv/tnCiaVO5JA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GOANaAoePWz9xStsBaA3vQtLRHWKZbEUx85AYyYpDnjcCXY8laWO+s6maj8CHuyAN8m84j9kxZpB3oYmntvs204hRGIvGNtX7k0x+khegF2NdwqEY5HxmVb6Ura8kovQEL03ok8ma+bVAowZ+qmGiOVIdi3txE23yi5lMA+tC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y3QjUFxP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IJVxCt8l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y3QjUFxP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IJVxCt8l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 763A32118A;
	Sun, 24 Nov 2024 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732442496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlGG18Zf30bJzqoWr+yMLdxEFj8p5DUC2odFi3jzLbY=;
	b=y3QjUFxP5rK1CiZm6eHl0+pQ63WsDIWP1UeymHpvSCYtFmv23eS7HAICjzsBbVsI1ciU0c
	ARYbspkR3YFy97R5vhqYLT8W+hB/n1mGW0oLsTJu39MDQIRMdxvShhYf7i+HuWL9yL4iTU
	doBuFHihpukzu46phImDKh0Z5MPgM7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732442496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlGG18Zf30bJzqoWr+yMLdxEFj8p5DUC2odFi3jzLbY=;
	b=IJVxCt8lKPikqzXKN0Sb74Hyq0mMnWlqdVv/pSJfF1e3MWlINaMQUbThif9oa9Iu89wunu
	30RlGYRhTeJa0TBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y3QjUFxP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IJVxCt8l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732442496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlGG18Zf30bJzqoWr+yMLdxEFj8p5DUC2odFi3jzLbY=;
	b=y3QjUFxP5rK1CiZm6eHl0+pQ63WsDIWP1UeymHpvSCYtFmv23eS7HAICjzsBbVsI1ciU0c
	ARYbspkR3YFy97R5vhqYLT8W+hB/n1mGW0oLsTJu39MDQIRMdxvShhYf7i+HuWL9yL4iTU
	doBuFHihpukzu46phImDKh0Z5MPgM7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732442496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlGG18Zf30bJzqoWr+yMLdxEFj8p5DUC2odFi3jzLbY=;
	b=IJVxCt8lKPikqzXKN0Sb74Hyq0mMnWlqdVv/pSJfF1e3MWlINaMQUbThif9oa9Iu89wunu
	30RlGYRhTeJa0TBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9495313998;
	Sun, 24 Nov 2024 10:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q9PSDX75QmfxfQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 24 Nov 2024 10:01:34 +0000
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
In-reply-to: <Z0LxtPp1b-jy2Klg@gondor.apana.org.au>
References: <>, <Z0LxtPp1b-jy2Klg@gondor.apana.org.au>
Date: Sun, 24 Nov 2024 21:01:26 +1100
Message-id: <173244248654.1734440.17446111766467452028@noble.neil.brown.name>
X-Rspamd-Queue-Id: 763A32118A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,apana.org.au:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sun, 24 Nov 2024, Herbert Xu wrote:
> On Sun, Nov 24, 2024 at 08:25:38PM +1100, NeilBrown wrote:
> >
> > Failure should not just be extremely unlikely.  It should be
> > mathematically impossible.=20
>=20
> Please define mathematically impossible.  If you mean zero then
> it's pointless since modern computers are known to have non-zero
> failure rates.

mathematically assuming perfect hardware.  i.e.  an analysis of the
software would show there is no way for an error to be returned.

>=20
> If you have a definite value in mind, then we could certainly
> tailor the maximum elasticity to achieve that goal.

I don't think there is any need to change the elasticity.  Rehashing
whenever the longest chain reaches 16 seems reasonable - though some
simple rate limiting to avoid a busy-loop with a bad hash function would
not be unwelcome.

But I don't see any justification for refusing an insertion because we
haven't achieved the short chains yet.  Certainly a WARN_ON_ONCE or a
rate-limited WARN_ON might be appropriate.  Developers should be told
when their hash function isn't good enough.
But requiring developers to test for errors and to come up with some way
to manage them (sleep and try again is all I can think of) doesn't help anyon=
e.

Thanks,
NeilBrown

>=20
> Cheers,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>=20


