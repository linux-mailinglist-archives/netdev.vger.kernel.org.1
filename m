Return-Path: <netdev+bounces-295731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WrbINWuRImo8aQEAu9opvQ
	(envelope-from <netdev+bounces-295731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:05:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DB1646AE8
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:05:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=B79AasAK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295731-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295731-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 158E9304C7C8
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45CE4B8DEE;
	Fri,  5 Jun 2026 09:01:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71944B8DCB;
	Fri,  5 Jun 2026 09:01:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650080; cv=fail; b=NO9j6Ii4VCJYQWbf5q1OdewcFDkSa9RqKS5hX+izZYJMZQfPpIsuqJ9xaaByu/RQKBX5CkUKdYq2CplMnLKSSnzNlIx+vLzWGNhX2nsjRRYkepK9hu9TJwRvUC3XASn3610PZVK6tOnCpfbrgw67XDiXvpkCeKnk3MSJSdWEUco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650080; c=relaxed/simple;
	bh=WvIobnspReK8B8/U6T5AJkNGJCRDtO10dTtcPzEz2KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f9W6U95e9S7AbEVjoUKMkoSfQ0dseinnvWKH47T10+nO5IrVFEFCLeb4oYwoOpAT6uy6dXDowLJajqIKYRefV+DJbdRoAymvJUtY7aOK8xnWNgasXKpKOd2rFjwdLJmgkME2sYE5hKQbOw2IL4XBmdZIibgth0JUQtwy8NhqxBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=B79AasAK; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEuX2T+jRrosEGLZ4GREBHyX3nip38GZ0DR4USoM5FUWxfDn9d7BzUoLY2qJF0WKOp5e7Oq8BwLPb6tMKKdaPYmxp3fBfieFBpV3t1fpympRvfpHzTGjOS8iCQI5EkAWtcCQb4GmgSljFirGZIDxSuOk0k5vkDrYsP+maq3Toqaf9yjL/QnzUVSG6dv0Neu6Yv23E0g6mMJQO/lwyN9DnMrOgdt6mz9ePVLB8jQC2nsHft8lf68Z2jmdNGKRMJjLoHJZ1Zt/RAnv4x6wpI1bu1m5deMFVozcssU+G3C7m8mLKZjETSHHpjZqUp1K5UGDvOHRKrwCvh1ONPgh9L0i4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAOP7Q3vqZ8u70rJrMqcToY3LFs8448ocnO7Bh/Pcqc=;
 b=JZKdMPAt5Jth7NMkE4A2fVqRfyvwy+jzmVLnlqGHOBSNd7xEHQrYsxGJ80UTOQPoyScM3+S+ibObZVeXaIyZtcX6bXeYBISuBSqxwAgawfKCalzrvaEJgTl4TbrBVuN1aaOTykqq7cVybc4uvH6P/Z0pIxZRQNPx+jli1olXddquUp4sxeuADuH1bmJbsjV8Fa1V9JFd9AAGLvaEoXTc+4xbgHdWhHpcAh6dBkrMLnSm4nfrFoFj4nYAaLoPgeTRckc/87fvqllbqEHgoo83SUtoYKxwnk+t9huhZ90lB4mkPNkqvP+aO/IQDTzVPtrCCQt0ESUZffMVt+y65M65Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAOP7Q3vqZ8u70rJrMqcToY3LFs8448ocnO7Bh/Pcqc=;
 b=B79AasAKnK0JnIXBvlzxGgkgrOzaWDX4P/wEyBf/7y1DzWyYrLIYFyurS3S0wih7V1EU670QqjHKSq8ZHG5uE55To6S/Vsl6JrTcz+b4pHP0ze9IRANHG3b61BR8ktHgI1wpNDYSvWk0opOAsD/sQx1/B4qFwZe4fZB921WArx2O/vHE1CSPq4CCGM5U4H4BgwRNA9oJ9LnX7cpSzggqspwsyQQpPwJYGh20DDIpG0Mz8miTXITLld9C5QngogXCr+2xh+S3O9Yai4pMXItWzQEiAvXNCbNmNamcg9I7h8v5HB2BZy5AzPB16nKoA3kpx8rzA999c/MjcOOu+KNJeg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS4PR03MB8472.namprd03.prod.outlook.com (2603:10b6:8:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 09:01:16 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 09:01:16 +0000
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
Subject: [PATCH v2 0/3] net: stmmac: L3/L4 filter bug fixes
Date: Fri,  5 Jun 2026 02:01:11 -0700
Message-ID: <20260605090114.16028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
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
X-MS-Office365-Filtering-Correlation-Id: 6e4240a6-04ae-4ab2-3557-08dec2e10032
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|6133799003|55112099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	s4QIDWThnNRp9A4zSWcovjrJoj7SZUDzvXC6yJL3szU36c4uk5zoVrF9axXMa3pULJFmME5A51vFpXsok/17wkVh/xCK6+V6a6LYdgzueUA1UpD3+2/LavcDgxLFocPCJH+LThQ9norTfiLaIBn14UeF7muXP8hOPzOJixJ5IXlP6EfvIlKddPNHco6Ek0QTxqalNx1Js0LF0NQz9HMV4EfKZtj/hup3Z4y84LMhH8Fg04vjZ/1VbKSIYlkG4qrzN46ZbZYxPwCisepTBNptv2ZAsuG0Ul0P6lpUa3pZq6NgMlMK4VrnlAk9iPsmh4AwfOl7XKp16KKVu09f8DAKKK4TJWl2zavsBZ5zSITfKUYeHBGUAy3Vhvalcj5wCn9NFabuHra+0h1CxlFNO2CZW3FlF2LIA/niRSAZGdXSxFXs+Eo/Z99Ajx/p8G2bCgTtT1C/NS87GIfj5leF2Cyrp3l/5ooJ3I+NUbkWuv9x1bVsLB55mSZHnV/wujtFeD2jaUCjb3kX64nmzldIzx2fDukLvrryesulFARCKzCg013SEQamL0x96FuJBXwV+uNf5KE8nTBpgGhOfl/U51yLIUlV6HzLmJSSlXsA3B4TkYvRx7SLMYqpJPb56w/QArCDdipKX+T49vHKq+tI+stAvE64CPrAFyjwvxsH6B9VEn52mQpaXRnshsNyq0ffzwJ4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(6133799003)(55112099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WAOzOQlJbQBThAspubXhmfXlXEv8PTPhbRZdV8jidy69KmgdR85ru8U/Z5ja?=
 =?us-ascii?Q?s3msYzmgIO6PGdV/N/VPb/Wew85/U0u+YTtAtstoBRUORnbo/wXpisjp4fZV?=
 =?us-ascii?Q?qTff6ASyqo0Qc0/sR3zooZT4w28YsBx9SgoCcE0TQvvFuRieLTre+fUP79Pa?=
 =?us-ascii?Q?TfJB5wx2Qj6RROEuh6rG1JkP6UwSLjAJEC++7+FevWflyrmQjheeS1joL1Tc?=
 =?us-ascii?Q?kMOzqyt9wfJgsmdgRo4vWJNXD25NWg4n6VKZmZI8mdyXRvy80ynOaoQ2InEE?=
 =?us-ascii?Q?GWBwVYtPKhYqOGWXb82Tq+hQy5BrHUA6uoTm2sFTHZJuzZ2N9UFQp/9UKVQL?=
 =?us-ascii?Q?ZfWpasXUIQPEszWa4CYgY+j3YPmF63FS7NxDWxpWrNlGiVOVApySvuILInoT?=
 =?us-ascii?Q?2leSk5wNjcu95rWIfivlGDl8LoU2KOsBwGFPKqfHs08Gvr4ggSyVJkYiKHZ3?=
 =?us-ascii?Q?mqSLHOjIsF4QgDIZKbfzNH1AlynUFpnxOd17bZKLDWRN5m61T97g/TBMUQkt?=
 =?us-ascii?Q?FlmzB46sr4PqrsDW12kBR6dsQ611hwz816LnnNWg26zbl5LrhEJApCKFXtoe?=
 =?us-ascii?Q?mz1TWYAJj0lrX91Vk2+i++zB+20obz3X75pOAj68xv/R+lJ309l9140BMx69?=
 =?us-ascii?Q?WGR5hsXa6ElDwzb8kzW9LLVvaPSVMWLZFgvlRp8PNkSCZC9m9qfOFwI4Yx25?=
 =?us-ascii?Q?Ydc/2/BvUx65NxHXXfSatdAiyL8VnDFkP3vFza63IaBdsNX82q7wg3cRGOIs?=
 =?us-ascii?Q?Z/aGaWKJu+1GKjlc57bZvUJpr0ZHUAlfYhB/PnUffKJrXCdrINBZNfXYtuM5?=
 =?us-ascii?Q?43bAudyab1tbls07JLLo3v0UYQ/G4tORaKiUZgoigVf9J08srzB1c4R4v8OR?=
 =?us-ascii?Q?2yy+PTuDh6GlvE9l1dwodeKqDxdlE+ffz7Aq9r5sczpPNqO2We6NpchiCatw?=
 =?us-ascii?Q?/fDv+HB0UEBIrtt1n/wW3Y4V+G4snGzgOVCB7BubrK9gHiM0rMJXGEGmXvsB?=
 =?us-ascii?Q?7juhHFlZGsrz1qpjGWHwBIIYMtQesni/JoFyUGMRFXayRtw+KbGvDSQqQa2E?=
 =?us-ascii?Q?HJjZRCp9lNdSqjiSA+tyjkRTyyjbwUw3k7yuy5uF5/3WsQMEqy3/Oxl+vhOx?=
 =?us-ascii?Q?y6zk3RzoCte2IxVrJBtyuUvSaSSD2CIwY+gqMpVvdbjQNVAYj+IwekdMeeJU?=
 =?us-ascii?Q?RNLLqOJGoUC1z4LIRlyVCVI2NVH1siUEsOfcHpO0X1nOrFw9UJ0SVY3fIBmR?=
 =?us-ascii?Q?oc3lmkWJBMuStudLhZIxPnukoSUutNw3W/q+xBcVMfqM59eWyQGGMbqs47ae?=
 =?us-ascii?Q?7bvt/dfFM1G1Z7Jw5FEmtavqmZLUtEbgLXAZ/Gum2lxMCLxc6Cdl1PHDNc5d?=
 =?us-ascii?Q?qs/LlRRW9gwtNSitMEoKIKtYD9Uxjd2ndCE/pFXW6o1kwaypvTn4lEl3b45V?=
 =?us-ascii?Q?q/FIJrFVNMOvtiY0X7nwzZtjYRTRDg0dBzRORW12DT3L4LK9UPUT8Ti1I4rq?=
 =?us-ascii?Q?GIGYomZP86ADptXPie6EaBQYngS9Tk7aRuV0uvxxxqGIsmg4LenfGpdib+9p?=
 =?us-ascii?Q?GBj2A+guOQziBtlc8brWFeYp5U2y7999366RilA2YdqYJiOdwrxh0sng5Cmf?=
 =?us-ascii?Q?IS16A0xgLRT7V1wvJF91lWf4pOf5Nu/JX1KjB+RjzfDfsF3ytNJ2s9a+owy7?=
 =?us-ascii?Q?AQi7YO0LctJMRfq9EAOg459SHrZTOQ+GXcQ8CMJtE/THrNl+2Cjv2nNDe/ro?=
 =?us-ascii?Q?H3BPztI92fmLNj8kfI/5FNmdHT4jnVv3LAGAHd6Y9d9m6PLshPsEo2KDCYeC?=
X-MS-Exchange-AntiSpam-MessageData-1: QrK2JOiY9FGfzQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4240a6-04ae-4ab2-3557-08dec2e10032
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:01:16.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnMRTleBR+1hGDTePrnsBfc765HxW92XjocoRtyt0LbyTdEzD7s27+FNlydYqiHkjFsro2b8wo605f2voLqce2wBh0M1tNHYj1v4L5XX1f/2hkNYtzTxeIbVO699DafxEqUblW6TqM98fdBxIw9MQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8472
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295731-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 96DB1646AE8

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This series fixes three bugs in the stmmac L3/L4 TC flower filter
implementation for the XGMAC2 core. All three patches target net.

The L3/L4 filter match count statistics patch (originally patch 4/4)
has been split out and will be sent separately against net-next per
Andrew Lunn's review of v1.

Patch 1 fixes a register corruption bug in the L4 filter port configuration.
The XGMAC_L4_ADDR register holds both source and destination port match
values in a single register. The original code overwrites the entire register
when setting either field, silently erasing the other. This is fixed by
using a read-modify-write sequence.

Patch 2 fixes the basic flow match parser to properly reject unsupported
offload requests with -EOPNOTSUPP instead of silently accepting them.
Unsupported cases include partial protocol masks, non-IPv4 network proto,
and non-TCP/UDP transport proto.

Patch 3 fixes a stale action bug on filter deletion. When a filter entry
with a drop action is deleted, the action field was not reset, causing
it to persist and potentially affect subsequent filter configurations.

All three patches fix the original L3/L4 filter implementation introduced in
425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower").

Changes in v2:
- Split patch 4/4 (ethtool stats) out to net-next per Andrew Lunn's review

Nazim Amirul (3):
  net: stmmac: xgmac: fix l4 filter port overwrite on register update
  net: stmmac: fix l3l4 filter rejecting unsupported offload requests
  net: stmmac: reset residual action in L3L4 filters on delete

 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 +++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 27 ++++++++++++++++++
 2 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.43.7


