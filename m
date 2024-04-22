Return-Path: <netdev+bounces-90092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568898ACC79
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 14:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885271C21099
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447E01474A7;
	Mon, 22 Apr 2024 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbx6PaKK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59242524A0
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787709; cv=none; b=XoZJ8dAVp2lDfggzvmrtLOiYCyxsmPoILz+LuyYptPwGRfh3rbtdgz2C21OCW4DC2TiB6owhLoBnSe1QoOsYIK+cOSXKRTxlqzLHe8AqF8ljbCTDKAcnc/TQu4kiYXTGTXpMUR8A9bqhQ3PzqrDVKaCeS99W/6rTGfpVnUFRFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787709; c=relaxed/simple;
	bh=onGADuFgtLcbZzs3I3zJj9+P7uL0Icr7dBA5cxPShQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6GrXTjA91N/sMKaYduo6X5pQ6aBk/2kuchEjhrHL1uMrIZUs+TScBUGmo8XWe/7/zVrlaUxoHIYB0A37roAEJHYhLiWVvdubIJZ0iS6sYgMhI3gHQcvW1fSvFuximacL5l2rL3cs8TgC+ZMCiuHf0UTbRn1XGGvC4JEvzOPTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbx6PaKK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713787708; x=1745323708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=onGADuFgtLcbZzs3I3zJj9+P7uL0Icr7dBA5cxPShQk=;
  b=jbx6PaKKtbumSoMaix7GkWWmc140k6XwEfY0qCSdS5rmwgg6yL2nGjuw
   jL++txPCiZT+B995+fRA89c53+11XurLBmnbVXURebKbdnn6PIbUzVzDL
   JT8hdSv+glTlLyGem/W60sHPtN5WQ3bEPn614GYxdbqolANJAKdBwHqwt
   fQfcqIGQ9+srNzzYcR/o6/xEgWMUrbrWraUI8agPaBPuy23nIAVuAAECC
   ByE2wlGUgg9DK9tboJVOBQYpHUnZ7K253Q/7vc4xWcmWi42seymtda0Uo
   9RnK9wveG7KRib6QMlqBgQPi+U57rsvlDjbIaYwtgV71fwCkkJ6TUWVls
   w==;
X-CSE-ConnectionGUID: iM8wOMjBSVe+h4/Bvos2xQ==
X-CSE-MsgGUID: fYM3bxA4Q3GrIJC1TZLT7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9147823"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9147823"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:08:28 -0700
X-CSE-ConnectionGUID: SLtzgl8qT1an5+WhLmu/mg==
X-CSE-MsgGUID: pPyXM513Sg+OrjtchvIsug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="54926278"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 22 Apr 2024 05:08:26 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A9F9C2878B;
	Mon, 22 Apr 2024 13:08:17 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	stephen@networkplumber.org
Subject: [PATCH iproute2-next v3 1/2] ip: PFCP device support
Date: Mon, 22 Apr 2024 14:05:50 +0200
Message-Id: <20240422120551.4616-2-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240422120551.4616-1-wojciech.drewek@intel.com>
References: <20240422120551.4616-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packet Forwarding Control Protocol is a 3GPP Protocol defined in
TS 29.244 [1]. Add support for PFCP device type in ip link.
It is capable of receiving PFCP messages and extracting its
metadata (session ID).

Its only purpose is to be used together with tc flower to create
SW/HW filters.

PFCP module does not take any netlink attributes so there is no
need to parse any args. Add new sections to the man to let the
user know about new device type.

[1] https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3111

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 ip/iplink.c           |  2 +-
 man/man8/ip-link.8.in | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 1bb4a99863b0..96f294a23752 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -44,7 +44,7 @@ void iplink_types_usage(void)
 		"          ip6erspan | ip6gre | ip6gretap | ip6tnl |\n"
 		"          ipip | ipoib | ipvlan | ipvtap |\n"
 		"          macsec | macvlan | macvtap | netdevsim |\n"
-		"          netkit | nlmon | rmnet | sit | team | team_slave |\n"
+		"          netkit | nlmon | pfcp | rmnet | sit | team | team_slave |\n"
 		"          vcan | veth | vlan | vrf | vti | vxcan | vxlan | wwan |\n"
 		"          xfrm | virt_wifi }\n");
 }
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 066ad874eb0d..b981ac9125fa 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -250,6 +250,7 @@ ip-link \- network device configuration
 .BR netdevsim " |"
 .BR netkit " |"
 .BR nlmon " |"
+.BR pfcp " |"
 .BR rmnet " |"
 .BR sit " |"
 .BR vcan " | "
@@ -392,6 +393,9 @@ Link types:
 .BR nlmon
 - Netlink monitoring device
 .sp
+.BR pfcp
+- Packet Forwarding Control Protocol device
+.sp
 .BR rmnet
 - Qualcomm rmnet device
 .sp
@@ -2125,6 +2129,12 @@ the following additional arguments are supported:
 .BI restart_count " RESTART_COUNT "
 - GTP instance restart counter
 
+.TP
+PFCP Type Support
+For a link of type
+.I PFCP
+no additional arguments are supported
+
 .in -8
 
 .SS ip link delete - delete virtual link
-- 
2.40.1


