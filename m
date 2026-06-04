Return-Path: <netdev+bounces-295249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2xc3LMV/IWoLHgEAu9opvQ
	(envelope-from <netdev+bounces-295249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:38:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50137640669
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:38:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=MuwEEA6g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295249-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295249-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92FE6304CDEC
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BF847B435;
	Thu,  4 Jun 2026 13:38:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0863AA1A1;
	Thu,  4 Jun 2026 13:38:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580286; cv=fail; b=uKIuLH2auyzzJnqzMwi6eG/KOcxgbSqnRsB3ufAg+o3T+TvA5zrNRyLPyX1AIu/6HFpaiZU6zDBJ8YX4PIHVEKOVmeiALCsWUuWhMeyIPc5sskeKhJUbWy/yo5DtEclFz9u8ioXFUYMm/4OEnWc1/7zFeMr2XFUF4AGRNyBTnO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580286; c=relaxed/simple;
	bh=H0pDEhXcKpdUn1hQ8IJUsGkUnILlrsXPzUjhkXDYlPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iCrh8NLheOh3OJcgLJD2598wVBiJH9dOgdDpvzAF+WR83Gvxked2Hvd2fiWKMRCWs2S8M11G9ioVy3kdwoEXQi5l442lJAAie2oFNGDl9AbXBMnozkogbpkoIf+fZqFPLfAvNnrKU7/a2A0z/hHoyxI9u9DoFypfxS3vXzt/+VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MuwEEA6g; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeNXEsk7qqGj8uPQO5hvcm+09DW46s0cAsKGqYw5XzLaOTj/pI+Se/HKXpvdEE/g/wKOugu1257NFqJzMbGYMAtPGP8bhFB/g3DLSpbQiKD+zWiHSRJXuhfZDx70LUiqvJhJ9w0OnVMf0UmtVCCwV2UcswzcPubTynId7zBPRGAEGb5D4/eURbPNi2Ag72dAYMld9Q6pHgWWH6fQTKgnToaX9t25rXpXeEPZbah5/F9q6hurVfdn4Tj5lykaK6Avtc9QNB4WnDroKcHOsYyrvvhylkK0Jywht5Gcm6O4rcEywHZ4MgsNElHLApwT26tFHTnhwzfRNZnGmYABWdmwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtoEIumW3IhBRKJpNwfvs0sarf2RaqNd0j2VsBCV6tU=;
 b=QHvvp/hu7FnXAFDm2VTwdOawIkmlR9jl270pZIdzZtJNG1MOq7zse0rKYjP0x92P4ayDkofzoa7KWS+78VvE8ATCHNgiIxG6sh5/TnJMrEWc2qZcrmWq61N2dC36st56egFnn6gsioCEgHXam5CGFsFWinTpqANqKgB40wsOm0Rs8ga/Dk25dFLmdYKCDaWj9PN+QxOjgRYFokkpc6FUIc40qaWdoWQtM9yCm3Ff5zDu1NHJOj2I54yi0H+H16nF1Zl/99ZZdbCrFbtWPv1nOGGJ040Ajq8UH7k7F5OezuBSWDMjp3u4sUEdPHXp8kUDu8nvpy2JVH5183LTGma5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtoEIumW3IhBRKJpNwfvs0sarf2RaqNd0j2VsBCV6tU=;
 b=MuwEEA6gB/eloko7xVap28vsG5FsVuHJEdMCbdpGkKT1LrM4H9zlgIHbQZkaQfhShTUbX/UZ85pXnhwCzlF5pnc1a8ieke26qVN+ECrb180O2e79fR8WWwaW/TB2m9+5l+Yk4a5yD4+DOrk3QckpSKvDhlq1SkWNJTbxQVw/XHk=
Received: from SJ0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:a03:331::9)
 by CY8PR10MB7122.namprd10.prod.outlook.com (2603:10b6:930:70::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 13:38:02 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::15) by SJ0PR03CA0064.outlook.office365.com
 (2603:10b6:a03:331::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 13:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 13:38:01 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 08:38:00 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 08:38:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 4 Jun 2026 08:38:00 -0500
Received: from [172.24.231.93] (ti.dhcp.ti.com [172.24.231.93])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 654DbrGp3466542;
	Thu, 4 Jun 2026 08:37:54 -0500
Message-ID: <731e6d63-0a5c-448f-9c6c-912b17c69bfe@ti.com>
Date: Thu, 4 Jun 2026 19:07:53 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] net: ti: icssg-prueth: Add Frame
 Preemption MAC Merge support
To: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: <liuhangbin@gmail.com>, <haokexin@gmail.com>, <vadim.fedorenko@linux.dev>,
	<devnexen@gmail.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
	<arnd@arndb.de>, <afd@ti.com>, <basharath@couthit.com>,
	<parvathi@couthit.com>, <vladimir.oltean@nxp.com>, <rogerq@kernel.org>,
	<danishanwar@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20260525182700.3135858-1-m-malladi@ti.com>
 <20260525182700.3135858-2-m-malladi@ti.com>
 <de0255c8-d751-4220-b0ab-88aef3a15f9a@bootlin.com>
 <ac753d51-0a1b-4fda-aae3-661ca5b8715c@lunn.ch>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <ac753d51-0a1b-4fda-aae3-661ca5b8715c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CY8PR10MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: bc89e29b-8236-450d-839a-08dec23e7f7a
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qZyxZFXqzZ7r1u8kCoiTu9k2LGEl+MQ2T0YuWlfChswuF+HCwcVU1nF8k1oqhMgImiaanGUI7mfOByL+iyxpGV1pRqa2D0bl6XAza6geqzobXYal1q2DfTugDd5tFdwQs/lphNrhCRapwX7KCjJe60Regnp3G8/PMaDcCUXfTdpA3+3YWs6EjmiB7labOB/oZkuG/KIddwMfaphGfRSRkmijpjrW09HtLR9YlaMhGGrWLORn82SPdQql+ETagQVYPq1i5kDcgERoLXhTpVJubfNZ8KiTBGD2RWik1P68OezMkJfqGfie8aItXzva5K7FktttksS6jDjdSAvoO/tBLsxIDeVAAmK+KwdHgoaXipsMJ0/qTsfKVUV0bSMjDHzS+fVEveSfRNjMYPKzKa2IwrVkb0xUDKu2aGzmnln+JKCtiI3jf3Z9zOH7b55746cosE8jqTifU1YN7P4Ziz+CTBg6FL+wrIY6MDI4e3LOKPUzOdObs1962mcWy6lXu9wp1EI3xRPLY1ilDay/whwPFD2T22egI61DPJ/OqiE4QNl/vKg7rl8HeeUn009EvbDjx/j3IU6kVeT22pKtHjAuhJEoGvDiv79jtaLFiif5rJABzsCHsckfEvxezgGgr5LuwQLsaZoPD+IVr3Fd3/jbcLkBFFTq6MRRyOn5cZGdrnf49nf7qVw5X+XJM9KScOYQ3/gozxYG0osCoj0iWguN3NxITZgCO2g0YtxUY1cuEGE=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AoG8j9JCSnNTGD1NPfnO+lDGxZZDxkVMSmqwaZASpT5msXyN3b1rL/hSeeqdyAYwZ7z6TDqcKM9qKAjzHCV8K9gWOpabFrWCXhSo3BoCrKceI1Sp7df2sWYmzTj1dQC+RNgZ8QYXd/BNmOr02DhQmN7weALAi/4bbgAkSYvXv/K5K7DE3VmkO3wO+RpfB4N3iT9uq41CPmt6kthObqmbFB8jS2Q4ckK7DTHdUUKOT72Q/VldSGFyHcrRNjSSWqtUW9XJ7IkzkoE+uEptpbWXc76hZP3OxZzzdgAmO68/FaH32gT3nrdWgR0bP8q8IbPKzpilXW+qjKwKL8getPlrV9DKRfeWDLeKSLwCd/Q+3LnRT+sBCLRNheU3wyfcd+4m1J42dPkphV9/JkC2XovtH79fQcM6+jEBkgJcu5bXou7j1441J+qtdRiaM6ueUVA1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:38:01.4345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc89e29b-8236-450d-839a-08dec23e7f7a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7122
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295249-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:liuhangbin@gmail.com,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:arnd@arndb.de,m:afd@ti.com,m:basharath@couthit.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,intel.com,arndb.de,ti.com,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50137640669



On 5/26/26 01:16, Andrew Lunn wrote:
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> @@ -44,6 +44,7 @@
>>>    #include "icssg_config.h"
>>>    #include "icss_iep.h"
>>>    #include "icssg_switch_map.h"
>>> +#include "icssg_qos.h"
>>>    #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
> 
> Sorry for hijacking another message, but the indentation looks odd
> here.
> 

Sure will fix this, thanks for catching

> 	Andrew


