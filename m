Return-Path: <netdev+bounces-80055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854D587CBD7
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 12:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366D21F22805
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796EA18E02;
	Fri, 15 Mar 2024 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkCCVh3l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E81B7E1
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500635; cv=none; b=E5iLGuR5g0l6oHBQWzCO9brCcVgDIoPw/BOP/kvK8iclPXum1R1VIbhTgk0kk1P+1MVVWylVKGbqotNdpSzjijOnPE7Uev2l3wnh3lvB31yxbG4udMZK87Y8S6fq4RFVBClv4JWwuIJzPaCgwTuRPNh/Q1wpsJIvbhKmcIasOFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500635; c=relaxed/simple;
	bh=jp05zdaPBy8QblvcBCHmZid5S/vi2Z39kiYDd/YOpZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aX9+5r5NZTRIOe8qeGMVMJKezM0nVf5o1Gsu/3jYdnSlTrdsxfdcfiSC5XsVVqjx29vcmAbpHjbMMPgiRimnmNLknXr9ebBviW3RlMKYN289I/1WAeodiqte0++va+Jl289zbsrjJxLQv774uQskjxVjxsv4wIsB/sLIhlWOURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkCCVh3l; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710500633; x=1742036633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jp05zdaPBy8QblvcBCHmZid5S/vi2Z39kiYDd/YOpZk=;
  b=DkCCVh3lyb7PZKxqvCMiblvjTA8JdKEFKRRgAYBW5QiDZhoV4M9oSwCB
   NLQWqKNQynCVgaXx85MXdaehhBrWGJl1I64YDE5+oIsE6uMHQC65ByBBA
   J6UV9MXh5Ci7CuJZLgSj6n5WOyrW1sqAkSCs+in1moj0WIMLr7ZTRvdbt
   6gvBtsP8RiIn9mwht6G9Tk+xQ5k3CxMDB0shgk6OczD6t+c3i32AgMg32
   MTUgepunpT+eacGJhLA3s7nCLOeQ5ez5HluUS7YbWsx+dQfiy3zc6/pTB
   a6NQGMJqVi2GcXhDzp23q17EhUmnwSBh9KGvBo2tuhSgL+Gt8JIVbC7+z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5549428"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5549428"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 04:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="35761191"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa002.fm.intel.com with ESMTP; 15 Mar 2024 04:03:52 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-net v1 0/2] ice: two fixes for tc code
Date: Fri, 15 Mar 2024 12:08:19 +0100
Message-ID: <20240315110821.511321-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Fix how ice driver is parsing tc filter. First is a fix to always add
match for src_vsi in case filter is added on VF. Second is removing the
flag check as it isn't needed and in some case can lead to a problem.

Michal Swiatkowski (2):
  ice: tc: check src_vsi in case of traffic from VF
  ice: tc: allow zero flags in parsing tc flower

 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.42.0


