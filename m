Return-Path: <netdev+bounces-199769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D032EAE1C1B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7654A759B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2EF2BD029;
	Fri, 20 Jun 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oTpxXXts";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kYUPSCEi"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6D29B23F;
	Fri, 20 Jun 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425888; cv=none; b=IkaXDCKn4xo+o0Kutwo3BdAx5Hd51I6B94B2QJFUxKsddpEaKPgt8FDM33UrjgEM10eQ/WE7mBchmxb+JfLXfEZwIR0yQqpA3k/azimoI+LQlmeCSKsMF9xOyGnF8tIMRMiy8RzpQIUPmfBGVIg9dYgif2VAoQfiPeOIrtkcA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425888; c=relaxed/simple;
	bh=aIu4PRiBcrsPPWLGSpmb6Xt9PwyMaFXJ5LYX9Cfj854=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HZkBq4CvdkxR84G6VQudQ1pIgk64wvnXC+n43hD4hhkFXeXga2/MJqA3XLoPkP7terYt2KrZN5HPR7pTq7kGpd/FN67oS5HZBQoWirsnUdE9m01Nl+oeshBWgSL9uigjrXQgw2sS8Fey/4fbFYlRZr3b59vlsmKePhBskpkpLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oTpxXXts; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kYUPSCEi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131944.344887489@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Gykaki7sViJDV0IpK1pJ16zNE8qYHNuR3Gz60NSphMQ=;
	b=oTpxXXtsSzqFDrjnhYulGVpRE7SOniui3ZqBZPAFsypVn4a4XbE+uFF7yYtyXxERJy37V7
	+J/BOiHy4ZmRPQM8x1eAzhAlhw947TcplXC2/Q0iDjA3isKFTLnzCmwkvfpLiHt2KC7q0w
	lsxp2/oo4QHNxQCWnj+dCz/TsPLee+40Uci0IhhYc4uP78nPgavDJ+zLukTIQQvlQXshmq
	YnXfOpTAqfiWG3HpMsF7SBjxNBhy31+SDWTvVJQTn7K0HhkkNxRkW3Rjneosq7SX4z85lR
	HXWALD1Wy8ikKIE3xNwXjsJ0rv8e9ncO1l8yu1MsS3uJOtGLQdXBAnR+xpL61Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Gykaki7sViJDV0IpK1pJ16zNE8qYHNuR3Gz60NSphMQ=;
	b=kYUPSCEilRfFP0LM2eU1I0kKcO8+h9ke+IaW1sgQD1naGCiTg0nVMgDzpNKykpnEgubyMa
	QUoEN2dly8okekDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 10/13] ptp: Split out PTP_MASK_CLEAR_ALL ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:44 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_MASK_CLEAR_ALL ioctl
code into a helper function.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -442,6 +442,12 @@ static long ptp_pin_setfunc(struct ptp_c
 		return ptp_set_pinfunc(ptp, pin_index, pd.func, pd.chan);
 }
 
+static long ptp_mask_clear_all(struct timestamp_event_queue *tsevq)
+{
+	bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);
+	return 0;
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
@@ -504,8 +510,7 @@ long ptp_ioctl(struct posix_clock_contex
 		return ptp_pin_setfunc(ptp, cmd, argptr);
 
 	case PTP_MASK_CLEAR_ALL:
-		bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);
-		break;
+		return ptp_mask_clear_all(pccontext->private_clkdata);
 
 	case PTP_MASK_EN_SINGLE:
 		if (copy_from_user(&i, (void __user *)arg, sizeof(i))) {


