Return-Path: <netdev+bounces-251485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JmHNPERcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:38:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCB74DF1A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6E4860BBA2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0300042983C;
	Tue, 20 Jan 2026 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OCZ1cgQf"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B46429821;
	Tue, 20 Jan 2026 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913268; cv=fail; b=LVOwECsyvn6e1GOXYnaj+/RzyEMiOoxIoVCMv3iu5kGHhXquzIysb+lDgDrglCboLi4EQi/SHZ6jDz9LIRsANcP02JVWSyx4uuQy2yE0ZnonFsHaivvq2eRzqaRfom5ikLxaMkImGqIvL487pSQlhU9VadlfB91kH+N9PJtnmko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913268; c=relaxed/simple;
	bh=cCFKi8WfjuFK9OVPxaiQM6DTThLqT7F8JjMgWfEyqHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QQMw6b9j2LpnrYo6At79TmqUnWTWEHNNyuFRoM5/gXCOX3dD8Uzd/+U9ap4WCw+lLYUNLDACwNUuYTQXaClAZlIjIZfsmFmDfUxAx6M8oQKvO4B8EO1eIbJCPWy+4ygVvcQGgWUxneeDl19t234WDhgZNOsZcj6ASBp4uICGpKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OCZ1cgQf; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2gJM6yufOhfJ+1sxserfM30MWnWao3tfsqdMrDhJfsURLJsc5nccJzOB8kVBWNpgXSdKZ9d0xpwxAb2+nXqKzShy1I0lsGEmDLXv4bl47um5HJGG8gXuCX5ztm5iS4iWygHPptIPZh5Yk1rjWp0EVDSyr84G2cYnDQcbyR/+B26OYeZ5kZCsjumI+v1+IHLia1JwXXMaVqAL/TGLSR5az+YZ64BW7gjENTzilLN/u3mF91xnAB3eUWu33eONWzaIT29t/p2pe9ZNnvKRbQxg1lPi2KVdn0CMHARo3ou3H9pKZkOmGeLL+LFtjV4xlMD3lBRnizq/QQdCmOFIqaaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxsck0M6oO75P4LPqNt7j44OGCo9lh9z+aZRMMNAVaA=;
 b=t7GLUSpfhT1weP8U64Laums7fiu+as28q9t2Vfom7G2eLUBlrk2nu7YRgz61TmbQo6ZTH/CZwJmEar5e6fS1vAW1ctTDh43RDValMQBNkpGcivD+R3vVlEjZL/VGHd+9/aKxWXOeRVEFMawvhbNQ/k4zTTUs28s0haQQgZyUSBth8ScRlTYmIqYhVb72D0NxQMyw101VyGbriydjlmLd/oaEVwhZHfbsyx6ThPt6+HK/kAZhZtKJAnFA7YWoxZ5KYiq/iXohFHI8/jbKB88FSscGLJaeRBqpF9JHe9/TpVvVRazYU8YvYxSPbQo/zHmrNPO5flrIkC2g84V1sXrC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxsck0M6oO75P4LPqNt7j44OGCo9lh9z+aZRMMNAVaA=;
 b=OCZ1cgQfIS64KfyqKQLu1s10Ip+JkEbJp8nsPQwRzjTO0U6H55i4n+gxsql8+PxCIwGOSUlNczjl8HqZRTzxITIxSWGE9HakmuTy81lJEYHLh+b2f7gHgrt4Xl7co1d+Z3PWDC1OmxpGZ0fOLh6qvEXwujLSA96Mlt4Ghr/Tp1c+SVI1RkVFhkHyEYVzoODo+pOrX38tdwMI+IMO4/fWhKQVK0tSn1o86ZpBvq+A7/c++aPjDLej38Et3dI46oOGAx8xCxuxhuZr0GMKRymuO1GW2iCouBgb9JL5RrdNEqq6EuBWt9XGl4JdZl1Bo8qffpdt41Hmwl5h2IwvZyYrHg==
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 12:47:42 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::f9) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 12:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 12:47:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 04:47:31 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 20 Jan 2026 04:47:31 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 04:47:28 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Joe Damato
	<joe@dama.to>, Stanislav Fomichev <sdf@fomichev.me>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net] selftests: net: fix wrong boolean evaluation in __exit__
Date: Tue, 20 Jan 2026 14:47:33 +0200
Message-ID: <20260120124733.604590-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|BN5PR12MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b8a3a3-07ac-4eba-f619-08de58221a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EUltaRW1cn/YHLX3piH0LJdqpOeY6rSBk/bDb0VfmORi+VxLtlfZrCulLc/L?=
 =?us-ascii?Q?0ii5pG9+3VL130a5Z4nMzQPZPpwwNSGZdQNV+tqUjSc7Lv5r71zQpRxMQNwr?=
 =?us-ascii?Q?A53MXkrbv3/9yLzox3/8Hf04/RTd4Q17uRbBwE77k4JudGyh70bLJgJNs1er?=
 =?us-ascii?Q?w1rCfoevj4yc4SuSBRKIvKomkVcUUyqozND28UIDNZ4g+MELqAN65X4WdjxP?=
 =?us-ascii?Q?W6Z0EAS+fkPBOanGUkrLhaicKF622o2kvZWCZW5E74bk65H7MDdzZ+UA01r/?=
 =?us-ascii?Q?JVXmKW56ZpheUQP6XkCRfj4y+mDLHLDWOkx5tcawANEaUHSUU3DgM0JloSVa?=
 =?us-ascii?Q?eWGW8tvqmr3DLbImnYCHT8JTy8RLmvccNxqEKrE83s0WkGL60zzutWdsuhLB?=
 =?us-ascii?Q?dvnrQ89qz5eNFmWseri43SCKuYkcpAdsPr2dn7HA26aUvz096wH7KFfVel/5?=
 =?us-ascii?Q?FMAi4PfuC9sLxKW+sVOpdbCOhV3r09GuQVTUeTfYOZtWh3YUe5L1pmu788II?=
 =?us-ascii?Q?HtlZSrHswiEKzlaC/WxKMSobBHHLy6rV21Olb8N9CoPRVfgNwKty3lDCMXe8?=
 =?us-ascii?Q?Q4NFI0Qkb++z2xxAiuZPjbm007Qbxe16SHi7sZRM2ZtIuD2te/3g3rN929CD?=
 =?us-ascii?Q?FPqe1L9CJSOwswu9/ao7dpNWMGv+9DZEL8VX6hEbcsmv2Y6nUKFZ2modhgqu?=
 =?us-ascii?Q?Yxfo+T3rwzCOLuTT/6sv5coZGkK8Ny2pyAPa38jav51yvt89OXVuJATyTYya?=
 =?us-ascii?Q?NmZH6U49VvqaxJt+J0njj/GT6fTaKrjenHpQydQhDM5SekGXjapZ+8aUxo3s?=
 =?us-ascii?Q?lY8yxir66QsmEI/UdjEXHma5bTZbM0mVHS6ckndqstwpXMcWSSyuHwqA6hdM?=
 =?us-ascii?Q?vyTNkZzIL3FFRg3c8gka4c5k90A26POt587aZgp8/rnbJV3Eh/pAOVIiZbmO?=
 =?us-ascii?Q?4DrfjfKABgJ6745XsmpcmHt5cz60vbkMMkiT9xMsZ8DPN6XjgpPl0ge5sFuh?=
 =?us-ascii?Q?DXEE+Bw2T24BPJmG1NEvrKf4FG/3+II4RurexamSVz10JJAa+Qd/ag/vlR2C?=
 =?us-ascii?Q?6eH3+2k/EeklKr2WQsUFPjHpEiVpn/diy6IOyDlvYvw+iNllGwU+Z6Quq28N?=
 =?us-ascii?Q?uLGpZO0RFud6WiN38FANbS73fByKA/AEs8dQNIv4yPJw/lDBxAKMa6t/kYWg?=
 =?us-ascii?Q?eh54CuxG1wUxx3sO0uRIldLqS0M8YRbs9HpvJMYqp4vbMtegtNj443PFCgeI?=
 =?us-ascii?Q?u56ZI0rMaRGxrjzhBs2s3GFWyjz2I25xwYLPYivqy5UAPGzD4wxQPQMEqy8P?=
 =?us-ascii?Q?03U1k/3DSq4HiMiSnHhu4/JdbC9UPNGaJgMqoAzgV5trSLgLxbswRWTcWxJR?=
 =?us-ascii?Q?eei+18emsPX8t6b35/5i4OMeX4rWWec7WYKLGkMzPGDYmS6StMX7VH6Q/Z2e?=
 =?us-ascii?Q?FX9kqqbdwBNiRFaKtoW0j9rOwXMoTf3dcC8x0aToBSLvGhFpnieTQc1XOOms?=
 =?us-ascii?Q?oOSd1uLdJlCnrik7q12kiHwWL62dcCQRMbcgYkW2ELYpG2UIj8ATzC5rwJu1?=
 =?us-ascii?Q?nH1yxhWeCsc5UTPNaZUaOPtcEfHDBv/Area+jgXv+bL1AOmj1b3V/4URnVYk?=
 =?us-ascii?Q?Wr7Dyn6DqtjzQKvnFd2/PMnV/9FU2K1Wtr+wdF7BzaK6mw0GyZRbp9Wz8tbz?=
 =?us-ascii?Q?6Da34Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 12:47:42.1202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b8a3a3-07ac-4eba-f619-08de58221a07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251485-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nvidia.com:email,nvidia.com:mid];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7BCB74DF1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The __exit__ method receives ex_type as the exception class when an
exception occurs. The previous code used implicit boolean evaluation:

    terminate = self.terminate or (self._exit_wait and ex_type)
                                                   ^^^^^^^^^^^

In Python, the and operator can be used with non-boolean values, but it
does not always return a boolean result.

This is probably not what we want, because 'self._exit_wait and ex_type'
could return the actual ex_type value (the exception class) rather than
a boolean True when an exception occurs.

Use explicit `ex_type is not None` check to properly evaluate whether
an exception occurred, returning a boolean result.

Fixes: 6e9a12f85a75 ("selftests: net: terminate bkg() commands on exception")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/net/lib/py/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 106ee1f2df86..dc1db78b5304 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -137,7 +137,7 @@ class bkg(cmd):
 
     def __exit__(self, ex_type, ex_value, ex_tb):
         # Force termination on exception
-        terminate = self.terminate or (self._exit_wait and ex_type)
+        terminate = self.terminate or (self._exit_wait and ex_type is not None)
         return self.process(terminate=terminate, fail=self.check_fail)
 
 
-- 
2.40.1


