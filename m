Return-Path: <netdev+bounces-81069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F5885A4B
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC5B1C21B57
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A21684FBE;
	Thu, 21 Mar 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehZGVpcs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82584FB8;
	Thu, 21 Mar 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029935; cv=none; b=J0xBYU4jNntjgIGdpCH6HBYd8XNaT41xzY3SupYW1DLhWXwAICs+D5O2xYm+Wwvr6DWp/nt6Yq6uGrU7hv5ThInG9dVlO+Bq3C0fmeebLUuZcS/TL7omnY94xX08RdV/ZOIuMxrges3145LxWJYj2EOWGPWv67Lwh+DDM039NHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029935; c=relaxed/simple;
	bh=tnh61gy3Hi24ulmSCoHJWEcsDEYuQESZN/JaYY3buA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LB04ezKH5ETAnjGv9I7Hk8bHv2J1GvkxCqzSfM4Wa5HzCXw0U4xifiyY+5aiHZbCvL+H3oBrEsDCbNFY3EJZCEcECM6UVhHntwnJwHDslOImj360gHz4ITBlW4KLtIO9xAV3tvQaM8g9U0DTP2yGzoiVyaEURw4NtjSOBj99EiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehZGVpcs; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711029934; x=1742565934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tnh61gy3Hi24ulmSCoHJWEcsDEYuQESZN/JaYY3buA4=;
  b=ehZGVpcs74rH2vN+TQfkszTj5SuiOPpSEVXOmY9O3eg/Z87KITyjpsOi
   IxCEbt3mqwMogybEhp9AAW3a6tNO3PR6PjSDuZKewxG3uFfi6F0QeXvfs
   kwjqVUa3OCiofNcqzVKmVOQxvoAsc5VsoNIW2+jlChW3tNKWHEK/Oc/mm
   EO8CaZG9LTEm4TdHkymFyTOH3W3ZSvOGdG8N7QHOSZMl1T8piGj/QQwN+
   tmgIi7+punYW8mOPpmU+U5Bm2d1iITTWNott0q2oHmVbKJAlY5P2MwaaI
   PCmHfO124vwaWj9jWvyC5coxQb9Qck5wgLwfAt85CKi7VfqYdOdQYlYTN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5910995"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5910995"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="14911353"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:30 -0700
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
Subject: [PATCH bpf-next v2 4/7] selftests/bpf: implement set_hw_ring_size function to configure interface ring size
Date: Thu, 21 Mar 2024 13:49:08 +0000
Message-Id: <20240321134911.120091-5-tushar.vyavahare@intel.com>
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

Introduce a new function called set_hw_ring_size that allows for the
dynamic configuration of the ring size within the interface.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 24 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 1cab20020f94..04175e16195a 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -521,3 +521,27 @@ int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 	close(sockfd);
 	return 0;
 }
+
+int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
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
+	ring_param->cmd = ETHTOOL_SRINGPARAM;
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
index de4d27d201cb..6457445cc6e2 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -65,6 +65,7 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
+int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
 struct nstoken;
 /**
-- 
2.34.1


