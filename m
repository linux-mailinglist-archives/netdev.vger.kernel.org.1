Return-Path: <netdev+bounces-110932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C8892F038
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A21282BA1
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C224219EEAE;
	Thu, 11 Jul 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moON6Emo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801D16EB67
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729180; cv=none; b=qw9nZNaMptFd73GY7VuO22Hah/sl39nPVhEmnimNde9XrT0vmpsUFnXRt6Yio2BbpqaS9NwiJJVrf979qoCeQh2VH+SKWNonUPihbHqBneh8El5NekVtrRwqhwsesXPXT2Gnosl+f0ihRQsZvvQNTE0jHef8VOCf1RmunddTdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729180; c=relaxed/simple;
	bh=Kk34XyVtGRbvV03MXYFKOt13mW+vFCGtlKh7LJeyg2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvOpu/3YzZqXr0AqoMria4do39AK054HbkJwh17OoKDE90rq1m1GaKlibtr1DcC4DvJX0Hl7tKtefFrERACN/A33DZwHoaqO5tSIuPO19nOmnr4DwjKX8BRSkCpAJv8w/Wb7NHh9fJUAOrAzipn/jrL5cd8n+te6f6sxH9/n9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moON6Emo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720729179; x=1752265179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kk34XyVtGRbvV03MXYFKOt13mW+vFCGtlKh7LJeyg2E=;
  b=moON6EmoB+PZpcbQKX4HYEIzPTeVfsliDn5hhP/GDoEQN4GUw/OrLdQc
   iHKGxO9TpOuTc4a434RymipBh8i5nQ/XuHrbh2Ex9+/0ljCY8ro9+aMjv
   c1+W+hkFdSOlW5WMArfEFNNd9KvHUKo85+NDjlpvJFRsRbHtZylVnJZRJ
   PEpxtdKpOnE8eUINGPzArN6rkDLWonAgaWeMIUl0p0tZilYu3m86YsZSN
   IZOvOjrtUinXrdmPhs2W5soOUF+bPV3ZuZxqZW/uGFClma0DXFdpIrNDH
   ex0K2rlSkmm8CaW3d9YrRni40FeX2dlrsT0G/oM4/QBNiPr9GhuqQknU7
   Q==;
X-CSE-ConnectionGUID: oZQkzIl9QrykQTSoB/+rFA==
X-CSE-MsgGUID: 9yP1uT/pTlOsC1FLEl/heQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="12508391"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="12508391"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 13:19:37 -0700
X-CSE-ConnectionGUID: L31wGvgqTFWXT/jPq24eiA==
X-CSE-MsgGUID: 5ktkvwM5SEGm+WFbJESq0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="71887405"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jul 2024 13:19:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 2/5] i40e: correct i40e_addr_to_hkey() name in kdoc
Date: Thu, 11 Jul 2024 13:19:27 -0700
Message-ID: <20240711201932.2019925-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
References: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

Correct name of i40e_addr_to_hkey() in it's kdoc.

kernel-doc -none reports:

 drivers/net/ethernet/intel/i40e/i40e.h:739: warning: expecting prototype for i40e_mac_to_hkey(). Prototype was for i40e_addr_to_hkey() instead

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index bca2084cc54b..d546567e0286 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -735,7 +735,7 @@ __i40e_pf_next_veb(struct i40e_pf *pf, int *idx)
 	     _i++, _veb = __i40e_pf_next_veb(_pf, &_i))
 
 /**
- * i40e_mac_to_hkey - Convert a 6-byte MAC Address to a u64 hash key
+ * i40e_addr_to_hkey - Convert a 6-byte MAC Address to a u64 hash key
  * @macaddr: the MAC Address as the base key
  *
  * Simply copies the address and returns it as a u64 for hashing
-- 
2.41.0


