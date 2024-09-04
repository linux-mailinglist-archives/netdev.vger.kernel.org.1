Return-Path: <netdev+bounces-124985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BB096B7F9
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64111283F4C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834B31CC89A;
	Wed,  4 Sep 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZyHUFq7i"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F256146A76;
	Wed,  4 Sep 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444742; cv=fail; b=Zf+Wc9j4lSuKwB+gh27UEmAzZm+bhPvBDJdRkik/c2xdQd7D85zCwU/IOE54ymFY3O8tX3HclG93bl5LXf5K7LZ/Lm/bL1dv2yD/7dzMUWhTVjsA3JkNDD7qzALRoZneuvBEB6vX4AHX1MlChSzwiK8oBOclWVxA1HK7lmiAdww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444742; c=relaxed/simple;
	bh=7iV7me35rAWsiW60vJhO4Yp9gxF4e+QuWwNukq5jCiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o7hI3epBer78/WP3CMv1b3l7z4AuFyEPN5ktbODdid76m4uj+MBDCHbDJTf0cnxxZTnNHUBavYWdpkYjEZkCuDpwv59Y8yqRhPkUV5vZJik0xJyI99NLWFOQhun20lxqAYtAhY6iCs2Zqwh/NBFgF3V+CHmqvAQv5KDaHhhZ8TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZyHUFq7i; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLvHopU326hAHD/zpt4SILxubKXZEBOr7kRMXcX1sQG+DpOPNkTuSuPFWIKpzz/0i643y3+0RAht72oH+PPAMP0bB02E7LXRzumrPygy25VYhx9OhhZ/noLQwU7QM5+Rne2iac/5VmKnqQN+jJ6lrnp5p6Jf9jm3LhhzA2p9M1bry+G6oxPtdhUb8Xvvy/JS5lSNkxeG5LyL/Wo8WcJMolVItetRMqSx3t+VvsMZh9t/Sh5r6PZnY2EsLRqlLQlmr6m+C6WYAsc0AB6Myta2ZdkgwBhpThNsmD1zZU7zTemwzemuLBMIj68NYOl51f/W+dLNyt4jP0TYEH5DHISCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpYTCNsWBXZBTYR9e3bQ92U5qdG3s2CzrcpaEl8VYng=;
 b=sXgvVbF7vMTj3xQFU/cXkFymfnj8EQ38CERQiDShGg1QqlZGnytEsKQpf1qbLENwMgMLnMbjgYxqyUNB2pwsQRT+fjbNByXJTJQZZKAJtNrTZThIcZNi/RrhursLSfMZKKyv23b8B3Ha+LtW0P5RATeb8ic7CtEC8/o+9KitxaXi8kLOvYLZeXFugtkQmt124GeCmPeHOGthgxmId6tKXmJwYx9FJJkdKh4/rjMSyERkFIeFhY1+NmNsNQ65VeKWzKmEnwasv32CeiCTfjttvFzBWwCfTP/YshMGlK3SpeL7Qf6SaRh0SQeC4puhXzvZSzCHI934Nv2lVlnPS4UPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpYTCNsWBXZBTYR9e3bQ92U5qdG3s2CzrcpaEl8VYng=;
 b=ZyHUFq7iyeETzXjaNM85z2i+Zseqo3sEjUZLkX5UFmw4MO925a/dQZwprGddqyrO+a4H2CeErSFPgVw1Kgds2pS4yIcuhiIKlWmMsKY64mYCjdJSpVQb+urcZAMt5W5fIIeC5+iF6ogUqmmu7k1yH5ltEjMYlauOnofwrAtcxWx4SFJFXSXrhFx7LS9pK5NQu5fw4o6K51N3YN34pGrhkv0u54sISnYrS3AZag5QCqW7Fe39EQNGbW06RiQtzI0EQaCoCMDQdoHXm9KNj28wOCR8I4R4ryN/wY3UIijmfjxmFnGZj1FEybP/X0u7mYBVpU9mCQHIFPBFLcv0S2tz/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10353.eurprd04.prod.outlook.com (2603:10a6:150:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 10:12:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 10:12:16 +0000
Date: Wed, 4 Sep 2024 13:12:13 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, f.fainelli@gmail.com, michael@walle.cc,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: felix: ignore pending status of TAS module
 when it's disabled
Message-ID: <20240904101213.oqdf3brqlzzmgln5@skbuf>
References: <20240904102722.45427-1-xiaoliang.yang_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904102722.45427-1-xiaoliang.yang_1@nxp.com>
X-ClientProxiedBy: BE1P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10353:EE_
X-MS-Office365-Filtering-Correlation-Id: b2345b83-62c0-4592-a002-08dcccca0da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G6gf/SEzdvGmgSerUmq9gNStLZZqiub+Ql4Eu50ozeMUrHELY+3URV3pX9Tj?=
 =?us-ascii?Q?jjkM4vcNyG7PYz/283gQNIu7aK3fP8zCv9sAy8/YmPD/BbBJC3B5w2SOdkJR?=
 =?us-ascii?Q?ALnGH9bzOHqLgx+ls+M0SKgrcau3YuBM+wbLHwrR22QxA9zonvHuih4Z7GRK?=
 =?us-ascii?Q?JmC0YDVWRZMct3DgLiyRUMOiqAszGhC5ulwBnWLofMNLqsyD2L5jdY/tqEIT?=
 =?us-ascii?Q?lZjwo+FBOCbingUWrq8p+sMUZ2kmUWOI+87JSevjbndchyG2NF6/4IIjW1t4?=
 =?us-ascii?Q?+rVFo3hNbSYIlDPPizFy9JCIkSPkp8VEs3Nk6zP4fkAmYuAjm1q4rYw1dlzC?=
 =?us-ascii?Q?pcP4D4DhvcO57Iamy7iLAuhn6WQh8Hqy22odsbzeQS5CvsoTzZb12IzsXgWE?=
 =?us-ascii?Q?UxO/B5Fc2X8vVoel9qxTV1YKDQYVziK7tluzj6YNkDFXCGyTS4HW0Yem+jhP?=
 =?us-ascii?Q?MzHktLZqiOTQdj+3uNGyMeh/tUY7yd5zGBa7EqetqG3b5weUGwMLAQaTu/DG?=
 =?us-ascii?Q?3VTcjBW4fwzQtUQSkNngSIgKaFsJgk3RJUZnwqF6oCdaO/2Qxkea0+tnH3pA?=
 =?us-ascii?Q?xzblL7Yc+1fL0e2cOX1EswhsOgIMbKg9cJDvAwcb10mK2ogRJy5yu2lh2Lk6?=
 =?us-ascii?Q?F5r3fQR+9qvWh0VITs8DknYQNaPaJY6eDbY2xUujTxFU35dBdkwHmYAJOwDJ?=
 =?us-ascii?Q?9UZ5ZY1RVnhvkNKgUYZXnqhAzjSbAVxQTLj/K2MR+qCNJPIrJTHsbcVxpZMi?=
 =?us-ascii?Q?jAGPk9w081p9oRC6RNt+zdvEHzHY55uzimSbUMmtTrYnc/tCp/XAHD+q6xqp?=
 =?us-ascii?Q?cGrLtHza8vQ/gPqngsqGt7E2mLB1fFb9f5EF4xvnAmdjfxsaMfof5Ybw4zNG?=
 =?us-ascii?Q?b6mrS6TTSDanvNk/K4kFPIdLSWxHrjzaqVIEtgzdN67jDOtbdz6pG0kSUEA5?=
 =?us-ascii?Q?1o5UTqvjHvppP/5Mo+4WfSo7dadJIcTWL/UWivan7quzK9OW/A9sk5g8Jh2g?=
 =?us-ascii?Q?3XIIWHGFNmPD73bdDDpaX6XET5XPkdH/KpBPLxlTmiAM+0bQ1CBv4auRh+ym?=
 =?us-ascii?Q?25igGMSydYDxeQO5p9CWLKR4TrM/7yHBLQsIKws2AcPpptdUzFfRdLbEW/2W?=
 =?us-ascii?Q?wpIxEkrXjs2KHZmq0Wh6U+K97G9sc5ECk7jfclbxk1qGvzPx8ILmEtDrqkqM?=
 =?us-ascii?Q?gQTC17K4YQntJIqr7Fal5vQmgA0aj42dxHYig8n+P4BMlAz3WjDsUIkuquGM?=
 =?us-ascii?Q?zrQgvGtNrYKR0az/n0go5TVe1sqz6YQ0fPECQxH2BXxkrcJySKx//e7hNMNx?=
 =?us-ascii?Q?FSVgESqMsuYD5IZ3ATjWyUg+lJhv+sU1CabMeOLmFnN6JQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?goLX8f8bsORz3+flqWiqtAnsv/RsurZ/m8hrI5euZyDSPXNicECdnXSDLx8n?=
 =?us-ascii?Q?qK1fbNLtoNO+bdZ1EufsFrDKpoaA7s4J8N/lP0HXNY2E4I+/nuhIFda3DgEM?=
 =?us-ascii?Q?fnZ7LybkT0tkgF2uz4jjtcn+Xa17NPOT8+bhS07YevQ8WucygBmaZbGkgdr8?=
 =?us-ascii?Q?3oqdguDk7UEAtw29jdrNLrzRTFNgTsgivuBwfnXJBA2As/pz369EjNFYL3Cu?=
 =?us-ascii?Q?sfpdf8q+j9F/LPQzOJos/CU3bka9u7kH6NsDt7wiga//eoktlClpzxUl655Y?=
 =?us-ascii?Q?Ts0wUFe6xCvGv4Dvkp2bFPcAB+scPqYyDyEvjm+Z0uaJ9XiadjKd+ip+Pi0j?=
 =?us-ascii?Q?BXOP5CQvIyEV6NDMNugDoTtSYDvjhdiCYfujjOxyPTuexZ13HIb1PcmU7Vsp?=
 =?us-ascii?Q?01mhvv11dxxR4EUzqZXR7rHTGHjcZA8CNhgo9kQ69Z1OpASVmN1l/59DaRLB?=
 =?us-ascii?Q?opufyV6r59ll82lNdhJeqyPmZalcsYBAVh5O2SKwF+UH95oqWQRHhdLEtg2E?=
 =?us-ascii?Q?T498+LOpZ/IKjQtYV5b++QANEzecado/7rTu3v/ThDFxnQInwQCP7ZugN5Nq?=
 =?us-ascii?Q?PNOaywQSB0wLeMFM1HQjOFjJCjDSYkNuUO96ZusZHgRwkv5R5Bh2EKxtz7E6?=
 =?us-ascii?Q?zoKU72YUjHznEAnvIJPcJcMiSz3g53PMua1tsaUz8qNjLDQovhu48k1XhFtk?=
 =?us-ascii?Q?AybJT7mzWub1sAnhgtzDcgZKGvFngcapMAriBgAwR8rKDKpYlcEWA7GO0pZ+?=
 =?us-ascii?Q?cC6fNLZvTZQq67O/8IsTj9xMQS9weRWYB02qlainH9+jf6XQvgHdvPCERi58?=
 =?us-ascii?Q?GH23HNtyHC2POWEiDb4ccc4xgibgd5f6J0aY0GLKXe0QM+kQ1dVnilC66euy?=
 =?us-ascii?Q?H8qBlKmCfNIq8fEmvCLOE7iTIj8oLQbr3XMc68LWv0SQDnL/fRtLNZiTUynG?=
 =?us-ascii?Q?r9Yn95dWRS2WcVBK9N9rVPMmMiZVcEBw+aDmMFKkzFyoxfctpbkW0LtSKuG1?=
 =?us-ascii?Q?L6dZTqLfslRnBdwGKwN35Tlcpn/3y7e+o8K2bLAxZRSEiPAK+1qMzCfF9eK6?=
 =?us-ascii?Q?n+jTbpcylF3beScV6qfyvX71TlTENrD5v3ALQYyu72Nuewc0sIfxOmVPjXfm?=
 =?us-ascii?Q?SnGIgVbiGYWf0HnEYyLcStvrlWK08sVkc1vc2GcPcHP9VXbnkITmhFmegID4?=
 =?us-ascii?Q?YFphNVF4BR9V5KjQH4krl0Ax+X9Lb9NZe9d185ojBl6vv1EtIpVDw447oRPb?=
 =?us-ascii?Q?Th01iCBZV+BviLPkXtLcBF91oW/u64SpP5xBojS69Fths0dWB6jyUYbrSI4t?=
 =?us-ascii?Q?9a8UurzMxOD7MPLQ0n4N1RIg73o2zXzValUJwZgATKq1dPA7loS4JMKmKht1?=
 =?us-ascii?Q?mq0GYNHhFNuLo3X0K8KhSnsIgw26vfHvBvohuPSfeuXi8N49EkSMF3zDFA0W?=
 =?us-ascii?Q?qfct2laWtpbC94HPtEYBfRyqDA3Cxi3WnZjHO87l4cxYyw9y4qxp68gFCPea?=
 =?us-ascii?Q?GqlFNSBRS+VNQU1Cb0nG5RdqaZrpGlJmhiLv6Hh2Aa+xCPiTYYoe8Tx7DRYK?=
 =?us-ascii?Q?fNGVVpRsglQd7dNzQ0emhHRAa2uTAZBIjPrcLBstcEYaqUL93Xr2JL9gIXg1?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2345b83-62c0-4592-a002-08dcccca0da3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:12:16.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r87oS2v4wkTgENHJXUcf+qqFOrHEGhoyeZyXC1ghmBFQpp2ovwBKrWeF6Q4cGF42T3nj8K96XJEpiu0IOvsKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10353

Hi Xiaoliang,

On Wed, Sep 04, 2024 at 06:27:22PM +0800, Xiaoliang Yang wrote:
> The TAS module could not be configured when it's running in pending
> status. We need disable the module and configure it again. However, the
> pending status is not cleared after the module disabled. So we don't
> need to check the pending status if TAS module is disabled.
> 
> Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
> ---

Does this fix a functional, user-visible problem? If so, which problem is that?
Could you describe it in the commit message? And maybe add a Fixes: tag
to the patch where the problem was first visible?

