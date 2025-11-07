Return-Path: <netdev+bounces-236712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74654C3F3D4
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 10:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA6D3A9277
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 09:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B221CC56;
	Fri,  7 Nov 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="emHV+ecR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2B2D8792
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508778; cv=none; b=hto6sa+iYJr5Bs8LsSnLPvScP2TRvdXy1JVQk17sZMLfxz7UwqfzpR4PfUsIw7q8+Rl1sLeo0uzLJZrhbrVvHSiVJlK4huEPeFAnd4fhLagXuPmyjeaRlIPAbs8NGnrrE9a3IzX1z07FTcv0orpvr1vTZ+H5e9cxM1PW+YQMzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508778; c=relaxed/simple;
	bh=CUb1UJSqe0J7eiFVk9FclskMnkcpr7t9CwNggoZDnJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feP23CJJMYI9TeaLR+9PwbNAsW70ClOcgArtYxc3d5pb+5AkR1UsGRLM1ur3r2vbiNQ3dQZpYHNpC0KaJzIGgEhcu6j4yAuVgteRBL99EikzQl2RzKRmutV6v22iJJ15xgQBVsbls0/O4tDWZo7O6x+1aYrt8u+ByOfk3J/AZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=emHV+ecR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A2E4F1A191C;
	Fri,  7 Nov 2025 09:46:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78B73606A6;
	Fri,  7 Nov 2025 09:46:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7E6E11851F88;
	Fri,  7 Nov 2025 10:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762508766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pejro6m8PvIgGo9bZixg+NiOc0vkGtgoLl3JZUg3MuE=;
	b=emHV+ecRkjSsv4LJWGCoeb+ZECWxYFYjOugu1GQE7hcHEI3cuPIXxLabOlZUltVyDm4LY4
	OsySXGF105CMQsw/N/f3r70MGdBGseIAhVW2br8P644HV5/BfVV2myVJZWlGcI3MVkixoj
	P3xpl09cK0su04xHPkhNfsJVDqPaTg6+Ypcz0axtTRSVNd7jqF/w95+RsG3eEGdlOuyJHh
	/bfsOci3/JVIeO2tA3I/GAgXu9xOjbwOhl+Fq8EktW4aDeVFF2Ad3mTzrPbnSRfj8OdcdT
	HsPvSJ+wrzEXbb29RDNY+0eAf5v416YlMWsY84Hi/YdlI9eklpjprk2GuQNf4Q==
Date: Fri, 7 Nov 2025 10:46:02 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next v2] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <20251107104602.69e2607f@kmaincent-XPS-13-7390>
In-Reply-To: <20251105192453.3542275-1-vadim.fedorenko@linux.dev>
References: <20251105192453.3542275-1-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed,  5 Nov 2025 19:24:53 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The kernel supports configuring HW time stamping modes via netlink
> messages, but previous implementation added support for HW time stamping
> source configuration. Add support to configure TX/RX time stamping.
> We keep TX type and RX filter configuration as a bit value, but if we
> will need multibit value to be set in the future, there is an option to
> use "rx-filters" keyword which will be mutually exclusive with current
> "rx-filter" keyword. The same applies to "tx-type".
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  ethtool.8.in       | 12 ++++++-
>  ethtool.c          |  1 +
>  netlink/tsconfig.c | 78 +++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 89 insertions(+), 2 deletions(-)
>=20
> diff --git a/ethtool.8.in b/ethtool.8.in
> index 8874ade..1788588 100644
> --- a/ethtool.8.in
> +++ b/ethtool.8.in
> @@ -357,6 +357,10 @@ ethtool \- query or control network driver and hardw=
are
> settings .IR N
>  .BI qualifier
>  .IR precise|approx ]
> +.RB [ tx
> +.IR TX-TYPE ]
> +.RB [ rx-filter
> +.IR RX-FILTER ]
>  .HP
>  .B ethtool \-x|\-\-show\-rxfh\-indir|\-\-show\-rxfh
>  .I devname
> @@ -1287,7 +1291,7 @@ for IEEE 1588 quality and "approx" is for NICs DMA
> point. Show the selected time stamping PTP hardware clock configuration.
>  .TP
>  .B \-\-set\-hwtimestamp\-cfg
> -Select the device's time stamping PTP hardware clock.
> +Sets the device's time stamping PTP hardware clock configuration.
>  .RS 4
>  .TP
>  .BI index \ N
> @@ -1296,6 +1300,12 @@ Index of the ptp hardware clock
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
> index bd45b9e..521e6fe 100644
> --- a/ethtool.c
> +++ b/ethtool.c
> @@ -6068,6 +6068,7 @@ static const struct option args[] =3D {
>  		.nlfunc	=3D nl_stsconfig,
>  		.help	=3D "Select hardware time stamping",
>  		.xhelp	=3D "		[ index N qualifier
> precise|approx ]\n"
> +			  "		[ tx TX-TYPE ] [ rx-filter
> RX-FILTER ]\n" },
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
> +		values =3D global_stringset(ETH_SS_TS_TX_TYPES,
> nlctx->ethnl2_socket);
> +		break;
> +	case ETHTOOL_A_TSCONFIG_RX_FILTERS:
> +		values =3D global_stringset(ETH_SS_TS_RX_FILTERS,
> nlctx->ethnl2_socket);
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

It would be nicer to have a small if instead of the big one:
if (i =3D=3D count)
	return -EINVAL;

With that change:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> +		struct nlattr *bits_attr, *bit_attr;
> +
> +		if (ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_NOMASK, true))
> +			return -EMSGSIZE;
> +
> +		bits_attr =3D ethnla_nest_start(msgbuff,
> ETHTOOL_A_BITSET_BITS);
> +		if (!bits_attr)
> +			return -EMSGSIZE;
> +
> +		bit_attr =3D ethnla_nest_start(msgbuff,
> ETHTOOL_A_BITSET_BITS_BIT);
> +		if (!bit_attr) {
> +			ethnla_nest_cancel(msgbuff, bits_attr);
> +			return -EMSGSIZE;
> +		}
> +		if (ethnla_put_u32(msgbuff, ETHTOOL_A_BITSET_BIT_INDEX, i) ||
> +		    ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_BIT_VALUE,
> true)) {
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
>  	ret =3D nl_parser(nlctx, stsconfig_params, NULL, PARSER_GROUP_NEST,
> NULL);



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

