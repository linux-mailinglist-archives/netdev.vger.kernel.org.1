Return-Path: <netdev+bounces-118031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0635E9505B0
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD51C20D71
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A619CCF0;
	Tue, 13 Aug 2024 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="hOhWombx"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8F19CCEB
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553781; cv=pass; b=QjpgkDXmBCAH+ooGs7JfQXuoxQN707kZx6f7aOflvTGCOo1z7XwKIBr78NDeMTctILQ8CtVjWW+84sZMeiiMOD8s5GEJ0lmwG5NwMjqR9mjinm8vOSMEE2lbuiVYXxKRMXdEIokRcEEKTys2AnyL7FbrYF+5i7JaAtxe/y4UvHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553781; c=relaxed/simple;
	bh=x3eqkVjDGJOI1g3dhzXuFryvDbHTzYbhfzIJzBqlJuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LoI6p65Xh8FjbT4SGk5siYnl/W9OAholxhPv43UliKcMzMw0t3Yr0Up8BxZQUd9H7FVvhMSCl6omVEiHlJkrGWK14sbqbMkZ899dfoKaaLyw4KMNzZWxl8CEvu/bBgKdsUs3pvumqNKBwCLQJkqoBmI88RN5+6To96J9Vv1USRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=hOhWombx; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Delivered-To: maciek@machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723553773; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iqvqBBYIrNivtdV90vdcpacqxwHGYrWrsfuOYxLjpB/nzQuZbC+N4uemELAt1ooVwrGkj9DsN6AjnMamkmDlFMV51CNxAVU3wEJaJTUGayoU4gCBKjeSTxBGkfaes6RyvGcagGpTxMSUp1G8chUmr4B1Gjpqv0rYTBFuMEOfZNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723553773; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C3WRiby8Wq8K7hvlbeM8eLrIDuE2Hz1HiitaBp9tZok=; 
	b=PZAuJW4u9cRMlRaBf8Oaapfo8dXMqF9EPhoX/wLyRrvBM28Ps1+Wh7W0BPeOjIst/6GgJWzfMgGWMCwRni2w5nW5nPT3mnyQj7QB+Wdi4F6sj+UZ3j38o+ra6SDebgae5rOK1g1VxebdVwo5VD6tjl6bYI2eROTY6ObMYIeG0Rw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723553773;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=C3WRiby8Wq8K7hvlbeM8eLrIDuE2Hz1HiitaBp9tZok=;
	b=hOhWombxE36+Fps57cRvIBa+AQ943ilRxtTAuGONb/gy4T0TXooS7V6AtM2UCKQj
	qyI9pQaxzqfbHIZMLz8IHZKo+eau/kFc5cnC01DzMMmgNBcmWjEzY2NPbj7pf8/vJTI
	dv/13AkZzH0zVJ+OhND5yAqvUgENEGetlaOsZy3RY2X4P7dnjNxB7ZYvcaKhFyrLZia
	V92PklRhgU1/9bfPyjGUrXfdVHewe4sJV94pk+gKF2CBcwY3UWA3mJjcQiIgZ9fnQEF
	71tXwSc+EvU/PhgsmizJerWu2WGsOXSAHuGmRzdpWXQF5GtWDRlF/EC+lNUxN5WOT3Q
	XPBE3HHsLQ==
Received: by mx.zohomail.com with SMTPS id 172355377056920.89656851491634;
	Tue, 13 Aug 2024 05:56:10 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: maciek@machnikowski.net
Cc: netdev@vger.kernel.org,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	vadfed@meta.com,
	darinzon@amazon.com,
	kuba@kernel.org
Subject: [RFC 1/3] ptp: Implement timex esterror support
Date: Tue, 13 Aug 2024 12:56:00 +0000
Message-Id: <20240813125602.155827-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813125602.155827-1-maciek@machnikowski.net>
References: <20240813125602.155827-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The Timex structure returned by the clock_adjtime() POSIX API allows
the clock to return the estimated error. Implement getesterror
and setesterror functions in the ptp_clock_info to enable drivers
to interact with the hardware to get the error information.

getesterror additionally implements returning hw_ts and sys_ts
to enable upper layers to estimate the maximum error of the clock
based on the last time of correction. This functionality is not
directly implemented in the clock_adjtime and will require
a separate interface in the future.

Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/ptp/ptp_clock.c          | 18 +++++++++++++++++-
 include/linux/ptp_clock_kernel.h | 11 +++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c56cd0f63909..2cb1f6af60ea 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -164,9 +164,25 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 
 			err = ops->adjphase(ops, offset);
 		}
+	} else if (tx->modes & ADJ_ESTERROR) {
+		if (ops->setesterror)
+			if (tx->modes & ADJ_NANO)
+				err = ops->setesterror(ops, tx->esterror * 1000);
+			else
+				err = ops->setesterror(ops, tx->esterror);
 	} else if (tx->modes == 0) {
+		long esterror;
+
 		tx->freq = ptp->dialed_frequency;
-		err = 0;
+		if (ops->getesterror) {
+			err = ops->getesterror(ops, &esterror, NULL, NULL);
+			if (err)
+				return err;
+			tx->modes &= ADJ_NANO;
+			tx->esterror = esterror;
+		} else {
+			err = 0;
+		}
 	}
 
 	return err;
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 6e4b8206c7d0..e78ea81fc4cf 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -136,6 +136,14 @@ struct ptp_system_timestamp {
  *                   parameter cts: Contains timestamp (device,system) pair,
  *                   where system time is realtime and monotonic.
  *
+ * @getesterror: Reads the current error estimate of the hardware clock.
+ *               parameter phase: Holds the error estimate in nanoseconds.
+ *               parameter hw_ts: If not NULL, holds the timestamp of the hardware clock.
+ *               parameter sw_ts: If not NULL, holds the timestamp of the CPU clock.
+ *
+ * @setesterror:  Set the error estimate of the hardware clock.
+ *                parameter phase: Desired error estimate in nanoseconds.
+ *
  * @enable:   Request driver to enable or disable an ancillary feature.
  *            parameter request: Desired resource to enable or disable.
  *            parameter on: Caller passes one to enable or zero to disable.
@@ -188,6 +196,9 @@ struct ptp_clock_info {
 			    struct ptp_system_timestamp *sts);
 	int (*getcrosscycles)(struct ptp_clock_info *ptp,
 			      struct system_device_crosststamp *cts);
+	int (*getesterror)(struct ptp_clock_info *ptp, long *phase,
+			   struct timespec64 *hw_ts, struct timespec64 *sys_ts);
+	int (*setesterror)(struct ptp_clock_info *ptp, long phase);
 	int (*enable)(struct ptp_clock_info *ptp,
 		      struct ptp_clock_request *request, int on);
 	int (*verify)(struct ptp_clock_info *ptp, unsigned int pin,
-- 
2.34.1


