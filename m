Return-Path: <netdev+bounces-29978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F5C7856AA
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B50280FEB
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C15BE5D;
	Wed, 23 Aug 2023 11:17:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6ABE52
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:17:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C35E5A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMLz9VVwzZ846Nipz18BP+fM11XKupY2FNY44HatDvAbMUuv4ZCWbNw608ag8X3AJVD5wawX4DpQPzUd5iyTIqFLlbewYZmTvDKpbJFtYcWkMFtcvO3H8zZMayRitm1H6INZOrSJWdtpIERsB/59QDa1uhAfzxSVGlvHbRFOTVCU2pqYB+nk4HaUtpw8EfcKeSR1qhY3ReKM8RY+nitILw1TCEPn/HgctdD3adNcyX0Oi8W0HN0VPhi+XUWIXW2YXyqMo44v2ZKb4Sj/O1spWuGHtZFhCwCI+xEDoroNV3aVFL4f1iPexiiKRBhKlQQlTUrjK3tYgBl3ByIATxtqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVzm8fshSXAC/fMZ7bV/4cp8LUNm134IeKvgRdIX0DU=;
 b=JZEX1YtVrGm3/RQbjIY3z9/PbXTw+JImwTEyAQUvbiwWxUwTMbPPLN47UxQ2bt4bSrcOrn+rt3aA43Jvezre914TsxcSYvH4tlwLtVanxLYb2rUBxnaPckjnt7bgrGABeulLiBJrEqGdOL7ZFxZQ/m41/X+HpaEXCe58CFuwVBbNZpPzZ7/ObeSQrV38mYLhC/7Wvh3/sRazhiYsWfAGEsgxOzBzSz7cdNVaw5MjslfbSVfWjR2fQAdD2KrY3ve0thvpj1lyk9aBaD49hYIbR+x1g7eRBlltDcT2n/AhkfM6XOukUmMXvnwN4eLFHwh8bQoD8QHxEeI+6zfHubPtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVzm8fshSXAC/fMZ7bV/4cp8LUNm134IeKvgRdIX0DU=;
 b=Hxa14lA/gfNcmn+x47//SHemsplmjQYlKln0Pv/3XB9MgBlHag2PQUpJ/Dp9FRhe/F5e6Fj2eDaKGfoZ7WMFHG081WcJEW9XHqGWsdoaNuUSxE5NKHWjxqr9BInEhSPEJ1sDLW7zNvpjPYyI1gmorhBX71dasCd4NLTbPfcacwI=
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 11:17:48 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::c1) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 11:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 11:17:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 06:17:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 06:17:42 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 23 Aug 2023 06:17:41 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 6/6] sfc: extend pedit add action to handle decrement ipv6 hop limit
Date: Wed, 23 Aug 2023 12:17:25 +0100
Message-ID: <20230823111725.28090-7-pieter.jansen-van-vuuren@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com>
References: <20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: 5419a54e-f563-448a-7153-08dba3ca952e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f+BByGDy1pkLUoRHNgIZhin4EaMIRIiTAMIRe0J5wiL9uEfaIDWicHaw8mNRPlZZUIu5UFxxS9t2XJXs4NMev44ItGhyj3Us0yCehjwBG8fLCx3+NmTyzALHu1LbotQL87xi0UB2Gmo1xALWx65nIFJdBiIR5Mt6ywyR4OQVGtX430UmBZRYi/qiod4bmQHwenOQNVz8wn0HGBWg2K/LC7xNXt2xixydLVWrjxGBPWVBajbz+1xHjTORcuL6oqW/ldjtrh4/0KGdmL37OHOb+c9tXRI0k+OFy+veQKsQJfPZaKbL9RwNBVHhgzXSEN9fmehwDiSk4/wZUawUwEv8IkBo+QpYMTnrz3r/MPEjlNCcfTiHUzVE9uH37v7VYMiDgmqR4CU+cVhy5TU+DnR7RAd6qfp+LR2nUXamksHah8JZ4Mg0rGdgK8J6EU6X3AlV8ShIg8k8MbuNHxLrBRdQQECE78ttdO7/kT0+CdMhh4Xz3VJebp4ss7WAcsb4sWciLkQrkhrTGcvndCy6rsUZkXxRo4fy5IcUe9wf/6g/+KW5s3gMfFBuCSjZ/Zef6RXur3X5d0ca51aEvoNisKWAPLjTx5HlebVf/r4zXDVUW5vckI64hwKEq/GpFTFKEuqnN6H2wtI6e75ZG4PysBVD6fC1ncbk9aK2EbJw6T3ckmBttgnJZ38htbyWD3yj2huT3RSyrgllFTm8i2D7wJ9f/YnzsUcpoBYG3hY3KN5NbMyWorEJeXSioGPWDE7a7zgpvlyrNpZT/gJR8dWDBRMQPQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(316002)(70586007)(70206006)(110136005)(6636002)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(81166007)(82740400003)(478600001)(6666004)(40480700001)(83380400001)(2906002)(47076005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 11:17:48.3220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5419a54e-f563-448a-7153-08dba3ca952e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 8ba5816b51f2..5be889f1b58f 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1097,6 +1097,31 @@ static int efx_tc_pedit_add(struct efx_nic *efx, struct efx_tc_action_set *act,
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


