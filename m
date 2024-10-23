Return-Path: <netdev+bounces-138159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 822EE9AC716
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F080CB21CC7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5576E1607AC;
	Wed, 23 Oct 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4+vgz6b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33FF136357;
	Wed, 23 Oct 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677273; cv=none; b=iH9SroO2q6f3qs19WNd2I6X0ROK077STKQ/hJCjlIGyg8h+s0m0HsHwASovd5Ywkp5RoQEdzSykMiOOfhEpk4EsKXcJVLvcYy1DLFqIktLDHSKxTaHwucI2YFk7/pEjOOY++Y+Afowd23cWDDirXwwPWADQk69R1c5EQdFRbL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677273; c=relaxed/simple;
	bh=nu9GAOSS/x9sYmn0ZM2+b58Z0TGVtwLfkOauMH3gYrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HAyAq4oUzjPMR3wDSs3d61NyWOREwmqe7dF2vDG1H2d2iJoNm1x9MbEc+VPVKC0+ZVXPY8JDfmTCCrV691zSI32Xqg2W0PIKegarn+t82sxwS1k0P7WmNxwwMAkqHFhlmReTxdGB+Xf17EiC1KKCm/B1FZ0ofGlhoVCxlNEgg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4+vgz6b; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729677272; x=1761213272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nu9GAOSS/x9sYmn0ZM2+b58Z0TGVtwLfkOauMH3gYrI=;
  b=n4+vgz6bhyXXStEutAqUCFhaYmg/wGVslKECStM7kzgxBPdLxZPOLtkO
   pBIg0sdtJ5udOEcRYnesRWsrSn5E6i6F/vXwckf/VStOGfI8Ye+hs3oDq
   3nwxb8uy4MqcYKKYt3TMmhkxRF/OojjWSoGB/rK36RbqF9441WCFZX+Vc
   +mLLf7lpSbXAovWQW+bcArR2yeifZ+f/xb/rmKYcpFyofWQeQ0HAw1/4e
   xLnGyj/jxkVAMugA4Yt/JHDw2vBSldrM3g412WbaE2jPsMrGAeLDmO+KD
   roBLfGZnh9NZeh//n+D1qJ+/dVleU1MJwa5xFShCLYCaiPVA5MEX7t3lc
   A==;
X-CSE-ConnectionGUID: u16ACxOgTYGqeK3xR+9vrA==
X-CSE-MsgGUID: YPGUnjW1Slm2d2O3zB8cPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54658332"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="54658332"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 02:54:30 -0700
X-CSE-ConnectionGUID: YrjIHI14TiqqUnxNvuOkSw==
X-CSE-MsgGUID: nz862BU8S+qyczgxZaIMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84771104"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 02:54:27 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3B8EB27BD9;
	Wed, 23 Oct 2024 10:54:26 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Konrad Knitter <konrad.knitter@intel.com>
Subject: [PATCH iwl-next v1 0/3] support FW Recovery Mode
Date: Wed, 23 Oct 2024 12:07:00 +0200
Message-Id: <20241023100702.12606-1-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable update of card in FW Recovery Mode

Konrad Knitter (3):
  pldmfw: selected component update
  devlink: add devl guard
  ice: support FW Recovery Mode

 .../net/ethernet/intel/ice/devlink/devlink.c  |  8 ++-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 14 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  6 +++
 drivers/net/ethernet/intel/ice/ice_lib.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 53 +++++++++++++++++++
 include/linux/pldmfw.h                        |  8 +++
 include/net/devlink.h                         |  1 +
 lib/pldmfw/pldmfw.c                           |  8 +++
 9 files changed, 97 insertions(+), 3 deletions(-)

-- 
2.38.1


