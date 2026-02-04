Return-Path: <netdev+bounces-256609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEsuM1sBg2lGggMAu9opvQ
	(envelope-from <netdev+bounces-256609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 09:20:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31580E30C8
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 09:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3E25301B917
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673BD38E5C8;
	Wed,  4 Feb 2026 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nF070XVQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66DD38F22C
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193205; cv=none; b=JkBKYqGz/gfmceX9HY2DmT8sKOVpkMCJ8Xv0jOyErgIOxnkCjmPYhuyIyTU3+kMQ26jx6aGPL3y4eVDyb6TMMs7rrVkInJXtyOK3zmhmSbXe9DGrtKF15qcLOjTmprkf575H+1VgBYNSuIoWVQUWP7AESGop7y4EoB9IM1O2Anw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193205; c=relaxed/simple;
	bh=cZhTHKpcC9h4Z/NZrd/KhdMDwD/RT0GMH1AxlWEZhj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aO2zQTwv0yLaJbzsSq6OL1KAi/okTzHbsoZ4NqlMcW2PjY0gu3jZYNB2Ui5+CCWPiMwfQeUInguthqWKNfrHj0/T/nL0DeuCyusXt7tV23JKPN+f+09gmYiYTCqm/hJ9VncKpjxYD6OeAz8R43vNKBlPEw3QNsermXEHB/FqJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nF070XVQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770193201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8vjXUNA9bTyi4x4bf9Kr+34dm9fLJzmNRQce1RSSVw8=;
	b=nF070XVQeSsRudZuPRRheROVMhsfTyCUN2kWZigJjzrt8ogkgsfe3QqIpq8pwXqNlBZvPY
	8a5YySdqBrsMwQ3u62C9Mw33ShuSkTTeK2egwmS0RlrTsH1z4femtpM6Zt/i41kD9DtwAV
	dDCP4QJpyZgMfuFvZxQOvJW+vSwdqBg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] serial: caif: fix use-after-free in caif_serial ldisc_close()
Date: Wed,  4 Feb 2026 16:19:33 +0800
Message-ID: <20260204081939.237738-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-256609-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,827272712bd6d12c79a4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,shopee.com:email,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 31580E30C8
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

There is a use-after-free bug in caif_serial where handle_tx() may
access ser->tty after the tty has been freed.

The race condition occurs between ldisc_close() and packet transmission:

    CPU 0 (close)                     CPU 1 (xmit)
    -------------                     ------------
    ldisc_close()
      tty_kref_put(ser->tty)
      [tty may be freed here]
                     <-- race window -->
                                      caif_xmit()
                                        handle_tx()
                                          tty = ser->tty  // dangling ptr
                                          tty->ops->write() // UAF!
      schedule_work()
        ser_release()
          unregister_netdevice()

The root cause is that tty_kref_put() is called in ldisc_close() while
the network device is still active and can receive packets.

Since ser and tty have a 1:1 binding relationship with consistent
lifecycles (ser is created/destroyed in ldisc_open/close, and each ser
binds exactly one tty), we can safely defer the tty reference release
to ser_release() where the network device is unregistered.

Fix this by moving tty_kref_put() from ldisc_close() to ser_release(),
after unregister_netdevice(). This ensures the tty reference is held
as long as the network device exists, preventing the UAF.

Note: We save ser->tty before unregister_netdevice() because ser is
embedded in netdev's private data and will be freed along with netdev
(needs_free_netdev = true).

How to reproduce: Add mdelay(500) at the beginning of ldisc_close()
to widen the race window, then run the reproducer program [1].

Note: There is a separate deadloop issue in handle_tx() when using
PORT_UNKNOWN serial ports (e.g., /dev/ttyS3 in QEMU without proper
serial backend). This deadloop exists even without this patch,
and is caused by an independent bug: inconsistency between
uart_write_room() and uart_write() in serial core. It has been
addressed in a separate patch [2].

KASAN report:

==================================================================
BUG: KASAN: slab-use-after-free in handle_tx+0x5d1/0x620
Read of size 1 at addr ffff8881131e1490 by task caif_uaf_trigge/9929

Call Trace:
 <TASK>
 dump_stack_lvl+0x10e/0x1f0
 print_report+0xd0/0x630
 kasan_report+0xe4/0x120
 handle_tx+0x5d1/0x620
 dev_hard_start_xmit+0x9d/0x6c0
 __dev_queue_xmit+0x6e2/0x4410
 packet_xmit+0x243/0x360
 packet_sendmsg+0x26cf/0x5500
 __sys_sendto+0x4a3/0x520
 __x64_sys_sendto+0xe0/0x1c0
 do_syscall_64+0xc9/0xf80
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f615df2c0d7

Allocated by task 9930:

Freed by task 64:

Last potentially related work creation:

The buggy address belongs to the object at ffff8881131e1000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 1168 bytes inside of
 freed 2048-byte region [ffff8881131e1000, ffff8881131e1800)

The buggy address belongs to the physical page:
page_owner tracks the page as allocated
page last free pid 9778 tgid 9778 stack trace:

Memory state around the buggy address:
 ffff8881131e1380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881131e1400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881131e1480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff8881131e1500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881131e1580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
[1]: https://gist.github.com/mrpre/f683f244544f7b11e7fa87df9e6c2eeb
[2]: https://lore.kernel.org/linux-serial/20260204074327.226165-1-jiayuan.chen@linux.dev/T/#u

Reported-by: syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000a4a7550611e234f5@google.com/T/
Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/caif/caif_serial.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index c398ac42eae9..b90890030751 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -284,6 +284,7 @@ static void ser_release(struct work_struct *work)
 {
 	struct list_head list;
 	struct ser_device *ser, *tmp;
+	struct tty_struct *tty;
 
 	spin_lock(&ser_lock);
 	list_replace_init(&ser_release_list, &list);
@@ -292,9 +293,11 @@ static void ser_release(struct work_struct *work)
 	if (!list_empty(&list)) {
 		rtnl_lock();
 		list_for_each_entry_safe(ser, tmp, &list, node) {
+			tty = ser->tty;
 			dev_close(ser->dev);
 			unregister_netdevice(ser->dev);
 			debugfs_deinit(ser);
+			tty_kref_put(tty);
 		}
 		rtnl_unlock();
 	}
@@ -355,8 +358,6 @@ static void ldisc_close(struct tty_struct *tty)
 {
 	struct ser_device *ser = tty->disc_data;
 
-	tty_kref_put(ser->tty);
-
 	spin_lock(&ser_lock);
 	list_move(&ser->node, &ser_release_list);
 	spin_unlock(&ser_lock);
-- 
2.43.0


