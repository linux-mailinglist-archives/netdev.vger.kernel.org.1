Return-Path: <netdev+bounces-117437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB2A94DF51
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 02:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96D71F21443
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 00:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59A1366;
	Sun, 11 Aug 2024 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="o6bVHNNh"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7B23A9
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723335530; cv=none; b=ug6/ud4G3KwTg5PewJM7jpLguKKo9MEEnBcVsNVGfUzc2ld+8K5AbtvO6qzFFXS9aJ04ROEycRBpzKIlNK+tVVC4vicgMjls9zPLF3LpFABPCjf5Mi5JPUiiVNIlDzK5AIDobd4OHhbXh349T01O67KPEDhWy1V0QLFF4Mz5G0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723335530; c=relaxed/simple;
	bh=rfsAqB3ABzAw4k4YFUsBGT5RlA2LBy1CR+W6oq66PLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JDxDOPvMf5Rx9g5EcOyRJrqv2cSbT+nxTlYtxyHg1UlP5Vawf7clUBh00bWDy+zk/RLo5KYSZ2UA5opS0wjoJOEnq6x58HgCes/OVzhigkGkSJDfmt8+BvdWf5k6Gih1kCnXoVMo7grUuq7lPoYjHaCtnWRkAm2trbm2ZWy/DzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=o6bVHNNh; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723335529;
	bh=sMzCCzLcqbDXnEI1gV/9SglcksJ6B9/EUKCZv8p6uOw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=o6bVHNNh9rdsAwhdDIywsOyfSNeqQli/Yui4uoTJOM6SjwHF4b29SmHUS0J8yxKVp
	 pXm0x+ahuhlPog/ha4OmRjbkgVnTgNVn1Y6ZFWFdmO/GaMS5+7FzWkHVf5eRYdKgPu
	 fvLq2y/jaf+ZznTlV91UeK8USk0RZdAXg4xkuqBnfM4orX2OnDaIq7MpwTHi9FukTd
	 Yz0wTU16C5gYnblWtDKBrxCuD3CA1EvuW43noSXiF6DqbqjUMgrEeg9Gzd4R01/JcV
	 LmtuOta3PXJ0A/708I0NnSZwDq/BIeS/bCo7yOBfMNQNGMeevhF0MAfFIg1TYsypE5
	 BrSnuJO3S9M9Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id E7E446800E0;
	Sun, 11 Aug 2024 00:18:41 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/5] driver core: Prevent device_find_child() from
 modifying caller's match data
Date: Sun, 11 Aug 2024 08:18:06 +0800
Message-Id: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD4DuGYC/x2MQQqAIBAAvyJ7TkitsL4SIWJr7UVFIwLp70nHG
 ZipUDATFlhYhYw3FYqhgegYuNOGAzntjUH2cui1ENzFUC6ze2dSxmQzcuW9VG4aZ40jtK55T8/
 /XLf3/QAHlhhFYwAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux1394-devel@lists.sourceforge.net, 
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: 4L9tuNO2TjW7i1hJIeaEMDcVxMnhKH5V
X-Proofpoint-GUID: 4L9tuNO2TjW7i1hJIeaEMDcVxMnhKH5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_19,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110001
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

For driver API:
struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));

It does not make sense for its match function (*match)() to modify
caller's match data @*data, but there are 3 device_find_child() usages
whose match functions do such awful things within current kernel tree.

This patch series is to clean up them first to prepare to constify the API.

Previous discussion link:
https://lore.kernel.org/lkml/917359cc-a421-41dd-93f4-d28937fe2325@icloud.com

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (5):
      driver core: Add simple parameter checks for APIs device_(for_each|find)_child()
      driver core: Introduce an API constify_device_find_child_helper()
      cxl/region: Prevent device_find_child() from modifying caller's match data
      firewire: core: Prevent device_find_child() from modifying caller's match data
      net: qcom/emac: Prevent device_find_child() from modifying caller's match data

 drivers/base/core.c                             | 41 +++++++++++++++++++++++--
 drivers/cxl/core/region.c                       |  3 +-
 drivers/firewire/core-device.c                  |  5 +--
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c |  5 +--
 include/linux/device.h                          |  7 +++++
 5 files changed, 53 insertions(+), 8 deletions(-)
---
base-commit: bfa54a793ba77ef696755b66f3ac4ed00c7d1248
change-id: 20240811-const_dfc_prepare-3ff23c6598e5

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


