Return-Path: <netdev+bounces-30323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA9786DDD
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF031C2030D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE87111A0;
	Thu, 24 Aug 2023 11:29:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA021119D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:29:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51610FE
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocw1rYdFSSqxIahGLUhSaJViLmAFcHpVD972gRCGn/1DTOOnxF3B2bQHUi0BGMY/uNrZLWqwJH9JHjzXjiJLcBAw5oxIwLQxbYyLNEiUnYAS8spIiJaWXKIJmYOZQkX8eL4Jqn1HAHzOu7wQlqlVifaYWsW77yeCym461livRvYtdXCtKLAMaJvuenHjryNVsPM7PLQnshnhrrfiioTljF5LAjIyO/oQh/uWXS9vGdrYZo7zAvuV6qj+GYveG613spUPAgYM3gY0Z7/LR+Uqn82SVaiXBVLPlsKLSzAl3Va96+6vgXwFmfbp4Xa1iA2gT6GeN/KO+KV4Qxqg4gUK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpPH5tPj0XGDgw1IR9nuqyAy/kzXVhlU8q/Bx+WiJz8=;
 b=ANRgn0VPypPNqvTZpTJzL3a+/lZy8ClV+yLC85jtz6R+at3tQLdllKsZlTYi5D7+9xkGDJUzn+M0P1SqED4uPR76Gtv8lPkm5FWUuyrjZYoHS+8PPtYvqSNWZZ7Tby9WPWGY68f2mfs28lyS1danaq/m0C0e4v3wjhM3V0xPLr/Zo4YcmLpKou7E7y4rwc5CWmVnRXHlfTuaKE+1/ksl77t9W1pA9Znv9QoooNOa3LG6/bkS/SpmIFA7NT5oDgYNskQ3ClXveVDhl7mp0vI8OkVfNJn2RfjnpNUJTIFwRSj1hcKXtXWTVGIrEBPpS6RQWJyWXHAA5ByvxW0UfLrv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpPH5tPj0XGDgw1IR9nuqyAy/kzXVhlU8q/Bx+WiJz8=;
 b=L4/3lZinCNZfxUZCA9+frjRORgLcKMAeLp366MMXnTO8vi/sfHbUgvbu+OMdUqkPRDDgZljR+c0YnG5VTEbWmXBkjH+QnMM3kO9YtfB7tN7gyn7GZ5KjU6+nG6YVYlHi8mhbKQBAnIqoaUnRhVsHMS/vEnWLefdVjCggjGXn1FQ=
Received: from CY5PR13CA0059.namprd13.prod.outlook.com (2603:10b6:930:11::20)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 11:29:04 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:11:cafe::72) by CY5PR13CA0059.outlook.office365.com
 (2603:10b6:930:11::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Thu, 24 Aug 2023 11:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 11:29:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:29:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 04:29:01 -0700
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 06:28:59 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next v2 6/6] sfc: extend pedit add action to handle decrement ipv6 hop limit
Date: Thu, 24 Aug 2023 12:28:42 +0100
Message-ID: <20230824112842.47883-7-pieter.jansen-van-vuuren@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>
References: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8cafff-3740-4459-b62d-08dba4955250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MFqfy63JnDqAi79Io4hXjCZLcqW5e8T8Y3mLtDCwapWAGyizu/z2TdT6JFhxYoJIynS/bleTaE3DF6zVhWZ9RcYrk76dlFpDPM9TSJ+d6hY3Ay/IJLNoNFP4LGXvZSEKzfv/fw4LJebWEGiby+8rYLsWQkXhKWjIostTFD79qgZRyEuRQ8F3C0HP5z8k++wKVFyj04B4kADINRMiHEoZoquLYRUcniKzIuQ2FXmhCRbA7WMJqU5T74pUe4Oqto42QUmZuY6TvBbaleixr0fI2yaBf+i/mVS+5ngcNAlp77379kj9VMMv1JO1e/XIc2W6oxjM4gEaUl5NU2gIDZLzD5IEo7evJ+tcgnWhSmpqm5ep4GGRJ5rKoxvh9NJJHMS0pgM9JpB6kV3B9NWm2eTLCTf8aGH8rphd3uA43m7OzIuqoW7y8aQ4yVPv5LqxBLHx4cm4vPZnq3OHejugBxpI9NWoJaHUjmqNYo7NyINLYShCQ5dMryXRg1NqcLAD294SJvyliS+t1sG1jVxf96DWsfl4hFc549aJtmyqI1rcEkNH6eWJCAut7I8gdahJYFSCIXdt/O1nKiPeRAzC3dlv6UZLSs7TEqt8v63B0PtUgK65Nx9PkZjRS+xxqFDxcuJTESuVbrcAVl2QM8pRonzROZTQS6+seS0rrdqP2UlVKkUYP0m9slN6aRGEKA9R7ps1T/NpjK60bivBcXLfrMA+ZV8LJ6izHiuDyTPlb5+fkpWDzXRNG+rkhjmzwQz2lNpEOKZ+/Sx2sas26E3hcA21Fg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(40480700001)(83380400001)(336012)(426003)(26005)(36860700001)(86362001)(47076005)(8676002)(8936002)(2616005)(4326008)(70586007)(316002)(54906003)(110136005)(6636002)(70206006)(478600001)(82740400003)(356005)(81166007)(6666004)(41300700001)(36756003)(40460700003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:29:04.0067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8cafff-3740-4459-b62d-08dba4955250
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend the pedit add actions to handle this case for ipv6. Similar to ipv4
dec ttl, decrementing ipv6 hop limit can be achieved by adding 0xff to the
hop limit field.

Co-developed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/tc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index dfe3a8bf74f0..047322b04d4f 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1084,6 +1084,31 @@ static int efx_tc_pedit_add(struct efx_nic *efx, struct efx_tc_action_set *act,
 			break;
 		}
 		break;
+	case FLOW_ACT_MANGLE_HDR_TYPE_IP6:
+		switch (fa->mangle.offset) {
+		case round_down(offsetof(struct ipv6hdr, hop_limit), 4):
+			/* check that pedit applies to hoplimit only */
+			if (fa->mangle.mask != EFX_TC_HDR_TYPE_HLIMIT_MASK)
+				break;
+
+			/* Adding 0xff is equivalent to decrementing the hoplimit.
+			 * Other added values are not supported.
+			 */
+			if ((fa->mangle.val >> 24) != U8_MAX)
+				break;
+
+			/* check that we do not decrement hoplimit twice */
+			if (!efx_tc_flower_action_order_ok(act,
+							   EFX_TC_AO_DEC_TTL)) {
+				NL_SET_ERR_MSG_MOD(extack, "Unsupported: multiple dec ttl");
+				return -EOPNOTSUPP;
+			}
+			act->do_ttl_dec = 1;
+			return 0;
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.17.1


