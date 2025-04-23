Return-Path: <netdev+bounces-185256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B69A99872
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BC24A108B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193B28DEEF;
	Wed, 23 Apr 2025 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYajAZ+e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA828CF7C
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436442; cv=none; b=p+8zm0lGRc8QKSEn5T1m2ws5dMuvrdipYtFOrg/AbSL3X6JBOGn9WWfse45idL3kjkauUFVWXyc1hO8ZYkQGMHtAWxUn+2Dn4zztc59/lAtSvgTcfbrcqZm7vG4CLFTkQjC0WaVEgpHS949/JyonIiHhjLhEkGk9ag7UE+byDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436442; c=relaxed/simple;
	bh=+lS48aIH0nwbF+4QasdHRqhUqt/P5CrH2lo+QcxCL40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IylGzDad8Tu3ag8832ABkToxYLv1gkNkc2E7ziynYTBjf/ty9T0sU+aJd3inE+AcuzwCdd0XWEkC5T/1+q57NEIiv8ynyfe1tfWgKaFSdH8fF2Q0SARA41cNJF/9S/CZr1imAcx5lPlnrjTqDWqJT0UGkpv+oYFf+jUNuK35sbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYajAZ+e; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745436441; x=1776972441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+lS48aIH0nwbF+4QasdHRqhUqt/P5CrH2lo+QcxCL40=;
  b=lYajAZ+eWdYKnq+ZdntfQWVV7t2zpxIVZNG5KauD20slEkN+TFnOuBYy
   aOA6R0AVIkccIDEZDv00RfdLdr4NortE33MsDsBb6/2sEYKLnpTi8wZzS
   659XH98aD0fIvaOcA0kfFym+snA31iXbuqJXkvnGpG4e/L6GLT0kWeZG7
   KAwX3K8678gbe9E/KZy//9w5x3Ai1bBsncVUeclE3EXfcEBlJBm5stiMM
   gANcgRK6+mvM4kjpdWuMg7d2xkZQ/6xwZQspuWTR1d6IKgc3AltPMGs96
   AQqyDRLG/MyhE3xf/hIMfJK1dpAkXeGanhzk14YosH5n4hZkB2OcKPfJv
   g==;
X-CSE-ConnectionGUID: +Cdswjk3Qvm9dBC4ROhQYQ==
X-CSE-MsgGUID: IBhU2dANTJiNHaSXvqnOMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47176396"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47176396"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 12:27:19 -0700
X-CSE-ConnectionGUID: w07j18X9T/a5oMH/g26tOw==
X-CSE-MsgGUID: i0OOXXvwSAiaVpdaHvNv1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163442465"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 12:27:12 -0700
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
	willemb@google.com,
	pmenzel@molgen.mpg.de
Subject: [PATCH iwl-next v5 0/3] idpf: add flow steering support
Date: Wed, 23 Apr 2025 13:27:02 -0600
Message-ID: <20250423192705.1648119-1-ahmed.zaki@intel.com>
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
v5:
    - Use u32 instead of u16 for num_fsteer_fltrs (patch 3).
    - Pass OP codes to idpf_add_del_fsteer_filters() (patch 3).
    - Use u32 instead of u16 for fltr->q_index (patch 3).
    - Use ternary operator in idpf_add_flow_steer() (patch 3).

v4: - https://lore.kernel.org/netdev/20250417221239.1390721-1-ahmed.zaki@intel.com/
    - Fix some conflicts in patch 2 (after PTP series).

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
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 124 +++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   6 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 238 ++++++++++++--
 6 files changed, 660 insertions(+), 44 deletions(-)

-- 
2.43.0


