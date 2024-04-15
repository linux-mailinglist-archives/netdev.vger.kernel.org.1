Return-Path: <netdev+bounces-88107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7D68A5C1C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F841C20F8E
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882BC156652;
	Mon, 15 Apr 2024 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q32W2x72"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF20811E7
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212047; cv=fail; b=Dv73OvIuiZH1HXa1r7qBcQCHukO159k1M+M/jzcM+gwjLQoYtEhBJ7vA+URVhiR7/vbpomRchhB4F7GINu8s8046e7CPPZHPa28Pg+yPuZgWFXsBtgWL6W3WYH5SjUVGg3ev4cRE9Xyxa+QugRPI5LKRtMiA4P+Ht4GrmlvYLas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212047; c=relaxed/simple;
	bh=jJxSdEHWSO/VRg7AAoeY7FY/piLMyoC4ufZDrbxjsQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LmnbWCHqTMqbRuibclgx8yxLLMyDWp55I+Qcf/5ixXgWgt3T5NBuPJ6auXgUJhgMDwgHqHfaOriHRwIKz4HWsDMDhRf0or0vatHDeQys0jBdhXKbJ2bFX9+CAt1q1C6di5876E6F/kEttv72AbmS5lSY4NE3wM2Ab7ZKXVNj9WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=q32W2x72; arc=fail smtp.client-ip=40.107.15.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOaorRFpCIaaCwAhwrxI2GkyLY+KL40bCOo5Vo81Nrg3dyVhzvaGf4UBBD+RqEHk7Gv2BcjPQiRAm4OKv+nFt8ftm30t3ePeFi3P2g7UXWMQxk+Ln1xnJ6MQI2fKKjxJe3UY9uPXWp6TxkBDBIJonVnk4R2cbAmW462mJieqRI/V8ZZUr/OL4E03Wi24gJWJfD5TK5PMr3wzQE9FPXeHbF5YStncjyU7xqHdJdq1nQyMAdyAm1fU95YIPlU7Oqb6bnYeg+Xz8c925VzACgfwzgoh1X8TDojwKdjj4iCSTrGJh0CuhBW+IMcLgu+GEpk0OhZzoBOCaOINKHiEfRZ5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJxSdEHWSO/VRg7AAoeY7FY/piLMyoC4ufZDrbxjsQE=;
 b=iUNmHqorZz/qy2LclEH/uYSPF8zhKGh3cgNkYN+deSih8vLoWxknnG6P5ZwDVHCK6W1iHVoTa5LeLZabkKhve2qc2V5aUgQfkYjitpXJwlH1shT78mLSrypowXAAgfpoJ3sk/hKdaduz4fetzKP2iwzKwl80jRFIgMZ1K0EmfbLSqtMnKhaNCcxU8WR5voqwjMj6Es4fUe4DfeXB+zvB6XfBudBamPU7axxN0igU1TrK7Ckr25nTOGR6bj0zCDiBWdxjSW3L9v86Hcn0HUStsFZmt98ggMg8ATmPLyw0jtIFZSWglq//kAavNgnrTROXbnYp/O44Viid9ii9ks9fvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJxSdEHWSO/VRg7AAoeY7FY/piLMyoC4ufZDrbxjsQE=;
 b=q32W2x72shjIwCaNQ0mTTlglLz0ow/WKagMdFUSiOb2V2mgEMIRGuuEpbUGO3YC+7XKyXptwwzv+CRc13E3IjFk97BsVl0iyoh4YkKO6oFKZNQYiBD7CMUPxzKYkiSRWHg0SdevhC0PKXh2BJ3SVFQN0AZOzjIOTwj/OaN/ra60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 20:14:03 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::2975:705f:b952:c7f6]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::2975:705f:b952:c7f6%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 20:14:03 +0000
Date: Mon, 15 Apr 2024 23:13:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: felix: provide own phylink MAC
 operations
Message-ID: <20240415201359.5sw6wa5imcc6gaft@skbuf>
References: <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <20240415103453.drozvtf7tnwtpiht@skbuf>
 <Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk>
 <20240415160150.yejcazpjqvn7vhxu@skbuf>
 <Zh1afZNFnl0DObX0@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh1afZNFnl0DObX0@shell.armlinux.org.uk>
X-ClientProxiedBy: AS4P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::20) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 98398b99-2b3c-41b2-12d6-08dc5d88983a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yx15Ylgexm8ICNb9RaLT6S9OwWDlP7i2BJvBul+klPknuuP6CHtT3lm9g4GmoIJp54pDK8WYAp/R2VhT0PCw+vuOBXGD6LjxQClnjM3sKGvTDHUr0ErCEO7dUN4ksq0m5/Jq7vFcH2SxE7sXzjeb/1RqjTytU/bozbUGSUO+K2kJTSgoDsQoS2wy/14p0WqSOfpjTUbehGPsaLrMdf8sUzxqe9AB7/WdmgBmEKYMnVv6kqDMs9jGKO5cffWvhPBv9fI3eIvB+AFObOiEk0esbk2cx0Sd5JAnn/+cLBDtDf3CsoppE8fKpjiASgRrc3yzy7mei5GfJhwcLx+GDSu4s3POKwZ7KZh6R93SzaK9KsuTVtWnYhpf3l3KVpTRpFQwYqWwk5YwPIjgtZosPiLaNmzvxxoouWqn2FdOsZpDuG7JcKbWbK3MjIOM/Mu2tmS8mS3pbmDxiEPGABPfOa9vQ/veXKyWwjkdRz5e2cMlX6N/SkvYiKQC6qZvfXCxO5QT6GAcXKvA3XPzefyaM2eO0y0F4BkQX4yd+1MxUyHe2q5pcSSRau7O1Zv7Shy2fYJJsrH+h8HQNY4STCkM6qdL6CSY+a7WeOamSAv48TnGbmueOXggQyK9Mg/eAHZasK1fqpPKowqvTvat+AFECUi6yitd/bwfsc6puvB0aKbjX4k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NyD1Q6+lX6NptOk32miBSC5PjVYiWocprABPMCHS23rEun10oWDBKbWgGNwC?=
 =?us-ascii?Q?5oIQKjKZKeTH/7AO+EH5trVzPKhe+SMoiSIyVU4oQ0gy3QF74NErb++oSdkG?=
 =?us-ascii?Q?O6rfMM2XLxnWgJmuxTxinDgKSK8OuK2vKVD1ZmeYbB19ZlKI0v65vtb8q+1O?=
 =?us-ascii?Q?ilsokZ9RMsSrcK3JfH44ALJ2S5Uzb/uog7CYyCeL4kc+SrQEry6RvVnvWxKH?=
 =?us-ascii?Q?q7beTvOfN1+W4cafK0qwYw4zdOQn6vu2GWZE2sasWMnT05l+pOeVO30zUFcb?=
 =?us-ascii?Q?4c69TrIw8+DMi4zEajF3ilFxjeRpAkiOUyIjoc0qkPDpLe7A65RXh7RK6X20?=
 =?us-ascii?Q?ZTu8qtgMBQDgfAH8NDjk9cYB3CWu0LVe+PjzlvyzaBIpJefWM6ma8uUV500+?=
 =?us-ascii?Q?VEdNCuh6ypaPbTBWOj78rwPIiQCfgCxYfJY/0Q/qWEvfKqp/AOXisVGqnqx5?=
 =?us-ascii?Q?z29Nt9ItS3SnfEn7ij/GImckQUyWBKLKPigAnXlwsDTHQHm8a6Rt0p/7awZS?=
 =?us-ascii?Q?YUFaAxS8581eppS/pkHRlSVe8VkrWbHXoFLL+0+VyMurxO2sDosZ85/fsnqO?=
 =?us-ascii?Q?f5f2poKnpfW8gtGbfty0YJygOhgVSBvgtZsvt/zNYFZVVe0LFAKDgSKkpiuZ?=
 =?us-ascii?Q?jbyMdmBZqsNhxHEJbdVI+VfZjDnyIyiAxNpxlavLs54E+DPxdymJ9y5iQM6x?=
 =?us-ascii?Q?GxThbm0G3+26OjmtPoYV7Qs0nO/nG4/5EJj2c+GgjM0zDQL3Xwso3uFnsIQT?=
 =?us-ascii?Q?ZxYOXbfnGmjRgU52vNDAc7gWDupNPvOJHToHQ2FoWRaXPVZIcoEq+CjHvhAD?=
 =?us-ascii?Q?IPuf91e4vSe2vXGe9aRO6JJunWa07mhMHzUx8lyxnxm0/AG+TPCgWFoDITjD?=
 =?us-ascii?Q?mdJGp4N6UBWF7/4e5TAiR0h6Z3SLd1wFAQ3zghHGXNgZ1ixxNq+2H7KCOZIH?=
 =?us-ascii?Q?6lGskH/KWK3uKFkIKuOg/jdh1QmA6T+WQh0yXt/21ZqyGSr3LG0BB1xgv8s9?=
 =?us-ascii?Q?CHzDkfVwI7NTihVkhixWsSAJrXUZMuA2FXeawm1WtSsFA8+8VtGx4tI9JFV7?=
 =?us-ascii?Q?/h/IpkGg0vuQRDAvwBLgdelREfdjsRkjW/BLPpjhRgYgIEmI8cDTd5mkfB7s?=
 =?us-ascii?Q?O4B9hR8ZmWV6EmiU5rxnPyFUM3p9jJdLnTRQsF9Dp1twRB2dzvPlCX2wZfDn?=
 =?us-ascii?Q?km6RYeBjZjUvkC6B4j7Ln5Db+n7qclau7l3InosjpT7F6x5ZSJBfw2+LiC6E?=
 =?us-ascii?Q?42FXbCV9Gy0guiYasLEdQ93RJx/ltyoM1aCeSMSMSL7yicFbeX+HtQTCAUd3?=
 =?us-ascii?Q?PKDez+cg7XRSi/QnbmcYuTVypeXsatFSLMp8UkaRtOxsD1vrxj8uitm76/A5?=
 =?us-ascii?Q?Klc6Suk6BnmMFL0M/k2mVEvG6/IU846kE0OImye6BrNMPLZAn2uXg6zxRnDi?=
 =?us-ascii?Q?D01lGx9saCC8ntnUbaCmdZx27opCrB+yUV5k423w8Xis+uTVLw9FKFd9N6M3?=
 =?us-ascii?Q?2PpFKukMZzwj4sdKJuAEUgHGYAMftnd7NEfzUxIwLenrlAPQ2z3UUQqBVqDv?=
 =?us-ascii?Q?aadB10kHf9pSDa432WE4a2HPDFNuanPI+V+epCf75VkEYvW2Y2246eQ7P37w?=
 =?us-ascii?Q?G9R5COZ65Dx0vssSVdpfoXY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98398b99-2b3c-41b2-12d6-08dc5d88983a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 20:14:03.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6MlrxrRgiGB8u+3EvdmGek5ZTEgmuGttgYn2CUXsDTogHjur6v7Xql0np+1iEE2EvLGIpauH56H24oHO5wGxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

On Mon, Apr 15, 2024 at 05:49:01PM +0100, Russell King (Oracle) wrote:
> Sounds like there's an opportunity to beneficially clean this driver
> up before I make this change

Yes, it is.

> so I'll hold off this patch until that's happened. I probably don't
> have the spare cycles for that.

Alternatively to you waiting, I could pick up this patch and include it
as the last one in the cleanup series, if you're ok with that.

