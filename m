Return-Path: <netdev+bounces-240429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2BEC74F7D
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A121A34BB8F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6227934F470;
	Thu, 20 Nov 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mwVCS2KX"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1F35B134;
	Thu, 20 Nov 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651722; cv=fail; b=jVVCnI+SI0YunUn1CCLUKuvyz06RRRwbl3h99JktBey1JyGSDN+9pG2xiZA5iIJsTNUKowD6Zd1Ou3xyr0FKazt0DE5I5khN5zTyEmKkuA5NGwwiXN55j3iTUt/0kgz44BxXHdoVmcD7vrwsxTVEaYqodceLnsRVCyM0nwzxFlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651722; c=relaxed/simple;
	bh=i3riWvkEu+5FSKtFARBxRuhBCg2613yEzJ1jWEljODk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DDn6pyf1MexVlUv9eWDL69xSOAET9Q0iBaJ3zi6cb/LNE03gzJt//vf2xwdPfCJ02Ghmm5WZVaVs+1+YZf/bv0RLZnmvs95ymmj2yJ4jvnKXyDYQXauZFbuCuPoZYYVqDvKb1QBeE3Wb/UI03e0mW3jggWCUK5GicpToVrXr2DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mwVCS2KX; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO3zAS2u+Fv2bI1xdQSt5DulpDxtKfzdU4wa1uw2QYtZCXJzCL65CpdyjU4bSuVOxF/kXuc5C+LtdlwpphMClRXho6FYAruLQk03d0c6ZhktzFi9tAlbkD4L/Sy0mPEQuqJ7I2/95CCd9UBFslsmj/84MoYl8J/G8E4v2/3tUtW/JL2QXcHVcd4NhlfXj4sz9G7AFvZxz3EKT8ZI6x8kmR4FrWuHGVRSBWmibULd6FFm96KAMo4/xYCLsX4wjryyawZx1FdJGZLhmRelHzp2rQpxT1/MFlwJpPTLvmrHR6sfnBqpOVyytyBHOX3clBHnbwF6DKiwoK5jsHOF0yyjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNxp/si0FLbt0Dhk1+EfgEghYHEXsDmMrF3iUt69fF4=;
 b=ILTSLqRZa49esGlpLJhXhJbUvGNC9qhCiuZj7doxLNPp7E9EN7+mQKQK6OQewIZndZLALQSx9aVBE0/ojmUEgDLrS4OIcrDvd2hXfnK7GCnvIVQYePnHs1yZbZKC9pZHUWp5kc7HmSkz+leggamdMB9v00SwwEU31S0++ccPXAcijfg12tI6P2d2p9YsIIqnsRefQRxYKW1yYny6gx6M9bvlJ1ciG0tzwXKHmaWz2f65SCIfKkdEsP3ZAb49JRUYnSEMJyZQ/2plG81GHn9On7cF899dJs1joUumubX0EYXX74N5tgh6oi3DQvJsriiZoeWjp+EjuldsVxKMBEg7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNxp/si0FLbt0Dhk1+EfgEghYHEXsDmMrF3iUt69fF4=;
 b=mwVCS2KXu9l5WJH6MVmSiUWDpEDL++Ic0BCqo9G81/Iw0mG9QbTucy2Ntw05MxVJArsgW1ufYoxs8Z29iYdIcm0hMoy5IPGATHXkmeb66nFGi6S0A48cX2wDRRTQH8EMggFJrPUIeL5NRllvktx9fC4k5q49L+Z7mrzxuXqmcQbVQf+SwXAPULS5uZs09dsxJm8F1t5fnhZ9n4Tfl5DJuCLdV+ynAsSE++Ufry20dGr9wcMbpCeMA+pJNOFI2d0toBHIyAGA8j3jHKml4nXV/1iAaMqNF/v8e1cOQeBN34Xo/E5CXAR2931hI88OShVN4x3lZuYo7hAs/eOMQuEz7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by VI2PR04MB10810.eurprd04.prod.outlook.com (2603:10a6:800:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 15:15:02 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 15:15:02 +0000
Date: Thu, 20 Nov 2025 17:14:58 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/15] net: dsa: sja1105: transition OF-based
 MDIO drivers to standalone
Message-ID: <20251120151458.e5syoeay45fuajlt@skbuf>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-9-vladimir.oltean@nxp.com>
 <20251120144046.GE661940@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120144046.GE661940@google.com>
X-ClientProxiedBy: VI1PR0102CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::22) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|VI2PR04MB10810:EE_
X-MS-Office365-Filtering-Correlation-Id: c511b8ed-533a-49a5-a071-08de2847939f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S+g0NkyXiFo7wBy17ORWrqqOROFhswon3cBjJyrJPwYEjJV8+zKzQXE9M+P0?=
 =?us-ascii?Q?7qLu6nfBJvJ9/39Twq1J662oNxp/48u9XsfVwo/Ct0hVbrkvY41lU2UFLic9?=
 =?us-ascii?Q?zibdI49gzPQKpmZusAWQ27zrGShJv95Ah1PdOSRS1lVoxMjntevwgwQb4sCL?=
 =?us-ascii?Q?oL8HLZB9FaWDlsYXpM5i9PBk08lmYOmC+PcWmlQQeVBA/pAmP5mJqPmD5pZd?=
 =?us-ascii?Q?LnWDzr9ARQpaKODL75DBbGRvAQ18rnetoBtMW34RuO9PM2fH3E6obSLcJOR4?=
 =?us-ascii?Q?o4OoM3bEAi3CjpFAD5eDApond8d0MpMKeA9jaw1aX448f2WAO5WeqsFPIQKj?=
 =?us-ascii?Q?deqM0jNYiy8fkXqOtS7qQekJrpCdhrKJHeBU4C84YppxQEYYca883Ewn6Ex3?=
 =?us-ascii?Q?2cZNxOEXs1NekSgi3F6jAmPLuzOJBkCrT/Fq0oUhueDlrqh+MTiJ/1RJzsPb?=
 =?us-ascii?Q?LdL1udp69GeCQPv5l1S2WjbdV47we00EwGjFKtC20EymDeh7h/4QRu+KEIdL?=
 =?us-ascii?Q?r7kSDn+ddSgfIvd55aMLGU4OI47FS1Rm2S9wPzNH6G1QX17kEuXJSDvZidHd?=
 =?us-ascii?Q?1CKX99gs/uKs7sxFrxMLO2Q5infDlQjWtHKc92+ocszweMmvmdeSBiKsRsY8?=
 =?us-ascii?Q?AkHEcxbmdjpwyMI64tMdQPjRez1EA0H8JLGKbXBdx4Zs5qnV/FOzrQnCgmI6?=
 =?us-ascii?Q?Urtari6+rnozGGd1be5ZU16xPSdtbzrY+FZJy7Uso2EoLw7jFHQvTg1emi7a?=
 =?us-ascii?Q?HGv3WxHILxHKBZabqXZXAzzQT/95a0Z5DEW//HN3B6YaLE32zIUjdgGkFQjL?=
 =?us-ascii?Q?b7bSRNPyHC19GoFSC/7ZXJX3+dKH9GH2D6U/jx5JR76pnifdS8vcX0IEy8DN?=
 =?us-ascii?Q?pzH6Eu9NOJPdroTxp9f8I8iqOhNe+f/48PaQlv/EIEb33b4cnwpW1CdEkQiD?=
 =?us-ascii?Q?3L78x9ibwRmMT7D0acbR1Sk1Y1biMW7yxF3O6mU5FMYMwhVZfDyEeMDj2Mun?=
 =?us-ascii?Q?V7tvIlzZougfiusOD7Lh19D4V2ZQg+7t/tlNKkvIqC9AEJVqaqCXVr8b6Y3p?=
 =?us-ascii?Q?UXrgy9Ss47W/mrYXnhv71BxxaBMgfU99OM/7IKGoooQxq6kgBc8MLu7u6nGk?=
 =?us-ascii?Q?Ph2XiG6fNTvjfSo/wRn3X1v6dikDGzxHQQ05+fag+50+3Bg0ThG2R2TaOLp7?=
 =?us-ascii?Q?sBpWMjUm6lRbHxJkaKGcqODOMIgHdBRP+QGmGYYtmYPvQIP8EGaI7mFC9mtr?=
 =?us-ascii?Q?V2y4p5DWX50cbrqwy/2voI/GkUd4lX374GnKAXidPBg+mhG80ST47uLITKkV?=
 =?us-ascii?Q?yBPWDRxOzUsuQvrM8IRVaZdf8xNzL/wJzMDW4EHVLLFpBzhnZkdC7CoX4CFn?=
 =?us-ascii?Q?2P+bo/hjxU6rInV/1FJO57FovFQQitKv9JvKNOYlLIA7QkMLa6Q97iQbnLpl?=
 =?us-ascii?Q?kpSn3k/CnPbfll7s07Z5Sq2EQ4Pr7ZBUnfkGkaC3irxODlrv+INHAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vwUyJSA/RLqntAd91PecBfkSzyFtIUElVt59O5SF2EH0JKzorzdP1kUmXvY1?=
 =?us-ascii?Q?nvzQt63VC+1JfwWSTpoBoEigFo4cUPd8UMCX+3l1ljiy5s+zPpyuMKm9Mppt?=
 =?us-ascii?Q?VTC+iyuQstp29OLx558pz1uE/4z2f3GSCNjzPR+D+PSi7bgk2YnhoVA/3TCW?=
 =?us-ascii?Q?9lil0zEZtO3UEZVRzjJMYnv19TGrVD5ROMIt4uoDWbWkXDj7LofK417q/Z2O?=
 =?us-ascii?Q?owY88spWtaGijHQYS9JTzoixkBQOKw/uTTzXLzaHYRS8AQmaoKx+9Jt0kFxd?=
 =?us-ascii?Q?6Hbm0aVkSd+CVeetSoLQ0RvRIBlWumaNmjW5l9cXX/kqY+S1CKfQ7g2I3lvQ?=
 =?us-ascii?Q?zP4VQ88+VZzHG9eAVbfRHNVgfM1UEymBPjos8ov64OAT8DFiG0GsDLRekP4e?=
 =?us-ascii?Q?KIJ0TxcsjwQXgUGiIUMPjV7CkYYe917Cph98+QVRvnX03oZn12lc4ki/3cY2?=
 =?us-ascii?Q?IjDsUxLTzADUQMf+6P5Gel4wdg70YYHpI2m8VCIOGOS0hiqsRaNr35SCklPP?=
 =?us-ascii?Q?Lyy6NcPUITVH2DYW+CVIPcG98f4zD8b95AGvoSsOYi3dmhU4nZmSfM3VqoO7?=
 =?us-ascii?Q?VInl8mAImWMgkROD9jdcRTxm3XCso5NjRUkwduU5eQLAdqv+ZApTwYnWphJ6?=
 =?us-ascii?Q?YwDSFGrtXNNAom7wc8TlOqxYdgFb1Hi4O3CsflpNSokkygPx1+1//P9oZc+6?=
 =?us-ascii?Q?LyZKMyOGqjSAs/XliiuabpHc379t1fy4vWFwcr6Du4hmIK8pdaAnxArrZ9rj?=
 =?us-ascii?Q?Q5HvVxCS959C4wZVX6w+F5wqbOT/nmoY27uHImz76FtkMyb/+lF50mII3m1D?=
 =?us-ascii?Q?WqcJuyR54UQg5vc4+irRmWjJiXT1oSfMlKgWaWG5frWy7BEp+8UGCJTmqeUA?=
 =?us-ascii?Q?GudONvMeS1KJnRTQLwGfPwHbIOBLR1Fh6SeZ1hlrpvgi2f+uAmSXWwy/OiZU?=
 =?us-ascii?Q?M+s8sdoiNcqt6dhZLd3a+ykibD+BoJ8xVA1rPCCeQOexckPN1ODSiXNrYmgB?=
 =?us-ascii?Q?jgdewsOMssF9WfPwKj4doJDdq/m8AZ/z6x3cMuXkcfBeiMAc2UiebyQ7mbrn?=
 =?us-ascii?Q?AskZbf0DRA2oG71OY7ZIqzWcLOW/Nuh24aWnIZBYsy3F8+9lZa4hW2XCH2i8?=
 =?us-ascii?Q?u6yBsofG3Q5b7U0LMHfRI6OFsRdqYOBfUQN9XK0Vo7vwDetDEPUqThvDWhvT?=
 =?us-ascii?Q?dhFpPFtKJgtpquur3XMnY51HQkmGEj0GTImA/HRrsXw/lIubNE+gwefCcWbD?=
 =?us-ascii?Q?CXo0wdX9TMYe+orFUVbIWB6DrUD12E7Jl/q7izTxpu9MFstj685yH+hFLfh7?=
 =?us-ascii?Q?rpJzwZqQCClJ3Whz4mf90OZ+xlnpJRKFHui2v4fRaY6caVkr40e5UIbnxjx8?=
 =?us-ascii?Q?RcFC4sznaEnbuaEQz7+3ZMgXGqV6MhwjH3I692DgoOfg/BG/1CYn3UnJTkAC?=
 =?us-ascii?Q?QJBrDXW0FM3Jzu0ZtANzgERLpF9V/CnvH99qUUJGuWgkgbp0O1WgAjlR7qRo?=
 =?us-ascii?Q?12gbXbkC8ekLR/0KUvaQeLw/Impc4xWsJlBheeNis+6GOhGjeiEbcO6kRs8V?=
 =?us-ascii?Q?FwGoFj/p/XjZxJaUGeEqG1dplmcMX6x2bUvdaP1liHqW/qYgNAmEU9VYJEP5?=
 =?us-ascii?Q?5SiZ7zE3A1IebYAPuG93I0y6x9uLTYisrM0zsjciKss1B1+ZH7EQKbeJzYpl?=
 =?us-ascii?Q?7qMuTA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c511b8ed-533a-49a5-a071-08de2847939f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 15:15:01.9801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0khgL1+ONYSEjs/1wdfllJDEeIylzJZt2f06UlV8luo8IqzbyLJPDpuSjCGlMo6vCCJd07lWm5gJ8tKgShxwqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10810

Hi Lee,

Thank you for commenting on the patch!

On Thu, Nov 20, 2025 at 02:40:46PM +0000, Lee Jones wrote:
> The MFD API is not to be {ab}used out side of drivers/mfd.

If mfd_add_devices() is not to be used outside of drivers/mfd, why
export it to the global include/linux/mfd/core.h in the first place,
rather than make the header available just to drivers/mfd?

> Maybe of_platform_populate() will scratch your itch instead.

I did already explore of_platform_populate() on this thread which asked
for advice (to which you were also copied):
https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/

    It looks like of_platform_populate() would be an alternative option for
    this task, but that doesn't live up to the task either. It will assume
    that the addresses of the SoC children are in the CPU's address space
    (IORESOURCE_MEM), and attempt to translate them. It simply doesn't have
    the concept of IORESOURCE_REG. The MFD drivers which call
    of_platform_populate() (simple-mfd-i2c.c) simply don't have unit
    addresses for their children, and this is why address translation isn't
    a problem for them.

I'm not trying to start an argument, but as you can see, I've been stuck
on this problem for years, and I'm between a rock and a hard place.

