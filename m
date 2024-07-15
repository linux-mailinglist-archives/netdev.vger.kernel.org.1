Return-Path: <netdev+bounces-111489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5C9315AE
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A90E1F22DB8
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E118E74C;
	Mon, 15 Jul 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n7mvSral"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013033.outbound.protection.outlook.com [52.101.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EB618C334
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049781; cv=fail; b=aRODS2AYFxmDN+QRKZHmekw5Q1vVG80BxmWd58KRIaYAeC8WyaSY5QtZquQCh0FYDPkbkGih2bMoN91FsM6ECEb598X1K7ZZw4Zcvjvn4bEDMdOrXxAuHeg9qw+m+IE7i5HEGPuj4TcPwuYAuYJa75KxBbKiLu7spUJQedU7KEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049781; c=relaxed/simple;
	bh=EyMdF9yKXrZleyAGcd5id2+fijtj+HDM1PEMFO1A1P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tWHmxmEFij7jRED8T+pizWtV8OxBxCRDXIJEUYYBlk4l+x5E9wsmArHlbY6Zha5Djpif46sZ2I4C9x+ll3sT9uq0XyYe0ilbCDVyw1Pyj48s328osARRdi+lCMW4VCnAIrq5Spq56g1YSWKzcfxaHQUcjLVCOqKpZiAIwyb3VzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=n7mvSral; arc=fail smtp.client-ip=52.101.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyc2EmO+7D799cBqDIKDhXHYtgCEqZuQ4U/ppfkOzvWwW3EYAhuohsfMh9TUlfqog1FV++rnZlZP3XqditUHCrIHBCZGgTam/jqWg4zuTccTbRjaYyYoAgM1TtHMj26IA+sJhT78kY7Adq9/G0rgXIyCN4Yw9tYvkCW/B9PIAIJVnIox3b3LAzrPhbOmF5+0xuIlQu3Il/RTdgRXOYDpELD/qBEzrD1w2UPnjiEaW/RK5BIf45aTe5VkX2HjXUFitWbUGhnAvgGo7/ZKN4iPkByI4rK7v28/DfuvROTiezpO+uSHDTsEXa7n2BlKAYGW0HOIk2yqJyZf1L8cNiG5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnVfi+NAhpYLsWrirszyUHgTVBcAXYDOIOHjKOS3njk=;
 b=rEObc6v4C8/lzX1k84lJ1NdesylJ2ucGJnnyid91LUrkPUoVieWuXF8Mkj9jY9Syn2AwirOJ1pN/UZGLHuW/u/KMrcIKTyf2ZuwfRRNgzn8/4904IcAhmJhGhxyrz1o8paIB4lpyvG8NoLxaaCVMEyvLWbKsGVXBVG8zbicGMs2j+hI2AwjHmBsQCS8IxSaXwSUh8jyE1yejOTxYn4xE/puRsxuuJ01gUHVM1eB6KEIMKj4zQ62HIwfQ1vUZxHgAWJZ37Sc2kQlX88cBy0/M1e1Od8+anLd3DXnPJCROt4Ga05CjMkedhqvqrb0a3ZTyLCjjHsIdEpCpuyB+5d+VXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnVfi+NAhpYLsWrirszyUHgTVBcAXYDOIOHjKOS3njk=;
 b=n7mvSralHOpRK5hiVSMZ+SelMKqWnQnpPSRlGErO02weHIp2+tz0W18CMdBxGad5cKQaUF9rhEUtKk8QfpkS7Xl6J2ZrxTGBEzVPDXJnWOxnJHuX9w8dznosNr+C8Iwb4F2b9ERh9lsG9m6AAebVv03QmioZNtzZ6e5TkQSN9II=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:22:56 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7741.017; Mon, 15 Jul 2024
 13:22:56 +0000
Date: Mon, 15 Jul 2024 16:22:53 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Message-ID: <20240715132253.jd7u3ompexonweoe@skbuf>
References: <20240711114535.pfrlbih3ehajnpvh@skbuf>
 <IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240715115807.uc5nbc53rmthdbpu@skbuf>
 <20240715061137.3df01bf2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715061137.3df01bf2@kernel.org>
X-ClientProxiedBy: VE1PR03CA0010.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::22) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AS8PR04MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 822b2863-e7df-484b-19ca-08dca4d13d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ztnGlNqd9+T/t2YUljE2ZeFmOdiVsb4LAP97b94f1657GqfwTEK8W7qD8Cl?=
 =?us-ascii?Q?MEqcYQ7oUL3h1bXKRYYnaZRfRCGW2m5LKicxEeo8xv6mZoJKdpmWWZk5gbVy?=
 =?us-ascii?Q?p1cM4gDs9WUNHufgtCYiO+jK5WAHpTyBgh2TIvelxxQGgCsHiKqr0FJq0SEk?=
 =?us-ascii?Q?T34j0ZpTIhhZ7fHzLTfnMMLkkxbPpYbnkQ2k1ly4BKtvCq9fn+MGw5FKhT8E?=
 =?us-ascii?Q?ehyM01A9RappRFLM1o0Uks55s3baW7EHteWypZs2RQd5ESRkXb4LcHeenX5q?=
 =?us-ascii?Q?OAm0Ly/nzgRrkxXtR5R2ixBPKjKEB8Ej0qxrqOnQXPXC/uPeiCz6AvQjNJ+O?=
 =?us-ascii?Q?fShw1Wjyiawob31Sfk2iX0eh255x37OcHYy6AUYhvih1jhTk2fP5b3EW3sSe?=
 =?us-ascii?Q?uEPARPrDMK7XRK2YMz4XSJC667tFMZQXKSYa7wYR50PDwD920q8Ua3rvwPVS?=
 =?us-ascii?Q?F3xQKo6yl1rXzooR2rVlo/CxCu2id1PhuX3mQeYcD0n87anwLnPH1lNH+d03?=
 =?us-ascii?Q?0cl9RKKRrsYbIrZLsskK+zrbltjJrbjbmAzJHrBl/qPLRPq41PJLb4pohC+o?=
 =?us-ascii?Q?U9oUTDANo0OrVQ1Ktw9ywdrigZX4Liks5FURyO7InScyp5NumKk8JkJcfuuD?=
 =?us-ascii?Q?5dHuuGx41HXOUv7GPB3nas+1lq0fnk/kz+281mhQ6Zb7638IkwJxsJoG+VqT?=
 =?us-ascii?Q?H2aWmH5NayFNvoIHvIMBjlWXWsCv0cJawLQKbjKWYZUIhsMeAk304dIZLb/b?=
 =?us-ascii?Q?zW4Takytitk8CciurW7s8qHtXHpNB2RQidpLK7W1TqikXffbWl1YCJULKaxk?=
 =?us-ascii?Q?N00BUGBndjKDIZQ2jkF7DmZIUkISRRAIynp5jQHvXbHnkpgCe6T8nbYj+ihn?=
 =?us-ascii?Q?fHQf90ttCXFAzrgMpR4QknraSgOx6qohLYCuCJVPUQDccYk4G98ZwGT6CKoU?=
 =?us-ascii?Q?fvqBAMmJ8GCkb4eXq0ZJdaj/8rTSD7laGU1QsvHi7kyZdV2mlvrysLr4rE6G?=
 =?us-ascii?Q?HJiHlsI/Kd6rAnEFm1sJXXMXBpekmJON545Ha1Rha0R+yq4gzezo58MYMRoT?=
 =?us-ascii?Q?xO/os6hKFF8QXLOb09g8+kWWoc5PLjWBw5H+XnKwFe4Q5rWvHhUDbKUbjmCC?=
 =?us-ascii?Q?kK5/eYBKZfNNAFKC+E12+B8+eR1fUGPEZ2QyUoQQOqB20EYk35bBZDB4cUYL?=
 =?us-ascii?Q?75qtwOks6zrKVHT5KwVZrUuQkAkdR0zVHGXyfZidnNPjMBw29Ezw49/+US0b?=
 =?us-ascii?Q?YYJxa+04j6W0k9hpL9mOiddeYkVBVWlzdA1RfG6HAguRKCY99Q1jLytewWC7?=
 =?us-ascii?Q?quhpTnEw5KleW9UgMef4qY8voshMNRC8AI80vEQkhNPnEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uNeBpy1K4WJKNt67Svc1/1EBAQBmXR27o0ZgrwWTOqvT5aAEPhJ09FKlKilv?=
 =?us-ascii?Q?x2hL7cdBYbvmbhDhQAvP9W3NwnAEXp/7uIL9YsH4Wpiwi4PItuQoD0Q/t5uT?=
 =?us-ascii?Q?T95UifPLkHoDRaRK3Lbaz+qU6ziBwc5ujwP4jah3Pj3qAWOMZxh7E39yFHNb?=
 =?us-ascii?Q?J9jQBDVgh1jxEiuPipXe68FA8bGr5yj113FSdJ7gfIN/FoBwMqE8XOCb6gMo?=
 =?us-ascii?Q?luMbeCrsHhTD+yGBtjcMEDGSCt0ywpVCL+g/N8XKOggEdRQ9XjZwQfD3cUQ4?=
 =?us-ascii?Q?fYwOqd9RuOsmuu3gwFSq3ux12INZr52SM0ziyxXF00FDhXUVtg25FG9Xja4i?=
 =?us-ascii?Q?/npqu98L2OGd8uV9qKYpZPXn0YaF1+OSPfcPihHKKbKAPNz3dbQynm21aQTM?=
 =?us-ascii?Q?9A1UNHSjFnC0/6EJ89Cpia8AzoZyiVHKATstAtgsrwgW8OOrZh71+mLffOCs?=
 =?us-ascii?Q?iLXR3w8nAWj1/JEX9YSLuUk8yM75lp0ATBamRxVas60GCVENIWKgwr9IHimP?=
 =?us-ascii?Q?mFr4EkEtv9izswhat5d7kkPc5gcS3/aum+o+k+47ytYCw9jCQvujqRJZVFzj?=
 =?us-ascii?Q?YHp37q8a85BtDUk3RlhEOpDbKA7WWm8wrecGLS2Wk5pfujSDBxuT/DX7xVk+?=
 =?us-ascii?Q?SlTRXHeze7ECTD97Gfk8JZu5Xzy4OT7sn0QadcBJz89Eunkt4IxLMyAm1ynV?=
 =?us-ascii?Q?h09llGawjxAjCnvIQOLwKhCiZkJz8PGIE4sf1M+B6oMPVzehSTOdyopScB0z?=
 =?us-ascii?Q?0sHoNsCk7a7dIO41QnTkdC6J/4p7uHU7ALKhjbAeEeh+fKSlQyj60LW9khkL?=
 =?us-ascii?Q?VWjM2VKYmHNUPKaDgwpdJvycv48sh22KNDbpckZ5hpMeqo0KDYvWdJSk6Scd?=
 =?us-ascii?Q?5X0vdh/JFm1FE9NJSbIDapoPMdzBhoabHKuxcrbU9QpZFuuK43puD/+UKHQ1?=
 =?us-ascii?Q?mu3HfXcYwvVVermZpkUN8ZrDVtd4FQ5D0dZbCdill+Dp60a8XPV11dMx0iaZ?=
 =?us-ascii?Q?6bHPEgyUrFAAOMCgpXtv0lkVVKggwNTtjYO9dvf47ioMHqTeazjguV1e2xAS?=
 =?us-ascii?Q?zHKkDT0Iojn9dq4iza2c+uUhN3MxgvWfarQAqVbnynUa6/6wWe9ytEpXe8Vn?=
 =?us-ascii?Q?v5oT+fJOCZiTWJhfvw0T3QmudFVMb6xjaePtC4YDaWxADXPGhJDLhhbManb8?=
 =?us-ascii?Q?kN/NKctyfNlEYrDK7OShtbZtSWVoCs7FzIWFM9mYEWoNduT4ZXRv4H3KqoyJ?=
 =?us-ascii?Q?mOEAWsr+Ii4hv0Hwx0N07B8q1/OJxvENxINZZNpsnmzhLtmfnIjahVhiGzJ5?=
 =?us-ascii?Q?1/McFAH7WdzROnVkfnxl+1BdrwRcxnJ2f8NOFLXd/7DeDyCRNkbu94ywXq2h?=
 =?us-ascii?Q?MX8gA73Bx6vJvlTRO+iiCFG82z6DMZpKRXQA8eQQ9Ye6iMSFe3nTsWSrYdYj?=
 =?us-ascii?Q?d5JjdhHxw0fp7Cq7xN1BeoCXhSETbrS9OohYiZrG0/asuRFqssj1WdgqXJdv?=
 =?us-ascii?Q?UWnaHalHrRqhSQeX693gpziksi3RRz6z8ERMlRbbUrBz/AD+9dly2sCuK/at?=
 =?us-ascii?Q?vclRN1hT1GNdvh8EahRj7vn9rfk6UY7LWhQVk6ccaOfwEVR/jB33GH4/lVsJ?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822b2863-e7df-484b-19ca-08dca4d13d09
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 13:22:56.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIrei5mYeo8Zqh034jTV34GbzpVmufoES7AIuVIrqD/iDfnH7EeS3qNZhVj8hSYMM3hIWZqse0ZPWoZ0QxDfTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190

On Mon, Jul 15, 2024 at 06:11:37AM -0700, Jakub Kicinski wrote:
> On Mon, 15 Jul 2024 14:58:07 +0300 Vladimir Oltean wrote:
> > Looking at Documentation/networking/ethtool-netlink.rst, I see
> > ETHTOOL_GRXRINGS has no netlink equivalent. So print_indir_table()
> > should still be called with the result of the ETHTOOL_GRXRINGS ioctl
> > even in the netlink case?
> 
> How about we fall back to the old method if netlink returns EOPNOTSUPP
> for CHANNELS_GET? The other API is a bit of a historic coincidence.

Explain "historic coincidence" like I'm 5?

