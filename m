Return-Path: <netdev+bounces-97009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F88C8ADB
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 19:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1431C20E66
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371613DDD4;
	Fri, 17 May 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LsggTa4C"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2096.outbound.protection.outlook.com [40.92.91.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583313DBBF;
	Fri, 17 May 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966543; cv=fail; b=BozBxhwBWsVJUROJFshgG+zJaQt15Umrq7iWjscDkLguXmk9ZQOm92A6Xz5SEtN/sYuoPf+ZHdt+NQjnlokw6xQVwhxxFf/15+Wm3e8bDukl1qpHxdwJE6/4B7HrtnEJ4iZeKiuZclpMJWhUTRdDakrGZbIBp/MtRl69ymiQuUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966543; c=relaxed/simple;
	bh=kB3U8m3Re8BlTJpMXSRzGiKYmnKFQfXu+Ge3aVEA/X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/QuG8/QJWSF32VpYN7ZXXHCDOb9cqHuR7Jh5vleShkz4sc8aWxhnmTGLkYDSPoZcUolN+K1YoxxLybi2yYIUw5WZsjfTllgXIC+m1mXkiiXsqHkYeJaA+phx4J6UkOzK93AzjwMEgDqGuME3ACmq+eTYLVoAejYtC6CqafsKC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LsggTa4C; arc=fail smtp.client-ip=40.92.91.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBUSbwmEAt2LhedvgLvorDmv+ITPrlUNxxR29kRJlIuCW42z1V2REbHtLm2g4L/ln5BWY05LHdM1u4v6iCQLxaIIzTVkNiyiZccGftv5xFmCFYDBys99N3p6z4MCHaW8mi/M7hob3gOJbEXYPgdCQCcuJWHvKaAj/bNQcWFmaEsEQlrIckZMdacqdO+61QMPdgGFlhGnkYyxjCAM3LVxINgCiPMc64lsE+S9b8qasNS39nfeQKFdET6XWtIhvKjBauFMW+x8jUtdtY+jCPE4i6hvY3xP81MZ5lDETFSeBSuD/3GnPiSowIzQPLiOBCajYwiHGcBi+AwDU5jhEF9fkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86j+Z41CMZV6tGeARCPhrhJgbrEp/mNU151SDWbLPpU=;
 b=X6UgS0jCPBzlH/dGKyflXahFyeIAtR5Rgntj0UiMv0hUK25qBBbKYT1hOFXpAAN9KlMiPCTDZh8Zi6H7AKjQjIXLMJgiOVIKozlYo2WyjvZYJt1/ciDL6jCpmVgOT8mIlwEWkV5M8i0yuwoQoziPjUzeVuchc1q6JJ08ARIuwFLjK73mjyT1OXESebk6xHbBfkeoR14LpnJSijxbrGuOzp9UUKCaS74rRLwbS6VzmbvOEH+Qv2VdFEAokv1IhbxaFJddp1U+kvoRUaScGVw84e8lGSCaaEvuV45u2GTdn0/t2NcCY27gNheEUVWbO2VJ1ecaVvrgZDPWLJ6h4XG+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86j+Z41CMZV6tGeARCPhrhJgbrEp/mNU151SDWbLPpU=;
 b=LsggTa4CkpA86XT9DvsgMuj39GVQEdtCNNfuTEmvyjOXko3UtkVQFbppaIBqZEgCpEUybaEntKXjWoV8bC3fXWOT7Y0tWds5HpSUvY8W6N8Y95NOjG1+0p208ViFl/4oG4blXabNj4ctdE4kKW+cRtSfbyxazXhlUgvX/3wbsWVexXj3QLKBtqRmknolNgkzljImc+4sTlba1wysEPDyuNyyCkOHjUAXsHSctD1EE9XtekIwIVzG4DIJvskNSdRDxTQ3UcT0h7qOK8zjTz0ih9wk8ej/xQ5+0IUZmMA9nWKjEADFwwTKGHeubylxIZCmIBcw4qqUqUt/cCQeJzVODA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AM7PR02MB6195.eurprd02.prod.outlook.com (2603:10a6:20b:1ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 17:22:17 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 17:22:17 +0000
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
Subject: [PATCH v3 1/2] tty: rfcomm: prefer struct_size over open coded arithmetic
Date: Fri, 17 May 2024 19:21:49 +0200
Message-ID:
 <AS8PR02MB72375B833F3EBFF72A0CF1628BEE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517172150.5476-1-erick.archer@outlook.com>
References: <20240517172150.5476-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [b5TU28qmp+pS+FOlh/7S+DHVSTaDAXxo]
X-ClientProxiedBy: MA2P292CA0028.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::15)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240517172150.5476-2-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AM7PR02MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d04504-0832-4226-6677-08dc7695e688
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	/U7KEYlf2eJ5ITIf4YCxhqzXOnzG3WGnsz9N1gM2DYf3SuaaafHiX7XyU4dSyL8cpKAxwsm+4i2S2ZMXQA3lHxH3vdt5i7HvMSlwYvUFMdp1cJ58W9V88emkbd9MwUz3NGQjpugyhySG+SwFlhzUSxqXrlGKNBxHnLgu2ewiVNCsfqJr4bK/uoMdlqlm4cXwGs2fZ5Zs9ApmjkrgDgA793G27yR4wtwE5cCq+GtccwiZ7vluUQYjFhsp15WvrZxybYSJTWGZ9ZjY7wg/EHkEENsw4oYi5mYwLpd6a7B+khu09uxIUs44kN7QsBozp2yegkZ0pnr8yZstP8PfYasx6QhUrfuH1a3KI1NFTGInwo8wyOownYrbG0fo/Tgwg4Tgqh9bSPGn9MQxsZTHFZBSabQ6QC8kOotgmxCR0+BdNu+w3+aNWOwV+Ivs+IWQmNAE9bqjYsiMkPk1rbe27CfYnyYH5TnCDgtNoxP2W213+FzQmPD2hqGNkVfMckF6Y7sH+g7Snzs6QVE17awCAcQvKgTxgoWu5srGFAMcRo5SSOxX9K5SGWIlQKv2ZmJpp3sjdNIEERl46VUVE/DYeFLlVZpt3GS1dPAVnJeOiA7Us4PsWqiXXWVL1Uw65dHvFfcjpc3NzOdfLiHEP8nDZU70FlyI6bBGL6pTr84llH10WnNEN8nz1wlBITeWb4XZfdziHkVoaA1PruhHcWU+ttZ5Fw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jPjmg+GxcFY28kyjlTMNRe/nKW4lBT8tgAxrTZax9kPg52Dv7SL2+mq4mpsi?=
 =?us-ascii?Q?56QVhN4wdBBxIJK6oXXWxHTLYclnPnKm36tse09J+/lreKIcviHF4JHGZRK8?=
 =?us-ascii?Q?kUDYlTyThd5QLXEhpj8XGcDrv3H6KoutguXWpGr6LGJWKkUlqHVJiN8z8vu1?=
 =?us-ascii?Q?ZqypJO/nI/BlTG0tsGev3L3sfpNNWYYkW10qpxyQQk8aHO3dwsvi83/jjQPy?=
 =?us-ascii?Q?OFsDM312NDJVffjYRFb31r6M9nwii5EtjiCfu80yLRan0dcqXuQZIeJp6xz+?=
 =?us-ascii?Q?9f6N+1afpaZpf1MzP1Yw+ttEXkyU9WDwPbNs9MVVFnimEZ3Icl7YL1/EsYS8?=
 =?us-ascii?Q?+YYfxr2Qnsy6ppDo+W6xq6e2HQOf8eGW3AOpUSf81M+BV8pltVB9FAggN0vc?=
 =?us-ascii?Q?1oyP6diSTYSSANVw9R90x4zMN4+tWoUSRKPHnbxuSj8gemih3GpyCYum/IbT?=
 =?us-ascii?Q?GBEg4kZZ9xbgakmCfe+N6qe6n6TKJ+PbzGNJZAXnc7yUb9qXuqTMl+Rkycl2?=
 =?us-ascii?Q?agmvxzKniJ/79QV4S5yy0PXNjGau/thMLN7Ps6mUXfE/qhXFdJcKhY9TvpWE?=
 =?us-ascii?Q?+ZRYpNZD1Ogn4eHbWsw3rEXFAUxfm5hFhE9vQrBzjdUKfrNdZtAcRVIBcxIU?=
 =?us-ascii?Q?31Q/Fm9pyrLoP6LflycTw86ynH7q70OXILm242uoLJbjHfIojJ3jBiKDpF4S?=
 =?us-ascii?Q?/i3F0Mx05WGSw5Ni+qNXgPHZ2yoOGczc8MUORIOe5zWzxqDQmtoUxJfX7x/8?=
 =?us-ascii?Q?5rE7cy50NrZ9fr2DF1DaI0LuzUoyiTWgwxqBXa0CyM+gR5AJqd9i5kSMC06j?=
 =?us-ascii?Q?L+1z1szIQIUyM08U9lsBk6GtErtGCx1+zkmWtao1D1NpkqZYIBw1NfGCLcCK?=
 =?us-ascii?Q?oMeH9QEOOqw5R5EWtCqFfUdB/LZ825BhzG29+Oovpu3p2s8t6Xwu6MkQ4WiQ?=
 =?us-ascii?Q?OXsOswTHAcPBMCjAzPxDXzS+BmZubCj8STkixaI6rGeyjl70hUh5AUhQpdAJ?=
 =?us-ascii?Q?r7ArqF4MN4HjcT5DrbAfMqGch92rf3aX4UtV4rqbdjU2DSadF9bvr08OxB7C?=
 =?us-ascii?Q?rFPyoKkbm9PMiq7Nr6juLTXR8b7vPSR+RlMch0lB4zyfyyujABR+cBmOecyk?=
 =?us-ascii?Q?U9N7f2svzjR98W20NSPzly3vx7oDQ+BDJh4TOs4k6nrLG342VTCP95SxJ9Mi?=
 =?us-ascii?Q?2KWYkcfwDKkiD+TRDFMOpHhnsBxoDTCkC3P77qv3Xv0d+NrggD9gmsgiduTW?=
 =?us-ascii?Q?9W0prnmejaCoCnTsBS9E?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d04504-0832-4226-6677-08dc7695e688
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 17:22:17.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6195

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "dl" variable is a pointer to "struct rfcomm_dev_list_req" and
this structure ends in a flexible array:

struct rfcomm_dev_list_req {
	[...]
	struct   rfcomm_dev_info dev_info[];
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

Also remove the "size" variable as it is no longer needed.

This way, the code is more readable and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 include/net/bluetooth/rfcomm.h |  2 +-
 net/bluetooth/rfcomm/tty.c     | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 99d26879b02a..c05882476900 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -355,7 +355,7 @@ struct rfcomm_dev_info {
 
 struct rfcomm_dev_list_req {
 	u16      dev_num;
-	struct   rfcomm_dev_info dev_info[];
+	struct   rfcomm_dev_info dev_info[] __counted_by(dev_num);
 };
 
 int  rfcomm_dev_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 69c75c041fe1..44b781e7569e 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -504,7 +504,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 	struct rfcomm_dev *dev;
 	struct rfcomm_dev_list_req *dl;
 	struct rfcomm_dev_info *di;
-	int n = 0, size, err;
+	int n = 0, err;
 	u16 dev_num;
 
 	BT_DBG("");
@@ -515,12 +515,11 @@ static int rfcomm_get_dev_list(void __user *arg)
 	if (!dev_num || dev_num > (PAGE_SIZE * 4) / sizeof(*di))
 		return -EINVAL;
 
-	size = sizeof(*dl) + dev_num * sizeof(*di);
-
-	dl = kzalloc(size, GFP_KERNEL);
+	dl = kzalloc(struct_size(dl, dev_info, dev_num), GFP_KERNEL);
 	if (!dl)
 		return -ENOMEM;
 
+	dl->dev_num = dev_num;
 	di = dl->dev_info;
 
 	mutex_lock(&rfcomm_dev_lock);
@@ -542,9 +541,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 	mutex_unlock(&rfcomm_dev_lock);
 
 	dl->dev_num = n;
-	size = sizeof(*dl) + n * sizeof(*di);
-
-	err = copy_to_user(arg, dl, size);
+	err = copy_to_user(arg, dl, struct_size(dl, dev_info, n));
 	kfree(dl);
 
 	return err ? -EFAULT : 0;
-- 
2.25.1


