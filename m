Return-Path: <netdev+bounces-99466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 735AB8D4FE2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C06B2372A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1DCD51D;
	Thu, 30 May 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OK9kKfdz"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904B1CF94
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086833; cv=fail; b=Ffr7Kcdbfq+/q+blfDjAiZAr0ble2+g5dVJupK01Ub6UEGjlGuAbOE2sSwwMk/hj5vi4BnWBuEC8972Jcunglb0CWlWHp+WRNk8wDs72tt5kFTFrKc8y31w3OybAoXFLy7pVCmetZtPMfib5U3NdZHGa6F5M6kVrNxWreindc4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086833; c=relaxed/simple;
	bh=o9kiuglD4JXg2EAkeedKMxlSfh/+4vWQm4rSPNytJW0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JVKf3Xv82cMmValVAEBUUHgZ/CpiDJ/pcCKyfhRgFIh25xtrMtfqEqwnV/6UrVF6L+nzYZQ8yF5cRzOi9h5TuDzVW4+BfWspPKBVpiR7IuWXXBcfLVh6C3+w2Mqa7H6CD1vioBwNgfy7gSg7bdyFqb8zaZDavgFxLWJ6LF+JIwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OK9kKfdz; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9nM5FP7Ol4sI0IObf5byyrg32WYOOZc1F322OnGvltv7KZeGVMkV3KLk3tGglX/6DRRBx+qhSodANgNXBDX12f5bYoN8kUtBeCg4Tl9KPm0W2ARXODcbK8TFjZFPLKxV7Ah21CYR2qLs03PYRBxcfjflvqJV16vLZBbFXtvhFB6mU984lyXuusXhuIWd5FvfUyytMdG5CqzPm/TA6T+l1wnYTVA1TB6YJ33zN6KPjHbDSy6XZfEZQiK7dnHM19aIM4mdmWrKaZm8ctJfig/JuIGOtfi4Ef/vmp0Ag9lj87THYgOQh9xetezhy3zcoFBNG8XQUK/fuMHqWPqPvpsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcR8Od9KU6n0TL2vRdv02YeUmK50BG8IT5HM7ia4iyI=;
 b=N3f5oDfwW/tNqFyVVHmBWa1gGyIsLlaXctd7bepPT5ckvH2iuV7XIVEmi4d1Kx76S5FIbXz0CB9BKaGqKw+SwGQwBZNXTNpgaYQhV79Yfr7Ad4+A/GOSYvSrjCEQuaPqaHeS30WuQtRcyFJsBu3iVnODR3jlO+kRasMxFlFIzRqPRVJfIwXKgICm+15fnrjjCBmaNskiDe3XgWs56hUfzcDc0bGtZWf1iJ6h+3zPckKXJS6sYGEhOZFJd2zGYCA1k4hQvozaZWyT7lshSIR7lL6QlgcBT6MuTZfxw82vz0MW+VcUjgpihrjDd6SrQnmC5CMIOJkP2+625LU7jFcedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcR8Od9KU6n0TL2vRdv02YeUmK50BG8IT5HM7ia4iyI=;
 b=OK9kKfdznLzQ6VTVRcgltyH4AyL+ajcpTKnPqZRGBhebw1o0lb3341KYLa12hPmNW3ZwSEljcWFLSySFAFEjbh5Omf5i3j2FojLGGCTSMfhwrHatEKjZNG/lRNmebtsOhKhxyy3GBXLwTQv26FhgIfKW2D2g5afG1sFUH9bQjb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 30 May 2024 16:33:49 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 16:33:49 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next 0/8] Probing cleanup for the Felix DSA driver
Date: Thu, 30 May 2024 19:33:25 +0300
Message-Id: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::20) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da8d551-af53-4e95-6733-08dc80c64877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tHtwo1Ut0bzoVPu31dWxH3DsLfSG4qNM54utXxmmvXGJ7jIBocrrZRAooV+Y?=
 =?us-ascii?Q?FAzLn7H/KNqFesrgscehcXqwoJzRIWmyOzG9jJ5iWGOWuCoO2bj0yy+snBl5?=
 =?us-ascii?Q?TKgBA/9nruqRPF3VuxaZ5LUf8Ve6lvorYRBgqeHnHKIGHzDL1HSsZQ5wDzFX?=
 =?us-ascii?Q?XFqQNUTvZ5IjUSedMjpZuCuxs+xH6WADU8po1y9RpBGo5PnLOwsRIwPdxxWw?=
 =?us-ascii?Q?aXT6GfpBhEFJElQSCsBWR0nATZqgA86jl6XADh7UXJKylTehrLoTMMSWimE6?=
 =?us-ascii?Q?nZcW7zs4en3lSRxsXNyJ0/jW677tWDwnE0tGycXlcHc7Unp6Dfm6DyMxT6pw?=
 =?us-ascii?Q?KCP3Xghsn2MwxQE7wNlj3bwv8hwDWzh1LFLCSPqAGVUvF9/EDzL3EKrPNPni?=
 =?us-ascii?Q?wGvOWH4+zA0+t60vCSCAegsDMrGtUmnbXNuHjetcepFl/32mnUfjunSZ8v84?=
 =?us-ascii?Q?BHE6APDySleHXwNfwnjDQjLWxpV1mdcyJqoxCFzT/iurMylfUntBAORT7MIz?=
 =?us-ascii?Q?/v/XNbNwmB45GkjnsO2qD/coVBJQe4qRD6zPd9rg0sbHvBQFlVm5PxdiJ2SD?=
 =?us-ascii?Q?ltb7vJyL8/kzULgMEqt7Yy1BILChv3ksEsVlGWpHuMdH4V3fLRnV5V+IxAU7?=
 =?us-ascii?Q?IA/MzZ9SGLMafCfMt1GnmZch1YTSLGag2frjQkACE79SfwignYQS0zrCR39a?=
 =?us-ascii?Q?po88rKYkDeQntQy0b/VVtxRBVDA3mYG0uzer6QyYwSFQTWkiJtpwf5CE9yo7?=
 =?us-ascii?Q?ZuEMic9ZBbRRhUJ+Q4+YbcROY62144HKDh0RJifJPL9znHPPWuZY37PEXDNq?=
 =?us-ascii?Q?PsYKuHVYEWYO/twFj/h7Cb5fIM5srmUzB1GwySM6fP6PQ7eapTAO9rX2d4qX?=
 =?us-ascii?Q?coFzFFBJJOBmHHXh00+9AuLE4SXNoT33VTNuss9xEFkIuE5othN7zs2vjeVv?=
 =?us-ascii?Q?LwqCSCfjbucmPAy1Lw/TUwO580EAZRvX+3VIpbix7xEZo3GGg9L50NqdLEEM?=
 =?us-ascii?Q?UYeeUNao/J/x7KuSmimLuVRJ1c9iPSdU88WN+y9JOnEcdebGlGBYkfbc9MJb?=
 =?us-ascii?Q?+tIzTcOAUK82gzQB8hzX0zHteek/3sj/HRTzcFtQhHwigP3aJRVvO5EE0H16?=
 =?us-ascii?Q?QA3gr4b/50JGeFetvjHQ0hhbfMBihhmzieD9oDUsC0itq4IFwHA1ZbJTqUGh?=
 =?us-ascii?Q?rsb/kl7jLnAHwfgSYM5cySXqAcJJluuV+uG7bz3rNdUv8JGLN08ED908bdya?=
 =?us-ascii?Q?RPLGCRth3BHkUioxQLsQIRxKM2dlMsiTs5plnBssmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+/EEta/NtD02kqF0MI2riUaZLJYUWwcSj0fvt64fGlPxwv6tBgdl7g+jmPH?=
 =?us-ascii?Q?JHy/0lW7Khm6Q6KJFfPzUlRLSr20nUpYU2nzGngx10dYENg2AK2RRLXwgl5L?=
 =?us-ascii?Q?MKej3zG38nmh7jmX8cfKdNduTxDr+HQ+O0ZVGG5dVs1r/L5Cl5C+4GrarA5/?=
 =?us-ascii?Q?LRlU9LgIiCNcCUvbhoyHZo//khcN44ZiO6m1uxV0GrSwzJa+U1Vhz9lxAqBV?=
 =?us-ascii?Q?3kAXZYHFkeGQ1+8AqJJlbh15xk3BpAjDMIzH4CyHKj40FruG9mrVe5NVD5JT?=
 =?us-ascii?Q?E4qIa0Xnuux2rjDYvVisIOBAS80QduI5SAua+1dCC55CmhwQDgiH/KA+04Wg?=
 =?us-ascii?Q?3hTQeRn79PouwSgX7qGyL0o0YkHZ0dHvMd9DWKy0NG6F/Tp6RdHcVh8uUWeq?=
 =?us-ascii?Q?PP+xHJUU4p1p4xlHxIvf1t17ruoFzcVGrN6S9Vda82ufClEcjUvB3O2aCtez?=
 =?us-ascii?Q?bOSjSz6tldaTjmSjnVSX21LbvmAzmWfAtdQ/283+CYyq5Z847QiGUrIMfXL/?=
 =?us-ascii?Q?EkS2wi6pJwIsH/Gl3Mhpc1ewik79B5LKv1P4wVn7uZcwk4IvIXdr+/6Y8ZFF?=
 =?us-ascii?Q?vOZMy7+otYvnnlvEgleMDFMNDsIX7OTH5+vh1cujk57sdEjK53x0gnW6wo8u?=
 =?us-ascii?Q?J53CoZMc5dywR/qBTyiB8qVoZHewBZvV9ptCcyzOl1aVUKdTa/6lffcfahXE?=
 =?us-ascii?Q?9qxTLqCl3X00G3NDW3i9CDbxJQy68bFSk1MK7SFg5Gf5nL685DH9xYkVtV89?=
 =?us-ascii?Q?FRO9QRwZA0OiUog95+9yXYS9EoZad+xpW98BEF+gvNqfvFzrxFdzzVi74ahQ?=
 =?us-ascii?Q?ZqHyq0cXkI0c/LFTL6y6pF9NzZbKhu/1TzFy0Wm5G6vpWjOV4jhnchEr+1kB?=
 =?us-ascii?Q?+g9115BvkqkoN7TzoOh58Af09jnJpiGIttG9v5d2ahrcMg9p2Cc83kHjrq53?=
 =?us-ascii?Q?tZXAJNVJGSQgH/ovCCMxuv7g4VlF3FaLSJNNAVNnUkcHaNMcA13ap6lIjl0w?=
 =?us-ascii?Q?iTB4IO1gAbx2/qKKXR6Xw6QsnWQqtl8Y5JVGTqklquMOr3eniAUAaFd6PskZ?=
 =?us-ascii?Q?r6KBXlJH586Q9rMxjRkJiMBqe2QHilO/wHvD26/PjUxCqyNnAeDYKAJqDUDE?=
 =?us-ascii?Q?HDTv9KXRdesR0HrhyAyErvDe5RRGckv4atKbjAU4GybBTm+Bsl8+Z3Cbv7M3?=
 =?us-ascii?Q?UeA02htmGEzjU7shQlw5erLJW0NnaBuTWQYz4XdwBgD7aBfgN5vTV3c0sWD1?=
 =?us-ascii?Q?mapd/XOnh64IpmjQ3CPCzoXYN/2br8fd/rXeVDxv/SzH/A5OAqZVvgl6LSkV?=
 =?us-ascii?Q?Un2xEfWPvXDB8ZBMMAauQ51iTG3pyqyK10Eqm8nciqloiH+XZnnpElOgm08/?=
 =?us-ascii?Q?pYadShONeq8ZQAHcGrYdFDetnGSu+1gr0rSY+LVUB3ADcuwEt90aIpUPIgkI?=
 =?us-ascii?Q?HJrUikyv+TXqaq2M+j64rN5nQ0UDu4uZfjU1l40eqJwQC8C/A9mLn/wY1GDA?=
 =?us-ascii?Q?3eAtjku7plqK1vWvOWXXBPvJk739TLbrYWpwHafI1Co1ulamAPLLnYU0C9mk?=
 =?us-ascii?Q?Lv3+i+hc8RDyPgYOHBp1TWYmw4n+HAxvGRKBte2scGBrTRHr6zAitUhej/k6?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da8d551-af53-4e95-6733-08dc80c64877
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:33:48.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckVnwZIAte2O5+LKy3twCXjQL4eS9L2cN07+zsguT+jlu/MLi/3ccjZy9DzDcatvtEANzIPKq35rQkfe9qVmVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

This is a follow-up to Russell King's request for code consolidation
among felix_vsc9959, seville_vsc9953 and ocelot_ext, stated here:
https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/

Details are in individual patches. Testing was done on NXP LS1028A
(felix_vsc9959).

Vladimir Oltean (8):
  net: dsa: ocelot: use devres in ocelot_ext_probe()
  net: dsa: ocelot: use devres in seville_probe()
  net: dsa: ocelot: delete open coded status = "disabled" parsing
  net: dsa: ocelot: consistently use devres in felix_pci_probe()
  net: dsa: ocelot: move devm_request_threaded_irq() to felix_setup()
  net: dsa: ocelot: use ds->num_tx_queues = OCELOT_NUM_TC for all models
  net: dsa: ocelot: common probing code
  net: dsa: ocelot: unexport felix_phylink_mac_ops and felix_switch_ops

 drivers/net/dsa/ocelot/felix.c           |  62 ++++++++++++-
 drivers/net/dsa/ocelot/felix.h           |  10 +-
 drivers/net/dsa/ocelot/felix_vsc9959.c   | 113 +++++++----------------
 drivers/net/dsa/ocelot/ocelot_ext.c      |  55 +----------
 drivers/net/dsa/ocelot/seville_vsc9953.c |  61 ++----------
 5 files changed, 106 insertions(+), 195 deletions(-)

-- 
2.34.1


