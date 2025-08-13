Return-Path: <netdev+bounces-213286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12715B24649
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8958A1B60982
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8032212565;
	Wed, 13 Aug 2025 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TAyC9li1"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013013.outbound.protection.outlook.com [40.107.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0E212562;
	Wed, 13 Aug 2025 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078638; cv=fail; b=JKpz2r4VgIDZp9e2SXPGgmtQMidm6DOiUf9qenZiWv8oiIkcMC/IW9R6CiO8CT0pVyiJcHXXUrxhZAvmZPU514dR+rqtFVn+5r7mEfJRIh7rfvo4wD9KUgXMgQ3gHW5NAQ5DlwxFmh3NhWwaWvBoiNd4YIRqYNpbGNBZHaBfrWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078638; c=relaxed/simple;
	bh=hCkOOGFAC+c9MKXbik8CjTzpjOvb3miTeuzm8dDHy9c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LIcRdccqj7kxR61NvLUETSFZd4oQvDpdmqWeXbq4E9y8nWRW1ky6k7Cj59J3B6LbDFvvE+u7OMxsunKXaFQFO0JMueMoB472YkY1+EvlVSchg5qpj6R6TvCn7L4YMe8G72UvlE3OLvSztWCdFNiZQcDLd2TWhJu2vb2xraZghmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TAyC9li1; arc=fail smtp.client-ip=40.107.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJcLikOtndidVIBn2i49/foxNPUjGsQdf3+UbzRMFfi7Qfk6WoHyPd5DdvzAXO8HTrhxd95E0nF8Kshr3F3mzMweTiYMCxPvfViMuv8nJ2u635TLS6r43I2b3t3ExlMEVp1sD9oVk9WhRn1Ly6/ur2IpHS0n0JJQwa0EKdWTl+0Zmthi11wBcPcWFQSmbRxXbpPhZ+VOTyQ8w11SeLWJqzcLd/pn22kK6ORld3E6JYoLGhJ3HA04HC4T6vDc4jQFwULqGhs0jYahM3lA8JNevda3X+ovBIT3fWDk7OPF3eUx7ZVPd3PpCcWMGhFrH+wuEKtlI43o05WZ+KMvwDBsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvmLUWVjZDS/9QGfjAjsS6gLNbYh+Q4L6ASgTHSGEA8=;
 b=kKldv4WTMp+toj+dxBe+Tia/nevzhmaruT6C6XeK/oSR/ugyayq5s864nOJsE1hyFucgW0QMJB3wNexfP34xzVFIijoAIrLnKMapt9zZ1IY0wRLf0DxZXgAZ44+bW3Xnl7bClnGD5XJ6wmTZn+eFX5N0NjoPLbB9Rki4Md5KrjukssVOVjHrnCRSArFQpjVBXpWwcI6fGG9k0hd14tGfm1tFucbJrnwesCcOgra5Oo7X2HqXTbSS5OuZV64t41pV/dx8c9OguXcYr5Fwjl2t9T1LWC2+PaT55aKU8DZAbEpKJGAaKNpGNC9GA10v+1vjia7alim7bWShoE+r6zDfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvmLUWVjZDS/9QGfjAjsS6gLNbYh+Q4L6ASgTHSGEA8=;
 b=TAyC9li1wbaizxbjZ6PTkabvqC/ueVcaXZxCgbNxPCmcta+/g5dF1qFgXE57YLBZRCrLZ67PlIGMIkhn9VL8w/JsLfVRZCaP+HH14tx/JHpFAuGMmqoGDWUSSZx1k9ZX8Ph8FXBNuURR66aN23lQRDxmex9NJd5NgEKMwohBNIMOwTB/QjzLLKjlfvtqo4zej4DKHbyC/XjuosMyYXOHukoE17+pFEOvpsmFdEHGvK5i/a0ZWYC3vhYscEj1EyTxNkzYqm04uoCZF65sPaY0s/j9ZjtP3r1CKplv462om2KNk9IPHSgYAIl6zEXkSl2xnxBWKWTrPLHGgKggnLdqzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEZPR06MB6927.apcprd06.prod.outlook.com (2603:1096:101:1ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 09:50:34 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:50:34 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] ptp: ptp_clockmatrix: Remove redundant semicolons
Date: Wed, 13 Aug 2025 17:50:24 +0800
Message-Id: <20250813095024.559085-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0312.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::19) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEZPR06MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b015569-c83e-4ae4-bc1d-08ddda4ed8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XdBvrQEl/A9+yb6hOSR1K1MByNfe394BXctt8C1Ph1IxATHBlBXWGqq58RvT?=
 =?us-ascii?Q?Bzyxcwx25V3vv7PSHfpM+J8wKEw7gglFBL+w1yUGeoYi6XG7b0kM3VFb/RRT?=
 =?us-ascii?Q?CAmRvRBskviNqLNhh+fLTv5Bjd81LcdQioI9017YWH8Ub9tj5fCMN5kR1jUV?=
 =?us-ascii?Q?/A32KncXwugm1f0agsqV5QavV6ufUb4rMFABmn1IW2ZkJ/50YDLkSGOTXz2R?=
 =?us-ascii?Q?m+72ZIWxb9yTspXYWqcwOf2QEuGYJl+lHtlUkW8ZG7A+7F5en9z/BmYdpevA?=
 =?us-ascii?Q?yb4+JHzcldzZbLgotF18n8FL0Z95tNVvnbBoD/XWEVtzCfeDNsdR5morb1m9?=
 =?us-ascii?Q?SFKvYtoCcDQOHAjhRw/dz2QpYSBY+EHlrHgIDyajRXdsmO4iBgHQZE7X7cH0?=
 =?us-ascii?Q?tmIBJRTz9WPsnODKUJYQ8mC+/ACq1ZX33W+/Wr899bAHu1KYR/30C1SO/pyp?=
 =?us-ascii?Q?J648QAT/VZ4309Ne+QbSg0Fyru3cBi+gC3jjoUDymZTxbtzIV5H4oSqsW33f?=
 =?us-ascii?Q?xN2AgfahIU9c1XkYocOCaZpwtndiIUecS8OxEwXDvmooZy6s4OGb1LZwVImT?=
 =?us-ascii?Q?GEsHYKtupGJwa5f8Q5p1Domw7ydOKrd/X+77B0XXEgNeI7DOuTvXuFaHX3cD?=
 =?us-ascii?Q?z8TDTdxxBtiYUq/1559jZbIWL+mL3UpJeNTKfw04O+/nSlx/CJcVQ+v10o4w?=
 =?us-ascii?Q?l5LWtMjrKDdR/yuQ+M5OfmYpsyuUTiYdZPwI78iMH1ANnujBAbBkxFLi+1Xo?=
 =?us-ascii?Q?8uvFhQtuDgu/8bfmT4tdIBxroLdwcYCnhYVFHCldHdAEftXlb75E+aspPLcP?=
 =?us-ascii?Q?7/Mmr8Eux2IdjASdKLNOjycu6ylRROmitKrssj6xc5qX06lT0L9xlx9IXQxR?=
 =?us-ascii?Q?p+kaIj5gc4GnhOM5lRNcWuavcKthrNiNTowRmitLSyqESM+b6Qa74U8sGizG?=
 =?us-ascii?Q?Nft6VfU+DDDKHY58tXhB7jntdsAIoZinqfXnkY18k/F1qmQ9AkCECScXu7yS?=
 =?us-ascii?Q?COz/v3415TsHuey8Jc2EQV9MOSDFjZXde5hVvgI9cBv9Y6wb+madgZ/mPdXP?=
 =?us-ascii?Q?U/bd/SbiGiUDvRFyivgXkwuCPowH6IPh1UwCoLg85V6wznzn1QH3PWB0oDWj?=
 =?us-ascii?Q?9MJ1ts/oYZBeOkb5LI3Rqh5y8fMEioEdDZqLNASuDCBL7pIRDWkaI7qoan75?=
 =?us-ascii?Q?ref1LF84LEabNLxLSaqqZIG1x7VVAReY3oU0kIVgrTDEUEiIXOEI5R9neXvl?=
 =?us-ascii?Q?+2Rq+MtEYwjwr585qkJBeP0P1ZuiO2zpTlE6zu5cEeV9w4mVfld0pUoSDCeq?=
 =?us-ascii?Q?x8FMnJI/u5yRsHwgmReRmTG2NlRio+ipod0uOReUCtCptvDMhRzePkuYF0Jd?=
 =?us-ascii?Q?E6hA1NV7OryVFxBCuy83C283E5wcXDIqKM86l9n3qzBwt9Xrz0tRfzn3Ceae?=
 =?us-ascii?Q?vdoyXp5b3Lh2j26Ep3gG98Ze1eys7apJYmTQCIILSqV5Ib4URSSNYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8sBV3+Geeh/oMShN/Oj46wdAu/iKzikJGRYVELfFMO8AAVS7jR8tsyUmPkuK?=
 =?us-ascii?Q?S1t0/F/WBmASStBFudC7PUy6U7U24zf0b+xepAB2xmYrawBIZx3qCC7eM+0/?=
 =?us-ascii?Q?e1t240D9cy+SA4HftsV0SnnJ/swPCSSUDoy5yqXdFU29SBF2D8+Oxq3fCgef?=
 =?us-ascii?Q?wIbtIToeofF6s2bdCf1KIIz6aFlnUowTuYjHbll5w8N7kcWprGqcKT0ykEwP?=
 =?us-ascii?Q?YldsybNnCfp7YySCLJDLo+lZY1Fcdo6BNv+FVO0vPvTB0NXK/O0gtiRiMLUy?=
 =?us-ascii?Q?J9Eo+XgIjp28kehZo4E01WKOTq1NkcCDdVlQ57hdN9bngZljTQa/XbazMaCR?=
 =?us-ascii?Q?PKBjuLqktGJzcPlkyzjy9TxUSgPi8KhpWZWihkD61PbyughfxKnVOxo5WEIX?=
 =?us-ascii?Q?TmwgwF5rh3NQnc9i6gib+eVsAIPr8yjchA3W7dSwenJdpAnShS6hO9ZIYssE?=
 =?us-ascii?Q?CSXyfqTVxLeTXfNMGZwNdZ03RQZylddp3NH71UxuXyTLHDNwv0cJCbKy403d?=
 =?us-ascii?Q?Q63XNtWa2hWbXrAj9iH1FOepCDr7Dta4m/lkuTGIB3aXN7wv/+k7YnxbyUeD?=
 =?us-ascii?Q?Y4CDbRigDzQlxQYY9P5es2kqjBBw0vTool5jixcCsu8PujMdxj3NBm/kfLSv?=
 =?us-ascii?Q?9vHKPkU13vpA5fg4l57ehLMl+OUQL6BypZkgA5pMMTVAr598Im6IqGLmrIsn?=
 =?us-ascii?Q?KRSu/e6OGq6g3IdzEBBGNF26K1qzNro6u/oP6AAbDyuCClXt0c4HMpje7Swe?=
 =?us-ascii?Q?AwnspiquBtmmMxkhanxUa5Uvd4NnoEvQCA8eOE0+YXEAlqIRv2s2GuTisLTe?=
 =?us-ascii?Q?1lt3/wo4X2/3d9kPWYFVzs7CJjzEpGvD8LbYaYg6IZDghux0dRo656Foy1Fm?=
 =?us-ascii?Q?4Vlny0OFrLMtZ+idUQ0dLjDoW0cdo/vCsV4zn5ehr7mdqX6Aja2eJ4DpErm2?=
 =?us-ascii?Q?ojaoyrMs3asPoh4WMyGsl+lSaVlTYDlJeqfnKdx1snnVF3qSEes2pfGJn1YD?=
 =?us-ascii?Q?SuNben76+WPxfPJnt2zi27ZjW437RmU0TQKakoblZscVsGmNSRQs6PU38+M2?=
 =?us-ascii?Q?/qBBW1Y98KxdNKPsV3JPtSSvDlcfopAd7wc8LWyWkWhVYLg5EPlKWk6eGQZz?=
 =?us-ascii?Q?s3OYFebQH4FhSol9+BFsrnK543PAotk3QGVljtNA5kfdZkb9gkSZDQRA+HEv?=
 =?us-ascii?Q?Gld3D3bbMtjpb54SSU9825BvMtvSFTBByCl8umCDtfAu1Rv5jt+IibrsDEls?=
 =?us-ascii?Q?m6BSnK+8YahPj73TZDgTvxPvUbCBzusQ9MWU/XrmQqBuG6+bJWAztS1TcIVL?=
 =?us-ascii?Q?bSEzv4PKvSKXg8US7PrKhIqUCg7LJgm//qxWk9w+496A6hHmCjXutftzAtyR?=
 =?us-ascii?Q?d9Uw/3X/OtHMiCes/dBV33RCB9fNRyivOEdnI8nPMJDd/3oyrtdFOmIj4KhV?=
 =?us-ascii?Q?gZlY/baxvtO118zA3xOMQHSLAvHoxp2zWLWFrtBmS5OmX1ldqHktLZFXvPUp?=
 =?us-ascii?Q?+5k35+2iEwFmV7SQ5YMCnRhMDGtih0q9dh7qzivTLDH4qgbUd41DyCHKLWbP?=
 =?us-ascii?Q?gm1l/VE8MVcbIRYaK1BPJY3UZq4MCGSrcURlvCvE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b015569-c83e-4ae4-bc1d-08ddda4ed8fb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:50:34.0161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HyWvqkdxL1yeUW2druzIXVazso7NZO11J94lq/Qf+fIV3yHYdhdGmofBwpR4UfaVLf2AojeZSVVKcXDPjgOPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6927

Remove unnecessary semicolons.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/ptp/ptp_clockmatrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index b8d4df8c6da2..59cd6bbb33f3 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -1161,7 +1161,7 @@ static int set_pll_output_mask(struct idtcm *idtcm, u16 addr, u8 val)
 		SET_U16_MSB(idtcm->channel[3].output_mask, val);
 		break;
 	default:
-		err = -EFAULT; /* Bad address */;
+		err = -EFAULT; /* Bad address */
 		break;
 	}
 
-- 
2.34.1


