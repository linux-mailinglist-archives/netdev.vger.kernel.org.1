Return-Path: <netdev+bounces-80080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846887CEB2
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD9D285BF2
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A73D3B7;
	Fri, 15 Mar 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8cjTbQD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0004F3A28E;
	Fri, 15 Mar 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512623; cv=none; b=pSMRPlsOjIC5HADC0arANeBVTQoMYW8MVtzmCfFWquz9dgHilYAAq8OpPafmXWMliIVCupPo1VdMHpP5KJPIbgBT+/qSfrPjTx3cH3o446AzT91OnkmvpkvnYBN5kAnUuH5nzJxPHQ8R0qd2SqTKm88d54vasDPLaN77fqbRiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512623; c=relaxed/simple;
	bh=jg2PdJKQGB4u9Cr0VqX6IloO14S4i9A1AIMZyfPu+QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BhWz3GgNVMamHNCidSt/mFTBeR2vsjL1ZYlxWC3wNy1+ys1su0GkZgWKIqVJrGDYPPVEIrojGmFcnG7MkVgbNa6bHoZlaVnqWouHNgCM7+GQ/5ZsqlIAbgvFuMwpoUoJOxy/faA04he8mSKnLHoqFQ8G7YLK9PTXkPgXCYQiUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8cjTbQD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710512622; x=1742048622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jg2PdJKQGB4u9Cr0VqX6IloO14S4i9A1AIMZyfPu+QI=;
  b=l8cjTbQDcpjyrCjZsZukTMEjVQHMNRSHsfi94CZzLxne8sH+R/NSz88e
   zuhEUBV65+93WgJJuG/x/+Ou8M55+RYvYffSiKfH8B13qQsnO9FlyrahF
   vkCHyeCqaofdOx1SN4ES7a/v60seP3j+P4C4T7NXYCJb3rwPMDMuVYjOr
   /1USCfrl77ArEGBToxpmhEeLGmDJ+FO08GLuPpMgJ8rTdh7l78EcZUQiF
   I+dXZ2i190hTSkhjssSleW3GAlukr7ZLZshQOZ/CGuUcFuq7og0bStR99
   UmvKmEDykFJmHH0RKfuCNfJatcArnzRXxC1AyDQBaF9NbQyB/Zomt83qX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5250069"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5250069"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17140754"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:38 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next 4/6] selftests/xsk: implement set_hw_ring_size function to configure interface ring size
Date: Fri, 15 Mar 2024 14:07:24 +0000
Message-Id: <20240315140726.22291-5-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315140726.22291-1-tushar.vyavahare@intel.com>
References: <20240315140726.22291-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new function called set_hw_ring_size that allows for the
dynamic configuration of the ring size within the interface.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 32005bfb9c9f..aafa78307586 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -441,6 +441,41 @@ static int get_hw_ring_size(struct ifobject *ifobj)
 	return 0;
 }
 
+static int set_hw_ring_size(struct ifobject *ifobj, u32 tx, u32 rx)
+{
+	struct ethtool_ringparam ring_param = {0};
+	struct ifreq ifr = {0};
+	int sockfd, ret;
+	u32 ctr = 0;
+
+	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sockfd < 0)
+		return errno;
+
+	memcpy(ifr.ifr_name, ifobj->ifname, sizeof(ifr.ifr_name));
+
+	ring_param.tx_pending = tx;
+	ring_param.rx_pending = rx;
+
+	ring_param.cmd = ETHTOOL_SRINGPARAM;
+	ifr.ifr_data = (char *)&ring_param;
+
+	while (ctr++ < SOCK_RECONF_CTR) {
+		ret = ioctl(sockfd, SIOCETHTOOL, &ifr);
+		if (!ret)
+			break;
+		/* Retry if it fails */
+		if (ctr >= SOCK_RECONF_CTR) {
+			close(sockfd);
+			return errno;
+		}
+		usleep(USLEEP_MAX);
+	}
+
+	close(sockfd);
+	return 0;
+}
+
 static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			     struct ifobject *ifobj_rx)
 {
-- 
2.34.1


