Return-Path: <netdev+bounces-240143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A67AFC70CBF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A765B4E339D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBF42F549F;
	Wed, 19 Nov 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5KFPEF8p"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559813702F1;
	Wed, 19 Nov 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580204; cv=fail; b=S9tcLhBbmjOgIIP1pClEBUbqGtSXxE8JvSWm6bRZHW6m9ZRM/JvtqFHySbybusa6jWI3ru2axuFAj3gN/GkxYXcIzkgjnCnBZU8CiWTMbwuPMxMmVusprUn9qoldCX7KSJ3IU2KxMmZ7ZRfOhlV7AoN3hcPSjMISnNEo+gsmtUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580204; c=relaxed/simple;
	bh=LdMFmHH3ubGVMKRJec10eAVpbpE74f3YEcOP+DCTCkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAVVq/1co5aZal11P4ZtfmY9U2pUNfnHkfe/CP5HGv+OX8WQe56XSfvY6SgixdxC6fLntANnnwmRYV/C0AhIKILa0Xm5jrfkSBQz8nRQ2VvKbKOwBK0ekAQ17Z7MmCN2QxbmlAtp5l/GOAq7439vI+rtmtqhljzm2lys2uNw02o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5KFPEF8p; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lusbrtyKVTQm+J3lQLeT2YEjO2rk5jFcMVSpLTUfwl6rmoClj5C0jK0bSUUY6VelrroagdzxnBJPCNeoQKNB92g+JhxvQeA4qVFChQc+Dko3KB6kEiPU/Tz1mOLvU9gthO1qSQKx/AYfHd4V/ao6LktMfH1O3DpAa2XATlSQc47o76VU8pyLvuy7i/XOuyGdy5q/QcyApxxvJY2pP87cb5HChZcx/yaOPVeNXv0qK3CoF3+ijv7JKA8X5TO+Fpm8UeWU7yYyZrLOxG9pftzeXFDB+wN+jUJ990u0wHU2gv6TCdY0Uw2IjlZEv/lgNyUDn8aWtRZwhIPdjSgjw3H7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZXiv7l20+3lRRwW+OFFGtU1uxYxwLDzW31SPAwi25I=;
 b=W8H/e1ve+bWhaB6BxZ+33dNjV7pYIwINgOQ/05DrbyVPyHxBMyIDKxlmZeO2WoWjfgXG/vlpPeMN3YjyDgMnYgaMeplkqL7RaxZygP9wF7RuSFuQtCYjAU/095TIPu3lq2stb6hOLKEdcRsbM4fbpB0lgd/kTQrW+EfdCmYiZAkFnUE+0MIbaeb5LVb6CJEGt8Yhpja29wdrrnHb+bemhNNgLGIAiaZR6QZ53v+c1VBDZVzD3zvIS43w7y5WpUyk3aQ2Dwk2U4ujWvqRl+Vr7Y/g3euv+BbYM94G5kYXwcxpWXp50cBqNCdmbnRy6MRNQxGfNRR5gkbC3NEWWSePSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZXiv7l20+3lRRwW+OFFGtU1uxYxwLDzW31SPAwi25I=;
 b=5KFPEF8pVMtlzmjnqxWOP9XR2Wdh+9NX4PG5hQR4ocsylm6t9NjVdheqZB/xtjHLDUGk3BnCE++LnqPHI85NgX2+xsEZPRVcWMQfVqyUXng3BVn8HgEVtHvQPIehbexzJPBQPwOEyTn5SWBSqU6veS24RFzrjLlAsNCfmDscXtY=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:14 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::1a) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:13 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:13 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:11 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v21 17/23] cxl/region: Factor out interleave ways setup
Date: Wed, 19 Nov 2025 19:22:30 +0000
Message-ID: <20251119192236.2527305-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d58a72-a677-47f1-2cee-08de27a115c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EQANM4HAS7expZLf7q+FauR41un4pDRicbdZ/OwZaQKM8BMaNSlfcav8/laA?=
 =?us-ascii?Q?iSAKOQBZ+ti5NKXbURIdeVUIpKMeCwKOqAN7PW2rtUSVDOb4SEk2nO08yyOq?=
 =?us-ascii?Q?IIg42/RbIvQ3iVlz8bibJVO3TOO0xRKCHAMhKvGgsjQO4IPwdlSSvq7ICVRy?=
 =?us-ascii?Q?GHR6eZikqGaH6pH3TpoBSxSJhO6jnEV1PxBUAuPeClh7mqc2o5jpm4JtX4zg?=
 =?us-ascii?Q?dIaTkb5rRWGwHWRtGx/JvtmJQ6UUN6FRgB00hZbLRXdb2cMvC5nAhApShg93?=
 =?us-ascii?Q?d29JdwHJqDWjGd6cxwpKP8Zf1H39rct7Ij2hqRY2cmJAHyCNXKnCStv2c6zX?=
 =?us-ascii?Q?TS2k0QiOoTCTWXdPjnTjmD7SA5lQg38vzXtNJzJIsQ0NP0CeCDzqvNonIC5b?=
 =?us-ascii?Q?ZNtc0x21WEBg03VieWsW/MSve8M3GtWVMALHIafBBKF5XaKyAYKCauYFSJFG?=
 =?us-ascii?Q?nbFXI8YsA8VJYe/aBJn1vMbViUjMPeJHkiBT2f/QPqlHNzgS1HDHxVCa3A5L?=
 =?us-ascii?Q?xHZ9EUrsUtUIjiQF17oNfaPALAt/Gi1qr+xhVX1XhTb7IhN0rlckmdHNUE0K?=
 =?us-ascii?Q?nzyivr7fObLbi6srT2i3PWTHgsY6kxrJd2kOyWTjfqbMdvTB/fqk6cvEtKBD?=
 =?us-ascii?Q?3k8S7aEAUESmpHd1rcUO8NsiKjX0C48HlhHIEqwB9LrLIDpPZ/gsGlSgFCsK?=
 =?us-ascii?Q?b3lWGHb5fTajsxcEsyIUkDDu15s7Qyoa1FUqnv4OFSzv2pYT3n+Viloo5QQj?=
 =?us-ascii?Q?casoYxb61WHakAY2J56JYmjg54ALJ1ztgoz/oLsDxjw0v6CDRNPrc57Kn+Md?=
 =?us-ascii?Q?9QS7ZNZ2ycsKu3UJI1CaBI6w4DniPufpbGLZ07dbkAGDb18chPZF04aXXzxk?=
 =?us-ascii?Q?WECt+lGlCjxsGL/cW9yKnToyKhlCi/gipKz2Nqj1STC8r+GI7ZpZCoiWYBEJ?=
 =?us-ascii?Q?jrD12AMAyq2i02RWDyQmQlrWoQFcqzK44Y1EAQuvkUbmjXnblgDxeWihRMdH?=
 =?us-ascii?Q?TipbxqLkJqs8xHTjCAv4GDMU8yNQU7wbDHR4UA2bHYTGYjs0aq1X3zBfMBQa?=
 =?us-ascii?Q?amsppIrweSiCaEnM26eLZ2jAj2vV5hbRTpHesBfHiipO1TNTAa2hzgDSRO3k?=
 =?us-ascii?Q?jJO3hnU+caqNRdbFPim6guvmZsBTpzveBhiBUCRZFCPiczU+szKZ/b2eKVMc?=
 =?us-ascii?Q?B6WTVWa34c+Yb9w80PixnCWLS0euWiaoQ1SY7TvGqCvA8OvaTYrZSh2cz4BV?=
 =?us-ascii?Q?ysVEbbXunbcNzJjWLxUt6Q8kc9MtkOKN+dAYfAKvYry4Q6m10nCHFrqKjK7s?=
 =?us-ascii?Q?/DzS0BVEmrMa+gqdo3ZNW6UUuHN1YKjm0TyXRDXo8aoZES5mQO8ETeJp+qJ4?=
 =?us-ascii?Q?6gQZgaF0ru7HAMMBkBX0QQNvgAuzM7/rfuSIsTEsaitquZnZMbAuu4U9oyaA?=
 =?us-ascii?Q?eJ5J46Sa9bFBqMv7e2Gd+/heC9shoW0iapi7VzK90kZB8a8I0dP5PxyENhdv?=
 =?us-ascii?Q?CMXz3mxKVpI5xJOQTFxVt+rr3k+5Y4S2YStPs22BuK2UGd+DjBHedfH2rjAd?=
 =?us-ascii?Q?T573iHj81r6U8kNjrCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:14.0386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d58a72-a677-47f1-2cee-08de27a115c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 85c2c7ab45b8..d618adee94e0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -491,22 +491,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static const struct attribute_group *get_cxl_region_target_group(void);
 
-static ssize_t interleave_ways_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+static int set_interleave_ways(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	unsigned int val, save;
-	int rc;
+	int save, rc;
 	u8 iw;
 
-	rc = kstrtouint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = ways_to_eiw(val, &iw);
 	if (rc)
 		return rc;
@@ -521,9 +513,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
@@ -531,10 +521,31 @@ static ssize_t interleave_ways_store(struct device *dev,
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-	if (rc) {
+	if (rc)
 		p->interleave_ways = save;
+
+	return rc;
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
+	if (rc)
 		return rc;
-	}
 
 	return len;
 }
-- 
2.34.1


