Return-Path: <netdev+bounces-120737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E9995A6BE
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9350F2817D8
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB37317557E;
	Wed, 21 Aug 2024 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYc8pAIF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685B13A3E8;
	Wed, 21 Aug 2024 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276209; cv=none; b=kNp2lHlR9s+63BsQdqDcNIznGUdT/NBr5CJECDSqnNdX2eLYimw5/gSAs5KI7IiswHeIkDwlcSSF9XSVzDxe9gQ7awoXU4aZMhtwhj9KaWRN8KGlai/nAhmO8bllPROfZ3VCgu86y2PLdR1ZivLiPpI+3zA/kljnwtacpi1khvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276209; c=relaxed/simple;
	bh=GiM+0ExQI9l2UFIsmfkehIGcth+Vvekiu0LRbZOTSMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VQ66be38mWWTgm+3Bme/Jqp5MxytLY8x2E/d7IGb/JfPJ7fni66eaZqZHsKcpAOF4U64apNdnjIGH/KSPai1smdF7ILD19l9uGcZu4KDOP1yXvMz21AoL29Rfrn2SfM5Ia4GCYFrOLPyGuN50u06pKtP1fInYhGItKablbmUWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYc8pAIF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724276208; x=1755812208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GiM+0ExQI9l2UFIsmfkehIGcth+Vvekiu0LRbZOTSMA=;
  b=dYc8pAIFlZxSlL2cqa+sdZkEb8Wx814j7r1sfOIKCeDpb2BjizH2qaAE
   SGSxF6t3wyARwxsHbLuGQ/a8PYN6+3uPFp3MXMiGHmJAo5UD2hijIiIzk
   xa2EhYqp5RorBG0MPtVmbUQi59zi8riMJtPLLEPCmEAqbZ3Cv/3jrpnUk
   HItRCzEhd/AV4JjPcVj3OTvxi1avIxLowTduc0QYTI6Ly/h+N2wX85Cci
   JqxtDKF7C05wrxHqhkl6xfbz3WSTiizW/gDGuTBWzFOVIVvnjJqqmnjZ7
   dkR8DirPcub5Xt5FRDJnR3W0ceSWWZUlH6cfNkiI+tSgjmh0tFI2ZvSBS
   g==;
X-CSE-ConnectionGUID: 8SDY2GhSQFmoB47Lb3cyQA==
X-CSE-MsgGUID: RmAmsGBJR5uvV/PjZ1iVcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="34083804"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="34083804"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 14:36:39 -0700
X-CSE-ConnectionGUID: bugj+qDySomfpUN6XsXw3Q==
X-CSE-MsgGUID: wjXeT6GXSZCZY2UkzDQ2+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="98724613"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa001.jf.intel.com with ESMTP; 21 Aug 2024 14:36:36 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v2 0/2] Add Embedded SYNC feature for a dpll's pin
Date: Wed, 21 Aug 2024 23:32:16 +0200
Message-Id: <20240821213218.232900-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce and allow DPLL subsystem users to get/set capabilities of
Embedded SYNC on a dpll's pin.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Arkadiusz Kubalewski (2):
  dpll: add Embedded SYNC feature for a pin
  ice: add callbacks for Embedded SYNC enablement on dpll pins

 Documentation/driver-api/dpll.rst         |  21 ++
 Documentation/netlink/specs/dpll.yaml     |  24 +++
 drivers/dpll/dpll_netlink.c               | 130 ++++++++++++
 drivers/dpll/dpll_nl.c                    |   5 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c | 230 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 include/linux/dpll.h                      |  15 ++
 include/uapi/linux/dpll.h                 |   3 +
 8 files changed, 424 insertions(+), 5 deletions(-)


base-commit: d785ed945de6955361aafc2d540d9bb7c6a69a65
-- 
2.38.1


