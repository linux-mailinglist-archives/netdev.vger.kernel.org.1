Return-Path: <netdev+bounces-257399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJdRGxxRhWmV/wMAu9opvQ
	(envelope-from <netdev+bounces-257399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:25:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0301BF9407
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 606AC3008300
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A0525A655;
	Fri,  6 Feb 2026 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6Vz8SXh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096124EAB1;
	Fri,  6 Feb 2026 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344729; cv=none; b=Quu1wpLsdwxqVpYqOFQihb2EPrLSeD+I0AUtTVBm5FfB4Sk4G4nRsn7EYQ+g7ye8Fn67KU8XNikSYsttYLdM113kuj+vYvUYBMEOOSUWFCCO2ABWVvML+7TkMlAB7W/9vN/WdcndSGtqII0zNDMsqThiZszCM7oUoHXufG+CXt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344729; c=relaxed/simple;
	bh=7TYnW5LHLTJMU8pfUwNFQAsIPO1pYWlPEJCyFKvlZd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvUX+hlwhLLQIybouJ+BL8XqFF42TQYG5xTHpn9C2kx3fyGVPToLCMKvGVMy6smMo4sgnFdbOiHGI/vUZBRXBqhuLp/QoPOm2mKGjYII42iWg4vgw7gGqqC5tjXPZ+JaHDWyKkI64l18W2aQDWlgxAgk4adwonUzAo0K7FC+E6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6Vz8SXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D14C19423;
	Fri,  6 Feb 2026 02:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344728;
	bh=7TYnW5LHLTJMU8pfUwNFQAsIPO1pYWlPEJCyFKvlZd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6Vz8SXht8wyrUkYJXLD50y/76G6JUIwmBfvexxVPq2m4/1Z7Anb8cTuPAz4yJSyI
	 z0r+Bt6xDOJVoD43NWhJjy1oBmP+JgSdurWH6jTNrjfjcKAfnjG1eiWfHEf4P+8Zql
	 fdQACA7TKJnFwHBncBP/tDQHhzREhOTH9prG3ngbjfCVKKsboppBCD0yQU1q/pd/lh
	 t77gNkNUe3YSPLdFnU3/n6XeGySh/wEogWoFCNUvSSVSDqKcCyW9psWl9sVUfbIKS1
	 CwfkwWXMfppJEmB19olWnelUn7SFplt3xq7BYOEcCD2SbZ1DJgYMhCl8UgcYas/fJG
	 5nXnlsXV1qfEg==
From: Jakub Kicinski <kuba@kernel.org>
To: jiayuan.chen@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jiayuan.chen@shopee.com,
	pabeni@redhat.com,
	jirislaby@kernel.org,
	sjur.brandeland@stericsson.com,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	edumazet@google.com
Subject: Re: [net,v1] serial: caif: fix use-after-free in caif_serial ldisc_close()
Date: Thu,  5 Feb 2026 18:25:26 -0800
Message-ID: <20260206022526.3191971-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204081939.237738-1-jiayuan.chen@linux.dev>
References: <20260204081939.237738-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257399-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,827272712bd6d12c79a4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0301BF9407
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
serial: caif: fix use-after-free in caif_serial ldisc_close()

This commit fixes a use-after-free bug in the CAIF serial driver by
moving the tty_kref_put() call from ldisc_close() to ser_release(),
ensuring the tty reference is held as long as the network device exists.

Closes: https://lore.kernel.org/all/000000000000a4a7550611e234f5@google.com/T/

> serial: caif: fix use-after-free in caif_serial ldisc_close()
>
> There is a use-after-free bug in caif_serial where handle_tx() may
> access ser->tty after the tty has been freed.
>
> The race condition occurs between ldisc_close() and packet transmission:
>
>     CPU 0 (close)                     CPU 1 (xmit)
>     -------------                     ------------
>     ldisc_close()
>       tty_kref_put(ser->tty)
>       [tty may be freed here]
>                      <-- race window -->
>                                       caif_xmit()
>                                         handle_tx()
>                                           tty = ser->tty  // dangling ptr
>                                           tty->ops->write() // UAF!
>       schedule_work()
>         ser_release()
>           unregister_netdevice()
>
> The root cause is that tty_kref_put() is called in ldisc_close() while
> the network device is still active and can receive packets.
>
> Since ser and tty have a 1:1 binding relationship with consistent
> lifecycles (ser is created/destroyed in ldisc_open/close, and each ser
> binds exactly one tty), we can safely defer the tty reference release

The statement "ser is created/destroyed in ldisc_open/close" isn't quite
accurate. While ser is created in ldisc_open() via alloc_netdev(), it's
not actually destroyed in ldisc_close(). Instead, ldisc_close() only moves
ser to the release list via list_move(&ser->node, &ser_release_list).
The actual destruction happens in ser_release() when unregister_netdevice()
is called, which eventually frees the netdev and embedded ser via
netdev_run_todo() invoked by rtnl_unlock(). Would it be more accurate to
say ser is destroyed in ser_release()?

> to ser_release() where the network device is unregistered.
>
> Fix this by moving tty_kref_put() from ldisc_close() to ser_release(),
> after unregister_netdevice(). This ensures the tty reference is held
> as long as the network device exists, preventing the UAF.
>
> Note: We save ser->tty before unregister_netdevice() because ser is
> embedded in netdev's private data and will be freed along with netdev
> (needs_free_netdev = true).
>
> How to reproduce: Add mdelay(500) at the beginning of ldisc_close()
> to widen the race window, then run the reproducer program [1].
>
> Note: There is a separate deadloop issue in handle_tx() when using
> PORT_UNKNOWN serial ports (e.g., /dev/ttyS3 in QEMU without proper
> serial backend). This deadloop exists even without this patch,
> and is caused by an independent bug: inconsistency between
> uart_write_room() and uart_write() in serial core. It has been
> addressed in a separate patch [2].

The claim about the deadloop being caused by inconsistency between
uart_write_room() and uart_write() couldn't be fully verified without
examining the referenced patch [2]. While the claim is plausible (if
uart_write_room() reports available space but uart_write() returns 0
bytes written, the deadloop would occur in handle_tx()), this appears
to be presented as fact rather than hypothesis. Could this be clarified
or softened to indicate it's the suspected cause pending verification?

[ ... ]

> Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")

The Fixes: tag appears to reference the wrong commit. The bug was actually
introduced by commit 56e0ef527b18 ("drivers/net: caif: fix wrong
rtnl_is_locked() usage"). The original commit 9b27105b4a44 didn't have any
tty_kref operations. Commit e31d5a05948e added tty_kref_get/put, but at
that time tty_kref_put was called in ldisc_close() which directly
unregistered the netdevice, so there was no race. Commit 56e0ef527b18
moved dev_close/unregister_netdevice to a work queue (ser_release) but
left tty_kref_put in ldisc_close, creating the race window. Should the
Fixes: tag be updated to:

Fixes: 56e0ef527b18 ("drivers/net: caif: fix wrong rtnl_is_locked() usage")

> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -284,6 +284,7 @@ static void ser_release(struct work_struct *work)
>  {
>  	struct list_head list;
>  	struct ser_device *ser, *tmp;
> +	struct tty_struct *tty;
>
>  	spin_lock(&ser_lock);
>  	list_replace_init(&ser_release_list, &list);
> @@ -292,9 +293,11 @@ static void ser_release(struct work_struct *work)
>  	if (!list_empty(&list)) {
>  		rtnl_lock();
>  		list_for_each_entry_safe(ser, tmp, &list, node) {
> +			tty = ser->tty;
>  			dev_close(ser->dev);
>  			unregister_netdevice(ser->dev);
>  			debugfs_deinit(ser);
> +			tty_kref_put(tty);
>  		}
>  		rtnl_unlock();
>  	}

[ ... ]

> @@ -354,8 +357,6 @@ static int ldisc_open(struct tty_struct *tty)
>  static void ldisc_close(struct tty_struct *tty)
>  {
>  	struct ser_device *ser = tty->disc_data;
> -
> -	tty_kref_put(ser->tty);
>
>  	spin_lock(&ser_lock);
>  	list_move(&ser->node, &ser_release_list);
-- 
pw-bot: cr

