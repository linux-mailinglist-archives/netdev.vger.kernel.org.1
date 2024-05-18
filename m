Return-Path: <netdev+bounces-97059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF658C8FFC
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920E7282AF6
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18673D52A;
	Sat, 18 May 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cJq2ASOM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2057.outbound.protection.outlook.com [40.92.90.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B79460;
	Sat, 18 May 2024 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716021074; cv=fail; b=p4doMpGVneDwUeS1s6x+HJwHBfBZQLeN2pjFhR0Aci+kM+tCPaR/JiVcXrk+5Y3f85La9+kpjWfm16yF+c2nvq5bTJZUZWLIcXTaMU5ztGCOwztp5aPYD7CSoImIeHqz4/9DwLdDdOVmP3Iv4XxNpTqAdEOCLsvJ3PdCsO9/LnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716021074; c=relaxed/simple;
	bh=gbdPQpnZG0u34Q+Lu6u7oT0mVZR9ulv3pg3+qshARC0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hghs2LgyBNPKjMxpSXa8JH5/+vwq5KPRPJ64KC/JLwcMSNyF75gTq4U3ywzmXrjeQnSk5bdylc9Ik7bNiS3zTYfwqIjkuTXB0OapBk0nHE6sOsyujQQQLZY+JsZfjV7/N3OdEShNdqI///pf45awnC+FNG5Ixp4LOsQhO24ASfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cJq2ASOM; arc=fail smtp.client-ip=40.92.90.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcgjSjwXlIWsjWAfN28F+HbedfXBJrFq/yQg+GNaIjiwxe3NF78BSBR8s9KOe1r7ugE+NQcDUVE7SxMF3TuB88xHUiMXul2wvWECBr0ZgvQfT/zkyDVCUDWL24RAmQUqArdgT2WG8WsRPl3SZFqjrTAkiGa6z3ahpD1vK68tXqdRGnJ4cf0XIgWbquzvFDC7xV8kdHdD3DdolVRXBnkOyAKAfuJMsJskANdg5mleJEX+V8+qhFDBaRFU6nD23KbA4Y/OEojaljYKS6UusiwW/gC4qxfgMQMX4isJwSGKDJ9pWx75AqO4zMWXGuCd4ilOgEMAzLnkplO/2QyliJZ2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGQT2HI96Df6uYB6sJ24nvpYiLiwEkBs8CwOI9JeLVU=;
 b=O4saKOnmY/dpH+ScKuM4R7X/zc9glHfz/L92lyhqCdMNpw75oeTM/yR8pMx85p/m3wAq96PwSn1nxaupr/bcCMoN5XMhuIeiR3xbXICW7M6KHjDg3r8s9pweEyxQer6bU7dwjZq6AwnaqLANRIwYDEK2qHi9nY0mCfhQhNehpxB11abD5Z3r9dUjp+JjbwMG+uhHfsEnuFRezZKKFmF7BXId1ZV118ZtdwZCXIUXNgFmkwBr/WXWFGMhFDzj/7D+6DJNas77AWBP8LGalxSjr25OlJBWMdlZ+m/qr5cetuXnaCrmZifhUoSAaJtJJu9blo3CYdH6aGq16od1oOtyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGQT2HI96Df6uYB6sJ24nvpYiLiwEkBs8CwOI9JeLVU=;
 b=cJq2ASOMVzKh1AZf45EuyjI3MpBRtHLi8TfL1deNjK/3KWoq6Dxr3Q1P+dMB3OTOWN6oKNKJSeHElLdpRgdaUAeKh4wi9n82Y9kAA7m0lsDm5DoiZoFfMoNkEznh1wXXIyBWVkb35fhFq65BG2GdIDw56npt1oQUyn98/wumg2YphOYfVi8AKEp+h7ciPC7aE8bKIPr0hZqRbrmuJoDe+oHJ8NtwhcgEQMRgfWfUrjZH8fgx+dae1G1qKlsnGpffxtxZK269rWhdD2X+ccn28D5NGGJ4R2aYACwBYcSdlCLaSuRjJ97CL00FLfa8xpULElWsanBFNBnm6kbL/GciJA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by GV2PR02MB8723.eurprd02.prod.outlook.com (2603:10a6:150:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31; Sat, 18 May
 2024 08:31:07 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7587.028; Sat, 18 May 2024
 08:31:07 +0000
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
Subject: [PATCH v2 0/2] Bluetooth: hci_core: Refactor hci_get_dev_list() function
Date: Sat, 18 May 2024 10:30:37 +0200
Message-ID:
 <AS8PR02MB72371852645FF17D07AE0CA98BEF2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nbTI7sV68c0uztVbCXbEzvnTt4GRqg0i]
X-ClientProxiedBy: MA2P292CA0026.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::12)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240518083039.7202-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|GV2PR02MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a04f747-5296-4efb-ecc8-08dc7714dce5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	uw1ZdkKe9aLU8le5R+KuUW8zSL0V8MuvUYVe00LYQ3qKOz08bYaBzN8mYXc1F+maHOVZBu6+lWPaiZRdb8pf8O2+nth9JFAuFuUZkRO40JyBguTjeK1EIu+r7xx/cnITEtqBLSaPku/cCoNtGGoboFwabseNxOKiQL7RUSB0TOz6sd0eo+j6sqIrOApfwVB1sq7SqkH5TWWl+5fYRdVq1zSbppLVwp/YEEXr1bMf55yRyzQwthkEauL1AdnCsMHoNHNC7NzUnSAVUgvKnZYWynwrLNGzqe70f6SRS9sBNTWR7FZehnyVER33bR1Nw7Mj11u122chDRT0/TZlhiZDg0FehEE0khiNC4zloPr0IqEiHLzu0TtfBOsDP+0eBfkw8Ow3jHU8weWuR4Z9k+vqaot62zbh9R45KZXhoCaL44rgn+gA9z6dl5sP73SiRST6CNpi+k+WPvMzqJE/jJWQCWoK/lfMfpl7GIAWP5T+VOohUWVtin2WlF6Faiuz7M2scgOcYV+mZamalrc2ipcmHv0945beTFmGVIVTD72bkbgb7Og1rH5Nio1P4Wi1AfLRW0ONY5Nznb/9NzPE3AIxdseKhC1FM2S5DJWaSBAKXpnqK+TvVwfGOpMzviIOfoRTM7PRTm4TiuLUOc/O2CaLd8fu1/f2mZoyFqPqSJp/HSHAzfggLyINcysvUIpDSt4kbHyp4MNqKdC0IJEn+t8azg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wi1o+iKxihqR3oR7nn1gROJPhi4PsR5+9RbWmgDLBPDlSDrBmYOoamAdJdT4?=
 =?us-ascii?Q?jKuUNUNg8nfehbEslfbLv29wDb2WF+E0C3jpGwMQmUjkow7x0WGP7X1HK0G+?=
 =?us-ascii?Q?I1DTY+PVXWl3h9Civ8rcfKCXA7e8FF2PW/BsBr2NHyMe5136fhIjf0Dj5Mup?=
 =?us-ascii?Q?X4+oikqscPDZWj8VbNCdqv+gCptKEeF1+nvoZFqAU8wP6BraMuHvsfzOcbz9?=
 =?us-ascii?Q?f/r21NzzDfLv2QzPemkDi4zykqSkM4d3ivf+QyUy9AZLuatkaAHAHMnKwnD3?=
 =?us-ascii?Q?B/bqy1PRoeu+9yBL4I/ngGySdDTo6+7XmSev17eW0kD0a0EG/NniuTMMouSy?=
 =?us-ascii?Q?Yjmt6IZk37o1o0SwDqSzallA/M86tWKqCZWwIfcc/2bqpTbUz1c4mPdODWFs?=
 =?us-ascii?Q?KzSiLO5Yxx/JrVGpobOp5o8X/Rcav24Ynumu/6U4C54F3cf1DHqjRVDfkb0G?=
 =?us-ascii?Q?o3On/1nwFU+3TSyMKvcCp/rhGHl69WBh6eS/ZOoHr9jNC6DckY8vkZpVJDTO?=
 =?us-ascii?Q?fDsPbUK7PnQkhXrXmloa3Y5nc1tuLJ3wpWj5eIzJ0kmK+BqyBY3dGRtCc0do?=
 =?us-ascii?Q?qSWOBJWJ3mDREvkarC6/Al8ti3810sKQsETKLW7/iNy2rh+TQvobJ47JaVw/?=
 =?us-ascii?Q?ZTkYx6PmlnFwS5mlGieBrdxHzah5c/h76hoh52G3+s3hc0QkNcfNf2b/OgnS?=
 =?us-ascii?Q?lXfgfiXSzEqiJPm41fgthiL5d7lewJE4uAZ5nV2+BjkkEI8Aw/aM2G+8ZCuv?=
 =?us-ascii?Q?6ri8x5zqMU04XspyxLIjUzCHcnokm49mz+xpmE0YpbxFbnMPjUwhYLH5+iSe?=
 =?us-ascii?Q?6Ux+c/JP1yqswwPLFU2AVd4f2oSeFo5BZzx405t15OOS/i5tgnLHKdrDpdr/?=
 =?us-ascii?Q?XVYcmel1uVh9+C4HXIQ6mI5WkU+dfkKKwx8yyuKH3lUTOsjk9R4MCLZIdIbT?=
 =?us-ascii?Q?JvmMAMAOTGq++nSj4Uscq8TiMlkDmWN5ugC83lmsPijwbTyvj70lq3/4/ntt?=
 =?us-ascii?Q?k4yS/T0m9zgZ5wIXpOVYc6EwwqMDF/t/PgE1euC5EguW7e3WiQg1a1Kl4dRv?=
 =?us-ascii?Q?XlwHbcuG7DxnJijevDfi508UemRm0FyIeerfiEkIDn9WcSkjGzbuG8vta0vo?=
 =?us-ascii?Q?2Of8wocXtJ6520P5YGSYEr8LvnA98vU2c3LWa+Ah1Gamg3nXSmx5ClEU9HHv?=
 =?us-ascii?Q?ONZJMaX+KuE2qoBGSvU4yfSTwF4M6W1tOxp8jbek7Idr52yaxJcYOHemb4yy?=
 =?us-ascii?Q?96XCeOIzgSLNc7vfsomi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a04f747-5296-4efb-ecc8-08dc7714dce5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2024 08:31:07.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8723

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "dl" variable is a pointer to "struct hci_dev_list_req" and this
structure ends in a flexible array:

struct hci_dev_list_req {
	[...]
	struct hci_dev_req dev_req[];	/* hci_dev_req structures */
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc() and copy_to_user() functions.

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions).

In this case, it is important to note that the logic needs a little
refactoring to ensure that the "dev_num" member is initialized before
the first access to the flex array. Specifically, add the assignment
before the list_for_each_entry() loop.

Also remove the "size" variable as it is no longer needed and refactor
the list_for_each_entry() loop to use dr[n] instead of (dr + n).

This way, the code is more readable, idiomatic and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Specifically, the first patch is related to the struct_size() helper
and the second patch refactors the list_for_each_entry() loop to use
array indexing instead of pointer arithmetic.

Regards,
Erick

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
---
Changes in v2:
- Add the "Reviewed-by:" tags.
- Split the changes in two commits (Luiz Augusto von Dentz).

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237ECD397BDB7F529ADC7468BE12@AS8PR02MB7237.eurprd02.prod.outlook.com/
---
Erick Archer (2):
  Bluetooth: hci_core: Prefer struct_size over open coded arithmetic
  Bluetooth: hci_core: Prefer array indexing over pointer arithmetic

 include/net/bluetooth/hci_sock.h |  2 +-
 net/bluetooth/hci_core.c         | 15 ++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.25.1


