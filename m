Return-Path: <netdev+bounces-108621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A904924BEE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 00:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D35D1C2258E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 22:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1217A59B;
	Tue,  2 Jul 2024 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="M7cto0CD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2117.outbound.protection.outlook.com [40.107.102.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C16156F46;
	Tue,  2 Jul 2024 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961140; cv=fail; b=Zq2c541XWVc8wfm6NJdKjZxsG07rd/ZqenVJ95ANX0YGtE7HZvDFJ4SZSGQR1KwXZv0G9xgxajPXI/ik/Mfb+UgdX6Ger7nIROgOYDPhNjcMTw3O7vLACQHUBiPkgbNHacAnviHAQkCOKyYn8RJRED67X5tiiMmsQwPxvkc/rig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961140; c=relaxed/simple;
	bh=t8cwQiGlu3LV7udPIIEYwmA5Bih0MHXeTzPiFdLrKaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fznCK5SFkVTA20r3b5+f54EIJIe1xotJ+dv2iPT1vwhHcczQxaPU9iK1Av38oVtPxe7KtHoQnvrUvrXKo/LK4PfbYetLYgKCettodH/FR4dtFfPi/9qaqzSySOtVyTGxTe9Q7fxM/oLjmpottc/eioKBXQTr7L5tw6o+G9yo1tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=M7cto0CD; arc=fail smtp.client-ip=40.107.102.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8zyle1ZHp6zym4uPWS1cesvOSmFnRSVjZfDaRyBJzukfUg9V102pSz7vQ0+2e+SScn6dA7/lvXNHwD1xq61t2FsAv2mrxgmK3Fff4WLxltOC+CEkrK5w6SQQhVUXHsZeNaQEhKX6V3+x9G+l1/IFPg56KEYtLwzwfKaE7D2NP70wO13SHSWVAf2c6+KaveMEP6XrassAbJZ0DjkKqoK4i/9k0kHjOnfw7xib48LggvJcU/Fo/C2b96oni5kqJU6cAjuvkDn3dmR7zFUJSvoZpjiClwloQsAakbAgP48vRXVsWIYkTSagNkOLDiXa+Cazm8SklXnzEw9UD+Elizzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maZd4uPe+FGvO0CYNqqAqiANTFso0QKd0yJj6CXMSyE=;
 b=VEvvdyPEFwuwiJmnrUb1gFuRxQcuQLSasS2E1h3qqaXwjhhi+O5YtSaBBl5p9/WiRU4sQvRfM3p/oY38iQHxA1yzXrDp5nSKZN8kEdeZG8g98DnKEfIsTL88IkWtS6Jx9m5v3so1i8G4vIJbu+AX8zFE4GPw7ecXJ4z4uNKrffRNEhR+dE1xrEc+fMbmQ5V7zyNK+lBBxB6XWkiYYVb1CMBMzeWl9pvq0/uHL8/I0tK6fWo04mdGz80NFPmY5HDwoPfowG2gus9KS9N/3d1I6qs93nwx2uXLkJ87sD0rK02BUeOIebQcC2pRSibvAP63VV/pwa/u1yPam74nJF7oyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maZd4uPe+FGvO0CYNqqAqiANTFso0QKd0yJj6CXMSyE=;
 b=M7cto0CD3zFJjk5dTqIuXh18J2LeDdWcs5f6PtuO4vpnxM6ZGR3NOWp+BhKmb+OwdmSpmpEVnbFiC66aEoT3b9QAIMx2bKCk8cPsjCwDGtcLiaMSRnLlX2Dq+ilbYFk/eS3FuXj4gurgQSwrXt+P9YDGw/vc4pou3+JvsnUirwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Tue, 2 Jul 2024 22:58:57 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 22:58:57 +0000
From: admiyo@os.amperecomputing.com
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v4 1/3] mctp pcc: Check before sending MCTP PCC response ACK
Date: Tue,  2 Jul 2024 18:58:43 -0400
Message-Id: <20240702225845.322234-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
References: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::11) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a01eff5-13e9-4025-76f5-08dc9aea8d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yYcGoyRUEXnrvRRJPY7gQUEXqB0PNhs+Kimy0riwhzCoTGoYoZosIeBan+oh?=
 =?us-ascii?Q?Qcp8oFuuIoQHWtkpED+4qO5Nq9i9ip/d4zRa25Jr7vyNpy2GvaGIqNYrEZBL?=
 =?us-ascii?Q?4v583lY9kcQUM4QdAFWCg5nQeoGUgpXd+RAvR/FG1AomRo6HrsJew5UAeZXV?=
 =?us-ascii?Q?ZQIKijr/70cX9beci0KZM3XgoBCnqBRE+IFrHvvMBv+r0VLq9Zy1OAKjn7Vx?=
 =?us-ascii?Q?u1/oY6j2IQLlEDfyaJagOcMIy7qsFq9w+bYEZKFvDMVmpp3r0rtnwiW3BeS+?=
 =?us-ascii?Q?TZsp8eVczmOG6+4KvSV1hapYU37pRg731X5StPTQGI1zX5aSFyw72K//KYkB?=
 =?us-ascii?Q?lnzPocbYRpB/1rkG0+9hJSp5DKAKpbekWLB/sF3AllHigNj2nL+p5LUiQYfB?=
 =?us-ascii?Q?7SuudTo5jhM3DPz+1CV2T0K7Cjrsi+/rLx4VElJU+zoNe5ouFykkoVS74xGm?=
 =?us-ascii?Q?nxwyrD3NDt4I4KuBA7paHtszkZJGBcu81BRmwrlNRUSjpb6FtrFGTzK3tzyu?=
 =?us-ascii?Q?mpDHWOvC6USZCc1dBIeeaqRHPozj9jyIL1zsSmGJeIabSaw5LcJThlKJ/Uav?=
 =?us-ascii?Q?2V5px/Nu2+jzEU1RUrLGTSBj0xCUQt92gb8IXd/RdzjJ8ZavLMwif6VWAvd3?=
 =?us-ascii?Q?W9wmhxvnX7P9AZsOpdHLvQaY5adW3u2mZOvj0DR2fGb3DcBMzviMo+W81q8d?=
 =?us-ascii?Q?7VtBRZr8M6NHgaSCxAnpyl2qf/xmGcwr6bdKFkwzuhzW0WUhLwh1KtqAz/ZD?=
 =?us-ascii?Q?8bO0MWKyiGGDqg4bl8lZC0nsODaSO7VFJK28nfdzaI8QlDUCJHFnRKjpjA0X?=
 =?us-ascii?Q?ZfYzELFuXoPuDJ+E+nmckgoCUZUGtj3lzo3MDnwndXz2LtocbMFpiiEGNPYt?=
 =?us-ascii?Q?bT41cOlSOQGdv8c+uTSs/SSsK5uCH3g+6A1Uu9zv+Nz2PGbKyNgpMg9UQBAG?=
 =?us-ascii?Q?woLyMeSCRoLqj2EM5udXfel0e5wOgclER1oAslPnaNrkvYWO6x+ZV6s/WHJs?=
 =?us-ascii?Q?GapVJQ9rqZQMfqQsBfI1YR8I/FK2ZZxfYXMzmvsGPI7LHu0rkzAGCD91Cs1n?=
 =?us-ascii?Q?anABoudUhjBXI7nxIEx/DmN5hkZP0xEc4LRJ0rU9hatGG6flAo6jNL3PHHpI?=
 =?us-ascii?Q?rs/up32QryC/20vfoW8ek9ZZZeM+ppPvOd/SVilUDnD8yQ2vCL1EqBqp2OK7?=
 =?us-ascii?Q?ULzg4fRbEdj9wh9xLBo1C4CkeZXDwnhu6Nlgcrz9SCuYGxCtaAxieIk5zI3N?=
 =?us-ascii?Q?yqArK7T3g+2LDmc+g2oQ87foktbVkyLDaom4fn6qUsF8Wc3oy6Wf4tUHNPiD?=
 =?us-ascii?Q?X2TZHF4T0bskHsw8XitstgD8NS4ZiDaCkcNW0NdyidjwGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GrQ3rFEo/Bv3p5Ss5aB+D/U2ZaGQjZa4yyWIvQh2X5YyERyQvAGDv/Wgrxpt?=
 =?us-ascii?Q?dGZ0rGestoTjg4RCpe0ohvkUq9SeB3TYJuZJdRzdk5D4whibsMPceuo0tYLq?=
 =?us-ascii?Q?UHt7XOfpdE5q2UX8+HUoOjWi4e+8kU1vO+HXa/OcpDPYfN9Sjii4IQTl4ryl?=
 =?us-ascii?Q?kDoxA+EhfplsN/8Brmwd/cSOPG4PFia1BEe2CiG45GyuVnxtYKmvGpNwFRZS?=
 =?us-ascii?Q?C+IegRuSFm8ob8+D+lFKJ1LPg1DIv+s+58fG16LsTUmnqx0cDRz3zyjczdnY?=
 =?us-ascii?Q?E1sza5CERhFSkKZ0Zwfun2BGi7iLlu/D+BIfhKJ6+NHQRdzHH0n7UqVIDGy0?=
 =?us-ascii?Q?A16/LrZ2BqXy0vCSUzblluQMNAPUg/gTAm9Lc87llkislgSvzNK1eNsvDy1V?=
 =?us-ascii?Q?zC+uBF4rbWXg76M9oHbXVpsHVg7noa90iSBmky9omLy7Qm8bPVQoznu7EHxQ?=
 =?us-ascii?Q?FERqsyq0XCG84/p9JICcvgKfGUKy7p3gAyqRrtFJ6KPdvZ1tnrcAtD3jsS/u?=
 =?us-ascii?Q?BVLsJl41XJ8dfaUANKIyrFPlCOV5Gp/3KTg+7UDcBKa0arOJug/DkEJcbosB?=
 =?us-ascii?Q?yYPDyCUQk5WDnbW9iEiynUOb/wcgVQhmCETjvVhuMlRURNDakceohZGmSU0g?=
 =?us-ascii?Q?KpQYWCtuDTWE0ZG12Ky4tpO3Pg6XgEv+bBaVYbSxxJBxUnVtrFM6CDGkxped?=
 =?us-ascii?Q?d1ISQTSPVrseHhs/PbVnUWk/KwvhElJBqgl3HNgwzMOI9OqD3kNOkZH6U3A9?=
 =?us-ascii?Q?+cCMVGIKuF8Asfk1vMlWlpczFEb5nzbng6jObNRZHcMmKvj5fGoxU7OY+lET?=
 =?us-ascii?Q?5QYiiuH/cXvmGN+/VZlAlhsauvX1EAcfTmix/etG+n7Vncn5x2xcfGqls5Q0?=
 =?us-ascii?Q?u3YsPLmaYkc+GSAS9odZ4D24n7gCndurP/rmQW/UcS6+Ejkb2vKlJ1mD58rG?=
 =?us-ascii?Q?28kyDGSV7vjsiMuVmJlJeMG/Esj5HSIHLynogewWT24Pv01Bp43TwwnUaOs0?=
 =?us-ascii?Q?FrKBM9qJ8hyJb2diXflTT0oLWWsXJamHBETxjKlp7diaVYXWzhDMtolcTkuH?=
 =?us-ascii?Q?TERx8QLOSf2EFJh5AjA+sq8C5Z6nJ3rVFWkR0c8Pgj5xDpQQCoP97snJwXCe?=
 =?us-ascii?Q?odAeviLsVwVPaNPXsed3tGQVtclrRLZ4u0bS7LZayq+/3V1C4WVHgFLQ5iD9?=
 =?us-ascii?Q?T7ZTctzYFubl4RtO9mXt8pZiz3+505pUCI9VyTYCD4wsDdzZejx5MXrVTUG5?=
 =?us-ascii?Q?FPbroshYictjdjgLeQmNsWab6dGDJxmdNY3MUpJal/a+CBAGPnjjzykbj2CX?=
 =?us-ascii?Q?K4VXBM4+pM7Mr3Irv8GGDD4+eIAzQUqPMCyzQSTUJQj73sc7aIduUUvPgjLW?=
 =?us-ascii?Q?U5mp6lf59IujxgeuhxPi9c4DS6cBUqAcGSlczI969F0Td5AFZuOTuTDU/8V5?=
 =?us-ascii?Q?DHbVN8IKgQlYZUVnojmsG/JgRd5ZBf2V3N3VctpLafrvS25OPoJl+7+d9UOL?=
 =?us-ascii?Q?HfKRTzlgqVTQJ7LwaEygPIRS8twONnDjlpyQY4GCKej2Bf5ICDTlqcbLscRa?=
 =?us-ascii?Q?MmLHq2Y3ISwtiuuo56dClVkB/rEkIDyvZNuqrYz6EK1ANUuAQ8L5AZSNgK89?=
 =?us-ascii?Q?YNP9zyTh2JkQL94mDFYpfN5SYePJWxjli6MQQFdQvJj5P7Rm89rhXyJGePuX?=
 =?us-ascii?Q?Au+BjInrBrf62X9Mc9V/k4HU8ao=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a01eff5-13e9-4025-76f5-08dc9aea8d98
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:58:57.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3V8chWT8vm+vnsSDA0YM0+5ddZ7+0ZGGN5AHvlTZVlW/7jKYajkWauASXY4YiBNE9i9YFnlSMJwMZ2hJOS0gc5Mjupl/5NFy0F91aiCnyi5ys+KEhZdsKet2WezfW/Rl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6509

From: Adam Young <admiyo@os.amperecomputing.com>

Type 4 PCC channels have an option to send back a response
to the platform when they are done processing the request.
The flag to indicate whether or not to respond is inside
the message body, and thus is not available to the pcc
mailbox.

In order to read the flag, this patch maps the shared
buffer to virtual memory.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 31 +++++++++++++++++++++++--------
 include/acpi/pcc.h    |  8 ++++++++
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 94885e411085..cad6b5bc4b04 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -107,6 +107,7 @@ struct pcc_chan_info {
 	struct pcc_chan_reg cmd_complete;
 	struct pcc_chan_reg cmd_update;
 	struct pcc_chan_reg error;
+	void __iomem *shmem_base_addr;
 	int plat_irq;
 	u8 type;
 	unsigned int plat_irq_flags;
@@ -269,6 +270,24 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 	return !!val;
 }
 
+static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
+{
+	struct pcc_extended_type_hdr pcc_hdr;
+
+	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		return;
+	memcpy_fromio(&pcc_hdr, pchan->shmem_base_addr,
+		      sizeof(struct pcc_extended_type_hdr));
+	/*
+	 * The PCC slave subspace channel needs to set the command complete bit
+	 * and ring doorbell after processing message.
+	 *
+	 * The PCC master subspace channel clears chan_in_use to free channel.
+	 */
+	if (!!le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
+		pcc_send_data(chan, NULL);
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -306,14 +325,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 
 	mbox_chan_received_data(chan, NULL);
 
-	/*
-	 * The PCC slave subspace channel needs to set the command complete bit
-	 * and ring doorbell after processing message.
-	 *
-	 * The PCC master subspace channel clears chan_in_use to free channel.
-	 */
-	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
-		pcc_send_data(chan, NULL);
+	check_and_ack(pchan, chan);
 	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
@@ -352,6 +364,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	if (rc)
 		return ERR_PTR(rc);
 
+	pchan->shmem_base_addr = devm_ioremap(chan->mbox->dev,
+					      pchan->chan.shmem_base_addr,
+					      pchan->chan.shmem_size);
 	return &pchan->chan;
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 9b373d172a77..6cb21f29d343 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -18,6 +18,13 @@ struct pcc_mbox_chan {
 	u16 min_turnaround_time;
 };
 
+struct pcc_extended_type_hdr {
+	__le32 signature;
+	__le32 flags;
+	__le32 length;
+	char command[4];
+};
+
 /* Generic Communications Channel Shared Memory Region */
 #define PCC_SIGNATURE			0x50434300
 /* Generic Communications Channel Command Field */
@@ -31,6 +38,7 @@ struct pcc_mbox_chan {
 #define PCC_CMD_COMPLETION_NOTIFY	BIT(0)
 
 #define MAX_PCC_SUBSPACES	256
+#define PCC_ACK_FLAG_MASK       0x1
 
 #ifdef CONFIG_PCC
 extern struct pcc_mbox_chan *
-- 
2.34.1


