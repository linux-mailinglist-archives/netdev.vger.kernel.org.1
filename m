Return-Path: <netdev+bounces-122756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7035962713
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E973A1C22FCA
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B2175D32;
	Wed, 28 Aug 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EFiAYyAp"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2065.outbound.protection.outlook.com [40.107.117.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8165E16A95E;
	Wed, 28 Aug 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848024; cv=fail; b=eCu6KtSx6FxOCgJ6ZM9EME1cUL0Y0UFoVO3oLbePjhZNw0eyGYDAyJa2IWb84oEaRVBb40rPpe6F49p32LCDjCzH/9VgNlO+Gsb4xWXhkL7MrQqVQ9PY+4l08fQQGp9BEpmcgNF1gnRKtIhyvBTH7FITBD1WbiWgKiTf1oaUs3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848024; c=relaxed/simple;
	bh=J+LNbKg5iIWPe6j5ETll9fXopLOsGGRtBFsgdgIc6QM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h3ur+qlLYpO/KERYGIjc0NLfGQCG259BtbBdw/ew3DA+1SBhEFveI4fyS/VGNGl+bsoDeT3JzTPjC7Baj8cn2CvpJ9PhkxjtF1//dQrXG2e1QUdPUvKQu5QYGFi4ves5SrWw3mGGmECErQWFPhWUNH/DZ/Jb4i/3HSp/RG5E0AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EFiAYyAp; arc=fail smtp.client-ip=40.107.117.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDbrdnRfl4gozj7sGBpoId4fqSMtAHdIrCFohcQW1hzAJgpivcAVxjHGHOkhIRmRTnPl4OqVwhwtm5SK4dGxCxAdlu+lsJqQ43rcTzVxGnJoY5E62ae4SjIK82T0YaRCUXBS1zJKqNaMDgpeJDOqAl2MoiQA62mYR2MpXl1x05bSX4QkWtaRU3VpXUU25V6h8K8cT5867ICDGRmE3Ks7Pt6Ss9cG423CPFGDQuHlnWzVbHyVCavXeghxTqZk41jxsxB0u2YY0/D0j9ToEr7y2aMIu5OehM0ItevBzCGDiVQJ+hNmGPfuUbFAB3KJwX6O4otYTPBH0LUgivtDHKkcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oykKYuNrzQg+Irx9h0AYaHUtKpflQMaiKq0nCUV0X+Y=;
 b=lXLW3b8zSR7RO0HHW7UDp+Rvb8IZuZtRNUf0Fc1aGdA/AiKo2+xP9tXTdmQTYdRrJdtvmaG23oSXDCBpTQpcxcKoYtgNGJwshVUxjmcuA+9aMXsOVc8lepEY4Jj0Sl8+51dwfeQg21XjLBROMKe1o99WeRwFHqwiiHIpMzpMu1BBo7vMYFgQzMiZHTjjAma35h0Qr9h9StOkpgIhsN3eqk6p7tLpXPwJ+Ch/QTNRV05IYcea430AMmClm/4ldJ0Zkj0DAW1IOcB9unTnZiTID1Byzf5vGzWew6Pqk+WyO29WiwM9zBJncWa2thzjvWRYQpBMWgGv+FPM++5jdXkMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oykKYuNrzQg+Irx9h0AYaHUtKpflQMaiKq0nCUV0X+Y=;
 b=EFiAYyApAKCi2QFUhCO4a4DxYODvxIVgHKaxTaHpX9r9ViM4gCgtk3TZ7Rk0b66IDtlKdPE2GRrAwtQUhRptBiKLBh5f9hXsXxeuP16oo0hrjcoH0GRYHPRvTWrq4NtyPxmslXooVn96CONXB053Fkay+hpOIxB2Bd+VWSIxDQZnevHVLVdiiRAQuZewhhwGRzj1g0ti1hu+uVc1yCenhj0lWUA6hsEwVnV+q5TGkLIFRHsP1bzsNrnvz2wSdaxYlbvjh281j5dTA3oTdk8HcHD2cM47uupCGvgX7fmxGlnsdwQPx02oVfdeuWRUabH53AF4o0j7vZwDv++h4bQ3XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TY0PR06MB5625.apcprd06.prod.outlook.com (2603:1096:400:32d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 12:26:59 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 12:26:59 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] net: alacritech: Switch to use dev_err_probe()
Date: Wed, 28 Aug 2024 20:26:49 +0800
Message-Id: <20240828122650.1324246-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:405:2::26) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TY0PR06MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c62b03-cfd2-4067-5804-08dcc75cb6ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FRpjn+98pes9QdNI3tNvcVhPAu4zcFHBsf99CmdOdqRFJhxJPyi1VjQb5dyZ?=
 =?us-ascii?Q?GWYLotpjW93ohlI3QZ3j9aoM+spiXD9hS8tSI7GFT+o7pbFigUvg8PxerC5T?=
 =?us-ascii?Q?dm9+y37aot2Qk+14RBW13hZyNF86oPgjCfiAkZalfdfg1hClpZNV8hRa6Edb?=
 =?us-ascii?Q?17LBt2CQInIQOHxHSvPJScOxMEdFdTD1oLdpalcbkC5NVnhq/0YQRf00izjI?=
 =?us-ascii?Q?hV8CBQEZV518PezdMA0CTCOPj2+JZuvcJwzhoMj6UY/BcdMeys48sJ/sBCrC?=
 =?us-ascii?Q?PfGRQKvyFl28bhga15yTDabYmsYl/m0pGgwvV08+6hc/EaQCFJgzdVLePRJL?=
 =?us-ascii?Q?PRqkv7iB6o7P9OX60YRa1oU+nP9PswXAK7HSh/wWlNrk0ZVzG7s7xIkNfeO8?=
 =?us-ascii?Q?r9YLrXhCicXkkuuVtNJBIMVWZLr0RsFPsE1RbD18QDEgeYq6by3roVHHsRG+?=
 =?us-ascii?Q?aytngXuvkCS82A+jnlgk8JMdMphekiaGUPzYt2x21aBDm074aXITDqGeW1H3?=
 =?us-ascii?Q?PyFUKrtqeXKiVF2YkcMu1ya0qu6s2wnjC7u/N65RTtxVtJZum8QslJ+tz2Hf?=
 =?us-ascii?Q?jF9yzuBG2RO6Dl0SqaiyBAgKLz0p1/JFIu/MXuKMMcyUsQI+8Kf/2hIji54w?=
 =?us-ascii?Q?ZZTBunOwoWOwDzDUx79ajCEPw1/lzJsdLwmrwTAN9y6LddrLtoMDcsIY4+Ct?=
 =?us-ascii?Q?D8dq7T8TEAmMGyXCGeYXF3T9yODh9lJ3C+07gVi8vBx4E2ZK3Ai3ni0VV/aI?=
 =?us-ascii?Q?Zm8AipU+kvsSVvVEFnTe1EWF5gRsqjNTRGhT43e6BaAnA5S6lrwCTOjuysRz?=
 =?us-ascii?Q?S3tuKNen6fNdNZXzJoHP/FdSZE/mzZOE/tfNAPcdLoFVVILbZf11puI1kCxH?=
 =?us-ascii?Q?PWfnG2O8t57Sku1d1Lm+j+bmcaw2TTGho8+s/3MIReqVs0s3hfvVXf33LDxs?=
 =?us-ascii?Q?J1LHHh82fGxcSfSZsIK7iWjSPuT9ok/PDmbz6TkNlkk9VHLMhH397sRsAdOB?=
 =?us-ascii?Q?SKfESQwGu7KBMKRewpWiRQnUU6UHwFEDCd0q49lW3dHv/uH4QYPW/RgnARfE?=
 =?us-ascii?Q?ea5KNGpMLl0o5VQ1hixjHylVfWPv3XDibRt1brdGDQapIZNOdneNeuAwyVz/?=
 =?us-ascii?Q?iehDqOKoC+VJ2SUxwuzYcUbz0EYBam+ZpCNLbGKw4kvex0AWvyayEEWiKjRX?=
 =?us-ascii?Q?7C0m3txUqMXnNd/jZE8aFQyNJ60/kKZrgKJpcrttzwvN8W0iBGsTVDsoHzZg?=
 =?us-ascii?Q?R8Ha7o7eS1yNIz1gi67VHGPmZ9UoFp0vRV8+NxA2LD8Q80fe9kPiQLgfDIWR?=
 =?us-ascii?Q?VozlkoH9ze0pm8rQT/SIiAyY6Hc5wSoeCHtLfb8MOkxeIl46Kfovv1sgaNTH?=
 =?us-ascii?Q?duBIElBirKWC/w4dT7RFMx0o7LJqqQr70TeayZQOds+gbwEqZYD7ZJuW8V3N?=
 =?us-ascii?Q?8LLWe0v69+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rFjlKygbEx/NhNGg2y/z/k8VO2TQ/2STSG3ZddMR9GJZzsEfj3sOB4jofbvF?=
 =?us-ascii?Q?yh/24ehfoeVwC07z5wRvM1qO+usxoYkr/2ahwVFI2kbZfyXotGZE6mARXm0S?=
 =?us-ascii?Q?Qd7ZLdh38UhGxn3bFvdTdGe+R5iNMzbh61YpjG9Qfq8OlRaf+1Jh7QWhwBH5?=
 =?us-ascii?Q?LH1XpXonuand8IUHo4OxMaLcXTrMbjWxgLsEZraA0zeHyGdwyPnGYlOJtIRv?=
 =?us-ascii?Q?N42lOWTd6URufei1nzZmwhT4RcevxgC1OXnGR/OKzDlhWboZpUSi/25Bazm1?=
 =?us-ascii?Q?xKIc0gky6Cs3aJztXm4U3dUeUfaL9VbWRZpvB8RKs7QF93eFp6N8NxjgPeW/?=
 =?us-ascii?Q?DBagC5AQQMEfDPz1t2Dyhf0hkQUG12060wuhiXlB19ooLHUPtc1/MKrRiEsD?=
 =?us-ascii?Q?kQTSW+/9LdyxFxW6fdWUCJ6jV2MMnkhmCv9e4LO01qif/t/hAQ4ITjCUKM2j?=
 =?us-ascii?Q?EijhYSO/9uggDCmjtSUtxaqzqpxVYWz5mzSyjlm6K0mYtCUovJ0UHA1cHS0C?=
 =?us-ascii?Q?lyssP4j/MVjaIWF1DIRw+7FfAzhsQ38/j8sup//uda+l+SQ6KiiCnLSYjwHT?=
 =?us-ascii?Q?JJ7qN9IosVQAKYIdELcs4yxjs5y5mssdmdwWZ+5dvEKxC4iDe+/n3fsZNGvd?=
 =?us-ascii?Q?DFUrLvbXBM5PZ2w9sVOejQOR5rnFP4KWL7MyKI3wHThlnj/Ym2yeN/HpiApB?=
 =?us-ascii?Q?SrCZ4xduc50pnrwB/WulKPtWFunQFZspCUk3kJtPddbhhKYqOFkLSJFTPKeY?=
 =?us-ascii?Q?GddEIvTcp4xIRnrgOVZijMpxHcyE1IvoqmEr+GeIKQUD04H/1FKBEJNtXh9P?=
 =?us-ascii?Q?TjQltr1qsOwDco1FyWMBDZRl3jFgfHlawrNpx1AH4kJ/nZ1gRj6bDpUMdfr7?=
 =?us-ascii?Q?3XDNOwLapNJAFZ2/Fce9m0fEESFKLoQipZFtCUgk6pFnvZ7+m5h4R6USNBEN?=
 =?us-ascii?Q?t1kZEITKVON1mAzcyxh+OQaQs25ruwob/U4pzlU4L0cecGHi2ivr9M9r4F+o?=
 =?us-ascii?Q?lKcc3LzfXbAQD5H3JO5sK1eaXMG8VFXjopjFRbzKVhvuhJjPJoyxKMxejFXZ?=
 =?us-ascii?Q?qHIMHfImNaC3xryHizntZAEDvlNUgA25u/PivRopV8bP99JaKd6CPn+zq8/S?=
 =?us-ascii?Q?UvxKwpWni0IJ1vmQLw7Jen+bLOuec4wsekPoBcSbJrDeihYFw8Lww6XfOFsd?=
 =?us-ascii?Q?lSU5CYkfE78Adg0dSdA/Uzsw4/mQwA3WExXbqxEoUr6S0GR5JO/GmXd87lPj?=
 =?us-ascii?Q?+LlJCJpTvZu0resxAnyRJE6YEFTABkw6AMEU/gZewA6z7EBEZ8Qg/DrPdIfi?=
 =?us-ascii?Q?ZwObpov4SoRTlCQvFVe0oXa2VWo+tIAeDZJIo+SaoLMrlHqWUyfNg7lno35W?=
 =?us-ascii?Q?vJ0IyTC19RCX0s9iunHr23QqLRbzSEccAb225dTpdNtiBP6aJeOdK5JoIwce?=
 =?us-ascii?Q?7OJC1ZVM0gF5aEm+5qI40ffbPVIqhw1IfCMaDK+dsaFtEq8tgcXvUl9ln097?=
 =?us-ascii?Q?lw5miFRWbZ0F0jQcWGpwAuOzEJfhJZBivlIzEgrhUUvgOhWOQlgJ9XbApdv9?=
 =?us-ascii?Q?vThhRiL1M/XkHAqHu40nYxirLZDycmfw8IfJ1EDm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c62b03-cfd2-4067-5804-08dcc75cb6ba
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 12:26:59.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6EyA7+S2E9a1TKA7olRffyekx8tg0mDJZBnPVEXhCQPE22NksdbUSipDjSNP3UIS2reuDMmqArINiZad38B+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5625

use dev_err_probe() instead of dev_err() to simplify the error path and
standardize the format of the error code.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/net/ethernet/alacritech/slicoss.c | 34 ++++++++++-------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index 78231c852..65919ace0 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -1051,11 +1051,9 @@ static int slic_load_rcvseq_firmware(struct slic_device *sdev)
 	file = (sdev->model == SLIC_MODEL_OASIS) ?  SLIC_RCV_FIRMWARE_OASIS :
 						    SLIC_RCV_FIRMWARE_MOJAVE;
 	err = request_firmware(&fw, file, &sdev->pdev->dev);
-	if (err) {
-		dev_err(&sdev->pdev->dev,
+	if (err)
+		return dev_err_probe(&sdev->pdev->dev, err,
 			"failed to load receive sequencer firmware %s\n", file);
-		return err;
-	}
 	/* Do an initial sanity check concerning firmware size now. A further
 	 * check follows below.
 	 */
@@ -1126,10 +1124,9 @@ static int slic_load_firmware(struct slic_device *sdev)
 	file = (sdev->model == SLIC_MODEL_OASIS) ?  SLIC_FIRMWARE_OASIS :
 						    SLIC_FIRMWARE_MOJAVE;
 	err = request_firmware(&fw, file, &sdev->pdev->dev);
-	if (err) {
-		dev_err(&sdev->pdev->dev, "failed to load firmware %s\n", file);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&sdev->pdev->dev, err,
+				"failed to load firmware %s\n", file);
 	/* Do an initial sanity check concerning firmware size now. A further
 	 * check follows below.
 	 */
@@ -1678,17 +1675,15 @@ static int slic_init(struct slic_device *sdev)
 	slic_card_reset(sdev);
 
 	err = slic_load_firmware(sdev);
-	if (err) {
-		dev_err(&sdev->pdev->dev, "failed to load firmware\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&sdev->pdev->dev, err,
+			"failed to load firmware\n");
 
 	/* we need the shared memory to read EEPROM so set it up temporarily */
 	err = slic_init_shmem(sdev);
-	if (err) {
-		dev_err(&sdev->pdev->dev, "failed to init shared memory\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&sdev->pdev->dev, err,
+			"failed to init shared memory\n");
 
 	err = slic_read_eeprom(sdev);
 	if (err) {
@@ -1741,10 +1736,9 @@ static int slic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int err;
 
 	err = pci_enable_device(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable PCI device\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&pdev->dev, err,
+			"failed to enable PCI device\n");
 
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
-- 
2.34.1


