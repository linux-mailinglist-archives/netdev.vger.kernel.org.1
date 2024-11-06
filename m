Return-Path: <netdev+bounces-142300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24B29BE266
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40A61C2334D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969471DB95F;
	Wed,  6 Nov 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dChU8DUy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC60C1D9A63;
	Wed,  6 Nov 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885079; cv=none; b=XwehrHjIb0xhZPa/a1Zk2ddoXZ8JLW/8BfVyt5WblQgv5fAZwFvSDT7Rl6XbSFNXJfErkfml+la1ohZnLNmy5PqEfTLUZamvfU1/KHzb+Wq0yFPhENFmoxH0jjKFXN7te40dESoQXEV33NgFXEGcsDrnOgNIx/ImfJ/f/zWjoY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885079; c=relaxed/simple;
	bh=aj3QpbQ3vAeAf4pan0gySW1WB6gm994teoTQgAanVdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZzoxi+pgO2L8sATjlbSfK+Zk+UblMJcmyXK6vwU2qaCDpB6dzuWFqqobGZRzKsc1k17Eas8gEY3/HlA4p8E3nupkQJE98+L+S8P2ZZoRbDM8AEkXBzvSf3x4XaWeT4HNCzd/mIPjlHzz1HwpZ5Nz0ZzFTpdVE/Vvx+zMUzwpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dChU8DUy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730885077; x=1762421077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aj3QpbQ3vAeAf4pan0gySW1WB6gm994teoTQgAanVdA=;
  b=dChU8DUymeq65Zku9OPY7dXdG0Mia88eeXa6BfxbyI8uQSRmuXmflIAZ
   0XnD1rlxMAf8XeaU24A0NICEp923bMtFKgNhDGTG4tl88jfblVIGER3q1
   EBQNCR8Z+TauLAOdeBNix60xp+pnbhUJaWXsa4AH8tvxo96yt5xkHJfHG
   RD4coqsg2kGOmSgkJJ2xFkNlSahcLi2WXNKLSTKK4sLvOWCUvXYB8oYEZ
   wByJB9m46Rc7SovwQIJ6z2WOh7lh9gU0sKdZILFWMuF+J/zeqGkINcoT7
   Anxex/T0WFDjSh6cn0pYoEV3/SxkyQdaEcNp4nNm14SuCYkG+Jky8bDCB
   w==;
X-CSE-ConnectionGUID: i2/rLwT1Q1epj8Xb3aWHaQ==
X-CSE-MsgGUID: BHoGK/vyRRqoUV0FZmgRzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34368401"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34368401"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 01:24:35 -0800
X-CSE-ConnectionGUID: t8nhEareSpmhJjTFVSTmGw==
X-CSE-MsgGUID: 7hbvPhtcQmyYso6I20nXUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="115221990"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 06 Nov 2024 01:24:14 -0800
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 38CA42877E;
	Wed,  6 Nov 2024 09:24:12 +0000 (GMT)
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
	Konrad Knitter <konrad.knitter@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH iwl-next v2 2/3] devlink: add devl guard
Date: Wed,  6 Nov 2024 10:36:42 +0100
Message-Id: <20241106093643.106476-3-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241106093643.106476-1-konrad.knitter@intel.com>
References: <20241106093643.106476-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devl guard for scoped_guard().

Example usage:

scoped_guard(devl, priv_to_devlink(pf)) {
	err = init_devlink(pf);
	if (err)
		return err;
}

Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
---
 include/net/devlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 7f5b36554778..6fa46ed3345f 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1534,6 +1534,7 @@ int devl_trylock(struct devlink *devlink);
 void devl_unlock(struct devlink *devlink);
 void devl_assert_locked(struct devlink *devlink);
 bool devl_lock_is_held(struct devlink *devlink);
+DEFINE_GUARD(devl, struct devlink *, devl_lock(_T), devl_unlock(_T));
 
 struct ib_device;
 
-- 
2.38.1


