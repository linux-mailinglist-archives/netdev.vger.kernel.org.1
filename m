Return-Path: <netdev+bounces-273421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP92Iqscy2kEEAYAu9opvQ
	(envelope-from <netdev+bounces-273421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:00:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6779362F0E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EEDC30AE90A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29457307481;
	Tue, 31 Mar 2026 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LffY4bDa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E542F0C45
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918551; cv=none; b=BxrqwdbCrBdAu0Nnihvl27s6lLOtnxpw+egG57LSNi6Novz1uV5KObR7a/neGTJ+emgGEhqwNCWa5OkEwtasYgqbopWGH2vFC67LWWH/mfs3Ty+LUBSaQ+4M7+eJ2FVfNZQR7mjV73gcVuhwl8NWb2Ufqz/NQCF+etaJg9X5FI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918551; c=relaxed/simple;
	bh=3Ark8aQOY4Em3R/sHF7aPS9hggZ7ftzGSA3PfLmQP54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWuOoK31WDYzTAJ/xrGF7z40g0pBNg2srlA70uuV8kUq6NYF6RNRQZ6/CHzFCv+4MO32+IyDeND9Otvq1ao5+x9d7cJOdBFppHaGJ5tDuR3vEpPy+6GMkULCmnJdHhxReQ85UCBqyJRX+/lQSQWrdAfFWJteF1+cNspDOTUZSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LffY4bDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF3C19423;
	Tue, 31 Mar 2026 00:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774918550;
	bh=3Ark8aQOY4Em3R/sHF7aPS9hggZ7ftzGSA3PfLmQP54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LffY4bDaAigmVthD8v/54Y8FenFC8hhtHpzs+VccKmu0W/7a1ozLBnexSNRm0sM15
	 6PjIYkr4lCJUUyQR1xuY4XZfyaLCxvPSsmTHFukwG2RFvIPP1W1xJmog5pKqKsCscm
	 Ex8LjoidMbrayj4CKXgIywIElrCveTSwSerExpexJMU+ivIHYYmAxFaZwgY9lCK8JN
	 M/sa3xJRLPXvOs/c+kSmZM9MJqHtCT3ve0b1YQUSMcDXCV8JQn83ECzVF0hVansA3P
	 fDqnMiSWu8Wpr2iKzb9E2r/qcepYximxTSvLn2kBID5CG79WZEX8UMUDtvz/f1KImF
	 DufffcATgDRhA==
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
Subject: Re: [PATCH net-next v6 10/11] net: wangxun: improve flow control setting
Date: Mon, 30 Mar 2026 17:55:49 -0700
Message-ID: <20260331005549.3459818-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326021406.30444-11-jiawenwu@trustnetic.com>
References: <20260326021406.30444-11-jiawenwu@trustnetic.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-273421-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6779362F0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wangxun: improve flow control setting

Save the current mode of flow control, check the pause frame statistics
in watchdog to clear WX_HANG_CHECK_ARMED. The received pause frames are
divided into XON and XOFF to be counted, and Tx XON pause is disabled by
default for SP devices.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 2f71dc24306d4..4e0195f7df39e 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
[ ... ]
> @@ -2831,6 +2842,28 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
>  }
>  EXPORT_SYMBOL(wx_fc_enable);
>  
> +static void wx_update_xoff_rx_lfc(struct wx *wx)
> +{
> +	struct wx_hw_stats *hwstats = &wx->stats;
> +	u64 data;
> +	int i;
> +
> +	if (wx->fc.mode != wx_fc_full &&
> +	    wx->fc.mode != wx_fc_rx_pause)
> +		return;
> +
> +	data = rd64(wx, WX_MAC_LXOFFRXC);

Is it possible that rd64() is reading a 32-bit register here?

Looking at wx_clear_hw_cntrs(), WX_MAC_LXOFFRXC is cleared using rd32().

If rd64() reads an adjacent unmapped address, could it populate the upper 32
bits of data with garbage?

> +	hwstats->lxoffrxc += data;
> +
> +	/* refill credits (no tx hang) if we received xoff */
> +	if (!data)
> +		return;
> +
> +	for (i = 0; i < wx->num_tx_queues; i++)
> +		clear_bit(WX_HANG_CHECK_ARMED,
> +			  wx->tx_ring[i]->state);
> +}

If data is populated with garbage from the upper 32 bits, would this bypass
the check for zero and unconditionally clear the WX_HANG_CHECK_ARMED bit on
all Tx queues, preventing the Tx hang recovery watchdog from operating?

>  /**
>   * wx_update_stats - Update the board statistics counters.
>   * @wx: board private structure
> @@ -2844,6 +2877,10 @@ void wx_update_stats(struct wx *wx)
>  	u64 restart_queue = 0, tx_busy = 0;
>  	u32 i;
>  
> +	if (!netif_running(wx->netdev) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		return;
> +

Does this early return cause the final hardware statistics to be lost on
interface teardown?

Since the explicit wx_update_stats() calls were removed from
ngbe_disable_device() and txgbe_disable_device(), and the interface is
marked down before hardware disablement completes, it seems any statistics
accumulated since the last periodic service task will be lost when the
registers are cleared on reset.

[ ... ]
> @@ -2893,7 +2932,10 @@ void wx_update_stats(struct wx *wx)
>  	hwstats->mptc += rd64(wx, WX_TX_MC_FRAMES_GOOD_L);
>  	hwstats->roc += rd32(wx, WX_RX_OVERSIZE_FRAMES_GOOD);
>  	hwstats->ruc += rd32(wx, WX_RX_UNDERSIZE_FRAMES_GOOD);
> -	hwstats->lxonoffrxc += rd32(wx, WX_MAC_LXONOFFRXC);
> +	if (wx->mac.type >= wx_mac_aml)
> +		hwstats->lxonrxc = rd32(wx, WX_MAC_LXONRXC_AML);

Will this 64-bit software statistic wrap back to zero when the hardware
counter overflows?

As seen in wx_clear_hw_cntrs(), WX_MAC_LXONRXC_AML is cleared by writing 0:

    wr32(wx, WX_MAC_LXONRXC_AML, 0);

This suggests it is a continuous 32-bit hardware counter rather than
clear-on-read. Direct assignment might break the monotonic property expected
by ethtool.

> +	else
> +		hwstats->lxonrxc += rd32(wx, WX_MAC_LXONRXC);
>  	hwstats->lxontxc += rd32(wx, WX_RDB_LXONTXC);
>  	hwstats->lxofftxc += rd32(wx, WX_RDB_LXOFFTXC);
>  	hwstats->o2bgptc += rd32(wx, WX_TDM_OS2BMC_CNT);
[ ... ]
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index b8db772c37c5c..080310a51ef86 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -150,6 +150,7 @@ static void ngbe_service_task(struct work_struct *work)
>  	struct wx *wx = container_of(work, struct wx, service_task);
>  
>  	wx_handle_errors_subtask(wx);
> +	wx_update_stats(wx);
>  
>  	wx_service_event_complete(wx);
>  }

Can this introduce data races with userspace ethtool callbacks?

The service task executes asynchronously without holding rtnl_lock, while
ethtool callbacks like wx_get_pause_stats() hold rtnl_lock() and also call
wx_update_stats().

This might lead to double-reads of clear-on-read hardware registers and
lost software counter increments.

Also, could this cause a concurrency issue during interface teardown?

During reconfiguration, ngbe_close() deletes the service timer but does not
call cancel_work_sync(&wx->service_task).

If the service task runs concurrently with wx_clear_interrupt_scheme(),
it might bypass early return checks and access wx->tx_ring[i] while it
is being freed and set to NULL, potentially causing a use-after-free or
NULL pointer dereference.

[ ... ]
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index d4f87fbb95655..e9439e4ebe61e 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -132,6 +132,7 @@ static void txgbe_service_task(struct work_struct *work)
>  	wx_handle_errors_subtask(wx);
>  	txgbe_module_detection_subtask(wx);
>  	txgbe_link_config_subtask(wx);
> +	wx_update_stats(wx);
>  
>  	wx_service_event_complete(wx);
>  }

(Same questions apply to txgbe_service_task regarding data races and
teardown concurrency.)

[ ... ]

