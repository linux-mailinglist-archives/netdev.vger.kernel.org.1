Return-Path: <netdev+bounces-152721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0C9F5872
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC84165DF9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2701FA14B;
	Tue, 17 Dec 2024 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeVSBVC7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1F1F8AF9
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469733; cv=none; b=WL+4r8CY7cEZcRBEtErmYfU4pT3vxsJ6/m/tv+h0qymTQ9Ch8MbCh/Q4fAsDkSsL9t+UQWGrvyMqzbu/pFDHQr0yJEfHGsHCKX/EsoUcJoN4cAPLqANyyIFbOSdbSvLY81PEHUllmDt+yXke+u0Ifx+xfq+TjYcudSpTMfj2LQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469733; c=relaxed/simple;
	bh=bKTUhGqIJAv0rmqbIdvWk+NxA3Y7E9yK5xKdfShBEGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVW0ba28tZJXHTpWMq0w7KC9ysWqeYMGWHGF2VGcK1I0xqxkJ7qWTOXqBPKLfz4JptgsSHMfnlTJ2wVkVOGdvurO5kD7g92YHZvO3hVUzFvo4hTnHma/zPxiZUIgejf33+CQT/PoKrWoGg62cT5IVjikYhz562f/tNyiMxjT1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeVSBVC7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734469731; x=1766005731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bKTUhGqIJAv0rmqbIdvWk+NxA3Y7E9yK5xKdfShBEGQ=;
  b=eeVSBVC7ncG+/SCFZ746Td8PCIJVtfCSurNmtOAXbkNdeQy5qbr4c5tK
   gSNMvI3QTrJSrftCd3uuLnLEEFU3AQEnYP4HWftWCu/5HTP2Z5UW+70+/
   RgZGmE82fmCy8apNl0OAx37rKDVZpUM2En9kRW61HuiqMe5aad0Df4EaV
   +tyTivWl5Oi16G4E4J8OouOtzxG5ZSfANIkQJDrcNgSY99pBSAp2vgXTW
   351HguRF10Gmc/mrm0ZNoe1fTiHrIgb83FbBzrMSq/xLymgmxyb9mCHc4
   xQ4x1MUtGxwl2Ta6XFE8ZTS2O5D8qTPLfR5dqwv6OznGAd1JOGgfAq0aB
   Q==;
X-CSE-ConnectionGUID: 3giKfYcPRzGYxXeH990iXA==
X-CSE-MsgGUID: r+Rzm6QrTl+xM3IROirVCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34794824"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34794824"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 13:08:49 -0800
X-CSE-ConnectionGUID: iQCudGe/Ra2n8C8QWNFs0g==
X-CSE-MsgGUID: LsQasKyeRwiC+Ps4X9SokA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="97436297"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 17 Dec 2024 13:08:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	mateusz.polchlopek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com
Subject: [PATCH net-next v2 1/6] checkpatch: don't complain on _Generic() use
Date: Tue, 17 Dec 2024 13:08:28 -0800
Message-ID: <20241217210835.3702003-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
References: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Improve CamelCase recognition logic to avoid reporting on
 _Generic() use.

Other C keywords, such as _Bool, are intentionally omitted, as those
should be rather avoided in new source code.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Acked-by: Joe Perches <joe@perches.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9eed3683ad76..a2066a6c9dd8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5843,6 +5843,8 @@ sub process {
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
+#Ignore C keywords
+			    $var !~ /^_Generic$/ &&
 #Ignore some autogenerated defines and enum values
 			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
 #Ignore Page<foo> variants
-- 
2.47.1


