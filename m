Return-Path: <netdev+bounces-80079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA287CEB1
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB66B21ACA
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179953A1CA;
	Fri, 15 Mar 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dh+V/PaY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED633A1B2;
	Fri, 15 Mar 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512619; cv=none; b=SW34x/G8XeWxwJQwergVycrafPrYLaJsmD2QdvlwwImX/884eBorlAfdw/+oH506lw97xNJMqQHZylBf21IE6D0cZ1JhmdXSkY3v/IhQ4I+gBkWZloN6TZTO29snaL5KEzKoxGNFDABoPklSuV6v5eBNwGd9JedsHKts4dkzXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512619; c=relaxed/simple;
	bh=RYogotB+lCiNsjmLNbwWGJ5R2aXrQ3ASR296p4smeus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e0fpPCTSi7ywRXsU2hZ0igZCpYIztt9f8jIzy6ZWQklsphtAwo8KzxDAOkhvp3KoJGUC5W0Lm79tiIQpCQtuWHLdlALQ5uOVWSA3A3BoJT04tzQ/YdKbjlNdDmKWbKprzPbqtGV8yvh62np6uIMFGMGnBg5FsA8Mlbzu0g0Jhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dh+V/PaY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710512618; x=1742048618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RYogotB+lCiNsjmLNbwWGJ5R2aXrQ3ASR296p4smeus=;
  b=dh+V/PaY1gBhjctIQTXGpdfD6vSBbsx7FHlohESOBHIxEZwGL3SlGWiw
   gwYPqglNVKTGwqPR/GucKdXG73d/o1oQYy4Vi9LgF2zrACXjXAWhAROJk
   E46teXAaEQI0GyAIsRMhe4h5YjEONRCE8TOFeynfOHiCjvju+IB96k+1p
   Fvk3bFdwnvN4kAhvUZ9p8i1AzmJvjd8fv/vcyhfXBpTOxTzocLV5sABM3
   B52bWOqKWxJpaWTl5zKkUmE659HcYA9XeChQoZiTR9fdhw247P+2rECop
   Aa7Jr7A1RH/kb624gT++fv/+d6HffzC3isPMIi9KYA3+lnS6VDzrM0BiG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5250054"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5250054"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17140749"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:33 -0700
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
Subject: [PATCH bpf-next 3/6] selftests/xsk: implement get_hw_ring_size function to retrieve current and max interface size
Date: Fri, 15 Mar 2024 14:07:23 +0000
Message-Id: <20240315140726.22291-4-tushar.vyavahare@intel.com>
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

Introduce a new function called get_hw_size that retrieves both the
current and maximum size of the interface and stores this information in
the 'hw_ring' structure.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 32 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/xskxceiver.h |  8 ++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index eaa102c8098b..32005bfb9c9f 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -81,6 +81,8 @@
 #include <linux/mman.h>
 #include <linux/netdev.h>
 #include <linux/bitmap.h>
+#include <linux/sockios.h>
+#include <linux/ethtool.h>
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <locale.h>
@@ -95,6 +97,7 @@
 #include <sys/socket.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <sys/ioctl.h>
 #include <unistd.h>
 
 #include "xsk_xdp_progs.skel.h"
@@ -409,6 +412,35 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	}
 }
 
+static int get_hw_ring_size(struct ifobject *ifobj)
+{
+	struct ethtool_ringparam ring_param = {0};
+	struct ifreq ifr = {0};
+	int sockfd;
+
+	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sockfd < 0)
+		return errno;
+
+	memcpy(ifr.ifr_name, ifobj->ifname, sizeof(ifr.ifr_name));
+
+	ring_param.cmd = ETHTOOL_GRINGPARAM;
+	ifr.ifr_data = (char *)&ring_param;
+
+	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
+		close(sockfd);
+		return errno;
+	}
+
+	ifobj->ring.default_tx = ring_param.tx_pending;
+	ifobj->ring.default_rx = ring_param.rx_pending;
+	ifobj->ring.max_tx = ring_param.tx_max_pending;
+	ifobj->ring.max_rx = ring_param.rx_max_pending;
+
+	close(sockfd);
+	return 0;
+}
+
 static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			     struct ifobject *ifobj_rx)
 {
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 425304e52f35..4f58b70fa781 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -114,6 +114,13 @@ struct pkt_stream {
 	bool verbatim;
 };
 
+struct hw_ring {
+	u32 default_tx;
+	u32 default_rx;
+	u32 max_tx;
+	u32 max_rx;
+};
+
 struct ifobject;
 struct test_spec;
 typedef int (*validation_func_t)(struct ifobject *ifobj);
@@ -130,6 +137,7 @@ struct ifobject {
 	struct xsk_xdp_progs *xdp_progs;
 	struct bpf_map *xskmap;
 	struct bpf_program *xdp_prog;
+	struct hw_ring ring;
 	enum test_mode mode;
 	int ifindex;
 	int mtu;
-- 
2.34.1


