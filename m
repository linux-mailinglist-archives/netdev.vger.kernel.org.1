Return-Path: <netdev+bounces-148997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CCB9E3C8A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF5AB3A973
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205561F758D;
	Wed,  4 Dec 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HJYcQjq/"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58CB1F707A
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321156; cv=fail; b=A3w/pvPoc8FZQhj5RmD2XyEQotl/FNx5rrB1ehThv0Wg1gwFIp5+FT+Qfg7bJ5ghfvIBM0CvRexNoBioNoWvWSQyGMM8clpO2fKixNLVZ/WjIljOWp8LpM3zo0bosQzBJVBqSt+bfBzzOq81+0ZzqT0Im7NzamT3KzSR8SpcTIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321156; c=relaxed/simple;
	bh=UAZZWr6YXGMnaDSgdCPZ9u8n9nEyEUKcbKQY9VCs20A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gi6POES5QSoX4gxXt+Jw3W2dWxX3oARKZSQ6PxIYfXqhUxOKp/U/1bWKrOck/auc5BsRHYkun+rgYVrbru0jztqJc9keu3Y/A9v/BYtaQhW9WvRyndZMs3kiTtDkHEtm8vjDK6BUoy+VdaLKcF9Nwe03WbmEutCefDrbiji9kOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HJYcQjq/; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOdEFmu2JytGQYWNs35GGeCIzGfQ0fWH16caIEIR997+AarkUaUV+PqunJCtHy5GEJUmVHghfxIK5UfAVqbRGCGh0Im7RRx/SGqSq0IkSBd7Slbk3n91Lv2vgOZJAU6hlSH/KoEUi1gcpizwsf2KuDHVp3h9njUO0PiiFJa/H5PMg9JcdCtDGm+01VBEie6uJwY28weH72x8FvGARbTYHQq1PBbflAb8Lv/veo7xKryFt2/bT+o/Cv5nLsDKihfb9lRacdBKzf/rYtqdqApq+c10jT8tCqWo47MlnqJt9KMYct0WOSzGk3d3qzxYhOv7FuxV1GVbVjolXvLUKgDhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr6sszUBaSCU+GNSDK4kOQmbJz8SLsWGAyv1pjQP1n8=;
 b=OdLZCgkNiKkIAFiPX7cyoslXqjpgxaPX9ocYua5VFKYqoFHLjsAWtYRX1mpUTtgBQjyXpVSFu+4gISZWFwYZkwD9xQjyhQmp4XXvy9d9PlJic1TTuY+4tTs4df26ihozBI4x+1hoPjbGtdnKfBWczKLmN1FHFvp6zgJIcmQtzyeo/lBwhSPW5O3jMdmW3sGphE2GEgBPWDfPfoRgOujAgUJKJkfNmSCs5fLfP/A6ao1FQaS7J226LuvmIRDw8uWYpasKl7XfAsqeob6harYoDshLzvWzBqrBqb+0uvxV7sFWKvp/UUP5voWRxEblAN/DB3F9g5r59/PPoDznB0jvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr6sszUBaSCU+GNSDK4kOQmbJz8SLsWGAyv1pjQP1n8=;
 b=HJYcQjq/wvPhe8p29rF8Iow2vad64fdn1PLhNvDvZyD54Ge+6QH7/qoitEnI710IKlLVIEJN8GAOFcNJ9TUakGOh8i2p9k1CUqCza8t5EhyizAgE+6ErAuWPOWr/tzQUdePwOFS7w+eoXNsx1MK92YqvXzS2YAAYvGkKAfzJF6r1/TwebLIto5YYEcI/NsCc5ZskwH6VmvihYJ/uWo2qYwQ6l1TQdCh9Q6z4vCBtAVY/KLG6z+QFri0w+WfIv8kDbeJHW5ciAUXvox6i9uS2p2Yaxo/VgeUIHQkoqCHTZj2h4UGMi6qvVmaa7J3BVFvw4P2Hhs0T4L7ubkNEAMHa0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10524.eurprd04.prod.outlook.com (2603:10a6:150:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 14:05:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 14:05:50 +0000
Date: Wed, 4 Dec 2024 16:05:47 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net] net: mscc: ocelot: be resilient to loss of PTP
 packets during transmission
Message-ID: <20241204140547.6epegdjf7i4swsfc@skbuf>
References: <20241203164755.16115-1-vladimir.oltean@nxp.com>
 <20241203164755.16115-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203164755.16115-1-vladimir.oltean@nxp.com>
 <20241203164755.16115-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VI1P189CA0035.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::48) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10524:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c84d88-968d-4302-6d55-08dd146cc254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C4Dh1zA3wuLIRoDNt/A/aff3AE9JPt9h6wUISGo/cfBRZCwwDdkf8VYSUJqY?=
 =?us-ascii?Q?6znV2mxIMX0DtVQqTz+4gX80d9lSlgwdlFUc5kLtgkGrwNJqLpEjDLMg9ocD?=
 =?us-ascii?Q?O6I9eyfuifr9T9ePQSR5YwN3ksUp+D9Eq0IWJLfpWxy1ifQZmzz6Evaj3zBY?=
 =?us-ascii?Q?nOPHqeCsDnb7Dg/6w/tTgatomH+7ltMaUnlmC3AO+ZOjT91IB7OunrzGp9eK?=
 =?us-ascii?Q?zV9a/zHOZ6TL+xTDijwVSW0o1OXE5OtVNrxSKBKrI6laa/t0UHGOiXleSwPi?=
 =?us-ascii?Q?BC41ZI/jyd5J45J0e6PQaoDCFTNSJlJhcTN45V7uXArwgVG98tX3aawV007c?=
 =?us-ascii?Q?afpSKMiWqIGGdtsgUAgNbZFb3vJi+oOQT8V1JZdKTnP7dSTijxZfiU7rIN0e?=
 =?us-ascii?Q?R0bLb1T809Eu3Equtvd5zdbi9/EapZUNJ4ExlWHHQyMhFIOByzTpZdoUHnay?=
 =?us-ascii?Q?mstKmX/zs4UXaMrMnRcpkyHZQ8wAIPSSgQQ19a3tuWfDjoDvnDKzj9RFFt/v?=
 =?us-ascii?Q?oFhbo/c1H1meDXbz4Op6C5/aE3nrxcol4u09Zab7Fy7e8gs8AUkqhnUOAIwo?=
 =?us-ascii?Q?fF49VnvwW4eJUdr3HNtVUZXEKk7O8CTOAZBUJg4jN31hCFIq9LFC0g69lZ90?=
 =?us-ascii?Q?QemD+EtPJBfcvoL4yDM15floZseIeOgEa7y62tKXggfoJmSThL+rn8TByydc?=
 =?us-ascii?Q?ytduoGj6YQEWmjdfXdGN6v2hdmMTw/3e/usX/mXIVJIM4H9BpNauVRhnXSoh?=
 =?us-ascii?Q?RIORnuQxrtrqz3gN/LHmgk8fZtR11Ly+NUZwGidvGhWd/QNufQcyMCOdm+nr?=
 =?us-ascii?Q?MUjR1W0QFA/ZeYIoX2KMrEeGShf9XeOZUfpzGe9KjXw50pLoLG0PvWMLso7n?=
 =?us-ascii?Q?jonPWRy9syyYuO/k8Nt74UEYIICYVyB8jBEI4ZRb89Ya6LfsPiUSj2IsXyFh?=
 =?us-ascii?Q?BQFWJHKAXSwwh0hgf302UgzZY4Qeri+KZNjP0qRpGo4uY2u6Q8VjbRH3P9FI?=
 =?us-ascii?Q?5+T+eUjGuJyNNDs7+mKZDsEL1Qdk2lKrhW6QXdya6kacsvoOg3ze8/tAhUJU?=
 =?us-ascii?Q?M/MJer8/aIPCEm2AcirtKG8GDLkVV2QbrEImAF+POkQqDfaRZcrkTtnz20Hi?=
 =?us-ascii?Q?WqhtW8BZoTcDlwjegUbsdAqvk37nEqqSg736ryQoYW1fUzmQewseF8MXkw7G?=
 =?us-ascii?Q?aDCXx8KpSNQ9hizquGrA+EWUVXDK0jvDTKmdqKMzqkZUgnCmjfK7pRcqlA1t?=
 =?us-ascii?Q?F8+4wQ9DkuzQK/0Zczoy7gw5EawgwCEfYvzfCY6BcE43SFkQ6eEHpdsWsPEP?=
 =?us-ascii?Q?/soDXrmDXNuLmU6sRpxUfEa++hhQErmnLSxYiyRcYBGGEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M3/8Xwim0ZqDwg/+Lmrm/bZZvrL8neC7kThslNgjIfYMKC8L6jhRQueCJUrB?=
 =?us-ascii?Q?ODdF1gThvy49mXxDoXeD54l/xvBq7fi9ulGgoPafXNo0mRvAbBUf89hPC5r6?=
 =?us-ascii?Q?LPyNvMN8Xma64Mg82QCYN51Y6qSLoFBBtloSeRE2tz4oWin/r7GL0W3IMRYo?=
 =?us-ascii?Q?OT0UY4rJ6uzIE8wYqUt/lE6swhXAYTHhKb0wtPu8QgM39xqfpKeMga+6CLVW?=
 =?us-ascii?Q?mhH4iOF6Qzhy9JsWzbAgGZt+MxiGqwg6nUYSdqE6ayIOfsISBgDR1aobTTaX?=
 =?us-ascii?Q?xTqyf1OAO1SKSlBN8ScpGvxxu+IPnJduTQ3FQ4zoR3f8N2rV03kOMrMI+N+V?=
 =?us-ascii?Q?n0hOvjTKnIMQ/QDdnGJ4DIXAoLAz5vdVZQdYc3Schr09MRxCap7wQbmMfoRl?=
 =?us-ascii?Q?wk7aaCSgFtluq+Suldk9pkwluCYikv8iBW/ffchMwzVWSF0Hd1laPAM68Ai7?=
 =?us-ascii?Q?xigIB3lxxtvyclo3gTyqEtVBYrQSKBLUvomEU4cjZFm2kzWddzw2cqUBtNAj?=
 =?us-ascii?Q?WS+4APoow2MCFCBrcnvrotAtSQJOjc0N1iC/J5twHSL2DFX3ad61aQxxibE9?=
 =?us-ascii?Q?Vr00ODwk+q89wtnZIi51uSrkl+56GWDtwGc0TY73NMSRttZt2elSKliOsgiI?=
 =?us-ascii?Q?gvgChml7FUaCI9B4UmSlu6bYTxy6ewK5WsbUZgU3S/chaOEWITqgr2s3vBfn?=
 =?us-ascii?Q?XuRO6zD4RSU6eW1GzpOIdurE6zLTxcpPcLz4lkxfvF0LxajkdOyudYS8jEH3?=
 =?us-ascii?Q?1M7ECUEqJL1K/RjoQhkF1sqIVIpTHQCjqizW/bD3KlDEEanWXcLcgEUB3Q6i?=
 =?us-ascii?Q?ry4OcGl1IwnOn+x32qtG5+7Ms1rPp5zmjWOFiU8hYhGAKLnq8MzkjM8k6pH4?=
 =?us-ascii?Q?mQs4LZtcVPX3lxdvm4svOW5bJ/SHlTwTEDzThnXTtbTNRsGhxtVfrSJdmBVy?=
 =?us-ascii?Q?iYDo0LqWCu6O8DBB7r00MIgArrvRtih6MHU0r0yoWS+MW4c8oTPOnCkLOZYI?=
 =?us-ascii?Q?9j6JjnXJuarmp7YBTDvBKoFNv/d6VYgPXPlTnPHFLksnMXbvyrAFjGDQohjH?=
 =?us-ascii?Q?30u/nDrkQ6chZPu16dkz8FpAk1Bi3bTQD0kJCE2hJ4Q/m5acwePkEhmP9ZBp?=
 =?us-ascii?Q?hYq/1tPGElMDn3n3ca+sf2lroIarAzNdzu4UE36SVzh17u9tp8feerMBjS05?=
 =?us-ascii?Q?wgsyRzpl37jhj7WM79up9DWGvX5+53M5ZTeCU1FNy+r9upoGXgDN6sDWa6lz?=
 =?us-ascii?Q?TLg088PHd8gzUrbtrlGffPrukpDqNCaLGMMQ4iaav0fB8o4qggquYKLGoysE?=
 =?us-ascii?Q?kuDN5pMIyd3JrdgyTl2frgw/ywsjXpgi0PK60hRm87DAYVB0INOL3C/NLiqJ?=
 =?us-ascii?Q?jHyLkHh3N6hjV3Xx2MAjx2zJ4+a6QLwE8lCN542t5JcWP/ifTdepVdYRtHae?=
 =?us-ascii?Q?THyYPuorZVe44qICUg+HQHRjEcoEfpthL3osu2YFYWCSpkl4sD1RWwHmZVn+?=
 =?us-ascii?Q?jgAVp84XWLh6i1VW393d6yayoQr5tCoH7vsevmiJXoC6EvzO1TTm5RrCKzxf?=
 =?us-ascii?Q?H9ESn+DHXccTR6JQF85eJMXxT3cCHf0EtFNlxOIu/mCa/Q5RNAJXd8/o+JXh?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c84d88-968d-4302-6d55-08dd146cc254
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:05:50.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/hRCg+w6QdMMitnxr5ZaFyXzBRUAeTuzrKYAhaQH/RVzj0RSBIEaemsGEhwGGFYjTPuJbP96UMX0WJNTzfmgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10524

On Tue, Dec 03, 2024 at 06:47:55PM +0200, Vladimir Oltean wrote:
> @@ -687,10 +743,12 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
>  		if (!(*clone))
>  			return -ENOMEM;
>  
> -		err = ocelot_port_add_txtstamp_skb(ocelot, port, *clone);
> +		/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
> +		err = ocelot_port_queue_ptp_tx_skb(ocelot, port, *clone);
>  		if (err)
>  			return err;

There was a pre-existing memory leak here.
If ocelot_port_add_txtstamp_skb() fails, we have to undo skb_clone_sk()
using dev_kfree_skb_any(*clone).

If there are no other comments, I'll resend at the 24 hour mark.

pw-bot: cr

>  
> +		skb_shinfo(*clone)->tx_flags |= SKBTX_IN_PROGRESS;
>  		OCELOT_SKB_CB(skb)->ptp_cmd = ptp_cmd;
>  		OCELOT_SKB_CB(*clone)->ptp_class = ptp_class;
>  	}

