Return-Path: <netdev+bounces-34829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBAB7A55B6
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 00:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619E31C20B02
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3E341A0;
	Mon, 18 Sep 2023 22:22:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01531A7E
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 22:22:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F99BE
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkoHOg2GyjSlrHTaPrIhASxZ3k5LbziZrZGaix147bqA4zvoFMM8pbWa6hcTdk0z3OWW8Fe81VOiK4uJOTwhwKVae6ZJBXogGVx6eqh1pMg/dM5nldTWkCgpPtqWNeHOO/N6dxfYK4g1zqJl6etgXqaCA/wTcZtOb61lFSbz3+cUiD65mUB5etLWYilEMtIi+KAHxK7hHi/qN+AvhOkwAVRtheDNjsmeaS3MTRHH7L6Z5V395pa03575Hlp4ud6e38lnjcM+/iSswOzEHec87iZWM6QQIzpyx+zotiVilEV53QT6M/6Ry7v8uqnuvdzR87eYtAwtemptuxXs/VSE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkJOjoIQT+LzvLymrZxwrHuYwDcuApNpSxGe+3YQsPI=;
 b=C3Y+OxeVJhLebPYo2DDkWAWniYrs53PpaT2y8s76CC+3khao/7UUH9DhPTcr6DGTGyRNa7bbqkuHVw+do3Zm8x7gEUkpG27kPr7ps0VZwtCgR/KgoUS0/nXyTkSv43ri1IEm/DYd5s6cK0EF1v7XhkZTkClF/Gxv+6zVBFmD0dDGETw0eHjKB3HpO3DVS6KOSyENjtUROvD0YayKmImo9OmwIsnR8NUpJrjEhLZf0GsooCijVlDbnkyWvaUhj44R8cjMuTbRkZQa5GW5//B3UDu5yNQ0U+8edoeRyuyhTuy55dJZSdUKM11ekWfrrSdRw/x4VdKoPtum0bC4TatV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkJOjoIQT+LzvLymrZxwrHuYwDcuApNpSxGe+3YQsPI=;
 b=UskAOQcbC6BR46qY6RcliQJx/QvGpr1iFLVbpKO4L5Jv+W4sO7ALALgGQB9KSk+edle1dIRjcRaejkzhy5zg21+YwYaDVtuJgqw0FaWMS6GWED7AzsBDq/ltzhzDYMApHHyK82sdRDBCbNQkTN7z1rnooTioUCr54AZeAOqph9w=
Received: from MN2PR15CA0015.namprd15.prod.outlook.com (2603:10b6:208:1b4::28)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 22:21:56 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::66) by MN2PR15CA0015.outlook.office365.com
 (2603:10b6:208:1b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 22:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 22:21:56 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 17:21:55 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 1/3] ionic: count SGs in packet to minimize linearize
Date: Mon, 18 Sep 2023 15:21:34 -0700
Message-ID: <20230918222136.40251-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918222136.40251-1-shannon.nelson@amd.com>
References: <20230918222136.40251-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: e3acb21d-76aa-49ea-beb5-08dbb895ab66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	63WSmpzpcktCxO8qLukVCf4XutmzlwI6N3cu82fGWoUO+52xVHUxsPJMTpjvukV2SyRfY1UbBY1rnqruprG4E9XfcbKMJw1dkF7FCfrxae7HOGbRnTf4rocB5Mm3BS9Lrkw82DWNwbr2J4SOJmszE12QhwIwObX0uPhp54F65x8f/y5Bo/W4TKudf0lfdDX/lUzQERs+RNT7oxk8sNxV9XwOsdrfX/m0+01yI6esnk2XdglUqbsQ8IddzJ06gqH7hd0xqkpqId2Td67qYOaeUTE2qCNzerrpQdJy9FOZISksZ2NlaHYzCJG8UhZ+w81f3uomj7MBC6vPDraojCMDvedPYl6NWIa1OWfci8RQunyB5Y1Ol2QowYs6DkpFyyvNdlq0KIAgbMRBzvUjfJ+p9G2bTZDoPO/1gN0bcgIgvqQzIU6h6BE+eewFtTYmwH1D5eN2ZsN+tVF48U9Qmlm4wID4CQ6CavVh/aoEiCjVyBuRgYzQGq+rwfPlmPTSSs37qT5QMYV+BYraCC8veR2dwU1ssxeLlTmKb2JEIH9qme7ZY3eeWmvkOEor1bLOGdE6q07IkouAiIAN7dS4gJUs2K8mxGEjan/W88ZMrAGSkIYl9Ov4D03XiPmUNygITB1yzkf9YASYcvCRLvGj6qpT+Pb6eDG0+jQP8/Ak6rv6mPEXcDoVrdZUxzzJtm5KpvjFWTE3VKIT793N94XynckR9en0kN+oZaznjvBHpWg0E3y1WP2sSz+XQSpLUP2rZpXXyhfhc/rHnRiYy6CdNmpV1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(356005)(81166007)(26005)(16526019)(82740400003)(2616005)(8936002)(8676002)(1076003)(4326008)(40460700003)(83380400001)(36860700001)(2906002)(36756003)(47076005)(426003)(336012)(40480700001)(5660300002)(44832011)(86362001)(478600001)(6666004)(316002)(54906003)(70206006)(70586007)(110136005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 22:21:56.7863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3acb21d-76aa-49ea-beb5-08dbb895ab66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are some cases where an skb carries more frags than the
number of SGs that ionic can support per descriptor - this
forces the driver to linearize the skb.  However, if this
is a TSO packet that is going to become multiple descriptors
(one per MTU-sized packet) and spread the frags across them,
this time-consuming linearization is likely not necessary.

We scan the frag list and count up the number of SGs that
would be created for each descriptor that would be generated,
and only linearize if we hit the SG limit on a descriptor.
In most cases, we won't even get to the frag list scan, so
this doesn't affect typical traffic.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 77 ++++++++++++++++---
 1 file changed, 68 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 26798fc635db..c08a61323066 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1239,25 +1239,84 @@ static int ionic_tx(struct ionic_queue *q, struct sk_buff *skb)
 static int ionic_tx_descs_needed(struct ionic_queue *q, struct sk_buff *skb)
 {
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
+	bool too_many_frags = false;
+	skb_frag_t *frag;
+	int desc_bufs;
+	int chunk_len;
+	int frag_rem;
+	int tso_rem;
+	int seg_rem;
+	bool encap;
+	int hdrlen;
 	int ndescs;
 	int err;
 
 	/* Each desc is mss long max, so a descriptor for each gso_seg */
-	if (skb_is_gso(skb))
+	if (skb_is_gso(skb)) {
 		ndescs = skb_shinfo(skb)->gso_segs;
-	else
+	} else {
 		ndescs = 1;
+		if (skb_shinfo(skb)->nr_frags > q->max_sg_elems) {
+			too_many_frags = true;
+			goto linearize;
+		}
+	}
 
-	/* If non-TSO, just need 1 desc and nr_frags sg elems */
-	if (skb_shinfo(skb)->nr_frags <= q->max_sg_elems)
+	/* If non-TSO, or no frags to check, we're done */
+	if (!skb_is_gso(skb) || !skb_shinfo(skb)->nr_frags)
 		return ndescs;
 
-	/* Too many frags, so linearize */
-	err = skb_linearize(skb);
-	if (err)
-		return err;
+	/* We need to scan the skb to be sure that none of the MTU sized
+	 * packets in the TSO will require more sgs per descriptor than we
+	 * can support.  We loop through the frags, add up the lengths for
+	 * a packet, and count the number of sgs used per packet.
+	 */
+	tso_rem = skb->len;
+	frag = skb_shinfo(skb)->frags;
+	encap = skb->encapsulation;
+
+	/* start with just hdr in first part of first descriptor */
+	if (encap)
+		hdrlen = skb_inner_tcp_all_headers(skb);
+	else
+		hdrlen = skb_tcp_all_headers(skb);
+	seg_rem = min_t(int, tso_rem, hdrlen + skb_shinfo(skb)->gso_size);
+	frag_rem = hdrlen;
+
+	while (tso_rem > 0) {
+		desc_bufs = 0;
+		while (seg_rem > 0) {
+			desc_bufs++;
+
+			/* We add the +1 because we can take buffers for one
+			 * more than we have SGs: one for the initial desc data
+			 * in addition to the SG segments that might follow.
+			 */
+			if (desc_bufs > q->max_sg_elems + 1) {
+				too_many_frags = true;
+				goto linearize;
+			}
+
+			if (frag_rem == 0) {
+				frag_rem = skb_frag_size(frag);
+				frag++;
+			}
+			chunk_len = min(frag_rem, seg_rem);
+			frag_rem -= chunk_len;
+			tso_rem -= chunk_len;
+			seg_rem -= chunk_len;
+		}
+
+		seg_rem = min_t(int, tso_rem, skb_shinfo(skb)->gso_size);
+	}
 
-	stats->linearize++;
+linearize:
+	if (too_many_frags) {
+		err = skb_linearize(skb);
+		if (err)
+			return err;
+		stats->linearize++;
+	}
 
 	return ndescs;
 }
-- 
2.17.1


