Return-Path: <netdev+bounces-202341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FC4AED677
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32DC1899A30
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97B2243364;
	Mon, 30 Jun 2025 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="ILHmruf0"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBBC24BBFC;
	Mon, 30 Jun 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270349; cv=fail; b=nT4yX0oxMuqgH6S2a2guEYkDOUHMBZyW1LBUCaFvbfVytHKqtJIwX4+jDy8aeOCs0FOgu5ntkH4idtII4sYVX5XM1GRuF76NXP+numT+HuiWYZT3ose56RAYSyBKRDvAoer7spjE6XAn9pouHDB58vUwMLpJeJFJSPeM0zjzaQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270349; c=relaxed/simple;
	bh=ur2RHCoP+Ai1J+PIdgumAMTDOBdalxhejYdJHfVbuZc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I8yT5YIvFcWjph8px0vM/pk1WjZFxBSzPWxJtJ3NwcG5LcpQ+q9ibSJdjjTAqpdASOZ0QEimySW8TGe++3Pcl3bdXmDCScmqZYo5/Djsu031Hv8hDmQ8cPOKWaJUZYCpPjmEH+IbuEzDNaPwWLrcwYRVLafg9o3+EtW4IO0OpOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=ILHmruf0; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuRO/kze0TXji7HuXS/s1AXxof0h3L9NHjas8XSgiz9MO556IW1G+rZnbMZw1YVl4dAP9t3rVTbQ74uRCZU57p6NSQ+fjZFzggpuTSZYxbDcaqC23K515WJXsYniVS2La6csAJEhMUWIRix6ycZrRlWO1i3Azn0rfk73mQTlGVWrzny2CrWs1iMUtDhMi0PvsBNkBYKGmPxWxj5iqtu7K/hDZ7DOA9eMhNdZA0j8B2t0wyaAp633MfcGjCJFjJ2R7C2NIDVHHIN8Jiow7NGeBJVKJeMBQlA529oQ1QNY1aW3mkmDRJ8tuTP3/l3bUVWXQy9MX+2fDqZhOXt+Keh3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G200Zh1fhMwFVNqirGO7c3FqtZ5xjSRvGBqiYDiWBjk=;
 b=KW34J65IU4ahPTZQh/fwgB1MDB3mOheK1923VFhd4AUe8BsKGN5n+/J98m56bMTxCBbnKB0AVuSYtUkiWcLr3DxzyL1B5LYQI/cZjAfoZ465qvDZnsbyz7O448d1EKWtgNGY0qJtX+7YTPZRzmKeL4xs+e7eYP+rNbty07CAZ80xG8Cv546xOPcFrs3Kv/5cazOuEwpLnfG9/LqynnEIQgErPD1n5pbeWSKcWvD10kVbRHPcwIPDUUBTh5BhPXwLD+kxapBN0SXDGQXTLrAkrzLqkpatDbBrSU2EtgUtEXSPCtWz5aWEXS6Yo6zv2RrX+2GRTJWC+f7p++/ND8m8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G200Zh1fhMwFVNqirGO7c3FqtZ5xjSRvGBqiYDiWBjk=;
 b=ILHmruf0UxdCD5JGLE3AbvqPzpU0sH9xT6GrseQ1swEWGjxDrzcZDKSKlTAj7dtYcmJGfolSEAtoteqrksIEBhrlSYKLkyjxfC9/YI/QHRZrkEBI2123dc96XMoSQTDhIne27O+A4PjNypHFfvwbZza6ySEAOV99pX3l4osH9bg=
Received: from DU2PR04CA0164.eurprd04.prod.outlook.com (2603:10a6:10:2b0::19)
 by DBBPR03MB6857.eurprd03.prod.outlook.com (2603:10a6:10:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 07:59:02 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::7b) by DU2PR04CA0164.outlook.office365.com
 (2603:10a6:10:2b0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 07:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Mon, 30 Jun 2025 07:59:01 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 30 Jun
 2025 09:59:01 +0200
From: Christian Eggers <ceggers@arri.de>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH] Bluetooth: HCI: fix disabling of adv instance before updating params
Date: Mon, 30 Jun 2025 09:58:48 +0200
Message-ID: <20250630075848.14857-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9BF:EE_|DBBPR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 45437b42-664c-4bed-b57a-08ddb7abfa11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GKM9YOnbyoGAsLZ04mm1S3zJXqGBIqjskjTQZF16PYay3m3mi46/N0ZPb53A?=
 =?us-ascii?Q?sWPssxTrUzYwknXcvvEfkj22yIgW4RBLG9jY93pnlnn9gLrrZi0i9sSGDF1P?=
 =?us-ascii?Q?7m7xPDjcEYAWqyqQ5CPlhno6iNzsD5NgBTUU+H7Vw9UOOE//Ug5pY0wbPsUd?=
 =?us-ascii?Q?biTGLBXXRiFpgr1ycD4aEV7mxK2NDahGarOZy+ik3z3/YajiXFHeeprNLZps?=
 =?us-ascii?Q?eQVCxGH1AShgVCvZadsU9JMaxQ8EryPpo1C6502GWPC3i5Ny7oy9U8lNfKl/?=
 =?us-ascii?Q?Pz0MnRdDB5gEoxPCGCKcGrLbW4dXJ1j9XVTPjEneCqTh8pv31md+KGKUQC+E?=
 =?us-ascii?Q?Isx03TqNmp3NOANPkOggS2xSCtI6MopV3HT47cJGaeJpxo6Dzquz7uJLNBAs?=
 =?us-ascii?Q?sxmP8oEKGLWWXODZq/Ms4WI+FlM0Jm32CUAPiFq//dE5NLMr2+osykgwD6VF?=
 =?us-ascii?Q?A+SHyuypyoa1olytPLUTW+8vNJsbp0PSgSAWu1nl2hwFr3rDTokgGkqdlRBX?=
 =?us-ascii?Q?s89D3tPQCJujgMuM5IamohkUzwRm/hJcBkEkGVFPhPCB57WxSfGsbuDFhkTb?=
 =?us-ascii?Q?l6DW16V4s2hlcyUzlNiUbwj89xAt9AEYhjKDF+6Fch4ut+4DTTHf9yPtPz+T?=
 =?us-ascii?Q?giElO0vvxRUjmdL19ZM62X4oPK5e0wqq8xQiDZyBpbevhDS37rUz+aM+HZRC?=
 =?us-ascii?Q?5C27TYs+xSYjMsXsNCkpwtUUJwfheO0Lsd+tX5PuFnuwMmIShUVqfMuMvPz/?=
 =?us-ascii?Q?5Aydpk3R6n6ao3bV1ZJim8AFzhaeOFhD82W3pkcnzWXULNOS0YXTQwKqxGl4?=
 =?us-ascii?Q?SGjqNLP5RKUvkvGYtuE5hKH4E3NpjjeexKH7qV8+/GlaETrtZ4Ey3fC9QH1C?=
 =?us-ascii?Q?8Sum/JoFddHR7uCWgs/ThCAM/sWvprAwxrJJAdmpv8q2XVA9OaF7Wma7lU15?=
 =?us-ascii?Q?L5IXwEvmugqUy7catzccfDKRblLsPeg00uAb0NQG3HapaSZZiHxoCpD/GJxn?=
 =?us-ascii?Q?MVJHg6zZ96BQLxZ69sG2zJBwpW6pwLGeRLpOOjxfo0TvnsTNo7jab8enf4Bm?=
 =?us-ascii?Q?IgtS/jAbbs2D3omOZLe0aLzneKwvRvBDAh+ULHyg994AUbKH8LSl5wPGTS4y?=
 =?us-ascii?Q?WiWPAFL+mmyxhDzshUArrBrJbev8y2NytC4DtUwts31yKQCG2SCawM4n3Jo2?=
 =?us-ascii?Q?C0XINE+WenosGl5SNuwuud64K+7zsEH9eolDgQJ/2vyRqFXOLzgfHg8QVuiR?=
 =?us-ascii?Q?cQ81ak4mq1AGz9CKbBIaCXJAyM/OGxlhiNdhLwfKDUAzUCbEa3R6PXbBjwvi?=
 =?us-ascii?Q?roETzg/XdvW2W5MoQSy6G9f+TervGTInLjdCerajWRPz/4HhU0MlALGnzEZT?=
 =?us-ascii?Q?mQAPvOA5an0HY8zeKwyRrxpPybWlFvgNEkbPd8Kqne6U4IhZbqk9+nd4ux0Z?=
 =?us-ascii?Q?CuDbIdEUpVYPaxKv8EDh1rCIQLmUxx7r+S6qjTzGR7tmqDnjcpQ08IbPA8lq?=
 =?us-ascii?Q?P4AnyZqtYOuVR37vN7+0mDzM2+Rad3KTJ/l6?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 07:59:01.8504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45437b42-664c-4bed-b57a-08ddb7abfa11
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6857

struct adv_info::pending doesn't tell whether advertising is currently
enabled. This is already checked in hci_disable_ext_adv_instance_sync().

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 77b3691f3423..0066627c05eb 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1345,7 +1345,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	 * Command Disallowed error, so we must first disable the
 	 * instance if it is active.
 	 */
-	if (adv && !adv->pending) {
+	if (adv) {
 		err = hci_disable_ext_adv_instance_sync(hdev, instance);
 		if (err)
 			return err;
-- 
2.43.0


