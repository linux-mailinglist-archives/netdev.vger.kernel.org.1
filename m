Return-Path: <netdev+bounces-39721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B117C42FF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0DA281D3D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26832C66;
	Tue, 10 Oct 2023 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M9BG4mFr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A232C60
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 21:52:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE9794
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6/B/4VAEEU4i2GovJw7NL9eWMaY0wiR4Bt5nJl6pq4j5zLTGtEyjG1NtwHRm1btkxJRAKLLRdbiyIqCp9bODFH0UOr9z24lO/cpCKpaJ7t4Q/4p+4q4DAXvfy0pHNsKI/GT1GGlOA5EHpQsLHmV+YrNs6z6MBNT1whTHgyfgXTD+Gy8FJ/WpHbXwfNcBbwKG/zJAkHFi4+6TnUCiiZR9GZMOxwoB2681LU+7YrfV3LEuheBMXZVkBj/5JzSVqZAwjS87Pli1kLgD1SZRfHTvNzFBU0BhNV1MaSIl1LB3MN6bzgAUm6Urf3OHSCw3KVafAWBuCb+X/TiU6jEwX5HGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmWVkWXuQHRIOJ7yU5nFsqRP5NzzoDg+iBvaKlElibo=;
 b=mhPFU+0du04hvwe7rdFXZSmtz0fVH+cSBy6HqKGu9p6BPhotyz5y87mO7qNNM+RJ3oDs0USXJKqG8sE1U66Ouq+xn91TSgV1ApcDGHT/lHN2XKlvH0NrTUoC6H8eZCXz4T1ICDVSGvQYvvqk/i2ebg2Vft8srshFhT3gJ2bsD/TTyWJocLQoINIYnSHoT/Uy/ozcliCT96BBbktJdo8iFUF0FnPy1KMWnk5VXOpJd67ISkoNj37wTHwQRtATJd4i4k1ya8nHwuWZ3QoLxkeUkwKo2MeHJco5l1VXlnChXGFx+CLDaj8/crF5yBKG634zcod+Yex5j1R4u8SqL8JbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmWVkWXuQHRIOJ7yU5nFsqRP5NzzoDg+iBvaKlElibo=;
 b=M9BG4mFrTnOZaQ84M6n7OlClYHD6x1ExP+QRuRDkUG1EKwPwWnT9auAweL3HacD2hs8KRFbB6I8qLYIkwwYEHfNirLfQ4VFee0dKdTujSNRTEfFVn5wovT8vnEXaAO/M7F++Pzu1/kpVmYr+I4UIDENYBbu7PPNkN5UpJ9BLEfs=
Received: from SA9PR10CA0010.namprd10.prod.outlook.com (2603:10b6:806:a7::15)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 21:52:46 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::4f) by SA9PR10CA0010.outlook.office365.com
 (2603:10b6:806:a7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 21:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 21:52:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 16:52:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 16:52:45 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 10 Oct 2023 16:52:44 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 2/2] sfc: support offloading ct(nat) action in RHS rules
Date: Tue, 10 Oct 2023 22:52:00 +0100
Message-ID: <23f5df0174faffaea27945bec668094e26c2b4ed.1696974554.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1696974554.git.ecree.xilinx@gmail.com>
References: <cover.1696974554.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fec949-f569-442e-3ef0-08dbc9db3ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ycsxGNR44XzYUAFtebeR0H9/PI8dIQtPwaEoJDJeBT5jmEChm3NkCU+dvu9z6w4xYqM1HixQCRJDcS+ZvFczNkNHdHFUeww+ikXX93GxrujS4+RJVBWYlxaGNUnguyt5TuRFDS674aqyDuA/VEfoWj2IJOtrcBtdqgXZduhWu9mXHrbe83DzbQ5UEprrCGMk+Fu2E0H7ZEm+WTsQ1NdT1KydmnrnKk7l9yEA+Dlv4rm0sMvJ/nBv2yNGXpFc+9gHX4+Reg7VGsk4ZlWaljIZgZ4TgGxlNu+8LbK5axdmnVZtwxkeLeuQ47n+qedeykmez3unwHWppf9WZsG1wBeZxvOeN7gidXFhFEHIvKsbKxSzwVedsy61I9uVx8cTJf9GCjfikIQAmhuNGtygHrDBzIv5Qu1MMhrSZl2nhXOjBZhqVwVzXwlZICVoPgg7elSbTev5XJ+4RGKyAVqU34zx5d9ZIfwd8zzml/dEXR4nQu9Ug8wn7hjsTBQr8GSFa7O4nJuZO0JEDszgCtObJHxjxdvqACvqtkemGp/050HwjVk5tc1maloj7I8rj+XOuMFOXmJib1H/TY9QpNvlbmQr67Wrx0K/bVIBLnGFU5/RfXOR8ilkzupfJbJ6pnhBpcGcx4AMPvVJSanjNk1yJuDbr0XqpOGlawGv6mNykLm2yjW53OiSqE/+eyHlsHd23wPBjX1zYbLRyMFG5pqJJVZQDCz/ZRlix2CmXC0fsFmlVvHOE+KAykheQ98j5rolgynik2a23bxldNrfDQh7zf9Ntw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(64100799003)(186009)(46966006)(40470700004)(36840700001)(2876002)(55446002)(40460700003)(86362001)(47076005)(2906002)(36860700001)(356005)(81166007)(82740400003)(40480700001)(9686003)(70206006)(54906003)(110136005)(70586007)(316002)(26005)(478600001)(36756003)(6666004)(41300700001)(4326008)(83380400001)(8936002)(5660300002)(336012)(8676002)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:52:45.9371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fec949-f569-442e-3ef0-08dbc9db3ce9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

If an IP address and/or L4 port for NAPT is available from a CT match,
 the MAE will perform the edits; if no CT lookup has been performed for
 this packet, the CT lookup did not return a match, or the matched CT
 entry did not include NAPT, the action will have no effect.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/mae.c | 3 ++-
 drivers/net/ethernet/sfc/tc.c  | 8 ++++++++
 drivers/net/ethernet/sfc/tc.h  | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 021980a958b7..10709d828a63 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1291,10 +1291,11 @@ int efx_mae_alloc_action_set(struct efx_nic *efx, struct efx_tc_action_set *act)
 	size_t outlen;
 	int rc;
 
-	MCDI_POPULATE_DWORD_4(inbuf, MAE_ACTION_SET_ALLOC_IN_FLAGS,
+	MCDI_POPULATE_DWORD_5(inbuf, MAE_ACTION_SET_ALLOC_IN_FLAGS,
 			      MAE_ACTION_SET_ALLOC_IN_VLAN_PUSH, act->vlan_push,
 			      MAE_ACTION_SET_ALLOC_IN_VLAN_POP, act->vlan_pop,
 			      MAE_ACTION_SET_ALLOC_IN_DECAP, act->decap,
+			      MAE_ACTION_SET_ALLOC_IN_DO_NAT, act->do_nat,
 			      MAE_ACTION_SET_ALLOC_IN_DO_DECR_IP_TTL,
 			      act->do_ttl_dec);
 
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 3d76b7598631..6db3d7ed3a86 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -2457,6 +2457,14 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 			NL_SET_ERR_MSG_MOD(extack, "Cannot offload tunnel decap action without tunnel device");
 			rc = -EOPNOTSUPP;
 			goto release;
+		case FLOW_ACTION_CT:
+			if (fa->ct.action != TCA_CT_ACT_NAT) {
+				rc = -EOPNOTSUPP;
+				NL_SET_ERR_MSG_FMT_MOD(extack, "Can only offload CT 'nat' action in RHS rules, not %d", fa->ct.action);
+				goto release;
+			}
+			act->do_nat = 1;
+			break;
 		default:
 			NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled action %u",
 					       fa->id);
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 86e38ea7988c..7b5190078bee 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -48,6 +48,7 @@ struct efx_tc_encap_action; /* see tc_encap_actions.h */
  * @vlan_push: the number of vlan headers to push
  * @vlan_pop: the number of vlan headers to pop
  * @decap: used to indicate a tunnel header decapsulation should take place
+ * @do_nat: perform NAT/NPT with values returned by conntrack match
  * @do_ttl_dec: used to indicate IP TTL / Hop Limit should be decremented
  * @deliver: used to indicate a deliver action should take place
  * @vlan_tci: tci fields for vlan push actions
@@ -68,6 +69,7 @@ struct efx_tc_action_set {
 	u16 vlan_push:2;
 	u16 vlan_pop:2;
 	u16 decap:1;
+	u16 do_nat:1;
 	u16 do_ttl_dec:1;
 	u16 deliver:1;
 	__be16 vlan_tci[2];

