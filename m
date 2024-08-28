Return-Path: <netdev+bounces-122643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D3E9620F1
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B801F212B3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8221415A848;
	Wed, 28 Aug 2024 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="EBqQlNKy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB1D13D248;
	Wed, 28 Aug 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829866; cv=fail; b=Tti0aHt/SKULdLWcg6isGMzwAIqFKHeNTrcwo9lydHq0jryqmdFOTLZxdLPLvzSoqFQG6FKv+2BdH3V8vy7GjXo3CBVeVuQr6/dT/rsg3NrG5K/nahTTnfSEV4LGGWo5oSgDckoTmgozq4LbwA0wAOAAb58r/RddKS8yvM/2NAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829866; c=relaxed/simple;
	bh=2+2Y+dwqlUPb/hpzB7uZmJFSs29cEbpJYJN67yApxbg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GBIcr7GsAUnD+t7Hr9Kwsd8GkKIZspZn67XzUDD/aD/gOF76NljHUa0cNkx7xMaz78QGnL8kcmrPaXaWCREFXZtWf0MRclg4vuNamVhmHT0rAAJ1lvdz/k85zZXQv7GTLbAKMlpxKKHMjUn2YCb9V0mC9bB3MMS3CG6hZ215Kxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=EBqQlNKy; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhP9CJHMNuvNjVHMpZ+tA8W0dDp5hdLxE6GCjaQGVmGDVIKp/X7RXk4wDd+qCJC+K9SKCq5OjU69K0CnTAAUFHPTno0BWMWKHtLvL+o+fIoLyCuojZpsPZLBGeoD049pEZxiV7EufskGO4gjieDMb0o4wC+EHf4msiK3wgwWHoxV/xxfPsC/ZruttQ8PzAYxKxF+b6L7ADmvOEm1TeB313Zf1JqS640bl96E0e0tW+xGne195SG6axbSwnTTdbsGxnZ1nH0bUmme5ihpBErvdI8vHi4QI00/zUqwUDBKdb1faZBN3eWszt2bCaJhcGIZV9qQOrx8LwQiNNmlkjtD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzFS4ZkTtTYEshIjD21YIYUFAgSmmHVfWR6MFENQWlw=;
 b=CmFbW8J2rDNfzdY0e39x4elQ1BMGX8SFpyJCFQeoBUVSH43PGyWmLysaxmcl5Efz0aJGl/1XK296AaIurkGgXloshjmLNqOUJ+95OnXl5+LDsnpx1jd/oi++calTNMBBjvIEP7A/OwUZeeOZls6XnBQnzRg9SURgS2QQxzco9BidD0RVJZnAy+VLvY0mSg1dMABnE5spuAnlDg4o3Ism8ZfgPifvIN0JxvIuVQfW0f95HZc2uoCB15NYzK43B45grxIb8+SOA0haZt0ovQqkzwTDLNDhqI5SM8CodtbUQHrNOKVxkpeB6u9xs95pkoT5SmvyTStKR7zPblFNSkfAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzFS4ZkTtTYEshIjD21YIYUFAgSmmHVfWR6MFENQWlw=;
 b=EBqQlNKyiqnkMKNljAcSKxTTW6w3x+DxDE+blS9kWleMq4YomKUu3+7YzTHK+RiDwr9oWgP2aqZAYZXKiV5bHdW0HI6cokVfqcXRPqIkExoI3f9zBPazz1yVs3gCNXBweK4dpYVcsdzehrWaExHhvY76XiwH6uQnS+nPoMXW8BQdb//8OWYtPEPiVJPyTld4ywh1jpN0YQEosCcoEjRE/h9SBkLIBnPIc0q7+A9QXLaHYM1BAaJLDNaKpIjfp8lmrWoSZ8RQ/D9fNGx7i2Ud7NNb8FS4wTq3N7UkFTpie6UyYrpdTLJCb5dYWbx4oqaNg1+GJivUwjSfM6Vby1IHzw==
Received: from AS4P192CA0024.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::16)
 by PAWPR07MB9201.eurprd07.prod.outlook.com (2603:10a6:102:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 07:24:19 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::b) by AS4P192CA0024.outlook.office365.com
 (2603:10a6:20b:5e1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 07:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 07:24:19 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Aug 2024 09:24:19 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
	by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 453D24020B6C;
	Wed, 28 Aug 2024 09:24:18 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
	id 297A8607B0F1; Wed, 28 Aug 2024 09:24:18 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Georg Kunz
	<georg.kunz@ericsson.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH net v2] mailmap: update entry for Sriram Yagnaraman
Date: Wed, 28 Aug 2024 09:24:17 +0200
Message-ID: <20240828072417.4111996-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PAWPR07MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 392f1afd-72ad-4edf-4700-08dcc7326e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTI3TTN5QmpRUjRDZUZORUJ6cWdraGRJWjY0VXVVTkdHZC9aTFNUYXhXYXo2?=
 =?utf-8?B?eVlBQ1NJaitWOVdPNHFaZmdiOEF2Nk9nNzVKSnBuWWlCN3JWWDlKM25Telhn?=
 =?utf-8?B?NVFXU3BlMG1pZW1lSkF4K0pTOTVuL285THp6VW0weFdMcWxPbG54a3JFT3Rr?=
 =?utf-8?B?N3E0eXNhcXltU1lmbStXaFhJVWZXRkdLU2FJekQ3Sml3UmpOT2ZlTXJXS1gx?=
 =?utf-8?B?RWhENGtnWjlmOHp6cVhnMU9zb2NNNXo1c1gyTzcwUDZWVnI4TW1UUzZBZWM1?=
 =?utf-8?B?Tjh6Y0lSUWRQSXgyaGN3T1dVMDdwaXl5MVhPWmpXdXMySWpibmhMK0l3U081?=
 =?utf-8?B?MkxlWFFicS9iK1FpREk3T2ZBL2tCVzkrNDJMa25nN2lURU45REJhcHZsR1Bu?=
 =?utf-8?B?cXo0Wkx0YlJrMmdHeitlMXdBVm9qYlVycUhLY0NVK3VPSW9MT0ZiWExtR1dM?=
 =?utf-8?B?cUhCdWhDOHk4MDlQekxIS1NnZkoxczYrWExQQ1JnNGJ3cE40QStWTW9zSEZH?=
 =?utf-8?B?cnIwZE51RUdCU1EyZ2duNnV4TkVpUkZaTjJ1MzlmMXpDcW5ZZlJHWm5xZVkr?=
 =?utf-8?B?citISmdDT3NvOXJuYlpPL2hBbXJKNjdvR0pCbUVLNEd4TVkzaUpIVFppb0Fz?=
 =?utf-8?B?aGRpeFp4SXIxUUVkNDlnZ1B2T0pSd0ZhYVl5cExWWTJsOFJGSXkrVFdRZDhU?=
 =?utf-8?B?Q01neXorQVV2OUhuRCtWTTI5QndRZHhXRjdoQ3prNm5DMjBwc3hGNjlSVXNB?=
 =?utf-8?B?VERzL2J1c3ZXdXpvNnJwcjlXVXUyaUg5aWlkSXNkZ1UrQ2FMS3Y2MmFMbkZ3?=
 =?utf-8?B?d3o4b0RIR2R5ektUVGp2TldubjV3aTFud3FNL25zZngvbnl3MU00dzZkTXZx?=
 =?utf-8?B?REFsa08wUVk3Y3N6bTdUakh6ckNaMDdOcWNkcE5URGpnR1dvZGg0dzEvbXZo?=
 =?utf-8?B?c0p1UGNkN09iN3R1WUkzMlR0SDh2WDhIYU1uY0k1R1orMzRPZ2loNkRmdnZ4?=
 =?utf-8?B?emNGcE9yOUNSRm5YUm1wMWhRQVRhRFZlSDQ5NjJBNnhLTjlmTGZkaU1kTTRZ?=
 =?utf-8?B?dmVBQWhmMjFRdExhQjUzMFd2ZVFvRVFDUFVNRFpiOCtOdEJ0bzBaemNqdkFz?=
 =?utf-8?B?VVNoeXNOeDdzcDJ4NDVOWUNyS2JUOHJEdnJHVVRCM251UjhIL1RsalZ3M05O?=
 =?utf-8?B?dGdFNzVnY0RzQUp1TWw0YnRHMTF3UGlMcy83eUtMVzg1VE9BL2hhZUZ1UUIx?=
 =?utf-8?B?bGk1eHJobDhEeG5hWEowekZWTldLMkVqL3RPL2JudFdINFdoYTdxYUFveE83?=
 =?utf-8?B?TFZMT1FQbVdVcTNRMitLa3JHQmRyd0NHSElFS1drOTRHbGVpWTFWRlZYQVJK?=
 =?utf-8?B?cGhXd0JZb28wWVp2OGhWbHJGdE1WT0dZeml2d0pTRlFkNTRSenhMeEdaQnN1?=
 =?utf-8?B?ZXFibXpONGRIek13cFJidFRYdkkzSmxmZG9lN1BrMU15Sm1qc2F2UXVqRWNr?=
 =?utf-8?B?cnY4ai9wQ3h6SXE0VEFxaTRZcEpXNVNkb2FjYnBGSDhETllVdUhtZjRHQ2Rs?=
 =?utf-8?B?TmFsejQzNUQvTldSMzM2QlRRNHpxVC9xZmd3WjlDWlZKTlYvcjZPY09FZDdv?=
 =?utf-8?B?ZG13UHlyak5RZlRuQmZmQjdIV1NMWlUzeWJ5dXVKeDgxRmswdFFQRnZNZkdO?=
 =?utf-8?B?L3lVcGFPZ21CelA1K1RSUERVeHJhZGpQL0ZtQmtoRmhiMzJMTFgxWEZOSVFP?=
 =?utf-8?B?TTd6TUx4LzY3ek5EQUZpejFBTkFxRDY3N1VBWEU2cW5DYlk0S0NDNk16aWNJ?=
 =?utf-8?B?NWdXTTJLUkxNTE5HVGovODZYcHFvZ1lxbVo3UEk4cXVnakMyVGVab3VJOHZp?=
 =?utf-8?B?R1JnRGtWQ0RxNDNBTFZnS0pPWWs3NUdWNC80d2Z4NGNDQk43U0FVSWdJd3hw?=
 =?utf-8?Q?InwlMxGWTkJZcakKw+MKyNIXw0zdAS0e?=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:24:19.5622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392f1afd-72ad-4edf-4700-08dcc7326e82
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9201

Link my old est.tech address to my active mail address

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 8ee01d9d7046..53ebff0e268a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -614,6 +614,7 @@ Simon Kelley <simon@thekelleys.org.uk>
 Sricharan Ramabadhran <quic_srichara@quicinc.com> <sricharan@codeaurora.org>
 Srinivas Ramana <quic_sramana@quicinc.com> <sramana@codeaurora.org>
 Sriram R <quic_srirrama@quicinc.com> <srirrama@codeaurora.org>
+Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stanislav Fomichev <sdf@fomichev.me> <sdf@google.com>
 Stefan Wahren <wahrenst@gmx.net> <stefan.wahren@i2se.com>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
-- 
2.31.1


