Return-Path: <netdev+bounces-185154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2767A98BE8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D381B65F22
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA81A5B88;
	Wed, 23 Apr 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mydxXgGo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705FA1A3167
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416395; cv=fail; b=cpO+hVkBrp6LOygCylLE7CYMIO22RFsy8HPXtU3lFqo1hVzllwrJ9PuoUhIURZAL5YEZJXFjFc3VjiG0L73x2Fb/QkJJL1a580NKkGhUBySUYpExFrQr2K3J8L4DuwwGsUc4BtUxQe6ulDCF82EY+2qud2HsfYJxEGDDSmd4bhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416395; c=relaxed/simple;
	bh=2lU0FzkB3AiTcU5YHDAieCGbOgkmwRHvFgtnHMvwzbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ro+3bYPamQNtRXoeyEcREoDy34xPp7eYURkVeq7/ETOkRqFMSTmxxoRah0jhgF5/IAQGkoZcfYuTjJHuUA5404Ct/9tqdct6ViK0WKh1wNoMiCP4OkhcawClGIMFm9iIA3sFoxjMIKbdJf/JqT0wRZSY88yYJ1cS6m3yJkFa/30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mydxXgGo; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMqAR3+HF8lxm870+3S8QUjSr4V7nP7C49JCaWran/OotdKYJhHkQbG3pOiLP0BD2kCe/PBCZCoJ6lgoFnABgoeYdx3JruDq+1QSBNWFRIY4tokdkCTzb1FF7Ku74/bMK5lR3ngcT6b8yN/Hb1DSXwgTWNNV3ohoFoFTe6HpQcibec8Ds1ctMzencj1Emuim0/Dxs7fWJ1YgR/JMNzUtIsC8bDA2WFoHoEJGn4YZFwFcVHVsqpIBQJC+T+IODQWsQYBq2UG5mR2FInAzgAM/o/FpDC7QqJ5ELTRui8O+3aXUG8rEYeM816CPOeUKxwG4ke4zKU4g86bTiIwflwmlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk9Due7OctDRzKOLvGc4vTwiSUtuQBsoVUW+4gIgnEc=;
 b=DUPO8tVP25y0voRhVijomIFmdnSiTH+kw0KZ3ijbQSiDtqNSYp7cmjVvVkFm2W0cvM0WiZaE4/fcFxXh0SXEb5BwZaq5Jmg7rdCRMvMA4wgG2abHbVnM9kgEmi8aUg2wxptmtzIZJOdUCI8VuZctzqBQrFijpgiaUwM/hO2gVYVinrh5wJ6jPU9gWDjBH2jv/5gTGqQ5CsEghnI5tTcMlEpkdRKzUz/ksdyvMUT2w8G2du077EtzTR7M6HEj2rWHz4yZ73pT9clO6tycTgR1aDF6hifU974xukfeSxlWjKy3ZgXa/3hJkYp6hG6BM5x0tF71WObcFGCm9sVUACAx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk9Due7OctDRzKOLvGc4vTwiSUtuQBsoVUW+4gIgnEc=;
 b=mydxXgGojA1MSLG6zqnciaObR6fjQrZO+AMuxoZbACdjHAK8o5i1bX8TMVCuR0DkjkcblIHpl36nfqbGHg3qkQMqb92ICK/M95alBtzxZznJs5Ok1KtNpGcz44yODsNFPKBCNUmW31EIBoRhNGidHu4IUdsQQpKAMNl4PCCKZoGJ55T53stOTIArFx/8ohql+C5aeRUrIh+oOl4EkyeexPqnWukt7QKbTqUDtd95/mQws6rCYc3IsNmfi528xLM2u9nt7gHhk2+JnphrQnR+VOF1eN3RLAXWgZSE2p8FzHvwHtQtnetXLldA29pGtkQ2HmqgWaVBJ3WPbr6I+1R2zQ==
Received: from BY3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:254::26)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 13:53:07 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::c6) by BY3PR05CA0021.outlook.office365.com
 (2603:10b6:a03:254::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.13 via Frontend Transport; Wed,
 23 Apr 2025 13:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 13:53:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 06:52:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Apr
 2025 06:52:51 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 23
 Apr 2025 06:52:47 -0700
From: Moshe Shemesh <moshe@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Avihai
 Horon <avihaih@nvidia.com>
Subject: [RFC net-next 1/5] devlink: Add unique identifier to devlink port function
Date: Wed, 23 Apr 2025 16:50:38 +0300
Message-ID: <1745416242-1162653-2-git-send-email-moshe@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ba3f33-b4e4-4ef8-e1eb-08dd826e2d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+PDQK8fbLZB0QF95bFp8y8E53a36gORuv0cXIJMcCAfdwy9MUvwK5kkG/D8s?=
 =?us-ascii?Q?r2xVNX/LZZ+oe6z6uWpInz35Kcsbg3bsF9IEwPmdVsT53zktvpHkO2HkmcJU?=
 =?us-ascii?Q?DYpIVRzL0pNyhWUhk76SyEePZAHGozqYxIIWfV6Ea+/9C33qdlb/47RV8107?=
 =?us-ascii?Q?6ci9x81rKz+NNWcHBxNXwtdZuW3mVikDolgzF7dbrigZ2oDfxzk5Y81IylNb?=
 =?us-ascii?Q?UEi5I4LkLnMXwIsvUcK5j4zqsrjLtaH89SyXCSiDvvgbwuYP+lDV3lEYHNje?=
 =?us-ascii?Q?NeDMqeQCjPCsv1/h/MHJc8beWlv1YKknf/8yr1Q7gwJLf16rurIBwbHROMWd?=
 =?us-ascii?Q?CUBLLNaneWQsBMCc+rEviI+PwS/ho2GG8l8m2zVQCegY/SM559lW7M78OUCA?=
 =?us-ascii?Q?1ujMstplE9hIr0PYnlWQ2N254e/tFHGold3bBtXxbd+LDMslBgA7uRY8BeJS?=
 =?us-ascii?Q?yQ8nkk48U5Nzqo+InLYMFWnoKIyfEf5f147DJinveo45juKTr+5tkD4LJz/l?=
 =?us-ascii?Q?If0wPoiBgLOOLx5Odmq/2aiwqWhS/pDqEHwQAc9EHEaR4jDMNkSKpg/kUqSV?=
 =?us-ascii?Q?dhRFH8OEUjBGjDWism9UIpVHMyLt2UTeZeNldemhwWkxOt6Cg0UQNIb9BHZE?=
 =?us-ascii?Q?F/TJ+aZJ+MxQKwHrhYPnxwVHZPv2YJvvPEtw9gwJ8tk0k0UvogWYFtTG/ar8?=
 =?us-ascii?Q?hHOpCgU/HGVvCKqMWfveonInVuSkms7fockVuUlhNQnKopQH4qgCk6jUSrxT?=
 =?us-ascii?Q?G9XYT7biuqbr1QnjJk8UL6aTYw66DD5bMz1xz1FG1iaAxQBYnBwcMMmyk8k3?=
 =?us-ascii?Q?IauFuFNkZDuZgOpG/JrqtjraWdEgCu5sFcL8Sm0gO5wqX+gK3hSK6s/uoEZH?=
 =?us-ascii?Q?aQTwo68kpznYbFchydzmMHiwIQsFlxV+QigcsQ60791wCE1A9UEMJ8hJsldZ?=
 =?us-ascii?Q?rfeL7y2ZBu7TQA0ffvUSvKKrpwIo2ezZWSnXnsg+nzUwtHWKHH/cznzP5tJ/?=
 =?us-ascii?Q?dR/kfltcmdtAgnHm0zJn+xxO7cXwhqqXpsqcGnLObdZodu1lQ2Yi8lTcaAsD?=
 =?us-ascii?Q?1+0s4OWZvdg2lD42mFUCyQrVEQMCP5yudaihzrb8jdc0UwpY2yo3rd8yhg/w?=
 =?us-ascii?Q?RojOt+jTHb94L4ncy7bPSFnkFCob9fqWhpP+b3LaHbDMtS2Ofyzv/65YVObq?=
 =?us-ascii?Q?IMU1t5RmI16unpgitbEiFiaUJGsPyegB7cGP0ejzyzbXVFQQhzcIq1vBPCpY?=
 =?us-ascii?Q?QD+LEUUhrslhkKfVWFncBFw/lqH5a/YxFe4q2LHUlOTLUWrRllmz4zv8VZ9x?=
 =?us-ascii?Q?0e4uc8f2aWISabtkUD169O4YLd2TOv2NUSskwJEDRMm+Sdluc02rH50/tJWo?=
 =?us-ascii?Q?5Yf84HRxrYvVX3bjzWu4jVBqRROVa3Ai38ykq2a/I36A8uMUc2OmhQrbl8Ev?=
 =?us-ascii?Q?726bLr5O2UXzZoF1D9/Wu9aS1yNiHYad/tKmWfggTfY7jZvaQZb2UFiLXOIU?=
 =?us-ascii?Q?XGNkctuQIhwqcHre4ylQqIlLptkgqecMcVSe0fDp+61WIdmmeIMXLctuCg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:53:07.5080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ba3f33-b4e4-4ef8-e1eb-08dd826e2d6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662

From: Avihai Horon <avihaih@nvidia.com>

A function unique identifier (UID) is a vendor defined string of
arbitrary length that universally identifies a function. The function
UID can be reported via devlink dev info.

Add UID attribute to devlink port function that reports the UID of the
function that pertains to the devlink port.

This can be used to unambiguously map between a function and the devlink
port that manages it, and vice versa.

Example output:

$ devlink port show pci/0000:03:00.0/327680 -jp
{
    "port": {
        "pci/0000:03:00.0/327680": {
            "type": "eth",
            "netdev": "pf0hpf",
            "flavour": "pcipf",
            "controller": 1,
            "pfnum": 0,
            "external": true,
            "splittable": false,
            "function": {
                "hw_addr": "5c:25:73:37:70:5a",
                "roce": "enable",
                "max_io_eqs": 120,
                "uid": "C6A76AD20605BE026D23C14E70B90704F4A5F5B3F304D83B37000732BF861D48MLNXS0D0F0"
            }
        }
    }
}

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml      |  3 ++
 .../networking/devlink/devlink-port.rst       | 12 +++++++
 include/net/devlink.h                         |  8 +++++
 include/uapi/linux/devlink.h                  |  1 +
 net/devlink/port.c                            | 32 +++++++++++++++++++
 5 files changed, 56 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index bd9726269b4f..f4dade0e3c70 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -894,6 +894,9 @@ attribute-sets:
         type: bitfield32
         enum: port-fn-attr-cap
         enum-as-flags: True
+      -
+       name: uid
+       type: string
 
   -
     name: dl-dpipe-tables
diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 9d22d41a7cd1..bb6f0970b322 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -328,6 +328,18 @@ interrupt vector.
         function:
             hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 32
 
+Function unique identifier
+--------------------------
+A function unique identifier (UID) is a vendor defined string of arbitrary
+length that universally identifies a function. The function UID can be reported
+via devlink dev info.
+
+The devlink port function UID attribute reports the UID of the function that
+pertains to the devlink port.
+
+This can be used to unambiguously map between a function and the devlink port
+that manages it, and vice versa.
+
 Subfunction
 ============
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index b8783126c1ed..46fd5b3f3253 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1627,6 +1627,11 @@ void devlink_free(struct devlink *devlink);
  *			    of event queues. Should be used by device drivers to
  *			    configure maximum number of event queues
  *			    of a function managed by the devlink port.
+ * @port_fn_uid_get: Callback used to get port function's uid. Should be used by
+ *		     device drivers to report the uid of the function managed by
+ *		     the devlink port.
+ * @port_fn_uid_max_size: The maximum size of the port function's uid including
+ *			  the null terminating byte.
  *
  * Note: Driver should return -EOPNOTSUPP if it doesn't support
  * port function (@port_fn_*) handling for a particular port.
@@ -1682,6 +1687,9 @@ struct devlink_port_ops {
 	int (*port_fn_max_io_eqs_set)(struct devlink_port *devlink_port,
 				      u32 max_eqs,
 				      struct netlink_ext_ack *extack);
+	int (*port_fn_uid_get)(struct devlink_port *devlink_port, char *fuid,
+			       struct netlink_ext_ack *extack);
+	size_t port_fn_uid_max_size;
 };
 
 void devlink_port_init(struct devlink *devlink,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..7b9821433a72 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -687,6 +687,7 @@ enum devlink_port_function_attr {
 	DEVLINK_PORT_FN_ATTR_CAPS,	/* bitfield32 */
 	DEVLINK_PORT_FN_ATTR_DEVLINK,	/* nested */
 	DEVLINK_PORT_FN_ATTR_MAX_IO_EQS,	/* u32 */
+	DEVLINK_PORT_FN_ATTR_UID,	/* string */
 
 	__DEVLINK_PORT_FUNCTION_ATTR_MAX,
 	DEVLINK_PORT_FUNCTION_ATTR_MAX = __DEVLINK_PORT_FUNCTION_ATTR_MAX - 1
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..4d14d1bfab33 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -207,6 +207,35 @@ static int devlink_port_fn_max_io_eqs_fill(struct devlink_port *port,
 	return 0;
 }
 
+static int devlink_port_fn_uid_fill(struct devlink_port *port,
+				    struct sk_buff *msg,
+				    struct netlink_ext_ack *extack,
+				    bool *msg_updated)
+{
+	char *fuid;
+	int err;
+
+	if (!port->ops->port_fn_uid_get)
+		return 0;
+
+	fuid = kzalloc(port->ops->port_fn_uid_max_size, GFP_KERNEL);
+	if (!fuid)
+		return -ENOMEM;
+
+	err = port->ops->port_fn_uid_get(port, fuid, extack);
+	if (err) {
+		kfree(fuid);
+		return err == -EOPNOTSUPP ? 0 : err;
+	}
+
+	err = nla_put_string(msg, DEVLINK_PORT_FN_ATTR_UID, fuid);
+	if (!err)
+		*msg_updated = true;
+
+	kfree(fuid);
+	return err;
+}
+
 int devlink_nl_port_handle_fill(struct sk_buff *msg, struct devlink_port *devlink_port)
 {
 	if (devlink_nl_put_handle(msg, devlink_port->devlink))
@@ -468,6 +497,9 @@ devlink_nl_port_function_attrs_put(struct sk_buff *msg, struct devlink_port *por
 	if (err)
 		goto out;
 	err = devlink_port_fn_max_io_eqs_fill(port, msg, extack, &msg_updated);
+	if (err)
+		goto out;
+	err = devlink_port_fn_uid_fill(port, msg, extack, &msg_updated);
 	if (err)
 		goto out;
 	err = devlink_rel_devlink_handle_put(msg, port->devlink,
-- 
2.27.0


