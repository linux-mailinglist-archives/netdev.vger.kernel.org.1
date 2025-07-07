Return-Path: <netdev+bounces-204621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9728AFB7CE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA93188542A
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99FB1EB9E1;
	Mon,  7 Jul 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="QrCb8pAP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564E1A0728;
	Mon,  7 Jul 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903059; cv=fail; b=bsuThwKbhuAsOkGGpB+PSspLl20BgBHZjajaz4rgjMfIFVoms3WgPel8AGwbNQtY5bAdJFSt9WQGUFO9VrJsspt9FYIt22FiJohDfwAkbPPqX3gJP8zqaRpXcfFDlwa3m4xatSuSvN4fnFia25ceCq5mfye2jOuIJfyeY/OxSNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903059; c=relaxed/simple;
	bh=aTfLR638tjIIuKVeZPfX8JmW4T7NO/INqIi1p1gk7YY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lFlIORQXmzaHH+firRhI0+OhW+36XXhFbunyE8PxRWanCtxGnQnLot6BX1yKXdcSj8kzZfjrDvjxp9SeZdqbqbNrlz+A//Zo18Md0EuuXtNZ7pS0H0BRPKgVrRgeSZc+u5obfBEtseg68YTvvlgy2I79/7UZiq0Nc3kOeG4Mvj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=QrCb8pAP; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/DofugqC1G9gJmqjcSbBaNQ01Bz4FAd8eDMLKVcNlld1SXVo/TC7CzLKLC0ezq6Y4pRtud9j5HpdxxlvhtawsNNROvpDjdi17YQbNK5puNtuHC512clED8ZaLW60BL/wBLS7Uij3wwrXKd+zVl9mjQkCoypBwsPHw6jmd4L7dJBpkz075jZFG/Wh10l+48gsY+zYuXixbG9MhtX3P0qswBaWnbzfWKfK44svN4BB8lz4eIjz81Uv4UbuuMMhf1kqq/mR81FvElxIaR6ptJu+sHZg20v9g2Eo78cdDNOiqjoA4ysBW+xpCmPg+MZk5XN+RLcNyUn63eQmru1YRHhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yz9VcErMjGO3vNwh9dqM7n48B2M1Epsp5tOmMhI3P0s=;
 b=CdPYPwHsJkQEi5soT3cuOfrCKfrCGodYyzoigyceVZnU6TqZJecRFnbc3+mERHF/UtBoDepwWILEtWU62OAgUye6WVFwnYxkhicObkY+Nx2KPAQwexSsl6NeUxGWxqT9GQVCwgDAuRoebjJMfkaPfTnasX1uQhYWqkoCa8AJUOYnOiepw8SdghDa+vpIPiHgnSjF+QxyZlU/0C1IMtxPQhLlgxzwl1/5xbfvyHp6aZl9Ovbz3s7BJG3Q4JDCzYgKuLZ8QtLfD5cJ12EzN0uDuC38Sn9fky1OK4lSMN4AJoNrcirQtUETflhdDTCXaF51ddBFioTYQ4wmnbmwQqJ+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz9VcErMjGO3vNwh9dqM7n48B2M1Epsp5tOmMhI3P0s=;
 b=QrCb8pAPgI8WA8mNnl70DJKpheS9FXLs6PnB/JrsBoIqOVUboA0WzglkB0xUly/YApAChXtxDH+ND2sgX2ciOGyM3T6KspYJ+ZAh4T5VaeAtltsT+cZn5Go/ThcMeARwbsTH2p8egoZMKtfdE0cRrQ92I50LXbj0ojgRKjSgFM60DFP5MtutzbJ74sXOY46dDC6XDWdwbEQ6PkcXXdApH7hhpv71BcNhWVaNln+aQYwzuq/+Vr7OejrhbaueAREYyzLDh097d5JfDEEjYpqyiPgzgapyT76eBCD/EoryPgsaM9b0vj1KDmbHGHCIJRw0ZQh3Ch9Ur1GWITj6oLWP2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SJ0PR03MB6600.namprd03.prod.outlook.com (2603:10b6:a03:389::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 15:44:13 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 15:44:13 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH] dt-bindings: net: altr,socfpga-stmmac.yaml: add minItems to iommus
Date: Mon,  7 Jul 2025 08:44:09 -0700
Message-ID: <20250707154409.15527-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SJ0PR03MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: feff6ac2-341b-444f-f979-08ddbd6d1f23
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/qNjxhF+hSx/IsLb07ynYInQgm/xk6IW48P0kkNoGhvxSbCxkw7V7ztajZ25?=
 =?us-ascii?Q?rFVDWzxynfl8mZF8Vq5g6Y3X1JaUG91whXg0aPgjFv6LO+ILfWRsuMeJKMm2?=
 =?us-ascii?Q?vtJVGWYYy9WYlqmd2K23q4/dDP4tsHpVQ+9LbgTVDiXdZDQAkcHdWvLyGoT1?=
 =?us-ascii?Q?r1+HIgybn5hPYnE78xagErFKDGjjPebb5Nvwb293I/YMpCq3NIJThsaEhpCe?=
 =?us-ascii?Q?iRcUAFjPQcY4CLkhqIDpCy6cy8HaJAYN3CkTfSNxgFXV8djJREG/dNS4nJEz?=
 =?us-ascii?Q?07M4h2Oi1pYOQHSMBRLxlhz/dDWfPuNQSc91npGVXEjLKF7bPM0mWOc1oM2K?=
 =?us-ascii?Q?RzuqNWIb0LUa8IVKYcKcZ5U//jMSvPB8L7OLEh/lMpjvmBxbXublsVs/A2c9?=
 =?us-ascii?Q?siAyj6DSzxRGC4b4nhGD5WzGTMHwuebPx6fbEHGXnkXk9ojVKb2bUtOnPe+R?=
 =?us-ascii?Q?fMJrvmOJe7ZWxbKtrHnBPYbCi6NKBQaEtiWdVHeitTmMN6NGY6yDdU53YjoP?=
 =?us-ascii?Q?/IzuM2ycCh1vm1DsXSP8CbSiiUKBRHeh+MWkaWun82IZBdvS2JW7k9c23XCF?=
 =?us-ascii?Q?LbONrGcTU5/49MBsElCkrati0iD2iT0JmVIwE2m+c0twdcIp4/HU+mybHvTR?=
 =?us-ascii?Q?71ndQAtDXfGAQmHwIBmpg/jlhvrmR5KFIot47rVnoIJ/O8Qxbf2ervcRQnmb?=
 =?us-ascii?Q?kG2lW54C5siyOPt2YMphU4NBifMNdmEhRGq1sWXrePRDcMB8E3Q44Nvj4M4Z?=
 =?us-ascii?Q?9YH1NzxbAywgYNm1GOsfdbojaRaPjuipvySsxPF16KYrikZ7q79Ld4/RfG25?=
 =?us-ascii?Q?l7OCgWBjkAbGXwbYz/Bd0AkbVXQQMsnTi7hTHPK3cWQZFf1mDX4AZfHw5Rc9?=
 =?us-ascii?Q?qkUlqmVu8lGb1vjJGbBD2VCaTa9kdNeRVQSRsc8UPROgC/5XELKcipX+vZBE?=
 =?us-ascii?Q?dlMlcSFlCZE/eLfaDYDhh4/znq4hL46jho8dy1mOYZ52C95o8tkMalARqv3a?=
 =?us-ascii?Q?s1DKygpndokLT7G0EhSpVUbfHHlr1SCG2qcueqLmhQ2hEIFx+4pDJT/YN/zc?=
 =?us-ascii?Q?wRzIjXDjO3F6MHyOhRnkSlJbd++G0A1dlNii1I2z5g16I9RX4CdIXYzpTniI?=
 =?us-ascii?Q?vqQy2K98CL4LwBMsqE0NFl5l8B/3P6GldgCLTlPU4R4RV6sEw94zPeEnYbZD?=
 =?us-ascii?Q?epOERiSpx2gBpvmVKEOd58sHPztrHK3pnYsmOAlN0C/FqU/xiPvIlCti9z5Q?=
 =?us-ascii?Q?kHduBHZvyb01kHtaSLVXIRGgb5iIBdT/kZaCb24sxAu8WBNkXUfjLui5hKX3?=
 =?us-ascii?Q?0iHQJVh/z2e6zUh6fqL8GzLjAbWQA/5KyDQTE4/OEj/Jsj8SLZBW7Do/TM3D?=
 =?us-ascii?Q?oSR4unhwDVCDTfkbIufFwoXe9k+1uy47gBgIgWpotvBPOEy9ahr9PaPeBEEh?=
 =?us-ascii?Q?r0Fi3KFQPkMjWvYRJndDTyqgwdPGHtoLcXrPQPk4C0IrJecL40MccQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IGOzMyBbiP4xZAcC2XHZ+IUorLbY+BhMnPvhrPPEukiQxgjtu5TQ9QPDEN8X?=
 =?us-ascii?Q?TgzvZjGN+PXUIJ3n5dUXPgyN5mc8dUSGERkGmcSznEMsOgBcE+19LPNam2ig?=
 =?us-ascii?Q?vpaCBqtkc3k0FtO/rDlnZC/003a20lpy4SSfRFAYL+JRnwyeAAemmJyC91K/?=
 =?us-ascii?Q?SysTc34c/yMfn3y2qQxBr3q2sDSpLEO7wePqZ2VVmU0Ll3Aim0o51oyAxreQ?=
 =?us-ascii?Q?FoiHuZ3aOaRs+CICDgJYkXfEdZxr7bsQsUPknGSlUWLhUftH0Rj/c3EqOp4N?=
 =?us-ascii?Q?M3DxfkkhOAh6g9zkxe5cnH5NWZDnEeKZrClKgYk9W6yEzTcb5BYScGX0wDw/?=
 =?us-ascii?Q?K2Gjt50gquzZR+kitd5uWPfyMb9Ph039+wYq+VWhktfLblPev+legzs0j3Hx?=
 =?us-ascii?Q?Mk+aevr2FGKUzKsf4afCwVbslLdB/ywr44gjmhyDGupxs4AQoF9Px9zc7OwK?=
 =?us-ascii?Q?njtLlrnGd5+vQZxssh2yi9nI2sZqeEcpYXHHahxjf0Xx3e8n/t/sQMfw8vjS?=
 =?us-ascii?Q?VGIpQPwo41GSvJAiImTMqOu3m6Y+axhX3b8RxDoc3xx3DswESevZEw4PF0o6?=
 =?us-ascii?Q?Qew/G1+sD+Dc9euJU5DA6WCh8Vgqw5/aVC/rUUZ+Bxth98icPU3Pec1CdEMf?=
 =?us-ascii?Q?IT408K15FBQCDMBuOzkUwNaqJqXQa/1I5Vzs1+7/a/hwY6YDcExxwCkirrCT?=
 =?us-ascii?Q?ErXQOA7Rgr6Uhw9wdqMCzpOnVzFRciLOOOqfzlkoQ3Aa3a/6bkakD+Kt4zbH?=
 =?us-ascii?Q?adWbCf6KmtaIW94uSlPS04HdK2EVoC7DTDCfbasOT+v95la2LZv284D/lynX?=
 =?us-ascii?Q?t3B3scAXn4oUKcQDAtt78UzQqiBBz4xhB8tpzq9xWGpl9BjPXpV3ucOgcvMR?=
 =?us-ascii?Q?x0xGCKIDmmTZpdNpjaH87Lwi62Li8VA9qJfy/4g7h9bHeJ2bs9UyEK7KkMl2?=
 =?us-ascii?Q?VUX7TaOSnXJxoyfg17jNlA2oxqI7qcmSeLOUg9X6X+UoBwlJKo6GZExNMMrB?=
 =?us-ascii?Q?CbqWHK9KHSB9whB32y7fa5rUYAfalCoBdxBJb9piJLycUl5AczP2/4bygoww?=
 =?us-ascii?Q?ZF+1Z01dy+Kbzc6U/10JwBNkL0Tg1dBVxdmpm66M2/Bysrk2X7Pm9GA/HKQK?=
 =?us-ascii?Q?Aj9Tw9949cOQZLqTuTLU31kN2zcdjc+6s9GXlY8PZwfomj2b8GzBTuPH2Rb9?=
 =?us-ascii?Q?vKO8Txy5NZf+O1HRAbhlzbpqQecXfsuQZ2bU4DcNIOqSOSypI8eJjqSd0BAK?=
 =?us-ascii?Q?WrZC6Qkf9zkrh2eSXOFUtK/blkgMVjRfEox0T2IYCnf+VvuDAXruM0f3xwbR?=
 =?us-ascii?Q?2TBClKQUCgPAqq3Tb7zrwMFray7HJUN5pTniU4awq1p8axEG3IYqTEEUzh0x?=
 =?us-ascii?Q?oR9tc5/6zC0nJOUqtFXB3nSkiWgNhj7mE1tpvzgGyvEnUfR3QqEtY1TKJSv4?=
 =?us-ascii?Q?a13lJNvY5Ui0iqvP23U/yVHk1FteE+RHi8D5eBoVLGx4oiftLxZV10i0DyZR?=
 =?us-ascii?Q?2bPuo+rsFwPwtxr9sUatUuZQEEeK6nSj3vU66e6vYTSe7trkTqRmqUdMTgr6?=
 =?us-ascii?Q?neLaI61nQ2CAhznIxcHGUpmGfLEmRoQkvpFlYCs4jvG7jD6PBM9p32gW/Dnl?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feff6ac2-341b-444f-f979-08ddbd6d1f23
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 15:44:13.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiwbEHNjND5meTQvCog8MjCIESgr/zeJ4uInpBBQdxxVvAMDM/gXrD4H4UTUtk3m/F81Ps/297LKpvK1xBJ2yKig+TnfqpxyUU/TO+jew8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6600

Add missing 'minItems: 1' to iommus property of the Altera SOCFPGA SoC
implementation of the Synopsys DWMAC.

Fixes: 6d359cf464f4 ("dt-bindings: net: Convert socfpga-dwmac bindings to yaml")
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index c5d8dfe5b801..ec34daff2aa0 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -59,6 +59,7 @@ properties:
       - const: ptp_ref
 
   iommus:
+    minItems: 1
     maxItems: 2
 
   phy-mode:
-- 
2.49.0


