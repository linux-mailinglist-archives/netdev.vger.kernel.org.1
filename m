Return-Path: <netdev+bounces-297039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XA9nHuMFKGrt7QIAu9opvQ
	(envelope-from <netdev+bounces-297039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:24:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C72DC66003F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:24:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=I+kTjJqJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297039-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297039-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB91E30C97EB
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20840B395;
	Tue,  9 Jun 2026 12:17:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A1236D512;
	Tue,  9 Jun 2026 12:17:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007429; cv=fail; b=Pi8iGlpCSf1mNdLal4QUrIkUU8H4dYYl8L1v3dCalJd82x3KigV0ZYsNm1QZwBH804JJ33a5hPdLr91/r18vvAERNhIbryHRheL14t6/9aEh3xSc9I0UOt1ZnQt5jNUlkRXMN/sIBFOKIZd9QaepK7ytNDoU0DtytvlwIN4vKJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007429; c=relaxed/simple;
	bh=Xh/pNumgMj57JJAr3rp8G9C/lC+VM7d+t2ETVCLloC8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ivZB0abLwA+T0VcBFNzzOpJ9nDCrPq+1Q7Tt4PjNPb26ftXloS8IeG1EFEKKT3XWZUtfTwEfCq9ateoUeKC53dEZR6c5XGDsHVx2ouXq730i6jTIe9vqBb8HbFkJlWB/SV4JLgSGSWvAyzsCYPql9Og3L02otAFo5QCozh++npA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=I+kTjJqJ; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPYJRIcVTuqZQAlS/7J+PGysVJqdsty2A5P3ELANvkVJxI+AzNc5IxEygvGQlINZG4YpUA7x4z932RhwEba9WHuQCcqDEXtX1w/RYE8g7+VuepdkYVamL8GVhzR3QAnXMve3pA5OVJmbDaMBXbodauRTGDnF4WuV5yl8AYu3gkMog57JryiWB9Ng0d4gQt58XYFNOhMpB3+UohyY8Csl3CdssuQK/tLxKSy6itFnFIU+gw9mHxeYGW2a1VFM+lPSWVOk0Mab89XTJjHZ4O6FzWrHWZ+a6lMmoXoZQQTQQ78ExWIoJuZM4zksb4hGRTiFrPtjUGlCPZ4QgrNvvBi0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GB1yC/V8eLSiE59zQ90LXBFLmb9o1B6HdF6flVrL0ds=;
 b=uV0JpDMILVa6GrnFJXETcShIxK7EP8EVHZRY96bwms06LuYW+O+XrG9q5GhSYG8eHbWaZtXDcTqyEIpHGnzy35XJR3ClyRepH32Nd/Co8ob/aFlntHOjWHJTtBQnWZ8cEBrb1azGMnRFlvpbNARNTnb/y20YjcEv8ERujZQcL3RFnsiXU1aNDd77jmjUkuHoUAZV5zFTGQnsKbr6D683AmSLr1tBNzQPmkIbTKKVbRrX+HSR3b1ZjMzoAS+3e0zgAaApiuh5dOLNwNXq6xWtwn/3OxE5IUIuBiiSw1DNE1Wj8glKv0dQoyGilS8HN6hhkr3I2C3TAdvu4AzJg0pJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GB1yC/V8eLSiE59zQ90LXBFLmb9o1B6HdF6flVrL0ds=;
 b=I+kTjJqJnUchtyDSLrHPOhgl32vcaWfnJtBFyQz3TiYJZnPdG90ZQ0mKtyQ6aaZWaZ6keUdKcFUKnd5BGWPD/uvP6+zDfIJ1aN5UYXIRBqbZGhXM3vCyCRYFHu3AjLtoQZhuzgk/XliwJ5KBUPdSRR77XpREcyfz5V5A4CVgPWLicqLl+gMR6rLg/EIPAXsmt3a77KJ2/XQBTSGf4nqoiTkmH6qALPqqpYmUKECLl+/Bciypmsh6+XfMcQg6ljlqKBP/Cy7zCdI9C+tfYVH8RgAqclzSJMfZrgdUK12qWyMOufyKGkBY41LWiaE2cPmiEObmRl6CwlV75pgZZOG5cA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MN2PR03MB4959.namprd03.prod.outlook.com (2603:10b6:208:1a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 12:17:06 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 12:17:06 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: stmmac: xgmac2: disable RBUE in default RX interrupt mask
Date: Tue,  9 Jun 2026 05:17:03 -0700
Message-ID: <20260609121703.9736-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::24) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|MN2PR03MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c52400-3d9f-45ce-984f-08dec621055c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|55112099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zvWILDQBTos6e1c/ktRpaDsBftJCqk9e7VRj0XQBemakdxOTg97DKbsCE+8QoMx4natjQc9R0y3S3R9cvEaTgvDOrKgZcl+qhSMeoQgJzOBHHzfD+8/U642Rg0DbH/fgoWbhnAd9exB63z2wWkuBUDYWJ5J03ZC4k/jRqPTS7K4QF0e5RQWZoh1Tj9LrK51mVjZIqjnroO2jRf7NPm5VOz/QD2qbFGS3qpxet01oWUSd2XIed98tWmrIX1EgjmsXfNz3NUwak/Bgtbf0lk6zaNu6WcYLXcweWvDNudh7Lf64bOpvdCtmKR4lOIKkpidBYkrRWf3nhkC+vcx+BeSpg556KSI/NrYc1C8Rs/OY1YWXpLGvNxvGfGA9R0ipzqHXqxEjcSb5fY0hrJM0H/6PdksmmOfKJlTo6dINa27rb26bh9VIGmBWkKwVF45bsP6/x+s9110G2sRJyqKRGHcFXJ2KjvraEaxy09dekJM1oFW1ljplmMDdwqdCmdFG6wxJZzclLIO/cno4AQkhSLg2poBNE2SmffkQdqbIS9OWpNqOXjzY81soxfP0dUYXlESIZRmCX7knzbhIiEzCe4KnZYx3gjJhd0GbFt798au9VQzwvq5WE9SITn17f20Q+NLoUBb4Ca3/09YpeiFMLwD+VI3MdwnE/thnwEfioDesu8oc8GzV11Gv+0wqa/VSFRhM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(55112099003)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5fogymM6BPqxHZsXTYHUBPrBjHHict8Gpmduixq/owpSXtry84p/SkmAmYky?=
 =?us-ascii?Q?zVlelzIK0YmL6KwLbA+Bsl9zKN7BfqMcyW1yoTbkLEQmnG2m2qHmhGE1OONo?=
 =?us-ascii?Q?P7RI2v5o0Fuvop0zf1KsK1i5MSrDTr7QdhXgXfBSxlEJ/1S6EMlTDNNzZYQR?=
 =?us-ascii?Q?NV9dPKTTiM1bk1g3OpJ2K4ZpRTeN5Z+Zx/NmiDC62WFRhwN7kpsWm0RajDe8?=
 =?us-ascii?Q?uVYczlAz+Iupf8x3gRSH7yU4Gb7bKi6r4hRT0vXsQ4maclVCcs+V0TU5ytfy?=
 =?us-ascii?Q?8UNOul5gEUwV0AC5OTVfSf73ONOdhCR/sY6/E85rsa9GtIWIRzXF4+QgfcFi?=
 =?us-ascii?Q?S4kTRFcz4IMe+5VwpaJN4cOa1vzC9gttubQLoLqPNOOYFmnf1XDWm9UzF69V?=
 =?us-ascii?Q?PMNHv4vAHmtsvSc82qwqplHOwBWllWZi9FYIHszCTVB66b8mfFgGIH0rpiLc?=
 =?us-ascii?Q?Q8rexc0svQu0rrkgCxgS2dsPV0Rmp7TxAgWnZi4XUn6sYd6qJo7gHREFgCZm?=
 =?us-ascii?Q?XXgdqJjAz642eUAf/v+qO/KuzzPLldugKqkokVtMJcserMyQV30jlQQq/h4H?=
 =?us-ascii?Q?t2Ock55ffVhdeTbp5FP73dbEPMEa8PdUGmpZ4JBNexep6ZaVVxJd9hTPuL8l?=
 =?us-ascii?Q?Ap4LHyqq6XoD1ncV+fhwWlKbE+Z9mgZM6jiYt+qE5oATcU54J7+pWg+WDsK0?=
 =?us-ascii?Q?wuZeXbBHz4D9ZsSg5tX6aYXXFzQajZOHHcpkNptdUO/E13Lapu9fBUhgya2H?=
 =?us-ascii?Q?8OuMEGkCBNeTFpRuvqJ6CXAaG84zo8OKeInxEd9CV11RLtYbJDcBsVPFV+kk?=
 =?us-ascii?Q?8YUBxr4n8JwKBvuDUU4aoyeNWcANKiNO6JMYgHlmFCsluELHpNuzkb5czFMU?=
 =?us-ascii?Q?N81KdLRBDB/jSVIX3//WtxEpp8EtpifJ7YTOWt+yvBavn6igaI4rdeRhGZit?=
 =?us-ascii?Q?xgqwUFW3cmZ0Rx1dnbpmSl7qWWr/cpePYRC+PyGw+KpaX1LNykmf/AeDureJ?=
 =?us-ascii?Q?gGqN9eOXYVpum7HzK0tgWT93qdMLFenf5qjr5Z+btHBI/e53dRTiqRTcFqhQ?=
 =?us-ascii?Q?xjqoYKiQKJohOIjYlXhqvoS8SbsF9xvi+Dm+BnJYMjYTfLH5+t/r7NtYB5LV?=
 =?us-ascii?Q?6xkDOgHmwxeLiTHnIqBQvKXXUKYarAaRZjEXzycFKpkLD433JOUGlbIKtp8H?=
 =?us-ascii?Q?bNw1DA+H1NGNwPNpMx/+i4AVFSX2h5Fsrj+B4RxPxapCkvf9porUAcyCAn/C?=
 =?us-ascii?Q?rg3c6vomh0ty7BtslKbcJVGy0XH44UrbcVqC9/cuvRc6Aob1rKQMbKzHW517?=
 =?us-ascii?Q?2PxjKyflC5Du9d4LFKDID3LKuFZLwsv2zY8R0AxleZZY7PWjSxK1vLZGsw8i?=
 =?us-ascii?Q?VpopQGIrb/F30LbtbNmC+Z/vboeGEwLfhAYrSOaJ6ONPM+mTpnnHlOTSL9bK?=
 =?us-ascii?Q?3Vlrgepm8S6cv8XHkvcyD7hdFj4aKoS+zO9WMMV7HKa2pi6OKYoE3TUVRSM5?=
 =?us-ascii?Q?EqJ4iY9vKKT4PEtEmvwlu9FRodPD0lFW4DHC3hi+gpE4Csi1E/1xVhfQHfl7?=
 =?us-ascii?Q?uQuXcbdfgeRi4ug/bwfRRc2StdA1MRRVJ0d8+BCRM/BP/i4D2UrCCcAaruYN?=
 =?us-ascii?Q?V2BhZ6SePWQgdWj18kPSSCJ0LwuDBslvQb12PYedtINrssLUzUzmIvJUp8i/?=
 =?us-ascii?Q?tSa7uqf/JQabDRYJbUchL2R/2iROcCJHMZVFpsP46eHmr2t4Gxk9Aw3lgGkJ?=
 =?us-ascii?Q?W2UA9KZZ+npu3IoaBIpL5PeeAaUZNj0lmi0oR70l6sf55S6azYFe2Tv5t9Wd?=
X-MS-Exchange-AntiSpam-MessageData-1: q06KSfzuKJjPuA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c52400-3d9f-45ce-984f-08dec621055c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 12:17:06.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAy/5Ug/usQiO6jR2E+T+/vH108DJ6xCodjn6hBFDX7CnaY/NXhKqVti+asOTgveOwca17cETLdd944g0Y9BwTyMsnIVmbJMvlDIIrPTtd3DpJQIMEvHIx4v/hBnfnRdJc9PjL4uQ0JcQMNxQ/rHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4959
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,synopsys.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297039-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C72DC66003F

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Enabling the RX Buffer Unavailable (RBUE) interrupt is counterproductive
and can trigger a MAC interrupt storm under heavy RX pressure. When the
DMA runs out of RX descriptors it fires RBUE continuously until software
refills the ring.

However, RBUE is redundant: the normal RX completion interrupt (RIE)
already triggers NAPI, which processes completed descriptors and refills
the ring, causing the DMA to resume. The RBUE handler itself only sets
handle_rx - the same outcome as RIE.

On Agilex5 under heavy RX pressure, the MAC interrupt (which includes
RBUE) was observed firing 1,821,811,555 times against only 2,618,627
actual RX completions - a ~695x ratio - confirming the severity of the
storm.

RBUE does not provide OOM recovery. If page_pool is exhausted,
stmmac_rx_refill() cannot advance the DMA tail pointer, the DMA stays
suspended, and RBUE fires again on the next NAPI completion - a storm
with no forward progress. This patch trades that storm for a clean
stall with the same RX outcome. Proper OOM recovery is a pre-existing
gap outside the scope of this fix.

Note: as a consequence of disabling RBUE, the rx_buf_unav_irq ethtool
counter will always read 0 on XGMAC2 devices. This behaviour is already
inconsistent across DWMAC core versions.

Remove RBUE from XGMAC_DMA_INT_DEFAULT_EN and XGMAC_DMA_INT_DEFAULT_RX
to prevent the interrupt storm while keeping normal RX handling intact.

Fixes: d6ddfacd95c7 ("net: stmmac: Add DMA related callbacks for XGMAC2")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v3:
- Clarified that RBUE does not provide OOM recovery even when enabled;
  disabling it trades an interrupt storm for a clean stall with the same
  RX outcome (Simon Horman, Paolo Abeni)

Changes in v2:
- Added performance measurements to commit message (Maxime Chevallier)
- Noted that rx_buf_unav_irq will always read 0 on XGMAC2 devices
  after this change (Maxime Chevallier)
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..b5fdc253a2f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -379,9 +379,9 @@
 #define XGMAC_RIE			BIT(6)
 #define XGMAC_TBUE			BIT(2)
 #define XGMAC_TIE			BIT(0)
-#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | XGMAC_RBUE | \
+#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | \
 					XGMAC_RIE | XGMAC_TIE)
-#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RBUE | XGMAC_RIE)
+#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RIE)
 #define XGMAC_DMA_INT_DEFAULT_TX	(XGMAC_TIE)
 #define XGMAC_DMA_CH_Rx_WATCHDOG(x)	(0x0000313c + (0x80 * (x)))
 #define XGMAC_RWT			GENMASK(7, 0)
-- 
2.43.7


