Return-Path: <netdev+bounces-214142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82F1B2859C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484503B7D42
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B942F9C23;
	Fri, 15 Aug 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lP+0lnPU"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33E6317714;
	Fri, 15 Aug 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281476; cv=fail; b=Ok1VFTasAUMsv4r7SkQA2afwSXwYu43ZZPmeqg1B6d7XFLtzNtDmfVIna6zpl9tc6A7VgP5Kq+zBkEJDyfr3TfYr6YW9wN4NP+/Q253zs30HxLS43ccA2JRXt/G6ZMMwuvSyF0mRyBS5iZis7Ra0hw4Adv6XFy7xWclPh/w2vjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281476; c=relaxed/simple;
	bh=gZ+xtq4Qw8J8ksOEY7G1Tx1wbHZSePzybvPbG60RaSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qB1bUFrD1sV0vAnDeOvrK+xw6c/MXH+c0UeufbVGBqZp1PPQvRxmtdqw7bo3sqy6RlG+NedpiJ3jWbzFa9r0ryLfhBG8wBCdDjBFAUZX/zBk9UQ9i/XNd/+Bll5PpuRZS3AR+m8o7kLL5mJgnheCmfHbWNNZKpu8RpSXuwa+D1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lP+0lnPU; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYUu+xtwskJboTQ/vcwXJUUVdvDjJ/WMCJTX6IINcoNxlhEcBv8djq+wrIpGHGyAICGgytjV0mQgoJqwV5fEy4g7gI5W8KbjgTC3f4BxCTNcyic6OXtfc/Gdkn6nEuInmamESCJnmzFXfsZQwHfZBxSnkQRaj4iWtRKKNWSqErVU1mmpJCakUslrLtTagtEp+bnTW8M3tYDx81PhEpl6LD66C7mVSvxSjcz8KXO5jhpn+NBx7TqS4hiwKCGxA5UdnwNc2G54xG/Ao3t1BHg7mjNUpHrm4aUuMPAtSMwplwABvsQqmCAudDX9mPWP5PySXyIdigwdHr2r6t1jCtW9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5CTdoGcWjITS+srWVt2qJynegFPcSq1dvyh03XonRQ=;
 b=KSnN6IPlW8WfMChFsxSGJz9B7DL+KUg2VFvia/FhHaVzeX3qhIoU96ZG/RsPpyH93NOjoZ3fxvNII+YC+ul4p+g2khiH516jQLSUxOUTsakTAGk9I/qKvof+PmhQ4UOsP6TAWbZulGPn2MBAe/svCcLFEQh892xGHoQC5Awods4WZW2vyoO8hQIldVVCwfnLwcKQI3KjqN5cpqVTJBw/rmULm97rpkQcl/Zp9hcjCfQjFw7E+tNXw3XmY5GnurHKp2hBJdEgAunJm/uydnf2JwDM/6ILWXQUtmlnrgiIe68grPvbsVBA695TPPasImmJXbfTricS7Ur3NDn0LCGrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5CTdoGcWjITS+srWVt2qJynegFPcSq1dvyh03XonRQ=;
 b=lP+0lnPUt3b+AInmkfNgiyiLa9qPAvC/QGaC6NDYNouaCNwtdS645r90KIx1MEzQiRZqYkd2cg+eJOUDwHsPRj8dLq0o4f56IgT1JKZmhOvJ4/uQT6aKhElfzWbyWSPQGSQ1t3TPm6qh6i/gg55101w3P0BU/09X8Hun+P0TFAyN8B570lTVQgiG7KmtJrb4dfn8HVYmwEEUEKBsHq8gTAvSicx2PWwFPFs0pc0k/NtPu7w77H0DnYNOaSugPWIR5mlNXVXU9eyHrsf7Uap2IhskOO54x1QLrzEeVscWaE6NV1TFjVks733Sz09k9g1W7atHiUiQwgDfQfx7qTDKyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7410.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.7; Fri, 15 Aug
 2025 18:11:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 18:11:10 +0000
Date: Fri, 15 Aug 2025 14:11:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <aJ94NL34kpdMKaH6@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-2-wei.fang@nxp.com>
 <20250814-hospitable-hyrax-of-health-21eef3@kuoka>
 <aJ4v4D71OAaV3ZXy@lizhi-Precision-Tower-5810>
 <cf531bbd-dc07-4c13-9dbb-774c8dfca70c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf531bbd-dc07-4c13-9dbb-774c8dfca70c@kernel.org>
X-ClientProxiedBy: BY5PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:180::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ee72e8-a579-4f92-0bc1-08dddc271c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8PmKC+jWd03W9c0f74u3VKtrq9yJLvi1ABf6khDTuVoq7zl941tEkt7UHBW?=
 =?us-ascii?Q?24JOJPzRq6c0Hg3HaaPfKsFZW6KOSPxsc08E16czXUWKurHcdSZvKmSXcwjB?=
 =?us-ascii?Q?0cUlY4/ClaSvMn1cxsc0QZujWA3Wni06ehZj3ZAC7+4v8MNlC4D2khqcGCtA?=
 =?us-ascii?Q?Fg5LXl/onDsG9MiylAgjREPCylw+71/G2B1Z0OfKXG3Gq6HrhEfX3A5+lpsz?=
 =?us-ascii?Q?uPOqIicTe4RmQ5rcgwSYSbEPlg7InDxVFfFVV8am4lOxy9FpgpF0ErKklaiO?=
 =?us-ascii?Q?4GeqwsoW31dqh1+/JDuzWCbiVnhvheF4T0W+ic/JcWD9USVGKfggltWZZq3A?=
 =?us-ascii?Q?lmt50XwcPpgoa5alRZoYjDndgcNWXfzwRlsrB5Lw0bXY3Wkonc4BG1KikOjz?=
 =?us-ascii?Q?OZxGpRL8VHRGqg1RWNNeJPNbAK0zjnsMbqMNG8GXeYiqY1yabbDWUNwwLCVo?=
 =?us-ascii?Q?U9ZaJTdPja7BJEPA/h0FMb85rXXOHPauPRgTZ1CuV1lQDEcmn6azSC4cWppo?=
 =?us-ascii?Q?TuMT8cNMnD18ovw7AvtVUz5zH6h+lwpbweBzMPCnj/7ferf3goBYWBBtQnQm?=
 =?us-ascii?Q?Fqz/6Qnnv6WMQ4N0svWJ95fvWbzFOEbPcXTtbVT2RGbJYOCGu5kXiDmC+bNw?=
 =?us-ascii?Q?JRulIAz0nDsl/9284kw/vm0aODzmn5QSiXUwz7w19Z0106zRaID2OR6oTH9E?=
 =?us-ascii?Q?UZ/Duw7d4wTVn1yP2pNdmfoiUmxBIrJZMP4eg920vle3eSW3ZSZrHBXTCh+a?=
 =?us-ascii?Q?515FX0qFZvvEdqa9D6AhjXhNB5f9SDIWZcDl4TP/xc3TkivyRS3syTyYVtIT?=
 =?us-ascii?Q?v2TiwZMuRlH+w+L6ntX65V/Ryqo++drkIF1QXyIWIg89q9H7wYr3yMxHrDYp?=
 =?us-ascii?Q?4PeraSUHPJJMef5N1BCMTf9xg7hqNLAmLJ7lFOBKlpEa9L3Elc36TRYFWqXW?=
 =?us-ascii?Q?e9W+RaL6SFLubr8+7CiNhNiussi3nauwfJyeK5by7q+g0dFB8CA2/POsBd6t?=
 =?us-ascii?Q?ACcSgSlDYhV7uk2OMq3/jzhWIU9u7iGOGXtX6iJseSW00EXW0F2E3ysc6Qiv?=
 =?us-ascii?Q?rqKTk7if/l2MDGYg+0T4sZus40bSDH4Xow/63fiHHW1LHfK5GuWTYbTtfAZE?=
 =?us-ascii?Q?l+uBQI0l8CDtYNkPUgHrZq/jD8FtY7q7furPs3Zseq2uceFDM/170wcDXg10?=
 =?us-ascii?Q?Uo3+SQaXa3eoIhJD8m1nfjqTrgLTuAjEWqzuP9Iv2fSQYdBFCCUFxuR54nHe?=
 =?us-ascii?Q?OXACq+QDOUIMPcVBLcKdoWGNfI4SrkEYB1Ln/2u980qiQRfK8IbQaxxO6K2O?=
 =?us-ascii?Q?Ag3+XBEYmJ4i9H9zN0hsDwcBvijrZmE0sFPmoXUgZfU7fvW+B81epijsZqEr?=
 =?us-ascii?Q?WpaRpoM3lFa1ziDu1c89uEE9VhUNLGe5PM1u0pYjhbrv8QXks3wfyEMP6LVt?=
 =?us-ascii?Q?MqNWXNA92vH5c9gPKn28zoMJbMqvTStr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CoDUq1f/1+P34F6rgPmSnqV1xnrRWlmB9M8rvM7IWIriNh3MzKF8+d+/6t7f?=
 =?us-ascii?Q?MILPOehJuB+MtRGGSD9mcX2ejIevdFqz45d/IAz8kEhlzU3vREi0si/fHefQ?=
 =?us-ascii?Q?d2ZTDguk353JCN4zV4HXFobLeDrQtbQb9BuOkwzorfHRXgveAfPaCDs9lZmr?=
 =?us-ascii?Q?7DJdhaIHFtL2LzhDl1Bd+3IBOzcZSXcHtIOeEfkDLMS1Hb6+p+EuIM4vS/EL?=
 =?us-ascii?Q?zpxz9MmkBHwtdDWi+ZqP+Hb2OzDP4a02jbdK5YMcNUUEoZ7rwBGWmGgl1AJd?=
 =?us-ascii?Q?Q9dfUfCkuNCHlQbiqtIQiHDjJm7Dqeuio+9WvMyzw5hRr73QZKf5Y29T66WL?=
 =?us-ascii?Q?AxdxBR2nw7KCJ8pFVoZ6W/ffhh0i94Azu62wvYbXiBTabBxVsom3t7rCKCWb?=
 =?us-ascii?Q?wgP+eoCMNRQe6bQYkg7pFCa1zAvn+JDxYnNznj9coZRSkU8u8lR/qA7iIr6E?=
 =?us-ascii?Q?Yr+zEWKJJDvx7t7sei5gvrJSw6PefR4lcGDTmxmuz8lBIBtxsoVqwlKxfK96?=
 =?us-ascii?Q?n8F7lVq6nTwAwgnkdx4PwBTWJ7CIcpDKTCvLgUvkTYvMn2VYjCtJPvfyg6Vk?=
 =?us-ascii?Q?n5fwpSJU1+msaCjG+5V4JmptKRsPuyx/4rdb1gyrm9tey0b6S7nGtsND6olL?=
 =?us-ascii?Q?vwybGXHvSly025xRwo/o4YzQFQQRH806LHUHh6EWI7aYlI/nlTm3FM0y8rVE?=
 =?us-ascii?Q?wwNrU2UJukT3SIhq64aciaYLl3cD2F/AFE6aCt+docA5GQOdfONKrlCkPI/h?=
 =?us-ascii?Q?IfBzyo8zfczOpbZy/kzB4P+9AayUZ+DzUREkRdwnio6/71wBy3ALakCv3/Kg?=
 =?us-ascii?Q?DmdfvHs6oSuLPPo+BtUdHztW+G6B4iwxqki6zv9MQoK1oGagc91OHy+huv9u?=
 =?us-ascii?Q?Ih8jTpsT6wOSdDg6O6t1mTzKopYA6e24BoYIbKkk/jaPZKvBM7GMdp4lLjkM?=
 =?us-ascii?Q?vsXrtgIwN6s3EknJLStjXPDc8SXzyY0JlVEcOX5qrdrFkNT8eRl5oUV84YJZ?=
 =?us-ascii?Q?1ooa05Ytx2zHTTCFuRnfknDrep1c2YVs4t45OV85rAHOyOpXT4R0okAb2DUv?=
 =?us-ascii?Q?i9Be+P7TXrsD7iIgCd8riRV/1dALOzL0CPNJfjpfa7d6i4SHIX/jwgfFoReX?=
 =?us-ascii?Q?mEMZE2p8m/+tw4QLbqCA5gqGtwN+U/SuN6d2A7sPe1gY9ITl1dcWmzXTd1Yg?=
 =?us-ascii?Q?kg7idaETBtg5XkiENcRV9w57/yWmN4zAkhBsT28IKoxVTBRiSR22vkwK+IcD?=
 =?us-ascii?Q?yT7ApqNwu7lUlgKsBAG0QU+4wBfE/3lfaYIKVzv7IL/wGuSyEp8NV3HvvaDO?=
 =?us-ascii?Q?Aa/R+p9Kbys8k/zJmmsgZcDBByTuSYegWdfF4ImI4jokY8cD/1pSzfHgw4AP?=
 =?us-ascii?Q?HQ9bo2fwkRQiIdugH6lfQ/FtqtNWM4wn7sOMObLl5qhitUPJFnvFmlJioHez?=
 =?us-ascii?Q?HF6+0rSrElmd52zYVAGjJ6PORVQTjdTCfiyRDl4RMO4O3hRC/Gdz594FIp85?=
 =?us-ascii?Q?BP4mnQ9bjx3YT4tDcajWQQMUKl+0FZVVuc+ZCT6xugVTEhONbzA8oLGGLW0F?=
 =?us-ascii?Q?DuqjDsAl5IVRTHVjcEa4KvivIbLlgdnnxI3F3T6n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ee72e8-a579-4f92-0bc1-08dddc271c9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 18:11:10.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tV7baC0/VPmKCPlDOLSy9l2TZpoo8VQ8vQ8YLWW0W/8uJZTj3AXCtO4XRmnpe0vK7hcJY3MmV6r6FjSB9trRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7410

On Fri, Aug 15, 2025 at 08:05:12AM +0200, Krzysztof Kozlowski wrote:
> On 14/08/2025 20:50, Frank Li wrote:
> > On Thu, Aug 14, 2025 at 10:25:14AM +0200, Krzysztof Kozlowski wrote:
> >> On Tue, Aug 12, 2025 at 05:46:20PM +0800, Wei Fang wrote:
> >>> NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
> >>> Integrated Endpoint (RCiEP), the Timer is one of its functions which
> >>> provides current time with nanosecond resolution, precise periodic
> >>> pulse, pulse on timeout (alarm), and time capture on external pulse
> >>> support. And also supports time synchronization as required for IEEE
> >>> 1588 and IEEE 802.1AS-2020. So add device tree binding doc for the
> >>> PTP clock based on NETC Timer.
> >>>
> >>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >>>
> >>> ---
> >>> v2 changes:
> >>> 1. Refine the subject and the commit message
> >>> 2. Remove "nxp,pps-channel"
> >>> 3. Add description to "clocks" and "clock-names"
> >>> v3 changes:
> >>> 1. Remove the "system" clock from clock-names
> >>> ---
> >>>  .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
> >>>  1 file changed, 63 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> >>> new file mode 100644
> >>> index 000000000000..60fb2513fd76
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> >>> @@ -0,0 +1,63 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: NXP NETC V4 Timer PTP clock
> >>> +
> >>> +description:
> >>> +  NETC V4 Timer provides current time with nanosecond resolution, precise
> >>> +  periodic pulse, pulse on timeout (alarm), and time capture on external
> >>> +  pulse support. And it supports time synchronization as required for
> >>> +  IEEE 1588 and IEEE 802.1AS-2020.
> >>> +
> >>> +maintainers:
> >>> +  - Wei Fang <wei.fang@nxp.com>
> >>> +  - Clark Wang <xiaoning.wang@nxp.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - pci1131,ee02
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    maxItems: 1
> >>> +    description:
> >>> +      The reference clock of NETC Timer, if not present, indicates that
> >>> +      the system clock of NETC IP is selected as the reference clock.
> >>> +
> >>> +  clock-names:
> >>> +    description:
> >>> +      The "ccm_timer" means the reference clock comes from CCM of SoC.
> >>> +      The "ext_1588" means the reference clock comes from external IO
> >>> +      pins.
> >>> +    enum:
> >>> +      - ccm_timer
> >>
> >> You should name here how the input pin is called, not the source. Pin is
> >> "ref"?
> >>
> >>> +      - ext_1588
> >>
> >> This should be just "ext"? We probably talked about this, but this feels
> >> like you describe one input in different ways.
> >>
> >> You will get the same questions in the future, if commit msg does not
> >> reflect previous talks.
> >>
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +
> >>> +allOf:
> >>> +  - $ref: /schemas/pci/pci-device.yaml
> >>> +
> >>> +unevaluatedProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    pcie {
> >>> +        #address-cells = <3>;
> >>> +        #size-cells = <2>;
> >>> +
> >>> +        ethernet@18,0 {
> >>
> >> That's rather timer or ptp-timer or your binding is incorrect. Please
> >> describe COMPLETE device in your binding.
> >
> > Krzysztof:
> >
> > 	I have question about "COMPLETE" here. For some MFD/syscon, I know
> > need descript all children nodes to make MFD/syscon complete.
> >
> > 	But here it is PCIe device.
> >
> > pcie_4ca00000: pcie@4ca00000 {
> > 	compatible = "pci-host-ecam-generic";
> > 	...
> >
> > 	enetc_port0: ethernet@0,0 {
> >         	compatible = "fsl,imx95-enetc", "...";
> > 		...
> >
> > 	ptp-timer@18,0 {
> > 		compatible = "pci1131,ee02";
> > 	}
> > };
> >
> > 	parent "pci-host-ecam-generic" is common pci binding, each children
> > is indepentant part.
> >
> > 	I am not sure how to decript COMPLETE device for PCI devices.
>
> I don't know what is missing here, but naming it ethernet suggested
> there are other functions not being described in the binding.

name 'ethernet@18,0' is wrong, which should be fixed as 'ptp-timer@18,0'.

which is independence device. This file descript its's bindings.

Other embedded pcie devices located in ENETC submodule is descript by other
binding files.

Such as MIDO: Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
NIC: Documentation/devicetree/bindings/net/fsl,enetc.yaml

For ptp-timer, I think it should be complete enough. Do we need descirpt
its's consumer? An example

https://lore.kernel.org/imx/20250812094634.489901-4-wei.fang@nxp.com/

+    pcie {
+      #address-cells = <3>;
+      #size-cells = <2>;
+
+      ethernet@0,0 {
+          compatible = "pci1131,e101";
+          reg = <0x000000 0 0 0 0>;
+          clocks = <&scmi_clk 102>;
+          clock-names = "ref";
+          phy-handle = <&ethphy0>;
+          phy-mode = "rgmii-id";
+          ptp-timer = <&netc_timer>;

This phandle point to ptp-timer@18,0

+      };
+    };

Frank
>
>
>
> Best regards,
> Krzysztof

