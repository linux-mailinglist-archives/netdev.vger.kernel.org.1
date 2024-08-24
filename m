Return-Path: <netdev+bounces-121643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F08B95DD17
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 11:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEA8283D8D
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 09:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021C11547F9;
	Sat, 24 Aug 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vBvAfaAI"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12C13AD27
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724490495; cv=none; b=PnhE6wiCA5xtrU6hutrIKO2m2M/z50BjVS+YNybtI7kXTr202IHwLXAAeSNmEE9Z4I4FhJvYl3Zm3DJMdYg8ShgdMTZtfXgvaOYpUR0pbVnwJgbwhogNVE49oZNb2i3nvLHaVSypwcgxvvPT8r2eSMTgWSDV6OZNhFwmp2C3Raw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724490495; c=relaxed/simple;
	bh=iDueYySTOYDf76dyKY+O2COXWFiJlDQMv8fu9IizmiA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rq8VrL2SNO4h1egZCX/CA0uG2zeNAo/tNJu3FMy9HEyHLmu6xuftzrDZcyVpvtVTXVo6iOCHUyEqXjRz+CVGO6UxTvuFuA9MYXcmnsIRGwCqQcse/7SCgj/r9qPmBPau4q+RH8ZI3JU5zfoJXDiYaIT9eqNez6VEtSxCReCPQoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vBvAfaAI; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724490494;
	bh=TzP6fFPiDxclLlxPva2OtcKn8MvNbhGsPMaB51w3/kI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=vBvAfaAIxGN1pnq2mQUXe0qKdUAMkx8vitOmUqcntV6DVfCcAOcHMAUUz9aOkdee5
	 fd9dNPRUOObQGLfTBG10GXeMGM68e1krza+hcWstHfvzFrmxgcuQGp4Cy/hBuCJVkS
	 eO+WSmaxJnA7oClqX+XPf0YYT9vr0OObqisDBSkmn9P+I6Zkr0ditji9OxhZphuLdp
	 BaoLq8Q+u5iwX11fdQVCvMX1KtNVmhvFyGbpFto/yL8tzvzDV3fVNKQMMlruLeMSiw
	 XBqoA8VKztglPeuGFPywOQOm1bxwOarGfZ/uPM6YOs7dM7jUB+rR2gHPv0nLtIc00c
	 IVe8Z1vMwYrMw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id B17D92010334;
	Sat, 24 Aug 2024 09:08:07 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v3 0/3] driver core: Prevent device_find_child() from
 modifying caller's match data
Date: Sat, 24 Aug 2024 17:07:42 +0800
Message-Id: <20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6iyWYC/33NTQ6CMBQE4KuQrq2hLT+FlfcwhsBrK29hiy02G
 sLdLaw0MS5nkvlmIUF71IG02UK8jhjQ2RTEISMw9vaqKaqUCc95kUvGKDgb5k4Z6Cavp95rKoz
 hAqqykbokaZd6g8/dPF9SHjHMzr/2i8i29p8WGc2pqmqAglWDUOJ0fyCghSO4G9m8yD+N8pfBk
 yFF2st6kMY038a6rm+3ZjIw+AAAAA==
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
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: X7M2T8oCoMcwW3v59-FhLlvTphq15KTt
X-Proofpoint-ORIG-GUID: X7M2T8oCoMcwW3v59-FhLlvTphq15KTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_08,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408240053
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
 

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
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
Zijun Hu (3):
      driver core: Make parameter check consistent for API cluster device_(for_each|find)_child()
      cxl/region: Find free cxl decoder by device_for_each_child()
      net: qcom/emac: Prevent device_find_child() from modifying caller's match data

 drivers/base/core.c                             |  6 ++---
 drivers/cxl/core/region.c                       | 30 ++++++++++++++++++++-----
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 22 +++++++++++++-----
 3 files changed, 44 insertions(+), 14 deletions(-)
---
base-commit: 888f67e621dda5c2804a696524e28d0ca4cf0a80
change-id: 20240811-const_dfc_prepare-3ff23c6598e5

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


