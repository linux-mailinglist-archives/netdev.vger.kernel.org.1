Return-Path: <netdev+bounces-136367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802FF9A1829
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410F8288BE3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558F22611;
	Thu, 17 Oct 2024 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="icJxY02g"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900091DFE8;
	Thu, 17 Oct 2024 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130187; cv=fail; b=BPRX+JK1SS1iidSUnYGwNdGhinppc7X7M4ZmivV9NhOEFwQv73+vL+xW0w5yoWomeiI5orgWW6rdBWC7pfmZikRamxaTjtQJXr0f64gnpHSGxogCmj77Aq0Iel3ZoNHQ63H7wLJW6pz1cHhwuZhmoCwlahPFTU3bwcR2GYy7O7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130187; c=relaxed/simple;
	bh=IZutdEoSGhN6dbNR3wyWGzT5c7cqe8fuQwL2IAhJtQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eVvQLdntKBD8PrJVwmjvEC0c6YyqmKmoF53MKHA1PMBN5hICTVliBraYAsjJgqjoHmNIuvdcdMav+c3f6wXIQMpIaxPlDU1CRbemoS9CxuAL0F5QqlGoffz34ihXrY5uJWg3++lW41YZwBcYTADvmn/i5ABMgOFeQv3oqpMQ4q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=icJxY02g; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDZE/VvPRmcN6sI8746mNTTWPlPQNMVwuPU0YMjyuyXPlE7jrJkS/NkKd2xsSQUQQxhHsOXY1Aq7M50WYeZESbeuHtDT6P9U4lVwr6pQDPwDEUwdKxVBOk8akU9HB8TBbVI4Y0/bOYpk/4KdkILKxirzLAfvkNPmtTEEiwrN8mazIiiYfjlzdoRgYls259d/doF+GouYE2OxBuoB1YV3EiHe6dlcBR8Wumf/VDe7D1E0aIp4hQ4m6WOMRGg6rFdoJYAKfJKTYlsgJj4R4hm4tzkpPUoxcemraUNWSYNt87/2N1sVb9Fwm6CQc2KKcnC7kulgobGyaRpbkJJJSxBfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+obRvOwQw1jtOIIaX7GVmP0JxY9IjjJ63VOSH/Gc4G8=;
 b=aKAQ/EJm1FZyPDc3snQ3pXJCXyTbgZi4OFpb1zi0VHQZBApwGeoe5S/672sbFeGaLTuBF6azDqlX2tjAUs0jCPND+YbCFjm00nDnMlJrx4VM0txLLckhHHnqeqI6cLElWYmWMTrwq3TZk1JRgjE/dAAGnH65C/4Kp60uIKit0qK/gGKYCseQi3q6c1RKFdH6rMuxnf639eB8BXfhs/XPk/D/WNc5d1rXO3nKUni8r4tuoS/kla1Z66h1u9N4nY5Exvwbi3uMCGud3mXU5iDJTA7wAAu5AzK8SMf+JVcs2BB6FwrnpM6hDdnWZtJaKKgqJSTfMQGXiSBWAlq70pWOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+obRvOwQw1jtOIIaX7GVmP0JxY9IjjJ63VOSH/Gc4G8=;
 b=icJxY02gv1mwX2HL4PMwEcwzGzCQcKaYkvH9kt/Fo69sIDZahTAKm42dOyKLJnFNxiP/QJwADKfQkqcNNEwkHSAICQxz/6Yfbw9rNDgLhar2LcSQ468U2i34tQnlIOCOnwiV7FRq+i8JmanCwYWui2LtkrSs/l5zJrK7VcFaEJl8L6CnsWhwmquOUinTrDK7wueFr6KWOJq26xL7gfT1jnNqDFUabo8T2Fbt6fFXymnN/xgUi6vaLPL19io6o0nhhepg0sBYOHpgy3hIn2f7FtmfCUbxVJ3vuFj5/HnFgI+9EPit5K26neKUzxXM9vHYB7BfDUoqp3RR0nsPQ2iyFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 01:56:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 01:56:21 +0000
Date: Wed, 16 Oct 2024 21:56:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 03/13] net: fec: add missing header files
Message-ID: <ZxBuvUFfLsBVXKWO@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-3-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-3-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: BY3PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a77dac4-3006-4e70-3900-08dcee4ee60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VAQMcuC1PJD25KFaya02B6+RJjy1hgHG0Rdj+lIgw6rXSfJbmraw5ZIwriLR?=
 =?us-ascii?Q?dc1Vjk7PDRlApqEqLMtwCBfhzgHr6w8vYPkWfdR7IkFTt+2YbW18H5mcvwkT?=
 =?us-ascii?Q?zytic4MIO/zofVVYKszI1KGg70y8ZRT4ncBOZOAGLiQ1grQMK/uVMtni4JSI?=
 =?us-ascii?Q?jJvsX78YjXWAIq5afIKIaYHrn+s+yHfrj5dtv3endj/AVny/hZxrS0sy49Bv?=
 =?us-ascii?Q?zFnvIaLeHVUaddlo9GC50Wg+r0kgZZs5nrcTKg8MKsfS26GD4iVVwOSUPXDW?=
 =?us-ascii?Q?p2rwgzp4UHiJwQpwSDglOIoN7w6cfmcT0Bpy9A6nrzvYSZXpNlLKlq3+E1s+?=
 =?us-ascii?Q?1+ct1zhKiXV3fSSjI6hdhIo0rcKNhLUlRP7aAh1B0QR6CGaUij5rmBfJwJ4V?=
 =?us-ascii?Q?M0dLLkf38zzrz2eB27DqwjVOc4L8+kHHYbvxAXFkOZ5OJh5MdLywwYmvwS3o?=
 =?us-ascii?Q?SYIKBG1UAcs7r0guictihXQRbEUhMARRBwbqnG9opkzT6k4I/fdtUPqMnlwG?=
 =?us-ascii?Q?oUc1NOonMfQ333oeIK4EJG9zAVihyKhEhAqUlYcQQgAWe4tZ83DbHwkFR0BU?=
 =?us-ascii?Q?dYJAXSLTXlCUJ3UxKB/WIAkLNVXqSst73KOhY/W9mne1N1joSHRbgp0n4PB+?=
 =?us-ascii?Q?EpbCjg0o3jmLS+WxssYXEo5IOsX/iFZGrX+LnQ/NC3RSkwWYMYAe7Muh5saW?=
 =?us-ascii?Q?Wf81mlFhFjLS+vo1XIjq88HLhNZb2f6V04w/pc5TwYu1u7fTYSfp+bqT1Ru5?=
 =?us-ascii?Q?wqqNwvRD78CsMUjBS09fD3LnPogKKD7NfLCdZKY+UQFHDfNK1B5H/yOb1QHG?=
 =?us-ascii?Q?GMgMdawbJmX02mKSx8rZYKtOKd0kOkpSkKhxfPZghJV0VyAYmFQsqF4Ccsbi?=
 =?us-ascii?Q?+a2tXtLyOEHa/xpxg0fVaKjjbXlSR6vRxZVjFQ9rrKzy7jB2L7XLq5KnVD9C?=
 =?us-ascii?Q?Fcw6X6hFYyWfzWloocFgxlHHWh/iPaur6LT6z9vlQ83Yv1tesURN7awv2Fdq?=
 =?us-ascii?Q?h0jpYHRmYWZY15lgCfaMFSfEpKenk7d99ogHh34nSBQif/E3Q4VYGu21aFLk?=
 =?us-ascii?Q?0bO8wTdC81C+F0lk93ZovS9c8qmq49r0Vnj8Jz/cnRyyzmlwGibdiwvwFU7O?=
 =?us-ascii?Q?e4zUjXJXYVuKjMbnIRvaSyovtCfYKx4uKQ6vbtKtN498m03NABRIMcIdhcQc?=
 =?us-ascii?Q?QNEGqe1jKk9PLj6q3e961eHYuICelHtA3W8IOhJNaR8+oinW6s4POEhUNzxf?=
 =?us-ascii?Q?0HOAPebk2kt97kE5UYwARUTsXIUDz5aWDl2q1EhtxVvlVZGwP49XTnM0EYqX?=
 =?us-ascii?Q?ZuNkv2YaCA7L7Ks7ToP37Ou3AJXxEM+M9W7bJ486TvokxPSmsO9U4WCMapkw?=
 =?us-ascii?Q?f72tw3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0tUb56Uwt4WM2csgnQtccriBqH/t0+3wbTZUziQiz+CGZbxtTGt0AgUVRZRe?=
 =?us-ascii?Q?zy6d0OifyqN4FZ7B1D51CCZZp9PctK8oLAkaHf6ebq+qtFo4ksJFUz+zlge2?=
 =?us-ascii?Q?w+7Xa5jPCPVTwcTYYgPzi7Qdus0uXSBnAhi3MxqPYmAY4lY7nF2Ftw+2I7sx?=
 =?us-ascii?Q?jEU+xQjVbPwwrxDpi4h/iDVgmlhB4B0NSq6CUypPzivafBqB926PKrDq3lzg?=
 =?us-ascii?Q?0VCaUTvfprc25E/bzHdz+dJsax7GruLFlCBfYAlY0rhBKGcS3wjGMfSuUuOO?=
 =?us-ascii?Q?yF3zGDUo2nytFz7RFq6epCCWWuKQd61N2RuJyThluXVI3hLoLd5m60rwZZ4z?=
 =?us-ascii?Q?Ny/OrbWPfkVi9h9QzDFvwobDJ8uQZV/2OYyoqh3i9T89QQYyAKeXXmYxo9/u?=
 =?us-ascii?Q?p9RdiYCYTiy3LlH+3FEVFYXuj33+EmuyzJEKnF1h9c2g3/WCu/6XQaQ6NYcg?=
 =?us-ascii?Q?QPzZJNNv3iqcqj9OhaN3fraBIdMzgoTr6/nBWjFDFAcX6zZk6roEgb6y+v2P?=
 =?us-ascii?Q?hJFY0yV4R7NtZVIffUahoA/5ptUbMH99m4yaHDo31YkFxg9gLDb/0QzFiN8t?=
 =?us-ascii?Q?S4P/1npXUxmTBnyaFPqApz74dvxrLIld/8TPD9YL7un3rRZEkyl5SzTD/WEm?=
 =?us-ascii?Q?1ZuPIVd0UezXF4kdUQzd1944XoLFQgjnI5T4wBBVbBoyniQwU1KuCTCAnmxY?=
 =?us-ascii?Q?NuAPjOkpIVyHZN+gdTM14joP9quLxkjfVSnEmLWGhcrAI+52MnLm6pmtM3gr?=
 =?us-ascii?Q?PVbaVQFklkTQzm767T/m7Lib8L7k0FkYAbn4X1dXzciGKfw8azGkdqVgUH92?=
 =?us-ascii?Q?96b2EUiD7M4xnvl2mmWoL1Kl3wve8oJ7nHsw5LKqd36F/ppjDEHD6bvqPJxo?=
 =?us-ascii?Q?p8Z6HIBWVOTy1HW6JLl/LuoTEh7z6T6tz7G35eNaePH6+k0V5bav0pmwBUpa?=
 =?us-ascii?Q?O2VGWJApytelgOcMAqTHMifeYlhT4nDQh1Za3hlWVtED0xoE9YKGQgbETZLM?=
 =?us-ascii?Q?Gr81l2i7gzcnXEEr9iVmOMzoZkQPahBzuVg0Z/wETAPR4sZZUw4ISSJ+K09w?=
 =?us-ascii?Q?CEpCRQRAU6QugI3WYMhorieVrJ7RWAptY1m5xSz+P4WoV9G9e0jLl8L8h0cv?=
 =?us-ascii?Q?EuoWvR/QtLMdqyUK6H7DhNbjo0IjYFD1/CrMIrH48oEcIVY4Y3y+zDhgjwVu?=
 =?us-ascii?Q?QiHCOjX00oC6Ty0Hx5KY1jOlDy3Gxtq2yBZxWRkInoDRL3XlDdYoPvguwAMG?=
 =?us-ascii?Q?2VT8LqycdwmrL+OTQBzvKnKuehILICo7+GtqUyeMbOmzFXG6EnoAusXHpc1F?=
 =?us-ascii?Q?34l10kbRiaNui9xEvgNLsKnRTwp3siukIar5/d+emwLt4KrbvDERmAKh3vU1?=
 =?us-ascii?Q?aVn5PZm5SkW2dD9Te1JsOMPf6WpNjotJWre6+4YBy2TVuOGIgbLcjA6iKdtm?=
 =?us-ascii?Q?uemIfJ6pwBo+ikljifot/HVP9rv2s7fH/9X96A0pqVJQNl7lj1cHqnnZ+DPG?=
 =?us-ascii?Q?GnKM087BTDbLzfaR+5+7q4LLXAAfUvNo9FqoK4b/r9EQShqDFtcNYnzc+pLo?=
 =?us-ascii?Q?R7AU1a5nMB7unsDkbAbkUX3E0xfUgkM3Qo5D5UZc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a77dac4-3006-4e70-3900-08dcee4ee60f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 01:56:21.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ak07PNRV0sTSMlnlqhy6kezCJnjzGFwKltll7Uy3uUYKu6QwZ+ey8/c1VAX6yhTMWbsONgrnX5xtrx9QMT42gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

On Wed, Oct 16, 2024 at 11:51:51PM +0200, Marc Kleine-Budde wrote:
> The fec.h isn't self contained. Add missing header files, so that it
> can be parsed by language servers without errors.

nit: wrap at 75 char

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index e55c7ccad2ec39a9f3492135675d480a22f7032d..63744a86752540fcede7fc4c29865b2529492526 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -15,7 +15,9 @@
>  /****************************************************************************/
>
>  #include <linux/clocksource.h>
> +#include <linux/ethtool.h>
>  #include <linux/net_tstamp.h>
> +#include <linux/phy.h>
>  #include <linux/pm_qos.h>
>  #include <linux/bpf.h>
>  #include <linux/ptp_clock_kernel.h>
>
> --
> 2.45.2
>
>

