Return-Path: <netdev+bounces-94394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE6D8BF538
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C67B22B16
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E183815E88;
	Wed,  8 May 2024 04:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="foMgfOnH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15A14A98
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 04:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715142278; cv=fail; b=XgeSJ1EX99LXAPytq+MEaa2fUpgFaXTUO8bQ/xmULHHgYR9uQ5UY6ctgo0cMAThi2zqnu8vyl+pExb9Mf7pqCPM75CBEfefQXl4GzcP72JEg37uVjRAqdYdwv2gxgl7niPXI+8mYxRYxdG0v1pEGGpoApf3T2Mk68Bs9QljKlVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715142278; c=relaxed/simple;
	bh=T4AbLUbhMAL1y7a4bGhTvyVxwVcJ9cE2AXEQvZEEOcU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=trb2xMOV8jgYxBZi+sZ+OpVoXau4wlztohvZBCzh7S0esACOKPWbMsiMAsdd1GaDIXduHS0kO0znujTR2i+hn91hO7KtugAoldDEGGXvSVcAOMZF2extvdN9XH7emTzcQmuNeA6SW+iWwp/4s232ILe84Lp4CHTeMi7QvZfVj4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=foMgfOnH; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9sH9TCo/9t1fDn0DSxYz03EU7Q1GQVHE1ZZ71AsnyGcxM3JuGhhFo6tt+CqMNRcVaoAHjOzo3mUGUTZPnX2deEqDzw9GoNR8AaG3QRJvakoz6V0S9xjIumhYWKi3B8+w2lPrEWhMx13RC3rNMhFBcToW15E5oSHCNb9phLx/YFEkOPCAHUArnBfBtJOHV++NpTrIPPwWqvicSnvZzLH0uNhrQELZ77PEiFs08EKQ0WfdVwQusXv6lkJs0NbaD4j5mPdUx1T1mU0WvFEyf592avp191hx2q6wDYT7lHNPgIoPfMV1FjMTO+Ka9OY1KlKoG6vv6+qYC5h4LgiIvI+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4izhF9cGynFD7tUNW9OzqMnatxR4oVkDC6ubmohSdU=;
 b=n9K5E4QqKzKnp7xKcwe1hYaVyvecNPeJapBxUemU/oWEESyxWsG5WqepiayxNhFj+3Q4t/iEX+oqbRGa/xlq2BRRnCzDa0xvS8oqCWo2hUWIhhwfGMF5EWPSaugCsBONfFMJoyED73jAyx2m1kMQADulqdtXpaDRsDFLSqHimQptW5I/Jzt0/YwmkOuiaDlIM1dhNb5weuQof2er71q9nwl1rr+sjqlMLe3y7cfgwCeMfKR7o0fc4naZB6ziMHFxMVF2VPfpriFONixpJryGSiPP/nRrDK63B2jh7KPlRpD7kzX1UwpbtsxBus7JQXABQlvEeieY9trIOtSvxC/ZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4izhF9cGynFD7tUNW9OzqMnatxR4oVkDC6ubmohSdU=;
 b=foMgfOnHahVlIqnDd8Jxuj4NXt0bVlrFL8X8tgEdNaaeWEJRO99LL+9nZg/nklRiyGGG7naE1fSAM7kS3CzoWAXfHtr8hUj7jv8vWWy6l7szp9TrfRNfoOWue+sBPy8ra0ShCDbao2fM0AgjiPrpod7aMceolgna6rhSmUn6P/H78nTFsZlJdGu7p6bsFN64W3swfSrMpz9enB+8EE+O3ReLd0lEgcyiVQuGPIAaI2CrJs5L0oYgpPSS+Wlkwgp2wGHktx7h2MvVtF8UaU5M3dSTDJeMJ4dXo1a7kV0diVxCOt1CYkP6J+RmumBU4i8FOqM3OA0zSpGggTm3OloOYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 8 May
 2024 04:24:33 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 04:24:33 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: cjubran@nvidia.com,
	cratiu@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	gal@nvidia.com,
	jacob.e.keller@intel.com,
	kuba@kernel.org,
	mkubecek@suse.cz,
	pabeni@redhat.com,
	rrameshbabu@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev,
	wintera@linux.ibm.com
Subject: [PATCH ethtool-next v3] netlink: tsinfo: add statistics support
Date: Tue,  7 May 2024 21:24:12 -0700
Message-ID: <20240508042418.42260-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a3dd58-2426-491e-deee-08dc6f16c2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CTD1asiUJp2PnuCq+zNvj8XKc4Xy3ISaOqoNpJt+HLcBW08iDqNIjBqcsTla?=
 =?us-ascii?Q?mlSfXtBJla31JPJCWXmqKxIHfCP2DCoZWP9P5rSlOR/4L8DPGTMKWUsAGz78?=
 =?us-ascii?Q?fUMDtoJSF4MdFJchq2wF+f1Be2g8KUwhL5MFbNxYC45b8DgHe8oES3YPQTZ8?=
 =?us-ascii?Q?rok4WMGH/N/UTwGnXZyMePq0TxvruqhaP9kW8xK945QuX9PhI82nE1TlSQlR?=
 =?us-ascii?Q?U/JNDfPETpEhMldjCyH4ZHPPhq7Jd5JlZUrP4nTzVpVpRcGlG4vpxite+eZZ?=
 =?us-ascii?Q?KJ5U2/behf7nsyI5V6OcVMt7ne8woke+1RVqcmcoRGcWk1cenh7esAoLEp66?=
 =?us-ascii?Q?aNEZwVgK9i/ciB/J3mQFgXTsqEOH4TxJ4rnVZ43UlM3FgdnVTIpROirpDTJm?=
 =?us-ascii?Q?45xHtJRBWEsgCCSz3kxDZAxLUGvZJ5GbsLjiWI+fV/ZMACXx3KeSDaCnyrZK?=
 =?us-ascii?Q?yQsIAv4TcbXTMHIc6h+khsUMdgOTuZafpsdPmPUUohzgxv6JmbuPfbWv0X/e?=
 =?us-ascii?Q?LL2FbBptqX5a9080QfgMRAwTjmzR8iUrbs2hYHudvYMvs9slGsrkVtIhZ553?=
 =?us-ascii?Q?0Cd+H0tOcff6/oOpFYglNt0dQgK8Fa3UoLyqpLUEjhuG6YZeGJksP+B6fk0f?=
 =?us-ascii?Q?GY3tb+F1JTjYVGrh4q7VTx/g725J4rus4QRzzLSQUH26carOg+QvSkMbkHeD?=
 =?us-ascii?Q?moM+EqgfJyQE5v+6yBsyZ6C+khcpC5D0yXPTRC8a2ZWV8h1mqbrF2QGdaA1P?=
 =?us-ascii?Q?HRrLdSnC2lr3WZ30AwXr1RQEjx+fqK2/hm1QzGiNzrJeioJS3JKhwItnRlg3?=
 =?us-ascii?Q?hc90MF/b4pLxiblKzHa5nYr+fkee4dpAYNg431krunBL9O7ubSx8Eene/UXP?=
 =?us-ascii?Q?/WIxfVt9l2OUOwHJjas8w13aMYKzoiLM7mwGnGgDZmmemlTPlW/bGlTB/Rf5?=
 =?us-ascii?Q?JkGyIWULTKD1ax/QxmdphZOUBWUonVEXlLdWoejXlvc93+mBZQTECXcPvGRI?=
 =?us-ascii?Q?h6niwQc/b7hG428QefvbaTHF3+Faggx2uCLYmbNaDHf7Co4xtAAu5/2Mbiq4?=
 =?us-ascii?Q?gVE5esoWkx0KHU/gykD/qzkxo2R1JnBX/YnKqlrZ6vJuwCBe4qWcxDTn628s?=
 =?us-ascii?Q?87fRyKzY4ViSNlfC5A7/4GaZN7a2px9Xgnt0aObVAKXyo1RxQCY2GuJcsIaR?=
 =?us-ascii?Q?Lvq3Z0gbkVJDJw9c37to4TwgONZaoKsmLJuNEPB8MGGWn1CwpqsRsNfxKswY?=
 =?us-ascii?Q?ErSDqlbhgKMuCV+nIxF/KjaN1K35wYEMv98hkhmkJmU58DLwYn+Y/11Vvfs2?=
 =?us-ascii?Q?XKo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pGMP+Vcv/1v8TI4PTNECWaS6mSnYEiXuHvnFD7Sytj7VT9k2FfxdNfRb5uLo?=
 =?us-ascii?Q?mxzy30BfoYosTBfvDyNQ9Q2aSBqdkWOYQLFTiOxS6113trC3GJzsm9PhAWbr?=
 =?us-ascii?Q?b5UKw6FBaEa8sKso7nKsY9VJM3/pSNd8WEnVxgfWMcl02SkJ/7RqKhb3BwjL?=
 =?us-ascii?Q?H6EDOiaDSsyCZXgTP4140YfbqML59kM8bswD8Dt1JnbgxY03CoJexS8jzVDj?=
 =?us-ascii?Q?ilfiYGKIFi/Oa13Bcs09iFFo9NGobcCr077hm7HsnXg+xBUgrlpDPMPlPWCB?=
 =?us-ascii?Q?0iJGFVm+ScECs/2VNJ/2zuzSXyS3a2chYBNm9Tf34jFQRtvDvp5RiAny+yAI?=
 =?us-ascii?Q?BeuXhMEa8gprXZq0YzEX3reE2vTFzE/GQNqP+8c3pta/0VTWz81Z+uVIKtrP?=
 =?us-ascii?Q?Kbny2eVcYKGmB215+lLCkDyaocp0inemGve4r14CRY870izVOCA86vRVtpqw?=
 =?us-ascii?Q?JWzzhLUkbOWX6s17+fn/GSfXdHy/8nWZwJL+BPB9sTa/J2o6dO/VfqJV4A09?=
 =?us-ascii?Q?EOf+PPwYtzRt4pUdygRoR1+LtB5gtuKiFh9R2h1bAjPsjNbNPsArlH6leItE?=
 =?us-ascii?Q?nvQ5EHtGIo2ZA0WEiaaEiTTf6uNIo5cZZWFZ0Sk/QntmOu0ozwuJRSVgP1ZY?=
 =?us-ascii?Q?OJCweq+22Dq1Ym2CHXKitFq+OWNtol8nM7WFzRzHjEVGwKa5dt1yyhzxicQA?=
 =?us-ascii?Q?ObYehCumBXCfX07yE/SBz1kSEl0D+7QAikOV3cQpGSCPWFgZQ/CO9EQgdIZ2?=
 =?us-ascii?Q?1LHyPSDMZAlSd1MgDs5FlDAkoxUzWhHP1fnDucJb8b2m/3uY+yRfhQuGRFPt?=
 =?us-ascii?Q?1HNqfgG78ZcGFwgOYZwJMtiBUpRm64NNoP8JeZf3D2Mb/E6mWdJzWhfLJDqW?=
 =?us-ascii?Q?Ymbptb+/egl3uGjHpmL9unXq/YJw0l/62LX9s+V7aAgDC9gwupkI+f1Iil93?=
 =?us-ascii?Q?2szdVBY/XRZg9iyVEXV8d1JZNBND5qSIVrcb7zIhlbLvfwaG+wCxhCjOHgGx?=
 =?us-ascii?Q?yy2bwP/gAiSZ20ZiEGX8+X0raezA/P9sKz1aadCp1Ws1J00RjgRzbHapqyEb?=
 =?us-ascii?Q?h0CG3HH9WdqA3vvEYLSBi09hTfusQZu/IHligmgi66XXpwCxON+nNXdUbZRs?=
 =?us-ascii?Q?Hp0ISL6OM9tdqkROatu6BVsHorMryUZCgCDNhzlLgZefm9UnqvqbCYugvoBM?=
 =?us-ascii?Q?H3brRMoJikO84t4RuiDieNEqNcYFeHNmfGNR6KcWdBW+l9zkCuuLw2qb9Mdv?=
 =?us-ascii?Q?2VHGusR2t8k9iP97Rh6H87b4xjm3TZYpynSqCERji3sw4JOvVl6WpwFoE7lX?=
 =?us-ascii?Q?d/mvQKM1vBaYWca7KOBY0YeGl2C3sVQPwpfl4Sd1HlFqnEMAEF/DEHess2Ep?=
 =?us-ascii?Q?FxEvXvnBeMFmIMkvixeLKdHj3JMtpsP0Lxmm88Gb4fkcA1zGSUGHyqRzYK+j?=
 =?us-ascii?Q?+7sDtGoid2J4yEkKSkxT5Rd1sltOpltBSuN6lSsRWmAx9OYv4iXGmDDDAiUe?=
 =?us-ascii?Q?naEVGPwiVktfo/gooBmtb1uPHMAn/KvU+lyF05WIaBxbnnXEpzB76cYXvijj?=
 =?us-ascii?Q?ZBZkYAfsn3SM63rfpwFNhE7UfYC9L9aZ5SkQ6PQTWA1a1GoAymKJwpee+pgn?=
 =?us-ascii?Q?8msr/bf1qVS8/a8pvtEFTc03qdGD8v/E2n2Y+ECxMZeVRbmXl/ZsA2ofL2bp?=
 =?us-ascii?Q?Eb7Vyg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a3dd58-2426-491e-deee-08dc6f16c2ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 04:24:33.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+qVaooOBXmbZMQJ4qeNroJPadoMzREfQXef1FBCiodZLfdJp0qKKnCkQrlvMYnnFu4SenQcVV3j0JpaJPitFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219

If stats flag is present, report back statistics for tsinfo if the netlink
response body contains statistics information.

Link: https://lore.kernel.org/netdev/20240403212931.128541-1-rrameshbabu@nvidia.com/
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---

Notes:
    Changes:
    
      v1->v2:
        - Refactored logic based on a suggestion from Jakub Kicinski
          <kuba@kernel.org>.
      v2->v3:
        - Dropped previous uapi header update by rebasing the next branch with
          the latest changes.
    
    Links:
    
      - https://lore.kernel.org/netdev/20240417203836.113377-1-rrameshbabu@nvidia.com/
      - https://lore.kernel.org/netdev/20240416203723.104062-1-rrameshbabu@nvidia.com/

 netlink/tsinfo.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/netlink/tsinfo.c b/netlink/tsinfo.c
index c6571ff..4df4141 100644
--- a/netlink/tsinfo.c
+++ b/netlink/tsinfo.c
@@ -5,6 +5,7 @@
  */
 
 #include <errno.h>
+#include <inttypes.h>
 #include <string.h>
 #include <stdio.h>
 
@@ -15,6 +16,60 @@
 
 /* TSINFO_GET */
 
+static int tsinfo_show_stats(const struct nlattr *nest)
+{
+	const struct nlattr *tb[ETHTOOL_A_TS_STAT_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	static const struct {
+		unsigned int attr;
+		char *name;
+	} stats[] = {
+		{ ETHTOOL_A_TS_STAT_TX_PKTS, "tx_pkts" },
+		{ ETHTOOL_A_TS_STAT_TX_LOST, "tx_lost" },
+		{ ETHTOOL_A_TS_STAT_TX_ERR, "tx_err" },
+	};
+	bool header = false;
+	unsigned int i;
+	__u64 val;
+	int ret;
+
+	ret = mnl_attr_parse_nested(nest, attr_cb, &tb_info);
+	if (ret < 0)
+		return ret;
+
+	open_json_object("statistics");
+	for (i = 0; i < ARRAY_SIZE(stats); i++) {
+		char fmt[64];
+
+		if (!tb[stats[i].attr])
+			continue;
+
+		if (!header && !is_json_context()) {
+			printf("Statistics:\n");
+			header = true;
+		}
+
+		if (!mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U32)) {
+			val = mnl_attr_get_u32(tb[stats[i].attr]);
+		} else if (!mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U64)) {
+			val = mnl_attr_get_u64(tb[stats[i].attr]);
+		} else {
+			fprintf(stderr, "malformed netlink message (statistic)\n");
+			goto err_close_stats;
+		}
+
+		snprintf(fmt, sizeof(fmt), "  %s: %%" PRIu64 "\n", stats[i].name);
+		print_u64(PRINT_ANY, stats[i].name, fmt, val);
+	}
+	close_json_object();
+
+	return 0;
+
+err_close_stats:
+	close_json_object();
+	return -1;
+}
+
 static void tsinfo_dump_cb(unsigned int idx, const char *name, bool val,
 			   void *data __maybe_unused)
 {
@@ -99,6 +154,12 @@ int tsinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	if (ret < 0)
 		return err_ret;
 
+	if (tb[ETHTOOL_A_TSINFO_STATS]) {
+		ret = tsinfo_show_stats(tb[ETHTOOL_A_TSINFO_STATS]);
+		if (ret < 0)
+			return err_ret;
+	}
+
 	return MNL_CB_OK;
 }
 
@@ -106,6 +167,7 @@ int nl_tsinfo(struct cmd_context *ctx)
 {
 	struct nl_context *nlctx = ctx->nlctx;
 	struct nl_socket *nlsk = nlctx->ethnl_socket;
+	u32 flags;
 	int ret;
 
 	if (netlink_cmd_check(ctx, ETHTOOL_MSG_TSINFO_GET, true))
@@ -116,8 +178,9 @@ int nl_tsinfo(struct cmd_context *ctx)
 		return 1;
 	}
 
+	flags = get_stats_flag(nlctx, ETHTOOL_MSG_TSINFO_GET, ETHTOOL_A_TSINFO_HEADER);
 	ret = nlsock_prep_get_request(nlsk, ETHTOOL_MSG_TSINFO_GET,
-				      ETHTOOL_A_TSINFO_HEADER, 0);
+				      ETHTOOL_A_TSINFO_HEADER, flags);
 	if (ret < 0)
 		return ret;
 	return nlsock_send_get_request(nlsk, tsinfo_reply_cb);
-- 
2.42.0


