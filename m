Return-Path: <netdev+bounces-97061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AFC8C9002
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F4282B23
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200023746;
	Sat, 18 May 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rLZrLKbk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2057.outbound.protection.outlook.com [40.92.90.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B317BA9;
	Sat, 18 May 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716021078; cv=fail; b=GIW2ra2w04yGU1vAeav7XffG1itrUDB7Pep24e/EHIcUJe/93T3R/2HLGGKuubbUOYpeiLpfWmhTC0t7GByOvTWw7NW23RfHYEqCKzn67qxYxvzHZCJm6mPaGMf7iQOwhtJMINmZRnA8pdTStqnTcJebwmwUgE8pesfOJSRGIkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716021078; c=relaxed/simple;
	bh=BfcUnnoGavhSUjWNm6uA9jJ5/41YkMxKsdVPjLPCZUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FUAYrOWeOaw+jWdf81taUHFJXnFOTj5JKCut2PZdydKIesV+4wgl6PNM6eUtpEJihj35ClCiNib/mb1iJcsBr7bknthxILPoSdDJ+JSQ0+fhZid/eixFY66X7Y9FFcQ2u4nx7Lh7Q1IR8O1Ood1O6ao39llpq9fhLsK54gxgfZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rLZrLKbk; arc=fail smtp.client-ip=40.92.90.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL8tE5YZ6lmdSwBqIB9IAb97DSoy2DmhZ2+cnNGkGf1zQf1REBd9yXodPAg9/kBXsMkGhp0T1QcuaBTPcbSBnWqNwrc1bZHBzJpJ2MRdaIa3g1VZI1GqaLpkgmQRyFKz0xMA5JiWsQc+nElgnK/WCLOH6c7NoynHdyVA+ZvABKH9ih8+T7wTI0RTuAKAJzkVRadmK+9V81AkiDUbOcQxK/9l9AWW2op8GKYhiPCQTr69OYb4vTgUlFXLo084c39+goQihNB6Ltyw0G9kaWKU81mhoJhDD4ir7WXt62Nr14Dl+y5B/BA3o7OTx+Pw1ClwsqZJt5CPAHa2bSB5rjik/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daC3THgyOiQzGJtJX2KuIaT/NeDMy0RudLFDY/u4FOQ=;
 b=L4nhkD7MliCGsUQ6xGrkCURpKKONFA0VbSnDkIYzvqPxtZvZWHGjtK6kCq14OzPgaf586x243Otg1XnPNBVp2xKkoTDYumW+7bRLLBv37k/tVRwmkhSI/6ZhBuzJtyn66YfWpTzXCbuIndsc20htuxJZ3sIX+lXHUknr/tcaTgHQSdAfHcVdZe7WTP6YM08TtdyirbZJC/CkeUv17dDbxTdYozHs+YaBV3/GK1l+2Z68blHZooeYrS7cHwZ9djYd68L3Ko23anl7RPr07NO/GdKUehlEmf8/xxRZZpSihXSVDfenH+LObyelsYgksffWd8rN7mO/4gzOC5nQpXh+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daC3THgyOiQzGJtJX2KuIaT/NeDMy0RudLFDY/u4FOQ=;
 b=rLZrLKbkgiC7QmEIgpBTpHgrR4+oXF7uMLqQynu9HuK6QvQNvwVhW5j82K1ivgWrqZsqQKsymjFsQhXmavmn7AiuNU939QDMXMdwQropKcbWfBH9IeKIYsRgzkGdd+SH5RjglpbXq58A/hpap6dzhsDg4hl7iXjpyJnleePbbgtj2/hOBKsmxHOrb64kd/tqStu1VxPfIVtkQToH31xscMysNChFpGCmvTWx6f6t2/UKHPzjKIrvKpLj2j3XVTIL/P7F7mKBZk6idmRsPZ2pVdZ6qCDexXtrUesMMx3PXazgSU77WRKsRJJXchZZOjxEkv3BVSf9RMbmDvqPyqLbGA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by GV2PR02MB8723.eurprd02.prod.outlook.com (2603:10a6:150:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31; Sat, 18 May
 2024 08:31:09 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7587.028; Sat, 18 May 2024
 08:31:09 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 2/2] Bluetooth: hci_core: Prefer array indexing over pointer arithmetic
Date: Sat, 18 May 2024 10:30:39 +0200
Message-ID:
 <AS8PR02MB72370994136D06FC99680CC88BEF2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240518083039.7202-1-erick.archer@outlook.com>
References: <20240518083039.7202-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [K7kVgqjXF+OcZcPiLQyP3yju7H8n/SLb]
X-ClientProxiedBy: MA2P292CA0026.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::12)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240518083039.7202-3-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|GV2PR02MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e869dab-8e2c-4783-1da5-08dc7714de47
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	o9/tebtvu7Ue7q3F+507HAQkdZneZz0j5KyvzNedAnAy1dMq8wh+OU2n/x0waeYBm0te5Cy6O64wsXC7fTtk/RSaBLcIzZpicfAIHT+o8hicNrGg1XqnNXQf/jPzI2GKbgX2VKP7rdFZNkw4tFLbx3dQYGofCopdelSA21L5P1QyMRqpjL/x2Yn4KE/hzNq187ggiWv8l0nl/IYF5sXfYmczHNOGnzIptSsRKLOhZzdHRuEeV+Ej2FrYvIizcIYun7Fu9oV7PAcXSSlkzsAMeqnKXzvvywbJrleTwiZ8mvHT0cEkOC0OupT0WsgX4II03D3dvB+5cbYKQ+2qHbGNMVPZye4uQWNfX2iG47ckAOk6sGqljo/fxAXavzLTiL8aQQqsz46OtexoX9lTkQUZPbz+KRsUx5dVZegTI5O7tqEk1jfSLVmPAAc6815/w9VbxZYrzmJ7xHj18tKxo5loqCz028kNYkaFlTJh4ssl0B4/yZ8KKLGU2NsjNasa4FKJBWHp/Fs0w3ciQzHjvghNxbrgghAwAJifkTh9XFsjS4W41H4g/qG7bAoh1rGpvyohjFvOx2zR2QK+cKN4xygRHckrqZPCB1vMj+yRbtWflbXURAyYQzOwTnDPK9dbS/L1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mnkoa4uBiNhQfD++9Jmsvh+qf/9XsmZG4Mu5F1fdkj5U2NpmtVlIFUX9tDAX?=
 =?us-ascii?Q?nW8SX5yO4x/uhH1HrxiX1RO97RRg4VJ1NckU8h8kBAXThncbjGHfbmTfJiNP?=
 =?us-ascii?Q?oB86ROgZc+tZ1evxYlTNV0xzrNTXHt9cAlfM5PMoBmnZvBO4KQOLbvd2cWcR?=
 =?us-ascii?Q?zFab9AhKreGYlMKjlWXZHy/ujSluEovft9MelSsmkepxEit9Sk8CWlEVLyWg?=
 =?us-ascii?Q?i8AJaw67L6/GlFVLIJPBSkdNoDgYdjJB7irbptErB6jr6HcQyWth0LOdHGpz?=
 =?us-ascii?Q?/iJ4HU0zvxGmJJ/4K3HjGc/w2LaXsZLGwYGhs+Zg6rTdPXNe8rtM/ChirZVh?=
 =?us-ascii?Q?+79bcW582LQ6NZmhve1EkulqnZO4OvPp5RLZBYXMZl4NU33eBcBkrROjCowN?=
 =?us-ascii?Q?wiUyKPJyThrcJyem97AWsREHknyRTHzYVFvkunhtjNsouS7EfVB2amgmHNbn?=
 =?us-ascii?Q?oXOmFPg+E8ezEsZJDFi8a1gJWyeknf/x5VmCd+bRQZbbAgqglKeQatYLtt8H?=
 =?us-ascii?Q?og4jwQUrGJNIHVkMQgFgX7APw9J1oW5I1gNO9IsY+V1zm4tZ7UoZGmKGtzAu?=
 =?us-ascii?Q?b7JEBNOG0T2osYig8PkphAhDpIbfLHPr11cskNHFTWyFFhi4F8uDYYf99ENz?=
 =?us-ascii?Q?D4b2NtbIBLaHM+ofKxOIWRkO1FvUKaF15hWnkByWOHijScPabnWbgeJ0/aFL?=
 =?us-ascii?Q?XISxhjZJMq/nKQ8unKZch/vWqRXeBBO+dzbvM0dSl2floYfeykU9dPztJw7t?=
 =?us-ascii?Q?ggSocGpV4YbNtVNzla2n9JSASO9p4AgIbPS6aYL8ghvbuRcr4tixe1T0F1Ou?=
 =?us-ascii?Q?+uU9cP43J1f5EboFC6XHDFdaK79PWEuSg3FjKQWP/T83w93hM7QPyq/UFjiQ?=
 =?us-ascii?Q?KbRdRj8W9DWZmbTA0Aw3t1FE0COzYPis5jrikMs9wgkz8UxJhOGXV0iz8AIN?=
 =?us-ascii?Q?KU6CfqizM3BBx3J4dnDVaa7X0E5aMF95T7W9ZoPliVZ9bAWHPHgLrFqTK4Om?=
 =?us-ascii?Q?h05jGW1Oml0kfY2WqjF/GeKFLIDZJNwq8B3D2EegyoVR5uGCgBg1IIdEM7kk?=
 =?us-ascii?Q?9f7D/tI9HKKZFMn7RnRhVdpJgyce4Vg9Z2T5uRWXYkncu8pOl+F1s6eSEB7F?=
 =?us-ascii?Q?d56fZa3voe9wlZjXVHDrR6iBcNUyviJSp+2bpnupPb7XcJH745Z8qIXZuYjd?=
 =?us-ascii?Q?2JQGI6DChRMD+pzhOO02hvkZZVJfKvwieea0OQUQphzsPwhpl6q25sSeoGnc?=
 =?us-ascii?Q?pNuXlPop4Q9GfSnxVuJm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e869dab-8e2c-4783-1da5-08dc7714de47
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2024 08:31:09.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8723

Refactor the list_for_each_entry() loop of hci_get_dev_list()
function to use array indexing instead of pointer arithmetic.

This way, the code is more readable and idiomatic.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 81fe0958056d..b3ee9ff17624 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -864,8 +864,8 @@ int hci_get_dev_list(void __user *arg)
 		if (hci_dev_test_flag(hdev, HCI_AUTO_OFF))
 			flags &= ~BIT(HCI_UP);
 
-		(dr + n)->dev_id  = hdev->id;
-		(dr + n)->dev_opt = flags;
+		dr[n].dev_id  = hdev->id;
+		dr[n].dev_opt = flags;
 
 		if (++n >= dev_num)
 			break;
-- 
2.25.1


