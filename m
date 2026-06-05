Return-Path: <netdev+bounces-295732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UItKNJCRImpEaQEAu9opvQ
	(envelope-from <netdev+bounces-295732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:06:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72049646AF7
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:06:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b="Qt/jZc9Y";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295732-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295732-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F67E308492B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AF64BC00B;
	Fri,  5 Jun 2026 09:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B864B8DF0;
	Fri,  5 Jun 2026 09:01:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650082; cv=fail; b=NFm+srTVg/i2mdZGq3gM8DplW+cyRa3zDUotWp1XKwcowzLkB7RaR6g0UxNj5BgbI7FIfCdT5zzYy69z+1i9/+0KZEXIr4k70fJFrRcpSpfUtodea0fhKbOORVXgwpQWe5OR+jchj0kVjbSeGVahG7LGC+T4vA47c/oHUNR0jVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650082; c=relaxed/simple;
	bh=j1tjeByXeIHinLjHoJARApYbtqw5FLZrQo/H1IVDTic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VSY6OQNCoIGsk+WeQOevAGkwv10stQVeVZqTzk9qLgsv5/UtIsmJ0z5TFHqoi8j53ThM9GKi6qzTrYm16RmvAq/VtnclT/C8VnouxVoPLaXpKMa4Tiu1pHmoVg8hlZsnO5QnN2UnFUwLtLBHs/LS/F2F1zffq6tbIKdZu3aiMz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Qt/jZc9Y; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEDroIJplxRpFWjqM57lElh1Yaqy2M28HaPYumN+f+RgUtmD8wMnx+FmVaBzty9rvgMbo06ei9L1/ZIfgrHnhs9kTNkzqaVmMG1qRvCou5qshmmYawmHvItlUzp7+Eiw2JMSzK1HtbOI0TAlEmKoB7O6AGPQfbZ0vsNdne7SM1kwUVGgqqQ4hVDMX2Uz/B9DMlh/LwcSbRn/U/IocHGYyt7PDpKhQI8/hzUfVFS9h2UWuowJHTTFmFf98130IC5bw0uU63DzazmBLEjn2OCV7s0wAMEvn4IOZ+KPe7KUpX5jv+gFqCZEY3YIYZT/bSRpSm0ME1pCXQPCKvx4U+5chg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=td+kIW4Ka04jL1Gvf/U6zGzfcIX44TYRoFobx2NUE8+TwZ24EeoBn+MD8uKGN1i1ltasi4FgF+SMQV4gA4aLBDix6Ni8vscGIs3IVenPP2P6QHQFKL89cnT4C6CGGiOPwKDZr0gak5RN1fcJW/pnxhFWVrKf5oIhy2pIt1aXFv3IsXXSjKvxjumdVxP2yO0Gt+VCRvn5QZa2ozmV7NpqkmNYhF9KwI6d0n5Jm0RwZ2z3o4KFP9Gokbgf44kdxEuketSwq0U9rwiYuPmUFR0tLc3t4MgYvp9Wuvl2e75XMUh73vhUv8B48QC8uxHfS0bYr4TC+/hBIMixEEmtkJ/JXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=Qt/jZc9YR/zneBdEu/MUX/vnHZnBIqHbj6CThU82Q7WEyTPugAUr/bIyo3xw7Yw/AhQNCFLguHA7/kPy/7oEOUEvUkNBO0SAhhaxQyTbVcyfNj+VPLagTwePlQPKO+Lkwoq6Ig3+4xQ4cJX8cwtAOil2QUdl0BlgmsSU2k3Tf4An5/nEqUD/7VISomYQPc6JCM6hc+jWK1fN0vG8x8ayWTMKPoA2mT0oDIaJ6vrW97nHpf8Cwp+vO6XV72afOd7DZvyRPKUcRkuadyt4saojayRQ7xOnoUuEdzQfHYdSkcrNt5x1MoZnZFFCbffTv2Z6q6X7b640ffsejAM3DMwP4Q==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS4PR03MB8472.namprd03.prod.outlook.com (2603:10b6:8:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 09:01:17 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 09:01:17 +0000
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
Subject: [PATCH v2 1/3] net: stmmac: xgmac: fix l4 filter port overwrite on register update
Date: Fri,  5 Jun 2026 02:01:12 -0700
Message-ID: <20260605090114.16028-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605090114.16028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260605090114.16028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DS4PR03MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c24ace-0e65-41e1-bc19-08dec2e1009d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	tJQhpQKit6Cx/9iS82k4L9gIhfO5dCdf5BBiPIO+SbAU6j5EY+8ZYHOjd+Fi0TnHDqt/BPmXRXdOW+YWVBNc+N/XNWXF8brVzgINld2Kybp1cSmKE/HxLkKHqlI6cn+6iYV8VWT3/joPocRNCbPQhTnfIn1GI+wnH63/1/Jwe+Wi3ny0DfS3JFqlEeiFF1GakRiUtBPvUaezQXBp6csuqmv6PbfzNZmOaapbPUYUU0+f/cgFlmTj0MmxUq6fDmBgA+ehpMyZ1x07VWhEZvKRRwQEv3qIqLsSazrVhmsqc+f+buMTQVJgNAXxhshHbGBR2GB3OZnHJu16v9S0W4F2KKMx6BiBOUKLF9lP2ZPZKgvk91kaKbv0HEphuvczKwI2kcCWC94loZcwvUhvKXnrgv/+u0+v+xj3cq8zv91sUgLeS+GrSSgm80O8QcYHVDRP45rNa+SsspmjqS/gFjCAJyYorjwp/53ZXKf6pVQV3dN9AlJ4/CEVpoRHXafCqcum+tLW2XiIMYu6IejMNUYANk7Fh8PCx+20HdqtOBdZi8twmJ8Q/ekOF/iS5bpf8uCsBpZ0IV8gMBhicsJviA7E6PaTGsCScnoqoCo0qfecLkmyqa8XETaZEHZTjDYE6YLN4nl2eUDjzGP+hZDASibbLIDZsPlcegwU8eA9XcFCEpFqaYmmFn5p0x4+jvIFDTPW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aFDHRFQRsaxcrXFqX+M696IcqQYsdM2eZ5C5E7tx0Fi0XArx2GfOyrYW7aAt?=
 =?us-ascii?Q?T8bIYBJNbUa4YHsRS+YXSgtROPjUE3p29BcM7UzxNwfHIIX7hvKsT6VTDMY5?=
 =?us-ascii?Q?fjhcREvkc2W0myZeBfFvHsobD7lI84QQqGQ2iuIWPumwJYhEEQL/mr6xEkh3?=
 =?us-ascii?Q?CBMsVFBF3XILfQ9gJCjKOKQqpWtbTPW2VmIsF23XXTPLlpx1l4Y6ZzWMIK0R?=
 =?us-ascii?Q?zghOpWtgMKfYCWF27LrY/x+fCR+w51EG6kdg1f+TnSw9BA7EcvJndJhL2yLf?=
 =?us-ascii?Q?wkeVc8YXB+xvhY55tDN1UhMJqDzVbCjTwUIbu15xWk3IiofngxdbsrcjxnLS?=
 =?us-ascii?Q?y/dH+6k6MsG0HHQ32xP/iKNcsnC4BrukV1WJPybGUn/E1l21rBmy7BYvrV38?=
 =?us-ascii?Q?F56/fm3m7I/ODl17eVflysIrnBNfhcFpVMMIJbv/Z6aHD4Nyyd13Hi0p2mku?=
 =?us-ascii?Q?x6/UrgX2j+GqO2wzkozcbGyz3IEtp8cxKFIrMgro5pJ42IwYsCO8yFpK+PM8?=
 =?us-ascii?Q?dr7imB/sDDt9q6N6Li2b7HYqFtNi+6Zf4mVW4TsAOTjPowWDzGRIpOqRCTc2?=
 =?us-ascii?Q?rT5BgrLACBGfoTShq/el50htfOusNDVYilSexE/q5G2/2gTwQ/ENi/VNp0cL?=
 =?us-ascii?Q?ry8svrfsEYI57ZVclh7S6p9tHvYhUNgjIvd2UFdMwE8CuZTkMBPDSp5GH9bY?=
 =?us-ascii?Q?1HUgRWGytCZFc7S6HDjvEVyAaiIcDiqJv+Vv8cbv0Y+MJ3HB5djK5B5rdGF9?=
 =?us-ascii?Q?4rB+RbvtfuOXZ8ErIbgxytaCbFqlXVzDInO3QGdm4mfrASdXw1gkNa6H7Z9t?=
 =?us-ascii?Q?laTNwCbWbjoDfzqfudB/6KmsDYUsjgd02KcDbA0zKImUjBZyavJBTdGbvqNA?=
 =?us-ascii?Q?xQ5YxnViIgm3lkPXFbifbwSxvup1MXjAeKs8KzNp/o2ktwwTTagWzSYpTVhq?=
 =?us-ascii?Q?TTgdNU2XnsM0oFanH9ppWujEovemNpOr6sYAuvQEEY+b/5JoZfET7sZiPb6o?=
 =?us-ascii?Q?6/0Ew016LW1MfZO4gtjiYT3mxnJmZkQSnVvZG6xuuboPoC9Pbn/pPh2yfQ5r?=
 =?us-ascii?Q?PD0+sKcD45CDJnha4FHElwquqvimirHzsiRli6GjHVMqo16CtA6PfSkBmPGV?=
 =?us-ascii?Q?hApZVzddgOq8rxseNh6uxLUEK4suDbjQpyOCnHhvRN5gTJKNMEJzVot9DcNE?=
 =?us-ascii?Q?lwjjjzJwMgqgulaG72qlPMRH4/nUw6sKxrJXhf9MrHL5I5x/Qfof0G1EqNrc?=
 =?us-ascii?Q?ICmaJun+i4AFCR5J/j64Q+v6t/92NTAo5g4SA8mqVg1ueibRC2L2U/rmTlaD?=
 =?us-ascii?Q?byLVrHIJK101cM5hCUooQ5970ohSTdNiovC69IBXsb1VwRq5bGulG3V6ghvG?=
 =?us-ascii?Q?vE0H9IZ9xbVM5FP1k9GxVR4qCKfMHqH5UuJJlTVGshrtXTL6wFj++5xYBYKV?=
 =?us-ascii?Q?I5vgMePzx5nnNzi9BVxYAsCpEzXMA3DxD/4FYyl+s87mf6uq0AfHOkm/cUOK?=
 =?us-ascii?Q?61UpBSNMVdxe/TyYW6yct8QraCpeDV6ZneIuCRhsxKU5pTFV0d1LYbzB6mqj?=
 =?us-ascii?Q?w+R1zvuhZ19xtlv1ZnXM6dwdcGn9KgVYDiseozT9TPt0lv+c56q8gMgDnrSm?=
 =?us-ascii?Q?p6KYjlZnasR3fN0xYOzppeztE2DRQeexGw0ogKlq0fGEsj5wARlkIFh3/6rs?=
 =?us-ascii?Q?xxko7u1IKSJ3xdjWXzNFDuzg26vhRVcajmHy/lgpdG9SQNY2cSdnMV7/+vmR?=
 =?us-ascii?Q?7MJQV2/xaszzUk6z9eIfSKTeFX1Yk1SS7ozpdDRH2H6Ntl2dOYPM0Q+8se63?=
X-MS-Exchange-AntiSpam-MessageData-1: EpMFsJK1zwV86w==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c24ace-0e65-41e1-bc19-08dec2e1009d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:01:16.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FK24GGP1xsbnj2Dcu1o3mAi8eWnHz/Dnmx3ox9Guf3ySqh0CJcP6WdPLAthWAQdqJ+82FBrSZzt0YGr0/pswag2ITjxPQKGgSSiLiMylH1yTapvHDlQS9s5M10HHtZw8dKy6ba/Pb2hKea3LguhbDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8472
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72049646AF7

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The XGMAC_L4_ADDR register holds both source and destination port
match values. The current implementation overwrites the entire register
when configuring either port, so setting one silently erases the other.

Fix this by reading the register first, then masking and updating only
the relevant field before writing back.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f02b434bbd50..52054f31376d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1370,36 +1370,40 @@ static int dwxgmac2_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 		value &= ~XGMAC_L4PEN0;
 	}
 
-	value &= ~(XGMAC_L4SPM0 | XGMAC_L4SPIM0);
-	value &= ~(XGMAC_L4DPM0 | XGMAC_L4DPIM0);
 	if (sa) {
 		value |= XGMAC_L4SPM0;
 		if (inv)
 			value |= XGMAC_L4SPIM0;
+		else
+			value &= ~XGMAC_L4SPIM0;
 	} else {
 		value |= XGMAC_L4DPM0;
 		if (inv)
 			value |= XGMAC_L4DPIM0;
+		else
+			value &= ~XGMAC_L4DPIM0;
 	}
 
 	ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L3L4_CTRL, value);
 	if (ret)
 		return ret;
 
-	if (sa) {
-		value = FIELD_PREP(XGMAC_L4SP0, match);
+	ret = dwxgmac2_filter_read(hw, filter_no, XGMAC_L4_ADDR, &value);
+	if (ret)
+		return ret;
 
-		ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
-		if (ret)
-			return ret;
+	if (sa) {
+		value &= ~XGMAC_L4SP0;
+		value |= FIELD_PREP(XGMAC_L4SP0, match);
 	} else {
-		value = FIELD_PREP(XGMAC_L4DP0, match);
-
-		ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
-		if (ret)
-			return ret;
+		value &= ~XGMAC_L4DP0;
+		value |= FIELD_PREP(XGMAC_L4DP0, match);
 	}
 
+	ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
+	if (ret)
+		return ret;
+
 	if (!en)
 		return dwxgmac2_filter_write(hw, filter_no, XGMAC_L3L4_CTRL, 0);
 
-- 
2.43.7


