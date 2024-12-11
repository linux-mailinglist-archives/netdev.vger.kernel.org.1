Return-Path: <netdev+bounces-151209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7C59ED838
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44E51884A88
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9FC1C4A36;
	Wed, 11 Dec 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a1YGa4yv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E71259498
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951584; cv=fail; b=qAPXEeDVEgExPRuQFMvDSyviJxz9QufFuN/LyzMuhN+uqZPu2faCsgxsmmsnRYwRPjmHenwQ3y0eogtpv/kMnlCNQcm1v388nxckIx1hLfnzpFvAAgsThQvNgXkUVr3gw6RHU/RD2HzPf9/zqm4k4vn/Qa7UC5bFtFe1rVyf+4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951584; c=relaxed/simple;
	bh=4jgBahOK83vkIyri1WVkx6BoCSJVLuHdOs1zhpF340Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U3J+gHLxFQ/NEvnz6t/hJ7J0qUlRQ1wjGCACoZWnEEXhj+SRpZMsW5l3qByqOIO8YMBGURqNoPLtCy7JzrUTp/LrZIiG2RvpF/pjZdnHc3Gyw5mc4EmyZ95pu2K9x3ufvdcUooLoE7neAA3i80jtiq5zPhhY+wziCp1Wfb/ET9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a1YGa4yv; arc=fail smtp.client-ip=40.107.249.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6ubysq+R4z6XmNH5a4Tn61aqbDRfPFfogdAko+hiVzUtSh9g+bCbuRDsPgyW1TMO8Ni8P2q5GKvyfKLG00LfYYafGR/S5bAoMm/o9BB+LiIXTmOpKKq+TvWPAgpvkd4BtM7IFrKNDzRmnmTMCHDrNWi+YS/vBhF8bCktnHM7RCW9bfSVA1qpqHr4XbgcCoPXBggtkJPYoIxbJKee9U15eXhbmqRaMXprxLCXRJIur9GSKjyu64bcZdRMn5OSa9AwMm7cI3bfLYYJzFzfLpqfsBbHQrQBJ/xm+seWw5K1EcthtT2RM5dkWiKWsFLmDsSZevRT7MsBCz2a/A+ZBe1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jgBahOK83vkIyri1WVkx6BoCSJVLuHdOs1zhpF340Q=;
 b=erERsBCUQ39VC2O3oZs7Cv1ASULhe+BJHkLm9BQKZKHhi/COgsTj5pBavRKtljHtxW/yrft4MJ5PvhPE5tL/n7DHrQf3HwzLqlcZIU67lDRVehptgevKBR841hK20j6M8yIdl3nJXl8arKPHy627Lga4UjrrTtqcaXffUf5ARYuPYWJOHYTp+6f9KVbkVNoC63qvxqRPxPb7HVBMDJyj/0iMLwFtA25poF8cUZN+sDS6iJBidxNly4oRNJuxz1aNKGnw6hSLFqDTNX+Uuj+NWVe6FQjK3srTFKMFFV9v9sFOoBgEWx77sr4CxCETH82aFnxna8SyIfoAWaaCgP/COg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jgBahOK83vkIyri1WVkx6BoCSJVLuHdOs1zhpF340Q=;
 b=a1YGa4yvt9PPP3UEgIpV44lTyDwe3qm2GqOPd4HtzVytGcy3z8ITJkGKAfTYiOIZGlyE4AmNwFCuff8hrvkOr6GyqIQ8hZRkVK4/EWPcFiJBkKCn2bSO33IaeiUTtwO2hvOaKjeJaKmk26WvYP4pttRYbkSdnFitQYKtB/mMv0xhmSUHJ+2v/DjOSfpuTdRfN2tBjDC91JMFHzviSxQdScCvfM1SAedCOlN8AlHVurz/6m29uN0Pw6jJRLC0zj4pdQ1Y0zFHk/PNk6hIQc6MiOAKlvG6dkyfnuOSTMbBPFeQBZQSuKIEyU2SncHn10Am9w5g9MEoOJn+bgPaaGaNZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB7866.eurprd04.prod.outlook.com (2603:10a6:10:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 21:12:59 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 21:12:59 +0000
Date: Wed, 11 Dec 2024 23:12:53 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next] net: phylink: improve
 phylink_sfp_config_phy() error message with empty supported
Message-ID: <20241211211253.d6blsm7zszneu437@skbuf>
References: <20241211172537.1245216-1-vladimir.oltean@nxp.com>
 <Z1nT-GlW24hgHkfx@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1nT-GlW24hgHkfx@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c18492-9309-4f2d-2056-08dd1a28956b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5S4SLTz2vML3HMvEEmXel5UKpDiNr3AQnHcsACtJybf+R/tkBNvIrnpCgO4?=
 =?us-ascii?Q?MhYUUzPsk6UCrU/WuVOe8id4OvFfUlZtv2PHz/QD0TnmNKFjwgK9465hoYmc?=
 =?us-ascii?Q?7HSUa0k6xOnLA0IApM7izYqsQi+/Fbg2R3CjOA8OiUFil8jB+N/dTpgKXrGD?=
 =?us-ascii?Q?V0+xUUtoGvhMWfK0UF/X6dpvHLDmx/SZ4dmXBV4oAGGo6AsmSOQFO8Cw1hTW?=
 =?us-ascii?Q?kwa30fK77DAEI49stMf25L/5WuD++U9GFdGjUA98GcGnQQQKG5uTGIoxIWOR?=
 =?us-ascii?Q?UCamm85vqv8pjI/gSl0hrDbmAMXw7LhTmKkR915Mx5vCLKyIFEjUA02FHIWr?=
 =?us-ascii?Q?H5oZOl3ZdX2g0ydfsIYLWurNVR8zTfbajmlYG34Zj392vJtLCc28YcaZPiMC?=
 =?us-ascii?Q?vyqQF4/NPv2QD46H3RVUbbgyXx86WYO+WXefIMbxRpoR5uH8dpV35EjxPln1?=
 =?us-ascii?Q?/3DaoVaYsGOk8zpMuB+cndB1suU1V7ZwluOHkOo06mp5+uZCx5pZefoqjeUV?=
 =?us-ascii?Q?JGYn5PaHJ2ae/bioqMzl97CBDfKDR14nOE+UZzfs41yEioGqsBO0g6IDmjs5?=
 =?us-ascii?Q?zGxkeqwdzvM0xn2IdCL/0mlZn9yDkzi3GOdR4ZWL9Yy9jtlMC0ed2NbvwSr8?=
 =?us-ascii?Q?kWYw0/zsvEvJzVAvhIRSwOAYkwAoqdCG/P5xWCk28YWQjo+MIaquK12uwEwT?=
 =?us-ascii?Q?Fe6RhlgUMAXqKFlK98BfV8yQ7B1sEJYDtFoZj8Cw24uQDr6bGM8kd5vv08Vu?=
 =?us-ascii?Q?AZp3WsJ4aLkE1tuvKxJdD0eECUCJRXl6nCtW9Cy6+N6ARWNLzanR1+aW3kIC?=
 =?us-ascii?Q?d8gp3xXVQECjQKJzDNC+Bg1WAjBuZa3OIE3aWig52++yiFOtEJ5GkPk1YrxS?=
 =?us-ascii?Q?5LoR5hv+d2ZiDq1pe0o1x8wKOPNhmOOn6oXVPXkRALpBQiMLbJsFcDosNe8s?=
 =?us-ascii?Q?3mphy+tBwGkKGlCroAx1QLCmD26aDQxKnsEGZZpjrrlcNNbLsMRamuD3to5E?=
 =?us-ascii?Q?UQGKkOAfhc0o2r6bxuS82dBX2qaX+GFCgxHlG2bhVOtU/+zSKaNoMwjoNg++?=
 =?us-ascii?Q?ej4A3EeyKFgmb4fhp9hxoJ9Zx1zDGK1x6aQEHo7fQ4t/pxujyFwvZKzQjLP5?=
 =?us-ascii?Q?Bp95nBSyKkJ9Q1Jq79JQV8AQcEvHoYI8nie5u1UiYs7g57KNGGtYuVgO6R2G?=
 =?us-ascii?Q?FRGKcw3xpIsbwMkGBTWyjXZwmBaxRo3cKGeg7/VIysqfn40fH9fk38ft8TnZ?=
 =?us-ascii?Q?2RD+0b8lr9JC91hILjumMBv/46pC1jNrM69alDcgXJIKVWunhLFnbXGLFj6H?=
 =?us-ascii?Q?LPzQ1BJkEx9epiRLR9uX07i79tuSFyd0hcRa2zwXmlZUmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0j3G3UFsKe5Oi8MnxxAuaeXcc2tXPtUZVcpxCWqQ8ordWyQ66KBIr9xy7r1D?=
 =?us-ascii?Q?rChDog0a0tRYNmvG0w4dgaJRHwfe5XRKostmpJWaK2ZAmNTZ3oCSUTb3al+y?=
 =?us-ascii?Q?kfDcLCbLE/32HKRUEAPaGrDrd78VNsnuippqqc4Keu7KZAPqEftOhbcBv7th?=
 =?us-ascii?Q?k12UR/CN+ob9GkPPqUqVjHlMXx3v0PGYPwsUodgatcRdJ6FC+k152GD8mKIK?=
 =?us-ascii?Q?5BzyU3ymDVEPrq5VSuuvjNBkpHfrOVYCUdw3yfOiv6kZ7WiYxI061ZGgEdqe?=
 =?us-ascii?Q?4ZfceyExqSgoed722TNCGElRt/UZtIO6fK3Coz9Z4Nwr6hBTPFoUW3Ydr82h?=
 =?us-ascii?Q?gqZfZjdMPQ+aiaJFlWDyQpD6N1zJEmxSPUFWLIuTI9mSXeAdj/TRUrzrRgSw?=
 =?us-ascii?Q?cWM+8qdcmWQUUySU5j/f+Ej2hsGS6Gh5NVVrrVMd0/P5q4VoQMt86KM8EzfT?=
 =?us-ascii?Q?z0Q5Qo4e2yO13JvnYR+CpJ44wQaHg5wY18PSNL83S8VVNmiVBwez4QodeFqi?=
 =?us-ascii?Q?NplS/28yJyxveDLwED6AHExEPV8NfcNhDBW2QHTXAtszNmEE/CG9myAydwAt?=
 =?us-ascii?Q?28QTpu4eYgEjeYuGKu3qqxamS4eIDraUEYOUHU/lKsZXT/mqmiLX1m0ZW6B2?=
 =?us-ascii?Q?VZw17W0Wx115SUT3l2RajsH408OI/236IDLhIG5gjBfQSjjAe5gx4PovbmPC?=
 =?us-ascii?Q?5rqKgI8jH5lJ4NHqGvCRKtfXU6n+VAlM9STUrq7vYaR48TBYm3/dMGgLgUJm?=
 =?us-ascii?Q?RBvp4i7yKEXotJkVV9yBmEjMZHmUak0pfNqp7AaAr7Y3gAsUuZIp9as0pnjy?=
 =?us-ascii?Q?5yhn3UwE9oIQ+f3R9g+0l5J89395e7glz4/lyc4VV3G9M1lgM4qbRsLzg2iI?=
 =?us-ascii?Q?PVYdGVQclqDGtOTTmv98opABjSmqIofHz1RLMNZsZcZRg6i4Nsj3Wu9uKsBf?=
 =?us-ascii?Q?KC8wvdXTwrVQf8ZH69Q0ap2EtquBUDZeLMEK/Bl1LrPY1GvmM6y7gsIbew8+?=
 =?us-ascii?Q?GZZ1ubfuGa/rHsQpJco/XC7hot3qJVm9bGeVbESVefZfaQDUysMJefpKniIP?=
 =?us-ascii?Q?MiJPnvyc5QUPh82GSfjfurJuB3Twp1+yxYHfCLZ6gM1e171FryO3bgn1NBIE?=
 =?us-ascii?Q?NrBqnseB7E3UaqQJA5x4miRQr2mB0xaOK+le8qcNPLoze+Wp8daUd7V7RSUd?=
 =?us-ascii?Q?LdnUkcs5v9VM7jWVJgkQkfHyi9JvRcjR8chyKKRNBRw+BCmhF//mj4eOR28G?=
 =?us-ascii?Q?BI34dcuE2cDvLTcYq3DgIfl96yyR4vRHwmobiP8gLjxIzVSt2AoBRuzseWYh?=
 =?us-ascii?Q?s5Btcwy77eaS7pKdueYSG6mHf00HlF4/0rZloYZEKK0EQKcDBRDsuvUCfogA?=
 =?us-ascii?Q?bveRn0DoiNu45ekhgS1FcxKYUG0dcrnFxB+7S/GYtMl6ANW2HIU1TQ7ap+tr?=
 =?us-ascii?Q?WOoO9WzKDIBqMzEJnyi7sAEjnrwARv6gHqwcZttwuf9v8uuaN8UTfpZrvy6q?=
 =?us-ascii?Q?LvxctEi1Fbv6NGXoWRAlDHLErc7oLGBxWpJLcAeR3KBN9NmXeDOOKrz62En2?=
 =?us-ascii?Q?T0KVaZFdMO2Kt+jy6RPptAwrFd/EIMyIAwoRdCq/kukmshZ7XG/zSZcuTp2k?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c18492-9309-4f2d-2056-08dd1a28956b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 21:12:59.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjyA9sJkmPHQx3NY1Yp1mresVq2uMMw8mxRpjSw+TaX06OjK/W6XSqspkRUwm320+n4E8/XVOakym/5omSnZGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7866

On Wed, Dec 11, 2024 at 06:03:36PM +0000, Russell King (Oracle) wrote:
> Wouldn't checking phy->drv == NULL be a better to detect that there is
> no PHY driver bound (and thus indicating that the specific driver is
> not loaded?)

Yes, I can do this, and also move the check as the first thing in
phylink_sfp_connect_phy().

pw-bot: cr

