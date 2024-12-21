Return-Path: <netdev+bounces-153932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075CF9FA1E6
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 19:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649561674DF
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743A1779AE;
	Sat, 21 Dec 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="s23080nK"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496721632C5;
	Sat, 21 Dec 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734806585; cv=none; b=ZWQ+bGmVog5yjTOP4UsgWwj1t61bngdaHTMlCf0dmYaIis0PffEffoJRDJ9k46iHmdasuLroFJcNptHCttpKroTTTryfQLDy2Df0ob1w2T6ievzyeaOkrpM8HGnuIVNwWQRCsQ5CkbBNKHxN5MglIt5BRDVEyxACy+V2tcdFH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734806585; c=relaxed/simple;
	bh=T9muLOJOvJ0H0BWSr18/EnfoIpr+EQK8a8yrQ7hb1g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFv6gkK/ylI3ZnEoulviZ6nP9pmOThiy8ScMycdCgPO3k5dSKgqw0pYTt+ZEwLP8/yVsuEEBiriGdmxx+gr6IyhMNdXPIpWqmHxebWUKOyMvkHeCgqKtAir1IBzOLd2DgynZDv9TZhcZhOzQwTbXrOIw90JtglqvyWV+qamsHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=s23080nK; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=0TFI9S9bap1xFhpx/5Ll76o0tMhdhRDlCPMt7aUPxYw=; b=s23080nKd4BH1FKR
	no/Rjc0i+ovnSwTtsYfI986t7HOJYJT5NpOL7CYjiRUqksfkvoD88nWR3RM09XPXqHxeBK/zPTXi0
	qKMPHhPT/HqNvPTVCLrXJQr1jeVXH2hQK44dLXyrxIwZRM1YkvzJ5dKcflz0RFKHvE1h5yVTsvIV8
	eC16Nn/tnA81jluUahnnQP5+SiK9wW9QnnqWd/bE2J3FaNxu57FpzZumqz7z21mZmZ8JZxJKy163M
	lovnK0t6ajpHgw+2DjV2s/+fO4cq30JIdj5G17yVTwSIHj26j6NjXw2yEBd41T04MKDlpi4+9wFv0
	JwtrMgjxGPceGgf3zw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tP4R6-006hEJ-0K;
	Sat, 21 Dec 2024 18:42:48 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [RFC net-next 0/9] i40e deadcoding
Date: Sat, 21 Dec 2024 18:42:38 +0000
Message-ID: <20241221184247.118752-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This is a bunch of deadcoding of functions that
are entirely uncalled in the i40e driver.

  Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (9):
  i40e: Deadcode i40e_aq_*
  i40e: Remove unused i40e_blink_phy_link_led
  i40e: Remove unused i40e_(read|write)_phy_register
  i40e: Deadcode profile code
  i40e: Remove unused i40e_get_cur_guaranteed_fd_count
  i40e: Remove unused i40e_del_filter
  i40e: Remove unused i40e_commit_partition_bw_setting
  i40e: Remove unused i40e_asq_send_command_v2
  i40e: Remove unused i40e_dcb_hw_get_num_tc

 drivers/net/ethernet/intel/i40e/i40e.h        |   3 -
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  10 -
 drivers/net/ethernet/intel/i40e/i40e_common.c | 458 ------------------
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  13 -
 drivers/net/ethernet/intel/i40e/i40e_dcb.h    |   1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 124 +----
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  40 --
 7 files changed, 2 insertions(+), 647 deletions(-)

-- 
2.47.1


