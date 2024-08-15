Return-Path: <netdev+bounces-118872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34054953666
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EB01C25347
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC4D1A3BD0;
	Thu, 15 Aug 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="RduMliW4"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B17B29CE6
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733904; cv=none; b=ILSGVsXvcwibM7/ln+6kNJOtblAO1VziGEK6eHOJjbwWgECrB5bcz8CYbGNF6/nBXCU29DF2xGu/0v6DJTEyRXlhQCl3vi6/aTDwwYtjW0ayA4usMSTmxLM8ccsMbmPaJGpSNYjrlSnIAwTtChYYyBt8oZQMlX0m4mCazZBHUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733904; c=relaxed/simple;
	bh=D5kBlArR3VBj/YNFjLvPshcFzIub8HASCAC5DqTanxk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r96JL4Heed4VSWU9mCdv4kDq8ikBkfrS2ZUN6dSRHRISgA15s3hjYS295v+gtMD4YefzfYDhR+18LfpQ08K64fwEQ95VRyutiRc0Oe8sPYwiJALQU1Uo/hCSJjODDrJMlSQrD+K6g33QPqetC3Kl5IV/LhrN/w25Caxoe8s7xQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=RduMliW4; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723733901;
	bh=yzHbpOIW6NkHcW18s93aDeUltQuaFPLn1cSSYIxW6rg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=RduMliW45n3coSQN3Mkmvby/u5QCAH3NwcTeKLNjaPTCFyQhfWDUT+phVLyY2ddU8
	 DYA4k01S/m0aK5LRyhEHeR++SZHicIwSNH4/2Nig3NSdNHnWBOdu1WH1DawejyPjQP
	 ytGlga9IpF2oRvOeMs5tNFTw5r/WFXBbKDnM23LjIBGA3zk+8diIiL5DxT87V7nuw5
	 kJugHKagI2R4vBQzcyJv0AGwS5pDBSJOqa7mco2mypHTrQYOZDdhmNwI3gmYHqZRkG
	 Qxo2p9+uJ3baR4qZ/3OGyTQdcTnmXsF6XUrVv+1KmUNta69xarpEs/Mg0TIAHfPXmA
	 zv3L/SK3wfSTw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id D22A7DC043D;
	Thu, 15 Aug 2024 14:58:15 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/4] driver core: Prevent device_find_child() from
 modifying caller's match data
Date: Thu, 15 Aug 2024 22:58:01 +0800
Message-Id: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkXvmYC/32NQQ6CMBBFr0JmbQ1tAZGV9zCE4HQqs7DFFomG9
 O5WDuDyveS/v0GkwBShKzYItHJk7zKoQwE4je5Ogk1mUKWqylZKgd7FZTAWhznQPAYS2lqlsan
 PLdWQd9lbfu/Na5954rj48NkvVvmz/2qrFKUwzQmxks1NG315vhjZ4RH9A/qU0hcPrOf0tAAAA
 A==
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
X-Proofpoint-ORIG-GUID: B4N9KxfVpvfIqZEcsYxqOgw_K_ymbEWZ
X-Proofpoint-GUID: B4N9KxfVpvfIqZEcsYxqOgw_K_ymbEWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_07,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408150109
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to prepare for constifying the following driver API:

struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
to
struct device *device_find_child(struct device *dev, const void *data,
		int (*match)(struct device *dev, const void *data));

How to constify the API ?
There are total 30 usages of the API in kernel tree:

For 3/30 usages, the API's match function (*match)() will modify
caller's match data @*data, and this patch series will clean up them.

For remaining 27/30, the other patch series will simply change its
relevant parameter type to const void *.

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
 

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Give up introducing the API constify_device_find_child_helper()
- Correct commit message and inline comments
- Implement a driver specific and equivalent one instead of device_find_child()
- Link to v1: https://lore.kernel.org/r/20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com

---
Zijun Hu (4):
      driver core: Make parameter check consistent for API cluster device_(for_each|find)_child()
      cxl/region: Prevent device_find_child() from modifying caller's match data
      firewire: core: Prevent device_find_child() from modifying caller's match data
      net: qcom/emac: Prevent device_find_child() from modifying caller's match data

 drivers/base/core.c                             |  6 ++--
 drivers/cxl/core/region.c                       | 36 +++++++++++++++++++++++-
 drivers/firewire/core-device.c                  | 37 +++++++++++++++++++++++--
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 36 ++++++++++++++++++++++--
 4 files changed, 107 insertions(+), 8 deletions(-)
---
base-commit: bfa54a793ba77ef696755b66f3ac4ed00c7d1248
change-id: 20240811-const_dfc_prepare-3ff23c6598e5

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


