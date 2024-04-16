Return-Path: <netdev+bounces-88466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842AC8A757B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F826281046
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF40139D04;
	Tue, 16 Apr 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0XhIJQA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23C2AE91
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299055; cv=none; b=uAozl1cqL+WzACgXlkvwqoaEz9ntnuHyyoNrl2R7Wjd7RMbSTN8vNfvLHd/fQJCJxN9gY0z3nmm6fgtUbU+yo+8zYlkUnrV/9dQwa4cTcciil3409rN5qq0E5V6XBRD+0Y3XJlYzxagj7ta7CMy4d+9ubU6HhKZ///HRdA7+uRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299055; c=relaxed/simple;
	bh=DEoA+CURLyCpXOL7v77u0P9G8o8JQPmfAcMupKHxQFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c69ytP4f3/yvpzBoHG5ugbcA+Jzp9mBU1+NW6Lk0XcusiWUcoAVcMJfgVmga+H2GFgDrm6fC8esh7j2ZalagUm6Kh8Si/+CuWHqn/ghBi07gurxyvWvE1t8qV+gpRzCu58ylC0JIXv3bNVK3ux5ceb9c8SeELt8ssLuNJK/iepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0XhIJQA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713299053; x=1744835053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DEoA+CURLyCpXOL7v77u0P9G8o8JQPmfAcMupKHxQFc=;
  b=I0XhIJQAvd7TIaLwW6S8aQ7SULVDSKXCBcosSB8jwovd+aAFmY3J1qgj
   m4XZxtbo8jZjgLs+tR2Lw68xFG1EkbQ+FCX3jwjEsCSOwbcFPHGl2x/hv
   eaF54eE7D2NatHYdZFrT7bH81/3tRXgeWAEzd3WUmAwMv/KcCcAfbFrFo
   4apurwTT+WzqbiCEYj2RhBKN6xyswtB60Ls/a3FVfBfw6r+u7DCjprQvS
   3SxQE9ZmZPjBIqpQi7TVZF+QgTpFcKuMy6aU+qwqYDq5Hhyn5QDSTJqRn
   zqYUKHxw9YPYb5o8REUddEbRLJrWI7zhtpaaRugyPaKA6m4Ts+mxQxMAo
   w==;
X-CSE-ConnectionGUID: qTXbUM9fTduBqgZNqEi/Ng==
X-CSE-MsgGUID: gwVsdGd4Tm2aNs3bXw91zQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8688445"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8688445"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:24:12 -0700
X-CSE-ConnectionGUID: L8Ie8bP/T5+obbORfiSjYw==
X-CSE-MsgGUID: N288vf7PTK+QX2WXMBeYsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26941866"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 16 Apr 2024 13:24:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2024-04-16 (ice)
Date: Tue, 16 Apr 2024 13:24:05 -0700
Message-ID: <20240416202409.2008383-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Michal fixes a couple of issues with TC filter parsing; always add match
for src_vsi and remove flag check that could prevent addition of valid
filters.

Marcin adds additional checks for unsupported flower filters.

The following are changes since commit e226eade8f50cda14a353f13777709797c21abf8:
  Merge branch 'net-stmmac-fix-mac-capabilities-procedure'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Marcin Szycik (1):
  ice: Fix checking for unsupported keys on non-tunnel device

Michal Swiatkowski (2):
  ice: tc: check src_vsi in case of traffic from VF
  ice: tc: allow zero flags in parsing tc flower

 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.41.0


