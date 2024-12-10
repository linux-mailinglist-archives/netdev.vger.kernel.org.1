Return-Path: <netdev+bounces-150628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270A99EB047
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068EA282E75
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED019EED6;
	Tue, 10 Dec 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FG5MXQKe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3170719E99E;
	Tue, 10 Dec 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831824; cv=none; b=KtTaVnwuJC7xapV/H7HNSyD5roWXTDRMWcuY7qR7fNL0yE1FksBCVEYciWE7F5i9ub08OOuIety06ySuIdpWjLNQbTa7qF2vzPqYupdkIRWIYIo71kbjnJowli3Lug3TWwkh41HHraRc1F7k4pwSn3VOjluoaO+7xF/A9/H3wRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831824; c=relaxed/simple;
	bh=+PGdy1a0YaWtqkwxhanaUKLDKgb00Z5XGEDcswMcHeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iT3V218gx8IHn6NvsPKceZ1Ime2xQ3Pzr3uQo4gZSVkIwYgC1q1N5Lq5KQldUYLE/HRt63VHpRahdL9K2nbVlzbGYdINfWex7CYkokXkYxCyxaYQUvKKyveYHBHOUO87gnRRIrIXHKY4JCG9Zp5Y8ehrhyQW8/ZV6W/pt1BHaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FG5MXQKe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733831823; x=1765367823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+PGdy1a0YaWtqkwxhanaUKLDKgb00Z5XGEDcswMcHeQ=;
  b=FG5MXQKedHjQ54UiooZmmXs4mpyQwNthB8HVHYwH+wh93wx6rYGgTdnU
   Y+kufD86Fm2JOA9rKH1rv7yP6tf9Rk3aU0stLbt8wqWZDA7twbIi/q9tg
   CRigYtAqoKWkpvuKECsLQ/uxhHMd+OMMHHqRS1rs4yC07Xdl8ssh58yCl
   Q416dTvcS29BPnUecdb3UWQimsQ5WNT16GC6A3QXfKRV1Lw0lNT+JnD+I
   BPj/jO24ib86M7uZTo3NM53/tKpGYtTs9QB7yyzoYj4+fUV3Yiqx+gztK
   oYKPy0T+LiW5wb2QRRovccaEoC5Ksfj3GhR/hmld0R7i3AEAo8631tHbM
   g==;
X-CSE-ConnectionGUID: HwbFKjI0RN6pAbd3H2TlUA==
X-CSE-MsgGUID: 4ozj2VfRSjKubIdR2sXw/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37954873"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="37954873"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 03:57:02 -0800
X-CSE-ConnectionGUID: 4O8P+dp1SIKQONr/Asa4MQ==
X-CSE-MsgGUID: qVlaJWULQuicI7j0PYSbjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="100341171"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 10 Dec 2024 03:56:58 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EF9852FC51;
	Tue, 10 Dec 2024 11:56:56 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next] fixup! devlink: add devlink_fmsg_dump_skb() function
Date: Tue, 10 Dec 2024 12:56:20 +0100
Message-Id: <20241210115620.3141094-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Tony!

In the commit related to "devlink-health dump" the sparse reports new issue.
It has been also reported some time ago by Simon:
https://lore.kernel.org/netdev/20240822104007.GL2164@kernel.org/

Please squash this change into to devlink-health series, the link for the
last sent version is here:
https://lore.kernel.org/netdev/20240821133714.61417-1-przemyslaw.kitszel@intel.com/

Thanks in advance
Mateusz

CC: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 net/devlink/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 3f6241d51007..57db6799722a 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -1270,7 +1270,7 @@ void devlink_fmsg_dump_skb(struct devlink_fmsg *fmsg, const struct sk_buff *skb)
 			 has_trans ? skb_network_header_len(skb) : -1);
 	devlink_fmsg_put(fmsg, "transport hdr",
 			 has_trans ? skb->transport_header : -1);
-	devlink_fmsg_put(fmsg, "csum", skb->csum);
+	devlink_fmsg_put(fmsg, "csum", (__force u32)skb->csum);
 	devlink_fmsg_put(fmsg, "csum_ip_summed", (u8)skb->ip_summed);
 	devlink_fmsg_put(fmsg, "csum_complete_sw", !!skb->csum_complete_sw);
 	devlink_fmsg_put(fmsg, "csum_valid", !!skb->csum_valid);
-- 
2.38.1


