Return-Path: <netdev+bounces-139127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323109B058C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFD01F24AA2
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937EB1FB89B;
	Fri, 25 Oct 2024 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JW6jZSyp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2EF1D4604
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865898; cv=fail; b=R1IRL1t87G1pUYgwTDSTBFmOiCU3mO2zz5h5OhBqmg7/xJcUDF+F9v4cGpLKCSv1wigIf9nMnl8qzwnDNRc7e5d4BYAIjEB5SR93RBrkGYwylvGcU86/zJ86D/8duKNZdDGguWkowMilo0nbFoBGDe6S1Mvsz22ntxYyeXMQI5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865898; c=relaxed/simple;
	bh=wBoJ9dmru4r0w5fcqQuCpFk7GQxqoHQiqDO+kjhUh8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R7+XdPFJQmuYjC2IlngUyDY8FWUzTw95fEasUfj7x9lI5gTFnqhkcdOzbRAYgEqeRLfXaQYS1UIDuJmY+mNS2wI0Rj3jy2tVTUEDj5o+f2/lN0BzDJkF6rSsqOjDXNH6MwhkPedeZLiNQ1VAZJQ3qHr75raWloYJgtwewd9elBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JW6jZSyp reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bD3uM9u5yRX5wmyVJuy19X4PoXuWNTI+21JlFG9VeZ8vAaDuGzFYlqfWOQge2+WkV8KNiAFwYQhJNTeU0buoRFuyDx3uBfIPh+AOT3S0DuKCSl5n+g7ZCZZSTuTvzxKaOgIUtuWe6+wmv8iNyJkU43VxWGNgNOrEY/DyBFQWk+3ZfYGLaigORK5o2EW3qcAT0Sfcfjxg5wSz1GLasZDbxU8S1LN+ImYIZEcDMXiqj8TbuUr/h+5BWK3DCcnH3mk17V/YoRVwyTwxcbNBzcWlnLIGSKHW9viC7TO5lO3/XbusMM8R5bOPYjAgCb3RmwZcLAtJbJNTl7Xd+XYIg13DYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyrcHASqNeBTIPaTmmboHdi6lvktEZlueRfe1KUHZyI=;
 b=RAyM67vwZdP3M3j9v6Xstaotx2u8LJDBLozNHNe9vsZ1k9rjLuy2+r9vdSTjZ2ibaWaNU32UkrLeFAguS2NTZ9bP9DOJS7bmxRJU0FGRosxhipRvNVQvSscyxOMcCIhNo82L4RFc5pf8Dq0ZViC5aARdVNVGghdK8IQ9JrVIweTFGg6VBTr6qKmSNKYIA8l5i1KeeQhnLO1kh643MpJW+evhNGUMG96g4KdhpvV0s3v9hRTiY27o07tjIXFjpwMcq1uMryvq15JvwQ8xWoHdYmWmXtROFmOEwl7hp0BFCPVianZ0xso23irAAvs9Xzk+T8vS5VsWKjTkqtuFs/hOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyrcHASqNeBTIPaTmmboHdi6lvktEZlueRfe1KUHZyI=;
 b=JW6jZSypS7PMRiB28TwQ0P4ZlhTSr4ZYPI9UBsq45yjRO5RSzoAe2z6gapdAlT14/Qqz3tN7r+DGhJyvVZPNMoqhHylJTNcnNIhRzkubRiTBbEl/2+nFBGQxwLnTC2GbWA+Y1z/Vf+N2r/+PeN0MMBAKhJVSaXkvTPF7hC0E7QMY9F1BaYmvKJU+r8UW9KJP2zJss7Lh01Trw0NbHP996kHgDMf6XTk+rSabf/m0ZcdS7uBBiPupto7TK+5KfIANgQT2RBBoT42nyg4yEH+JrofONqxBYriGyKAeMRDXDf7ojGCMPpv4DK3aySONMRWsQLnvIhUyhIPCkJyUyGHnVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 14:18:13 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 14:18:13 +0000
Date: Fri, 25 Oct 2024 17:18:10 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: =?utf-8?B?SGVydsOp?= Gourmelon <herve.gourmelon@ekinops.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 1/1] net: dsa: fix tag_dsa.c for untagged VLANs
Message-ID: <20241025141810.b37jxsaz2jjhxhvb@skbuf>
References: <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
 <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
 <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
X-ClientProxiedBy: VI1PR0102CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: cacb6585-b9fc-42b5-fd64-08dcf4ffdc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?/XRE+3wSGK0PXEhbKIPVx9Nn4JDwEJsMw1iJiBbiSW19ARR0K2fduY5FJE?=
 =?iso-8859-1?Q?kWmZwpJSzdqrvVtLFQIlsci4sBHMWrVKbjtMwtxjI8bNzUaeHbsu9r/fOP?=
 =?iso-8859-1?Q?7fZRaGwRt5e+cEohKFWn1rNzxY7N19FFgw/IZ72inIwrYONGtjd6t8r75P?=
 =?iso-8859-1?Q?TMn7ixWMZ6WxaJIZymkprFe13qfgclFhNQUMIq1DtpuuHVtFt7hKHGfHso?=
 =?iso-8859-1?Q?MnpSlgmNSf703nlqdnIlRAwL3hqGwGmXf5ofafncQcV8v3/FVu9hFRV1PX?=
 =?iso-8859-1?Q?IItpcmwNWXb2UgbsRcrAwJDDIq4J9lwBYQX2UBu3MiSZsar2Leeir7SpVi?=
 =?iso-8859-1?Q?p3Ml1ZaAVYPI745X3RoHNbVL/XJsxOmzJgu+PTrWmocXTOyNoPoaaXVfCT?=
 =?iso-8859-1?Q?3LCWKZyi0qXOmxn033bzwS1kE/gX6W1P9jZluOe+zWLUhHE0gofpYMDO4f?=
 =?iso-8859-1?Q?WBi1HxtoKBTPVM1Ka+PUsZb+JYTZsHL6sljGyP6czEuAMCP7FZpcmKASGU?=
 =?iso-8859-1?Q?0OGhDgTSgl4MrgUpkkFHGk5zimvzpBrh79ho5gnx3z+ZE+Y99AfVKNDny3?=
 =?iso-8859-1?Q?4vfmFeeCw2PsD1BAIET/39q8wb8MQVDuPaERYsjUw7qyfeyvYZkNwRWvpb?=
 =?iso-8859-1?Q?POLkx0tSXLH9w2Qk/PGHKHX/fVlneKOvwjS7USHCjW7dsOrG+9EY/lNhuM?=
 =?iso-8859-1?Q?9SfdKyKsMm6vvCDXyIAqrR449cOJuH8+tPxDKN/NgScR4e04shFw2vna+I?=
 =?iso-8859-1?Q?Qq3R9ib6C4727d26mqc/eF1LVKsaXRe0AQWRLhRX0raualo3cxATX1By+g?=
 =?iso-8859-1?Q?2Roui0pTJHIiaqIPYRikqXOz4EFnA3Rf6wK3sknU0YT5dRLtA8euLUbSzO?=
 =?iso-8859-1?Q?jDmV0F+hkHUgLOnrV5vk1d/k3nHKNWnVGCOeDxm80c3tHTHT5Wb0gMc/m6?=
 =?iso-8859-1?Q?9Nqz6VaybyL9BhxZYaA+F4AQE7tdyyK03ZhR1r2PemjMP65lUFCvbqyba3?=
 =?iso-8859-1?Q?fb7pJJvOgSVZeXobS6NM5Re0VhAB71yO4Bt6+/hFpyBiFuf9lNI54EC6cv?=
 =?iso-8859-1?Q?sHDMFT5+EIKBC2glMjjPaSb47NMKBV754ZZFjow3kf7QY1dPW1Xevr/5Tb?=
 =?iso-8859-1?Q?UeVe1RHz3ZqOu4W0TbSDPypp8rU61a0DSuA4U2O7aXHzghfTt4uvd8AunJ?=
 =?iso-8859-1?Q?1dYA/KYIRTWe8FignppbFl6nMRrTv6dB3UMNaw7roGU48IKpaHyo5Tj39r?=
 =?iso-8859-1?Q?v4wE+xNddFU2YCcuX1BZXLy/Zsqn6Ca+jec/UpCE21P+z/GYOl1XIVn20e?=
 =?iso-8859-1?Q?K73dzE6fK3O8Ia+pEOMaLWygyFzYDwu+DCYJAa4mPVzMEE+Fh9Nz4ZwNu1?=
 =?iso-8859-1?Q?WsAxcIjhFf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?SJZU9PUnajqaXmyAIE+WdAw8sKRbfcRKRgDeVbH8MpzRiOjYMSymPgDl9S?=
 =?iso-8859-1?Q?SziWraL130bJuqy5WEtnUAZ0WCT2EVl9rYV7KC/TcZigGGNBl6GYbrq0jj?=
 =?iso-8859-1?Q?ALJyj9lK8qmx0HApZX3ERbYeXmlISN9DGSLLuizpIGhva33Km39TNSTCrr?=
 =?iso-8859-1?Q?HgWr9kCgR5Rx8JZpHju8qXQrFaxpygjreHk8//8ya3/ZQeHiJv8JTLEB2u?=
 =?iso-8859-1?Q?BgTZ93o/KhadOl2V4T4jRObwQfMylU/3b6Gh503pmST6C7rAnPAbOZI8qL?=
 =?iso-8859-1?Q?YfjcpqZLc1ELqPBJVb6WxxP/5CnU+tCc3ZnBNcU+vQYC+WWX//gRtCACTA?=
 =?iso-8859-1?Q?xTwPi+GwpI4U4ujhJHvfQclMDRtb8ZjIsu8Maxvlx4n6kySrbVNPZTqji6?=
 =?iso-8859-1?Q?9txSqTSa3Lbx6sEaz1UFpfuwoexeiCnvQc+VxXG4ZrB1zbwlIFPFPV7sA5?=
 =?iso-8859-1?Q?uBXUifwLXIYJ3b2bcXgRmVdAUIMm/1kkd6bW3HSjRmIkDsr3MjfMzVphcB?=
 =?iso-8859-1?Q?F7xwsPlZSbUDgjIx/Pf0fbsQSeV7IlWH9Kh+iyrhDD5b2VEq7e2eXq6vfo?=
 =?iso-8859-1?Q?DHM+YrOMEUlSeO/HZL9OqR4JHcyB5YXI8nYea/2ugOpD3fSTWu3Dvti34l?=
 =?iso-8859-1?Q?sYNA+h7Uekx8YTn/5GStNHzT2bx5k1oDzmH847AvwOd6gsnf/MYuEEAJO3?=
 =?iso-8859-1?Q?HPzjhozhFA6e57perUb/CGXYe37/zxZmCno6Lk8If9tvE3lPM7Ayt0hRnl?=
 =?iso-8859-1?Q?lUtjdYJtKTHc3hMq2XcaaUVI94nCITwJzELwBWrh0aV204ngahyobjevvl?=
 =?iso-8859-1?Q?KIeKPWsY1N/MTJ8u59QX4XA4iVFsdVpQHcRmuSVkhFeMMPm+HgXd1FOqtD?=
 =?iso-8859-1?Q?VH6RKzqfrNIMN/62h49RFtXYe52qnxZV6tumMYlEI4icNcjE45K2eERNVO?=
 =?iso-8859-1?Q?gqjXRN2znbkOZtEhsEVS+GBtcV6baBT9w5o9BlqSLPpIeyuXNqOFoqe2fP?=
 =?iso-8859-1?Q?LgkAgGS/HgEvEB9usfTJAN+LEm/rf0dIvYrR23sYfDkPfD+jWOevzS2UDz?=
 =?iso-8859-1?Q?jpPLcRRMMpFyxrUn+kPHeOPSf15nDR4V1F1HyCDBZC11sjn06TSOg1NPze?=
 =?iso-8859-1?Q?O2ghH47V9hSePMIRpyCqrsRkO7ajKVZ0HusDXZ/Q8Pr3Cmp2ZbwI7LnFn7?=
 =?iso-8859-1?Q?zSgOZhmE0hhXm2hjAsu0n0o4JdHaNEEC/AhTql1f5eZfUmYvq6URluOHtO?=
 =?iso-8859-1?Q?nok8IUQ85kGeLVpkIQ5cHwKk89x/Unjo/2Fvhs+xwLxJT+xpqmr3gXPAbi?=
 =?iso-8859-1?Q?KChj05JHhxyPEWrChBQ5x5u1VznTY3atmEuzPpZgoUVXRwmI09YHamnCTc?=
 =?iso-8859-1?Q?Lf3rVhkkb9r8vO+akEaVMrAzosljgm/wt1viEoWhbP/lJ8/s5N7KrTdQXQ?=
 =?iso-8859-1?Q?Hd01S2SDjBTUnDvq0Ml3CW/NOmlSZE8gqUfHY/VJ05oEDmL1LsfY0f1fuU?=
 =?iso-8859-1?Q?R7DRC7q3Ty5gPGyS0l3U1cKtSIVDaDc1nP7xDIvS6CGWBtvh21vidtSst+?=
 =?iso-8859-1?Q?BtipvIf9CiJlBM05gDyXB3/ABGgofQnI33tPu8P8hHvCgD0ueWj7IGE/tT?=
 =?iso-8859-1?Q?ZrbM8tkYUQijBulxDXXfWLK/gwgE9onhcXefX/vCm2aG1t4k+uCoi6VQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacb6585-b9fc-42b5-fd64-08dcf4ffdc74
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:18:13.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulURF8HKM3JcGvb8M95kU0RIZc9gCqs+W5onIw8AXFb/vezs0Nzp2l0iW3o2TUwtEXOarIvL3CRmU8S7SCMiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

On Fri, Oct 25, 2024 at 01:46:48PM +0000, Hervé Gourmelon wrote:
> Hello,
> 
> Trying to set up an untagged VLAN bridge on a DSA architecture of 
> mv88e6xxx switches, I realized that whenever I tried to emit a 
> 'From_CPU' or 'Forward' DSA packet, it would always egress with an 
> unwanted 802.1Q header on the bridge port.

What does the link partner see? The packet with the 8021.Q tag or
without it?

The packet will always exit the Linux bridge layer as VLAN-tagged,
because skb->offload_fwd_mark will be set*. It will appear with the VLAN
tag in tcpdump, but it should not appear with the VLAN tag on the wire
or on the other side, if the VLAN on the bridge port is egress-untagged.
If you only see this in tcpdump, it is expected behavior and not a problem.

*in turn, that is because we set tx_fwd_offload to true, and the bridge
layer entrusts DSA that it will send the packet into the right VLAN.
Hence the unconditional presence of the tag, and the reliance upon the
port egress setting to strip it in hardware where needed.

