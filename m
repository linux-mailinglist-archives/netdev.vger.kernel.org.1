Return-Path: <netdev+bounces-290341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE6oIHnfDmoVCwYAu9opvQ
	(envelope-from <netdev+bounces-290341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:33:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E86CA5A35EA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CD0A30A8B57
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922063A0EB3;
	Thu, 21 May 2026 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiiQq5Wp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882C39EF1C
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359393; cv=none; b=I77T9e66l2iDijGHr34Yj5qrIOdxMwdrK/L+NWUaJMUiKdKp1EkLmT8tsSuoRrnDHIHDvvcalKF/3X1KQ2Sy8RjR+fUthwYqiLYWsOMYsx7b09QZ4PwauMN5TErtFQd50YyC13MfHw/f5IEtpliyzKPJQlWvfBj0UPa3SDHU+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359393; c=relaxed/simple;
	bh=4P/zfAkb0g8d+gw+ZEAI4bYPL3nLbN1wptaJAr4uEsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E24ilNZGTEdZUuDyXZaMgpwiteoGT0s6qgpUaQMTIFAl1Kdj5lMZeqA9cj1tjSZPmDXofGTYppaB0FvLTJ/eYJ01sNMl+4JicX8EHm6VrN3k0B7h6VwbiL2Yk0hghP31h2gRpbjUOV8JTJ1/7cvvoqvS0WTHoUrqfHakT2ET62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiiQq5Wp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779359391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ik2DCw78SxIVih/zQgvUo9wf5E1reoJnk6xvWC1gUYc=;
	b=KiiQq5WphfnwDSVN/yVTWg51Ih8KdRf2MPCsKghWrGLNm9MJRx+bRfttMUe/BjMGIkQHb3
	UfvNquOdooYpBsieSKBWf/2E78xY1ryWVWpXjhcAxskIOzhhQhi8IN35nAFV8u+xceE9/i
	LMtOh1EuyoBKWcS2MlvSIb65TL5PVYY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-CWAEpgTSOBeDsJGEsr0Wzg-1; Thu,
 21 May 2026 06:29:46 -0400
X-MC-Unique: CWAEpgTSOBeDsJGEsr0Wzg-1
X-Mimecast-MFC-AGG-ID: CWAEpgTSOBeDsJGEsr0Wzg_1779359384
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12BE919560A7;
	Thu, 21 May 2026 10:29:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.233])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8407E300019F;
	Thu, 21 May 2026 10:29:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: tim770802@gmail.com
Cc: netdev@vger.kernel.org,
	tim.jh.chen@wnc.com.tw,
	chandrashekar.devegowda@intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wwan: t7xx: fix race between TX thread and system PM suspend
Date: Thu, 21 May 2026 12:29:33 +0200
Message-ID: <20260521102933.126040-1-pabeni@redhat.com>
In-Reply-To: <20260518075033.58996-1-tim.jh.chen@wnc.com.tw>
References: <20260518075033.58996-1-tim.jh.chen@wnc.com.tw>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,wnc.com.tw,intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-290341-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: E86CA5A35EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: wwan: t7xx: fix race between TX thread and system PM suspend

This patch addresses a soft lockup observed when system suspend races with
the DPMAIF TX kthread. It updates dpmaif_ctrl->state in the suspend and
resume callbacks and adds a second state check in
t7xx_dpmaif_tx_hw_push_thread() before pm_runtime_resume_and_get().

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
> index 7ff33c1d6ac7..315a77e2465a 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
> @@ -451,6 +453,7 @@ static int t7xx_dpmaif_resume(struct t7xx_pci_dev *t7xx_dev, void *param)
>  	if (!dpmaif_ctrl)
>  		return 0;
>  
> +	dpmaif_ctrl->state = DPMAIF_STATE_PWRON;
>  	t7xx_dpmaif_start_txrx_qs(dpmaif_ctrl);
>  	t7xx_dpmaif_enable_irq(dpmaif_ctrl);
>  	t7xx_dpmaif_unmask_dlq_intr(dpmaif_ctrl);

[High]
Is the unconditional assignment to DPMAIF_STATE_PWRON safe when the modem
was not running before suspend?

Prior to this patch neither suspend nor resume modified dpmaif_ctrl->state,
so a modem that had been moved to DPMAIF_STATE_PWROFF via
t7xx_dpmaif_md_state_callback() (for MD_STATE_STOPPED or MD_STATE_EXCEPTION,
which calls t7xx_dpmaif_stop()) stayed PWROFF across a suspend/resume cycle.

After the patch t7xx_dpmaif_resume() forces state to PWRON and also
restores que_started=true via t7xx_dpmaif_start_txrx_qs(). The TX kthread's
state guard then permits it to proceed:

	if (dpmaif_ctrl->state != DPMAIF_STATE_PWRON)
		continue;

	ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
	...
	t7xx_do_tx_hw_push(dpmaif_ctrl);

Could this cause TX HW writes against a modem that the MD state machine
considers stopped or in exception?

The commit message describes the resume change as "symmetric with the
suspend change", but the suspend transition (PWRON -> PWROFF) tracks an
actual HW teardown, while the resume transition forces PWRON regardless of
the prior MD-driven state. Should the resume path only restore PWRON when
the modem was PWRON before suspend?

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> index 236d632cf591..d5a5befec71e 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> @@ -460,6 +460,9 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
>  				break;
>  		}
>  
> +		if (dpmaif_ctrl->state != DPMAIF_STATE_PWRON)
> +			continue;
> +
>  		ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
>  		if (ret < 0 && ret != -EACCES)
>  			return ret;

[Medium]
Does this new check actually close the TOCTOU window described in the
commit message, or does it just narrow it?

dpmaif_ctrl->state is a plain enum read here without any lock,
READ_ONCE/WRITE_ONCE, or memory barrier. It is also written without
locking by t7xx_dpmaif_suspend(), t7xx_dpmaif_resume(), t7xx_dpmaif_start(),
and t7xx_dpmaif_stop() (via t7xx_dpmaif_md_state_callback()), and read
without locking from t7xx_do_tx_hw_push() and the ISR path.

After this new check passes, can the system PM suspend path still set
state = DPMAIF_STATE_PWROFF on another CPU and grab the PM spinlock before
this thread reaches pm_runtime_resume_and_get(), reproducing the same
deadlock the patch is intended to fix?

The commit message states:

	add a second state check immediately before
	pm_runtime_resume_and_get() to close the TOCTOU window between
	the wait_event guard and the pm call.

Given that the window between the new check and the pm_runtime call is
non-zero and the flag has no synchronization, would it be more accurate to
say the window is reduced rather than closed?

For reference, Documentation-style guidance on flags-as-locks (the gate
guard pattern of reading a flag and then operating on shared state without
holding a lock) suggests using a real mutex/spinlock or a completion that
suspend waits on, so the kthread's PM reference is guaranteed to be
dropped before the suspend path runs. Would something along those lines be
a better fit here?
-- 
This is an AI-generated review.


