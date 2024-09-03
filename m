Return-Path: <netdev+bounces-124756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1265396AC75
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60635B23F64
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350BD1D58B7;
	Tue,  3 Sep 2024 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KrEa8e34"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81A1D58A7;
	Tue,  3 Sep 2024 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403496; cv=fail; b=j3CzLvyMeWYP3DpYoOKJU1mHJYbu1Src8arGI5YV1wPBOx0ZJppSfDfVLNrWNPZ3NfJe+yBoSAscTBEFEQszGsFIZCx6+RynrcKcnnaquRAq1Z0TAoZJD8uasxNlqJIU4YsKLxbmSKvDD1J/TDxgB7Q+Nzy8jzsfUKTZfcFgMzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403496; c=relaxed/simple;
	bh=4SCc+efh3mDK318+zIyQTrLCKblAb7B/ZOgKZlS1bk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDkb4FJ/8d6O9hfPZBI/bTv28yLVR8p0Y678GxSeNGGSZK0ARaISFw0I4ukmMgxpbLFMWbN5lKaJqQ3IUhuYA8wAB7SZrnh5jV41lSySSVEyv/SxnZNwQEa9mQ9F1MBPVh8OvDy5OPyy0y2UFQGSvgcLuDdv81KLXL3mV1HAGkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KrEa8e34; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww72CPeBvCibzz/Io+u6k8mQRLYEITRMUzDghXmwwksKAtRTzE/qCOANXbwVqErGWtUpInu2QtiJyLdY9PbtuV9kl16CYR4imz6ZmZeVEGHijtwqdlKmT/RlyYdHnHlqt5V5ggFGNCy6oKC18N71y2EhzoM65lGl7yhItabS6sTZvT8bkaxb5OrQLllZbT4dkxFoR4jyiyAn6a/3vdqlCxumAchfr1OB1qp9QilRH5jM9tp2m/PNvBbETchdUCEuTj5ZGwwIjUsLHHFJlX+846NKQnPuuey5cy/3slE59FJW1x1+oTbUHyPaOezSMD8Ch0klIhMJJXYEdcUt0KO/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwT3pwlwEQBpTJPHB/usrng0yJgGcfaZZEkxLB574XU=;
 b=kIZ+/O+5P2e0puDUSty6GHrHFQGwjhaAxpXKZYlpgWMYRNR667GSj7Oy6d3hlqLEKUiwGZGrkqFFKQYYUDOyYuWzGiUtqgWKL2kcE/ViviIiI+18QsukcYOeifc9YbdPknnfkFa7TUYcnKzf90Y8fx14or/oGqg1HzVwYZY50pDiXC4Psf9ogiiC+au1fs77qJr+pOxRh9zSxdfhrGXrd5AnvKXPNMx3Cqh/WHYrGSSsXIIFc4uPgM2ug/pc+e30HvHlLVbwF0/EMNqPp2ulcw07RAKXOr5JOscSh38tidTL0RkVAcyOLPtURWDl1qN5JXCf2HN/C6/zt+Qwt5E2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwT3pwlwEQBpTJPHB/usrng0yJgGcfaZZEkxLB574XU=;
 b=KrEa8e345QHhHnAhnEOwJtzqm3h5fyFbYvRibryXyJYs64700YDuROG5q5FMFF53r6qBZqcr6n/nZ+vwVOluU8zuov7o+gMLHHBHv/V1XxRGLMC0p0ixku0sIugLKftZ025qr6gwZcKzJI2fR4kdQo1e6fmjIHKy3+AhMsieyBTJJxpJOckSNAu6JqzHw7gO0KnOUnTYcHWhQMJKDwYo6n3zwBSxBTPjsWdLjhSl9CYYJ+dTKizkYfe+YeFpgEZ5h24q9K1ITlA14HEjIKm5XpzPS+ACE/oRC5wgilbdnQpTrWnM63ZJzafPw4uApymkwhTKdk4xRW4VvBinqALYmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10976.eurprd04.prod.outlook.com (2603:10a6:800:25b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 22:44:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 22:44:49 +0000
Date: Wed, 4 Sep 2024 01:44:46 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@collabora.com, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: enetc: Replace ifdef with IS_ENABLED
Message-ID: <20240903224446.mp55dvria3rrtope@skbuf>
References: <20240903140420.2150707-1-martyn.welch@collabora.com>
 <20240903140420.2150707-1-martyn.welch@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903140420.2150707-1-martyn.welch@collabora.com>
 <20240903140420.2150707-1-martyn.welch@collabora.com>
X-ClientProxiedBy: VI1PR06CA0199.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10976:EE_
X-MS-Office365-Filtering-Correlation-Id: b05aee8a-f70c-4656-d742-08dccc6a04a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jA3PwzA8b5naUQBdbL/fPMyMWyDm7tbA55cc77HSKy6uaslwKEujxXZlxqHa?=
 =?us-ascii?Q?c94wUXrWfuOoCpCL8CnpX0RFKItU6ilLoWNYNgtAsHwKsWJha/KmHQJ+ZQc6?=
 =?us-ascii?Q?XLp6V+xML/Y5+zpzFLFkw/mDuHN5Vo0mDTaZKt+7Nxk5a66rLjCNBOj83rUP?=
 =?us-ascii?Q?L+oXDst2YkFGx5uD2C+YD3E4w3bWraZClr0VvxH9bewJdHR17O5mw0woYOSY?=
 =?us-ascii?Q?UZzCOmDdZBysBS3LpjybOqapTk+8VmQ8UMqzijdqzolvFa/UKCXrRmnU2dCr?=
 =?us-ascii?Q?uyMxQI7gWXux1YyecQQJUtwp4wvdf6uOxSJlOhG2tzyHP0EDanTzXumjj767?=
 =?us-ascii?Q?X7ZlpeN6iL2qnTDWs/t9hTnE0mx5+kFApONE6ZcqRaqJcjdiWBbDrJrxJJdv?=
 =?us-ascii?Q?OgAF85twzsCTwRRBQ6AM+kSWNOAbPDkBOJZE24/joW+dr1UWDuh3RTqm8BvT?=
 =?us-ascii?Q?koz9noCm1+PeXBh/E0s2Ug8KMzH2Ks1z1PqeaYh5Ka4YyJY2vdaImOsyVwgP?=
 =?us-ascii?Q?gEmxBXVQueugiIEn/GPyS8PGJ9dfSC+1a4PVWng58sfA469/A9bZTB1bmK4e?=
 =?us-ascii?Q?I8p6+8AwXAaizGOus4CR2fon0h/8ltRXVw2cqpn8dGEAlrV7eGMGKHmhiMUT?=
 =?us-ascii?Q?vbxp7TzFASVtXnNNOjyx889k+BrAl+9Gzb6Fzg1aw1jY8ueVzLOqGDbN4Wz1?=
 =?us-ascii?Q?obygWChe9e4jrn+zhxFc/dEBnvUm1NdCmcv+4fBZZsUPS8Lp0yCrMDVwB0kf?=
 =?us-ascii?Q?FLOLhfy+gPrn/ogiPpQHZFG6tpsdCShGKq9NoDgIEkSa2LQUj1+pS7dkyjJ3?=
 =?us-ascii?Q?U2sUAhiecLOszPESh1ljtk8MsnzYK9d+UfzW/U+8AiUpyELKBvyCK9AkhWHU?=
 =?us-ascii?Q?0MwsN8Ig5nGu/bZfJqh1Zk72DthmsfdqleTQCuFpvrsTPTpWztF8pEHh/KAP?=
 =?us-ascii?Q?3qYJzHafvhFfDC1k+QG8In3jG1G0f5osXp3+4mslgCdu6B9/Ej1KUNdabNAb?=
 =?us-ascii?Q?B0SAKe2LRKPMt8Oj7fGa3FeUe8ReIyhaAqTSAcITlbGM/Kygr2dqipUFDloQ?=
 =?us-ascii?Q?7mffIDIZ+EaO0H03+95DswS2L5htHgugZFMuB7fHwi8aFSnUNOM1kRjpvjW8?=
 =?us-ascii?Q?CW/5/do/OibcnDcBH0qwns92GYN3DpuU2i8aDSVNPFFua5pJzzSfHfTG5dqS?=
 =?us-ascii?Q?MlScDfKH0CiLnFkbf4RPm5DS/v/NvhZMUgzJoshf6JABJUVJOGT5uiIZDT1e?=
 =?us-ascii?Q?A+hOHXviJtsIqE1tYN2dveeOlkA3AAss2Z8OxK8m72Ihq1mlM6uOAuebIZq/?=
 =?us-ascii?Q?XjgAoxchuCxEgzBDWOGMlH5inTo4C+T2FrtGoxJVEDAT5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D5bYnKErTyBlSRxxtiwByPpv7O2odbmV2zNVc4v3zesWK/oiumAlYSKdr81i?=
 =?us-ascii?Q?pY10I/6wce+UTfQ3N+dj4UXwEVd0E5cSe0qF/+gSaMayuewOBwodHlhZZ+xZ?=
 =?us-ascii?Q?+KuL1orM+eZRfzsr2TxcQ/45OfSlUugeUBedZ4qXdqnyF/MeoiZ15ZjyOX2K?=
 =?us-ascii?Q?OAQTbu3wVzTTAq0NHnYDP/n3x4e0G2jcEEttMlklIZSf9kvehjmDK0xOZ7eI?=
 =?us-ascii?Q?B5tr9AUVOXTF6/lewBrw0LEZB5sUENXFOBXETHEFpNQipXVYYQHY6lvMUkch?=
 =?us-ascii?Q?m9TFcXXPRCnCOlDQtgA013jzpjKtHnNgCFmlArUTRtPfq2urUSym+SAZOBFs?=
 =?us-ascii?Q?k86laLTyUgDoTnS323t52T84GdmTlsDQ9d4YZPsxPO8L9xHULIBUh8hBnLrL?=
 =?us-ascii?Q?naHlGChtlrsA4i+WQ4dlKEy83pqVwlQdPPxqqMAnI2nBUMVQpFPMDIh/chXG?=
 =?us-ascii?Q?ipTIQa34dIoKYyJz0pdgx1WHVyDweDzmbcUWiN+tk2mR7Sd9bT/Nof0iszoQ?=
 =?us-ascii?Q?fLdqDo1gYPZxX/+xaubzJcEPDF3GHl7jBwcXkj7uXpDdAV40kIg6xXG2cSe/?=
 =?us-ascii?Q?q7AiWG2b1bSPFw3GluDzW4Zcb8qkqmCiuY3onKn9XbkkrBt0QzZ5HmS7Gag6?=
 =?us-ascii?Q?bK/or3Yj6QDou/j4sawEAXjCjkSP+eG76WHb62xuFqcwxg59qHHnW+aZNRMT?=
 =?us-ascii?Q?BzUPNnquM5q5HIWH00oJNXqlEJyvtacv1VSIAwu1G1jSl8nKCGQ1BSKTo7gv?=
 =?us-ascii?Q?7TPQIKC503relIT79NTSdkXg6P5QoNerKuJENHtwxizNnvYCjdbXuO8iM/n5?=
 =?us-ascii?Q?ke5d71FjmqBiwSNuDxMQHNxW35JunQ4fkwldf5fHtgML4aO4i9ySWy9j+owp?=
 =?us-ascii?Q?W882khYG0bJTRuw/kKuQiuw223KLfajm7y922udfgoQhY45QYcNtXxQhMpP2?=
 =?us-ascii?Q?vwIUBorrAyZIHamownzUMQ1YXGpVUfsMAFo+l0u6M1fwiqW/Lr6CBL2WPQb5?=
 =?us-ascii?Q?NQLJLxfyI4ymiMj3f+nLaJLI0Wyym8pykfDxaQLqF/NjNGyHHrywCttkZRQZ?=
 =?us-ascii?Q?HvMOi1eB2dL5rwr8rVyqYU7Cx4fXxdBWon/UVN2P7GtjxIgtUu9TftXs89Gj?=
 =?us-ascii?Q?CiyftsEcO9AQ60XYdn0WZ+3B5SREvBIZRjHpA0GDJGLvEskvFXXsZxQEm5no?=
 =?us-ascii?Q?28aZbqddDchae+v+35pBF9gwY5Qh2RWHlS4H7aeRT3Ej0eRzqikhKmAaeKRy?=
 =?us-ascii?Q?+x+edtgvc1RAJpV9Pwgg/l/FRMdfYOQwCN2MsyZBrjGqvcRVApAC2lYrmxxu?=
 =?us-ascii?Q?+VQack4QT72r/39F4ydUtvVKqYxACxbzT+Vf6Rs2vx2c3NKJO2dloGr3O0yA?=
 =?us-ascii?Q?onnindf3VRBdviFMsnR7pyCBBFY0nku56Dd6IqLZDYguIfgvO7KDEvZ/vTOA?=
 =?us-ascii?Q?6UBC4/nFtHOGQgBB0tdKzdegIDQcVfO0rHdEIGdG0IbwijgWzRnGeUjKA6HX?=
 =?us-ascii?Q?FgVSEik+lmxXk2QIkpEqWWGhS5slKNziM5HcILXALEn3htMNGw28EgM1R0h0?=
 =?us-ascii?Q?ksr0NAQDAQMXoli3d210w3ekc8pMN038iUpnDwLX3DgXo7kg/pi08tbfI1MZ?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05aee8a-f70c-4656-d742-08dccc6a04a8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 22:44:49.8468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FK1jZ/+2AecgBpMHBEL4lnNkU1laKklnq2I9N19KCubdSSA1D1XrWab+Qy3KyI8hC7X9GIfu0Owz8saMQdLsJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10976

Hi Martyn,

On Tue, Sep 03, 2024 at 03:04:18PM +0100, Martyn Welch wrote:
> The enetc driver uses ifdefs when checking whether
> CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
> if the driver is compiled in but fails if the driver is available as a
> kernel module. Replace the instances of ifdef with use of the IS_ENABLED
> macro, that will evaluate as true when this feature is built as a kernel
> module and follows the kernel's coding style.
> 
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
> Changes since v1:
>   - Switched from preprocessor conditionals to normal C conditionals.

Thanks for the patch. Can you please send a v3 rebased on the latest
net-next, which now contains commit 3dd261ca7f84 ("net: enetc: Remove
setting of RX software timestamp")? The change needs rethinking a bit.

Also, could you git format-patch --subject-prefix="PATCH net-next v3"
next time? The networking subsystem tends to require that from patch
submitters, to indicate the tree that the patch should be applied to.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> index 5e684b23c5f5..a9402c1907bf 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> @@ -853,24 +853,25 @@ static int enetc_get_ts_info(struct net_device *ndev,
>  		info->phc_index = -1;
>  	}
>  
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> -	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
> -				SOF_TIMESTAMPING_RX_HARDWARE |
> -				SOF_TIMESTAMPING_RAW_HARDWARE |
> -				SOF_TIMESTAMPING_TX_SOFTWARE |
> -				SOF_TIMESTAMPING_RX_SOFTWARE |
> -				SOF_TIMESTAMPING_SOFTWARE;
> -
> -	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
> -			 (1 << HWTSTAMP_TX_ON) |
> -			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
> -	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
> -			   (1 << HWTSTAMP_FILTER_ALL);
> -#else
> -	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
> -				SOF_TIMESTAMPING_TX_SOFTWARE |
> -				SOF_TIMESTAMPING_SOFTWARE;
> -#endif
> +	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
> +		info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
> +					SOF_TIMESTAMPING_RX_HARDWARE |
> +					SOF_TIMESTAMPING_RAW_HARDWARE |
> +					SOF_TIMESTAMPING_TX_SOFTWARE |
> +					SOF_TIMESTAMPING_RX_SOFTWARE |
> +					SOF_TIMESTAMPING_SOFTWARE;
> +
> +		info->tx_types = (1 << HWTSTAMP_TX_OFF) |
> +				 (1 << HWTSTAMP_TX_ON) |
> +				 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
> +		info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
> +				   (1 << HWTSTAMP_FILTER_ALL);
> +	} else {
> +		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
> +					SOF_TIMESTAMPING_TX_SOFTWARE |
> +					SOF_TIMESTAMPING_SOFTWARE;
> +	}
> +

How about:

	if (!IS_ENABLED()) {
		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
		return 0;
	}

	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
				SOF_TIMESTAMPING_RX_HARDWARE |
				SOF_TIMESTAMPING_RAW_HARDWARE |
				SOF_TIMESTAMPING_TX_SOFTWARE;

	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
			 (1 << HWTSTAMP_TX_ON) |
			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
			   (1 << HWTSTAMP_FILTER_ALL);

	return 0;
?

I think I prefer the style with the early return.

>  	return 0;
>  }
>  
> -- 
> 2.45.2

