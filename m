Return-Path: <netdev+bounces-48463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790FD7EE6B8
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 19:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CB61C20991
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48364642D;
	Thu, 16 Nov 2023 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fiLcRKap"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7302B195
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 10:29:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNLCfsL9fVcXA7M/0Bsm67qz+Sio+OhEq2LaY6QSGyMxGRGriWW0+rfjaN1XtCvzQRZGLNsSxz/+NX1LjOa28TnOLJr/H3xGUAzwOEw8NSfSSuhIqwchV2Go2FRi14boMaOIFfmHM75hGtIa3PoJkAdY8lw5cRgiAhZK50O/wyd6rR39uhyTv18SxOrHZ14iQKoOHV6N44wuKPYD4/GD8yB5jUdq1TU+sIVEkv3uPi/bbXZyzB3VOTiWKfAWEEcuB1ThbxG8wqr8S1wn/vvTveLaha6fmXu8ED5MfwP0ejcEdnEmhbdN7bdxCO1LLVGL+6S7hEHA83mDunqnKef/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHnw6Z50q8FXhW/0E65Y5Lc+7OBE6/R9iA7joNzqLEg=;
 b=LsuyDPjAoH1eqwej5lLx/p5CEQs54/ZK9n9BwzVbQEvlVP2Hke6k3QpimtGHuIUArCirqKzOj3Lr7YurQka8/BEOaLFO7YhiEAVv8/7P1qPSC2hqlZsEpME8GNx2vBa1xkEX4kVR8owXGyFclX6+mM0ICAt5YLgBitkE+jAWk6L/VvukvzcmQWJiE55XP7nWzoQ9zi3Dituv+xsivFMSdzYP0BedvcXpWF1JekOqUsmXqsGfGVmjv2lyoDww94CMf4FWfIp68yjL+8YxcvGMqVzziM0mWSmNDvdc3MHa66JlUBuVSzIhKBcNY3KTRhAUXbjORGeM5niJcgDtvjJEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHnw6Z50q8FXhW/0E65Y5Lc+7OBE6/R9iA7joNzqLEg=;
 b=fiLcRKaphBF4B53ET0fKR2aw8C8Eu3stvkZ/DF+4fy6W7xw5Xdpu4G1ZDnPq9Qmsf4THfHn0n/chwKyTVc0i3sSg6s0rHIFrRc77NHrfSmNciNOQo6XXFVD94hAExhw2ZwXMskcU2D0yXo2bSG8TSuMfMQOOxzAn1h9gGPr6b77xb6yCgeMDcUe4AHAaoAOwz4OMlMPIf86ETAhEF3o59aieWdUWNpxXV8h9SSpGAYntZv8vr51lvO3uDc/bms516q6E6tiHopKl3JMj7wHYizIqy4K9JZ4C+DsNp/Hahc74GcZndlFUd56JHv4N6QXRX9HwbVpqU/R6DY93jdpoxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 18:29:12 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 18:29:12 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeed@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH RFC net-next v1 0/3] Take advantage of certain device drivers during MACsec offload
Date: Thu, 16 Nov 2023 10:28:57 -0800
Message-Id: <20231116182900.46052-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9d6f53-f89e-47d6-1acd-08dbe6d1edf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nei68eIlccutcVG7chctTMpITNBC38Ba++RoDM8X6M2w469LoT+wFGE4h1PrbwsHZIcvTY1DsZo1JGGu427KARLd8DfZysHS3bJr+Z5ByTwaKIp27MwCeqVJJO0QRzCOKFpBxhgx/w1W3XxztIN8F660m7WIEn/lFfgM/ZaQP+UQZ0opqD9Ga1tD2M7KGL9U2Oe5baa5R56ZAuPZ75zYvq0jUaVAqJpanG/YITOpPPvzDOoWuBRZ/4J5xoKicmZMCIPVYoTgT9dd26GN7YUbdo2stCYqSjbRRIoSEKqwp9QvmLizx2KSjVeOGFbWgHARO68GhOPzYl5tUwwy5QqoEYFAkrAjbmHOPrORXDXGh42JZx+9AqihG+z1hL17U9FAXLizVvfPpUXaj9fjX5+YkRSRbU3RsrVIM72uM9Q4wE5X+JrvPfINLX1xsjXDglVYp4CNJMnRDm9lIbYAjkM62PuWK8bYusWfstxhlQwZZJaoBgcmmUQnoTWEDXUZYsci4CnqWEG5gnifZqrzFUvhrWaswAuNOr7tAx6+bjBcnmtXd8tCBbH2FWgzXO/brw7eL2mwlAnSgXwFZpQlLSzX05UaKvybNGxJ5OJsPkJ9knssLjRSrG2/aIUYeKgpsImW+1wbuMQ7Et078fpKoA3opPjNXAoE9f4t5OY3kjSF9nNREr1W7ETVhpOG+nwmvDC4GnimrwlSyn8msCkAlfVT070R04VZlSlmmwMQKJaL3EnDWJ9Skq01lS5zb7XjNt8/LZqgsRH/GjxjnF1jwoV9R+LjUz3cxDba72PO4jlXY4nmzxcvcYn3aLp26BKB3txt8jgncZhXHr/wa7eGXEgKXTXEtGD6c8fPu2JemeExN/VqWcW1qEMWnqIeoCH+SHmb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66946007)(41300700001)(66476007)(316002)(6916009)(66556008)(54906003)(8676002)(86362001)(5660300002)(2906002)(4326008)(8936002)(83380400001)(38100700002)(6666004)(966005)(6486002)(478600001)(36756003)(1076003)(2616005)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T3QGVsZtOF6pHX8wETmilqmrWo7vIQ+BJmqZ2GZm4eDfjIEHYVaBY/gSVAX6?=
 =?us-ascii?Q?VRlv8V8NbosNIWdJ2iKIcHZ6yltOjvkQ/GnDWRz+pcnIGWYKeVCnDjsokWbn?=
 =?us-ascii?Q?GlPdZClWVrqqohRxxXAC9WRdrKUahUmgd3IdWw776+TD9y2fqvrjY2WCHPak?=
 =?us-ascii?Q?oqqsSUiZFP8X4e1JuLsMOvn4JD3T3yzG5hPkckGTlLy3Q0A0LXmpvS92uXO4?=
 =?us-ascii?Q?zvgNVXmsuLEeNhfKs7F4mVDeGiDzxWR/X3kmFpgWHIE/8HpnZL+EweERvI3k?=
 =?us-ascii?Q?XAGsoIp3IHHNe8T1usQd7mpYaYYxfGIMxWivJ+Hfdbyjnfy1D9ZOuAku5/03?=
 =?us-ascii?Q?qrMgBlzZGZlYjOyYSeAp/i3CpyFiyeLrU5PdZX/f2tVWDEnbZr72PRKI+qkg?=
 =?us-ascii?Q?V4N1y1KEEMuKM0FnPpzI6rznlFu7uWkHSp8zZO5yv1oRJk02Bnfz6FjxvQ64?=
 =?us-ascii?Q?t59/G/VZ4Ssia86lvm7STnZS1WI8znZ2zHR062htrRWVtK+uMadvKyGZQCcQ?=
 =?us-ascii?Q?6h3eBVpH91NIDNaF81nqpQQw1ZTtR6N00VjQoTkBMuIX+m6oC4Ju+nJ25Ko8?=
 =?us-ascii?Q?i2+A7C+PQ3boYUg58JWzcZMwHiEyOSlEzgBk+lrK4I/PHDdlse13sZwU5apO?=
 =?us-ascii?Q?Fbg88fc+6DEZbxo+iagLXHwuiBdl99YJvmEjFoR9lyqqTJ6Z+7qpph+o+ytL?=
 =?us-ascii?Q?5Dod98SqcCiYF7odxmVAOC4j6MYRFxhWayu16VxfiRMwsAWaAdJEXrsDMZlc?=
 =?us-ascii?Q?UkNlLQ/t+r2syM1C+97YCVfzJ8t+SUSfEjPgjw3YCg3KbwBO+A1NZf5iLAaz?=
 =?us-ascii?Q?pciM27kTnSfdcm93H2jZUVJ5/+SHo4aKTEB4NDg7bThe7u2OtTFRyvXubjP+?=
 =?us-ascii?Q?50A7Q6DMHk2edX3JrE8totwHhexfeHLCKEnW7BS5KRufSnwmlwDSx11W3b0G?=
 =?us-ascii?Q?lnTTvqL0uxQYcnXtTtIe9Q+u7/dZ/5UyejBt8DyXJlQ03VbudbBQycH3pVEj?=
 =?us-ascii?Q?WxS1w84tH8dLOOXE77IdtGag3jlRF9W0SOMNfrbCw+Yoqdzq5QmlVLx6DkWA?=
 =?us-ascii?Q?GX8spESkL2+ut3IqxOKlIm+D4YFiSZFXA/24IfJMjp2wWPyfa5j6gLNg4LZR?=
 =?us-ascii?Q?RlI3B3M8usFHl3XgeQRT50gjzGjjDELlzdQOSOIPWTrZmBTYvRHcp6HYzyju?=
 =?us-ascii?Q?sIyyigroek8v9y/v68XquMCE1n9DFGNjttZYLNoXRVLntmJsBJNw3DvCjbAY?=
 =?us-ascii?Q?9iu+01VvsIbHMhSVRKdiMR+OtsIJI/V84yA+yrlL57PTZI24YLVL8zBpb0ja?=
 =?us-ascii?Q?9agtrNZktMSNKixC8Bl4FVYgehIvX/J1L0De+MAiye/LyUNzE9LBMUVOzNbl?=
 =?us-ascii?Q?74OvLsZYFSmGhcYlhGHJvhSsSHJOyKII1zEwQG+8yDf3q8ujQYDle3KvnlIL?=
 =?us-ascii?Q?RT92LVuoAQ9RV8tEhAaIA6FynPiICpEFARPAJrlLrRrlByzItf5EROTMY0ax?=
 =?us-ascii?Q?xhCSR4TS5iED6PQxyNZ7m5lUvyCqud8Pw7xroINqA/2x7cQwajDNoESz7bbj?=
 =?us-ascii?Q?Ve+DNDe2oBtBNMMr3aRAC6uQ/Sel/n17w6rUECtyjv+iYF54cYJK4f6/XG1c?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9d6f53-f89e-47d6-1acd-08dbe6d1edf7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 18:29:11.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47puvKEUXkqXzQG0RG8j1AqwA4v9pBb7c5KZEfXGH6kvd7ta8jLGTYk2Qfube9MNzLCHyfzpHUoOuzx8iHELgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

Some device drivers support devices that enable them to annotate whether a
Rx skb refers to a packet that was processed by the MACsec offloading
functionality of the device. Logic in the Rx handling for MACsec offload
does not utilize this information to preemptively avoid forwarding to the
macsec netdev currently. Because of this, things like multicast messages
such as ARP requests are forwarded to the macsec netdev whether the message
received was MACsec encrypted or not. The goal of this patch series is to
improve the Rx handling for MACsec offload for devices capable of
annotating skbs received that were decrypted by the NIC offload for MACsec.

Shown below is an example use case where plaintext traffic sent to a
physical port of a NIC configured for MACsec offload is unable to be
handled correctly by the software stack when the NIC provides awareness to
the kernel about whether the received packet is MACsec traffic or not. In
this specific example, plaintext ARP requests are being responded with
MACsec encrypted ARP replies (which leads to routing information being
unable to be built for the requester).

    Side 1

        ip link del macsec0
        ip address flush mlx5_1
        ip address add 1.1.1.1/24 dev mlx5_1
        ip link set dev mlx5_1 up
        ip link add link mlx5_1 macsec0 type macsec sci 1 encrypt on
        ip link set dev macsec0 address 00:11:22:33:44:66
        ip macsec offload macsec0 mac
        ip macsec add macsec0 tx sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
        ip macsec add macsec0 rx sci 2 on
        ip macsec add macsec0 rx sci 2 sa 0 pn 1 on key 00 ead3664f508eb06c40ac7104cdae4ce5
        ip address flush macsec0
        ip address add 2.2.2.1/24 dev macsec0
        ip link set dev macsec0 up
        ip link add link macsec0 name macsec_vlan type vlan id 1
        ip link set dev macsec_vlan address 00:11:22:33:44:88
        ip address flush macsec_vlan
        ip address add 3.3.3.1/24 dev macsec_vlan
        ip link set dev macsec_vlan up

    Side 2

        ip link del macsec0
        ip address flush mlx5_1
        ip address add 1.1.1.2/24 dev mlx5_1
        ip link set dev mlx5_1 up
        ip link add link mlx5_1 macsec0 type macsec sci 2 encrypt on
        ip link set dev macsec0 address 00:11:22:33:44:77
        ip macsec offload macsec0 mac
        ip macsec add macsec0 tx sa 0 pn 1 on key 00 ead3664f508eb06c40ac7104cdae4ce5
        ip macsec add macsec0 rx sci 1 on
        ip macsec add macsec0 rx sci 1 sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
        ip address flush macsec0
        ip address add 2.2.2.2/24 dev macsec0
        ip link set dev macsec0 up
        ip link add link macsec0 name macsec_vlan type vlan id 1
        ip link set dev macsec_vlan address 00:11:22:33:44:99
        ip address flush macsec_vlan
        ip address add 3.3.3.2/24 dev macsec_vlan
        ip link set dev macsec_vlan up

    Side 1

        ping -I mlx5_1 1.1.1.2
        PING 1.1.1.2 (1.1.1.2) from 1.1.1.1 mlx5_1: 56(84) bytes of data.
        From 1.1.1.1 icmp_seq=1 Destination Host Unreachable
        ping: sendmsg: No route to host
        From 1.1.1.1 icmp_seq=2 Destination Host Unreachable
        From 1.1.1.1 icmp_seq=3 Destination Host Unreachable

Link: https://lore.kernel.org/netdev/87r0l25y1c.fsf@nvidia.com/
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Rahul Rameshbabu (3):
  macsec: Enable devices to advertise whether they update sk_buff md_dst
    during offloads
  macsec: Detect if Rx skb is macsec-related for offloading devices that
    update md_dst
  net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for
    MACsec

 .../net/ethernet/mellanox/mlx5/core/en_accel/macsec.c |  8 ++++++++
 drivers/net/macsec.c                                  | 11 +++++++++--
 include/net/macsec.h                                  |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.40.1


