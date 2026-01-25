Return-Path: <netdev+bounces-253123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p8JOO59rdWmRFAEAu9opvQ
	(envelope-from <netdev+bounces-253123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 02:02:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C637F69A
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 02:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E83E300A8EB
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210686329;
	Sun, 25 Jan 2026 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrudJ2l8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D93EBF20
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769302940; cv=none; b=fCBBDjuOZeu6sTWEk+MoI6r9MBRsssgVrWtnhCK4jRAcYNs2+bU/xnHpKilGRgGE1T08H+2CtCYXFSjjalrH8dLEvG+qkiWTJhi+8iTUp6eUmwMq+CMLirvItvMb/Bk1ymRlndEESVSvLD2V1BSomPuNZlQiBbQpe4h0nKAjI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769302940; c=relaxed/simple;
	bh=9ZTjT68rvCZ1yq/eCvHh2oIZ03Jta9I1WQRDjBvHH5Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=djTlodHBobyrAJMma++22ggKfFc/9AfIqsTW37kbKzSeVY4CQkeprnGWvQ8NKmYOx/WJMu1k981+/d2comjDnvrdn1RTbi50nldowif599Dlvf6KnFVUsF+5ESwjuWsdinZ4DFFvNXqpDweSeLHHBW087ILz2vfGX/n2h3mcTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrudJ2l8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f25e494c2so37061885ad.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 17:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769302938; x=1769907738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RX8RX2jk8ljzZ1deKCet546PZdgQS3CqCJ2Kl6Se5Vg=;
        b=YrudJ2l8JO7QBTd00+FzZ4Wqv+N4KIg3r2gpC5HvXikOSGl1bgL52PUMH2lFdl0ZNY
         XWMBfM1RcSD5KmRLpMl07zMp8eFDDFzBNZZ1jLQH61vJb0DV1ym42qvw0sP9cUDfgRzh
         AwQlPgN+8FRrR0eCBU/kxShW7+yf65kR2KrjRwZDtj3xHsV2v6vWum1116EdyhjywyJ9
         HXJR5v838kDpCRtokemH9SdDAvVMkPUst+qKofraGGLCRXQMIc6i19RwNWMNQc39E/yG
         82JiMcaFpu/TB/r4qwJmM0wKiZtTveUouQG1PfLc4wnwRVVgzpEY/xc5Xna5Rd+5hHmQ
         WfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769302938; x=1769907738;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RX8RX2jk8ljzZ1deKCet546PZdgQS3CqCJ2Kl6Se5Vg=;
        b=dx4Dz/vGY+pIqtjzs0rRDBmtrommTwWyI0PCdXVpqyaEgrowAgpBwGgHeB6zRGM+1P
         Ke+pVrGxayxEJwQJGMqXb2klP6By5A/BozkQwKIWYCj2YwcUGF7HrBiG3iEABxWH7bMM
         kdKo8EI+RPERK87lne3V6j5WA5AwS7fw80zSR8Gw6MHd5dd17MgXmeMvaH86kfXN7GVK
         mmSL+mHlHGbTUfbQlWsFwrPDtrqdwKhcu4N38iXaOZkVSL/hNrcujHb7E84NTNf7Sy2y
         0OideWC2RBPg+o4s1Hhfaq1gNYTR3qcJldZzzPVMzdrQ1l1qyp0jZMicryl6hkLSMclJ
         PsUA==
X-Forwarded-Encrypted: i=1; AJvYcCVeg+uI0S7eah1CBd3hTLZUb4dx8xI3DMq6YGOWyixrx8TofTsjAJEWWqO650wXdS/zfgDJQmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMlyKhxtmV4rT+Hu9kxaWI8h0I2zpwl463AW+3EHXiy0aehOI
	GbkjrbwMqlMRlobYg4r/HCd62FX+A584JATLV4cgyQ3qe0yHsJiGuFyQ9cdwkVFLqJAbv7O8M8Y
	/C0gATw==
X-Received: from pleu4.prod.google.com ([2002:a17:903:41c4:b0:2a7:885b:ea39])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b50:b0:2a7:5171:9220
 with SMTP id d9443c01a7336-2a84558a9f4mr3265785ad.14.1769302937838; Sat, 24
 Jan 2026 17:02:17 -0800 (PST)
Date: Sun, 25 Jan 2026 00:59:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260125010214.1572439-1-kuniyu@google.com>
Subject: [PATCH v1 net] nfc: llcp: Fix memleak in nfc_llcp_send_ui_frame().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+f2d245f1d76bbfa50e4c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253123-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,f2d245f1d76bbfa50e4c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 03C637F69A
X-Rspamd-Action: no action

syzbot reported various memory leaks related to NFC, struct
nfc_llcp_sock, sk_buff, nfc_dev, etc. [0]

The leading log hinted that nfc_llcp_send_ui_frame() failed
to allocate skb due to sock_error(sk) being -ENXIO.

ENXIO is set by nfc_llcp_socket_release() when struct
nfc_llcp_local is destroyed by local_cleanup().

The problem is that there is no synchronisation between
nfc_llcp_send_ui_frame() and local_cleanup(), and skb
could be put into local->tx_queue after it was purged in
local_cleanup():

  CPU1                          CPU2
  ----                          ----
  nfc_llcp_send_ui_frame()      local_cleanup()
  |- do {                       '
     |- pdu = nfc_alloc_send_skb(..., &err)
     |                          .
     |                          |- nfc_llcp_socket_release(local, false, ENXIO);
     |                          |- skb_queue_purge(&local->tx_queue);      |
     |                          '                                          |
     |- skb_queue_tail(&local->tx_queue, pdu);                             |
    ...                                                                    |
     |- pdu = nfc_alloc_send_skb(..., &err)                                |
                                       ^._________________________________.'

local_cleanup() is called for struct nfc_llcp_local only
after nfc_llcp_remove_local() unlinks it from llcp_devices.

If we hold local->tx_queue.lock then, we can synchronise
the thread and nfc_llcp_send_ui_frame().

Let's do that and check list_empty(&local->list) before
queuing skb to local->tx_queue in nfc_llcp_send_ui_frame().

[0]:
[   56.074943][ T6096] llcp: nfc_llcp_send_ui_frame: Could not allocate PDU (error=-6)
[   64.318868][ T5813] kmemleak: 6 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
BUG: memory leak
unreferenced object 0xffff8881272f6800 (size 1024):
  comm "syz.0.17", pid 6096, jiffies 4294942766
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    27 00 03 40 00 00 00 00 00 00 00 00 00 00 00 00  '..@............
  backtrace (crc da58d84d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __do_kmalloc_node mm/slub.c:5645 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5658
    kmalloc_noprof include/linux/slab.h:961 [inline]
    sk_prot_alloc+0x11a/0x1b0 net/core/sock.c:2239
    sk_alloc+0x36/0x360 net/core/sock.c:2295
    nfc_llcp_sock_alloc+0x37/0x130 net/nfc/llcp_sock.c:979
    llcp_sock_create+0x71/0xd0 net/nfc/llcp_sock.c:1044
    nfc_sock_create+0xc9/0xf0 net/nfc/af_nfc.c:31
    __sock_create+0x1a9/0x340 net/socket.c:1605
    sock_create net/socket.c:1663 [inline]
    __sys_socket_create net/socket.c:1700 [inline]
    __sys_socket+0xb9/0x1a0 net/socket.c:1747
    __do_sys_socket net/socket.c:1761 [inline]
    __se_sys_socket net/socket.c:1759 [inline]
    __x64_sys_socket+0x1b/0x30 net/socket.c:1759
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810fbd9800 (size 240):
  comm "syz.0.17", pid 6096, jiffies 4294942850
  hex dump (first 32 bytes):
    68 f0 ff 08 81 88 ff ff 68 f0 ff 08 81 88 ff ff  h.......h.......
    00 00 00 00 00 00 00 00 00 68 2f 27 81 88 ff ff  .........h/'....
  backtrace (crc 6cc652b1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    kmem_cache_alloc_node_noprof+0x36f/0x5e0 mm/slub.c:5336
    __alloc_skb+0x203/0x240 net/core/skbuff.c:660
    alloc_skb include/linux/skbuff.h:1383 [inline]
    alloc_skb_with_frags+0x69/0x3f0 net/core/skbuff.c:6671
    sock_alloc_send_pskb+0x379/0x3e0 net/core/sock.c:2965
    sock_alloc_send_skb include/net/sock.h:1859 [inline]
    nfc_alloc_send_skb+0x45/0x80 net/nfc/core.c:724
    nfc_llcp_send_ui_frame+0x162/0x360 net/nfc/llcp_commands.c:766
    llcp_sock_sendmsg+0x14c/0x1d0 net/nfc/llcp_sock.c:814
    sock_sendmsg_nosec net/socket.c:727 [inline]
    __sock_sendmsg net/socket.c:742 [inline]
    __sys_sendto+0x2d8/0x2f0 net/socket.c:2244
    __do_sys_sendto net/socket.c:2251 [inline]
    __se_sys_sendto net/socket.c:2247 [inline]
    __x64_sys_sendto+0x28/0x30 net/socket.c:2247
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 94f418a20664 ("NFC: UI frame sending routine implementation")
Reported-by: syzbot+f2d245f1d76bbfa50e4c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/697569c7.a00a0220.33ccc7.0014.GAE@google.com/T/#u
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/nfc/llcp_commands.c | 17 ++++++++++++++++-
 net/nfc/llcp_core.c     |  4 +++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index e2680a3bef79..b652323bc2c1 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -778,8 +778,23 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		if (likely(frag_len > 0))
 			skb_put_data(pdu, msg_ptr, frag_len);
 
+		spin_lock(&local->tx_queue.lock);
+
+		if (list_empty(&local->list)) {
+			spin_unlock(&local->tx_queue.lock);
+
+			kfree_skb(pdu);
+
+			len -= remaining_len;
+			if (len == 0)
+				len = -ENXIO;
+			break;
+		}
+
 		/* No need to check for the peer RW for UI frames */
-		skb_queue_tail(&local->tx_queue, pdu);
+		__skb_queue_tail(&local->tx_queue, pdu);
+
+		spin_unlock(&local->tx_queue.lock);
 
 		remaining_len -= frag_len;
 		msg_ptr += frag_len;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index beeb3b4d28ca..444a3774c8e8 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -316,7 +316,9 @@ static struct nfc_llcp_local *nfc_llcp_remove_local(struct nfc_dev *dev)
 	spin_lock(&llcp_devices_lock);
 	list_for_each_entry_safe(local, tmp, &llcp_devices, list)
 		if (local->dev == dev) {
-			list_del(&local->list);
+			spin_lock(&local->tx_queue.lock);
+			list_del_init(&local->list);
+			spin_unlock(&local->tx_queue.lock);
 			spin_unlock(&llcp_devices_lock);
 			return local;
 		}
-- 
2.52.0.457.g6b5491de43-goog


