Return-Path: <netdev+bounces-199761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E11AE1C0C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EA65A4F7A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3228ECFC;
	Fri, 20 Jun 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xz5H99Uw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AjXQvH6p"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A904328E5E6;
	Fri, 20 Jun 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425875; cv=none; b=JIJXBL3b6U2jagcAkshDJMaHjDnMCJD+QZXC587oxm/dUvJDNrJtvEhMhgFncaEhmCsJaYwT0qEQHWPCV+Dmq4SfkGRGO4nWGBC07/ypXqJfnMYZsRexR6YQaKHzA4pdSR38W0sH8mHSyaMkcjkSeqjjOXsOzdIPJV373Qfdmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425875; c=relaxed/simple;
	bh=OJYci7OAeG3QER5ikqywHKfyNhsvjsZ52UiSoWmu/R0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Z27rmnelma7fg1gK9OzrRSMFm+47p7shWhbTTnB0z0YRVouujJyJ1Q5gyXJDHPbD/cGNJ+8c3whzVHusZsh+afEjzAS47Uj8L48e8EYSI86wrODRnuH3wooicyqJkLGq34+PONJ67A9N1+O4mRtuwAsxP6nImdsutBD44EnF2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xz5H99Uw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AjXQvH6p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131943.905398183@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Kp6AT3TDorAUKTxQ1OJvaUJt91Mt2okSRa5ponWtJlY=;
	b=Xz5H99UwulA/KNUGm6P0KSmoV3Pd5YE1/k6DIU9ztNeg6xUnHxafWAVr3TIm+VihHR1Hqa
	gkB3nVRmCZiZNjlxypIWTlStLBCNcsyeNlqDOZgta3ISncvgQbqwLYcI47MlzTKR1d5rcz
	1+ZHCgk+IE4Vz+WrqEpQUZDgHn+xOWFvcGBV4vIUjITawGCNsl5mcIDYe1WvoOux5HhAul
	LftcQhso6sVpF2XBy0B+FbfIEmLnw1PKddraH9wASKlUGGiImZ5ZYh4kv86E9GaYt8XjR7
	tLutsfLPsjq5oGnQ7n7c3Ke22kwPVAmh9ph7qjYlEIwdAzA3mXr0u6xzRd2R9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Kp6AT3TDorAUKTxQ1OJvaUJt91Mt2okSRa5ponWtJlY=;
	b=AjXQvH6pPCGau3qk9ZpCuoY16iFI56xNsGXiYvbHSpmxcSDxWSaoXBGvGEXxLenajf+E/e
	8cUq6Bc12An/QOCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 03/13] ptp: Split out PTP_PEROUT_REQUEST ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:31 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_PEROUT_REQUEST
ioctl code into a helper function. Convert to a lock guard while at it.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |  129 ++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 71 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -223,6 +223,61 @@ static long ptp_extts_request(struct ptp
 		return ops->enable(ops, &req, req.extts.flags & PTP_ENABLE_FEATURE ? 1 : 0);
 }
 
+static long ptp_perout_request(struct ptp_clock *ptp, unsigned int cmd, void __user *arg)
+{
+	struct ptp_clock_request req = { .type = PTP_CLK_REQ_PEROUT };
+	struct ptp_perout_request *perout = &req.perout;
+	struct ptp_clock_info *ops = ptp->info;
+
+	if (copy_from_user(perout, arg, sizeof(*perout)))
+		return -EFAULT;
+
+	if (cmd == PTP_PEROUT_REQUEST2) {
+		if (perout->flags & ~PTP_PEROUT_VALID_FLAGS)
+			return -EINVAL;
+
+		/*
+		 * The "on" field has undefined meaning if
+		 * PTP_PEROUT_DUTY_CYCLE isn't set, we must still treat it
+		 * as reserved, which must be set to zero.
+		 */
+		if (!(perout->flags & PTP_PEROUT_DUTY_CYCLE) &&
+		    !mem_is_zero(perout->rsv, sizeof(perout->rsv)))
+			return -EINVAL;
+
+		if (perout->flags & PTP_PEROUT_DUTY_CYCLE) {
+			/* The duty cycle must be subunitary. */
+			if (perout->on.sec > perout->period.sec ||
+			    (perout->on.sec == perout->period.sec &&
+			     perout->on.nsec > perout->period.nsec))
+				return -ERANGE;
+		}
+
+		if (perout->flags & PTP_PEROUT_PHASE) {
+			/*
+			 * The phase should be specified modulo the period,
+			 * therefore anything equal or larger than 1 period
+			 * is invalid.
+			 */
+			if (perout->phase.sec > perout->period.sec ||
+			    (perout->phase.sec == perout->period.sec &&
+			     perout->phase.nsec >= perout->period.nsec))
+				return -ERANGE;
+		}
+	} else {
+		perout->flags &= PTP_PEROUT_V1_VALID_FLAGS;
+		memset(perout->rsv, 0, sizeof(perout->rsv));
+	}
+
+	if (perout->index >= ops->n_per_out)
+		return -EINVAL;
+	if (perout->flags & ~ops->supported_perout_flags)
+		return -EOPNOTSUPP;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
+		return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
@@ -262,77 +317,9 @@ long ptp_ioctl(struct posix_clock_contex
 
 	case PTP_PEROUT_REQUEST:
 	case PTP_PEROUT_REQUEST2:
-		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
-			err = -EACCES;
-			break;
-		}
-		memset(&req, 0, sizeof(req));
-
-		if (copy_from_user(&req.perout, (void __user *)arg,
-				   sizeof(req.perout))) {
-			err = -EFAULT;
-			break;
-		}
-		if (cmd == PTP_PEROUT_REQUEST2) {
-			struct ptp_perout_request *perout = &req.perout;
-
-			if (perout->flags & ~PTP_PEROUT_VALID_FLAGS) {
-				err = -EINVAL;
-				break;
-			}
-			/*
-			 * The "on" field has undefined meaning if
-			 * PTP_PEROUT_DUTY_CYCLE isn't set, we must still treat
-			 * it as reserved, which must be set to zero.
-			 */
-			if (!(perout->flags & PTP_PEROUT_DUTY_CYCLE) &&
-			    (perout->rsv[0] || perout->rsv[1] ||
-			     perout->rsv[2] || perout->rsv[3])) {
-				err = -EINVAL;
-				break;
-			}
-			if (perout->flags & PTP_PEROUT_DUTY_CYCLE) {
-				/* The duty cycle must be subunitary. */
-				if (perout->on.sec > perout->period.sec ||
-				    (perout->on.sec == perout->period.sec &&
-				     perout->on.nsec > perout->period.nsec)) {
-					err = -ERANGE;
-					break;
-				}
-			}
-			if (perout->flags & PTP_PEROUT_PHASE) {
-				/*
-				 * The phase should be specified modulo the
-				 * period, therefore anything equal or larger
-				 * than 1 period is invalid.
-				 */
-				if (perout->phase.sec > perout->period.sec ||
-				    (perout->phase.sec == perout->period.sec &&
-				     perout->phase.nsec >= perout->period.nsec)) {
-					err = -ERANGE;
-					break;
-				}
-			}
-		} else if (cmd == PTP_PEROUT_REQUEST) {
-			req.perout.flags &= PTP_PEROUT_V1_VALID_FLAGS;
-			req.perout.rsv[0] = 0;
-			req.perout.rsv[1] = 0;
-			req.perout.rsv[2] = 0;
-			req.perout.rsv[3] = 0;
-		}
-		if (req.perout.index >= ops->n_per_out) {
-			err = -EINVAL;
-			break;
-		}
-		if (req.perout.flags & ~ptp->info->supported_perout_flags)
-			return -EOPNOTSUPP;
-		req.type = PTP_CLK_REQ_PEROUT;
-		enable = req.perout.period.sec || req.perout.period.nsec;
-		if (mutex_lock_interruptible(&ptp->pincfg_mux))
-			return -ERESTARTSYS;
-		err = ops->enable(ops, &req, enable);
-		mutex_unlock(&ptp->pincfg_mux);
-		break;
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0)
+			return -EACCES;
+		return ptp_perout_request(ptp, cmd, argptr);
 
 	case PTP_ENABLE_PPS:
 	case PTP_ENABLE_PPS2:


