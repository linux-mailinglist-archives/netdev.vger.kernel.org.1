Return-Path: <netdev+bounces-228201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B767BC47D4
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 13:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66803AB1FA
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477B62F617B;
	Wed,  8 Oct 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fd1P1mt3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F6119D082
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921231; cv=none; b=PErlODD0g9tX53JpDiDgXC9+wCvFDKKFwOWZzMTOlKy0z//jbDuyMBDFsPfWGZXP7zbc17GxWmxMZRW3IwFTmFoQbE9R6Zns/TlbqfY7+ziOq1ydq9fZBoMhCN5kFe5iZQrUn+xW8aLcsQ5P/M8B/eweJw9CAOfQ7yOldF8qAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921231; c=relaxed/simple;
	bh=4rXAjtqrs4KZKZKHHUtMRuXCWdptQ9OEIuUk6kINpaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WJN/veLjUIcxvBnfa8HiR4Eu8wNpQRWHSgLktAIdO0T/NvxzIQQHhXqeddAYgGFfPo1B3BAazU+bgqZ8FlXA/rs9tGXReDb+zkMr3BWkXF8rB1gWolPrx60nLc1SRPqNFFMveuNzyQip1rY9cVIGy+FZkB8oKpJV9cN8ONy5lVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fd1P1mt3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5988HSdX012885;
	Wed, 8 Oct 2025 04:00:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=QlHxTxSIyS+Q8FGsGu9HwK+
	UiKLU3cElNT+wr3+C9KM=; b=fd1P1mt3iOdEQUgq7mZh07oQBsZx+6aLHYnbiIh
	Kc8PFvEXLgffd7haOMBrU0pKIDWKXBXDugBRdnNNwtaA7gxQL2Deuy2/sfwv+zKH
	TZ15IWXuEV0xQGqy9+ZvpI+wnRTcJ6vohx98Gvv/rd3/YZyvCF1B6+0KBdotzWUj
	bsgVNLivBZ6vLQAMSdrE4e1H8n7C4evP7INBSDY6lfe2bRyH19lhqHVbAFXNn9Sn
	ED9j+SJ8A4kBidb71UTBBYspyNSJ3zgv7/t5kwugdU27yMIwhJAOWfy0O7dWlUPE
	epB7W61qR4XC0BHGxwfefHZiE0OtEjgoR4Cp6zPww3azB5w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49nmag089a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 04:00:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Oct 2025 04:00:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Oct 2025 04:00:18 -0700
Received: from 5810.caveonetworks.com (unknown [10.29.45.105])
	by maili.marvell.com (Postfix) with ESMTP id D2D255B6940;
	Wed,  8 Oct 2025 04:00:05 -0700 (PDT)
From: Kommula Shiva Shankar <kshankar@marvell.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <pabeni@redhat.com>, <xuanzhuo@linux.alibaba.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>, <jerinj@marvell.com>,
        <ndabilpuram@marvell.com>, <sburla@marvell.com>, <schalla@marvell.com>
Subject: [PATCH v2 net-next  0/3]  virtio_net: Implement VIRTIO_NET_F_OUT_NET_HEADER from virtio spec 1.4
Date: Wed, 8 Oct 2025 16:30:01 +0530
Message-ID: <20251008110004.2933101-1-kshankar@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA1NSBTYWx0ZWRfX6g1ABL/IOQfp
 m1LxBG6etT5MeUsHifu89PsHddGQ50msRqDmvo6Rj3yCkcRB4JIn9yAqlIA1dvkMlDcRy1+lcdG
 IYr+b+/vw0wYycH+uJtKW1JTc+aErd4xVd3w1nn8VZkZa2pr+wbTTcfO5PTF/g9KYX0QHEo4viO
 ZJ3+158j1tXxFVBv/5zGd//LfSCJPlFkoev+wcDgyaHbmZo2R65KSLslRNNFJPb+wz2vtye8WeQ
 5HvOBfHBZ7GZvHXAnkunWqbdSx7PAKsxcf9nw43RgNm+7fk/V3bN2A7IQ6Kps/iRh0MTwclqMQA
 JLaQxfiophGdQ+31+XIHOyhoca9Znc8lksTJMB+WTHXwL/vMEFgG9KpUIcSjmVpKiemVPtv1weD
 DhwB6RI/+hPSwBNYGRepYgn/mU8mOg==
X-Proofpoint-ORIG-GUID: g0_Dqd5nU0TSEfI4ROf9tX-fBDLptDnc
X-Proofpoint-GUID: g0_Dqd5nU0TSEfI4ROf9tX-fBDLptDnc
X-Authority-Analysis: v=2.4 cv=ar+/yCZV c=1 sm=1 tr=0 ts=68e6443a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=tZkuUt_2NcZHR2g27asA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01

This series implements the VIRTIO_NET_F_OUT_NET_HEADER feature which was introduced in the virtio specification 1.4 recently.
With this change, segmentation offload functionality now propagates outer IP header offset information to the device/apps running on NIC.

The virtio 1.4 spec introduced VIRTIO_NET_F_OUT_NET_HEADER feature[1] to address the performance issue caused by reading packet data
to determine outer network header offset and to support Inline IPSec functionality,
where vendor hardware devices need to know the outer network header offset for Inline IPSec acceleration.

Currently, devices must parse through packet headers to determine the outer network header which impacts performance.
This patch series implements the outer_nh_offset field in virtio_net_hdr to avoid parsing overhead.

This series was tested on ARM platform with virtio-net driver where ~4% performance improvement was measured
for device applications.

V1 -> V2: Added IPv6 support to outer network header offset feature 
	  Fixed sparse build warnings

[1] https://lore.kernel.org/virtio-comment/20250401195655.486230-1-kshankar@marvell.com/

Kommula Shiva Shankar (3):
  net: implement virtio helper to handle outer nw offset
  virtio_net: enable outer nw header offset support
  vhost/net: enable outer nw header offset support

 drivers/net/virtio_net.c        | 23 +++++++++++++++----
 drivers/vhost/net.c             |  4 ++++
 include/linux/virtio_net.h      | 40 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net.h |  8 +++++++
 4 files changed, 71 insertions(+), 4 deletions(-)

-- 
2.48.1


