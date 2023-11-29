Return-Path: <netdev+bounces-52033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C203B7FD051
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 09:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E0B1C20A0F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3FF111B9;
	Wed, 29 Nov 2023 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="FCi+/4Wh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2112.outbound.protection.outlook.com [40.107.92.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F361BC6
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 00:04:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIYy2VmndQn9w856UlX4pflAj18MeTvkGgNztOrSTL/1N9Ko5sky25B/9wLSyrRjmaCMvODyMAtSSs/TR0auPFGB+IT1rhB65ywzsR1G+/nCQeEPnUBOUBkVIb+fd4J1Y3QBhUYy+UavK6I/FRv2JYngjB8J1Q0Q9jl2WHlYcF2phMfXEMBeBcfjoy+kk5owkC1uY1/jEq0q/ukoBn8Vf6XjD7DuqkHVrncXfQ0EJEs9PzVmczs/SDApT5Lf/uCZ1ylMOw9dnMRKpJHpu1Cl1YalFb3iIber6K6QdflvKvY8RGc09MjlWQdjkRU63zISusWJ6U1hKzlNEXOKMDWQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB5JU6HldYZFZZj54m1KweonKUfmoQUalP5pLwBYKsw=;
 b=Mp+NQVguXl7uQWu/eqYprDPsvFL9KS1k6NDRAVfj0hOzwnMaGqHJ6x4MRXo/LuxgWoL+wmbbf1zdFCe72Tr+io3yjNc65p9OroHVURv9g36zFpvVOSBqrTFn4bQyKXR0+Ru/VPP5zMMIbGmhziH1ehQMbyEVjmKWGrUbiTHhLQ+9zytrv8AtInZoPDevvh9UXiPgtvH6Cv8zZQs8/CNx8dH1CliAtFch+cg3bYtvJtHEkuBQZ8wXj2xkUnP+vN3ps6HEWWNeBznFQ69ol9ch39pmphSj8ChwEUKxzaYxaCC/sQM/m3kFX5iQGjbma5BJBn4Sh9srYjiqXjPa4JrD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB5JU6HldYZFZZj54m1KweonKUfmoQUalP5pLwBYKsw=;
 b=FCi+/4Wh3kuAOASjzQQaSHAIvMZbBQLYKoKpjZ5WDfY8u7fqkZmz2QhH2r5CLakqNtpZXM9ugSGm0XjdBOtSsNH9EDKhB5N9/SrUQWRQgmlH9lecBUiEoGHL707e6no+aP1+T/Nt+43l+1g6vO2SnGuIepsh6ybDCowtT+8NdG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by MW4PR13MB5909.namprd13.prod.outlook.com (2603:10b6:303:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 08:04:35 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 08:04:35 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yinjun Zhang <yinjun.zhang@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next] nfp: ethtool: expose transmit SO_TIMESTAMPING capability
Date: Wed, 29 Nov 2023 10:04:13 +0200
Message-Id: <20231129080413.83789-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::14)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|MW4PR13MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 03aae3b9-b8e2-42f7-0870-08dbf0b1d330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VWeMWfnE8Tlm/v+XXAJ+lL/bFpl9RtsMjrTFcj4GP2/qIcR4HrcHRfAVD57fM9tI5oukgNpbglyMOo5z/C6gZPZCrat/sNQolMX3sB5NuRjvIPUR2IhwzeuUiZbpJzqyVQcDs//HdowkHii8UXmMEHiberrvuTDVoSwipjw8pP2ZLuZ3KtAGOaFqvHG1Sy0O5orfRLbN2TpOzTgxXfJUPAzz68afEWk1fUI0jU+6dXjSUQGtQM74rhawdWEoshvWU2dCdq5nODl7mlqCKi10kg4NgieQm/XPYVSyYtQnxLFAgwAXQda41tOiZvAObO/cjnlMhkhRlrb9N+5DW4FNVjIp6RbDx9Rgx+thzvRohdWfv7y5tLCMq6FXbEtRyIiTfIhFCu40yez0Yf64QDmOiWQ1uFBu1yWWDLl7+Vh95jg67qaayulen/XYATBhL9VME8McS5JEQunb3zEiCncaYWA7eLA6c+rvHevwmt0KtzHgSwaRPUyggeaCihe1GARY2W+HTK+TOZMNBZeMIBggNABuPCmkC3IYnXCUrC5lQMEoNYBQhw8pYQdgBmR1N3rNS2gT3KBOStlyusSuS/Up0CLO0bLvBx2gy087/RewvwoaISzWWzAYPYGwJuCFne5KunG5bgxrmYJBixcFXThsqhQVehezqQ1B55ZVN6CwlDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39830400003)(136003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(38100700002)(38350700005)(36756003)(1076003)(4744005)(5660300002)(2906002)(44832011)(26005)(86362001)(107886003)(2616005)(6512007)(6506007)(52116002)(6666004)(8676002)(4326008)(8936002)(478600001)(6486002)(316002)(66476007)(66556008)(110136005)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xYC04fAQHtw+y7gpL3qu21RTxRcq0gvkXtxEr6aSK9bUPt8XHEF4OLsstvrm?=
 =?us-ascii?Q?km9b8qFqGQYTDpmwMHmjctPCEjkXDxpTDVLhmwWwYjvr4bWcgC8hORGCBb+Y?=
 =?us-ascii?Q?alZptevbOugwjPGNcepiIptoQ78UjABvFCazxzi3eyrtyQByzrE0eSCc0j51?=
 =?us-ascii?Q?gMfA/Apr0YCxbcFNqvWQNBhuhvTi6KbU+vgxMX0LK4TwLuKPGQ6oJBlJEMjY?=
 =?us-ascii?Q?zKc3MjDiKng1SHcy4sSQ+BBrzlGJgedLOawuMx9+0R8KgH/Er1LCgM+GVkwX?=
 =?us-ascii?Q?Wey68MSSslKgFUoHUPNRxFRF+oXJeyDjzcN0LIJnVd2CTNcZvZ7bSJlvo2q4?=
 =?us-ascii?Q?jXWhbKBFKadGEckwqNWOj4fonRdUa95UOSMh0YkSvYapWPFQAiXnbOlvdz/P?=
 =?us-ascii?Q?SoyZXFNugg04ELDvadnFaUDsCvFkZ9wpAGw8/c7u+ci3OnIzyffKYr+RcQsU?=
 =?us-ascii?Q?1ihTTK+Aa+QR7e0L0NsmMhCigOoIOQjz4quhmavNzIc+kaZ4/zNYAmznSdVd?=
 =?us-ascii?Q?NodOKlT/xbUrXvrLiH0LJJJvCEXlQipBoOfGL4Voium1l1WONaC97izdlp72?=
 =?us-ascii?Q?nvsg1qE5g1zfXE4QLoaz1KDCelCwzA2EKNrPDnZc7SegXAMOP+IkmEN2z5n0?=
 =?us-ascii?Q?CoMLtbrf6SRtGJWrwEsRDmmePlIErBGJN7hdXsw6VYb/pWE1xXsf7QGTvHqy?=
 =?us-ascii?Q?HFX9MYaIV2fkT30k2E8ITDhOGlbV1hY4C08wBdUm0YLKXDqGlVnDqEAYGxeH?=
 =?us-ascii?Q?egodSF/13BDJ4CPXVQ9SvsHyVRZzQjuTDGqw0GNF65pE9T8A92UuUMCXWsLS?=
 =?us-ascii?Q?0WAkg1A2yEhpSu6YM1MmnVIyoZlxFhPahF/1NV0Uc8k5CF0VPLCK7a/tdg2I?=
 =?us-ascii?Q?cKr527gB6/vb5l/1DMu20coFtpPIZTNIJzt1yEK8COXcV6TwEOq7MhgljFZ2?=
 =?us-ascii?Q?eiqdX2ImHEDEjZOJpDQSxjQKjeJRYznS/GDRbRMcBZL6cX8DgR8081ebX3lE?=
 =?us-ascii?Q?ZXKvFleg21v54iscE+PHrpuF+8+B/osjL4JIbGTBuMTcwKHB0Wbz9sRKxL8g?=
 =?us-ascii?Q?sl1MYf1E0synP59q3x3RY7I+1hftCnBf96mbo8aYaiB9JHdKHzERG3I/QGae?=
 =?us-ascii?Q?E41NZtt2yUBsS9gBSyt3tXbj5pNm3cEwLP7AwXhD0IMo7JFojvT3C0MxVtMF?=
 =?us-ascii?Q?MIY/yVhEiCpQ+5y9D7vcpCdObQy6IEN+rY16tvFCMRRATqqspwhfQHNwCnNL?=
 =?us-ascii?Q?ZK2dU79mWeq1AuaLDVgIWq0/FkRMVKW6tGjG8k2WLtPN8SULCPG53I6zL3nN?=
 =?us-ascii?Q?vEXfXLvvJk6LiQYpvvW5WOHy4kqs3FTrkgBGhfIEtpeIcanSb8sn/pQ7XZ1v?=
 =?us-ascii?Q?CyNDCEXbpGnOB22KRrhJcmZI3H8Pc2oXrapYLkACv4G1PGf4BtZrHgkj1umy?=
 =?us-ascii?Q?wpbD5Afq0RWWOcvMB9NIqNxu08m5uT4Lh+gqX95jRQ52++sLwaIs66pftZ5X?=
 =?us-ascii?Q?hUHlW+gDqEFY2EqlOtw8tdmX9Mb4hbuEk66Nz//3JBntUdHThflt+65eLAYi?=
 =?us-ascii?Q?gVuGH28CifuO6JqZguhfzIWKOzCMw0TKCwpJxK+dv4xRb55Y6KxXlasg8lGe?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03aae3b9-b8e2-42f7-0870-08dbf0b1d330
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 08:04:34.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlewdoCLoDpj2rIskF8V3qxSh/VhRXqLjQEFPwNg3DzAcmLBKaWtonau9Rct4ChRHZLXbpRTIMfMIYp4eX6r56cY954jXg4MN/IMfvgEIOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5909

From: Yinjun Zhang <yinjun.zhang@corigine.com>

NFP always supports software time stamping of tx, now expose
the capability through ethtool ops.

Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index 776bee2efd35..200b3588363c 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -2502,6 +2502,7 @@ static const struct ethtool_ops nfp_net_ethtool_ops = {
 	.set_pauseparam		= nfp_port_set_pauseparam,
 	.get_pauseparam		= nfp_port_get_pauseparam,
 	.set_phys_id		= nfp_net_set_phys_id,
+	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
 const struct ethtool_ops nfp_port_ethtool_ops = {
-- 
2.34.1


