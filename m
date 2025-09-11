Return-Path: <netdev+bounces-222345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761E4B53F2C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB7B3A6E8E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331522F747B;
	Thu, 11 Sep 2025 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQ5LbCh6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E602F6563;
	Thu, 11 Sep 2025 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634103; cv=none; b=Qikt+cflwZcEU+99ZU1JmabTVvskSvCDI/PnjiVnppKhmvgRDioJOLFCfBA0mLwhuWqpSgR9HDEOKB2P8IX76TlJlAipbCRGrUKMkS5pjzB9Gpwmbc548iIQ+KdScxcENKRJ9Ac8smBfOCA2zZNVtx7KS8AfVj1dGc2QSHKoOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634103; c=relaxed/simple;
	bh=U5LicZk3zOH+cfVm8UiDiYn2gNrNlZZkTJ30LuKTw3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RXzOp/soJS//KEsG0vGnurLRo0lxu/gVbtCZX2O6CshNDujfOIj4bs4ojbTG86G42Cm4H40+GN3fSRk1UtMrJTUO+d7xR08yJrwerUFFgN9pJ9krQPzwuFTQI9vC7ylr5gORZ4xqEfUYOsvBGEAQjPe4kaUojAyfkYzvoSP1iYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQ5LbCh6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757634102; x=1789170102;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=U5LicZk3zOH+cfVm8UiDiYn2gNrNlZZkTJ30LuKTw3c=;
  b=PQ5LbCh6URv94wDzJazb0zLj82Ki7vC62oUw/EZA3y5GgDGlulxpPYOj
   j5WhrAcJZH28O121zwvwURjgrX7gH9XejANlt3KHr4MWoQOIh+47592TX
   nCsi+vnh/LDkolQOJeoKnjdOHZx7WpZdsloVDY5hX3dSpVWid0Kkqa4V1
   GKMdglCB1B152gMt1IOTmtUHOKwadi2DdTvf3rTZzU7Nli537KyIC5GGv
   LtczBdSNGn43It7Xrtrb1npR5PNz+nkML9FcTBpZdQ6Z+XmA0Of92vG96
   CdKsJ+qFNDA+GRXe+XYJ1dVFElmYvQNbnbZCDJQpylirluaRY4xkpgFDf
   Q==;
X-CSE-ConnectionGUID: 5xQ66eTpRqqt2x7oT9grkg==
X-CSE-MsgGUID: I5uyOVNqSxyLON018edeow==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71354787"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="71354787"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:41:38 -0700
X-CSE-ConnectionGUID: 1vJ9H64AR4mCT8ojLdObtg==
X-CSE-MsgGUID: itRUAuH3QRCRU3oHFa92Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="204589490"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:41:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 11 Sep 2025 16:40:37 -0700
Subject: [PATCH v3 1/5] net: docs: add missing features that can have stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-resend-jbrandeb-ice-standard-stats-v3-1-1bcffd157aa5@intel.com>
References: <20250911-resend-jbrandeb-ice-standard-stats-v3-0-1bcffd157aa5@intel.com>
In-Reply-To: <20250911-resend-jbrandeb-ice-standard-stats-v3-0-1bcffd157aa5@intel.com>
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>, 
 Simon Horman <horms@kernel.org>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
X-Mailer: b4 0.15-dev-c61db
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=tgbQu2OqsM4wvoaJ2Ac7Pu7HlNzbap0vQ4hGe758rUM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhozDcQbXAksf9db77ag6F7ovql4q7v4E+xaLOa0B1YG16
 /iYzWZ2lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMJGqq4wM296Zvc6ck9N++PDy
 Sca/bc5IHFtgINLwq1t30UvV2TM4tBn+2VR9TMibXDqv+f9293kBi9c/yEgxv3ndtjP2TsSq9tV
 GnAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

While trying to figure out ethtool -I | --include-statistics, I noticed
some docs got missed when implementing commit 0e9c127729be ("ethtool:
add interface to read Tx hardware timestamping statistics").

Fix up the docs to match the kernel code, and while there, sort them in
alphabetical order.

Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/networking/statistics.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 518284e287b0..66b0ef941457 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -184,9 +184,11 @@ Protocol-related statistics can be requested in get commands by setting
 the `ETHTOOL_FLAG_STATS` flag in `ETHTOOL_A_HEADER_FLAGS`. Currently
 statistics are supported in the following commands:
 
-  - `ETHTOOL_MSG_PAUSE_GET`
   - `ETHTOOL_MSG_FEC_GET`
+  - `ETHTOOL_MSG_LINKSTATE_GET`
   - `ETHTOOL_MSG_MM_GET`
+  - `ETHTOOL_MSG_PAUSE_GET`
+  - `ETHTOOL_MSG_TSINFO_GET`
 
 debugfs
 -------

-- 
2.51.0.rc1.197.g6d975e95c9d7


