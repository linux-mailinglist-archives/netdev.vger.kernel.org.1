Return-Path: <netdev+bounces-81856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA9A88B536
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 00:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF442C8062
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410DC82D9A;
	Mon, 25 Mar 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwmcHqyA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A56482D9B
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408894; cv=none; b=regf/160K40VOeZZkLfsj/ogEBzISVvns2+yLsZpJpRifA+d7KivGpQDb+cw2+k8peIxh4tJ+PH+NXBEhabzrXVpIpSDgLUYZFVEYWTUFJLSZit0mCissa4D6VcsFP3is92JmvzD4ILkA4y7vUlFetw63jJRjTvEQ8WuMjSURF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408894; c=relaxed/simple;
	bh=GTwgS5+lI06vaIg9nEie8aGVWRxINIiKhwLB39wSQMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8MLGGwsroJ9NQos3e5FI7tF6MyohNiqskyVBU86TGbZKIxqS+nSpW2VXDdLl4BN9xtZ/5wez/jpfsjCcizu4whguW9tVbwo/3oTCDzJaPAzdKItoAyvVHqcfKd9WG8V2Lzy5YYDNfo9QO24qsDtBoWvqAEcbt+pRY2/T9BXZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwmcHqyA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711408890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGd5P27OAv5OFt6fz1lFKfOAMYgxcy0CeGG/K5oDSa8=;
	b=XwmcHqyAzrmfRmxVWnqQZqCrr7Hxog1YfmUqa/6ZsnMEBJkJbXC1xlFML9uOlW8MxQA3uu
	2nwBrMvcciS0G975LKQqbsOICF1yNwIqZ7TD/kIVHNbysYNWbLN8SjzorpnyOfbdct9cOD
	2LhEmp9yHMGJgQK1sQFPh6O6qddGHlE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-zRDio62IMMqebv4sWYnXIQ-1; Mon,
 25 Mar 2024 19:21:24 -0400
X-MC-Unique: zRDio62IMMqebv4sWYnXIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 481731C05EAE;
	Mon, 25 Mar 2024 23:21:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.113])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95EC61C060A4;
	Mon, 25 Mar 2024 23:21:20 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
Subject: [PATCH net-next v4 3/3] ice: fold ice_ptp_read_time into ice_ptp_gettimex64
Date: Tue, 26 Mar 2024 00:20:39 +0100
Message-ID: <20240325232039.76836-4-mschmidt@redhat.com>
In-Reply-To: <20240325232039.76836-1-mschmidt@redhat.com>
References: <20240325232039.76836-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

This is a cleanup. It is unnecessary to have this function just to call
another function.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
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


