Return-Path: <netdev+bounces-287875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG9AL8uUBWpLYwIAu9opvQ
	(envelope-from <netdev+bounces-287875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:24:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC853FBCC
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15B1A300FB1A
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B2639A070;
	Thu, 14 May 2026 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5SU/LBW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42662399007
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750652; cv=none; b=QLfFqOz8+GVt3n0dMqby1F5RjFHzGzHasI+uBGKnVDTITF0cc+pLhFXEenqxttQOe2E+HKSmSa3n0RLk3WHwl/ilaZHVYXVMEMgK0gtN4ihADbm8oLnC/TUlC4SoYin5o+meOxFziCG+UZETubcKb6psEYurconL4iLdVBfj2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750652; c=relaxed/simple;
	bh=fpTH+nIt3dpOZScMWmumD99eTm9JG+U/OuMfSOpsDJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZ05zaYx+9VvGzaMDf7x+SzrlMs6LQm1g7rs7PKe7YEfZV0E+LYrvotNbqkjH7l6+yli6NwOkEy/kdOLb3pL6AAhmMkZ+v8ROIxWY4RrtR8JFXn1kqgd1jVrHnqfZ7r1lbKhbGhaWXGIbNlDZWEH3WXwVMnTGZtW3zYNGT2Wsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5SU/LBW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778750649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAb+nCHzeS/VFm4KncSYdknD7kA3Pr4qWEBvMKTKggI=;
	b=G5SU/LBWOg63OH4HExUiELmp32EBwg7yvALmE6ACCwrUD28g85mpHEXJ1+KockJRDVoJtm
	CbsBaAYQuGWcABHTPP2quaHJHcf4xQqn1yH5rFjN+DsN1xp9Ls0P/gEylbKe1WB9UxpNq5
	f1FXnqnHrLq61mRPGPFQEjIWkLMqMSY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-jY02ZgFWPIiwBAfN5hJ71Q-1; Thu,
 14 May 2026 05:24:03 -0400
X-MC-Unique: jY02ZgFWPIiwBAfN5hJ71Q-1
X-Mimecast-MFC-AGG-ID: jY02ZgFWPIiwBAfN5hJ71Q_1778750641
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EF521956080;
	Thu, 14 May 2026 09:24:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7956E30001A2;
	Thu, 14 May 2026 09:23:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	kees@kernel.org,
	larysa.zaremba@intel.com,
	leitao@debian.org,
	joe@dama.to,
	jacob.e.keller@intel.com,
	fabio.baltieri@gmail.com
Subject: Re: [PATCH net-next v3 2/5] net: wangxun: add Tx timeout process
Date: Thu, 14 May 2026 11:23:46 +0200
Message-ID: <20260514092346.90833-1-pabeni@redhat.com>
In-Reply-To: <20260509100540.32612-3-jiawenwu@trustnetic.com>
References: <20260509100540.32612-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: C3AC853FBCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287875-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: wangxun: add Tx timeout process

This patch implements .ndo_tx_timeout for the wangxun drivers (ngbe and
txgbe). On a Tx timeout it sets WX_FLAG_NEED_PF_RESET and the service
task picks the flag up and calls wx->do_reset() under rtnl_lock().

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> new file mode 100644
> index 000000000000..bb61355447a8
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2026 Beijing WangXun Technology Co., Ltd. */
> +/* Copyright (c) 1999 - 2026 Intel Corporation. */
> +
> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +
> +#include "wx_type.h"
> +#include "wx_lib.h"
> +#include "wx_err.h"
> +
> +void wx_reset_subtask(struct wx *wx)
> +{
> +	if (!test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> +		return;
> +
> +	rtnl_lock();
> +
> +	if (!netif_running(wx->netdev) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		goto out;
> +
> +	wx_warn(wx, "Reset adapter.\n");
> +
> +	if (test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags)) {
> +		if (wx->do_reset)
> +			wx->do_reset(wx->netdev);
> +	}
> +
> +out:
> +	rtnl_unlock();
> +}
> +EXPORT_SYMBOL(wx_reset_subtask);

[Critical]
Can wx_reset_subtask() deadlock against itself on ngbe?

wx_reset_subtask() runs as the first step of ngbe_service_task and
synchronously calls wx->do_reset(), which for ngbe is bound to
ngbe_do_reset():

  ngbe_sw_init():
      wx->do_reset = ngbe_do_reset;

  ngbe_do_reset():
      if (netif_running(netdev))
          ngbe_reinit_locked(wx);

  ngbe_reinit_locked():
      ngbe_down(wx);
      ngbe_up(wx);

  ngbe_down() -> ngbe_disable_device():
      ...
      cancel_work_sync(&wx->service_task);

So the running service_task ends up calling cancel_work_sync() on
itself. cancel_work_sync() inserts a barrier behind the currently
executing work and waits for completion; the barrier cannot run until
the current work returns, and the current work cannot return until the
barrier completes. Would the worker hang on the very first Tx timeout?

There is also an rtnl ordering question. wx_reset_subtask() takes
rtnl_lock() before calling do_reset, while ngbe_close() runs under
RTNL and calls ngbe_disable_device() (and therefore cancel_work_sync())
with RTNL still held. If the service task is already blocked on
rtnl_lock() in wx_reset_subtask() while close holds RTNL and waits for
the work to finish, can the two paths deadlock on each other?

The same hazard is reachable via ngbe_dev_shutdown(), which wraps
ngbe_close() in rtnl_lock()/rtnl_unlock().

Note that txgbe_disable_device() does not call cancel_work_sync(), so
adding it there for symmetry would import the same self-cancel
deadlock; the fix likely belongs elsewhere (for example, having
wx_reset_subtask() schedule the reset outside of the worker, or using
a separate work item for the reset).

> +static void wx_watchdog_flush_tx(struct wx *wx)
> +{
> +	if (netif_carrier_ok(wx->netdev))
> +		return;
> +
> +	if (wx_ring_tx_pending(wx) || wx_vf_tx_pending(wx)) {
> +		/* We've lost link, so the controller stops DMA,
> +		 * but we've got queued Tx work that's never going
> +		 * to get done, so reset controller to flush Tx.
> +		 * (Do the reset outside of interrupt context).
> +		 */
> +		wx_warn(wx, "initiating reset due to lost link with pending Tx work\n");
> +		set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> +	}
> +}

[Medium]
On txgbe, can WX_FLAG_NEED_PF_RESET survive across a close and trigger
a spurious reset on the next open?

txgbe_disable_device() clears the flag and then calls
timer_delete_sync() but, unlike ngbe_disable_device(), does not call
cancel_work_sync(&wx->service_task):

  clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
  timer_delete_sync(&wx->service_timer);

timer_delete_sync() only stops future timer fires; an already-queued
or in-flight service_task still runs. wx_watchdog_flush_tx() sets
WX_FLAG_NEED_PF_RESET based only on netif_carrier_ok() and
ntu != ntc, without consulting netif_running(). After phylink_stop()
drops carrier and before wx_clean_all_tx_rings() resets ntu/ntc, an
in-flight service_task can re-set the flag after the close path has
cleared it.

On the next open, txgbe_up_complete() does
mod_timer(&wx->service_timer, jiffies); the service_task fires, sees
WX_FLAG_NEED_PF_RESET still set, and wx_reset_subtask() runs
txgbe_do_reset() against the just-opened device.

Would gating wx_watchdog_flush_tx() on netif_running(wx->netdev), or
clearing the flag in the open path, address this?

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 8b7c3753bb6a..ba55a17da3b8 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -228,6 +231,7 @@ static void txgbe_disable_device(struct wx *wx)
>  	wx_irq_disable(wx);
>  	wx_napi_disable_all(wx);
>  
> +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
>  	timer_delete_sync(&wx->service_timer);
>  
>  	if (wx->bus.func < 2)
-- 
This is an AI-generated review.


