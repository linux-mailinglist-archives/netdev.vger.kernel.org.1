Return-Path: <netdev+bounces-74975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBE2867A9B
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39993B27C61
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4655131754;
	Mon, 26 Feb 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JolEmY2L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F412FF83
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960326; cv=none; b=VnTj+ze8FLVQeFP8o7kyS3Mpi38P2cbPqBdJu5SQK61+mWMtI3CoIvPDggzi7ua6hCdPUB/WWZZjLsOk7W8hV1hY9KWRHLL4JVUkz2b79K7NvoRAIJ8xUP20di3mys6ZC+4L9fTS+K2OPrHNtAgpw1fErJzUJP8wJDtNaUjeOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960326; c=relaxed/simple;
	bh=ajSwOPKt2g3sItVQGJkG/STy6xTTsDrfZyZ+k9cpsfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shuHrtEFsvlgejmYXTKFGZLXmczsMq6WzLh+ZYvhT9ZakUcn+65/hxQg/fp/SKoZI/og8KNyGEoO6fNNJ5qZZDdqz5U+Jka7dSbUjHW/x36uvVimplEK2/7bBChoHqkUWVcOalgeNh3IJHlPqokJttxgg3EK8VJ2RBHsWrSio/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JolEmY2L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708960324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WVe7vsMe9lR2qfwwmPRKfxZe0asgb4zn2pd+IxD4So=;
	b=JolEmY2LaOuGGt5Gg2FWJ6wLMr+CYSo5SktR9aORytLpCz9BudPRksu6ASlpmZhqxkOhBT
	JKSU5cUZflu8AyGfbFm8its/lI24D9Q0kOLMoYmHrlxtMcPouhStqywIjtoT80n7l6+JS/
	XYzzDUqANhfzheM/t7bPC1fWpjbGIXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-FC2-jptIMoWCyTqRidptVA-1; Mon, 26 Feb 2024 10:11:59 -0500
X-MC-Unique: FC2-jptIMoWCyTqRidptVA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89754881C82;
	Mon, 26 Feb 2024 15:11:58 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.226.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C84DA492BC7;
	Mon, 26 Feb 2024 15:11:56 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] ice: fold ice_ptp_read_time into ice_ptp_gettimex64
Date: Mon, 26 Feb 2024 16:11:25 +0100
Message-ID: <20240226151125.45391-4-mschmidt@redhat.com>
In-Reply-To: <20240226151125.45391-1-mschmidt@redhat.com>
References: <20240226151125.45391-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

This is a cleanup. It is unnecessary to have this function just to call
another function.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 25 +++---------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b6c7246245c6..cb061966cc9e 100644
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


