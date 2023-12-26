Return-Path: <netdev+bounces-60283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8281E730
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 12:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA851F224F8
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EAB4E1D4;
	Tue, 26 Dec 2023 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+G5KAMD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6C44E1D0
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703591416; x=1735127416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v1xdHtRyvG94UP1kD9FPSjUs3Ibi0hmcmPueEEKvHFM=;
  b=B+G5KAMD1VbPoVgTya+frdUG95vCAjoUGRfX807q/dFfgCSzvVlW9TpQ
   K8zJ4I7FfBWaJe2eSJoRX+dkXlbgzx5wYvuDuru72NDpglbISA9WtlnLa
   +eJrw6WARuSzzQL57dKwsFBWU29S8/0KME1hfWQMLpmnRs/1O4GZUk1Jd
   zncerY+NXS6HnGOerHCdKZjEVAlKkkQLp5pWpO9nByF2er7DdVDn43OHe
   GODanh06GNVYJXHyQNw9jMH21SdcbslKo6FtR5fqR24+hX5IHaZPx+hv7
   o7nU3lAUyUG6Z7P/eT6IiGSZjxJJcCuhLY0oIHGDVuHFnzj4ez6ea3+4e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="400162573"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="400162573"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 03:50:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="777935768"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="777935768"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga002.jf.intel.com with ESMTP; 26 Dec 2023 03:50:12 -0800
From: Zhu Yanjun <yanjun.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] =?UTF-8?q?virtio=5Fnet:=20Fix=20"=E2=80=98%d=E2=80=99?= =?UTF-8?q?=20directive=20writing=20between=201=20and=2011=20bytes=20into?= =?UTF-8?q?=20a=20region=20of=20size=2010"=20warnings?=
Date: Tue, 26 Dec 2023 19:45:07 +0800
Message-Id: <20231226114507.2447118-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Fix a warning when building virtio_net driver.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 49625638ad43..cf57eddf768a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4508,10 +4508,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 {
 	vq_callback_t **callbacks;
 	struct virtqueue **vqs;
-	int ret = -ENOMEM;
-	int i, total_vqs;
 	const char **names;
+	int ret = -ENOMEM;
+	int total_vqs;
 	bool *ctx;
+	u16 i;
 
 	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
 	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
-- 
2.41.0


