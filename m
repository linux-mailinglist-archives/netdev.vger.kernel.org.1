Return-Path: <netdev+bounces-120835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E095AFA1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F0F1C21FEE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22143153565;
	Thu, 22 Aug 2024 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="o1Qo4XIB"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2082.outbound.protection.outlook.com [40.107.117.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C171383A9;
	Thu, 22 Aug 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313020; cv=fail; b=fZnkj/SJSPC5Jtf2AnYXwo1BWhJEQeOs79C+JFT7ymzDWygI3EQPx39DK2tFvu6X7m/lM8zg7CSU8U+7SzAZbyBTciVAm53e5Ou3MY8pQJq+1JPvEiV3MgAe6ehM7e+hG1jIJW94QGMujO48hlz/pPcMEKelJtA9eJtcz89R3hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313020; c=relaxed/simple;
	bh=8N32QXjuS1bHU1FTGvCQ5oRSBZM/iety+WIfspiQ7c8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iqI6eVwR3wyrPyvX43D5whVigAcIaLL0XNSuQ2TIMuTbLJ4+zbKbIFkhXKaCU9d2zVyrtutMxKPyG0dcMGQvyxDIC9bTw4XLhURv7z+4GHRPyPlPjq6BVwF7zfFTOyndg+NHDXI5nbyOry5PfjGyRpu+lHkxFLfBKrEzmD3tIfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=o1Qo4XIB; arc=fail smtp.client-ip=40.107.117.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ds9qzr95y9INQgD3q2/2ugoLu6doE2R/YlHqnXP5MIO4PJ0xgAya1hQBlyu4PvWSjPk0EfXXax7o73hxl8Z+UwonAY+3YYTzM7jch0RQOpIqUOA+R4byShYILsyQr9eA4Z4tZlz35yMTqlMlQIOcV1R2RFdn1S4k6rgkdg3Qui6VcX7U+YaJI5wUTu/sMTY1IKrK4uBDSXR8KBp78AZfeCrsvMW3T/QZA1q9koCWoBsDAC/ZNMCvEDe/+i8JSBdupLf7GVqnKROqzUz88QHLH034THiL2vQ/t0bRdysF5TT0kJw9pyOCdCU8m2yTO2OtZ1bXNzZCY2oQOI8HbcLmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgcsd90J+uXpbttlr3kYPfjzD1OtV4L4QqzfeIt0O1Y=;
 b=kIsc+ZmOiP8t2Pr6fWv2XVH3hcuR8TSLhDjvbBo2zvR4mqNK09sBklJIABiEPmtGnfcpgR7p8OrKmKukUWIdgzKDEPBlgoUM9f4N1p9U4m6DBJgXiseiET9BBUgoPV4OfGGfKBFhMVShOn5hFHwAXv1q3FNdSSGZuGWgiamQPqlkZv6lGMwWAalWLX0uNFlCCBB2mlzqcmTARY2lpBUN2uzNbfUkoY9AFwDdXV7PLKSMxdnUbbD4xya2b54w2Kubr0Tf+qaiBybo+lSha3nJkUYyUopg0DVy2XR8hrUmG56CYSVoqUz1/IFHgvnKcD9jwjyoxVQ55dicGhLBCLxDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgcsd90J+uXpbttlr3kYPfjzD1OtV4L4QqzfeIt0O1Y=;
 b=o1Qo4XIB2qxGtHDlxCO8/eKdRFoLy2KiEpfJ6Qbmik4QT3bxttzoDBnrm65Ya7I3m2TMCFYXMY47MFMtph8d5JVX9I5BRpwpaIei7VTwHfyiW7jxnRJM8ToS6jKBTNjlqpmZLnFf/lIzaT6jWHddJGtgaMMWEcbmIauo12pFYCRPJ/QehqQd8mLB4y2cCskZf8u1fA4YYEEJjcZv4gJpFIpksbeFt1o13dhibv5p7JGp5kR7XHlFZpH73U000jZ9AqgxKYNT2QsOP99dRYqYgHoUJO5uYxkfpKGtkFXDMWCZ1MXQ0VIhGkWYSJpak3gLMJK9t16zIeBGdxf7WM62Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TY0PR06MB5777.apcprd06.prod.outlook.com (2603:1096:400:270::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 07:50:13 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 07:50:13 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Chris Snook <chris.snook@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yang Ruibin <11162571@vivo.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] drivers:atlx:Use max macro
Date: Thu, 22 Aug 2024 15:50:04 +0800
Message-Id: <20240822075004.1367899-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::19) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TY0PR06MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: f52fe461-dc84-401e-9ff3-08dcc27f0e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iEYQ5w8lGj1GipArMuAfdBIPM2dfmvDaenX6OYqIU36r2BSOoWiM41eal2An?=
 =?us-ascii?Q?pAah1kxl6y1M/ZSS+ohv1+eX/5zmgtbi1hS5Of7uhphVl8FY08P3OCMU1vcO?=
 =?us-ascii?Q?obtetq/alsLIZZYtaVP1+2s8dxDinPFOhdqCwJlCR8UDk0nvsPpO6GRIxQf9?=
 =?us-ascii?Q?7aujTg/0u4lMyGLSIOh7Ngzr4CcwRp22LkfJIHPzCL980Fx+3YMdkQRV3cvK?=
 =?us-ascii?Q?akgb4xfBnNJV0KfaFcgds1CFj2RXgMXqjta8VhVbgflMacCkvW/G9T/RlDaQ?=
 =?us-ascii?Q?rGUaIjfC1YtpD4Au/3o/cPHi+oMMYnlDgG2WL1bmxfBLPOo5osGjjvWXltuk?=
 =?us-ascii?Q?5ui2cro8aiMKygdWtvVL2n90+jaKR3mId+jYkTFMFyofUR0zGTet64PTqzzZ?=
 =?us-ascii?Q?UApJmQ07oZXUZt6xD78fXGw0LBVDTu/HmTlcLwrAuJ6EEHvRmaXnTvVf+8I5?=
 =?us-ascii?Q?uku34LI3JNL+TNWJTJm4hBNQEnsD1f90DtTP93Wc4yt9n1S3Kiga0GIfYc7u?=
 =?us-ascii?Q?kO/0rETpk4N6Rf4LrOlg5wLBlNaNGfF0kg2MLHGcam+F9DiQ0fgOBTx2mQc6?=
 =?us-ascii?Q?AWdpBbr7A4FJdUt3G/Gnb7vVVnmtxR79cVoMG+pXGGLenntwbP3Uj+u+bE3l?=
 =?us-ascii?Q?JUeBNPC9FAYW5WSAAGW8rtk/7UMRMwcPAE+GuJDhDUPe+rm7PH2xzjDLLoR2?=
 =?us-ascii?Q?LiDyHaUupTSpRItZ0XkpMKW+RJ9+Ogz6R4Z4sRvrf/HxaSh29ywEg4N7vxdS?=
 =?us-ascii?Q?yql+p8NOOowbDqZqodNMdgmoePZMW22M/bEYhtjKNq7rS8JSEAEeBhxfowBr?=
 =?us-ascii?Q?j11RB+e3mznCTVQXq+ly71f3H6gtB8hxrz7iDJ6Az75hYL/9EGUPYHYUCdAs?=
 =?us-ascii?Q?aB5jkUXcEd1tbLWbgWjUlHIDuZeVHH9YlXDrVanhexiTC4tCtAG+OKkMoUEU?=
 =?us-ascii?Q?WVYx1ASH6CCfaa9I42Ayg3r1LZJrau5wtSYKMhLbKWTnDYfBkOuWxSb6FK2D?=
 =?us-ascii?Q?TdowyxZwX68NQ9MQsMR7JohczmojTNsm1DBfZNxwZ/yyqFUkZtlM+ufXFwPU?=
 =?us-ascii?Q?afvXQdIJ/pF+FQSvkYj+/YrohIa6JscIobcNfm3i0L4hEcwJVfib7tu73saO?=
 =?us-ascii?Q?aLFMwS+BZ7ZMyCgIfgzsi36+gX90ZcP8N5tX8CYRX4qGfrKwqFJnCl32rask?=
 =?us-ascii?Q?ABvFBB2nSIzLApzBZDVWbi6Wc/dRF73AgIvpThsSUhU0Pr4pG6rQ4eYDt8C2?=
 =?us-ascii?Q?u8ZcVsWbUV9duqRDqoZCkzbG/YwLBpcRfFrMoPENvqV7zSxgXcuQ4ZS6pHUh?=
 =?us-ascii?Q?RxZq+eQjsEDi3DST2XyEq707OicmweRwdgCWlFo1LgN8R6Mq7LwYWjrzplqB?=
 =?us-ascii?Q?Plabp1QByTEuzmtojty9n/z8rA6AAHjBTChN1i/UFaiZC+P5BA/tQk1B4cx3?=
 =?us-ascii?Q?6jcx9JOwHbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kyWxFYykpgjEBwPUgpQpSQn9In3cjm/m89+/sJ9fG3qNVcMvdUnzkGNtXKcf?=
 =?us-ascii?Q?j/rvqcsi/lTXEcNp6VgauGwSvPFUGPB/jsOMGJ6VHvDUx0e0FJpe1mJGyrvi?=
 =?us-ascii?Q?iVVXQJpIiTYTkX5ccfqny451K6oKnBET43H0PYTLc82G8AhME8qY1+Bn796b?=
 =?us-ascii?Q?H6BcYSFvlILj6qAgnz9uleCsOmLLnh7Q4mm15t5uF5lqZhXcpAWG+LYXfxMV?=
 =?us-ascii?Q?eLXRGQaSUegOsZWm2W68nczImz4iEDiOYhVp8Iw+aLV0m2FqEW0SCuu5r++z?=
 =?us-ascii?Q?LJLMrJtKNbvYPZx2dV3/Ad5pUrIC/Cu7zLiIKVWR8oUTGE3K/k7Qs/wC5J5S?=
 =?us-ascii?Q?ZodXIzYxnnnvL3z+EHV2jjwTMFvFLtdZuA0j0M0TD//mT5eJ2VNHR8UdM8ft?=
 =?us-ascii?Q?vIVg/x+TcBl9UqNHCA8MSrZ4CZVcn2bRaqEyNRkpo0IpbaGosh37K8BYJeRJ?=
 =?us-ascii?Q?XIbzJ8XjDKBbw9wqVmSdRKgroVGFSE4EpVIxPDlnS/89xKLE6prmDUWUhTn2?=
 =?us-ascii?Q?Ml7ChfLhSAgBQ7F4+lH1dLpb4VOgrsMZ1w6Y+ato90+Tn5vHImdYyo9J4ilu?=
 =?us-ascii?Q?ElBZKgnca/ypPrrX4iyanVpXDV15U2NbIULv4yh6MMgR0SSmvWwaN11JWtva?=
 =?us-ascii?Q?EcviZwmG3VrOZrTZJtN9F9vnnC01I2XNuJW/O7dA/ohsh+eh38lD3BSbnWYM?=
 =?us-ascii?Q?z+7VB5cCdyJ+Hu04mITzash3KjfghmrIMgvM2NIe7SBtxcLgO+NG0NHauw5H?=
 =?us-ascii?Q?ngZtFCqorHh5pmkFjW3V1hllxK5iQD6qGYgsXzo1T8BOUjdGsY9GM8u5DzNY?=
 =?us-ascii?Q?1yux57ax7xXOb4Iv+rH+DEeQXbbwLT6ts+kAKOBefMtPJTNu+X7RASCn2jIY?=
 =?us-ascii?Q?5HFsX+dm3+z08/5+HJc4eoL9eTi2lUTE6sMqch5idku4OZrakerpYX9OD0M/?=
 =?us-ascii?Q?azcYAOqSIpeIbq8YO778A30sudra/nQ3wNOXe01OEAL6UCRhEZzXNH18DA+B?=
 =?us-ascii?Q?4Z8XRrPiL85Tn6QPwFvbKnpyukp5Il+RLGDZ6iwYOsMkw4OMcTPQmWtC4Chb?=
 =?us-ascii?Q?PIXf3bRV7rAru/vFBh5NWJE2Zy2aro6tc4F2iVy/GmQkn69czFGhEh6gDx/T?=
 =?us-ascii?Q?3UNRMDJpeemKSJ3aM4gqlELaJSvLxuxOl+jLNNftDlv3yDFfz6zdl3W6Eepv?=
 =?us-ascii?Q?D6wdtlBjYPr3DskCDh/FjLFZr6n3aosjzqQ0RWXTA2NZtsJsyWZa7HdfhDKi?=
 =?us-ascii?Q?rMPimbtbts6jEPTgLR2t0GlZFCqeAt2MWvoMjnyu3qNwBwqn+Vha5LqwroVC?=
 =?us-ascii?Q?89yMc1O7cA+NGvWT0KaZYJRrN72LOrBpXRuUnE+DdiJzlfbyjazOArKSvN/n?=
 =?us-ascii?Q?XR7oA3YY/Frr2dfeQHPHloobvCMagGqKOVJx6i3hLKhqpvvoaJCrqQPU2Bok?=
 =?us-ascii?Q?8VSPRBicSjembCeodmnI9cUzan1sDF9/Vqg7nwAqaUjYIiyGq4pfhn/7dMDJ?=
 =?us-ascii?Q?XLRRgAcmRa/nTGt2qVQW9vt25nsmjc1epa2GrW+EbDWh8wnOSetiHzIz8ugK?=
 =?us-ascii?Q?iGDXivHG1/68rMwiT1N3JGQWNf68rYzhlPyLNH32?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52fe461-dc84-401e-9ff3-08dcc27f0e04
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 07:50:13.8151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2fwxEWPzvto1eOU6S+4VTTWai8ukcbpszaXa++tG5iTYrodWWii1BAbabnkdF8cHoclYhavp+b+5d5pKAUVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5777

Instead of using the max() implementation of
the ternary operator, use real macros.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/net/ethernet/atheros/atlx/atl2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index fa9a4919f..3ff669e72 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -2971,10 +2971,7 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 #endif
 	/* init RXD Flow control value */
 	adapter->hw.fc_rxd_hi = (adapter->rxd_ring_size / 8) * 7;
-	adapter->hw.fc_rxd_lo = (ATL2_MIN_RXD_COUNT / 8) >
-		(adapter->rxd_ring_size / 12) ? (ATL2_MIN_RXD_COUNT / 8) :
-		(adapter->rxd_ring_size / 12);
-
+	adapter->hw.fc_rxd_lo = max(ATL2_MIN_RXD_COUNT / 8, adapter->rxd_ring_size / 12);
 	/* Interrupt Moderate Timer */
 	opt.type = range_option;
 	opt.name = "Interrupt Moderate Timer";
-- 
2.34.1


