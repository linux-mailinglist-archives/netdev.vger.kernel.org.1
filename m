Return-Path: <netdev+bounces-282238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFuVOymk8WnxjAEAu9opvQ
	(envelope-from <netdev+bounces-282238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:24:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA8548FBAA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE22830091FD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524FE37999D;
	Wed, 29 Apr 2026 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MfQEqobg"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F2339866;
	Wed, 29 Apr 2026 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443876; cv=fail; b=aY0hRC4/6wwrz50cRen4tvCOmAKCZxVhRZkIB9OKnlPbnHcDUs6sgpOXyMG/dXmaj5gV52ka87KrVOC5UHF5BgXCTsvhdXL6R6apGSKU7YbPOJahhlwvC8n18+VnNOnCFSpIodLhcIYb81xl0z6GPP5Qauuqmo+JX4xZjXil9Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443876; c=relaxed/simple;
	bh=/aYJFUksNRItWTzD9gOWvoysyDB7h35iANo/6iACx7o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pg9kZJ7q0aFQ8buBb4sqpHzNqgVmMRBD9OcXuip17P+Uzx2QWBpYRKtKG2WfO1IQnnP0ZcNGA8FosulQ5Cc47qydyhCB2KygwwA09sL3La6vorso6fxPGdysbWgrzUZIuoVoCfd68AVFpgXhVeQ+pS7j7TyukRud9YFqx7Vlm5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MfQEqobg; arc=fail smtp.client-ip=52.101.57.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLoaKNP58np7TRXNGR3z07AOFWFxbkKgNkDZ5JEmWEGNkRWYrsE1h47QWBZvnpY4jxsL/3JeOmgsxMWPV5IsvhT+PwWHhuqYzm3nYZv9FgfBkmglbNC7GqDJQ56fyXBbI36aEV9RkLcyVoL/8N0LbOfCZ2l3z83ueq1a32RI3XznQIKoJXALYQ9geBhF4jwcCmVY6n7/TANJ87yNEze/pZR12yT1jLTVxoozvQXEjf/j0pkZModvnqhK7ZDsXtLpSfnO6lD8wKa8+A17TNweoxEU97weD9suuG4y2JDnApsU6u4Opzc0YDwf8M6HRUja9diBeobjKNuvoM6lKQwg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0W4cGYSU23W2xf+5GWvqm8yWJeVTXoXcGbbov3CU1I=;
 b=f+sA69PJUfIPc5IwyTQgFBg+9yzkJmFMDiWFwGD2j4HQFlvOi6oZ1WqI0qKrD/eqDqMNTsGOBFIjVeZICkODd0Qoc6G1KTaUPbzcb08lvpFLvZhGYeyVDFhH3xLMrjYvkoWNJpFDmdSfzqTxsA15oU6miQr61lxmSicMeTBmgsUfzCrGi748ex/P02FlpU8lCyEWnrSvvfRYkl8LrxYBdBZtdUTUVk7He4jrM53CEPF8WyZOhH/RhWAnkbtOJX6wlGwbWz3Y4tMabeWAfQcNtvJIaWZ6IpkABUrt+eqg0nSQ1FpFNxUn59J2VhZTb8sek7Yd2AW2AEHANmWwXRRW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0W4cGYSU23W2xf+5GWvqm8yWJeVTXoXcGbbov3CU1I=;
 b=MfQEqobg0wxOqdkhtF/mtKEA6cPuAIVppHBiWAeAE8UMKcF11maWTATA2nafGmLWungNHix9yujmlWVT20qk0NNXvS5QGXQzNXIOdXprpfM77RCzByGYXlK87XBBySxqSnKdKwmZSQ53ZDyyVBM8LIPM5TwdQjNtc8Pc3kqccehQvY1Q2MXgHmF3hm4BBezXvjndlvR4QA4Ap794rMIXgWkAlk5vYuH80lL9XD4/uWneDqOws36iWLfk4O0ft8Sfcjyto+HRx++GhXfbwnz8uWKX6jHhdMo2UXHmkpSpYdtY49qvk5be9MrLGfF2mrd99yHtbpvNbPpGIeHQzbed4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CO1PR03MB5796.namprd03.prod.outlook.com (2603:10b6:303:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 06:24:31 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 06:24:29 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Use interrupt mode INTM=1 for per channel irq
Date: Tue, 28 Apr 2026 23:24:28 -0700
Message-ID: <20260429062428.18438-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::25) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CO1PR03MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: ff533045-96e6-4cbc-e9ee-08dea5b7f851
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	qfmyJpTb3FtSdM/+vcN13faGC8OSjFLC7pgYSnGWEmgp88dYpdyUOfX/g2v8kwtxxX19aNw0k1bi21PTicbuvAB4n27Z69XlDajl8uxHIqyEhmhwutNeNQTJSOoAksn/8UthsaLfyt1bQQksMSH5wvYZ51Fxf3mceDIxiOTgt3/0a+/H1XjuObCLtWob3N+sRR1Fvt2pR+baDhcQbBuTB5SW/m3B3h6A9uIXMVi55Ul6Dxc4LPEjIcw+fes1s9CiEMn3rTtFtT1ZaSeUOPK+NTg+TcYsW/s1kTnSZgiykOSKRa0TxaEq73EIPqt6zOEH0DrzmRex6pEvwOwnvN0Lu8euD3KZ/UTFKyz+KpxBS7G8QyhSj9j2CXSCzlRj+BYZBR6SUEkUnRa0XQXgkCWOSGGJonGsGrLEMfAbal6JvYni8RFztRTlqT/4qYUhPjVfPrUEgcNN243kXtI7NGGqvstzHoEsS88JoZYY3CPPsp2i0Uv+A4uExKXks9BmpaoXFGKDcGAvZVo7MRm8kaANqTrXyZjczCKnf0Pn+uffuvIEIDBg7NvMFDzzOZGqkdi3dZHMxxCuuo7OJ3xh0pyWdPgqv91WfM4aQo4qyM31s5tvZh/EyJYGsvAaivtuImYknniCtA7HfeOepL5lBwFra7wlRZU/N0RxSTsgpx2CoW+ORrZz5vIz4Kdf4xANluIod4ajcP6+GJhodQsJNSr/36JwTKsWtin4NRxbvSCYaV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LgSKB1iWBlls+XFEs1q6mE0+nr95D4FEeUo1oobTE8IzOWD3UcivjoLfWj3N?=
 =?us-ascii?Q?O89tEyYVePHFbrPZowmVrb0XKepG6dQUPewGgZC3aIs+KYDC41xeau4CoBk7?=
 =?us-ascii?Q?uBt3c/bEPgvS0BtLVlrb8s1J2izEvtA7kvkw8E02ZbXjf3xx1HhqiimEKWIL?=
 =?us-ascii?Q?30tuDQ8zzdpkIYyPMGBdIQFKMN1d42riyYHwHTSVkC0HQ2nnY0Lo9xy5TuuV?=
 =?us-ascii?Q?zYoWpZBmeP7jK3kUj/xTBWoy0Hpn7xvcJHE5QSLcYSqH2ZtYHJYCx9NPXCnm?=
 =?us-ascii?Q?0HcnCXBahz/e/X8yjtGXM7vTvntiXQTGepaDHG28Cb4fy4X2NoobKoHEELaP?=
 =?us-ascii?Q?fYO5G3OOLGSLUoQRHsPhThGqOaamhlvf80My8g21wY6F4V+hF2yaDQlVd5Nr?=
 =?us-ascii?Q?5hNC7aroC76TEYPP1DC2sI0xhv63V1okQxKhOrKzz+udR8/0DO5hbF4MrTQc?=
 =?us-ascii?Q?BsFgyKRIleW68q0PLu0udYCGtIrp93q6HmYq1BfUok2YUoFyeWpd+2pwN+fm?=
 =?us-ascii?Q?a11xCZgwQdyPokRLPNE4Y6l6xrcZZgfWSATx67cwlWU8LuwIYNngVmQYiOhI?=
 =?us-ascii?Q?OFBML6JgsEj2AECZOefaRkrrrMheYpbJBPrM5z4EUErhzaYu/oo5tIzv9WO9?=
 =?us-ascii?Q?LIlyq/cOgyPBTHiEher/z/MOADa43MjjY/fqUBaOs7cZEkPa+KnhPeC5suq5?=
 =?us-ascii?Q?jN0ORxyIdlsWkjfzudBqvV3xXSLx4JLA7+x0j266IWsy7aABE7D6zIkld7Jy?=
 =?us-ascii?Q?JOrUemv3TOcZGpf6w8NYI30Nvg0K9PEhRRAFAPRSxZojtewV78GyW+8WjNJt?=
 =?us-ascii?Q?Ez9V0LlrijCHV0ipWveVZ7uCV772Ds0Jds41cF2qAQPT84sWhwKE9B+WrTuH?=
 =?us-ascii?Q?OYB7S1TwEtKker7HK3mzDY+832UbhWIxk8d5EpSdpR6oHeDvxyEZWWJEV9HD?=
 =?us-ascii?Q?3MJuZtlIaukyIEwyrorTeBm9xjXxq/xhhpsih5i6ngU1o7RiiKyZ0TbR3Dw9?=
 =?us-ascii?Q?ZsXvXYQ5XEaZbIRuGjyo81KpIv67/yDU2DM7UuFr97+tD9yJwhKtW1KSMbAR?=
 =?us-ascii?Q?Nh1zU5RzVR0E6APySqDfIN4I2LxkatU+l9uDWn0z26aXX42w3fFeN02m4vfY?=
 =?us-ascii?Q?5js2skT2yJIxHteeCLC51TpZHpFjiNA5ntArqDFF9MGqJ545mPwPN+m2Vqif?=
 =?us-ascii?Q?vriELagCfPUrxtI6uds+F9ItuwJpJ4PQ+BEfvOerdohKaZqPI2D4QBiWg8qF?=
 =?us-ascii?Q?cYZVcB7sW9CsptE9zaBxYRNGpAYHwT9YpEib4fRHEh6qMLFoXo15cDcjiABd?=
 =?us-ascii?Q?J6vQJMWmYjAbdGoXmtditnrs+mqYPJLBA14ZZK3AISXqKBhP/AQatRDfRokU?=
 =?us-ascii?Q?fGLr5CoVv8ph0Aet/EzVhcDTC7bbzzywtPNXJ0Ju4wyCxnap7be+ehKog61M?=
 =?us-ascii?Q?d7UbYIuwR8RPYBaDiqOzx2m1sNHvv2hbRQgtF7yOse1TOlwzTV6K/68NdshO?=
 =?us-ascii?Q?pQnxo38VoVvrlzd2VeyHqXGk7zjtPzDmtOcJZiVEIWia18dEDTAAh0nx3QcO?=
 =?us-ascii?Q?Tb6EEDvphyMSUJArfxU3m1GvVuNZ2+Fq4F4zmatIl27wMemFvYBb//MWc5CO?=
 =?us-ascii?Q?vQVNy8lMG1QkqjuGklydkAO2wLJX7gHQN5AIjz6i8M4Ric6Q2N4+Fv4iiTun?=
 =?us-ascii?Q?hX99lqz40PNDT90FVAMHkqZ+5ZJEh6gDNM997Lx0SyjoHgmsAg4XdANHeYNK?=
 =?us-ascii?Q?TgYX1wpPlE3OYS6fmccvaB1uELcOWPN+wkqjbN+8t5LAPbWLaGo0J1l/MmMf?=
X-MS-Exchange-AntiSpam-MessageData-1: ixrCtiypJgzw9A==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff533045-96e6-4cbc-e9ee-08dea5b7f851
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 06:24:29.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vEK0DB3rv+5APjrdC4uXhpFbq9J6CJ1O+1HTd95hPhSGyoU7Hdgmi+aoRdYS2VBhBygw4F4S5iXLPGIE2VDiB+MMB1s8aHEb9kR1AM2ooxi0UA4VyYveVM101bVktIO8w/+/PvhyUEL4x5RHAvSjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5796
X-Rspamd-Queue-Id: EAA8548FBAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282238-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,altera.com:email,altera.com:dkim,altera.com:mid]

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

commit 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1 for
multi-MSI") introduced INTM=1 interrupt mode for platforms using MSI.

Apply a similar approach to enable per-channel interrupts using shared
peripheral interrupt (SPI), so that only per-channel TX and RX
interrupts (TI/RI) are handled by the TX/RX ISR without invoking the
common interrupt ISR.

The TX/RX NORMAL interrupt check is decoupled since the NIS bit is not
asserted for TI/RI events when INTM=1.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 3 +++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 7 +++++++
 include/linux/stmmac.h                             | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..94cbf24b3118 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -320,6 +320,9 @@
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
 #define XGMAC_SWR			BIT(0)
+#define DMA_MODE_INTM_MASK		GENMASK(13, 12)
+#define DMA_MODE_INTM_SHIFT		12
+#define DMA_MODE_INTM_MODE1		0x1
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
 #define XGMAC_RD_OSR_LMT		GENMASK(21, 16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf3df..3789b62cd2e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	if (dma_cfg->multi_irq_en) {
+		value = readl(ioaddr + XGMAC_DMA_MODE);
+		value &= ~DMA_MODE_INTM_MASK;
+		value |= (DMA_MODE_INTM_MODE1 << DMA_MODE_INTM_SHIFT);
+		writel(value, ioaddr + XGMAC_DMA_MODE);
+	}
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 4430b967abde..5deaa1a797a5 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -122,6 +122,7 @@ struct stmmac_dma_cfg {
 	bool eame;
 	/* multi_msi_en: stmmac core internal */
 	bool multi_msi_en;
+	bool multi_irq_en;
 	/* atds: stmmac core internal */
 	bool atds;
 };
@@ -349,6 +350,11 @@ struct plat_stmmacenet_data {
 	u8 vlan_fail_q;
 	bool provide_bus_info;
 	int int_snapshot_num;
+	int ext_snapshot_num;
+	bool int_snapshot_en;
+	bool ext_snapshot_en;
+	bool multi_msi_en;
+	bool multi_irq_en;
 	int msi_mac_vec;
 	int msi_wol_vec;
 	int msi_sfty_ce_vec;
-- 
2.43.7


