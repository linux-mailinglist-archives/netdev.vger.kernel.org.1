Return-Path: <netdev+bounces-43080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B07D1541
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2840B21326
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FA5208B1;
	Fri, 20 Oct 2023 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWGUcHkl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA7C2032F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:56:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C52D5A
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697824568; x=1729360568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gxnk7yHwCdSv6SzLuCS2G3He4Fa4XDKYwaLUL51MTwg=;
  b=GWGUcHkl4K7oK8wts7nffCSssFtj6x7uutq9txy4ZN8fPRDcajifgubl
   AbVJMeQpOW7kHSXdJkMsWWBM9cVYnIV1cwZ0e6Ky0//uG/uLxNCzS2v+h
   EJHa+o2uxNeCX7IRIhVOn1ZOV1YZkNeu2LywudHj+PVR9yOhOW0Klw+ET
   zvEA8OvrqPZXcE0TXttl6C/rMc6TdzGTes3pRvBe/T72s2xBFpbggx122
   ZP1PUdMFVgrUUlklQV9pH00MEH0Jo86MXLDLIbtC3XgzKynt5v21iwy+3
   o5wA2wY+xk14adJsNiFUDhzYpQWKRuzi2R7Q1dfD10e3OCUzh6wZTZb2b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="386357489"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="386357489"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="750997533"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="750997533"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:56:07 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH next 0/2] Intel Wired LAN Driver Updates 2023-10-19 (idpf)
Date: Fri, 20 Oct 2023 10:55:58 -0700
Message-ID: <20231020175600.24412-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two fixes for the recently merged idpf driver.

Michal adds missing logic for programming the scheduling mode of completion
queues.

Pavan fixes a call trace caused by the mailbox work item not being canceled
properly if an error occurred during initialization.

Michal Kubiak (1):
  idpf: set scheduling mode for completion queue

Pavan Kumar Linga (1):
  idpf: cancel mailbox work in error path

 drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 10 ++++++++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c |  9 ++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)


base-commit: 041c3466f39d7073bbc7fb91c4e5d14170d5eb08
-- 
2.41.0


