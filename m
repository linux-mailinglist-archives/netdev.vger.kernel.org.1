Return-Path: <netdev+bounces-288829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOItAImBCmoo2AQAu9opvQ
	(envelope-from <netdev+bounces-288829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:03:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 974AF565416
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1FBA30022F8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E306F37F73B;
	Mon, 18 May 2026 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GsPdL6la"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FFB37C112;
	Mon, 18 May 2026 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073396; cv=fail; b=EyGZKoxaGqchImOPqSKlVMBDDDOJRXwb88LczNrWp5K30A2WUNyD9gBmYucY/64HDldkcZ7X61E5/y0ng/HHlROHNC7N6jgXkbZl6EmdDt7ffiIePdM6G2JO6MSkaMWDZy3kno7IgUx0ftNUMhHbBMOYvEdhWvWHDxnx0mK3dww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073396; c=relaxed/simple;
	bh=g2yO31hkPrwbc+jLq7UjxgSo640GYCqomiVAxICctWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JyGH/Mw2swBXqTIv2GC6Q/fCkOeqktf10hBaIqdHqPureALrU2Oz8MbZ7TND89vI5uLmXvXwky1NHAzGp0DVfdSaMviJfYl8Uqzwb7Hk57O6OU7ppI8tHcYIpWX8NADryQTKeT2tm+iwDYRL2V49xMfMNnZllbh5mT4vQ8s+Jj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GsPdL6la; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIK0Ov2Lyij1agtLaFDZVHLRfC8HR7xMbd7a6ledCJS6Qeaw5N4BFDumdGo3KybiXKwhg3XvXiAXN03tds1BaDbN0aIYf0D0g0/lTEaBrW40HJ+IsH7lYOzRTxyHy+p+iIBUyeNSt1Yqxh1wMtx7DRjV3Rho9cgFUur3e3AF4a1XtZpCRXyH6ksbcRepKig88wFG8pzbhJmF0CNgad3de2JCgKzof6D3P3jE3yQZihXDHgVrIbEl0QPu2uv3ZgTbhBoNOOFr15BXmIvgKWmXv0lT8k6jCbLsSrscFNeZEmB1uDtUlH1dSMRPgHHRnXVCiktBG+versCT5rHmZao7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4ubNFf3c3m9gmtEz42l9InH/kYbBONgQzj+rV8l0bo=;
 b=OPTjVmVoeu1xK2CU4CogCbZrDIIyJBm2WWQy6TIs0DoZRUSX5UMywYIaye+n9k2ENdpIWL0wyHxu0Tc+5xryinUOJdXfQx1lwazCns1jlwm8I689PaqGtHH66/ibMLkBzeokw+6AIOzPNa7aHTmwL38objaIk0wbWajtznCBU1UcrvG45ct/3ECtdl58if9SsoiHrOnV0kV5OdxzY1MmK3wgOf8QQJVTAKNnNgeeWGl+Jd+IonGc3iLKBA4cjoCfhBXRgz6u01/+IinRAEJv3ZcMTmISi0FAwnOVPSOH5TxCGyyFgcRhWtUersDV/JQgdD39RSYRfhUcXK7ftfX8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4ubNFf3c3m9gmtEz42l9InH/kYbBONgQzj+rV8l0bo=;
 b=GsPdL6la2UlUDCq+ub2wnEfMTcxmXxgEwsKvVgTqsFiL0iL5dEWazF1QPvweXGoYH5FyfrBJPoyOa1CwJcypXJIpOhU13YW6aqgeCalCA7cCvVyU76hSwtJ0TPqCwcYv36XnF09S4ggO6Fv3WfeVMo37hIcYt2SvGWTXsraZWwiRZoIyi5e6VGuA6hNyXW8VwFGcFhfdV6RmEXymIlth9rbZmu8dxy3C3YsgorT2XpaNWOnaaxc60haYsymN0FeW1kWLuENlQWWqRP0bzF7i1LfooHEl4KrgGfmggOMOghD++lVmbrjsrdARf5idZa15kOZnINskl/yhQvemlJgbFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 03:03:08 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 03:03:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v2 net 2/9] net: enetc: fix missing error code when pf->vf_state allocation fails
Date: Mon, 18 May 2026 11:05:28 +0800
Message-Id: <20260518030535.1057228-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518030535.1057228-1-wei.fang@nxp.com>
References: <20260518030535.1057228-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: 065c5d8c-d3ea-425d-e173-08deb489fd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	qf5DK7xb9kK/NluXocEyTHC8pE6DKb9xCDpsJToF1yAFEGOmGRuHzekq3BAON3oEipM4iHGTwLUEcN3uRoNaufTMzGfz5fkS1fycha1QV86sShyYUR1PINCrokZ18rWmlO0HNyC/L0QJq3/c0f6C1hTfI2U5Ee4GrHQRB0AJwIttZJAhvzr4VPsXDlxF2CvJ6nyyHoavHB83jH8X/mQcBvFuXxlM2ydXpUaz6NUJrbI8YtRNdem4clddtTh/iZH5nrVTWWQKFZIIzH8V4WrpjKRyJPA5dN3LD56OOmEX+Tsi+3n8CiyyzvtnEDhSycrIYuQBoeHsHhl+iR5ndX7oaaGkuKa8ZOGSA/NLv7AOqDNdbeV4cDa6ExRJE8o3e7mnwbf38XT8cgANLVA4O07x2v8qYMCO/e+IvqQRWV/t8TTTNVaUFKWuxRIkl1L8ndHldHuFP6dr2qbCEZNOgh4wItx9v/R+fEe6MIn8Yy7p5EIKq9rj2fERp4AWSauCEbePWrtJokvOewxXiyS60jRxvkogxc9oirnfKhZG/x+DBnflOfx+VJ77eZB18gfq5xuBdZD1mwmsl845Yfy+xM+SSxVwT2EqVzyW/tsj5pnqmpFRBMPAhOReDq9mtzGp5gcrhnr0VD8MFu8DjR6p3PgFbJuwqrwpVSHfUhPkFwJose4+5fZLQ6mi0i3Ssf8q0XOfi1BxtUWn3NmRZYrD1CxxwT5Hh7+TXmWrFY80IVf4jLORJ5wHImsUELNkrN57gPak
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZCbvmSqNzMGVk5sKLt1qbCtDIopr/HxKIKkiYi91RLukfk1OjtThDgt2Zgt?=
 =?us-ascii?Q?PEAamnLjnadGWitTl0AOwlx5sHKKZZPCxwAtCcDF0OeYGRBnP6fsbzjk/QT0?=
 =?us-ascii?Q?4wp4MtvcOa+lt3xalEQ6zKwkcLEkVQbhe/FLaRiYWlPypvkaITIVMgQM1WSh?=
 =?us-ascii?Q?tafwM0hmk+u1jyDxJb2voqU2z2fbnEA1kUUDMqDGCUZavQOYS8dYp/kBoS7g?=
 =?us-ascii?Q?e2vBPFBsLC7wy6jvO3qdHjkxnZQ2KOBEBhnh6apZeSN0oduUXp+1Gpn6nuPr?=
 =?us-ascii?Q?pYM0Ayi6S6V4kzrWDU700PiHTKIWj4Ab/0cE9shx1yu/dgdF+062z/TGo1W8?=
 =?us-ascii?Q?o2tnT3yVnbairX01W2G3JC6hZubICi6g4Urneiji+gOVNzs3PVIZphZDlsvB?=
 =?us-ascii?Q?PWJvf/GvGJaKA/3ifKze4X1RP7TdaxgIOCczmhPi+/a2MecD+SAeRNl3DgFD?=
 =?us-ascii?Q?D//EOWqavWR9i4SdDqk5jKAO3A0hCFPyYBVNzYFrXQyLg4V1qs3y0cFgK9u9?=
 =?us-ascii?Q?1VGLocxHgr1qLgvraZNh1anOL1g472pG/+lqxIzJllbFA+ssO4/e9gRTNjRU?=
 =?us-ascii?Q?HtCi3DZY6WQay3Ms2QMcjGPGUbPOSZL/Ut2NV+J4uNPhkCRd9umAbgq/ap3k?=
 =?us-ascii?Q?BcEfgMsqVochLhm1H6hOaJSa/N8846NbhvaLiYyI1dvRIOaiKGuxVSr9d5GN?=
 =?us-ascii?Q?K9q1BuNwIfl49kpSwHrGGbnUJvRa52yLOU24GodtBN434IkR+fYI5/TdPmQ/?=
 =?us-ascii?Q?re2Z2QSZsYj7kP2srVOKK6XJgB6i8riUJD3UrVEpDGX8dsuAwX7jTcLnd/YR?=
 =?us-ascii?Q?wUUFrNuAOyW2MCdaYgzQpsViiTlE1/jRnQtERYI5ec0C1ILd4ihXm34qZ3cD?=
 =?us-ascii?Q?iDpfGNJgZkA4XtGaM6c6gV4fOdGfbJOOGyCDS7TAYpHuBQDC4oPZzwODNUKP?=
 =?us-ascii?Q?bAxx5MHR60CZ5COu0tZUSeW26b4NfdLQVmmrOi2MACYOM4evxvTaAHOsKTVL?=
 =?us-ascii?Q?WK1S1FGwtMlf3sJAr/0ipotrwEug/DP4qRmsD52N/VKNfUY58EH9q8YyMErw?=
 =?us-ascii?Q?B8op9kDBVRYESE7cbkFB1Y+6eBqlbOCVvJA3t5uQz8hHiFYLYwK+6eDp4s34?=
 =?us-ascii?Q?EW3Kv727n/68gbxJrXDGIjC5wjkpj1WtWmkxIeiSPYTJDMXmBtQwlWrNFDJO?=
 =?us-ascii?Q?/eKkXemYVMHId+HxuZlXRV79pUaRqY4wu/HBVoQyPzOQ18+sr141fXca57Pz?=
 =?us-ascii?Q?XdcyAEzpkTIPDKNLb1H9Mz7QI4tMhJspo/fCe7zvAmRAs7+mYCaovznKW7Ik?=
 =?us-ascii?Q?cixfRHrFueua9Mt25nPmehhy9edHEhkFd3PD3ZrKHuypQ1UKmRVMuhl/BavN?=
 =?us-ascii?Q?1HobtnhY/DhPgCl/U/PHExy2w+/OwflHJkqRl8f7lz4StFhRI8q2Z3KXkj83?=
 =?us-ascii?Q?5SaKOvZLZtdy0DcB6hWNYeVkmtqKzCjrL33360DyO26YRpzqqr5uwBXK7p+3?=
 =?us-ascii?Q?qzfCmM+EIOzVI4pGYS0gOtt8DsMFc4XbJ9RWd2rag0g60+XSXIeLEG5rlhgk?=
 =?us-ascii?Q?Y3VT3e/59QHEjKPgW39E+kfbLtPOBo4x69fdM1wmMxNO0mupCO1slKFEsZwb?=
 =?us-ascii?Q?6kKCOEgkMGhFu2Tjrv0DWaHb9b/9hZI+P2aAI62MKmVN/J2ZAKOwUtZixqNu?=
 =?us-ascii?Q?wUr07wL7cLdu4sQH+887DlkkwwpS7YlnSUoJEHKrQxt/WSWKv0s7WXrHVJDW?=
 =?us-ascii?Q?+W0rkrlJvg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065c5d8c-d3ea-425d-e173-08deb489fd2a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:03:08.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdgUyzkUDkSqyu2x5pTCkGSZXpuUV/MqF30HkoGaz0Hk61kt7cLq83Okkx/NqOowKlvO2NnZW6KOiaLqIU6Qgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Rspamd-Queue-Id: 974AF565416
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288829-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In enetc_pf_probe(), when the memory allocation for pf->vf_state fails,
the code jumps to the error handling label but the variable 'err' is not
assigned an appropriate error code beforehand. This causes the function
to return 0 (success) on an allocation failure path, misleading the
caller into thinking the probe succeeded. So set err to -ENOMEM before
jumping to the error handling label when the allocation for pf->vf_state
returns NULL.

Fixes: e15c5506dd39 ("net: enetc: allocate vf_state during PF probes")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 27d4bb65e017..b743b6d33ccc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -962,8 +962,10 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	if (pf->total_vfs) {
 		pf->vf_state = kzalloc_objs(struct enetc_vf_state,
 					    pf->total_vfs);
-		if (!pf->vf_state)
+		if (!pf->vf_state) {
+			err = -ENOMEM;
 			goto err_alloc_vf_state;
+		}
 	}
 
 	err = enetc_setup_mac_addresses(node, pf);
-- 
2.34.1


