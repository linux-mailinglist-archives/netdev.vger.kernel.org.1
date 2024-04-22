Return-Path: <netdev+bounces-90091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9AF8ACC78
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 14:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADF7B22069
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB39146D53;
	Mon, 22 Apr 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+QfU1Uw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C11524A0
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787704; cv=none; b=LRO6vAmZXJrzJc+j7dXWWg+45SDN1aFHl4c4LZFEk1xwN1+hG3i0Yejbtx7bHNnzyBh560TAroA7zFzBMxrmjJFkq9n7rSRhWshlPUT/QCQcSKRT/SPwMmduPyFKYSndBPH/TqPIOKrQzRUf4i82fEGPMsJeJ9ugzDsShAApghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787704; c=relaxed/simple;
	bh=87rbLq9QwjxpILT7ANi5vyalHCKR5XSzhNYgA9GAXaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oHavUAY8sdYUgxhVUHGqX2pSWVcC/T1rwt4gWIUZ8Loz4VSYKUUIc9o0s6kekN1QNfIqUjZ7DFDrDLRrhclb0QFZ/UU2FdLt8cLIwh1ddv/BHHJQM9BGLV4lktljurHr8raELyXjbIN2MHtGKoneY6Sjns8+iUJuz7i8pO5D01Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+QfU1Uw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713787703; x=1745323703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=87rbLq9QwjxpILT7ANi5vyalHCKR5XSzhNYgA9GAXaM=;
  b=c+QfU1UwAKuepZfUj4BgLzaGkxqj7A9Zs9A+GE6s8QrhnPnNWSr3cK26
   gieQvfkRC6EZbZuS0leZa8pK/PyydYPy9qkHlFNAMglIoYaI+h3920LpY
   h/Zp4PZEWGX0EENSuv6zzktTVmAEublUfLw7t0Q3KeMd5OgtZUFYHCBqg
   Nli/jp3v1/ix5Wu2iEGr82h/cmS2DJ2gKrZR64zCAuPQoLhCHfgtGD4bk
   i0xCH+v3AxUGZG0klAwuwUfstDU35iubPR1EFAD52+dZCxQraVBGxnWVf
   bRosAAj1h2yTh8RaoCLHti9eUNHixDOZHPGhP1vLIY0O4GzglHZjpK76s
   A==;
X-CSE-ConnectionGUID: wF2TJgbzQAePtnvpLUzpgQ==
X-CSE-MsgGUID: 3aSwXIOJTx6pmXMWLHRU5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9147819"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9147819"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:08:22 -0700
X-CSE-ConnectionGUID: yyGBW1IERdq1DnvmgXMfSg==
X-CSE-MsgGUID: nT6MRLU6SUu4mSn4veHhXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="54926262"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 22 Apr 2024 05:08:21 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4E22C2878A;
	Mon, 22 Apr 2024 13:08:15 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	stephen@networkplumber.org
Subject: [PATCH iproute2-next v3 0/2] PFCP support
Date: Mon, 22 Apr 2024 14:05:49 +0200
Message-Id: <20240422120551.4616-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New PFCP module was accepted in the kernel together with cls_flower
changes which allow to filter the packets using PFCP specific fields [1].
Packet Forwarding Control Protocol is a 3GPP Protocol defined in
TS 29.244 [2].

Extended ip link with the support for the new PFCP device.
Add pfcp_opts support in tc-flower.

[1] https://lore.kernel.org/netdev/171196563119.11638.12210788830829801735.git-patchwork-notify@kernel.org/
[2] https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3111

Michal Swiatkowski (1):
  f_flower: implement pfcp opts

Wojciech Drewek (1):
  ip: PFCP device support

 include/libnetlink.h  |   6 ++
 ip/iplink.c           |   2 +-
 man/man8/ip-link.8.in |  10 ++++
 man/man8/tc-flower.8  |  11 ++++
 tc/f_flower.c         | 133 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 161 insertions(+), 1 deletion(-)

-- 
2.40.1


