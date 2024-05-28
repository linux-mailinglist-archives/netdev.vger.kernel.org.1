Return-Path: <netdev+bounces-98753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A79A78D2488
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1921EB27C5D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0917836D;
	Tue, 28 May 2024 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SGEKDYGm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2103.outbound.protection.outlook.com [40.107.223.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39CB17836C;
	Tue, 28 May 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923923; cv=fail; b=Sc/IaT3SaBG3udmtDhNlo5pawZPG5b0sBPq51FQY5GjZ1OsYzg+N/lNbBdBJhdoRsZzqDPIWy8yTomgwM8n3tqFHbebZn0sawV8Pq4M17viTifZuBQo7eMb9GvZmfnd0zsLEwKxN5wVG+xaiENZjLeZyeI6nMjkUvwbrwz6Jxts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923923; c=relaxed/simple;
	bh=WTj/g6dlnqrYkTeb2uct6w7zwReJNVkSTiVF5NbkY6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dpCTl1Txhx9eHNxOF6S1kT4Yrbr6fPRCyXC4rKjqsXfDZx6Q1l0hu8cV1imVUgU21Ls+dwAVeH6az1PQ6YcxLIccJ3aQMtTX42woXELnE1KQ2e5JwavKclY+Kysvv7sJA0zsYmiuoht/XdgJMJLaEOhzggMGVBDUaf6FJosSDJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=SGEKDYGm; arc=fail smtp.client-ip=40.107.223.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiTVo+Ux8EsaBVykQOHod38KIHB1qIw97Obs8Mf9ug9fj/G8TMDFNNsD1MNxVb77QGgNzJnFvZqZBGPDYXQo+JAhAflg2LkCHS87DhQ64N/VW+Up5pletQqGBrSrRU9PTky7NHgYgtCcfVRpiVKM95FR9Gs3R7kfMTknguaPJZMU0jbDXqT4XNg0/7xn898W8imORXswmQPBdLnO0jGhU6fOjk1L7jIjycEVouYectrDRzoLOmhcQgNkkStW04m7vPf/1JXwElkCaVC7Srt7UbhUYyaYT0GDpJ9eo0bCjIfWwnXxVQdouwfWR3tIzkk/r83+sH4/ugvn436YavBImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dWv2wfVlaq1CYsfunQM+yTD/9mAA69XoFmv5PqgNOU=;
 b=F2nt4Izkt6S7BHw2iwngG/1JdzqAnSSGfjsx/nvWveQbtttYVPQfeMbJtwSSs5z04qu7WxNQozyz4OkWKZMP7q0bmbiKeRENfFA5ixLbSeoLPu7Y7l/1d4enDEBk+nHDLZQ7gUvSq3eNlZH1ryDLhXxuJJxNgKG/pDWCxOjjXDAiQ0tnq8mN7Bum5vAvwfS8GhSHXDq/mjQuihuX0HuOCzDjQQ2J3m0y8ni9PurIQ3v94OcjuTh4TfzChqgMEdfqA/BxoiPaVha1UAFWtxvvgje8SBioOCWWKUBbO8EyB48ovnytix2jtg1f3LzR26rlZBPZdrbpij6V0EqYqof/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dWv2wfVlaq1CYsfunQM+yTD/9mAA69XoFmv5PqgNOU=;
 b=SGEKDYGmDYKER5B3ZNL8j1OB2N0DAjwS1G+GpkpqGRhQ3FD7jJ4M9Jd+gD8lB1UmUe1aPo+y7PcBqZsDxhVDXKgG5thBwqYn5kzruV/Zaq6JGsb/QxeIKkZb/FLBYS1X3q8YTPnZDuP1dBHlsa0Hmku4LISB2g7oF0Vz77B2Rq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ2PR01MB8403.prod.exchangelabs.com (2603:10b6:a03:547::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Tue, 28 May 2024 19:18:39 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:18:39 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 28 May 2024 15:18:23 -0400
Message-Id: <20240528191823.17775-4-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528191823.17775-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ2PR01MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba353c6-46c7-4f34-2ecc-08dc7f4afaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|52116005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7X3MtPzszpvg64U4YarQn504TvYL2PB1FCzbls7MFk4QcJNcOVVuYiSiAecY?=
 =?us-ascii?Q?KUgtth36JB9nhTrjPePR28FYrRlSwPMM09WkXdfDEcmaTmw5xEnMrTb33EkT?=
 =?us-ascii?Q?SfjxgUBIIw852/RgeY/rkiRJ3e2Tv/iFYCno0Vb0mbeIojmzW+o5Ss/awXhn?=
 =?us-ascii?Q?YZNPoqmWBUxQPMx3javzGymR6sx6/L04H53QHeW0n5zY0U1XoIvpvyS+4s1b?=
 =?us-ascii?Q?6M6vPrBfblJu64UtKEOENWx9FmtOWzuWP+UAw6TfQu+NElwmw/NNgxR/OQnK?=
 =?us-ascii?Q?bvntPNibb2WsHRx9L2hRlJU8Jbyfi5MD9TLPslWACUXY6nRJxOuem8YWVUeS?=
 =?us-ascii?Q?4a7Wc1l/+I5el+G8VrazzOLsCPzS/ZBoOVrtt2ePIWszxLNMin5RclNfRdrc?=
 =?us-ascii?Q?okf/QEUgkGbj5wmZdXomkhGhWDmJ/7mLElPcWTAvfeWo9uqavXtkWGPoD7Y8?=
 =?us-ascii?Q?ilibPtDCb+rZ22P78qFk8Kmk5DvVZX/klNQItyKizNGBVt3cIz2h9FLgN3Ni?=
 =?us-ascii?Q?OW8rrgq9DcrISh3fqy80Ajz2Vx+rzihTQhLUZLIwJvNxz1QlsbiMwFb4lwlX?=
 =?us-ascii?Q?O4dOel6fzYZYU73IQRIjF07xmY/puPqOlQXmz0SnC9TeEomjhQhWNkPi6l/1?=
 =?us-ascii?Q?2Z1+8qCz7gNp24WcxfAh7aED6Dv1xiTdcKBeA1TtF/eu8/EjlFUVQe3AdKPO?=
 =?us-ascii?Q?09nfpG59J4E5CSQNs+W6BLyPmn7Mwc1MyuhwgobGQAzxl4EW6UQ3tgGpGppq?=
 =?us-ascii?Q?L8vBoZnjBmSmhBe0OAvKFUv4SjaZdZdy0yCSG5XIMfNKMWksqlQvOekbV62E?=
 =?us-ascii?Q?I7I3aYRvgehP0t3cUCa0gEkek4ejS35kxRo4xXnM8rxCZk+h6ipSOqdaHL2G?=
 =?us-ascii?Q?Ih68z6BpytWam/RWiizLPsKe9BvZORaIJfEhQtfpyXgEs41XQOWyItx1iheh?=
 =?us-ascii?Q?YhVxv3L65D7/B69hh0P5FnekiFGG0ryGlPKjWexJjHyNLM8AEqyEcYnXFzCD?=
 =?us-ascii?Q?bXHi2TNWUd3QN07QhKgSEZdREC8JXCxjNim/1Mv5eaBa9EnmHwIV3/1MLtYw?=
 =?us-ascii?Q?ypt5Hi6aS8FXuIEPyuf4q5YIyxqMvX4jJYFIUP1pzY/qioJ59ySuUmxgf3mY?=
 =?us-ascii?Q?xEmZkb75Jx4ctNNdwnYpNeoYalY2CjT9rgZOqPf5fTKSBI2Yu37rXQd5CuTN?=
 =?us-ascii?Q?PFhZpNXvxq1gSkH52ZMp0YTHdwAM2eHyyIB75mLWbJ1ueSF6D50Eu6yH6ZQ4?=
 =?us-ascii?Q?9h0Pt3V48eFQpj42+ugREX6ESrDC2wXa8LytUpjW/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSMc0gKK1R6rShV0UTxtKq3oruP+cHV93WAwnBnr9/cenYpbeR5sEIsyET08?=
 =?us-ascii?Q?yUKM0ZwgPD9Kgad85BbFVvBSOTEHASyJmn1Ia5EZHhW9OsNUFl5qyR0Qd/NV?=
 =?us-ascii?Q?X+pCz0+hKQU7MQwXydLHkV+apARhUgR5Ax8O61zyuK/APrIG8BVqAYo7Bc9b?=
 =?us-ascii?Q?DdRItVvLjR2CU6j8NK2Y9GKun5cKe6RM88d2f6wyB8PjqUI7vcFT2l9mrydC?=
 =?us-ascii?Q?n2iaaNK1r5pPzaHqRvp2PXCe15CWuTeoWP0TMec1yg7nKytsYn9z1RUFsOuE?=
 =?us-ascii?Q?Cqb3Caf/GZxeKkZhgIMxnTI8HS59UGPwzcEaCBH7CoBzxX7o5EzMiou7abCw?=
 =?us-ascii?Q?w7wxscBqvk2qiyR/9C880fB+bIYGfEnloog6i4OqnGmOb8xR1o34DFR2p1dt?=
 =?us-ascii?Q?MA1NlTuBxHj8UWBBgp3pN8JeCdjYpB4dfO07W6HUVxVzf5SRjaUcOoV5/e/S?=
 =?us-ascii?Q?22zNB3Avs7tzLhvvRcyD0iVukbbxNf3a7SS5hISmkj01LL1LeLoLaor/41bE?=
 =?us-ascii?Q?l6FGAswROkXV4+8pFWtQJLWrL1rOWkvJ7Pn4In0dp0dMHzZcwkefgX19RvDc?=
 =?us-ascii?Q?lk7WFettQ/e+55kJwftshEHNfF3Tfgtkb05G9UmsM2/IoEsShwMeDz1di09J?=
 =?us-ascii?Q?JBHmLJ9hgll2UbNjwHv97AGzY2V7s4XnRsqzsWbc4FJpz859qd+zJeIAyQZP?=
 =?us-ascii?Q?HzXNMyG4pWqzEReh/58R1OVODRzWUiU3luMQSVV0ggo2Ge1OqguIBnnYmozK?=
 =?us-ascii?Q?HJpJP19PFpxkxmzkVCX9K2pSKm9pQO7IXwEF5McH5NIWZUhe9NiMCG4l4rCE?=
 =?us-ascii?Q?QvvQZmiPMFPgCc5hPSlg0MkOw7rnJdwIToD30/Hb3Yo1hXJnPkSZt6hK9Q20?=
 =?us-ascii?Q?HbuxwTcSXzYztwJulr1lbnn7LYp1M2CJLBWA/b3iJbK19tGZ9lrSIOmI71Vi?=
 =?us-ascii?Q?mK6Shc2v5k/TdwnNDIPi9/YL6NqxYAINI9u4VooaxNx++TRWcAyrRzjRKfmy?=
 =?us-ascii?Q?6T2RWvPP61chgSCJX4liEvGAzapMoZXFy0BYqZXCGV2hjlboHBUOPxUGoIjs?=
 =?us-ascii?Q?thW5TsjLGLZP0TLAVbvu2MkK3NtJB8C4oWpLHa6o5ApZ87x/1xZqGjB7nDeR?=
 =?us-ascii?Q?3Zrrt0i1H3l3NhJHL9+62v9j5OQP8Wph652Km7EFD7AqOlT9I15TWlFpzBCM?=
 =?us-ascii?Q?mbepb8ng40jS1ZD5tEohwhZoIcCuaNeGsbZ5PT+lHxYMzXWwOhmRA6EdHvdZ?=
 =?us-ascii?Q?v8YLDFhxjApVHhS79YBmNWEgKhDji+Rkn8JRuJwbXxfaumprhUQPM1J1IcDs?=
 =?us-ascii?Q?YNcU47gK0WHgzSfBe5cJ2siR3tAyofzXuN33htPbliyj0PIEWTdHMRhD38LE?=
 =?us-ascii?Q?7IiTRO4pbecLsHWjChDTPZYoZ/SlzZU+PdYVeXSGZK6jr9fXTzN2Zp1RhB+H?=
 =?us-ascii?Q?TT1VzZswqburO2os2sP3l8EH9y4+QhDMSPdm1PD5uVQOIGkPat7QedZAGATm?=
 =?us-ascii?Q?G6H8hJmbEoK+rH98X1S+Q4r57CIhPNbTBWdA5ZhjOC32gHyBiXyPyHwpwzjG?=
 =?us-ascii?Q?np1OLahpm37Cf6L9YzxKWlECJIY9vY8ogPwGxIZ++wUlvIbuQbW4EI2tETPS?=
 =?us-ascii?Q?mfNh7RzvyEq6WArtJTZh4ug+ZUbys2XFGeSKoe9rthS2sdQmpDA/LkswKIVl?=
 =?us-ascii?Q?P/NPYPvjMgd9rfRPdoOrtebkiGE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba353c6-46c7-4f34-2ecc-08dc7f4afaaf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:18:39.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQV0iR+/hyIFMsc0WsVOX5T30qB51uawrji81xnFZj/HbIsHz54lubJsLexPUyd+66PMgQjbN15Wn+vyAPhcdyBW7JV1QZ9jW0DGhWztXmijh30eyzy1XiYdjs2wb5ro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8403

From: Adam Young <admiyo@amperecomputing.com>

Implementation of DMTF DSP:0292
Management Control Transport Protocol(MCTP)  over
Platform Communication Channel(PCC)

MCTP devices are specified by entries in DSDT/SDST and
reference channels specified in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.
---
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 361 ++++++++++++++++++++++++++++++++++++
 3 files changed, 375 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index ce9d2d2ccf3b..ff4effd8e99c 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -42,6 +42,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP  PCC transport"
+	select ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  commuinucation channels are selected from the corresponding
+	  entries in the PCCT.
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
index 000000000000..d97f40789fd8
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
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
+#define PCC_DWORD_TYPE 0x0c
+
+struct mctp_pcc_hdr {
+	u32 signature;
+	u32 flags;
+	u32 length;
+	char mctp_signature[4];
+};
+
+struct mctp_pcc_hw_addr {
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	struct list_head next;
+	/* spinlock to serialize access to pcc buffer and registers*/
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
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	u32 length_offset;
+	u32 flags_offset;
+	void *skb_buf;
+	u32 data_len;
+	u32 flags;
+
+	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
+	length_offset = offsetof(struct mctp_pcc_hdr, length);
+	data_len = readl(mctp_pcc_dev->pcc_comm_inbox_addr + length_offset) +
+		   MCTP_HEADER_LENGTH;
+
+	skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
+	if (!skb) {
+		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
+		return;
+	}
+	mctp_pcc_dev->mdev.dev->stats.rx_packets++;
+	mctp_pcc_dev->mdev.dev->stats.rx_bytes += data_len;
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mctp_pcc_dev->pcc_comm_inbox_addr, data_len);
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	skb->dev =  mctp_pcc_dev->mdev.dev;
+	netif_rx(skb);
+
+	flags_offset = offsetof(struct mctp_pcc_hdr, flags);
+	flags = readl(mctp_pcc_dev->pcc_comm_inbox_addr + flags_offset);
+	mctp_pcc_dev->in_chan->ack_rx = (flags & 1) > 0;
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_hdr pcc_header;
+	struct mctp_pcc_ndev *mpnd;
+	void __iomem *buffer;
+	unsigned long flags;
+	int rc;
+
+	netif_stop_queue(ndev);
+	ndev->stats.tx_bytes += skb->len;
+	ndev->stats.tx_packets++;
+	mpnd = (struct mctp_pcc_ndev *)netdev_priv(ndev);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	buffer = mpnd->pcc_comm_outbox_addr;
+	pcc_header.signature = PCC_MAGIC;
+	pcc_header.flags = 0x1;
+	memcpy(pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
+	pcc_header.length = skb->len + SIGNATURE_LENGTH;
+	memcpy_toio(buffer, &pcc_header, sizeof(struct mctp_pcc_hdr));
+	memcpy_toio(buffer + sizeof(struct mctp_pcc_hdr), skb->data, skb->len);
+	rc = mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan,
+							 NULL);
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
+	ndev->addr_len = 0;
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
+	struct mctp_pcc_ndev *mctp_pcc_dev;
+	struct net_device *ndev;
+	int mctp_pcc_mtu;
+	char name[32];
+	int rc;
+
+	snprintf(name, sizeof(name), "mctpipcc%d", inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+	mctp_pcc_dev = (struct mctp_pcc_ndev *)netdev_priv(ndev);
+	INIT_LIST_HEAD(&mctp_pcc_dev->next);
+	spin_lock_init(&mctp_pcc_dev->lock);
+
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
+	rc = register_netdev(ndev);
+	if (rc)
+		goto cleanup_in_channel;
+	list_add_tail(&mctp_pcc_dev->next, &mctp_pcc_ndevs);
+	return 0;
+
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
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct acpi_resource_address32 *addr;
+	struct lookup_context *luc = context;
+
+	switch (ares->type) {
+	case PCC_DWORD_TYPE:
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
+	int outbox_index;
+	int inbox_index;
+	acpi_handle dev_handle;
+	acpi_status status;
+	struct lookup_context context = {0, 0, 0};
+
+	dev_dbg(&adev->dev, "Adding mctp_pcc device for HID  %s\n",
+		acpi_device_hid(adev));
+	dev_handle = acpi_device_handle(adev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
+		return -EINVAL;
+	}
+	inbox_index = context.inbox_index;
+	outbox_index = context.outbox_index;
+	return create_mctp_pcc_netdev(adev, &adev->dev, inbox_index,
+				      outbox_index);
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
+		struct net_device *ndev;
+
+		mctp_pcc_dev = list_entry(ptr, struct mctp_pcc_ndev, next);
+		if (adev && mctp_pcc_dev->acpi_device == adev)
+			continue;
+
+		mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
+		mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
+		ndev = mctp_pcc_dev->mdev.dev;
+		if (ndev)
+			mctp_unregister_netdev(ndev);
+		list_del(ptr);
+		if (adev)
+			break;
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
+	pr_debug("Initializing MCTP over PCC transport driver\n");
+	INIT_LIST_HEAD(&mctp_pcc_ndevs);
+	rc = acpi_bus_register_driver(&mctp_pcc_driver);
+	if (rc < 0)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
+	return rc;
+}
+
+static __exit void mctp_pcc_mod_exit(void)
+{
+	pr_debug("Removing MCTP over PCC transport driver\n");
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


