Return-Path: <netdev+bounces-124740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9534796AA83
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 23:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC89281368
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091AD192B68;
	Tue,  3 Sep 2024 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SsT6LKFB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aqDegjFQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SsT6LKFB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aqDegjFQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC91EC013;
	Tue,  3 Sep 2024 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399843; cv=none; b=X+j6Bkvh49o1P/ozvXu24SM79CUzX9+qMTKy4clE6PFThR+yVEJu0CwKjhc1QzdHlqfYJ4wJYGdzmgI9bFF0BAunIZvhLa1Wms2y2ye7oQO4+H1C2TkoVP4a2X9Q7/9xWoveNw8Ph5FvvXgdKtHScWePjM+NGSTSKcLIw3/+FNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399843; c=relaxed/simple;
	bh=b0Hg7UiymZA9O4YE79C/lPQ8JHhkZBwqn/R+sJpQyjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKcPEEjbSImdA15dT5rKL69sYTKWevLcZGUCyqjAEHSUNBPFhjAw5vuWwlAHrzr7cTMFxft/OfvABhB3y+LcHHPHKQyWlt4CbVzwgejg58xzI5WX55wccBj4i62UAGV7voI89FsIIIiC0VVgfCXObDNmdgkpf3kG9YeWXLrlkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SsT6LKFB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aqDegjFQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SsT6LKFB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aqDegjFQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0649321B8F;
	Tue,  3 Sep 2024 21:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725399840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQ2Z4c48ce6CUlKYTbl197VdpIjkeOTW1y7Y+4S08+Y=;
	b=SsT6LKFBNSYyVy1SRGdkIMGkpkqjvNAUdiJNhSuADZP4A7FX6wbV7nXa7hgGYM/G2CfRZL
	aYYAkH8JdI13xXs/Wgue9ALsX3AqzFdnv2AC5REUErU0Fl6XsBr1bxxCuEwvRfcUypZoLc
	lIJYdJnoSuafTYhDtBaGNvYUpEUrF4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725399840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQ2Z4c48ce6CUlKYTbl197VdpIjkeOTW1y7Y+4S08+Y=;
	b=aqDegjFQE/6/6LwQNwSM4FgpCF7XB9hSy+vHMJzGrpZkpPquFO9A2ee3+qMb9tq2Rajqqa
	xZOsLzfz47HRTvBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725399840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQ2Z4c48ce6CUlKYTbl197VdpIjkeOTW1y7Y+4S08+Y=;
	b=SsT6LKFBNSYyVy1SRGdkIMGkpkqjvNAUdiJNhSuADZP4A7FX6wbV7nXa7hgGYM/G2CfRZL
	aYYAkH8JdI13xXs/Wgue9ALsX3AqzFdnv2AC5REUErU0Fl6XsBr1bxxCuEwvRfcUypZoLc
	lIJYdJnoSuafTYhDtBaGNvYUpEUrF4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725399840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQ2Z4c48ce6CUlKYTbl197VdpIjkeOTW1y7Y+4S08+Y=;
	b=aqDegjFQE/6/6LwQNwSM4FgpCF7XB9hSy+vHMJzGrpZkpPquFO9A2ee3+qMb9tq2Rajqqa
	xZOsLzfz47HRTvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEFD4139D5;
	Tue,  3 Sep 2024 21:43:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ACvLR+D12YrVQAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Tue, 03 Sep 2024 21:43:59 +0000
Date: Tue, 3 Sep 2024 23:43:43 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: "Ertman, David M" <david.m.ertman@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net] ice: Fix NULL pointer access, if PF doesn't support
 SRIOV_LAG
Message-ID: <20240903234343.5c17f735@samweis>
In-Reply-To: <IA1PR11MB61942396759BA7F1C20BA41BDD972@IA1PR11MB6194.namprd11.prod.outlook.com>
References: <20240826085830.28136-1-tbogendoerfer@suse.de>
	<ZsxNv6jN5hld7jYl@nanopsycho.orion>
	<20240826121710.7fcd856e@samweis>
	<362dd93c-8176-4c46-878d-dd0e1b897468@intel.com>
	<20240827211224.0d172e40@samweis>
	<IA1PR11MB61942396759BA7F1C20BA41BDD972@IA1PR11MB6194.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 30 Aug 2024 17:12:56 +0000
"Ertman, David M" <david.m.ertman@intel.com> wrote:

> > -----Original Message-----
> > From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > Sent: Tuesday, August 27, 2024 12:12 PM
> > To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; David S. Miller
> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-
> > wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Ertman, David M <david.m.ertman@intel.com>; Jiri
> > Pirko <jiri@resnulli.us>
> > Subject: Re: [PATCH net] ice: Fix NULL pointer access, if PF doesn't su=
pport
> > SRIOV_LAG
> >=20
> > On Tue, 27 Aug 2024 09:16:51 +0200
> > Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:
> >  =20
> > > On 8/26/24 12:17, Thomas Bogendoerfer wrote: =20
> > > > On Mon, 26 Aug 2024 11:41:19 +0200
> > > > Jiri Pirko <jiri@resnulli.us> wrote:
> > > > =20
> > > >> Mon, Aug 26, 2024 at 10:58:30AM CEST, tbogendoerfer@suse.de wrote:=
 =20
> > > >>> For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
> > > >>> allocated. So before accessing pf->lag a NULL pointer check is ne=
eded.
> > > >>>
> > > >>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de> =20
> > > >>
> > > >> You need to add a "fixes" tag blaming the commit that introduced t=
he
> > > >> bug. =20
> > >
> > > Would be also good to CC the author. =20
> >=20
> > sure, I'm using get_maintainer for building address line and looks
> > like it only adds the author, if there is a Fixes tag, which IMHO
> > makes more sense than mailing all possible authors of file (in this
> > case it would work, but there are other files).
> >  =20
> > > > Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for
> > > > SRIOV on bonded interface") =20
> > >
> > > the bug was introduced later, the tag should be:
> > > Fixes: ec5a6c5f79ed ("ice: process events created by lag netdev event
> > > handler") =20
> >=20
> > I'd like to disagree, ec5a6c5f79ed adds an empty
> > ice_lag_move_new_vf_nodes(),
> > which will do no harm if pf->lag is NULL. Commit 1e0f9881ef79 introduces
> > the access to pf->lag without checking for NULL. =20
> > >
> > > The mentioned commit extracted code into =20
> > ice_lag_move_new_vf_nodes(), =20
> > > and there is just one call to this function by now, just after
> > > releasing lag_mutex, so would be good to change the semantics of
> > > ice_lag_move_new_vf_nodes() to "only for lag-enabled flows, with
> > > lag_mutex held", and fix the call to it to reflect that. =20
> >=20
> > I could do that for sure, but IMHO this is about fixing a bug,
> > which crashes the kernel. Making the code better should be done
> > after fixing. =20
>=20
> Thomas,
>=20
> Nice catch!
>=20
> I looked into this a bit and it seems that when I sent in patch:
> commit 9f74a3dfcf83 ("ice: Fix VF Reset paths when interface in a failed =
over aggregate)
>=20
> I left in a spurious call to the previous function for moving nodes. Sinc=
e it is
> just in the error path it went unnoticed this long.
>=20
> Since this is the only call to ice_lag_move_new_vf_nodes(), it seems that
> proper way of fixing this would be to eliminate the spurious call and the=
 function
> definition entirely.
>=20
> If you do no want to do this, I can volunteer to write the patch.

either way is fine. But shouldn't the fix alone just applied first ?
Who will pick it up ?

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

