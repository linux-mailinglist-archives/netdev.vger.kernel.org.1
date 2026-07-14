Return-Path: <netdev+bounces-307333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0b8PAoGbVWqCqwAAu9opvQ
	(envelope-from <netdev+bounces-307333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:14:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD19750509
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:14:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=UALrL0Ut;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307333-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307333-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A098307F1DB
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA25037E301;
	Tue, 14 Jul 2026 02:13:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711B3033DF;
	Tue, 14 Jul 2026 02:13:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995193; cv=fail; b=SV3/n8N/Mv0/K7qxHphhwwiYpHEzFBq3anjsNQbZCbAPMKuFpRcN3xNxYeHl5gGCs0zOOBDU4u54a/oCJ8ImWe/+vmttG0sY7uWHWHFdcQ2oMEi+O9xvWjNk4h4jwArN+/X6GR+H7ATkGE23CwgauKpFyuzTeFwZnUV4+4IvwGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995193; c=relaxed/simple;
	bh=T/p8Bt0qi9o5fnA9S38PoOb8Gjl/HZRfBPRYhRph4d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3dZV3lIS3LXwC1C6Q/sWo5phHGZTtBfivkrCiXMvhKVKJgyplUbh8h9rLq75G6s6LE1wTTdPj89mHBzXGkgznEq6SOdJh/hfhkvGd9UkrGWqCCk9ee+JxojJvczfCsArwcniGJsXXXvDCZ9mJ9wwKRsCwbZhaee+71ATkzNcWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=UALrL0Ut; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQgAPsfClGe63QSBuTMTS8iA176m5nAFd+6HXmPZuxDbGTRTasoce99dDvqxfTLinp+/RgZHKLNG1WOvhrC7c2ZyCTb+tpJXCjd9v3QkrMA9uSMSnwXQFFirJhh+0UTz+VqlAsqXPtbuGS33gyNrezCCGuVMC8KJSOiVijW5aoo8emNv6ZD0L+6q7aT2rDTwBm/aNen6ZLogEkCBAUZzgpaqt8Q25GU0McBKYh4u4ZHnPmrG+kKwTtUVqwXjGZwt75HyduLElWy3Ivdezhs9SKu7X3EY56qJyDK6Bd9uX0OgB4V3YO9W8VIEwpJpfLaHfz4jFQ+C8zr7nI05nn2deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZmDJm0PuTmXb19yKO/6JvxD3GcrSlXnwYyLOKYx9s8=;
 b=VCkSIf2ihwNwPtVGEsMbsj/awSUdepA8/lbEv4WKouw/3CxBZn7shaaTXT4O8Ulzd5wAWE7s033Hh1zDkvrve4rYC5HxP0KX3hCfWESEQV4rYpXaWHTjmRL6SaOxcMLPpIAtVrn9YT6Yn7PE2rsay5B3RBUPNg573rKZVbxlkZ8RaTUuvg5Q4CTsC90AD9fT9HmYQuKGUtzpV3kHYg/jx1EnxE/c+xXgRwSP3eEzvz/oue77oEVJC86eVJyHIAeRKrbVrQG7BuB2IjKlxT72viSkdNyNgjgkj69Bqsc7xzeKOHsKne7p4jTvxovw1VWy0OBi7MLWUx5hFbestazOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZmDJm0PuTmXb19yKO/6JvxD3GcrSlXnwYyLOKYx9s8=;
 b=UALrL0UtDyYolc3WLGQt4yqdcgkIlKU/vLHPiKCHY11mR9Ms/q8cLNh0ruTfbmnrAhMQzlTVdl9dAVypGLy9OSCwh20TZogjAB0jVEnfndy46KYaTB/8b3QSmbl8DLzbi440wlCvQaI5zt7LMgMVVXjQkG5GLDr7J6FXiXdN8T5Ezzr7cg2dHb83W/FcpqLI+IeHkYna2xJ8K0FIW8eIHt7nqc9zLhmK4aPe8tSbzsBTLMfDJDdk9nnMa3k30BDv5loRqtbKCKVQHTs1bvnIhkFLKEj6aDxOgE8FFYOGwP0OpMfmNjxTDfo1lDpnhwQqj/fKwO2Ufe+WGdJnrKTW2A==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BLAPR03MB5410.namprd03.prod.outlook.com (2603:10b6:208:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 02:13:06 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:13:06 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2 board
Date: Mon, 13 Jul 2026 19:13:01 -0700
Message-ID: <20260714021303.30042-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260714021303.30042-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260714021303.30042-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BLAPR03MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: d30b2cf5-d834-4615-3dde-08dee14d7108
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|6133799003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	puhlGDTeehzrYrvq2M8ZQsq2LQeXa9/HfzLjvIR51Ex/iYaeszzXjbkwDoDUn9uNPU8i/WlrgsoS3wUv+1JGPmf70a4f8w2Uk7LZtDDSGrjtkATxyJB/kpIoV87St44TzJAIjRPHScU5TKCjuqVtB/DpIAbj68R3NlBQ7628CTYijbZDGCuV4/dena3kHIlNaVMBwJG8crL8jrpOK0qNcE+xxjhB5EL3pySjdfjLZELjv+ti3Q939bgQvB+MAdnemAsG1SPcpvA41KNya1lbCBIcyvIS/a5PJH3cyFzXhK1pynG690NZ2D4g6ktit3MCInR1+zCIiHqiECoWvnCvPCkaLvDb8OP4QuIFiTlsSwLKkFzcFiRkhrH4tqfSbF6v7yHTFhCQtEnJnAhdpqzctVgOA13ZR8KtLX5GApbpK4Wgs6EpNPBH0MshVXbfU/3ha3/CopvNi3lZeV0Hki03rqA91rTgz964HRPXcEKnAgfTnkkaaXkZZd1llPiPTYivuohAVY1YM3usCS+dCUUESkGBHd9UqGek/NjwjVzsqNnXzuVNvLQP5fVLi0XrBaFHrQ8DDI8l3+Cg3rghkUDr0ZJatJ3s6JmV57yhwbJuYW+h6+HDx4T1VQlMG4TW7FZuiBxChAffOPVlBz6cCtX3bk+LP44oeU7IYYODA6rEWFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(6133799003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NXJseqbct4USPjSVYRsvVgRAESKPFFX0IW+SHiefjcSa62LEVXAb3Byl4W0n?=
 =?us-ascii?Q?/fvxpv0pfQkTH4ZD8nK0T/LNWtHURi6rbjKOAOLYjOqGcOW9/N+FuS6e6HUZ?=
 =?us-ascii?Q?Eiqz3sN8OB0zDEbV8GWhB+aY5etTQoANK7CjshMVdq1ZAbeooPJO5yv/9m3c?=
 =?us-ascii?Q?QOTVpiK/MQo1G9RkRadmTWRNpGZTVizWBpKgXeiE3RDlbdZ6x3/ofIojxnzQ?=
 =?us-ascii?Q?rbCrymb/ZgrlF+XwTO9n0sZms4iwJ3B7GwUmjkPIHXAMsm6MXf6buZHXcTSl?=
 =?us-ascii?Q?kY/EAvHQpU0Rt0EDzB9QwS0ogSTpV832Zt9cxCmLJOUBKtGjXTPbK/xaIe1S?=
 =?us-ascii?Q?qUIb3VUyiSzF4Utuw2ISBpvdzi6KCIb04mgDxFDTGgOurmYhyE/74HhnwdMe?=
 =?us-ascii?Q?pF/rAENijrY2lBT1Q8s9Yj+bUXHqi1RzvS5VsyweJZex3ByytaGdlqog6XhZ?=
 =?us-ascii?Q?BmdZVFVFXr8kEJ2yk1wiUH/0qKtcKvXgs3oVCdG4KzP9dH2T2EfIdKCL3H9f?=
 =?us-ascii?Q?0U/kJmlDzSf167GZjse8BNrQEdzbm4kkZ3aCDu1Gq/akEbsvo+jqG0LNUWzN?=
 =?us-ascii?Q?D6yHOIlMe0byLZc3P4BwUevW8/gO6YjzJl9kOtR+aEjfcokMdPWZofFY3BM9?=
 =?us-ascii?Q?fu4sT4BTkydfxg3ARBCaGCNq4dOu22pAkw/qJf8y+Vj+GQx9JxZmwOvrHqfa?=
 =?us-ascii?Q?3sYVUJYreCAgeYckb3ia8rCf3kBKsn5wSfqaf+V6sR9wjcjl/lIgiHbWFIAd?=
 =?us-ascii?Q?STsje8uRBYtDCaco8Y3e4q5xkTfHMOYZlcKmb5QOunyU0UhkdB2bgfxgZRij?=
 =?us-ascii?Q?rwsE4CVNqV2MYazCXIiOq0d7zbIjfCXBdUddIBXsZGcFPGT2cmxU+WfYKJ/T?=
 =?us-ascii?Q?SNG6fo4fK8v2iNm8snuS5Xi78VeR9dwa0IArfIu8fkg0N8F1rjU6nbKBdTWy?=
 =?us-ascii?Q?gpJpYJ7OWfLbWqklK9iSN5Z43eACo5fZfMOWCJYEHqvLBYJF0YZoRUm+QvzU?=
 =?us-ascii?Q?XRGKvck95kZRx6MA6aMebkTFUd3izRkcZsYBpsHHgxVOWtzRG6oaC1Te3Jfu?=
 =?us-ascii?Q?XOj4g2+2X8gb1+7PaI1GkOSjUn1uLmZTrRfeen6VAyGTvtPub0gSu3dr1FVL?=
 =?us-ascii?Q?fDyNVJ8zD88WPhtXMx1hES6ePL2hRrlSkqGpXM3nOL5HlwRozlFg5QKDTuX/?=
 =?us-ascii?Q?7KQT1Z8oY9I2xySrcWroShlGto83rOnYlJOkX4BxkqxgddjCPzsbF5gxFQgs?=
 =?us-ascii?Q?Bi+gRnlFO+jS/NDFT3kszNTNic0l69UidgZo6QP34py65Z1qiUMfV3axBoP2?=
 =?us-ascii?Q?S9YDbmqpkuCKYFurWGlsnSJG0RVoE8ks/ceT8oLINGXYCigi9u2Czp28qU7e?=
 =?us-ascii?Q?8M+EeadFAK+xzWrVO0fi5Qf6d8MGYFXKm6vvpovoq668Wv903cw9jyuJjfVh?=
 =?us-ascii?Q?bMfaP6fxpFcBXk2onktVt9+b5fQwHWYBt+yCSN2r2UfnSjy75gRiOU6dPOLI?=
 =?us-ascii?Q?eWYqfWp06FEnNfRJawzX0rGf/dfRTCmhPwkmh1/Do+RvoDcp7cC3iJPDbMjQ?=
 =?us-ascii?Q?M7kzUu4eB/28FsZB5NTIJLUz06Y+oAuySZBVk2CHUJOS2xlxSe97/6BRSkX3?=
 =?us-ascii?Q?mifqxFcXhU1bWBISeDVxURh83AMMvDvpRAS6U5UKQc8ODTcFxcreIk6bWMQi?=
 =?us-ascii?Q?iXh+RHfqiNy6gVTkLykewtdjYH2nodM3p0WvXkgfEtS1LJatUSoVEmKHU3Jo?=
 =?us-ascii?Q?yckax05RMYw5GCF4Jpe6qWBvDMIgdYShwpP239Mz0mojT8/3CZB1Mgtyi8Bg?=
X-MS-Exchange-AntiSpam-MessageData-1: xEQ6UFgsddemcg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30b2cf5-d834-4615-3dde-08dee14d7108
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:13:05.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeTRq5FWXyp2gBu/SOOR5YIie+9tcYU8hloSP9JNbgRG5fJewKVX6e1dBGx/7C/wkHYSDd3NGIFvtteQbuCAGT3nehyhKALoMmo2DG7Hy43XjRgv0ga/s2KDwCaI6Vf9g6dlFVThUoTN45YO5bQbGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5410
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307333-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:from_mime,altera.com:mid,altera.com:email,altera.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FD19750509

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Add device tree for the Intel SoCFPGA Agilex5 SoCDK TSN Config2 board
variant. This configuration enables gmac1 as a TSN port alongside the
standard gmac2 Ethernet port.

The TSN port (gmac1) connects to its PHY through a GMII-to-RGMII
converter implemented as FPGA soft IP. This converter provides the
RGMII TX/RX clock delays, so phy-mode is set to "rgmii-id" to reflect
MAC-side delays. A board-specific compatible string is used so the
driver can detect the converter and strip the delay bits before
configuring the PHY.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
v3: No changes from v2.

 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../intel/socfpga_agilex5_socdk_tsn_cfg2.dts  | 131 ++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 270c70fdf084..ce7cf3a63275 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex5_socdk_013b.dtb \
 				socfpga_agilex5_socdk_modular.dtb \
 				socfpga_agilex5_socdk_nand.dtb \
+				socfpga_agilex5_socdk_tsn_cfg2.dtb \
 				socfpga_agilex72_socdk.dtb \
 				socfpga_agilex7m_socdk.dtb \
 				socfpga_n5x_socdk.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts
new file mode 100644
index 000000000000..bf13ccfc1faa
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, Altera Corporation
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 SoCDK TSN Config2";
+	compatible = "intel,socfpga-agilex5-socdk-tsn-cfg2", "intel,socfpga-agilex5";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "hps_led0";
+			gpios = <&porta 11 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gmac1 {
+	status = "okay";
+	compatible = "altr,socfpga-stmmac-agilex5-tsn",
+		     "altr,socfpga-stmmac-agilex5",
+		     "snps,dwxgmac-2.10";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac1_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		emac1_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "micron,mt25qu02g", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		cdns,read-delay = <2>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x04200000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x04200000 0x0be00000>;
+			};
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.43.7


