Return-Path: <netdev+bounces-108867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CA692619D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E01B29A8E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D516F827;
	Wed,  3 Jul 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7+HzfDa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8491E4BE
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012578; cv=none; b=uGyJX9ce5jsMF4wMbcIDKSI6G73G6vNhadWF6nrvNCmujFRQmF+62mE8cqU70teZ1d6oQZwAH45Y8MtHHDEZjPJvVaE4t+NDj87iRr56MFU1YONa6tsKiCxfmv/vB3TygpC6Zl6p+AmZesLjZBJ7LZm8VdHh5XDsDdFuo+yNQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012578; c=relaxed/simple;
	bh=TP/ppx/cq3u7qkLqLaXkSh5C+kpwmGVYUxuMox6NGIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RRQPvzlxi3tEqWC1iWGJY6+F47P6IWaq4lV6miTDd2NttWrJU2W9KQIEhloxc6Clnve16ALmGIFEC4BbBPxjxYYdHUAhUt4bXoTgw6QdYr/Gtw6JqbD9MreHtVlFag2laOmflgVHEWUspSIIPCaEk4/39cCmRBlh5GvwRquibYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7+HzfDa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720012577; x=1751548577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TP/ppx/cq3u7qkLqLaXkSh5C+kpwmGVYUxuMox6NGIE=;
  b=n7+HzfDaYAf+FencsJw2Kv3TWh8EhhpuH0kTfeXS1dOj3DvILTd6lQQj
   iugA0RNf+XCWmlAi2GOBfk1Xyxhsi3+xOLRDnXmhKSk0dJfdlatDI9FRl
   nfjhShc7qzgF8ZUSgTMTAFEM/a41+6CBN+FL90o14haZL17WuspuXEHgA
   Zl0FUdnl5cGfG8JX/Ee4eBnMxHEJRmwDlemrs6mjdOuxpcXtwwiIaK8QE
   We3eX0KN4FClsyfrrLjjbVkkp7kYHOdjPyTrPcibLVqinvvUWmTBmyGtR
   YNQf/c3qhv5RaFVoEoFsIg3Zk+l4kBqKIreJAkZkwIyY2D1JYNoubmTVJ
   g==;
X-CSE-ConnectionGUID: bav8tEApQN6hIwWNzhlsyg==
X-CSE-MsgGUID: g0zQPoNiS9WMVLGvAnHO5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17195084"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17195084"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:16:14 -0700
X-CSE-ConnectionGUID: kRpeQjVWReKiCpNIr9AGww==
X-CSE-MsgGUID: 15MfImwEQOSlV7/1dbh11A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="83805882"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 03 Jul 2024 06:16:11 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 567FE284FF;
	Wed,  3 Jul 2024 14:16:10 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iproute2-next 0/3] minor improvements to makefile, devlink
Date: Wed,  3 Jul 2024 15:15:18 +0200
Message-Id: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three minor improvements: better error messages from devlink app,
fix to one example in the man page of devlink-resource,
and better build experience for single-app focused devs.

Przemek Kitszel (3):
  man: devlink-resource: add missing words in the example
  devlink: print missing params even if an unknown one is present
  Makefile: support building from subdirectories

 Makefile                    | 45 -------------------------------------
 common.mk                   | 43 +++++++++++++++++++++++++++++++++++
 devlink/devlink.c           | 27 +++++++++++++++-------
 configure                   |  3 +++
 man/man8/devlink-resource.8 |  2 +-
 5 files changed, 66 insertions(+), 54 deletions(-)
 create mode 100644 common.mk


base-commit: 357808abd3a67bcf4d1444a25268c45dda62e87f
-- 
2.39.3


