Return-Path: <netdev+bounces-263511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LU8HTmKp2nliAAAu9opvQ
	(envelope-from <netdev+bounces-263511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:26:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB311F9349
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2429F3036385
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95143093C3;
	Wed,  4 Mar 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPLs/puc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B642FA0C6;
	Wed,  4 Mar 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587574; cv=none; b=KR+e9CTTjUAtD3QxxfeDbBhUFY95J2qW6NeWyFJgMx6RIMzZM3e0FMiXEcNEmmSmI4U+W9uDgxQtSSD9xkO/T0CDC39J8+aIxtU6JthqmovSl0qzMHSMxjM6eQiK1hcx10YPrvDIfRrtHP6D17Ouih2qe9k3NZLo3pFONGlsxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587574; c=relaxed/simple;
	bh=/GzBSdollLP1oWlbirW3cObED2Mti3E2VhxF9n4062g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hk45eamosnBAJDm8Rhz/Cly6zOPqETdOIgNznJcLMWHedQr7z/UEzAxESc9C41+7Ovrr1TgoQ5UeqN4EXeX375n5cO5BuVsf3MK+wEyjatXRYWbgWTH2UQm0zYoj3NGixGL2UZga62OwbiGI8JHXM0+YXY0lJpF7nKGR8Vahcho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPLs/puc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4989C116C6;
	Wed,  4 Mar 2026 01:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587574;
	bh=/GzBSdollLP1oWlbirW3cObED2Mti3E2VhxF9n4062g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPLs/puc0eofNR6Zb9n8ISui3nCYsj5pbcSGS9n79ziK/iAeE5oBDtQ51emrWEkiz
	 U3TtwyOCKIpnX1JdOzDbPMNpC76P0WF3NfHu8kcscI1vzi00datHkKf7SEV4n+Iv4x
	 UCLQ5tUmSEixG1WQ2UphsDB4atqZuWZ9u/zFtJ1g4qNDaKw1Cx0d2itc2x3J+d8Msx
	 zwcwMJR9YXK+zT8uAkd6IsR8rhWqC6pPvngIlTb5iUVKrtWLybq5NbMkPvIuMuZj/q
	 FLApbiaNv45AsWG7ceHdGoepd2n5tSCO8U0QzP4g8A8oKLwgvj75Izfux8xKv83Qld
	 CU65NPgkGU6fA==
From: Jakub Kicinski <kuba@kernel.org>
To: shuangpeng.kernel@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jiayuan.chen@shopee.com,
	jirislaby@kernel.org,
	andrew+netdev@lunn.ch,
	gregkh@linuxfoundation.org,
	shaojijie@huawei.com
Subject: Re: [net,v4] serial: caif: hold tty->link reference in ldisc_open and ser_release
Date: Tue,  3 Mar 2026 17:26:12 -0800
Message-ID: <20260304012612.2592839-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301220525.1546355-1-shuangpeng.kernel@gmail.com>
References: <20260301220525.1546355-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAB311F9349
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263511-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
serial: caif: hold tty->link reference in ldisc_open and ser_release

This commit addresses a KASAN slab-use-after-free in pty_write_room()
triggered when caif_serial's TX path calls tty_write_room(). The fix
holds an extra reference on tty->link throughout the lifetime of the
caif_serial line discipline.

Link: https://lore.kernel.org/all/20260228094741.1e248271@kernel.org/
Link: https://gist.github.com/shuangpengbai/c898debad6bdf170a84be7e6b3d8707f

The Fixes tag points to commit 308e7e4d0a84 ("serial: caif: fix
use-after-free in caif_serial ldisc_close()"), but the regression was
actually introduced by commit e31d5a05948e ("caif: tty's are kref
objects so take a reference"). That commit added tty_kref_get(tty) to
hold a reference on the tty, but failed to also hold a reference on
tty->link, which is accessed via tty_write_room() in handle_tx().

Commit 308e7e4d0a84 merely exposed this existing regression by changing
the timing.

Should the Fixes tag be updated to:

    Fixes: e31d5a05948e ("caif: tty's are kref objects so take a reference")

> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> index b90890030751..1873d8287bb9 100644
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -297,6 +297,7 @@ static void ser_release(struct work_struct *work)
>  			dev_close(ser->dev);
>  			unregister_netdevice(ser->dev);
>  			debugfs_deinit(ser);
> +			tty_kref_put(tty->link);
                        ^^^^^^^^^^^^^^^^^^^^

Can this dereference NULL? The tty->link field is only set for PTY
(pseudo-terminal) pairs. For regular serial ports and other non-PTY
devices, tty->link is NULL.

The CAIF line discipline can be attached to any TTY device via the
TIOCSETD ioctl. When ser_release() is called to clean up a ser_device
that was created for a non-PTY TTY device, tty->link would be NULL.

Should this check for NULL before calling tty_kref_put()?

>  			tty_kref_put(tty);
>  		}
>  		rtnl_unlock();
> @@ -331,6 +332,7 @@ static int ldisc_open(struct tty_struct *tty)
>
>  	ser = netdev_priv(dev);
>  	ser->tty = tty_kref_get(tty);
> +	tty_kref_get(tty->link);
        ^^^^^^^^^^^^^^^^^^^^^^^^

Can this dereference NULL? When a user attaches the CAIF line discipline
to a non-PTY TTY device via TIOCSETD, ldisc_open() is called with a tty
where tty->link is NULL.

While ldisc_open() performs capability checks (CAP_SYS_ADMIN), there is
no code restricting this to PTY devices only.

Should this check for NULL before calling tty_kref_get()?

>  	ser->dev = dev;
>  	debugfs_init(ser, tty);
>  	tty->receive_room = 4096;
> @@ -339,6 +341,7 @@ static int ldisc_open(struct tty_struct *tty)
>  	rtnl_lock();
>  	result = register_netdevice(dev);
>  	if (result) {
> +		tty_kref_put(tty->link);
                ^^^^^^^^^^^^^^^^^^^^^^^^

Can this dereference NULL in the error path? If register_netdevice()
fails after the CAIF line discipline was attached to a non-PTY TTY
device, the error path would attempt to release a reference on
tty->link when it is NULL.

Should this check for NULL before calling tty_kref_put()?

>  		tty_kref_put(tty);
>  		rtnl_unlock();
>  		free_netdev(dev);

Simon Horman raised a concern in v2 about a NULL pointer dereference in
update_tty_status(). The v4 patch does not use the spinlock approach
from v2, and does not address this race condition.

After ser_release() sets ser->tty = NULL, a concurrent handle_tx() that
already passed the NULL check can reach update_tty_status(ser).

Looking at update_tty_status():

drivers/net/caif/caif_serial.c:update_tty_status() {
    inline_decode(ser->common.flowctrl,
        ser->tty->flow.stopped << 5 |
        ser->tty->flow.tco_stopped << 3 |
        ser->tty->ctrl.packet << 2);
}

It dereferences ser->tty directly (ser->tty->flow.stopped,
ser->tty->flow.tco_stopped, ser->tty->ctrl.packet).

Can this cause a NULL pointer dereference?

Simon also raised a concern about potential deadlock with spinlock usage
in v2. The v4 patch removes the spinlock approach entirely.

handle_tx() is called from caif_xmit(), which is the ndo_start_xmit
handler. This can run in softirq context (NET_TX softirq). ser_release()
runs in process context (workqueue).

How does the current synchronization between handle_tx() and
ser_release() prevent races?
-- 
pw-bot: cr

