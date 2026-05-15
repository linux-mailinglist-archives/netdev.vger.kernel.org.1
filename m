Return-Path: <netdev+bounces-288331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFWwDeQyB2qQswIAu9opvQ
	(envelope-from <netdev+bounces-288331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:51:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2F7551B28
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 443273002331
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D53B52F5;
	Fri, 15 May 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="dYZtQGPW"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D92371045;
	Fri, 15 May 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856672; cv=fail; b=XcawWxee3hI4/T9SqjXqxKf/eniGcgFWzo84jIsTyC/PrWtNU+AQ9AZJv9zopkVYu18xkQdU/lf8SH2NuJgZ5H1txeFb4mOnJZFx+aLL85Ti/QXcIhtZWTR/twadtxAcBSyrCBMqV4GW2EaOSUsxt8X7jABG1LITCgYY8xP3POo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856672; c=relaxed/simple;
	bh=Bei/raEm6vi85np5ykJ2KGpENYqPw+iZ/FJvH5OsGSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMbDfFO5d0PAbIu88isqrf1KyR/wtJj6TIwsu4761QEYTvjiVvQKLtkegrrQDSaMT9Q7p/8JAyscMZJskzOvY0zTXZP7pCYkXxoss7087l1GuksEs4wmW+Fzmg7vf6AYqIKy82FQh01HT2E5xVW32yOY6iPWRmnDx43FB2b/6xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=dYZtQGPW; arc=fail smtp.client-ip=52.101.83.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyJyHaYBxE+OocoXvzhMBFiOM4RvyvVv6XXLZpHNK3p3h1H10TxMGT8k8dTgsK86unSpCeDL1zxs13YcPQjHcZte3ZN/UcGQsbKvVQRoCxYDhQ5m8nsK4ofWpeH8x084DX5cl16Bs65CK79gQiHwxEW2OyW/+R9IG4HdWr9d2PoJgp7921AoLBxpT9+SpAr46U6Niuz+1uWkcH5xhAfsEw6YwEKIn9domLxVk2H07ZmsBX5EeBvsw2k54q7yVFcIr/sWVjnTHfC/rDLifUuzuaivP77jFes2nxFp1UTdzaDNef6oQY67z2j0wytdCb9v0YjjYDsDhOZ+qmpPARA0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWkXfSE8Kh2AvGneaktJKKI1MlE6FYtR4pAXtPZwr7U=;
 b=kmmvxYLCOOAT2r8hK035wYM+6WdUqJPvFaBmSX1BbSFj3NIQHUQLVXxU7f8W2nyZ9llfYr+tN2kPZWQf2AjYrJtz4bSV6CqhiKrRNI/UpKwxneY2E2H1QSnrKBHiSEK0HIEXxxGPKI6PjzAXnryoZ4mxfhbfOCslpScMn0zGYdmpKi3BO79dzoa7yZwrKHUnMSu4KqLacuuqDB7ii59iwpliQl+MctWbs/P/X1CrcdRs6BmPnnYxVH9BSydmFxCpiBvewZ2KCLMp8ux+ax+tGFcOy8q1VOWqJPvE/nO5Zki/pbWAsYPSrSZbiZCnWFbzOm8gMH/aurf/qisKRX1r9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWkXfSE8Kh2AvGneaktJKKI1MlE6FYtR4pAXtPZwr7U=;
 b=dYZtQGPWhQwjQAyFvh/+Zc7Ym1vlRKXb4IEF+zbaxZq/6hsKr2VhvV2u8UmvZGAZvw0aLSkcljnf8S1XUf4FD0lAOiJvXWsvK2DZx1LD+LdppvvHAauDTcF592MxMRU6FBZjcQGt9K51GWRoD0PSi0AVPwchyGRwYBFHryowfXtzL6kMIzosn+rEwNKwJUe7D2Wz11wnje6/pX5sL4pHgD8OWYeGnGsr0asQXmzqCsBBxbcxfnIT+t4iGevUeMZjXlbr+W0Sdq3Zoursktd6yIrv3QR1mZyJDabm1X0HArFgJy4nGbpzHT5cm9TW3rd/V8ZRNB/50gqR025hBDjW8A==
Received: from AS4P192CA0026.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::10)
 by AM8PR07MB7427.eurprd07.prod.outlook.com (2603:10a6:20b:24a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Fri, 15 May
 2026 14:51:05 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::a7) by AS4P192CA0026.outlook.office365.com
 (2603:10a6:20b:5e1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.13 via Frontend Transport; Fri,
 15 May 2026 14:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 14:51:04 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 15 May 2026 16:51:03 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 6566D40215A8;
	Fri, 15 May 2026 16:51:01 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 4A5DB1005D6A; Fri, 15 May 2026 16:51:01 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>
CC: <olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <marek.behun@nic.cz>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>
Subject: Re: Re: [RFC PATCH 1/1] mv88e6xxx: Cache scratch config of 6352 in setup
Date: Fri, 15 May 2026 16:50:42 +0200
Message-ID: <20260515145042.3091827-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <d979651d-bba0-4042-8e72-609b56121682@lunn.ch>
References: <d979651d-bba0-4042-8e72-609b56121682@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AC:EE_|AM8PR07MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3c7185-1800-445a-8e24-08deb2916397
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	5fL9AMGCzfv36ZY2NnY/BNQ37kkkdEcFhQeDY/gmHbz79zzeLR7YXl3bXLlyylxYHR+ITNzqqaz8DspcDV91h72WnX+rqA8SS9/FgYCRhu7uLDaOW44G9sqUl2ABHmcECPc8TIGYJp/NlB+9xt5hhcO1xvZggUKGtwJ66xhUnuxOpJ2aJUlsZPEzijwkJp3FK9JwFsNpEfzGP2hPUW9TWg5nKvx5P9tZ6YyKi92hCgEc3CBu2X/ePhrJ+kYnE+PKsbrmmurIehj+A6bYTJVdWXhxxFVMKjCupZOPpQOEfaFGumZeJ8RMkM96bNhQYRmNhFXCH0Qi/H2ywZpwiQXOCMcXKat56MLrfSHicCicbLOpv5NYzUeAJU9z6Zn4sI8VvJmhwmX3jXiLfviqjGWNNUjeBAz0Ks19L8SMV5KtHXqs4Q53nEVBin7yRPjQbgrATT/Fsl/Mdq1HrHSxR2imcRuEU+4lxKVnt2gXTbxrUOF5fCwJKo95SkJfJS5m2+KN/R4e0wYTZmtwrp3LFBgbKe6ILtrMhCqjVwXm+OVkwQFjgMMaUn5Zp3wLLNnlTp2EDXesa5CDYNFwkrthNVvN9uLx8v6V925FfoAXUKd+TJ+KTiCaIhA7Rc5PtQ7mTpsDCAbRSmdd6d+9GyvTBnlkiJ6yJXsnArxMDHRXKPD/+wFrcXwTMS6EZjRDF1YYGi6V4MFwbQTo4ciQa/EqjxSYYz/GQxF4oAspQVSZW+TyJEQ=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hsLBGajnXNRzHozDcrLp1KMuWGo6KWV0Hz1KOZed1sv9VQCnzTX5UQIHiciZ3vLNotPRvKTrB4IYS57rjeeX5ot6ib1ltmoRz+VRg4AAg6QSnGxFssYIZKvgWXBEmRhiqi16Z6WpSNV/+yw8EqgYo97WNwMHOeMyDV13z8YgKQmozL2yeR2vPwFPZELm+0fXOFxIALGxyZtFBYX1hz9DOe8tmbvpXRvfwbwan8HyfBWqYwB/XQeNOtGwNGKoycw1KIkapaOMuy/arsu8b34ZPG1gOc4C6MgV3QrnhQhxXpsgSnyhu/Z6JfPwbXIfhsxhurSiZH9eLieuom9WLAWG6y1EU6p92j8rMZnRS97Ne17M2U4XFOe++vfHdTD3+YyzdGhQHKjVBu+YT1Kacyr978PcgVPvMiqQsVaCLX/Hc90AutEshWkR65jEj+7gFzVZ
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 14:51:04.3415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3c7185-1800-445a-8e24-08deb2916397
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7427
X-Rspamd-Queue-Id: CD2F7551B28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz,vger.kernel.org,ericsson.com];
	TAGGED_FROM(0.00)[bounces-288331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ericsson.com:mid,ericsson.com:dkim]
X-Rspamd-Action: no action

> > In mv88e6352 scratch register in Global Control 2 set of registers 
> > returns which port is attached to SERDES. This value is set and stays 
> > constant after the switch is released from reset; thus, it can be 
> > cached during chip setup instead of reading the register everytime 
> > when SERDES config is needed.
> > 
> > 1. Add setup_chip_specific member to mv88e6xxx_ops and
> > g2_scratch_config3 member to mv88e6xxx_chip.
> > 2. Add mv88e6352_g2_cache_global_scratch_config3 function as 
> > .setup_chip_specific which reads the CONFIG3 value from the scratch 
> > register and caches it.
> > 3. Call .setup_chip_specific during chip setup.
> > 4. Refactor mv88e6352_g2_scratch_port_has_serdes to use the cached 
> > value.
> > 5. Remove the locks surrounding mv88e6352_g2_scratch_port_has_serdes.
> > Not needed anymore since no register access in the function.
> 
> We ask for lots of small patches which are obviously correct and have good commit messages.
> 
> It seems like you could break this up into smaller patches. Taking to account my other comment, how about 4 Patches:
> 
> 1) Add mv88e6532_reset() which simply called mv88e6532_g1_reset(), and make use of it for the 6352 family ops structure.
> 
> 2) add g2_scratch_config3 member to mv88e6xxx_chip, add a helper to read the register, and call it from mv88e6532_reset().
> 
> 3) Rework mv88e6352_g2_scratch_port_has_serdes() to use the cached value.
> 
> 4) Remove the locks.
> 
>    Andrew

Hi Andrew,

Thank you for your recommendations. I'll send v2 of the patch soon.

I have one more question; now that mv88e6352_g2_scratch_port_has_serdes()
never returns a value smaller than 0, should all the callers be aware of
this fact? Shall I change the checks for return value on this function not
to check for <0 ? All the callers except 1 will be refactored to use
serdes_get_lane function later, so it might be unnecessary.

Thank you in advance.

Best,
Fidan.

