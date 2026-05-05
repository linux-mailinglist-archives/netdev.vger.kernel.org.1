Return-Path: <netdev+bounces-284181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE5JFrJZ+Wk68AIAu9opvQ
	(envelope-from <netdev+bounces-284181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:45:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A6E4C610C
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A42301110E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A7C3A3804;
	Tue,  5 May 2026 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="TytQtiSe"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690F3932CC;
	Tue,  5 May 2026 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777949103; cv=fail; b=ZUbYv84YnyOnU7fuNn2b4kX5oU17trAM+5DHpEUnbiR7Fk2GarDEZXWTVA7RvtcjDw6hUERij6XlcyXNOFsFqPCSFiYYUKB4y9G/CVFDpZRl/2/ketSLcjUdYF2NxEUmMVZ9SpPu6DtLqJ0Fp1lqUHQ5SECerfWetLVK2SQb/Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777949103; c=relaxed/simple;
	bh=rdzscvryveoPZytYgc5PufwdfdSpTAb8UhmGmqNH9jA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IxF775O5oSboglR3W6BK5ScUmQXafbZctPIp9XoFU1dLReqx8qQpuFSB385fmxF+aYwxQjbQxuLRX34kzzdiIKUZj/pATqegFaSjdlRGfbHFJhkslzHKIVPMw83XxgDKXiOUaeoYwkH7M45XySq4eY5X8Gx9eHbZz/8Xa3FsNJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TytQtiSe; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDyJXKQuA16dDoszyFJmLDGOmJsiJELL3ZK/r42RiX6ZqFo7ThJFxr+stSyil4QUwwAAP/5o8E8hwmN3tGJAhlkZd+kux5mjMzvsPLexTFp0ylpjEO7wlWsZv46C/auG2etNVgKN5N92yIwtjWyY+mchyACalq7w5W7r2B09aLzgTvOaVJyKMscV/4dF+lo7v3r1nq02NY/ex+QlS4PRB8MgVXo9ODxQeeLzsdzpbURfb8yW9dG0Pw6+vP0JLJixPaWobhnrp55U14nrvg7qpqGAzcoxnGS/WQwqkoeTBO74rPISwmm5hdoY7vh4Ces6S4pNEKXz9nB5OMIVG57dew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lOXIfdewPR0LHDQdnamu/GUJjRnxisp1n971IcPxVg=;
 b=TLfDDbYpuuiVRWn816xa00FpfuMJCk44rvf8bpWqH/YiAM0R7j9GniLzWta/kbDxkTAuH9cZBAIUksTe11DRV0DcgWfpxrxWpWiUk0PpkbPfunkk1QDMkXhTOm2jq3DbRg9bpZDtdvh6zFP8CmmTvObtV5fhoYNHEdpOIZVm5pDzjHo+vKn2OOP5BPYtZRw1+8yuL72D6OzbZZnuYJs+q2ZI0aoKztvf20Vj2B3dfuNsyWznHn995/Q8BZueTCW9cRjh5nIGXrRLZrHde2gZuAFSkob8ccHGWfhl6MV3hivzvC/42mMsJxgza7dKc5SPJQGIsh0dcibH+oeD/2eJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lOXIfdewPR0LHDQdnamu/GUJjRnxisp1n971IcPxVg=;
 b=TytQtiSeGxFcsHTYsMQJP5YVCMne3hLXFmgou9g2iZkR2CTP+iNOlnNdzGj1NLXfXJvZYlhgMbMtSGN54UA0BrVjK8CSqQ/bIW5dN3GhM49OuYK231hGrjxt12JQrkhYtATpwejgfShi1R1pzbyeckXFpbhOIn+v6ZkyJSM0V/pVbt0N2eJA9gWoDjjwse8xsTCNG4jJ0IOTQY3CfN5OCiY+oQ1PVm+LB9ql27QK5Zzksw8rVbu5TVh/O1splz4i02ylssUNYbLndMEL9D65KDGVdVVh/UsPYm0DGwT90KkI/kL1pSn+anRLnm9eCy2kV/bs2RM8GyEBIEgfINhJhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SAWPR03MB989177.namprd03.prod.outlook.com (2603:10b6:806:4d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 02:45:00 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 02:45:00 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: stmmac: Add support for TX/RX channel interrupt
Date: Mon,  4 May 2026 19:44:59 -0700
Message-ID: <20260505024459.22463-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SAWPR03MB989177:EE_
X-MS-Office365-Filtering-Correlation-Id: c62d6c02-aa1b-4b93-7b5c-08deaa504d3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Fv9+/1ZEf8tNjcm1SayzX5WGfGCORy8HiGPEalWZrWtL77R3JxWxnBGC68tvZ7KsekF/MvVWqkbb6Civ5hVa6GIO0zsrlvKfscNLWvJvbLNN5LjPNSrdbmynynLzyUwuqDVrD+cXN87Jb28EbO0FAFrhB8ETnDWyr2qstgt+3dENOXOLSp8QjcEk1MbYtt7yrAQHHUYODtdZIw/N1Kus8TVUQjiaXnZhwVNw4OAGgO80zPyiNjDCVW3GBiE1OaXGpC+G0fIh7BO7UZgSQt40VFBNt2/BAPeSmpwASxv81idEYwG80zxRo6dSusdsJ9Exo4xE4MBZh7YsyVM6wMr9SOrEPmJAX1aVGgOOHG0OdM1sItvW4psaT044SsJr6zJA4iCQOyWnpoRkdOtDvpYfYSHIFy24H+IMICnQw0dSmmJvdf2uiep6vYV6/nQoHdP4rt2wuaqjpfMoCBH2foIvg8El439bPKQrBUzTKUroYrbCvwBXpsukjHCfoNFBBOFj/be8H8dDSchHePN4v8jFz5SkTHjlAz3NsGUzmo3ky3ioYGNhynpnsERf/GMEoxfm3afKrrUWbIkrJaI3JS31q8Jt5Dvn34GOv+3GGYMhYWIL8ksUk/PoFcgUalN4thV3xBelrQkYvikqZ/bWiQbIRj2VTqPly6Cl/dt7HE8/Kqmsw+laoThB1GK3gf7/dAHj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h099M1bvCwhCj3ORPGRW6eYuSM7gzkzAd1AfMo1KTcSWZnl9K/CKkpO3avMo?=
 =?us-ascii?Q?FU5hncsct66ZnArAqONoe8hcBsBh9HVujMzX+YsDycj+qjP5VF9flusx0X4j?=
 =?us-ascii?Q?pNoGC+UdYJBOV5fo/rR2rECX1pX1Bze6pHfEcN4+REB44xz1zYXJ8K6fGa4N?=
 =?us-ascii?Q?ZZWb+8vfVCn2CSGjo9u5YqmBE70Tm21+53feBJFlvuzxFnGMcy3iyb9rSFz1?=
 =?us-ascii?Q?m5kpqqh09NugJYbCrepZvuqae8O5NAZv7oHPlVW69xmExpXlK6j+pm3aEUKE?=
 =?us-ascii?Q?kDxiZEb/7ad/bBC25vn0ffh6ov5MfucvAKGXgIrzKdKUpzq6BTwqPpvOUYWr?=
 =?us-ascii?Q?4TmooFefOTkRwJ9cm+I/b/CbZTFETq2PCO0WSDUZpqXP9pYk/yjQDv9SSL27?=
 =?us-ascii?Q?XzFy58tAIr+9E4tRIHrlm5uiDAM+g8D23KXt65ZOoIa2+lTAhjL1P0yP5erX?=
 =?us-ascii?Q?JlklExPW1YWj37VM53U3ikF3KE7sqKcFiyHAnOUzA+opvWCcMcLQ0XK7/JJK?=
 =?us-ascii?Q?NwA0PSqOyh/rLNnwUEVqIYODaapUKLN6Ql2SjqUX3Qpot6PRRpgs4P3CS6dv?=
 =?us-ascii?Q?M3WkVMs1nqLrsN0nKfI/aO4IxKVrnLvT7xyCErh8kBzwlwVBLl7tw1KY1NRX?=
 =?us-ascii?Q?vjwLrHVGKkP0wY8Ye17pqv+SyaC6/DOwls6yQ/fplxy1gJqA+8vr38l68Sfp?=
 =?us-ascii?Q?1qXz3gGzSjEihFwJUUcMMhi4VJKzVMM3iAnx8hmyfqNRArR7V5tVaUdppZWT?=
 =?us-ascii?Q?qxPzIJnekdIRreyHCyYPjv90lXHeJW/CpeFHAWBf2Ioble2slAFEwQ+7Zclk?=
 =?us-ascii?Q?wo2aXnqsBlxApgODOJinhwhTQZoSRbsRkeVQY7EHTHn8/gqol0cPcYKOMnqx?=
 =?us-ascii?Q?TGRV8ENQa9UvT2UgYFaZ7O0zQtTR6Yd1a2fnRW5g29EF3a8/cdKchujfb4DM?=
 =?us-ascii?Q?F9j5BvPQDwUacn8T5v1I6xxqUaPbdOcv/IPX1PFapY2H7bCI2yAu/AP7pkFU?=
 =?us-ascii?Q?K1Ah7xtVT1VoETuwAcBhGIVARGvIzb44vyCcA18/8s5g7aQWa4goM+vA/wGi?=
 =?us-ascii?Q?UFrJpEJgJ6nRInqL77bSsGerDXvkleCQQEQO/dVRR/6ZLPw+FSzFlcN3u1Xc?=
 =?us-ascii?Q?Q/FE7Nu5gpK2mV8R9BXR5hdkQWBsLsQzrscUrdS76GezX/LpT/Si1Tkt1Yz+?=
 =?us-ascii?Q?iUCK4alH8tBianLxK7nmqtvPS6evRqzrtEyQfltzrtuVLVKY8wC7PjGUYkmE?=
 =?us-ascii?Q?GyWBjwg5DdFAU/wGPBwoUB965C9MHzJNhnLkDVwjtVPVkTTMpLZHRkvf4NAS?=
 =?us-ascii?Q?FzLy3F5RJEO7H2NkoBdczpo/Ntw7ixJv74WO/4dPJ8VVbGlYt8eFvNyImzD5?=
 =?us-ascii?Q?rm/ERhcpNt62XD6ZCVSod7uqNaUUbRG5X4RwdzmE9sopG4KzeKC6rS/DrrYS?=
 =?us-ascii?Q?0C6PiyC8lMOnVpi6o0Q95iRAiuGJnVZXlUdCdYljlWWsLwiab2nEOHC2Bmvo?=
 =?us-ascii?Q?kYAkXkfpKNFvx0s4Ur4JK9RIRYb9C80s4rDG75T3LwSMxs17zndFc8xYXzZD?=
 =?us-ascii?Q?n9324w82Ha2gaWtxaEzSUFkZarbeSyDdgGLGWdqVaL4vvS0kYsvoHf8iO4yI?=
 =?us-ascii?Q?7zUJDRQMg4YZS7j5ey/kastbZs3uUgewZBd0iVVz1iSr3BYhGoWdQcF2RZpk?=
 =?us-ascii?Q?TlijTqQM9FneDK0n1cZL5VhoDguLzeb2MDemMZh1zshfGPyjxBfVsHz/HYwV?=
 =?us-ascii?Q?GnVMbPIaIJ6Gge/4MSYqJuvZ4qkg0Pg3Bz/4lSSpD+n/DPn1V3cz71O1corF?=
X-MS-Exchange-AntiSpam-MessageData-1: 5h2Rn/U7wGCfcQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62d6c02-aa1b-4b93-7b5c-08deaa504d3a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 02:45:00.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVBXbWkypyDQc4il3IYQMrIdkPUJWBKtupOBQy/WwxB+E3Swn4C4zoMhdniCMQvDw2tZCoR0zYchZihvYbLQ48c+RwR7p7D8DfJzXJm2d2iqSApmUBTww6qYrFtKxc+tHlxR3xnRolLSrzhYdMnC1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR03MB989177
X-Rspamd-Queue-Id: B0A6E4C610C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284181-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org]

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Enable TX/RX channel interrupt registration for MAC that interrupts CPU
through shared peripheral interrupt (SPI).

Per-channel interrupts and interrupt-names are registered as follows,
e.g. 4 TX and 4 RX channels:
interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
interrupt-names = "dma_tx0",
                  "dma_tx1",
                  "dma_tx2",
                  "dma_tx3",
                  "dma_rx0",
                  "dma_rx1",
                  "dma_rx2",
                  "dma_rx3";

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v2:
- Use -ENXIO to detect when interrupt name is not present,
  and return any other negative error code to the caller.
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5cae2aa72906..9039e207ddbd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -732,6 +732,9 @@ static int stmmac_pltfr_get_irq_array(struct platform_device *pdev,
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
+	char irq_name[9];
+	int i;
+	int irq;
 	int ret;
 
 	memset(stmmac_res, 0, sizeof(*stmmac_res));
@@ -767,6 +770,30 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		dev_info(&pdev->dev, "IRQ sfty not found\n");
 	}
 
+	/* For RX Channel */
+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq == -ENXIO)
+			break;
+		else if (irq < 0)
+			return irq;
+
+		stmmac_res->rx_irq[i] = irq;
+	}
+
+	/* For TX Channel */
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "dma_tx%i", i);
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq == -ENXIO)
+			break;
+		else if (irq < 0)
+			return irq;
+
+		stmmac_res->tx_irq[i] = irq;
+	}
+
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
 	if (IS_ERR(stmmac_res->addr))
-- 
2.43.7


