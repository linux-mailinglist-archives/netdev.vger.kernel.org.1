Return-Path: <netdev+bounces-43636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8047D40DF
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC130281339
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0223742;
	Mon, 23 Oct 2023 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLQf/Ik2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB563C0
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 20:27:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7974ED7B
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698092826; x=1729628826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uWXkS1osewUgCluvbeMqun+oByKj+V9qtt1qUITjiy0=;
  b=eLQf/Ik2U9O2dHGllY4vE/icyzVpdvwvD+ljSBtJwRN9cnlR6T1DQEMp
   GWXRJGVG1LT9JDTdQ6PPxXWTSYS3WIYyI5FS7jwcfihXy1foEwxYsfvd9
   GOIzDq1tvwUMqOMH/Ps6I4CCgopiZ0lyg50ryOtDeuJVKOnly4tyUwzJO
   xD7+8mlFltXpcT8uyCgL5bkXJRNJ3JSc38ghwBRDkXjkHxnGjLzXil3QZ
   6P/k/RpMsIPLuTDzwmYmaxaV7WaZtF9WzyPtRghyq4THdjDcgh5V2VWAV
   dm6ikZRaebmibsBLf3O7q8vkwPiN7MPCSPrp2QmQ+nUeAnM0g/BOC8rSQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386732571"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386732571"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 13:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="874813960"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="874813960"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 13:27:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 0/2] Intel Wired LAN Driver Updates 2023-10-19 (idpf)
Date: Mon, 23 Oct 2023 13:26:53 -0700
Message-ID: <20231023202655.173369-1-jacob.e.keller@intel.com>
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

Changes since v1:
* Corrected subject line

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


