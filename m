Return-Path: <netdev+bounces-285356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKgiA3Cj/Gn2SAAAu9opvQ
	(envelope-from <netdev+bounces-285356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:36:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985F4EA4C5
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E37F3006B27
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F7402B9B;
	Thu,  7 May 2026 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNbvERez";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z8BrZ14T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eoDh41dn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fl5WbAZA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7E3F0763
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164366; cv=none; b=NpZK+Nw9tWEvZAYgVSQCNJ+thJhkAw8/a8+I7HeYUm+KxLAkh0RstwiGvuOitVIOa63Ou9IiY6+5/C8W9Q5FfoxNhIJAE25pbRAVlE21anVxPDqNBGTNlrVV7LITGtl+rips7waZDLyFCbByIJ7JKCMlXlvIeOj7jkRbYS6AZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164366; c=relaxed/simple;
	bh=5uGawXoDlc4k/fCjW/6XYBM2eIyS0AzpHJoJ1pMOp10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN6YoXB6ZEjMD8pqI+TfkDzR9Qfg2YhCkoDlicy1QNFNapNN76ifDDdyv7kVwai91mTDWmn+VWq2MPT4ZSTQ+D4Eu70ajWmzZAJtEU6q0mlD25i8HqNajHOyZ54K9uCwGpSChARMHd4gbqT32pU0/jPGQzOxHIcze2AFf/Gcaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNbvERez; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z8BrZ14T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eoDh41dn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fl5WbAZA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.149.218.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D64116AAEF;
	Thu,  7 May 2026 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778164361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5uGawXoDlc4k/fCjW/6XYBM2eIyS0AzpHJoJ1pMOp10=;
	b=rNbvERezM+K8w521bOSWpKmY4Di2BkGfFOIUQ9fWBSIT/ZI7mB3LTQrRusYm9oMld5+I09
	TpfXQHU1MrPU7uJr/vAuCtthUAm5Dmm9WSoEfCnJK+m/fBX6ryp8TMSI4JDAdYcUBlfCOz
	I3tjDndh0/FDTvZsn6EgivJvtJNf7hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778164361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5uGawXoDlc4k/fCjW/6XYBM2eIyS0AzpHJoJ1pMOp10=;
	b=Z8BrZ14TGH7r4Q2Aq9BYT/4nl1pFa1LOX80uf3VQbMT8WfC6R0AVXpgPHe+QDtFiMMABiq
	oKSlvcbOv0kk0eDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778164360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5uGawXoDlc4k/fCjW/6XYBM2eIyS0AzpHJoJ1pMOp10=;
	b=eoDh41dn/9oDTzvTQtZTCpZgVpY1RGdvnZcRekTFAJEAX9UYXSxVc1wkBQh9OFD/ffy6EN
	G2LHAlgmr+fyBo+TQ7LSQ05C6djogQVptzLjp1eWJqlNfu2W2X0ceg9xxVYBQ4sKxrlfnD
	kjejVShCZQxcipl4LvtzRurdqXoYmOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778164360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5uGawXoDlc4k/fCjW/6XYBM2eIyS0AzpHJoJ1pMOp10=;
	b=fl5WbAZA5O6/nJn0cjzFWR2FpfmQtQGZNSvDhc5iXsrYGZG+H9Dnz7PtGlO1fvt06AjTw0
	+4QL2ZQ+1swQh3DA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id B87202008C; Thu, 07 May 2026 16:32:40 +0200 (CEST)
Date: Thu, 7 May 2026 16:32:40 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH ethtool-next 0/5] ethtool: Add 'pages on|off' option for
 module EEROM hex dump
Message-ID: <a3hwbnaaomurr7mwbq2xnykaytwp6eblfflkg3mwihkkybnake@wkdxsrodzl5h>
References: <20260507114721.3409128-1-danieller@nvidia.com>
 <4chkrvenxrbc2tylrbob6vdo3uyjzbwbhbup25yvnohrccvotv@fd7rqasq4btv>
 <DM6PR12MB4516FAE7C203C652E10BE801D83C2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w7toz5yyfyvw5uuf"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4516FAE7C203C652E10BE801D83C2@DM6PR12MB4516.namprd12.prod.outlook.com>
X-Spam-Flag: NO
X-Spam-Score: -5.90
X-Spam-Level: 
X-Rspamd-Queue-Id: 4985F4EA4C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285356-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkubecek@suse.cz,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--w7toz5yyfyvw5uuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2026 at 12:37:25PM GMT, Danielle Ratson wrote:
> The reason for keeping the switch is backward compatibility: today's
> ethtool -m hex on produces a single flat hex dump, while the
> page-organized output has a different shape - per-page headers, blank
> lines and repeated column headers interleaved between hex rows.
> Scripts that parse today's output could break.
[...]
> Since the format changes shape and not just size, we kept it opt-in via pages on so existing consumers are unaffected.
> Are you OK with this even so it might break some existing usage?

Good point, there may indeed be existing scripts that would not handle
changed (default) output format. While I would personally prever the
binary dump for machine processing, people often parse text outputs that
were never meant to be used that way.

I suppose your approach is a safer choice then.

Michal

--w7toz5yyfyvw5uuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmn8ooQACgkQ538sG/LR
dpWjoQf/Ta7SNVab2BnWNo88gK0hE7kdHaiKOpRMo6dK4E5pHwpI48wrW+QZ1OeM
qMHPrKj6aD1u3doxqOCiJrrvSZrdLgqGXPlfg0bOGIaURDRPkHukDSdS+7iCAY9/
u5hm326r6IXwDq4Dg2yKzd6M6wYatVoPtGqy5sMqkKE4PaOeiYmcVZskkbWrqjxf
LThglJ2o8hj5a+g16vhDsRijQsGRj+MjdjbKaVGnY+hbMgryzIO6ZXK3Opzi+s9P
8H/T9aQKFJs4dxi2JWjaqta9r2S9E6d4g4m4pNWcuQf5NT3Yiyi40oZ2YbPPplUI
Rn4MTATZY2Tw0Dej2kEI2TJ3ITA7Uw==
=EAsM
-----END PGP SIGNATURE-----

--w7toz5yyfyvw5uuf--

