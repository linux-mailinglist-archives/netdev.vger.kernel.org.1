Return-Path: <netdev+bounces-82168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4147888C906
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC42325885
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3066613CC6B;
	Tue, 26 Mar 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7r6tDXl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483B13CC5A
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470246; cv=none; b=ta5R6NMyrtvY9Vmp18TGdvPZO0uYowwgO/GzRw8d8sdRLkXMbdJ4SpLDf9hZ3wT3sKFe+YGDEli9gog1fR+FR9n6qY8SzJEsRCOP8eItJO/FsiIVOJoItYNfLTLUUJJYwnBWWs1xEp0ZAOI6rpwoQdtLwAbOD6u5a/J9Qfu91pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470246; c=relaxed/simple;
	bh=zGiEYWMSG6C0tBk4LZS9aQfWlGMKpE3yoYfSYxu4VQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjsdmbiGiVF4XB+4A6HZatuAM3HTRXs22YRpWqAfVgQY11ehpxpBu2GXSp0JuxhFaZcmaMAbeOcnJ4vtQzLxRthyfD+DTspANTiH7OYtM4uMPod7AcEXis8TdPFoGHNUB8cQZCCWjeUbXszs3IOM7YdeY6FtGoMiUgUuaq6qjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7r6tDXl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470244; x=1743006244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zGiEYWMSG6C0tBk4LZS9aQfWlGMKpE3yoYfSYxu4VQQ=;
  b=C7r6tDXlqNareTNglfFbTA1fX74/Syi12tg0zdbpFAqqBQ7L0K3tVTv3
   gwtGMvknS4E+toP2yKpP5Sz4UcaZVBk4mfdhMqqO4UmgvUEdfVhE1GmEI
   6oVOA542oDrBdhqBp0AqB507HIH2nlr2OTsh+t2o40WDhN9rGrddMGRoc
   Xbw/v1e2aji7COintkzqb6fVuvbIqna0H6qwBKZQnNzfjGe/ZD5hV+InJ
   TAOv9dI26j6qWoWCTA7xuI9X8vasXZGBKW1irfSWt9gBMx/PwZUXI7zaz
   AvXp1+IldQJPElBt2tzq3c1th3Z7AEN4pnQYvPqxGds9+5+VJGaiiy2aj
   w==;
X-CSE-ConnectionGUID: OTYBrkzaSMmC/O8bY7tKMQ==
X-CSE-MsgGUID: BOzZmKS6QY+3SNhu6M+0Pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6471918"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6471918"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16403025"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2024 09:24:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2024-03-26 (i40e)
Date: Tue, 26 Mar 2024 09:23:41 -0700
Message-ID: <20240326162358.1224145-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to i40e driver only.

Ivan Vecera resolves an issue where descriptors could be missed when
exiting busy poll.

Aleksandr corrects counting of MAC filters to only include new or active
filters and resolves possible use of incorrect/stale 'vf' variable.

The following are changes since commit c1fd3a9433a2bf5a1c272384c2150e48d69df1a4:
  Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Aleksandr Loktionov (2):
  i40e: fix i40e_count_filters() to count only active/new filters
  i40e: fix vf may be used uninitialized in this function warning

Ivan Vecera (1):
  i40e: Enforce software interrupt during busy-poll exit

 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 13 ++-
 .../net/ethernet/intel/i40e/i40e_register.h   |  3 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 82 ++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 34 ++++----
 6 files changed, 93 insertions(+), 41 deletions(-)

-- 
2.41.0


