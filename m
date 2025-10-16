Return-Path: <netdev+bounces-230225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29ECBE57F9
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DDC1890425
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8947E2E1C58;
	Thu, 16 Oct 2025 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="giN2j/ma"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023138.outbound.protection.outlook.com [40.93.201.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7521CA00;
	Thu, 16 Oct 2025 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648560; cv=fail; b=pJSkGFxXdLdMebfuuQLBcfGC1MnRgTDSvV+XgqguE0lDwT1xYe7ccuEjQxCbhpmgOcIb2WG3JiJQUM0TsJPNwEp2fwWQ4NshcDI8OKVixl7d9CV+CY1yzFLwBz5XMqFHD45JlAQAq5oNvn+jaMNrNqKmmA2j/W+HYagWYk6zBnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648560; c=relaxed/simple;
	bh=T4iQJgbqn9MuxGoQBAmWTU7YsU3Zp6RhG4Dl0DozHao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b3V3voUv2RZhOKP9O/NgA2Fbv4kpuXlDBjAKv+sLfdS/XYx5P5ikjv0q/lrZykNxLS3swgZgElZiEceHTGsyg7kBfawHa1bAV5nDFmEhjcDV+azN68OoVIreGs2vWYhtfx4RuKK/uoeveqSvpWY8KU3K9mQhb/gYRLruJQH1O+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=giN2j/ma; arc=fail smtp.client-ip=40.93.201.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2Rj0/IgatHMkzJbFVngXq5ZiD01MEYZZo+IUvV2u60Z1oikPXaNp/29bWw3JXU+qrjQ/f6XUvSAwkEdJ9NZ6o/NJ+mqHF6vTNl4Qd9pzpt+YD4L7frwpwK64xykFgCr3M4pwfPAFW4w6zNdMy+SHwKRagC7Br8XCNWji0qkp0kQxFzG3+Gwy9MUxc0Umny79mKzzXLYYWiMpqIHNf0KtTNNIInx5eGf40TF78iq3SJ2DZZYMn+Ts+Xh6cOhZGRKgIbcyvfMB1MH8nOR0auS17jkc53e44f5lJs9CkXEh5ntFDKn7xZxPuJ2/c+7QxlYcAcWpzNOEJqFQdT5IKcy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcZ34gbBO1m78hk3RjctoaITbEU0NquTYFn5sujIjic=;
 b=OY9WX/BooSWyNyinOYAC+u3lN8HWDq3udD7CJxAKhnoZz/Iz7NWl4uxtKNhuHB2wHGejlvrkFBNeARz2zCueFOXeh2XCmleMEJFlSp6ydQdvhjBfqGIaXNEUCoB23G9crN9shzMl4AkwWUtlLLvSBI1zIQQk0YAJRE3pgQaDT/U82dRAs5ASM2DpgxMHm6NAaduieuSSEbWs7xwfsG0eXQrd967c1yvIcVFhF34yMLRPAOs9sXqgZ9IoiNd6xnRFqswnJOvyrbyWIhvD5ah5nCJF5cHovaNXVEVkv6S5OLfpogaYXDL5eioilTa6qeXhK7k0cFwvZJL3QRfXD2XsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcZ34gbBO1m78hk3RjctoaITbEU0NquTYFn5sujIjic=;
 b=giN2j/maiqteJp+5S9Mc94PbRZYhqPlN0qzqB/wrUuYhEXLhThkIxVF2ZNaNuipPVR2u72q6j3ddj98KvJOSwo21idVGwRv0lNZK9JzqmJRdgPR39hMOallIc08+OL5xbsrFAtdruu4777va2OcGo91QZYQQ/TJutOdmdOMW4aI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV2PR01MB7813.prod.exchangelabs.com (2603:10b6:408:171::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Thu, 16 Oct 2025 21:02:37 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 21:02:37 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>
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
Subject: [PATCH  v30 1/3] mailbox: pcc: Type3 Buffer handles ACK IRQ
Date: Thu, 16 Oct 2025 17:02:19 -0400
Message-ID: <20251016210225.612639-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:930:8f::12) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV2PR01MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: d774d308-fe53-4d98-b434-08de0cf755d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ADBOfBzvrHjxo3+sWtpO7TkKlUQ84cqoSv39jf/jw3engVLDyq9YdtUmf13y?=
 =?us-ascii?Q?MOYd0ajaRWCZVvt3mAH0tclCjaVoaO4Y6UNak83PtmNu0SXYjrYLuY5wjSBe?=
 =?us-ascii?Q?IfG4edv25+M35r8tS5FVoTF/9MB80FtDyD9FiKgVajIPpiJ5PMmHPDPezSR2?=
 =?us-ascii?Q?enuEHpKUnLEVHBv5VC8BNE+DeiroVndP9pYIGZNvHbGJazdnSegbD7qCKyLH?=
 =?us-ascii?Q?49+bDeNP6EhTdwS71p30qZZAHMu4WG7/MyBuptkYGESb7MpKAVTqtu1qTqt3?=
 =?us-ascii?Q?6Wz+CLWtSuvR6UJXzaWilCtnxw2W0vv/HC5DpwXwsBWcEZNIC6C8VMJqC5sE?=
 =?us-ascii?Q?ke0r3dNHZAU5pZZu2ByBAK+4OWCbsZ15y1tbABcza6dRZeSLq/1jw/CXJ3ev?=
 =?us-ascii?Q?nnU3EWAKP93n/Sa2cevd98blHJqu9wvbmgP1B3OZhLf27+7I52Q3Wa8LvPYC?=
 =?us-ascii?Q?wOYW7wxt07LFVX2RzQvg12oue7/OCA2Vj2sY1UoSZGT19fGkuWSNMAX/VEPa?=
 =?us-ascii?Q?tYzX5MrUMkBBZw7mr55Lhz80uIMM1xygu5U5shwl+JEH6QMhrOMnQiRCH/Gz?=
 =?us-ascii?Q?bskJ1MUuPYDxrWr58SFX4PvO2vm03ZbK923W6x5wuTleJCG8XXeMx58zLrab?=
 =?us-ascii?Q?gVPcWDzzKfuVF6q/MCu/XkiPWMchfSmWNH2LwCuDN83XD15QiC0DsGgwqsRX?=
 =?us-ascii?Q?62XfALr5JuS+irKOucVaJB4CXaJMvg1Dz3eldn/R1JsZH8CTaaT6vfXMHn/V?=
 =?us-ascii?Q?rImTcpUTo9UjXZ4IXw+8ebphBbDEGiMlr+O9JIhTfW9zAY6NqBaDUwyH6FhY?=
 =?us-ascii?Q?feXuYN/Jgp8wqTGaocfaMMhpndBLJweFT0oN6VI0sCE/a1ALjQFFbunIEFcR?=
 =?us-ascii?Q?SFiXznNpWhyAMFbQW/zkWnWpsgRYl3ObLRjNGWpxiOpK7GnDsX0yx0uaMrtx?=
 =?us-ascii?Q?l5uJAkqqqVFjCJVLnQoHJ2Pzn2+8hrAHYZQlG84XY5eVH4T50Uo1Z1mu8MNk?=
 =?us-ascii?Q?YpTVZewvhOA0zYMGHQUrUVMUe+YeXGHXyMOGM/IaCXgQKmcA/UpwT4fyzT+P?=
 =?us-ascii?Q?MYEchTyib8K3X3Olm69OaZ+nmFITbFbME3YXyUgfZl8m11uFSSOoMubkGjV3?=
 =?us-ascii?Q?NMGQjaQ3a7Kd1wuJyfBYAWIVV2ucLqkGuB0gm9JJDvz3YnZCXm9toJzoyXpq?=
 =?us-ascii?Q?5RF3s91hkpdPmxirQEUvZIKyqHDTarEt5OoVw1swfgg2m6TuvWVZaFc/JpDm?=
 =?us-ascii?Q?52D0XgxFI+g71RdNl0Dt/E56wTJPRDkHRonZjn3CpdnYACZb26G6r6/NPj0V?=
 =?us-ascii?Q?UAnbL8Sw5+mm4TICjPiTzPRRuFMm8iaUDRQJvzyWg3xCsj31KQbNbXPp/GUL?=
 =?us-ascii?Q?h51Etheik3saRPWbHCr1xxAXzJZeLyaymMeZvuDxR/tj4HAeS4abzz7g2XX3?=
 =?us-ascii?Q?ch0WV1GrWVTnZQ68acWG65fAygRnPAvh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BlMOhFqHHihKvcoi+/+D3s+OmTFsDMvV97A6MWW7D1XPTQUtK2Ot1nd3QGOs?=
 =?us-ascii?Q?qhrCmfEyzXdE5doxGNE4OFZfntAnT94QqqD6sdlXj+YWPNo65UEitlSr97GK?=
 =?us-ascii?Q?Ehdj2d9+5g9W4c0+fBZ8wPGUSpwUXTq0t/wY9UAOLI2Ik50yN4iR6TG9AYkp?=
 =?us-ascii?Q?ezl0pTfjoH0RrPG0rkNmpnoIcpViS7geFk1ST0PNJfFQs0HAFOwQUMu7oB+1?=
 =?us-ascii?Q?jhv4JRelTc+QS4dAM8s1C+Ah8+H7cGFYV1m2y9WX++QK3mHonabGNz6JPVYy?=
 =?us-ascii?Q?Vf++es/MeZzZ54PYMJKhKO3eiG8M+/YI/E5oPKzULi2Kpmx/CI2yULbgmlaW?=
 =?us-ascii?Q?DA0Gl0h3Uj48oLTagVw25FIf7xJlYopoVbKnORnU33CUIFFHUB5ll4I7D8EN?=
 =?us-ascii?Q?A7mAF1oO4L7BZXcxWHnLXcydTwOoprAZsRX65r3h5OG5GMX4rtpezgL0r4dN?=
 =?us-ascii?Q?FTf29EUehbl9vs9gHyyxbP4r9X/G8mp3jDli1Fxdd8hpO4vksTnkn27y4EWt?=
 =?us-ascii?Q?FgCS1VYRyz6uubV5xWc/X/r5bRb5Srzqg4XDHq+dquzPseYL8Hx8g0fPLqMW?=
 =?us-ascii?Q?UGzBH3alG1GrGB+SpGOfN3Grtqepttz7P+x/HXKhhA8IlapKEcUHsi0aw/Tg?=
 =?us-ascii?Q?yQxPoPsnGBJ0MIyqiydR5NAEXfoNxW66fz0uMS2BJQ7rSBz0jY457O6xGTI5?=
 =?us-ascii?Q?7K+8hNaJvcQBRo2wnCl4ea1N66xhawiBOiuP59U3FVBhlqYqewJsnhPyW1Uh?=
 =?us-ascii?Q?x4F+dckGppqJ328xXupsER4d9S3dww/60CCT7MsoPLxUy1WSScyXdaJTnZ8k?=
 =?us-ascii?Q?1ES72eOJuYzpB6CZuBeIMxnd8E6K5bgE6fvUqqmMzAP4NLqIvWAjNHlRzRNI?=
 =?us-ascii?Q?IZ8o8J1AowjpG36NeBHpGtQSk0eGoqMHCctPMIr6kb7x2SfEqR87G76wccOF?=
 =?us-ascii?Q?8e3VWxCnhYjhzxH5BCWetvdtS/xg19HRe6mfuj0HtiOqSckWBMLsAsKDNUcP?=
 =?us-ascii?Q?PX2SGFPBxRLPuowqTgPOhru6forenOev7FZXDiiC6eYXbro27Qqd+bMaIYgC?=
 =?us-ascii?Q?cAILBT0qwsXyZwkGF9vZYZF/q1iHKkuCwO2SOSw2ck/ne+Ut/Re8QepE/YR+?=
 =?us-ascii?Q?WCwfkFkigglQiY6eMEj5SEW8vK5wYcVEIT/kZY1VhxpskDYWD8HKzxnPYmqt?=
 =?us-ascii?Q?GpLTUzDTDR22MhlbDbwesn2zdwMNyXCi9FsOq3AlHR1FpquqRLHZ/zmFNKZs?=
 =?us-ascii?Q?xv+3rOZuiqeLlQ0VCDmFZNKZcAFMGVv1xv1lw0ZZKHplh+tqQJHGFjM5Y3RI?=
 =?us-ascii?Q?ukEacP0fUc6rTrKyyoD5bgJIDZ9n4qqH0+BmC5a+Bsjx46mih5rIciRviwno?=
 =?us-ascii?Q?iYKFf4d5MATbsVTgu4It/7QdlQbHW21/oJne8rm5/GRpSgKslclohfl08j6i?=
 =?us-ascii?Q?LeiVGmXG1Z6rRT0nckItdjGVAD7FnG85n/vj3c4NKBmb8Vb5ili1qK7z8dsV?=
 =?us-ascii?Q?ehkJ3y/xlrj/2LXem6fOZhlsLY+c6EjN/kEbXsZiqkk4dwi0J6FJ0BfmLO0b?=
 =?us-ascii?Q?kCGFpYIPuNMOneUvNqxgS+N1t6jG95NoijUd6CFyAqVwiPMjvIgKWszfU4bl?=
 =?us-ascii?Q?x3jJ4sibBDLa/+PIixz2/bHjkvEfsCQrw3xr0h5QKcIgcBVD8sx4krAJGEBh?=
 =?us-ascii?Q?VTQY87dbHndaSqD3KCj6PTSkEVc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d774d308-fe53-4d98-b434-08de0cf755d5
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:02:37.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2uXwdyffTWhdSMmqEP1dMcA9GZ9j5EG9Uspd7ZYYt0FbeWOTJEdWeIE99oh7jvUfgNRsNsQcvGUi0dCXYSQ0/GB/ctTgsVr4/lRFHgH3zYVh3T2BYvAevUiSRRfc29b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7813

The PCC protocol type 3 requests include a field that indicates that the
recipient should trigger an interrupt once the message has been read
from the buffer. The sender uses this interrupt to know that a
transmission is complete, and it is safe to send additional messages.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

mailbox/pcc extended memory helper functions
---
 drivers/mailbox/pcc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f6714c233f5a..978a7b674946 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -306,6 +306,18 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
 		pcc_chan_reg_read_modify_write(&pchan->db);
 }
 
+static bool pcc_last_tx_done(struct mbox_chan *chan)
+{
+	struct pcc_chan_info *pchan = chan->con_priv;
+	u64 val;
+
+	pcc_chan_reg_read(&pchan->cmd_complete, &val);
+	if (!val)
+		return false;
+	else
+		return true;
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -340,6 +352,14 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 * required to avoid any possible race in updatation of this flag.
 	 */
 	pchan->chan_in_use = false;
+
+	/**
+	 * The remote side sent an ack.
+	 */
+	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
+	    chan->active_req)
+		mbox_chan_txdone(chan, 0);
+
 	mbox_chan_received_data(chan, NULL);
 
 	pcc_chan_acknowledge(pchan);
@@ -490,6 +510,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
 	.send_data = pcc_send_data,
 	.startup = pcc_startup,
 	.shutdown = pcc_shutdown,
+	.last_tx_done = pcc_last_tx_done,
 };
 
 /**
-- 
2.43.0


