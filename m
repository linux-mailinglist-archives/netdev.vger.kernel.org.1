Return-Path: <netdev+bounces-48555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8AF7EEC7E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 08:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BACC1C20947
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 07:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF4DDA7;
	Fri, 17 Nov 2023 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="OPurkXyW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2116.outbound.protection.outlook.com [40.107.95.116])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08046D51
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 23:11:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb3FNEQaR7vHcXaDRK24jaa5EubU5MDTrv2Z5a359cBvZogK8PqUAaK7efgnbURP1NqqQC9kJjiuvhK2SWA//oz9PRV6vimWLGrAAdW4mNdZWIf3oKq3JERLSOfORa4goFHWdQYekdR/xC2i/0IeZbVFT/1Ht9p1ao5KfnoCtI7Q8WeAp5gR3Y83KQ2QOOCMMhK0QRbyyGyMuNwL0UJaTBa8hZhLRepsPbpZ3Ws2Ewn/OWT69PgForGtCxkaqp6dEyE8uh6vmjC+3v/v2tqTtB3rUSzIu4DADua8VTyAm3wXPgTOTPZTXR9XUtGv/HHiLPuilThB4trcb+VXwQJeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c71Ets+7/bKQsEEPE4A6Hbw6aFT9NFeog8N6MbFSveU=;
 b=fa8ND0krd0R7dYLvHrXzg95MXRUkbOH7IyK/UjIEhYOTEa/VhS8eYG+36jjI8ON07PGwbor3nv8ODhiVjsw+aVLD4jChq4P6h8c1ZYbbiM8R2qPaCJOomzNDJ1bnaHTlZxTgCCQVmpsAS+011mNdjYLuRt6v6bu3WxaWF0RpXySxL+2otAEhHow4LYZczWR0bBYAwOjwUIWDGIpJ8XCwiz/+ISk+iDfZuK75azniwM8dfW7SBImBgP+DlP94j8KqldfPny2Jq2tso5hiKrVDNXj/Q7sBF5uCiH5fvfMvCTc8JfpRjQch3dnrzPfnw4fVjG3PB8czD8FKVlgDUXmDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c71Ets+7/bKQsEEPE4A6Hbw6aFT9NFeog8N6MbFSveU=;
 b=OPurkXyWT2cZLoMzH7KOIsynF2ef8L1Hc1vYsKDPuhkpnhKiWBMwsFjXM6sPmsfyz0CZT3zpD5AZDfc3+NJlS274hAn8weWYIpo304xf0mu0nc5Gx4OnORdjyb5suIs8qjYvESulUMsVYbn7ePyaiKOqFST4xz61fRXvfxghH0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH2PR13MB4553.namprd13.prod.outlook.com (2603:10b6:610:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 07:11:49 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 07:11:49 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yinjun Zhang <yinjun.zhang@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 2/2] nfp: offload flow steering to the nfp
Date: Fri, 17 Nov 2023 09:11:14 +0200
Message-Id: <20231117071114.10667-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117071114.10667-1-louis.peens@corigine.com>
References: <20231117071114.10667-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH2PR13MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f623cbd-eb83-4089-49ef-08dbe73c775f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wj9CYGXn9p1493gTt9mVmZRffSj4nMJQNcz9TqIyVggDZnJoNRkcREEbPkl9QtLDiHZgMlnpYO9zVeRf6jj6b2hOIF6h1Pj2HTActCq9YyBXGr764crdD0CBs/jchVYthsV7KLbA9mC5kwXocrXG6kYIKE0186OIF8T9LhVr2TDZCnVLuLD89MFEcsQAAvsjtBixRk/Zb+JeSy2pkjnFwJDM9pA5CSix+M9P+lfstRMcKvJWpHWWT8qe75vvbzhqHB4nERyRqiUOiFwcI2xymEVY3ZxPHRQjUTWhrPTzhDqTT5RGb7uhgd2A7drUIpgwXQTcTHazawKfyYD+IgMO9CtkNew2k+ilISmXBpjHQf9SPXhhc3sBm90JzJkgTSBY/ly4PH1dP/y+ns4X3tiaQlx8db52BnfWkq9IgG/RscC86cd4zCsP0t7YKPffB/qHSRDQef17JeCBfSts5A3CWUVoZGhN0Pfn6iuvt472FzzgPenLbbhXm6kip32I7AGjs3JloxW2kWvKyLs/ese2TeHmpeiaScGrCRZZnR+ZmZ4dl3Ft5Jq27gjat1VUzwStok27L10ZP+U7fnz5tVzVtU4+thWX3Fx6vnS+wLy+6czQZs5/3pPlmuThvee5yw6HSS8+i1VyHkOVYrQebeF5zZ56Zdiy8Teyjx+qCNf3AqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66946007)(66476007)(66556008)(110136005)(316002)(2616005)(26005)(107886003)(1076003)(478600001)(83380400001)(38350700005)(6666004)(6506007)(6512007)(6486002)(36756003)(52116002)(38100700002)(5660300002)(44832011)(2906002)(41300700001)(8676002)(86362001)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fr0LLIDfLRkkVadOBqQT20umds32KDT++qBM8NG3TU3dDCaPYHj/LU+GiKB8?=
 =?us-ascii?Q?470ZFXKLjZSyF2w5SEXrS8eBwJO5hMlrf502zZEdEBi0pW+NgJ2BiyJBN9xC?=
 =?us-ascii?Q?0wq8MQivu8QGnbiq9kaWE9kigHpPy2AIxHKqq/lmPWN7vlY2sY4lt59nfTB5?=
 =?us-ascii?Q?pJmqUknCkIvlyrcBmDDZnZvXzhJ0DrPAbuvk3RNYY/Fh3vGpRgZIqvO0Jm5y?=
 =?us-ascii?Q?AuRbScN1dYb1Nwv0UnxBfNA/W0mRBD1/4rxx9GXZwGEfBqeLlGwP9Hi+c/tV?=
 =?us-ascii?Q?n2fRROiAELzaz/lZ1sUkxzpGcY4yWQD+jHpiHQvo0L+V58j1x/SCp35yZY6x?=
 =?us-ascii?Q?dWTlHmtrJbvi7z5Ueg3JOegaGbIsNSe0aMlgxhs8kks5HDBitL1gzU0pGiCE?=
 =?us-ascii?Q?U2zcLVtYnhwt8q3gWRmaSmABB/Gk9w2JVWrADVKFgNjmgZzqVhbYogKKotq+?=
 =?us-ascii?Q?kIy8NHmWOtK7c5Kgdvkmi1idyYfff16WUcoFAvPDDbLDz2wv9htOgS4T3ycT?=
 =?us-ascii?Q?KWvtm6NwNDSwi5f/rPpXUcEcTKIa4O9kh710OOrb2ExKCJ8CTouvxtWEkzja?=
 =?us-ascii?Q?sj+luhIH1SlligdzzQ7LUj2hzlm/vM1YwqE460TdEC36sY+r3DA812bxkhmM?=
 =?us-ascii?Q?v6X4gRxQQsKWhmGVXs4H5DKmk5UuvtmueWOG2myKdUNNTmgBwttENEwoXqVT?=
 =?us-ascii?Q?MGLcS2ysyS0uSSkISkcRR74NrNl37qchK73VG+f1t0L1VYB5dS/yTl2xs6bl?=
 =?us-ascii?Q?lbaq0F+ljuwalYEQJD6vEHsQjy8+UilBzYgxjnofd4g8PCjtOxZflvn9NUta?=
 =?us-ascii?Q?qxUpzQlvNVxweJHBbogq6Y8leUNz5VIgV7FFWjUp++30EvDtKfwj/c6OTyqG?=
 =?us-ascii?Q?1b6WfeK9TjrlmOv0CZotOrG+AsOoNxtLCTna7VQji8SNLyvI6etkz+JfYdF+?=
 =?us-ascii?Q?9WB83ZV7DHelltwKPLGWm4A0TlgyZxlPtJYAapMyy1thuwF3uPatptDTKSeb?=
 =?us-ascii?Q?Hkd3flHpGx75BJ2/MR4wmw2AYVhdxQH3n8W6bLNS/fTsgdIYyN2MXjwXTlNA?=
 =?us-ascii?Q?xelmUW7COM+DCPMkuK9iMIyj6T2D3WkjvYP4oOBBz+yDLjj3NWi05ypGLqHb?=
 =?us-ascii?Q?nT88aBzIMpI3ZyzJP/Pxu9g8MTm7SN5lzKqanguAKcapfPms2ug7qyHEfODC?=
 =?us-ascii?Q?HR4u8DXnFpFDrQ3kweY0KuSEdYh6u+csw+IooBHt3mUsajEFMs1+u91E4T1V?=
 =?us-ascii?Q?9TVFgGq27Mwv03roOdgq9zdAgzuMQX5FDO6Vca8hz0pJiaYA49beUrftYegs?=
 =?us-ascii?Q?UOX15jZgl/95W9waTJT3i9a/bbw7JbY9GnLHeIrGLwChgDzABSpJZbh+4+Wj?=
 =?us-ascii?Q?Z1eC0VcjOwn1w4DfP2Ts1q8xn6YMZrCOOxwq93NHrb2ZVElcV3rCmgs+PIoj?=
 =?us-ascii?Q?GeE8AugXH5SVFXXdM2PeqeJ0ShDooFxeb4SR7b17zhLoleoZHu/0tGurNfil?=
 =?us-ascii?Q?HCgB4XwIB1IEcGT/ZQ00OLg9QIFYee3Nm0K4bHZ/A8vaL9QcnbFa4h4R3Eba?=
 =?us-ascii?Q?olJula39X9nXtjfy7GoxLiU9ztrVTsOiACs+zA2vCrmg8Ygk/+ywpFASX9aQ?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f623cbd-eb83-4089-49ef-08dbe73c775f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 07:11:49.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bd+r7YfKuZcrW6d6ZKFras4OzOXHwffLBqncHnjNGzYR1vV0n3Blp/WYPVMGNwRwO2AWjwrgSgfRVI1f4KAyWH2pAR8VoxV7KkW02dYMGmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4553

From: Yinjun Zhang <yinjun.zhang@corigine.com>

This is the second part to implement flow steering. Mailbox is used
for the communication between driver and HW.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../ethernet/netronome/nfp/nfp_net_common.c   | 163 +++++++++++++++++-
 .../net/ethernet/netronome/nfp/nfp_net_ctrl.h |  14 ++
 2 files changed, 175 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 12eda2c2ac23..ac1f4514b1d0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1763,14 +1763,173 @@ nfp_net_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 	return nfp_net_mbox_reconfig_and_unlock(nn, cmd);
 }
 
+static void
+nfp_net_fs_fill_v4(struct nfp_net *nn, struct nfp_fs_entry *entry, u32 op, u32 *addr)
+{
+	unsigned int i;
+
+	union {
+		struct {
+			__be16 loc;
+			u8 k_proto, m_proto;
+			__be32 k_sip, m_sip, k_dip, m_dip;
+			__be16 k_sport, m_sport, k_dport, m_dport;
+		};
+		__be32 val[7];
+	} v4_rule;
+
+	nn_writel(nn, *addr, op);
+	*addr += sizeof(u32);
+
+	v4_rule.loc     = cpu_to_be16(entry->loc);
+	v4_rule.k_proto = entry->key.l4_proto;
+	v4_rule.m_proto = entry->msk.l4_proto;
+	v4_rule.k_sip   = entry->key.sip4;
+	v4_rule.m_sip   = entry->msk.sip4;
+	v4_rule.k_dip   = entry->key.dip4;
+	v4_rule.m_dip   = entry->msk.dip4;
+	v4_rule.k_sport = entry->key.sport;
+	v4_rule.m_sport = entry->msk.sport;
+	v4_rule.k_dport = entry->key.dport;
+	v4_rule.m_dport = entry->msk.dport;
+
+	for (i = 0; i < ARRAY_SIZE(v4_rule.val); i++, *addr += sizeof(__be32))
+		nn_writel(nn, *addr, be32_to_cpu(v4_rule.val[i]));
+}
+
+static void
+nfp_net_fs_fill_v6(struct nfp_net *nn, struct nfp_fs_entry *entry, u32 op, u32 *addr)
+{
+	unsigned int i;
+
+	union {
+		struct {
+			__be16 loc;
+			u8 k_proto, m_proto;
+			__be32 k_sip[4], m_sip[4], k_dip[4], m_dip[4];
+			__be16 k_sport, m_sport, k_dport, m_dport;
+		};
+		__be32 val[19];
+	} v6_rule;
+
+	nn_writel(nn, *addr, op);
+	*addr += sizeof(u32);
+
+	v6_rule.loc     = cpu_to_be16(entry->loc);
+	v6_rule.k_proto = entry->key.l4_proto;
+	v6_rule.m_proto = entry->msk.l4_proto;
+	for (i = 0; i < 4; i++) {
+		v6_rule.k_sip[i] = entry->key.sip6[i];
+		v6_rule.m_sip[i] = entry->msk.sip6[i];
+		v6_rule.k_dip[i] = entry->key.dip6[i];
+		v6_rule.m_dip[i] = entry->msk.dip6[i];
+	}
+	v6_rule.k_sport = entry->key.sport;
+	v6_rule.m_sport = entry->msk.sport;
+	v6_rule.k_dport = entry->key.dport;
+	v6_rule.m_dport = entry->msk.dport;
+
+	for (i = 0; i < ARRAY_SIZE(v6_rule.val); i++, *addr += sizeof(__be32))
+		nn_writel(nn, *addr, be32_to_cpu(v6_rule.val[i]));
+}
+
+#define NFP_FS_QUEUE_ID	GENMASK(22, 16)
+#define NFP_FS_ACT	GENMASK(15, 0)
+#define NFP_FS_ACT_DROP	BIT(0)
+#define NFP_FS_ACT_Q	BIT(1)
+static void
+nfp_net_fs_fill_act(struct nfp_net *nn, struct nfp_fs_entry *entry, u32 addr)
+{
+	u32 action = 0; /* 0 means default passthrough */
+
+	if (entry->action == RX_CLS_FLOW_DISC)
+		action = NFP_FS_ACT_DROP;
+	else if (!(entry->flow_type & FLOW_RSS))
+		action = FIELD_PREP(NFP_FS_QUEUE_ID, entry->action) | NFP_FS_ACT_Q;
+
+	nn_writel(nn, addr, action);
+}
+
 int nfp_net_fs_add_hw(struct nfp_net *nn, struct nfp_fs_entry *entry)
 {
-	return -EOPNOTSUPP;
+	u32 addr = nn->tlv_caps.mbox_off + NFP_NET_CFG_MBOX_SIMPLE_VAL;
+	int err;
+
+	err = nfp_net_mbox_lock(nn, NFP_NET_CFG_FS_SZ);
+	if (err)
+		return err;
+
+	switch (entry->flow_type & ~FLOW_RSS) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+	case IPV4_USER_FLOW:
+		nfp_net_fs_fill_v4(nn, entry, NFP_NET_CFG_MBOX_CMD_FS_ADD_V4, &addr);
+		break;
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+	case IPV6_USER_FLOW:
+		nfp_net_fs_fill_v6(nn, entry, NFP_NET_CFG_MBOX_CMD_FS_ADD_V6, &addr);
+		break;
+	case ETHER_FLOW:
+		nn_writel(nn, addr, NFP_NET_CFG_MBOX_CMD_FS_ADD_ETHTYPE);
+		addr += sizeof(u32);
+		nn_writew(nn, addr, be16_to_cpu(entry->key.l3_proto));
+		addr += sizeof(u32);
+		break;
+	}
+
+	nfp_net_fs_fill_act(nn, entry, addr);
+
+	err = nfp_net_mbox_reconfig_and_unlock(nn, NFP_NET_CFG_MBOX_CMD_FLOW_STEER);
+	if (err) {
+		nn_err(nn, "Add new fs rule failed with %d\n", err);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 int nfp_net_fs_del_hw(struct nfp_net *nn, struct nfp_fs_entry *entry)
 {
-	return -EOPNOTSUPP;
+	u32 addr = nn->tlv_caps.mbox_off + NFP_NET_CFG_MBOX_SIMPLE_VAL;
+	int err;
+
+	err = nfp_net_mbox_lock(nn, NFP_NET_CFG_FS_SZ);
+	if (err)
+		return err;
+
+	switch (entry->flow_type & ~FLOW_RSS) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+	case IPV4_USER_FLOW:
+		nfp_net_fs_fill_v4(nn, entry, NFP_NET_CFG_MBOX_CMD_FS_DEL_V4, &addr);
+		break;
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+	case IPV6_USER_FLOW:
+		nfp_net_fs_fill_v6(nn, entry, NFP_NET_CFG_MBOX_CMD_FS_DEL_V6, &addr);
+		break;
+	case ETHER_FLOW:
+		nn_writel(nn, addr, NFP_NET_CFG_MBOX_CMD_FS_DEL_ETHTYPE);
+		addr += sizeof(u32);
+		nn_writew(nn, addr, be16_to_cpu(entry->key.l3_proto));
+		addr += sizeof(u32);
+		break;
+	}
+
+	nfp_net_fs_fill_act(nn, entry, addr);
+
+	err = nfp_net_mbox_reconfig_and_unlock(nn, NFP_NET_CFG_MBOX_CMD_FLOW_STEER);
+	if (err) {
+		nn_err(nn, "Delete fs rule failed with %d\n", err);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static void nfp_net_fs_clean(struct nfp_net *nn)
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
index 515472924a5d..eaf4d3c499d1 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
@@ -419,6 +419,8 @@
 #define NFP_NET_CFG_MBOX_CMD_MULTICAST_ADD		8
 #define NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL		9
 
+#define NFP_NET_CFG_MBOX_CMD_FLOW_STEER			10
+
 /* VLAN filtering using general use mailbox
  * %NFP_NET_CFG_VLAN_FILTER:		Base address of VLAN filter mailbox
  * %NFP_NET_CFG_VLAN_FILTER_VID:	VLAN ID to filter
@@ -441,6 +443,18 @@
 #define NFP_NET_CFG_MULTICAST_MAC_LO	(NFP_NET_CFG_MULTICAST + 6)
 #define NFP_NET_CFG_MULTICAST_SZ	0x0006
 
+/* Max size of FS rules in bytes */
+#define NFP_NET_CFG_FS_SZ		0x0054
+/* Sub commands for FS */
+enum {
+	NFP_NET_CFG_MBOX_CMD_FS_ADD_V4,
+	NFP_NET_CFG_MBOX_CMD_FS_DEL_V4,
+	NFP_NET_CFG_MBOX_CMD_FS_ADD_V6,
+	NFP_NET_CFG_MBOX_CMD_FS_DEL_V6,
+	NFP_NET_CFG_MBOX_CMD_FS_ADD_ETHTYPE,
+	NFP_NET_CFG_MBOX_CMD_FS_DEL_ETHTYPE,
+};
+
 /* TLV capabilities
  * %NFP_NET_CFG_TLV_TYPE:	Offset of type within the TLV
  * %NFP_NET_CFG_TLV_TYPE_REQUIRED: Driver must be able to parse the TLV
-- 
2.34.1


