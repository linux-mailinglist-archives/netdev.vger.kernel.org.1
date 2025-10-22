Return-Path: <netdev+bounces-231696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BE1BFCB4B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30CF19C5D7C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFD03431E9;
	Wed, 22 Oct 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="bQ2Eg7jC";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="AiWL+aby"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay36-hz1-if1.hornetsecurity.com (mx-relay36-hz1-if1.hornetsecurity.com [94.100.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFD35BDC4
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.128.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144809; cv=fail; b=ipUVLB3i2T8D93HcEgpm8yDpsCImdwvElCSWosR9L+CoswnBoiOy89BePfnjQ4GipL06eAs2+kTZO9WXW+uU+BanzZOPlc26YPi8exbsULLWb91oXl6sirOxgJYvV+kFtvN9c1dSWSGN8ttBxFB0VkayBa4ysXWgFUTQTxMYCE4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144809; c=relaxed/simple;
	bh=hFP2srFJDDYhW3ng2Q/QFqd3EFabxRah2gpTulXWJYw=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:
	 MIME-Version:Content-Type; b=qLzNi13L//eI6L6h+UOupgdQeJJ68xWB1th5ny6Hz+26AyiYymQXPpVv/KfDELY9UtYz6J1K7v7LEeCbq2T2m4kU4rvk6ccEcWwEtj/mttYh1Yn/4oyxndbPGjwXB9w0B+NsHDxseTPeIR5r7Bj1PCqhqDFByl4IWgzFlUT3Eo8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=bQ2Eg7jC reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=AiWL+aby; arc=fail smtp.client-ip=94.100.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate36-hz1.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=40.107.130.96, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=mrwpr03cu001.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=yryNR+teDhTEf/9Bej2QsewlIcH2w2YgsHPkqK16SaY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761144804;
 b=LLkyf5pVDzQ29OJo38Pqmn1JoDRM4YIgf1sbpHP/r4ht8TB9Iz6FfRBWjhJNcCMeBvRvDUY5
 f1JUxhDJFHQbggj55EAN4nAiaK7nXnodewiGk2mglJdILBfkSJ1+uzrrHEj0D0sPqKtXxe7Txnd
 zr7jyyywWO1c6u/gCSSK+NJ9iPdH+WV+RiLoDRmyq2jMgwoJEFOnVpE3fvYVSMeTB0/qVdYhitQ
 b1cjFAxI9Quw+jPjZFMtCGqrPT53fqZr1AjKYHUkPs/xFLtC/uHcRU6ZvAk5G43TRRRP0zOj3Ef
 kOxLDsfOm7c+hS1LmUVHaeeT/pCNebqJL9Kfb0Syy3cmg==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761144804;
 b=pfwqx5de3XWvnW8h9kQYvGhtvAJTX0kcnnIJ+ZvwtQ5x8y+sn8y60dmftwRA372BlQTEFa66
 8T+uU1nauzrn+S20Rb7tMMQfHZycwi58Ck2XxCKsrHodlLaJOijkRG5Ncj/Vmlfu24j5DDOk+Il
 ffkv1FohTpcmgcJZExjP7lawMoQDr7k6kswvkiv2W8G0CBgkLfU2GI8PipL4RqD9USERJ8gj0Ge
 Etzn3QpKlqtLiAGRol1DLX5YwCEP60nbi8dUY1hp68InvnvHLzJnlae2JtxuFuoklcXE6kFfC+a
 MaeXwhjeLcUL+a2+gLHNOdrIItBbJWyCrDsddyj7zLh8w==
Received: from mail-francesouthazon11021096.outbound.protection.outlook.com ([40.107.130.96]) by mx-relay36-hz1.antispameurope.com;
 Wed, 22 Oct 2025 16:53:24 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwRGi9OX2XvBMGYzWU36xJCoeRTw6DtGyr7Li+SE7gaS1wp67BUo+nENacAmr9vcBxabWry8n5FNpRjhmfbdjo6jMoIHm3F4IpchVNqXXZYiJiBibyA9o8yg1Bn8xPxyHJ1CqBFKO8WYNpbRnmBTjvBYvCM28kV4SLlDV9tYLO1lGnfaCl3og9k5PvboU51QmXzPT8UTvxGLIsjQwP1Kj6fKvnDOhrBZbYPZORtjGWj/zzGOPvtktn6PlTYaX0Ds2iKfWIR9YnY06OUEZPFS28h0DwA/9byq9x2zO55dE2VYcM5RzQZqv7iCJTVqu4zunEty33y8tphqinmbXxSSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB1hj33jGAMRCC+K+/RWHhXuVBhmyQMdQfBRswg2wnM=;
 b=uqxnboFSSNu2QAt3u91Q12omYjjBJvqBcpiZqNXczwKk4QKJ8XliadXC3fufPu+tZuqzjq8fOx0/nV9/Enyo4rEyzC0aNWsv9phHluzZEIwGMjaEUiX5HLRjR3TehumkczkkA5HxLL+3/P1JRqlAiAZITKO6lGtgdqoQ9hN8Ik2a9Z/w4SVAjmCcPupGmgwMcV77wbtWxTymwks6+klMQHULae8E6pajtdOC/wCbLCCzXMcODDHluz5hTEv78kho+91/CzHApVcs6mmFxAp6XzB+1xRtaEUQfdsBAA6/EpFCItlxTjMlahj4zG6+N8V1+7ZvQRbLud5vNVZxn1qM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB1hj33jGAMRCC+K+/RWHhXuVBhmyQMdQfBRswg2wnM=;
 b=bQ2Eg7jCnszy8p5SGD0mhkqR9N/WBqhAjCghiMNH9Zghz2/2F0uW22lqbFjCO515MdHsc3Lt+V/mURs8O4eK451Eh9ff6ZQpas+/SwLXsXZoqFxz8wNMingWmovJLC/dTqLetfvAhlbA2EenHY2u0jxdh70O2fH2vpO5fd5eoFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by AM8PR10MB4036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:52:53 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:52:53 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Wed, 22 Oct 2025 16:52:44 +0200
Subject: [PATCH ethtool v2 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-fix-module-info-json-v2-2-d1f7b3d2e759@a-eberle.de>
References: <20251022-fix-module-info-json-v2-0-d1f7b3d2e759@a-eberle.de>
In-Reply-To: <20251022-fix-module-info-json-v2-0-d1f7b3d2e759@a-eberle.de>
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761144770; l=4220;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=tBqKSYhZiUqZVR18Qxl5J+n1osf87KZdIFCm+8NQf9E=;
 b=HRpaKzBy1OBKsuMy45URiuFLdx+BL8p9XJAeG+aG+xDrjnu730/P+yLwRIW9tzUHCKiZUnEnm
 OTykZGvAXBQCKia9metejr0eBS4/Ux+VV4unJ2ssYRkVUFJYwIQuUi9
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|AM8PR10MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c21164-0acf-4fca-0551-08de117aadbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0xlRzhsd05FQlRwYlZzMWhTR1BUTjNTTG8xdTVQUDNIVU9PeEpSRkJSd2ZK?=
 =?utf-8?B?MnlWcVFLNU1rc2RKU2RIOHBwRjlSWlc3UTA1MUxyRzJUMVA1Tmd3R0xOYkt5?=
 =?utf-8?B?MnVaYnRpS2w4VDkzL0w5UVhhbVdJYUhPa1I2Z0RwcGNHOWo3cGovYVdVT1pW?=
 =?utf-8?B?M1dEbFkvc2lNRFZpSHZaTEJ2RjdYK1Q1RndIb3VwNlNSUkJMaVFSVDhKMmlC?=
 =?utf-8?B?bWpVZTQ2VTIvYWhSSXVJWUFDNDZtemVRd01ac0hwRWxKNm5aQ2UrNE56ZEZS?=
 =?utf-8?B?c0dybVAxb1ozQjdiMmdqOEl2UW1ZbWtiV1RNZVNYNjhiNE9nRDI1eWsxanBx?=
 =?utf-8?B?RmU0WFo2YlFra3BPeTRLVE00UG9ma2dhcEdjNU1iMTQyMnREclNscFFOSjBr?=
 =?utf-8?B?dW16NUQyd1pOYVp4b1l4SVR3R1ltRThSQlJBWGlYcmlIaHVCUk1CaW94Nmdq?=
 =?utf-8?B?dHRRbmFIUWJGYUVQNTRBR3p3VEtWbVREanlQanRvdHhuN0I0cExTc0d3UGpF?=
 =?utf-8?B?cnI3ODhqU3A0Y0VId2htQ1NYamFkSHZlVkV5OVA2RWhJdC9OZ2xpUEs3Qmc4?=
 =?utf-8?B?YjlCMkloUzBTNUVBTDFlbDlYaDFZWnRjWThOWCs1cmZrYUVIRFNHemp0UHpv?=
 =?utf-8?B?WFRGYjNDNlFHeEt0TnZtWE1qQWdRNWN4Nzl2ZStYMU9IdUhhVHpHMDIzYlZG?=
 =?utf-8?B?cUNTcEJmNHFnQi9UOUxBSkw0MktlQTdRYUpkeGRiQVZMaTBlTUpNRVo1N2Vj?=
 =?utf-8?B?QkhnTCtyQnpGQ0F1OUIvNm1kRHJwbHIzeTVmZGgzNjFzR1BKaDJaaXhtV2Qw?=
 =?utf-8?B?SGIyejRSRFFMVHBEQlVudUgrM1k5czlBL1p3NTk0UHhocFEwT2RhR0xHK0tU?=
 =?utf-8?B?RWl2V1ZSMFc0NGdHdWU5QXZkMVZWaUZxM3BwRlZwQ1EveUY5aXlqWC9PMEQ0?=
 =?utf-8?B?ZDl5UEVRdHR3cW1xMmpJZDNhUmluVzYxempmQkRlVmlGZlpwcVBvdXFWQTR5?=
 =?utf-8?B?MkhoQ2ROc05UdUhLTEQzUXg3c2FXeER5bXhUeDUvTmdNbi85OTdDWktFM0l0?=
 =?utf-8?B?dERZelk5eWtMSUgzOXdqVFBYdFNoblJKcnJRMEpodnV2VnFrbzE5MDN4NDVB?=
 =?utf-8?B?YXAvQ0ovTVFLd2c0TTlCZTJBWWlzcUJ0ODdXeW9ZQlQrODFWZ2FvcHI3L3Fp?=
 =?utf-8?B?R1VYZWNTZlgwUXA2M1J3NXZIek41OXJyZDBHV0MrS3ZYVUUxV2RKN1RnSXZQ?=
 =?utf-8?B?MHpFaE1IR0ZsVzBOOHRHcmVmYU1tLzFpZzZaWURBSFdmYlR0ZU4zZ3ROTTJX?=
 =?utf-8?B?NC92R1BTdWZrSGQ1eVZyZWhLL1NFUzgyNU5CS1BzUDZNMEJPUWtVRHdZNWhU?=
 =?utf-8?B?RWFaOGE1eGY0SXVMRmRqT1V1TzU3MW9CSTBNd0pVZ3FNZW1tVDdxZERGT0Zi?=
 =?utf-8?B?UlR3MGM5eWVRUWFuUi91RXBNOVgwMEQ0eWYrREQ3M0NteE95Tko0RmpaVWRh?=
 =?utf-8?B?L2dyamlOVG8vR3pPZmxKMFNjV1FuQWtIRitBUVhLWmw3a0Q0cXJBNllrQUJI?=
 =?utf-8?B?NmUxdG5veWRMZ0toQXJpclY0UXRxOEM2Mi93eCsxRGdGZ3dtOGJtVXhXby92?=
 =?utf-8?B?QVNnOGtpZ2VMM2xieC9GN21xUlJpaytHUTQzc2lVTVdYS21SbW5TcndzSmFQ?=
 =?utf-8?B?ZU1pTWg5Vmt0ekswNVY5TkdGRURmcm90ZFFHVzA3ZFBkSFUzVk5ncDArOUJm?=
 =?utf-8?B?QndRSCtoSHRiRlNVZXl3NlN5RVpiRUhraXRwY3FDV2FMcUZ6K2wzaFRxYW55?=
 =?utf-8?B?d3dyYkVUVy90Mit6MzRZMnE1THhUVmRlaDNkVUJQeXk1UzNrVUQ0djdzWnpp?=
 =?utf-8?B?VEorSFBvVndZVFIvZHZTSEFkSDFRKzAydHZmZmx0V25YOThMT1hsbG16YkhC?=
 =?utf-8?Q?dyn8ovbeARFVQzPIp7cUnB1ZkatX0jWW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STNqMjZqVHRQelUydEJJWG9jSUN1ek9zYW16SnJxOTFDRTJwT3lqVDRFdkpN?=
 =?utf-8?B?cDQveEFZNi83QmprQWgzOGlWa2hna1lXQ3p2cW9XcDRtL2o3UVJzZFNnK2xk?=
 =?utf-8?B?VCtaQXlsVStuY2RxZXlZLzgva0FDV2xVdmc3S3RTRFJkSVZsOVRiUjg1YVV5?=
 =?utf-8?B?L0lIUFJkQTNFZU1UaXdQRElSbml3UVNhUDBmcGhQUXdnU243dGpRbjFYUUhm?=
 =?utf-8?B?aG5pQmp4czZmdWZMcVJsNG82M2NoeC9EeWlOOWtISjB5VmhuQ1cwcU4wL0M0?=
 =?utf-8?B?MFBreHlpVjNCMVRqdkgrOU55VHI4c0k1TGFEOWdxTFI4VFc2VE5rOC9wMzdv?=
 =?utf-8?B?bEE5d1Y2YkwrMXZNNnFZczBHd0JRY3BBenZObk1qY3BSTTQycytzY1Jqem0v?=
 =?utf-8?B?cnlmS2R0c2tXUGp6bFB5LzZpbWYzSVcvU3B4UTBKYWhvRDh0S28yZWttbDFU?=
 =?utf-8?B?d2JXaW1VYUNqcGpFT2x1SVRWcUdqZG1JYzd3OExIYVJONFhmckw4bjY4dG0x?=
 =?utf-8?B?aldxNzAxM2RpaXBmWC9xYTI0dk9KSDlzZXBPdFcyQmFUODk1VTFOV1NCZFhF?=
 =?utf-8?B?L1dQbFg5dTYySFcvMmdPOFNtbUhNYWNxWGVvQ2JKQ1g1MlJBdk5QOWFWUTFZ?=
 =?utf-8?B?eHdLQUVHTHRjaEsyblNOZ0lpZHd5TDE3enF4cGR3TUZXTU15YlJqN0wzVUps?=
 =?utf-8?B?bkhReU9nak1LMzdKcTNLWTMwT1QwZWJqMnl3YWw1ODFaTThoL1E4dkg4RlBX?=
 =?utf-8?B?ZTF1VG1NcVBZYlp2SERIcmxibjcydDZSTnNhMks4Uis0N0hxMUJzMkw1WW10?=
 =?utf-8?B?LzZFbEQ3VlVFbHFwdENTalRRbmpKcHFrNlBsZE5DU042MU1OWWxEdUdOM1Ux?=
 =?utf-8?B?U29ZV0NGRE9PQkRJZ25zT29FWnUySGF6anhYcGlwRDNQMlRJZTgwSVdyYTF6?=
 =?utf-8?B?SVVkc1lkRGJBRWJqUW92TzFzUmptOFd3UzNBS2VrcUpNQ1loUlN4dVFWRURF?=
 =?utf-8?B?SHQzWEszR1ZUckREYi93bk1tMFQwMGhoK3ppSGVOaEI0MzBXaHNhTlJ1cDgz?=
 =?utf-8?B?Zk9uNkNnNmdHVm9XeThOWU5rS1phbXRWMjZrTmhNOEZQRnUwbmlVTHF3dzky?=
 =?utf-8?B?Vk55ZmlJK0lhZEppRkdLUWs0dUpBTG5BRWlSMmtoZHFFc1B2cWZ1TzNFL2Na?=
 =?utf-8?B?QWgxRDUzcmNUZWx1N2wwSVlMVkg5OUEzYm40c2d0am9XRU5NbFloR1pKdzYw?=
 =?utf-8?B?b0hEVkFiQWJlajRtK3NzbUpEYXgwUE9sOVd2Zml6Mkl5QVNVNGFVK1B5UjBX?=
 =?utf-8?B?MWZIb1NBaHFFL1lrWjNhVzRLL3BJYldpTWs4MFlSWmh4KzlMditHRzNPbUZS?=
 =?utf-8?B?MkE0SUV6a21GQk9Gd2t2WDR0VHVIbkZETVZjdEs1Vnh0RDFxZkphVUZtYmQ2?=
 =?utf-8?B?YXFqVThPS085Wmd2MDZzOW1xTExwU3B5U201NmJZaFNGUUd6R1dHSERiZkto?=
 =?utf-8?B?ZTVmRzdSSDlIUkJhWmlFUnhoQms4bFo0UVloNlNlRjFFZDE1aFhnNXB2TW9B?=
 =?utf-8?B?QkE3cnIrbVM5WUtZaTZXT0xQK3NVZWVMRm1zWmFRTVRFVjNibU5TcWk0TVpv?=
 =?utf-8?B?VFdBMlhLUXoyeTF3aTd3Q1dualNpQUpWMzlZNDNNbVNmWTE3OWQvTkNJTVVL?=
 =?utf-8?B?aHhSeHNselpMclJ3RXVsZWkrQzFqeVQ4WHgxVUVDSGNacDNrRmZGRUNIZDQ4?=
 =?utf-8?B?Sis5d2NWR2hKaFRXVGtHQ1NETVJxbUh6c3FGV0p5YkVHTGs0Z3VWNlhuNCtW?=
 =?utf-8?B?UGI0ZnJUU0xEY2U0NzQ5WUQwV1hqZWNCVVZNZUw3QlZpVllsd1ArUWZzRG1h?=
 =?utf-8?B?bjNKOWZjd3JkcHNwb1p6ZE9QUWlhSE4zSjlBZk9wQ29uR3ZoZXcrUnRRWWhs?=
 =?utf-8?B?U0NvM2FhZ1RERGR4cDNPeGVPNFhRUFVtTThmZmNScDhlSERpWUIrOHBoK2Vx?=
 =?utf-8?B?Rmc4cXYzWmN6cnVoTGdkN1V0Y1dmaU80eEZIdGtzNWsvZE9lSm82QlVOOWpP?=
 =?utf-8?B?THN2d0xSbE53NytUV0p2YUM2T2VzK3VvQzlBZ21NbkxmTEh0WW1HNU5ieG9l?=
 =?utf-8?B?cEt1enhtS1BISkxlTDV6QTJ3SUp3UURyQTl0VmhrK3g4SUM0THBBMGNmOVhE?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c21164-0acf-4fca-0551-08de117aadbc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:52:53.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01xCc/BUAnqk177UoxKbQ7Ha9HqGUM9YtKUx6nxAaaSOBvwFK7jahx42uwFCBbj7VGXxecYat1rMrqPOwouTlCxlysqCcVAbwoCcUEnCg0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4036
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----BED174A4E7B3169C9C84E4EDF2215892"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay36-hz1.antispameurope.com with 4csBx60Wlgz2HYpP
X-cloud-security-connect: mail-francesouthazon11021096.outbound.protection.outlook.com[40.107.130.96], TLS=1, IP=40.107.130.96
X-cloud-security-Digest:9f75291e295e0ddd82ee21679e946945
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:2.063
DKIM-Signature: a=rsa-sha256;
 bh=yryNR+teDhTEf/9Bej2QsewlIcH2w2YgsHPkqK16SaY=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761144804; v=1;
 b=AiWL+abySTlFDxkYkEpDVbXWsgzsCMcVtAgL688IGHz+8N19/c8a/6y5hOJNXVSUdvd0Ni5d
 k9pI7sdfl3Jy55djmHKZiDPy/1v/8/9cfzR5LtbyMT3elrML+UaifllKPbLnt2NrwAJJ1MrvD+a
 QvzCAkSakCY9JCqo1QUwgy0yTiEinl+Wp7gCljHSr3CANxWBydMLbBfOHUAPjeDqSfAJVDiHY/Q
 Z8QxXFyTgq+BF8GhO9XYwBRNR38G2JiqEtMCC4Hb5qxNP6+cXVLqkbvUi/VRk6EgrNxtBqt3KBm
 xK9DL7gOPJ1w3DWXgV01BdlANyNbB6BM+SR2ri3xIopCQ==

This is an S/MIME signed message

------BED174A4E7B3169C9C84E4EDF2215892
To: netdev@vger.kernel.org
Subject: [PATCH ethtool v2 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Wed, 22 Oct 2025 16:52:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Append "_thresholds" to the threshold JSON objects to avoid using the
same key which is not allowed in JSON.
The JSON output for SFP transceivers uses the keys "laser_bias_current",
"laser_output_power", "module_temperature" and "module_voltage" for
both the actual value and the threshold values. This leads to invalid
JSON output as keys in a JSON object must be unique.
For QSPI and CMIS the keys "module_temperature" and "module_voltage" are
also used for both the actual value and the threshold values.

Fixes: 3448a2f73e77 (cmis: Add JSON output handling to --module-info in CMIS modules)
Fixes: 008167804e54 (module_common: Add helpers to support JSON printing for common value types)
Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
 sff-common.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/sff-common.c b/sff-common.c
index 0824dfb..6528f5a 100644
--- a/sff-common.c
+++ b/sff-common.c
@@ -104,39 +104,39 @@ void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type)
 
 void sff_show_thresholds_json(struct sff_diags sd)
 {
-	open_json_object("laser_bias_current");
-	PRINT_BIAS_JSON("high_alarm_threshold", sd.bias_cur[HALRM]);
-	PRINT_BIAS_JSON("low_alarm_threshold", sd.bias_cur[LALRM]);
-	PRINT_BIAS_JSON("high_warning_threshold", sd.bias_cur[HWARN]);
-	PRINT_BIAS_JSON("low_warning_threshold", sd.bias_cur[LWARN]);
+	open_json_object("laser_bias_current_thresholds");
+	PRINT_BIAS_JSON("high_alarm", sd.bias_cur[HALRM]);
+	PRINT_BIAS_JSON("low_alarm", sd.bias_cur[LALRM]);
+	PRINT_BIAS_JSON("high_warning", sd.bias_cur[HWARN]);
+	PRINT_BIAS_JSON("low_warning", sd.bias_cur[LWARN]);
 	close_json_object();
 
-	open_json_object("laser_output_power");
-	PRINT_xX_PWR_JSON("high_alarm_threshold", sd.tx_power[HALRM]);
-	PRINT_xX_PWR_JSON("low_alarm_threshold", sd.tx_power[LALRM]);
-	PRINT_xX_PWR_JSON("high_warning_threshold", sd.tx_power[HWARN]);
-	PRINT_xX_PWR_JSON("low_warning_threshold", sd.tx_power[LWARN]);
+	open_json_object("laser_output_power_thresholds");
+	PRINT_xX_PWR_JSON("high_alarm", sd.tx_power[HALRM]);
+	PRINT_xX_PWR_JSON("low_alarm", sd.tx_power[LALRM]);
+	PRINT_xX_PWR_JSON("high_warning", sd.tx_power[HWARN]);
+	PRINT_xX_PWR_JSON("low_warning", sd.tx_power[LWARN]);
 	close_json_object();
 
-	open_json_object("module_temperature");
-	PRINT_TEMP_JSON("high_alarm_threshold", sd.sfp_temp[HALRM]);
-	PRINT_TEMP_JSON("low_alarm_threshold", sd.sfp_temp[LALRM]);
-	PRINT_TEMP_JSON("high_warning_threshold", sd.sfp_temp[HWARN]);
-	PRINT_TEMP_JSON("low_warning_threshold", sd.sfp_temp[LWARN]);
+	open_json_object("module_temperature_thresholds");
+	PRINT_TEMP_JSON("high_alarm", sd.sfp_temp[HALRM]);
+	PRINT_TEMP_JSON("low_alarm", sd.sfp_temp[LALRM]);
+	PRINT_TEMP_JSON("high_warning", sd.sfp_temp[HWARN]);
+	PRINT_TEMP_JSON("low_warning", sd.sfp_temp[LWARN]);
 	close_json_object();
 
-	open_json_object("module_voltage");
-	PRINT_VCC_JSON("high_alarm_threshold", sd.sfp_voltage[HALRM]);
-	PRINT_VCC_JSON("low_alarm_threshold", sd.sfp_voltage[LALRM]);
-	PRINT_VCC_JSON("high_warning_threshold", sd.sfp_voltage[HWARN]);
-	PRINT_VCC_JSON("low_warning_threshold", sd.sfp_voltage[LWARN]);
+	open_json_object("module_voltage_thresholds");
+	PRINT_VCC_JSON("high_alarm", sd.sfp_voltage[HALRM]);
+	PRINT_VCC_JSON("low_alarm", sd.sfp_voltage[LALRM]);
+	PRINT_VCC_JSON("high_warning", sd.sfp_voltage[HWARN]);
+	PRINT_VCC_JSON("low_warning", sd.sfp_voltage[LWARN]);
 	close_json_object();
 
-	open_json_object("laser_rx_power");
-	PRINT_xX_PWR_JSON("high_alarm_threshold", sd.rx_power[HALRM]);
-	PRINT_xX_PWR_JSON("low_alarm_threshold", sd.rx_power[LALRM]);
-	PRINT_xX_PWR_JSON("high_warning_threshold", sd.rx_power[HWARN]);
-	PRINT_xX_PWR_JSON("low_warning_threshold", sd.rx_power[LWARN]);
+	open_json_object("laser_rx_power_thresholds");
+	PRINT_xX_PWR_JSON("high_alarm", sd.rx_power[HALRM]);
+	PRINT_xX_PWR_JSON("low_alarm", sd.rx_power[LALRM]);
+	PRINT_xX_PWR_JSON("high_warning", sd.rx_power[HWARN]);
+	PRINT_xX_PWR_JSON("low_warning", sd.rx_power[LWARN]);
 	close_json_object();
 }
 

-- 
2.43.0


------BED174A4E7B3169C9C84E4EDF2215892
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjIxNDUzMThaMC8GCSqG
SIb3DQEJBDEiBCDj6g4ELz0gwn7+McIOThGYXIzUj1tqJMtRMdWnIR42szB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgCbCWHYlXC+
5VFG4u69dK3qfFadfIt9iLeCY78UkyHbFMXvtRCUF80iQJ52cD5OtWP7cVYdkd50
39NjvkYGbWGgHCZG9HlAjS0dIt/q6IT+4nssz6bq5sAMQYoiBSWN03YNSBQlV0do
NIclkBWh68/8rKVX4+A4C8npfIW61LnySpzTCVyeOvJIE892U8PWZJKum8Kk6plE
23iL7+ejM5eiexyH/47MR1nLnqHVpFmNsZ2/J/KaFLZJrxosNhVumD/iezYkYQAX
RHIVoOkdapuw4zjxFK5fVmyphcKA6IqzQnrsx2AivZ6XsP1VWOSkyzqQD7JMdYBN
2dM+w8JIw0b4OPkJ2B+XT/sszsDQLjonKKaUIuNwFMqi24HV2NonURDqpgciWojW
6kSW0MF8FaBq10WAORWQOpYNIGQaCXKZW3FWdC9Bdjj8/we/43A0ybquC8RuDMWE
WWRmR79O8KFoMJXJjWvqepHVnXyT4SFGwqAUislvJMn1AoqwmGXcQyGiktrEoDoF
1MO5FXDwwE8nS4tBj6Pm9jHJrGzWp51Aag++gRP0nA1L03faFNt8vfyhtgVvgz50
wia07XEdrZKGAyNy9Kb9xCemSi2NQZWWjaboHj6kU6ARSVWA2Nl4S3ZVC1Vnxw7W
Ze7t+Pyy1PQ9MI6jTO11hu7wPb7zulQ19g==

------BED174A4E7B3169C9C84E4EDF2215892--


