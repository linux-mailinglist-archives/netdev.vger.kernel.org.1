Return-Path: <netdev+bounces-141323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3779BA796
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61912B21131
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B81885AF;
	Sun,  3 Nov 2024 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="E6051eCj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7116EB5D;
	Sun,  3 Nov 2024 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730661011; cv=none; b=ARo4mTh3hvSSyXJ8tfks34QI26RVlRKHS8yA3sFz2cpCGrS5Dt1sg5ZQ0iiRKnRwx9LfL5+NKdJr5VqEAVQPWN9HmuteY2ucj/mCKibfFQfoZYkqZSTBC1S/DDPy1GjR0drefI4mOopRCu0glEUDSrwVjKZT2VSJTXS6CtfXcdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730661011; c=relaxed/simple;
	bh=Fmtcg7gHbp2eod0PRstGOm9fCcRs2KDhLE3Cotx5ruI=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oH1UBKwYhcGQeqOEL7X9idg1bztQMOJ25CMA+QRRDGnBMc+nhU60H1gK0/GZe8zyYFTyC6M+UP6VASP4WpIsfY8J+EAy0y6gBX4KAQW0MsRhSfpClAqTR++hc1pzMlGH5RT6g6UjgkT6SM7tFfXYbZtcofxAJjiV51BJ1stHyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=E6051eCj; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730661009; x=1762197009;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=ilmu7TW6wuGdFt7Ze70JteGywNkZc5EQwC9NJ9T/MN4=;
  b=E6051eCjNKo+gupboBkcvtRpvrZV8bcD6AUbmREMoKKsoxGwHtNri0Wx
   vr3DKiHq/WkcZRXUbP+4wFquYwJUngQuNz9JzBmwqx6vs9kCjPiQ23t8z
   lMzxGNnRDNojYkHxgJCMJ34lCvlgFuR3zAAKJd5BmcquoQZPRt2JoYg6g
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,255,1725321600"; 
   d="scan'208";a="144027567"
Subject: RE: [PATCH net-next] net: ena: Remove deadcode
Thread-Topic: [PATCH net-next] net: ena: Remove deadcode
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:10:07 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:14604]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.47.120:2525] with esmtp (Farcaster)
 id d5157aae-b8fb-4ec0-8df8-273d0571e847; Sun, 3 Nov 2024 19:10:06 +0000 (UTC)
X-Farcaster-Flow-ID: d5157aae-b8fb-4ec0-8df8-273d0571e847
Received: from EX19D017EUA001.ant.amazon.com (10.252.50.71) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 3 Nov 2024 19:10:05 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D017EUA001.ant.amazon.com (10.252.50.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 3 Nov 2024 19:10:05 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Sun, 3 Nov 2024 19:10:05 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: "linux@treblig.org" <linux@treblig.org>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan,
 Noam" <ndagan@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Index: AQHbLXLgvL+qB884I0GFZVN0vD/JqrKl7Dfg
Date: Sun, 3 Nov 2024 19:10:05 +0000
Message-ID: <8c44053e6a1948688f347ae61c977eea@amazon.com>
References: <20241102220142.80285-1-linux@treblig.org>
In-Reply-To: <20241102220142.80285-1-linux@treblig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> ena_com_get_dev_basic_stats() has been unused since 2017's commit
> d81db2405613 ("net/ena: refactor ena_get_stats64 to be atomic context
> safe")
>=20
> ena_com_get_offload_settings() has been unused since the original commit
> of ENA back in 2016 in commit 1738cd3ed342 ("net: ena: Add a driver for
> Amazon Elastic Network Adapters (ENA)")
>=20
> Remove them.
>=20
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/net/ethernet/amazon/ena/ena_com.c | 33 -----------------------
> drivers/net/ethernet/amazon/ena/ena_com.h | 18 -------------
>  2 files changed, 51 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c
> b/drivers/net/ethernet/amazon/ena/ena_com.c
> index d958cda9e58b..bc23b8fa7a37 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -2198,21 +2198,6 @@ int ena_com_get_ena_srd_info(struct
> ena_com_dev *ena_dev,
>         return ret;
>  }
>=20
> -int ena_com_get_dev_basic_stats(struct ena_com_dev *ena_dev,
> -                               struct ena_admin_basic_stats *stats)
> -{
> -       struct ena_com_stats_ctx ctx;
> -       int ret;
> -
> -       memset(&ctx, 0x0, sizeof(ctx));
> -       ret =3D ena_get_dev_stats(ena_dev, &ctx,
> ENA_ADMIN_GET_STATS_TYPE_BASIC);
> -       if (likely(ret =3D=3D 0))
> -               memcpy(stats, &ctx.get_resp.u.basic_stats,
> -                      sizeof(ctx.get_resp.u.basic_stats));
> -
> -       return ret;
> -}
> -
>  int ena_com_get_customer_metrics(struct ena_com_dev *ena_dev, char
> *buffer, u32 len)  {
>         struct ena_admin_aq_get_stats_cmd *get_cmd; @@ -2289,24 +2274,6
> @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
>         return ret;
>  }
>=20
> -int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
> -                                struct ena_admin_feature_offload_desc *o=
ffload)
> -{
> -       int ret;
> -       struct ena_admin_get_feat_resp resp;
> -
> -       ret =3D ena_com_get_feature(ena_dev, &resp,
> -                                 ENA_ADMIN_STATELESS_OFFLOAD_CONFIG, 0);
> -       if (unlikely(ret)) {
> -               netdev_err(ena_dev->net_device, "Failed to get offload ca=
pabilities
> %d\n", ret);
> -               return ret;
> -       }
> -
> -       memcpy(offload, &resp.u.offload, sizeof(resp.u.offload));
> -
> -       return 0;
> -}
> -
>  int ena_com_set_hash_function(struct ena_com_dev *ena_dev)  {
>         struct ena_com_admin_queue *admin_queue =3D &ena_dev-
> >admin_queue; diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h
> b/drivers/net/ethernet/amazon/ena/ena_com.h
> index a372c5e768a7..20e1529adf3b 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.h
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.h
> @@ -591,15 +591,6 @@ int ena_com_set_aenq_config(struct ena_com_dev
> *ena_dev, u32 groups_flag);  int ena_com_get_dev_attr_feat(struct
> ena_com_dev *ena_dev,
>                               struct ena_com_dev_get_features_ctx *get_fe=
at_ctx);
>=20
> -/* ena_com_get_dev_basic_stats - Get device basic statistics
> - * @ena_dev: ENA communication layer struct
> - * @stats: stats return value
> - *
> - * @return: 0 on Success and negative value otherwise.
> - */
> -int ena_com_get_dev_basic_stats(struct ena_com_dev *ena_dev,
> -                               struct ena_admin_basic_stats *stats);
> -
>  /* ena_com_get_eni_stats - Get extended network interface statistics
>   * @ena_dev: ENA communication layer struct
>   * @stats: stats return value
> @@ -635,15 +626,6 @@ int ena_com_get_customer_metrics(struct
> ena_com_dev *ena_dev, char *buffer, u32
>   */
>  int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu);
>=20
> -/* ena_com_get_offload_settings - Retrieve the device offloads capabilit=
ies
> - * @ena_dev: ENA communication layer struct
> - * @offlad: offload return value
> - *
> - * @return: 0 on Success and negative value otherwise.
> - */
> -int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
> -                                struct ena_admin_feature_offload_desc *o=
ffload);
> -
>  /* ena_com_rss_init - Init RSS
>   * @ena_dev: ENA communication layer struct
>   * @log_size: indirection log size
> --
> 2.47.0

LGTM, thanks for making the effort and removing this from the driver.

Reviewed-by: David Arinzon <darinzon@amazon.com>

