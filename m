Return-Path: <netdev+bounces-124061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4005967C76
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 00:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB75A1C20AD6
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 22:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36D713AA3E;
	Sun,  1 Sep 2024 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILkdjCDA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FH83tNME";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hJD1LvQk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t4os1Lgv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066217C;
	Sun,  1 Sep 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725228284; cv=none; b=mFmp4lbghbciqnvlE0/00IyVUlAI4zac2IdTYAbrP5usuImtoKB71ELx0dVlmRCRx4odk/YTZ2zoLLd7ab8cZ5qPwHBmjsLQPR7qpGZqR3A4G1Eg3VtHz1UPr9p/xYPjbJ09boRhT9xjp24ZN/uWFCD+osgc560SFUUV7RAbdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725228284; c=relaxed/simple;
	bh=c37rpiXkm2LHi1jZdBq2tr5kRE5KtstnSJwMipwaQP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btRqWPa/+UqlSvSdGzQduoU+6G0BSCoM/wNIESn96VoFW4ltKWrrn2qwp49lbrgPcJyhJjZS0Ti2ebrMrb2byIugU+GYL2l+TqKzodQ0Dad7JdlIkdfxWaT0wPeDXes1tWOBg74FLnCnJH8klUSfxymF6TeexLW/bskJRKCGgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILkdjCDA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FH83tNME; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hJD1LvQk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t4os1Lgv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54C8921ADB;
	Sun,  1 Sep 2024 22:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725228280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myVYiztsVw4aaGaw5Ze5hEowZsNkoppn77yMsZ+r+8k=;
	b=ILkdjCDAnJk8mzCHYjOAplZK5w6tF58+dHaWfugMjfe4+3kBT5ChV/yRR5X4LqOX2UcpKI
	Y99bCV1pxlmoTr9g2RqnFHGMDZZ+adMrl8jwFC2o3fKcL1AvX23o3jcnCdLxo0UQBSO/h2
	b3KxXxV22BJqF9eQYZ9ij4Lp8N0AaSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725228280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myVYiztsVw4aaGaw5Ze5hEowZsNkoppn77yMsZ+r+8k=;
	b=FH83tNMEwstXyD6Rvtdh+HmBKFRCNKpL3LAru8ptWlfaL75Bm32Bx2237p654zi7q3b4YS
	P2VxnhuPJzfi83Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725228279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myVYiztsVw4aaGaw5Ze5hEowZsNkoppn77yMsZ+r+8k=;
	b=hJD1LvQk6FJ38AkxflcPoJepDBJMYuc8T02M6uUf8iZUBDENXPIO3kbREC2wLLaZUYbwLK
	nh4+FgFJRCakXLRrAIX5mZ9XTPLgF4Gr1mjP9ftCpYV9iisguf4vRCRk8sEeJ1Y20nF2zn
	NxulIHkvTMvqSZbkrJNFZimWe5yQ9hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725228279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myVYiztsVw4aaGaw5Ze5hEowZsNkoppn77yMsZ+r+8k=;
	b=t4os1LgvdZ46et4yVT24e2K0rb/+jcXBwNxViRqlnXITgVwYLLSfv6Q//m6Y19BOyHYcS6
	BH/WEWrmC92TpIBQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 3F03A2012C; Mon,  2 Sep 2024 00:04:39 +0200 (CEST)
Date: Mon, 2 Sep 2024 00:04:39 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Herve Codina <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jonathan Corbet <corbet@lwn.net>, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, =?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH ethtool-next v2 2/3] ethtool: Allow passing a PHY index
 for phy-targetting commands
Message-ID: <bwh3s7vcingnkhnnvucak656sj2u2vikwupysgihvfdcshixtf@nymosaa2eth6>
References: <20240828152511.194453-1-maxime.chevallier@bootlin.com>
 <20240828152511.194453-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yavmk5fnem4h4s3z"
Content-Disposition: inline
In-Reply-To: <20240828152511.194453-3-maxime.chevallier@bootlin.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.40 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_ONE(0.00)[1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,bootlin.com,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,lists.infradead.org,csgroup.eu,gmail.com,nxp.com,lwn.net,pengutronix.de];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,lion.mk-sys.cz:helo]
X-Spam-Score: -4.40
X-Spam-Flag: NO


--yavmk5fnem4h4s3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 05:25:09PM +0200, Maxime Chevallier wrote:
> With the introduction of PHY topology and the ability to list PHYs, we
> can now target some netlink commands to specific PHYs. This is done by
> passing a PHY index as a request parameter in the netlink GET command.
>=20
> This is useful for PSE-PD, PLCA and Cable-testing operations when
> multiple PHYs are on the link (e.g. when a PHY is used as an SFP
> upstream controller, and when there's another PHY within the SFP
> module).
>=20
> Introduce a new, generic, option "--phy N" that can be used in
> conjunction with PHY-targetting commands to pass the PHY index for the
> targetted PHY.
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  ethtool.8.in         | 20 +++++++++++++++++
>  ethtool.c            | 25 ++++++++++++++++++++-
>  internal.h           |  1 +
>  netlink/cable_test.c |  4 ++--
>  netlink/msgbuff.c    | 52 ++++++++++++++++++++++++++++++++++----------
>  netlink/msgbuff.h    |  3 +++
>  netlink/nlsock.c     |  3 ++-
>  netlink/plca.c       |  4 ++--
>  netlink/pse-pd.c     |  4 ++--
>  9 files changed, 96 insertions(+), 20 deletions(-)
>=20
[...]
> @@ -6550,6 +6559,16 @@ int main(int argc, char **argp)
>  			argc -=3D 1;
>  			continue;
>  		}
> +		if (*argp && !strcmp(*argp, "--phy")) {
> +			char *eptr;
> +
> +			ctx.phy_index =3D strtoul(argp[1], &eptr, 0);
> +			if (!argp[1][0] || *eptr)
> +				exit_bad_args();
> +			argp +=3D 2;
> +			argc -=3D 2;
> +			continue;
> +		}
>  		break;
>  	}
>  	if (*argp && !strcmp(*argp, "--monitor")) {

Could we have a meaningful error message that would tell user what was
wrong instead?

> @@ -6585,6 +6604,10 @@ int main(int argc, char **argp)
>  	}
>  	if (ctx.json && !args[k].json)
>  		exit_bad_args_info("JSON output not available for this subcommand");
> +
> +	if (!args[k].targets_phy && ctx.phy_index)
> +		exit_bad_args();
> +
>  	ctx.argc =3D argc;
>  	ctx.argp =3D argp;
>  	netlink_run_handler(&ctx, args[k].nlchk, args[k].nlfunc, !args[k].func);

Same here.

[...]
> diff --git a/netlink/msgbuff.c b/netlink/msgbuff.c
> index 216f5b9..2275840 100644
> --- a/netlink/msgbuff.c
> +++ b/netlink/msgbuff.c
> @@ -138,17 +138,9 @@ struct nlattr *ethnla_nest_start(struct nl_msg_buff =
*msgbuff, uint16_t type)
>  	return NULL;
>  }
> =20
> -/**
> - * ethnla_fill_header() - write standard ethtool request header to messa=
ge
> - * @msgbuff: message buffer
> - * @type:    attribute type for header nest
> - * @devname: device name (NULL to omit)
> - * @flags:   request flags (omitted if 0)
> - *
> - * Return: pointer to the nest attribute or null of error
> - */
> -bool ethnla_fill_header(struct nl_msg_buff *msgbuff, uint16_t type,
> -			const char *devname, uint32_t flags)
> +static bool __ethnla_fill_header_phy(struct nl_msg_buff *msgbuff, uint16=
_t type,
> +				     const char *devname, uint32_t phy_index,
> +				     uint32_t flags)
>  {
>  	struct nlattr *nest;
> =20
> @@ -159,7 +151,9 @@ bool ethnla_fill_header(struct nl_msg_buff *msgbuff, =
uint16_t type,
>  	if ((devname &&
>  	     ethnla_put_strz(msgbuff, ETHTOOL_A_HEADER_DEV_NAME, devname)) ||
>  	    (flags &&
> -	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_FLAGS, flags)))
> +	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_FLAGS, flags)) ||
> +	    (phy_index &&
> +	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_PHY_INDEX, phy_index)))
>  		goto err;
> =20
>  	ethnla_nest_end(msgbuff, nest);

Just to be sure: are we sure the PHY index cannot ever be zero (or that
we won't need to pass 0 index to kernel)?

Michal

--yavmk5fnem4h4s3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmbU5PEACgkQ538sG/LR
dpUe5wf9Hawb4p++EX53KxigjHOW0j3mvpwW1WENZmcgjALVHuedMpUYQQjKqKDB
9SpCWfLua4I+qlpInrR5FlnjOyCtQ1Re29HIeezhhkbAArPAGWSorLwmO36bjCIx
mihpb/VOQrYhSnqCTJumIurpCEp8PAIFHTgzCyCKiqBjV+snp6saXHCn+fPgkb9w
Jz3oRD9VRnrVhV6/lbwGynkVBokShbrrEYw3coCCfm2vv4J+9oQZihj+SZHwhKM5
35vSIy9OT3gBduOJsqm1Cm0OnBQOz121kRV7RqJnQb3zEXThRLf+HzC8+dzTzo0+
FN/fFZG3GdvAY2pM87DuvvXJrR6yuQ==
=wkXx
-----END PGP SIGNATURE-----

--yavmk5fnem4h4s3z--

