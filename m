Return-Path: <netdev+bounces-225715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8AB977C2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F13C19C8333
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5341E30E82D;
	Tue, 23 Sep 2025 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hpG7Metz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC52830CDBC
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658999; cv=none; b=b3QPqRlpcTJJyTHLJoZLsP8a0MCqi6MNRdRUMkcwGALmY2y5pbWQx4jeddHjPfRuD2SubfVUSUwin1VK5/24B6q0emp8DPMjHJP3hUKXpZPa2spalZnmIMWvvsaXXYDXt7KnNzHEVH6wcFBKko8L2KZKGRBsWSrFjC313RV5vJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658999; c=relaxed/simple;
	bh=AIbzj+NKIDavwpTyl/NKkVvbYHyLtiaIFm2HmsmoipU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g05W7jcd04Yf31ZC/8HGVE3m3mxDSei7USXo8ZIJiqY18O9mbQ2scKqyzJEVMn5JmLKwL4TwRweuQEHij426NmZ4nFx3IEQ5OwLtxnNCGpOJ2DhhM2L6nUOgICZQsSEMKiVVWHqhazyzCHdM8q0E4IBqr8TVk1MoZZavxZx5NSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hpG7Metz; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NImYx3021414;
	Tue, 23 Sep 2025 13:23:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=s62IrFVxcdoIeGVD4Bt6JMO
	yZSNwPHWhE/aVtCWa2UA=; b=hpG7Metz9LKOMzQj1LqSNWI9DBKJ+bqaVmx/pyn
	/riH4VyJjWUMv3JFtvy+JqbbSJKmVUXsLExXZQpkqSONlQWs1duwu/TVo0Np1D5o
	RTFoc6Q9n9askaVxSwITmkn6CPJ9BmPCSZSgfvDN9evjBuWSo57e3Wno5l+rfCKM
	2T6NoQowTmw8mQ9b/UUs8gf2Kgq/idQ5cQ0q9rV4Ku3Qfikj6d4d02nO3wO8gQ65
	a8HmlDK9jnZpcPnBFmxD9zDNehO0m3Mw3mkeF9GvddjVKbIShDQNR4MforZXt5DU
	EYYCTmFi0IcyZ6HCtRgnD8XvPD9BT38NJdBrjNUUI28LMNQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49bnagsvx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 13:23:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Sep 2025 13:23:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Sep 2025 13:23:10 -0700
Received: from 5810.caveonetworks.com (unknown [10.29.45.105])
	by maili.marvell.com (Postfix) with ESMTP id 84A803F7064;
	Tue, 23 Sep 2025 13:22:59 -0700 (PDT)
From: Kommula Shiva Shankar <kshankar@marvell.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <pabeni@redhat.com>, <xuanzhuo@linux.alibaba.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>, <jerinj@marvell.com>,
        <ndabilpuram@marvell.com>, <sburla@marvell.com>, <schalla@marvell.com>
Subject: [PATCH v1 net-next  0/3] virtio_net: Implement VIRTIO_NET_F_OUT_NET_HEADER from virtio spec 1.4
Date: Wed, 24 Sep 2025 01:52:55 +0530
Message-ID: <20250923202258.2738717-1-kshankar@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=X6pSKHTe c=1 sm=1 tr=0 ts=68d301a8 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=tZkuUt_2NcZHR2g27asA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA0NyBTYWx0ZWRfX9cFyBLg6PZyQ 2FAKjiyLNmsSTp5NE4i/kOkM3wTCcASFwVkxMYOrtLaDGupiGJSF2m6hhM/50k+J6Ja2T3E+D9W SItbrD2VkSpF52t5EDjm0vZxF96oWuyPA+yQ3A4CHTLb1YSY/sJqWhXpx9SbSCrmW0cPXEhtqWb
 ZrBxQqLXjujHnxGP+mq9sVjZJbMDfV1eg85NUiBm9RC8hnc7YwN4/a1WDLMC2QBT5n08+qeyWJO nnoWprmODR2NUUJTCKE2HpiJPMsCeUGQby7CSlt01CQKDXPHC2n7pPeN9q0oLUZjBGnA6cNF9ZF /M5JuqfrXZweP+43rcvlW9M7yBt2CMc+bSWtbrVnH6YeR9aJf5C5caGn053BqQg2nBz2DyjbSTN UoB7K1Sh
X-Proofpoint-GUID: cn6ms6stqRHt-3w6x-MSG5uqBCercYbR
X-Proofpoint-ORIG-GUID: cn6ms6stqRHt-3w6x-MSG5uqBCercYbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_05,2025-09-22_05,2025-03-28_01

This series implements the VIRTIO_NET_F_OUT_NET_HEADER feature which was introduced in the virtio specification 1.4 recently. 
With this change, segmentation offload functionality now propagates outer IP header offset information to the device/apps running on NIC. 

The virtio 1.4 spec introduced VIRTIO_NET_F_OUT_NET_HEADER feature[1] to address the performance issue caused by reading packet data 
to determine outer network header offset and to support Inline IPSec functionality,
where vendor hardware devices need to know the outer network header offset for Inline IPSec acceleration.

Currently, devices must parse through packet headers to determine the outer network header which impacts performance. 
This patch series implements the outer_nh_offset field in virtio_net_hdr to avoid parsing overhead. 

This series was tested on ARM platform with virtio-net driver where ~4% performance improvement was measured
for device applications.

[1] https://lore.kernel.org/virtio-comment/20250401195655.486230-1-kshankar@marvell.com/

Kommula Shiva Shankar (3):
  net: implement virtio helper to handle outer nw offset
  virtio_net: enable outer nw header offset support.
  vhost/net: enable outer nw header offset support.

 drivers/net/virtio_net.c        | 23 +++++++++++++++----
 drivers/vhost/net.c             |  4 ++++
 include/linux/virtio_net.h      | 40 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net.h |  8 +++++++
 4 files changed, 71 insertions(+), 4 deletions(-)

-- 
2.48.1


