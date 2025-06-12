Return-Path: <netdev+bounces-196932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD27AD6F9B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1737A548E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACA422D7AA;
	Thu, 12 Jun 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TG5f4AxL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F5227EA7
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729397; cv=fail; b=XJRy8yLuDcyTt5m777s1ZkjwHdNhg2by7mrUpl94jVlHOBaxtQY6F9kDuoypeTQjSBtv1zKBSQBEcmGtzSZRtsLt4MB/Z8itm4UB86xa2Dr9j3dYHy9ZABOsmoXwlhKOX4mNpCtUEVr2H3u4uAoniVSNXLgRNEAyRJOS+IEoejU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729397; c=relaxed/simple;
	bh=tNfqMt3mClCnZX5vWGmECHxZ49HLI4BAqsVMZQpx3v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WzW9jxpFJuUQqOE3bhbc5goP+3yeVj273bF/kjNgIvGEmFK9MvJ6e3yJvSJ8sJprctJVWzSAvJG3zyhjAAvxX3eNJm/kPKqBZWtK2kAntjT6Rt4gOukw8yKs8mlM/kSOZUSsZd4ocRBhsRkyTtt1PaIN9wrK0lKjgd4jnLlWqhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TG5f4AxL; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCuCMaOSxszx5xKhImY/MG22b00Z7pfIV9oOdLbtNLj7NLIWXzxIkutyY3JFVxXUoeIt+OpxU/H9MFqO6e5pEw820KMm16B80rXaqZSDorScFZXq1uC+9huFXlI5vRrrlH8DaeIGR06x+rNQWx1lEEBUXhaIIsMtIDluw4ZRWs1odW4hjxR2Uu76taIdE0YtX8Tfnh7R5BCBuCXZZWJ5en7jreBG5UOCTCsvKHPmydP946pnkJRkO1LJLpnz4cXAajDxoOS960mLMsCkTSOE6W2sMwvUhsYbqnOriIurv4eHxqkkawOKUaP3rzcXXFxClWSklN1HLIlN7EGFFWvPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBzCTgetQs8O5UPcuAVOHijqO0uvLaCG6ZNkDbwTlng=;
 b=xqAp27dMREFWFMVCFv8pcZ9uJ+SFoGqRegPg8bdkDJ/nBRlLMLrpNcasqOz+MSxJ3fKBQdCRKjE6LvRKxpQcMbNVtqpgMb01hBBG3b7iH5J+iiPLPmtSoZVuASFj29qoOCvprmX8sxIbODw07dA1b/nOhvgf70jzuArQVGdpmh0hrD3fhrQgUh9un9MiL2OEcwWFB8rF4/i68eq8sQHyMHzB6rQLv/UjYTpsuWT4k6w1vseRIODCSusie5Nnj+FI8aaBBWa5p3ZEOdefIVK56x2lJzxh6aBbtqmW2xPY1zNIM3ghaEpDYxpQHL+r9uFvB1Q5eoApSWuDAvv0EP0sZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBzCTgetQs8O5UPcuAVOHijqO0uvLaCG6ZNkDbwTlng=;
 b=TG5f4AxLQ9W2VyGHkdnTowLC5NlbmwdhjyOLyaKAoZm+9sp4Vx7pamKv1aiNQzcPlA5ScLqmNwGvsMdBdShL5zd5MaJoiE4+qGBvAK9idaLZ4Fayar9AV14k+sWPrjipk1fAvXR5qOVn0CfGQ+O9Wvk6FH8Q2QyZrE2UczQyvfxZ4HI4I2rm3cXOeS57rh4NNrwTPc60bJ+bJsqD3hrs/ceKIMAagUHjQMkuY5RH2wY8FtnNf2dWUz5oBW9Bn6T0EaVZc0ANXiGxPfMizuGNiMVGslW90VGpVeatO/ceQ3nY8+6v2A6B0SOe4AD5KO92LCcFngrPZXgA61JEWzP7BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.22; Thu, 12 Jun 2025 11:56:33 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 11:56:33 +0000
Date: Thu, 12 Jun 2025 11:56:26 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, sdf@fomichev.me, 
	almasrymina@google.com, dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com, 
	jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <5nar53qzx3oyphylkiv727rnny7cdu5qlvgyybl2smopa6krb4@jzdm3jr22zkc>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-20-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-20-kuba@kernel.org>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aee9c4d-1a0f-4216-bc1f-08dda9a82cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p9ubwPenFVVoj8REq4+jkI7QRdqCIciu6fXnUb1HDW4YwsdrldwczIWWsThQ?=
 =?us-ascii?Q?g7GA+bfPJeEDlRYQjKqz9nsLlVyTX0atLRdfbMdZGpvWiGq6JltWeoEhzxuK?=
 =?us-ascii?Q?slSfVtIoXABAqDTH9uTtMvOS8NFEBerzwKJqPlew12usJSVlxy173SivDsGQ?=
 =?us-ascii?Q?NENSy1mZJZRYFvh9wCZr+TM5mDHu7EbnaTV50Kd9ZKbT5Fu5XlICNtomGnKT?=
 =?us-ascii?Q?WCZvSHu7e8nhQ71Ecs0VApvp6OxfX0Xdw+RqH+1Z2iwrt0a3lj6qcbIbEF3C?=
 =?us-ascii?Q?cXPKEGWreVVyUb4FQqoE9qzLZ/Drju4OgToierrLZJLdrBWf56yHaZtk7i0s?=
 =?us-ascii?Q?O9U3DV3bkJEgBqkIozn8oRltJCVCYFO1tZ/mP2iwzwAxaaQlwydgEVPt8Pvm?=
 =?us-ascii?Q?+qPxJbOxoJTphIiV/X0f0dp0KXhvBF0CuzuDSl4MTIhZW876j9KmhXPrGr78?=
 =?us-ascii?Q?ru3aKWpPcA1hu8WDsRsGrKxdgpGAF8JrDgtMVBiHNROwjys8GsNQT9C3B92C?=
 =?us-ascii?Q?JZt8Alh0teR7abtTOUUMTPmV1MdU3NdaWZNZTr/QOTtfgR+21ZBJidtNOsHh?=
 =?us-ascii?Q?FhHF/EyHqhu5/t/deM2CRPYTHrH7ZRN2aGIN4l1OBqqxgtzHmLlMr+i7v4mT?=
 =?us-ascii?Q?kWqb7wgwyZ7CLQRXUI4cw3OiKwDPGOVPtA97nJyccCokjB5vpUqknazoP6Kz?=
 =?us-ascii?Q?gzRjeM1nARRUlsfLOIToL56bJfDNT5hqbKrKbHAwi7sVD1K4HwovYa66tRLD?=
 =?us-ascii?Q?D09r3P3rCJ0QBw3hs3bNKWCxBoldx0V9L25Ec4+7YvRA+uVDHSiTijC5jT4v?=
 =?us-ascii?Q?6eQ6hbVu7me77qwXJifPhbNPy6YaELPf8EGIundlXnOUQqmp4evCzK3iLi9L?=
 =?us-ascii?Q?SifpfhoLTO3RahcMPVRiihkpYz1bRX9vZNXn99bFA42275fR2tn1dOqiUMyy?=
 =?us-ascii?Q?mlorEH8D30ewDlt5NYQ7D1gbLqDeKyYoHSuf1pN/5ghgvZgcheNDYzEo+Jv7?=
 =?us-ascii?Q?JWQW0K4KvtxlJbOJQJRD+oYSGMMxWtholPQ9AL7M3Prl8NEyxaOmUJftPLGS?=
 =?us-ascii?Q?4t/BsLdZmKhp7EQk3fH6BnKyFQ4RiEmkfc8HvPi+bDxkc1gLU3d2R1SkFsuH?=
 =?us-ascii?Q?2eVo3YTJv/V2MjrCicbnukZeaMvnWIBcTlEuZjhzqSzwiQHSMe/gPyPDuc1U?=
 =?us-ascii?Q?2eJnXNs4ayA3WSk5ZexOTH3AQY+VByL33fPLnW0CV2ZqPI3IcKgQsXsUt5T8?=
 =?us-ascii?Q?PqYn1DnEsRvR3g58DtrAu93Q+ebN2sKsRglK2p0t597wlVlUGkIRr91VURiX?=
 =?us-ascii?Q?kKTxGdJLt5YaVk3PlO31yTqEmiyjKgMb/h+3BL+K6fJVgQGpC5pMihzEdZSI?=
 =?us-ascii?Q?pXL7z1BnvKmTWQy0yt6JL0CfHnWJ+CWOmsHraLbUC33e3l1AHbHpETFGig6Z?=
 =?us-ascii?Q?qSgEmCjQUms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qDXQyPwi/trkdiuwFRZiQX6sc09w7zQKSUn6l0/6YReiPJl5M1ycEpTmyIop?=
 =?us-ascii?Q?zDjn+yEK9ZC2vRdyOPas+M6bUYysIJ4O4PgW+5Kd+HiSSgLCKOIxtsfQWB4v?=
 =?us-ascii?Q?eIoetGFcufxYpPAayp3kyYspzSFPuwgdA+lM//v6tyQ1owHnvzBUbnZnp6/C?=
 =?us-ascii?Q?odyGmtD3ufXzSiozRZL+z0I5CqSDY/ZhFoPdG1juFlBv9mRfDIM+nzpYa1+B?=
 =?us-ascii?Q?soneXeJi0zTP82YIm+aPP8hnGPifuW5gTV/fjM3siy8T/MUeEBgWPggZ7pIG?=
 =?us-ascii?Q?R62cadBZS/yo3cm38gtq4U0lVKaOLjSVj4scNTfu2ElUD/xpaBtK/pJqYEvq?=
 =?us-ascii?Q?jAUoMVjdZTB7KL21YIZoX3uDa4gRJI+vmfWM48TviZZ13RKKrtlTR5qJgWoL?=
 =?us-ascii?Q?4Lg4g1/h+7tup09+FsGNk8dfgViJ1LRAna6vEAbwTu+pG3WbReLQCdohnnaA?=
 =?us-ascii?Q?m042lHd6ryHsRWB3JeZncrw7c8eS0HHcN03Qy7pl98e4UEt3gts1cnoB0vHM?=
 =?us-ascii?Q?IWwu0P2ISFRVOVpAjjd/ttVuKkvpctmQXKsqNZHv+0a3SEfFhGVf+E1yKzj4?=
 =?us-ascii?Q?oAzuS712/OJB5di+Yo081XaAyrxRJI9JcUqTewejrafm/hnn1uDLHdc1GyyK?=
 =?us-ascii?Q?AA5m5kqgsMimiih+TRnm0wTdJRqNK2TMGQRxq0BVx9HePkZ7hQrbozCDaXKW?=
 =?us-ascii?Q?cKdXz288DPS/Vf0nLDKrJc4BQadXIwnIJfxGSuIhaBmiyAKWHudMDjNbFT4+?=
 =?us-ascii?Q?IBNbvyrhdvzEOe7G+fQIutljW7piIfy90wkvP70Ayn6VlPfI+TDBectqx2Jn?=
 =?us-ascii?Q?MSK+ZA8WafDSAjDnPuVk+r67L9bHd02vdpiGHvBqei1G7AslHugCVLezyNRc?=
 =?us-ascii?Q?1AM59SkSvP9F3EkvFRQ/qhEyhHJF1NiSrwd060batuehIfVwEdPm0vS2gZzx?=
 =?us-ascii?Q?uf6B4rsyFjjhbekaDStsZR66XBJiCnw93tNdopZUP1BN7lBg/2D2QymijBZM?=
 =?us-ascii?Q?QrBJHbsBEjRV1+JFKw1CVr8mub4j+ccDnCzTyK/vKWxb9670jfiKhxx9Nwpy?=
 =?us-ascii?Q?pZoCW0hebk6iQL6zwChU/NZVLMIHkVA2hiJJLeODUuo1cawAM3pcNlrKVjxh?=
 =?us-ascii?Q?O9QnhcoO9tk37qCx2GevPG/Th8LRIavi6kw/FYHS6XbXIxKNpSSKgYR0HvTn?=
 =?us-ascii?Q?RBooCuV/uFOJPYFXK1BuupwxIhZdZb9AyVziCoJ/6rrzvcoPRDbdvmYIMcBl?=
 =?us-ascii?Q?Xbyrks//xr+VIgegLmSmcL/af3M9EuX543GYuT+zFIkJTOJYriVvDcq1uWI/?=
 =?us-ascii?Q?1Yp+gVTH6PyCGo8pLGvYdpz7D4PiQ1WGwRH5cv5bhedavmcB0j4rdWBeRpfm?=
 =?us-ascii?Q?CRGdekupRlgWgozK1EHA2OgVIbVgqB05a3dn1I3Ho7AHC6votU0Mz8UOr+yx?=
 =?us-ascii?Q?kExMpAJehzylnO6ZYVnAF3DCIIQfObISzJpgOxK+yas0maUha2kBBve77A9W?=
 =?us-ascii?Q?Thrm95It2eB3xweJPu/3oebXQlLBIZG0v0CYRwoQGxh0FnRyC7sKAt9wUVAl?=
 =?us-ascii?Q?QEkMkNYIcxH8SzXcvkS+ykmRaYeKQCLlgSLOWadU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aee9c4d-1a0f-4216-bc1f-08dda9a82cdd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 11:56:33.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW3Lebg55lnNXzm+EZKWq0jzUyu5OYu21jXIFFg8lbV6zhJ3CaACnDEHaFpj4id3brAbpVqigVwHp37KzlaWrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262

On Mon, Apr 21, 2025 at 03:28:24PM -0700, Jakub Kicinski wrote:
> Move the rx-buf-len config validation to the queue ops.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 40 +++++++++++++++++++
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 12 ------
>  2 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 43497b335329..a772ffaf3e5b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16052,8 +16052,46 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	return 0;
>  }
>  
> +static int
> +bnxt_queue_cfg_validate(struct net_device *dev, int idx,
> +			struct netdev_queue_config *qcfg,
> +			struct netlink_ext_ack *extack)
> +{
> +	struct bnxt *bp = netdev_priv(dev);
> +
> +	/* Older chips need MSS calc so rx_buf_len is not supported,
> +	 * but we don't set queue ops for them so we should never get here.
> +	 */
> +	if (qcfg->rx_buf_len != bp->rx_page_size &&
> +	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
> +		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
> +		return -EINVAL;
> +	}
> +
> +	if (!is_power_of_2(qcfg->rx_buf_len)) {
> +		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len is not power of 2");
> +		return -ERANGE;
> +	}
> +	if (qcfg->rx_buf_len < BNXT_RX_PAGE_SIZE ||
> +	    qcfg->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
> +		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range");
> +		return -ERANGE;
> +	}
> +	return 0;
> +}
> +

For the hypothetical situation when the user configures a larger buffer
than the ring size * MTU. Should the check happen in validate or should
the max buffer size be dynamic depending on ring size and MTU?

It is currently hypothetical as BNXT_MAX_RX_PAGE_SIZE is 32K. But for
reference it would be good to know/document.

Thanks,
Dragos

