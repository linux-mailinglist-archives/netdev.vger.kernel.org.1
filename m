Return-Path: <netdev+bounces-81068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D167885A49
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383CE2834E6
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7822884FAF;
	Thu, 21 Mar 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/FbfY36"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CD84FA7;
	Thu, 21 Mar 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029931; cv=none; b=DsUMe+q3FfOQnWG7ShnkCPcxzeYGiz4Dr8HZ3uxgbDzIC3QYniydA9TOjO79zgMV4xAFYIZuKDngusZBN3R4yJIYMz93Ep281kwJb3nEjAFF2gPs67Che5BMvDKai9yN43AwDrcMXKUYVD8a9VxVpKnEO8BtW7H1tttMmwTagoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029931; c=relaxed/simple;
	bh=flbEeV6zO1FOeWvevk1LsX12NdClZWYsch/8ctd8Ovc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O9o+B64hyU5L+vUKacIvqhKK6rupEl9Bguas6Ea80DPPXvZnCj0z6lezFk4LdinbBU2Y/mmR5YsY9oeueo7kcSVwcBh8TuAKo0Aqc/627iyuBvoZDHX2WQCHSEeUc86jrbPQdEoSMVWt3FQS6hF8nMmnDEL4ToavjtHoLnncUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/FbfY36; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711029930; x=1742565930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=flbEeV6zO1FOeWvevk1LsX12NdClZWYsch/8ctd8Ovc=;
  b=U/FbfY36KElOnqaZS1SuUKGLWMT3ZASZLes7gN4NkuRIjovVdekMC1i9
   QpBVX6X5bUPxjisuFuxmjuVoznLxYwWecBIxG70EWxLRp71sOkdAHPD2W
   UsQeLBJ0BPKY8up2imuBAtqSHjkeMVmqvViF8AL/kU9i9KywIuwBofCGx
   dWZJ5VeCie5OXCG61pUbotlIEYzezNJFVBS8V1mlFzrNwziV1IyIaIs25
   6cNNjmoZcto8fEUPxHr6HfQpIRToIVB8mXrQ1KXU1V7Q76bYYOVCH0a07
   SWkeH/xMGLgHUOEjHBIxozm5v9YpLDFvGoJ4//YV57vCtFCnT776dFzid
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5910970"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5910970"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="14911327"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:25 -0700
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
Subject: [PATCH bpf-next v2 3/7] selftests/bpf: implement get_hw_ring_size function to retrieve current and max interface size
Date: Thu, 21 Mar 2024 13:49:07 +0000
Message-Id: <20240321134911.120091-4-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321134911.120091-1-tushar.vyavahare@intel.com>
References: <20240321134911.120091-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new function called get_hw_size that retrieves both the
current and maximum size of the interface and stores this information in
the 'ethtool_ringparam' structure.

Remove ethtool_channels struct from xdp_hw_metadata.c due to redefinition
error.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 24 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  4 ++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 14 -----------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6db27a9088e9..1cab20020f94 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -497,3 +497,27 @@ int get_socket_local_port(int sock_fd)
 
 	return -1;
 }
+
+int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
+{
+	struct ifreq ifr = {0};
+	int sockfd, err;
+
+	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sockfd < 0)
+		return -errno;
+
+	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+
+	ring_param->cmd = ETHTOOL_GRINGPARAM;
+	ifr.ifr_data = (char *)ring_param;
+
+	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
+		err = errno;
+		close(sockfd);
+		return -err;
+	}
+
+	close(sockfd);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 94b9be24e39b..de4d27d201cb 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -9,8 +9,11 @@ typedef __u16 __sum16;
 #include <linux/if_packet.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/ethtool.h>
+#include <linux/sockios.h>
 #include <netinet/tcp.h>
 #include <bpf/bpf_endian.h>
+#include <net/if.h>
 
 #define MAGIC_VAL 0x1234
 #define NUM_ITER 100000
@@ -61,6 +64,7 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
+int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
 struct nstoken;
 /**
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index bdf5d8180067..0859fe727da7 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -495,20 +495,6 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 	return 0;
 }
 
-struct ethtool_channels {
-	__u32	cmd;
-	__u32	max_rx;
-	__u32	max_tx;
-	__u32	max_other;
-	__u32	max_combined;
-	__u32	rx_count;
-	__u32	tx_count;
-	__u32	other_count;
-	__u32	combined_count;
-};
-
-#define ETHTOOL_GCHANNELS	0x0000003c /* Get no of channels */
-
 static int rxq_num(const char *ifname)
 {
 	struct ethtool_channels ch = {
-- 
2.34.1


