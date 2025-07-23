Return-Path: <netdev+bounces-209297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3361B0EF5D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1628C17EC33
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C7528C5C0;
	Wed, 23 Jul 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hh4MtpJq"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423CE28C5B8;
	Wed, 23 Jul 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265179; cv=fail; b=sWAonzTbffsdbaJwK874RW0mifGndyOEK6xbG5cUau7aoTu5OOd6Ep6xBqdsAkIVw2A1A3KdOvNXnAWTyjn2HlGn/XhTXAo+AqFyTf9Q9zrRPwAP55+ADT1aC/fH1tOM5z7ErT39RgpuQ5eqA+KoqlT2z22SfMHEyVbboAsgtDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265179; c=relaxed/simple;
	bh=yarfPgd/bm35fongnymHeibthnySSotsfk+MKgP0hbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=afekS/sCM1Rh1WAjHveBj63jqeAaRbK4ovrSbmJzuGvjnHpeiucEvGcPY8HB6i1vuIlNO4QbF/rp0jdFSQKpi+xAgsLyn3AjZXcjKlZCky6V6X1pf+wyPPk3YaYui+uKGWKt29z8yzkRSfLT3zwWeYQaI79nJMbpJnR08QsmZSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hh4MtpJq; arc=fail smtp.client-ip=40.107.130.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxt6Raf3YRxqGMpS1E37eqdhXYMP72ykZKJq3TcEvlEv4DWK+UFbQVB7ZVRf/OrE9z1ysynNG3Mcyc3mxHN9R3psHsrBHbovr9nEsNW/+PUtlfEold5HPyrZ4w+lqBPUFy44OK1CocDgPz0c5C61rSzF0N/ItADQ+rs7wNNZ7ctwhwbRPDAmmqO9l1jIq1XEc9KAlyqYeSnaWc3S0uC/yvFLEkUpNosx8/LCpbIcTssnLwhXsHWPe/g5Z5gR/2RtLo9q4Ud98vpGjg8+zGSz7pAYd024h+6u6wRtlcmwBhH3mPM+6B1iPHnY4uAaKdRlKe0LdZToKTEI/VFhzo2zVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x22JPadYfcA3LTup3dk/uYtJBrO8ua96jm6UsCu0nao=;
 b=HL10ruE0lTnQaLnzZ5qVn0C82hfI8kIya23bL4/AdhpHVdJVgnnV6LO23lVfvdM767xe8hAinDX3uo7g8OSNCvYt57KWEDHigC+ARS0ds5/PhYL7PZmvyGcs3w3LChMlSlWNG8vvFE2y8BXNYULb05TXHTTJnry0dzpvRQiw1uDqOaWkRvtqOcvyNNraHCMsdFj/Y+wdD48lxXYugOFQt6AsnPo7V2tQXkCVqq5trFT5UBcF0u77afVImG/PaJccDue8niKCnCO2sB3vPf+kTuBy3yne31SxtCHfciwq78Hh9I5PjCzSCtxuKbyIlGfB6ZSy9CRku0t6ZhjJGQbJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x22JPadYfcA3LTup3dk/uYtJBrO8ua96jm6UsCu0nao=;
 b=hh4MtpJqhM+i7hu5xqm5+dnLh6bgsHZiHts3+4GYw8lNmF07z7UwUJ95C4t6JLOuQJpcqS7CU0LZ8mG1meL6NoNflk/LLfvTcHcUJk3uteeYyjZ75Gl5DTLpxPWAmB9jerGqYe906twWU8YXI6/LlHW7cVv+xRLY+kccwqxZ/yPPSmfoI3yAJo79MXoCwaEKDXXcBSiSFrED/hJPWnqMXMpNn7x8NbRNRNzniosO+W8xuDgo4Ywp6kzjNAvuiM/jmgf/qTL8EKf6mnqlobZ3XQM3qDkgbnmB9kPj8QPr1rDa8iX1j1YwkWqwvjUB3QM2Z/gdWkjqwV5XL4EwwrmBNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 10:06:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 10:06:12 +0000
Date: Wed, 23 Jul 2025 13:06:08 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kuba@kernel.org,
	n.zhandarovich@fintech.ru, edumazet@google.com, pabeni@redhat.com,
	wojciech.drewek@intel.com, Arvid.Brodin@xdin.com, horms@kernel.org,
	lukma@denx.de, m-karicheri2@ti.com
Subject: Re: [PATCH net-next] net: hsr: create an API to get hsr port type
Message-ID: <20250723100608.apixcv3ix5rn7ydz@skbuf>
References: <20250723100605.23860-1-xiaoliang.yang_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723100605.23860-1-xiaoliang.yang_1@nxp.com>
X-ClientProxiedBy: VI1PR04CA0099.eurprd04.prod.outlook.com
 (2603:10a6:803:64::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA3PR04MB11153:EE_
X-MS-Office365-Filtering-Correlation-Id: 28482152-57be-4431-bbcb-08ddc9d08d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t374BkFMWn8jNXY5jRATsavRklnCB8lK+tkh6lm/tK0FVkmiNP5J2r++oVHG?=
 =?us-ascii?Q?h577PZHrUrFodx5x0Yboje0R9slhKPqRq2+JpAXsLCNVa4G7xCJhvl1xiB1a?=
 =?us-ascii?Q?qHP7HzDk1haTB/cxxqaELdGepCNNHlixALXwyszvkXQPkJIBl1BC701zKqjT?=
 =?us-ascii?Q?eExFuZP3wlRorssRWC49tgtQ4qRsYO+aDMIuRaQljIEq3LsQyv9C+pQNhYTW?=
 =?us-ascii?Q?dIl0WGDONFgSZ7jfxQtc6KEqAYJ5AJjr9oXjUxFPMwLwE58T/xsp9eGxBTcr?=
 =?us-ascii?Q?gJ2oohyNIhPEFoETcpmdnRlpMCXdHmD9MFDmb3N6ow/gfxzVx1O9T7UqocAA?=
 =?us-ascii?Q?IOydy0H41stw6mr1XgUgzoHpyPyA/XRd829O7CYbAt4Ted6z6/4M4A1h+kX/?=
 =?us-ascii?Q?T6jP3vzqAuUclsCX9HYzrd2V1tCJMppOFdg9vyyqSBqX/NQlYa6MUb1sGYMd?=
 =?us-ascii?Q?ncRZ3rZTX80l5im/ajv8ZT/QWMfM5/NfKj8JRcm9G3YW95N4D6+ebjIoXfq5?=
 =?us-ascii?Q?phJBnEmSSxf64tPNlvmNnOK3bMBeFXRDygjUX/AjtzXu75ed2BS0wAhTl98x?=
 =?us-ascii?Q?2ygoOGoVbl4qBO59x9abUlIlgQqhpfUJuR190WlVKfW2tYkYGvWgpZDUM2PQ?=
 =?us-ascii?Q?qvGG/owFqgHQ9KNfdkmH47PE0mJkoiCeOHIWtrehCuhw6gxTRGnNcauM90mu?=
 =?us-ascii?Q?AqFmlKxrjt3TwsWMhrehhzr0WbKQU+020sRsIIn00+W5QlT7foutQ6xP1y59?=
 =?us-ascii?Q?G26Om8t6keJ122Ga/SYwKVh9dnMFi2PlD4lAMfB/XzXa4gTZBFDrinpW5YTX?=
 =?us-ascii?Q?w4K0msT50LRLWBO45ltVaQuu0GZBvrf9pzoNNxg/XjEzuDvB3BQQj5n+szvh?=
 =?us-ascii?Q?A+zCFBvFY4ziuiK3ExxLuGwPewWu7umWNizFuRLZLYmsTfSquhHa4twkARkn?=
 =?us-ascii?Q?xTRjeu2ctCgij5Ob8JWqbbl93AVCo+KDFxIBNwYoS/ALC9SPOAumEZX8COfd?=
 =?us-ascii?Q?QJzs6nxS+/4Ii/gow153JCuh/Zy5VPly85RAI25kuiqM6/Vm4hFoBSPtKCpv?=
 =?us-ascii?Q?2HxcHp1/kujHUrpghAVGplT9GxhNlqIEbvgFJtO0zY8fRumR81S5A5Pw6uCU?=
 =?us-ascii?Q?EVZ6Ie5bVRj9M/u6TfH7h9FGtUrATOxt4BVpfYjATG9tH86CYjE0+Dq7Q0gf?=
 =?us-ascii?Q?7gta5lodCwtHkbLj8g84G+6UW2v4zJdTh5iPUYSNJZnJO3MDZFl1V1zP++Hd?=
 =?us-ascii?Q?AbEzUX7T9YfPBCnJRf2Wq7B1xWXNydUU3gWMLpO5qzCig1yGkT234Lx5q9KS?=
 =?us-ascii?Q?CWNP8gIxrXULf7Zk8TLvvWkjATa5gZRkG1QC1ps0ZNKIYUaMp/fSWE/N+hRR?=
 =?us-ascii?Q?XIljm2UvZ7PCh6Wj0J2EsglKfqB0qIujgj4Ur1gSOwTvsyeJ3O7JPCGb+i0k?=
 =?us-ascii?Q?hD5le7QRsUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cB05h5Nck24dO6MFp9es3xUkfCx0sx4xqCgv1Ld9kgPduTSaJd7FklrDf09M?=
 =?us-ascii?Q?ZnMR+FCvKA3iLl9bTot+JPcIIEaD0ha93y+vGTWoX07CmIXCHs5umdicLY+E?=
 =?us-ascii?Q?KMeTnn1fdgX6sBPLatnNoDpMnaYBFYPsyWegkeJt76AGR5IBwEAxfgf5PdYh?=
 =?us-ascii?Q?vIjhe8chXkEFoZjeOQTcrhp5HFgmjffkqx7BZ2/wMoQHZLaYZCCI1jF8t0oO?=
 =?us-ascii?Q?Z8NqZJC3DwC4O9bsLwyxL9AXyIzPVrOSXUR2HzdT2RYUagolvSMPo3eyhVO1?=
 =?us-ascii?Q?O831zvlz2zmJSnVYtW7Z5D35khDvLKgxjTJ8YSTx/M0CVm1oRDSp0mxkr9kB?=
 =?us-ascii?Q?MFY1MLxGzRYb42gNBeOAa6w/Jtp9Kw63arT6Fn+wSB4HbURcoGZkk6kYGXh5?=
 =?us-ascii?Q?NvPeZaYaZnHSFZfgYifh7ZZ1VHsbcbm4KmDLgN+YTUFKIMAvPTVuD+PKCYqm?=
 =?us-ascii?Q?tAx0JSg08bl+rw8DsZ3Joyi2wZYbrH6MhzgSWvce0hQ+9XRpQHV+WB9Vw8ag?=
 =?us-ascii?Q?P+oerhK+7OcY2uWlZPgB63DVislmBbUQiN3URfiaQMDZq5NTSHNVOi2PBIr8?=
 =?us-ascii?Q?ECZeO5ZH56PkATCcUpcptRQtCarIMsESpNCxae4sCHfdvk0IcaanXt1gP5jq?=
 =?us-ascii?Q?j/h24Zxhy8VRxxQbrswVN0/l/tdIxph4HRYPJMDeEcZ81jJaXcy3fKjKbzdJ?=
 =?us-ascii?Q?PzXVET3wnwLNFTT+qV0F3/co7sUho2VtMcGVYA/pe6luP8D8fC6tS/PCnZuC?=
 =?us-ascii?Q?ZEtMXApoj93re30Z7zhfNRMg521IJrHxTV30ck9MzrYwgPbNg8rMbtjO5O51?=
 =?us-ascii?Q?UcYj7O4sJ/Sj9Hp0tODh5opVprVv8aJSXHBSEE7brfDW/Ux1JE7QV2BN02pq?=
 =?us-ascii?Q?/lHLt71j9s6Z/7fdgpFE47wuqJKrBsIq5av6eANVjYm9x9Yh/0Q8XJ7PaTec?=
 =?us-ascii?Q?P6gypoolvUKxIrfHsJIS0DfSLvQTbXvf7f3cDdyK+thWbNmFE9iUyarfIOcs?=
 =?us-ascii?Q?LVZj9wQ63zFEc8gLpgEvGpz3EfYilH6yY3g98NEdNT718uMHp43MId0xMfLQ?=
 =?us-ascii?Q?KzHvfB7+nRy7yOj0z6UnIVfPVd+GF/+zrrxyzLN3xuEFOOpLuwaRj34JZWZ9?=
 =?us-ascii?Q?Oap6BGEsJV4Lyb9tWIe74aGIGvbMGN5DSqKib2zFwsnDUjJ3q3Gs8s1Oa0Tu?=
 =?us-ascii?Q?uJ9sOSw2eHILFkuVFqjphERqkZ3a+j9HRHSv/xRadOXHEbNoR2Snfk24WlDO?=
 =?us-ascii?Q?WQ9sxEpySTrj5ZJNWWYgUgFTVQ7LZ/1reCpTVUPS+Rq45GrVSOE++lOCb+f1?=
 =?us-ascii?Q?pm2CtIsOdDqOuZ7Sw/8hSW4JPWSx+Z8X56tuUdRXU4yUhit7YuY/ZAtsFQ7o?=
 =?us-ascii?Q?M2mPEWb5baGmjOqA3JI+kFe2zVxY2UkdNsHQnRypuNRvMuiCKBK8MQpwvt9A?=
 =?us-ascii?Q?gnyo4O8xcpmWn0Db3qs1j2L0R2titL+LEWlj75DGVVu4WDoSfyKjev+9SOlO?=
 =?us-ascii?Q?UxmN/Tc0ZM+nKJzcn0seMlLi7/PNNp2uzfn5Ygw3RKPgIYnI7BZ4d/P7WRpI?=
 =?us-ascii?Q?mC8jkf8Iy0Yi+BQij442oGEmQbxhqK+HK9GdvQiIbhDc486LwWuEWbDXAulR?=
 =?us-ascii?Q?zfKZeS5FgbOuo/pv2J0RbecQj96onriBuJ8cF6xIL5ym8kolA0Yye4thhxcA?=
 =?us-ascii?Q?/eSe+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28482152-57be-4431-bbcb-08ddc9d08d18
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:06:12.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OucdW0hx7ce5Wlu8myXaqaWm3g1U68+o9mKFUmOQ/Q8s5ocPSJ42mdgXKKcpHoXTDEzFaat73CNtDXexf/kFuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11153

Hi Xiaoliang,

On Wed, Jul 23, 2025 at 06:06:05PM +0800, Xiaoliang Yang wrote:
> If a switch device has HSR hardware ability and HSR configuration
> offload to hardware. The device driver needs to get the HSR port type
> when joining the port to HSR. Different port types require different
> settings for the hardware, like HSR_PT_SLAVE_A, HSR_PT_SLAVE_B, and
> HSR_PT_INTERLINK. Create the API hsr_get_port_type() and export it.
> 
> When the hsr_get_port_type() is called in the device driver, if the port
> can be found in the HSR port list, the HSR port type can be obtained.
> Therefore, before calling the device driver, we need to first add the
> hsr_port to the HSR port list.
> 
> Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
> ---

An API with no callers will never be accepted. You need to post the user
together with this change, for the maintainers to have the full picture
and see whether it is the best way to solve the problem.

