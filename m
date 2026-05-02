Return-Path: <netdev+bounces-283389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME/WDjbD9Wm8OgIAu9opvQ
	(envelope-from <netdev+bounces-283389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 11:26:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 962C94B1843
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 11:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C33D3011129
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A930BB80;
	Sat,  2 May 2026 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="CziTYEC4"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD72FD681;
	Sat,  2 May 2026 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777713962; cv=fail; b=csdl4CBH3LGklQ/yO7cI5th3ZHfnKn7Z3nN5lAqGQLxO7g5IppvQUjcwul8Vazr9h1NLLzA36JYDNbobdZ2dnGUcyaFkLHeYFi7zhBcAqeCtQDazmusQ6Yy78sm4J76LleRpc+6hRjKgPyFawI/w94MuTKJk/c/MSN4FNSIo7KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777713962; c=relaxed/simple;
	bh=WzI0XFBLrsw+I/UIMAemIKuaPl8WkIHY2pSMJmn/z6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHfWz4dRbOZVpmHpgJxa3xXUC4ZxL8fxgBCsgBqUVBSDaAG4nWbAKJUP0PY1B574S7GsGeSd590SYuT4WE45m5/1vm6LNbQ19mH1tEjVtTlAiRPvf8DC5Thbb8LUQepCzMVFC+Gc1AS0YHnNiRDAPT+BlSMX5EBqogqEFzivEzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=CziTYEC4; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7NYFCp+n69KLR48g4WdQN2JgWyWGyIzmI5vcaGuO4B3JeMOweA0E87yVDj2MbHePYuREp9M+AEn4IVsz/Wjt83Gxel42GPDakoTQi2OW462eNiprh/C/jE+ZeWoOkKrOmFa4+JObypMmHY385ublz+v0ipiYAudVUZm8cyLB2IpVGNLuxEpoIAQg8D24TU2WpTWaVtNwTGjq+vH8pFaHF7+5+Q7ozLabbKKAqSuuBgAyv/SwtPNHAgPHHeitRmViGryop9fhCTc38PF9J5k9WB7WLGZLpPHDdGOUt3WbcBPFtV1k5fiyGWgsehNsxjCcgIypR4gZuBl/oUBqIdnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crXNQPpS7bTdq3eMZFpBVtCyidF8jttCKQxntZ2buFM=;
 b=g6RyW3EaqyfaJIgHFe498x/jd7hxTT5fybNtaUWACeFZ2FnapDY5nFndslCPkZ2fxCjhoVx+5l5tZUamAR+rFf3888Y23M822xqYbJ5UGcC+cA3k1mDUtQJiDNwNCa/n492M3c2F/HvjuNR0pjEG8h5dsOExrlS7Ko/PldN2haAmdYP9ZDK5yoo7Uupx+0ZGv3nYZbKWXWmp11KzT4MEbxI9toAAOW27Ol/9zkv9BQUS+tOFpYdp4ZwNLJSMMfqBgzKdOLtDfFh7H2QYnba+Dv78nf+FxpYzP+mnsHpIPtXmRu4i7TorCkhjojDHmFTH5Vp9yHuyiSVex66CHwUPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crXNQPpS7bTdq3eMZFpBVtCyidF8jttCKQxntZ2buFM=;
 b=CziTYEC4DRvnxvnLpz+/hcDAvdk2Tto9JsjGOksWTenoQB/LdAIHbEqLOrp1YmfJVSiapIQZGP837P+zsN9Qc9dl0ipwvMjk0zqJos6Njwe+xX8dTNCJ0ql9Zm8472iuvrdSXo35WL+YqfeTKtkl2F+8HIxaNAZl5/Txr73dNCubi0kDFQvuvE1TmrOQroXWPJ28bZvBnuD7c2bNeDNLnb384hfncYx3oSi0X1ezRou+V5mBOWRMJCuL4V042iTXKXKsqwiGtYxUDszKfklvc2lOIH4sRh1VmGcHNi7QAc+HAwnd3DRkspD+oEJxqpUNyvBC9FtoiDZserIfCjREyQ==
Received: from DU2PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:10:3b::32)
 by AMBPR07MB10620.eurprd07.prod.outlook.com (2603:10a6:20b:6b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Sat, 2 May
 2026 09:25:57 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::f1) by DU2PR04CA0027.outlook.office365.com
 (2603:10a6:10:3b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Sat,
 2 May 2026 09:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sat, 2 May 2026 09:25:56 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 2 May 2026 11:25:56 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 80F4E4020840;
	Sat,  2 May 2026 11:25:55 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 6B2B91005C88; Sat,  2 May 2026 11:25:55 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>
CC: <olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.eckerman.ext@ericsson.com>,
	<fidan.aliyeva.ext@ericsson.com>
Subject: Re: Re: [PATCH net-next v2 1/2] mv88e6xxx: Refactor 6352's serdes functions
Date: Sat, 2 May 2026 11:25:52 +0200
Message-ID: <20260502092552.2217977-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <8f2a1956-5cd9-4267-8035-b81024148a9d@lunn.ch>
References: <8f2a1956-5cd9-4267-8035-b81024148a9d@lunn.ch>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|AMBPR07MB10620:EE_
X-MS-Office365-Filtering-Correlation-Id: c376b90a-b8dc-4a59-1dcd-08dea82cd0ad
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xcS0MTKrXVMXQnslsryCEP1DhimVtI7ZLLZF7t/kovYpG2S6eQl/9+NpoGjA7a4psIWEoFwa/lclpWCPSy+hJhc+Cs7Aw/cNHutY6txTl0/CtgBjdfriJFFLMgSRTPC6J4cpQx1KAm9Hmmf2aAfkgUjBwKi+JFOezAe2WDrF9cLNiHgIQqdyx1lMz64iNu4nFoZLgQdNlvWY0RMVUlC91GDLLw/Sf8Q6++ZX2hAf+iMT5pfQEozK5eAVCB1uVL1RquCirN/Tlw9YRkMYWskMl3NDe2GPI1td70y8DiE1HxqGgk4Xe/zKL39cJN60d8u/1tahQ5c4IhcjM/rHY7NGIxBhUIlf/rhhxq9+J9d988I6JnA80p/H4WlVGTasHBNA4QFryPeANXJC/ySitiBw64CUwRFEzAHmau9UEHRKjZ0BUv5dYX+9eeMGUrPrmskY+6zCKw64X4YNvj9V+o+ldJlk0JilvKXKr1LZPxaljF2H1r3f2/bnntWzJJxNTqaJWhxz+088b2HIYFbqc8WPYhnvtlGpzuvBbEaGKtrPZteY0ykZvKbST/+REbXiPQ6cNKFspVc9pFDhaOQ5Pnggp7fNDg7uJSwz7bPxaMnjPxw+OK60xNzD43Y5H10sBeUOhnVMZlf+G+X3gqKdn6sSn8CQ9GPHr3P91ZSpc3vDym+Pc+BzMuesGEdSwZU9WeLKcnoHfBFfBGKjp3LHAXkNuX595RkW4ZLNj3O3Jku95nE=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/SeAGb+Vbf3KJbGgp7KqutbQeI0RP65b/pyhDTz7ZruRIXD/cd2dnBuE9QZaAGilLcCL1KH21S7h/9bczCZ3+ccjJGuuN1jskLeVBdRD9vARhB9rcnWgwHQVM4ouc6GvS31gpuJ6e2AosKwv4oIPc/EKShKqcxEyU4+V2Uu1GmVf/QEKaAsB9we7gZerOwHU31yVmGqgRtIudaGkrv7K586NvmL7hOsOoTIJnmZKHkkEiCP+pgrKNS0iDNk9O1ahKtdps4IFs2C8ca2H7Nb8ACAt2G8PtIb9bYU4hNuszkhhnaS8cEHjw8VZAMVVDX5zcQX1h4+tp8lS71s03jH0a51nhPmEnZjbM8ydF0NDK1/x3MfpHiHvoI2/gzHz1/+MjOvvEEXasK9a0ruhxM+9FYbcsATSA5yzTdHviG3an3JzHTKa900+/WWGo0QfA96i
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 09:25:56.5434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c376b90a-b8dc-4a59-1dcd-08dea82cd0ad
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB10620
X-Rspamd-Queue-Id: 962C94B1843
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,ericsson.com];
	TAGGED_FROM(0.00)[bounces-283389-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ericsson.com:dkim,ericsson.com:mid]

> > I wanted to make those functions generic and not introduce new 
> > functions other than 6321_serdes_get_lane. However, those functions 
> > cannot be generalised the obvious way because they run with reg_lock 
> > already taken which would cause deadlock in mv88e6352_serdes_get_lane function.
> 
> Ah, the scratch register. None of the other serdes_get_lane() functions need to read a register. O.K.
> 
> So we don't expect the scratch register to change at runtime do we?
> 
> Nope, the value in it is read during reset. After that, it does not matter what happens to the pin, the value in the scratch register is fixed. So maybe read it during mv88e6xxx_setup_port() and store the value in struct mv88e6xxx_port?

Hi again. Thank you for your feedback. I can make the proposed change. But
I do not have the functional specification for 6352 to refer the change
to, neither do I have access to a 6352 to be able to test the change on.
Do you have the functional specification document of the switch, maybe?

Thanks,
Fidan.

