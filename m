Return-Path: <netdev+bounces-307343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mzqBGZmhVWqcrAAAu9opvQ
	(envelope-from <netdev+bounces-307343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:40:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B75BB75069C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:40:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=dmoP2xuJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307343-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307343-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 353F930F5C41
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042DB381EAF;
	Tue, 14 Jul 2026 02:37:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180F383328;
	Tue, 14 Jul 2026 02:37:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996660; cv=fail; b=NMm++a8lxYrSQuvvv4RSZsvN8Co+vVTuXinUuK4FRMIcfqpvxtMeJYs6h66vaSGNMkJoPohuQep39mUK1MKOQFrQYP85bFZmv6kxOoYrDUclUc6kY8EG3phROhIELtldtkv9OF/pHkFrPgZvIsvfgpI1NJhK1mIzPGntXIvq++Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996660; c=relaxed/simple;
	bh=vXJ4n6FkjeJt48Y0bUSonF2Ja9KQ1s7xDHCIP/b+Qik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwAJmLEOKHtwC9X8WjaPaV5+kwZ7viWyAq5xI/NkL/HiWrOLqbfxlRCa6NAPdiyb6ysSi6tcrO7RSnKffzJG6PEl990I0x2w7Leh01bxhKcRavO5KuCY5R4WIVPdXdtsi32MGL9R5wMwqs4vEIAp/Q7/IyLsdeSH+63LmRKlC50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dmoP2xuJ; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qv8x6o7XCnZWO6WKdEBIXylnxUJgpqKvU3bAyoJI0hwzwM9kTFauRAivJ1zDvqSJsGOMVeG7gqZ8xr9IWutgnTmbdviDWDcWfcD3zvSgigK+M8jj5fV3Co3bQHqWqS8fg9gtmWIZZMRNPToF+UUWNjjhtncp/f45XKZpcn27D8oGvYxhHM9EMiziGfH6z5c+E3OSmjAR54IM2xUKj7CmSYe6Ukc9jsioZUYIeJ9TPdHUb7rGPhXYiLeXwgcZOciZ93bXf6sZ93lGmiQx1KSrI7wERUJe3eA2hVAr4+Yf5v0LR4QNRpAJRbECDwsAGsLifoiuorLDpBYqjERFIjkEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohQMI1sj2QytgtCyi8JP1WbtLnJaAmpjScQmKsP/PG4=;
 b=BKf5XA/WVBkYHvfQWgmxQXFsFqmChDQ7+Ye8p3XaRmSvwKoMJsRTyJF1jWNfBtLKFK2DZIBqgGW4ExRuhQ8foqNvKPtLoe8D+aAieKIVoJxn1CxpqAon2Qv2HkjfYhQpP7rS5vKKagbtAdrae2M88IPAkux4w4EBD/l/8zrRj6SusmV3NBBmIbmr58NZDDL+1kZG39KqWG5Wox5wmWm6sZ67ifEQJ/OsDyCVGGGVw1hft/OKVV3ROtOWbGKs7laYlVHwC2/XPzXwrCupRUzb7q8bw1Tq3IGsIyvpyz3dlWRvczma06Tn5cZK1Yd3f3fY1WGslUnCtTLfRZ1BnAXWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohQMI1sj2QytgtCyi8JP1WbtLnJaAmpjScQmKsP/PG4=;
 b=dmoP2xuJ0flDSHSPEbjS2yx3lX1Inz7T+BUQMPoNgItwt98VwvXN3imMFO7P5cyA9Rd54YJPCdBtRChtp5C4jgWJ0R7mwv+fbHNswGkyvGg7euGv6bcN6tojk3orUGpsrGTNl5/GjNkqU88bU13TiYZ68mu1vL7x/nvE7UsWlFxHKHQpKCH00H1IkSQb01U1gXZHuk16aowjo0nU9JsX+e4gwKnoEiQ60xmPPyt0sCh4HZgcddPbhHQT/eQJj/gySN2BtJA8LImpVyk2O9ItBUYgjAT7StpgzznSdd9T38Nf+IGnJo0TzLUIewm2f/PcNU0imr1hHkf6lZJGfUpRHg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM4PR03MB6032.namprd03.prod.outlook.com (2603:10b6:5:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 02:37:18 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:37:18 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 3/3] net: stmmac: reset residual action in L3L4 filters on delete
Date: Mon, 13 Jul 2026 19:37:16 -0700
Message-ID: <20260714023716.29865-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DM4PR03MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed50ab0-d380-4739-aa57-08dee150d2e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	0eMou3/uG98XIlMt8vimKXbs+pu/A/PL5HGj+B9gskqeHplEjVJtFsqRYKPzGbpiV9Wxlwkwhs/IC4POmuvOn0I8opxzP8FlRT6rUCa4sOFI72ahU191/RirAeWPY5r3qd9rYX3SVs93gYL7TNW5BM24T6NXDrcJKt/ybBU1XI+HkIvWpfoLenKtbPxpDuoI94i8xTL3LeruRfcAvrAI5BGhkn+raVFoDE335JBmk37pRFqB3tTKZi2gv+s4dFPHnaA1JL0zX/7Q6a9bAthOW97GslcP4krcYUz/vyNIps6a7q+huNKoqXKPUAcbDngrF2+9vps/kFUjDUQVtmoJ4LLRowmYmYYOjQEZc0eBcVOVF6jfrVQfxAYu0oRiphKL8Kkt9uBiKB9QvaVU2Mw0uMJ77h49jdwkamGpEB0pQ9dJHfS45wAmHT8MJlKOtyCGWtMwqWSS27D6PI9FlHnKkjTD+EQ/QMJuPbLJVSgSBmbRUpzbdMKsoNcK5ki1TG1sYF66sngyVd4GXkxkKYejPsAE8Adajxpe99GbQOTZ3HYRaLesNe9beH20wajHL65HrQk+jVwqD9D+O3L6STe/ZhopEW6NNTkG7HjtOXEyJc6nG3PmdEQzROcKBbLAM3cYxHPst6J8S6QQbY5igI2ZZdLWIeyLEZc3xdQmzp2vOWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHmuu5O0OuWxX7XOEn8zl+NUWjv3IdFtgow8XTi/SV21aezfgXFMO6+WlOrr?=
 =?us-ascii?Q?ke27ZklDbY3MJur+Z1phL8ovK+Kql6auxwQsm7hJz/babn6hBGOEwfcYeoJF?=
 =?us-ascii?Q?bO2JCYiRxjE5VdXJ32Yi8wWzVAN/haUlBW3rMcU/OJIGl6TNlzBFP+b+27M5?=
 =?us-ascii?Q?vsROuYCjQ3z7qmWGGF4Fda3tVqEzJKWcTmZKAhDWqcBA68yMUMw+jltJI8l8?=
 =?us-ascii?Q?KFdYKEBii8ayoMvL7P4OQPxgaz/YYSkGjLotkEdtPo2ISAN3PXwUbEgSTqym?=
 =?us-ascii?Q?1hcT0LmWYLGqvaGdypVTfrUqY4xnNel8yTJ1pxWHC0Nvu6hlyDNH53CzZ3ta?=
 =?us-ascii?Q?k0wRRYFHh52TJu2iWa6QjgHfuJPa6KXIw3mbZg7ixx7gUaShHlqHU9kWY3lJ?=
 =?us-ascii?Q?Q2vh2oHhtzk8uQtelA5GWMkcV9wUx5m4joyiEohePrZsmcr8bJgs+xjER8Un?=
 =?us-ascii?Q?eogfmajiH3+Qm0C8+VFLcuvGH1tZNWyoUs9IXfT5fiJ0EpqPlu5D6MSL/HG2?=
 =?us-ascii?Q?tgtqUu0eiJjUakr0gETeluROdshAtUX59NfwqO7IqDuDWpLucheuMQuu4ugk?=
 =?us-ascii?Q?2QjDQM7nDmRJI7CqGwBkzkfMmpvHGgEmoYHxESB6tf51JRaTfeFbtNJuIvvl?=
 =?us-ascii?Q?/6S3R8N3bKVUXu8heJ0cwpzrwf8XbjeyFe11m87sTc1iCcX84YAmCIZhxXi7?=
 =?us-ascii?Q?SAqq70WeXLBAwLMydNAgZw1UGK9kUamn4bO962x5aci0RqxhXFiCA8Iq2Xa1?=
 =?us-ascii?Q?kz5OTOTokUMSLQ0s+DrqReDHNwCA93MYZNyViUHF4qgdBZefH+bsLsIVj/2U?=
 =?us-ascii?Q?LKWJx4mh8qxF0Q6KmTKY2QCFW5O9hv2Z06qAF/ODU9XrmSFjzZnvNH4uFvmU?=
 =?us-ascii?Q?rn6R4Gm6ryBnC3/rfRV8kj1tIuh0Uc+Y3z2s7M46tv4JI0azT+wi9N+P8RJB?=
 =?us-ascii?Q?73DDn9uFLGFwyHHyVYZ1l3T9eMsNhhY93R6Uilllqqx2XyK2DiVEeUUZRxzn?=
 =?us-ascii?Q?KM2OsDTRlRKAUgIZ6E6iCp6R6xOnDeUM1MaTPnWEc4hvt8jD+0lnw8toy2Iz?=
 =?us-ascii?Q?/uxvfugNnQfsvDCipfArx4zsFpgMGSH9WGp8+0AQAgUPwAq1NGUwM3s/+haP?=
 =?us-ascii?Q?EJWYJAFZZ8lwanHAQzT5cYTgLUaatX1pDIbtWJc6Zn3WAL9D2B11xHa/3UuB?=
 =?us-ascii?Q?HivywC/g/N+YofDYUwlNX5cyATElucpWfveo0NJ1DHeT3SmYES2u3SMbpOnx?=
 =?us-ascii?Q?rF6DjvpBk6ZJhRoemz4XB72kXAJ+qSlAx7emO3SkIcLcI1bbNaEYQHw1p5bh?=
 =?us-ascii?Q?3Kvjmf/OraZi03oITwQX+gtuayY10QQ8BtFb7vCaE+VItmQzBm/JPlUhzZAy?=
 =?us-ascii?Q?HJMFxoI7mhU6f12Rbl1mAPMbD56JJYcQpm9VZbpH6hszvx1iaOpHZ1r79Qoe?=
 =?us-ascii?Q?omLSq0quzCVlFVxBCCHLtxAKhX9/MrfHBwEtTOl7JBvBPgnv3SzeVywuOCCU?=
 =?us-ascii?Q?3bKgaObjk/5zIaTAf6DgCGwL3S9a8ag5CDzgYuRhbUSGWcgZ3QWEQw3IrZsm?=
 =?us-ascii?Q?iZruhFh60E7vnEKlZbhFexKxJLvGUAcf+rKXQKlXYTVPcOUbkA8QwlMkGKLf?=
 =?us-ascii?Q?Tx7Rn4o6Az3LZezgS2kd8XF9Pw01Do6jMbLE2kwlRcIDjhGznz7OMDHooJcK?=
 =?us-ascii?Q?A4eE4oM8zKlmyzcTtD6ICK7nqKJG6BkFW4C96jcOQ8vWULhMuwQy430dljpS?=
 =?us-ascii?Q?Bto5bmqbTIep2I0lSYfJUv9Sdi17n2Lq52EXCBnW9C8YN3oogJQ+9NI1TJ7C?=
X-MS-Exchange-AntiSpam-MessageData-1: w2YdoDKRXFbVIQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed50ab0-d380-4739-aa57-08dee150d2e0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:37:18.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnxVZPwFPSr503F2eYxVsjyzVyXM7uww7634jBVKHrZG9LC1UraoFtjWGWliH71PhRsJr9kKbhnthKI7lqGVVIna+RNf/JXDC+JLXqVU4cIoQPBkd0qqLmaHb83NVHhrEeaCTYXG0HPCncohrT3oZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6032
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307343-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B75BB75069C

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

When deleting an L3/L4 flower filter entry, the action field is not
reset. If a filter was previously configured with a drop action, that
action may persist and affect subsequent filter configurations
unintentionally.

Clear the action field when the filter entry is deleted.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 1f8c9f47306b..14cabe76e53e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -661,6 +661,7 @@ static int tc_del_flow(struct stmmac_priv *priv,
 	entry->in_use = false;
 	entry->cookie = 0;
 	entry->is_l4 = false;
+	entry->action = 0;
 	return ret;
 }
 
-- 
2.43.7


