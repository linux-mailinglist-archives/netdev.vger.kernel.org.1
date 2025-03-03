Return-Path: <netdev+bounces-171147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C15A4BB3A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A6B1882B04
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A2E1F09B3;
	Mon,  3 Mar 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KXfEQKBX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115121F0E3E
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995620; cv=fail; b=EJf9vk14QA7D6kHVi6/Q1eeMghkNPD4Qydm4gf71d0cMOdmyOABVHbDhqqBz2N2krql3z3noRyzTM9IJga5WXVs+vuB5KkIqRLCIi7mJtsAFgYWNY8JqChmS0/fIjf2QOPZ18W8pTpAvhx5CZa7gL/isrAp8VR4KY3IthE0AHeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995620; c=relaxed/simple;
	bh=NTxSWzMB8h73BlDo5C1RHWxedbvjcac4CS9dlMvKsOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Maa/bsEh/eXTeG+62FWNywmQ5x/lWBDyeAV33gRkIJMclmbB6MKIx/SB++t06LNMGw8lM6kM6UtM+vEVoWbGh/WX10WBwsWFISNdi/jyZePjvhNj+OmYeeD0QcMLgJXMW2oE9JsEaAAow2ylNJfiE3s0djZuNI6zyCOk4cVn3FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KXfEQKBX; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCo9voG5AmgoTboLGPzpopv1WEhrpJBkMSs0EhYOCvrH0dgrjDo216ir/l0hJnYtEupK1srvcjkuPwdD9rmVkjBZ93oA6gNubC2rGGtWLKQOJXpV8s3paiOAPVTcYXFMZaysEEZBJ7Y0HOo9u4lKoDugtdj3RR7pWeKZTs8MS5IYdPuXX1DIxWQuYWyYzYlJlnABPo+7uh3rO630L/jvDIGMEHTKtZt/QxGYhnrumkQosQODhM64vP5vMF6yE4ZFIR3j94lfmYGPiOyIK3VTMfKjcZJ3XdnQyOUT+ainapirR6T0tLMlsDgoT+VLR2fx1A0xOaXiqC7op8T4ocMcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkhd+EVRJIAOQYRyaOqYqW9we4kxEMFUkspbe9kcIlU=;
 b=HcjYNgam/yUv7qU7TUOuQ3ARH8xzIAqCrQ53Nnf3ZFrUFvsNZhHuxdMpw+6JVHRn3d9IQXYhnd5xSaieU2ioMlxkn2Co3S5DS7hjzZ4kZQoYqzMfsIVRoDnugudJqUCvEk3Nd5uMN5041ATAmMOkwwXz1uU2Ah2IjSLQ1jrLK+MReui6/RmnQsJaHXW/tyWdcDdoXsJ9U65CqRXHrn5wgRfEqAnm26qgyC0KuKkHzY4TC+Y/mPH9bJVb4xmYyeRgvs9RQE64SyYQh9Oe1IS3t9Y4k1q10UQS/VJyaupjempiT9yBcJg8xoQsvR/pOJ05GzdmIVzbznlEJo8t3+ISZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkhd+EVRJIAOQYRyaOqYqW9we4kxEMFUkspbe9kcIlU=;
 b=KXfEQKBXRAQG9aDDyJaN8B6nv7KQvLGcF4YJYj4ursSSUIut8OrjK/MFIRsytTvx2bxaUopx6Tgm6OeYUIsnAhiY1huNYSKEdVeQPGJX6bHYzZyEF4kyTQ2tyzF1z1pLVBU29crARZIPCEXGN8BMGU9eWOye3NtelGFK5xkvUoCEy/22B4KieMe9wQQ3yszj3BjmmpOScEnKCTQoLeepCEGheiOZp/HfM8y+4Un/1zUzjVULFzGxN7wJ8H4Ozm0WbxHsgcFWRnW+tUtqyx3h1vhXz0vSceXU7IL2ZhOTO0ePpgu7Nb1qmYh4jIRGwiHnmsNCjbKRjdCP5zCG7uph/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:53:36 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:53:36 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net
Subject: [PATCH v27 04/20] net/tls,core: export get_netdev_for_sock
Date: Mon,  3 Mar 2025 09:52:48 +0000
Message-Id: <20250303095304.1534-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0041.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::29)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 5712e65b-11c9-4cc1-b202-08dd5a394483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvP9swqxi8s4+miayNK0XwkG569UMu43yqXMaFTK0QrO+BePwt1b0EPbARSE?=
 =?us-ascii?Q?0e9TmQCiCPDXOI1UDRdQLd0TWpIdsrt5YkOzRC/9/Kq2VlQk52RaHMnk5p1c?=
 =?us-ascii?Q?tQa56Z4N9+8rZYUf1bOmB3PRMxhGT5qpNGCparnIVMiMp28o9U0oIEQ5WpKS?=
 =?us-ascii?Q?zj/HlyeYB2dOsDtiO+WRKgrGCX8t1a7+R7x22Rsi/C0q0rV8aTgQhKVh2Rvw?=
 =?us-ascii?Q?A0svbvDuoS/o7+jacOxO1RzwS4kyNpMBY6CdAQrQfRpSl0iboMDFsk9gkEBS?=
 =?us-ascii?Q?bwgayo3Uh35Hfb3vFuuCEzwJUdiHeG0fYUsruzwqfD2kuk0qdPuBPIz+UMPa?=
 =?us-ascii?Q?Dowid7No+SBvlcYeNBVSMUoUaJmhWgNhPE65jeF5JKk/LZAq1Ybh17EKm0RB?=
 =?us-ascii?Q?zgmnOvGqBSi0KpGulNJrivqIRvpGiohIx8vuAdzLRd556dRdjIQpkPv/4uPh?=
 =?us-ascii?Q?I/6kEtKKGzwJQhAUCkPySVc4Sp81f8rsS6I01dS2HphIsF/cLfn3OMPHKJRj?=
 =?us-ascii?Q?YssBIyu4CYrZfdEumBBdYXLxoMvZpd9dTMsV5YOX5//7A4jm+n8xPSLI9+lT?=
 =?us-ascii?Q?3ibfsbNMjgjUIBNHzlxquBqhBy0/5kG8+TsmJuYKswph6GejUcWaSaR7AVkb?=
 =?us-ascii?Q?ALGa0OwBZ0qYrNPAiY80V7BLNSsqEqmPr2WBQsvKhLHz1zjMfL7YzYYu/vxU?=
 =?us-ascii?Q?alKyixtsKyx22QNwrr076ZzQwo9soE6Ef3AYbASWhIvygeGdyfImI3yeJ1Xg?=
 =?us-ascii?Q?3QaFoi90nuHnv8dN7fjWehuvqd+0mydP7qWFxpLyN8EYDTqvYrSr0eXL8eKv?=
 =?us-ascii?Q?hBIXVw98OqIxKFVradxd9Bx8ogJOFQNZOdlO6QvrIku6W/oSJYETDZNzUvQK?=
 =?us-ascii?Q?XL7wkaTAN3o1oz/Jys9KUceBqY4J+YK907J8eu3qa+9YInEBI0GnafaUhTz+?=
 =?us-ascii?Q?IfW1vxtHDyUjlk22TVM63l7cx6d157PplbF0Sw5aq2nwCV3iyNIw0/HQbDl8?=
 =?us-ascii?Q?stWMqEXXXRuTnteokdgPeQzoofCaXS+qiDvie/eXCrb4O3nUpeCeSmltYzSa?=
 =?us-ascii?Q?Mf6etKfp4m+wLt4HML1RlCGWjt3sByIQo9oIIpPj7txoxnG8QR9Zfgh4Haxk?=
 =?us-ascii?Q?olWUvCFCqxI66nNOGe92AuLEEAGcvovSEALPWsdaKTtH1zEAoZ8KwVLLkk34?=
 =?us-ascii?Q?fS7kSpR0NB8Cwmsgm6o5ZOEed3wrP0l8Cury9Db/2auxeOv2ka1T8TgUTR30?=
 =?us-ascii?Q?saOVRAUao3z2evE2ZfWDo6m8/aIOwRFQ+MqttfBsXAeE8OdWITQMhqnLLb5F?=
 =?us-ascii?Q?IDPGrOMG3oODboGIaKBlB9vrv8NEK3d243BEKRzlCOL/WlyA4zOfsw1/iYDN?=
 =?us-ascii?Q?BDrA+/VGim/TfwnxuHTPwyqVB9zI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6XyZL+uaqs+ANjfUIcxdmOnAVB6SX+J27gbRXKmMHoWKFKjkyQW5gnSWOTc?=
 =?us-ascii?Q?ljkO8WktNrwUzsBQnxAd4nkjrw9m3BqixHC3Oeblq34EpQKEhRcJXtNBqAbm?=
 =?us-ascii?Q?XbaN3gKQ9w4eT2MPodAV8qPf4sJ5C3yXec2m+6WKojl5rlN/EcN1SIw4NcoF?=
 =?us-ascii?Q?v/MZ38vkOBInfQMWPzi8H5Ldrw6Cz+g6muIt3bQ9KavhM/ZDoAYV6SnSXXZN?=
 =?us-ascii?Q?63cpVb6qfvn1SE7LWOWdEW1YhLeWPRCYCkiZ1tYnGBbgHI8CIaCQA6hBnSwX?=
 =?us-ascii?Q?T/Al3VACQb5vGENamDUbgLA2HVGDdlUHuRw2S/0wgDbMyk+H6uPsgfizFJxJ?=
 =?us-ascii?Q?J/kA+/4hJUvFfiQDH0GcTcooD5GP8Xpnk9NDKO+w+4su2C7bgV0qZz3zqKll?=
 =?us-ascii?Q?hLyMpfRTPXyanx/dkEpWqE8BPf5tFgRncMOND7bYEwGP/6BvBKaxHWVQqB7C?=
 =?us-ascii?Q?2a2Zar2px86jeWxQOuyTlilOacdqV8RV+WHqS9VNfs6bVZoXWniIdBLrh988?=
 =?us-ascii?Q?pjR/F8uQ9SGIfqyPDGz9P3jcAd3ymTG+zd2XGC3SxxACt3ZMf52f78z8uKHF?=
 =?us-ascii?Q?pe57FADrpR7KTL6FlWepjmzGQCJqBVDC64c8BfDAeJOdgwItFLAc5J4DLA2G?=
 =?us-ascii?Q?7WJTmkuEiHwtUHS03PZhczcM3yKzTUouK+oXUAA28xarxddgrnw9xixzqtCe?=
 =?us-ascii?Q?byd8kPy4BpBujzyOqoO7xvwEFpSB+/V/0QT3pippCBd2HNlR3QdgOJK1YtyT?=
 =?us-ascii?Q?MgzvC3zRV12u4IW4vPiT6lYqnU27/Oppo7nYGQynXhANvYkTSpIBU7QXVkC3?=
 =?us-ascii?Q?HK0Rs10kszzmaB193xMcEwejacXv/Z8TfjFjogd82ym/sMSLS3Q/CmDbsLf0?=
 =?us-ascii?Q?87usPn9cAGpDLn2YcPyqmPGXYMqytst/s4txqAh/RrGCZYiQ296xVIYbOhgm?=
 =?us-ascii?Q?sWDDE5yzR+a5aprkhnEAt+CIdBTFEetnBaW2cSCYI7Vqp6WCMJrT+dQNon21?=
 =?us-ascii?Q?ofGGQoWKaEWoqAmQCJqll1jZlrG1Y6mJxdQVIUHL2WGMQPpNNw3vUxRf3c0w?=
 =?us-ascii?Q?bIHAR5rxM5KTKRXN+n2HtnarYnF8dQSjyhAQM6mBUUOwYQmdChEZLgAqLQtq?=
 =?us-ascii?Q?lvOX4iHZkYxXTFHoEGyHFp94cLKNN3vkaj0PdQFZC3WvGQRRRGNPKScc+BIX?=
 =?us-ascii?Q?YfABSZiZwMXYszLvvTYvT9Vrd+PRcttizoxM1RkC52iFldycNJIx9Wy2PS4L?=
 =?us-ascii?Q?pWK0g0ozYRGZzQ4tjxGSTlEuNVhq8pS+IvMTsSeM5YPS9zt0SrwNs6Jj5NrT?=
 =?us-ascii?Q?khBmsnvA/WuhxeHo6mP+60VBydutcV2aavBEUQYvzhf+4NKUesm6sedJga4E?=
 =?us-ascii?Q?9QBYarrcugSLHJLxN+mfBq3JO8ygqTAShk1ABqPZokZlI+HvqMEAkP+Vs/yi?=
 =?us-ascii?Q?OoI+RXYeAOY46EzCR1KI5BUupaM/BnDKfG14ornv6ewAvoYwm18Bqfw2g2XX?=
 =?us-ascii?Q?x/Wac4/M2GAkse6l5+zqvqDP8+91npA2wumw2lUHnLogMdt/f8k1kTzwAO90?=
 =?us-ascii?Q?h5z+0FqXQupFpD8OYcOiLlFXtgEDZGZM/GrcIK+h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5712e65b-11c9-4cc1-b202-08dd5a394483
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:53:36.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4on99ki6Sz4gIypzY76FyMNX6OkJOkF++VWcybsqy13k7455yIOxfRib/RJv+hXAejaEEFHuxoP4WlhToE1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

* remove netdev_sk_get_lowest_dev() from net/core
* move get_netdev_for_sock() from net/tls to net/core
* update existing users in net/tls/tls_device.c

get_netdev_for_sock() is a utility that is used to obtain
the net_device structure from a connected socket.

Later patches will use this for nvme-tcp DDP and DDP DDGST offloads.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/netdevice.h |  5 +++--
 net/core/dev.c            | 32 ++++++++++++++++++++------------
 net/tls/tls_device.c      | 31 +++++++++----------------------
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ceba93aeed5a..ae98cd7b33c7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3378,8 +3378,9 @@ void free_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk);
+struct net_device *get_netdev_for_sock(struct sock *sk,
+				       netdevice_tracker *tracker,
+				       gfp_t gfp);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
diff --git a/net/core/dev.c b/net/core/dev.c
index 2dd9e6f490e6..1c9497e5c7be 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9018,27 +9018,35 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
 }
 
 /**
- * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
- * @dev: device
+ * get_netdev_for_sock - Get the lowest device in socket
  * @sk: the socket
+ * @tracker: tracking object for the acquired reference
+ * @gfp: allocation flags for the tracker
  *
- * %NULL is returned if no lower device is found.
+ * Assumes that the socket is already connected.
+ * Returns the lower device or %NULL if no lower device is found.
  */
-
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk)
+struct net_device *get_netdev_for_sock(struct sock *sk,
+				       netdevice_tracker *tracker,
+				       gfp_t gfp)
 {
-	struct net_device *lower;
+	struct dst_entry *dst = sk_dst_get(sk);
+	struct net_device *dev, *lower;
 
-	lower = netdev_sk_get_lower_dev(dev, sk);
-	while (lower) {
+	if (unlikely(!dst))
+		return NULL;
+
+	dev = dst->dev;
+	while ((lower = netdev_sk_get_lower_dev(dev, sk)))
 		dev = lower;
-		lower = netdev_sk_get_lower_dev(dev, sk);
-	}
+	if (is_vlan_dev(dev))
+		dev = vlan_dev_real_dev(dev);
 
+	netdev_hold(dev, tracker, gfp);
+	dst_release(dst);
 	return dev;
 }
-EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+EXPORT_SYMBOL_GPL(get_netdev_for_sock);
 
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index e50b6e71df13..1a5c348a2991 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -120,22 +120,6 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 		tls_device_free_ctx(ctx);
 }
 
-/* We assume that the socket is already connected */
-static struct net_device *get_netdev_for_sock(struct sock *sk)
-{
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
-
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
-	}
-
-	dst_release(dst);
-
-	return netdev;
-}
-
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
@@ -1060,6 +1044,7 @@ int tls_set_device_offload(struct sock *sk)
 	struct tls_offload_context_tx *offload_ctx;
 	const struct tls_cipher_desc *cipher_desc;
 	struct tls_crypto_info *crypto_info;
+	netdevice_tracker netdev_tracker;
 	struct tls_prot_info *prot;
 	struct net_device *netdev;
 	struct tls_context *ctx;
@@ -1072,7 +1057,7 @@ int tls_set_device_offload(struct sock *sk)
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1166,7 +1151,7 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1180,7 +1165,7 @@ int tls_set_device_offload(struct sock *sk)
 free_marker_record:
 	kfree(start_marker_record);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
@@ -1188,13 +1173,15 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 {
 	struct tls12_crypto_info_aes_gcm_128 *info;
 	struct tls_offload_context_rx *context;
+	netdevice_tracker netdev_tracker;
 	struct net_device *netdev;
+
 	int rc = 0;
 
 	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
 		return -EOPNOTSUPP;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1243,7 +1230,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	tls_device_attach(ctx, sk, netdev);
 	up_read(&device_offload_lock);
 
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1256,7 +1243,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
-- 
2.34.1


