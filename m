Return-Path: <netdev+bounces-131817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495098FA5B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76601F227F1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7256E1C7B6D;
	Thu,  3 Oct 2024 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wI3ie3TD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iUxcEZ6f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wI3ie3TD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iUxcEZ6f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF314F124
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997609; cv=none; b=iAUpCACbfqavDffnXsYg9zStoUfauwLn1QqTLBlG3HgH7MsIZt0R8BNkHnv8VK6mSqz6FgumIn0x7Df1wW8OpYBId5p41wC3xlrOxNhQs+zQYJGINxhhCucgjwnj8cUwbOYHFtXKRzW8QhGuGCJbmanZxRGaeI9d7v2LOJuPwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997609; c=relaxed/simple;
	bh=H3iTC4DsGRHd6QZQPxJQYq1PpP9GX71uNhyC8fQSM7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFIrviGFOhLE/KlrjGlME+6UKqRx82GZccubNmoBzKgU7NEN5wQKWgtfKjdC0eLCPJwI67iy175y5cxsFs3PsRxGu/wiycC4Gm6garTSyFrF/t46YzDo1zTBiwbmmNXa2TBGZXYaSyjRi6A77XNi0IMXlCFJBMMaQ2DeV4oK62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wI3ie3TD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iUxcEZ6f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wI3ie3TD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iUxcEZ6f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4C211F441;
	Thu,  3 Oct 2024 23:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727997605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H3iTC4DsGRHd6QZQPxJQYq1PpP9GX71uNhyC8fQSM7Y=;
	b=wI3ie3TD2c7puMco3psKNq4aflpK49lfgT8ZKP0E2CnzEs3pfY75CxPhZCPNBb0590HDU1
	Yns3AhY/W4KPVTMmOUKINOxSe3KCZ6MytM89Zf9e/TnJGvSVzIdjJ1I5VTqoyrFz1cOCx1
	mgdVn0PFB9l6ILHAwRXBVAPSqGXwQLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727997605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H3iTC4DsGRHd6QZQPxJQYq1PpP9GX71uNhyC8fQSM7Y=;
	b=iUxcEZ6flXyeIdVZFOwIVcZVIjZtnhqzld3ANIkMwhA0qEufVkPiMGQIdZdwUtzZxU+Rae
	sa1ZspURSvQFuuAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727997605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H3iTC4DsGRHd6QZQPxJQYq1PpP9GX71uNhyC8fQSM7Y=;
	b=wI3ie3TD2c7puMco3psKNq4aflpK49lfgT8ZKP0E2CnzEs3pfY75CxPhZCPNBb0590HDU1
	Yns3AhY/W4KPVTMmOUKINOxSe3KCZ6MytM89Zf9e/TnJGvSVzIdjJ1I5VTqoyrFz1cOCx1
	mgdVn0PFB9l6ILHAwRXBVAPSqGXwQLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727997605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H3iTC4DsGRHd6QZQPxJQYq1PpP9GX71uNhyC8fQSM7Y=;
	b=iUxcEZ6flXyeIdVZFOwIVcZVIjZtnhqzld3ANIkMwhA0qEufVkPiMGQIdZdwUtzZxU+Rae
	sa1ZspURSvQFuuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8292D139CE;
	Thu,  3 Oct 2024 23:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V7ePHqUm/2avYQAAD6G6ig
	(envelope-from <mkubecek@suse.cz>); Thu, 03 Oct 2024 23:20:05 +0000
Date: Fri, 4 Oct 2024 01:20:03 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
	"Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Message-ID: <tctt7svco2xfmp7qr2rrgrpx6kzyvlaia2lxfqlunrdlgjny3h@77gxzrjooolu>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240913224858.foaciiwpxudljyxn@skbuf>
 <IA1PR11MB62661EF398124FC523CC3C03E4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <45327ee6-e57c-4fec-bf43-86bd1338f5fb@intel.com>
 <20241003091810.2zbbvod4jqq246lq@skbuf>
 <dcdnyuvjksvebfgcavogszlcoro3gwinzc6fzfjjtijadyg3km@7spc2j4v2ci6>
 <20241003134916.q6m7i3qkancqjnvr@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fs4wmkgysjkaqvkp"
Content-Disposition: inline
In-Reply-To: <20241003134916.q6m7i3qkancqjnvr@skbuf>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -5.90
X-Spam-Flag: NO


--fs4wmkgysjkaqvkp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 04:49:16PM +0300, Vladimir Oltean wrote:
> On Thu, Oct 03, 2024 at 01:09:47PM +0200, Michal Kubecek wrote:
> > I'm afraid we will have to keep the unfortunate ioctl fallback for quite
> > long. The only other option would be to only use netlink for RSS against
> > kernel which provides full information and use only ioctl against those
> > which don't.
> >=20
> > Michal
>=20
> So, then, is there anything blocking this patch?

I'm still not fully convinced that this mix of netlink and ioctl is
actually better than fully reverting to ioctl until we can get all
information via netlink.

Either way, I'm going to handle this before the end of this week so that
ethtool 6.11 can be released. At the moment I'm in favor of your patch,
however unhappy I'm about it.

Michal

--fs4wmkgysjkaqvkp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmb/Jp4ACgkQ538sG/LR
dpVj7wf4zmMjoBUJFAkN0cMZKcawHfxm6UuHZNglL3IioXBXYHw4hxnisZ0Rj5Iw
Pi15QOwL3bnL7zZWq8PNQyezrwcHlucCc2QiQ2SLyGjbgMS52/050NQEXjHk9W8b
t769FJWe6wHTqG1rsajEjzM4lxGcUvdX+fsazCa8QHXlAGS3UcVb+GONXWBVxgEU
CICyDTUoomru/EZ8nQOmd9+AUmaiLM+HBWvtOk/ot4ynygDhNCOpyQg+KZK+gDMT
t02Q2q00wCeztazjjCOgG+/2gwk0m0PqsTPExFD4Xu8CaglqRnxPKTqJqEfEHlHT
4C3H8Tf9jYZTmfPTT6Q+3iNSPldr
=X2em
-----END PGP SIGNATURE-----

--fs4wmkgysjkaqvkp--

