Return-Path: <netdev+bounces-143461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E99C28A5
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 01:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604561C20EF9
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 00:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076081E;
	Sat,  9 Nov 2024 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4j0WWfd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271138B
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111138; cv=none; b=FdlHLv0isf/WDQB3y3+hzxTQ0pVRrZq5Q93n3w7IHH32u3rvo4zA1EPT9Q3vnLkaymRstPcEl45ycVd72QY6EdUSyQoUJKcy/vdZucng3BQyJXeoTS5kzWb2Zw0RCEw10zDJuWZQAK1PZ5lE78kcGWnk/AwlNZc1sNYJGGpXj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111138; c=relaxed/simple;
	bh=AjITPXx4oPzInPimR27fMUr+z7wdtMLtKa2dw61+mdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAmhQeYjugj1RydcCWBff/XFE3BjH7jlJcKbEfwljWHBi4fHcVjzMqJGOS9QlDxhcKQ0pb5z01cxVsbbwy5Q2eZ5GWqRjPZicc1xh3WjSF7kGgjEdueT41NL1hKE+MF8mpRswYelKUPIAFr8zlYTS/ykhiUShW/mdlWyhljxcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4j0WWfd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731111136; x=1762647136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AjITPXx4oPzInPimR27fMUr+z7wdtMLtKa2dw61+mdE=;
  b=J4j0WWfdsaiP2AU9tGoCt1JMLX05NMWscwYUfRTgYd1QnzdlYUFcFliD
   ViFP/KRILFTMuneBcWM3Jml14+UjHn7xcHnUwCWPyZHIfWn+I0v/2Pj/7
   xCyT0IdQLEf/vA5/rL98OsZ+Xqhb/FeJDdurQvbLl3RByNKR6G4YcouVB
   9Ys47prZl9KzcLZbc0wHb2qJWnk9Se4g+NbVK9pEc8WXnRpqIyvWoEpfL
   4bREzm88NbGgYwyT0zKD19OFf5scTWSw35ZnBoxFW3gnJ5srTAD2fcwnL
   PKg2bT63sfwLHCCCjbbsQLFD2WXm+9/eCasPfoxVPwvsSPght4kkgAqXg
   Q==;
X-CSE-ConnectionGUID: +vruqwJeRA+h0YFSup9zSg==
X-CSE-MsgGUID: 5k45aNDPTqaupphKkp7rbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="34795114"
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="34795114"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 16:12:15 -0800
X-CSE-ConnectionGUID: cMNijbVZTEazeUYG85+Srw==
X-CSE-MsgGUID: IdRgU1DMSK6/rv0GppaE7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="90905914"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.245.163])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 16:12:14 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-net 0/2] idpf: Preserve IRQ affinity and sync IRQ
Date: Fri,  8 Nov 2024 17:12:04 -0700
Message-ID: <20241109001206.213581-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the IRQ affinity settings fallback to defaults when interface
goes through a soft reset. Use irq_set_affinity_notifier() callbacks to
fix it. Also, wait for pending IRQ handler before interrupt configuration
is removed.

Sudheer Mogilappagari (2):
  idpf: preserve IRQ affinity settings across resets
  idpf: finish pending IRQ handling before freeing interrupt

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 36 +++++++++++++++++++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 +++-
 2 files changed, 39 insertions(+), 3 deletions(-)

-- 
2.43.0


