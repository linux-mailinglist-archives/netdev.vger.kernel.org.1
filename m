Return-Path: <netdev+bounces-201103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4ACAE8204
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D691BC48D1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F80B25F79C;
	Wed, 25 Jun 2025 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7TFQyri";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nmmPPJhs"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32725DD0F;
	Wed, 25 Jun 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852350; cv=none; b=OM44QhhIusFuEXt2TJ0WvAFClOXpzKerKntx9F/WRPnWmxOkKC+4qukCsXjF+JfbB8wFWJ+OmRFjj8JKGztwuzAsXe1DcvQetT8UN3Ocl9uorbZUiMzXtlBIPN2LJEMExluSvgGf4zewev3i69x1yRTABAB5d7H5OW0fycbeD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852350; c=relaxed/simple;
	bh=6RlVzs3fCOAd4qRWS/7kult/RAF8dXFwcDnWfa4rByA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=b+Sr9hGLwjQpckeh8fE2N7+3NxNrxYuKBx/Re9PsMPa4pjrPa3OFyIRzTAydwBFhrIei4RZ8EKJr/Dlo6O8aTTzG3CXzepSbfGP1MpFpsdhOKXhBlmMZYvJTxRYbjmAPClRzNsqOeDQt7XA/NU8XMbIBAmPfjfKYepZWHEDvLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7TFQyri; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nmmPPJhs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115132.860150473@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zgoZ/RSkDk5K7pseXzJ0rfM5eJzM2/RwyA4demwcSB8=;
	b=t7TFQyri+pM5/wTS2RWiuwjMFBkh//QrzWxByB1BWW6gJtgBV2zIBrB7iNxM1u8FLanAQz
	h90v9xv8Vw7TPkziptZdrTXq6ECrrdMZ2+dxylg3DxWZjls9e4HYKhPVRuxE88oxlcVys9
	jV9ws/GaT4FmFzV1/yL/n40XqV5MqBLnDo8h7osZG5SradsZQqzPBs9UGSYzfUETkkDDH5
	EWA6xnRcteykwKI7eON89N6QE2TOVHkCWgJv5R3ixY/vjzBQsolHRdclSh27xjWHivGcR8
	92TJPiyHUgcRRm8nToRWTOF0GNMaGzsLfnzQi8zAxc+2xDft65O/lvoJMynpUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zgoZ/RSkDk5K7pseXzJ0rfM5eJzM2/RwyA4demwcSB8=;
	b=nmmPPJhsz/mN2HSo1OGGdGuFMa5RgwTNfkAQGQWJSdZs2/9CA6hScF6y9SdjMw5gkzbDSB
	xFLiOgnqhRB33rBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 03/13] ptp: Split out PTP_PEROUT_REQUEST ioctl code
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:27 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_PEROUT_REQUEST
ioctl code into a helper function. Convert to a lock guard while at it.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

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




