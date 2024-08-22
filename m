Return-Path: <netdev+bounces-120789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D7195ABBD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 05:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBE1C26180
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F50224F6;
	Thu, 22 Aug 2024 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MPL44hQJ"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2056.outbound.protection.outlook.com [40.107.117.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC593BBF1;
	Thu, 22 Aug 2024 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295950; cv=fail; b=Rf5iU4+uh5XDcGxhQm/TwFdeHuR/ZX/vn+yakgcTAavsI5neHYm8RzIJLBd5iZCqfm7fBwId/WQxCRVYIeR9uwVDTQQuKaEmRO2Y2sd2kVMEi61eNW0wj9YPk09v+5DcJGRoelgIJUNY8VSsa+opuhr00xLkKOEuIXI7XA1X2l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295950; c=relaxed/simple;
	bh=ZIE3AMDkL85vzLpUVeLkbsx8PG2H88bmihAGcFnue40=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HHckVIU+ee0DuDZhV24lTDCTLae2Ip0oLPaVhtQg00EAOfYSzTQ3aM3tt3hhkVIrA+/rSgVHDVduuSSls4P3KIo8KNANq1p8PbyU8TNnzTejaMh9iGefaSHSZPpjWAIT0n6lWP/nE1hm7/i7fJ6+Ol0pBhl9/aVKyso+srWESTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MPL44hQJ; arc=fail smtp.client-ip=40.107.117.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1Tg4a8dBg5mWpg/gjWuLo0LTCde7FBuB9dm0HAPuL/yXROcJaCM+5NZ+Pr60UlfHkC65s3QxABx0OqQHUavrfewvc1WCkmY+RE/whLZuZdgSUJ+pA9upKXEusoIeU43HdyyrIhXbgZy+uIWEInZuZLbU3W8kkXJNtdmSfQyE4tK3Bx/toKLyE/gtwn2M5wOufCewe36jxPEQSaWiu1HGWKhOHzJmhQjLJqxnu5SzTRhTscHtinK94qXmh2GAfyEEYnGoXMC98B9Jj54SrATiKjRH3NBOyMV5G44pGREFVlgeO4ru2IDfjWSgLVko7Cmvg8CN8rdpHHcZOuhkxr7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTD8bS6AHLIl3p5QEui/KtAP9S6Sl5/OO3+AUxIG1+g=;
 b=dUrruD+XPwusVQm7apGx9gBp7p4wUQ2KqWwmALy+/uvZCISiIl/dDxcYOX4fJrY8WTAe8KEU4/03/IUmQ/hEXKBh2xyz+eNj4HYh7hYnnVNX4uudGQzHWrCi7yHXZc0UWObjKt6SqSrpcBuuTgfgbN7TRX9zIawV7SmS3YXiTO60NVVgR+toPC6E0xTPkDIa5mnoH5Lm0l+9SDIipf9/sdi/8SV42Aht6bVSxP5IQ/dpd6tIc5Kwc5JcjEBHYGeJBmGv/SoIbJ+oU24JGyCsNYd/lbPvAPlVSJCxKmoF/2kRof7K7Oluknpz6J7/h6V4JCpJiq0u3btBvk0U4P7jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTD8bS6AHLIl3p5QEui/KtAP9S6Sl5/OO3+AUxIG1+g=;
 b=MPL44hQJF5sWXlRBPf0VwzLxvdH5HswGN5TBF0X5JQCX80eStAuxbor4rOSso35qz/rHiz0YYo3bEs81fFeHAKdscQL5rPglq7nIY+MUZNkWF9qvT6NUFYdfDYGkVelWvcmD3WSf005Qrtoayk5grQyAksg4OAD5sQ1O6726PX4VtwUbT1iAJVKnZeYhvPE6GF/EhJduLjkGm0ey2OU2FJ124VivsBBwiHhcS25OOZ4XrXN4QddRkeomaROKSUc7G1VqmloYztYFzyDt4ih7rVC3sVkrnAYcydOPiZNEfyQve6refaDAe/KsiULBuqZlZYKeE704kRKmwCJ/2rY8qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5724.apcprd06.prod.outlook.com (2603:1096:301:f4::9)
 by TY0PR06MB5780.apcprd06.prod.outlook.com (2603:1096:400:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 03:05:45 +0000
Received: from PUZPR06MB5724.apcprd06.prod.outlook.com
 ([fe80::459b:70d3:1f01:e1d6]) by PUZPR06MB5724.apcprd06.prod.outlook.com
 ([fe80::459b:70d3:1f01:e1d6%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 03:05:45 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: mark.einon@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] driver:net:et131x:Remove NULL check of list_entry()
Date: Thu, 22 Aug 2024 11:05:35 +0800
Message-Id: <20240822030535.1214176-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To PUZPR06MB5724.apcprd06.prod.outlook.com
 (2603:1096:301:f4::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5724:EE_|TY0PR06MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 223e1187-34f2-4ffd-c7fb-08dcc25750e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J4QbvhVo3UANqM0xCuKJ3e7lvm/SAoj68+f8k+p5gA7gDHIj5QEaS7EsFn8P?=
 =?us-ascii?Q?kL/X9OOL8/JyOGjDyqNmLug1D7cv1/v/ayxo/B4mkzq+D1pnUs1ltd7gzwKS?=
 =?us-ascii?Q?HRtNIjZaQj3O8MDw4+REbIYBaBPgJSHM6zbAigtz69foAaJnfL1nUBdLIuR0?=
 =?us-ascii?Q?RDrdMWn5JyFBaipjee1L4EQ0ahNhmb/w29j0rzNvbArDoNkC343hxY8UEFS0?=
 =?us-ascii?Q?vB/wlRjPAuXfWle9Td+AAAaf1LAfn43vAeaHhkZhGrxZmrMSgPO9DzzCdqMd?=
 =?us-ascii?Q?aXh8OaZt9n/qEQ6t/yfpkmXLzA89dDxtN5Zw2WzgwJMki4dFbIbhHxUu4kKL?=
 =?us-ascii?Q?si1Y6/HXPhvuX21+g40u8g1txX2lXKk3kQ+boAvbfTVyL9EwM6CVPJ0neuYS?=
 =?us-ascii?Q?51f/PhXtQ0w0lKuPd/rJJeKEtKwWnt95dv7iUFNOj1T3LHT9E6TzGAGWR974?=
 =?us-ascii?Q?LhWvEImmTaekhRNzPqIBE7OC1vy0YMoHgc7ED0KhHgJse0Kk/kY+XOl0Bf0G?=
 =?us-ascii?Q?Tt6wvS10iP8pDpMdA8aao5NR9jckJJrxlP4Hmsdp64Y9SCpzimOtdaLJwK6J?=
 =?us-ascii?Q?zoV9zK4lS6CntJTgX8iBF/eUzugpH6Vc+WQNU4DMtK9pMO1MD4o/gy7BAgyM?=
 =?us-ascii?Q?pkHYXofyJZhRzatuoDsU45TwJWz/JRuemubUMUjAtSzeq4h1hB2Jur0LG++T?=
 =?us-ascii?Q?6DYCpL9bzoR2OaPIlBmtI7b9sdoIW3h++PC7DPCOGgDUXTt32LWMGO9sXETq?=
 =?us-ascii?Q?ueiwOgWU/DnrzJ1Ttle7kTE94TeoYYLHhY+x+DcGfJTV5RutHqg/MxnsmHwJ?=
 =?us-ascii?Q?lvMg+bJugdJHEfN1pyfM09b4GFNCAhDXqII+FqEox4ynn79i1kmxNLMXru3p?=
 =?us-ascii?Q?5Cl082yQ8Q/zmY/KePEjk089HoNx/jlZsEUDM8DY7yrrzLD0wwETF6TcmHZm?=
 =?us-ascii?Q?s06B9DUdlSxaujKCPjyUDQ70IrRqOTBfRKU1SEB+4RNq9Ey3VJixsUk6yh+P?=
 =?us-ascii?Q?YiEmyqV2cL/8SNsrKIpxJqJYfO63voUIqQ7dOajjzIG+DTqUaUrtfn6EpEP+?=
 =?us-ascii?Q?S9RUC7YHp2PrmMt/lDu6Axjh/U9ozUv1jQ4G5Y0ezJ8Il36Wf0jIsFiev/Nj?=
 =?us-ascii?Q?UdJITGt7tyl9Ks3Noy/jkBzV00ZKN2i9hzyTbjor+Lv/UMS8bbtb8Tu4YUgJ?=
 =?us-ascii?Q?r1e8O8nrBu2InriGHZXJVfJOICPynC06bm7uOMJj34bJZLVkXyGgOVRW+Nr3?=
 =?us-ascii?Q?w+jhi4xaTWiCxR/3bMxqP7UpEgRkHEeAqMMt1Q4FDhX0p/Xnlu/1NDUOOo6N?=
 =?us-ascii?Q?8jUUV4zw7J9tuivyhoNOT5bXVXKyW39zDf3Mpyl6628HgRe/16d0/drXk0cH?=
 =?us-ascii?Q?YqPS5v6tfZZUXC3bNphqwkAMyDrNdr66Wsq1emqO1s7Lw5+IcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5724.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMRDfIf63N+nKaompno+yntrcQkXBy6AkgcXebDI5rYMKuU8eq0E3P2O4B3q?=
 =?us-ascii?Q?wyfrtJXr6Bu+XvYpiTPKjC81zTftEx+zzN8IERytGACBM5R7wJomYaPj136y?=
 =?us-ascii?Q?ihmVu9/jlNWY4CKR5geMOEjOuT+NwhMO9nScKCPpym3o2Zt0FzfnBswgBtTu?=
 =?us-ascii?Q?tN5fzYbPifsu9R0+5SWKTe6Txv9QNZK0OGgjEI0pVjSPZMmKMeLeddhx6MaD?=
 =?us-ascii?Q?ysa5hNp1UKQXNex5QQSMezxnTSBIg1m4DEPtZLvd5bnrvcwpedO9T5BPHzUE?=
 =?us-ascii?Q?SaiYpyIaUfNU1ZG0W8XHw9qzOoY52uwGV7GyNEVDAMGjIngWjfT6NkJyhUPH?=
 =?us-ascii?Q?Qae6ukgjs2e0mdVPNUedgzErnwzp8sgILjSVdK8tGn/BIvUQ4HLrAVWypAg4?=
 =?us-ascii?Q?N7wnZeRffGY8uA4Ac8ft0IwAQg2sujHWnVXU4iYMwLRzVujabctrbbmR55iR?=
 =?us-ascii?Q?ZhDINg6DFZSLxKzyRG+s/eS8Zvvy7S/Vxf6HKD1I6dPw48Y3enmnk6+o9sRo?=
 =?us-ascii?Q?OPbDHzwDmAL7jhqZ0kQUoFcWNmzQ4HPk/RYffRUWJortnyNWuQN8pvv2K31a?=
 =?us-ascii?Q?eOvx46xc+vraZPtWU+AlogIUN4OWQZ3DePm0SasCJW8R6n1+gIXDVTOiZeQ8?=
 =?us-ascii?Q?1Rg0RVlEUSxqZd0jsqjCoWv7p2Q47IAvF0AIAImuvg+9YwMeHCALyl7zwfi3?=
 =?us-ascii?Q?Ris2V9SNwCZ0uKfVlTuHM7N7OtHb9ujXuWYzv3DjRICVN5tY4aQMzHjohJMV?=
 =?us-ascii?Q?IqG9MZBVpoFSkwdYw60uvMsWlGMZZnBwMmzwEI58uhRR48CPRy60K08T1gXR?=
 =?us-ascii?Q?B4F2jVuk4Cul4fxRpbYWZMpPPZsx+dt6AKZkcQo1Hpuihf3V1LnQrAlRmNAI?=
 =?us-ascii?Q?HuHHJH51Y5sYcSc3Wxe0cn/RNTTeyvjdbgRIEakN7WEf8Ty9jn8Z0WTLT3hp?=
 =?us-ascii?Q?lL12qlbkUiXPflXEfwRpzWMsa4e29hAhhaNfnSo+YqBS2lhhEj05R6K7rtlM?=
 =?us-ascii?Q?ZC6h8TLVM7J9JGZm6Pk1TPwOKe0x7OeXl7r05Lz7F/F68dR+Qi9LJQHbbMHP?=
 =?us-ascii?Q?WGVHz6u9loMa2mFPhMRmpXGFSlxVWKyeUF1ZeDbl/0PPlmTFpc3WwfgtO1eM?=
 =?us-ascii?Q?qAgbSiuaYc5ragUXbdTaMVSOArEGX5NR/s4uR3j5uS5NWTKEm4pEaf++VsHK?=
 =?us-ascii?Q?UfmVIuk+u/Oxo2SUdZIaYDHHdh4HpjYyIuiWl0nG5gqN97tTkKeT9+Sg7WYv?=
 =?us-ascii?Q?48nAfLbKFhgIu21UhDjwspuCpNUMDzhcRY42zwhKWt+juU/ijW836TBNAt5T?=
 =?us-ascii?Q?BfQ2p6LeemE2xBfUyLFSHnE2mLit8bARZ/nQsaa+mZSzwhvbttfa/LLzdUja?=
 =?us-ascii?Q?T1DeYnpDn+Me9UAJQOKUj8BIoZHS2RYSuqVeTDpmAxi9Vhs4VPAUpWaNoNvr?=
 =?us-ascii?Q?8rKGlDrYzDZOptBomg+tKbBuooTcKXtLYBHhEvWEpuLvCapVy3aPEGG3wUcE?=
 =?us-ascii?Q?xJzqPtWVlxvwfFqbFjbFx47+6rMHbEeN4pTW5TvoiYqlD6zwHbbYPpBU8RJP?=
 =?us-ascii?Q?rB32Q8CsKTBTycRlNx5+2vn4JDK2VzVybe7lOW0w?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223e1187-34f2-4ffd-c7fb-08dcc25750e8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5724.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 03:05:45.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SHxpRoiv05txQuUJgdrx3GVMSLttQO2ouQuolpzn5yGmJIo7ONjveYLm67NpknH15yF3U29i6VdNxbdH3RNOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5780

list_entry() will never return a NULL pointer, thus remove the
check.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/net/ethernet/agere/et131x.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index b325e0cef120..74fc55b9f0d9 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -2244,11 +2244,6 @@ static struct rfd *nic_rx_pkts(struct et131x_adapter *adapter)
 	element = rx_local->recv_list.next;
 	rfd = list_entry(element, struct rfd, list_node);
 
-	if (!rfd) {
-		spin_unlock_irqrestore(&adapter->rcv_lock, flags);
-		return NULL;
-	}
-
 	list_del(&rfd->list_node);
 	rx_local->num_ready_recv--;
 
-- 
2.34.1


