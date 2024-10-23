Return-Path: <netdev+bounces-138240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D509ACAD9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23331C20C27
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A114A1BC065;
	Wed, 23 Oct 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5oHv4jx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6F1B4F32;
	Wed, 23 Oct 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689212; cv=none; b=r1BDe2Mrm5QKdF39F9U0pVbzQVjlkjs/qeyBqXvUfIl3RPyp2o/6p8faHQVmxSMegXWcMB3utHjJgtFLlYhb67D348x/e0rss2foun8ivWrHQAwDuAqDzfrlc7MiKdtvCIXVhlvMt5NCkuviIL0SBIxjrybVSm1vg5buftqyKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689212; c=relaxed/simple;
	bh=KGwSHGv8HieFGzkcSZoeMcMWGvtOAqrT72PXLT1HkhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZN/e72+kkGBbGINdlfdN1PfmItYMyAa8/CBcwnGmar409ulKT1atziu1bLZeGOQoQkcJ62jZwTNKesbwMEVx9Aea4zKlyCzdZSTZg8e6zaMWzKGSeMOl2SI9hJJipNT9dQRABhz88zqzkjBSarSPFmX+3MqeQNdtCZJfmmYcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5oHv4jx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729689211; x=1761225211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KGwSHGv8HieFGzkcSZoeMcMWGvtOAqrT72PXLT1HkhY=;
  b=m5oHv4jxJ/RWa7aJjQbUIFXfZadiffjNjs1zcOZdVuWPNYDuLryjdBmU
   uQPEgtGrTpJqfU21D/IGWl8v4UIAmuH9DK8wXAF6WSZXsC7ATBh7I/tbR
   yOxv14q9wFyo8HaQUh9zwVU5t73DvktsnDHYtTK5KX3KpPz99Kv1TOe6Q
   ELf+byznzVcMahQQ6TP1KksnBrbwamqQqb/V7MoaEBonxH7/pZGTSMJVl
   OJlDrFEgKLCA6F/CbNFIYkNKzI432uIHmtTAkCWa1udsFj68f7xR/o6nj
   x7oyz/tVfNYWV618VixktEjIaQEBV6p4dN/2EEbhkphx//CRU6eL1oF6h
   g==;
X-CSE-ConnectionGUID: 7CriG2/tRUW8nE66o3BpgA==
X-CSE-MsgGUID: XGfZxaywRNCYg6EgdVEJ4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="46758571"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="46758571"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:13:30 -0700
X-CSE-ConnectionGUID: syDjI5m5RKCnpDCP8tXtGg==
X-CSE-MsgGUID: E5BDJ9oJQvuF4PfIa0MSvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84820116"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 06:13:27 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.71])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 998292877A;
	Wed, 23 Oct 2024 14:13:24 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v2 3/7] devlink: devl_resource_register(): differentiate error codes
Date: Wed, 23 Oct 2024 15:09:03 +0200
Message-ID: <20241023131248.27192-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
References: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Differentiate error codes of devl_resource_register().

Replace one of -EINVAL exit paths by -EEXIST. This should aid developers
introducing new resources and registering them in the wrong order.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 net/devlink/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 5ce05e94f484..96c0ff24b65a 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -345,7 +345,7 @@ int devl_resource_register(struct devlink *devlink,
 
 	resource = devlink_resource_find(devlink, NULL, resource_id);
 	if (resource)
-		return -EINVAL;
+		return -EEXIST;
 
 	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
 	if (!resource)
-- 
2.46.0


