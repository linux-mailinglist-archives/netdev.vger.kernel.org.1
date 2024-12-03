Return-Path: <netdev+bounces-148698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8937A9E2E89
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B9C1670BC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242CA20C494;
	Tue,  3 Dec 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYusZe2d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AC20C02E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262936; cv=none; b=nWycGm/SajY0X7cAKcUWh+Vc0+h083GMVWM7RIQWtBlSsj1ae4A84Ux70CSIBsLMzOncWuuImsXfVLvZm9JqIqd8vPggN/4tmAHJVFMlqeI0Ohl2AqhXFXgQKHCIlQKINDlrK1LARPV+Fb9GGUw9GbFnD8trPGeJAxH55OG0Dz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262936; c=relaxed/simple;
	bh=UdyR4PJHi6VBm3/+paaOfmCEmQoUhDZEbunWfeGFRTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkrJaiaKlAcEn0AFyOISOV0hTQOFm4lislGur8utkgAmQmI6HrFHcjrDqB9Q4H1Wifw1gt8Pg0C2400xUv/+M0xDNTXFbBKDrIQTFV7jNPuJ6qCOcFXe7EhGnXPqqJW758GnLGEjun1uhARalFF+v6Hf4ZMVzyqapEHOt1qw7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYusZe2d; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733262934; x=1764798934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UdyR4PJHi6VBm3/+paaOfmCEmQoUhDZEbunWfeGFRTs=;
  b=VYusZe2dtqM2URnVpDruA4OhMQZWa+L6BG6bC9AFHwX7zA9tNcWvtEvV
   SRqYEPJHhSXIuymjhtd14XQ+0fV1hPQzZR/uupSanfYbHrHErUIsdTV0L
   pwwhSyuPijQah1YKKwuG7k51wpQ6TCKKWBl3SXjUL9bLMgy4tD6O/xRyf
   yKIlh4QEFZ0uiUZFMgGrX9BByE/VZ1LYyPLZ16WM2PCO+BRAnoZQwuxeC
   oqmC9W7FfP0P10vUGSxtjF8kaAavIkKKpNNUDjw/xCA5byU+pf+iiu3zY
   Ih3XU0DuwlVua9FtJC1IAEHKN+LgyFUCJRXltXUVQ5Rwo7Z5qiwqSP+cU
   g==;
X-CSE-ConnectionGUID: kSgq4VIUR56xUOipY0aI/g==
X-CSE-MsgGUID: jLbTMKDZQouQDq0s74ygAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="21087145"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="21087145"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:55:29 -0800
X-CSE-ConnectionGUID: DInEKKwfT8eXWToVYLm+qA==
X-CSE-MsgGUID: Smo4HCfzReS6lt6JccP+Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98578885"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 13:55:29 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 6/9] ixgbevf: stop attempting IPSEC offload on Mailbox API 1.5
Date: Tue,  3 Dec 2024 13:55:15 -0800
Message-ID: <20241203215521.1646668-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
References: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Commit 339f28964147 ("ixgbevf: Add support for new mailbox communication
between PF and VF") added support for v1.5 of the PF to VF mailbox
communication API. This commit mistakenly enabled IPSEC offload for API
v1.5.

No implementation of the v1.5 API has support for IPSEC offload. This
offload is only supported by the Linux PF as mailbox API v1.4. In fact, the
v1.5 API is not implemented in any Linux PF.

Attempting to enable IPSEC offload on a PF which supports v1.5 API will not
work. Only the Linux upstream ixgbe and ixgbevf support IPSEC offload, and
only as part of the v1.4 API.

Fix the ixgbevf Linux driver to stop attempting IPSEC offload when
the mailbox API does not support it.

The existing API design choice makes it difficult to support future API
versions, as other non-Linux hosts do not implement IPSEC offload. If we
add support for v1.5 to the Linux PF, then we lose support for IPSEC
offload.

A full solution likely requires a new mailbox API with a proper negotiation
to check that IPSEC is actually supported by the host.

Fixes: 339f28964147 ("ixgbevf: Add support for new mailbox communication between PF and VF")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 66cf17f19408..f804b35d79c7 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -629,7 +629,6 @@ void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter)
 
 	switch (adapter->hw.api_version) {
 	case ixgbe_mbox_api_14:
-	case ixgbe_mbox_api_15:
 		break;
 	default:
 		return;
-- 
2.42.0


