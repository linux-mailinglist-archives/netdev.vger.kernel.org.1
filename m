Return-Path: <netdev+bounces-50104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943997F4A35
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D0F2810B2
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914894E63A;
	Wed, 22 Nov 2023 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BJENf2Fp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127AAE7
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:24:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOi8fyvkLEm9nkpFRXROODPvHmv9zIB/kYf2Iq49JMlsRc6kuDQYltPq+OlpFA3VglrJpJK/M4f34kRbkA1i/U27EDoZt888vPtzzpIOwVRic+xwV4f+VHiUUeAptLgIqZ36Y23l+3rxwWlF2bwgu2v+PcrNiKqxfrZr4QmRjEthZ/tVrA8sRO706a3Fg/u0fndI36GbPsjtji9cUXlpvLYmaSS3njIcFqSEMQn2sz0hmrxpA+NRxQBLDPzb+TyVhUsNwXTkHK06UPCu2sQEBh4W/315fbwcTo0ehJiKgP4ZqXHe45+YtJ2BsUyb8oPAvXykNBZ7nhy2l80a0VqinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/8s6LIYYnB/6r/eNx0bHu9ugMG44wzWBwHpNCvyCgY=;
 b=U85P4InBIqwSiPNIOYbA6ldu88QYDFMjOMaH01q6afPZ88Hn/c5h5M+9wRyW3KuZ1Qv1laSltwOSVO4WZrJ63Rnt6Wg0LQUcAOEmsApttSuy18GjP9gphFc180iqwJIx+aVnAvunQsG1bvBIGjbIJvlZ58GseS8tFffoT79eJoZef7DZkTWV/IcWcMqTYtgBVlpP/RD2NdHEmQ8/I81Wibxlv25ClivLNlEw2nChSYx5zKPcfn+jdhTfMZvFu9bfvRgrlwnmJ454mDL3yFsjEvRp+PtF33GD7FakLcV/VnocYHC4gNn5GnC6oOpH0dgixLYvxantwzjRifHPKy87vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/8s6LIYYnB/6r/eNx0bHu9ugMG44wzWBwHpNCvyCgY=;
 b=BJENf2Fp/kOgnl82b8zhaArghnwXFTwkMHsZNLWx+GkRI1Yw4Sl6N+I2a9pBDXWF79Mpsg6wARQbcgLTYILarAKqbjkUDfrnJf0AZD5ihJaYi0bJjzphs9hgpX/MLJIEQ13wF37xU3CDrMvF5CoeVOzBSf9Pg684+7YNsI+zy4J2edzj9ar2b3l7UdKbBXOPO4Pd+xWJqVmKY2jJliDocf+o3se/KmQV1hh25a+b2Jrz3WLKHJgKWAoroKihe4C2K3tpoOXPwi0kvOexTm2mSvzo9kvU9MUXAF3UV1yAiCmNv/zlg2QomDXj85aEMIDlzZLt6C01rnbwFB10parcBg==
Received: from DM6PR02CA0111.namprd02.prod.outlook.com (2603:10b6:5:1b4::13)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 22 Nov
 2023 15:24:20 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::c4) by DM6PR02CA0111.outlook.office365.com
 (2603:10b6:5:1b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Wed, 22 Nov 2023 15:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 15:24:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:07 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 07:24:05 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next v2 3/5] lib: utils: Convert parse_on_off() to strcmp()
Date: Wed, 22 Nov 2023 16:23:30 +0100
Message-ID: <f110d5183b851777ef1d2b24ff9648aac77ba363.1700666420.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700666420.git.petrm@nvidia.com>
References: <cover.1700666420.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4a3414-e646-459f-5e5a-08dbeb6f1922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Am7+z6wanZ/nF5K0n27dz3lvtaS8OoOBZkwTxAI6LK8HcQp4t/A4FCqVWtsJhQSKIO3AEK4DnUWjwlOin9jRcadRzztorUSt4C0XvAlACQoNbE/PSooIvHp/oaiEJS+j4VqTVlD6Tm5mzJmXCkDAIian3BwhLKPHz6vgYg1yt634G+WXRWwBCbcBuQMWpvSGR9Ps4xRrQWhPsiK08lENHQ5SjDpRqCm9USIJC27J+QS+5Xyf/nw4n8pJDVrA7zfJbc95Xh5Lx8OfrBufKKJDWXaR/+xOErvtAk/W569fNCJnjQEQ5e6U5P1xBXrqTdJJDFaDY9xXslLPPNl8lMNV4U7GmH5/J5HppFA8xlvmHlcKfvYmWAABZjqa5INYIOO3N9PIhR5XT6HFwMI+H1LTr8E5XuLZRru7F/ISgteMBwOXnvcBKTAHgkMHRggVhA49WkUjkn2ryrqp7kqPRodLSuUbsLXiUReUW/1aP+uuDIze8BGO0tQqeoj5NKOAiKhhcNFtIlf1oan8Wr3+LXA0N0h3puKVYqDmkrTATeiu6oweNVo4YD+Pknt5JTxVocTRti4InYQ36VmsDmbbyhB2KmwHV0RIbZxEuXYPwqJZ3yavKD0euA063a3AgcsGiTgUIBKMoov1BkitN1U1yNmtTQyRcpoR4ZQFsMf8/4eUJIwSSPVSO3FB/aVwK1PSHbiWRwFyF9TaBJ1vIUt/t1Y9lFfDF3LloKxXB8mFKa4YeHN5mOs4oMxyrcOh/hqzdjh6
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(8676002)(40480700001)(4326008)(36756003)(26005)(8936002)(82740400003)(110136005)(6666004)(2906002)(54906003)(316002)(70586007)(478600001)(5660300002)(70206006)(86362001)(7636003)(356005)(2616005)(36860700001)(47076005)(40460700003)(107886003)(16526019)(83380400001)(426003)(41300700001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:24:19.7074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4a3414-e646-459f-5e5a-08dbeb6f1922
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133

The function parse_on_off() currently uses matches() for string comparison
under the hood. This has some odd consequences. In particular, "o" can be
used as a shorthand for "off", which is not obvious, because "o" is the
prefix of both. In this patch, change parsing to strcmp(). This is a
breaking change. The following paragraphs give arguments for why it should
be considered acceptable.

First and foremost: on/off are very short strings that it makes practically
no sense to shorten. Since "o" is the universal prefix, the only
unambiguous shortening is "of" for "off". It is doubtful that anyone would
intentionally decide to save typing of the second "f" when they already
typed the first. It also seems unlikely that the typo of "of" for "off"
would not be caught immediately, as missing a third of the word length
would likely be noticed. In other words, it seems improbable that the
abbreviated variants are used, intentionally or by mistake.

Commit 9262ccc3ed32 ("bridge: link: Port over to parse_on_off()") and
commit 3e0d2a73ba06 ("ip: iplink_bridge_slave: Port over to
parse_on_off()") converted several sites from open-coding strcmp()-based
on/off parsing to parse_on_off(), which is itself based on matches(). This
made the list of permissible strings more generic, but the behavior was
exact match to begin with, and this patch restores it.

Commit 5f685d064b03 ("ip: iplink: Convert to use parse_on_off()") has
changed from matches()-based parsing, which however had branches in the
other order, and "o" would parse to mean on. This indicates that at least
in this context, people were not using the shorthand of "o" or the commit
would have broken their use case. This supports the thesis that the
abbreviations are not really used for on/off parsing.

For completeness, commit 82604d28525a ("lib: Add parse_one_of(),
parse_on_off()") introduced parse_on_off(), converting several users in the
ip link macsec code in the process. Those users have always used matches(),
and had branches in the same order as the newly-introduced parse_on_off().

A survey of selftests and documentation of Linux kernel (by way of git
grep), has not discovered any cases of the involved options getting
arguments other than the exact strings on and off.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 lib/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/utils.c b/lib/utils.c
index 5c91aaa9..f1ca3852 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1763,7 +1763,7 @@ bool parse_on_off(const char *msg, const char *realval, int *p_err)
 	static const char * const values_on_off[] = { "off", "on" };
 
 	return __parse_one_of(msg, realval, values_on_off,
-			      ARRAY_SIZE(values_on_off), p_err, matches);
+			      ARRAY_SIZE(values_on_off), p_err, strcmp);
 }
 
 int parse_mapping_gen(int *argcp, char ***argvp,
-- 
2.41.0


