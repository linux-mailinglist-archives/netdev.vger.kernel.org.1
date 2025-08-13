Return-Path: <netdev+bounces-213382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C53B24CE5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D73188C39E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDAB2ED172;
	Wed, 13 Aug 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZSOeaP4P"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA92E8DEC;
	Wed, 13 Aug 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097633; cv=fail; b=f/3tuFS6JgyRjcTau8YxQPZQyI/Icy/WSyHCeMEUpU4Vme5dbawwUXmjSAADJh7G/V3npdOXOQ3wt9rRLJzm0uoJ+6Z5MIuKsA0Hk6nopD6twU/C2NONmn+9fOzL/iyrvBCYdhJwSngLxHaIdJYBEXo+kgV5nvjFSM0X1mWw80s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097633; c=relaxed/simple;
	bh=s5XSI4dOC2ZZY8fiqJnA3zrVradMLiVBxCLm61JTA1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mzgRn6FqKmtZXOCjEipLGT2hDJev+87oEEhIEKHIDCejyi+jU2pF5xGB9U4Qvm2eeKDqLQFw2ctSgDtKIb9N9hR9BSPY9ZKSzLEThyttjdbS/Vr6GkTqikn3xyaHVwJ2RyYWoLokjTSQvRBFVIbL/0YEpS0Io1Hg4B1pejTmb0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZSOeaP4P; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcsdXx12qtI9Cuseq0AkX+cnADFEaTqqPlMAYnno6IHn6zyLY5zyOuHeMGblMn9ZWu+ZCPUB1I7y7kabfvzJ0RaVWzsatJ/lrGfqmBpMdvCuFB6bGxGCA9UmTL+DJkdzLeJmk0iHzro3g8KvT0w2w4C2nrQ9eC9k1Q0U8678z40lNve0OXbzE4lMbfiKS2KeqSFoM8ooK8sQwHKVkalExu/Cd2E0JO0XZB000jKbwb2kOYEeTNghReEUzmcQwA/OrTKjz8Pfac0LROCekUJl4d74URdsBeKVwE+BeS1MRJr9psdwdeBznyB1IMFnwfqNjcI6AaUkAcO/6L/HMWzPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9ZYDqy096uIvmNyoFQS3fZvfcXN/Hsk5yh213OxLnc=;
 b=hOGWH/5oA09cm2opXW7jcJz9pO56Vyd+Ae5bRsoBpknddsguqb4XsB88VTcG0kXTCQqpljdIE5LdgKHKXEMWyN0y92xGnyehiqFF5wQaZ9qtT+j3gMn1OGm6ZDlpNAdpbf1Q3tgOYGMArTgv0ewrdt5Yf41dHBxAtK3M3TeP5Stuoq9shOl9IxqFyHYUUerh0Kxuz3hxPUNzwNCzk/6JWjX0ltEeR2bou5va5AmFfuNZ7/B8FqhwP5PDbYzDbIfEuMceBmWnyeIlpCjpFhmp0DgbbYW71OqVifYpHyTViZCT/ufWkemf654A6pGzY6+PSgD53c7Ca9gSCSINrTSC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9ZYDqy096uIvmNyoFQS3fZvfcXN/Hsk5yh213OxLnc=;
 b=ZSOeaP4PUH9ekBCfUwO6qfUjL9nuHBPI/FKD21TNm1Prkj8ktyWyiYY36LfhJHvj5N6TmApuE+8QblPQWxK7ErRjwosilYxppXuHIg4dxXlP9g3S+bIUdJJeZkizONwBwGKRAed9JPF8WijhfiK4NJC7M3j+XZzU7iMzw4AnEjDpBKjs/ct42NpwsGqPmA5EM+xgNMXEBsSI5Rprhnq+fEcFAr5NcOiLRM/U9Je5NjmAhEF1GcCFC6rZKNhLLShO0FBKuehrpf8mHEBaobJEUIWQ/i9rywbOujkNdNf8n9RrYoP822jfHeI30AVbtVyn37+gSw5CfqkIln0A9hbVHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 15:07:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 15:07:07 +0000
Date: Wed, 13 Aug 2025 11:06:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Message-ID: <aJyqDxFwzKgmeUdA@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-6-wei.fang@nxp.com>
 <aJtZl3jgBD0hLyt0@lizhi-Precision-Tower-5810>
 <PAXPR04MB85109D4D0866A0E03BF04611882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85109D4D0866A0E03BF04611882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c0610a-d0e7-4a24-bb90-08ddda7b11ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P0QRn9gTfjiqHBu8HJHSkBzgfawSabBEpodp5BslzqE5lkcjaO0B9kC+ZTz8?=
 =?us-ascii?Q?D/Q8ukA0lX9jBL0Hlb1KN5I/CxX8Qv0UXQSutu1/1WcuXbNscHFKov8qYy+z?=
 =?us-ascii?Q?PatD/bk3daoYnL2qfkCE+jSheR2u/w6Cpk9vBlNOE5yYwktfv4tSLZltLmFm?=
 =?us-ascii?Q?wKyhdaZ9d2aZKA60K9Aqd0Haq6JSm8M+oEG++teiuu5Nu+9bTFyygnRcrlYa?=
 =?us-ascii?Q?jGGX37ZjYMyZZjjI9f17k+3GxUkSnEyPPNvCN08jDfEya7X/xYPrBFec3JQO?=
 =?us-ascii?Q?Q/CrcXD/mFmqdl+oQGSk0SX8te3tIWrzj45j+EvWygSd/EjUNk8GnrraDT4F?=
 =?us-ascii?Q?EF0YjJ358DNxiDHs/bYbw/o05CzBywEpPsENBFD/zPC/iW2zzwwBDInnwPBu?=
 =?us-ascii?Q?cYuFYSyeWT2CDSGXhBTpCkc/RnRqNYyA7ACtvW6ZYHVyLl0vqXOL1ck+Bcf5?=
 =?us-ascii?Q?RpXx6b6N7Ddwl7yxHvxCp8w3CLf+Hk6Zuiv9FMehiUkQ8wOhwOWwASCR4Iwt?=
 =?us-ascii?Q?2Y9H8YfgCL8qJplOt7cmuagZvG1/n5p3N5tjTuX7LyV9Ccu7FH5KgUy9ZEoN?=
 =?us-ascii?Q?IpDDLB9QIf4d/5EUXeL1/WxFAFP49Vsz7LHpWO3FUOA6nAVxlHAtXnS0LWd9?=
 =?us-ascii?Q?dxL8LYjfhhheB3it5W6SCFCWN7uNwqpPR9o4qMKRAvWb43XwOgi7OyVaScHu?=
 =?us-ascii?Q?sKdh6Ssk4zVSufY+IjbaeiwmqgEfpkACjmwkE/fEiDkm2+CKx+wOnrxMQvfS?=
 =?us-ascii?Q?gJSxbGYGNKUt5KQbchjtzKrV7TsM9tliTP07QFjVEd+goxlsrF8wZ/D0Wjaf?=
 =?us-ascii?Q?uxRGE+Y0/iMLIRXqNMfitbbqAG4GtS0kpqULCF8Sn1XMHgymd39VZyjDMnxX?=
 =?us-ascii?Q?uMMOpEIHCZqX1O+9Sw3G8QUcldNmr6jotxWWKPM4c/BWAWKFkklkD7lSRgMl?=
 =?us-ascii?Q?qGHhODXgeiR+7z2zTVfNyBFwtdkZoRJycOsQyA5zPIG5lSx+C28lbMwf0VqO?=
 =?us-ascii?Q?uM/vmCypBsMTTR98vzk1YOt8nN60TVtfRhfKybl/fG6bnpF1Bh1hUv9djQwH?=
 =?us-ascii?Q?7P3wvXzIRWmE6krDwrdFF76E+6VrYLmMKEN8jt8OycGNFlBI+3ag4YSLB5M7?=
 =?us-ascii?Q?mwTCBhPprN/R+8g5kkbsMcuBRmVzGK16s9frvcEIYWGJs+bwuka//WUawso/?=
 =?us-ascii?Q?jjxYpZYEbsmzVOpHHhdEXxBTY3R1Z+HR9ho5G0c2cHh8CECb5wNxPNiswsJf?=
 =?us-ascii?Q?BUahCUwiYvHxo3BJeDlBvRAfoT4PFM1k4g+58O2Qhvk1PEW16VdYzKY/jdk6?=
 =?us-ascii?Q?OBMAkDbKZ+II3WRqUv8ZM9z2i/qMpCUAvqjLu/eiWQPHmyMbtjkuczwih2P6?=
 =?us-ascii?Q?M3J3UxU+C1btqxou049fh0Z15xQQUm5TlcsCqIThSZStqimhLbkqBmurTxS2?=
 =?us-ascii?Q?gSiO+C0kLiEtTvCqp0Eyy6rqwj4ciVXw7V2RltlG9OCH/5Ov0s/kY5ZXHkVD?=
 =?us-ascii?Q?905hKv3G9ep1j9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dyQo8tlG3MrMoBHbUPPntzU2EKorOmTrCN8uR/gvsFX0/lF/H6Ur31IWE+Oo?=
 =?us-ascii?Q?qgd41Mr7oyAoxAYljahszohxIC2vOtJG3jUFoPa3jFahEpf+e9ElimBpc25L?=
 =?us-ascii?Q?4WMUrjnIN93g81KD1hqqvt6n3F0nPHEY2sBl8ZRueRE9kKWdrvrmawFNSA5g?=
 =?us-ascii?Q?EGt6xN/j+HBAaA5pVXFLTI5kgwADJrxF1/KiNl/ihi47QI0LgSaL6IE9p1Ec?=
 =?us-ascii?Q?+qVVBXALOBONBGacs2y66Sq2RC2ZXXo8NswGVVjSKp0AqJvPP7XAJC6cZ82b?=
 =?us-ascii?Q?xFMK78ksW4zb22w1J6hZtTH+J8jjjLVbfz35fyQYgsR5ZGcR7VTHhzXiGvAx?=
 =?us-ascii?Q?96STeiGh6oGFEFfRy78QnHw9GEmwcy6TJZRa+YO8R5OVUh44gWiOCcc1rUsD?=
 =?us-ascii?Q?KcHWc0X/7kNZeX7DHwICy68CZMH4H/qFzB6cwvwygd8sovs9++Bdd4sWwJqd?=
 =?us-ascii?Q?N6gsIOevSNnt7/oBVvTa6zleSLQ5tO9tKeaCNJ32jK8SHlAsGXM5HK8WkvZb?=
 =?us-ascii?Q?XO9UEV2yko3ISecilRAtuUtKgRSzGlUnfjdjbePqPyWvrDUMK6uYtzU1wLMl?=
 =?us-ascii?Q?x/uh4vwWxyt9JlWvp3M5HKuy6QYQggtw4tcSVcmUZt9jTKO9+H8F6busR26e?=
 =?us-ascii?Q?tl45ro1NRVbAHrLyMJ1zH8/WRRdMzcMhvZtJAW2iZrLHdXUr+iiji4hrGogb?=
 =?us-ascii?Q?gSS3+hSg1jKi10o7T0EvYZvkxNkcIoq42Z6kxhqhmEWQ2pWmty++S1HWOEzX?=
 =?us-ascii?Q?qvWgX+gUl34oBwFM7OFgWn7u5bvmK2X5KI7PkhoXHmwORjq9bYTqHj+JBhq9?=
 =?us-ascii?Q?pBpyp8O2A+ROWHO442Wm5C9sbv0THRpjYyy9bZBPsi4IM8nsu0+2urryEl+r?=
 =?us-ascii?Q?1oWs75h0krx0f1lPfZtyf7jwHYCEimYPK7T3QJfpCSWiT+y2OmNyM9gl59ou?=
 =?us-ascii?Q?QLnVoWI0C6SXsP+F2I0fbUKIny1HH756QwThazsQ7A54BzeX/cPZQmxWK+nc?=
 =?us-ascii?Q?7zYcJ8WdOFg+qCb/yj8th56mzTvk8G7H21k7oA39t1/CuKqzpcDHZaYBGoSB?=
 =?us-ascii?Q?sQRZc2n2PceEJklnEHNPcLgwc1ujBYSfwOiLH22eNQKs4DSfgBwsRkNDuujl?=
 =?us-ascii?Q?Tlai3+NKU9LHgYz6xyGCQsGq3y0Byw03nPGtGnHj+gonIknDOW9UCHK5RvLS?=
 =?us-ascii?Q?ED1xziVpo3db2J5ySqvbmf/e64Fu8NJATqa6pmvuLVCvPYKSNutYq3KB0V0B?=
 =?us-ascii?Q?aOodBVQxS3/g1OUepqFGumg2duHMnTstBq9P0IsmpCW6q6iK3JH5yIbNich6?=
 =?us-ascii?Q?YnNfFNIJ6xUPHTjejCcpkotVSM1Uq/joObMF4C7ircNBWEl/7ABvRyDw5QEj?=
 =?us-ascii?Q?izWws1UheL9HEgchy2j103/Ej6ZtZOY5pfThAo8EQOg4neJ/BMP6SYr1ivN2?=
 =?us-ascii?Q?PX5CzyohAm6WXA8fybgSgGtwtXxCuenfRxrYU/u13fPVpYJ+YPj7uf62Pl6V?=
 =?us-ascii?Q?z/vZh3k7ZJX7mNNkd2uIT1Hasoc5OBmIZry+l5Gla98Y8oTZbAARJZq7/ky6?=
 =?us-ascii?Q?3bUoLThhfigeOMomWzgTWEkPOs3kLFWjDkCyVOrS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c0610a-d0e7-4a24-bb90-08ddda7b11ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:07:07.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lomoRBZHxnxvrs/LgzJAHTTJWx2At0Mj8QuOHO2n++IvTGO50hYqVZnEINcGIki5t3+zhN97d5sGM+N14EJ0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276

On Wed, Aug 13, 2025 at 01:59:01AM +0000, Wei Fang wrote:
> > On Tue, Aug 12, 2025 at 05:46:24PM +0800, Wei Fang wrote:
> > > The NETC Timer is capable of generating a PPS interrupt to the host. To
> > > support this feature, a 64-bit alarm time (which is a integral second
> > > of PHC in the future) is set to TMR_ALARM, and the period is set to
> > > TMR_FIPER. The alarm time is compared to the current time on each update,
> > > then the alarm trigger is used as an indication to the TMR_FIPER starts
> > > down counting. After the period has passed, the PPS event is generated.
> > >
> > > According to the NETC block guide, the Timer has three FIPERs, any of
> > > which can be used to generate the PPS events, but in the current
> > > implementation, we only need one of them to implement the PPS feature,
> > > so FIPER 0 is used as the default PPS generator. Also, the Timer has
> > > 2 ALARMs, currently, ALARM 0 is used as the default time comparator.
> > >
> > > However, if there is a time drift when PPS is enabled, the PPS event will
> > > not be generated at an integral second of PHC. The suggested steps from
> > > IP team if time drift happens:
> >
> > according to patch, "drift" means timer adjust period?
>
> No only adjust period, but also including adjust time.

I think 'adjust period and time' is more accurate then drift.  drift always
happen. The problem should happen only at adjust.

>
> > netc_timer_adjust_period()
> >
> > generally, netc_timer_adjust_period() happen 4 times every second, does
> > disable/re-enable impact pps accurate?
>
> PPS needs to be re-enabled only when the integer part of the period changes.
> In this case, re-enabling PPS will result in a loss of PPS signal for 1 ~ 2 seconds.
> In most cases, only the fractional part of the period is adjusted, so there is no
> need to re-enable PPS.

Lost 1-2 second should be okay when adjust time, which only happen at
beginning of sync.

Does software enable/disable impact PPS accurate? For example:

suppose PPS plus at 10000ns position.

enable/disable software take 112ns, does PPS plus at 10112ns Or still at
10000ns position.

Frank

>
> >
> > >
> > > 1. Disable FIPER before adjusting the hardware time
> > > 2. Rearm ALARM after the time adjustment to make the next PPS event be
> > > generated at an integral second of PHC.
> > > 3. Re-enable FIPER.
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > >
> > > ---
> > > v2 changes:
> > > 1. Refine the subject and the commit message
> > > 2. Add a comment to netc_timer_enable_pps()
> > > 3. Remove the "nxp,pps-channel" logic from the driver
> > > v3 changes:
> > > 1. Use "2 * NSEC_PER_SEC" to instead of "2000000000U"
> > > 2. Improve the commit message
> > > 3. Add alarm related logic and the irq handler
> > > 4. Add tmr_emask to struct netc_timer to save the irq masks instead of
> > >    reading TMR_EMASK register
> > > 5. Remove pps_channel from struct netc_timer and remove
> > >    NETC_TMR_DEFAULT_PPS_CHANNEL
> > > ---
> > >  drivers/ptp/ptp_netc.c | 260
> > ++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 257 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> > > index cbe2a64d1ced..9026a967a5fe 100644
> > > --- a/drivers/ptp/ptp_netc.c
> > > +++ b/drivers/ptp/ptp_netc.c
> > > @@ -20,7 +20,14 @@
> > >  #define  TMR_CTRL_TE			BIT(2)
> > >  #define  TMR_COMP_MODE			BIT(15)
> > >  #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> > > +#define  TMR_CTRL_FS			BIT(28)
> > >
> > > +#define NETC_TMR_TEVENT			0x0084
> > > +#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
> > > +#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
> > > +#define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
> > > +
> > > +#define NETC_TMR_TEMASK			0x0088
> > >  #define NETC_TMR_CNT_L			0x0098
> > >  #define NETC_TMR_CNT_H			0x009c
> > >  #define NETC_TMR_ADD			0x00a0
> > > @@ -28,9 +35,19 @@
> > >  #define NETC_TMR_OFF_L			0x00b0
> > >  #define NETC_TMR_OFF_H			0x00b4
> > >
> > > +/* i = 0, 1, i indicates the index of TMR_ALARM */
> > > +#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
> > > +#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
> > > +
> > > +/* i = 0, 1, 2. i indicates the index of TMR_FIPER. */
> > > +#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
> > > +
> > >  #define NETC_TMR_FIPER_CTRL		0x00dc
> > >  #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
> > >  #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> > > +#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
> > > +#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
> > > +#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
> > >
> > >  #define NETC_TMR_CUR_TIME_L		0x00f0
> > >  #define NETC_TMR_CUR_TIME_H		0x00f4
> > > @@ -39,6 +56,9 @@
> > >
> > >  #define NETC_TMR_FIPER_NUM		3
> > >  #define NETC_TMR_DEFAULT_PRSC		2
> > > +#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
> > > +#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
> > > +#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
> > >
> > >  /* 1588 timer reference clock source select */
> > >  #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from
> > CCM */
> > > @@ -60,6 +80,10 @@ struct netc_timer {
> > >  	u32 oclk_prsc;
> > >  	/* High 32-bit is integer part, low 32-bit is fractional part */
> > >  	u64 period;
> > > +
> > > +	int irq;
> > > +	u32 tmr_emask;
> > > +	bool pps_enabled;
> > >  };
> > >
> > >  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> > > @@ -124,6 +148,155 @@ static u64 netc_timer_cur_time_read(struct
> > netc_timer *priv)
> > >  	return ns;
> > >  }
> > >
> > > +static void netc_timer_alarm_write(struct netc_timer *priv,
> > > +				   u64 alarm, int index)
> > > +{
> > > +	u32 alarm_h = upper_32_bits(alarm);
> > > +	u32 alarm_l = lower_32_bits(alarm);
> > > +
> > > +	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
> > > +	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
> > > +}
> > > +
> > > +static u32 netc_timer_get_integral_period(struct netc_timer *priv)
> > > +{
> > > +	u32 tmr_ctrl, integral_period;
> > > +
> > > +	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> > > +	integral_period = FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
> > > +
> > > +	return integral_period;
> > > +}
> > > +
> > > +static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
> > > +					 u32 fiper)
> > > +{
> > > +	u64 divisor, pulse_width;
> > > +
> > > +	/* Set the FIPER pulse width to half FIPER interval by default.
> > > +	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
> > > +	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
> > > +	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
> > > +	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
> > > +	 */
> > > +	divisor = mul_u32_u32(2 * NSEC_PER_SEC, priv->oclk_prsc);
> > > +	pulse_width = div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor);
> > > +
> > > +	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
> > > +	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
> > > +		pulse_width = NETC_TMR_FIPER_MAX_PW;
> > > +
> > > +	return pulse_width;
> > > +}
> > > +
> > > +static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
> > > +				     u32 integral_period)
> > > +{
> > > +	u64 alarm;
> > > +
> > > +	/* Get the alarm value */
> > > +	alarm = netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
> > > +	alarm = roundup_u64(alarm, NSEC_PER_SEC);
> > > +	alarm = roundup_u64(alarm, integral_period);
> > > +
> > > +	netc_timer_alarm_write(priv, alarm, 0);
> > > +}
> > > +
> > > +/* Note that users should not use this API to output PPS signal on
> > > + * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
> > > + * for input into kernel PPS subsystem. See:
> > > + *
> > https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
> > > + */
> > > +static int netc_timer_enable_pps(struct netc_timer *priv,
> > > +				 struct ptp_clock_request *rq, int on)
> > > +{
> > > +	u32 fiper, fiper_ctrl;
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&priv->lock, flags);
> > > +
> > > +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> > > +
> > > +	if (on) {
> > > +		u32 integral_period, fiper_pw;
> > > +
> > > +		if (priv->pps_enabled)
> > > +			goto unlock_spinlock;
> > > +
> > > +		integral_period = netc_timer_get_integral_period(priv);
> > > +		fiper = NSEC_PER_SEC - integral_period;
> > > +		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
> > > +		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
> > > +				FIPER_CTRL_FS_ALARM(0));
> > > +		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
> > > +		priv->tmr_emask |= TMR_TEVNET_PPEN(0) |
> > TMR_TEVENT_ALMEN(0);
> > > +		priv->pps_enabled = true;
> > > +		netc_timer_set_pps_alarm(priv, 0, integral_period);
> > > +	} else {
> > > +		if (!priv->pps_enabled)
> > > +			goto unlock_spinlock;
> > > +
> > > +		fiper = NETC_TMR_DEFAULT_FIPER;
> > > +		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
> > > +				     TMR_TEVENT_ALMEN(0));
> > > +		fiper_ctrl |= FIPER_CTRL_DIS(0);
> > > +		priv->pps_enabled = false;
> > > +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> > > +	}
> > > +
> > > +	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> > > +	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> > > +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> > > +
> > > +unlock_spinlock:
> > > +	spin_unlock_irqrestore(&priv->lock, flags);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
> > > +{
> > > +	u32 fiper_ctrl;
> > > +
> > > +	if (!priv->pps_enabled)
> > > +		return;
> > > +
> > > +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> > > +	fiper_ctrl |= FIPER_CTRL_DIS(0);
> > > +	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
> > > +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> > > +}
> > > +
> > > +static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
> > > +{
> > > +	u32 fiper_ctrl, integral_period, fiper;
> > > +
> > > +	if (!priv->pps_enabled)
> > > +		return;
> > > +
> > > +	integral_period = netc_timer_get_integral_period(priv);
> > > +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> > > +	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
> > > +	fiper = NSEC_PER_SEC - integral_period;
> > > +
> > > +	netc_timer_set_pps_alarm(priv, 0, integral_period);
> > > +	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> > > +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> > > +}
> > > +
> > > +static int netc_timer_enable(struct ptp_clock_info *ptp,
> > > +			     struct ptp_clock_request *rq, int on)
> > > +{
> > > +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> > > +
> > > +	switch (rq->type) {
> > > +	case PTP_CLK_REQ_PPS:
> > > +		return netc_timer_enable_pps(priv, rq, on);
> > > +	default:
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +}
> > > +
> > >  static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
> > >  {
> > >  	u32 fractional_period = lower_32_bits(period);
> > > @@ -136,8 +309,11 @@ static void netc_timer_adjust_period(struct
> > netc_timer *priv, u64 period)
> > >  	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> > >  	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
> > >  				    TMR_CTRL_TCLK_PERIOD);
> > > -	if (tmr_ctrl != old_tmr_ctrl)
> > > +	if (tmr_ctrl != old_tmr_ctrl) {
> > > +		netc_timer_disable_pps_fiper(priv);
> > >  		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > > +		netc_timer_enable_pps_fiper(priv);
> > > +	}
> > >
> > >  	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> > >
> > > @@ -163,6 +339,8 @@ static int netc_timer_adjtime(struct ptp_clock_info
> > *ptp, s64 delta)
> > >
> > >  	spin_lock_irqsave(&priv->lock, flags);
> > >
> > > +	netc_timer_disable_pps_fiper(priv);
> > > +
> > >  	/* Adjusting TMROFF instead of TMR_CNT is that the timer
> > >  	 * counter keeps increasing during reading and writing
> > >  	 * TMR_CNT, which will cause latency.
> > > @@ -171,6 +349,8 @@ static int netc_timer_adjtime(struct ptp_clock_info
> > *ptp, s64 delta)
> > >  	tmr_off += delta;
> > >  	netc_timer_offset_write(priv, tmr_off);
> > >
> > > +	netc_timer_enable_pps_fiper(priv);
> > > +
> > >  	spin_unlock_irqrestore(&priv->lock, flags);
> > >
> > >  	return 0;
> > > @@ -205,8 +385,12 @@ static int netc_timer_settime64(struct
> > ptp_clock_info *ptp,
> > >  	unsigned long flags;
> > >
> > >  	spin_lock_irqsave(&priv->lock, flags);
> > > +
> > > +	netc_timer_disable_pps_fiper(priv);
> > >  	netc_timer_offset_write(priv, 0);
> > >  	netc_timer_cnt_write(priv, ns);
> > > +	netc_timer_enable_pps_fiper(priv);
> > > +
> > >  	spin_unlock_irqrestore(&priv->lock, flags);
> > >
> > >  	return 0;
> > > @@ -232,10 +416,13 @@ static const struct ptp_clock_info
> > netc_timer_ptp_caps = {
> > >  	.name		= "NETC Timer PTP clock",
> > >  	.max_adj	= 500000000,
> > >  	.n_pins		= 0,
> > > +	.n_alarm	= 2,
> > > +	.pps		= 1,
> > >  	.adjfine	= netc_timer_adjfine,
> > >  	.adjtime	= netc_timer_adjtime,
> > >  	.gettimex64	= netc_timer_gettimex64,
> > >  	.settime64	= netc_timer_settime64,
> > > +	.enable		= netc_timer_enable,
> > >  };
> > >
> > >  static void netc_timer_init(struct netc_timer *priv)
> > > @@ -252,7 +439,7 @@ static void netc_timer_init(struct netc_timer *priv)
> > >  	 * domain are not accessible.
> > >  	 */
> > >  	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
> > > -		   TMR_CTRL_TE;
> > > +		   TMR_CTRL_TE | TMR_CTRL_FS;
> > >  	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > >  	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
> > >
> > > @@ -372,6 +559,66 @@ static int netc_timer_parse_dt(struct netc_timer
> > *priv)
> > >  	return netc_timer_get_reference_clk_source(priv);
> > >  }
> > >
> > > +static irqreturn_t netc_timer_isr(int irq, void *data)
> > > +{
> > > +	struct netc_timer *priv = data;
> > > +	struct ptp_clock_event event;
> > > +	u32 tmr_event;
> > > +
> > > +	spin_lock(&priv->lock);
> > > +
> > > +	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
> > > +	tmr_event &= priv->tmr_emask;
> > > +	/* Clear interrupts status */
> > > +	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
> > > +
> > > +	if (tmr_event & TMR_TEVENT_ALMEN(0))
> > > +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> > > +
> > > +	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
> > > +		event.type = PTP_CLOCK_PPS;
> > > +		ptp_clock_event(priv->clock, &event);
> > > +	}
> > > +
> > > +	spin_unlock(&priv->lock);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int netc_timer_init_msix_irq(struct netc_timer *priv)
> > > +{
> > > +	struct pci_dev *pdev = priv->pdev;
> > > +	char irq_name[64];
> > > +	int err, n;
> > > +
> > > +	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> > > +	if (n != 1) {
> > > +		err = (n < 0) ? n : -EPERM;
> > > +		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
> > > +		return err;
> > > +	}
> > > +
> > > +	priv->irq = pci_irq_vector(pdev, 0);
> > > +	snprintf(irq_name, sizeof(irq_name), "ptp-netc %s", pci_name(pdev));
> > > +	err = request_irq(priv->irq, netc_timer_isr, 0, irq_name, priv);
> > > +	if (err) {
> > > +		dev_err(&pdev->dev, "request_irq() failed\n");
> > > +		pci_free_irq_vectors(pdev);
> > > +		return err;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void netc_timer_free_msix_irq(struct netc_timer *priv)
> > > +{
> > > +	struct pci_dev *pdev = priv->pdev;
> > > +
> > > +	disable_irq(priv->irq);
> > > +	free_irq(priv->irq, priv);
> > > +	pci_free_irq_vectors(pdev);
> > > +}
> > > +
> > >  static int netc_timer_probe(struct pci_dev *pdev,
> > >  			    const struct pci_device_id *id)
> > >  {
> > > @@ -395,17 +642,23 @@ static int netc_timer_probe(struct pci_dev *pdev,
> > >  	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
> > >  	spin_lock_init(&priv->lock);
> > >
> > > +	err = netc_timer_init_msix_irq(priv);
> > > +	if (err)
> > > +		goto timer_pci_remove;
> > > +
> > >  	netc_timer_init(priv);
> > >  	priv->clock = ptp_clock_register(&priv->caps, dev);
> > >  	if (IS_ERR(priv->clock)) {
> > >  		err = PTR_ERR(priv->clock);
> > > -		goto timer_pci_remove;
> > > +		goto free_msix_irq;
> > >  	}
> > >
> > >  	priv->phc_index = ptp_clock_index(priv->clock);
> > >
> > >  	return 0;
> > >
> > > +free_msix_irq:
> > > +	netc_timer_free_msix_irq(priv);
> > >  timer_pci_remove:
> > >  	netc_timer_pci_remove(pdev);
> > >
> > > @@ -417,6 +670,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
> > >  	struct netc_timer *priv = pci_get_drvdata(pdev);
> > >
> > >  	ptp_clock_unregister(priv->clock);
> > > +	netc_timer_free_msix_irq(priv);
> > >  	netc_timer_pci_remove(pdev);
> > >  }
> > >
> > > --
> > > 2.34.1
> > >

