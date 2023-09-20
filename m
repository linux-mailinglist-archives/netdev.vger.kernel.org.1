Return-Path: <netdev+bounces-35197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5014E7A789C
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C20E1C20878
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E293615ADC;
	Wed, 20 Sep 2023 10:08:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9315AC3
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED25C433C7;
	Wed, 20 Sep 2023 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695204487;
	bh=AMzd8aTw1wdmBkqMSRGACywvP7lB5QZvFpo1MiU8psE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQeo/8TWRIT8ee2s9OpeacidvagHS98nQZn/ZGdzANU2nqLqQHQxjlF77Zgjl1XKH
	 Pd8yMl+9uokxLLfDuZQBkaH2PeOgOdq0U73ppsoIr9hxaDrkldt00wReVvFVX4iYEI
	 PXNtZCUbbIZVmMLxCjHXnw8WUIAFPx2p9YIRieSm1niJ8Zi18FIeqjyY+9mOBaVfPo
	 hUMezGskR/OQn51souuazIQdN0D4NoKYvbW23dFk/VjSNuJ0YQltr85/HQ7Q0HZje7
	 AzO/WrLHRTTrdhY9b4McyfBvuuXcT+kl+fru1qYkoNPJwVHCu9vwH4i+9yT2Tp0Grr
	 fnBl7zFsRyU2g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 1/6] IB/core: Add support for XDR link speed
Date: Wed, 20 Sep 2023 13:07:40 +0300
Message-ID: <9d235fc600a999e8274010f0e18b40fa60540e6c.1695204156.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695204156.git.leon@kernel.org>
References: <cover.1695204156.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

Add new IBTA speed XDR, the new rate that was added to Infiniband spec
as part of XDR and supporting signaling rate of 200Gb.

In order to report that value to rdma-core, add new u32 field to
query_port response.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sysfs.c                   | 4 ++++
 drivers/infiniband/core/uverbs_std_types_device.c | 3 ++-
 drivers/infiniband/core/verbs.c                   | 3 +++
 include/rdma/ib_verbs.h                           | 2 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h           | 3 ++-
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index ec5efdc16660..9f97bef02149 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -342,6 +342,10 @@ static ssize_t rate_show(struct ib_device *ibdev, u32 port_num,
 		speed = " NDR";
 		rate = 1000;
 		break;
+	case IB_SPEED_XDR:
+		speed = " XDR";
+		rate = 2000;
+		break;
 	case IB_SPEED_SDR:
 	default:		/* default to SDR for invalid rates */
 		speed = " SDR";
diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index 049684880ae0..fb0555647336 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -203,6 +203,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_PORT)(
 
 	copy_port_attr_to_resp(&attr, &resp.legacy_resp, ib_dev, port_num);
 	resp.port_cap_flags2 = attr.port_cap_flags2;
+	resp.active_speed_ex = attr.active_speed;
 
 	return uverbs_copy_to_struct_or_zero(attrs, UVERBS_ATTR_QUERY_PORT_RESP,
 					     &resp, sizeof(resp));
@@ -461,7 +462,7 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(
 		UVERBS_ATTR_QUERY_PORT_RESP,
 		UVERBS_ATTR_STRUCT(struct ib_uverbs_query_port_resp_ex,
-				   reserved),
+				   active_speed_ex),
 		UA_MANDATORY));
 
 DECLARE_UVERBS_NAMED_METHOD(
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index cc2c37096bba..8a6da87f464b 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -147,6 +147,7 @@ __attribute_const__ int ib_rate_to_mult(enum ib_rate rate)
 	case IB_RATE_50_GBPS:  return  20;
 	case IB_RATE_400_GBPS: return 160;
 	case IB_RATE_600_GBPS: return 240;
+	case IB_RATE_800_GBPS: return 320;
 	default:	       return  -1;
 	}
 }
@@ -176,6 +177,7 @@ __attribute_const__ enum ib_rate mult_to_ib_rate(int mult)
 	case 20:  return IB_RATE_50_GBPS;
 	case 160: return IB_RATE_400_GBPS;
 	case 240: return IB_RATE_600_GBPS;
+	case 320: return IB_RATE_800_GBPS;
 	default:  return IB_RATE_PORT_CURRENT;
 	}
 }
@@ -205,6 +207,7 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate)
 	case IB_RATE_50_GBPS:  return 53125;
 	case IB_RATE_400_GBPS: return 425000;
 	case IB_RATE_600_GBPS: return 637500;
+	case IB_RATE_800_GBPS: return 850000;
 	default:	       return -1;
 	}
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e36c0d9aad27..fd61c3a56fa7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -561,6 +561,7 @@ enum ib_port_speed {
 	IB_SPEED_EDR	= 32,
 	IB_SPEED_HDR	= 64,
 	IB_SPEED_NDR	= 128,
+	IB_SPEED_XDR	= 256,
 };
 
 enum ib_stat_flag {
@@ -840,6 +841,7 @@ enum ib_rate {
 	IB_RATE_50_GBPS  = 20,
 	IB_RATE_400_GBPS = 21,
 	IB_RATE_600_GBPS = 22,
+	IB_RATE_800_GBPS = 23,
 };
 
 /**
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index d7c5aaa32744..fe15bc7e9f70 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -220,7 +220,8 @@ enum ib_uverbs_advise_mr_flag {
 struct ib_uverbs_query_port_resp_ex {
 	struct ib_uverbs_query_port_resp legacy_resp;
 	__u16 port_cap_flags2;
-	__u8  reserved[6];
+	__u8  reserved[2];
+	__u32 active_speed_ex;
 };
 
 struct ib_uverbs_qp_cap {
-- 
2.41.0


