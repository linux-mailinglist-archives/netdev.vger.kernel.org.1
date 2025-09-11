Return-Path: <netdev+bounces-222323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0707B53D7D
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C188C560D16
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319CD2E03EF;
	Thu, 11 Sep 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTQJ7yIC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1C2DF3F2
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624749; cv=none; b=dAl134B175Q/ZfKPHCrBMKuCQuEPw9fkco/ldaC6XrpV0VoDi2DiQsQWYsswWBvsLELzXs2pbzErYvC+ovH1hZFAn3WoUD/bw5WivK/ce5YLRQaIZzxn3g166BIxvxJC0FfWac2vHCm0n10B7azt3pJBHtQkHkI2//k19quFSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624749; c=relaxed/simple;
	bh=nNg8Lez5TyhenYYXSz/Z3HL7LmI7ZaYg/ePKv/jdIDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfQ/8J61zjaGiLItLPpSBlinDU/2shLdsPr2Cm38aaMlB1IJ6QF/GNwdFHBYgMLlxHDwjd6tNq6aWRSpqOXqFeMOUPFgicfSEzZlgaxTvnaEic8K3UGTTnNN4A7Z3u7VE5XEHdjEoB4ketjc3R+kJLDsZNTT3M3yaAulL2Aqx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTQJ7yIC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624748; x=1789160748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nNg8Lez5TyhenYYXSz/Z3HL7LmI7ZaYg/ePKv/jdIDE=;
  b=DTQJ7yICOAPimYTo7yRYH+iMHirtGfnDbuMzo9gijCvZ0toHEaEup1b8
   QUscYTS6Op6xq5dBqsYN0C3IsGmaPUc4XAQdQS/jomj1uvZa10CoZZk0d
   RLck1uCCUsAPB4xYiMCQaoK9+652xRbCng7UKiN0HeNwx0iqxvy7RHHWY
   g3AoXyRdURrSLyDFKBkjudxI1p/1zJKMLeWksKxqBiKowEjgEmLYPztEo
   qpBhkX3JZMHmQrB7WuqMlFSfxgF38+jV8S9qxK7I12PhFj93M20lirHzE
   HYkeq8KohqIokgE+4Z/kV6iu1iL/UfZwpvekIJLxvXglFt3vvx6QqJRwK
   g==;
X-CSE-ConnectionGUID: Gy/HNOFIRZy9FF2/fSptVQ==
X-CSE-MsgGUID: E+nO9Y4ZTqKJXmWYkA/oPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558959"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558959"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:47 -0700
X-CSE-ConnectionGUID: aN4o4eDVQIaeruVsob5SPg==
X-CSE-MsgGUID: a1j4zAGCRdm5QmxPgoXkrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583453"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 13/15] ice: reregister fwlog after driver reinit
Date: Thu, 11 Sep 2025 14:05:12 -0700
Message-ID: <20250911210525.345110-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
References: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Wrap libie_fwlog_register() by libie_fwlog_reregister(), which checks
first if the registration is needed. This simplifies the code and makes
the former function static.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fwlog.c | 11 ++++++++++-
 drivers/net/ethernet/intel/ice/ice_fwlog.h |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index cb2d3ff203c4..8e7086191030 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -290,7 +290,7 @@ static int libie_aq_fwlog_register(struct libie_fwlog *fwlog, bool reg)
  * After this call the PF will start to receive firmware logging based on the
  * configuration set in libie_fwlog_set.
  */
-int libie_fwlog_register(struct libie_fwlog *fwlog)
+static int libie_fwlog_register(struct libie_fwlog *fwlog)
 {
 	int status;
 
@@ -1095,3 +1095,12 @@ void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len)
 		libie_fwlog_ring_increment(&fwlog->ring.head, fwlog->ring.size);
 	}
 }
+
+void libie_fwlog_reregister(struct libie_fwlog *fwlog)
+{
+	if (!(fwlog->cfg.options & LIBIE_FWLOG_OPTION_IS_REGISTERED))
+		return;
+
+	if (libie_fwlog_register(fwlog))
+		fwlog->cfg.options &= ~LIBIE_FWLOG_OPTION_IS_REGISTERED;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 3698759c8ebb..e534205a2d04 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -79,6 +79,6 @@ struct libie_fwlog {
 
 int libie_fwlog_init(struct libie_fwlog *fwlog, struct libie_fwlog_api *api);
 void libie_fwlog_deinit(struct libie_fwlog *fwlog);
-int libie_fwlog_register(struct libie_fwlog *fwlog);
+void libie_fwlog_reregister(struct libie_fwlog *fwlog);
 void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len);
 #endif /* _LIBIE_FWLOG_H_ */
-- 
2.47.1


