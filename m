Return-Path: <netdev+bounces-98751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3D48D2484
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9961C1F29CA5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A86A174EFA;
	Tue, 28 May 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dH+acqNF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2091.outbound.protection.outlook.com [40.107.223.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF8170822;
	Tue, 28 May 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923917; cv=fail; b=Yy3WR42b1MNF0z1Zb5O75LhftIxvEdxh2TmsHLp4oSYijIgWnQhh5jCZ2t4eoPULzP3N28ohygUWpWxLwEh1gyt+wniFiE1uWFBx/7+v9Pr3lHyhK3hP/E+C2kBuqmv7U8RNzw5bDaaApaQwlPza9jAAxJoXVBAtjj4So7/6dAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923917; c=relaxed/simple;
	bh=Hmj5Ulvo+nqYAvqEuYtvQDDA0L73DYfZL1cGFTucQ2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oG727+ppRsWVp93G/bMVxqRm/1oUz4ZZM5rCB/KS30Fb9Cbs/nw5qxeukp1zpsqcVIIkcF9EEdIERs/bc00bwvIDUu9hFsRT2o9I7YQL9BDuarQRUm1FEnVCWImmWZ8Puqz8u9Yq2iVwwh1fKGcldlh3DKtMgXDSm//5zFdxgvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dH+acqNF; arc=fail smtp.client-ip=40.107.223.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEfhEjbd6pOrErwLh5Q4IH6GCWMbjmxwjHFpThEK8/hkwS8eLC0VdRMnV2hrsti8pF6LPqZOYBShvDcA0A9JV664bTw2GnGoC9W5SMBW33ELtZ7wQAUBNz0I4SDHNuwLQd57lQUXLJQiZD2E5CbXi9O30QK2Ts8ofwEqrxv6pCjlT0zwXtZ3bOKm9sp30nqezThRs4/1Pvv1mGSmH+HYtXE5gV0qBBFClj9R1r5pPCD92NlvTZPWLOR1fl7gGPJ6AaftXg6B/fBORWk3e7FQw5UNLhp1GWjxY6QmtuO3ihnyn4m1oquEnDAjO77R5uOzavg8ncJsp6lp1rhEIqPSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK5zzcguWsiHz4kYsH0I/UsY5WwKBjTtaszm+g/aWwY=;
 b=UpNGBdgbcXNtIQKoBwHggneqpHREK8szE/eTnFmIixggwqIwlpeVMIVfXfs7xzq9p++cAALVYDI1Q5Fk3DgFZuaya9tDv3bVo7Rw2IPgphtAHcegi7aerM7fe22m46gLG93wG9bm1IIiNBPhUHkd/eMyQr9PXmIREFfUl4UIQQPy3KBPrYhzlNthHKFoLTKw6hAtMzlaIWSzQiAZWcE4zM/EyHRodusTpk1MQ8A5wzEKRw6LBqBGWqyZUrwARZoX9k4299GVJ1jZBb9NujbtD+Sh4g7iiqn/gOsWhn7PhmXeFKCfvUJXCQYijCGy8xN8RkBmYvJx+Iy6Bx2lHprUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK5zzcguWsiHz4kYsH0I/UsY5WwKBjTtaszm+g/aWwY=;
 b=dH+acqNFP1Vv48ynRJAYYsebGGjvo7uyRpqr4kp563ohLN1z2kixuSaVMUrscQTyOBOWa/neCg2D8X/fm67pyBeMHkPjaRLPwqTYQ0XEt+rYl2tv6eyxVLU2Y5fz2bgNDeSmMkgo3U5wJrghL2PcZpoGc2u/yKc05ItldxP2i0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ2PR01MB8403.prod.exchangelabs.com (2603:10b6:a03:547::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Tue, 28 May 2024 19:18:32 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:18:32 +0000
From: admiyo@os.amperecomputing.com
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mctp pcc: Check before sending MCTP PCC response ACK
Date: Tue, 28 May 2024 15:18:21 -0400
Message-Id: <20240528191823.17775-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528191823.17775-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ2PR01MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 0acc3724-55ca-4925-dc85-08dc7f4af6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|52116005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O4GwgEvaQTwhJht/WH0XZ60iSHbn5mn04diOLnyOvWR5lBt0HyKuTZ/KxizM?=
 =?us-ascii?Q?r4xNDPH8lbt9DUUfRodCZgI1UJFckwwfbKsl8wMOPmila4gTy3QhTkRnMt6X?=
 =?us-ascii?Q?vnFrWaXYCMW7FT9Xj37DKcU/E6CDWfz0GDRk70bhSGvVDnZOx01wXGbryUVn?=
 =?us-ascii?Q?LOMgk9ZTP7LQQpEuvpbAXzkcj0YcpCuvaWjkTju3fe/EWYY9gvOY61KWc8A1?=
 =?us-ascii?Q?I0IWnK1avA/rTKOhj6/PcgXTEP/DmzXQqeOQTHvoo0eun4Ah3aNQgqMOELLR?=
 =?us-ascii?Q?rMRDBnVkjX2ErtwBwKgM80/ln9wgDFr241ZY05uqACy/6qq4sa2N9kcTpLIl?=
 =?us-ascii?Q?RV5GDbW5EumInNRoIGx9krFa/YNcQgg1RT0S2U5IEyFbeog2JuIezXNvIxdy?=
 =?us-ascii?Q?8SEYCOJImwo53FkIPCIWIRyZpB1j6hUfRCIuKmlZXwKzSPnili00iI41jM0b?=
 =?us-ascii?Q?myWwkZmKF/byHBZxgOWzNdxt+ZBd8BDND8wON+7a/Y9i0me6bYaQUtRhamJf?=
 =?us-ascii?Q?FdNBV9iczvNuLcxk0Fkh9mT1jtvQcA7/alAcjDypmCwzJo3srXx9gye7Po9p?=
 =?us-ascii?Q?/f2tDYJMKvVNRkrvstbZTUUzc9VR3ePoHehy280Aq7s+Y0O3yqEFl4DLqQ2C?=
 =?us-ascii?Q?ZG0UNA39hbukEX71TyR6HqGoG+WDOVr/yXqeUWiHQILG3gbsDUSbFxaC66fF?=
 =?us-ascii?Q?GOdaYa4l917y2FH802ITKwzlQYmdCEN/uxmAJTheNb1X0uD+x6L+cxLQbmVz?=
 =?us-ascii?Q?W7ddRoj6kzWxhezF4djC9ziitmocZ+ovgEGeZhC4OB6BlAnL1Da4tVc/2ruX?=
 =?us-ascii?Q?mMSK+jTNn0bwKikkFGCkAb1IfsOecsOz7WG2RCch3o9ORSStRhWYnSeSGDtw?=
 =?us-ascii?Q?nzdExxafFEcGnHSMoqjzDG1RsfcL3uZ3n+g9hHBDRmKiK96sHSyfoJpH3ZUi?=
 =?us-ascii?Q?dwlc2OFXNKpWXbaCVNK+JkcZO+1hv11K6bLJe2Uo4vZ0JtifGRMzmN79WWm1?=
 =?us-ascii?Q?xtFL0jS13fiENSoqYTPmv/8TLV+3Ns+EQ1HQ4d0M5N3j0Lgk1vNOJQ3ib/0F?=
 =?us-ascii?Q?3bVq0lhJyLLqFZmPV3PwqrumqpfjERCCtTYBN5TJyG64B02mX7NSUgRUX8zw?=
 =?us-ascii?Q?G/VDCH7gsR2RN5BdI6SecTVFCSk8GyKzwjp9IMZcIcGoLMVZR+/54kKTCy+u?=
 =?us-ascii?Q?u/eCNTGae/zCEsGfAkwTOnAvL8ZbDRoVaLonY2dHwn2PPMNZNCbctWDp9rgo?=
 =?us-ascii?Q?KTwYIyBX8VnQpamUTtkrHzLpEBxGCe3op7wsIZzTzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5kyw9Dn9L26l4i92b623uWdeTLOYnvYB0E87g1hS3QHGYJV8lBlAfTrQSHto?=
 =?us-ascii?Q?NmK+E/1EEyfI/aq1HmCD5uDxToEZf86MhPnjHx95vM0k3ipuf90Ez/v+r0yS?=
 =?us-ascii?Q?nOM+9fJShCcIKowqrmqR7QaB0ZV9gNPIMbSbS5sLWynNX9ZPO2FCVeXfwHYQ?=
 =?us-ascii?Q?xpeHFv9lRAMXiP3F7/Ux6dLTh6Ws3LapTF5pqV1nByBQUSzZq3NOhzfjdbxL?=
 =?us-ascii?Q?yTC1WrfH7VVqElq+9P/JG+zKZ6YsmyxlLbe1ANsHGh/66rl3EltdkGnFS33h?=
 =?us-ascii?Q?29qZpx946fyDqGNTN5t6HdaY12fbfIbBquPI0TMviwJrOHlkHbNzuu6NX7S4?=
 =?us-ascii?Q?r2NXMfz1GSEYsteQKe9UmOY/lOODGLBFTMjB/byCeIiGELIoHwUCwEoO8A9W?=
 =?us-ascii?Q?XWxf2WlZ/njRNdyu6o+Ke6zDWwyrqjeRzfoGDl4V4p+Zd16AX6DQf78lG2TB?=
 =?us-ascii?Q?eu/t4RF+xc2lsj9ogdGWLl3q3y/zzzqmBZOYZEOWgyOoN1tlcJv+S2Fb9kXJ?=
 =?us-ascii?Q?L4BwfzieXcmySXzT02Rh2nwPfkujqoRr2PcruFNLkHjHXDJzzkk4KfDVajpx?=
 =?us-ascii?Q?Sk5dHipzd7qewcroTspWQ2WJ/Ud7tk+6F9qd+Vhzb3LgbeatZvXPLuapi3WL?=
 =?us-ascii?Q?FXBbLoOFbneII+b9j1aSTcwSb7Wz6GEvmNbGiZAxhBKBQd5LjhD4cBWi0B4i?=
 =?us-ascii?Q?cUcpKuuBsPZgzDSG+kUjfo1sH2wWjR7zlH5Fs2lPJ+QVNniCBChmDCQVUS3b?=
 =?us-ascii?Q?rDGHtpPbqEPh2C2WGozGghIra3DpGCfUyugqPPMnhn9E2SoKVKKi/Tp3v70/?=
 =?us-ascii?Q?ki5/mPamUggoBv6lJr38fwIYFTkbtgMtKpedecg9TFoff0M83kd5UgpMgMpb?=
 =?us-ascii?Q?wxFcNJhRqbW8dyCGLkkT+JDhC5ChwU9scO7KUoOH9N01R3RJA4g05nfL91K7?=
 =?us-ascii?Q?NxaFjSVasxyyr5RXAxhY3sbaxiYoIYj23Y6R4Lrl/EHIXaiISIr2nOPRS2vu?=
 =?us-ascii?Q?XBzRFG/WRT3j/09un5+HOTEuBF+NznUxG3sONFVqMkj7lhdiGhNLxo7SzeYS?=
 =?us-ascii?Q?uMK09JMSOvmzWLnRVA9uwEEfWzVK0uHf0fZ2NKXzvZRkbQhVt3USGZC5mWBg?=
 =?us-ascii?Q?22aWZrLZLfDXMQ/ZyKoU+Wp06H4MVTipQz48u7HzJWUgdoUjuzrcPCsEJ8bO?=
 =?us-ascii?Q?yBNIfwK5UGpb/2pMDU96fEpnXXxcZk5715eAZ88dX0lRvbsrfo80W8dyog9g?=
 =?us-ascii?Q?bHGrhbnGztF9QO/vwaclWpOfsBYHT0gIxmo3Hp0/NPUYi9XOpJ3JQkvh1NL6?=
 =?us-ascii?Q?i33AjcpN2fnniWScs7oxZvfrfB20B6G/+p14liUEr6nuGOpsMvHC4C8KlO0H?=
 =?us-ascii?Q?LubceofmJoSHA8lpoYvMzGCxLVdVrk1kIw8QF/JW5aApzevrDgqvVrtjgmBs?=
 =?us-ascii?Q?CtVX2pRj65qZFs8ByQj/aVV5rou87jP/Pd0YiIcQCg7cuTj0/VCGUi0mMe60?=
 =?us-ascii?Q?mL/lzj7IOleEzCngeAu6kQSgKynGEfrW9p0H+MlekcTgcShJfZfhqhQb71sG?=
 =?us-ascii?Q?KESr2tHQy+ybLL63IH7H94bRZL7reKypfLwNS7b4ZN8jKqfzQk+NdeTrEVeB?=
 =?us-ascii?Q?YXW3+Fbm3l4pSRuMVcec31qAsVXRdwxE7pfd2/nXpIaoMKvRZqGPLY9u7etU?=
 =?us-ascii?Q?lP6ucOmBBZ1nnILPbqq5Cnj2z7c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acc3724-55ca-4925-dc85-08dc7f4af6f5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:18:32.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zj1at55oUSdLohhICX3mGrI/++RoqZE9T/XKhUeHIlRGx4aM6b555Vz744ZM9lUxAa7tcdmosopKGRLrqV2XaWmiQtyqClOkG2doMu0nqaXkZhpLuStDWpaJ1iBtLiMR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8403

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


