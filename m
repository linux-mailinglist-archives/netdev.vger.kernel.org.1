Return-Path: <netdev+bounces-43671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399957D430D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FD6281630
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529FD24219;
	Mon, 23 Oct 2023 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mI5N6DJ2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C987241F7
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:08:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1325D78
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698102514; x=1729638514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pw1ZnF72Me48TVIKXe7j+LVtPvRbpBoOzpcTk/x3OI4=;
  b=mI5N6DJ2vu3uSGz/JpfpkRp2JsBycPgt0B774TmzSsWdzioRNMFdleFp
   aIxjY9URJlq7vf7icBS7kc4AgIdd4TdxMAeecvLZbhgVCAf92ZGVN58eF
   TJ+CZHXo4TjMWPztLdbyyAlJAtz8rkyFBmxwkqtFdZP5sSyT3yWo6s6Sa
   QZu92QrthkBnhz4ZLTl5UJr0K2ZlQCLRvmY4P6jNt5v0uUdjLgTANIm4I
   kddbgGHg3ChFZ7DdzcgQg+SlD/Rc06Eaa/AdeZ5/28rgPJxkbX0uJ2dZg
   ZSAQ64/JS5LZtJfChbeYwJWsloewQu18Bug6SrU/7dVF4kKJfaJfvoj83
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5573700"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5573700"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793288323"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793288323"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 2/9] iavf: simplify mutex_trylock+sleep loops
Date: Mon, 23 Oct 2023 16:08:19 -0700
Message-ID: <20231023230826.531858-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023230826.531858-1-jacob.e.keller@intel.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

This pattern appears in two places in the iavf source code:
  while (!mutex_trylock(...))
      usleep_range(...);

That's just mutex_lock with extra steps.
The pattern is a leftover from when iavf used bit flags instead of
mutexes for locking. Commit 5ac49f3c2702 ("iavf: use mutexes for locking
of critical sections") replaced test_and_set_bit with !mutex_trylock,
preserving the pattern.

Simplify it to mutex_lock.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8bfa928ab415..da9cd53afc24 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3011,8 +3011,7 @@ static void iavf_reset_task(struct work_struct *work)
 		return;
 	}
 
-	while (!mutex_trylock(&adapter->client_lock))
-		usleep_range(500, 1000);
+	mutex_lock(&adapter->client_lock);
 	if (CLIENT_ENABLED(adapter)) {
 		adapter->flags &= ~(IAVF_FLAG_CLIENT_NEEDS_OPEN |
 				    IAVF_FLAG_CLIENT_NEEDS_CLOSE |
@@ -5064,8 +5063,7 @@ static int __maybe_unused iavf_suspend(struct device *dev_d)
 
 	netif_device_detach(netdev);
 
-	while (!mutex_trylock(&adapter->crit_lock))
-		usleep_range(500, 1000);
+	mutex_lock(&adapter->crit_lock);
 
 	if (netif_running(netdev)) {
 		rtnl_lock();
-- 
2.41.0


