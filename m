Return-Path: <netdev+bounces-122488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE119617DA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11F71F21F04
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8491D2F6E;
	Tue, 27 Aug 2024 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X+vPlEne";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="siK8oYLj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X+vPlEne";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="siK8oYLj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21B148FE5;
	Tue, 27 Aug 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785953; cv=none; b=rVg4ed2mndFqCysO7VRzA6DDCiY0mqi84qVX27clIwSR/ya3xsG1LXph7vIjH3+wnYWwkX+NCOBwsAoYmOBEDnQoNBMdnpbqwx4PBRN7L7k1DVkRTy1xNi+n1VacUFz4UfP4YWtaZFHbhF1FvfJFI2n+UqePXdK8N23e6N5AL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785953; c=relaxed/simple;
	bh=WwyLTLHHcXK9QqAZ1s94cqc8FzuBnwLDgcAQwNo2nbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heFlv8oTI6aTUUZpcKpL59ZWQ1TwTyJsxHC4h6p8k+1QWzSS1AJe+u1Iuedhq9gp1SylcXN38Z036pmaGH/XQIbVNb4hLgxLkczifJ9c/upfW3CXGDe4N73CRpNdLcavkxpm3Mhazif2BrEtKfBTTtml2A8eis2Nzyml0gyvkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X+vPlEne; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=siK8oYLj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X+vPlEne; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=siK8oYLj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB53B1FB86;
	Tue, 27 Aug 2024 19:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724785949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV7fAjaizF4vynjkGZ/75HBzKrPuuFVP8PnlSmPIxwk=;
	b=X+vPlEneJD0qhFJi2Kx8Xo0qkNOHG3KSuspOC6CMtYIY/+h7F1r9nMfpW8zLROF9taU8S3
	aFE3GHU4Ows4b6yDeZ8jLISne4PhwcqW1DvBEh5zL1nUXMr9oQTk5JQTonU6wi6OP+Gc2Z
	TJ2yYxpbtXWwo53DgMaBtL95IVpEQeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724785949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV7fAjaizF4vynjkGZ/75HBzKrPuuFVP8PnlSmPIxwk=;
	b=siK8oYLjSAiJ9eajPXBKoZORHOIGT3g8kdmV58jc8X/mqGtBMefSgY/j3s81MB0qZYOwDK
	7zSZsaMT5TnT0FAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X+vPlEne;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=siK8oYLj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724785949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV7fAjaizF4vynjkGZ/75HBzKrPuuFVP8PnlSmPIxwk=;
	b=X+vPlEneJD0qhFJi2Kx8Xo0qkNOHG3KSuspOC6CMtYIY/+h7F1r9nMfpW8zLROF9taU8S3
	aFE3GHU4Ows4b6yDeZ8jLISne4PhwcqW1DvBEh5zL1nUXMr9oQTk5JQTonU6wi6OP+Gc2Z
	TJ2yYxpbtXWwo53DgMaBtL95IVpEQeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724785949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV7fAjaizF4vynjkGZ/75HBzKrPuuFVP8PnlSmPIxwk=;
	b=siK8oYLjSAiJ9eajPXBKoZORHOIGT3g8kdmV58jc8X/mqGtBMefSgY/j3s81MB0qZYOwDK
	7zSZsaMT5TnT0FAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8007813724;
	Tue, 27 Aug 2024 19:12:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GGUBHh0lzmY5agAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Tue, 27 Aug 2024 19:12:29 +0000
Date: Tue, 27 Aug 2024 21:12:24 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 "Jiri Pirko" <jiri@resnulli.us>
Subject: Re: [PATCH net] ice: Fix NULL pointer access, if PF doesn't support
 SRIOV_LAG
Message-ID: <20240827211224.0d172e40@samweis>
In-Reply-To: <362dd93c-8176-4c46-878d-dd0e1b897468@intel.com>
References: <20240826085830.28136-1-tbogendoerfer@suse.de>
	<ZsxNv6jN5hld7jYl@nanopsycho.orion>
	<20240826121710.7fcd856e@samweis>
	<362dd93c-8176-4c46-878d-dd0e1b897468@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BB53B1FB86
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue, 27 Aug 2024 09:16:51 +0200
Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:

> On 8/26/24 12:17, Thomas Bogendoerfer wrote:
> > On Mon, 26 Aug 2024 11:41:19 +0200
> > Jiri Pirko <jiri@resnulli.us> wrote:
> >  =20
> >> Mon, Aug 26, 2024 at 10:58:30AM CEST, tbogendoerfer@suse.de wrote: =20
> >>> For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
> >>> allocated. So before accessing pf->lag a NULL pointer check is needed.
> >>>
> >>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de> =20
> >>
> >> You need to add a "fixes" tag blaming the commit that introduced the
> >> bug. =20
>=20
> Would be also good to CC the author.

sure, I'm using get_maintainer for building address line and looks
like it only adds the author, if there is a Fixes tag, which IMHO
makes more sense than mailing all possible authors of file (in this
case it would work, but there are other files).

> > Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for
> > SRIOV on bonded interface") =20
>=20
> the bug was introduced later, the tag should be:
> Fixes: ec5a6c5f79ed ("ice: process events created by lag netdev event=20
> handler")

I'd like to disagree, ec5a6c5f79ed adds an empty ice_lag_move_new_vf_nodes(=
),
which will do no harm if pf->lag is NULL. Commit 1e0f9881ef79 introduces
the access to pf->lag without checking for NULL.
>=20
> The mentioned commit extracted code into ice_lag_move_new_vf_nodes(),
> and there is just one call to this function by now, just after
> releasing lag_mutex, so would be good to change the semantics of
> ice_lag_move_new_vf_nodes() to "only for lag-enabled flows, with
> lag_mutex held", and fix the call to it to reflect that.

I could do that for sure, but IMHO this is about fixing a bug,
which crashes the kernel. Making the code better should be done
after fixing.

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

