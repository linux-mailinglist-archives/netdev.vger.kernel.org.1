Return-Path: <netdev+bounces-105028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21190F759
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611E01F2376A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E29E15958E;
	Wed, 19 Jun 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="irXN7m2v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2136.outbound.protection.outlook.com [40.107.92.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C3156F25;
	Wed, 19 Jun 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827567; cv=fail; b=n781yTqIUI3nj25ntuW4mNgGZr9tTrOm3oahZ5B7GkD7t/77OF0HYig50B/WBsmZOdeLgtDj48zY1v64GKSwjK8bL3E6NSkJdOQVE4a2VDwTC+ipjAyro6HrfU6gWbQ1ggghGBuE0h/KN5auJ/tytCFL3J36N9ZqUJ2QIPhzX3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827567; c=relaxed/simple;
	bh=Hmj5Ulvo+nqYAvqEuYtvQDDA0L73DYfZL1cGFTucQ2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ggd5HRFqGlYXL3BVFlIBubvFu66/8wurWiSt4KlfJcP4VH+lCRJPwQK9hozAxLbo7pvdCOMvq4Hy6PdzJwjy6Gg/Jls7rJhzxo9lYK7nTrAi4ZWK4kA21UGQeDSH8TMRwxVQYZm/0+gGTwuZb9qtQJTfstqCThO3fBv5csp5oJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=irXN7m2v; arc=fail smtp.client-ip=40.107.92.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGHKoOrmYdPavcyZfbzI6O3TqAbsNE+8R3avPoNTE11UIFZQnWiqtFHGccalKQUyenEApYfNLQqSccx0vL5lkfVX0mgf0ccskjsN383mS+WztmA+8zPtxm37wd2kp6/fZeG4DlHGD9/DU3RRygAv339AaMsVlCbev/rJlHtbkdcp7d/t2X1sTvNLY8srYbMqPOgD0bH1N4phq+4KrqnwrCSLJa4J+cg0ogAk6nUeW0mvTuzXaPTl6rv8f1ACNAyUVFvzKNBm9cZH7z/bwqKhHkn+lkXlhbPNE62QPH1XbQcWLsR7yu1f+JWLSsQl2ZiKBD5LMLj5qJoCzBbQyJWWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK5zzcguWsiHz4kYsH0I/UsY5WwKBjTtaszm+g/aWwY=;
 b=oGwvzr4PyPEqQAuTNLOcc0RV0qR1q3B+LeFAFcR1U+cHGTwK17YZPnBxLDDJ+dvzBmDxesQdURge8F6Anb/5R6uMwHtBW1rAgHl6aOx3rCTvcCeIZwejwg4CUOsnFz7j34HUJP9y/8RiUIsP2toPuP+eYXPS9xZ25uofGPk7ZJ54KWZpim8HWG5M/oaKglClt9pkn8xw7RrOfhNdfv0oJ6QEUOS1ymg2WAjM4friBffe53OATxOE/zzeScvk5JayXu6bSEO38/2mfwmL2IrszJ4kAw8flc06pbomfbFv3ZNrkPddDSb4Gxwz88hQyNo+o5ykLj4hHd3PZYsrziLVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK5zzcguWsiHz4kYsH0I/UsY5WwKBjTtaszm+g/aWwY=;
 b=irXN7m2vzoyruD7PsSLhQsEraCQHRFX8mU+5HDWJ3DL6JiipsniVVg3sPaatXtAbpDMlgRUmxAFmpp2+2gvNjHiT/0rqfr/wl0KO+dNG2g+7rgNNBNATcU0FPrWOmSGc8/qIcBpeA9zfsVnFVI3KhUY6aYp1wP2jcOy6C4KO6m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BN0PR01MB7086.prod.exchangelabs.com (2603:10b6:408:14a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 20:06:02 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 20:06:02 +0000
From: admiyo@os.amperecomputing.com
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mctp pcc: Check before sending MCTP PCC response ACK
Date: Wed, 19 Jun 2024 16:05:50 -0400
Message-Id: <20240619200552.119080-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619200552.119080-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240619200552.119080-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:334::23) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BN0PR01MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f71535-c779-405e-3244-08dc909b3e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|52116011|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UWqL6FHenvJywJ9gjtRazwsV0UAvzd/cLtWnhYQwio+UZiOVZ01lzOUyWND/?=
 =?us-ascii?Q?yfbikMIRmTPMMur7vmoZKSumUbrVZ6U6oRMsHYsWOSdxiHJ33Vq5fbu12SKs?=
 =?us-ascii?Q?6WxtTvLPuteVs+Mc16Q3GYr8j+U99KV6FqxNMm2+8Hzk+gvu5yZvgRgjdKL/?=
 =?us-ascii?Q?XH7lILvHwBxgsgWnMqjJadboSTivcrdaxegGUj5RN6MXLxQzDyUFa/SO++b0?=
 =?us-ascii?Q?hVoMKLDt7CdxweMDJHztiGrACt3qP6sgmQjRvHMDVjYTNmYOpkWMNr9F5xxZ?=
 =?us-ascii?Q?tpIczuVVGLCt9qSgoeYsJVNPv8OEnSMlRSFsVrEX6PTDllWwbSaJY/SFb6W8?=
 =?us-ascii?Q?XR+oAMAW108s3IE2v3O/R+XB82Frgi6bdaTVvYwwR4VUzWbChiuM3gPonuyP?=
 =?us-ascii?Q?nbkNMvVuqewGRuLQF2RzJqVAE4+nhF7OPFlkpHVUiu623CzrI+TnOot5XKgn?=
 =?us-ascii?Q?lvML2foeAmXVZFuQ8pO2+H0WK600S9h2NhwyWsDz8Wsk+MtZ1Z/KpevzBAvm?=
 =?us-ascii?Q?O6vH4IzbgKKCLIGlqTqfse+buLArWz7VmKH4edketuUOPGBO3kMkx3yqdlNZ?=
 =?us-ascii?Q?FJufLihgXFFxFMxGpcaZiBqk1noJG14jcMfVFrObeSq51YDshYWt4KRkTzaB?=
 =?us-ascii?Q?kXBl82D7La2jJ1SaIWNooUuqlhIwdEAnfDWJw+CsbSEaMqgai9rt19gHUJfr?=
 =?us-ascii?Q?vL1ATf8SF/XPZixNjD3maxImCqz4WFTYVi5DP23CAh4q0abWW28pUqOT4Y04?=
 =?us-ascii?Q?RrfJIW3mVAJ7LrDrQhjNQxuy2VrMidxt8FBYWhUXwAci0wiJNm7ntE547b9a?=
 =?us-ascii?Q?sAuB0fPiynDEsgC17S3AchisDf4Z+mN9LJoCcNud/gmnpUpRWkKftP/P8g2C?=
 =?us-ascii?Q?Nj6VfgAfdNRCIoN3unyune2bUeEgf+fTNBuOOQWyUrIWqe3DTzBF3YwkwgsI?=
 =?us-ascii?Q?71fCX5CDuEpqcnPNmzCTjJQb76YF18aZM5gziayW8STi8Sp2rsIwp4uxAGaP?=
 =?us-ascii?Q?s7SUgrJD++zvTZ6nUKVPfV0YSpnmbzVkX2Bm29Sa8ojBYOjmmvHJBkOOVddM?=
 =?us-ascii?Q?GNS0ZwpyayDdaHKad1UpL0hwr17woXPanjKeGCUUyg+1/cpzI+83wcZwFsZl?=
 =?us-ascii?Q?axEcdDMo0DGHxXCHhqVuVaIBn9BIN5t6Xa8no9WFY6N5SaJr0klJxTifyCwB?=
 =?us-ascii?Q?oF1eJ8VA0fKifIV0M9v/msqWCllZ/3FVkPgTfMu5VMY9/QbQcYzDeL2loeYW?=
 =?us-ascii?Q?kyG+/5BBhpjDqzbQNJ8EDpCniYNIWEghtiuaTooydhHsOaFz9/+r3FSZ0z6I?=
 =?us-ascii?Q?PlujBxZHE38eXaLyCSQoJI6M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KK3tHtam3OO2LksrjsPL2R/717GcPcTI7fZYp+PJiJh7nF5a5JROpAc0zLJh?=
 =?us-ascii?Q?P49PFxf872FOwFH9YK9A4pynHz3ZkCNpabeUytiR0GCXDIlw8HQQFKOfl1yy?=
 =?us-ascii?Q?FAYOejZrABg+BkFJtEPwtLxaYOgvgCebgTMv/Sjr+rnTicOztH3DTFwzL4Cz?=
 =?us-ascii?Q?r0QdfV8EPj1eQXAOhBTyNBlk1lnoqhaesqqoC9QcWvD9XynJk8vkK4ptPTI9?=
 =?us-ascii?Q?EshCslgzykTA/b1U9w89S3UY80qwcy7HKPYSX0iyB8enFpZwa47tS2GnaLZV?=
 =?us-ascii?Q?lPj18lyIIIE8N7RfU5ZT1EWAhRqTt7JznhO3oU9PKv0w6mf0Cn7cSSN6h4wh?=
 =?us-ascii?Q?aP4k+jasajt88cTYLgSNcfHz0GEHdMCRRoyI/QnalvwHcbnns4ACvxAEFC76?=
 =?us-ascii?Q?MSr/eGXPZ0tH/XVk9URMBA68Nhn9KKmTEoFm2hfQcmShdA4o2PcgR3lmgDN0?=
 =?us-ascii?Q?fGLdJaK2sFwzgV68ZUHI3IdI/ML5ImsFM/3iRjLJFzjEGSExMRb+3qDjetiX?=
 =?us-ascii?Q?KrWQxlMMbuPmTxQMoF/+r7z2PugSWA5zvXN90EDXAszWuJAbJSjeG0JA0tt1?=
 =?us-ascii?Q?tp4SZtA070Q0OpRnjeYFbIF/728nQLNSvFAvK3yplOi4tMZfqQXVgJXT06VF?=
 =?us-ascii?Q?Rnv+jF03fbbE3zpdqdWirDuKX/T0DIw6cm00If31DSUrDzwDbnqcKfLMsUub?=
 =?us-ascii?Q?5VMHUl+wi7+yCuLgyZ+0hFAzTCJqC3bAwqVMn3gbZzQCCHnOzHu4F1OqqWze?=
 =?us-ascii?Q?/FZpLUoMQqcvV7D2IUOdP87las4Mc6MG5JAhfyyFPtyAmMqoNggwJwDwYIJC?=
 =?us-ascii?Q?4Mg+lsIC+f5t0Rgd2W5u54W+59C+FKT6z4gsE+xI2s6sWe3yJFFL+OZMzd8e?=
 =?us-ascii?Q?ACtS7KWu+ujVoGjuZc322tyj+a5ljlZEE8AUtGHf2L4UotVR2IZfgqgGXOrO?=
 =?us-ascii?Q?ZhufGuHpLp1I5ES4izFHw19RU90DWCxlm3c0JswYF1zCx3RSjUKFQ89sgvvy?=
 =?us-ascii?Q?6BpJKoQz+sj6RAuN1OnaNsTARhQtw2YNZE9ljluC9cHFxdqaYJAWWIE46IUR?=
 =?us-ascii?Q?fTYTHGs/r1yIcWni0klOuI4Ku/fKwD5eMSB+hAsvUKYwB8TKnJ6uD3ZWjwjV?=
 =?us-ascii?Q?d1aER2q1ivig2jfzaX3Nzlzv8lC84BKEN7b+G52EJPMnsaDHYuO/wL2PqwCV?=
 =?us-ascii?Q?mPlYWtnJ/Zs8f2w1mH9eoA3As75XBPKno+cmj6bNAZ/BLMEq+yMMRE1Ua0fM?=
 =?us-ascii?Q?aMafviVb/Lc3qekMHybaDSwrClMi9ZSnGDRx56kkBTaRwmhIXRfqN3jar9YM?=
 =?us-ascii?Q?keLKJ7MlOUHfwtAxLPV6Z2UzZrDCOyhozftlSKtqsHfhLBOIDdbsJA8kTP5R?=
 =?us-ascii?Q?L7t5SxoC4L+lzFQAv2aCLqeGHW3GadOQUj173oEC8V5TTTreUcqyR4qiTk7/?=
 =?us-ascii?Q?DcaT+YJXHApz5tToI0USFCrF78ZAUScxq+U3fNtK/Iefaqm5KpCa7VCwjQJU?=
 =?us-ascii?Q?CFtDBJUUWf00sZcBDMzaenU7cJJn8xPY2N1de3UdPvOb/JYagTLd+SKeRJ56?=
 =?us-ascii?Q?oEjPqP1jtEvveVb+omnxWRyEUlc/SCWdcUbYasEapsRhGjFHkpZ0xeOLDD4a?=
 =?us-ascii?Q?VuhQ8nLU5flk3J4ttHuNtN8vRniQJZepjn0FmjUjWXY6bKw4Zko6lqan1nqX?=
 =?us-ascii?Q?FW6+2mrxfxP6tu/3U13f+uiYcnM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f71535-c779-405e-3244-08dc909b3e8e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 20:06:02.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZ0WRLZguMoB/1MLnMHPgcabyKoxDx4OdW+VgKy5ixnu0aBY/9Jd/tVZnIxpi37h4jppMYnTDKQA4aY2Jme33P1ucOZJlKqAPGiEXqgKaBOX3uf+N3UaAAfxRYdaYhc2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7086

From: Adam Young <admiyo@amperecomputing.com>

Type 4 PCC channels have an option to send back a response
to the platform when they are done processing the request.
The flag to indicate whether or not to respond is inside
the message body, and thus is not available to the pcc
mailbox.  Since only one message can be processed at once per
channel, the value of this flag is checked during message processing
and passed back via the channels global structure.

Ideally, the mailbox callback function would return a value
indicating whether the message requires an ACK, but that
would be a change to the mailbox API.  That would involve
some change to all (about 12) of the mailbox based drivers,
and the majority of them would not need to know about the
ACK call.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 5 ++++-
 include/acpi/pcc.h    | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 94885e411085..774727b89693 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -280,6 +280,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
+	struct pcc_mbox_chan *pmchan;
 	u64 val;
 	int ret;
 
@@ -304,6 +305,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
 		return IRQ_NONE;
 
+	pmchan = &pchan->chan;
+	pmchan->ack_rx = true;  //TODO default to False
 	mbox_chan_received_data(chan, NULL);
 
 	/*
@@ -312,7 +315,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 *
 	 * The PCC master subspace channel clears chan_in_use to free channel.
 	 */
-	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+	if ((pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE) && pmchan->ack_rx)
 		pcc_send_data(chan, NULL);
 	pchan->chan_in_use = false;
 
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 9b373d172a77..297913378c2b 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -16,6 +16,7 @@ struct pcc_mbox_chan {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
+	bool ack_rx;
 };
 
 /* Generic Communications Channel Shared Memory Region */
-- 
2.34.1


