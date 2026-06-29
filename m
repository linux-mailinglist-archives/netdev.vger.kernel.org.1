Return-Path: <netdev+bounces-302775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d6DpLdq2QmpYAAoAu9opvQ
	(envelope-from <netdev+bounces-302775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:18:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4656DDF67
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:18:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VNtHKhc9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VGtJps6u;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SsLfc1Uz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0ewm2h2d;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302775-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302775-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68689304544C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0155637FF47;
	Mon, 29 Jun 2026 18:15:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD1A3803F7
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:15:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756904; cv=none; b=MVsk+3/vsdiJTWXOYlJhj4bR+RiUJaVRw+FWjaPaXU8+pcwageC/lthYLJyiX2ov/DkiUE97Af66EgcifFYxlET+vNO4ZGEObQSy/jwtmducs9+zKslZLxqL8Z9a9HwkOI6/9EV4yXIZ6AoG648K+3z5x3Sc8InN6sqrebP3f7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756904; c=relaxed/simple;
	bh=By0n8G3sBjGLrUSrrTIHRTlZQW3MAqjP1hwQzFXUw7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqAsYGWpYjpVBWIVF3aZzw6EmELywmtexuF9jDkcDJDwvh7Y/D37WUux7ooC8jKt23pUTscQe+qJ0F4gngcW0HvyGi0ph/f96leIQK0aC6TeMvvYrqPKahFX2ZnLtf2N+YzYNd6mBbpZnFi7A8YmEUlqyt3oemNWWWAjrnUmwqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VNtHKhc9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGtJps6u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SsLfc1Uz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ewm2h2d; arc=none smtp.client-ip=195.135.223.130
Received: from lion.mk-sys.cz (unknown [10.149.218.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA524731FD;
	Mon, 29 Jun 2026 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782756900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKDO9YEPoEjEnMcJ6USeubCIXl3RKllsrDCzVLn6z9c=;
	b=VNtHKhc9ARdD8zfheivU5BHCNZn7aW7IugGli1pdOVyPVCWvLit3KzxPwgsN0A7/GKNp4r
	qLVBiYMqZDghr8rsoJ3s2OdbrXkDsJWvAzdFl5hCAGX96RUgCWdfOxS/ZLhrJryDBef+eG
	hds+1srxiM8VLQc4Yls9vzVA0RNanoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782756900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKDO9YEPoEjEnMcJ6USeubCIXl3RKllsrDCzVLn6z9c=;
	b=VGtJps6uimFJEKdlPlWS3P1gKnOlTx8J5KMA2qR2HjXxNxuEUeiDw1IvFlLojxpN9wnAfE
	PrIwBSJcPTuhIuDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782756898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKDO9YEPoEjEnMcJ6USeubCIXl3RKllsrDCzVLn6z9c=;
	b=SsLfc1UzxwE8Xlv+ELmNDUBdsgw7gis0jjbYoLlRCNZP6CpfGmwpFPTknKAg9CYYSNTsSc
	4zlfdVlioxomjqDK8K7LL6k/kcWh2F6s+Qpo80azWITEPacYdxUtusAEdJNh6/NIZ6ScL8
	YFl3xTOiwVJrK7S2kdR+oW6OEAAaqbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782756898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKDO9YEPoEjEnMcJ6USeubCIXl3RKllsrDCzVLn6z9c=;
	b=0ewm2h2d1h24j7cJcdmUcK5A1DUGwcKJ7co/X7ZP4iAWcXQl/RDWdMKqH+EU1FZ7E0UmBp
	zmTzQfG2RWw7yOBA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 9B4292008C; Mon, 29 Jun 2026 20:14:58 +0200 (CEST)
Date: Mon, 29 Jun 2026 20:14:58 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "D H, Siddaraju" <siddaraju.dh@intel.com>, 
	Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"Das, Shubham" <shubham.das@intel.com>, "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>, 
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>
Subject: Re: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Message-ID: <jwbx3t5mxv6drv56ttu3iavtbv34csqtdewdgal4jkutx4zpgs@uya4traf7und>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
 <MW4PR11MB6912BE7FEDE5C509B6C5D5DF9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2baa5a77-3305-4ed9-b56d-ba27cecc1911@lunn.ch>
 <MW4PR11MB6912BABFEED268D38B4BC2BB9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <1b3975a8-788a-4b81-94ec-3ab5708b251b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2h5sszaprbwge7ah"
Content-Disposition: inline
In-Reply-To: <1b3975a8-788a-4b81-94ec-3ab5708b251b@bootlin.com>
X-Spam-Flag: NO
X-Spam-Score: -4.90
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:siddaraju.dh@intel.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302775-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mkubecek@suse.cz,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkubecek@suse.cz,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF4656DDF67


--2h5sszaprbwge7ah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 11:30:43AM GMT, Maxime Chevallier wrote:
> > What about
> > "option-(b): create a new enum ETHTOOL_LINK_MODE_10G_SFI_DA_Full_BIT"?
> >   Idea is just to create a new enum, with same enum value of 10000baseC=
R.
> >   This will NOT consume a bit position in "ethtool_link_mode_bit_indice=
s".
> >   It just helps those tech-savvy people, who does not accept 10000baseCR
> >   and prefer 10000sfiDA for being explicit.
>=20
> The thing is that even with a new enum value, that won't bring much to
> the table. It would likely be better to have a comment near the
> 10000baseCR definition explaining the SFF equivalency.
>=20
> >=20
> > At worst case, hope we agree for
> > "option-(c): ethtool.8 man page help strings to indicate 10G_SFI_DA"
> >   Something like
> >     "10000baseCR (10G_SFI_DA    SFF-8431 SFP+ DA)
> >   under "advertise" mask values.
>=20
> In that case, let's add Michal in the loop as the ethtool maintainer. Even
> then it's not straightforward as some tooling relies on the JSON output
> from ethtool, so _if_ we change the output for that mode, it should only
> be in the non-json output.

The biggest problem I see here is that even if ethtool has its own link
mode tables, those are only for backward compatibility and as long as
reasonably new ethtool and kernel are in use, ethtool gets the link mode
names from kernel. There are multiple aspects:

1. The UAPI constants. These are part of kernel uAPI and ethtool just
gets a sanitized copy of kernel file. In other words, if we want any
change here (even adding a comment), it has to be done on kernel side
and ethtool gets the change on next uapi sync. Adding an alias here
would be quite simple.

2. Link mode names as shown in "ethtool <dev>" output. These are
normally retrieved from kernel via the ETH_SS_LINK_MODES string set.
In other words, if any change were desired, it would have to happen on
kernel side as well. And unless we add a specific exception to the code,
the same name is shown in both plain text and json output. (Personally
I don't think it would be a good idea to show different name in each.)

3. Link mode names that can be used in "ethtool -s" command line. These
are handled exactly the same way as names used for output. Here I could
imagine an alias implemented on ethtool side but it would have to be
hard coded in ethtool and it would only work in (new versions of)
ethtool. In general, names shown by "ethtool <dev>" should match those
expected on "ethtool -s" command line, any mismatch would be very
confusing and impractical.

4. Adding a text to ethtool(8) manual page is possible. While most of
the link mode table in the man page is (unsurprisingly) generated, it is
then reordered manually and adding a note would definitely be possible.
One just needs to be careful about the table formatting. (Yes, I'm aware
that this table has been getting out of hand for some time and I'm
thinking about ways to make it more readable and useful. Suggestions are
welcome.)

> My personal opinion would be that adding a comment in the enum definition
> near 10000baseCR is enough :/

That would certainly be the easiest solution but as I said above, it
would be a kernel code change, ethtool would just inherit the updated
header file.

Michal

--2h5sszaprbwge7ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmpCth0ACgkQ538sG/LR
dpUrBAf+IN/EACNYTvrR6+Ay7cZ/WZvBfNHjN0bO1bipHGngUSS/815PTo5SFQ7M
7r18M7nNDH4v0W2KxvkIaLYuAFpsxRTV/ykUgzdy4ZamizF/qFLAo9PjNaK1wTaQ
wlMmotkiR87FMZgIEaMZy3r/6DBYRQ4OWDJ9CZx1bEkqS/Mvu0S7jeTGrl3WQRgP
mtS8nhdCvPtl8T6Y0c1d45QUTPe36a13Vnssnm+xh8rOaF04ofp8Go0TXlsodtaJ
H4ZraOGTX9WSzd6SoimxBfpliDDuhuRyylNXQ5i0tjcAJVX20nzgaZppjpMhgcJh
iAPJSAUihIARMuS24p1erBCLktt+hA==
=J4JH
-----END PGP SIGNATURE-----

--2h5sszaprbwge7ah--

