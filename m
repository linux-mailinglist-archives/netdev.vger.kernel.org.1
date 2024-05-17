Return-Path: <netdev+bounces-97010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6129A8C8ADE
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 19:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A3F281284
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA613E040;
	Fri, 17 May 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="a6I7+rgG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2096.outbound.protection.outlook.com [40.92.91.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69E13DDDB;
	Fri, 17 May 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966545; cv=fail; b=VSnASxnu8QDGHBY2YrWoff3Xg+sWRMKt1+VZGSwd7QKOvOuu41DmSfJASGxLe994mSKdM6/F/7/rBoPifMcuPcNUUQk49lAQp6QZVuRWPhdIhczCOtZk0+LPCX6t63Y94modKuWcJm11rLc0q7uTt58khi/CdWglmadbTvqjkpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966545; c=relaxed/simple;
	bh=R2g7aB2FQvoAzLDlfjL4We59knASFYxPNbiWCI5FTAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=saI3OlhHIUQFlpQiHJm3w8GabtJ/mVtUgOvvBEDOWM/C5YmP+0rUOmIhGFx/gWWDfdi7G/5YQxWVs9di+B/aDxp1qLwHRdJArb8t3ES24vzEJbdi6W0nexQA9VnppnkSF3QgfzMDGrXpq6ckuHchOlzqgzo9euW/vvVxAoVZk3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=a6I7+rgG; arc=fail smtp.client-ip=40.92.91.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHdJhw2kOAtViKbNkQpIANPf6wpCMFlhyIRoI3m9qCcELp7hfHseBdkXQRWNl7yGSub2E+hDDCcYjf50ErmKIUInl5RiKs5lbbdlawulSj8HPHY+11qeNebxuPhChFQ/kCFrk5UI4FI1UbAk7alNLsIFCcera5lH5k8A9VpnnHt5LCEhcSeWbCqIP8DRZ+GBnISDD+LHUa9dGXQptX14vtcL4kvqzdl+OUQDlL/U57MaLAgl2jb08/TfvyEdyWbqRwHDh/Q1RLugZzYacP2KC7Cbb6kYDvPoQ24X/7adPYSeXioEXF9gTQYXhNprciTOor2VDOULha2HnR6d+CmM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdXNwbNaULL/bRsVSHS0cQxwWklP6P8Qao9V20EgFTI=;
 b=VSw72wymh9GwpQjfnwCl9hcAvB4SXEfRw1G3Zbtl20S/VB3AmxeaAZax5iTjdcqp+xCTpShOrww360ZcpTazDMo8TX+Ejusyprxcf2yJ0yzg7dBwtxz3vVpJ0ymNCgJ9wIs1r3gBUWTF0SE5qUzFUhMIgncnV3sQfjhlFkbJC/m2VgGBYG0bKJFOGMMDfZGRUyMI3GpNJ8QSuGva/gLP+cHPYjirH/pdRJN2xDmqqBHOdB5r+Oz5x0+5vk15FJd65/1nm6V+Ehf4oJqDQzuq6/Fb638rd0AMDhjPsSUr+JpMpEZFzXJkQY2hjKu4F1RRtmC8etHTi+b6gfp3j1ieQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdXNwbNaULL/bRsVSHS0cQxwWklP6P8Qao9V20EgFTI=;
 b=a6I7+rgG9Y1VwI06kSc2TZQBz4Raq12Rk1+gn/CLyDgH5WK73Sdcwr487zQ1yryCPGwM4NCWHewiOjQqhxzWlKOmvLsYAoRzF4MlBpIQu6SD/da1hv8W4+gWwtOd7OttaZ8a3P3bhPbPVigh7x9imwsCtK4X+x+OGO3cCpWXgGYSutxZgCmiIveIt37dL1hAoHuKCn0DvyALLxqdZieT4X2zX6lHzu/CVjWKj+3O4rdWCoemfClzV0LWiiIHhoBhOnoID2/0cJzqmQk+9S/9EaiqNProkd13P7E5hZWz4RBg/UDuG1NKORUY8Ti1jpzNOFNhjwuxihpBBpK0rKgQgg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AM7PR02MB6195.eurprd02.prod.outlook.com (2603:10a6:20b:1ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 17:22:18 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 17:22:18 +0000
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
	Justin Stitt <justinstitt@google.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 2/2] tty: rfcomm: prefer array indexing over pointer arithmetic
Date: Fri, 17 May 2024 19:21:50 +0200
Message-ID:
 <AS8PR02MB72371AEAFAEE5563812D189A8BEE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517172150.5476-1-erick.archer@outlook.com>
References: <20240517172150.5476-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [AyUf7TvpU/T8yh7Z6kMAXUGQltDUUjYT]
X-ClientProxiedBy: MA2P292CA0028.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::15)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240517172150.5476-3-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AM7PR02MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 8631edf8-2f37-448b-dc92-08dc7695e758
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	Gqqmtbug8A5m1O38cwGqMZwycpDHjg6WnO8lzrM6adku2vGsxCFt5p1/qqOjZTI5bpsraaIlvhLUPak7WgKWl+E+Fi3k6w59S6O5pdfc2istKFhmBOK4t8btehNU+3aiHLdXnTpPJHjxCbFJXWJ2T4YrZL1WbHgKoYC7M7sQUeM2UJaenZzaFKPJGp8lB9qNfltO3t98JKqrvSZ9vMcI2LuxVbxM9HOUt4wWC1N20dOlVpM2VCToF9BN+bltrULDCPD/Cjmnm6rggePJpx9tgU+kpdyIhDoRloceQMcD0+1L77Eg15eitPZOE4uqoyGJ2u8ZAISeqnUXfUuh864lGIGRtkkeHo9bXceZXG7kOVz5ZR5f7+pC4ElOpdnfFlrTuVNN5ljCVgxKfdvMCYbHuxpaGyLpJbarmrXHPz51rfqdM7DDd4dEVGrcbqIAbFTRysXuiWkFoGUVjGkqGBZGQtzZd1Q473GlJxBMPKtyG/HU8JAngkmBLKdYhB86Gm+xyij5A6cjCH8YyyJyCImin5AizP6oYA/ZSRLUZ2yqdHJpJ+9mxuJ6gxa8pDDayjnrjqnFS6lwSgeUpCNch/k51tiriyqySHvdOUsYCpX2gLnuZvT2hXN7MJ1vX5y7dbu/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pWiWxQu8l72kPvWqiweokE6HDiFf/PKZG0O3O3XKKoAyCPOKUMSUOCGZRidQ?=
 =?us-ascii?Q?2PT5GpRZZ+CMtCtCAkzzZC3+olRIZAa0nQx82Y2AoWPZavpxHpMfmperS8wO?=
 =?us-ascii?Q?3SC5pg0r6DKqtGYk8n5fZUFQACZA+CeChBMjlOCXrpKrwXWuK01mIERnpYH2?=
 =?us-ascii?Q?4WBQRt63MPboGZJCJe6CFprOZUFor021bNAOoBWHuc2zysB5eyFbxdEPuGMR?=
 =?us-ascii?Q?JUOId5fBCUX2yUMPzieFMacT+HEa8mXqNf9hepmhT3oms2sSrDxo8QHNBneZ?=
 =?us-ascii?Q?CLA6SOh/6rPr9G4PCUL0mjKXaOKtVvxGr1uWYf4FNDCr+ibn4hwYONtlwRJI?=
 =?us-ascii?Q?aYvaWpBmH050oei6lI6DVVEs47/5X0EfVRmK4P1bFmlRbCYhojTZ5mdlj/z9?=
 =?us-ascii?Q?tiOSpp/3WrNm/fPzhmGME9kFVZnsSY2vJRceUCWoTOv5Pias16P0VH+R73gs?=
 =?us-ascii?Q?4uYrBEGv33ZB8c4O5S8XoO9pfdCC6eohLbFBUo+jjm0o2qIt1axEXDKt0Rv2?=
 =?us-ascii?Q?nKhxwVTmOMbZ0lMqJNXpf+pqXpswHM5P+B+vQO0/htD5tiXsJgB023ZIPDVw?=
 =?us-ascii?Q?P5KsF9XssPiXh6R45HCTEagbX41UVXS7ExoYQF76EoKOUYJcylBOq6p33KI6?=
 =?us-ascii?Q?lRxLKKqNRLBq1yn9IW0L1y9Mkr4uvG7N3JgCyoJI2rwZ27rQBcYIEX9zlDWT?=
 =?us-ascii?Q?uiMqICkX2vFdviabO5XEvNqxecW1VlrPGDAcFkXoMsJG84Oez3HsvT6ixzfo?=
 =?us-ascii?Q?fRgeZd99sjvhtZVSb9T79vOq9oIa6W6ZaK9UtSVzGUmhtiaZZV5icI8fh35X?=
 =?us-ascii?Q?Rk8t4u/zvfQKYESOBIYEv5U6Bv1wUwK+CJN2cF5v1AD3iohRTWIj8r3W/nUi?=
 =?us-ascii?Q?jXwY7tWyVOm0r8EpdPtM5N2+33oOpJVw4QpLHnoHFiyDVtodnJAM+gopXYEf?=
 =?us-ascii?Q?J8KCHoopdGq4AeRR/XOY2GXKoqaulx9JMauEVUnF/qll+greugsXZto+yzFS?=
 =?us-ascii?Q?ZasMAzXqlexRfBk80Mqe0uY6pWhys0hLQQHLONL939GVBbh3PbDVWBLTUwwG?=
 =?us-ascii?Q?ezA/S52uKV1/BD0gMfkZKt44+GKP4wlwf6yrOOcDDV1AFKII1JFm138fGIAJ?=
 =?us-ascii?Q?5DVpOzw8cN6oBC+2Dj6AJEnyaa6pU2q/s8sObq+b5iP3JCIvOkkdyEfWFVhg?=
 =?us-ascii?Q?+SDbQOWWRwp8HFigAdTg93ClQJf8qm+UfzX1RvsIaBShOEIWAIeOIWHRXrec?=
 =?us-ascii?Q?1apGONEDAH038SJPjoO8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8631edf8-2f37-448b-dc92-08dc7695e758
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 17:22:18.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6195

Refactor the list_for_each_entry() loop of rfcomm_get_dev_list()
function to use array indexing instead of pointer arithmetic.

This way, the code is more readable and idiomatic.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 net/bluetooth/rfcomm/tty.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 44b781e7569e..af80d599c337 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -527,12 +527,12 @@ static int rfcomm_get_dev_list(void __user *arg)
 	list_for_each_entry(dev, &rfcomm_dev_list, list) {
 		if (!tty_port_get(&dev->port))
 			continue;
-		(di + n)->id      = dev->id;
-		(di + n)->flags   = dev->flags;
-		(di + n)->state   = dev->dlc->state;
-		(di + n)->channel = dev->channel;
-		bacpy(&(di + n)->src, &dev->src);
-		bacpy(&(di + n)->dst, &dev->dst);
+		di[n].id      = dev->id;
+		di[n].flags   = dev->flags;
+		di[n].state   = dev->dlc->state;
+		di[n].channel = dev->channel;
+		bacpy(&di[n].src, &dev->src);
+		bacpy(&di[n].dst, &dev->dst);
 		tty_port_put(&dev->port);
 		if (++n >= dev_num)
 			break;
-- 
2.25.1


