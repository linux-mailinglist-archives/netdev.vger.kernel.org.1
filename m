Return-Path: <netdev+bounces-183943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF10A92D22
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17B03B3A80
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 22:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB4211460;
	Thu, 17 Apr 2025 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcyLfntF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC311E5B79
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927975; cv=none; b=pStjH2gkk0mdxUmWQFK9Q0cAnC7AcXn8ZyXhk/iRzIFD++wQXBzQx8IVOwD2CcgiVHX67E4QZq5jf0HoMNjKpPGxF3yjbPP7LXpHpSRMqTmC1FFKwGGPmox81dFayZgh+0hDyLEN7ZfDfGDcvO6RxtcWX3R+tVvAzPa2uwILGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927975; c=relaxed/simple;
	bh=h2uAEIodaUhnv30mkKugk8vncU08GSVmuJvKDRPya5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQlLkADP/ViRBh9N1NS9hQD0cSpKizs8ddMKTRHG3uQq4WYlYQfKn5p5GMtYablJhOu25WDCQfsLx/BY/nQNOQtjutF6QoicJ8rEUXkMJUzQnU+ZKX7/XcfrOktG3tH0jqw/LFEuLQVbzCAjCRWR/i2l+XtvbYhSmnnujGpnsqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcyLfntF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744927973; x=1776463973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h2uAEIodaUhnv30mkKugk8vncU08GSVmuJvKDRPya5s=;
  b=gcyLfntFLq48qWOrBuMZqOQPWXJkZCUiqlsbpkOZgmIzoqhAYRKCA/kL
   9YjOUiFx7i9slHgGSi+6ncsONuaH0K5DYHqC/LnVzA7nefV1Gyi+FEA3s
   YIl+HZXaNAAeKhclNTJQvUPbokRa7cnKejg5+e/vCME1rZbNQf/7GcIsg
   ZWWs9b4qLt1MDsE4FP7tY/DHnb/co2iue+pdt/w6lM50/iVUrAkKTQjKf
   Z5OMmw4uwZMzvDJnAjvFNZNt8Uq9BNgqN+M8ePOHmaiHRKDXFlhML0V+A
   uNO/07g0qdBhy7AK2xoeaF/kGSr+rTOucbpOhJRoye+1xRuadElUDIW0S
   Q==;
X-CSE-ConnectionGUID: uMiXaaZJQ1yRfHjd6MGUwg==
X-CSE-MsgGUID: jtffAMnaR5+9NMcIznN2hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="34168283"
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="34168283"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 15:12:52 -0700
X-CSE-ConnectionGUID: zpbTKG0FTyqjlMcL/gD/yg==
X-CSE-MsgGUID: lWjgCFG7SCKZP+C7IV6VFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="168148920"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.110.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 15:12:47 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	ahmed.zaki@intel.com,
	sridhar.samudrala@intel.com,
	aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com,
	dinesh.kumar@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	almasrymina@google.com,
	willemb@google.com
Subject: [PATCH iwl-next v4 0/3] idpf: add flow steering support
Date: Thu, 17 Apr 2025 16:12:35 -0600
Message-ID: <20250417221239.1390721-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic flow steering. For now, we support IPv4 and TCP/UDP only.

Patch 1 renames "enum virtchnl2_cap_rss" to a more generic "enum 
virtchnl2_flow_types" that can be used with RSS and flow steering.

Patch 2 adds the required flow steering virtchnl2 OP codes and patch 3
adds the required flow steering ethtool ntuple ops to the idpf driver.
---
v4: - Fix some conflicts in patch 2 (after PTP series).

v3: - https://lore.kernel.org/netdev/20250409205655.1039865-1-ahmed.zaki@intel.com/
    - Fix sparse errors in patch 3 (Tony).

v2: - https://lore.kernel.org/netdev/20250407191017.944214-1-ahmed.zaki@intel.com/
    - Rename "enum virtchnl2_cap_rss" to virtchnl2_flow_types in
      a separate patch (Patch 1).
    - Change comments of freed BIT(6, 13) in patch 2 (Tony).
    - Remove extra lines before VIRTCHNL2_CHECK_STRUCT_LEN (this makes
      checkpatch complaints, but Tony believes this is preferred.
    - Expand commit of patch 3 (Sridhar).
    - Fix lkp build error (patch 3).
    - Move 'include "idpf_virtchnl.h"' from idpf.h to idpf_ethtool.c
      (patch 3) (Olek).
    - Expand the cover letter text (Olek).
    - Fix kdocs warnings.

v1:
    - https://lore.kernel.org/netdev/20250324134939.253647-1-ahmed.zaki@intel.com/

Ahmed Zaki (2):
  virtchnl2: rename enum virtchnl2_cap_rss
  idpf: add flow steering support

Sudheer Mogilappagari (1):
  virtchnl2: add flow steering support

 drivers/net/ethernet/intel/idpf/idpf.h        |  33 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 298 +++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   5 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 120 ++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   6 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 238 ++++++++++++--
 6 files changed, 656 insertions(+), 44 deletions(-)

-- 
2.43.0


