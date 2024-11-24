Return-Path: <netdev+bounces-146940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 895AD9D6D3E
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 10:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443DB281298
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317F5152196;
	Sun, 24 Nov 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YbZ1OtrN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5in47z97";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YbZ1OtrN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5in47z97"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5F136E
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732440842; cv=none; b=AcGDBgHqGZj7o3BClbsm9uNPKRRD4O7Rn2cCKRNGwHLlxYeuIIbO7w5nxNAo4dxyevp8UJLF7bg0Wc7IBpTUTLPsu4jmm9yqZHU8kSJq/86iEnlA7OTp4JdudzFSMwnTOhuko+z7pxFu1txHuQ7rcMsgKuagXvSPcTUHhYbwHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732440842; c=relaxed/simple;
	bh=4oPmaEoaDr9k3VN0tSTwO/BYdWcdPrTalP4pgnrsiAw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DHJCTV1PDt658XSS4yL5kmr3dwVEDEcCQFBWQWCOgeDuatSeD64Qv45cDNbqd9tLvzKB/JnzfDTLHDO5kL+k60mWYSFtWyP8v8siS0ONSPa6vO8tCCpSX7BloxroiyTHLciOb5kkxnv+Ty6WcFe1P3z2pSI2PP5gAAUthWAVO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YbZ1OtrN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5in47z97; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YbZ1OtrN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5in47z97; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0DCB91F381;
	Sun, 24 Nov 2024 09:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732440349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gDbEG/cskwlc2UpH2cr8qe1dmmSkUIOGeIH5R29caQ=;
	b=YbZ1OtrN8Vp/t3c9vYjbebuAoANExhRvpL1h03aU+4bWYG/uwQ9kz9hPwBbBrCR1KQKrr8
	KWzqIFjkNA1y7/6aap0o+syqo1Ll7S4nYJ5uxEoVxlWnxuqqaeTMaI1X4j+zDLsGHXyz3/
	Hm251QLp4HxRMO4J3vqSIpHJpQmbtKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732440349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gDbEG/cskwlc2UpH2cr8qe1dmmSkUIOGeIH5R29caQ=;
	b=5in47z97EibjhJ4Bam+LmQd0uxj9jUdBufJLZOlROQsWfiEzZLUPWOUK8jpZ684Q/5whAt
	poHK8quiQuHc30DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YbZ1OtrN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5in47z97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732440349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gDbEG/cskwlc2UpH2cr8qe1dmmSkUIOGeIH5R29caQ=;
	b=YbZ1OtrN8Vp/t3c9vYjbebuAoANExhRvpL1h03aU+4bWYG/uwQ9kz9hPwBbBrCR1KQKrr8
	KWzqIFjkNA1y7/6aap0o+syqo1Ll7S4nYJ5uxEoVxlWnxuqqaeTMaI1X4j+zDLsGHXyz3/
	Hm251QLp4HxRMO4J3vqSIpHJpQmbtKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732440349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gDbEG/cskwlc2UpH2cr8qe1dmmSkUIOGeIH5R29caQ=;
	b=5in47z97EibjhJ4Bam+LmQd0uxj9jUdBufJLZOlROQsWfiEzZLUPWOUK8jpZ684Q/5whAt
	poHK8quiQuHc30DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B1A513676;
	Sun, 24 Nov 2024 09:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b+SRLxrxQmesdAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 24 Nov 2024 09:25:46 +0000
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
In-reply-to: <Z0KaexOJM1phuJKS@gondor.apana.org.au>
References: <i3vf5e63aqbfvoywuftt7h3qd4abdzomdeuvp3ygmzgza4xjdt@qx36kyyxxkfi>,
 <Z0KaexOJM1phuJKS@gondor.apana.org.au>
Date: Sun, 24 Nov 2024 20:25:38 +1100
Message-id: <173244033805.1734440.12627345429438896757@noble.neil.brown.name>
X-Rspamd-Queue-Id: 0DCB91F381
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 24 Nov 2024, Herbert Xu wrote:
> On Sat, Nov 23, 2024 at 12:21:21PM -0500, Kent Overstreet wrote:
> > I'm seeing an issue where rhashtable inserts sporadically return -EBUSY,
> > thrown from rhashtable_insert_rehash() when there's already a rehash in
> > progress, i.e. rehashes aren't keeping up.
>=20
> EBUSY should never happen *if* you're using the hash table correctly.
> It is expected to happen if you insert multiple identical entries
> into the same hash table (the correct thing to do in that case is
> to use rhltable which is designed to accomodate multiple entries
> with the same key).

"*if* you're using the hash table correctly" seems to mean that you have
chosen a hash function which is a sufficiently good fit for your
incoming data stream.  With the best effort in the world you cannot
provide a perfect guarantee of that - and most of us don't have the
expertise to do better than use the default or something easily
available in the library (and while we can mostly trust the libraries
... https://lwn.net/Articles/687494/ ).


>=20
> Now assuming that is not the case and you are using rhashtable
> correctly, this is when an EBUSY will occur during an insert:
>=20
> 1) The hash table elasticity has been violated, meaning that
> more than 16 entries are in a single chain.
>=20
> 2) The hash table is below 50% capacity (meaning that statistically
> we do not expect 1) to be true).
>=20
> 3) An existing rehash is already taking place.
>=20
> The reason we have the EBUSY mechanism in place is to prevent
> the case where we are being actively attacked by a hostile
> actor, who has somehow compromised our hash function.

I think that in many cases this "cure" (i.e.  returning -EBUSY) is worse
than the disease.

I believe that inserting into a hash table should *always* succeed with
zero possibility of failure.  Nil. None. Nought.  (or at least it should
be possible to request this behaviour)

This is why I posted

  https://lore.kernel.org/all/152210718434.11435.6551477417902631683.stgit@no=
ble/

six years ago, but you wouldn't accept it.

I understand that there might be situations where failure is tolerable
and avoiding pathological hash patterns is preferred.  I imagine that in
parts of the network layer were retry-on-failure is common, that might be
a perfect fit.  But in other situations such as in filesystem internals,
I think failure in intolerable.
Failure should not just be extremely unlikely.  It should be
mathematically impossible.=20

thanks,
NeilBrown

>=20
> The first line of defence is to change our hash function and
> conduct a rehash.  This is what would have occured if 3) is
> false.
>=20
> Once a rehash is in place, if we hit 1) + 2) again, then it
> means that our defence was futile and the hostile actor is
> still able to create arbitrarily long hash chains (possibly
> by compromising our RNG since we use that for the rehash),
> and as we do not have any defence mechanism for that, it is
> better to just fail.
>=20
> Of course this is meant to be impossible to hit in practice.
> Whenever it has occurred in the past, it's always been because
> people were tring to insert identical keyed entries into the
> same table (Use rhltable instead).
>=20
> Theoretically it is also possible to hit this if your hash
> table was immense (expected worst-case hash chain length is
> log N / log log N), but it has never been hit in the past
> with our default elasticity of 16.
>=20
> Cheers,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>=20


