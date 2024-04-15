Return-Path: <netdev+bounces-87940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C028A5076
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5909FB2368F
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEE913A24D;
	Mon, 15 Apr 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/0l6LWk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0168073174
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185538; cv=none; b=nPwKdIVrbAw8IyHXExreZWRiZ0jrWDyNZDtJYRvd1KRQ4tYYqGAfhiNef4reIMRzJuYjCo7VolbuAv0nstcEr2PsbydORaznvIqRSg4GnAkXhnTZZXi/POLGEOFAejstuTmzrQDc+hX6P66ZCA4BVwyabr7TdaGLgD3W1mthAWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185538; c=relaxed/simple;
	bh=APFMnIFuItwRd16mAPXH4UZOOrLZxnfCUvZBgH/GZno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E2etUiXYg2nt7CMeO2a0gRcZZ6Io6L2s4TLw8CaCUkMAwU8lObKgLUe9JOLQ3iryJ2jDY6zHUCZYlJ2cEbuxK7OUC9jRlMaI3rLQGUqu9kQ2z3HTu3NJPxaL9G/eyQaSIzpT+CX1DTjIksO3JQQ+1kkCyAXj6UN0msxCvi57ln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/0l6LWk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713185537; x=1744721537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=APFMnIFuItwRd16mAPXH4UZOOrLZxnfCUvZBgH/GZno=;
  b=B/0l6LWkDXYzioGuyiFnL/OCCh+RHJPb4mVcy+PTZAHPPs1ZBOayXXPr
   d6H49btl3Bunw0KyZP5JXH1ZzCfn8pBgNZjNBe2FSEloEw8yJs9a2iFDd
   SlrXTf3m/LL07CYzl+6SkOR76nbIEq+KLf0fzWldMTsXq7czU6A98a8xD
   d3S11/OeEXLb5Av5gGoJufx8R+rFJsV2Xs2c6pQ34dNXeMwwWGajLUB6I
   EV87nWqefSK2EsDRIyg3kyFcKEG7f1GdaCueiRAKhbucz10j9rxKRblSi
   xmuARWCa9rY9xBE8cGYzi2TBNKIEDzH3R85GRLQUt6DZpvpt3tLk/KnTu
   A==;
X-CSE-ConnectionGUID: xPLTgnZJTD+OvGri2ZvbZg==
X-CSE-MsgGUID: mL33eCCJQCSc49u+U1IkWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="11522773"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="11522773"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 05:52:16 -0700
X-CSE-ConnectionGUID: /sNlz8JKRvOTJ1lxskkiuA==
X-CSE-MsgGUID: 9xIrjSkMSvmbEnpfVhu1IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26323421"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 15 Apr 2024 05:52:15 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B330C333D9;
	Mon, 15 Apr 2024 13:52:13 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	stephen@networkplumber.org
Subject: [PATCH iproute2-next v2 0/2] PFCP support
Date: Mon, 15 Apr 2024 14:49:58 +0200
Message-Id: <20240415125000.12846-1-wojciech.drewek@intel.com>
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

 include/libnetlink.h         |   6 ++
 include/uapi/linux/pkt_cls.h |  14 ++++
 ip/iplink.c                  |   2 +-
 man/man8/ip-link.8.in        |  10 +++
 man/man8/tc-flower.8         |  11 +++
 tc/f_flower.c                | 126 +++++++++++++++++++++++++++++++++++
 6 files changed, 168 insertions(+), 1 deletion(-)

-- 
2.40.1


