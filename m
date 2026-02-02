Return-Path: <netdev+bounces-255953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCt6Gf3bgGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:16:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE6BCF754
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B07D830F392A
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBDD387570;
	Mon,  2 Feb 2026 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C7NpPLt6"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54FC3816E9
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051990; cv=fail; b=WKbK4q1VLYsEAEU6+lFETN6zoWVCDbOu13gd1zngi5VsE8klRXdLqPHMOkk9A5Xaw4p3ZOwdSitLfto8BzphMBlK5uSCy9nv3V6gc9serQcKN9gJooMI+jmMM5g+yWkEL2jvpS12fSfQ/TIieLE8G7MWJ/qpoNFdM/sX9R6+i2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051990; c=relaxed/simple;
	bh=c8dqtJ0tl7vsll3l8JOK3Dh94r8YgQikL8Muw7MS+Vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyLawEHDmQyAUzd4nCT/zUsxUpdwA9m0rIvcKgKwap/aDLcpVHe+/xJmrNJ9uaH2577JPxtBICZFOjVt3JtmDEWJOM68YSlExg+cT0mFnQ899MezJ3a/pWiGyCaG7J1k8m/W9p5blYdPHkIju26R+OhHL9c+odZnpaHSj1JFMhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C7NpPLt6; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvwx+MyyBldBaSZkw7XeFSVN0l25nwrjy9Ye9PxymZHc//2X9bmI+ock4Q+sIKG0monT1HWHyXgYFL9CxFCp7YwGBjQzhvzCVJsEmeI+8+nPj4mqHAUJqsFmhgpMnF9gwNHhqRCptR9JM0lFU6seQJ1Q0Z6gXv1t0kqloy1plQq+iB3McnzYzeZErucZF8z6MLJYHaQK3Sihi9apwpfmHxljcjMt/HMKjewgcaI1PjqDappTiXXqN4A5zlcfUGC2wbvEl/alNrWYcPrK+ijFsBUezJqdisQYluRbF79G6V6XJ/XFugJ6WzXnwpnG7GcN+mOYPayusVeLw+TcZH51Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0yRcJJZ22zibAISbgx/8lo576GfWW09aMSHukKwgvo=;
 b=nzhGNizxCHbSxYgKX3S8ovBu0ieIk3PBRa9oUkg5HUQKozuml/Ji+2jmRJki7qTOkFlBBkO+dTZ82CUrCqtsCW6KvZMjpr+5n1GyaAsY/2Ra2l+7HKQ0o8GAsFvuZ7BOJwDQt+ilTQED2Jivyuxw4QeY/dt5rz8W5FSK0NWAs2femtyCplgV/qsY7GqvoEOU1JxatzblkBDIJguDlK5v67UqkxlYo5VixjehnG4fm7nYHsAs+7m2opOlxDKWvN+ERl9YRvs+jtG6Q7SHS6KpJo2cmg6GhNKafOHtXsfOd/JHQTjh/2zAFFCuPG9aoJznpUUK/sduK5spLdmps+eKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0yRcJJZ22zibAISbgx/8lo576GfWW09aMSHukKwgvo=;
 b=C7NpPLt62xPDAdd6E4EWJxbQfMCPFo5yBaXGjh1hPutMQfoI/VMIU05yQNMBdK48k3zFaPvMpJboy2C4pxMF/KOh+B+yqyqN7EAzGnYT9pOS45kF5eNZtuPM739+luL5cOHE1TEvuIzXo0HWgILXk1pa96WS2FxMsyS2NIQox0KYa4T+iES50NHCn4Ni57uIgvoRD4dRLwaSxH0FekTseLQemK+DFEIcpnGC5N/LwKEjQ0qZn3jugZCx/yyiDAI5DxPR1YLcfRpotFSHUP1smkQIIeMcPxoGz1AhKU1DEXGs8GyL8zzg+QwntJMNNjlJXKRsjt17LPbe6e+ifMaR+g==
Received: from DM6PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:333::26)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 17:06:19 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::ae) by DM6PR03CA0093.outlook.office365.com
 (2603:10b6:5:333::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Mon,
 2 Feb 2026 17:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:06:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:57 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:47 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:45 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 12/12] virtio_net: Add get ethtool flow rules ops
Date: Mon, 2 Feb 2026 11:05:18 -0600
Message-ID: <20260202170518.9076-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202170518.9076-1-danielj@nvidia.com>
References: <20260202170518.9076-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ef6744-e21c-4330-14c6-08de627d61ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WnYedpteosbUM3GH/iYQMNDyiW5uSusLO/s7S8q5eY9T10GwBkBMUWh8J45w?=
 =?us-ascii?Q?AHv2T/tkiiGom7u+L5cnnV4AnG0X9Ksj0zP04n/C1tWwaHg3hFOpbbUjJF4i?=
 =?us-ascii?Q?SR1MtKweNB869Lm7tzqj8EqTf2DZl1G5br/acZdcvG7eq+4SIa2hlmMHMhuA?=
 =?us-ascii?Q?SFNlbfsxKLVHO+6ax6HyWc6y06+wV33khHyCxB46gr2dASo+HNaWrSEdKzN+?=
 =?us-ascii?Q?9Ni7I681pVKgYDlmkj7//QwNyvNprPtW8SUpZZfoJfqaysmwHofjOSPA0Con?=
 =?us-ascii?Q?CmmLj9+beWBGaQUuoQ2xo/dbRdc8m3pdk6xHKr97wk6U5K58azmuACJRSZ9X?=
 =?us-ascii?Q?0N4/gmjgpqE5FNtpBvFqCp8JNYEvVjjAlka2lQTwo8Iwbu7T0+QrNCibt0Tp?=
 =?us-ascii?Q?v3ZwgZwji0OTGhS+eL55WQyEwEUqKg5IgmVxSndaOoUr9lp3K8tOf643K0ZM?=
 =?us-ascii?Q?Wygdy/Y9CG6zcczjZV7/1CktvnBqRA7cN5m1escXFOjLyCyAzuGAzMUvg89J?=
 =?us-ascii?Q?YJSzsUyzBnqzr260o75Kdq3gDYiLRsg+rTZWAa80+eFOcrUx138quERyJkLi?=
 =?us-ascii?Q?WfMAXzWR+V6dHnltkrwNo7V0OsPUFdupWmYS3JjaTOrkZ+PYyGGK0SATyBwP?=
 =?us-ascii?Q?VXlv1XD4LIQM5Kd+/OLp8dXGVVfU9/h9CmwZy/UHsXEQP+l2wjoXhWYe/ykv?=
 =?us-ascii?Q?Db7yhQNevJfXJvjxkDrY0vNdAL8fibLVW2KvOtORO8k1Xu6KkIJs6z74Pyub?=
 =?us-ascii?Q?pPa+pewuZb7vmpjS0GtVx2yBjNDUAQzBHTcGLt2c6lI+5XXtzslsR2MgaqBO?=
 =?us-ascii?Q?7YMyAkH8L/WSnhI0st47gWZNJIR8/4PHorVleBVrdArQYDkn5tcPerRGY1P5?=
 =?us-ascii?Q?DT1IXUOgtjqUeZyhlWm799GJqlKeHREI5rFhDtUZOlMeMOwB9k4gwu7EptTB?=
 =?us-ascii?Q?NyIoFOserQ7BVZEEcyfuT+zNc0gWgHYsYZGchhIF8AigiT5LtY+Z8c2CVTDM?=
 =?us-ascii?Q?Z3uf8zX9epXf2MPSs0k7Zk6ZyUVFz+4hYMt42SMIlRgX2cVpT5KF4JsCMAm7?=
 =?us-ascii?Q?ZystqxKXcdrcUhsZOXq8q2FHyMFgsy1j8TjUzRTXKsm4/IMhVtO6KYMHWs2l?=
 =?us-ascii?Q?heOswmk4BYuKNjvZDBq0D8Oipd1s7QZR9bwejPFNZ9y2+D59Ed7Idf3X3JA2?=
 =?us-ascii?Q?K409nHzV3vMk8mwZ+uuo+c7KhsGyGlF04w2/LzWMNPqpfknihJ8QqK/Onyto?=
 =?us-ascii?Q?AkoRPwiRaSY+qR0NXObscYJkWYy9iyXQFxTFSf3YOnFTB9K56TtcrkiQOBX5?=
 =?us-ascii?Q?/epE3q2+Oe8hpam4QlDUsGChSaMRc1LOUZtut3O67eMbS84rW0hUboTEoWKA?=
 =?us-ascii?Q?JNfdU+LVD1Kc8Ngl0Gbxxsp8YtYv0KcuVmo5c9krIIpcBhJ9DRlRNYQhJ9Pl?=
 =?us-ascii?Q?citFpPDiafIB++Z98U+E7PQWIxAC04p0U6v35WXVFQOTD6voDVkw7clOyxZ1?=
 =?us-ascii?Q?XJoHAFuD85vTcCOEncJjS53b7yQWoqy1QZks6okLv0Vhu54p/kqTk9Ydz81j?=
 =?us-ascii?Q?UdGhaS9h+IHREEPWYhCrZO7InnhZSX9GpOoEqGyc5zftowPva1K27Ew7kXR4?=
 =?us-ascii?Q?t1LfiBywfMl3M6+IDHimk83ARK0vbsxZVkGuvE/4Fjl+JLzoCl5IUlAOCfxy?=
 =?us-ascii?Q?MN8ODg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q8Bc2X0uAwS2uEj7IIUI/6LXttb3J4HP10DtZZbqf9zS9+re9c4PHznStzaZd+XucIq4y3ZW/Xs8qw67ATy7cq5crEUREOOSNftPzYgu9e3ZQdU/cg2TQfQIvX5U8WNHiK6PgFS2U7Z1lt5P9rU2huodx3YPNrBal7j+pdJVUKhlE2eydw5mxSys9Gg631HqpJ8qxyZky3lC0ET8jvBQlEgtxSlRc2ePgosKN31SAZ9cKqjIkvyHbkkWb8nCnfJMYO0fZa0cgFK6vP+tBCErGi7xbs21RZP5o4R3R7aMt4y5BdYV25chmmRZLMCoKxj1MQp0GEBo19QnVqIW3IVF9NFFR3KOuKtmvdOBVJ7oykDpmx1/WfQ4Je744QYOiCVoKriVKAQM7nlXX4Gf5X7U4wkxXY2hcm8k/11q/yVaFXIAt+2ym+RmVa0sT5MikIbI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:06:18.5276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ef6744-e21c-4330-14c6-08de627d61ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255953-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,alibaba.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CAE6BCF754
X-Rspamd-Action: no action

- Get total number of rules. There's no user interface for this. It is
  used to allocate an appropriately sized buffer for getting all the
  rules.

- Get specific rule
$ ethtool -u ens9 rule 0
	Filter: 0
		Rule Type: UDP over IPv4
		Src IP addr: 0.0.0.0 mask: 255.255.255.255
		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
		TOS: 0x0 mask: 0xff
		Src port: 0 mask: 0xffff
		Dest port: 4321 mask: 0x0
		Action: Direct to queue 16

- Get all rules:
$ ethtool -u ens9
31 RX rings available
Total 2 rules

Filter: 0
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 192.168.5.2 mask: 0.0.0.0
...

Filter: 1
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: Answered questions about rules_limit overflow with no changes.

v12:
  - Use and set rule_cnt in virtnet_ethtool_get_all_flows. MST
  - Leave rc uninitiazed at the top of virtnet_get_rxnfc. MST
---
---
 drivers/net/virtio_net.c | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1af73a765d85..a82db11cdd85 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -313,6 +313,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
 				       struct ethtool_rx_flow_spec *fs,
 				       u16 curr_queue_pairs);
 static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info);
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info);
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs);
 
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
@@ -5596,6 +5603,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
 static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -5637,6 +5666,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -6568,6 +6598,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
+
+	return 0;
+}
+
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
+	if (!eth_rule)
+		return -ENOENT;
+
+	info->fs = eth_rule->flow_spec;
+
+	return 0;
+}
+
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i = 0;
+	int idx = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
+		if (idx == info->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[idx++] = i;
+	}
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+	info->rule_cnt = idx;
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
-- 
2.50.1


