Return-Path: <netdev+bounces-190659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73177AB8247
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150FD1886CCC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B56228D857;
	Thu, 15 May 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IbievQmi"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059304B1E4F
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300603; cv=fail; b=Vp9+G4l7lNioLlJOJpoFkyt86Fs3DGOLiMNGKfmy7s+1pRxmOXy6V3Yc87k57EjE+Izbx+1//w7BaK7allCjpfhf43Fc5HhdodJ12Db+858tKzLPm0H8C8Ok/yltNVwihUV3FQV0cktgYaZTEjxDcVNgC/M4+sVOMBrHJwA8GQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300603; c=relaxed/simple;
	bh=75+GxHslSkbhajaZS6GFCoeVcKFpzaUZ+7/vaNKgK2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AnA0zrjxtUfDR+/fdJUfiEp2XqV+ljx4ROhItWblsGJTAJxL4CUIZXMED9upOS/bXLGSi5LiF7f8dlxb507fLJ4k+ViRVEZhUBed69LtyYrFM5rNAbt69bo7mkJmYb3wNReVTxiF8/dIZTSpRupE+0I9RiE5bLsf2NGCY0W5spc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IbievQmi; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3Ai0k2x3wE5SeIKzGp3FqDikve4AoCAUqKqA7fFIeVMTRR5499jAYCh1sS4obhO+S8wQG4I8oraXkXoTYj33ObgRHLTFmdpGdk++QtQ6uq4kh06K9LMM4R7qnRU+zTaoLTwV0C4WTTFwnesD/huyXESC4umtt/7ZW8iLK+Ia3u7ff3lGGIA3qeVF28GONU/68NFa29I9UKw6mmcATs5YyzzypCVSOCl4/6NzADaBYaMtWbPsVYWaaxwGSKLMv4xxpW1yM8pHaiLdgnOY7Etm5qakk6DCdYjE6YtplhBA9AbnorO6Pevf0XoUlqEzzXITbl6fkf+JR+NHy27I0v9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxWmXkb/tth/n/zZ2kNdqOXLTgJWwmCFpjQYHu8ZWi4=;
 b=Hwzu8c0jzEeNjVr/VuWRGaaN0r99uiV29VN80nqPQb+uXal/9R44M+fLG8752q/ITNBfkJ2LXlvVT/8lh8/sHZlg0ZmDzthoC+CNiChpScn2XY90t/foduq3Y4j8kYbCTB/SafAdb9hbhPnVuVtJaMGizisAb/qbTtTaBlTZuP58KVp5c67oya9K6zrvp3vmlrWar0In8thZT7Z2yUC1kgGbT0z8AjSfw5/jroW3gLFXKEK39uCjAvkc63yiqgBUhDcw8ks6v5nQT5132xdvxON3aIZjXH3uOdewQkNEI9Bz2neB5g3+wmaWsQVQ7XnsvaIkHWic/r0o9uJiDGsWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxWmXkb/tth/n/zZ2kNdqOXLTgJWwmCFpjQYHu8ZWi4=;
 b=IbievQmilxqylyNwEV+2jjEEpVZS/D3q/1D/LU+nILC/I55hzJ+QCNQoY4h/2/O/N5bC4Qbb8ZOggdI/fTdX+MOrlIl3O+mq+ud5cSs+ccZm024HJ66swS/4EVJ2mdm8zFd2u+oxtVb9x8xZh6fPyk49yBd+mCR7qGo/bprhVRD3/JFy+lzH0BPNM6t4P9BxbKqerlQbRBvevJEoBn9vRU6Djf/TXaiwOZ4ghLTHeylPIjTsGWLfbYrXyaYhZaNxz0vdvPVLDUhwdqZFcZ1VQSyHZVt/2wpZC3iM+9vhDJiNwbnYAGEwxv6EI1N3HDe6fOaLcDwjmIKRKFUUkpa7tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10490.eurprd04.prod.outlook.com (2603:10a6:150:1e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 09:16:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 09:16:38 +0000
Date: Thu, 15 May 2025 12:16:35 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net v2] tsnep: fix timestamping with a stacked DSA driver
Message-ID: <20250515091635.gevpm33zszsbfpxu@skbuf>
References: <20250514195657.25874-1-gerhard@engleder-embedded.com>
 <20250514195657.25874-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514195657.25874-1-gerhard@engleder-embedded.com>
 <20250514195657.25874-1-gerhard@engleder-embedded.com>
X-ClientProxiedBy: BE1P281CA0458.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::6) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10490:EE_
X-MS-Office365-Filtering-Correlation-Id: aad88312-a041-470d-4399-08dd93913233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N7XNU/sqRXOel2vYxhPZ3p0UAOyeT5wsxYzuZO/GFew7CLzesE/4DnS63y48?=
 =?us-ascii?Q?sYGAVn5J+Sl5ekIcMo63XIVIok0+Bjbj3mKPffi60/8cccoSBCTY8IXh6FN+?=
 =?us-ascii?Q?TG9FljsTADGyodo3EXtKLogTIOtK4dfqsmRG8OxqxNIHVqNuZamLWALknbLL?=
 =?us-ascii?Q?ZFl0PiET9PJ2StUJmW4M3IxO1hmcRhk1+E43/ur0NI02y50itF7lBnfjDwTf?=
 =?us-ascii?Q?tdQQkLCzjSTln767uLeafDiR8y2Mm17DknWx3k2RJbeBOqK2Ld5dedwCAEdW?=
 =?us-ascii?Q?ErbNp772EW/d8iTEb+NQzG9aWkqcckueOUGpu2ddmhtmWyMeW0ONOxW7UXan?=
 =?us-ascii?Q?SAv6TDxFE9vOfQYvnh7zDt8vDd/BxqWjFcYvMO3BV2+YukilRAMAFrZu7eFz?=
 =?us-ascii?Q?Zwr6jV/9w1OI0Sj2Zg/2dQQ2lI8PXVk7fFif+6HN1KQeDxQTDwcV4nRvwM3B?=
 =?us-ascii?Q?E/so0iK0d9rpWEIUiixcvPA35clHphLR0LaDu45e/fqk3ODFDkb7oYjYeTaQ?=
 =?us-ascii?Q?ak79JHjxhRyfBLvxIK0V3uQ9xEl5mMtJUmXDhGX9iwXBVwyVtAYb0was8ul/?=
 =?us-ascii?Q?yan6pZyoduQtGQSxqYf/D1TOuntl9PjatqkJGbNkm7kU6C6QcAdFmNNxVwY2?=
 =?us-ascii?Q?XDheId3hVwoAq7kVIwnA4ZVOUcqVGJ+bULQl/nADhiaWcgH0/74vlQuhUOmv?=
 =?us-ascii?Q?Ordpn7jxd6lMrt5kxLltcw0nHGqhmCsPCR0JfHARz7G+QyNIi2xWZViAWK41?=
 =?us-ascii?Q?lpPX4Tj178t2O7sPfxbmEPTHlux2SZKHUPNvj8o81q/Rky8z8zr4tOsHQkQT?=
 =?us-ascii?Q?uV7WaBoyeLHVp61IuL5pPiPXiDBkF/SG/W2tPbr8CZzPZbgJRNzaF8iJjPWu?=
 =?us-ascii?Q?Od2iSMNZqv4xBuhFlKBCJIi1UpL/EkYxG6nUfmxSp2gS8F3DsVTh7JDibOOp?=
 =?us-ascii?Q?9enr0VyFGFgV6sVOpurcldCdv3kfjyxckqkBzLXsm3Vf/9CMR3rZd6Fi6smW?=
 =?us-ascii?Q?B1tswi/eo98BTd+TbFm1fFQGEyke1E31bRL4B8uwbQwLjC5+oImVUq5x+TkF?=
 =?us-ascii?Q?TSeYCt+Px9sE2VaW7GTAmwrcaGj+fJW38u41DQI5geYdYCsxGiPV7N6dxbah?=
 =?us-ascii?Q?rhQq485HJKjMg1QEzm6v/fMIziYm3DtVPv4nmJWZk79BsGvSEeNe0aiDfQ6g?=
 =?us-ascii?Q?LTfutFku5xJvXVxJhThOOg0sE+6eXMPl1Ivj0QYJ4l6Z99Ng8hYY94J9KcY1?=
 =?us-ascii?Q?d1a+3aWRgH7kQROlWy5WyX/RoXTZi/vytYdmrA6OIaiLqTbQ1i431WWjS7Jg?=
 =?us-ascii?Q?t/o8y9o0g//650q+KPKQ6aNnKL/Mb6YpT8YNHNS4XG/eYjBJCQCd1NCRQeQG?=
 =?us-ascii?Q?44UAZJ2zMzz62tE0ETZ0phpjOXeVzsx63ylpu99FmJlfs6aCnJ7X+Wxaikbk?=
 =?us-ascii?Q?JBGAKUMs0ms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pREmOHl/LJ+CpFcu7k49hMwiQFmucS1/gO8tUBQ4FyfwYrZFwtbg/mh1pIG3?=
 =?us-ascii?Q?oGI7CYI0eDetcXXJ3eJ8N5Mk8iz/kvyOeruP5NNYruV71dv5Xr2pFna7q0l4?=
 =?us-ascii?Q?HuI1NU7Hhm49lfoTHhvTzaRijxFaXHD+58xG2Ei+UtMXloAdAoxT745bVY+V?=
 =?us-ascii?Q?yy6+jPwwz0/ZDpD7wlT4ekc3svm7KTAtKNIlOxKfzaSvArny37BKfTkkfvj+?=
 =?us-ascii?Q?PrJpKKEVfENVjR4Bblvh7rbfTQaWrCAZ5eV+OyOjIpBbz/5E0RqQdQEdVqcf?=
 =?us-ascii?Q?qS8xGFuLIB5A4z0rMhOEh7Nb/FRmyVdLMm13UqjePjqHOnHGSmDgr9/SQK1d?=
 =?us-ascii?Q?g2oTltN9VBkmg8RC8oRCcwsSuHZ73zXs+8HOMc7YOt12dAW8rHYDNE/nxQSb?=
 =?us-ascii?Q?VY9PTYtAXRj5g1hNDhYz6aAQCV0PbjLkUIujxTV6BddmrjlJE3ACjm3x4xV7?=
 =?us-ascii?Q?ENFYZxd7rWCUiUgRDXphPQnsIeISInfhKwThXkg5xV+8BZvEMmfVXUkIJYyD?=
 =?us-ascii?Q?sIwylIaOBPfeP24hWLd7/7i0jJ/9qaFhHKvE9PCLEbUrk10MAq3WcNROWJB1?=
 =?us-ascii?Q?P+h9Nkz1a6tnMGoFANwLvXmcX7VXk+OcNtjFnEvjZZeniaqAx+c0UxL77gUB?=
 =?us-ascii?Q?ecTpDXgIgSiWPUXn9Ow2AC8+zhjKecqRUETPjoM+hrh8MylCftsoGWsfwXT/?=
 =?us-ascii?Q?Byd5z9PcJsvEC24kPSQpIabEeQGLqVOtkDX0fcvmoeiM0UMkPcWLl1vYW55U?=
 =?us-ascii?Q?5WJTvxr0BeMY2MQIFHSjoaOzCQSuvjdvHwnIbTnQk1Z3UEIhRRHqthZ9XAc/?=
 =?us-ascii?Q?+4Xa/IFMD3zHSWbeCyBsJ+L+XoJOcRORv2PV9hJeBml/shsdWl/1KijTggUR?=
 =?us-ascii?Q?QXSHPutL7Hge3sn8mHWWUbSJiF0i0SlPoZmKXlufldCTknSUAzY9aMVFZX7j?=
 =?us-ascii?Q?Q8G3D166oCT2fAmnxPeHnkv0NA1xuCUwBwyIsMtXsONvg4vU+QCzi5GfF9+6?=
 =?us-ascii?Q?PJjJVpncCDSVBYyHPUhS1hO0GV4Sz3th7ESu4q+UjnKYoX5lGyJdTmoYkqqx?=
 =?us-ascii?Q?FG85T/mq/kDifVYjaeHudExAS6xQPTAUB/zqK6j6qprOYskpKdDYEPH4hR7b?=
 =?us-ascii?Q?S2mrE6QyCxrGjqEeg5wXHR1gcgkU6wjCUTbgHjXCU2HgApHdEXk+0YD+ND2Z?=
 =?us-ascii?Q?klb4mx9kRIp7uOi+o14uVeCr93/fYOAGpL9mJR4dT022Gm21YskRl2nsR8nN?=
 =?us-ascii?Q?J80+vcqTz/jLLOKIzpy7rN8sCtAdRkM1QqnEZ1mRp9M1ckrnKJHSoGnl2C06?=
 =?us-ascii?Q?nVYdTeiPi/tMGJBU2rLaSHLWt8+Rn0jW2nSCFHCVokyDyy+92lRPAO+BIpXI?=
 =?us-ascii?Q?zBMVfNVP9W1bfkfuwjGoP2pzXwRlpEdNjitKDI2PVuT8OprtbbZxz6+sftC5?=
 =?us-ascii?Q?eE8NffFbAP/rOy4Oteo9yWbsKO5e92EKYL+1JXRPZafvkbZ1X7R7yIfYTCvO?=
 =?us-ascii?Q?hp0FWPohi1uB4w/C0e0XTNqeBfgOmFY7hBmb/me9DVKS8BZGYJmTn7Fd9UJT?=
 =?us-ascii?Q?OjON3SLKO+WHY93inTSf5VBxT3WNbg+GD15t4D1tJWIDaiEN76rfgA29vIsk?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad88312-a041-470d-4399-08dd93913233
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 09:16:38.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Td87/Ni7OX7x21GMk22N71ExoI2+TD02iz0J3iYB0geshttl3XMeLrCNBKWppmCgaB9JStlO/TflmkzT74L5yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10490

On Wed, May 14, 2025 at 09:56:57PM +0200, Gerhard Engleder wrote:
> This driver is susceptible to a form of the bug explained in commit
> c26a2c2ddc01 ("gianfar: Fix TX timestamping with a stacked DSA driver")
> and in Documentation/networking/timestamping.rst section "Other caveats
> for MAC drivers", specifically it timestamps any skb which has
> SKBTX_HW_TSTAMP, and does not consider if timestamping has been enabled
> in adapter->hwtstamp_config.tx_type.
> 
> Evaluate the proper TX timestamping condition only once on the TX
> path (in tsnep_xmit_frame_ring()) and store the result in an additional
> TX entry flag. Evaluate the new TX entry flag in the TX confirmation path
> (in tsnep_tx_poll()).
> 
> This way SKBTX_IN_PROGRESS is set by the driver as required, but never
> evaluated. SKBTX_IN_PROGRESS shall not be evaluated as it can be set
> by a stacked DSA driver and evaluating it would lead to unwanted
> timestamps.
> 
> Fixes: 403f69bbdbad ("tsnep: Add TSN endpoint Ethernet MAC driver")
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> ---
> v2:
> - took over patch from Vladimir Oltean (thank you for your work, I hope
>   the Suggested-by is ok for you, I was not sure about Co-developed-by)
> - do TX timestamp check only in tsnep_xmit_frame_ring() and store result
>   in TX entry flag
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

