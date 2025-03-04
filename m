Return-Path: <netdev+bounces-171591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12CDA4DBE6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9304D7A85EE
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65A1FF7B0;
	Tue,  4 Mar 2025 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/ucTgPC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1611FF1D1
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086541; cv=none; b=c9D2ETC48NvTDQ/hDXTUt/UvvEQ9aiAdo2bV65MJk02QVwhtTfbGVIzTB8+E5dlP+zy7NEUE14kRVl/vu+DndNPTL2kJPGwCY/ncl1+HjnVCtw7EMOOKcPc/CKNYDdj8j4L8LaUJ2owdGW0xV0eAdUD81enx0GbFluGmmzpAFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086541; c=relaxed/simple;
	bh=lQt0v6clScT8tF7sJdLeACojniDkejJ4n7Vxm1H0j/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOySXhimyPo16gj3a5V+Mj99gFo0zO2f3H46rnSa81UEKiENDSXUVg8ipfv4VBqn3tRKxTvQrBl/6ZmvzubrK1fOTnlAnEcTZ80KrnmIXuScpnlH9ilAEVm++SvLRdqcMEX1D9jZr7/cxiWs2+O1FKoG0Z/Bk/8FGprklPoAYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/ucTgPC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741086540; x=1772622540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lQt0v6clScT8tF7sJdLeACojniDkejJ4n7Vxm1H0j/A=;
  b=T/ucTgPC88e8Kqf+YDXBx3zH6ZfvIl0OtSESLBpusXkUFRWpg8eQE3RU
   ghrWMDhXX6fdTat2RXrY/D4aCma/HUFM1aB1+z2BfiC/wj1h87o35I8a5
   eojuns/fMQexBJZLs7Icg5hw+VOxByUjxobSWBWie0iMK8Gsyt2f6P+KW
   wocSzwLHxlAjj5SK3gW3mClXGncijh5nAZbZYyT4q/+HrPLGD1Odl83IS
   8uZ4vakG1drIOVZGV60bmpEPqRc8WwT9FxhVzS6enUgxSMLMLCQoo2y4e
   kcR5ak9Zue+JJdIrCzGTnPdFS+o67fzgEzCc+vj1GbBinP7WoE0KgAa3z
   g==;
X-CSE-ConnectionGUID: e1SK+HjnRZqaPCsRJhMpRg==
X-CSE-MsgGUID: geVFsc86RYupUgSPSU4Plg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41246992"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41246992"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:08:59 -0800
X-CSE-ConnectionGUID: /ALizo0SSiKC8ACjARWuBw==
X-CSE-MsgGUID: LC90gxo2QvuMEo3ya4TWUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118341235"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa007.fm.intel.com with ESMTP; 04 Mar 2025 03:08:59 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net v3 0/5] ice: fix validation issues in virtchnl parameters
Date: Tue,  4 Mar 2025 12:08:29 +0100
Message-ID: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses validation issues in the virtchnl interface
of the ice driver. These fixes correct improper value checking,
ensuring that the driver can properly handle and reject invalid inputs
from potentially malicious VFs. By fixing validation mechanisms,
these patches strictly enforce existing constraints to prevent
out-of-bounds scenarios, making the system more robust against incorrect
or unexpected data.

---

v3 -> v2:
removed redundant check and fixed kfree being called on uninitialized var in 5. patch

v2 -> v1:
attached Mateusz's related patch
rephrase some commit messages to indicate that this are fixes and should target net

--- 

Jan Glaza (3):
  virtchnl: make proto and filter action count unsigned
  ice: stop truncating queue ids when checking
  ice: validate queue quanta parameters to prevent OOB access

Lukasz Czapnik (1):
  ice: fix input validation for virtchnl BW

Mateusz Polchlopek (1):
  ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()

 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 39 +++++++++++++++----
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 24 +++++++-----
 include/linux/avf/virtchnl.h                  |  4 +-
 3 files changed, 48 insertions(+), 19 deletions(-)

-- 
2.47.0


