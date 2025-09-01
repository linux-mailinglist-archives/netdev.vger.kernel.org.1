Return-Path: <netdev+bounces-218663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086FB3DCCF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112AB3A8BE7
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03AB2FB61B;
	Mon,  1 Sep 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dCEXUQg5"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88751DF252
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716153; cv=fail; b=eOXX40lPu1QWUUj8SdQK982w6OcEhc3JxrACvkAy/VdwwEIogeFnIJtx0QhwJ9wdGczAw3FgUFYvdAjjpB7j9vuZlkxrP4vZ0hEpiZDxdH3r7ZBNPqW1mbLlznabFwAfSoigpotnirvKt9xhQkuacp1w45NkWCPIHhLseDCQeis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716153; c=relaxed/simple;
	bh=kNzftlqPgzja+9u8nm1EG1dJNG5VUD9lqG6ZSAaQnPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qozd1h/x/azjbGo0Ph5tMtO8ufRYwy1ZacOBUjkZdXPNwCHMOZCDNnKTfW6cAYE94UguHxTy/shnj8VaohPADiQs9cCG/ZTGV5Q8m9FfMD4ZmSMAGeVZ0HvJWJAYI0X5T3CBCAEZamYodaLW/Nm1rkN38Jn4DhcFiV19pLL0RHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dCEXUQg5; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+VzQxh364hAld9ga5x2t8/HfbZmw2XlVNmwgVnI3J+6rZimZ9DBIV335R3/DBSZFmm//LX00xgAD5K8dteLBjxd5penNq4pXr0UCyPLrTN08S6WH8F87tp+/TSoBLnNdUr5gOC8c85KGhSC22fcLDnZ2GR4UI8M7JVrfUas1imrTu+VBWibcmguJPsweGzFl2ECSgiZ45v1lHB07Tz5uC3Gq6YLV/k25h6Q0ZnLK7vRyBzeHiPUGTE3MUQtswaIYL0lUAfM28fJ2HY7vlGv6njlBiKCQmi38wYm0NZivxA8NGddvacS5SklMOTkmfZhq9L4yEMM1eTTo7LwaXyL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNzftlqPgzja+9u8nm1EG1dJNG5VUD9lqG6ZSAaQnPo=;
 b=KDgBcLIrpmNgfTsW6PB4hoMcXnKPbNuI7EaDLKJQDhyJr0suk9mjhWqbbZZDxAo6jpMV80DeAUlDuQ7kqQd9ztvN0pQ0IzieeXvROILb1wq9F+xZ/GXQJNWym0ApTYA/pSUByu63jJW6PWA7lYfcappFRtZhEIOBj3jOtYB+fgaALvgwAG4Y/oYcv7dqvnMWPlgHN/H3pjO622bOyF05pwc7bwCOd62wg2guUWmr5zBit/0TsLZXED2e6qBAJI3XKILDbqbyHTpeqhW+XS8K94ltLWjOc/j8YjQKD8+/MfgxvKTM0SQ8oDlAkI7K+Q8kH5MJDpb9kjq9h/uHkiFE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNzftlqPgzja+9u8nm1EG1dJNG5VUD9lqG6ZSAaQnPo=;
 b=dCEXUQg5pwaomw/npKNENrv1U/tFrWZwyIGarb0VxnpdUlQFTkG8GjSzkS9llbJL4+cGX0poJGJEpEe1KxaemZRiPfAz3lDH2QVl6zyLuX6bGLi5zXh13bXrxymV2xC8ITSa6kwUHYwV9+zBNLDXk960QOU0y/2TSTpgnC8tXYSywtAwCoPj83WR1hidE2+2Qli9YrgjJxSZ+6MQvR3uNTpA6B5NG5c8YM7H3xeV8ryujKXAarLzNyvUn558fbVvv3ua6qbDNl2zYgDO+q7mNP5JYWyFBJpWRvk6mPm2hfvZK3Kov7PhCpBHzJEkjkzB5Nnx68n0yyMgR7QwJ0DgaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB6935.eurprd04.prod.outlook.com (2603:10a6:20b:10e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Mon, 1 Sep
 2025 08:42:28 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 08:42:28 +0000
Date: Mon, 1 Sep 2025 11:42:25 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <20250901084225.pmkcmn3xa7fngxvp@skbuf>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
X-ClientProxiedBy: VI1PR0202CA0034.eurprd02.prod.outlook.com
 (2603:10a6:803:14::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: b923a666-2e55-4178-9dbd-08dde9337b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oz/rSSN03ALCJT9yZSQ/C9t41E+/PTjs4gurumYyiIvtgAt3ZXtb7MV9zFHi?=
 =?us-ascii?Q?PDGtzfJG2KiC+eug8fDcoGpXZVUXmCNgRHUDpkonb7GZUg1a9Htp0o3iE+Ka?=
 =?us-ascii?Q?j4A9lk7T3/FQLD9PEP5a1j05qRfiLNy3Gr/iKr+QGSWhtHoWvx0fBHIlYs/q?=
 =?us-ascii?Q?jJ5VZboaPA6ot82phq6hEKuB0F4Bv6wDDAWmkW/2izyLazUMFn5YbWFTtNt+?=
 =?us-ascii?Q?XILUwXdtzpdUYcfpGOcZ7TEsWnETm5Mk0NNwBJO+dmTbP4qxDUCk5t0+Bgdc?=
 =?us-ascii?Q?4/jxS7Li3sG3a2M3LbmJGFCypNkeZgr4UaJmTi4qyvIRZY4pMjpdPlcyRm+0?=
 =?us-ascii?Q?8vdwzXl7an7aI48LI+V6HCBWa6ZEPf/TCXgnHvro2qKoWY1ceuWdwf0RgPYY?=
 =?us-ascii?Q?PIL4O/VPnUzUJWE4UfV6pfyUCfwrqBbV12ouQTen1rhz+6d8ArRE6x+mlPVS?=
 =?us-ascii?Q?re0zV3QSO6v89OSmyu+eMH9xmTcrd6xWxVOhx8m1aYelGhkucxJYVFgULPf+?=
 =?us-ascii?Q?9ioJPoXRZR9CPXmmDGxN2dmOooXg6GwQi+MKQw8RkK8QYLGo8H94oje3kCNs?=
 =?us-ascii?Q?KgloBibYp1UDKiXwLa7KXG9zWpsUxl3t1+XeriWd8gminr/G73luycilSykf?=
 =?us-ascii?Q?DAIGxqRKc7aTbsxzuJlHlUxesCCpEy/h3EUqdYX0tJmsLvW9uldSa+wczOQy?=
 =?us-ascii?Q?WkWc9xINZ6Auj14ybzfuUIx09W2Brg5L1yRnUtK2dvLZb36Y+VSCcqLl8oJj?=
 =?us-ascii?Q?adNIeP83Hd47eTOHqRxyKjXYai/K8negF5wpm7PuYvyY8Md4nQhBu7qa8WbZ?=
 =?us-ascii?Q?jSYeVs4pIOTLvGrDtMAbZ0L6wN8y4ZJPM11+Qd/DCbk30uXWG0QCIcGEhEYi?=
 =?us-ascii?Q?YxoSHiCZOc9dYQeaDpP75GT0HrAPJQVzYryCxiJk6PPnQtznV+c9Du3NkwW6?=
 =?us-ascii?Q?VFAVB1TFA9HUaC9c90qA2OvKHc0KfIzLjZtu4UgkzlCrS7UjdS7Dol81i/E4?=
 =?us-ascii?Q?XWN3Tc3Gprv6lATcJpnZR1jpYmQbqWwUeK/HnEmahqPN9QQ6dLO+YBRvrJ36?=
 =?us-ascii?Q?KSJeaHpqAlqFEkdsuDmbpsONV9m40lgwP1EV8ytHc4VFFR7etXaCnmcarifU?=
 =?us-ascii?Q?KeK6/eoN6d/uGfX5UWwcARIpelfnKcxYdQWKj2tvbykZd2zwWSuDcLElhlqB?=
 =?us-ascii?Q?4uD9Vi0vS4/8P6xszubwCdwmLCOwBqqfe/Ac675LX3kLongpltI6Fa4+tlv2?=
 =?us-ascii?Q?4uRCEUCqAtFFAiufZze1LpQ/XlzbkxfjcojtaP7G6kDFtqv17AEn/53efN46?=
 =?us-ascii?Q?RoGJKO2MLIuoLWrjF2I0VgZrRuf7CaGcXWV6q+cHGdDnPi5h2C9Zjue00bNZ?=
 =?us-ascii?Q?jHlXFVJpaxhGPNWSDz1enaUIpDvdhWgnFIx9XwvOxmqiXW3CNebqF6gIR/4T?=
 =?us-ascii?Q?klChZHtyvkg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4CtDTyFbo511R1tyiaPafcAdm7c+xzQ7dUDT1AKHE/qXLZwU/PVz4lohB5Y4?=
 =?us-ascii?Q?W27eEIS0ZiJwSj5Ey8xDJBNwWjgFDEJUCOut2399jqwzwbmRsbjRN7gvkNmu?=
 =?us-ascii?Q?G5BCpdsSoccof6CgJvDeFNsZ0YMR7zP3ZGprzINFZ5lzUc1O1iJd4n5Qmznq?=
 =?us-ascii?Q?KSNerUTeJGoR+Ooc7yZzWuDkmFFaASzWyeU1dFxvGxjN85WrfkztEy3YNljY?=
 =?us-ascii?Q?5jxySf/L6iILEF6xOPrcW+eV/XM4+RduKZsEFX6Bi4X03CwbQHj7G9hCOQ7y?=
 =?us-ascii?Q?7ZxXkn0+yUfeayClcCSbFpMqpqq4IWG7WVAkeX3kn1mA32O5RCgJQoPDi/xc?=
 =?us-ascii?Q?kGCLBrrEIbAcshDOz6a4YgDuhi1XEnCZPm6OkoM7phCqjhGRzDc0mj8007Wz?=
 =?us-ascii?Q?cz3inD2At1elyucoU/DyXt0DURLvw4uKK/TqfQWK1exVGr5VC4HQ9NTE94wt?=
 =?us-ascii?Q?wIu0FK1NkIfbseq41ijWww8+t3gTS9O1Lza8V5ThzTXN/VzMwnVSiPMFJ0v3?=
 =?us-ascii?Q?3smz9HYPZHTYbVJCG33gmeNGznS1w5hQ8m36T0WFaF5gdPVJzSrMJXPC7FSy?=
 =?us-ascii?Q?N7W5/rBpPYMhpIc99IsznArkvGqWIkgzc1sAO5ZNvIFULaEj9A+TA3bFO9vw?=
 =?us-ascii?Q?XnbEM6ytaBKcC8qhdC8eMGz2BpQiKhaMN+gA7c8sh8zPiu9nqm4p9a1sqKu9?=
 =?us-ascii?Q?raNgaXmVl4VPj9Q7byq/bAkXa8HaULlFD2CAlMY2Ikj44AAFvoWZorcAN0hc?=
 =?us-ascii?Q?feg7YViCaHsTO4rV38YWhf1FInQFJJyReRjCnSHz0Q5jrn5bcM9Zl8SbeA7W?=
 =?us-ascii?Q?GkU45s7Ly/8PlHDa1G7eHCs+9+CdXB6twDFe1aiL9tGJnAIovNU0d9wAarhm?=
 =?us-ascii?Q?Dw1YyOuym0abXvPhk23cCvzb9Y1qqb8/n0HvUhjk6uxyI2Z90U39RZ4aeP58?=
 =?us-ascii?Q?DWZdHgIxlP4bFEXby6cDtOE1xrY8e7/9DT2bc70j2MNeIN6fEFEnZY3XL9u6?=
 =?us-ascii?Q?rrkCtjIy/D8m4QAsnLBhe0PL6ge6OW/vHbvVv7Z9Z4pGdGQHbkjqwnsJGO8C?=
 =?us-ascii?Q?L/skwzhNQsRQKxqUAJX/A86HOQ3rG1wMOFCibtvnFv4irPYgJ349WlQaemBx?=
 =?us-ascii?Q?32QXsJk6Be724wMI4n6rjmVoGKWw+xFM7EFMRAY0OIKClZ5T+Lxib8rAe+BB?=
 =?us-ascii?Q?IggAQu9yWaiZ21Y1LYCTIJyu5tn9sXtm5kBgDyZ9kvFQKvRnV8/lf3BGfB1t?=
 =?us-ascii?Q?3BbHff0G7kt0Gtk3tOD1zCPbqMva8X4QuNfI3U0jwCYTSj09wh8Wo7h3FCyc?=
 =?us-ascii?Q?ptdQ+EhtFuX62HQIdAcvWOM+T5JOQkdj6e7OMu9cIl+jx7BL9chzSGk9DTmo?=
 =?us-ascii?Q?ihXc90rKSaKSQ+t/i8+QbwLQ1ZG6ZgVawGZP1NUcow7/d7hER1hTZPQGNv55?=
 =?us-ascii?Q?qJyEfR+UuKubCMwDuC0mzJulGwOfAMfA3KxXzQToHARTlZjQf/9zGen40gXd?=
 =?us-ascii?Q?v4NLtTj10ZPiUaVUqs/BAZTme4cQDViTjULeBwDGO7W/lcM/NI7SKlsXMzuN?=
 =?us-ascii?Q?bdb5o3xhGGFA2gm+nyg+vqzVJP4n0LA/wJXpzB3AfuqX6LGaZKgWlK15dowT?=
 =?us-ascii?Q?uvCK0k2OldST96czYPfjEQugE9zp8M7vm6GfF1dS/rDgKtDDm6JoPWeyF+9r?=
 =?us-ascii?Q?DraWfQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b923a666-2e55-4178-9dbd-08dde9337b55
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:42:28.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +W1GjFuN+LYhXD3VEucg0ymZZWNsKfyjgmVODGgE6LR3SBFOp/8DPWbobwtEzZaPOl9IqRq4OXF4X7r5ayaRAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6935

On Sun, Aug 31, 2025 at 05:38:11PM +0100, Russell King (Oracle) wrote:
> phydev->phy_link_change is initialised by phy_attach_direct(), and
> overridden by phylink. This means that a never-connected PHY will
> have phydev->phy_link_change set to NULL, which causes
> phy_uses_state_machine() to return true. This is incorrect.

Another nitpick regarding phrasing here: the never-connected PHY doesn't
_cause_ phy_uses_state_machine() to return true. It returns true _in
spite_ of the PHY never being connected: the non-NULL quality of
phydev->phy_link_change is not something that phy_uses_state_machine()
tests for.

