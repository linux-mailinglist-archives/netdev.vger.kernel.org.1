Return-Path: <netdev+bounces-273420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPIAKfwby2kEEAYAu9opvQ
	(envelope-from <netdev+bounces-273420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:57:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 274BB362EBE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27A6D30396BD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752A3016F1;
	Tue, 31 Mar 2026 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU4hc9ou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837D2F0C45
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918549; cv=none; b=EuckH56/9V++E6K4O7yYVV5ZTHTnf6aYuwZwxJQXcrtuOXTX1LJHeu2J0x8m58oygCfW/hfrBLQHPGUMzyr5g94/z3P70JjcMU7+amXJz/BpU1VKQcAnTywz2KSrq3ovJt/UbjGVNaNa0T8T7A9ojQALPpqSXYiSHLe9vtbA+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918549; c=relaxed/simple;
	bh=Z12xXaMLQzTv74SK2vyYxnztFcumyqBh9+YGmq+0VQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPo106v3jbPNPOtkfbaPS7y3m5YlmrAu7hJ40fqkyHKNxJyFyB+lTt6q0IQg+erOnD8l2ykT97EgOrA+u7iSrC1HWl+cC085sv890rxIQ+FihnRn2RR5WRaxkL3WOKWc9Itvu82x3HZRSarcR4+XeC5w/e5fn1mMuAG10fowQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU4hc9ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D5EC19423;
	Tue, 31 Mar 2026 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774918548;
	bh=Z12xXaMLQzTv74SK2vyYxnztFcumyqBh9+YGmq+0VQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bU4hc9oup64w+Z8SYhtNAY8Ii2AXSVBgSQhu/om3DN25sRaxXAz26/JTvbRL2rt6a
	 fi1exbtEqgH+PQvJ8PDxESWRNA9Eo+9Hi5vyvNQzELDoxso6g4qJcUJpHRJhYEv9tP
	 EjUNboDWCZbvhTUfbpYAhXM/vCjOYnqwigIakhMg0yw6gCTGClJjb3Gs8yW2xQyUvq
	 nYGmjIv9H0XKBdUhnZtIS0RmBgF7oFMXwFwH5s+U1lk1Q6EY9Nip+n3vj1mBjW5IH7
	 brhqT05z+d0Bd8FMt8PQ2zAo45xjLyS0eG2USAIJEf6uwXNylXF906JzGJUn9VGGC6
	 i8bJ6QxrGi03w==
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
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	kees@kernel.org,
	joe@dama.to,
	larysa.zaremba@intel.com,
	abdun.nihaal@gmail.com,
	leitao@debian.org
Subject: Re: [PATCH net-next v6 09/11] net: wangxun: add Tx timeout process
Date: Mon, 30 Mar 2026 17:55:45 -0700
Message-ID: <20260331005546.3459790-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326021406.30444-10-jiawenwu@trustnetic.com>
References: <20260326021406.30444-10-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-273420-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 274BB362EBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wangxun: add Tx timeout process

Implement .ndo_tx_timeout to handle Tx side timeout event. When Tx
timeout event occur, it will triger driver into reset process.

The WX_HANG_CHECK_ARMED bit is set to indicate a potential hang. It will
be cleared if a pause frame is received to remove false hang detection
due to 802.3 frames, which is implemented in later commit.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> new file mode 100644
> index 0000000000000..bb77bdce69d22
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -0,0 +1,126 @@
[ ... ]
> +static void wx_reset_subtask(struct wx *wx)
> +{
> +	if (!test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> +		return;
> +
> +	if (!netif_running(wx->netdev) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		return;
> +
> +	rtnl_lock();
> +
> +	wx_warn(wx, "Reset adapter.\n");
> +
> +	if (test_bit(WX_FLAG_NEED_PF_RESET, wx->flags)) {
> +		if (wx->do_reset)
> +			wx->do_reset(wx->netdev, true);

Can this race with dev_close()? 

If the interface is brought down concurrently, dev_close() acquires rtnl_lock(),
clears the running state, and frees resources. When wx_reset_subtask() later
acquires the lock, it does not re-check netif_running(). 

Could this result in calling do_reset() on a closed interface, leading to
hardware state inconsistencies or use-after-free crashes?

> +		clear_bit(WX_FLAG_NEED_PF_RESET,  wx->flags);

Could this unconditionally clear WX_FLAG_NEED_PF_RESET even if another
context sets it during the do_reset() execution? Should this use
test_and_clear_bit() before the reset operation to avoid losing concurrent
reset requests?

> +	}
> +
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

Does calling wx_check_tx_hang() from the dev_watchdog softirq context cause
data races with the NAPI polling context (wx_clean_tx_irq)? 

wx_check_tx_hang() modifies ring state bits (WX_HANG_CHECK_ARMED) and updates
the 64-bit statistic tx_done_old. Can this lead to torn reads or writes on
32-bit platforms and silent corruption of the hang detection state?

> +			wx_warn(wx, "Real tx hang detected on queue %d\n", i);
> +

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index baffcadb22690..b8db772c37c5c 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
[ ... ]
> @@ -370,6 +391,7 @@ static void ngbe_disable_device(struct wx *wx)
>  	wx_napi_disable_all(wx);
>  	netif_tx_stop_all_queues(netdev);
>  	netif_tx_disable(netdev);
> +	timer_delete_sync(&wx->service_timer);

Does this code leave the service task running? 

timer_delete_sync() is called, but cancel_work_sync(&wx->service_task) is
missing. If the work is already queued, could wx_check_tx_hang_subtask() run
after the transmission and reception rings are freed, resulting in a
use-after-free when accessing wx->tx_ring[i]->state?

>  	if (wx->gpio_ctrl)
>  		ngbe_sfp_modules_txrx_powerctl(wx, false);
>  	wx_irq_disable(wx);

[ ... ]

> @@ -816,6 +845,9 @@ static void ngbe_remove(struct pci_dev *pdev)
>  	struct wx *wx = pci_get_drvdata(pdev);
>  	struct net_device *netdev;
>  
> +	timer_delete_sync(&wx->service_timer);
> +	cancel_work_sync(&wx->service_task);
> +
>  	netdev = wx->netdev;
>  	wx_disable_sriov(wx);
>  	unregister_netdev(netdev);

Does this teardown order result in a use-after-free? 

cancel_work_sync() is called before unregister_netdev(). Since the network
device is still active, could a concurrent timeout or interrupt re-queue the
service task before unregister_netdev() finishes? This might allow the
re-queued work item to execute and access the wx structure after it has been
freed by devres.

