Return-Path: <netdev+bounces-39986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE47C550C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EA71C20BAB
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21BE1F5FB;
	Wed, 11 Oct 2023 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1T5Ce36"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF41A27C
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:14:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB48F
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697030095; x=1728566095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cOOcPKe0SjI006MvdpjWkc0xtpRtNoCUue6a2fyTCos=;
  b=K1T5Ce36tjaBbyvPqXzJiLoFhCc8ueTmPsIpSUj2QlEgOGzNcvqin0SJ
   +T7dh3LXfr5f81KDWv/dA3uuMEBmBIt0dkns+vjKTrdTPynupmoSqJ+hB
   PotBj8T9H4vvNkf2Jqg+KrpErswP363wTSvt5ZG33EAE1ZEMLrW5A5qvZ
   Fhy1/ovIjevtoPyICAxjI0Fr4JkcLX27vUcYfP/wrpJPH+e2B15Y0ANV1
   SSDkZJ7G9D3XZcZPAxvXejJ9Oayx0kNagXfMbp0+aOWBxYj26qSrQb206
   8B8pgJ8yuCfWXsoH4KDayrffCS+uwN48wlDGuWxp7Nj2KMUMD4xJBR0tf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="364021490"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="364021490"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="703733879"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="703733879"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2023 06:14:43 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2F1533497A;
	Wed, 11 Oct 2023 14:14:42 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	horms@kernel.org,
	vladimir.oltean@nxp.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jdamato@fastly.com,
	d-tatianin@yandex-team.ru,
	kuba@kernel.org,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH net-next v4 0/2] ethtool: Add link mode maps for forced speeds
Date: Wed, 11 Oct 2023 15:13:46 +0200
Message-Id: <20231011131348.435353-1-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following patch set was initially a part of [1]. As the purpose of
the original series was to add the support of the new hardware to the
intel ice driver, the refactoring of advertised link modes mapping was
extracted to a new set.
The patch set adds a common mechanism for mapping Ethtool forced speeds
with Ethtool supported link modes, which can be used in drivers code.

[1] https://lore.kernel.org/netdev/20230823180633.2450617-1-pawel.chmielewski@intel.com

Changelog:
v3->v4:
Moved the macro for setting fields into the common header file

v2->v3:
Fixed whitespaces, added missing line at end of file

v1->v2:
Fixed formatting, typo, moved declaration of iterator to loop line.

Paul Greenwalt (1):
  ethtool: Add forced speed to supported link modes maps

Pawel Chmielewski (1):
  ice: Refactor finding advertised link speed

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 193 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  46 ++---
 include/linux/ethtool.h                       |  27 +++
 net/ethtool/ioctl.c                           |  13 ++
 6 files changed, 183 insertions(+), 99 deletions(-)

-- 
2.37.3


