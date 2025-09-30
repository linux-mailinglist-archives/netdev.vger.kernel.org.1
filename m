Return-Path: <netdev+bounces-227394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D56BAE9C1
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18F63AA0A5
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 21:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF35E29D266;
	Tue, 30 Sep 2025 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/mn4Dvd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A339246332
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267443; cv=none; b=HUwtmhwPrxr4d7/gjdarpchqGS8R3avhIXwOK6XBpwKBVZI2IhIKx+IzBrtRkDu4v1IjvQOJAGvGPyQ8pfdeNi1TwiP28RrrG06E2gOZr3JCDicJqhzfKcHGlP+hcYtPQN03s3ID2wTiWNtX53DzmSqiYY1OOCEROz5TWye/CY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267443; c=relaxed/simple;
	bh=bnqMEMYrDQ1b2tzbSz+Pwt6++N+gEZwp+C1Le/GByEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eDpcRgguG/ejBrlUhK0cQ1XBDSw82S0GBER1bVGyhwYhr3DY2ycfMMYrCzx+x2rUcJ974bn6zr6DmSOW2F6DZCwmSrXcYOU5YSALAg0Z6Mr0AsNAGNjEmu446tvfwtymKrynyqIKbEBdd2abGiG4PqZtYyeee7vZ7Opi+aHN+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/mn4Dvd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759267440; x=1790803440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bnqMEMYrDQ1b2tzbSz+Pwt6++N+gEZwp+C1Le/GByEk=;
  b=m/mn4DvdZ+Ntz0M+TPVQK5/bIjbEhPCXWLflua05HHawZxfC3GLwPpvZ
   lFBdfl7MSTj2P2i+aA4qPMbPrpHs14xLjw3aB7G1vPNp8u1smT43LYKe5
   iqxpA0G0pv1v+fGN9Am6b4IjKJk+bTSg4s9N7wLH3SSKG63ThuJjgJeSi
   Mkeb35/y9fAkpMDrvZ2l8mDLeFIc+rv2rXRlU7IZNQJbOQ6l2Mn+lsnhz
   j5cy47BFEqsryb+8DfBfjKTthEcJXvTUSl1llJEEfl+6wQZAMz9fbTp+t
   iefPUVP82ZPOlCthxlC0AzeRkM/EZ4GnSvv/Qdv5kwW8F4N6nPim9nvYR
   w==;
X-CSE-ConnectionGUID: qUwIG94XSxSgtQW36GB0ug==
X-CSE-MsgGUID: ZijThYUSQ828DCkqzQPdkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65358356"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65358356"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 14:23:59 -0700
X-CSE-ConnectionGUID: tWfmBC4DSHOjMq9YbG6TWg==
X-CSE-MsgGUID: 1osXLQLWQCeMdKbkdAiPcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="209336169"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by orviesa002.jf.intel.com with ESMTP; 30 Sep 2025 14:24:00 -0700
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: sreedevi.joshi@intel.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH v2 iwl-net 0/2] idpf: fix flow steering issues
Date: Tue, 30 Sep 2025 16:23:50 -0500
Message-Id: <20250930212352.2263907-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some issues in the recently added idpf flow steering
logic that cause ethtool functionality problems and memory
leak.

This series addresses:
- Memory leaks during module removal with active flow rules
- ethtool -n display errors due to incomplete flow spec storage
- Add logic to detect and reject duplicate filter entries at the same
  location

Changes:

v2:
 * patch2
	Update commit message to add details of improved validation
	sequence. (Simon Horman)

Thanks
Sreedevi


Erik Gabriel Carrillo (1):
  idpf: fix issue with ethtool -n command display

Sreedevi Joshi (1):
  idpf: fix memory leak of flow steer list on rmmod

 drivers/net/ethernet/intel/idpf/idpf.h        |  5 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 72 +++++++++++++------
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 28 +++++++-
 3 files changed, 80 insertions(+), 25 deletions(-)

-- 
2.25.1


