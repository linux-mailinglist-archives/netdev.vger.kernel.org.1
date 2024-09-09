Return-Path: <netdev+bounces-126549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCBA971C6B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D4C282091
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3F1BA26F;
	Mon,  9 Sep 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="Jki/8RUn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730DD1BA286;
	Mon,  9 Sep 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891849; cv=none; b=Ynjp7av6XTlVEl4lgt9Ki2eCn1n6dNgpV83XZ4ELIgBeqPl8EDva7fEM0LB0FVfI616p/5/W8ksxoDph/85fnhY/ZomWc09XcWm9Pw3R6NY0LcdhQyWMrsnw286+bM4NL7PXjKnOp03D0r5lW9/bEKq3tCH8jK8EhqRz63B0oNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891849; c=relaxed/simple;
	bh=yih1JKEi5S+cVQYgac1mEeT91xxXGr/+YHurIOaBEco=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rGUzP2KTjD09qHXbgF1sui1rXaZHMtXwbkJInDBx81HISsdBCuZHxtxPFdZ7v2vKVa/Nqeq2ZADyCYC9Y+xf7XyPoymVP2Z8aBFiFHz/EVmFXDcva7xpUGBSpPJmomqN0k0VwVDPDoamkvHeuKU6QFWvZPOs370Md8vn9wJYrME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=Jki/8RUn; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id ADA11112C628;
	Mon,  9 Sep 2024 17:18:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru ADA11112C628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1725891509; bh=DBUNDsprJ9aLnQQfedUzhI0hMQKv26MW41blIInBndU=;
	h=From:To:Subject:Date:From;
	b=Jki/8RUnyAAccZ61/3XWJB9Uf+PHI/WgQ5nbqjihf/8tUDLKPTIGCWLm2IORx/QRt
	 Zg9miBtyLP+S4Uknu3VWq312zkPsSifvh33X6p3qrIGsdjUwiy0hBm5MivTGrcGcEw
	 OaOrylS5p+xMUuEvkoJNHLY1pMYNz5P3atOgrY7Q=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id AA465313D307;
	Mon,  9 Sep 2024 17:18:28 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "roopa@nvidia.com"
	<roopa@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Kmemleak false positives in mld_newpack() and ndisc_alloc_skb()
Thread-Topic: Kmemleak false positives in mld_newpack() and ndisc_alloc_skb()
Thread-Index: AQHbAsMjHXmCyRbzlkupSXo1Bme0CA==
Date: Mon, 9 Sep 2024 14:18:28 +0000
Message-ID: <Zt8DszHeHqK4UzhI@debian.infotecs-nt>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA31690BBE54C64C9B0C0C1AD3C791D9@infotecs.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/09/09 07:41:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/09/09 11:31:00 #26546663
X-KLMS-AntiVirus-Status: Clean, skipped

Hi,
my local syzbot reported memory leak issues at mld_newpack():

BUG: memory leak
unreferenced object 0xffff888105083000 (size 2048):
  comm "softirq", pid 0, jiffies 4295566459 (age 39.329s)
  hex dump (first 32 bytes):
    00 00 33 33 00 00 00 16 aa aa aa aa aa 0c 86 dd  ..33............
    60 00 00 00 00 4c 00 01 00 00 00 00 00 00 00 00  `....L..........
  backtrace:
    [<00000000998fe539>] __kmalloc_reserve net/core/skbuff.c:142 [inline]
    [<00000000998fe539>] __alloc_skb+0xac/0x630 net/core/skbuff.c:210
    [<0000000096d01817>] alloc_skb include/linux/skbuff.h:1096 [inline]
    [<0000000096d01817>] alloc_skb_with_frags+0x92/0x570 net/core/skbuff.c:=
5896
    [<000000005e7dbbfe>] sock_alloc_send_pskb+0x797/0x920 net/core/sock.c:2=
348
    [<0000000021266c13>] mld_newpack+0x1d2/0x760 net/ipv6/mcast.c:1604
    [<000000007bf59075>] add_grhead+0x269/0x340 net/ipv6/mcast.c:1707
    [<0000000080a93257>] add_grec+0xe30/0x10a0 net/ipv6/mcast.c:1838
    [<00000000206e567d>] mld_send_cr net/ipv6/mcast.c:1964 [inline]
    [<00000000206e567d>] mld_ifc_timer_expire+0x596/0xf10 net/ipv6/mcast.c:=
2471
    [<0000000023c64f57>] call_timer_fn+0x181/0x5f0 kernel/time/timer.c:1414
    [<000000001a53ddf1>] expire_timers kernel/time/timer.c:1459 [inline]
    [<000000001a53ddf1>] __run_timers.part.0+0x66b/0xa50 kernel/time/timer.=
c:1753
    [<0000000070064c8e>] __run_timers kernel/time/timer.c:1731 [inline]
    [<0000000070064c8e>] run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1=
766
    [<00000000d67c96e4>] __do_softirq+0x286/0x9a3 kernel/softirq.c:298
    [<0000000002a81fe9>] asm_call_irq_on_stack+0xf/0x20
    [<000000001b74b134>] __run_on_irqstack arch/x86/include/asm/irq_stack.h=
:26 [inline]
    [<000000001b74b134>] run_on_irqstack_cond arch/x86/include/asm/irq_stac=
k.h:77 [inline]
    [<000000001b74b134>] do_softirq_own_stack+0xaa/0xe0 arch/x86/kernel/irq=
_64.c:77
    [<000000009c0f9a71>] invoke_softirq kernel/softirq.c:393 [inline]
    [<000000009c0f9a71>] __irq_exit_rcu kernel/softirq.c:423 [inline]
    [<000000009c0f9a71>] irq_exit_rcu+0x136/0x200 kernel/softirq.c:435
    [<0000000072169c58>] sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/ke=
rnel/apic/apic.c:1095
    [<000000006d64a7a1>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86=
/include/asm/idtentry.h:635

I reproduced these issues and confirmed they still existed in the latest
upstream and in 5.10 stable releases. As it turned out later, all these lea=
ks
are false positive.

I noticed that the detected leaks relate only to network packets.
The struct sk_buff itself is released and isn't detected as a memory leak,
but the kmemleak detector signals a leak of the "head" buffer containing
struct skb_shared_info and pointed to by skb_buff->head.

I found a similar issue
https://syzkaller.appspot.com/bug?id=3Dceee5d7bbf373a903551c396c66c0f7cb98d=
9bdd
which causes the same false positive leaks.

In all cases a network bridge is used.

In most cases, three types of leaks are detected
(all packets belong to the IPv6 protocol):

1) When sending Router Solicitation type 133
(ICMPv6, Neighbor Discovery Protocol (NDP))

BUG: memory leak
unreferenced object ffff88801a526300 (size 704):

  comm "softirq", pid 0, jiffies 4294749186
  hex dump (first 32 bytes):
    00 00 33 33 00 00 00 02 aa aa aa aa aa 0c 86 dd  ..33............
    60 00 00 00 00 10 3a ff fe 80 00 00 00 00 00 00  `.....:.........
  backtrace (crc 3ab17827):
    [<ffffffff81d3ebd5>] kmem_cache_alloc_node+0x2d5/0x380
    [<ffffffff868cda3a>] kmalloc_reserve+0x16a/0x260
    [<ffffffff868d6d76>] __alloc_skb+0x126/0x330
    [<ffffffff875de515>] ndisc_alloc_skb+0x135/0x340
    [<ffffffff875eb81e>] ndisc_send_rs+0x7e/0x910
    [<ffffffff87577ffb>] addrconf_rs_timer+0x2fb/0x7e0
    [<ffffffff8175f42a>] call_timer_fn+0x17a/0x500
    [<ffffffff8175fe44>] __run_timers.part.0+0x684/0x970
    [<ffffffff817601fa>] run_timer_softirq+0xba/0x1d0
    [<ffffffff88a1932f>] __do_softirq+0x1df/0x8ce

2) When sending Neighbor Solicitation (Type 135)

BUG: memory leak
unreferenced object ffff888015215500 (size 704):
  comm "kworker/1:1", pid 49, jiffies 4294733392
  hex dump (first 32 bytes):
    00 a0 33 33 ff aa aa 0a aa aa aa aa aa 0a 86 dd  ..33............
    60 00 00 00 00 20 3a ff 00 00 00 00 00 00 00 00  `.... :.........
  backtrace (crc 7d46e68f):
    [<ffffffff81d3ebd5>] kmem_cache_alloc_node+0x2d5/0x380
    [<ffffffff868cda3a>] kmalloc_reserve+0x16a/0x260
    [<ffffffff868d6d76>] __alloc_skb+0x126/0x330
    [<ffffffff875de705>] ndisc_alloc_skb+0x135/0x340
    [<ffffffff875def82>] ndisc_ns_create+0x192/0xc40
    [<ffffffff875eb538>] ndisc_send_ns+0x98/0x130
    [<ffffffff8757a2bf>] addrconf_dad_work+0xc5f/0x14a0
    [<ffffffff81541cca>] process_one_work+0x7ca/0x1450
    [<ffffffff815431ce>] worker_thread+0x86e/0x1230
    [<ffffffff81564639>] kthread+0x339/0x440
    [<ffffffff8131a088>] ret_from_fork+0x48/0x80
    [<ffffffff81004ddb>] ret_from_fork_asm+0x1b/0x30

3) When sending MLDv2 Multicast Listener Report (Type 143)

BUG: memory leak
unreferenced object ffff8881055df000 (size 2048):
  comm "kworker/3:2", pid 272, jiffies 4294729488
  hex dump (first 32 bytes):
    00 00 33 33 00 00 00 16 de c9 ae f0 47 15 86 dd  ..33........G...
    60 00 00 00 00 24 00 01 00 00 00 00 00 00 00 00  `....$..........
  backtrace (crc 981e6671):
    [<ffffffff81d40443>] __kmalloc_node_track_caller+0x3b3/0x4b0
    [<ffffffff868cd9ef>] kmalloc_reserve+0xef/0x260
    [<ffffffff868d6d56>] __alloc_skb+0x126/0x330
    [<ffffffff868eed04>] alloc_skb_with_frags+0xe4/0x710
    [<ffffffff868b76f8>] sock_alloc_send_pskb+0x7e8/0x970
    [<ffffffff87616d63>] mld_newpack.isra.0+0x1e3/0xa90
    [<ffffffff876178ac>] add_grhead+0x28c/0x380
    [<ffffffff87620437>] add_grec+0x11e7/0x18a0
    [<ffffffff8762528f>] mld_ifc_work+0x41f/0xcd0
    [<ffffffff81541cca>] process_one_work+0x7ca/0x1450
    [<ffffffff815431ce>] worker_thread+0x86e/0x1230
    [<ffffffff81564639>] kthread+0x339/0x440
    [<ffffffff8131a088>] ret_from_fork+0x48/0x80
    [<ffffffff81004ddb>] ret_from_fork_asm+0x1b/0x30

To make sure that these aren't leaks, I made a patch that adds fields
to struct skb_shared_info for debugging. The patch sets a unique ID for
the network packet when the packet is allocated and prints this ID when
the packet is deleted in the skb_release_data() function.

Patch fragment:

+struct skb_dbg {
+		long id;                  // a unique ID for skb_shared_info
+		atomic_t clone_count;     // the number of cloning
+};

@@ -603,6 +622,7 @@ struct skb_shared_info {
 	unsigned int	gso_type;
 	u32		tskey;

+	struct skb_dbg  dbg;


I also tried to dump leaked objects in this way:

BUG: memory leak
unreferenced object 0xffff888082831000 (size 2048):
...
BUG: memory leak
unreferenced object 0xffff888103c3de00 (size 704):
...
BUG: memory leak
unreferenced object 0xffff888081ecd000 (size 2048):
...

root@syzkaller:~# echo dump=3D0xffff888082831000 > /sys/kernel/debug/kmemle=
ak
[  192.540842] kmemleak: Unknown object at 0xffff888082831000

root@syzkaller:~# echo dump=3D0xffff888103c3de00 > /sys/kernel/debug/kmemle=
ak
[  211.628825] kmemleak: Unknown object at 0xffff888103c3de00

root@syzkaller:~# echo dump=3D0xffff888081ecd000 > /sys/kernel/debug/kmemle=
ak
[  220.300779] kmemleak: Unknown object at 0xffff888081ecd000

As one can be see, these objects aren't in the list of kmemleak detector ob=
jects.

I assume that one of the reasons for the leaks is that after cloning a pack=
et,
the kmemleak detector somehow doesn't take sk_buff->head links into account
during the scan. In scenarios with bridge, cloning happens quite a lot.

Interestingly, if I add a single line to __skb_clone() that increases
the cloning counter, the leaks are no longer detected:

@@ -1614,6 +1619,7 @@ static struct sk_buff *__skb_clone(struct sk_buff *n,=
 struct sk_buff *skb)
 	refcount_set(&n->users, 1);

 	atomic_inc(&(skb_shinfo(skb)->dataref));
+	atomic_inc(&(skb_shinfo(skb)->dbg.clone_count)); // when you add this lin=
e, the leaks disappear
 	skb->cloned =3D 1;

I'm attaching a slightly simplified reproducer:

=3D* repro.c =3D*
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <netinet/in.h>
#include <sched.h>
#include <setjmp.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/capability.h>
#include <linux/genetlink.h>
#include <linux/if_addr.h>
#include <linux/if_ether.h>
#include <linux/if_link.h>

#include <linux/in6.h>
#include <linux/ip.h>
#include <linux/neighbour.h>
#include <linux/net.h>
#include <linux/netlink.h>
//#include <linux/nl80211.h>
#include <linux/rfkill.h>
#include <linux/rtnetlink.h>
#include <linux/tcp.h>
#include <linux/veth.h>

static unsigned long long procid;

static __thread int skip_segv;
static __thread jmp_buf segv_env;

static void segv_handler(int sig, siginfo_t *info, void *ctx)
{
	uintptr_t addr =3D (uintptr_t)info->si_addr;
	const uintptr_t prog_start =3D 1 << 20;
	const uintptr_t prog_end =3D 100 << 20;
	int skip =3D __atomic_load_n(&skip_segv, __ATOMIC_RELAXED) !=3D 0;
	int valid =3D addr < prog_start || addr > prog_end;
	if (skip && valid) {
		_longjmp(segv_env, 1);
	}
	exit(sig);
}

static void install_segv_handler(void)
{
	struct sigaction sa;
	memset(&sa, 0, sizeof(sa));
	sa.sa_handler =3D SIG_IGN;
	syscall(SYS_rt_sigaction, 0x20, &sa, NULL, 8);
	syscall(SYS_rt_sigaction, 0x21, &sa, NULL, 8);
	memset(&sa, 0, sizeof(sa));
	sa.sa_sigaction =3D segv_handler;
	sa.sa_flags =3D SA_NODEFER | SA_SIGINFO;
	sigaction(SIGSEGV, &sa, NULL);
	sigaction(SIGBUS, &sa, NULL);
}

#define NONFAILING(...)                                              \
	({                                                           \
		int ok =3D 1;                                          \
		__atomic_fetch_add(&skip_segv, 1, __ATOMIC_SEQ_CST); \
		if (_setjmp(segv_env) =3D=3D 0) {                        \
			__VA_ARGS__;                                 \
		} else                                               \
			ok =3D 0;                                      \
		__atomic_fetch_sub(&skip_segv, 1, __ATOMIC_SEQ_CST); \
		ok;                                                  \
	})

static void sleep_ms(uint64_t ms)
{
	usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
	struct timespec ts;
	if (clock_gettime(CLOCK_MONOTONIC, &ts))
		exit(1);
	return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void use_temporary_dir(void)
{
	char tmpdir_template[] =3D "./syzkaller.XXXXXX";
	char *tmpdir =3D mkdtemp(tmpdir_template);
	if (!tmpdir)
		exit(1);
	if (chmod(tmpdir, 0777))
		exit(1);
	if (chdir(tmpdir))
		exit(1);
}

static bool write_file(const char *file, const char *what, ...)
{
	char buf[1024];
	va_list args;
	va_start(args, what);
	vsnprintf(buf, sizeof(buf), what, args);
	va_end(args);
	buf[sizeof(buf) - 1] =3D 0;
	int len =3D strlen(buf);
	int fd =3D open(file, O_WRONLY | O_CLOEXEC);
	if (fd =3D=3D -1)
		return false;
	if (write(fd, buf, len) !=3D len) {
		int err =3D errno;
		close(fd);
		errno =3D err;
		return false;
	}
	close(fd);
	return true;
}

struct nlmsg {
	char *pos;
	int nesting;
	struct nlattr *nested[8];
	char buf[4096];
};

static void netlink_init(struct nlmsg *nlmsg, int typ, int flags,
			 const void *data, int size)
{
	memset(nlmsg, 0, sizeof(*nlmsg));
	struct nlmsghdr *hdr =3D (struct nlmsghdr *)nlmsg->buf;
	hdr->nlmsg_type =3D typ;
	hdr->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | flags;
	memcpy(hdr + 1, data, size);
	nlmsg->pos =3D (char *)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg *nlmsg, int typ, const void *data,
			 int size)
{
	struct nlattr *attr =3D (struct nlattr *)nlmsg->pos;
	attr->nla_len =3D sizeof(*attr) + size;
	attr->nla_type =3D typ;
	if (size > 0)
		memcpy(attr + 1, data, size);
	nlmsg->pos +=3D NLMSG_ALIGN(attr->nla_len);
}

static void netlink_nest(struct nlmsg *nlmsg, int typ)
{
	struct nlattr *attr =3D (struct nlattr *)nlmsg->pos;
	attr->nla_type =3D typ;
	nlmsg->pos +=3D sizeof(*attr);
	nlmsg->nested[nlmsg->nesting++] =3D attr;
}

static void netlink_done(struct nlmsg *nlmsg)
{
	struct nlattr *attr =3D nlmsg->nested[--nlmsg->nesting];
	attr->nla_len =3D nlmsg->pos - (char *)attr;
}

static int netlink_send_ext(struct nlmsg *nlmsg, int sock, uint16_t reply_t=
ype,
			    int *reply_len, bool dofail)
{
	if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting)
		exit(1);
	struct nlmsghdr *hdr =3D (struct nlmsghdr *)nlmsg->buf;
	hdr->nlmsg_len =3D nlmsg->pos - nlmsg->buf;
	struct sockaddr_nl addr;
	memset(&addr, 0, sizeof(addr));
	addr.nl_family =3D AF_NETLINK;
	ssize_t n =3D sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
			   (struct sockaddr *)&addr, sizeof(addr));
	if (n !=3D (ssize_t)hdr->nlmsg_len) {
		if (dofail)
			exit(1);
		return -1;
	}
	n =3D recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
	if (reply_len)
		*reply_len =3D 0;
	if (n < 0) {
		if (dofail)
			exit(1);
		return -1;
	}
	if (n < (ssize_t)sizeof(struct nlmsghdr)) {
		errno =3D EINVAL;
		if (dofail)
			exit(1);
		return -1;
	}
	if (hdr->nlmsg_type =3D=3D NLMSG_DONE)
		return 0;
	if (reply_len && hdr->nlmsg_type =3D=3D reply_type) {
		*reply_len =3D n;
		return 0;
	}
	if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
		errno =3D EINVAL;
		if (dofail)
			exit(1);
		return -1;
	}
	if (hdr->nlmsg_type !=3D NLMSG_ERROR) {
		errno =3D EINVAL;
		if (dofail)
			exit(1);
		return -1;
	}
	errno =3D -((struct nlmsgerr *)(hdr + 1))->error;
	return -errno;
}

static int netlink_send(struct nlmsg *nlmsg, int sock)
{
	return netlink_send_ext(nlmsg, sock, 0, NULL, true);
}


static void netlink_add_device_impl(struct nlmsg *nlmsg, const char *type,
				    const char *name)
{
	struct ifinfomsg hdr;
	memset(&hdr, 0, sizeof(hdr));
	netlink_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr,
		     sizeof(hdr));
	if (name)
		netlink_attr(nlmsg, IFLA_IFNAME, name, strlen(name));
	netlink_nest(nlmsg, IFLA_LINKINFO);
	netlink_attr(nlmsg, IFLA_INFO_KIND, type, strlen(type));
}

static void netlink_add_device(struct nlmsg *nlmsg, int sock, const char *t=
ype,
			       const char *name)
{
	netlink_add_device_impl(nlmsg, type, name);
	netlink_done(nlmsg);
	int err =3D netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_add_veth(struct nlmsg *nlmsg, int sock, const char *nam=
e,
			     const char *peer)
{
	netlink_add_device_impl(nlmsg, "veth", name);
	netlink_nest(nlmsg, IFLA_INFO_DATA);
	netlink_nest(nlmsg, VETH_INFO_PEER);
	nlmsg->pos +=3D sizeof(struct ifinfomsg);
	netlink_attr(nlmsg, IFLA_IFNAME, peer, strlen(peer));
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	int err =3D netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_device_change(struct nlmsg *nlmsg, int sock,
				  const char *name, bool up, const char *master,
				  const void *mac, int macsize,
				  const char *new_name)
{
	struct ifinfomsg hdr;
	memset(&hdr, 0, sizeof(hdr));
	if (up)
		hdr.ifi_flags =3D hdr.ifi_change =3D IFF_UP;
	hdr.ifi_index =3D if_nametoindex(name);
	netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
	if (new_name)
		netlink_attr(nlmsg, IFLA_IFNAME, new_name, strlen(new_name));
	if (master) {
		int ifindex =3D if_nametoindex(master);
		netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
	}
	if (macsize)
		netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
	int err =3D netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static int netlink_add_addr(struct nlmsg *nlmsg, int sock, const char *dev,
			    const void *addr, int addrsize)
{
	struct ifaddrmsg hdr;
	memset(&hdr, 0, sizeof(hdr));
	hdr.ifa_family =3D addrsize =3D=3D 4 ? AF_INET : AF_INET6;
	hdr.ifa_prefixlen =3D addrsize =3D=3D 4 ? 24 : 120;
	hdr.ifa_scope =3D RT_SCOPE_UNIVERSE;
	hdr.ifa_index =3D if_nametoindex(dev);
	netlink_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr,
		     sizeof(hdr));
	netlink_attr(nlmsg, IFA_LOCAL, addr, addrsize);
	netlink_attr(nlmsg, IFA_ADDRESS, addr, addrsize);
	return netlink_send(nlmsg, sock);
}

static void netlink_add_addr4(struct nlmsg *nlmsg, int sock, const char *de=
v,
			      const char *addr)
{
	struct in_addr in_addr;
	inet_pton(AF_INET, addr, &in_addr);
	int err =3D netlink_add_addr(nlmsg, sock, dev, &in_addr, sizeof(in_addr));
	if (err < 0) {
	}
}

static void netlink_add_addr6(struct nlmsg *nlmsg, int sock, const char *de=
v,
			      const char *addr)
{
	struct in6_addr in6_addr;
	inet_pton(AF_INET6, addr, &in6_addr);
	int err =3D
		netlink_add_addr(nlmsg, sock, dev, &in6_addr, sizeof(in6_addr));
	if (err < 0) {
	}
}

static struct nlmsg nlmsg;

#define DEV_IPV4 "172.20.20.%d"
#define DEV_IPV6 "fe80::%02x"
#define DEV_MAC 0x00aaaaaaaaaa

static void initialize_netdevices(void)
{
	struct {
		const char *type;
		const char *dev;
	} devtypes[] =3D {
		{ "bridge", "bridge0" },
		{ "veth", 0 },
	};

	const char *devmasters[] =3D {
		"bridge",
	};

	struct {
		const char *name;
		int macsize;
	} devices[] =3D {
		//{ "lo", ETH_ALEN },
		{ "bridge0", ETH_ALEN },
//		{ "veth0", ETH_ALEN },
//		{ "veth1", ETH_ALEN },
		{ "veth0_to_bridge", ETH_ALEN },
		{ "veth1_to_bridge", ETH_ALEN },
	};
	int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (sock =3D=3D -1)
		exit(1);
	unsigned i;
	for (i =3D 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++)
		netlink_add_device(&nlmsg, sock, devtypes[i].type,
				   devtypes[i].dev);
	for (i =3D 0; i < sizeof(devmasters) / (sizeof(devmasters[0])); i++) {
		char master[32], slave0[32], veth0[32], slave1[32], veth1[32];
		sprintf(slave0, "%s_slave_0", devmasters[i]);
		sprintf(veth0, "veth0_to_%s", devmasters[i]);
		netlink_add_veth(&nlmsg, sock, slave0, veth0);
		sprintf(slave1, "%s_slave_1", devmasters[i]);
		sprintf(veth1, "veth1_to_%s", devmasters[i]);
		netlink_add_veth(&nlmsg, sock, slave1, veth1);
		sprintf(master, "%s0", devmasters[i]);
		netlink_device_change(&nlmsg, sock, slave0, false, master, 0, 0,
				      NULL);
		netlink_device_change(&nlmsg, sock, slave1, false, master, 0, 0,
				      NULL);
	}
	netlink_device_change(&nlmsg, sock, "bridge_slave_0", true, 0, 0, 0,
			      NULL);
	netlink_device_change(&nlmsg, sock, "bridge_slave_1", true, 0, 0, 0,
			      NULL);

	char addr[32];
	sprintf(addr, DEV_IPV4, 14 + 10);

	printf("-------------------------\n");
	for (i =3D 0; i < sizeof(devices) / (sizeof(devices[0])); i++) {
		char addr[32];
		sprintf(addr, DEV_IPV4, i + 10);
		netlink_add_addr4(&nlmsg, sock, devices[i].name, addr);

		uint64_t macaddr =3D DEV_MAC + ((i + 10ull) << 40);
		uint8_t * mac =3D (uint8_t *)&macaddr;

		sprintf(addr, DEV_IPV6, i + 10);
		netlink_add_addr6(&nlmsg, sock, devices[i].name, addr);
		printf("device: %16s  addr %s  mac %02x:%02x:%02x:%02x:%02x:%02x\n"
				, devices[i].name
				, addr
				, mac[0]
				, mac[1]
				, mac[2]
				, mac[3]
				, mac[4]
				, mac[5]
				);

		netlink_device_change(&nlmsg, sock, devices[i].name, true, 0,
				      &macaddr, devices[i].macsize, NULL);
	}
	printf("-------------------------\n");
	close(sock);
}

#define SIZEOF_IO_URING_SQE 64
#define SIZEOF_IO_URING_CQE 16
#define SQ_HEAD_OFFSET 0
#define SQ_TAIL_OFFSET 64
#define SQ_RING_MASK_OFFSET 256
#define SQ_RING_ENTRIES_OFFSET 264
#define SQ_FLAGS_OFFSET 276
#define SQ_DROPPED_OFFSET 272
#define CQ_HEAD_OFFSET 128
#define CQ_TAIL_OFFSET 192
#define CQ_RING_MASK_OFFSET 260
#define CQ_RING_ENTRIES_OFFSET 268
#define CQ_RING_OVERFLOW_OFFSET 284
#define CQ_FLAGS_OFFSET 280
#define CQ_CQES_OFFSET 320

struct io_sqring_offsets {
	uint32_t head;
	uint32_t tail;
	uint32_t ring_mask;
	uint32_t ring_entries;
	uint32_t flags;
	uint32_t dropped;
	uint32_t array;
	uint32_t resv1;
	uint64_t resv2;
};

struct io_cqring_offsets {
	uint32_t head;
	uint32_t tail;
	uint32_t ring_mask;
	uint32_t ring_entries;
	uint32_t overflow;
	uint32_t cqes;
	uint64_t resv[2];
};

struct io_uring_params {
	uint32_t sq_entries;
	uint32_t cq_entries;
	uint32_t flags;
	uint32_t sq_thread_cpu;
	uint32_t sq_thread_idle;
	uint32_t features;
	uint32_t resv[4];
	struct io_sqring_offsets sq_off;
	struct io_cqring_offsets cq_off;
};

#define IORING_OFF_SQ_RING 0
#define IORING_OFF_SQES 0x10000000ULL


#define MAX_FDS 30

static void mount_cgroups(const char *dir, const char **controllers, int co=
unt)
{
	if (mkdir(dir, 0777)) {
	}
	char enabled[128] =3D { 0 };
	int i =3D 0;
	for (; i < count; i++) {
		if (mount("none", dir, "cgroup", 0, controllers[i])) {
			continue;
		}
		umount(dir);
		strcat(enabled, ",");
		strcat(enabled, controllers[i]);
	}
	if (enabled[0] =3D=3D 0)
		return;
	if (mount("none", dir, "cgroup", 0, enabled + 1)) {
	}
	if (chmod(dir, 0777)) {
	}
}

static void setup_cgroups()
{
	const char *unified_controllers[] =3D { "+cpu", "+memory", "+io",
					      "+pids" };
	const char *net_controllers[] =3D { "net", "net_prio", "devices", "blkio",
					  "freezer" };
	const char *cpu_controllers[] =3D { "cpuset", "cpuacct", "hugetlb",
					  "rlimit" };
	if (mkdir("/syzcgroup", 0777)) {
	}
	if (mkdir("/syzcgroup/unified", 0777)) {
	}
	if (mount("none", "/syzcgroup/unified", "cgroup2", 0, NULL)) {
	}
	if (chmod("/syzcgroup/unified", 0777)) {
	}
	int unified_control =3D
		open("/syzcgroup/unified/cgroup.subtree_control", O_WRONLY);
	if (unified_control !=3D -1) {
		unsigned i;
		for (i =3D 0; i < sizeof(unified_controllers) /
					sizeof(unified_controllers[0]);
		     i++)
			if (write(unified_control, unified_controllers[i],
				  strlen(unified_controllers[i])) < 0) {
			}
		close(unified_control);
	}
	mount_cgroups("/syzcgroup/net", net_controllers,
		      sizeof(net_controllers) / sizeof(net_controllers[0]));
	mount_cgroups("/syzcgroup/cpu", cpu_controllers,
		      sizeof(cpu_controllers) / sizeof(cpu_controllers[0]));
	write_file("/syzcgroup/cpu/cgroup.clone_children", "1");
	write_file("/syzcgroup/cpu/cpuset.memory_pressure_enabled", "1");
}

static void setup_cgroups_loop()
{
	int pid =3D getpid();
	char file[128];
	char cgroupdir[64];
	snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/unified/syz%llu",
		 procid);
	if (mkdir(cgroupdir, 0777)) {
	}
	snprintf(file, sizeof(file), "%s/pids.max", cgroupdir);
	write_file(file, "32");
	snprintf(file, sizeof(file), "%s/memory.low", cgroupdir);
	write_file(file, "%d", 298 << 20);
	snprintf(file, sizeof(file), "%s/memory.high", cgroupdir);
	write_file(file, "%d", 299 << 20);
	snprintf(file, sizeof(file), "%s/memory.max", cgroupdir);
	write_file(file, "%d", 300 << 20);
	snprintf(file, sizeof(file), "%s/cgroup.procs", cgroupdir);
	write_file(file, "%d", pid);
	snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/cpu/syz%llu",
		 procid);
	if (mkdir(cgroupdir, 0777)) {
	}
	snprintf(file, sizeof(file), "%s/cgroup.procs", cgroupdir);
	write_file(file, "%d", pid);
	snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/net/syz%llu",
		 procid);
	if (mkdir(cgroupdir, 0777)) {
	}
	snprintf(file, sizeof(file), "%s/cgroup.procs", cgroupdir);
	write_file(file, "%d", pid);
}

static void setup_cgroups_test()
{
	char cgroupdir[64];
	snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/unified/syz%llu",
		 procid);
	if (symlink(cgroupdir, "./cgroup")) {
	}
	snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/cpu/syz%llu",
		 procid);
	if (symlink(cgroupdir, "./cgroup.cpu")) {
	}
	snprintf(cgroupdir, sizeof(cgroupdir), "/syzcgroup/net/syz%llu",
		 procid);
	if (symlink(cgroupdir, "./cgroup.net")) {
	}
}

static void setup_common()
{
	if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
	}
}

static void setup_binderfs()
{
	if (mkdir("/dev/binderfs", 0777)) {
	}
	if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
	}
}

static void loop();

static void sandbox_common()
{
	prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
	setsid();
	struct rlimit rlim;
	rlim.rlim_cur =3D rlim.rlim_max =3D (200 << 20);
	setrlimit(RLIMIT_AS, &rlim);
	rlim.rlim_cur =3D rlim.rlim_max =3D 32 << 20;
	setrlimit(RLIMIT_MEMLOCK, &rlim);
	rlim.rlim_cur =3D rlim.rlim_max =3D 136 << 20;
	setrlimit(RLIMIT_FSIZE, &rlim);
	rlim.rlim_cur =3D rlim.rlim_max =3D 1 << 20;
	setrlimit(RLIMIT_STACK, &rlim);
	rlim.rlim_cur =3D rlim.rlim_max =3D 0;
	setrlimit(RLIMIT_CORE, &rlim);
	rlim.rlim_cur =3D rlim.rlim_max =3D 256;
	setrlimit(RLIMIT_NOFILE, &rlim);
	if (unshare(CLONE_NEWNS)) {
	}
	if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
	}
	if (unshare(CLONE_NEWIPC)) {
	}
	if (unshare(0x02000000)) {
	}
	if (unshare(CLONE_NEWUTS)) {
	}
	if (unshare(CLONE_SYSVSEM)) {
	}
	typedef struct {
		const char *name;
		const char *value;
	} sysctl_t;
	static const sysctl_t sysctls[] =3D {
		{ "/proc/sys/kernel/shmmax", "16777216" },
		{ "/proc/sys/kernel/shmall", "536870912" },
		{ "/proc/sys/kernel/shmmni", "1024" },
		{ "/proc/sys/kernel/msgmax", "8192" },
		{ "/proc/sys/kernel/msgmni", "1024" },
		{ "/proc/sys/kernel/msgmnb", "1024" },
		{ "/proc/sys/kernel/sem", "1024 1048576 500 1024" },
	};
	unsigned i;
	for (i =3D 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
		write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid)
{
	if (pid < 0)
		exit(1);
	int status =3D 0;
	while (waitpid(-1, &status, __WALL) !=3D pid) {
	}
	return WEXITSTATUS(status);
}

static void drop_caps(void)
{
	struct __user_cap_header_struct cap_hdr =3D {};
	struct __user_cap_data_struct cap_data[2] =3D {};
	cap_hdr.version =3D _LINUX_CAPABILITY_VERSION_3;
	cap_hdr.pid =3D getpid();
	if (syscall(SYS_capget, &cap_hdr, &cap_data))
		exit(1);
	const int drop =3D (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
	cap_data[0].effective &=3D ~drop;
	cap_data[0].permitted &=3D ~drop;
	cap_data[0].inheritable &=3D ~drop;
	if (syscall(SYS_capset, &cap_hdr, &cap_data))
		exit(1);
}

static int do_sandbox_none(void)
{
	if (unshare(CLONE_NEWPID)) {
	}
	int pid =3D fork();
	if (pid !=3D 0)
		return wait_for_loop(pid);
	setup_common();
	sandbox_common();
	drop_caps();
	if (unshare(CLONE_NEWNET)) {
	}
	initialize_netdevices();
	setup_binderfs();
	loop();
	exit(1);
}

#define FS_IOC_SETFLAGS _IOW('f', 2, long)
static void remove_dir(const char *dir)
{
	int iter =3D 0;
	DIR *dp =3D 0;
retry:
	while (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW) =3D=3D 0) {
	}
	dp =3D opendir(dir);
	if (dp =3D=3D NULL) {
		if (errno =3D=3D EMFILE) {
			exit(1);
		}
		exit(1);
	}
	struct dirent *ep =3D 0;
	while ((ep =3D readdir(dp))) {
		if (strcmp(ep->d_name, ".") =3D=3D 0 ||
		    strcmp(ep->d_name, "..") =3D=3D 0)
			continue;
		char filename[FILENAME_MAX];
		snprintf(filename, sizeof(filename), "%s/%s", dir, ep->d_name);
		while (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW) =3D=3D 0) {
		}
		struct stat st;
		if (lstat(filename, &st))
			exit(1);
		if (S_ISDIR(st.st_mode)) {
			remove_dir(filename);
			continue;
		}
		int i;
		for (i =3D 0;; i++) {
			if (unlink(filename) =3D=3D 0)
				break;
			if (errno =3D=3D EPERM) {
				int fd =3D open(filename, O_RDONLY);
				if (fd !=3D -1) {
					long flags =3D 0;
					if (ioctl(fd, FS_IOC_SETFLAGS,
						  &flags) =3D=3D 0) {
					}
					close(fd);
					continue;
				}
			}
			if (errno =3D=3D EROFS) {
				break;
			}
			if (errno !=3D EBUSY || i > 100)
				exit(1);
			if (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW))
				exit(1);
		}
	}
	closedir(dp);
	for (int i =3D 0;; i++) {
		if (rmdir(dir) =3D=3D 0)
			break;
		if (i < 100) {
			if (errno =3D=3D EPERM) {
				int fd =3D open(dir, O_RDONLY);
				if (fd !=3D -1) {
					long flags =3D 0;
					if (ioctl(fd, FS_IOC_SETFLAGS,
						  &flags) =3D=3D 0) {
					}
					close(fd);
					continue;
				}
			}
			if (errno =3D=3D EROFS) {
				break;
			}
			if (errno =3D=3D EBUSY) {
				if (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW))
					exit(1);
				continue;
			}
			if (errno =3D=3D ENOTEMPTY) {
				if (iter < 100) {
					iter++;
					goto retry;
				}
			}
		}
		exit(1);
	}
}

static void kill_and_wait(int pid, int *status)
{
	kill(-pid, SIGKILL);
	kill(pid, SIGKILL);
	for (int i =3D 0; i < 100; i++) {
		if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
			return;
		usleep(1000);
	}
	DIR *dir =3D opendir("/sys/fs/fuse/connections");
	if (dir) {
		for (;;) {
			struct dirent *ent =3D readdir(dir);
			if (!ent)
				break;
			if (strcmp(ent->d_name, ".") =3D=3D 0 ||
			    strcmp(ent->d_name, "..") =3D=3D 0)
				continue;
			char abort[300];
			snprintf(abort, sizeof(abort),
				 "/sys/fs/fuse/connections/%s/abort",
				 ent->d_name);
			int fd =3D open(abort, O_WRONLY);
			if (fd =3D=3D -1) {
				continue;
			}
			if (write(fd, abort, 1) < 0) {
			}
			close(fd);
		}
		closedir(dir);
	} else {
	}
	while (waitpid(-1, status, __WALL) !=3D pid) {
	}
}

static void setup_loop()
{
	setup_cgroups_loop();
}

static void setup_test()
{
	prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
	setpgrp();
	setup_cgroups_test();
	write_file("/proc/self/oom_score_adj", "1000");
	if (symlink("/dev/binderfs", "./binderfs")) {
	}
}

static void close_fds()
{
	for (int fd =3D 3; fd < MAX_FDS; fd++)
		close(fd);
}

#define KMEMLEAK_FILE "/sys/kernel/debug/kmemleak"

static void setup_leak()
{
	if (!write_file(KMEMLEAK_FILE, "scan"))
		exit(1);
	sleep(5);
	if (!write_file(KMEMLEAK_FILE, "scan"))
		exit(1);
}

static void check_leaks(void)
{
	int fd =3D open(KMEMLEAK_FILE, O_RDWR);
	if (fd =3D=3D -1)
		exit(1);
	uint64_t start =3D current_time_ms();
	if (write(fd, "scan", 4) !=3D 4)
		exit(1);
	sleep(1);
	while (current_time_ms() - start < 4 * 1000)
		sleep(1);
	if (write(fd, "scan", 4) !=3D 4)
		exit(1);
	static char buf[128 << 10];
	ssize_t n =3D read(fd, buf, sizeof(buf) - 1);
	if (n < 0)
		exit(1);
	int nleaks =3D 0;
	if (n !=3D 0) {
		sleep(1);
		if (write(fd, "scan", 4) !=3D 4)
			exit(1);
		if (lseek(fd, 0, SEEK_SET) < 0)
			exit(1);
		n =3D read(fd, buf, sizeof(buf) - 1);
		if (n < 0)
			exit(1);
		buf[n] =3D 0;
		char *pos =3D buf;
		char *end =3D buf + n;
		while (pos < end) {
			char *next =3D strstr(pos + 1, "unreferenced object");
			if (!next)
				next =3D end;
			char prev =3D *next;
			*next =3D 0;
			fprintf(stderr, "BUG: memory leak\n%s\n", pos);
			*next =3D prev;
			pos =3D next;
			nleaks++;
		}
	}
	close(fd);
	if (nleaks)
		exit(1);
}

static void setup_binfmt_misc()
{
	if (mount(0, "/proc/sys/fs/binfmt_misc", "binfmt_misc", 0, 0)) {
	}
	write_file("/proc/sys/fs/binfmt_misc/register",
		   ":syz0:M:0:\x01::./file0:");
	write_file("/proc/sys/fs/binfmt_misc/register",
		   ":syz1:M:1:\x02::./file0:POC");
}

static void setup_sysctl()
{
	char mypid[32];
	snprintf(mypid, sizeof(mypid), "%d", getpid());
	struct {
		const char *name;
		const char *data;
	} files[] =3D {
		{ "/sys/kernel/debug/x86/nmi_longest_ns", "10000000000" },
		{ "/proc/sys/kernel/hung_task_check_interval_secs", "20" },
		//{ "/proc/sys/net/core/bpf_jit_kallsyms", "1" },
		//{ "/proc/sys/net/core/bpf_jit_harden", "0" },
		{ "/proc/sys/kernel/kptr_restrict", "0" },
		{ "/proc/sys/kernel/softlockup_all_cpu_backtrace", "1" },
		{ "/proc/sys/fs/mount-max", "100" },
		{ "/proc/sys/vm/oom_dump_tasks", "0" },
		{ "/proc/sys/debug/exception-trace", "0" },
		{ "/proc/sys/kernel/printk", "7 4 1 3" },
		{ "/proc/sys/net/ipv4/ping_group_range", "0 65535" },
		{ "/proc/sys/kernel/keys/gc_delay", "1" },
		{ "/proc/sys/vm/oom_kill_allocating_task", "1" },
		{ "/proc/sys/kernel/ctrl-alt-del", "0" },
		{ "/proc/sys/kernel/cad_pid", mypid },
	};
	for (size_t i =3D 0; i < sizeof(files) / sizeof(files[0]); i++) {
		if (!write_file(files[i].name, files[i].data))
			printf("write to %s failed: %s\n", files[i].name,
			       strerror(errno));
	}
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
	setup_loop();
	int iter =3D 0;
	for (;; iter++) {
		char cwdbuf[32];
		sprintf(cwdbuf, "./%d", iter);
		if (mkdir(cwdbuf, 0777))
			exit(1);
		int pid =3D fork();
		if (pid < 0)
			exit(1);
		if (pid =3D=3D 0) {
			if (chdir(cwdbuf))
				exit(1);
			setup_test();
			execute_one();
			close_fds();
			exit(0);
		}
		int status =3D 0;
		uint64_t start =3D current_time_ms();
		for (;;) {
			if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
				break;
			sleep_ms(1);
			if (current_time_ms() - start < 5000)
				continue;
			kill_and_wait(pid, &status);
			break;
		}
		remove_dir(cwdbuf);
		check_leaks();
	}
}

uint64_t r[2] =3D { 0xffffffffffffffff, 0xffffffffffffffff };

void execute_one(void)
{
	intptr_t res =3D 0;
	res =3D syscall(__NR_socket, 0x10ul, 3ul, 0);
	fprintf(stderr, "### %s:%u errno=3D%u\n", __func__, __LINE__, res =3D=3D -=
1 ? errno : 0);
	if (res !=3D -1)
		r[0] =3D res;
	syscall(__NR_getpgrp, -1);
	res =3D syscall(__NR_socket, 0xaul, 1ul, 0);
	fprintf(stderr, "### %s:%u errno=3D%u\n", __func__, __LINE__, res =3D=3D -=
1 ? errno : 0);
	if (res !=3D -1)
		r[1] =3D res;
	NONFAILING(memcpy((void *)0x20000040, "veth1_to_bridge\000", 16));
	res =3D syscall(__NR_ioctl, r[1], 0x8933, 0x20000040ul);
	fprintf(stderr, "### %s:%u errno=3D%u\n", __func__, __LINE__, res =3D=3D -=
1 ? errno : 0);
	NONFAILING(memcpy((void *)0x20000040,
			  "bridge0\000\000\000\000\000\000\000\000\000", 16));
	res =3D syscall(__NR_ioctl, r[0], 0x89a2, 0x20000040ul);
	fprintf(stderr, "### %s:%u errno=3D%u\n", __func__, __LINE__, res =3D=3D -=
1 ? errno : 0);
	//syscall(__NR_migrate_pages, 0, 3ul, 0ul, 0ul);
}

int main(void)
{
	syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
	syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
	syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
	initialize_netdevices();
	setup_sysctl();
	setup_cgroups();
	setup_binfmt_misc();
	setup_leak();
	install_segv_handler();
	use_temporary_dir();
	do_sandbox_none();
	return 0;
}

Thanks, please let me know if you need any additional detailed information.

Regards,
Ilia Gavrilov.







