Return-Path: <netdev+bounces-78019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D22B873C48
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3252282876
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0A013A89D;
	Wed,  6 Mar 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKSE2K7D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94A13A246
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742611; cv=none; b=thCs0D9aU9h6Pim5Vh1ATE8iZCyRS6kQEYOp7IlEdsLzab1DNLu/gDOtRyEaL7PPS6COX2s3OqafiZOmpim1ofID00AcVMHn7jjbUTmuoXMIoCV+NVbbtGMj0WNkjBeZSbosDANfOZTctnWiSuViElu5/yTe5leMPj3Qbnb4fIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742611; c=relaxed/simple;
	bh=JaXAMgruNSSbD1f4FlCgFPf1bCTVECRO/0D250xzjKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A89fnZlE1jlFhU/QYFg/VCIkbGQnXO0EAdyojlbCbSIIxcivBCbm35kzOvyGlhOLiLTpVQlkLIDgvQ+Y5C6u+7shzJwYOPukzdbEn9RetB0BhmJ4Vn0kYGpZvBMr2YEFKkQEtHb9U0y0Kl16JQ75Q3wmsQ5jj5kDro7ukdHXWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKSE2K7D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709742609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTGE09xtnIme6+GRFUjACMeP0HPOQDGOO8CtxR+SQkQ=;
	b=NKSE2K7D1QMYuUl4XXrFMaX7iDIxcLF94SKrcj7TPnWRQFjgh7SBJZPsvUmoOuAdb/NMR8
	W95NZbr60GjPls5CzfER3w2a7FjOAtslhG8fJG4z/9VEUKcMQya+FLuXa+I89PreukpA1E
	jrGybb5fldexLBKTQio9PFr1go1enZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-WXPhzIXCON29OO9j5Q-ArA-1; Wed, 06 Mar 2024 11:30:04 -0500
X-MC-Unique: WXPhzIXCON29OO9j5Q-ArA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C004800266;
	Wed,  6 Mar 2024 16:30:04 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.224.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0C954073436;
	Wed,  6 Mar 2024 16:30:01 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH net-next v2 3/3] ice: fold ice_ptp_read_time into ice_ptp_gettimex64
Date: Wed,  6 Mar 2024 17:29:07 +0100
Message-ID: <20240306162907.84247-4-mschmidt@redhat.com>
In-Reply-To: <20240306162907.84247-1-mschmidt@redhat.com>
References: <20240306162907.84247-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

This is a cleanup. It is unnecessary to have this function just to call
another function.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 25 +++---------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0875f37add78..0f17fc1181d2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1166,26 +1166,6 @@ static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 	ice_ptp_mark_tx_tracker_stale(&pf->ptp.port.tx);
 }
 
-/**
- * ice_ptp_read_time - Read the time from the device
- * @pf: Board private structure
- * @ts: timespec structure to hold the current time value
- * @sts: Optional parameter for holding a pair of system timestamps from
- *       the system clock. Will be ignored if NULL is given.
- *
- * This function reads the source clock registers and stores them in a timespec.
- * However, since the registers are 64 bits of nanoseconds, we must convert the
- * result to a timespec before we can return.
- */
-static void
-ice_ptp_read_time(struct ice_pf *pf, struct timespec64 *ts,
-		  struct ptp_system_timestamp *sts)
-{
-	u64 time_ns = ice_ptp_read_src_clk_reg(pf, sts);
-
-	*ts = ns_to_timespec64(time_ns);
-}
-
 /**
  * ice_ptp_write_init - Set PHC time to provided value
  * @pf: Board private structure
@@ -1926,9 +1906,10 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
 		   struct ptp_system_timestamp *sts)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
+	u64 time_ns;
 
-	ice_ptp_read_time(pf, ts, sts);
-
+	time_ns = ice_ptp_read_src_clk_reg(pf, sts);
+	*ts = ns_to_timespec64(time_ns);
 	return 0;
 }
 
-- 
2.43.2


