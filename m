Return-Path: <netdev+bounces-128549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6EB97A4C9
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBC3285CEA
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D9E155CBA;
	Mon, 16 Sep 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g4eCK+hr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC77D51E;
	Mon, 16 Sep 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499127; cv=fail; b=kQCjuq0+e3efGJbSFZSMBZeqDxDccxi383jy9T4sZnEDc/bHi5CC2Thu1OkYFDKnk788vMN1V+4hycDgH8QnexuyQrUvn+hZBqcjQ8D79JrNrv1GFRUkViesuX5QzoYQUFKjKj8gzA7EvBEBs1nZuXIlQAl6KFnAEm2Djj5v1PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499127; c=relaxed/simple;
	bh=pDanKzqXouUAlyd4CDi43z4b97Yp53OiV1lF+Mg7/48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Px7nJFYokF2qZuIuNPQ2cgaCOcc3EGlhN34T0Rm6VneBwNs+2w1PGeVj1RVBatX8RLiWXYDwXRTOlUFJuwy8xE4OWHa9Lr9uE8VT/F4/kU/QNMC5u7pJdn1w34+fNOaznMsU+9kqNqaQ0REcixHRkAO2pI1oUXUuEdgGeON9K9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g4eCK+hr reason="signature verification failed"; arc=fail smtp.client-ip=40.107.247.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWr6JRlRr5fEZ+6+28VjaqWVOAeqnjRF3JjNE15fHxUHywStOYCDGM0GTrRBJNRs9F6GHuxRMQiNKW9N9VdryB5wSKa9M1PQkBAgglfyL9AP2dicWwiWV7cvq0Ak97KMcjCGBjFy4xifq8nuQsFNzhbHu2E6wbV+E3M4xg7F5NZPaR1o8C75s4U2lyjH4tH7j0FwPfheYqDpChpwuVip7sgHBnfM0nV5O+jDtxlMWpjRK11jKAT6tECAp9CBvMxiT0CmTbmF5OJYbAG0v8lNPPQyff+h9YRPcMQHZyok6qLhRzQB136Q5kX1QwQ1pvKHtE8EnZijhnsbpPv5Hiy24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hH0xVM1CqFlRGtnIPiz39d+ej+kU/WWtaF+xj8eQSQo=;
 b=IcZibkt4ymKRTi9JbzIDuOHn+Rd8pOt0puOhWZHRMIgLlQueiUcyyVR1Xw9P3txjBeNaKg8S5xpEnV5gCSK80hoRjnKwxu4N5aJVIa8++V3lFxK00p6dqBrFHm92DLS1duksoMBdnpEgkUXu+AYNRLfNTdbAkbDcPlbqEmm4C3xaPfzbjWtN0mC7OPUlgkFSyuWpLBfm4CXkK6Mt5rUJeNvokwSBdf+9qnx6QK7Av7RKqnSlOuKDA6Mzh8E1EOmtruEzLuNGgcqSqLfB/LNKulOI5WWtf1ikWbqHC//jaCeNy63Cfc2eEhqUsj1Z7Nx+8yKZ9P/B4f3K1y1VDe5knQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH0xVM1CqFlRGtnIPiz39d+ej+kU/WWtaF+xj8eQSQo=;
 b=g4eCK+hrXGL+thWb4LMsR7JL+/PdNC5odiuBGIqe38JxvjB2c/+4bf+0BIxz0/WTTKPbQMFMQXJWpa8ALh6EqZEKmJz2jURBT30yjW9QH5Myc9l6is35ZDSiUDcnpyDrTit/dLu3UilDmwQL/KJCRdFLG+S7kLMRX9zDiPZDlfAZb/auhcB0LsS4Sb+qJQ9Up26osorejmESUmW50hqvWCEEZ0KwUO3WWO9cecjVPQiMLXMyCmP8eGBNnyKYo09kQhgqpdm4OGbuqd2hcP/bJDt7wjpnkw8bp13C7HqstrEJbGSUii5KOUhT2OJlnXwVuRrBYizWoeAgyWa5Qs5Hwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 15:05:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 15:05:21 +0000
Date: Mon, 16 Sep 2024 11:05:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 2/2] net: fec: Reload PTP registers after link-state
 change
Message-ID: <ZuhJJ5BEgu9q6vaj@lizhi-Precision-Tower-5810>
References: <20240916141931.742734-1-csokas.bence@prolan.hu>
 <20240916141931.742734-2-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916141931.742734-2-csokas.bence@prolan.hu>
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb0b501-cfcb-49f9-ba21-08dcd660fc0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?YkGRwIOkRWvrnqGahUshaT0u5p4cMvdGblBCxLGfMi/KtDZEuSJsA11cp/?=
 =?iso-8859-1?Q?RCMZCsR/+EHNks6vfZyJZcf1szADDE5xVFF0AN75XK7h40GgmjehJRyo5j?=
 =?iso-8859-1?Q?JKZMu0JxF4QlBUA0Nq4m7inGM9AATx50KpmysPKoath0OncdtRXkXkZSFw?=
 =?iso-8859-1?Q?pOKccfIF8A5kVRgKMec8QgstXm4LrhLqOQDLuKO/fyUiXLcc6gPFGleny9?=
 =?iso-8859-1?Q?TTmP4MmrucwBzkVY+wiZLp212crKICD/g3dcSMQwyWPCPkHLXcy2jRzN71?=
 =?iso-8859-1?Q?xq2A8Zvd8SpQjxh0Sg7bIGJjXL6DnwMp16xnOupF2hLFOrxwz2ecIViKF1?=
 =?iso-8859-1?Q?Y1ER7Y7Y/tQDnbfc2iYzdVEQQNaBN2IGFSJjDMJRLIrbZRIVuF9dmp5eXj?=
 =?iso-8859-1?Q?c+/k+Cy0snxCxnX+wOX8NIQUPQfUXXYA9XKMLCFeV2NcoUkMTA5eRWiJs1?=
 =?iso-8859-1?Q?FVxjAptB0HURBGBHIvtc7B9SAjEDMjMgRlsPNZQdzwbZTSe9axuonQ9qhu?=
 =?iso-8859-1?Q?KvhlPPSNqYVr3GdStSetuhfndj6VPZF6T+MAgg/MF+1q1LLZpfpqdKT1tT?=
 =?iso-8859-1?Q?09tkfEkKXcv831A3s2MQ7L+fQ09WMxQ4CvTRw+LmhNF9CpORB/P9U5/mLH?=
 =?iso-8859-1?Q?qSdG8TMp2J6qOesuHsEp3jbRQm5XXc0ssEzOHjQ0F4VtozlOfD1yW3tWy2?=
 =?iso-8859-1?Q?q0LPwJwirXvueZCYnbw21405qdgBWQK9hJiEyKGEHc/fRcjW5JXHBfNS7k?=
 =?iso-8859-1?Q?BZpLAMf8ihiREINoPX49azAl5eKTkimsYMT3VLPayBLsKJlmf/OODqxHkv?=
 =?iso-8859-1?Q?js/XqIzsne6FC7KIGsFhvIFoIgEl+5afEEGF7vQ2eiHixvJUXkplazM+Fp?=
 =?iso-8859-1?Q?mNf9k9UlTAQRwHdqDgOto+/Lc+m6ZmY1nFzNWLIoXdnyXgTNOh7FzJf+wy?=
 =?iso-8859-1?Q?GWnNxHgfDZK7TibS6tfGOgmQZMLxL3P6CYsMkfuHb045vhaEIcJ5b6Q6un?=
 =?iso-8859-1?Q?RhXs7O0q3oMmDINTXzK6RkJ3cY7ZwAKyQf0by08sPvDStPTguW2cKh+o0N?=
 =?iso-8859-1?Q?6MU1sDvm2XjL/YGkyU1h1BPtU8gkO7SWWz2cri1k2AqxT1W3nQgNjot693?=
 =?iso-8859-1?Q?vVgy6MdjKbNgBIgzF9Tfwx0F5YZRrf+Pq6a9C3MkNp4CuQmWKOlZnvIYsY?=
 =?iso-8859-1?Q?JSx3jJtbpLkJ1p05t5+GeI17ADKuJYyxtiGK1iskowsLNpqBLQ7bilfFUH?=
 =?iso-8859-1?Q?BePZg+7l4y2wlygCHqD41KgDdomSAd0hdNkEfnVZr+9XySY3Xdw1Ecxv5Q?=
 =?iso-8859-1?Q?wQ5UScCzjiDc1LPZS97Q4O+PhD6Gro/y4nVFbWa+QoOtMTTIyDKwcOavrJ?=
 =?iso-8859-1?Q?OyTQpwCdFylxRMjJzD2ZRYbD3ZfAGj0qbZlxleiunGk3+QK6jHzY9DwGYQ?=
 =?iso-8859-1?Q?A0VZqcIdzyrEeaGbJKnp0E80wCTevXFeb8VnBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?+ecytLG00U4srvcV1o/D9GdmQDL1UqDFlKT2oDPQF3WY73ctbldLC6A0kM?=
 =?iso-8859-1?Q?QD2odF5mKf8E57r3wyM+nB18WOP3Yfq9bxS3UNB1YY7O2h5zl+t1sTfCIY?=
 =?iso-8859-1?Q?qH7kgrIdtnSGI4M/kRg3phNoZ9eIL2RLKMAWLZfP9HAAx9KdmCqXLSIzHZ?=
 =?iso-8859-1?Q?BWU8LtwBrE0gI5J75xeThEY/TQHi5lpFXGWdW9U0KGOyiurvPP1I/Ea5SY?=
 =?iso-8859-1?Q?JKQ4JhfPp8Kjm1WJnircFCaoJewwHpmNGRNocsau89Dpm/nF0Ss6IyxXPU?=
 =?iso-8859-1?Q?nOS/HQZ2GoOMq2RG1sFctJnvNCct9Y4D1UqXRWYV1u1MHKmjCC7NLFN3EO?=
 =?iso-8859-1?Q?LpaQnDuvOTKan/+nn+kmcyb4aOltv8e4S941OXKKT7/axiVcKgtoF1aKav?=
 =?iso-8859-1?Q?qsrf2di6xMrcsWwZX/OT/LQ4ybKlfQHAWkGVPI3T48DmiJpnWitpivzS/w?=
 =?iso-8859-1?Q?wIihdB1pMOaMnMcakD4Ll7KG8Oh/KQ2AnRJ9w1awul8OLhwgIBD7f2G+sg?=
 =?iso-8859-1?Q?pIlU70R9o/AT3a9o7IDP7EtuuW9XNQS3udZt1VvjZYNHbfjDTBXbG/wkkD?=
 =?iso-8859-1?Q?wFvMjqvwiNyKvVXBIYrRd97jxkKfLRJznCgIxpMA+GacwB+fVR4yjLv9cY?=
 =?iso-8859-1?Q?wK3IuYHAQF+uLG2AEf1hSpQAHKjdDejv4NtsiHeEPvHTZlIJf2ipJ70Bfo?=
 =?iso-8859-1?Q?Nq59ZID6tKyJCQ9RG3nVpGcT70YP1I9Y3pk1z7TkhND6aHu6rkuJdiahVy?=
 =?iso-8859-1?Q?t0KF510Vi16Z5ES2fyqPcj+pybPQITZlyukySk4r5Yvcx7smFTixFTnhmK?=
 =?iso-8859-1?Q?wGLma4AXhzyZd/IK3QAEELIDKTAJOHBBLIGswJAHxXcbuLrXx6j4Bzmnx/?=
 =?iso-8859-1?Q?Q2ceBmXF17dR/ODpwgnhhObibGHix4mnmgBjjQQ4PDUoiFhDlFUeUa/wDC?=
 =?iso-8859-1?Q?1dnNEjKCcwjOeyk1wIz04BDrkflO7rilhPpu+gY+6uCzL0BfjcYCf2xMqt?=
 =?iso-8859-1?Q?3VBdty/Dbv92yBwKVffyD3Y13EX57n3Fxnuek2lEbhIHURThnJ+5dSv5z1?=
 =?iso-8859-1?Q?sjEjxXfu6aGo/aW3c+DZAk1F1Fjc7TF5+DScQwPYekxs7Wz7ohA5q91ivb?=
 =?iso-8859-1?Q?+eDpbalbL3ojmoJe4BfZGF+M2+XIEtETSpTCFRWxgwSeFqNhZoIdhmc3Xs?=
 =?iso-8859-1?Q?i1xQmyCw7YAfA5GX+BKaAokUqnX5+NoCqrxAYmvJn2or0ZLx/YTqOLoGk0?=
 =?iso-8859-1?Q?NhtGjUZ5og9388KYOnI1Qt0STixqmL7CIs+1d6bmoQ6T3QRJIbeSsYJG+z?=
 =?iso-8859-1?Q?/QY2c74C4xQrF8Pa7O91KwWNd0LTgMKEfABSTU5aqSPXH8slP+RGOex4Dy?=
 =?iso-8859-1?Q?UHDypggVO2KLhecCtQtFWSfiKV1MIVAcq17rHCrH+0JN2o4By/eS9PpNs6?=
 =?iso-8859-1?Q?/np5/9yJrGxUz4otw93JmyztnDUydEV+6xDsuuD7mCNTE0+IklTWG60PjT?=
 =?iso-8859-1?Q?3KHC7EXcyKEHtq6jbZvzHxUrPR93AEVZL5eXO5g01XnXvvzcs+q3XdTtXv?=
 =?iso-8859-1?Q?KZYM6vlHdu3hOQmlp129xuJjqfJGSdNgiRsej4ecI6q0PRrpqdCzsJUzMX?=
 =?iso-8859-1?Q?bcv/C+JvczliZKObe34Kj81Za4Wp/MegNR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb0b501-cfcb-49f9-ba21-08dcd660fc0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 15:05:21.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A1XFaGIevtPw8d6Mz5j9CLUtgNeDz+1cwWbgO1ktHPjgUxw6Ceej9ThTF6H10WK9b/qm5jt+JCryXxP501GLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

On Mon, Sep 16, 2024 at 04:19:31PM +0200, Csókás, Bence wrote:
> On link-state change, the controller gets reset,
> which clears all PTP registers, including PHC time,
> calibrated clock correction values etc. For correct
> IEEE 1588 operation we need to restore these after
> the reset.

I am not sure if it necessary. timer will be big offset after reset. ptpd
should set_time then do clock frequency adjust, supposed just few ms, ptp
time will get resync.

of course, restore these value may reduce the resync time.

Frank

>
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
>  drivers/net/ethernet/freescale/fec.h      |  7 +++++
>  drivers/net/ethernet/freescale/fec_main.c |  4 +++
>  drivers/net/ethernet/freescale/fec_ptp.c  | 35 +++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index afa0bfb974e6..efe770fe337d 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -691,11 +691,18 @@ struct fec_enet_private {
>  	/* XDP BPF Program */
>  	struct bpf_prog *xdp_prog;
>
> +	struct {
> +		u64 ns_sys, ns_phc;
> +		u32 at_corr;
> +		u8 at_inc_corr;
> +	} ptp_saved_state;
> +
>  	u64 ethtool_stats[];
>  };
>
>  void fec_ptp_init(struct platform_device *pdev, int irq_idx);
>  void fec_ptp_restore_state(struct fec_enet_private *fep);
> +void fec_ptp_save_state(struct fec_enet_private *fep);
>  void fec_ptp_stop(struct platform_device *pdev);
>  void fec_ptp_start_cyclecounter(struct net_device *ndev);
>  int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 531b51091e7d..570f8a14d975 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1077,6 +1077,8 @@ fec_restart(struct net_device *ndev)
>  	u32 rcntl = OPT_FRAME_SIZE | 0x04;
>  	u32 ecntl = FEC_ECR_ETHEREN;
>
> +	fec_ptp_save_state(fep);
> +
>  	/* Whack a reset.  We should wait for this.
>  	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
>  	 * instead of reset MAC itself.
> @@ -1338,6 +1340,8 @@ fec_stop(struct net_device *ndev)
>  			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
>  	}
>
> +	fec_ptp_save_state(fep);
> +
>  	/* Whack a reset.  We should wait for this.
>  	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
>  	 * instead of reset MAC itself.
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index c5b89352373a..8011a6f3c4be 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -770,9 +770,44 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
>  	schedule_delayed_work(&fep->time_keep, HZ);
>  }
>
> +void fec_ptp_save_state(struct fec_enet_private *fep)
> +{
> +	unsigned long flags;
> +	u32 atime_inc_corr;
> +
> +	spin_lock_irqsave(&fep->tmreg_lock, flags);
> +
> +	fep->ptp_saved_state.ns_phc = timecounter_read(&fep->tc);
> +	fep->ptp_saved_state.ns_sys = ktime_get_ns();
> +
> +	fep->ptp_saved_state.at_corr = readl(fep->hwp + FEC_ATIME_CORR);
> +	atime_inc_corr = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_CORR_MASK;
> +	fep->ptp_saved_state.at_inc_corr = (u8)(atime_inc_corr >> FEC_T_INC_CORR_OFFSET);
> +
> +	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> +}
> +
>  /* Restore PTP functionality after a reset */
>  void fec_ptp_restore_state(struct fec_enet_private *fep)
>  {
> +	u32 atime_inc = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
> +	unsigned long flags;
> +	u32 counter;
> +	u64 ns;
> +
> +	spin_lock_irqsave(&fep->tmreg_lock, flags);
> +
> +	writel(fep->ptp_saved_state.at_corr, fep->hwp + FEC_ATIME_CORR);
> +	atime_inc |= ((u32)fep->ptp_saved_state.at_inc_corr) << FEC_T_INC_CORR_OFFSET;
> +	writel(atime_inc, fep->hwp + FEC_ATIME_INC);
> +
> +	ns = ktime_get_ns() - fep->ptp_saved_state.ns_sys + fep->ptp_saved_state.ns_phc;
> +	counter = ns & fep->cc.mask;
> +	writel(counter, fep->hwp + FEC_ATIME);
> +	timecounter_init(&fep->tc, &fep->cc, ns);
> +
> +	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> +
>  	/* Restart PPS if needed */
>  	if (fep->pps_enable) {
>  		/* Reset turned it off, so adjust our status flag */
> --
> 2.34.1
>
>

