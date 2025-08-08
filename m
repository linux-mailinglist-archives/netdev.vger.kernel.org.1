Return-Path: <netdev+bounces-212259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E30F8B1EDE0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C78B44E1EC0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4181CBA02;
	Fri,  8 Aug 2025 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ejc3VpI2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C023199385;
	Fri,  8 Aug 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674792; cv=none; b=T3BIjZ+Fil3Fyl9bgV/HLyshJC+sfygP+RcI8J6AARl6FusL/1Km+adBGxQAt82OjiCFHLlK4G32mtUFWUIbR2A1CfCE+VBN9O0RYbrY7F2uVomjXv+cuC3Cq4AkCiO0VPolIQkZNrc6dMMC1o1uJ0BiUdwbvELXheH3mxvcO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674792; c=relaxed/simple;
	bh=+k9c7Cb/QVIWMb4JvwihS38V1NqKDT4MgVlpqaS/Muo=;
	h=Subject:To:Cc:From:Date:Message-Id; b=cMhlDiZ7yyoXGr85xIZ8S6cCezILfxyvJF/XEhvgmykovU5YLrhLiVIFzg6J8mw6pDnp5H4UTE6pAqAaM84NwylIA4WhoNzbnCyhiPysNKXsrn2+LSQAZC7F0w2EDbKhkNaq4merJzdSaO+icC6ynXHqkVabBgHI71P1DbnD16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ejc3VpI2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754674791; x=1786210791;
  h=subject:to:cc:from:date:message-id;
  bh=+k9c7Cb/QVIWMb4JvwihS38V1NqKDT4MgVlpqaS/Muo=;
  b=Ejc3VpI2y6X8GYVKKsWKz3dg5jxdLo4dRKZVeQr7Zk7wa8tpNwtEhDix
   yc2UmyhzILMg0uElsAI0tIomIuf7+korGZOFmmmTb1zbZ1FsGj2NgiHvE
   kTxPeepOZLgz+r9Q+yq8OwfKsBHeIlDr5hN85bAxaaKofo0Gg2qPiU1Jb
   MaOeY3HoZ4frW325HMSa3o7SFSr8kWc/iQPJC2M42EC5/UwWoZXCA38ov
   FQ6HTboNXXq4t1UdyiB5RcD3mKe9elaaM3d4ET2UK5UZ0yAN3JMHYGV0j
   vz6c1jknzDFzS5aSBxzaAb+PyI9IrfhHSkqssNGZUz09BcCrh0oTAhf8j
   Q==;
X-CSE-ConnectionGUID: S+v/tMpxS3C40uKQK+rRug==
X-CSE-MsgGUID: /jL8u7rJTcaATefMfWLfVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56062901"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56062901"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:39:26 -0700
X-CSE-ConnectionGUID: LTFjkgePQNiyogW7vMeOWA==
X-CSE-MsgGUID: ty/ZeoGMREuU+gH39245sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="202565003"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa001.jf.intel.com with ESMTP; 08 Aug 2025 10:39:25 -0700
Subject: [PATCH] MAINTAINERS: Remove bouncing T7XX reviewer
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Liu Haijun <haijun.liu@mediatek.com>, netdev@vger.kernel.org, Ricardo Martinez <ricardo.martinez@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 08 Aug 2025 10:39:25 -0700
Message-Id: <20250808173925.FECE3782@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This reviewer's email no longer works. Remove it from MAINTAINERS.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: Liu Haijun <haijun.liu@mediatek.com>
Cc: Ricardo Martinez <ricardo.martinez@linux.intel.com>
Cc: netdev@vger.kernel.org
---

 b/MAINTAINERS |    1 -
 1 file changed, 1 deletion(-)

diff -puN MAINTAINERS~MAINTAINERS-20250707-4 MAINTAINERS
--- a/MAINTAINERS~MAINTAINERS-20250707-4	2025-08-08 10:38:10.580631443 -0700
+++ b/MAINTAINERS	2025-08-08 10:38:10.592632494 -0700
@@ -15671,7 +15671,6 @@ F:	net/dsa/tag_mtk.c
 MEDIATEK T7XX 5G WWAN MODEM DRIVER
 M:	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
 R:	Liu Haijun <haijun.liu@mediatek.com>
-R:	M Chetan Kumar <m.chetan.kumar@linux.intel.com>
 R:	Ricardo Martinez <ricardo.martinez@linux.intel.com>
 L:	netdev@vger.kernel.org
 S:	Supported
_

