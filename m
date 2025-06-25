Return-Path: <netdev+bounces-201111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C834CAE8218
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20513B9B67
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658E8265282;
	Wed, 25 Jun 2025 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DNdAXql7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BI2eQrTm"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE72264605;
	Wed, 25 Jun 2025 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852360; cv=none; b=q7z7fXM74UiJj8TcdjY75LrsXp5q9+oduQfgITdA7wbHa74jSzZgeOBeC9x1FnoCrn9c5vsdvH8O3B0tGQrxtTJplCqHG/92ofcHlfF1Ttuc1jEHsfRtEDGS/6FtPNaAu9t/XvidDQOIhHLXUtQfdUpoIlavtBXQaxoeFJct3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852360; c=relaxed/simple;
	bh=yp4cQ7SyrZb/h1H/bAPLKYT41i6JWxcxpTEUlSOTBiE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Hx1rIY0KZAOxySd9KqKYi6kWwEuKQvqaUz6FZt2bb7xJOR0SkMTQYX250BDGs6wZgXdoR55jpy6sLbExUbGzR/h+MH5tij2XPDl95tQzQ7nfWP1/I67E5AF3uAaH/cCitpbTz3XV9gIj89XtYTCkvGede5WOHzGQNiI6hbn356Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DNdAXql7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BI2eQrTm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115133.364422719@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ySI5aByKOimt5iQ+JtZosgPpWha4hSg8x1EopuuGh3I=;
	b=DNdAXql74VWV7S+VrdvaSI9ctWL6qyFJqD+GwUnKjUwnslAo4+CIP2LYb14M+dEvINME9e
	/14xr31hhnJ3gP5it2x6Azzfi95l6K6ZtQ5myQDhI7DrCYD0vLsB6zakvwz4SuOjYr5FPt
	2swD5xhZWw0k2sDjXBypQ5z3/QdDkHdD/KaHvDL7ldVMz414sEdZ9V1cgGLhk9MJxgvprj
	Brl05w0iBm00ZgBjuRXzyWoC8OelfXQRMy4hIPwm3OGOAV6mJ1mwXOIOVpENqMxVGGIMuO
	PfB1/xLkZjNuzciVnWxlhmmkvxlGSzTGVEBzIEh5F//DTTnhROVJT1TXEO7+gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ySI5aByKOimt5iQ+JtZosgPpWha4hSg8x1EopuuGh3I=;
	b=BI2eQrTmn0mqU3fvwt3iXDXZQpIZzShpgB79FcLyUQkf+L9V4KGRSaL6pAJCkVVXuW0UV1
	nIp+35HBU/BdaUDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 11/13] ptp: Split out PTP_MASK_EN_SINGLE ioctl code
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:36 +0200 (CEST)

Finish the ptp_ioctl() cleanup by splitting out the PTP_MASK_EN_SINGLE
ioctl code and removing the remaining local variables and return
statements.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

---
 drivers/ptp/ptp_chardev.c |   35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -448,22 +448,28 @@ static long ptp_mask_clear_all(struct ti
 	return 0;
 }
 
+static long ptp_mask_en_single(struct timestamp_event_queue *tsevq, void __user *arg)
+{
+	unsigned int channel;
+
+	if (copy_from_user(&channel, arg, sizeof(channel)))
+		return -EFAULT;
+	if (channel >= PTP_MAX_CHANNELS)
+		return -EFAULT;
+	set_bit(channel, tsevq->mask);
+	return 0;
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
-	struct ptp_clock *ptp =
-		container_of(pccontext->clk, struct ptp_clock, clock);
-	struct timestamp_event_queue *tsevq;
+	struct ptp_clock *ptp = container_of(pccontext->clk, struct ptp_clock, clock);
 	void __user *argptr;
-	unsigned int i;
-	int err = 0;
 
 	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
 		arg = (unsigned long)compat_ptr(arg);
 	argptr = (void __force __user *)arg;
 
-	tsevq = pccontext->private_clkdata;
-
 	switch (cmd) {
 	case PTP_CLOCK_GETCAPS:
 	case PTP_CLOCK_GETCAPS2:
@@ -513,22 +519,11 @@ long ptp_ioctl(struct posix_clock_contex
 		return ptp_mask_clear_all(pccontext->private_clkdata);
 
 	case PTP_MASK_EN_SINGLE:
-		if (copy_from_user(&i, (void __user *)arg, sizeof(i))) {
-			err = -EFAULT;
-			break;
-		}
-		if (i >= PTP_MAX_CHANNELS) {
-			err = -EFAULT;
-			break;
-		}
-		set_bit(i, tsevq->mask);
-		break;
+		return ptp_mask_en_single(pccontext->private_clkdata, argptr);
 
 	default:
-		err = -ENOTTY;
-		break;
+		return -ENOTTY;
 	}
-	return err;
 }
 
 __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,




