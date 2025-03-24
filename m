Return-Path: <netdev+bounces-177076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14B6A6DC0A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E2116C0FF
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5705625EFB4;
	Mon, 24 Mar 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGg1zVQw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B14C25E476
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824191; cv=none; b=QnEDgH005UZwBap0ZL3w+n3JMD7irlVf/ldJCEV/X7dQ4AJ0JBaFrfxVALQ4rVufGXy2FjDkaiybmeQ/+R8vPYVxbxFPtXL6xPUzhIa0sHzHsGmVx06Ouzgn4Yj7Aj4zD+xMxZk7aIMOOAt333fP9R2uRzx129G/PD2elWfqpJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824191; c=relaxed/simple;
	bh=jRHH3qfGBbAZx7F9b5q3n/Z7g+/ohCk78ZR+9CphUHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY/gHFPo2TDdCqwYl3+cJpoUwch4/A6tlMp3G7jBkAaKvAgch00w5zr5hpPHmBzUzAB8DyhUnGTIbHTnQ6ANwDCsWZl8uAN3qMRJxQpwursFBBP7PAGglS6jL1Fo0i2RcopS2urX9pUQ+wWjbgKRPAgFhWttCk7jNjKuns4HIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGg1zVQw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742824190; x=1774360190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jRHH3qfGBbAZx7F9b5q3n/Z7g+/ohCk78ZR+9CphUHA=;
  b=mGg1zVQw4jE081OEhJRPJndRN7WHubeaipXXdKRrBaAQi8cJU2EQkaH0
   KhCw/hqbarV2Svg4n9To4F+Gfy8JyKnISlr1xqa0IHvMCXNuuJeuVkdgP
   cm3Iun4RtqRSCCV1NA5z6BlOYTcU4Wu+V96P/dfPoWaP39i7jA2REBgkk
   +HAxhdtQJi8PK+7UutJqmmPg1FtYuz1iAoo5jPlQNNpHEwFhXS4y9ITUw
   JuWD7iz5PeYI/X+UXnTZ+VN2Z5jJ7DLs0XbxAihaEs406I5ecaPDQwxg1
   dnzHxv5OV62V4Zt6+ErBMjw8oc6zs0snpthp8Aqdz36x4sa4l+Gc/Cj3X
   Q==;
X-CSE-ConnectionGUID: Nm3jG1LwQzuqgBRS3WHvvw==
X-CSE-MsgGUID: 3rCqCo3/QUukebKDZoMcDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="44042450"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="44042450"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:49:49 -0700
X-CSE-ConnectionGUID: 21eX0LNWSfqQqopcVrOlpw==
X-CSE-MsgGUID: l9kMlYLyRxWMkDklznG6fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124572038"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.77])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:49:46 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	almasrymina@google.com,
	willemb@google.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-next 0/2] idpf: add flow steering support
Date: Mon, 24 Mar 2025 07:49:36 -0600
Message-ID: <20250324134939.253647-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic flow steering. For now, we support IPv4 and TCP/UDP only.

Ahmed Zaki (1):
  idpf: add flow steering support

Sudheer Mogilappagari (1):
  virtchnl2: add flow steering support

 drivers/net/ethernet/intel/idpf/idpf.h        |  14 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 297 +++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   6 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 104 ++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   6 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 233 +++++++++++++-
 6 files changed, 650 insertions(+), 10 deletions(-)

-- 
2.43.0


