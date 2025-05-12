Return-Path: <netdev+bounces-189727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ABCAB35B6
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0C4188A92D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A154288530;
	Mon, 12 May 2025 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ITDG9u/r"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA3A288501;
	Mon, 12 May 2025 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048347; cv=fail; b=FMYbgwsg7qVdaUPUZ7J/oSo0Q1XTIQSMa3eUe5H0cAo0f7zIfkYUoGvL8Rn4WTTR70tO6WscJAzFsCQnqYHHxh/bLqAwN/k7QaasrfSK9SgsrZI2a2F062EW52jITorJ8LCP4Iai3HUdOOaEf2ofWC3LnCPjlX1eaxYKwScWyR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048347; c=relaxed/simple;
	bh=i5Oo0DulZZbjzFsUR2TivDVMkGbVogAQmZ9WvvD1drE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iLI+3oVWiminwDt16nvqlU6z0L7nGwWkUGjVW1yW/r3vqe6iKM3VWXYQS506+laLha8CSPbDMEJBIPxMvavZtF4lt12jHQFyCgRoSz8whSbn5Js5LGYCrvZGaJKpmeqxsdaaC7Z7Km2ZGUotMaXRNJ+YsD+rrNDMsfluhCxnnLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ITDG9u/r; arc=fail smtp.client-ip=40.107.241.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7nHCMHLNv7y5ioHMoUwMFGf96HLZsrjU3zPoPuVhlyOLEr1DzuPyyqVve7KJgfIuVVOYdOyieYI0sezsFRk4CQ1ssdL40NLbf5LwQLV15auq40vBhvIEOIxdrzrV4/rtmu77ckzsDdbG6V4Yv9zVAMd7Um6rIVwtwhNTyDzsYc4MbxC6ln+iZEUYj3yy1WPCT0OPREUfMklPbtXXrdvecPzzYxOKtUomdPo9Hv9xA8IwB/yuY+KF1wNSRuwOlXiw0b3jQ1sHeRVcBG43DNi9q1///Sb8HybU8CQCZCsURx4v54AH4KL/7uNyZrrUYO6j5kghNA9DlLs2k3/Ey0jLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svWOEP39ZarC6UHAW3F5le0RFAA8ILoWYsfgivecCiU=;
 b=y/mq+s3WQe7z/9rYozVtYyS+miEYG7Ycb1KOLZeOCHfigzJe6uTGuls7GrwO18pdl7Ef2vN4Wor4ZMGwPvLyMq4FNBS4V8ax9IIvDaXzu+8goR8FBmMXGH555wsKtjVFWEa83Zus4dL7DKj47T64giBWiMIfXKz1wfPRrxDzUTWukpFweu2F5hDY3yYFBKFqrqdPJb+U+TmR1qiyhUFAxewn1n5Qga/Tm5yxcAVw7GcpluOvA4hDI3P81hItA9It4msg8T90rkNZXhB9t52AjFxImTFpnFhCMO0NDI+YGzJvTpn9jUVRG3WYCAjCoVDAx/jNT4PX62zS1c+8kMHDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svWOEP39ZarC6UHAW3F5le0RFAA8ILoWYsfgivecCiU=;
 b=ITDG9u/rhqgtR1GcPX15Lo1D3yjjIjC7cWhD5S276Dr7nlEPxy2tV2soLspN6SWD0zdpffeHdZvi5LhWOJBF7FQ0YrntuHXJEL+UJj63ZOZ42Mvos3j1hV0FQRQ01KiI6va66eQB8JXCYk+gJoPRf9Ll5NeW0n+LOWfvI53KFiuHC0Y5DP9CSKQY09334rgh1/vYSSCJXgBkDVUT/BPLjdFIF+r/j2Wl/wmPvCU7C/kk4nHiXjNO3F4gNNw2Sjc6RUfsg3aJsc7iEQKMsT2/ikaj3VJdWOIyT8K9SIZbUF6ovhU6wshyUd1FzOkYb9Qc2jFbPxtU3I+Lm+T1W8aHEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB9211.eurprd04.prod.outlook.com (2603:10a6:10:2fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 12 May
 2025 11:12:18 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 11:12:18 +0000
Date: Mon, 12 May 2025 14:12:15 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next] net: enetc: fix implicit declaration of
 function FIELD_PREP
Message-ID: <20250512111215.jljlwu2t5fc3kstc@skbuf>
References: <20250512061701.3545085-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512061701.3545085-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR03CA0069.eurprd03.prod.outlook.com
 (2603:10a6:803:50::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: dc862890-c7e9-4a6a-fc67-08dd9145dbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z7iRfaT6aMxumDQb6F1LQ61/HnQAgN4Fg6ADwxAdRdVgchMZ9LgqLb8UtLzB?=
 =?us-ascii?Q?1MAfxeU/XIGvr8xh/CLDYmmVL9kzgx+UfJdkYI2fE19nc6k9SLgHcATULaTV?=
 =?us-ascii?Q?AAHWz08QwKuUCdb2Pgn//e3MU8OweUyOcoSnIttZCsNyhsBVQiGg76zNRA+B?=
 =?us-ascii?Q?nV+8B3+5QhxMGM8jt3/twAyrd7+1HG3NAEe3ptV/OUrk+0mkcctVuDdgPsZ4?=
 =?us-ascii?Q?YtFs/HbvitbOfuYjebPMwZvT8vwCnjjiyOmtgpMQQs8UwogdrgVzn4gUuU2o?=
 =?us-ascii?Q?SCoo/TpkdiNEK+mNJeHNDNQ6T6fqDdlyNnfZJQZ1/XLzDwPXwKwtwUDwpIEF?=
 =?us-ascii?Q?DZEHx9ToZJa7KJJnsoUp8tc5mJ2jtGxy1Y9Gwg58Q+GHBMpMiDL2wOg5nyYZ?=
 =?us-ascii?Q?nhm4ThOMOpzhbBKnv1Lff8/hWZxMa51+V/PJ9Pqt6xn8J9a5zux2iSmoY6sf?=
 =?us-ascii?Q?kbMUDsiOcHvLe+5vnlEGev4j0CEbHlUMNAWoRGJ5ozi7Yimfh0RySqs3Nexl?=
 =?us-ascii?Q?7ELzon5ntZjzAc5n7MWYFC3XdrWUVChIZWbBS6Dk58q5YF5XgJbcXeNoT+7c?=
 =?us-ascii?Q?d7W5tSHPU3n+amj71IW80MeOdz4MoDSqkMQAN0Nix2Gfh1rKYHGnCMKEcWm8?=
 =?us-ascii?Q?iKSi0luZqrBGlIFYOlZrK8XH+bIjvdodSEHvdqOC9r+uco4Pfu5ixZch2ngc?=
 =?us-ascii?Q?kaqCax1UAmPy5wbMGaUd1sskKW0gpmMQiyzkn87uuYBkIoGIIncKTulBRURT?=
 =?us-ascii?Q?IHTHN5IkQ2iDOAf1ILHX9RPIe0vpxp7wzJfttYhPGVSQrh0zAMzHp33nMxov?=
 =?us-ascii?Q?x7lSKsx3T6Qm9iju6CNhha7T32NurYifrfRiOYtW3/K+zjXIW0Ox9kzN8aub?=
 =?us-ascii?Q?7IMLdm3oV8FmSFPlajc8BRIqsVTb7wzMY7/j+sM9EmGJxtJUCPOm4serUSS8?=
 =?us-ascii?Q?7noDd4Ed5J1x2AEDelAgLKaR03d12+IuFleeBMY4xAaFz962T/cxZiLOuu3G?=
 =?us-ascii?Q?V42APjTfxGb7vuAOyAaI+w1X5TsY1xjH+HG8ndUZ/ru8lhZS1DqdNBSOhkMe?=
 =?us-ascii?Q?tdLhdm079hIOqiuEEvP9GnEb8Zv9GN5Zh6GipvG10aqYSBZ2rt/7WbS1emFz?=
 =?us-ascii?Q?+A0QTRMASnMTdkDSrCDnVZNM6OdUAS/wNDiQsbAmdMHMeZyl+7CwuXIjZ3R2?=
 =?us-ascii?Q?LQsk0Z8MejUXEw8t768TuwKusClRltAgaLl8GN6pDWK66UQalX+LwhxsrjvI?=
 =?us-ascii?Q?itLWQtHX4urTJQc2x/CFE/VS9+msn5sHgVfDN0TZgsQD7ewsqJCBV5+qrhj7?=
 =?us-ascii?Q?GwKRn21PsXd5qFClXybNCV9DBs9QfWquiwa5cEHL+ICq9HoOik2WQSAwb0Z5?=
 =?us-ascii?Q?cx2rUeskwZSgNCK/XCyRSWB1WzkskzDcJeKOjmP1fO4nEf13rZGr86a0V9WO?=
 =?us-ascii?Q?OiIE0BgUGdI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8IqnXRvnlxIHJXehcfTa45AcRYGfqtScdSOiQkazwNwzBrffmhfzo5nAZ4qV?=
 =?us-ascii?Q?U8F1YWjzZIve1c6+cK9PB1eU3BKowZwVEs05CfA71W+UYbEp9vFSgIVQVGmj?=
 =?us-ascii?Q?gdzddafqdxO1sez5ZSBPTuRDYaR9Prk9Foc1AKp3ZPcuc21VrtTOxDPwWOUF?=
 =?us-ascii?Q?Qr9SxhmwrBfRlmJs0QqUTYJdspJeStCZZoHaMfRFhK+wsfC2wYZeg4U7kQKv?=
 =?us-ascii?Q?D+Ihnjq/LqIJF7xma4sfJ6mhOHnFJ/2KQEP8HxsP3Bh3CyPqQN7Vjd+TrR4J?=
 =?us-ascii?Q?SP/0PVNJ2+Kjoo5AOJObH14hQTZ0DS5naZWJ1R6DwZO/P7epU5lNuIiOz84D?=
 =?us-ascii?Q?UM0GfDBc+3Cllm7zUf+dK0rFQCzZxQygO4fp0DrsOuKtL6Q7ZMK4AWxwga8R?=
 =?us-ascii?Q?0mPJRcwT1k0Gg5zxUSZP2LHJF4vwRuRPDVP0t9gWsNn0qZ3CMrfXD01MBmqD?=
 =?us-ascii?Q?UqN9uO/otosZbpv7v7a3zuEq0wcT5D0gA6nsQhogRVVvacG/eiFw0qa/qdtI?=
 =?us-ascii?Q?1Dv967yqJoc88uVaRXgUDY+TR5SzN5NwuATAHsI6if4eA0YtinXc3oS9yqB4?=
 =?us-ascii?Q?rviKqVNmGS4zK76BBNKaJXLXQj7M13mORYGBRcqbKU2AjD3mxL8zsW1rb4AW?=
 =?us-ascii?Q?iVYy/+2HlZdmYa8X84KtDFry6dpRq0E0RLYhdjcbJ1Yb/UoImV5Y7oqIUUGI?=
 =?us-ascii?Q?JuCwibIN56KvfOCWShEvHGp6BSXsPJwSviFhMyH60hW8FEWezkdWHF6jRLqD?=
 =?us-ascii?Q?s9G0XaHf334v7bQNN7SeroiX7+EDHHJMcPZwpQyhMadgkjCYL4O6Vqbq0QdI?=
 =?us-ascii?Q?BZgzuT3BZITysDJHm1mJFul+vu7R91Sep5+VD3sKGfRKhw6rQips5phdSQaw?=
 =?us-ascii?Q?m+n+8q6VAdi3y0BT+8P0hvIjp+11lrPAfchff+toiEh8AS1rWG5Ecdhb+ynG?=
 =?us-ascii?Q?e7WDozbCHmSQBg7SIhObY+9Z+1HREFbuhCFxhShvS+DsvIdQ+3r/kg85TgmV?=
 =?us-ascii?Q?2/gm29/NeEWmMtm+PaMeRbNr2epm9YKqxS72xhs+srbd7EDNrSHfNkEaV5F+?=
 =?us-ascii?Q?Z5rwHTvNbicY7va6fxq6xHX9U/U7Au2GEEp4WwbeFGlCtklTzhB4e3OVbKsg?=
 =?us-ascii?Q?SS5JJRf+iglDMXH5VBIFazY3k6zxYtdCLFPR+9S0jgHErrkGVS+tBq6suT2s?=
 =?us-ascii?Q?OUn/w9BUgYqvQ/nykrBkQJwaoJtELC4r2w9Ww0hiY+gUX880MjmE3P2Hdfya?=
 =?us-ascii?Q?6Tjq0vkCv8G23UuPL7GqDEI0wuNhiXKbPmK35gJyT4s1chFyndVNhTUwbIdZ?=
 =?us-ascii?Q?mYSz8Vo8lwEVcO5NtpScjXkiaYq5l1ZZjewJNubVF2YzlcUWAVFZU1G3blU0?=
 =?us-ascii?Q?95hkTHQ9uUhFiwWT8+cWpleoaUzNEaw2L1QQXM2NgoJuhfqY3Hvm/CUM1rW9?=
 =?us-ascii?Q?m82NRX0PATnbofV0QV3Myuzur4VdZJ+1rBYkZoUgSC+8HFgitKdzHUcpaAMa?=
 =?us-ascii?Q?iKU927xTcAv0w/9oUSEg3tbAmB1muotVyCzWFOxuUkCL7Axm0HvC8D56fJkb?=
 =?us-ascii?Q?OZDi/szpjAaQQgWkM9k/+UCwdhHrM7ZzuDH56vh8Su8uoXtkiMggeDKE8j+f?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc862890-c7e9-4a6a-fc67-08dd9145dbb9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 11:12:18.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsBXRMoSEqUtjR4HwMC6ZvYff2CLi3g+8iojamUGnzjXgKa0E3oiWUBb+ynGcI4T1N2AOzwLRK+eKca/UQZUDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9211

On Mon, May 12, 2025 at 02:17:01PM +0800, Wei Fang wrote:
> The kernel test robot reported the following error:
> 
> drivers/net/ethernet/freescale/enetc/ntmp.c: In function 'ntmp_fill_request_hdr':
> drivers/net/ethernet/freescale/enetc/ntmp.c:203:38: error: implicit
> declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
> 203 |         cbd->req_hdr.access_method = FIELD_PREP(NTMP_ACCESS_METHOD,
>     |                                      ^~~~~~~~~~
> 
> Therefore, add "bitfield.h" to ntmp_private.h to fix this issue.
> 
> Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505101047.NTMcerZE-lkp@intel.com/
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

