Return-Path: <netdev+bounces-228223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA7BC515B
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 15:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186813A92CB
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B971AE877;
	Wed,  8 Oct 2025 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JfCJl3HA"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79542A80;
	Wed,  8 Oct 2025 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928431; cv=fail; b=BQnlLa6BXswhtuRCKK4YXsZavi9uvcvp7WHiZr8X33VMniInYARGZhDE5nkXCsaMUOJ1arTFU+/cASM3JxiBcXe1xAw08yxc/5+gCnDinTL/jADX0p5XguMS1N0POwwguL5upynKvc+sAO35QTPB/MtAgomUk/CD5Hw2OWWpi4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928431; c=relaxed/simple;
	bh=P1gve15LxPqNg7+tWccyOi/BOAjbdnYqFpQ5nIdjm48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HMnDhTXUV8qsTZntyBt9Rdka4C49WPFxpkAqmJwsvUKQbsE7PttFZh6KqtiIyfoS6RQtTNTvODRu0ulI7Fvc9nFUCDmENQ85gg7nBdgWkqF6q9/oax3Av1mdLE58MeTcXJui73uBX0wbE7yWtCEZQdkQ+SEpjiKQOhmqF8/pZFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JfCJl3HA; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jng9zKrmecuSjD/XBreU3F31fhrMqYucavp/BtU6KQcmjl1w4a3zEBFMWZohcqIDIO6jmPQsT6scV9A+7Aux0TUKWguLROLvHVAZTQKgXWUQP9OCRSH0iUY9oZxS9NzsQgbcMHd/EG15CeQCNWwZhR7L6bBjzeTyDkvEhnbQlaFoI0ktaXsxN3nds4UHXE30uqlCYwlGI/yhbklaIZ7YNE7jU4z8jnOCOjMNUchpOp5V956djapwm+NP7MyTsJQkcrqz8ix+NZsf9RsRTRJmEmJ+nHuvj3YvbL2hKyn7wehfaj0z6enqELtkku7nSfyyKrxjp7n4G+X2c7aUCb6i3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tNYURfaEixbT+iZLLRa/ywLfqYg0C5qJssNCpTwwrg=;
 b=PNX/nezw7bjKwn08vjXQl7veLAcdOeKvowdSiChgUoNxMt3g0L39bXwXx1aogX/f5hFMwJMGK/5/OaoSX10hEqFhW80YerTtjWlciaCvJv+afEYHs/8/ADbN7qUwZGMTWCA1WP1d8CyzYAkdFQ4C/J4/lnKke0fO2m2tjaphFiTEkQj5Jtu9yPORLE0KEj/T0rzu4p6fNu85g79zeuM+caKp/atyn+u/Gr3Un/LxPj07hh437H53XKVX7QcTE0al6zBTfNl0vfU1GY0d0M1Wzm0FTkiMOF74VES+69R/CdwgziWcgYZRxJiKUSS7mvFcx3l+3jFy7wxkqyGx7jfnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tNYURfaEixbT+iZLLRa/ywLfqYg0C5qJssNCpTwwrg=;
 b=JfCJl3HAhmZu9Aj0v0TSFOXvUoDPnNkv7eXtGvEJBGtq7dJxBEKLMyfzoppPEX6kHMEqzh5I2N5KMA483Y7X4c9miMJmU1rRTF9mEi6MwnDOXaxia+sWVUOZofC1h3Mlev80n7OGIT7vwW9YZWtajwuzns2c4hJmPDBk+L0oIqYiG9BBBtx8kRibigDNtad128XEQmNEwqGU2qCPyJk9Q6veHbyG4hSViY6hlrNvDkMZ4xBnP3+kAbgy1uW9NkuYRY8MoVY16rXxdsV9dsg7y9I6VsqM55u6jN5bvZ/t+GzQqk32mSX9223HINezIh5EU+vS21ihoOzSMpaDnqBkfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7407.eurprd04.prod.outlook.com (2603:10a6:800:1ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 13:00:22 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 13:00:21 +0000
Date: Wed, 8 Oct 2025 16:00:19 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20251008130019.xe5w5x7pvipb23ks@skbuf>
References: <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
 <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
 <20250828092859.vvejz6xrarisbl2w@skbuf>
 <aN4TqGD-YBx01vlj@FUE-ALEWI-WINX>
 <20251007140819.7s5zfy4zv7w3ffy5@skbuf>
 <aOYXEFf1fVK93QeS@FUE-ALEWI-WINX>
 <20251008111059.wxf3jgialy36qc6m@skbuf>
 <aOZemYL1iofWyBji@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOZemYL1iofWyBji@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR09CA0118.eurprd09.prod.outlook.com
 (2603:10a6:803:78::41) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf51a83-423b-44ef-9e8c-08de066aa3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3dqOLG2ALQBSmfKW1DyeOBJ+wYoFACcWZrXdectwY+oU3kONpOcHSbo7y1qb?=
 =?us-ascii?Q?ZDV/cLY14zYPTyIDhttRIjWqghQIxfhveExRoUADB3MUwdKL5Lrp4EMbvCS7?=
 =?us-ascii?Q?fGM+iQJDj8rFqzpOVOEez9dcnodlFkjPAzWekponVmvFwyBwkkAiSJSoucBy?=
 =?us-ascii?Q?lPg9X0geXrEi4fiI1IutmK8rqR9aSsrw6fFnJt82BkbVArrCDVcDFtV+ePWv?=
 =?us-ascii?Q?5TlXVjZlHZV7Od1irRq/+nRipkjHiUOtW95cpIFc5cP+34xSkNbtvKnvvZIh?=
 =?us-ascii?Q?TnoLlMH156RUdRJ8UvyNEwvgV+VIrh/DZhojXA9DC+UvptpOF7f8WIYjqUjZ?=
 =?us-ascii?Q?WOzsVBsXVYGlNaLRFlI+0ZsTMNqO1xn3HAS8iVJGJwEE9itLUts31A9FzVA2?=
 =?us-ascii?Q?lBCvHwBYzcbWzcayQJ4hkcZAbJnra4aqJjxW+nTxup5egzVjzw61gDI95gfN?=
 =?us-ascii?Q?9XNQjwfuTQOOG4aYsb2TGYsjoqvJugnOm+0MtD5GodVD70VJCaEAqcYVzG6G?=
 =?us-ascii?Q?amerZqEfjVDgAG4u3tPJazurKmiW6pjSiYofBtTJRO2fne9PATlmUhRNkj21?=
 =?us-ascii?Q?yjyZje4SU8AyTLVY4h/KQdXZ1209Vjsa/q/5a42P7vFMMnh1NkjWoWYhbQ5T?=
 =?us-ascii?Q?6KNt1GdndbCCksE5x9nqNOx6VedallwjT87mgBq1CTkoBRHrZguSer2CoymQ?=
 =?us-ascii?Q?7cFrpTx4JvwwHqOx7vMNFdYzE2g0VSNtLZbiMKx0Z8JLcA65+hf82RfKRhYg?=
 =?us-ascii?Q?I+x7KxRneVGz9WhxyRIWQjPBltZFptpmF4ZfjwqMP6qHfl0FmYFaENYJ6eii?=
 =?us-ascii?Q?LMxsvtLRmyMxHjWeP89bzDDNz4qX6tjxvb/7JeYl35/4Y744PRmbO7/IxbBQ?=
 =?us-ascii?Q?n4qMTg0Ee/YwoQNAljNWwW9RdvXZ21BdUINmSczad+7V+ShvvDi/srEVj+5i?=
 =?us-ascii?Q?1E3DpHzj6emtq/qv3hmvYFP5q+5nvOVSs2IoHSPrK4HNsZX1rvVk8HyvzL/5?=
 =?us-ascii?Q?rJFWl7m4X0SwQbR5T5CcXNNcgjq5sW4UT7G2MOT73Koc295Vk99nscki3n5s?=
 =?us-ascii?Q?+LLguTaTF0+JaPERRBgNvoslAX5XZ62Ms+qI++qZZIqEx3c3uCjFuyRw9ICV?=
 =?us-ascii?Q?nbtdrxfQHb0EyUom4tFs7unbZhPk0xBx92rXqJl6GShtmFPZhsFkTMgUP4a8?=
 =?us-ascii?Q?Z552yewmdjYUFLlHhWK3pXBz0/TrPnhswe47nMJlEShwfgksNlLnIUdtnDbj?=
 =?us-ascii?Q?RgNvDCi6nFNudEYJDIzpvDXANWP+9BIWMJkUHGu+ye8FcnAfd3+Yg0zVKASZ?=
 =?us-ascii?Q?VptagsgTbZ4HSxwHqsm9cp+pY8U4uPKv0JKDK3MJKZiLZsLca+Si69tjUy44?=
 =?us-ascii?Q?LJqUEyC91h7s64sz5IzUD0N93Nem7osIpuJEpZ8zkwD5ZaYbj777KAgqs6p3?=
 =?us-ascii?Q?QvDvsCLDI8I8kqWGD6/C9zYV6FQAmi6i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fC+52EtvKqdjvRtD3OdbISlbadOxuE8X1oVSvbAXS0q76P1/xiXbBQDtkQSr?=
 =?us-ascii?Q?cM7Xa5MfJcT4Lh3Ur/Raz3tW3sXTOcZ0EujD+CD6CaSg7iDPGQ4ZkwApcvCu?=
 =?us-ascii?Q?nfsJVR1Z56difx7JSPruVLyBvRd7c+/AujKNITn54tCEz5ttYftLD+2ZNkTn?=
 =?us-ascii?Q?PlximqyOPfhjvfcUz60ZxpbPa5J7/tQXqBJ5vn4mwqTpWG5Yv20Lr0wAa1Nf?=
 =?us-ascii?Q?2XUSBzlKco6rngUmhhAijhZ/gJ6i1CujzK8W/kMQFQ4TQNhGeHPEKpbyOHEn?=
 =?us-ascii?Q?c4sib5UpuyyYIlJXiDzz/l6TorZ67Jn5Sw+CkeCpfoZjsXWIMzG0Q2mkqkty?=
 =?us-ascii?Q?kLsM9irR+rkNnDOXH5YX3s75mXxo97iSxenWcCS21DCBv/9kgRG7lnxlgA3O?=
 =?us-ascii?Q?QYxdvwRre5MCK7g5Qu1FtjV7zJFRXJfF59FDF7r2tluv5eWZ4DEMqbLFAIi1?=
 =?us-ascii?Q?43Fim2hv+QBt9o6nLNUTcxYN4R/+l7NJ6e2uD2oiRmLmQOQ81ArqILZPzTTN?=
 =?us-ascii?Q?g2NdhbC24uRHUHRG1jezefVYih5jzGQbFU4636+wF3DcW8tk4LDGY8jcS+sa?=
 =?us-ascii?Q?IYQSD28l+1LuXDoCVFvtAQZC7y/D1fexUK0Y7khbGSaO3Fw849FKT8EJ1UTX?=
 =?us-ascii?Q?Bdg/kTlpvEjvkOYoJtPUIzsregQH5ZGUv8xZwlFj+Hz4Gle38Boqk/S4R4qm?=
 =?us-ascii?Q?ixJGTSbZfD50jnEzcMMniYE/b4Gg7QfWwgxyYLZyHKrx1H8GFyIqGR/BNeM8?=
 =?us-ascii?Q?9hIgIvmGrg/ykE2v5bQhT8r/Tmc9jJcAhxe4gFhQfLBZbEiv3t5VwjLUFi1m?=
 =?us-ascii?Q?yIhOmjV+duCkQqaCo+gzkM4n3GTdz3dfDp2+Xb6LDe5CN4iedQzD2GsVE634?=
 =?us-ascii?Q?vBkGKq6fMz+xEavgHuwnpQZIR2mJnnPRMG1PLcLF6T7gAe1J+NmNPIKBiX4z?=
 =?us-ascii?Q?qtkBSyqRmdftxPYilC332Ixc0sErF1D6QSW+tCaB/q4BDHIz3Suk0FGQJj0c?=
 =?us-ascii?Q?oWBm2iicFFsh7Hj9GbzbbW/0b9Jqqz8BiE3FKypEOKiko5rDolWDUH4PkvkB?=
 =?us-ascii?Q?E5OledNgpHzI8oO9xlKuIqg9ngwtlS3tAkivrihpA2kAHRZAEOi7u8fWtsj5?=
 =?us-ascii?Q?pVYLgCMDczKVpxC7rz0BFOrmAOihqS8CiuyaSYTqOC06BfPdEOagUFAwSkQo?=
 =?us-ascii?Q?rt/YBVIXl7X9Cwie6KS15QZwlkQ2zrW4lzAQZ970xkKr8meUsKuhva87LYjS?=
 =?us-ascii?Q?3qJIEBw/EnZ9s4X9QlzvAdEqM1A62gOUVBMzcX6qu8xKMl05GySqTPIXrY0v?=
 =?us-ascii?Q?zcotaHuxbJUwEPQqYT7DpAA3sxyWjgqqPOuT6UUYpVNgU9WS9EWCuzTl6dbf?=
 =?us-ascii?Q?nQBb37qtbgwESmFs67B+MBsImepl++TsmYorPyT75NXALL/KF6D+itl5JMfH?=
 =?us-ascii?Q?CTq6KEThEvAvcULJI7c83sVMMTV86G8C1XNMtbycMAmT+Xnzry3rL+zncDE9?=
 =?us-ascii?Q?v/HUDpgg6m6UGJKq24bfKug4t4LeXezADbOKyFU2krFHL1VV782A8zBUPl42?=
 =?us-ascii?Q?rOsbVDGNYPe6oWzDGK1Aw2cie33fD9JHOJUlA+isfo8hWzPvoh4cuSMiL7go?=
 =?us-ascii?Q?tYh8YDOm1sQLHh3J87YRcg/3Yr6KaJeHQegR+t/cBuTz3ndxobw9wwPMTWg3?=
 =?us-ascii?Q?Ak5OOA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf51a83-423b-44ef-9e8c-08de066aa3b3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 13:00:21.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TP4DD/eKbRftgFR6KcKIdvY4354dteVBJToJwO+zBO4BvhPsfWsTMt0p9YULg6ZBZnYKeN14Ws6FJ9P9ZNegsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7407

On Wed, Oct 08, 2025 at 01:52:41PM +0100, Russell King (Oracle) wrote:
> On Wed, Oct 08, 2025 at 02:10:59PM +0300, Vladimir Oltean wrote:
> > 1. Configure IF_MODE=3 (SGMII autoneg format) for 2500base-x:
> 
> Just to be clear, we're not going to accept SGMII autoneg format for
> 2500base-X.

The "good" change is in the attachments of my previous email. The inline
diff on which you've commented is solely for further debugging of the
original issue, and is supposed to be applied on top of the "good"
change, and undo it (and in the process, get lynx_pcs_get_state() to be
called).

I know we're not going to accept SGMII autoneg format for 2500base-x, I
also said so in a few places in the email and in the "good" patch's
commit message.

