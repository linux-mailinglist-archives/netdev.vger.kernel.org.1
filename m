Return-Path: <netdev+bounces-125325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42696CBD4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB071C22BBB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3299B4A33;
	Thu,  5 Sep 2024 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nJzaGNNI"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE02A4A2D
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496612; cv=none; b=dmHOR2TZ/g/xdVqyMzd90U3Sf6C1E9dxP0pXDfnxrjn3yRSrjqefLo3wVglNFTeoK0YyQWQ2sSdoL9SAKa6qCmhph6NYFWWaar9tQIEE7253xkldZsPlEYV1ElRDLtQVNs0oYGmVp/NZpM0l5o19wGUgITffqgjG4qH6pJtT7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496612; c=relaxed/simple;
	bh=WOkm1kdKgc5McMjUB8LPocHoxSN0n0x6QzlsXX/pwLE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f2JlRReuN38voCM7rxRvgNqFD85UtAZpc//be/0F4NftqYauC3zGD3bl7rOEJYLUWrEAPzH3mf8QeWhnrpd9xTfgypodbvI1C+vHtR/ClsaZ+d+qLlhQY7esdjCDJFSGIOcf+IqsXIm7r0tfIvToK5zOTnkcPMbRcDuD+VYlvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nJzaGNNI; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725496610;
	bh=+JXm3cbOyXZGBfZt1/MMaaX3ewJ7Bpd6ErNxnOc+4YM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=nJzaGNNIVZ8bH1rdwZ/NBmT3gE5n4WJCNMV/Vx+dIij0WfxXUgc+e5iaxQ9kgO/ZR
	 ZeYqI/AA/LUEws60REcY3/aOmk25/r07Fbtc8Wd2BzLhIkVfC/Iu65ARk0lqeNstKP
	 YJJ8KwpvZ6gijZyp7S/b4zo29XOLjoM7NF8m//kOMqnuIn3XIT4pPsDBhSWxQpzIc2
	 gPSq/D43sXg3Axzc/dAUJWADAgoHwex3eL6bkTh5S0MfQoq2I+IOgAaAA4d7+BVxUW
	 fQs0D7LfIp2e5+I3ezb4iHhM0CFCuAeKyiXiGdAIWvEOrPGeQwwfdjrgKH/p82606W
	 gz7qW/8K6C+2Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 1F40E4A01EA;
	Thu,  5 Sep 2024 00:36:41 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v4 0/2] driver core: Prevent device_find_child() from
 modifying caller's match data
Date: Thu, 05 Sep 2024 08:36:08 +0800
Message-Id: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPj82GYC/33NzQ6CMBAE4FchPVtDd/kpnnwPYwgsrfQgxRaJh
 vDuFk4YiceZZL6ZmFfOKM9O0cScGo03tgshOUSM2qq7KW6akBnEkMRSCE6280PZaCp7p/rKKY5
 aA1KWFlKlLOxCr81rNS/XkFvjB+ve68UolvafNgoe8ybLiRKR1djg+fE0ZDo6kr2zxRtha6R7B
 gRDYtjLvJZaF78GbgxI9gwMBoKAXFUIdV19G/M8fwD5i2PPPAEAAA==
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, Timur Tabi <timur@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: LlxH74fFnXib7Om1_SdN4Xl-IEu1xDXg
X-Proofpoint-GUID: LlxH74fFnXib7Om1_SdN4Xl-IEu1xDXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_22,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409050002
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to prepare for constifying the following driver API:

struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
to
struct device *device_find_child(struct device *dev, const void *data,
		int (*match)(struct device *dev, const void *data));

How to constify the API ?
There are total 30 usages of the API in kernel tree:

For 2/30 usages, the API's match function (*match)() will modify
caller's match data @*data, and this patch series will clean up them.

For remaining 28/30, the following patch series will simply change its
relevant parameter type to const void *.
https://lore.kernel.org/all/20240811-const_dfc_done-v1-1-9d85e3f943cb@quicinc.com/

Why to constify the API ?

(1) It normally does not make sense, also does not need to, for
such device finding operation to modify caller's match data which
is mainly used for comparison.

(2) It will make the API's match function and match data parameter
have the same type as all other APIs (bus|class|driver)_find_device().

(3) It will give driver author hints about choice between this API and
the following one:
int device_for_each_child(struct device *dev, void *data,
		int (*fn)(struct device *dev, void *data));
 

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v4:
- Drop driver core patch
- Correct commit message for cxl/region patch
- Correct title and commit message for qcom/emac patch
- Link to v3: https://lore.kernel.org/r/20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com

Changes in v3:
- Git rebase
- Correct commit message for the driver core patch
- Use changes suggested by Ira Weiny cxl/region
- Drop firewire core patch
- Make qcom/emac follow cxl/region solution suggested by Greg
- Link to v2: https://lore.kernel.org/r/20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com

Changes in v2:
- Give up introducing the API constify_device_find_child_helper()
- Correct commit message and inline comments
- Implement a driver specific and equivalent one instead of device_find_child()
- Link to v1: https://lore.kernel.org/r/20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com

---
Zijun Hu (2):
      cxl/region: Find free cxl decoder by device_for_each_child()
      net: qcom/emac: Find sgmii_ops by device_for_each_child()

 drivers/cxl/core/region.c                       | 30 ++++++++++++++++++++-----
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 22 +++++++++++++-----
 2 files changed, 41 insertions(+), 11 deletions(-)
---
base-commit: fea64fa04c31426eae512751e0c5342345c5741c
change-id: 20240811-const_dfc_prepare-3ff23c6598e5

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


