Return-Path: <netdev+bounces-280768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK2xHw4i6mnKuwIAu9opvQ
	(envelope-from <netdev+bounces-280768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:43:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD94532FC
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29755304DE84
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A6D2D0C72;
	Thu, 23 Apr 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="lCKY5VpX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2F2D8DB5
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951721; cv=none; b=pkpBfEqM0GYceFZ24IQ7+Puwiyz9yKDb0UGnHGz7ASRR/iK6qBuMhfJDqfl4KwiK6AI14FrI1uWHL/7UWJOPB6qBhg3DwbtC8lqgfK/eBS9oQTlkt5fw/qvYACKriWZMX1GS8mqAZOnsHo3qsc+2euqUWh+S9Hbd7j9GncYh6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951721; c=relaxed/simple;
	bh=m2Qi7B/mKMdXobB2JEc9n4IZTL8ld0MZmbRMt7pZQAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bius+t0hLYx34vPP65XxXHznTiRGUnBDFpQuxlWdIQ2WQ8tYbD/8jLCCC+wZ8cmiEmEKVQNYQgmgBO8eDH+7m/IHsN/FXOzXvooRMpXAm8VxVVoSVxneQzXvTf9ieuvvtQofREmt8Y7hb1ToW0YXBDFIkkzWAlQwSPW/L56BmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=lCKY5VpX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2ea1b3962so38704935ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776951715; x=1777556515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ViuZMIxEJKx+N/Bvei4uc5LuWBYsa4mQlXNhyeX6OVU=;
        b=lCKY5VpXjJXp/f6GyYXP7ZGEfO1Aswp7BLbM7aC0JLUsBd/KfONiMAjkJ+jekowFR+
         jV0VaxD79JmpeMSRhM8I9Q+tTEXcWz8Xw7p3R/mbq6OE/1jDQaUdjcnIApmk571qBtIP
         dVNg53zIoMserXPIrJJwrPl/zgxeb0O4FKNx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951715; x=1777556515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViuZMIxEJKx+N/Bvei4uc5LuWBYsa4mQlXNhyeX6OVU=;
        b=LDfJfx/2AmhlDuwIY6f2T5QcnCugx6IN2slAE1DOCcabAANQ4ljgxsY+fIDwYxMnU4
         TizatnJlax0AxSMCLI/H+Rx1yF7/XOooqOGNTNgnitJZztte2XTzUX49OqLU1YOiZsFq
         UzYy5nigbZyUR7uUmCcAvh1eX3GL68s2mAfvnJHcz/bLXemeqZtNke9HH3eY1Y/LfRFI
         e68GU2TNLNrW+FWRfbACTn8wJk4JfqnvSAOWYkeIg1os3X9Wvj63UneWagsdhUUn9g7h
         dQqbox6IlLFAIURjGvUNTNwZCLACgYjwF+3Fp9QhLeV9GVi/1oaj48V0wP9mh6dvesTk
         Fyxg==
X-Forwarded-Encrypted: i=1; AFNElJ+kPFEgsjqsPZhWH1Yw8HvbJZGn+jL4R00jrYQbsOvK0n8f4BkK2Kf5TMM80F3BAKSnowGUtyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVb1SqdJ9bydzp1uWvhj9I6hbisEgcPFEZ66WWAcanPy4193K7
	sKf8QXLjMuF7AwORWRBE4zzZ5yTnL0BnX892IlDkRLimEtvt6xRRh8Q0nE/B7vgSNYw=
X-Gm-Gg: AeBDietSpx+EKVRRYMbK3tSHG3T7xmJIc3YJajsAjG0CwA2V9+fDZaSV2EsIph+zzKF
	Aq8yc34LUSRQcjLJGG6re8KO9uEg3eDNDv2nX4bHDKkfNG+H2z7rpdM+cdbrqB2DtO8cPq7PiNs
	G0SgVjvJAHT0B/xhQ0T6iBC9mZc/Xn8yfBp282lFbMnSg9sfo3X4m3ZcqvhevaEzJqSlU+yPQjj
	eFj3hptkNeTz5Ay4pOSzaEO3yd7rO5+56H3tCIMMvkzxeOAitC+Egc++RfKLFQxIrU2D5qmteTD
	1qTKNO+cQ26HR0Qic18BZIT+NiA3X2UvQ7j61/95KZRPJ8PCJ06pSQzbhmWOiiVV5ltXqHLS07s
	SgiEXZtMRd6d8wn1AcNENfrOAqixpXgQWsftww8gY8pNlWfs88brHdVB5VdUhYkU9/O5NhcojmE
	xXWSelNffsUIlO74grcWjnknnlI1KvbFT7Rp+hFJ61AhKVWG0/o2iloThQ/bRMsmao6Q998hjv4
	b96DvtvuIaTrzJqj1FWgBY=
X-Received: by 2002:a17:903:2ac6:b0:2b2:549f:7d2b with SMTP id d9443c01a7336-2b5f9ee2f21mr283530745ad.11.1776951714755;
        Thu, 23 Apr 2026 06:41:54 -0700 (PDT)
Received: from eulgyu-desktop.localdomain ([147.46.174.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3casm250057675ad.17.2026.04.23.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:41:54 -0700 (PDT)
From: Eulgyu Kim <eulgyukim@snu.ac.kr>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	byoungyoung@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] KASAN: slab-use-after-free Write in sk_skb_reason_drop
Date: Thu, 23 Apr 2026 22:41:47 +0900
Message-ID: <20260423134147.1933565-1-eulgyukim@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eulgyukim@snu.ac.kr,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280768-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:server fail];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,snu.ac.kr:dkim,snu.ac.kr:mid]
X-Rspamd-Queue-Id: F2AD94532FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

We encountered a "KASAN: slab-use-after-free Write in sk_skb_reason_drop"
on kernel version v7.0.

As this memory corruption bug seems to require `CAP_NET_ADMIN`,
we report this in public mailing list.

We have included the following items below:
- C reproducer (~100 lines)
- kernel delay patch
- KASAN crash log

To reliably trigger the race condition bug, we patched the kernel
to inject a delay at a specific point.

The kernel config used is the same as the syzbot configuration.

Unfortunately, we do not have a fix ready for this bug yet.
As this issue was identified via fuzzing and we have limited background,
we find it challenging to propose a correct fix or evaluate
its potential severity.

We hope this report helps address the issue. Please let us know
if any further information is needed.

Thank you.

Best Regards,
Eulgyu Kim



kernel delay patch:
==================================================================
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c492fda6f..ba7078e18 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1891,6 +1891,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
            !tfile->detached)
                rxhash = __skb_get_hash_symmetric(skb);

+       if (strcmp(current->comm, "slowme") == 0) {
+               mdelay(2000);
+       }
+
        rcu_read_lock();
        if (unlikely(!(tun->dev->flags & IFF_UP))) {
                err = -EIO;
==================================================================



C reproducer:
==================================================================
#define _GNU_SOURCE

#include <fcntl.h>
#include <linux/aio_abi.h>
#include <linux/if_tun.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <pthread.h>
#include <stdint.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <unistd.h>

static int tun_fd = -1;
static int route_fd = -1;
static aio_context_t aio_ctx;

static unsigned char tap_frame[14];

static struct iocb aio_cb;
static struct iocb *aio_cbs[] = {
    &aio_cb,
};

static struct {
    struct nlmsghdr nlh;
    struct ifinfomsg ifi;
    struct rtattr attr;
    char ifname[16];
} delete_link = {
    .nlh = {
        .nlmsg_len = sizeof(delete_link),
        .nlmsg_type = RTM_DELLINK,
        .nlmsg_flags = NLM_F_REQUEST,
    },
    .attr = {
        .rta_len = sizeof(struct rtattr) + 16,
        .rta_type = IFLA_IFNAME,
    },
    .ifname = "test1",
};

void *thread_fn(void *arg)
{
    aio_cb.aio_lio_opcode = IOCB_CMD_PWRITE;
    aio_cb.aio_fildes = tun_fd;
    aio_cb.aio_buf = (uint64_t)(uintptr_t)tap_frame;
    aio_cb.aio_nbytes = sizeof(tap_frame);
    syscall(__NR_io_setup, 1, &aio_ctx);

    prctl(PR_SET_NAME, "slowme", 0, 0, 0);
    syscall(__NR_io_submit, aio_ctx, 1L, aio_cbs);
    return NULL;
}

int main(void)
{
    struct ifreq ifr = {0};
    struct sockaddr_nl kernel = {
        .nl_family = AF_NETLINK,
    };
    struct iovec iov = {
        .iov_base = &delete_link,
        .iov_len = sizeof(delete_link),
    };
    struct msghdr msg = {
        .msg_name = &kernel,
        .msg_namelen = sizeof(kernel),
        .msg_iov = &iov,
        .msg_iovlen = 1,
    };
    pthread_t thread;

    tun_fd = open("/dev/net/tun", O_WRONLY);

    strcpy(ifr.ifr_name, "test1");
    ifr.ifr_flags = IFF_TAP | IFF_NAPI | IFF_NAPI_FRAGS | IFF_NO_PI;
    ioctl(tun_fd, TUNSETIFF, &ifr);

    pthread_create(&thread, NULL, thread_fn, NULL);

    sleep(1);
    route_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    sendmsg(route_fd, &msg, 0);

    return 0;
}

==================================================================



KASAN crash log:
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: slab-use-after-free in __refcount_sub_and_test include/linux/refcount.h:389 [inline]
BUG: KASAN: slab-use-after-free in __refcount_dec_and_test include/linux/refcount.h:432 [inline]
BUG: KASAN: slab-use-after-free in refcount_dec_and_test include/linux/refcount.h:450 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1292 [inline]
BUG: KASAN: slab-use-after-free in __sk_skb_reason_drop net/core/skbuff.c:1223 [inline]
BUG: KASAN: slab-use-after-free in sk_skb_reason_drop+0x37/0x110 net/core/skbuff.c:1251
Write of size 4 at addr ffff888126d779e4 by task slowme/10161
CPU: 4 UID: 0 PID: 10161 Comm: slowme Not tainted 7.0.0-g1e0734834e71 #29 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:389 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 skb_unref include/linux/skbuff.h:1292 [inline]
 __sk_skb_reason_drop net/core/skbuff.c:1223 [inline]
 sk_skb_reason_drop+0x37/0x110 net/core/skbuff.c:1251
 kfree_skb_reason include/linux/skbuff.h:1322 [inline]
 tun_get_user+0x17bc/0x3e70 drivers/net/tun.c:1978
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2003
 aio_write+0x535/0x7a0 fs/aio.c:1633
 __io_submit_one fs/aio.c:-1 [inline]
 io_submit_one+0x775/0x1430 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x185/0x320 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x415b8d
Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9af2f7b228 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f9af2f7bcdc RCX: 0000000000415b8d
RDX: 00000000004c7158 RSI: 0000000000000001 RDI: 00007f9af277a000
RBP: 00007f9af2f7b240 R08: 00007f9af2f7b6c0 R09: 00007f9af2f7b6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9af2f7b6c0
R13: ffffffffffffffb8 R14: 0000000000000000 R15: 00007ffdbdd55900
 </TASK>
Allocated by task 10161:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_mempool_unpoison_object+0x9f/0x130 mm/kasan/common.c:564
 kasan_mempool_unpoison_object include/linux/kasan.h:391 [inline]
 napi_skb_cache_get+0x3c9/0x780 net/core/skbuff.c:306
 __alloc_skb+0x146/0x7d0 net/core/skbuff.c:691
 napi_alloc_skb+0x7a/0xaf0 net/core/skbuff.c:853
 napi_get_frags+0x69/0x140 net/core/gro.c:681
 tun_napi_alloc_frags drivers/net/tun.c:1404 [inline]
 tun_get_user+0x77c/0x3e70 drivers/net/tun.c:1784
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2003
 aio_write+0x535/0x7a0 fs/aio.c:1633
 __io_submit_one fs/aio.c:-1 [inline]
 io_submit_one+0x775/0x1430 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x185/0x320 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Freed by task 10157:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kmem_cache_free+0x189/0x640 mm/slub.c:6295
 kfree_skb_reason include/linux/skbuff.h:1322 [inline]
 kfree_skb include/linux/skbuff.h:1331 [inline]
 napi_free_frags include/linux/netdevice.h:4262 [inline]
 __netif_napi_del_locked+0x2bb/0x3c0 net/core/dev.c:7684
 __netif_napi_del include/linux/netdevice.h:2910 [inline]
 netif_napi_del include/linux/netdevice.h:2928 [inline]
 tun_napi_del drivers/net/tun.c:293 [inline]
 tun_detach_all drivers/net/tun.c:671 [inline]
 tun_net_uninit+0x566/0xa70 drivers/net/tun.c:953
 unregister_netdevice_many_notify+0x1ce5/0x2340 net/core/dev.c:12452
 rtnl_delete_link net/core/rtnetlink.c:3550 [inline]
 rtnl_dellink+0x513/0x720 net/core/rtnetlink.c:3592
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6994
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x981/0xa00 net/socket.c:2592
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
The buggy address belongs to the object at ffff888126d77900
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 228 bytes inside of
 freed 240-byte region [ffff888126d77900, ffff888126d779f0)
The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888126d77400 pfn:0x126d76
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88811a8f8e01
flags: 0x17ff00000000240(workingset|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000240 ffff888101af5900 ffffea0005b48590 ffffea0005c35610
raw: ffff888126d77400 000000080019000d 00000000f5000000 ffff88811a8f8e01
head: 017ff00000000240 ffff888101af5900 ffffea0005b48590 ffffea0005c35610
head: ffff888126d77400 000000080019000d 00000000f5000000 ffff88811a8f8e01
head: 017ff00000000001 ffffea00049b5d81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5283, tgid 5283 (udevadm), ts 18916143409, free_ts 16721349562
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x23d/0x2a0 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24e0/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab+0x77/0x670 mm/slub.c:3481
 new_slab mm/slub.c:3539 [inline]
 refill_objects+0x33a/0x3d0 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x2e8/0x730 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 kmem_cache_alloc_node_noprof+0x443/0x6a0 mm/slub.c:4918
 __alloc_skb+0x1d0/0x7d0 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_uevent_skb+0x7d/0x230 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast+0x2fa/0x560 lib/kobject_uevent.c:410
 kobject_uevent_env+0x55c/0x9f0 lib/kobject_uevent.c:611
 kobject_synth_uevent+0x527/0xb00 lib/kobject_uevent.c:207
 bus_uevent_store+0x115/0x170 drivers/base/bus.c:910
 kernfs_fop_write_iter+0x3af/0x540 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:688
 ksys_write+0x145/0x250 fs/read_write.c:740
page last free pid 5331 tgid 5331 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc43/0xde0 mm/page_alloc.c:2978
 __slab_free+0x263/0x2b0 mm/slub.c:5573
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 __do_kmalloc_node mm/slub.c:5259 [inline]
 __kmalloc_noprof+0x317/0x770 mm/slub.c:5272
 kmalloc_noprof include/linux/slab.h:954 [inline]
 tomoyo_realpath_from_path+0xe3/0x5d0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x1e8/0x5a0 security/tomoyo/file.c:728
 security_file_ioctl+0xcb/0x2d0 security/security.c:2436
 __do_sys_ioctl fs/ioctl.c:591 [inline]
 __se_sys_ioctl+0x47/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Memory state around the buggy address:
 ffff888126d77880: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff888126d77900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888126d77980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                       ^
 ffff888126d77a00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888126d77a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

