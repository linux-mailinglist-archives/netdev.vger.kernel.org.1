Return-Path: <netdev+bounces-122273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AE296098F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0BC1C2257E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F619F466;
	Tue, 27 Aug 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="ESqWoSvv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478C1CD31;
	Tue, 27 Aug 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760368; cv=fail; b=eb5ekQ28mtP0Xdhqh9GbMoif2mhawsDZUg7n8gpHxFdgxymhMdrvPoekp00XtOYgKfO0gZ2y5zshdUU8EHg4Ka+lEbY5tB8UoiWIPLaoZMd/Vkg2PiixndS8JtHVbH73/dfljiR4H17IgY+vEcP5/zHaWdkYoYCu4c23XuWUwRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760368; c=relaxed/simple;
	bh=XCVOpVA0zCVl8+huSwEOKfWSd5u38K7qWsGJa//9vTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ke7ipwh4ZCG19AuatQ1u7n3hMW7K5qSw3i7aAfnXd8M4pGo6gK/VwQaificNGK7W+uNTzQmQu/SRsscwOUwBhuww4HVpwoV+rot9qiArMldN62vrlLGxyiZg29g9m2cFg2KRDmvKhh5+Z+wq5Br6nDx24uvmfwDhskwji+SWFKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=ESqWoSvv; arc=fail smtp.client-ip=40.107.241.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f91bxGvRghM653PaDzz0Rvof0iJ3zyrCWqhZO778LSn8IW3cxRGHefEZPol5iUDOZ2KbWOn1Hqx6ABmrJRLCkKI5Xrhaxmd3AVpcw0cqWWuLZSAQobF2g8LzLbGXc97ryEx/kzlZ/WV40vXWhCw/SM8CRRPMk/9m2O04TLOKXolHeuP2qYt+Fm1NpofrMlMgZbVCoRAMpta5y76KfhDXZw0OOmXnIOz9Q8tY379dPYohk7WWLVbRFkMaH3qVjkEAk7D59GVi1FnlGaMQ/z7ufRcSVQhtpxFWRrshKoJbD9NA2qDHfzHxcd/iG1cjm6kdTRAsXvBMmC/utMJvc5fEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNKZU8iecNpVKONbZghzKQEDoj+EAKj6RHxLlJ1p1p4=;
 b=jg4SogV7dk8cgKhPguZyqmbz5hOhsG9A66f8gSsuH1S8+rvyTzrgEN6KDRhMRc0dh7f4uHn4PU6Lb9RjzaUyunGHc5DfS1SN7sOlJWIHTCHfAgswzdleaSroNU+yfJ97GeiRMYYgtyFY2uhaCZUgdhs4kAtFqsmitFzs1PXXVNYXhb0XaBQ1veybw5gIWsCJhezFci5/vDVuTRbfN2w7waRjYm0TPkUUtn8ewXSJxm8x7q+el548wh6X4tGk7i8ydLOzNyrDm9QzSUafIMfdzGnvPhKuADYwv2iEcWvD/6UHhy1W8pkEt3KEuiVvpDmp6gnDSMSiegR8mCkyr1wLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNKZU8iecNpVKONbZghzKQEDoj+EAKj6RHxLlJ1p1p4=;
 b=ESqWoSvveCzwoDFymk8Wp21WqJSdKflyBrPtmzJ2Pqbxr7nvfWuzNA2NrMpn7vtfqYJPhB9VvpEWm4KXLgO5R401L4XFsG5Kw7iI+x9/fj1Zwpad+NSBNBzjw2ifZlZSEDWT6Lo6khT1sAKfVqXERwarRvPmncMoegM0ik++bk3LNX1hnbNtj0v3XSzaYcJe2NPfBCnCXDHW5l7TwoGWrq2joe+7FU8kHvPygvg6B935SiRRKcI9ukWmDP/5OpoKQ9hUgnvnBJepOwMUfLF6xQW+VgaK2m2jnIsdhQs6WZwYHNtaoh5TLIf9EG3ZzrHGF9lwRvBB+C2szgGRMRNGCQ==
Received: from AS9P250CA0013.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::24)
 by AM8PR07MB7538.eurprd07.prod.outlook.com (2603:10a6:20b:246::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 12:06:01 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:532:cafe::7c) by AS9P250CA0013.outlook.office365.com
 (2603:10a6:20b:532::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 12:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 27 Aug 2024 12:06:00 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Aug 2024 14:06:00 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
	by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id CB1814020B69;
	Tue, 27 Aug 2024 14:05:59 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
	id AE349607B0F1; Tue, 27 Aug 2024 14:05:59 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Georg Kunz
	<georg.kunz@ericsson.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH net] mailmap: update entry for Sriram Yagnaraman
Date: Tue, 27 Aug 2024 14:05:58 +0200
Message-ID: <20240827120558.3551336-1-sriram.yagnaraman@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|AM8PR07MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 82553268-fcaf-48fc-8fcb-08dcc6909e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFlBY1B4TDR5UGplbGV2WHY2Q3ZMUU9lTzFFN1J4NzAxK0J3NGdieHBUbHhm?=
 =?utf-8?B?Vm81T3JLbzhDZDlGZzZnSzRKeE1GQVJMWFRtZzI4ZXdpam5pS2RNRnJTNlRS?=
 =?utf-8?B?YzR4NGFGQnBvclR6Ui8xTHlOUThsckM5K3I1cGIvQ2FEYXRLc3Y3Z3lnUDBL?=
 =?utf-8?B?UmpCNEowMW5XWncwbjhIY21XVldlSTI2TGNGRm9Wc3VUcWtmTnhuZWxhUkN2?=
 =?utf-8?B?T2NHenA1cjBmUDkxb0tNbmVvSzRSSTBQRVpiUFYrSGdGdThkN1pDRm5DMkRG?=
 =?utf-8?B?ZkZVU2dwRjlMaUVmTjViQnlxdnZZQ1doaS9mS0RTSEFUUllWR01NdTNvS29R?=
 =?utf-8?B?V0NOdDFjOWtkMi9WV0hWeklpdlU1aDFWRHo0VnFiQUFNZHJvSmZzZEcyaUV0?=
 =?utf-8?B?S1lUM3Z2L01WRUpXYW5IZXVlY0p4a1VhcDgvUWJSSWlPSlc0dTRYcUdnMDVV?=
 =?utf-8?B?K3FGYXVKNGE3blRYYXY0bVhHVVZZcDVYUHZBdVl2bnNwdFhuQkJzWlc5RFRv?=
 =?utf-8?B?bFBSNWJNYUdweU9ZYjBLWTJrWWdTYTVYaExZZVZwOEVpM0lScGJQNkd0ZGMw?=
 =?utf-8?B?VTg2azlYVzRaczI5MmNjZ0FBYkNzbzZ1ZVFIRTI3eTBCbnRqTHFlTHVhS000?=
 =?utf-8?B?R0poSm80dnUvTXd2cUxLckFobUJPc1hGaThvcGg5OVgrdkdmUGQ0N29mMWNr?=
 =?utf-8?B?cVRMTE1BaUFUWE92eERTclJkbk5rek84Yi9GcFFucVdEeDljdEdpZWVFU1hD?=
 =?utf-8?B?WU55L0M0clBhaXQ3NklORnhJdTJUZU16b0VXWGw3NG9BbDNnbWMvanp5UGQr?=
 =?utf-8?B?c2tRMlU5QURNcG82Um1GYWpEOXNSVHpWekdyZWtVa2oyVGhnR0k4bllHckov?=
 =?utf-8?B?WnFBQ0lKaENOdG1mbmpSaCtjNEhmMDV5ei9WTHMwM0ZmRnNhRjQ2SU41azlR?=
 =?utf-8?B?ODRScGFUR3VLaGpKcXVMVGw3OXJKTGZPZEJFRlNqUUMxUVNzT1VRMDZLeTdH?=
 =?utf-8?B?c20rZTVKQnVzNUNKb1QwR2JtY09OTk80QnBHZjVMUUY3SjZ3OHJxajBET1p5?=
 =?utf-8?B?Y2c3cmdlZU9KQm1yOFd5WkVIMDkwMGkzRXpTMmJ5VVVMRG9XZk05SlhmQ0Yz?=
 =?utf-8?B?UVUrZllMUzIzWmtpM1RWQkxqQ2VtRldJY0lMakJDSlJZZFRxMm15VDJQbGZQ?=
 =?utf-8?B?Rktqb3Q5NWZCSlpDNExZdWNFeXV0SXFyek5FMytZN05VcW5Ic0JRZWpNUXhT?=
 =?utf-8?B?bUJualVoUGg2MjBzMStCY3oxSDRGMzZCT1FoNFlKVk5leHBWTm9lcEJ1OTl6?=
 =?utf-8?B?eXBUcjBNZnpEbTBSVmpva2NqR0p4K3BhOVM1cWJneEdsMlArZ292YzJqVjlQ?=
 =?utf-8?B?TmMwRzJLM0hPaldDc2hyQXU5MU90MFYzV1FFbU9UaHVWdDFRbVRJV2l3WnBz?=
 =?utf-8?B?cklGcmtvOUdQM1Y1Y21uU0lZaUpWOVFpNkNkVEl1QTIyV0dsRFp6SHlJWTYv?=
 =?utf-8?B?WWk2eCttcXh0MEZkalVVVXRVU3ZLRVJOMUVVUFprV1BjTElsdERiT2RmWDBD?=
 =?utf-8?B?b3NQTmVXdU0yWkhnTFl6b1ZiOEwwTFNrUWVvdTRhZmRkcmFBM1FGOVFkeStX?=
 =?utf-8?B?Y3VGZEVTS1hZVTFZTE1RNjRva0hacGg5NDVBNGdUN1FabE9ZS1RJQUVuNEVL?=
 =?utf-8?B?UkpNOWkyVXhVNnBiRk5GUU84TGxkMWVyWVVpZVZmRXhJVnRXKzBvNVJoWXNX?=
 =?utf-8?B?bGVvZVhJbEwvcjFMaUl2TC9ENWIrZitVVHR4UXh5SWFUL1hQcjc4TFdPRXk4?=
 =?utf-8?B?RUtmby9seGx6Y2tYTUdOTUtBazZEbEI3V0xkZmlYMnpRREU4cit6eW53S0Fm?=
 =?utf-8?B?d3hXaDJMbURmSWF2MTZGWlFUVXFmM0QxNmc2VklkM1FIS2FKbG9qeHZpRlZp?=
 =?utf-8?Q?Fg8Vr+lAtgi/azQr1idnvJxIAXB0U+y3?=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 12:06:00.8185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82553268-fcaf-48fc-8fcb-08dcc6909e07
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7538

Link my old est.tech address to my active mail address
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


