Return-Path: <netdev+bounces-154795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030CB9FFCE3
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32761629C0
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEDD1B6CF3;
	Thu,  2 Jan 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="nDgK2uur"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB21B4241;
	Thu,  2 Jan 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839466; cv=none; b=AQOnueaWjsbplqgxoKc1sPc8a6HqAit/f6UDIUK7T+0yQf7CbWa9CJje/VWRIb+4SazD2YDHWEehiRAGMprL2X1T3eMXRhXpGOGR31N5XXgXuK5CBCZJLr1tBHjp9rt0tW9fttEMdJds8knnvniooXdyT89+KuYmFxSRxa4mKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839466; c=relaxed/simple;
	bh=j/gKmgjEpP6k6X7PI8kZeQemP5CzhOyL5lQAFWPfTq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShV4nxZurkgqe/emn2w9PK0v2KANt3DDMBYPjW6WjAcPF7p10VRnOYQXbUX5WAZQYS2N35BXYqPAbtOEXuJP7yQ7hmnxx2TZPTLNDXNMb2DJuKY+nSJwEKBpc2KRm3WFFY490hkVyCayOLrir610UcYRJOuPRBl9S3O0fcgonlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=nDgK2uur; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=BLfWDy6Mh+x3ZLFoG1A6rUjcWBV6etcehzoDQyHhNU8=; b=nDgK2uurZqxVHz5x
	3CvPflLhVQz+M1MFUzqJz2hn12t3tKV2YdnrK2RVnU/TbcoWSEJL7cgZpFBfCsFSq5yP21zWRh28l
	QTxdRn4MktBgXY31aHcjS/dkm6fDupLD11wl/uHPU7Hp9NR/m7d8bG7e2b9kPDwXDLWpC4BZ7lT6A
	Rf67JN/+MGNRc/jKYO46dTflT+REeLp2QZeVyzfjZYPoZWp2APOSSMam7SG/Cos911ZT27Up8TY5G
	0hibNenYnktmXpsmlhvXjSSs1C3n+POUiQ4yQyeLpERURUYmSVN/X9zYXiqA+96AgX0Tfmer7a00i
	HpJAJZOFVbRvqWx1oQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTP8K-007tod-0q;
	Thu, 02 Jan 2025 17:37:20 +0000
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
Subject: [PATCH net-next 0/9] i40e deadcoding
Date: Thu,  2 Jan 2025 17:37:08 +0000
Message-ID: <20250102173717.200359-1-linux@treblig.org>
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
(Resend now that netdev has woken up)

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


