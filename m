Return-Path: <netdev+bounces-214994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCA8B2C882
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D8DA033E3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344B280309;
	Tue, 19 Aug 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JgOWVOAs"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F283285CB2;
	Tue, 19 Aug 2025 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617348; cv=fail; b=mtEtAeu1BGWVTFBuLR+P1nb5omIBwGQiFKj8Uje8pXDT8c7mCvdovko3jPB6pFc8WtQrwqhmvAsLgetKezeafdntIsNHPt9uDe720LHKzK3AvTOLxOplI2EDUNzrSakSfttHMTwkAgq9XkplKYGzWzPnFJqth3CXBfp8Xq76E0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617348; c=relaxed/simple;
	bh=HQu8Sa1fNLMi2h9D0LkjdctEm3kTaPcR186/EKWsoy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uat1BKOOlWozXybBFBKzDzls00qHykG8zz3l5pn3i0JPbife5+0oLa1dNZOYENhRGHBDHTEep1t1F9eLzSotmGNjT+kVEuO3Y5GpXr4aJq2TVIpO0ZILP8Q6g2imlZmCJZkPNqEc+QEGRPDifDFYyIY2XQI/DrH0vkyp0qm66t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JgOWVOAs; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJvQuJ8L+zmx9+JT/XU4rfPf8zSCpMbOwDMr/WCdHrHwARRa8qG5iEQLEeLzFNYSx5z7t0IJkkUAP/joLvYu+OGCP+KpuZBamLwbNubtyL9c6fCX7zrb0tQp6EA8lv9KpiV1RnLMnGjwGLa/HXDUCO7PPBDZwicCe77ziFkEbqVcCqjN1jJgGOtlDHVQJ7qb0gMof3/tD74/92Z+EMuaqmTLkLoaHRcHT96o3IR8Csvy5jE0Y/i+DxPScAWyosbv+WrjuZ0XRuN5hv97vu0mcLOsw0t3f7VmHzIYrJcOmYJGNx84xDHK0f+uK4GUXce+GavNKOsWbP2ay1e5f6hexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiYQyaNYOcFUp5R+i94kpBcM9aQm6IREpSgzVPRDFR4=;
 b=WhTF0a6MPEVAAjYrz4KpF/5/PhaItR088RLdK+aLR3KXGrZLggIEslhKTDuXRE2MVFTZiSk4F4W4cMmXlTeoUiaTmgXRJMuUB0DjhUPj//oOaFGBzuHcpyS1sU0a0LrhCKG6muw7/wM5hmE+YhrNaczyJsHmKK4ayVUEkHGskDRtJHB3afR8Jq9Z0s9hEATNxgZT0w9aNms+GrQR+yNGhtsc31i3zic5DIpf4SXFuEDptfjP7/QQBY7SSJDqIXMS1B7FiEQLj5WaDQRgA3sZCPfaV5TdsCToe0CiJeoivyixOMpNL7GrZhj+7nNrH/F5Cd/H6xJu3kH10Zdu9XDfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiYQyaNYOcFUp5R+i94kpBcM9aQm6IREpSgzVPRDFR4=;
 b=JgOWVOAsxbWwTKqXeOsAkpbtgm7mbmf/egI8NSvyCqeXJbKOAHQfyYHRKbvT3k52rD6iA3HAM5cNOgSpcSakJTSpqlBTGXEMNMh+8i7ljW5hYIBKmMQlSp2by+sBh7ekJ5Z1+HYXbwZIXLYYHlyBryMBLTMSEOa622LN16SlRyPi9SexanMO20n/q2JnhAPpmiEobi6lbPiH5yTkc2c77wYh10zM27pRN+2W3pj/XsriqFV6sYfGH48JLIXtgOF8CVGJrorHRWIvy5+yQQqjCbeSAn/QnPljQfTN2icVnjPBAi6sdD5QNl6kN5dEc5MfBr920CTe2E5ZF5H7uhbc0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by MRWPR04MB11492.eurprd04.prod.outlook.com (2603:10a6:501:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 15:29:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 15:29:02 +0000
Date: Tue, 19 Aug 2025 11:28:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v4 net-next 06/15] ptp: netc: add periodic pulse output
 support
Message-ID: <aKSYMxObH1n9luEs@lizhi-Precision-Tower-5810>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819123620.916637-7-wei.fang@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|MRWPR04MB11492:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a9b5ba-bdc3-40a9-f131-08dddf352021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mHgyD7XZPIM2X1X5jrTiFw/elzeyhfZ5NLESatM44K3B351cskRiruzyC7Wf?=
 =?us-ascii?Q?TmMYbNGAMj2LTJ7kU+JTOHBgfqUi9meygArMvDZWGklMXKAK9VaytW+fAik2?=
 =?us-ascii?Q?bpxVJzx7wo/B11FfYEnJ7NyXdhNcJ62rdF9UZ1FFN0YahAxvPLIpqhLTCDij?=
 =?us-ascii?Q?/uXLVxW6ahWo8Wh4pfLsIO4XJ64eBYR/36RMKYPYgMo9DYYDBbP1qxg2DiDi?=
 =?us-ascii?Q?V9UcEqBTyXrV7CtkL7j/oe/HmCOTp2Tbr8SDSZoi6572TJHqGNWwI79S+pRd?=
 =?us-ascii?Q?2jm4H6aWJ0bjIuAe0nA3lTvNmeb/eJLCNuhm0KBdWBbsGDkL2okNstgcLRHW?=
 =?us-ascii?Q?N9cM24/42YRgiAzyPgHA9BVquyeZg9xIbR6Wd1zbA9s092JohPIXJVYr1OPt?=
 =?us-ascii?Q?gxEfFIhwMqqYlr/vuCqpTCZeqFlkGxjSQ054A8aCDuvxAhF04kabWc3szD3g?=
 =?us-ascii?Q?i/dxttdsSivgNhjc/eLmL/lxL3k3FsP9gVDsPFEbmLWWnUqNv3/8PgO9/D7W?=
 =?us-ascii?Q?GgzOsPIvHT7X+L6oEI6kdi2uEZJ+pd/ZOdgXeRZwWcZkL87w0CrDf1rqYt7H?=
 =?us-ascii?Q?fe5QQXH6c7cn9EuoFSqRPga4O9BF+vDyKokJ03UvAINxGXpyKQUK4aFH8XOU?=
 =?us-ascii?Q?uVBG6ESEuzgaQgsybOsYJfrlxTzf8feQgqNxJtOc+meXMbyC/H8Fvw1UOrR4?=
 =?us-ascii?Q?9M6IW2Gf8iliBmQZGWWLXX7KUy71s63qwnO4qWzgjIESiD/hdN0qdhI5DxzQ?=
 =?us-ascii?Q?qnGtEaZrceotaYZD/qVyoJ9EjAHw9oVgktNIIEataZVYDPh7jrhQulNGNu3U?=
 =?us-ascii?Q?UB4vHEDwpkYRkPzNkz14ZYUdYVlvr9/zJW8+qsc2v4aeb79gwYkiTQAyfrqG?=
 =?us-ascii?Q?OIYHcHPKxDSlRahZFp1fUBEfIRJsIhOkquZrrWarK0Kf9+Rpz2Xk2XgvCqqE?=
 =?us-ascii?Q?f7pG8M8cujsblnxmpMP7dIBmeyomGvjGq/8YjADvk6BRrywYa8rBXlcb3bNi?=
 =?us-ascii?Q?7XkzkhcNzDDA5YHjPTqGUP7S0ZsuVDylOOIm6+TiXoWdBHWjKqflqZ8Bn0eW?=
 =?us-ascii?Q?jbUyaxTWauMglsKCtGXOFXlzW2qgG2UpYLem4Ct8OT1DV6K8fjoOqee/mPZl?=
 =?us-ascii?Q?Sh//3QRSyGGpqk4SYzb+SSUL8pEBe4+PFPFSrA57G6NLfG11Ju1Ja5een6r/?=
 =?us-ascii?Q?J6BbCQiN2tn3jbgOOfi6g+EwWNG3C2fRNR6gE/74usvPX4sZgYEmvOje1yR5?=
 =?us-ascii?Q?8Xwsg2+Kh8Iun69Qo8HjNXhFtSAc6ZufeeUf9CWh8BlRPfol/GitLsWIpIFr?=
 =?us-ascii?Q?bLCzYX5DOUA9fb6mR7li7aw32ZlbtOiP9rit8rULoFMMqxog35W3iNUxrPNw?=
 =?us-ascii?Q?SFznoUP1RMEyBxgFZfromUFXiDC2wXMC83J7yvp4a26BabJGW/KOljWv5Nmt?=
 =?us-ascii?Q?v37dnqcz8ANDgQqRz4d4RNi4zI+iIUyp/MgXroqDjsV7G3aUCQJTgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4VjBSifD8tcNiNhg+gHcLtElJxfS5v0Gpmq2PRdiXN7UTNXf3bQsBZvt1xu?=
 =?us-ascii?Q?Keo6ognr+94qr8jRng+44+fOeKWL8+Kv+cDlrBI9I0kboOpXTH1roBTAVS/k?=
 =?us-ascii?Q?T7S/IwcVjChWp17sLETrmnHG5PaV84RuSwweGJ4+vycZeIVWz+FVdY3FqyFz?=
 =?us-ascii?Q?rotYdAIczqif41ox4VPUtNoBO5GoDaseXSggjPbXWAaJKvvbkI1zRXd9CKNs?=
 =?us-ascii?Q?uKf4VfyX0iFjrs6fBhAd+l/tRC3JrLX+cHRv1WIDQADLG23II68tuTEe7Oq9?=
 =?us-ascii?Q?6/F77TaGs9s/hE56aYjt1pJHiJz9oA4+GyhCKfMoixo6rz0w32zbvJ4ZeUV4?=
 =?us-ascii?Q?uw3dlvaAuYqLIHUj2+4IJBdqPBfHEZZzffCVwoD6Wuf9b8fMMLa1aWZc+6mP?=
 =?us-ascii?Q?RXe+gcN2EaplZk5YNhWq0KboR+U5EUGcFCLN4iHu+znUrfpdJOzvkGWCKzOE?=
 =?us-ascii?Q?U6V7LjDLpiTb+nFOy3F0Xog3K3dBFqwajtCpWGPsTJ3o/jXBusieLncyBK8i?=
 =?us-ascii?Q?WpeE1Lm4tCsOrNucF41FSIQadPyXSDqXXmHWQhN2DnhFhISxxYUzRLOKYejf?=
 =?us-ascii?Q?6Bk7BOdXlQIVR09UVOsQD/LPqJ0X5UXwzo/fBgs5Q7gGjnKIWMntfJcP2sF7?=
 =?us-ascii?Q?nIReQobiQ1u+um39YL6nhwVBGKVnLh0IE/shzxq4EkSgscr0t7CKuXlLjAx/?=
 =?us-ascii?Q?5TLTaVXm4p5ETCT/TJAt0OS1qouGMbCtCnwHWlkOtw2HvMvYV9wZ48vFNUXt?=
 =?us-ascii?Q?tzAQgH/2qiWyPNgqDAX0Ql3PgsCPtppUGpv+tAuG2rbjGzdiN4rIh4njccFj?=
 =?us-ascii?Q?/jUQqqqUkJMgQFQ9egFRXElGEiial6Lbf5leubY383nCTyCI4L+dsbJu7Z2E?=
 =?us-ascii?Q?nsLZuW2EHcuDmZpxdzFoomavLY1+wAP/+ifwosC74Tx8q3j+8/ojR9I5g43L?=
 =?us-ascii?Q?S62PKezokxvDCJ0SVn/YwNCMHc9cqmLDvO17or4oyFO35LWWsBaQHzBIMlKJ?=
 =?us-ascii?Q?+ywxwx9vhfHW4etgJn+uWLgm5T52o6/2JNk91MGZUDxA/oN3GLWKg07WsvCR?=
 =?us-ascii?Q?nK5wNvoT2diRvMJ4lH/nEy/7CUQTED/PBVJ/ZYV9LG5z56Un7qU1I+C1bt3M?=
 =?us-ascii?Q?8HkkahWfuM6hX3un9J7TvlpqLaBTxX/XdvDzKUflgKYfOI0w55eB/YQ3J3YO?=
 =?us-ascii?Q?l2ndgZEoEenItqHSeEf7EJLuN531wkKdBQqkI0E8d9qeNHnNDI6YA0O5w8In?=
 =?us-ascii?Q?cnY1beLVruRwCGjPXfIl65tE25a0dqU8Ku3S+eJmg6CXHTNTBXnFXgYd3eqW?=
 =?us-ascii?Q?XQ2cdFjnVjxipD6Msk6Bj7GSqnJQ+SVNVaSDLDP3FClMw1cu1FiHY3WAp3WV?=
 =?us-ascii?Q?vE2WCBJLjH6fuh7i/FivMbpPOemZgfHF3tMprB6K+xEL9HzdFZrMIM5ZR5eK?=
 =?us-ascii?Q?7W5x2Pw/aS3ijp+J2IX6yXHy0sxbuJT3dNwJPZF/IdkglXs/PSKQmDyt+3Y8?=
 =?us-ascii?Q?RwuT/FoToqBymCqKwq5trpxErUTUEq0JutVePEUR6TdJm8IT3dXDYhxXUTjY?=
 =?us-ascii?Q?CT2CPrace0hu0gFnOUlPzPFfHZ7UyT1Rnjup/BED?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a9b5ba-bdc3-40a9-f131-08dddf352021
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:29:02.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeA+2KDGBxFsI5pQsEpGARgxdXk+Qwvev2qPekTGR3ruMMgJ8rU9cJVgUtkzXvDLqHs63n+rv2crZhp4OFrHsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11492

On Tue, Aug 19, 2025 at 08:36:11PM +0800, Wei Fang wrote:
> NETC Timer has three pulse channels, all of which support periodic pulse
> output. Bind the channel to a ALARM register and then sets a future time
> into the ALARM register. When the current time is greater than the ALARM
> value, the FIPER register will be triggered to count down, and when the
> count reaches 0, the pulse will be triggered. The PPS signal is also
> implemented in this way.
>
> i.MX95 only has ALARM1 can be used as an indication to the FIPER start
> down counting, but i.MX943 has ALARM1 and ALARM2 can be used. Therefore,
> only one channel can work for i.MX95, two channels for i.MX943 as most.
>
> In addition, change the PPS channel to be dynamically selected from fixed
> number (0) because add PTP_CLK_REQ_PEROUT support.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> ---
> v2: no changes
> v3 changes:
> 1. Improve the commit message
> 2. Add revision to struct netc_timer
> 3. Use priv->tmr_emask to instead of reading TMR_EMASK register
> 4. Add pps_channel to struct netc_timer and NETC_TMR_INVALID_CHANNEL
> 5. Add some helper functions: netc_timer_enable/disable_periodic_pulse(),
>    and netc_timer_select_pps_channel()
> 6. Dynamically select PPS channel instead of fixed to channel 0.
> v4:
> 1. Simplify the commit message
> 2. Fix dereference unassigned pointer "ps" in netc_timer_enable_pps().
> ---
>  drivers/ptp/ptp_netc.c | 356 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 306 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index ded2509700b5..da9603c65dda 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -52,12 +52,18 @@
>  #define NETC_TMR_CUR_TIME_H		0x00f4
>
>  #define NETC_TMR_REGS_BAR		0
> +#define NETC_GLOBAL_OFFSET		0x10000
> +#define NETC_GLOBAL_IPBRR0		0xbf8
> +#define  IPBRR0_IP_REV			GENMASK(15, 0)
> +#define NETC_REV_4_1			0x0401
>
>  #define NETC_TMR_FIPER_NUM		3
> +#define NETC_TMR_INVALID_CHANNEL	NETC_TMR_FIPER_NUM
>  #define NETC_TMR_DEFAULT_PRSC		2
>  #define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
>  #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
>  #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
> +#define NETC_TMR_ALARM_NUM		2
>
>  /* 1588 timer reference clock source select */
>  #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> @@ -66,6 +72,19 @@
>
>  #define NETC_TMR_SYSCLK_333M		333333333U
>
> +enum netc_pp_type {
> +	NETC_PP_PPS = 1,
> +	NETC_PP_PEROUT,
> +};
> +
> +struct netc_pp {
> +	enum netc_pp_type type;
> +	bool enabled;
> +	int alarm_id;
> +	u32 period; /* pulse period, ns */
> +	u64 stime; /* start time, ns */
> +};
> +
>  struct netc_timer {
>  	void __iomem *base;
>  	struct pci_dev *pdev;
> @@ -80,8 +99,12 @@ struct netc_timer {
>  	u64 period;
>
>  	int irq;
> +	int revision;
>  	u32 tmr_emask;
> -	bool pps_enabled;
> +	u8 pps_channel;
> +	u8 fs_alarm_num;
> +	u8 fs_alarm_bitmap;
> +	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
>  };
>
>  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> @@ -190,6 +213,7 @@ static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
>  static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
>  				     u32 integral_period)
>  {
> +	struct netc_pp *pp = &priv->pp[channel];
>  	u64 alarm;
>
>  	/* Get the alarm value */
> @@ -197,7 +221,116 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
>  	alarm = roundup_u64(alarm, NSEC_PER_SEC);
>  	alarm = roundup_u64(alarm, integral_period);
>
> -	netc_timer_alarm_write(priv, alarm, 0);
> +	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
> +}
> +
> +static void netc_timer_set_perout_alarm(struct netc_timer *priv, int channel,
> +					u32 integral_period)
> +{
> +	u64 cur_time = netc_timer_cur_time_read(priv);
> +	struct netc_pp *pp = &priv->pp[channel];
> +	u64 alarm, delta, min_time;
> +	u32 period = pp->period;
> +	u64 stime = pp->stime;
> +
> +	min_time = cur_time + NSEC_PER_MSEC + period;
> +	if (stime < min_time) {
> +		delta = min_time - stime;
> +		stime += roundup_u64(delta, period);
> +	}
> +
> +	alarm = roundup_u64(stime - period, integral_period);
> +	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
> +}
> +
> +static int netc_timer_get_alarm_id(struct netc_timer *priv)
> +{
> +	int i;
> +
> +	for (i = 0; i < priv->fs_alarm_num; i++) {
> +		if (!(priv->fs_alarm_bitmap & BIT(i))) {
> +			priv->fs_alarm_bitmap |= BIT(i);
> +			break;
> +		}
> +	}
> +
> +	return i;
> +}
> +
> +static u64 netc_timer_get_gclk_period(struct netc_timer *priv)
> +{
> +	/* TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz.
> +	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq.
> +	 * TMR_GCLK_period = (NSEC_PER_SEC * oclk_prsc) / clk_freq
> +	 */
> +
> +	return div_u64(mul_u32_u32(NSEC_PER_SEC, priv->oclk_prsc),
> +		       priv->clk_freq);
> +}
> +
> +static void netc_timer_enable_periodic_pulse(struct netc_timer *priv,
> +					     u8 channel)
> +{
> +	u32 fiper_pw, fiper, fiper_ctrl, integral_period;
> +	struct netc_pp *pp = &priv->pp[channel];
> +	int alarm_id = pp->alarm_id;
> +
> +	integral_period = netc_timer_get_integral_period(priv);
> +	/* Set to desired FIPER interval in ns - TCLK_PERIOD */
> +	fiper = pp->period - integral_period;
> +	fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
> +
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
> +			FIPER_CTRL_FS_ALARM(channel));
> +	fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
> +	fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
> +
> +	priv->tmr_emask |= TMR_TEVNET_PPEN(channel) |
> +			   TMR_TEVENT_ALMEN(alarm_id);
> +
> +	if (pp->type == NETC_PP_PPS)
> +		netc_timer_set_pps_alarm(priv, channel, integral_period);
> +	else
> +		netc_timer_set_perout_alarm(priv, channel, integral_period);
> +
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static void netc_timer_disable_periodic_pulse(struct netc_timer *priv,
> +					      u8 channel)
> +{
> +	struct netc_pp *pp = &priv->pp[channel];
> +	int alarm_id = pp->alarm_id;
> +	u32 fiper_ctrl;
> +
> +	if (!pp->enabled)
> +		return;
> +
> +	priv->tmr_emask &= ~(TMR_TEVNET_PPEN(channel) |
> +			     TMR_TEVENT_ALMEN(alarm_id));
> +
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	fiper_ctrl |= FIPER_CTRL_DIS(channel);
> +
> +	netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, alarm_id);
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(channel), NETC_TMR_DEFAULT_FIPER);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static u8 netc_timer_select_pps_channel(struct netc_timer *priv)
> +{
> +	int i;
> +
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		if (!priv->pp[i].enabled)
> +			return i;
> +	}
> +
> +	return NETC_TMR_INVALID_CHANNEL;
>  }
>
>  /* Note that users should not use this API to output PPS signal on
> @@ -208,77 +341,178 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
>  static int netc_timer_enable_pps(struct netc_timer *priv,
>  				 struct ptp_clock_request *rq, int on)
>  {
> -	u32 fiper, fiper_ctrl;
> +	struct device *dev = &priv->pdev->dev;
>  	unsigned long flags;
> +	struct netc_pp *pp;
> +	int err = 0;
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> -	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> -
>  	if (on) {
> -		u32 integral_period, fiper_pw;
> +		int alarm_id;
> +		u8 channel;
> +
> +		if (priv->pps_channel < NETC_TMR_FIPER_NUM) {
> +			channel = priv->pps_channel;
> +		} else {
> +			channel = netc_timer_select_pps_channel(priv);
> +			if (channel == NETC_TMR_INVALID_CHANNEL) {
> +				dev_err(dev, "No available FIPERs\n");
> +				err = -EBUSY;
> +				goto unlock_spinlock;
> +			}
> +		}
>
> -		if (priv->pps_enabled)
> +		pp = &priv->pp[channel];
> +		if (pp->enabled)
>  			goto unlock_spinlock;
>
> -		integral_period = netc_timer_get_integral_period(priv);
> -		fiper = NSEC_PER_SEC - integral_period;
> -		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
> -		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
> -				FIPER_CTRL_FS_ALARM(0));
> -		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
> -		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
> -		priv->pps_enabled = true;
> -		netc_timer_set_pps_alarm(priv, 0, integral_period);
> +		alarm_id = netc_timer_get_alarm_id(priv);
> +		if (alarm_id == priv->fs_alarm_num) {
> +			dev_err(dev, "No available ALARMs\n");
> +			err = -EBUSY;
> +			goto unlock_spinlock;
> +		}
> +
> +		pp->enabled = true;
> +		pp->type = NETC_PP_PPS;
> +		pp->alarm_id = alarm_id;
> +		pp->period = NSEC_PER_SEC;
> +		priv->pps_channel = channel;
> +
> +		netc_timer_enable_periodic_pulse(priv, channel);
>  	} else {
> -		if (!priv->pps_enabled)
> +		/* pps_channel is invalid if PPS is not enabled, so no
> +		 * processing is needed.
> +		 */
> +		if (priv->pps_channel >= NETC_TMR_FIPER_NUM)
>  			goto unlock_spinlock;
>
> -		fiper = NETC_TMR_DEFAULT_FIPER;
> -		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
> -				     TMR_TEVENT_ALMEN(0));
> -		fiper_ctrl |= FIPER_CTRL_DIS(0);
> -		priv->pps_enabled = false;
> -		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> +		netc_timer_disable_periodic_pulse(priv, priv->pps_channel);
> +		pp = &priv->pp[priv->pps_channel];
> +		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
> +		memset(pp, 0, sizeof(*pp));
> +		priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
>  	}
>
> -	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> -	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> -	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +unlock_spinlock:
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return err;
> +}
> +
> +static int net_timer_enable_perout(struct netc_timer *priv,
> +				   struct ptp_clock_request *rq, int on)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	u32 channel = rq->perout.index;
> +	unsigned long flags;
> +	struct netc_pp *pp;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	pp = &priv->pp[channel];
> +	if (pp->type == NETC_PP_PPS) {
> +		dev_err(dev, "FIPER%u is being used for PPS\n", channel);
> +		err = -EBUSY;
> +		goto unlock_spinlock;
> +	}
> +
> +	if (on) {
> +		u64 period_ns, gclk_period, max_period, min_period;
> +		struct timespec64 period, stime;
> +		u32 integral_period;
> +		int alarm_id;
> +
> +		period.tv_sec = rq->perout.period.sec;
> +		period.tv_nsec = rq->perout.period.nsec;
> +		period_ns = timespec64_to_ns(&period);
> +
> +		integral_period = netc_timer_get_integral_period(priv);
> +		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
> +		gclk_period = netc_timer_get_gclk_period(priv);
> +		min_period = gclk_period * 4 + integral_period;
> +		if (period_ns > max_period || period_ns < min_period) {
> +			dev_err(dev, "The period range is %llu ~ %llu\n",
> +				min_period, max_period);
> +			err = -EINVAL;
> +			goto unlock_spinlock;
> +		}
> +
> +		if (pp->enabled) {
> +			alarm_id = pp->alarm_id;
> +		} else {
> +			alarm_id = netc_timer_get_alarm_id(priv);
> +			if (alarm_id == priv->fs_alarm_num) {
> +				dev_err(dev, "No available ALARMs\n");
> +				err = -EBUSY;
> +				goto unlock_spinlock;
> +			}
> +
> +			pp->type = NETC_PP_PEROUT;
> +			pp->enabled = true;
> +			pp->alarm_id = alarm_id;
> +		}
> +
> +		stime.tv_sec = rq->perout.start.sec;
> +		stime.tv_nsec = rq->perout.start.nsec;
> +		pp->stime = timespec64_to_ns(&stime);
> +		pp->period = period_ns;
> +
> +		netc_timer_enable_periodic_pulse(priv, channel);
> +	} else {
> +		netc_timer_disable_periodic_pulse(priv, channel);
> +		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
> +		memset(pp, 0, sizeof(*pp));
> +	}
>
>  unlock_spinlock:
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
> -	return 0;
> +	return err;
>  }
>
> -static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
> +static void netc_timer_disable_fiper(struct netc_timer *priv)
>  {
> -	u32 fiper_ctrl;
> +	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	int i;
>
> -	if (!priv->pps_enabled)
> -		return;
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		if (!priv->pp[i].enabled)
> +			continue;
> +
> +		fiper_ctrl |= FIPER_CTRL_DIS(i);
> +		netc_timer_wr(priv, NETC_TMR_FIPER(i), NETC_TMR_DEFAULT_FIPER);
> +	}
>
> -	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> -	fiper_ctrl |= FIPER_CTRL_DIS(0);
> -	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
>  	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
>  }
>
> -static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
> +static void netc_timer_enable_fiper(struct netc_timer *priv)
>  {
> -	u32 fiper_ctrl, integral_period, fiper;
> +	u32 integral_period = netc_timer_get_integral_period(priv);
> +	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	int i;
>
> -	if (!priv->pps_enabled)
> -		return;
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		struct netc_pp *pp = &priv->pp[i];
> +		u32 fiper;
>
> -	integral_period = netc_timer_get_integral_period(priv);
> -	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> -	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
> -	fiper = NSEC_PER_SEC - integral_period;
> +		if (!pp->enabled)
> +			continue;
> +
> +		fiper_ctrl &= ~FIPER_CTRL_DIS(i);
> +
> +		if (pp->type == NETC_PP_PPS)
> +			netc_timer_set_pps_alarm(priv, i, integral_period);
> +		else if (pp->type == NETC_PP_PEROUT)
> +			netc_timer_set_perout_alarm(priv, i, integral_period);
> +
> +		fiper = pp->period - integral_period;
> +		netc_timer_wr(priv, NETC_TMR_FIPER(i), fiper);
> +	}
>
> -	netc_timer_set_pps_alarm(priv, 0, integral_period);
> -	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
>  	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
>  }
>
> @@ -290,6 +524,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_PPS:
>  		return netc_timer_enable_pps(priv, rq, on);
> +	case PTP_CLK_REQ_PEROUT:
> +		return net_timer_enable_perout(priv, rq, on);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -308,9 +544,9 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
>  	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
>  				    TMR_CTRL_TCLK_PERIOD);
>  	if (tmr_ctrl != old_tmr_ctrl) {
> -		netc_timer_disable_pps_fiper(priv);
> +		netc_timer_disable_fiper(priv);
>  		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> -		netc_timer_enable_pps_fiper(priv);
> +		netc_timer_enable_fiper(priv);
>  	}
>
>  	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> @@ -337,7 +573,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> -	netc_timer_disable_pps_fiper(priv);
> +	netc_timer_disable_fiper(priv);
>
>  	/* Adjusting TMROFF instead of TMR_CNT is that the timer
>  	 * counter keeps increasing during reading and writing
> @@ -347,7 +583,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  	tmr_off += delta;
>  	netc_timer_offset_write(priv, tmr_off);
>
> -	netc_timer_enable_pps_fiper(priv);
> +	netc_timer_enable_fiper(priv);
>
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
> @@ -384,10 +620,10 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> -	netc_timer_disable_pps_fiper(priv);
> +	netc_timer_disable_fiper(priv);
>  	netc_timer_offset_write(priv, 0);
>  	netc_timer_cnt_write(priv, ns);
> -	netc_timer_enable_pps_fiper(priv);
> +	netc_timer_enable_fiper(priv);
>
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
> @@ -401,6 +637,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
>  	.n_pins		= 0,
>  	.n_alarm	= 2,
>  	.pps		= 1,
> +	.n_per_out	= 3,
>  	.adjfine	= netc_timer_adjfine,
>  	.adjtime	= netc_timer_adjtime,
>  	.gettimex64	= netc_timer_gettimex64,
> @@ -558,6 +795,9 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
>  	if (tmr_event & TMR_TEVENT_ALMEN(0))
>  		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
>
> +	if (tmr_event & TMR_TEVENT_ALMEN(1))
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
> +
>  	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
>  		event.type = PTP_CLOCK_PPS;
>  		ptp_clock_event(priv->clock, &event);
> @@ -602,6 +842,15 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
>  	pci_free_irq_vectors(pdev);
>  }
>
> +static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
> +{
> +	u32 val;
> +
> +	val = netc_timer_rd(priv, NETC_GLOBAL_OFFSET + NETC_GLOBAL_IPBRR0);
> +
> +	return val & IPBRR0_IP_REV;
> +}
> +
>  static int netc_timer_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *id)
>  {
> @@ -614,12 +863,19 @@ static int netc_timer_probe(struct pci_dev *pdev,
>  		return err;
>
>  	priv = pci_get_drvdata(pdev);
> +	priv->revision = netc_timer_get_global_ip_rev(priv);
> +	if (priv->revision == NETC_REV_4_1)
> +		priv->fs_alarm_num = 1;
> +	else
> +		priv->fs_alarm_num = NETC_TMR_ALARM_NUM;
> +
>  	err = netc_timer_parse_dt(priv);
>  	if (err)
>  		goto timer_pci_remove;
>
>  	priv->caps = netc_timer_ptp_caps;
>  	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
> +	priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
>  	spin_lock_init(&priv->lock);
>
>  	err = netc_timer_init_msix_irq(priv);
> --
> 2.34.1
>

