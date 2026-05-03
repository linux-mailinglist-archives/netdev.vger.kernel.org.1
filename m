Return-Path: <netdev+bounces-283524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKQABNSv9mlyXgIAu9opvQ
	(envelope-from <netdev+bounces-283524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:15:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF224B41E4
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4686300BDBC
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEDB27FB18;
	Sun,  3 May 2026 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HufniLm9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB98324B32
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774534; cv=none; b=RahOPvuEW8Bj1GKQulNiguJpfY8wauh2QMoBrYCENS/gDrhwduaoI/K+YdS+/jYf3SvhGs/Db+YGJeM9gc7sWhkj7C9JU5AN/1p7dp6janacXagL5LfO0fHWH1tbPNrXngymv3bIGrQaeGlzjrWsrfkV73GDsPTeT4PHOeBi7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774534; c=relaxed/simple;
	bh=UqQKRImh04Af1l0bAw9K28w99fueEWZ7cBu9sh65J5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4j4ujotO+nZicZGKisj1fJfDtpRg1PoTfQVWrceT4cO2qi4nxObpAFVy53lOtF68oKsRgXuO7kOu9vvTpmMNUG7/pVStkH6meYEamb1ea9rBSk9Qr4+eMwfwYRgp51aVORx7D5zbEhEH0H+eiMkz8HP2d1ZuVrlr5PqSL7Vj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HufniLm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75559C2BCB3;
	Sun,  3 May 2026 02:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777774534;
	bh=UqQKRImh04Af1l0bAw9K28w99fueEWZ7cBu9sh65J5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HufniLm9BYJkGG1iGwveq3WApig5rLsSfTSqdMFlbSzse7ClfhOP7pBYSZYzdFhow
	 cJOkwhFWNf3iDgIIg2aJGgmCSxeM7yy7qrpzBvOI76LkdL5cyl47iyoGvVUo/g7POt
	 XfDARf1G6mfzagAGiR3Hw1ykRHMV+Jx8TARrmX+kc3Usc9rF2PQeSDwkXEL3TfnVw9
	 jCwtYzHArz3S+N1dM5UWpjUBeeAN18ZIqSEcmUZeJNbYOSUF7TBkrP5AcGQ5uaWTte
	 VoqYL96o39JyxrMalvtpmNTpyJvSOTHKwYloz3hhWzfmKqx6vlEwQnfJ3W6UDRQywT
	 lJumGhzgO+3Vw==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: Re: [PATCH net-next v2 2/6] net: wangxun: add Tx timeout process
Date: Sat,  2 May 2026 19:15:32 -0700
Message-ID: <20260503021532.4127268-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430082517.19612-3-jiawenwu@trustnetic.com>
References: <20260430082517.19612-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FF224B41E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-283524-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wangxun: add Tx timeout process

Implement .ndo_tx_timeout to handle Tx side timeout events, triggering
a driver reset process. It also adds logic to track potential hangs and
clear false detections during 802.3 pause frames.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> new file mode 100644
> index 0000000000000..ba5f23cefc0f9
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -0,0 +1,126 @@

[ ... ]

> +static void wx_reset_subtask(struct wx *wx)
> +{
> +	if (!test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> +		return;
> +
> +	rtnl_lock();
> +
> +	if (!netif_running(wx->netdev) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		goto out;

If the interface is being brought down or a reset is in progress, does
this leave WX_FLAG_NEED_PF_RESET set indefinitely? When the interface is
brought back up, could this stale flag trigger an immediate, redundant
hardware reset?

Also, could this rtnl_lock() call cause an AB-BA deadlock? If the network
interface is administratively brought down, the networking core acquires
rtnl_lock() and invokes the driver's .ndo_stop routine.

If the teardown path calls cancel_work_sync(&wx->service_task), the close
path holding rtnl_lock() will wait for service_task to finish, while this
service_task waits indefinitely to acquire rtnl_lock().

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

[ ... ]

> +void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +	u32 head, tail;
> +	int i;
> +
> +	for (i = 0; i < wx->num_tx_queues; i++) {
> +		struct wx_ring *tx_ring = wx->tx_ring[i];
> +
> +		if (test_bit(WX_TX_DETECT_HANG, tx_ring->state) &&
> +		    wx_check_tx_hang(tx_ring))

Since wx_tx_timeout() can execute concurrently with NAPI's wx_clean_tx_irq()
on healthy queues, is it safe to call wx_check_tx_hang() here?

wx_check_tx_hang() mutates per-queue NAPI state like
ring->tx_stats.tx_done_old and ring->state without synchronization. Modifying
this state concurrently could corrupt the hang detection state machine.

> +			wx_warn(wx, "Real tx hang detected on queue %d\n", i);
> +
> +		head = rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx));
> +		tail = rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx));
> +		wx_warn(wx,
> +			"tx ring %d next_to_use is %d, next_to_clean is %d\n",
> +			i, tx_ring->next_to_use,
> +			tx_ring->next_to_clean);
> +		wx_warn(wx, "tx ring %d hw rp is 0x%x, wp is 0x%x\n",
> +			i, head, tail);
> +	}
> +
> +	wx_tx_timeout_reset(wx);
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index bd905e2675758..e9561996b970f 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -147,6 +148,7 @@ static void ngbe_service_task(struct work_struct *work)
>  {
>  	struct wx *wx = container_of(work, struct wx, service_task);
>  
> +	wx_handle_errors_subtask(wx);
>  	wx_update_stats(wx);

Is there a race condition here that could cause spurious Tx hang resets?

wx_handle_errors_subtask() sets the WX_TX_DETECT_HANG bit.
wx_update_stats() clears the WX_HANG_CHECK_ARMED bit when XOFF pause
frames are received.

If a hardware interrupt schedules NAPI between these two calls,
wx_clean_tx_irq() will execute wx_check_tx_hang() and might test the
WX_HANG_CHECK_ARMED bit from the previous interval (since wx_update_stats()
hasn't cleared it yet).

Would calling wx_update_stats() before wx_handle_errors_subtask() prevent
this false hang detection?

>  
>  	wx_service_event_complete(wx);

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 8b7c3753bb6ac..5793da5b7bab4 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -128,6 +129,7 @@ static void txgbe_service_task(struct work_struct *work)
>  {
>  	struct wx *wx = container_of(work, struct wx, service_task);
>  
> +	wx_handle_errors_subtask(wx);
>  	txgbe_module_detection_subtask(wx);
>  	txgbe_link_config_subtask(wx);
>  	wx_update_stats(wx);

Similar to ngbe_service_task(), could NAPI execution between
wx_handle_errors_subtask() and wx_update_stats() trigger a false Tx hang
here as well?

