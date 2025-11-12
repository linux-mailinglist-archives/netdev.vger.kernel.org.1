Return-Path: <netdev+bounces-237885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A0C51311
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B693B9ADF
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D422FD7B4;
	Wed, 12 Nov 2025 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1scivq4Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B42FCC17
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937336; cv=none; b=oWPs0S/DPfXV5GgOQFxUm8TQ+eWR1CR+uf5PGb3DVMzBIqZKlUN5t8xByvdvKWRppFGl2rzBm28U1sFNcD6j+Ok45U97OYA7XPa9mcIKFQZsft/PH/1pb/BuXuKfNPVqB5pgsZ+SeZL8ftmyefvS1JhGIl/hILE8NZ3NYFvYOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937336; c=relaxed/simple;
	bh=9hm7oVB//69sbX4ylo7VEiAxJGzKb/9z2QUVOrDfxBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrRa4cWdRIUHgdirEeWkR9jIsCOyJyV/JsDGBb31bYwVUmTIXPKNQLBrE2skwsjKeHQJJKuKH3qLd1RGVZbTas7eDz8VUpgqWIfMTtFMACs+HmV6BKTxKVNnunyByGhLdbhRvDj0sWv4KfqVUxF05cHr1h7uN47iXd4HMwQWA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1scivq4Q; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3470EC0F55A;
	Wed, 12 Nov 2025 08:48:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C74F16070B;
	Wed, 12 Nov 2025 08:48:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57E8410371975;
	Wed, 12 Nov 2025 09:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762937331; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jwo/N9BzHpnpqYG8V/87Z/FfjGQu/D2v7z5e7HU1lAA=;
	b=1scivq4Q6NFwkcVW5ZtHooFgj5DV7xqCOrfGxsbhQlkQqtBWB86Hbbfanea+bHtGagob4U
	PMVGRdhRcZpy6wQVUkCRWvXS+t/MLWo1gqVIwifE1DBWke/lLiaiFr6cGQ5rZI1J0x2tCx
	GsP7KqdcbQQ3pGhiPX1RATeTvDpzRHjsOm+eycOVABoFk0XSFeayN+iOXazYIHQnTxqkfF
	Ip3Hgo29cTsIEDAiWt+guzllVhB3s7jGdsvAeBHSXXsCtDZhyJmuL7UNMo0yDh7ZUGh6Ff
	mtYmomv9+PizeYfSveLfDqrXdLhCR4ohDXwUvMS5vWdrQyoOnSXKQuLU4F0cGg==
Date: Wed, 12 Nov 2025 09:48:49 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next v3] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <20251112094849.23b344af@kmaincent-XPS-13-7390>
In-Reply-To: <20251107182044.3545092-1-vadim.fedorenko@linux.dev>
References: <20251107182044.3545092-1-vadim.fedorenko@linux.dev>
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

On Fri,  7 Nov 2025 18:20:44 +0000
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
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> v2 -> v3:
> * improve code style
> v1 -> v2:
> * improve commit message
> ---
>  ethtool.8.in       | 12 +++++++-
>  ethtool.c          |  1 +
>  netlink/tsconfig.c | 77 +++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 88 insertions(+), 2 deletions(-)
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
> index d427c7b..f4ed10e 100644
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
> @@ -94,6 +95,66 @@ int nl_gtsconfig(struct cmd_context *ctx)
> =20
>  /* TSCONFIG_SET */
> =20
> +int tsconfig_txrx_parser(struct nl_context *nlctx, uint16_t type,
> +			 const void *data __maybe_unused,
> +			 struct nl_msg_buff *msgbuff,
> +			 void *dest __maybe_unused)
> +{
> +	struct nlattr *bits_attr, *bit_attr;
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
> +	if (i !=3D count)
> +		return -EINVAL;

It seems you update your patch too quickly and don't test it.
It should be "if (i =3D=3D count)" here.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

