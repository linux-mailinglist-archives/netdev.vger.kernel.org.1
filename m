Return-Path: <netdev+bounces-96123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AAF8C462D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21B41F24A82
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6436B374F1;
	Mon, 13 May 2024 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BuZ9CbA1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2126.outbound.protection.outlook.com [40.107.220.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C82E642;
	Mon, 13 May 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621770; cv=fail; b=W1vEu1KvOe6EoPiOKIUe0jBrIiWuB1/RP99CzzOORaU7XB/ErBOnGMjZHwgs8tAcb8a+KAfQznNiP4eXLZHEbw02i27JcWShK0FQNWad5yTsnp8p/6jDGDRitP970g6WVcKUCDmI61ly9yZnjWEo8fGr6GlVQhJFQaZpY8w6uWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621770; c=relaxed/simple;
	bh=8CBJDKs5VcadL2xD+UZfvIkQa2KAqeo0wah+iZ4bxG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajl/VELDaQlo1ERVPG5+LrwS8Y7d1gH+C/zANlsVi4+c/nT1hpN8yjjm33G6c/ZXJ3yrz3+iSsVabOS8grFcaVLSHpqFvfTectLdW/RycrQZ+XPQnV9gemxEbCRLydD3LOM81vsAAhQLD93HPWC3DFh3l69LkW1fQn6/GZpxuTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BuZ9CbA1; arc=fail smtp.client-ip=40.107.220.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmqUJhiPDWry6bY2rHhKSNTd9PU6/7CylGDtAcL+wDImg+tJuiPAGgya64RTxQJDcp2LDMAQESlZ5ecLwpFLMvGwBOQXk5OZivXRXvsTQ9d1kvK1VdDCbEG1aBuswlZQuNSZgeh2fO1QQPc33htJscktuknklNl/yQ8r7ga8BHQ3cqRgABwaRJZzv8OJllSS4wv4AM37VbOatMQo5CV3rMAnfCdXMhNxKBm9gWZZ4/0258anlEsQtmy6F//VXHja8lL1qiUlsh6c2fuEhsKYb+4KRCkHVaCau57q88uMU4fj+wPPEtshmYayk9W7bZaUGC2sojkr4pr0EPsiJgNn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1KGNTPhBzpsjkkHGgPTcFc6xWyKWmAWMQ3CQpC8C54=;
 b=SVpXCXSx0O4Ftzb7ET4RNkBZVghuW/lMCLjVJ9lfYHVxAiH7nuiy+6XDVKdRsqQ+fRlrzM5EoL3l6RMVfH0Kf8UvcPvF6ZK+cF4VOPbAohX7KKl1lQ7hKXjXUrKDRfijWfc5sEJkw+VqbvZ5Le5fm6QdIrUw6TRz7kyInPwjwqZfOfgjM/aO94WLt1bGbwL49jgwm7m1UqKhKFpA7GpjZ4hrDojmPoG7Cskg/al/Vx+nIzsSL6z1gvmM77a9XwlUbA5ScuxjdoJn6BLsCW58aEY3L7Bi+YwUyFPNxYRSuhc/15AEFn0X92MMwbnK0gq4lkZJEytP6EFQe4pjmcpA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1KGNTPhBzpsjkkHGgPTcFc6xWyKWmAWMQ3CQpC8C54=;
 b=BuZ9CbA1FjNa8u01NVPQTke+Qv7o5/lnEfltW44GNh8uJs9s4NHfQVL/Y6CUWY4b3TLefVIif+XlhxMbWv98jDvH9aUNdbo5IclS0Av00tRuqCEMoIXIWaF/mpg9j+AQQssFFDClGYzK3tUcVHHF+xUybdehumF9XPElReL5/GM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB6191.prod.exchangelabs.com (2603:10b6:a03:296::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 17:36:03 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:36:03 +0000
From: admiyo@os.amperecomputing.com
To: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: [PATCH 3/3] mctp pcc: RFC Check before sending MCTP PCC response ACK
Date: Mon, 13 May 2024 13:35:46 -0400
Message-Id: <20240513173546.679061-4-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:610:32::18) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: e757cf37-75a4-4f1a-f6e1-08dc7373297b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?afnJk3pl47fftm4hIZcDht6tC7W+ZtZEpZtEcEXh2uFBw3oa3puDzFOiW1X9?=
 =?us-ascii?Q?f0cHIAagcv7Vbud4wBNqDHNdieHPGedk6e8IRDt/DWx0+JWWhraGfSzUBO8N?=
 =?us-ascii?Q?swQahADiSAENwvcoQ3OL0j0fzrGcLWfej2m/MJicqLtEsVZkE/WAXUnQrkx7?=
 =?us-ascii?Q?Js7mxIBTPf9xiwgyLWdW3PXqY/SkRMyrSe1CsDJ64D/IbSW5CIUcczUW66+A?=
 =?us-ascii?Q?Ll/hCxTT7D0/JQsHK2SeeycMLP0gofcHuUXG2Z0tVGRf5vKgHWsnZC01uCwX?=
 =?us-ascii?Q?Hs3pjSOXUaXGIzAD0jxkC/HyHp+bV47s76htfNA5rMvNEIe+u32+PxtGrXk0?=
 =?us-ascii?Q?vdQ86xZdduO2txuHFSbGjcMldcmsRTDl4QBQzvwDRBLQtXlV7g3jP2galEy1?=
 =?us-ascii?Q?sYH7CyQ72yKVJ73VekQ8jAK6IlFaJkX+GmA6svZdFkuYoBLWL5iyEE5p6E7H?=
 =?us-ascii?Q?06aNMLkU9KnIkSJ1CcdopoKXqsmSOsccsHX8qsK30Gg2z6gevYa2yEyj7X1F?=
 =?us-ascii?Q?fTBtw4ZdW6lKRFtMgSUtPlW+TLwN5CWgaAo5zpzaAUNLNROfKysnp4VD2CyP?=
 =?us-ascii?Q?rMk/mugbIrDc0PVtUo3QK37Row8JiESNX0OpxL79gAcaX4g3oy3+yJpyGBiq?=
 =?us-ascii?Q?tT4VSt6SVfTCEqv7PNk9iKi0WjyxSo/zapU8XxFau3/UYep2oDgpbYpVvRUe?=
 =?us-ascii?Q?tFnuX0meFfqAbpETaqwOMUXpaslag26HnY33X9JVctnLo1/zRVxJlwjssS1z?=
 =?us-ascii?Q?GNk21qubsQWwkIhf/f0ZsZN/ysLzLqd+8v5sVuTQ1ZdvCK1q/98BXCjn5GMc?=
 =?us-ascii?Q?I8y8xnogqL0/1pJKxgz8CfyscnBrU8tR8sHq47VOak5RlKGFh3ANZVYo4ims?=
 =?us-ascii?Q?cGf0XfnUxBxakoDPVZI0OEf3MjFE66d4d2CxgDleTy/N1OT6Tx2Vbyuty3Tj?=
 =?us-ascii?Q?aIIjI1i/CGY996/pRX3CweY3KqhMd7lNE5pTOvbbuLDsCJXzWsVAQYUnWRZc?=
 =?us-ascii?Q?1B02qxwdRV3ovFD6lTyFVw+H04E7AWXxIYAc69fzh4bI/XzmiZhDLUtVJnng?=
 =?us-ascii?Q?3uv8RQRX5E13TLOvikM5zJ1AE66JLbRnDeEfKVstKGb71tmT3veol+jjRUIl?=
 =?us-ascii?Q?MCl0wnjnzQhJtJicFdi9FUTfKFKGBWvhf5O2/lvS8BypvOxXbPoHoIWujOGz?=
 =?us-ascii?Q?nTaGaluBZs6ZHZnd3UDuw+Up2MrxNc5E94eTHViwToPiz4gUSYUfyP6sSVic?=
 =?us-ascii?Q?bLZZJkpsjeS3s678Wk/fwHYOvDvFln13BX79nNV7gn2EclKksK1B2K+Qr7KB?=
 =?us-ascii?Q?jSP6Sy29QRskwLDbU78c/sYc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kErUBXLVwIVvACmMPYRwQIEewHzV3N7cfaDA8nFzWv2NK7f9Bd3PfKJqGyD1?=
 =?us-ascii?Q?6mUPLN4RiJDB92pAUgZ5IjcAV4GYj1VfFRB0TUsrfHsaF/KydJY99F/BKvsf?=
 =?us-ascii?Q?/yFmBuuTi79D34LefjBTjboNhFoGnVNTpkYhKznh6wNw9Rhss74tePt3oj1I?=
 =?us-ascii?Q?TMsXp5htpMNiU1TjTMyvPdWkNUa6xiB9tp59Jo91lHwDTIbklAzIxMLMNmtF?=
 =?us-ascii?Q?XwQkXMh5G2Fjbcuep9RuXakgA1L5uBEgsw7ne3A3Bv+L7lkDR02ww0oLYsJ0?=
 =?us-ascii?Q?1XXOexpwTL6GqvfgKWUe6rc7LgfWyFCsSCwC2jV006d2Pk9Epr3dveqy0/yI?=
 =?us-ascii?Q?eA/ZcfpNWyCrROxXqPt8iAmNqKXxsNGMQJ8XGxOE5T6U0AgbcYp8WSgIn6Xq?=
 =?us-ascii?Q?HPTw7ZGi3lqBQkkCkGQkihgdsIs8FRbUcISsfDhp6WleP+OvJS6bwh69FpBn?=
 =?us-ascii?Q?s6qzs3lUdCH5FfJJkvGONq+lDspU0kJIEG8hzaLAg44LHnWYL8+tz7Qo7LzY?=
 =?us-ascii?Q?h4jxfRlinCfzliejvBgc0dKoC02VHUFM98nXYe3DS11p7f+zvzX4LoAlyn6T?=
 =?us-ascii?Q?6S5Jd5hXa0lY3ySd+Ij0qIc0TDTvXMBq6c40vG3+hMT/Ix/iiFmQREFY/M0Y?=
 =?us-ascii?Q?0f0lObbibIbvNutJgmwEktZHNOmb9C6WaKGX5oCxQSVJezboCYGxJUKvsBJJ?=
 =?us-ascii?Q?xlXsMEoEaKbYKETdQLV3aU8ko5g/Xg60jLdG7Ak3q6GiMVuY1U3+3PTjjGgy?=
 =?us-ascii?Q?5SQbjEHklzCnNcUMcgvDCTzfRCZDWCwVPxuSppunUO8xfyP68vgaCdeAHo20?=
 =?us-ascii?Q?s5DeT1Ut40WT+2rIqVJ6m4yllNSMd2+iRcJpq5MG10LYfoSqwqtUZBf3oElA?=
 =?us-ascii?Q?i+Zsbpu33mIYeKfiQISMskz01dajaF0ENet/9INppiDDBgBo/QAgZ8gf0DmL?=
 =?us-ascii?Q?xrPLmDZb3ho6aYCcGWuupGVUgyAVqQGrdBJzOatpSAxGCHxI7JwJU3NPTDsW?=
 =?us-ascii?Q?xSi/pMU+x8n5FzphuY7jF7HSmLjZvFD3krY5w2/+Fq5A3++5iGz86bSiqstt?=
 =?us-ascii?Q?b5NNO+KC1obIdR5Ps30JSjAKTjFos/nWoOdIGwMQyqoy06IIrJ9p7HBIQLJC?=
 =?us-ascii?Q?PhsJpt+k7v1/Afrd2zotLqiyaEd8GL/mLr5aEc5sIV93VR9etu0keUOhbozj?=
 =?us-ascii?Q?Hw73NlhoFcTKqy4O1dvFON8e815+woArWw1LXproLW43734vYVojxyKhkKEi?=
 =?us-ascii?Q?lr5HusDWxgpCDDAkJuKcTP+XgMpIok0LYa/xs6k4iq97+KjbzgkcQVQjMkMh?=
 =?us-ascii?Q?Pyj/70TtGEK8/3cNOi6jxtFzuY7cQcjADM6SqhyjkYxWf7BMdvVrGpK5kL1o?=
 =?us-ascii?Q?VdzU8g1qBlJJ37bhI4CHXuVKwRZ6FtyvkENq5R1HeZmWPzfcYCyM3ixtBTHu?=
 =?us-ascii?Q?RLtWGFC0gK3VqUXZI/VB1ORFB6x6cvfKDxne4LQiVwt3eporbLK5uMWeZbgS?=
 =?us-ascii?Q?z1LYc40G8Qvv9wYGR+nAoiicKE70qf6na0RpblwtLldpBXjtjQlgWk2ep2TV?=
 =?us-ascii?Q?gH6XSEmHbLSp4mSWpgPwyyADY4554eP+X0UcY4sDeRAOQMmjQyQh/8yuDFrq?=
 =?us-ascii?Q?oHcpzEzaHKxghx9Xu7cJezNYCYZ1rUnb/D/jQxHUVOtOWCHdDuS5Ia6Zh4D+?=
 =?us-ascii?Q?SmR+Ie9D78r9dVNtxW91LfvhqCc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e757cf37-75a4-4f1a-f6e1-08dc7373297b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:36:03.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voYGs8TXDRB7tQnc8f8A+Y2DXCjyL4pGxPa1qgUd7LnvAKnkr1Dy78cEBkkX1ELciBCmsJrmMMQBwNOED9DaVtkLYWu9ARR1xHtFUEka6kpLM/REflMrWk+aH+8iwFXq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6191

From: Adam Young <admiyo@os.amperecomputing.com>

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
some change to all of the mailbox based drivers.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c       | 5 ++++-
 drivers/net/mctp/mctp-pcc.c | 4 ++++
 include/acpi/pcc.h          | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

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
 
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
index 7242eedd2759..3df45b86ea03 100644
--- a/drivers/net/mctp/mctp-pcc.c
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -96,6 +96,7 @@ static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *)
 	unsigned long buf_ptr_val;
 	struct mctp_pcc_ndev *mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
 	void *skb_buf;
+	u32 flags;
 
 	mpp = (struct mctp_pcc_packet *)mctp_pcc_dev->pcc_comm_inbox_addr;
 	buf_ptr_val = (unsigned long)mpp;
@@ -115,6 +116,9 @@ static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *)
 	cb->halen = 0;
 	skb->dev =  mctp_pcc_dev->mdev.dev;
 	netif_rx(skb);
+
+	flags = readl(&mpp->pcc_header.flags);
+	mctp_pcc_dev->in_chan->ack_rx = (flags & 1) > 0;
 }
 
 static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
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


