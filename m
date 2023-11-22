Return-Path: <netdev+bounces-50049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2007F481D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0884C1C2091E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC71D533;
	Wed, 22 Nov 2023 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iOZvEWPP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051BD56
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:48:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6DKLed+FfXg98JSuzHMCElIZGIewLGSJmNBVKZPWqS9bvUPpwqCk/ElPWViD7pLWXgidrPbhJdAeRZtG9zw1ZIOHuIaIOVtzT1s5BZxrD/Gt8i94R0sfjitlnaE6Mb4MfboM8Ytc/8y6tYB6UY7umVGFgfm3+pqNcwhbdvaajABEe9q2o1dvap6OF3Fry6Xrp+CyzwVLWCZE5yDq0auxa28fInoPuo7EO59mlv2fZy9Ux29DR1kGcKAv6ffMHT3KrfPWk4Tz2cMRF9c5co+l/5uSUkgYHCeNqWfRJgu9h0qCsZx+mldEcz6Zc3fbaoeR55MxYYTUFGEZNPkqycmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BUVTVUIoOOHkjPR8/CkZeWLy/e80cv4cuA+TpWiPSU=;
 b=ZCWAqYU7yC9LPPFKI6hTsrpBbSzJQTdGUmMr1oQbxeVpJPAl2M9vjTD3R30tuWn2e3Q5g323eUvIBJ+xhf5EWYE5tvT/linlcnCgA10cd7NDP//XQo7QIzRKA0bH0pG1GpsG7bPIWlyVMmcmRERsmygiRNiMMsyMeYe7ICnwJ2h7rSjKT4I53BcYFnRUy2jOOK41K2ip4dVuL8E0lnZmT0UmDK6Nx8cMJMjd8BVeBt605Esoe8/B8WfFlzEwHbvLN95WJd2mqV4Tq42T3riHIZQbGCXn+rrF25Ijq2MiN3O+vIDAhqumEVwsDEB2VZoBGUQbIMJ6CZcJBHx5q/IMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BUVTVUIoOOHkjPR8/CkZeWLy/e80cv4cuA+TpWiPSU=;
 b=iOZvEWPPf2IC/0O+qU0uVWs1o4l0+do1pIJV8C/qSRtVJOZzpOMmLdU+3C1/w1WR+qYrR/KfLqO8tmrTlJYaze38zScErOo4cJFNA7yjfVCCt4piwp/zvGh8AhBOg/B7Ii5rxn4vm7PwQoOpfHcuAehjDEKATPMiLW1KK8lAE/PdSUb6FLWgo9illnQ1yXIeTpqg9EF6cYZRNqjnfRf63RVWhWfRlB8jUs9B08dEOnYnAujLw5D4Kys2E0ON6aCS6CwjzGUWpiDL3nSEtfPlGvS+7bOXXSKK6cU+kUTMru3FOEgMcYFp8vXs0BtivDfOfvxLP/cdLGVo/eNw9/hobQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:48:46 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:48:46 +0000
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH v20 01/20] net: Introduce direct data placement tcp offload
Date: Wed, 22 Nov 2023 13:48:14 +0000
Message-Id: <20231122134833.20825-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::24) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 943a9639-d774-4886-dcf2-08dbeb61bf89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3aVmVDegSZr1j6fVuaOwdXpP45O4zuBBU4K1ZvXcWBOJKhKH1FhNoHPEiJ6/a62smvtSR6LXjBQkXSo5VfiPMzECJG9Fp0SGW5+/Qs8lXqHg7AhsFsagSvUOWVg/cjGr5sXIDno9F5k989JN+uPNpeZK7yarr3519DpQkSg2nHy4QvA7r7ajnt3zmbkEoN+vfhUUXYb8SqUqQzRccOhWF4QUMgESnLKR/tPJFFw4524h2pYgcWyDF4ay7AvC9dJee16UPwP+of3a+raqqjbZyRiGqe7vZCqkmg2RpFCnD7/Q4DWN7Ot2djXrbUTcSK3h4z5GLcGg5TIy885LuT/Fd195Uggsh1kDxuyfhLpbkkhnbahyHgfFfXJLOiwZI3L0mN8YITLqSSGiqAsRxFiulZDluIPNvapv9qbDCHE9tc1SlRvyWa1wKUEGroBzuPbR07XG+Hzg0kpRil1Uw6F+rsC8cw6RNbkfPzYJClmJ7wMtzqi6v1ZiI39beIar2KgJIn2R3/0miTE1l6m30NxpM/CFADerjhJbXvPayvrLuw7TzrQKQHAs2BNKb+yEFio1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(30864003)(2906002)(5660300002)(4326008)(86362001)(8676002)(38100700002)(8936002)(7416002)(41300700001)(36756003)(6512007)(2616005)(1076003)(26005)(6666004)(6506007)(83380400001)(478600001)(66556008)(66946007)(66476007)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dqNdKFaXxMYuUOgIy0G66OEQyzjule5UPE07OEON+druTcoLdf6zRcVY6E2M?=
 =?us-ascii?Q?TLliJ+TDE08dr8y4UM2koSYSH2t1R0qzaWcWR1OdZRlQZMkIxv9IKf+uBGPM?=
 =?us-ascii?Q?1N30tuLYTbWuAGqWhKSCUuwPiQ9+PnnxX/KDu62OhGSXRrkNrScbGIDRkNU4?=
 =?us-ascii?Q?x35DNf0yo8G6+MH8qtc0pDa4XN0vURF8dbjg3eWld41ltu8edjcreQjvjdW7?=
 =?us-ascii?Q?z6rgGVCVxAS6TRHllNGsEzhuFNxxCYEKm8g9P5ytad1E1iCAvMO4ssfg/o2D?=
 =?us-ascii?Q?7EOQLVO2/2Vl3FmlmX1QzSE7ySl/6Bu2UPUX+l5pl8XhVbe+aqw1cjRXZ4FF?=
 =?us-ascii?Q?3Ym2hc8G4pHw3s2JAl3E7YKJzDhv/Ytt2gonSgUhIT+z19wXz9M3QoCFNa15?=
 =?us-ascii?Q?Sf1NorGcXfnnjXusuKFDySIbclM5WDdnzcnI1d5eigCXbQjxkuZhuhxx61xx?=
 =?us-ascii?Q?dBo1760oXsWsCmGBrMNPXYhAtyKszC0doiUCwkj/XNI6aoAS6Nl4PueOFA9a?=
 =?us-ascii?Q?rp44XlJAdFbv+rDKLICRbwg5MrubouGVcOhQhlnVvaMQWi0JEfMgK0tbeDmq?=
 =?us-ascii?Q?mf/nA62Qfs/JbHFxdNDprMuqCHEiQBKUMozQTEVP2axkr06y7aMnC0PP9jiP?=
 =?us-ascii?Q?T8iqoRinQPcw7p01tL/gByQ8Ivg3YyqiJKLTEpmP53EEgc9abAsjNXtnNIZJ?=
 =?us-ascii?Q?nF9P/bEgd/63L91Ed7W0JKTAsCESHnlQR6Qx0FqYGSopyycNdUk1CUfgp6wE?=
 =?us-ascii?Q?Lb1rqUalzh499Hf+XVZVFdDs2DH01OA4obhEUIsBOfqzTX10DzNHYMCefEPi?=
 =?us-ascii?Q?NnrOPqkAFK3K3mXdqGWqSZ8/UYVWYkiWs2qbDTEJZUOke76R88SU13IWD5yq?=
 =?us-ascii?Q?MV3+hlZF8VaREYywQIXPeeOKIQyE7iaQNQCxy0Tja612wERNiABy9HPissT3?=
 =?us-ascii?Q?u8o9M7hZUf3EoQVE1yo8ry2/x2MOQaOokjI0E+pteKfEvPvW/JBZ0a+lAA7v?=
 =?us-ascii?Q?/7TYMTEV1C1M5ooFu4zD6+8L72tKKbIyb3dp+2YD53ZzlntiGMfJ3lSt1pCJ?=
 =?us-ascii?Q?mra1FHkcYRpi78hZdm6Xk50rWnAts+bUz+njGEUjkeuZFkQdPG4n2Mr6Wueh?=
 =?us-ascii?Q?gumGZjPaxIbApygYty32ZyuWOigbPGu62ryp9WgrZk3mZrBA2Z/M1kZkNwsb?=
 =?us-ascii?Q?5nXgwd9EYqbEX5s29TEoAta2qMKAPLjrJ970UkrQn1k2ldGxDfQB/V+KW2NZ?=
 =?us-ascii?Q?CSmrXWK+PoBSkXGyjaZqRdWdgXOtj9lQitVHHVJxmYymS0BhkcxPIAS5MCBo?=
 =?us-ascii?Q?24nH62x9PSFx/tkjQKypCTpy6vlbSQiyhJ4pk4Ii1KPFOFP4B0ecSCVDyP4y?=
 =?us-ascii?Q?hck7FcIv24z7jhmY6HeysEkYwP/f3wr04pUxPSr8Fm8Oe1fRTCdms2pr7y44?=
 =?us-ascii?Q?SiWuVI/qA4N2eXNzLMQQA6jG5ZQcfDiSbUYq7pj8qkGGBlv+KA1VB3tgiU0o?=
 =?us-ascii?Q?kR5HntRwZNKZsAKmHte2Ao0fE69Zc2ZaPZrRVvJVSFFFXO8R3bHWraZvQvGX?=
 =?us-ascii?Q?3mqYS0/HV0UajMZdG79l8Rxq8yyPNwpSG0d6JXnw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943a9639-d774-4886-dcf2-08dbeb61bf89
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:48:46.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36BUjCd1m3kKrVP0z/RRU6APrivqIBbD5WF+FfLNHr7HiHmCEpbXh5oQrBxq8CT0IT0z88hvToG3XS5RTZSXvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement (DDP) offload for TCP.

The motivation is saving compute resources/cycles that are spent
to copy data from SKBs to the block layer buffers and CRC
calculation/verification for received PDUs (Protocol Data Units).

The DDP capability is accompanied by new net_device operations that
configure hardware contexts.

There is a context per socket, and a context per DDP operation.
Additionally, a resynchronization routine is used to assist
hardware handle TCP OOO, and continue the offload. Furthermore,
we let the offloading driver advertise what is the max hw
sectors/segments.

The interface includes the following net-device ddp operations:

 1. sk_add - add offload for the queue represented by socket+config pair
 2. sk_del - remove the offload for the socket/queue
 3. ddp_setup - request copy offload for buffers associated with an IO
 4. ddp_teardown - release offload resources for that IO
 5. limits - query NIC driver for quirks and limitations (e.g.
             max number of scatter gather entries per IO)
 6. set_caps - request ULP DDP capabilities enablement
 7. get_caps - request current ULP DDP capabilities
 8. get_stats - query NIC driver for ULP DDP stats

Using this interface, the NIC hardware will scatter TCP payload
directly to the BIO pages according to the command_id.

To maintain the correctness of the network stack, the driver is
expected to construct SKBs that point to the BIO pages.

The SKB passed to the network stack from the driver represents
data as it is on the wire, while it is pointing directly to data
in destination buffers.

As a result, data from page frags should not be copied out to
the linear part. To avoid needless copies, such as when using
skb_condense, we mark the skb->no_condense bit.
In addition, the skb->ulp_crc will be used by the upper layers to
determine if CRC re-calculation is required. The two separated skb
indications are needed to avoid false positives GRO flushing events.

Follow-up patches will use this interface for DDP in NVMe-TCP.

Capability bits stored in net_device allow drivers to report which
ULP DDP capabilities a device supports. Control over these
capabilities will be exposed to userspace in later patches.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h          |   5 +
 include/linux/skbuff.h             |  25 ++-
 include/net/inet_connection_sock.h |   6 +
 include/net/ulp_ddp.h              | 325 +++++++++++++++++++++++++++++
 net/Kconfig                        |  20 ++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   3 +-
 net/core/ulp_ddp.c                 |  84 ++++++++
 net/ipv4/tcp_input.c               |  13 +-
 net/ipv4/tcp_ipv4.c                |   3 +
 net/ipv4/tcp_offload.c             |   3 +
 11 files changed, 485 insertions(+), 3 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2d840d7056f2..228ba67d3378 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1427,6 +1427,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1668,6 +1670,9 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops	*ulp_ddp_ops;
+#endif
 };
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 27998f73183e..5c5373a1dee6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -810,6 +810,8 @@ typedef unsigned char *sk_buff_data_t;
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
  *		delivery_time at egress.
+ *	@no_condense: When set, don't condense fragments (DDP offloaded)
+ *	@ulp_crc: CRC offloaded
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -989,7 +991,10 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_not_inet:1;
 #endif
-
+#ifdef CONFIG_ULP_DDP
+	__u8                    no_condense:1;
+	__u8			ulp_crc:1;
+#endif
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5066,5 +5071,23 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+static inline bool skb_is_no_condense(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->no_condense;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_is_ulp_crc(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index d0a2f827d5f2..583b7272112f 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -67,6 +67,8 @@ struct inet_connection_sock_af_ops {
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
  * @icsk_clean_acked	   Clean acked data hook
+ * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
+ * @icsk_ulp_ddp_data	   ULP direct data placement private data
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -97,6 +99,10 @@ struct inet_connection_sock {
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
 	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
+#ifdef CONFIG_ULP_DDP
+	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
+	void __rcu		  *icsk_ulp_ddp_data;
+#endif
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
new file mode 100644
index 000000000000..fa3f84939901
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,325 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *   Author:	Boris Pismenny <borisp@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _ULP_DDP_H
+#define _ULP_DDP_H
+
+#include <linux/netdevice.h>
+#include <net/inet_connection_sock.h>
+#include <net/sock.h>
+
+enum ulp_ddp_type {
+	ULP_DDP_NVME = 1,
+};
+
+/**
+ * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+ *
+ * @full_ccid_range:	true if the driver supports the full CID range
+ */
+struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+};
+
+/**
+ * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+ * protocol limits.
+ * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+ *
+ * @type:		type of this limits struct
+ * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+ * @io_threshold:	minimum payload size required to offload
+ * @tls:		support for ULP over TLS
+ * @nvmeotcp:		NVMe-TCP specific limits
+ */
+struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+};
+
+/**
+ * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+ *
+ * @pfv:	pdu version (e.g., NVME_TCP_PFV_1_0)
+ * @cpda:	controller pdu data alignment (dwords, 0's based)
+ * @dgst:	digest types enabled (header or data, see
+ *		enum nvme_tcp_digest_option).
+ *		The netdev will offload crc if it is supported.
+ * @queue_size: number of nvme-tcp IO queue elements
+ * @queue_id:	queue identifier
+ */
+struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+	int			queue_id;
+};
+
+/**
+ * struct ulp_ddp_config - Generic ulp ddp configuration
+ * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
+ *
+ * @type:	type of this config struct
+ * @nvmeotcp:	NVMe-TCP specific config
+ * @io_cpu:	cpu core running the IO thread for this socket
+ */
+struct ulp_ddp_config {
+	enum ulp_ddp_type    type;
+	int		     io_cpu;
+	union {
+		struct nvme_tcp_ddp_config nvmeotcp;
+	};
+};
+
+/**
+ * struct ulp_ddp_io - ulp ddp configuration for an IO request.
+ *
+ * @command_id: identifier on the wire associated with these buffers
+ * @nents:	number of entries in the sg_table
+ * @sg_table:	describing the buffers for this IO request
+ * @first_sgl:	first SGL in sg_table
+ */
+struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+};
+
+/**
+ * struct ulp_ddp_stats - ULP DDP offload statistics
+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
+ *                           for offloading.
+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
+ *                         Direct Data Placement.
+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
+ * @rx_nvmeotcp_drop: number of PDUs dropped.
+ * @rx_nvmeotcp_resync: number of resync.
+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
+ */
+struct ulp_ddp_stats {
+	u64 rx_nvmeotcp_sk_add;
+	u64 rx_nvmeotcp_sk_add_fail;
+	u64 rx_nvmeotcp_sk_del;
+	u64 rx_nvmeotcp_ddp_setup;
+	u64 rx_nvmeotcp_ddp_setup_fail;
+	u64 rx_nvmeotcp_ddp_teardown;
+	u64 rx_nvmeotcp_drop;
+	u64 rx_nvmeotcp_resync;
+	u64 rx_nvmeotcp_packets;
+	u64 rx_nvmeotcp_bytes;
+
+	/*
+	 * add new stats at the end and keep in sync with
+	 * Documentation/netlink/specs/ulp_ddp.yaml
+	 */
+};
+
+#define ULP_DDP_CAP_COUNT 1
+
+struct ulp_ddp_dev_caps {
+	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(hw, ULP_DDP_CAP_COUNT);
+};
+
+struct netlink_ext_ack;
+
+/**
+ * struct ulp_ddp_dev_ops - operations used by an upper layer protocol
+ *                          to configure ddp offload
+ *
+ * @limits:    query ulp driver limitations and quirks.
+ * @sk_add:    add offload for the queue represented by socket+config
+ *             pair. this function is used to configure either copy, crc
+ *             or both offloads.
+ * @sk_del:    remove offload from the socket, and release any device
+ *             related resources.
+ * @setup:     request copy offload for buffers associated with a
+ *             command_id in ulp_ddp_io.
+ * @teardown:  release offload resources association between buffers
+ *             and command_id in ulp_ddp_io.
+ * @resync:    respond to the driver's resync_request. Called only if
+ *             resync is successful.
+ * @set_caps:  set device ULP DDP capabilities.
+ *	       returns a negative error code or zero.
+ * @get_caps:  get device ULP DDP capabilities.
+ * @get_stats: query ULP DDP statistics.
+ */
+struct ulp_ddp_dev_ops {
+	int (*limits)(struct net_device *netdev,
+		      struct ulp_ddp_limits *limits);
+	int (*sk_add)(struct net_device *netdev,
+		      struct sock *sk,
+		      struct ulp_ddp_config *config);
+	void (*sk_del)(struct net_device *netdev,
+		       struct sock *sk);
+	int (*setup)(struct net_device *netdev,
+		     struct sock *sk,
+		     struct ulp_ddp_io *io);
+	void (*teardown)(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *io,
+			 void *ddp_ctx);
+	void (*resync)(struct net_device *netdev,
+		       struct sock *sk, u32 seq);
+	int (*set_caps)(struct net_device *dev, unsigned long *bits,
+			struct netlink_ext_ack *extack);
+	void (*get_caps)(struct net_device *dev,
+			 struct ulp_ddp_dev_caps *caps);
+	int (*get_stats)(struct net_device *dev,
+			 struct ulp_ddp_stats *stats);
+};
+
+#define ULP_DDP_RESYNC_PENDING BIT(0)
+
+/**
+ * struct ulp_ddp_ulp_ops - Interface to register upper layer
+ *                          Direct Data Placement (DDP) TCP offload.
+ * @resync_request:         NIC requests ulp to indicate if @seq is the start
+ *                          of a message.
+ * @ddp_teardown_done:      NIC driver informs the ulp that teardown is done,
+ *                          used for async completions.
+ */
+struct ulp_ddp_ulp_ops {
+	bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+	void (*ddp_teardown_done)(void *ddp_ctx);
+};
+
+/**
+ * struct ulp_ddp_ctx - Generic ulp ddp context
+ *
+ * @type:	type of this context struct
+ * @buf:	protocol-specific context struct
+ */
+struct ulp_ddp_ctx {
+	enum ulp_ddp_type	type;
+	unsigned char		buf[];
+};
+
+static inline struct ulp_ddp_ctx *ulp_ddp_get_ctx(const struct sock *sk)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return (__force struct ulp_ddp_ctx *)icsk->icsk_ulp_ddp_data;
+#else
+	return NULL;
+#endif
+}
+
+static inline void ulp_ddp_set_ctx(struct sock *sk, void *ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	rcu_assign_pointer(icsk->icsk_ulp_ddp_data, ctx);
+#endif
+}
+
+static inline int ulp_ddp_setup(struct net_device *netdev,
+				struct sock *sk,
+				struct ulp_ddp_io *io)
+{
+#ifdef CONFIG_ULP_DDP
+	return netdev->netdev_ops->ulp_ddp_ops->setup(netdev, sk, io);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline void ulp_ddp_teardown(struct net_device *netdev,
+				    struct sock *sk,
+				    struct ulp_ddp_io *io,
+				    void *ddp_ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, sk, io, ddp_ctx);
+#endif
+}
+
+static inline void ulp_ddp_resync(struct net_device *netdev,
+				  struct sock *sk,
+				  u32 seq)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->resync(netdev, sk, seq);
+#endif
+}
+
+static inline bool ulp_ddp_cap_turned_on(unsigned long *old,
+					 unsigned long *new,
+					 int bit_nr)
+{
+	return !test_bit(bit_nr, old) && test_bit(bit_nr, new);
+}
+
+static inline bool ulp_ddp_cap_turned_off(unsigned long *old,
+					  unsigned long *new,
+					  int bit_nr)
+{
+	return test_bit(bit_nr, old) && !test_bit(bit_nr, new);
+}
+
+#ifdef CONFIG_ULP_DDP
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    struct sock *sk);
+
+bool ulp_ddp_query_limits(struct net_device *netdev,
+			  struct ulp_ddp_limits *limits,
+			  enum ulp_ddp_type type,
+			  int cap_bit_nr,
+			  bool tls);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr);
+
+#else
+
+static inline int ulp_ddp_sk_add(struct net_device *netdev,
+				 struct sock *sk,
+				 struct ulp_ddp_config *config,
+				 const struct ulp_ddp_ulp_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ulp_ddp_sk_del(struct net_device *netdev,
+				  struct sock *sk)
+{}
+
+static inline bool ulp_ddp_query_limits(struct net_device *netdev,
+					struct ulp_ddp_limits *limits,
+					enum ulp_ddp_type type,
+					int cap_bit_nr,
+					bool tls)
+{
+	return false;
+}
+
+static inline bool ulp_ddp_is_cap_active(struct net_device *netdev,
+					 int cap_bit_nr)
+{
+	return false;
+}
+
+#endif
+
+#endif	/* _ULP_DDP_H */
diff --git a/net/Kconfig b/net/Kconfig
index 3ec6bc98fa05..0ecb5c1fa942 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -517,4 +517,24 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config ULP_DDP
+	bool "ULP direct data placement offload"
+	help
+	  This feature provides a generic infrastructure for Direct
+	  Data Placement (DDP) offload for Upper Layer Protocols (ULP,
+	  such as NVMe-TCP).
+
+	  If the ULP and NIC driver supports it, the ULP code can
+	  request the NIC to place ULP response data directly
+	  into application memory, avoiding a costly copy.
+
+	  This infrastructure also allows for offloading the ULP data
+	  integrity checks (e.g. data digest) that would otherwise
+	  require another costly pass on the data we managed to avoid
+	  copying.
+
+	  For more information, see
+	  <file:Documentation/networking/ulp-ddp-offload.rst>.
+
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index 0cb734cbc24b..b6a16e7c955a 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -18,6 +18,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..0b5561f2ef9e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -76,6 +76,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6606,7 +6607,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		    skb_cloned(skb) || skb_is_no_condense(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..5438e4c58347
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.c
+ *   Author:	Aurelien Aptel <aaptel@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <net/ulp_ddp.h>
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops)
+{
+	int ret;
+
+	/* put in ulp_ddp_sk_del() */
+	dev_hold(netdev);
+
+	config->io_cpu = sk->sk_incoming_cpu;
+	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    struct sock *sk)
+{
+	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
+	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
+	dev_put(netdev);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
+{
+	struct ulp_ddp_dev_caps caps;
+
+	if (!netdev->netdev_ops->ulp_ddp_ops->get_caps)
+		return false;
+	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
+	return test_bit(cap_bit_nr, caps.active);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
+
+bool ulp_ddp_query_limits(struct net_device *netdev,
+			  struct ulp_ddp_limits *limits,
+			  enum ulp_ddp_type type,
+			  int cap_bit_nr,
+			  bool tls)
+{
+	const struct ulp_ddp_dev_ops *ops;
+	int ret;
+
+	ops = netdev->netdev_ops->ulp_ddp_ops;
+	if (!ops || !ops->limits)
+		return false;
+
+	limits->type = type;
+	ret = ops->limits(netdev, limits);
+	if (ret == -EOPNOTSUPP ||
+	    !ulp_ddp_is_cap_active(netdev, cap_bit_nr) ||
+	    (tls && !limits->tls)) {
+		return false;
+	} else if (ret) {
+		WARN_ONCE(ret, "ddp limits failed (ret=%d)", ret);
+		return false;
+	}
+
+	dev_dbg_ratelimited(&netdev->dev,
+			    "netdev %s offload limits: max_ddp_sgl_len %d\n",
+			    netdev->name, limits->max_ddp_sgl_len);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_query_limits);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bcb55d98004c..e5514036ce62 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4792,7 +4792,10 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (from->decrypted != to->decrypted)
 		return false;
 #endif
-
+#ifdef CONFIG_ULP_DDP
+	if (skb_is_ulp_crc(from) != skb_is_ulp_crc(to))
+		return false;
+#endif
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
 		return false;
 
@@ -5362,6 +5365,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 #ifdef CONFIG_TLS_DEVICE
 		nskb->decrypted = skb->decrypted;
+#endif
+#ifdef CONFIG_ULP_DDP
+		nskb->no_condense = skb->no_condense;
+		nskb->ulp_crc = skb->ulp_crc;
 #endif
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
@@ -5395,6 +5402,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 #ifdef CONFIG_TLS_DEVICE
 				if (skb->decrypted != nskb->decrypted)
 					goto end;
+#endif
+#ifdef CONFIG_ULP_DDP
+				if (skb_is_ulp_crc(skb) != skb_is_ulp_crc(nskb))
+					goto end;
 #endif
 			}
 		}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 86cc6d36f818..33ef22dfb768 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2054,6 +2054,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	    tail->decrypted != skb->decrypted ||
 #endif
 	    !mptcp_skb_can_collapse(tail, skb) ||
+#ifdef CONFIG_ULP_DDP
+	    skb_is_ulp_crc(tail) != skb_is_ulp_crc(skb) ||
+#endif
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 8311c38267b5..56705fbe6ce4 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -268,6 +268,9 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 #ifdef CONFIG_TLS_DEVICE
 	flush |= p->decrypted ^ skb->decrypted;
 #endif
+#ifdef CONFIG_ULP_DDP
+	flush |= skb_is_ulp_crc(p) ^ skb_is_ulp_crc(skb);
+#endif
 
 	if (flush || skb_gro_receive(p, skb)) {
 		mss = 1;
-- 
2.34.1


