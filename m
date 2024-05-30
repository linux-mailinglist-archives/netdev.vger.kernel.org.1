Return-Path: <netdev+bounces-99471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7448D4FE7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567661F231A2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781AC2E84E;
	Thu, 30 May 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eYBqMMVK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736CC374C2
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086843; cv=fail; b=Xv24gUPInwQDRAU/pU40EEyU7cnwZurpS7YRqZ/B2Pqt4duVOJ7a97Shy4cW0lK+hFvvQpC3yKtwZXHD9aKS0Qodl7k74xMeEIlTk77Mt0n4aQ/MkW89rkbptjGy5oF4MdeXWbIJpWEWqP+Qby9qAmU2LTkijKvCew6Zk5CMJ9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086843; c=relaxed/simple;
	bh=h2Y1Ccylv+tFg7rTYJfwhYLV+uls6p1/SjJtORJOQhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E5+Y0ZYVmv4vGskyl0+th3f2+t+jvl26a4UJieqZTEcAVOEXWBRkWkqyKwJF7EZ9AcLNMiCqlgLQcro0eW/rDv50gnze01J4yZlbQugzGAhJDbzMdjmzl1HP32HIx8vPv3Llg9Jh1FN5AHr6GRVIjbrKiKgnbaMssJm7pLAvtOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eYBqMMVK; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPE2DoGf93igop3snaI7mrOAo4N4HE5a3PYJYvBgEXgvLTXJch3yfdZJsUiuMJoUVicAVPol4q7SVAEd5nh5GGFwj+lrn6/aJJYIvdgeE1I5aBiEigsMlmZolRYG2j6g895UYv+yYUbIPZNcpP3JPn1UDn2dTbOrCFS7ZUArvTJjYl2p6jWlRLhmvWH0rRKFCsob2GrM5Z2j88dUcFgqzx8pk/bk+bu1LPIPj2I5kQ6NOpFQ+HcKU+EBOT+i3NtnkrX9W3vm3AEgBKSizFWq7/FLSMwEJ+s1TPlVMLJa5HjgQkhmpnCllgh02J/m5XH3x1FJQwWWMumrowj9GoeKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfdtFZscbyORsEWgUnbJboQocuimvSFbV1X2XjCK1FY=;
 b=AzedaBwTxxURSZ5PBEoLdxRXbbiw1YaRzHELBrQfK+OOfPTc8o+AZxSYi4z0rjMq+yb/30OATFC5xVVMsn1ORz3LbbRDTdW4aWSwuq1aXpuRcwrUtlyTg6dvq1oeO9m8oknYcwNmkB7ubxCGtP+fu+x4Nwug+yP+nV8FYvTnONTyPtjNBhdB0pu1ZhajzpC3015jJjbQ1a28g0AyrNfo/4P5FQ3Dnaa/1rrID6e5XQosJeZmRUB8nrNiAnmEjLAl6LXruIBCeFjokSKDhkAFqRzj2JPeDJZ0ESZoA9cdaQPPfGlnqbusx/hIeNteWAKQczwJnX8c0keWRYqOfUctNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfdtFZscbyORsEWgUnbJboQocuimvSFbV1X2XjCK1FY=;
 b=eYBqMMVKzyw9cWB2nANUvGQ+0EDKRdk6bZL8++0+hixCfCAKB7SYyW300/uvcrv1domtHzkreoi/MAsdtmHo8FCpPQKufTPlo3AqP3fWHFjfJEnKSlYNW2oqvG81P9/k00YoZHDPmX6X5x4TAeP9X8r8euD6kqOLoJ9uvWkSw2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 30 May 2024 16:33:55 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 16:33:55 +0000
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
Subject: [PATCH net-next 5/8] net: dsa: ocelot: move devm_request_threaded_irq() to felix_setup()
Date: Thu, 30 May 2024 19:33:30 +0300
Message-Id: <20240530163333.2458884-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 812fb1e1-812a-4e56-869c-08dc80c64c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J0acdXbD+sNJu/BavlPALmEmLtZkLbStCnSNqnXGUbnbd4WxvljJ0DUDkvf1?=
 =?us-ascii?Q?Baf0mwkLeErbhJRzwyxEw9vRqayu1k6bI8mktcx61R7DddFS9jrPnSTWSJdU?=
 =?us-ascii?Q?aboklaXzZFo4S8uYVmFZ0fWba831shyzlmat/wOsMQKX6nCTnVlk9/gSKei3?=
 =?us-ascii?Q?YbZSNeCXz2xDI8tDm4puaQcT6b4seVFkEIZZ03DfqAsrJbBwDyRDEzTqfhAc?=
 =?us-ascii?Q?HwD/e6HFuJ1cDWQk/spRFKhethnLFVJWXFAby5kIAxF/kr7IEMWn7tyvYY+7?=
 =?us-ascii?Q?EA2uWhLh2Oc6rNzCv5Q7sBjfnCO5X63c2XqjcJgCR7s3HmZ8IQzaFuFCd9+O?=
 =?us-ascii?Q?iS1HXxBbiviOsHEIvAml2NKBhkGymIAR5LbZhGlpHJ0CgzFmw7XCr1pwpoSQ?=
 =?us-ascii?Q?a/aU/TbAh3lhmCVuuv9+tmGF16HGb0yM4l+7cfQB2AdIsSIfQ7ekuKgabSQj?=
 =?us-ascii?Q?iss+C93Sjs1Iv4RQ21SrNUJafj0Ld7MTfIyU0qDm4jK9mhJvUdaCkgsSHp11?=
 =?us-ascii?Q?ROo9mpA4y4FIUuSmOYJXNwhqQzmO9+q9XOeCFIsWWavVYADfGT1xESRtp5Ux?=
 =?us-ascii?Q?lHCTJcVWBb31gC/sxUG8eizP/F6g8ym/o6OpP9tdA72p3KiQCoN+mJrJ4bK2?=
 =?us-ascii?Q?JK7UUkuOSyqdY+19IdRSljsRY/tNQOFP0ZgNl9I9ekvbgm2tWLoQZNP03P3u?=
 =?us-ascii?Q?nf+Dq/jGPRYrWEUSbng6EfP6cUpxQ+hifa4xwZudkccLKePF76bSDMsSTADF?=
 =?us-ascii?Q?ZcXLpm/ZNzbqg/NFi/NVg/8O7/weuNDnb62B6EDw6sDpAq1OBXt7+ac/gUKa?=
 =?us-ascii?Q?kw2X0+Vj9/5kM8+984xgO07YTGJ6O3dlSmybxU1LmfaJROqA2e3yNNQRR1/J?=
 =?us-ascii?Q?6VfM2PPlldi2CtcnOD/tEtyiDokWNzlVespfrqqGjJ9b0G83mTAKAwGQS+Xg?=
 =?us-ascii?Q?phIMxLwXID28ZufIcpDwx+WS/P234hDr+SFKy6w/a+jhZDQpPxLqTVdOqH/6?=
 =?us-ascii?Q?nKaGSNPlv2Kww+ARY/e8VxBDyFUOXNjIbjr5dipPwGIU5kwAKLcGBv5shtfr?=
 =?us-ascii?Q?mwL4dEqzaAalPS6TaL2B0v29vx7CPt7RWzpoWfMld/pRyEqA+u6II76rMf4g?=
 =?us-ascii?Q?b0pqF4/IpqEpQXQBTTJGoaWuFUJo3dPNLoaCcKxsgxbJ6jGaCkVDh2fiF2ez?=
 =?us-ascii?Q?VGh/znspiPfbSwhXRRtMcCzVpfVYDLp3WB1HNBRsuYJ+k3erijkngr0NoEQj?=
 =?us-ascii?Q?Wv5Kir9fa7UzPlezzU8oT/xcNaRMxXODOI5X31G6wQMHehPBNxeBeszp0j1E?=
 =?us-ascii?Q?8zXqfrlGxiepm7qkt5+8mWTrZ5GrTttZ7mKJWcUNsnbw0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hC3whdZtMREhjD1+2veczIEUycgdYOyFDlbwnqxCV/bD2bAPa3CUngRiS4j?=
 =?us-ascii?Q?BjtCl/v5ALJmm6E+BWMU+xmwwP45X7V94wpjnOdAzQUMozqCw3IyngJANWdN?=
 =?us-ascii?Q?gDyYvUvCEMRuqC5y+/0VVVC5qvdLn+JPSinhXzvVah4Ih2xxOjfCyTTsdrVQ?=
 =?us-ascii?Q?Pplp4dyAVyBgXd8ptIRItEEksnWsYXVR+rkF4HcyM/mU4+5GK3/6j63Cozxi?=
 =?us-ascii?Q?GnKldBA+10433mSqCswASrdq2rOIKPM/Lda1OYAv5/AWkfeRq4E9aeaKLt+j?=
 =?us-ascii?Q?tEbZLPI9NKgzWrf4363rr4dQYByzVs12tMnEFvYiU6GUkLNtuWzYilgEPHuP?=
 =?us-ascii?Q?5fjmLgCH1uiNHplGsi7X7Cn6bRLM3U+1Sf4NGZAAkkiCpvYU8tc1nR3d9wmf?=
 =?us-ascii?Q?bvDR14PfYYTROg+Xp7rddOjb42dJTYqy/KZ5/zmJzVp3EjQOTMHFo4tmAe+q?=
 =?us-ascii?Q?bKgSFk6cOuJkDT6Z7wvpMXHQ8NK+VB0C6vRNhJHsQly4EZuPqf+pfB51C+/V?=
 =?us-ascii?Q?C1pbj27K1jHhcMsWKzjLFZYmWUrGTqn78BZTQQhPOzEbRupbsJgdtUe9IhKt?=
 =?us-ascii?Q?8teIQcS0/2OKS88naA8YyNAxa5kVwJQ+Rdu5i6jJSiYyKflBunuKWLCXaAE3?=
 =?us-ascii?Q?lSR5VjIAbtrYLlQyWjzy1J0ZdYcc8qfDACf52FKhBTrzTJl77t0f8PcjTdYd?=
 =?us-ascii?Q?P/7oNP+JE89h1SmigcqiysJKwU0yTfUTOREhRpyjqEMlptll+OtzUvD15x3P?=
 =?us-ascii?Q?WFohrZtU33BPvBKCRKsivrEEZR6WmivRcGIIrtU8K8quoSW0t1EXI+w4x5Lo?=
 =?us-ascii?Q?ofO4Gu64WdrJD2HOpsvXOEvEzjEl04QfhKYXRhEtEeVo6/ru92nSShliwjBD?=
 =?us-ascii?Q?6rx4oY9ZeJTz57EwZazfbsvraWaV8vVFuyurVc49hAUNTrlFloXSwIsChfew?=
 =?us-ascii?Q?PwfGo0Gux+qFzR1gOmX9gCGOdnzBni/nTJSd+SnaZ18xzA1Idwz6I+1Uye5h?=
 =?us-ascii?Q?Oa34GWk95xeLRZ97XF6U/ftQxM9i74wjTa0HPgGXtAoo67rJvrYgu4Ep582W?=
 =?us-ascii?Q?NFt/Whk5KaPHYv9XOwCfBkHXuKu6Xc+/fku7+xElwnElympL8AEz7O52mClI?=
 =?us-ascii?Q?QZJYv5+Mg5YAkHAZP0Vvq7SERkJd7CtDoEgIsvNXQ7PouhmepeOkLdbz9yn9?=
 =?us-ascii?Q?a47ts7qje0fB04ll8dTLhZjGKu/GScbEB+wJFNa/FEk+ukGxe+OTnmMoz4cV?=
 =?us-ascii?Q?lYaDkKTOtrV3YrUXCUj4P7/0I3ry7AYZ5B2jU4M0LhWIREPxS7+B3MER9V7U?=
 =?us-ascii?Q?mvo/ML3g7pv9NG/T0PPY9chEywTFo/eyvnT9pybQho/UKow+Kurus0L98xJS?=
 =?us-ascii?Q?J4OjDAjQ7OUNvpn6yYRoM746VhX8Z2/jRFBKzfbvpbygjNxda+wex8QRAL0a?=
 =?us-ascii?Q?f3u7m7cUE5cq7GS7mi98YSKjQ4GrJycGNaxkxXwVIWuKfY+owe5ieA7b7sc3?=
 =?us-ascii?Q?qNKtuF76qk38v7WCMv4vKt5x9YRUCv42M2d9arT69Bb2IKT23KYvp2fymKpS?=
 =?us-ascii?Q?xqLsQRcjq5G/89a763m1bu0MZOYTH5CT4hV3zRQFrDyoPlAtNCz/uqsRHf4Y?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812fb1e1-812a-4e56-869c-08dc80c64c2f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:33:55.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuUhQwl/9c2G77sINzwm7p9wn1umdiqnuhIVkVGFr+BMxuypGaERXTT+60bsxKrvG/hB5KuTPzwt0lnOupsNig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

The current placement of devm_request_threaded_irq() is inconvenient.
It is between the allocation of the "felix" structure and
dsa_register_switch(), both of which we'd like to refactor into a
function that's common for all switches. But the IRQ is specific to
felix_vsc9959.

A closer inspection of the felix_irq_handler() code suggests that
it does things that depend on the data structures having been fully
initialized. For example, ocelot_get_txtstamp() takes
&port->tx_skbs.lock, which has only been initialized in
ocelot_init_port() which has not run yet.

It is not one of those IRQF_SHARED IRQs, so CONFIG_DEBUG_SHIRQ_FIXME
shouldn't apply here, and thus, it doesn't really matter, because in
practice, the IRQ will not be triggered so early. Nonetheless, it is a
good practice for the driver to be prepared for it to fire as soon as it
is requested.

Create a new felix->info method for running custom code for vsc9959 from
within felix_setup(), and move the request_irq() call there. The
ocelot_ext should have an IRQ as well, so this should be a step in the
right direction for that model (VSC7512) as well.

Some minor changes are made while moving the code. Casts from void *
aren't necessary, so drop them, and rename felix_irq_handler() to the
more specific vsc9959_irq_handler().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c         |  9 ++++++
 drivers/net/dsa/ocelot/felix.h         |  1 +
 drivers/net/dsa/ocelot/felix_vsc9959.c | 44 ++++++++++++++------------
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 3aa66bf9eafc..09c0800b18ab 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1597,6 +1597,15 @@ static int felix_setup(struct dsa_switch *ds)
 		felix_port_qos_map_init(ocelot, dp->index);
 	}
 
+	if (felix->info->request_irq) {
+		err = felix->info->request_irq(ocelot);
+		if (err) {
+			dev_err(ocelot->dev, "Failed to request IRQ: %pe\n",
+				ERR_PTR(err));
+			goto out_deinit_ports;
+		}
+	}
+
 	err = ocelot_devlink_sb_register(ocelot);
 	if (err)
 		goto out_deinit_ports;
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index 4d3489aaa659..e67a25f6f816 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -64,6 +64,7 @@ struct felix_info {
 				      const struct phylink_link_state *state);
 	int	(*configure_serdes)(struct ocelot *ocelot, int port,
 				    struct device_node *portnp);
+	int	(*request_irq)(struct ocelot *ocelot);
 };
 
 /* Methods for initializing the hardware resources specific to a tagging
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 34155a0ffd7e..20563abd617f 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -2605,6 +2605,28 @@ static void vsc9959_cut_through_fwd(struct ocelot *ocelot)
 	}
 }
 
+/* The INTB interrupt is shared between for PTP TX timestamp availability
+ * notification and MAC Merge status change on each port.
+ */
+static irqreturn_t vsc9959_irq_handler(int irq, void *data)
+{
+	struct ocelot *ocelot = data;
+
+	ocelot_get_txtstamp(ocelot);
+	ocelot_mm_irq(ocelot);
+
+	return IRQ_HANDLED;
+}
+
+static int vsc9959_request_irq(struct ocelot *ocelot)
+{
+	struct pci_dev *pdev = to_pci_dev(ocelot->dev);
+
+	return devm_request_threaded_irq(ocelot->dev, pdev->irq, NULL,
+					 &vsc9959_irq_handler, IRQF_ONESHOT,
+					 "felix-intb", ocelot);
+}
+
 static const struct ocelot_ops vsc9959_ops = {
 	.reset			= vsc9959_reset,
 	.wm_enc			= vsc9959_wm_enc,
@@ -2645,21 +2667,9 @@ static const struct felix_info felix_info_vsc9959 = {
 	.port_modes		= vsc9959_port_modes,
 	.port_setup_tc		= vsc9959_port_setup_tc,
 	.port_sched_speed_set	= vsc9959_sched_speed_set,
+	.request_irq		= vsc9959_request_irq,
 };
 
-/* The INTB interrupt is shared between for PTP TX timestamp availability
- * notification and MAC Merge status change on each port.
- */
-static irqreturn_t felix_irq_handler(int irq, void *data)
-{
-	struct ocelot *ocelot = (struct ocelot *)data;
-
-	ocelot_get_txtstamp(ocelot);
-	ocelot_mm_irq(ocelot);
-
-	return IRQ_HANDLED;
-}
-
 static int felix_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *id)
 {
@@ -2690,14 +2700,6 @@ static int felix_pci_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	err = devm_request_threaded_irq(dev, pdev->irq, NULL,
-					&felix_irq_handler, IRQF_ONESHOT,
-					"felix-intb", ocelot);
-	if (err) {
-		dev_err(dev, "Failed to request irq: %pe\n", ERR_PTR(err));
-		goto out_disable;
-	}
-
 	ocelot->ptp = 1;
 	ocelot->mm_supported = true;
 
-- 
2.34.1


