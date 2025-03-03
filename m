Return-Path: <netdev+bounces-171223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01EFA4C023
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27121893530
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7070A2036EC;
	Mon,  3 Mar 2025 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StveBFuY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499F1F0E2C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004431; cv=none; b=ZgGwtcACu3rRfhI5bCvJ//jq5cD/Z3PflZi+QEJXzNIaE5ysnJVB+4PusOJxkne6iiqpqSsPsYgYPinmby+80Cr7OheHWf/+xb/qGf4GCUBbibSLsiiL2zLu8ZF6GHP3OYh9llzZbw304EYOLsUFAd36XwdYrWWaULs3bsXrWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004431; c=relaxed/simple;
	bh=kUYpmkUuMpjH5qH6TkoatDdSONJoaxi7IvJFsbgS+DE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8TVLV5ECDWp+4dIIA0rwSwUyOQ5CmQq1rJYAq2HblvAdeODh8H8cb/q/h6Jv9odZ/9j56jxOSQ8X67x+OvFImkz6EFarjqRmH2Dx02G2drn6Xt0BUVfwZImbFGS0yQMfqztxTQQG9WYPaayd/6Z674A2MEq1kZEPbjyXXD4bpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StveBFuY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741004430; x=1772540430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kUYpmkUuMpjH5qH6TkoatDdSONJoaxi7IvJFsbgS+DE=;
  b=StveBFuYMbLEZ2sErHN+rU4TmETaZTnJ/Wi1HyD/QK/demO7anHIuBXr
   jsB8W7cqAQQ2rgE2E0Gn8xpquudEnKrviX9AaAa10GQ/icCL90vvg+9zQ
   61SyhKCzqbDHAYodpe7fXRgcFUuTGmwatm0dcirFsgFFaPfDYv3McLgJu
   WLDXyoC6fgAmlpB6QgF31T3a3tlDVXwt+xs/8DnQCnT9B+mr6gZtlyRfE
   Xbyksd+xC6u+BIxzcEof4mKyZc8tbw0x6+2XqYu04SvargtHx6bMRXiuD
   D5kNvE8YByCtL9YL8cRaN8F1ouS2G0PfRlZiTea046T6L35ntx7dmWORU
   Q==;
X-CSE-ConnectionGUID: nUpFb2LgSuKsisOKAAV+wA==
X-CSE-MsgGUID: bCQ3+VU7TNC+ud7BfsgXjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41052424"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41052424"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:20:29 -0800
X-CSE-ConnectionGUID: oKukZZFXRH68sS2LSbI4og==
X-CSE-MsgGUID: C3iNrGAkQfGbYmt88O2THA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117976097"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa007.fm.intel.com with ESMTP; 03 Mar 2025 04:20:27 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v3 0/4] ixgbe: add ethtool support for E610
Date: Mon,  3 Mar 2025 13:06:26 +0100
Message-Id: <20250303120630.226353-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As E610 adapter introduces different approach to communicate with FW than
the previous adapters using the ixgbe driver, there is a need to adjust
some of the ethtool callbacks implementations to the new pattern. Some of
the features are now set using Admin Command Interface (eg. controlling
LEDs) which among the ixgbe supported device is specific for E610 only.
That means ethtool callbacks related to these features need to be handled
specifically in case of E610 adapter. E610 introduces also different rules
(eg. setting FC, setting WoL) for some of the features what also needs to
be adjusted.

This series is based on the series introducing initial E610 device
support:
https://lore.kernel.org/intel-wired-lan/20241205084450.4651-1-piotr.kwapulinski@intel.com/


Jedrzej Jagielski (4):
  ixgbe: create E610 specific ethtool_ops structure
  ixgbe: add support for ACPI WOL for E610
  ixgbe: apply different rules for setting FC on E610
  ixgbe: add E610 .set_phys_id() callback implementation

 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  29 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 171 +++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  10 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  14 ++
 5 files changed, 212 insertions(+), 13 deletions(-)
---
NOTE: initial version of the series has been sent as V2 - it had been
tagged by mistake. Sorry for messing out.
So this revision is in fact V2.
link to the initial version:
https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=446487
---


base-commit: 35c698223836714535e5413753b5899ca2a05d0a
-- 
2.31.1


