Return-Path: <netdev+bounces-87941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5258A5077
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198631C22616
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB97EEFF;
	Mon, 15 Apr 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkAaplvb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111437EF06
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185543; cv=none; b=W6R9fCpZCw+A5CK3mq6jYeo4dGQdmarm5kjcWxv2ucX85oxQs5zn8pJQl139D1Fb9kNUhEhopsQiphJGOnia3VwCN8DdP9taEJqNk8ZCrw7FVtC56rQLvulMvy5Xl4t/rIP7kCxv62+aLWcKyem6AojFNUGKLTuy4TjwiCA60hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185543; c=relaxed/simple;
	bh=Emv197oZZubA8i7fvG/gSOa6wosW9h3Mu7jf+DBoOQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h/L0IupxCBzVNOI6CK7iPC/g1z1nVOx9fydU6L4ESE+hXs6KwqAfVDTGQGgdgvnOd1Av+hWkhJyCGOrx1wjRF/jkOuCGx/iAl9l99GuGqcIrmdW+njswn+Msa8hm0IjM3nzFl7jxqyKNhFDdJsiMjqZXkViFuiHlNjA2TccLrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkAaplvb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713185542; x=1744721542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Emv197oZZubA8i7fvG/gSOa6wosW9h3Mu7jf+DBoOQo=;
  b=mkAaplvbrkoq8yWg36+b8Z03E/NMbhTrW1AGYX4C2sWPdKyzZ4XZfjJn
   L464hQw3KeJUeHRhD8VmNHu1J2Hbtd+gP5hXUKOcJnis2pl+xn1WdMvot
   LtZoLQMp7Q4fDkc9vOue3qQHkpGvK6inXytF+1Kw9a8tqBjd0E7lEkjxn
   XLTbwvBFkJ92j3bHT1/E3BiSwQA1+cM2qAC11cf0bTv6OBIkD8ac/ERtd
   3hrKWyPXFCFepjiie7LNv5Dvi6jCQI229UEMczwYuxzg8DRUyfjUkg9vH
   AysvoI078Dc0smmuxC3RqmJcn+itNI9zxV6Glp+hQ0WhpH1LbNoEy5uAL
   Q==;
X-CSE-ConnectionGUID: gGBWuW7QS96KedfRiNvMsw==
X-CSE-MsgGUID: yzwJGgwRQueiCmMZyDXfKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="11522777"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="11522777"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 05:52:21 -0700
X-CSE-ConnectionGUID: uPcqQjFmTEOApTh/R5pd9A==
X-CSE-MsgGUID: CHota4ySSfWteOTn1Lhbqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26323469"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 15 Apr 2024 05:52:21 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4E51B333DA;
	Mon, 15 Apr 2024 13:52:14 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	stephen@networkplumber.org
Subject: [PATCH iproute2-next v2 1/2] ip: PFCP device support
Date: Mon, 15 Apr 2024 14:49:59 +0200
Message-Id: <20240415125000.12846-2-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415125000.12846-1-wojciech.drewek@intel.com>
References: <20240415125000.12846-1-wojciech.drewek@intel.com>
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
index 95314af5ab1c..73d4cd428047 100644
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
index 31e2d7f0f5b8..2654f8c361ae 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -249,6 +249,7 @@ ip-link \- network device configuration
 .BR netdevsim " |"
 .BR netkit " |"
 .BR nlmon " |"
+.BR pfcp " |"
 .BR rmnet " |"
 .BR sit " |"
 .BR vcan " | "
@@ -391,6 +392,9 @@ Link types:
 .BR nlmon
 - Netlink monitoring device
 .sp
+.BR pfcp
+- Packet Forwarding Control Protocol device
+.sp
 .BR rmnet
 - Qualcomm rmnet device
 .sp
@@ -2124,6 +2128,12 @@ the following additional arguments are supported:
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


