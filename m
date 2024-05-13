Return-Path: <netdev+bounces-96121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672BC8C4629
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A00A1C23176
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369402942D;
	Mon, 13 May 2024 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="P8/+K7d1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2126.outbound.protection.outlook.com [40.107.220.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817520DE8;
	Mon, 13 May 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621767; cv=fail; b=QYBEgcvO+rSbvUcw4csvDbfZHWKJHDa+T3TOQHvbhtRza0Ic6g47okyFzLcQpblBfSNk5r5LnTosw3reRByjQysU3LeiyCEECki0H2Ci0Na+wva+eyvRem6E0GQ8ctGRNlv62rZEGqhp9KwKbDeoQjRXNzgW3KFH1YI7MdHyavU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621767; c=relaxed/simple;
	bh=52/H4VhMWsBWCW5HZjL5onvCNziVYG4+OOtNsjYjuwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bhRw55kmWecMdfRwP1o8VGMgnmcabMpX+GZ+BAikM4Nik1ppsypvkXnOcf0m59+PGoQagDXXkZxXGGEia/WObR7J50pPByS/Pp3pe6X3p4n4PYpXoNHhIEqGqoPp3oGiiqgW+MMEnzhZL2T3X1n5+qjfCNT5wa9Iab2LslkFKpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=P8/+K7d1; arc=fail smtp.client-ip=40.107.220.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nau9tFpLKFj8JdJy4fgvGWi5CE5xJ41Rd/Wk/45vFkwY++JE15uFKMX8iiyaK0IjOk8xY4ssgyYoUui9qn2Qm9sQKyglrWe851BiIWRxKJGEeWvtHW+WtuBqn12hizxwcqj8sNC6lb4evOklI0eBmm8uWzk5dvkwxFZspcVG1s4LTdCI35oP6H8T7+QRaByTZq0Ldqll4UA/5F693VBD4sPYqDwxINNcqQ8IgRA3YjFbWGyn7HKHLIsIKUPKnrTTb+a+Fhm3cSV9ogivspmMXPCh199q2Qo+qqWAYTWng7u2Mx+5H9GB3qYoJ93KeSF1oEUe6Ui84uj4hkXp7XMGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb16iOyU4Z7n4VfqdhsTkXo/XtcuKHNZXhk2vH67qVk=;
 b=hPAfjoRey6XSJXG3gGpsLsyHojdl1cw9Y7V+0y+CWlCFma39PBYVRfpSJTlBHB8H/eYVS3NZ8u9biUn6VEdqXO/Fjk1Nk8KU7idZNttONR1hdjzNZAk6n8/canUv4WT7Gj1Oe350OwGAeWN46wCW8gBFwagvCJVapxOi6xT1JVWJ6gGy0tL2Y2WHi2//xUL5v5hD/mVFt6kAMGPYfpkuaj2uvoUu3JfVzRd5rwtdzga2OzP5tvjA3AQ3JVQSfT9tChGO91IHg1rW70Pup78MoLQuYrmKUGuS6BtegvoRVXmjxrsIOAMIh2MuX3vP2HPDtK1SnrrjTNTwdQiguaW/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb16iOyU4Z7n4VfqdhsTkXo/XtcuKHNZXhk2vH67qVk=;
 b=P8/+K7d1/29T2KziJLYop86ZbDtls4QV+6FcBp1lStfcjbDw/7DNcnHYVhpF2g9UX/fH3b1F+FUaw5kpXlZ7oZ4zERyZh38r02dX40XI2LFpq++zHgQDQoIqqjwU0/G/RJu2VAqVlVDrXDrCjs9B87RZymqQjiG/KmQ+GRFWxOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB6191.prod.exchangelabs.com (2603:10b6:a03:296::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 17:35:57 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:35:57 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: [PATCH 1/3] mctp pcc: Implement MCTP over PCC Transport
Date: Mon, 13 May 2024 13:35:44 -0400
Message-Id: <20240513173546.679061-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:610:b1::17) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ed9d97-99bb-47cd-c707-08dc737325ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|52116005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+gtumCYfUDy5iLMwfkeftH9NS2VkhXNLK2ritKkIj8lgOACwUUdC4X8/DbdY?=
 =?us-ascii?Q?R4pz96om6tnSDPvQMvypEzgcvm7jzadsjb27nX+jstmkxw0kKj1ZdbE96OFM?=
 =?us-ascii?Q?IYwc6nsOCr8DSre299zA/rb7j3i7QN/0/UKWxqV3aLZ1lZLL24ZyYTPd9Hd/?=
 =?us-ascii?Q?L+b0eWw5YGapb68JD3PpyUVHfDIAZUI02RnluSKeND2kmfj59Wp8pAzB8x65?=
 =?us-ascii?Q?bJcohSL7J19f4xyA/ebqbH+b9nWzrOkLwACb5dYGZPf7EXdJ+cCau76JY4Ha?=
 =?us-ascii?Q?Qo/UEk7ciSfi6quf5xqzCzP8sfYogv6dWO+QIV5RXrHRv1DUvnF5LncXKXWt?=
 =?us-ascii?Q?9Rtls3yAJlxpgxJ5TaiBvzHJ+oC9Wbfmd+7b9GHcNosZ3cNGROFHfej8GZUY?=
 =?us-ascii?Q?f60eD8PRekbi0ncFJg17NyH/K8SuM5b45i6a8kWeQTDAv4Pe/sI2MuuBTWGu?=
 =?us-ascii?Q?GBC/xamKbGTgvgheVeaGB/o1p1ggFIYprzJPPfcLZUuDfYXzpxYn9H4+X7Uk?=
 =?us-ascii?Q?VAftcgryr/c6nI3IZOow4Oj2myxVUhY6lKGCTccxFamju4Pt0AgftbAnGlxj?=
 =?us-ascii?Q?7GfHd6kVcuEw4o2VDebUWV93H7AVIpryFjDTELrUGlo26hxxd0Z8Tka+AlqF?=
 =?us-ascii?Q?4bLQYKHF2n9b9eIwhRt/u6QfqUGIqCmMg3Qn1x28aPkC+AERkksJZTeuJ92b?=
 =?us-ascii?Q?jx2g90ySMLzS3jdMvB0SVv+6M8vtpEjPemzGWt2sGruw5agS846OjPJ63U2I?=
 =?us-ascii?Q?csA166DXbRkaxFb7srpGqrVFxjH9dCBlpT3vLbp4G7m+qMefLyrTeSzmt68e?=
 =?us-ascii?Q?9+ntqYdulCdzHzotbZNLLgvN0CfTds6oYSqryk8iEuYBb7cI/13sGu+l7LV0?=
 =?us-ascii?Q?XxyEEmQcGcS+T9BMpMvcUBVN65UGdGY0GkRuCU5Kn+eQXv4dwE8C0w3CwsO5?=
 =?us-ascii?Q?t1Zw8j1NrlTx+/WY9+gMTfI5E4yZ2C+I5AGlQZ52x/TToxd9wJD3sBxz97Hg?=
 =?us-ascii?Q?ytYZ8e9OQRgKupYNI9sSt5SwBQooEF/BjMl00gmXrbXTpiLgFx2GLU5IiHuE?=
 =?us-ascii?Q?PqweVvfdDQ9A9wL4TIHhJ9rkEQqQkrq9J2nBHdY2PuvC7GuMlnZ1yZIZznHn?=
 =?us-ascii?Q?Zy1GnjrhK0MhPPiB9ReN5BnE4RmNb7byEruYJushW8tKe8eF0Wn7xtlceIXk?=
 =?us-ascii?Q?/evcnff0ljUkuoIME3v6dNbcKYCc2KhpGebH3s+k+hOUfErdT9QPG5NqNKE1?=
 =?us-ascii?Q?wbwso7CbElhCJqkJqG7MVe3dl1FFBDFbc97SsoMHQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z61QdDj48keeTFtJ2rmNTb5ozKZ8u7OGdrDvZuTKtJNZQRCQYRaf/jOABn8+?=
 =?us-ascii?Q?4C2lHcxSPYEbkpTmyJvG8NFdCVYaVbpFaUpGkncg1vNw+oxmdIwtH4PeaQbz?=
 =?us-ascii?Q?A9aDTrJtdBWg0hsD5vV0gaXWMKZy6avN+NQzyryI7W8CJ55LN3HLj++sIyp9?=
 =?us-ascii?Q?jc5EkioKC6rqvuUrA8x1xgEEMQMw12gTxEYAYa0mBi0EZ+JoG2o928wFeZlc?=
 =?us-ascii?Q?Cz0Bgki1rBujJO9fxoCqSK6atEu+bwUgjUg1STiO4XN95ZeoPhgq62cqyGtu?=
 =?us-ascii?Q?GWdLjtR4RuplazCz893SwCQeY4MeE4pHeBZyaRDG8PYQRGKLABK31RVvvRJi?=
 =?us-ascii?Q?4u/6v5lUgX1M7GAnVZ5hnPmivuBIMG+D+LSU3WaJwut85Gic6OFrsKFHvG53?=
 =?us-ascii?Q?ubPmMH2E5SUvYmR13EwoXZB8p8TjrIMTr4/OnH89GnZKJmKIrd297Fv3j9yf?=
 =?us-ascii?Q?/WQVrLm+jPk0eTxQzMI1URjVL5CelwmwwPelCIOHIQseU6e4p8JQNTIbOctA?=
 =?us-ascii?Q?2NIYvXNrhwlCIhSoX1AKWqHG7aq2KCzcLiam/lqQBSHeYKowXmid+TraJaGq?=
 =?us-ascii?Q?p2a7yHRyBjvu5k6CROdIWdlZPA0v5uHiGBiE+YloGsSexjUc/ur5Mxdw7fWj?=
 =?us-ascii?Q?gbuEGWxo23xAS9BnHA1c8Z1R0rbdRYxR7Ln5JzQ1unyCXF7HhVINYl19Gowk?=
 =?us-ascii?Q?DtIHo6P97hWcj2Xhk8Dp0wr1Nxq5H6mhVJgAxjB9cZtWjn4+RoHN+Tm5IU2f?=
 =?us-ascii?Q?8LTTgGU2ajsOmv1Qus12v7tNnHI+dqa3pHZYBjhJpZOxzWGZgXb5CGoQm60S?=
 =?us-ascii?Q?agSFxS1Ydm3+gzx32e6sJMHjbS4hmisBbqUWN6YVVnliJ/tLOnuWZd0/fwd8?=
 =?us-ascii?Q?kkqJJZfbNncFyjIL8zk9pd/zmt8vw6/K4oH2CtAwO/HNKNA1j1Jm910GxAMX?=
 =?us-ascii?Q?pO8DXo+/Jtb8bNTub6/sGFsSCBD37w2+Dt6/rhzBB84E1i5y0sWPUpFUZJ06?=
 =?us-ascii?Q?7WcRMQeY0du0FEPZaan6pK6Sy4y39Blf7g0m924tPlmPzEEcGqens5funsg/?=
 =?us-ascii?Q?LR3XbB0TC4BQ5IwMDXFZA5v6R9+h8JizrgMFR5vdhfFKMYnLHuBhpBKl/XSh?=
 =?us-ascii?Q?f4E9+lFHQjdyNKpaIX/JDI363H7JV9DjWzireytmgZ8jPIPmCBcoOM0G3WdN?=
 =?us-ascii?Q?pR7xE/K1vkaghYbJthT3se4UcQOXowAM/cuqYTiOawA7m0KcB85yWnTk6d5X?=
 =?us-ascii?Q?njrm7ow3KAYc3/S8/dgycuEVylCKH5I+4Rr/6C5wZUsFi1HYtLui/mkCI/tQ?=
 =?us-ascii?Q?e7MByTWgBqFxDRoGijuhUchUdYh+pJ6RBWpomMY6EYzDnF8/UgDmRMnbKZQR?=
 =?us-ascii?Q?Ica9rfDEnd+W1aAQFy8ypSNSMwUO0rhhCX3ypwHgZsMfWAlucT8D9uOQL2vF?=
 =?us-ascii?Q?5cylcmGs2nq8bQiFOBAY8qcNbr4Bvzkt3kSjy2HqNsPzjq93zdJWp5IKpJUS?=
 =?us-ascii?Q?kfgk0K0+/KWcjb5cOi2/EAGzQ4gMnyfEd8bFcGCfOahNcD4IS6ffEiM9xc4L?=
 =?us-ascii?Q?yi8v5hiuyEbmsL2/5qnlZ0AqejUoF63BCP91VNS9u6EYRCLdowUWxdO8Kcg8?=
 =?us-ascii?Q?I5BPez8oW98JcYf1NVo6cPYVmLKOn65qSNXG5np52bVxm6sfqGDhZU+tvAL4?=
 =?us-ascii?Q?mQmxV3k3f7gWaWWOlyOlGb9lQRU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ed9d97-99bb-47cd-c707-08dc737325ba
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:35:57.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2liY5dM0/ziK3mhlcsEej9pWFUD6n8gt8VKZH9lq63wQ0kFJEAS+dIZoDeL5VmQpvWGWajbo6CzmtZNIPQ+31/+yedztakCpiydHKfghPekKyiWpZqN/o09P85O5twL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6191

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of DMTF DSP:0292
Management Control Transport Protocol(MCTP)  over
Platform Communication Channel(PCC)

MCTP devices are specified by entries in DSDT/SDST and
reference channels specified in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/net/mctp/Kconfig    |  12 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 368 ++++++++++++++++++++++++++++++++++++
 3 files changed, 381 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index ce9d2d2ccf3b..16bad87c9a6f 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -42,6 +42,18 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP  PCC transport"
+	select MCTP_FLOWS
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created for each entry int the DST/SDST
+	  that matches the identifier.  The PCC channels are selected from the
+	  corresponding entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index e1cb99ced54a..492a9e47638f 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..7242eedd2759
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp_pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+#include <net/pkt_sched.h>
+
+#define SPDM_VERSION_OFFSET 1
+#define SPDM_REQ_RESP_OFFSET 2
+#define MCTP_PAYLOAD_LENGTH 256
+#define MCTP_CMD_LENGTH 4
+#define MCTP_PCC_VERSION     0x1 /* DSP0253 defines a single version: 1 */
+#define MCTP_SIGNATURE "MCTP"
+#define SIGNATURE_LENGTH 4
+#define MCTP_HEADER_LENGTH 12
+#define MCTP_MIN_MTU 68
+#define PCC_MAGIC 0x50434300
+
+struct mctp_pcc_hdr {
+	u32 signature;
+	u32  flags;
+	u32 length;
+	char mctp_signature[4];
+};
+
+struct mctp_pcc_packet {
+	struct mctp_pcc_hdr pcc_header;
+	union {
+		struct mctp_hdr     mctp_header;
+		unsigned char header_data[sizeof(struct mctp_hdr)];
+	};
+	unsigned char payload[MCTP_PAYLOAD_LENGTH];
+};
+
+struct mctp_pcc_hw_addr {
+	int inbox_index;
+	int outbox_index;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	struct list_head head;
+	/* spinlock to serialize access from netdev to pcc buffer*/
+	spinlock_t lock;
+	struct mctp_dev mdev;
+	struct acpi_device *acpi_device;
+	struct pcc_mbox_chan *in_chan;
+	struct pcc_mbox_chan *out_chan;
+	struct mbox_client outbox_client;
+	struct mbox_client inbox_client;
+	void __iomem *pcc_comm_inbox_addr;
+	void __iomem *pcc_comm_outbox_addr;
+	struct mctp_pcc_hw_addr hw_addr;
+	void (*cleanup_channel)(struct pcc_mbox_chan *in_chan);
+};
+
+static struct list_head mctp_pcc_ndevs;
+
+static struct mctp_pcc_packet *mctp_pcc_extract_data(struct sk_buff *old_skb,
+						     void *buffer, int outbox_index)
+{
+	struct mctp_pcc_packet *mpp;
+
+	mpp = buffer;
+	writel(PCC_MAGIC | outbox_index, &mpp->pcc_header.signature);
+	writel(0x1, &mpp->pcc_header.flags);
+	memcpy_toio(mpp->pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
+	writel(old_skb->len + SIGNATURE_LENGTH,  &mpp->pcc_header.length);
+	memcpy_toio(mpp->header_data,    old_skb->data, old_skb->len);
+	return mpp;
+}
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *)
+{
+	struct sk_buff *skb;
+	struct mctp_pcc_packet *mpp;
+	struct mctp_skb_cb *cb;
+	int data_len;
+	unsigned long buf_ptr_val;
+	struct mctp_pcc_ndev *mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
+	void *skb_buf;
+
+	mpp = (struct mctp_pcc_packet *)mctp_pcc_dev->pcc_comm_inbox_addr;
+	buf_ptr_val = (unsigned long)mpp;
+	data_len = readl(&mpp->pcc_header.length) + MCTP_HEADER_LENGTH;
+	skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
+	if (!skb) {
+		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
+		return;
+	}
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mpp, data_len);
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	skb->dev =  mctp_pcc_dev->mdev.dev;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	unsigned char *buffer;
+	struct mctp_pcc_ndev *mpnd;
+	struct mctp_pcc_packet  *mpp;
+	unsigned long flags;
+	int rc;
+
+	netif_stop_queue(ndev);
+	ndev->stats.tx_bytes += skb->len;
+	mpnd = (struct mctp_pcc_ndev *)netdev_priv(ndev);
+	spin_lock_irqsave(&mpnd->lock, flags);
+	buffer =  mpnd->pcc_comm_outbox_addr;
+	mpp = mctp_pcc_extract_data(skb, mpnd->pcc_comm_outbox_addr, mpnd->hw_addr.outbox_index);
+	rc = mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan, mpp);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_consume_skb_any(skb);
+	netif_start_queue(ndev);
+	if (!rc)
+		return NETDEV_TX_OK;
+	return NETDEV_TX_BUSY;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+	.ndo_uninit = NULL
+};
+
+static void  mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->addr_len = sizeof(struct mctp_pcc_hw_addr);
+	ndev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+}
+
+static int create_mctp_pcc_netdev(struct acpi_device *acpi_dev,
+				  struct device *dev, int inbox_index,
+				  int outbox_index)
+{
+	int rc;
+	int mctp_pcc_mtu;
+	char name[32];
+	struct net_device *ndev;
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct mctp_pcc_hw_addr physical_link_addr;
+
+	snprintf(name, sizeof(name), "mctpipcc%x", inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM, mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+	mctp_pcc_dev = (struct mctp_pcc_ndev *)netdev_priv(ndev);
+	INIT_LIST_HEAD(&mctp_pcc_dev->head);
+	spin_lock_init(&mctp_pcc_dev->lock);
+
+	mctp_pcc_dev->outbox_client.tx_prepare = NULL;
+	mctp_pcc_dev->outbox_client.tx_done = NULL;
+	mctp_pcc_dev->hw_addr.inbox_index = inbox_index;
+	mctp_pcc_dev->hw_addr.outbox_index = outbox_index;
+	mctp_pcc_dev->inbox_client.rx_callback = mctp_pcc_client_rx_callback;
+	mctp_pcc_dev->cleanup_channel = pcc_mbox_free_channel;
+	mctp_pcc_dev->out_chan =
+		pcc_mbox_request_channel(&mctp_pcc_dev->outbox_client,
+					 outbox_index);
+	if (IS_ERR(mctp_pcc_dev->out_chan)) {
+		rc = PTR_ERR(mctp_pcc_dev->out_chan);
+		goto free_netdev;
+	}
+	mctp_pcc_dev->in_chan =
+		pcc_mbox_request_channel(&mctp_pcc_dev->inbox_client,
+					 inbox_index);
+	if (IS_ERR(mctp_pcc_dev->in_chan)) {
+		rc = PTR_ERR(mctp_pcc_dev->in_chan);
+		goto cleanup_out_channel;
+	}
+	mctp_pcc_dev->pcc_comm_inbox_addr =
+		devm_ioremap(dev, mctp_pcc_dev->in_chan->shmem_base_addr,
+			     mctp_pcc_dev->in_chan->shmem_size);
+	if (!mctp_pcc_dev->pcc_comm_inbox_addr) {
+		rc = -EINVAL;
+		goto cleanup_in_channel;
+	}
+	mctp_pcc_dev->pcc_comm_outbox_addr =
+		devm_ioremap(dev, mctp_pcc_dev->out_chan->shmem_base_addr,
+			     mctp_pcc_dev->out_chan->shmem_size);
+	if (!mctp_pcc_dev->pcc_comm_outbox_addr) {
+		rc = -EINVAL;
+		goto cleanup_in_channel;
+	}
+	mctp_pcc_dev->acpi_device = acpi_dev;
+	mctp_pcc_dev->inbox_client.dev = dev;
+	mctp_pcc_dev->outbox_client.dev = dev;
+	mctp_pcc_dev->mdev.dev = ndev;
+
+/* There is no clean way to pass the MTU to the callback function
+ * used for registration, so set the values ahead of time.
+ */
+	mctp_pcc_mtu = mctp_pcc_dev->out_chan->shmem_size -
+		sizeof(struct mctp_pcc_hdr);
+	ndev->mtu = mctp_pcc_mtu;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	physical_link_addr.inbox_index =
+		htonl(mctp_pcc_dev->hw_addr.inbox_index);
+	physical_link_addr.outbox_index =
+		htonl(mctp_pcc_dev->hw_addr.outbox_index);
+	dev_addr_set(ndev, (const u8 *)&physical_link_addr);
+	rc = register_netdev(ndev);
+	if (rc)
+		goto cleanup_in_channel;
+	list_add_tail(&mctp_pcc_dev->head, &mctp_pcc_ndevs);
+	return 0;
+cleanup_in_channel:
+	mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
+cleanup_out_channel:
+	mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
+free_netdev:
+	unregister_netdev(ndev);
+	free_netdev(ndev);
+	return rc;
+}
+
+struct lookup_context {
+	int index;
+	int inbox_index;
+	int outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares, void *context)
+{
+	struct acpi_resource_address32 *addr;
+	struct lookup_context *luc = context;
+
+	switch (ares->type) {
+	case 0x0c:
+	case 0x0a:
+		break;
+	default:
+		return AE_OK;
+	}
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *adev)
+{
+	int inbox_index;
+	int outbox_index;
+	acpi_handle dev_handle;
+	acpi_status status;
+	struct lookup_context context = {0, 0, 0};
+
+	dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
+	dev_handle = acpi_device_handle(adev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices, &context);
+	if (ACPI_SUCCESS(status)) {
+		inbox_index = context.inbox_index;
+		outbox_index = context.outbox_index;
+		return create_mctp_pcc_netdev(adev, &adev->dev, inbox_index, outbox_index);
+	}
+	dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
+	return -EINVAL;
+};
+
+/* pass in adev=NULL to remove all devices
+ */
+static void mctp_pcc_driver_remove(struct acpi_device *adev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_dev = NULL;
+	struct list_head *ptr;
+	struct list_head *tmp;
+
+	list_for_each_safe(ptr, tmp, &mctp_pcc_ndevs) {
+		mctp_pcc_dev = list_entry(ptr, struct mctp_pcc_ndev, head);
+		if (!adev || mctp_pcc_dev->acpi_device == adev) {
+			struct net_device *ndev;
+
+			mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
+			mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
+			ndev = mctp_pcc_dev->mdev.dev;
+			if (ndev)
+				mctp_unregister_netdev(ndev);
+			list_del(ptr);
+			if (adev)
+				break;
+		}
+	}
+};
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001", 0},
+	{ "", 0},
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+		.remove = mctp_pcc_driver_remove,
+		.notify = NULL,
+	},
+	.owner = THIS_MODULE,
+
+};
+
+static int __init mctp_pcc_mod_init(void)
+{
+	int rc;
+
+	pr_info("initializing MCTP over PCC\n");
+	INIT_LIST_HEAD(&mctp_pcc_ndevs);
+	rc = acpi_bus_register_driver(&mctp_pcc_driver);
+	if (rc < 0)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
+	return rc;
+}
+
+static __exit void mctp_pcc_mod_exit(void)
+{
+	pr_info("Removing MCTP over PCC transport driver\n");
+	mctp_pcc_driver_remove(NULL);
+	acpi_bus_unregister_driver(&mctp_pcc_driver);
+}
+
+module_init(mctp_pcc_mod_init);
+module_exit(mctp_pcc_mod_exit);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.34.1


