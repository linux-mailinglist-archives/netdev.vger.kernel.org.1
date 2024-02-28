Return-Path: <netdev+bounces-75717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A12786AFA3
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7611C25206
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6FA149E0B;
	Wed, 28 Feb 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bLysYCAm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E51487DF;
	Wed, 28 Feb 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125121; cv=fail; b=OSmBC2FfnNx2zT1fW1n9IekyJhyHezITzc7LioA2fDyDj9j7nyM8eTKd2B+E/rkAtJSC6iTHAsznqaASuswAhBPNbBH6SJY2eTknqHtdx8jb4ir45vNEfl90y4JOoXIsTDRvUmlhycg/+Mxqqgb+igNjRtyuGDsqDZXcUKQSuHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125121; c=relaxed/simple;
	bh=+LdNGKODjidhFjD67+8mjNg4ZNr4FKVUUvgwOOjxnjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RctdNFSkWJZ/BfXN212el73fYGDL5yuDEYe+K61NijtQ8gUd2dEv1wXRefF9iuq6OFcVVvWnVLQKd42rPm7QYsAfWKxdvgZGQ1Byy1eZDnRNQV2hY8w5sO7ZvIYAN3aK8Ixn9I7sjWyGDDg15PoXadwN5T0B9dWNNpyoejNwcuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bLysYCAm; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkPpBQlgEeUlDs9Hdrb6s0hQwXxj4nUMY4eJapZ0/GCHYZHhyR6HLzLax8pv/SakeOzDXA+RHTf4K/bs+T4jssWiCn6VpW50Ddu5P6qPOTSfkKTRUEbP+DPw/WXrNcCyl1jggdO8D2O0gjlh/51bRuMGtnlsa8aeFzTdUf4RIqlApAs+KYjRqYqmLMs0mIODiYRPCb7nVmlfaR7HVpC4avLNF4moTPmzDhjR7tJNDx+msX+rlKsVsb4/y9y6ehRlGMqpOQq5PSvdlyHpzXden4NUOq8U2KP2j1iJ/Y7ynM+Flr0B/IAYe3gXrfukNVjpc7YCnh4dikx8NUeJwLmzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km8O+Bbqp5VjRWGtVFWspLxJHyuMM46DH/4xj/EyMyQ=;
 b=j6HCtJvJIRhWl9EjTfomabWd5mFKLAPl6XNUuJHDpXFcKVNJzKbxLBzzE9A/+MljFi+m2OV+4+j0xBcQph59k3QIRHNsMPMVwUigibC69Ys/dZc0OZ3W4+6FWorYDKB6saOyWs7YkzbOniygkwHEhrYXskNmIzBqK/hgRhlyZTJOiogjqcI4S5jg825an3OALiD8jfIKK0PEjUb//nfNOtj/dsnhSL5Dkws6EnIWpHacEt0npHrAgBsC1v3dnkjSy3PbE89Lz+cXDWxyy2HaoF365pOuvSTvxCExouskmDlvvYiRZB1GSTnB4I9tAhSsGMf2VMKKajqMV9s2aMOpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km8O+Bbqp5VjRWGtVFWspLxJHyuMM46DH/4xj/EyMyQ=;
 b=bLysYCAmU6Fli+1SaXxk6Y6GB+lL8O315Kcgcq9eCKgtZDZm/ny2w5msFVYyuleDazSKqHs2W1MBmG8VcjRI7w8eHOtYDHTkBCDtEBqLjxZGwn1S13zwEtUBhQcsj1ISXfXgpWeTq8VcQfw6+vb5u/QBh1h+WAoib4fZqLdiDGRvk909AgoqEX8rngRcMhzQE5f3BQM9EjZv9MA/b6y91IX1fBrojaJEmQ3l9utE09sm0KGs/3HFiwjwMRNIPqVHn4Uq9KQVpiBWdi/bS24a1bjESeQG9Uz3QJffIhjd+SPMZdpYJPNn4Q3gkT0L3vpA5vsG1BTqmgzbdOvqSbEBgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 12:58:35 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:58:35 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	linux-doc@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	corbet@lwn.net
Subject: [PATCH v23 09/20] Documentation: add ULP DDP offload documentation
Date: Wed, 28 Feb 2024 12:57:22 +0000
Message-Id: <20240228125733.299384-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: f8503666-677a-4f19-03d0-08dc385cf91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QgY8NyGdQMxhh7RAd311bcjYBPcwKKKrgGCtUnsOuneBk+wUGsbPI/YR+mMO6/TNIP6LjYHuRA9JZV/2eIsl4J5EA3r1NtUQcXO5r3cBAmDTx67CjVAyYVQWcG6u+V/hJBTzatIKb69NPDP15SMwmsl1VRNrXVJijeGCpVBtb7kBuqMJ6sQCUsbVIY8Xu1BiH8L+VcChJY5ONPwsa26mveX78VkNZ/6VEBxIt7pqwmqtJSStSXbPezxy2EzerJkZKMWZCqTgHUWEGnnHoGqPgQpg9cyGt8EbYjtu5gYGCrfI2iC+FwuvST1ck0oywXCWISy/ePqbpsD0Fy4BW5R7+kugYmCp8nk7u9IiGzVVHUkltMEFJPcihWYASJ/yjZ+cWRFjdtzlTPaWCQJfxcofngcjmStVDkp+77BY0dmbyyO9R8MIpTTgLXOwHWBxwb4qsDVKSScG6A7/9BR8vJfIxqp37Oe4qbOFUX62+fUR78UQTe9aYp/QYWLywpZi0wHEsoURnFuF8VcI+uwHY6ZWQB+WQWBnxPuLIJ5R7foZgw8+yEDaP0GScic4UYx/gwzjbwcVG+bcRlMHEjK8IMX1yRQit4dHdOJSyeDlDLyF6y3AJ3Xr85UATk5ZomxRNNHMd6JCa6JMtKYi1ryxAchdlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iW84r4eorqia6YK0HHRVTOHwB9jQZCzpeUbcbsNU2+Z6iqsTyWjVsbh8zidK?=
 =?us-ascii?Q?HSx5/UeiljRmCeBDPgfFnpt4dfw5rHeTcPBmKE5O1V0ONI4tonn6SUFIIUqt?=
 =?us-ascii?Q?T+LZQrF7dh56EHr7GH5fTPZDNCOyeoMh6tk3mxnWdpmSfTTE3sIshb7uJ6K9?=
 =?us-ascii?Q?fCPlLwNfh0WE3jf7bkdfEky1Ykd+xxd8HFdOTnn8ZLUgwyqxqzSY42yqDNJd?=
 =?us-ascii?Q?6K12RGymwOBLMnrvkhEu+sqBVUZNL825HR6m5HrwMU/XlDsF1vzX9o5bXowE?=
 =?us-ascii?Q?bDgueJnyqwUdma/am+k45dxC7OjUSUGAY5MCLjiPrIjq9mXP7qeW1eOIMOwQ?=
 =?us-ascii?Q?5mAVQ6gRU7K0P6Saxq/XRXjD7pDn23ax/VJ+8vJzemDBi78g+0M19h8UA+4d?=
 =?us-ascii?Q?i3JD7zgmgsx4oEV5XGUXjmw7/FA1mZESKbDMNEKY7D/tuGD6FfF7f3KA+G6q?=
 =?us-ascii?Q?LSYGeKxKDmRtwe/EMJeqopxDp+9TMiEwPssiSe4qn6LLxJwBTAyBRbHzWbPR?=
 =?us-ascii?Q?UcsoSVx/UZ6DFSQYQd2OrLfbndvaUcokPzBL5r7gyg5CLdZm3syfWxIO254i?=
 =?us-ascii?Q?8DGXxOQ2SawVKNdOhjEiYlD1U+h1kFDSWuzypwDuZAChDLak5XtfhdFVeNWV?=
 =?us-ascii?Q?m1qk2digN4BOjkFtGPNl78KRm8OCzqZZio+XEw33PzEiQZJV5dN7ql9RcdSC?=
 =?us-ascii?Q?1EQG0jUfV4rntE7VFgRsY7hElVQEMnJe0DtJ5Q3R/b50jSFR8RR62NlmeO6P?=
 =?us-ascii?Q?DI7MW0BRDsmyqIDRxcpFmOd9P5ME2/EsCKWpZvVYnzJoPwVrOiig1S4nvaxE?=
 =?us-ascii?Q?Rq3QQYcnUh6szFH5x/AIVMvD+CVvbDceUKa0bpiFPEmsJECZcs2MqiE0gGEK?=
 =?us-ascii?Q?6ThFg3i8KPhh7bj9hWY4WeacuNr7Q6vuDfq+0a8fD73NjFaK8YiBd6/a8aBj?=
 =?us-ascii?Q?HDLgjIA1Sn35IDrZvlPz4RsxTKiuxsrpZXcjcP8hdzRk0QN43XeSFv1QaE+P?=
 =?us-ascii?Q?kqrpKYiQ6VvxXb6Hj1kVTeYoJExCYS6WhWlhyii4AGa2RIWy8QQRNE9dYHr9?=
 =?us-ascii?Q?C58Vb2neRtzp8sUTNh4wFT6/gtpMZe5gJnOqzgPgIf9QRI3oCygiDxxVhfJs?=
 =?us-ascii?Q?mApmbaUIUsJgCp1LI94dcYScirkVaYY9BkOo3PJBYfGahq5SEo2WpbIgyubw?=
 =?us-ascii?Q?Je38hmQSzsrBuVHk64n4P8E1O4e2uZqm+c52wYqA2Vfuvzd34WZRs+iPnC2j?=
 =?us-ascii?Q?odvH4lH7UphrtRExgUxUddm4iGGX8HwuYOTw5e4AWmJQrA7teq5xybHUNK1D?=
 =?us-ascii?Q?sAqvQ/Trto+CsEoysokJR6lpz0C3miw+PN0Lm0v43N2B0rIWVs0Yg6OCd7rG?=
 =?us-ascii?Q?kHwhKSuq7PrNTlXsij0gMqNnSGhd1En2Uj2VzQNEdm1boqzN27AboufNhiVl?=
 =?us-ascii?Q?p2wi6FbO25HhHZjEeScEVp8gHUifcUW8Q4J6YQqtMttvTGHgpI58swJD/nKF?=
 =?us-ascii?Q?9fs8xwVbjynwEitZL3SvwBH3Hb6BkMEbIt2+JuJI0saWqqGXdaY6wt2Yk+xF?=
 =?us-ascii?Q?K/LBPWE9ArnpKli2UOzlxbB3lCMf4xFcLA1CfL7Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8503666-677a-4f19-03d0-08dc385cf91d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:58:35.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jS9uxQLKUq/oLX7x4uMcjYGLzoGMuOXo9POQREK0WLhA/t1KqIw3HMTUAqG4D/9i8Kj8IAbunEKvVylC1yhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218

From: Yoray Zack <yorayz@nvidia.com>

Document the new ULP DDP API and add it under "networking".
Use NVMe-TCP implementation as an example.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/ulp-ddp-offload.rst | 374 +++++++++++++++++++
 2 files changed, 375 insertions(+)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 69f3d6dcd9fd..2b96da09269f 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -110,6 +110,7 @@ Contents:
    tc-queue-filters
    tcp_ao
    tcp-thin
+   ulp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
new file mode 100644
index 000000000000..438f060e9af4
--- /dev/null
+++ b/Documentation/networking/ulp-ddp-offload.rst
@@ -0,0 +1,374 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+=================================
+ULP direct data placement offload
+=================================
+
+Overview
+========
+
+The Linux kernel ULP direct data placement (DDP) offload infrastructure
+provides tagged request-response protocols, such as NVMe-TCP, the ability to
+place response data directly in pre-registered buffers according to header
+tags. DDP is particularly useful for data-intensive pipelined protocols whose
+responses may be reordered.
+
+For example, in NVMe-TCP numerous read requests are sent together and each
+request is tagged using the PDU header CID field. Receiving servers process
+requests as fast as possible and sometimes responses for smaller requests
+bypasses responses to larger requests, e.g., 4KB reads bypass 1GB reads.
+Thereafter, clients correlate responses to requests using PDU header CID tags.
+The processing of each response requires copying data from SKBs to read
+request destination buffers; The offload avoids this copy. The offload is
+oblivious to destination buffers which can reside either in userspace
+(O_DIRECT) or in kernel pagecache.
+
+Request TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+-------+---------------+-------+---------------+-------+
+ | PDU hdr CID=1 | Req 1 | PDU hdr CID=2 | Req 2 | PDU hdr CID=3 | Req 3 |
+ +---------------+-------+---------------+-------+---------------+-------+
+
+Response TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+--------+---------------+--------+---------------+--------+
+ | PDU hdr CID=2 | Resp 2 | PDU hdr CID=3 | Resp 3 | PDU hdr CID=1 | Resp 1 |
+ +---------------+--------+---------------+--------+---------------+--------+
+
+The driver builds SKB page fragments that point to destination buffers.
+Consequently, SKBs represent the original data on the wire, which enables
+*transparent* inter-operation with the network stack. To avoid copies between
+SKBs and destination buffers, the layer-5 protocol (L5P) will check
+``if (src == dst)`` for SKB page fragments, success indicates that data is
+already placed there by NIC hardware and copy should be skipped.
+
+In addition, L5P might have DDGST which ensures data integrity over
+the network.  If not offloaded, ULP DDP might not be efficient as L5P
+will need to go over the data and calculate it by itself, cancelling
+out the benefits of the DDP copy skip.  ULP DDP has support for Rx/Tx
+DDGST offload. On the received side the NIC will verify DDGST for
+received PDUs and update SKB->ulp_ddp and SKB->ulp_crc bits.  If all the SKBs
+making up a L5P PDU have crc on, L5P will skip on calculating and
+verifying the DDGST for the corresponding PDU. On the Tx side, the NIC
+will be responsible for calculating and filling the DDGST fields in
+the sent PDUs.
+
+Offloading does require NIC hardware to track L5P protocol framing, similarly
+to RX TLS offload (see Documentation/networking/tls-offload.rst).  NIC hardware
+will parse PDU headers, extract fields such as operation type, length, tag
+identifier, etc. and only offload segments that correspond to tags registered
+with the NIC, see the :ref:`buf_reg` section.
+
+Device configuration
+====================
+
+During driver initialization the driver sets the ULP DDP operations
+for the :c:type:`struct net_device <net_device>` via
+`netdev->netdev_ops->ulp_ddp_ops`.
+
+The :c:member:`get_caps` operation returns the ULP DDP capabilities
+enabled and/or supported by the device to the caller. The current list
+of capabilities is represented as a bitset:
+
+.. code-block:: c
+
+  enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST,
+  };
+
+The enablement of capabilities can be controlled via the
+:c:member:`set_caps` operation. This operation is exposed to userspace
+via netlink. See Documentation/netlink/specs/ulp_ddp.yaml for more
+details.
+
+Later, after the L5P completes its handshake, the L5P queries the
+driver for its runtime limitations via the :c:member:`limits` operation:
+
+.. code-block:: c
+
+ int (*limits)(struct net_device *netdev,
+	       struct ulp_ddp_limits *lim);
+
+
+All L5P share a common set of limits and parameters (:c:type:`struct ulp_ddp_limits <ulp_ddp_limits>`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+  * protocol limits.
+  * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+  *
+  * @type:		type of this limits struct
+  * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+  * @io_threshold:	minimum payload size required to offload
+  * @tls:		support for ULP over TLS
+  * @nvmeotcp:		NVMe-TCP specific limits
+  */
+ struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		/* ... protocol-specific limits ... */
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+ };
+
+But each L5P can also add protocol-specific limits e.g.:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+  *
+  * @full_ccid_range:	true if the driver supports the full CID range
+  */
+ struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+ };
+
+Once the L5P has made sure the device is supported the offload
+operations are installed on the socket.
+
+If offload installation fails, then the connection is handled by software as if
+offload was not attempted.
+
+To request offload for a socket `sk`, the L5P calls :c:member:`sk_add`:
+
+.. code-block:: c
+
+ int (*sk_add)(struct net_device *netdev,
+	       struct sock *sk,
+	       struct ulp_ddp_config *config);
+
+The function return 0 for success. In case of failure, L5P software should
+fallback to normal non-offloaded operations.  The `config` parameter indicates
+the L5P type and any metadata relevant for that protocol. For example, in
+NVMe-TCP the following config is used:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+  *
+  * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
+  * @cpda:       controller pdu data alignment (dwords, 0's based)
+  * @dgst:       digest types enabled.
+  *              The netdev will offload crc if L5P data digest is supported.
+  * @queue_size: number of nvme-tcp IO queue elements
+  * @queue_id:   queue identifier
+  */
+ struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+	int			queue_id;
+ };
+
+When offload is not needed anymore, e.g. when the socket is being released, the L5P
+calls :c:member:`sk_del` to release device contexts:
+
+.. code-block:: c
+
+ void (*sk_del)(struct net_device *netdev,
+	        struct sock *sk);
+
+Normal operation
+================
+
+At the very least, the device maintains the following state for each connection:
+
+ * 5-tuple
+ * expected TCP sequence number
+ * mapping between tags and corresponding buffers
+ * current offset within PDU, PDU length, current PDU tag
+
+NICs should not assume any correlation between PDUs and TCP packets.
+If TCP packets arrive in-order, offload will place PDU payloads
+directly inside corresponding registered buffers. NIC offload should
+not delay packets. If offload is not possible, than the packet is
+passed as-is to software. To perform offload on incoming packets
+without buffering packets in the NIC, the NIC stores some inter-packet
+state, such as partial PDU headers.
+
+RX data-path
+------------
+
+After the device validates TCP checksums, it can perform DDP offload.  The
+packet is steered to the DDP offload context according to the 5-tuple.
+Thereafter, the expected TCP sequence number is checked against the packet
+TCP sequence number. If there is a match, offload is performed: the PDU payload
+is DMA written to the corresponding destination buffer according to the PDU header
+tag.  The data should be DMAed only once, and the NIC receive ring will only
+store the remaining TCP and PDU headers.
+
+We remark that a single TCP packet may have numerous PDUs embedded inside. NICs
+can choose to offload one or more of these PDUs according to various
+trade-offs. Possibly, offloading such small PDUs is of little value, and it is
+better to leave it to software.
+
+Upon receiving a DDP offloaded packet, the driver reconstructs the original SKB
+using page frags, while pointing to the destination buffers whenever possible.
+This method enables seamless integration with the network stack, which can
+inspect and modify packet fields transparently to the offload.
+
+.. _buf_reg:
+
+Destination buffer registration
+-------------------------------
+
+To register the mapping between tags and destination buffers for a socket
+`sk`, the L5P calls :c:member:`setup` of :c:type:`struct ulp_ddp_dev_ops
+<ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ int (*setup)(struct net_device *netdev,
+	      struct sock *sk,
+	      struct ulp_ddp_io *io);
+
+
+The `io` provides the buffer via scatter-gather list (`sg_table`) and
+corresponding tag (`command_id`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_io - tcp ddp configuration for an IO request.
+  *
+  * @command_id:  identifier on the wire associated with these buffers
+  * @nents:       number of entries in the sg_table
+  * @sg_table:    describing the buffers for this IO request
+  * @first_sgl:   first SGL in sg_table
+  */
+ struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+ };
+
+After the buffers have been consumed by the L5P, to release the NIC mapping of
+buffers the L5P calls :c:member:`teardown` of :c:type:`struct
+ulp_ddp_dev_ops <ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ void (*teardown)(struct net_device *netdev,
+		  struct sock *sk,
+		  struct ulp_ddp_io *io,
+		  void *ddp_ctx);
+
+`teardown` receives the same `io` context and an additional opaque
+`ddp_ctx` that is used for asynchronous teardown, see the :ref:`async_release`
+section.
+
+.. _async_release:
+
+Asynchronous teardown
+---------------------
+
+To teardown the association between tags and buffers and allow tag reuse NIC HW
+is called by the NIC driver during `teardown`. This operation may be
+performed either synchronously or asynchronously. In asynchronous teardown,
+`teardown` returns immediately without unmapping NIC HW buffers. Later,
+when the unmapping completes by NIC HW, the NIC driver will call up to L5P
+using :c:member:`ddp_teardown_done` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+ void (*ddp_teardown_done)(void *ddp_ctx);
+
+The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on provided
+in `teardown` and it is used to carry some context about the buffers
+and tags that are released.
+
+Resync handling
+===============
+
+RX
+--
+In presence of packet drops or network packet reordering, the device may lose
+synchronization between the TCP stream and the L5P framing, and require a
+resync with the kernel's TCP stack. When the device is out of sync, no offload
+takes place, and packets are passed as-is to software. Resync is very similar
+to TLS offload (see documentation at Documentation/networking/tls-offload.rst)
+
+If only packets with L5P data are lost or reordered, then resynchronization may
+be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU headers
+are reordered, then resynchronization is necessary.
+
+To resynchronize hardware during traffic, we use a handshake between hardware
+and software. The NIC HW searches for a sequence of bytes that identifies L5P
+headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operation
+type can be used for this purpose.  Using the PDU header length field, the NIC
+HW will continue to find and match magic patterns in subsequent PDU headers. If
+the pattern is missing in an expected position, then searching for the pattern
+starts anew.
+
+The NIC will not resume offload when the magic pattern is first identified.
+Instead, it will request L5P software to confirm that indeed this is a PDU
+header. To request confirmation the NIC driver calls up to L5P using
+:c:member:`resync_request` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+
+The `seq` parameter contains the TCP sequence of the last byte in the PDU header.
+The `flags` parameter contains a flag (`ULP_DDP_RESYNC_PENDING`) indicating whether
+a request is pending or not.
+L5P software will respond to this request after observing the packet containing
+TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
+software calls the NIC driver using the :c:member:`resync` function of
+the :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_ops>` inside the :c:type:`struct
+net_device <net_device>` while passing the same `seq` to confirm it is a PDU
+header.
+
+.. code-block:: c
+
+ void (*resync)(struct net_device *netdev,
+		struct sock *sk, u32 seq);
+
+Statistics
+==========
+
+Per L5P protocol, the NIC driver must report statistics for the above
+netdevice operations and packets processed by offload.
+These statistics are per-device and can be retrieved from userspace
+via netlink (see Documentation/netlink/specs/ulp_ddp.yaml).
+
+For example, NVMe-TCP offload reports:
+
+ * ``rx_nvme_tcp_sk_add`` - number of NVMe-TCP Rx offload contexts created.
+ * ``rx_nvme_tcp_sk_add_fail`` - number of NVMe-TCP Rx offload context creation
+   failures.
+ * ``rx_nvme_tcp_sk_del`` - number of NVMe-TCP Rx offload contexts destroyed.
+ * ``rx_nvme_tcp_setup`` - number of DDP buffers mapped.
+ * ``rx_nvme_tcp_setup_fail`` - number of DDP buffers mapping that failed.
+ * ``rx_nvme_tcp_teardown`` - number of DDP buffers unmapped.
+ * ``rx_nvme_tcp_drop`` - number of packets dropped in the driver due to fatal
+   errors.
+ * ``rx_nvme_tcp_resync`` - number of packets with resync requests.
+ * ``rx_nvme_tcp_packets`` - number of packets that used offload.
+ * ``rx_nvme_tcp_bytes`` - number of bytes placed in DDP buffers.
+
+NIC requirements
+================
+
+NIC hardware should meet the following requirements to provide this offload:
+
+ * Offload must never buffer TCP packets.
+ * Offload must never modify TCP packet headers.
+ * Offload must never reorder TCP packets within a flow.
+ * Offload must never drop TCP packets.
+ * Offload must not depend on any TCP fields beyond the
+   5-tuple and TCP sequence number.
-- 
2.34.1


