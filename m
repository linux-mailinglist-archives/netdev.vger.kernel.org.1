Return-Path: <netdev+bounces-102438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36106902F60
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 05:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064461C211FD
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 03:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4E16F90E;
	Tue, 11 Jun 2024 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vLpCoeHr"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2172.outbound.protection.outlook.com [40.92.63.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABDE64B;
	Tue, 11 Jun 2024 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718078067; cv=fail; b=q7mzXAsCVwdyHuFrL3UN1ov25x+UOr5WCoi/3/cfwNR7KRbws79Om0mRGEzHpSJclnDm+GWn2zzruDsmZjw9x34HHn5VpjoY8OSZlOuRG3yUsEvI+eAmnPmO2sJAofzRv+ro0JjbczMDX673VP/AFGsfnxpnMjVlWPt8lhgpp34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718078067; c=relaxed/simple;
	bh=+mThVEnHMZ3pnpM81BFtuITg6rekBAsrtuWXlxgmmQc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WNokAKD4UzY+Asm5HA+iyEtc5X6VsD7thSoqj/RI7t5pYXDJd2W64eZKmifTBNx0eB3gxXhGGyTsXo5SAIRT0m/hOW6pIIyUZQKv03TIJv2H2Li3M07MfbRgneUNICahSMzgt/fOK7hNeCGlcdYZfbYStbYYTQkAuEtbvyEmCX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vLpCoeHr; arc=fail smtp.client-ip=40.92.63.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyWKkcxe8bTjKL96heVbmBO5MRWN71XkpnO/hvk0cKIoJklmk0Jf0O7w5pejMscd0P5mu6NYNwuEhAAf5erFieGbZXkmXdHXqu8SQ9q4M/6oDUsWaB5mRr/z03KSq+e/Kmuyom1Df/4HZ9axa4ts18knFMjroUk9IgK/+32VJSF78MOBEwkMozU1ne0TSkfch7z6U433BeYK9wo70Z84Z5kW96rJiv7ih+59/WvDJhuO5CFlCLDCVlFKikb3Ycw6H55OlAg0LA3I5WZxMXMAeIXQ/rwENzPR375ZF3faVk2Wkn2LyTfGskgnrki3WlVTKGBrPbURDVlBUP5kA6frmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXMJzQTcnj+4D9mqrF1QZShzQ3HG7rL/a84lMCJfGKE=;
 b=JznB6y+/xiIplmyhjMFlJk0XbAWY1xMN+0jpzlh2Dpeg+wvzDEoR7ui64lYXLtHHu60qeKeIl2uiJYcIF4fGmGx/phyReDay2R4NDNp91piAvd5EFHwN+trs3f5ADA8ZDa1PQv2ti8KQcyDcI5tJSWtQUqaLU2/0LgzhQl/Emgd4Lo78qNxok7YPmR3LA8O/ICbk3MdnLzmZThEHz9ow4VTXiKk9RpsEWGc+MMPW+rD57CiHZGX557Q1M9wzYHOaJZ2nc5j+yAFpQiAouBBYFFoBraiWYdsP6nxzu3sGyJmkFsXFFNOTppCfPvcNmTOhqZBlHzwjPTrpuUjScg6tQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXMJzQTcnj+4D9mqrF1QZShzQ3HG7rL/a84lMCJfGKE=;
 b=vLpCoeHrOw/3T0Q8VZcADaowpsBf1NsIvJCENGt8IkaUgF47LKrMB10zF3LJKIgq0yf3e8sQ8yS0GM3ooRwxFsPT4ErD+DS2wyKchJtoLmSk5VHSd45JjB4DHe/lGSB5VEqqjfTewcCVQddW/1rh6SsRd8idBigaItOkQvKTHkgw71Ad3ozamdT6JNFdDZ2Dkq0E+wWJaD7prXrz9Tm/4Ub01fuH7D2Bz62IbevhezxSgNz5yHdaRwhrGK3BaE0tYv4Cs0orZ1duWR1BOaJZiEdY1HbERoOURH5Rvn1n7MGrFB/gct5NDtJMlYv3mPXV0ygeJJ6l4HmTv8PFmKkK2Q==
Received: from ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:186::10)
 by SY7P282MB4832.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:54:20 +0000
Received: from ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ef09:453a:38f:15d9]) by ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ef09:453a:38f:15d9%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:54:20 +0000
From: Gui-Dong Han <hanguidong02@outlook.com>
To: 3chas3@gmail.com
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@outlook.com>
Subject: [PATCH] atm/fore200e: Consolidate available cell rate update to prevent race condition
Date: Tue, 11 Jun 2024 11:54:10 +0800
Message-ID:
 <ME3P282MB3617E02526BEE4B295478B1AC0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [CUeWyBGfb9MW8DKLjTKBPef0uUVJmEXZMg9DPUBkK06Wc86OTwd0rgzM1zyKVjuj]
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:186::10)
X-Microsoft-Original-Message-ID:
 <20240611035410.9255-1-hanguidong02@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB3617:EE_|SY7P282MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf6e535-e698-4b00-ae6b-08dc89ca2c92
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3430499023|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	e1ZA98nsDvX/fD1IVeMVDKEXIMGUs/49M+1MXm6D3J05gJLRtnX99dbIFz4wiwWVc1oLIhxEjBkpNCRB4OLxU8xmb4EIee7HzuqujEAn3+/ZP88cIV1SPNpReGIxcugRNzMjTZmzBm/hiQIFgzNCxHJv+tgVtYfnlAXM4wLuMKZLKRV3iw1jpTznj94ngJ7qH5GzyWPqiaErFjmA7TWTy1R7h/vMawhRB46s5bM7NhBH5bETVriiMZPHMIOnS42JfeYNktyCxW0aG3YbwfFaLRUAzxCfqneO6RR5m0xyHmJ5hHxyThanqpxKl6PZg31tI9AcIFD4JrmCMXswuUIytqB4ABkMt9Rhn+kboqvqPugUs7C2YZ2oEhmRPDeSWF8oD7ozbu548BbGfB4fYG8M6cDCmrvNN1usQZtGE7jjESFw83o8TMqPGcr5RFaaN241ZQp0mQbuDWw9abSllPo4lUClDBJwcgToZsrcwoIjP6jqeTVmxle0InoH5bftPpgu8/om9dviJXCu3jqPsQ2cyA+MJWnIsMT1KrXR80n4ZqFekAMHJQd1hUG07AAtieC6hdSrIiUU9UU9ht3LNvlbGMwXaP/RPtkCzTRpP2M+jcJbJsjefSumCSQjKLe+dM0U
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dnqsm5vR28hQ+r10Qym9UdtfruE/FHhPELYhkdlcd/e8//RWOoBUree8C07o?=
 =?us-ascii?Q?DCUVG9MFNsZLSIFZigbiUr/EZnHbZbkyldXCU+cC7DA+dKvYp+YUOOs9VYd7?=
 =?us-ascii?Q?mCjhwP7plFUMXjPnvT+b+0hoC+qCPLEOGQ9kAoL20OxgdPIZN1udkXbkoQdv?=
 =?us-ascii?Q?b+LZ2QVxjlsk+JVRXcL3s4/5oOn+NSDXEeRdKv0M2yvSmE23F0LuBj9dHtYM?=
 =?us-ascii?Q?uNj3CsoKwpPhb8kIG1D9kA491FIT32yCzKNR1t1qrd5K3yixSP8iVx82T6Nf?=
 =?us-ascii?Q?R9aDw1wHgQlfiwSliSy7zJA2mHBx3RVw8YCjLq8zd/Ic4YZBgqETOSNPNyhr?=
 =?us-ascii?Q?mJg1tC5uKlmWVACrEQ7BuzpRicekb0+stgYokkhMMMfks129PQWmVv0oBMwH?=
 =?us-ascii?Q?KcF6jNfrPxnURybn6mUwCfDH93akxIZRB7v5r7lL4Chq4wQzAtUhGarxJ7Lx?=
 =?us-ascii?Q?PsDKOM8aX0iZqoAmo4ZvK4zOXfhn+74QZ7xjYbZFyV7eG+N0gRN+JUr6ST4k?=
 =?us-ascii?Q?GoUvsNGXFOTEZYuGU1g/nDgG6VPbPHlX4Ub9O77jLhZaXGa2rHqbMrSl5guo?=
 =?us-ascii?Q?7+GMGKyIF4ZrrnXWgOE0BIwgFUscA3svRh6Crpwe3CFP4aFquliZeR60QhOh?=
 =?us-ascii?Q?GaRtDy7Tci7jJEvXCQ3ImTGJoIuCJ+UoFWfHw9sKDZ0XXD2vXoVbaUXkGoW3?=
 =?us-ascii?Q?zIiGydCsAAMNrwJ9T1/y3IlWt9TaYOgjzRQUeUnaHVD3fuWEwkaCH14sVFOU?=
 =?us-ascii?Q?LftIOKY2Xx/JwYqNoaAz2UN7jpBGZ7beoR+JVst1FWrE4iZBTnX3X0KV0KeJ?=
 =?us-ascii?Q?eD9PzbsbbiRY8zfwB95ZoI3mlH+HJWUnJCygN7GcGNr7FzNUyJLpHmONRR/J?=
 =?us-ascii?Q?uwyw6s0kX4iom/+SbhrO8UOTEprNcGEgl4bYvc0Rg2cvT+QvHkV45tYPKdwI?=
 =?us-ascii?Q?lgdvhSyHF9jnW+qhNXoDIErMOurtUs4HffpE/nK6XzPYe0JzRCzmIuPSyY50?=
 =?us-ascii?Q?wcwwv2MMBOL9uyqDahbbPyHjITlvZA4E0xUgXz6xXmsNh7hcIJjewx0g6jp6?=
 =?us-ascii?Q?GpLufB5S+GvyHtciqwh4vrs+sMiX3S5Ylv0tvUfhPKSuMbe4odMRA0m6eEd8?=
 =?us-ascii?Q?2yn1nl0OisXPdLzzrWv8IePv9+6uEk4dd1yJ2XrECp5VxG1WpKqmXHEEGhRT?=
 =?us-ascii?Q?wt7zh/J9/jJ4PgUIXrD6g4fslRdOEqrhN5/Uyc2qS3OU3fGdWpr8j0/bOkIx?=
 =?us-ascii?Q?qFPrMPpBRfqIZs2pkzu6KuC/mgWMZ1bHjxW4BKaF0DhXy/RqEod9FK1Q2/uc?=
 =?us-ascii?Q?g3kwHE14d72lzX99DJjPLPHn?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf6e535-e698-4b00-ae6b-08dc89ca2c92
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 03:54:20.6854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4832

In fore200e_change_qos, there is a race condition due to two consecutive
updates to the 'available_cell_rate' variable. If a read operation 
occurs between these updates, an intermediate value might be read, 
leading to potential bugs.

To fix this issue, 'available_cell_rate' should be adjusted in a single 
operation, ensuring consistency and preventing any intermediate states 
from being read.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
---
 drivers/atm/fore200e.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index cb00f8244e41..d54e044d7542 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -1906,8 +1906,7 @@ fore200e_change_qos(struct atm_vcc* vcc,struct atm_qos* qos, int flags)
 	    return -EAGAIN;
 	}
 
-	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
-	fore200e->available_cell_rate -= qos->txtp.max_pcr;
+	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr - qos->txtp.max_pcr;
 
 	mutex_unlock(&fore200e->rate_mtx);
 	
-- 
2.34.1


