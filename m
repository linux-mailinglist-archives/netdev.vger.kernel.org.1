Return-Path: <netdev+bounces-295602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JnpDEAQ7ImpNUAEAu9opvQ
	(envelope-from <netdev+bounces-295602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:57:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B94644C50
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:57:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=UJmu3cS2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295602-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295602-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B07B630193AB
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A53F3DFC99;
	Fri,  5 Jun 2026 02:56:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74E236F419;
	Fri,  5 Jun 2026 02:56:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780628204; cv=fail; b=ewJw2VXGFPRxqOorCJOmzHJKkYp2Vk1+HQMn7LgWfe2U7Juq1wz9D3DQKGD+on54Ofmd4Sy6HRDgczCv98sMTRenGYpLi3IjFium73/r/Vd6ajMTUo6uEh8Ie0KAQg20CVxRjAHA6PAX6G/CsjhMvGayYHUtxXeUoCcghfUHG5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780628204; c=relaxed/simple;
	bh=1nQ7UaUkdtTXQ3vKFgV2TBjRQ8huaOhmHVw5E65L8iI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tkTe9MOGvOlFbIAtZ+y2y2DVtNgXadtUgjErQkbK6JU9gLklJ6I+amHU7ttqtqGNig5TGbK2BxyNxBlJABlWS1Da04GeiAaNHCS6L7jpy7ianCtDeLzmVHBODioFZTleqVeZ/heOaSsrBzZ943iUqUYcUYsHpaSp+Ty2zKO/EBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=UJmu3cS2; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ER+yQfRgyVvWmFcs6UK0gPEu7M3oSSEjEaQ7gdPfEa1YRDE16TKENtPiEXUSdUn+9TtV9ptc4O+vOI1WHexshN2VC6hx/8hB0smcHq2Qq6W15FYEI+x1E5voscNgkcSQNUPWMYAueKsdOYxnRVd0f0xGm8LiZ4UCX1EESdcI0XYjy39V7J3Z91zO/WaaygxtFEjcveZgS3A++bFpcHO8J7xqghKcAoVVKXOEnnDTTGOnpJK3q0UAX/U9uzdwQ4WkDjol9eZOiFR4nGvqNnB446qPRX9aqK7NAzAToOAeBY0KT9L27kke76y6/OZKt/oYuCEiG/5rG4fBZFC4TlAPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QzLVHeg1muNLj42jjICgkMx6QV964jMOA/+g2O6sls=;
 b=mGYbgIokxsCBzAs5N8dlX4d+mC+tpzqSeD/XBYWyiTokoczJS9HHbxKmN+8UurMARbkicygbjeFLJR7NW9q+8adzUpwHwnif2XZvaxE+WI1isPtnPjVc/8iR8NAomIo7sRccXCPBnWCCEykaly4t7lYY2j2MrIRgbj90yqy+cOhSYSlvwxGQbhYwbU2Ud4kthWSJJIjaVD0X499/m+ezDxtSK7oAC96sIi9GcfwTLwDHUIgmNbLSgyI9x4+sCl+P+lnz5URHBzm6bFon4QSefdmwUyKSyCurXhZRP4nsWd9wIoJWPevJXKqJ8ZSoYnXazi9sfBu8d6IDOnHYYOVAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QzLVHeg1muNLj42jjICgkMx6QV964jMOA/+g2O6sls=;
 b=UJmu3cS2VULr9fx7XQP1mptj9W0G7cOTg81CGLg+SyKZ3z/HFPkvyf6gxgEbbafed8k14rTZ05/oQ1QpUj7jFGHgl/F+ZxYotogvFXvdMqdvRQjoTzanQXVP9mLrPcN3QYp+uVKxyS8hTplXiXBr0dX+PjiygBOsyqKh8ScWVLAvD/whav8LX88Oz1M79DyBDBJhvMqbdKDSvF14ARGN/xOpRAYyX5dWfS12b00xchtaNrdxcTJoWQ8I+iR3YaosOD5YJHm3zk/WJ9QRbQZLwagTd6+YxWCS0tOPSrj/gUsvPrJmgKcRrODaG5gdGbbNQHndGWGtLxqzjJzNouU22Q==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by IA5PR03MB989628.namprd03.prod.outlook.com (2603:10b6:208:60b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 02:56:33 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 02:56:33 +0000
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
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethtool: mm: Increase FPE verification retry count
Date: Thu,  4 Jun 2026 19:56:31 -0700
Message-ID: <20260605025631.2872-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|IA5PR03MB989628:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3fd88f-bbc6-45e2-a8b7-08dec2ae0cfe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	SQYuUtjbLgmbqUTnsXMg0uZuRQWEVU0Xon+1nxNW5QTgoqHSNLi+YdW54n2pKETWhhvj88zTgH/by/g+VyO/PZJVqSt2n7nNjYDFH+XPYQn9oXL9j91q+zoH9lUGT5C2zdWehRNCMI1gFbFrZrZOXFNaRYAzlQEhwVcqhsGWUiFdR1QkqZovZKXT1z/g1kRqaPqP5JIj5AMYFdEDWRZCl2NG10X5ZvE7cA36tcA2qRYT4wLc8FlHmY6tEz6P6nC/MM9bxAtSk03ojcj+RFsTJfYMBTCwZAgCugEqeilnSCHnJ8F3zaUCZ71cnBMmD6VSA4Qu3fFg3DyPBnZZGpyNfhFuMWmT83trqWdFQssseSB8OySOJG41vafPfFYe8x06QKu4DM1YBsa3GTp3m9mLVfc9rJFiCiHUVGK+JlqAEQWBYabQZVLufRILxljKyq2gVfvTs66igVXwipdZCaMdC/bs8xNz7pZReyuJd6rd5ggH5sMY86gNyXSCBFclE4wj2YI5XTu2o5abPrbDswHRxJDbMBMnEVbaRJzVRxzll6Nh4gqydi/qKS0X5CsKr27cgfs3wgYNFmsYIlVDSstep1TmiFJO6YetXIDMZNGZRNC7LEUzMUjKwg6VZOejXRS0dnmMVTtYm+xMHrmWe+VBLOtvDmyMRS1O36KVgWlg+jQVJy9LB8A90esuQTdrUdmp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FjeS7pr7ubKDGqarJoKaKJwf4IbpridRbsghNiLjU3FMDjQ1U8MTqNKJuoo3?=
 =?us-ascii?Q?gUK++/P5OwFeJX0/VcYtAh0dHH6rZ+/X8yo1IpuFdSuU24QdemZ6jQvmNWYI?=
 =?us-ascii?Q?u2dNKKu893wSkloOvV5F7zolplI3M16Dd1jDaGY1vJaYggb6vD9Tr74dwBMj?=
 =?us-ascii?Q?shlgViOuVMSiPHpuP2k6xlhp7A0fJZuQFDBHg/0mqH6PgIv/VutXWIZ3j7E9?=
 =?us-ascii?Q?U6O73q1mFJZ7JZOpsykDrv/7HzHgEmd7H4oiF2byozvwnNWHPgJtSoSDwyg7?=
 =?us-ascii?Q?9cRysblPswjQxcGkofxjDzXZU/eQLFvzHIjI/ldeJi14L8s6Iq4qyB6JZFo9?=
 =?us-ascii?Q?l9/Oo9wgJCXKr0ZHk7/hfLJdO5z7u9DgD1NqGff+DvR/fBQB6QxTsu5yW9M2?=
 =?us-ascii?Q?KkVmbZuxa9WHCRkbYNmDZy2hyeQPfZjlm+0EGMG1i5t8NhEBBevV1EmifElr?=
 =?us-ascii?Q?EgGVZ3uSMmdr3AdB9rOOYPeKT/gJReh6CcjvCvxHu0/EDk+NP4aLMc6acjd4?=
 =?us-ascii?Q?BReQ8RwnMXFNYKQwZv6M8B2gpPKPzQ4Zm9lOV40wOzwy4G3JfIxbdsbhCQ2a?=
 =?us-ascii?Q?9I/DFmmq6CnqSunLwbh+rUL90RHpIbDj2gVKF4rokZBlhOCQwxrHOF25TzDr?=
 =?us-ascii?Q?AOaZqYk3nA+Q+XJ7uYvzsfQB9F6K+izCkpYKeqyDytpWREL9tyO8gVLdAW0W?=
 =?us-ascii?Q?WAxfDc/Z0ExC0SZspN44ZDMh2gIxxQSkdhBXfmgRmoZ9IQJrN96Hpc8kiT0G?=
 =?us-ascii?Q?tX2a3JF4jUX7aH9EN1a0ud2Fbuv/Ao8Rgqq8FUQDwUiBpM8/NZYFYOCtPUn4?=
 =?us-ascii?Q?S188lRENtbjYt3tf9hSmxNHivA9MVW4hkGmeBbEX4PGM80RXwNmkw+PdzSMN?=
 =?us-ascii?Q?3EiLtK44pOb9oSQyHDKoRe9jVDEnuJ1Nxrgvo4+aSrTdzgChoSP+SX5Jb5Vo?=
 =?us-ascii?Q?QWMoYtskLi4NCZt43F7p08kN2pBVh00EtAH/wSWN+OgG3Kncwlr+qwp6E5Lr?=
 =?us-ascii?Q?wRW3cCXFNco2/2OEtv96zUiLuDcuhNcztpUPvBWxwpjneAWFmhLPfGTEjd8g?=
 =?us-ascii?Q?VBryw9rgqD8VNgDC6IfHnPdhMoLN6qXCTq45U6p9qsPLXzoHHWAmBJ9bMWZC?=
 =?us-ascii?Q?2JwrES6NOgiWSceEMypM16CUQEWSnB3CwEaAScHq80s3Wdm3yQTKgjvI10Ms?=
 =?us-ascii?Q?CFuyR2bC7y1N2BPbT1ONzh50MA/cXjsJaDyVOyEt3XqO4s3I6KeyrmakhKk7?=
 =?us-ascii?Q?OnKa8+WXs+oN3QVj9muDxr3auNht1FbOZC0iErJQPU5q4VsbcRyRIbYlqqqt?=
 =?us-ascii?Q?UNrUIyb9odN/J2nXUVrVR1Rc/OysUhqCyrjYlv1OuCfc471yWFaLDSkbII+l?=
 =?us-ascii?Q?Mt6z5955v2kbS1ZJUzsYhgOomGS8FVTqZJGsLHEmLKJm2v6bfb7/cXOFHT61?=
 =?us-ascii?Q?DGjg0z+oIJx5YabVC5D0ibYPqVFYKa8YVPqOwi/1DpEdDrej6muvDjDDIMlV?=
 =?us-ascii?Q?lSNHg4xFxHZiGJE1WImNRkNtTVjgbt2U/q1hqpbAnkxDyh1DeWS20+wESa+J?=
 =?us-ascii?Q?ok652yDtHZliQ3oyGR6jSdnobY3HjK0QKCxN50nMezh/JgqtotRlgR/W6COX?=
 =?us-ascii?Q?o0/dXHfN6VsjGegdB/6soP03GNyx/jNCv4Hh658F7nKm0zKY3lgfZP/p6sBS?=
 =?us-ascii?Q?+J1t0oJNKDU4aIygQK94SoF1/Mpfi+GJH+5uZzUPkG/Sws2AmFBt4W/i6aOt?=
 =?us-ascii?Q?J9uPfemMBTOWjCLni1nbhrYIlhmyHILvrNWoExygWIy0cddtsRVRNpJKM/y9?=
X-MS-Exchange-AntiSpam-MessageData-1: y2gDlBSVUtzCfA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3fd88f-bbc6-45e2-a8b7-08dec2ae0cfe
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:56:33.4446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHMTnzxJKzLz9fu23nmU9t4fV/0czhFHakAjalx0lwoPW0AKTG8G4160vnHqwMZV3neiXtosuzHQyRZ3Dtwg8gcyobIHVVwqNPSnAHlseBG5rJooyBD9YlfCau+5BE1WFlWTWsECo2GUSdCA8kOpVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR03MB989628
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295602-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7B94644C50

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The current FPE verification retry count is set to 3. However,
the IEEE 802.3br standard does not specify a fixed value for this.
A retry count of 3 may be insufficient when the remote device is
slow to respond during link-up. Increase the retry count to 20 to
improve robustness.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 include/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f51346a6a686..9a1b1f5d37a4 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -23,7 +23,7 @@
 #include <uapi/linux/net_tstamp.h>
 
 #define ETHTOOL_MM_MAX_VERIFY_TIME_MS		128
-#define ETHTOOL_MM_MAX_VERIFY_RETRIES		3
+#define ETHTOOL_MM_MAX_VERIFY_RETRIES		20
 
 struct compat_ethtool_rx_flow_spec {
 	u32		flow_type;
-- 
2.43.7


