Return-Path: <netdev+bounces-233008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C07CC0AE4C
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 17:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154C53B119D
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CA723AE62;
	Sun, 26 Oct 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rd1eo4i5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NNB5cHAJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pWfK26dh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZJx/Y/d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495DA8F7D
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761497843; cv=none; b=FMleG3g8o3Czp8YFIOxcMN08p2S9qYJwd9wbK7L3dMRStraLkJ0s0VIDJrST3B0WKPoxeVWd2n/wn88ojhQkdWQZLoA8ov01fi2v2sYuf0+IS+aX0w7hiRq5W5S9N3D3VVLDI9KjbS70xT9wxZMKY22Gi/idsrJEhOZbNmHYDMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761497843; c=relaxed/simple;
	bh=3EUdY8Qy5tGBvj561GdZlfhm8BLI+Lnb8J62UNYQkCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6WENw334d1BpZnAJ4sOBNGHKKfdOYV3IbTzsXaQ7NreRabq0/s1yhingBq5fXMqZYJycozeYvUtDkB1G3fnywAc8CbrMqHOKFeKxkBO0fkTgRVNFcx+WRG7LtSKzR2y3SYFeaPTbzqCdiHHFZOmFJ7X6Tcks66EYsk/6UW2F8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rd1eo4i5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NNB5cHAJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pWfK26dh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZJx/Y/d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE910218D5;
	Sun, 26 Oct 2025 16:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761497833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kB/rs8X+HMHLL3O/JfwK3tkyxOMmnVN17ubjZsEEQo=;
	b=rd1eo4i56Vn7QQCOgnWbOvoDcLiP8JfFnOtgSC+6hWp+aX1EeLKPRmpykdjXlp8ZYv2FyT
	S45u6tzEnyXGA4IciUcVaAqOpN2YkJVS5Y3B+ApgfQa1d1uBGVAUKqmMVvQ9+bcnHd83Ix
	EGJ3yC8JCLhD7VNI6whUW1X94Kz3q58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761497833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kB/rs8X+HMHLL3O/JfwK3tkyxOMmnVN17ubjZsEEQo=;
	b=NNB5cHAJOpCCl2ghvhcOtrGBeC0LN9vPSEcJR//XJ3A+ofupqu4cGJSUmVITv5rJf8G/cv
	QTTUzunmNN4FuDDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761497832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kB/rs8X+HMHLL3O/JfwK3tkyxOMmnVN17ubjZsEEQo=;
	b=pWfK26dhY9M3oVibKEqt/4CtF2QBjciVyomOV7dLDEq9TBIm7mUvwx/3qAKAW+PsBf0E7c
	9WdFKslw1n9yktGoqOPSvqyM04sj9LB5OXlMr/brkV7nUe2idkadcBgT59QG+LYsXtfUJr
	/ptX2dLhajUwo5OzbD3f/ZiXYNm59Us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761497832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kB/rs8X+HMHLL3O/JfwK3tkyxOMmnVN17ubjZsEEQo=;
	b=SZJx/Y/ds8VLJB3SyDQL7B04hDV/3fLfPtnYWyoNFzHcqHIVKe1nlz5FodLfPuIt4bUdEj
	qT2vqD6kE+/DmMBQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id AEA3020057; Sun, 26 Oct 2025 17:57:12 +0100 (CET)
Date: Sun, 26 Oct 2025 17:57:12 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4v4jjwtlcvn5wfhr"
Content-Disposition: inline
In-Reply-To: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
X-Spamd-Result: default: False [-5.77 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.07)[-0.348];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email]
X-Spam-Flag: NO
X-Spam-Score: -5.77
X-Spam-Level: 


--4v4jjwtlcvn5wfhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 04, 2025 at 08:27:15PM GMT, Vadim Fedorenko wrote:
> The kernel supports configuring HW time stamping modes via netlink
> messages, but previous implementation added support for HW time stamping
> source configuration. Add support to configure TX/RX time stamping.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

As far as I can see, you only allow one bit to be set in each of=20
ETHTOOL_A_TSCONFIG_TX_TYPES and ETHTOOL_A_TSCONFIG_RX_FILTERS. If only
one bit is supposed to be set, why are they passed as bitmaps?
(The netlink interface only mirrors what (read-only) ioctl interface
did.)

Michal

> ---
>  ethtool.8.in       | 12 ++++++-
>  ethtool.c          |  1 +
>  netlink/tsconfig.c | 78 +++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 89 insertions(+), 2 deletions(-)
>=20
> diff --git a/ethtool.8.in b/ethtool.8.in
> index 553592b..e9eb2d7 100644
> --- a/ethtool.8.in
> +++ b/ethtool.8.in
> @@ -357,6 +357,10 @@ ethtool \- query or control network driver and hardw=
are settings
>  .IR N
>  .BI qualifier
>  .IR precise|approx ]
> +.RB [ tx
> +.IR TX-TYPE ]
> +.RB [ rx-filter
> +.IR RX-FILTER ]
>  .HP
>  .B ethtool \-x|\-\-show\-rxfh\-indir|\-\-show\-rxfh
>  .I devname
> @@ -1286,7 +1290,7 @@ for IEEE 1588 quality and "approx" is for NICs DMA =
point.
>  Show the selected time stamping PTP hardware clock configuration.
>  .TP
>  .B \-\-set\-hwtimestamp\-cfg
> -Select the device's time stamping PTP hardware clock.
> +Sets the device's time stamping PTP hardware clock configuration.
>  .RS 4
>  .TP
>  .BI index \ N
> @@ -1295,6 +1299,12 @@ Index of the ptp hardware clock
>  .BI qualifier \ precise | approx
>  Qualifier of the ptp hardware clock. Mainly "precise" the default one is
>  for IEEE 1588 quality and "approx" is for NICs DMA point.
> +.TP
> +.BI tx \ TX-TYPE
> +Type of TX time stamping to configure
> +.TP
> +.BI rx-filter \ RX-FILTER
> +Type of RX time stamping filter to configure
>  .RE
>  .TP
>  .B \-x \-\-show\-rxfh\-indir \-\-show\-rxfh
> diff --git a/ethtool.c b/ethtool.c
> index 948d551..2e03b74 100644
> --- a/ethtool.c
> +++ b/ethtool.c
> @@ -6063,6 +6063,7 @@ static const struct option args[] =3D {
>  		.nlfunc	=3D nl_stsconfig,
>  		.help	=3D "Select hardware time stamping",
>  		.xhelp	=3D "		[ index N qualifier precise|approx ]\n"
> +			  "		[ tx TX-TYPE ] [ rx-filter RX-FILTER ]\n"
>  	},
>  	{
>  		.opts	=3D "-x|--show-rxfh-indir|--show-rxfh",
> diff --git a/netlink/tsconfig.c b/netlink/tsconfig.c
> index d427c7b..7dee4d1 100644
> --- a/netlink/tsconfig.c
> +++ b/netlink/tsconfig.c
> @@ -17,6 +17,7 @@
>  #include "netlink.h"
>  #include "bitset.h"
>  #include "parser.h"
> +#include "strset.h"
>  #include "ts.h"
> =20
>  /* TSCONFIG_GET */
> @@ -94,6 +95,67 @@ int nl_gtsconfig(struct cmd_context *ctx)
> =20
>  /* TSCONFIG_SET */
> =20
> +int tsconfig_txrx_parser(struct nl_context *nlctx, uint16_t type,
> +			 const void *data __maybe_unused,
> +			 struct nl_msg_buff *msgbuff,
> +			 void *dest __maybe_unused)
> +{
> +	const struct stringset *values;
> +	const char *arg =3D *nlctx->argp;
> +	unsigned int count, i;
> +
> +	nlctx->argp++;
> +	nlctx->argc--;
> +	if (netlink_init_ethnl2_socket(nlctx) < 0)
> +		return -EIO;
> +
> +	switch (type) {
> +	case ETHTOOL_A_TSCONFIG_TX_TYPES:
> +		values =3D global_stringset(ETH_SS_TS_TX_TYPES, nlctx->ethnl2_socket);
> +		break;
> +	case ETHTOOL_A_TSCONFIG_RX_FILTERS:
> +		values =3D global_stringset(ETH_SS_TS_RX_FILTERS, nlctx->ethnl2_socket=
);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	count =3D get_count(values);
> +	for (i =3D 0; i < count; i++) {
> +		const char *name =3D get_string(values, i);
> +
> +		if (!strcmp(name, arg))
> +			break;
> +	}
> +
> +	if (i !=3D count) {
> +		struct nlattr *bits_attr, *bit_attr;
> +
> +		if (ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_NOMASK, true))
> +			return -EMSGSIZE;
> +
> +		bits_attr =3D ethnla_nest_start(msgbuff, ETHTOOL_A_BITSET_BITS);
> +		if (!bits_attr)
> +			return -EMSGSIZE;
> +
> +		bit_attr =3D ethnla_nest_start(msgbuff, ETHTOOL_A_BITSET_BITS_BIT);
> +		if (!bit_attr) {
> +			ethnla_nest_cancel(msgbuff, bits_attr);
> +			return -EMSGSIZE;
> +		}
> +		if (ethnla_put_u32(msgbuff, ETHTOOL_A_BITSET_BIT_INDEX, i) ||
> +		    ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_BIT_VALUE, true)) {
> +			ethnla_nest_cancel(msgbuff, bits_attr);
> +			ethnla_nest_cancel(msgbuff, bit_attr);
> +			return -EMSGSIZE;
> +		}
> +		mnl_attr_nest_end(msgbuff->nlhdr, bit_attr);
> +		mnl_attr_nest_end(msgbuff->nlhdr, bits_attr);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>  static const struct param_parser stsconfig_params[] =3D {
>  	{
>  		.arg		=3D "index",
> @@ -109,6 +171,20 @@ static const struct param_parser stsconfig_params[] =
=3D {
>  		.handler	=3D tsinfo_qualifier_parser,
>  		.min_argc	=3D 1,
>  	},
> +	{
> +		.arg		=3D "tx",
> +		.type		=3D ETHTOOL_A_TSCONFIG_TX_TYPES,
> +		.handler	=3D tsconfig_txrx_parser,
> +		.group		=3D ETHTOOL_A_TSCONFIG_TX_TYPES,
> +		.min_argc	=3D 1,
> +	},
> +	{
> +		.arg		=3D "rx-filter",
> +		.type		=3D ETHTOOL_A_TSCONFIG_RX_FILTERS,
> +		.handler	=3D tsconfig_txrx_parser,
> +		.group		=3D ETHTOOL_A_TSCONFIG_RX_FILTERS,
> +		.min_argc	=3D 1,
> +	},
>  	{}
>  };
> =20
> @@ -134,7 +210,7 @@ int nl_stsconfig(struct cmd_context *ctx)
>  	if (ret < 0)
>  		return ret;
>  	if (ethnla_fill_header(msgbuff, ETHTOOL_A_TSCONFIG_HEADER,
> -			       ctx->devname, 0))
> +			       ctx->devname, ETHTOOL_FLAG_COMPACT_BITSETS))
>  		return -EMSGSIZE;
> =20
>  	ret =3D nl_parser(nlctx, stsconfig_params, NULL, PARSER_GROUP_NEST, NUL=
L);
> --=20
> 2.47.3
>=20

--4v4jjwtlcvn5wfhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmj+UuQACgkQ538sG/LR
dpVnqQf0CEPfvFWqTwabf/XW8myPwzlrM5p/jxbFxz0HfuKJGO34BUS5RYIAim9/
6OZ2MXJdA1yhiXB/ePEEgnKhQWVW4Uwei4DU4SX7uwMyV6sNPdqOwjGxJlmtF53s
z8pYBfvsrgWFQ65P3Jylmv5WvG6wHMaNbcZRd4QLjK+T3RQ1IpeyWDw+EonTGslV
hJb3NPZFNzv8O9oEx6axebyQvAMJpTi06BIU5NgkCvnuaGQ51ZlEzY11s7xEQKT/
YNzQCxAP/JLyFqcfRRgeZOWQpvJ5Jf403GLAQCvLBHlH7x5qaDVe2ePmKWJ1Tgwj
EZl9XFpKnKUxrXhWjj8Mtisw7Vn3
=c/X+
-----END PGP SIGNATURE-----

--4v4jjwtlcvn5wfhr--

