Return-Path: <netdev+bounces-242802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E114C94FF6
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C11C44E15F0
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6915E280A51;
	Sun, 30 Nov 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UXC/QzNb"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD3D27F171
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508666; cv=fail; b=bbZ7aYLML/v8KfjUyfiELwIgBmT2w0QBwc9ckVZYOlt9awYo6u8lYbav4r+E+8VYI/K3oneR8L52n0XZSquGttzkQtonXDjgRyxqhriSj+ByK/IwBkWbLaLqJyw7OdRvaN3BAESXhQVb6q/I7d8XSINiuR+wpePn3V4HczCSRwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508666; c=relaxed/simple;
	bh=GRPfxhO5czwkZtIFVEmlLN+24xYpb8PRvtiYiJnV7CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5zkxdrKGWtsg+FWxjycBIPA/WCMJmwWmHMM3EwUpaBl1thIbYvrb5cJfp5O16UTwNkHU2KSuC5vEjy+VRByxRpWwvFSqJzCiqzMuQeEx8wmJGbNOEb9VkE8FPee/KDwk+Qp2HQ0+0DV0ghbwe79nrPpQVWdQDxdMFNBIv//zM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UXC/QzNb; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh0HT8vXlRXavNpjauX3H0Za7bubrK2q3ve/vHS+GkVg9b93iUFs+Uq1gc2Hjj7gKjvwtpE4vWnUZ+00XhpSDGaogoItKyyUi9Fjjv0T6pvUv8+ml3eB77mOUHO3pk1h0Vce1zCOXQ/smDPZGXwp2jFWPH3WJqOnQeeWkH1LfGsHZTyn2OozmPzpwhvW7k4Y7wSo0UI3BlmqE4raxrjI9U2dUvutL3tOQV6kBaZot8ZPKoIB0qSQj8DQrEDEgnOY3M8mh9hM3xp8ON4htQ9Bgi6AF2aoxYcNaK9dOFU3YjncVg/AXF7MLkyMkef+IgWM/yvpMzKeYdDJx/qNwTbFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNyEMf2HlbO6RWXZwDFR4Sti4oWAxXr7igLNBquG6G0=;
 b=SgACCnpDNRWinr5vEixkDe0UvqjmybSKudNl+Qpf2U7rNxvdcD0ZgtCdGXi7yOXX63y/HjrpyShck2BM2CY5T0rlX3sr6cyNHgtrZ3wS3QSH0xSdHwI8Haf41EKGu4PPHRFBHxWNXMvJkgdXPVLMPTkscaM8hcA9LC/Un+GOPfbtNdA7oKhNR6ReeYRgpu9JHHai+hNfMVrFueqZqkeraIncSQR9p+ycPJG6pBrf+iREn0I8nW9vBrP/9IIIwcuVsUbxgNbggWmxqbVf7JXfFjB7qn8abxPgEMXEytgfj56Gm4E55rD7IgGByocP/tcXDJHyLej+5SRShnx6nt8XmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNyEMf2HlbO6RWXZwDFR4Sti4oWAxXr7igLNBquG6G0=;
 b=UXC/QzNbfF+eIzb9y5H/t296Mbh231OXwIldSRxI4wd2ZP96FgSqP+Apq8iy1XD4MWpNmtG1tzOnbxTnOfM5FoVeWUoBez56M5ji7WyhvmEFHRbbxzrKdEulGue4LQxa/DUUa0sfTmFMhfZsH1+xsFzz80MgbeJxaGHsMy+JIZQDCfMN8oOpeEPPYyJoviI2nYfux5ROZKtfaz6etWLHOb7LiwMf/T4k4vajTGBGiCZ4rxu32pdSLKMpW1Z8wx9MoF8WnsxWIQXs846DI/LTlpKKwSH5Rx4rtogQWEBRwJylFxlfWNtaBQjPiuzT6DfZD8ZeUfKoLem9C6vorH9SxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:35 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:35 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 07/15] net: dsa: ocelot: use simple HSR offload helpers
Date: Sun, 30 Nov 2025 15:16:49 +0200
Message-Id: <20251130131657.65080-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: 229f3c63-24ea-4d22-8f13-08de3012d3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xZ23Y/7HsjShxW1K9PZgycKHIiXY5e0rmwQ7IEkblFcmB+noQjBNctvut1Jr?=
 =?us-ascii?Q?Ee8ldPMeByMZu+32ef6JHpXJqpNW4bd8KvYnaCMj/RNOY+QyvBjcZu6F06gQ?=
 =?us-ascii?Q?vheR4Kp6Todtm21YiSGL2JbBwemajqGqqrSM4dZY37ks9Ggp4k/+NC8XMPJQ?=
 =?us-ascii?Q?cMe4wi/uNxCKfRFDCk22iXI1jd65cNDwCgXSwgHU0Dsz6ZGWNWl+kUoSSxY9?=
 =?us-ascii?Q?n/nnbmDoihnwHqYegL03K99GpjfXN0XONi3W/N8RuyS+YpkDIMXj8M6TSGSc?=
 =?us-ascii?Q?H9Gg1C0ZYj7tqklapAVPADMX8zd3JOQ0aGo4yUF7IVygUMUbUM7qdEgpPPC8?=
 =?us-ascii?Q?HKt/dGohg3xVow+kZZMMfSBD7MtJuDSkErgYmv7jqqsBIopAlEerYWKgJeMQ?=
 =?us-ascii?Q?D5vUkfSEXN5WL+pWv0DN25xYN/5bMu2kTHIvMpi3oMUl4TQwLt5AV5YcOtTh?=
 =?us-ascii?Q?xezfKZgWK5GMb19R6x31Z+J5ivuUvSLp/0gXCLaTo1MWN1DgpE+tkTAxCYMl?=
 =?us-ascii?Q?vY1YgS/ME7MyYq8zjCYtAH8NkvGi3whqP0k5gvoXaaMmBEXWApRfzSSAx4FP?=
 =?us-ascii?Q?z4ZnGKRY0DHfnrYu8kUBBbmRbPN4BVlHq8gm6vvk43cb41uwS3JwxWHXtvhs?=
 =?us-ascii?Q?zRy4PHkjyGFoWYXhbUwJAfHt1iq8xEDSnfm5ZrTDdjyygrill1yKLjnjsr8p?=
 =?us-ascii?Q?YhqwNOvj7EbBA9Iy/Q63Xgd9SEOoo9cotRzR0cZJh0lJ+6MHlrYlKYaEOM9t?=
 =?us-ascii?Q?Hll9si23lj3RFeSwrBE2oOca/2BVi6VWAYT+x5vTPmn+xUM7nXKuFbJ9jc/N?=
 =?us-ascii?Q?91cPkqjveDNW/waYFJTkU+j8mFU9mwWKGHOSpLZ5xQhXxC4/BOx6KI9xAror?=
 =?us-ascii?Q?aUL8J1HlzYWR2b048XlQhQ256+/NiCeDJZ8lvTG/FjoD5SYD/sxGiSZNgElu?=
 =?us-ascii?Q?oM6a8T249KyWMhyqwIM3SN2/TAsUQzTb9U33JPFbsrUJx89qaaWGMyo+Nm0m?=
 =?us-ascii?Q?BhMzktK/T25vET3AEbtkdyV7q0yCSrn7dnVZP2ddMAyitg2fOGRf87kyGKWm?=
 =?us-ascii?Q?rEtFzR4nFmpRQkt+PH3HQI8yk2l0QjJd241RexLdLmZZ3YNvfR4lOJa95WqL?=
 =?us-ascii?Q?UeDnoearxBJts0iI6fTGHp8jCdEK4OjX0QApjnHL8vcvz7u/oqqzCpsrmVaq?=
 =?us-ascii?Q?ecAFxoy+oKD4T79q2YnTzQaNwR9rAV75JVyQYqays2pm53YMsZmJUArN/k8E?=
 =?us-ascii?Q?kE3BBu8HGtXc9miH3Hi0PYideQbtmhGcxArKM+KyfvJlHtmaRMkKr77aomTT?=
 =?us-ascii?Q?F+Aixzmp0xfqGzCRIhg3yYw7wiCF9ncMO/xO7XXxlTvd5UcVZksax23dqhWX?=
 =?us-ascii?Q?XRUWesw/JoB1GVGdZC0fLaA3/WlgZXm6mkEF0GaDEMy1c3jPmzHhlpy0XlKA?=
 =?us-ascii?Q?xYYmM2maIGcak+3MGd8LemTppvqKct6YYCHI2rZyVptMR7XAGGI/NbZDocfR?=
 =?us-ascii?Q?wWZn+M4Mzd9ld92W59fNZrY1GDrm2XNl4RyY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f6qMoZnNIX10jz4UpzOQxmWsnEixMB57XebM1u69RrL4EP0259iRqvAJuBXJ?=
 =?us-ascii?Q?5qhzm+p6D6/oYyLUh105dPmzQto19L3YiOehzz0Pp/zP8/qVBE4JHGPCpQGC?=
 =?us-ascii?Q?8s0Jk1XtU9YE56I+izc10ESTOIpSlhCcMkh5mS1d/Ypilzwqm4xnUc/UHjOJ?=
 =?us-ascii?Q?PSqFOLSftpYF/jSpazh7kQvbnibuNHN4Hd4/fmpES94hKHTEmhNWUkLeMl00?=
 =?us-ascii?Q?V/aJ5UCNCHjuToHgOaGpDnXIYI6YD0Lrna1socBxSSFvuns5BzD+P+Ww2YXg?=
 =?us-ascii?Q?ZC8XWfA9ve/KQ1xLXwFf1pSKwC8UBKTUffiR873jTjUVgdnM7yFiBwBiyBBZ?=
 =?us-ascii?Q?LE4y36UCsEZAwnQ/BJxodU1/pO4tZi/Ax1RuZLsmGcskqxmgim8sh4qEsuNj?=
 =?us-ascii?Q?lPzbtrVys/Fo5SVBJg0tfeLRD4gTImiM/blmMDnzFtGwBOM+ygLRNAMm3mEX?=
 =?us-ascii?Q?8jfDHIVJ64wOF1tIgJ22kkGSPj9VYD8u5ei3tKR1yHAY9KR2IT9UOdM9KNxD?=
 =?us-ascii?Q?6bS+pbqig4BmpVAjnpomTEFAtPxhvqa4TdHImdVHdhjTG8dH3mXFcfDt5PiS?=
 =?us-ascii?Q?qQB3OUt4bSM0bBGBlIRp4xdn4uGIZ77PGMt9gtHKzSvaQmgT2CXog7DkyhNQ?=
 =?us-ascii?Q?oGJJhe67Zuwvg/O7t2YBnWdKhCoLlmFjmzdHgpatp/6hn4gFCoru32eQLGTF?=
 =?us-ascii?Q?IY+Ic25nz8ZxmIT+ZozWbTex874scVEzJDZjgf/xN2gfJKljHJhLDZVYqUFt?=
 =?us-ascii?Q?sCVsVudzDwq0mTj64yRNJZ2N1oiXjphXCToH3l1VaP/6Naz1ILmSjStLDPfS?=
 =?us-ascii?Q?zHvf98rtg2LTaECz/UAoZXkGuiG7Z8EpKe5qlFnVqirccVjJT4Tr9N70BnSm?=
 =?us-ascii?Q?gh37PKT6YGV8kWnP7uLBY/ocYHsYSQX7Kg9aSIxFeL5kJgOryK4S01UpSWDZ?=
 =?us-ascii?Q?yW5QIa12cSws7Ken/Q1exkDBUVfuK8SvfrGaNrw1cN6JE9vWWLx6t/6xHrqt?=
 =?us-ascii?Q?wD7MM2chwVLtIzIXJtK+0SDpW3Et3yh9gKKN3a7PyeFHyE/i63MxyklO0Zak?=
 =?us-ascii?Q?/nRtUyyHaX9eDSSGvb7D23k3StL+79KOWni+v2r0fhxzcVW9KLCOlgq7XuHC?=
 =?us-ascii?Q?12Mk+sdMZwO4FreQoUmFvF8o555HplP5KtPEaOavm0bqGCCxrTzNvSHfdnGk?=
 =?us-ascii?Q?eS9obII4et4Yezh0lv94AYSdU67cjUaWA9K3JQL0xciz62zExvDZufMCa0IJ?=
 =?us-ascii?Q?TGPNzxhYOQPk5ZgLFY7OBcNgz7OKx3X2jHTcIM3O9N5FUQk951vBKhNcdMfW?=
 =?us-ascii?Q?/Nd0M8m72n1wa2HtCoIKyPcH+vWvFmmyqHZfJQo4+/74yWj8LZM92xOca4Qj?=
 =?us-ascii?Q?WKZrO6uH7Bc/ZsZlISk2C2fROMvfqIzTx29NuhqOnR1IhWNHZJnmazCVpV1c?=
 =?us-ascii?Q?3a1fpQe/bTSWZimganBMs255dxYUO1fpSNy+VJM9UMZcQHLzNpPuF7aR7Jid?=
 =?us-ascii?Q?uRzw6fVzOMSX3Uxztdex7ZjFHbiy34PuFBgQItU2xalQSfg1IvtxXae0B6pc?=
 =?us-ascii?Q?3v5zGz/L4t83Kd/XIBHt3M2Tq22dhsD4An6NF2qK2pDElNeP/BIHhG7B5lBq?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229f3c63-24ea-4d22-8f13-08de3012d3bb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:35.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vZY2r1AiViuine19sg/Dfdaq/GheB2ueWM6BIWX4mb9YA+D5StsrxfBymc/EkQ84DIAUxviE7didTPMoPnPBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

Accelerate TX packet duplication with HSR rings.

This is only possible with the NPI-based "ocelot" tagging protocol, not
with "ocelot-8021q", because the latter does not use dsa_xmit_port_mask().

This has 2 implications:
- Depending on tagging protocol, we should set (or not set) the offload
  feature flags. Switching tagging protocols is done with ports down, by
  design. Additional calls to dsa_port_simple_hsr_join() can be put in
  the ds->ops->change_tag_protocol() path, as I had originally tried,
  but this would not work: dsa_user_setup_tagger() would later clear
  the feature flag that we just set. So the additional call to
  dsa_port_simple_hsr_join() should sit in the ds->ops->port_enable()
  call.

- When joining a HSR ring and we are currently using "ocelot-8021q",
  there are cases when we should return -EOPNOTSUPP (pessimistic) and
  cases when we shouldn't (optimistic). In the pessimistic case, it is a
  configuration that the port won't support even with the right tagging
  protocol. Distinguishing between these 2 cases matters because if we
  just return -EOPNOTSUPP regardless, we lose the dp->hsr_dev pointer
  and can no longer replay the offload later for the optimistic case,
  from felix_port_enable().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c | 70 +++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 20ab558fde24..9e5ede932b42 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1233,6 +1233,7 @@ static int felix_port_enable(struct dsa_switch *ds, int port,
 {
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct ocelot *ocelot = ds->priv;
+	struct felix *felix = ocelot_to_felix(ocelot);
 
 	if (!dsa_port_is_user(dp))
 		return 0;
@@ -1246,7 +1247,25 @@ static int felix_port_enable(struct dsa_switch *ds, int port,
 		}
 	}
 
-	return 0;
+	if (!dp->hsr_dev || felix->tag_proto == DSA_TAG_PROTO_OCELOT_8021Q)
+		return 0;
+
+	return dsa_port_simple_hsr_join(ds, port, dp->hsr_dev, NULL);
+}
+
+static void felix_port_disable(struct dsa_switch *ds, int port)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct ocelot *ocelot = ds->priv;
+	struct felix *felix = ocelot_to_felix(ocelot);
+
+	if (!dsa_port_is_user(dp))
+		return;
+
+	if (!dp->hsr_dev || felix->tag_proto == DSA_TAG_PROTO_OCELOT_8021Q)
+		return;
+
+	dsa_port_simple_hsr_leave(ds, port, dp->hsr_dev);
 }
 
 static void felix_port_qos_map_init(struct ocelot *ocelot, int port)
@@ -2232,6 +2251,52 @@ static void felix_get_mm_stats(struct dsa_switch *ds, int port,
 	ocelot_port_get_mm_stats(ocelot, port, stats);
 }
 
+/* Depending on port type, we may be able to support the offload later (with
+ * the "ocelot"/"seville" tagging protocols), or never.
+ * If we return 0, the dp->hsr_dev reference is kept for later; if we return
+ * -EOPNOTSUPP, it is cleared (which helps to not bother
+ * dsa_port_simple_hsr_leave() with an offload that didn't pass validation).
+ */
+static int felix_port_hsr_join(struct dsa_switch *ds, int port,
+			       struct net_device *hsr,
+			       struct netlink_ext_ack *extack)
+{
+	struct ocelot *ocelot = ds->priv;
+	struct felix *felix = ocelot_to_felix(ocelot);
+
+	if (felix->tag_proto == DSA_TAG_PROTO_OCELOT_8021Q) {
+		int err;
+
+		err = dsa_port_simple_hsr_validate(ds, port, hsr, extack);
+		if (err)
+			return err;
+
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offloading not supported with \"ocelot-8021q\"");
+		return 0;
+	}
+
+	if (!(dsa_to_port(ds, port)->user->flags & IFF_UP))
+		return 0;
+
+	return dsa_port_simple_hsr_join(ds, port, hsr, extack);
+}
+
+static int felix_port_hsr_leave(struct dsa_switch *ds, int port,
+				struct net_device *hsr)
+{
+	struct ocelot *ocelot = ds->priv;
+	struct felix *felix = ocelot_to_felix(ocelot);
+
+	if (felix->tag_proto == DSA_TAG_PROTO_OCELOT_8021Q)
+		return 0;
+
+	if (!(dsa_to_port(ds, port)->user->flags & IFF_UP))
+		return 0;
+
+	return dsa_port_simple_hsr_leave(ds, port, hsr);
+}
+
 static const struct phylink_mac_ops felix_phylink_mac_ops = {
 	.mac_select_pcs		= felix_phylink_mac_select_pcs,
 	.mac_config		= felix_phylink_mac_config,
@@ -2262,6 +2327,7 @@ static const struct dsa_switch_ops felix_switch_ops = {
 	.get_ts_info			= felix_get_ts_info,
 	.phylink_get_caps		= felix_phylink_get_caps,
 	.port_enable			= felix_port_enable,
+	.port_disable			= felix_port_disable,
 	.port_fast_age			= felix_port_fast_age,
 	.port_fdb_dump			= felix_fdb_dump,
 	.port_fdb_add			= felix_fdb_add,
@@ -2318,6 +2384,8 @@ static const struct dsa_switch_ops felix_switch_ops = {
 	.port_del_dscp_prio		= felix_port_del_dscp_prio,
 	.port_set_host_flood		= felix_port_set_host_flood,
 	.port_change_conduit		= felix_port_change_conduit,
+	.port_hsr_join			= felix_port_hsr_join,
+	.port_hsr_leave			= felix_port_hsr_leave,
 };
 
 int felix_register_switch(struct device *dev, resource_size_t switch_base,
-- 
2.34.1


