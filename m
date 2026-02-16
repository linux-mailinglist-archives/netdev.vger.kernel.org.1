Return-Path: <netdev+bounces-258891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHgtDvcgk2kX1wEAu9opvQ
	(envelope-from <netdev+bounces-258891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:51:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A07144289
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8132A304C916
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161D4310630;
	Mon, 16 Feb 2026 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYjor/Wf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575231062C;
	Mon, 16 Feb 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249438; cv=none; b=M8zHH0R34uUQwrO5kOTny99yq0yJjLmCYKO0mVkg7xzK7RqjM9x6CF1i2/8GzkXASrLspPtxapnoGEWUDrD9Q/fZ66QuKjIqhlhFnDaCRsZdq4W1fEcaeZrqd2Oxl+c73+2ZjGyX4kxE7AId9qLl8xZXmRVwVVQ4CRl6YyB/m08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249438; c=relaxed/simple;
	bh=gPs/j8mZ4JtTMpJPUAAZlBBO1MdiCcHejBR8z4toN1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiREhi04+RaTfF9tGfz7KMaUIO4UicD08estQ5LIvnHB0hRymeKmm5litgcAJn0pyZKYkVJkhzn23gVEvzDP9tszE6gL6P7d1RGMJpv/zvauvkKxbZSbcqt2I/nvK0w59RAyoTPns9wLcMcz9+tX2taAqQadpecbE1p6bK8hJdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYjor/Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B65C116C6;
	Mon, 16 Feb 2026 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771249437;
	bh=gPs/j8mZ4JtTMpJPUAAZlBBO1MdiCcHejBR8z4toN1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYjor/WfszggvDY4zzNZsRcNjwFp0pvhV0H7ol7/sO/z5RSgBeB4zyUXnNYNQMH5E
	 NhL/+dgkayOz20oB5jcz/q5itAzqXYDVE0AWUeSM+2OvzNlmNWEIir8xluWHoIuRfb
	 eznsqS4/k2TW+ngiTTqCmN7niKu0KEKG/xHniLzkB0xntMiSX6gHHCXROKgd3zn9RV
	 VUJglxPNzEBlAjm8KMBCkeM44sf0Wrs8Dgpr8Zrhw1OdxsAamiNWXzdgAdSkcdxmOp
	 IC28gLTw9zJYN8fKjxiTXDnFhdkXm8ehDThZ0D0hENjssCH+jO+9UDqFUQoszJBuhk
	 GDCpreIeBzG+Q==
From: Simon Horman <horms@kernel.org>
To: shuangpeng.kernel@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [net,v2,1/1] serial: caif: fix remaining ser->tty UAF in TX path
Date: Mon, 16 Feb 2026 13:43:40 +0000
Message-ID: <20260216134340.68496-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260215025141.1106576-2-shuangpeng.kernel@gmail.com>
References: <20260215025141.1106576-2-shuangpeng.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258891-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: B3A07144289
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
serial: caif: fix remaining ser->tty UAF in TX path

This patch addresses a KASAN use-after-free in the caif_serial TX path
by adding a spinlock to serialize access to ser->tty. The TX path now
takes a tty kref under the lock, and ser_release() clears ser->tty under
the same lock before dropping the reference.

Link: https://groups.google.com/g/syzkaller/c/usNe0oKtoXw/m/x8qUc3yUAQAJ

> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -68,6 +68,7 @@ struct ser_device {
>  	struct net_device *dev;
>  	struct sk_buff_head head;
>  	struct tty_struct *tty;
> +	spinlock_t tty_lock; /* protects ser->tty */
>  	bool tx_started;
>  	unsigned long state;
>  #ifdef CONFIG_DEBUG_FS
> @@ -197,12 +198,21 @@ static int handle_tx(struct ser_device *ser)
>  	struct sk_buff *skb;
>  	int tty_wr, len, room;
>
> +	spin_lock(&ser->tty_lock);
>  	tty = ser->tty;
> +	tty_kref_get(tty);
> +	spin_unlock(&ser->tty_lock);

handle_tx() is called from caif_xmit(), which is the ndo_start_xmit
handler. This can run in softirq context (NET_TX softirq). ser_release()
runs in process context (workqueue). If ser_release() holds tty_lock in
process context and a softirq fires on the same CPU, calling caif_xmit()
-> handle_tx() -> spin_lock(&ser->tty_lock), won't this deadlock?

Should this use spin_lock_bh()/spin_unlock_bh() instead?

> +
> +	if (!tty)
> +		return 0;
> +
>  	ser->tx_started = true;
>
>  	/* Enter critical section */
> -	if (test_and_set_bit(CAIF_SENDING, &ser->state))
> +	if (test_and_set_bit(CAIF_SENDING, &ser->state)) {
> +		tty_kref_put(tty);
>  		return 0;
> +	}
>
>  	/* skb_peek is safe because handle_tx is called after skb_queue_tail */
>  	while ((skb = skb_peek(&ser->head)) != NULL) {

[ ... ]

>  		if (!ser_loop) {
>  			tty_wr = tty->ops->write(tty, skb->data, len);
>  			update_tty_status(ser);
>  		} else {

After ser_release() sets ser->tty = NULL (the new code from this patch),
a concurrent handle_tx() that already passed the NULL check above can
reach update_tty_status(ser) here. Looking at update_tty_status(), it
dereferences ser->tty directly:

drivers/net/caif/caif_serial.c:update_tty_status() {
    inline_decode(ser->common.flowctrl,
        ser->tty->flow.stopped << 5 |
        ser->tty->flow.tco_stopped << 3 |
        ser->tty->ctrl.packet << 2);
}

Won't this cause a NULL pointer dereference? Should update_tty_status()
take the local tty pointer as a parameter instead of reading ser->tty?

> @@ -245,9 +255,11 @@
>  		ser->common.flowctrl != NULL)
>  				ser->common.flowctrl(ser->dev, ON);
>  	clear_bit(CAIF_SENDING, &ser->state);
> +	tty_kref_put(tty);
>  	return 0;
>  error:
>  	clear_bit(CAIF_SENDING, &ser->state);
> +	tty_kref_put(tty);
>  	return tty_wr;
>  }
>
> @@ -293,7 +305,10 @@ static void ser_release(struct work_struct *work)
>  	if (!list_empty(&list)) {
>  		rtnl_lock();
>  		list_for_each_entry_safe(ser, tmp, &list, node) {
> +			spin_lock(&ser->tty_lock);
>  			tty = ser->tty;
> +			ser->tty = NULL;
> +			spin_unlock(&ser->tty_lock);
>  			dev_close(ser->dev);
>  			unregister_netdevice(ser->dev);
>  			debugfs_deinit(ser);

[ ... ]

Jakub Kicinski's review of v1 (commit 308e7e4d0a84) pointed out that
moving tty_kref_put() to ser_release() doesn't fully prevent the UAF
because handle_tx() can still fetch ser->tty while ser_release() is
dropping the last tty reference. The current patch addresses this by
adding the tty_lock synchronization. While the v1/v2 review thread
didn't explicitly mark this as blocking, it represents a legitimate
race window that this patch fixes.

Reference: https://lore.kernel.org/netdev/20260206022526.3191971-1-kuba@kernel.org/
-- 
pw-bot: changes-requested

