Return-Path: <netdev+bounces-138066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F969ABBA4
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FF31C21EAC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7C487A7;
	Wed, 23 Oct 2024 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVwYCIxN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7C8825
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651195; cv=none; b=Q8qVTFDYoNbZhaNIZ7fMnai+oyJwLqo7fXGae48OqItSiaiJWH8u8cQb1GLS3B8bI9kJ7hpY6xrdcmP9oZ5fbKjlqmGOZqt4YdIc1yOe0NN2Nb7vj8mJgzgmNf0X9K2F7WWB5yeXwfotCU9osU2AtQmPZuUHFdcDITtQH15PgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651195; c=relaxed/simple;
	bh=qCAPd+EKjSnUO6a+dnDXRPZ6SLhdHJyhlvsnFzp6X3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m/u11bqUnOh7onPyJfPrqhVE16HUmsv3IYncpWSbcvmMUGI+Fsiwk9cKVDTvLh4FM7zckWyCBBJVIvWrCkUvAjDuluqJXczHrmA1TGDVZAwsUQwSaMumX0GalUaNqZhCBteo/22FkQcwoAiTcSuOunXhHv6dLvy5NCuOUZ9HjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVwYCIxN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729651194; x=1761187194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qCAPd+EKjSnUO6a+dnDXRPZ6SLhdHJyhlvsnFzp6X3Y=;
  b=hVwYCIxNj9N305oNCjSkD7hEb0pKfPGP9X7gbx0eDWD11Cs8MV+xarpp
   lOxYZGVYBI7gQjZ+WjFLtfGJfuAMNtKqXS9FEs4t8GCTTSLs7rnfBmd9B
   +SPArAb6q3kppiOEekU/ntHVZ6qbRnyFCmQDQgdNAw2GSoEXcITLJWjQj
   FECZzexRKmuw2HBWRPbJ3dKQxGEmgT1skC31daDNIWcxb4zGlRJUJ4x2N
   4wQwA/8tQO9jpvKemjV/+v58lI08Z/fWx6B0hlGwOTdmF69Yx1pYxz3g2
   ckg11SsDL+8hmY8uKgkVQr3vYv0D+3GYgxJCKUxHgInYCTeeUm2mr7OvP
   Q==;
X-CSE-ConnectionGUID: ro7+LM2lTwaHsL08jNpmrQ==
X-CSE-MsgGUID: DuxOlLnTTcmRT17lrkBaJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32918029"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32918029"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:39:53 -0700
X-CSE-ConnectionGUID: prLyHlcnQyydZLLa4LTxmg==
X-CSE-MsgGUID: FKILdsurRcG/+Tf5QWAbVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80396816"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
  by fmviesa010.fm.intel.com with ESMTP; 22 Oct 2024 19:39:52 -0700
From: Chris H <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	vinschen@redhat.com
Subject: [PATCH iwl-net v2 0/4] igc: Fix PTM timeout
Date: Wed, 23 Oct 2024 02:30:36 +0000
Message-Id: <20241023023040.111429-1-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There have been sporadic reports of PTM timeouts using i225/i226 devices

These timeouts have been root caused to:

1) Manipulating the PTM status register while PTM is enabled and triggered
2) The hardware retrying too quickly when an inappropriate response is
   received from the upstream device

The issue can be reproduced with the following:

$ sudo phc2sys -R 1000 -O 0 -i tsn0 -m

Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
quickly reproduce the issue.

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
  fails

Changelog:

v1 -> v2: -Removed patch modifying PTM retry loop count
      	  -Moved PTM mutex initialization from igc_reset() to igc_ptp_init()
	   called once in igc_probe()


Christopher S M Hall (4):
  igc: Ensure the PTM cycle is reliably triggered
  igc: Lengthen the hardware retry time to prevent timeouts
  igc: Move ktime snapshot into PTM retry loop
  igc: Add lock preventing multiple simultaneous PTM transactions

 drivers/net/ethernet/intel/igc/igc.h         |  1 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  3 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 98 ++++++++++++--------
 3 files changed, 62 insertions(+), 40 deletions(-)

-- 
2.34.1


