Return-Path: <netdev+bounces-283294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N/oOZgU9WkEIQIAu9opvQ
	(envelope-from <netdev+bounces-283294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 23:01:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9D24AFA1E
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 23:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B0BE3003BC0
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 21:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFFE423A6C;
	Fri,  1 May 2026 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="kxt/RVXc"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DBC359A99;
	Fri,  1 May 2026 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777669267; cv=fail; b=UXzvEpNgEqT+JZQaLFcEXamUKRh1sD6aMjEvr3OnyK5EBG0INs3vdlPOOxeWuMMV5Li1CJL3eCeSYwuyIYFZ0Lh7y/AzmqdjJY7VJ9HhDKbTUYx+xCOacSB9YGqe+Le7NRaxTdhGj95e7IXzWX8Ver2yr/o9V68mS+GEwERo07I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777669267; c=relaxed/simple;
	bh=Z4y4F6fYnESW93yaa5npUa30scaiHV1FYsNHu3WpnJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ux9y7z4aNCwVGMjpgp1N+HocwJbM+Ce0Czrld8MqbvQyDvT3vbL5YjtaguH9r1mi//Tp3FYMbLJiwTSln1Eitoaj+v4tG09iBzrpQdwJXcp+6FK2LxhdT249w/0QgX9cE1C39YGB4+Vqp46mp1Wj46c26cmHFz2Ke4pQv2mKZsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=kxt/RVXc; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QziT8NVUlnKX2jpxUNDfhgOFSnC7phUfZSEttFUpsDy4yGvQGhOzzYzt+qaWeqz9SVAfB2lDm8Q0qVX3Nfqd+UO3EZBVSZCv2SKlwNHj/9G4ZLOnn2Km+Yk1K/2cQkk7gtIdGhPU+XHgSjSHYTSElZC/w41ceuqYIPoCtMjp5efvEfHwzrowzp4ZRsoKVciEvWbOrFyCefwTYDb5VUSX9iNVXdiGXneUpcDWhoTcrkE6aj6cXvo+Q6xtgYbeG2tSYcIVYAFsfV13uLZqDapz5dCgxX2eGYdxLYhoYynxne5+nRahY7SB6RcUCQxbTT7kojIPnMKtjtyyVJeCwbjl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okipBd+cW6TXUuSKGZZQFs/mEgFTLqsNb4VoRf2kjKM=;
 b=SopYKqRuY6LUUMmKwS3b5Gn1LaTg/C3WLtBGk+3OBvYg6gO4f2UwqqMAhCXIZoNUTJ1dwiSsyWtq7var77rLxY7gcnnPUNztPjmGmcjSExD6cyRkP2/CgHyBRTRi97uU/aroHz1+uwzk1k7+QhskUYvCClwkHpzk5LOrQRnXWcvzfkKnu5DOZgllzbAehhFJi96WtNYV9V4syNqPYw1KflaKXOfNHJ3RYY0VS7s93AUESseCLRuQvjo9cTRG2MyOkBReZ1z3IhaTvOGw9xCqpReEqC5TjsEddMd1hiTXqdpnGz/BpddstQROvFKzqU3InkJISKMFk01PVSSfmqfecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okipBd+cW6TXUuSKGZZQFs/mEgFTLqsNb4VoRf2kjKM=;
 b=kxt/RVXcD6SmB+kH+ojavJaFT6+6lZ6VSnSY0EFa68h2jCeJngYA2Wrxk5HM3UoKlULELWI0/i1aAjaaZTQ+CNopHTR5TUamodqj++TBwQMQNLlBwYEGomM9rcQ1/YL9aQCNbYc6BPQ41qs8qMrItC36w5y2oadcMV64zX6lBBnAzbDykauzfjLLo2nB4Yc2apvPQZugh3wUg2cgAhPxRLcoYW8k+hpbAI8IbxxRArv2c4ZVDF7X0aiQCBd1MQXbAzQobDnXFMd64S+0FfyY9us2zgEfYVjhI8IZBN6s0EVvlklOVNVTMnC1qNgyciuTPMzF76UsSsnxnFMSGUsiSg==
Received: from CWLP265CA0535.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18d::7)
 by AM0PR07MB6290.eurprd07.prod.outlook.com (2603:10a6:20b:154::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 21:01:02 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:400:18d:cafe::fb) by CWLP265CA0535.outlook.office365.com
 (2603:10a6:400:18d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Fri,
 1 May 2026 21:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 21:01:00 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 1 May 2026 23:00:59 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 5507F9569E;
	Fri,  1 May 2026 23:00:59 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 415971005C88; Fri,  1 May 2026 23:00:59 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>
CC: <olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.eckerman.ext@ericsson.com>,
	<fidan.aliyeva.ext@ericsson.com>
Subject: Re: Re: [PATCH net-next v2 1/2] mv88e6xxx: Refactor 6352's serdes functions
Date: Fri, 1 May 2026 23:00:36 +0200
Message-ID: <20260501210036.1675100-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <1a57e151-7fff-41c7-9616-20237c27e935@lunn.ch>
References: <1a57e151-7fff-41c7-9616-20237c27e935@lunn.ch>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|AM0PR07MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4fc8e0-521d-45c8-5a65-08dea7c4bf90
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A6ucNA0qHdqY/kudN6nH5eFcIgNzXjEVzEbVBAGBWd7Z0qAnQlJGmK8nzG2aNBvnkembs0d6q1AJi/OcFdGMRbjB0opLWYUQx8/l6S9rG4YdgNXcA6+Fgt8eJepxQn/iU9vNwYNTTc3wSX+EuTtCKAhQ8WEbi7MZ4xjgLa2gNI3XU+XPgljxtjfHxsXJgh1o7MwlVqOfBMPUC+ubLyKleMRWwrBM3sXc3X/ICd2R8k7J4ddxGZ7GmwDvOi/fOOLzJX9rtHx2z2ajWjUuu29fed1BRlr072hEZ4R6xSsEkD/jJvWcpLDDxPBwFkjiU+aVvODolca/EU2P2W+LL01Kl1qyTm1Uky1g88x3wtcHERUYdrWfzKWkXL4G6I3G4vfFKeDcyJu4FqtrkBROd90R3mXB7yhamjqtiyjS6zDaRNsAiGmp0ndgsLW3gX1NXmLL531lx5VA0buZITm/yFGxOpHujKAOLBdgx1mVI3IR2DcEWPmaAvO8Vxpiu3j8fxi3UA93FYEBrgnf3TncykdDOtO4NpttbrF0zy1UF/A1eg0uIZNrwqOFq7jNy9g+YyZii1/Bhl4ZuE/E29qh14eQXHChzHWZu7cUPOYMto4Sz9uk2XpGh657xceQdC5JNcCr8rCnU1mgsxNY92PIEwrEvcCRk9g0cq7v3yEPLChH4Ai9qCjPGEkFlTdSMvGaKMF8UT9KIcUP0THVfnpSxLFoMsEH50rbujbFLoCsdkngLh8=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OVJhXwHP2xdYpXgq5oTmR8uXInfOO+dFrO46pcDs6gv6MGPiXV/ttThG1ND3nRg9kY0bfXudD19p6Rzznacb3SSsskiBtNi/PnaSl+Oq+ea0Br6M9KtqKHn8Fd3JzPul0mwbKhjYU96V3/vS3stDeQN1p5fg3CofNl9pi613S9AIHBzed6K8zopfv+WfLEtWujtGq571rZyVSSO88JJRj6dKu3AMTjV81VkYHUBqRebKcBpjwj3GN4LCPWxDDg8JlM87EIiPAb2Z+4elu1xE4VeQ0hLr3oUht6o/cgdplWCT84DbonfkdmNGWoW/wBNTiJ3T5oVUfqL23/oBwKr+DXhwU77epFOzKvCUdx5emp3/L+cH6rh0bSg7zTzT33TACfHlyflHbQgE+6CNlWmRgiQC6IVLcCjlAS+tf0tQcQZE1wdWm4Da/GP5pJJibYoX
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 21:01:00.1950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4fc8e0-521d-45c8-5a65-08dea7c4bf90
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6290
X-Rspamd-Queue-Id: DB9D24AFA1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,ericsson.com];
	TAGGED_FROM(0.00)[bounces-283294-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

> > @@ -185,7 +200,7 @@ size_t mv88e6352_serdes_get_stats(struct 
> > mv88e6xxx_chip *chip, int port,
> >
> >       for (i = 0; i < ARRAY_SIZE(mv88e6352_serdes_hw_stats); i++) {
> >               stat = &mv88e6352_serdes_hw_stats[i];
> > -             value = mv88e6352_serdes_get_stat(chip, stat);
> > +             value = mv88e6352_serdes_get_stat(chip, 
> > + MV88E6352_ADDR_SERDES, stat);
> 
> If you generalise this, you can use the same code for the mv88e6321.
> 
> > +void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, 
> > +void *_p) {
> > +     int err;
> > +
> > +     err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
> > +     if (err <= 0)
> > +             return;
> > +
> > +     mv88e6352_serdes_get_regs_from_lane(chip, MV88E6352_ADDR_SERDES, 
> > + _p);
> 
> Here as well.

Hi, Andrew. Thank you for your review and feedback on both this and
previous version.

I wanted to make those functions generic and not introduce new functions
other than 6321_serdes_get_lane. However, those functions cannot be
generalised the obvious way because they run with reg_lock already taken
which would cause deadlock in mv88e6352_serdes_get_lane function.

Do you have proposal on how that problem can be avoided to make these
functions generic, too?

Best,
Fidan

