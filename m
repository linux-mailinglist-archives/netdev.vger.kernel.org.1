Return-Path: <netdev+bounces-78665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7761876108
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7EE282600
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA152F7F;
	Fri,  8 Mar 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ccsno1JB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="90oYvb9s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ccsno1JB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="90oYvb9s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25B22F0F
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890693; cv=none; b=ZeSEsC+Oapt9B4thbvii4ON/GmOxRcL26tcM5jjZVA6Hv652Q5aA2/sXU8jpLwBNFVD2Ln0GViYAZifRMU5+APX5HPlRq3aF/1en/H4A9TUbRBorhmlPhAAWSwPAM5vj0GFmi34M1UaPE4EkvPZ6DaOUBMjB41lGS3SZeDG8YyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890693; c=relaxed/simple;
	bh=7cPWq8PidDWpME3nuqSCElVzBmJ1vDhz0swL9iTH5Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9KooFAP+BpUJoXAmnlwrWruQjRt3UGwrtgQVnAHISCPfDjEqhb/4SoeqV7dCegtTqfBDzK5oihfVnjrKo+vV8Pu3lx/fL+S4TG951xrKy8uLZqFequNbreNaAKjtpXmobJy9VD0rQvl756SCxn/1BPq9pILjuLUegX4DX7KE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ccsno1JB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=90oYvb9s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ccsno1JB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=90oYvb9s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8167734879;
	Fri,  8 Mar 2024 07:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709882144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y/KyuaciNXjMkUvqRU6b/zZAmnW+SMlaxNEMG7wFdw=;
	b=Ccsno1JBWYK03N44CMBwStAjZIXYf78Dz1jo4+g39UkbcpXfcf68j5kmyciKAZZio06F1Y
	aaq42WRCKAkHjxvnnAmNDsekPCfRKo7CF0VGzAuAtwpFjkRj1ocKbTFQDQRNrCW4bGJv+b
	pk7g+AhBz+HI/nmjKr8ZbCJ9wML7osY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709882144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y/KyuaciNXjMkUvqRU6b/zZAmnW+SMlaxNEMG7wFdw=;
	b=90oYvb9sz1InD2oloCDfNamSmPENxW5+ltICi/yag4MEHTsMsdoIzlK3yUVMsxO1K80ez4
	b87xZwhvbHwOe9Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709882144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y/KyuaciNXjMkUvqRU6b/zZAmnW+SMlaxNEMG7wFdw=;
	b=Ccsno1JBWYK03N44CMBwStAjZIXYf78Dz1jo4+g39UkbcpXfcf68j5kmyciKAZZio06F1Y
	aaq42WRCKAkHjxvnnAmNDsekPCfRKo7CF0VGzAuAtwpFjkRj1ocKbTFQDQRNrCW4bGJv+b
	pk7g+AhBz+HI/nmjKr8ZbCJ9wML7osY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709882144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y/KyuaciNXjMkUvqRU6b/zZAmnW+SMlaxNEMG7wFdw=;
	b=90oYvb9sz1InD2oloCDfNamSmPENxW5+ltICi/yag4MEHTsMsdoIzlK3yUVMsxO1K80ez4
	b87xZwhvbHwOe9Dg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 6F5822013C; Fri,  8 Mar 2024 08:15:44 +0100 (CET)
Date: Fri, 8 Mar 2024 08:15:44 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: "Sagar Dhoot (QUIC)" <quic_sdhoot@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nagarjuna Chaganti (QUIC)" <quic_nchagant@quicinc.com>,
	"Priya Tripathi (QUIC)" <quic_ppriyatr@quicinc.com>
Subject: Re: Ethtool query: Reset advertised speed modes if speed value is
 not passed in "set_link_ksettings"
Message-ID: <20240308071544.dnh47hijov3aqbzu@lion.mk-sys.cz>
References: <CY8PR02MB95678EBD09E287FBE73076B9F9202@CY8PR02MB9567.namprd02.prod.outlook.com>
 <945530a2-c8e9-49fd-95ce-b39388bd9a95@lunn.ch>
 <CY8PR02MB956757D131ED149C97F7D0DBF9272@CY8PR02MB9567.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrv3letzv62idca3"
Content-Disposition: inline
In-Reply-To: <CY8PR02MB956757D131ED149C97F7D0DBF9272@CY8PR02MB9567.namprd02.prod.outlook.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-5.20 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -5.20
X-Spam-Flag: NO


--lrv3letzv62idca3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 06:33:00AM +0000, Sagar Dhoot (QUIC) wrote:
> Hi Andrew,
>=20
> Thanks for the quick response. Maybe I have put up a confusing scenario.
>=20
> Let me rephrase with autoneg on.
>=20
> 1. "ethtool eth_interface"
> 2. "ethtool -s eth_interface speed 25000 autoneg on"
> 3. "ethtool -s eth_interface autoneg on"
>=20
> Once the link is up at step 2, "get_link_ksettings" will return the
> speed as 25G. And if "set_link_ksettings" is invoked at step 3, it
> will still pass the speed value as 25G retrieved with
> "get_link_ksettings", even though the speed was not explicitly
> specified in the ethtool command. So, after step2, if I must go back
> to the default state i.e., advertise all the supported speed=20
> modes, is there any way to do so?

IIRC this is backward compatible with how the ioctl interface behaves.
The logic is that if a parameter is omitted, it is supposed to be
preserved; thus the third command simply means "enable the
autonegotiation" and don't do anything else (which is a no-op in this
case).

But I agree that it would be convenient to have a shortcut for "enable
the autonegotiation with all supported modes". On the command line it
could be e.g. something like

  ethtool -s $iface autoneg on advertise all

or

  ethtool -s $iface autoneg on advertise supported

On the implementation level, the problem is that IIRC we have no easy
way to express such request in current netlink API. It could be emulated
by querying the modes first (which returns both advertised and supported
modes) and requesting supported modes to be advertised but that's not
very practical. So probably the best solution would be introducing a new
flag and using the complicated way as a fallback if the kernel does not
support it.

Michal

--lrv3letzv62idca3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmXquxwACgkQ538sG/LR
dpU0YggAkkI1KS52Tdlbt9cZEWdmhu8yQVElkKlCCkbmmZaSZTcw5oDG2FhblwgM
WxMpHdFFDUvg1QWKVXLsuBGcU329zj96u1oxvgQ5g3f0MDM65qFdN8jgumY5bXoN
/RSPcpW5aJmHzG3/temf2uOODTp8pjccRBLBtPz+1BFIOc+pAlJDxorgofmFb20x
cw8RnOEyDZjxyOvXylnGMvOjUjjLic/Wh7Nj+V4ATANjq/OP62hn7sqG2bHQQrou
0YUJbIy0euJgZ2INX92SozLHYb9onZanYGLaM7KV6vgnn02AJtPe1B+HuVXpJZxm
PpnasBruGtntziJ4g0ngLaNLsyXIjA==
=02t6
-----END PGP SIGNATURE-----

--lrv3letzv62idca3--

