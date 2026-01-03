Return-Path: <netdev+bounces-246640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77464CEFB5A
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 06:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB88930141CD
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FE526E702;
	Sat,  3 Jan 2026 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KspRgSll"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05319258E
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767418746; cv=none; b=go79RirfcNqAJucHt6MLFTrqKaDqYdsCR+MC0eFJpvux7+xWy6PFA+T5bUWlDwD4SZgjH33yf/jpwUxwT1JWvzN+JMiLSIx9F14zlRkt0CzDLj6a0lgcsyYL7YZkj6G194TregmOSrblIx6bia7n70u4MFvaY4VZERPlSZexu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767418746; c=relaxed/simple;
	bh=zB7InRxdhbUfArUeoDkJEcjsUSyvb8a9oqQTv82r8uQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuhNQwq6/mL31sIqUGxZs1JipDDL5dmlQW16QZHMzfddH2GcfLBGi7roPfpROX1hBL5iPOs6oP9JbWM4dJOvJFx9q9/4nKw3I4aci2oHt0Kvla8fE9eDsPYdRHTPXqXvmZIwKR0A51v2qJRZloiWBFqtpw52OatmsOfMdsdEYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KspRgSll; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6034abcu558689
	for <netdev@vger.kernel.org>; Fri, 2 Jan 2026 21:39:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=dPZistrW42shSqONuISjFKYdIKC68QTLEs9Rb5vD9I0=; b=KspRgSllwdkK
	IhK21B6zhGAXdO7wsOGYpQj8wt8XNy+zWmzAN7bK0C3sI1Pww8ZCwJ+gaD29pxr5
	AD8eiVPiFpazgLPcOEtDiPB7ZFI0lz6BikvHbKmJ5RQQG8QN7CRqubXNHyiA1mIe
	lTLMw08nqKtZXBWvG8Uqjf12Ok2agLCuJlJ8a1dDGPFCUGfcoiuwt/nCDI5v8xah
	zDAv9U03P8VaId/DLVyeDBTh1MWKx4ze/yaUhG3BIfawrkxSgA3bbbOT5z3CR9P/
	hL6GLE9E8HAtIxm8BhX0e0lPlhBASyD7sOqgucXKcfTDiYusjyLtH9K2yoaPIicx
	eHLUZ0UNEA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bev80r4pe-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 21:39:03 -0800 (PST)
Received: from twshared17475.04.snb3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sat, 3 Jan 2026 05:38:59 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id C9E25E3FFCE1; Fri,  2 Jan 2026 21:38:45 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen
	<yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [RFC 2/2] [fix] mlx5: modifications for use cases other than CPU
Date: Fri, 2 Jan 2026 21:38:35 -0800
Message-ID: <20260103053842.984489-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113213712.776234-1-zhipingz@meta.com>
References: <20251113213712.776234-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wQCo3KWRgblD_IsChL7HvE6ydOFGGimL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDA0OSBTYWx0ZWRfX+StqJbch0HLD
 NkciUQe0KK/tHTgkXXlEH6Ee+HT2ZWRSI8PW1KWaUIdpanT2IcIJSSilXZYK9VoVn+4AQo9uDlW
 XfdmEBLbHDfudJh3ZPNJFcxheg8azjZ3/jsF9pff1Z+6ePYo3DgrZzX8SFrZ3nhmdAnKknG12t6
 ZMDLEtPzf4ttyfWFK+SO8f51N7asCVg68IRWlXhWP3c2lWoqMrZfqHnwX5KFe3VQtadVqups+Qk
 ZYRgO4iK/EHhQejNMEQHFnAV1BSjjB9W2LZNnTaG9wG4tKA6/abb8k9MWw2itueWJ1iLRV0T0zU
 qQszDuP461KvkyGdSgz8UPSlsoRQh/eC30aiIgLNQsiFXKyvDyW3yyvZ/OCKxf+hA+1Yfx8CWHQ
 sr6GZlajMWESjFL9WYD41qhcF4B3o2U7643DGdMdeRBAc/5D6a5qLgLiI91gJr8xgrjICA5wqVy
 FSS57iODEoKIjCdpwYg==
X-Authority-Analysis: v=2.4 cv=Bc7VE7t2 c=1 sm=1 tr=0 ts=6958ab77 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=dY4F4hLoAaLEDHvlMMEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: wQCo3KWRgblD_IsChL7HvE6ydOFGGimL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_04,2025-12-31_01,2025-10-01_01

In order to set the tag value properly besides the CPU use case, we need
to also fix and modify the few checks on CPU_ID in mlx5 RDMA code.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

> [RFC 2/2] RDMA: Set steering-tag value directly for P2P memory access
>
> Currently, the steering tag can be used for a CPU on the motherboard; t=
he
> ACPI check is in place to query and obtain the supported steering tag. =
This
> same check is not possible for the accelerator devices because they are
> designed to be plug-and-play to and ownership can not be always confirm=
ed.
>
> We intend to use the steering tag to improve RDMA NIC memory access on =
a GPU
> or accelerator device via PCIe peer-to-peer. An application can constru=
ct a
> dma handler (DMAH) with the device memory type and a direct steering-ta=
g
> value, and this DMAH can be used to register a RDMA memory region with =
DMABUF
> for the RDMA NIC to access the device memory. The steering tag contains
> additional instructions or hints to the GPU or accelerator device for
> advanced memory operations, such as, read cache selection.
>
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/hw/mlx5/dmah.c | 3 ++-
 drivers/infiniband/hw/mlx5/mr.c   | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/dmah.c b/drivers/infiniband/hw/ml=
x5/dmah.c
index 98c8d3313653..c0d8532f94ac 100644
--- a/drivers/infiniband/hw/mlx5/dmah.c
+++ b/drivers/infiniband/hw/mlx5/dmah.c
@@ -41,7 +41,8 @@ static int mlx5_ib_dealloc_dmah(struct ib_dmah *ibdmah,
 	struct mlx5_ib_dmah *dmah =3D to_mdmah(ibdmah);
 	struct mlx5_core_dev *mdev =3D to_mdev(ibdmah->device)->mdev;
=20
-	if (ibdmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
+	if (ibdmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS) ||
+	    ibdmah->valid_fields & BIT(IB_DMAH_DIRECT_ST_VAL_EXISTS))
 		return mlx5_st_dealloc_index(mdev, dmah->st_index);
=20
 	return 0;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index d4917d5c2efa..fb0e0c5826c2 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1470,7 +1470,8 @@ static struct ib_mr *create_real_mr(struct ib_pd *p=
d, struct ib_umem *umem,
 		struct mlx5_ib_dmah *mdmah =3D to_mdmah(dmah);
=20
 		ph =3D dmah->ph;
-		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
+		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS) ||
+			dmah->valid_fields & BIT(IB_DMAH_DIRECT_ST_VAL_EXISTS))
 			st_index =3D mdmah->st_index;
 	}
=20
@@ -1660,7 +1661,8 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device =
*dma_device,
 		struct mlx5_ib_dmah *mdmah =3D to_mdmah(dmah);
=20
 		ph =3D dmah->ph;
-		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
+		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS) ||
+			dmah->valid_fields & BIT(IB_DMAH_DIRECT_ST_VAL_EXISTS))
 			st_index =3D mdmah->st_index;
 	}
=20
--=20
2.47.3


