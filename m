Return-Path: <netdev+bounces-257486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HjOGiichWmUDwQAu9opvQ
	(envelope-from <netdev+bounces-257486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 08:45:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA9AFB1A6
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 08:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A06A3002934
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 07:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DF7342534;
	Fri,  6 Feb 2026 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WttI+oYS"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84334251A
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363940; cv=none; b=CmzzV0lMHPEOxFCxOiFvfSN4SNbLa3HVKGu0hS1QjkLhy8S4F1fFjaow5LsweD1lX/34Hzccq1Jg/nmxxk5OuQTWBmLfgsS0Vuc4p19SJuQQoEVWPWy5pbtyk02H1K8ALeWFBRok1G5P15Ipf/pCQOBlleyNHl5XBMlb3zcjla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363940; c=relaxed/simple;
	bh=li9wXsAM0OTnT0JrucsW7xDzklW6/dn3tZgwrrukFME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmaJHw20FL1QlUc5SCpqUQZFNzl/oFfi++oMHyIPY32D/xR9snrzcYI6FRCvI+H+JXzEwyfd2CPDZt7JRbmfgrR67X0SesZ1/ZKmZfsChEoR05E2IifwbFxzEQA48bi/sliC23uKstVSdjnl072dXD/YJUhZIOm8Eps8phPmUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WttI+oYS; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770363937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ThWMHpHlGFAEuR+nP5ko+S0h4veLJlnU4bBXy2Bf6qo=;
	b=WttI+oYS/78hJcbBVaLTs8BKYJXaN+8igTQduKj9MDgqWIpWtj1kR2Ry/iaSEBYfMiYHkT
	MX/s/1vfGihQX2Xf9ZVJks+vdoQ20zkAozXFWMBZPfuanCdS4FnncuW9o0m++e05Jl3R9H
	yQdiTR16UxYKkpOHNzAuOit6KkMLlwI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Konstantin Khlebnikov <khlebnikov@openvz.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] serial: caif: fix use-after-free in caif_serial ldisc_close()
Date: Fri,  6 Feb 2026 15:44:44 +0800
Message-ID: <20260206074450.154267-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257486-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,827272712bd6d12c79a4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,shopee.com:email,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 7CA9AFB1A6
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
lifecycles (ser is allocated in ldisc_open and freed in ser_release
via unregister_netdevice, and each ser binds exactly one tty), we can
safely defer the tty reference release to ser_release() where the
network device is unregistered.

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
and is likely caused by inconsistency between uart_write_room() and
uart_write() in serial core. It has been addressed in a separate
patch [2].

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
Fixes: 56e0ef527b18 ("drivers/net: caif: fix wrong rtnl_is_locked() usage")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

---
v1 -> v2:
Add Reviewed-by tag.
Use correct Fixes tag.
v1: https://lore.kernel.org/netdev/20260204081939.237738-1-jiayuan.chen@linux.dev/
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


