Return-Path: <netdev+bounces-120617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03011959FB0
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC8B234E9
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB171B251C;
	Wed, 21 Aug 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QisuUhVc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2381B1D6D
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250258; cv=none; b=ZQfUby1XOJ6y861k1+osTd+B3pkMFEnlshXpVNhmwu8qYYbkwcahNL+5m6di19/Z2yzJytI35RzWl+1NV8t2DNG/AH+9tyk/wFDdOgMLSFsp5Z0l3qdYrqprvU9Kba0sDUFZbqiiu6Mn/ZhELOheoJNLCd+eEBUDIErx1FfFThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250258; c=relaxed/simple;
	bh=zba7tmF1NmTvBJWLLY//6vcc7OAzCrA6reHKqs74DjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ItatsJHjv6fg46G4Ynqohuh9kGVAmaVft6oz969aS/BsvxrerxSd05Zr/OmnR4BPcPTpTQv+KucXXqHZ8pYuntyFURz/39eZUzdNJVPFxQLzWSOQYLBgIqeLLNJpKXWD3WI22mCQ/gaoT7sHznp5FRumpWYkFOu6+Vj9d+kGBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QisuUhVc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724250257; x=1755786257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zba7tmF1NmTvBJWLLY//6vcc7OAzCrA6reHKqs74DjA=;
  b=QisuUhVca4zGXy1EvdDOZHVeCj9uw7I6EGxYPfQLSt3RRN2Afc4RqfNL
   j8mGCnAfCbz/AkVAcPgSiX66f9MGZNCwn1nBVtvFXOTwLRBtXU5f90ulV
   m6kbxEGS/dCdGv0G2N2CeNm1FDV0QTGdM06z2K/OI9CeZXr+SObi/8+aq
   ibwMvfaLsA3ivdQgJ/ZFQ3d9gtrSaocJN1521YzysEeqVTai/YaZzHA2b
   P8+2/5Fz8+QHn7mZucSqihhIAF2+Nrjv61YagqfMS07JimrMaD4BJj0zn
   MnKCPzRI+N6cbywIJFQx2KYFC8Hd7ykEFlr9gz8HS5Gm108Q8XRruFsst
   w==;
X-CSE-ConnectionGUID: OfcZpyqVQOGDyTZb+MULFQ==
X-CSE-MsgGUID: It6Y1vhGS/CKdeCCRLhULQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22762633"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22762633"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:24:16 -0700
X-CSE-ConnectionGUID: 2eqIswKuSGSPpz0zjb5oCw==
X-CSE-MsgGUID: XG8qoiKATxSUmTGmDHop3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61088153"
Received: from ubuntu.igk.intel.com ([10.91.15.74])
  by fmviesa008.fm.intel.com with ESMTP; 21 Aug 2024 07:24:15 -0700
From: Krzysztof Galazka <krzysztof.galazka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Krzysztof Galazka <krzysztof.galazka@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] selftests/net: Fix csum test for short packets
Date: Wed, 21 Aug 2024 16:24:09 +0200
Message-ID: <20240821142409.958668-1-krzysztof.galazka@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For IPv4 and IPv6 packets shorter than minimum Ethernet
frame payload, recvmsg returns lenght including padding.
Use length from header for checksum verification to avoid
csum test failing on correct packets.

Fixes: 1d0dc857b5d8 (selftests: drv-net: add checksum tests)
Signed-off-by: Krzysztof Galazka <krzysztof.galazka@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 tools/testing/selftests/net/lib/csum.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
index b9f3fc3c3426..3dbaf2ecd59e 100644
--- a/tools/testing/selftests/net/lib/csum.c
+++ b/tools/testing/selftests/net/lib/csum.c
@@ -658,6 +658,9 @@ static int recv_verify_packet_ipv4(void *nh, int len)
 	if (len < sizeof(*iph) || iph->protocol != proto)
 		return -1;
 
+	/* For short packets recvmsg returns length with padding, fix that */
+	len = ntohs(iph->tot_len);
+
 	iph_addr_p = &iph->saddr;
 	if (proto == IPPROTO_TCP)
 		return recv_verify_packet_tcp(iph + 1, len - sizeof(*iph));
@@ -673,6 +676,9 @@ static int recv_verify_packet_ipv6(void *nh, int len)
 	if (len < sizeof(*ip6h) || ip6h->nexthdr != proto)
 		return -1;
 
+	/* For short packets recvmsg returns length with padding, fix that */
+	len = sizeof(*ip6h) + ntohs(ip6h->payload_len);
+
 	iph_addr_p = &ip6h->saddr;
 
 	if (proto == IPPROTO_TCP)
-- 
2.43.0


