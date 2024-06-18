Return-Path: <netdev+bounces-104663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE990DE79
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04171C233EC
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6BA17837F;
	Tue, 18 Jun 2024 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBuRsDJH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FF13DDD2
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746416; cv=none; b=EYEzpiUISwbje3VdXygs3kEZjUj/2MMcr5xsi7q9uXHtn8ye5V4KAm1DlpEhecBKsuknw5VcbMrMiuCGYnynExkYwkPdBHWxOWeqLAJCEcY1cq9YEXdJ6dYoudYmjRVCnpddFvdHXOWNvKbrLdE62ClsuMd5lD9naTVQFN5GgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746416; c=relaxed/simple;
	bh=1a4GRo1iAcTmdXdJpVU+j26iRaaIRVDykR6OkhL8R3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9akvL2vSAFFiVw3RL7vCzSUXj9tEzcWl58ytt1KiyF4M7iw4DCONd4sZeUl820cGt0Jpp6mMR3dQemg/q0wf7iLh7ObZhau3pZ9/KdI1/4RrtMZIah2YO9CBl2L2oL5FOS6dYSTQL643ykzlQsdU0BwydoNe7mFkwhvSdfFH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBuRsDJH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718746414; x=1750282414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1a4GRo1iAcTmdXdJpVU+j26iRaaIRVDykR6OkhL8R3k=;
  b=DBuRsDJHDx8H6ZgXP5lU215OE8if2L4PYbXtzfTFxRb3XdZstzrYRvom
   PDmnCTdbT6g9Feg9Ttf+//b9WqInQIAzln/dNwQafATcZ9+lrY3TWNYHb
   M0arGFcgNsbjc+EBgDJ1BuCPrPajCJKQwNs+GGdf2JF2iOoqawPB14amf
   EYC32h/xB2E0VakYC2AWFlalF6aIFWAL1pMJzuI9vp3bljl8JpW+Ibm2A
   7fiiOUYxtz2rL3XCgnxfpjBJwbwWxUyZiLV1TABMRkPqW83aoBvQqfIJ5
   3EMwGEmbcJKTKdwdtfqMZGpNbmMGVgarFV5P7H4D/ImDpRgUPqZF+6RDH
   g==;
X-CSE-ConnectionGUID: ZWJ9VFvURxyRQObCNL1icQ==
X-CSE-MsgGUID: hJQ8Z2SISSWCTfAjmobQ5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15890669"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15890669"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 14:33:34 -0700
X-CSE-ConnectionGUID: 5WFUqobXRz+Yy4r0VgxPsQ==
X-CSE-MsgGUID: pmRAPZQBTvGcnTfVizhmNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41529406"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2024 14:33:33 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jackie Jone <jackie.jone@alliedtelesis.co.nz>,
	anthony.l.nguyen@intel.com,
	chris.packham@alliedtelesis.co.nz,
	andrew@lunn.ch,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next] igb: Add MII write support
Date: Tue, 18 Jun 2024 14:33:28 -0700
Message-ID: <20240618213330.982046-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jackie Jone <jackie.jone@alliedtelesis.co.nz>

To facilitate running PHY parametric tests, add support for the SIOCSMIIREG
ioctl. This allows a userspace application to write to the PHY registers
to enable the test modes.

Signed-off-by: Jackie Jone <jackie.jone@alliedtelesis.co.nz>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index fce2930ae6af..3af03a211c3c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9139,6 +9139,10 @@ static int igb_mii_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 			return -EIO;
 		break;
 	case SIOCSMIIREG:
+		if (igb_write_phy_reg(&adapter->hw, data->reg_num & 0x1F,
+				      data->val_in))
+			return -EIO;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.41.0


