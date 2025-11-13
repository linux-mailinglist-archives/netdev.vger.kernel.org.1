Return-Path: <netdev+bounces-238509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B505AC5A380
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E8C84F9D7C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A83246E0;
	Thu, 13 Nov 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nDl0MKy8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B213E322C88
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069848; cv=none; b=QHusyTAm06qMdZAeATv1H5UiZbnSiRUNKmBYIvyrcHx8255PPlxhr853H3Tcv3KjJDNyCWMdm7Zw6OkR3D1Ls5wwY7/oYlnGz2J9IgY/NKsCJLO5OsHhDMQ35GUraxfTNzevxg91Ut4BhI/VBBqRCKUJfPZ6O8WCOKipdHhZN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069848; c=relaxed/simple;
	bh=5TNlqq0nn/dB7CaEZMfDE2J+2YooCTDXWl35OGhkUCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j/gAgDMhEvOPuo+01FddH0piD4yGslfKQvCrb59Tiqs4ndt765hyREkuE+/Nw3wQVEg8glIH44AMDUUJo45zLF1Ju4S7ZFoQ/8oT8Fnsrzq8yFOPMh45pAiDi33CsvNCH7NBUr5F3klHYa7dfRpBkUe7c34Hm1p7GtfLn6AqFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nDl0MKy8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADH6cwc1639165
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:37:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=unenlBehig4ih9eN9L
	cbC67e5n1CVX4Fyyz/24V+tK0=; b=nDl0MKy8yCMChW3qeFKiNqVxpgsFV6eeJU
	sG+YJZM4gYM2UIQrK1PnZfC9VHiKyc7UCnJuBIVUaNZ2T+WFABK583Tetu99bJVm
	glr/BxMzruFYtUmnjc00TR3zP5dmaQwqY5YwCd7WITATjO+dA/UBP46TSO10NDoQ
	BRsOOvfcYtzchCWFh4aX9bvZsax7ehPR4HzLqkoRgFm/3GiHmausLNvJqlk6jYQ+
	JLDzjP0avwx9FSzOqyelr+tmQ0nPQiLOKML0OlgdZpGG+a/GDmjef5RbfqmJr8WU
	iMqi3o1pbiMGqHmRnoGtSB3pCuQ3+yiJ+zNMiFW3edulVUcT0FHg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4adkeptjb0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:37:25 -0800 (PST)
Received: from twshared22076.03.snb1.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 13 Nov 2025 21:37:24 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 68E97C14673F; Thu, 13 Nov 2025 13:37:13 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
CC: Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 0/2] Set steering-tag directly for PCIe P2P memory access
Date: Thu, 13 Nov 2025 13:37:10 -0800
Message-ID: <20251113213712.776234-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BqJ2s14ZzGKlDgj3UMDumQrGbwVAbrDk
X-Proofpoint-ORIG-GUID: BqJ2s14ZzGKlDgj3UMDumQrGbwVAbrDk
X-Authority-Analysis: v=2.4 cv=fOs0HJae c=1 sm=1 tr=0 ts=69164f95 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=LD3YureWr3Rg3Zxk1oQA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE2OSBTYWx0ZWRfX6oo8uTxVkQMg
 3GB3Hx7lkWyJLtjYom/MQ0+k7J+63ntfaKVTxLNML5BxnAWGwqqubiVaaxmxr9Zgik9U4Yx25mv
 wtGzVVwcKkMN/yMeLrQu17p0P7AjhobuXGpUEM/76L8wBe280INDftXEgbvo/c12xdfAkIW8qaa
 wz3i5FB4EO6NptVpHxBaO2xf6C14z2Bsl47+RN7WA0WamjGkBb9kziIfkWsCLw7Uif35R/JT0o2
 ZGEFeUpTVkLJlaC9bbEqwncmThKDRMMhRhtFFXM0lrrVJMdd2MyPK3c9GAb9tsLj/F6rYGb7TAG
 D2rr6D8x9+JPVghhAFFiS49MeZn7TQaGi8ftAKOSIj3bcor8T3PRFC9IwXJn5MtParB7qVVHAmg
 Sbs0GtVXqQYAGZBqytBmUgVgQcMDBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01

Currently, the steering tag can be used for a CPU on the motherboard; the
ACPI check is in place to query and obtain the supported steering tag. Th=
is
same check is not possible for the accelerator devices because they are=20
designed to be plug-and-play to and ownership can not be always confirmed=
.

We intend to use the steering tag to improve RDMA NIC memory access on a =
GPU
or accelerator device via PCIe peer-to-peer. An application can construct=
 a
dma handler (DMAH) with the device memory type and a direct steering-tag
value, and this DMAH can be used to register a RDMA memory region with DM=
ABUF
for the RDMA NIC to access the device memory. The steering tag contains
additional instructions or hints to the GPU or accelerator device for
advanced memory operations, such as, read cache selection.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Zhiping Zhang (2):
  PCIe: Add a memory type for P2P memory access
  RDMA: Set steering-tag value directly for P2P memory access

 .../infiniband/core/uverbs_std_types_dmah.c   | 28 +++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_mr.c |  3 ++
 drivers/infiniband/hw/mlx5/dmah.c             |  5 ++--
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 12 +++++---
 drivers/pci/tph.c                             |  4 +++
 include/linux/mlx5/driver.h                   |  4 +--
 include/linux/pci-tph.h                       |  4 ++-
 include/rdma/ib_verbs.h                       |  2 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 9 files changed, 53 insertions(+), 10 deletions(-)

--=20
2.47.3


