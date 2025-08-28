Return-Path: <netdev+bounces-218027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7AB3AD7C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92563B1DEA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BDE26D4D9;
	Thu, 28 Aug 2025 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2JChZjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F825DB0A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419905; cv=none; b=DeoTv64sQLaG7OiV30gWhc5LmmqSerhBcbeIrvdMANUwCWNq6TLshvN+j+qgLJhWBzw8lDFU6GM7Ilr+1GWpTpaxMFPsNTOW0aNLuec54bJycn3L5HDi1NEoA1KXg6jbqYo5cwj8iQUaSczwH0mT4p1o+Y2Jt0xO8i6jcVrqQ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419905; c=relaxed/simple;
	bh=LZnOcamJ2WcsD8OI6zm1yZUBlguglNNG4tzYALBOOpI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AVMPHx2cAD2kYeU7dOIl3C+4PdS6Y1B4F8JCR6ffu/GsZWYJLWRGMN+C+uR+kVguE7VP2noVRNKEMNeiplQzF/GZ6JHiTs8Gy4GGG+4DO+1JY0nNf6Mf3hDS1kw0PcGEiazyfamlUKUKPpuJcjHXjyL5MUFvrbdPsUntF1tI4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2JChZjJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-771e1451631so2924713b3a.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756419903; x=1757024703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YIvRUSKhWgOwHyQqtErZQkrfK0jLtpcsjbP46eNm73s=;
        b=L2JChZjJEyAoxccop6TO2298fBqGowXvaIQzYC4r31I1TtSuD97ZVd88qDI86SWj+u
         DExvnP33b7Y7YdzEZMU/ZfTsPIM4PFFLTbwx4tZGrJvhZZtMQaDxlRWjnA+D1cEt4ocW
         b/nL+PrzQ90+6DGk1OkTjvzemJmjqNzlwGefZTVvTA+XPiv9vstGdZ3xtXVRf7sYipYg
         7h0/bpkKSZjvxTHhF9OkV0ol3i+4DPpY/ibuThOTcp2MzoflaHFGA+nPuhJ/Ua1uStt1
         bGt9uu2cPK68FV7HK1fltcUNBMyKMZLeZZabXGM4D+Ktyslkvhh5nGm13ArtYpD1ywRd
         EopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756419903; x=1757024703;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YIvRUSKhWgOwHyQqtErZQkrfK0jLtpcsjbP46eNm73s=;
        b=nfFaVhk0GArMBnJtb8V64OeHbkrNFzpGPQmzICkfwN0xMGuMGh0oYoaCFSS3Kp0DfC
         flc/kJoKEfRAK8/4KEai9KD7kAIv4YX08n++KMq8toCtb2CYAS751qYxN+FaO/inlRIC
         mLDoEdaGoJxeennklAwGcyutgzTnTydVkz0QwWj0ctL68gW183x+S1vKoHz5CWbu3hsZ
         sYYjFBbH0zgWtATDOLmVunqtILblhL5NXrpQym8qfFwL9YYKsVP1/bdotDzOuar31Yo3
         dHN4W/usZHAuYv53waxd+eMvSStdsN0Q3YVNEf5QFrCsOKwxW9wdcTZ3Pvf1GHV1SPOU
         C+sw==
X-Forwarded-Encrypted: i=1; AJvYcCUivlueAIDPWEpIn06QQI3DASK9F52JksesxUouduWaE8OpLXLPFTUwMUcYzsObzX1DUncWz8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDeyK8oG92VKfxatbwZDweHiFA5qZ2G6ehSntkIUCltbdPEJmD
	kAN01OzEpFjghHA0FNeQHm1xVA8iaVC1KWBBa7unTJ/SdrNP2i6hr6a02wQO0zLTAyRXHoex8H+
	nibF8dJcL3S2l2w==
X-Google-Smtp-Source: AGHT+IERdFW4ssfDi/tmGsRakORmM33CXqHtQbyhrilzY8+uOQEHf0xKqzWDXV8crW69yo5fbhFVQlfoMWANJA==
X-Received: from pfwz4.prod.google.com ([2002:a05:6a00:1d84:b0:771:ea87:e37d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:240f:b0:770:48cf:83f5 with SMTP id d2e1a72fcca58-77048cf887emr28051823b3a.14.1756419902833;
 Thu, 28 Aug 2025 15:25:02 -0700 (PDT)
Date: Thu, 28 Aug 2025 22:25:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250828222501.288951-1-skhawaja@google.com>
Subject: [RFC PATCH net-next v2] Add `xsk_rr` an AF_XDP benchmark to measure latency
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Note: This is a benchmarking tool that is used for experiments in the
upcoming Napi threaded busypoll series. Not intended to be merged.

xsk_rr is a benchmarking tool to measure latency using AF_XDP between
two nodes. The benchmark can be run with different arguments to simulate
traffic:

- Payload Size
- Packet frequency (1/period)
- Application Processing (delay)
- Busy poll in separate core
- Payload verification
- Open Loop sampling

Server:
chrt -f 50 taskset -c 3-5 tools/testing/selftests/bpf/xsk_rr -o 0 \
	-B <bytes> -i eth0 -4 -D <IP-dest> -S <IP-src> -M <MAC-dest> \
	-m <MAC-src> -p <PORT> -h -v -t

Client:
chrt -f 50 taskset -c 3-5 tools/testing/selftests/bpf/xsk_rr -o 0 \
	-B <bytes> -i eth0 -4 -S <IP-src> -D <IP-dest> -m <MAC-src> \
	-M <MAC-dst> -p <PORT> -P <send-period-usecs> -d <recv-delay-usecs> \
	-T -l <sample capture length in seconds> -v -t

Sample Output:

min: 13069 max: 881340 avg: 13322 empty: 98
count: 6249 p5: 13500
count: 61508 p50: 14000
count: 114428 p95: 14700
count: 119153 p99: 14800
rate: 12499
outstanding packets: 3

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

---

v2:
 - Rebased
 - Using needs wakeup
 - Added PREFER_BUSY_POLL
---
 tools/testing/selftests/bpf/Makefile          |   9 +-
 .../selftests/bpf/progs/xsk_rr_progs.c        |  60 ++
 tools/testing/selftests/bpf/xsk_rr.c          | 901 ++++++++++++++++++
 3 files changed, 969 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/xsk_rr_progs.c
 create mode 100644 tools/testing/selftests/bpf/xsk_rr.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4863106034df..1d10cb3ddb3d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -135,7 +135,8 @@ TEST_GEN_PROGS_EXTENDED = \
 	xdp_hw_metadata \
 	xdp_synproxy \
 	xdping \
-	xskxceiver
+	xskxceiver \
+	xsk_rr
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -516,6 +517,7 @@ test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib
 test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o
 test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
 xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
+xsk_rr_progs.skel.h-deps := xsk_rr_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
 
@@ -781,6 +783,11 @@ $(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/network_h
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
+$(OUTPUT)/xsk_rr: $(EXTRA_SRC) xsk_rr.c $(OUTPUT)/xsk.o $(OUTPUT)/xsk_rr_progs.skel.h $(BPFOBJ) | $(OUTPUT)
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
+
+
 $(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/progs/xsk_rr_progs.c b/tools/testing/selftests/bpf/progs/xsk_rr_progs.c
new file mode 100644
index 000000000000..79f5e562587a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xsk_rr_progs.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/in.h>
+#include <linux/udp.h>
+#include <stdbool.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_XSKMAP);
+	__uint(max_entries, 256);
+	__type(key, __u32);
+	__type(value, __u32);
+} xsk SEC(".maps");
+
+__u16 port;
+
+SEC("xdp")
+int rx(struct xdp_md *ctx)
+{
+	void *data, *data_end;
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	struct udphdr *uh;
+
+	data = (void *)(long)ctx->data;
+	data_end = (void *)(long)ctx->data_end;
+
+	eth = data;
+	data = eth + 1;
+	if (data > data_end)
+		return XDP_PASS;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		iph = data;
+		data = iph + 1;
+		if (data > data_end)
+			return XDP_PASS;
+		if (iph->protocol != IPPROTO_UDP)
+			return XDP_PASS;
+	} else {
+		return XDP_PASS;
+	}
+
+	uh = data;
+	data = uh + 1;
+	if (data > data_end)
+		return XDP_PASS;
+	if (uh->dest != port)
+		return XDP_PASS;
+
+	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xsk_rr.c b/tools/testing/selftests/bpf/xsk_rr.c
new file mode 100644
index 000000000000..228bfe07d327
--- /dev/null
+++ b/tools/testing/selftests/bpf/xsk_rr.c
@@ -0,0 +1,901 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <arpa/inet.h>
+#include <errno.h>
+#include <error.h>
+#include <linux/errqueue.h>
+#include <linux/ethtool.h>
+#include <linux/filter.h>
+#include <linux/if_ether.h>
+#include <linux/if_link.h>
+#include <linux/if_packet.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/net_tstamp.h>
+#include <linux/sockios.h>
+#include <linux/udp.h>
+#include <limits.h>
+#include <net/if.h>
+#include <poll.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "xsk.h"
+
+#include "xsk_rr_progs.skel.h"
+
+#define MIN(x, y) (((x) < (y)) ? (x) : (y))
+
+#define MAX_OUTSTANDING 1024
+#define OUTSTANDING_MASK(x) (x & (MAX_OUTSTANDING - 1))
+
+#define MAX_PAYLOAD_SIZE 1024
+
+static int cfg_addr_len;
+static void *cfg_daddr, *cfg_saddr;
+static struct in_addr cfg_daddr4, cfg_saddr4;
+static struct in6_addr cfg_daddr6, cfg_saddr6;
+static uint16_t cfg_eth_proto;
+static int cfg_family = PF_UNSPEC;
+
+static bool cfg_server_run;
+static char *cfg_ifname = "eth0";
+static int cfg_ifindex;
+static char *cfg_mac_dst, *cfg_mac_src;
+static uint16_t cfg_port;
+static int cfg_pkt_len;
+static char cfg_payload[MAX_PAYLOAD_SIZE];
+static __u32 cfg_payload_size = 200;
+static __u32 cfg_xdp_flags = XDP_FLAGS_DRV_MODE;//XDP_FLAGS_REPLACE;
+static __u16 cfg_xdp_bind_flags = XDP_COPY;
+static int cfg_outstanding_pkts = 1;
+static uint64_t cfg_server_delay;
+static uint64_t cfg_client_send_period;
+static bool cfg_client_send_threaded;
+static bool cfg_rx_polling;
+static bool cfg_skip_kick;
+static bool cfg_verify;
+static uint64_t cfg_log_f = 1UL;
+static pthread_t rx_polling_thread;
+
+/* constants that can be used in static array allocation
+ * const int is not sufficient: a const qualified variable
+ */
+enum {
+	pkt_len_l4 = sizeof(struct udphdr),
+	pkt_len_v4 = ETH_HLEN + sizeof(struct iphdr) + pkt_len_l4,
+	pkt_len_v6 = ETH_HLEN + sizeof(struct ipv6hdr) + pkt_len_l4,
+};
+
+static char pkt[2048];
+
+#define UMEM_NUM 8192
+#define UMEM_QLEN (UMEM_NUM / 2)
+#define UMEM_FRAME_SIZE XSK_UMEM__DEFAULT_FRAME_SIZE
+#define UMEM_SIZE (UMEM_FRAME_SIZE * UMEM_NUM)
+
+struct xsk {
+	void *umem_area;
+	struct xsk_umem *umem;
+	struct xsk_ring_prod fill;
+	struct xsk_ring_cons comp;
+	struct xsk_ring_prod tx;
+	struct xsk_ring_cons rx;
+	struct xsk_socket *socket;
+	__u32 tx_head;
+};
+
+static struct xsk_rr_progs *bpf_obj;
+static struct xsk *xsk_sock;
+
+uint64_t min_rtt = ULONG_MAX;
+uint64_t max_rtt;
+uint64_t avg_rtt;
+static int first_idx;
+static int next_idx;
+static uint64_t outstanding[MAX_OUTSTANDING] = {0};
+static uint64_t empty_rx_tries;
+static uint64_t rx_tries;
+
+static uint64_t prev_print;
+
+#define BUCKETS_NUM 20000
+#define BUCKET_SIZE_NM 100
+
+/*
+ * Last bucket for outliers
+ */
+#define BUCKET_MAX_VALUE ((BUCKETS_NUM - 1) *  BUCKET_SIZE_NM)
+
+static uint64_t buckets[BUCKETS_NUM] = {0};
+static uint64_t total_pkts_intvl;
+
+static uint64_t pending_sends;
+static uint64_t done_sends;
+
+static inline uint64_t get_current_time(void)
+{
+	uint64_t now;
+	struct timespec tm;
+
+	clock_gettime(CLOCK_MONOTONIC, &tm);
+	now = tm.tv_nsec + tm.tv_sec * 1000000000ul;
+	return now;
+}
+
+static void clean_buckets(void)
+{
+	memset(buckets, 0, sizeof(buckets));
+}
+
+static void print_percentile(int percentile)
+{
+	int i = 0;
+	uint64_t rtt = 0;
+	uint64_t count = 0;
+	uint64_t total_count = 0;
+
+	while (i < BUCKETS_NUM) {
+		total_count += buckets[i];
+		++i;
+	}
+
+	total_count = (total_count * percentile) / 100;
+
+	i = 0;
+	while (count < total_count) {
+		buckets[i] = MIN(buckets[i], total_count - count);
+		if (count != 0 || buckets[i] != 0)
+			rtt = (buckets[i] * (i) + count * rtt) / (count + buckets[i]);
+		count += buckets[i];
+		++i;
+	}
+
+	printf("count: %lu p%d: %lu\n", count, percentile, rtt * BUCKET_SIZE_NM);
+}
+
+static void show_rate(void)
+{
+	printf("rate: %lu\n", total_pkts_intvl / cfg_log_f);
+	total_pkts_intvl = 0;
+}
+
+static inline int record_send(void)
+{
+	outstanding[OUTSTANDING_MASK(next_idx)] = get_current_time();
+	++next_idx;
+
+	if (OUTSTANDING_MASK(next_idx) == OUTSTANDING_MASK(first_idx)) {
+		printf("\n%d %d\n", next_idx, first_idx);
+		error(1, 0, "outstanding array full");
+		return EAGAIN;
+	}
+
+	return 0;
+}
+
+static inline void record_recv(void)
+{
+	uint64_t now = get_current_time();
+	uint64_t rtt = now - outstanding[OUTSTANDING_MASK(first_idx)];
+
+	++first_idx;
+
+	if (min_rtt > rtt)
+		min_rtt = rtt;
+
+	if (max_rtt < rtt)
+		max_rtt = rtt;
+
+	avg_rtt = (avg_rtt * total_pkts_intvl + rtt) /
+				(total_pkts_intvl + 1);
+
+	if (rtt < BUCKET_MAX_VALUE)
+		buckets[(rtt / BUCKET_SIZE_NM)] += 1;
+	else
+		buckets[BUCKETS_NUM - 1] += 1;
+
+	++total_pkts_intvl;
+
+	if (now >= (prev_print + (cfg_log_f * 1000000000UL))) {
+		printf("\n");
+		printf("min: %lu max: %lu avg: %lu empty: %lu\n",
+		       min_rtt,
+			max_rtt, avg_rtt, (empty_rx_tries * 100) / rx_tries);
+
+		/*
+		 * Just to avoid divide by zero
+		 */
+		empty_rx_tries = 1;
+		rx_tries = 1;
+		print_percentile(5);
+		print_percentile(50);
+		print_percentile(95);
+		print_percentile(99);
+		show_rate();
+		printf("outstanding packets: %lu\n", (pending_sends - done_sends));
+		printf("\n");
+
+		clean_buckets();
+
+		prev_print = now;
+	}
+}
+
+static uint32_t checksum_nofold(void *data, size_t len, uint32_t sum)
+{
+	uint16_t *words = (uint16_t *)data;
+	int i;
+
+	for (i = 0; i < len / 2; i++)
+		sum += words[i];
+
+	if (len & 1)
+		sum += ((unsigned char *)data)[len - 1];
+
+	return sum;
+}
+
+static uint16_t checksum_fold(void *data, size_t len, uint32_t sum)
+{
+	sum = checksum_nofold(data, len, sum);
+
+	while (sum > 0xFFFF)
+		sum = (sum & 0xFFFF) + (sum >> 16);
+
+	return ~sum;
+}
+
+static void *init_pkt_ipv4(void *data)
+{
+	struct iphdr *iph = data;
+	struct udphdr *uh;
+
+	iph->version = 4;
+	iph->ihl = 5;
+	iph->protocol = IPPROTO_UDP;
+	iph->tot_len = htons(sizeof(*iph) + sizeof(*uh) + cfg_payload_size);
+	iph->ttl = 64;
+	iph->daddr = cfg_daddr4.s_addr;
+	iph->saddr = cfg_saddr4.s_addr;
+	iph->check = checksum_fold(iph, sizeof(*iph), 0);
+
+	return iph + 1;
+}
+
+static void *init_pkt_ipv6(void *data)
+{
+	struct ipv6hdr *ip6h = data;
+	struct udphdr *uh;
+
+	ip6h->version = 6;
+	ip6h->payload_len = htons(sizeof(*uh) + cfg_payload_size);
+	ip6h->nexthdr = IPPROTO_UDP;
+	ip6h->hop_limit = 64;
+	ip6h->daddr = cfg_daddr6;
+	ip6h->saddr = cfg_saddr6;
+
+	return ip6h + 1;
+}
+
+static void init_payload(void)
+{
+	memset(cfg_payload, 'a', cfg_payload_size);
+}
+
+static void init_pkt(void)
+{
+	struct ethhdr *eth;
+	struct udphdr *uh;
+	uint32_t sum;
+
+	init_payload();
+
+	/* init mac header */
+	eth = (void *)&pkt;
+	if (sscanf(cfg_mac_dst, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+		   &eth->h_dest[0], &eth->h_dest[1], &eth->h_dest[2],
+		   &eth->h_dest[3], &eth->h_dest[4], &eth->h_dest[5]) != 6)
+		error(1, 0, "sscanf mac dst ('-M')\n");
+	if (sscanf(cfg_mac_src, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+		   &eth->h_source[0], &eth->h_source[1], &eth->h_source[2],
+		   &eth->h_source[3], &eth->h_source[4], &eth->h_source[5]) != 6)
+		error(1, 0, "sscanf mac src ('-m')\n");
+	eth->h_proto = htons(cfg_eth_proto);
+
+	if (cfg_family == PF_INET)
+		uh = init_pkt_ipv4(eth + 1);
+	else
+		uh = init_pkt_ipv6(eth + 1);
+
+	/* init udp header */
+	uh->source = cfg_port;
+	uh->dest = cfg_port;
+	uh->len = htons(sizeof(*uh) + cfg_payload_size);
+	uh->check = 0;
+
+	/* init payload */
+	memcpy(uh + 1, cfg_payload, cfg_payload_size);
+
+	/* udp checksum */
+	sum = checksum_nofold(((char *)uh) - (cfg_addr_len * 2),
+			      (cfg_addr_len * 2) + sizeof(*uh) + cfg_payload_size, 0);
+	sum += htons(IPPROTO_UDP);
+	sum += uh->len;
+
+	uh->check = checksum_fold(NULL, 0, sum);
+}
+
+static void *verify_pkt_ipv4(void *data, void *data_end)
+{
+	struct iphdr *iph = data;
+
+	data = iph + 1;
+	if (data > data_end)
+		return NULL;
+
+	if (iph->protocol != IPPROTO_UDP)
+		return NULL;
+
+	return data;
+}
+
+static void *verify_pkt_ipv6(void *data, void *data_end)
+{
+	struct ipv6hdr *ip6h = data;
+
+	data = ip6h + 1;
+	if (data > data_end)
+		return NULL;
+
+	if (ip6h->nexthdr != IPPROTO_UDP)
+		return NULL;
+
+	return data;
+}
+
+static void verify_pkt(void *data, size_t len)
+{
+	void *data_end = data + len;
+	struct ethhdr *eth;
+	struct udphdr *uh;
+
+	eth = data;
+	data = eth + 1;
+	if (data > data_end)
+		goto bad;
+	if (eth->h_proto != htons(cfg_eth_proto))
+		goto bad;
+
+	if (cfg_family == PF_INET)
+		data = verify_pkt_ipv4(data, data_end);
+	else
+		data = verify_pkt_ipv6(data, data_end);
+	if (!data)
+		goto bad;
+
+	uh = data;
+	data = uh + 1;
+	if (data > data_end)
+		goto bad;
+	if (uh->dest != cfg_port)
+		goto bad;
+
+	if (data_end - data != cfg_payload_size)
+		goto bad;
+	if (memcmp(data, cfg_payload, cfg_payload_size))
+		goto bad;
+
+	return;
+bad:
+	error(1, 0, "bad packet content");
+}
+
+static int fill_xsk(struct xsk *xsk)
+{
+	__u64 addr;
+	__u32 idx;
+	int i;
+
+	/* returns either 0 on failure or second arg, UMEM_QLEN */
+	if (!xsk_ring_prod__reserve(&xsk->fill, UMEM_QLEN, &idx))
+		return -ENOMEM;
+
+	for (i = 0; i < UMEM_QLEN; i++) {
+		addr = (UMEM_QLEN + i) * UMEM_FRAME_SIZE;
+		*xsk_ring_prod__fill_addr(&xsk->fill, i) = addr;
+	}
+	xsk_ring_prod__submit(&xsk->fill, UMEM_QLEN);
+
+	return 0;
+}
+
+static int open_xsk(struct xsk *xsk)
+{
+	const int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
+	const struct xsk_socket_config socket_config = {
+		.rx_size = UMEM_QLEN,
+		.tx_size = UMEM_QLEN,
+		.bind_flags = cfg_xdp_bind_flags,
+	};
+	const struct xsk_umem_config umem_config = {
+		.fill_size = UMEM_QLEN,
+		.comp_size = UMEM_QLEN,
+		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
+	};
+	__u64 addr;
+	int ret;
+	int i;
+
+	xsk->umem_area = mmap(NULL, UMEM_SIZE, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
+	if (xsk->umem_area == MAP_FAILED)
+		return -ENOMEM;
+
+	ret = xsk_umem__create(&xsk->umem,
+			       xsk->umem_area, UMEM_SIZE,
+			       &xsk->fill,
+			       &xsk->comp,
+			       &umem_config);
+	if (ret)
+		return ret;
+
+	ret = xsk_socket__create(&xsk->socket, cfg_ifindex, 0,
+				 xsk->umem,
+				 &xsk->rx,
+				 &xsk->tx,
+				 &socket_config);
+	if (ret)
+		return ret;
+
+	/* First half of umem is for TX. This way address matches 1-to-1
+	 * to the completion queue index.
+	 */
+
+	for (i = 0; i < UMEM_QLEN; i++) {
+		addr = i * UMEM_FRAME_SIZE;
+		memcpy(xsk_umem__get_data(xsk->umem_area, addr),
+		       pkt, cfg_pkt_len);
+	}
+
+	if (fill_xsk(xsk))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void release_tx(struct xsk *xsk)
+{
+	__u32 idx = 0;
+	unsigned int n;
+
+	n = xsk_ring_cons__peek(&xsk->comp, XSK_RING_CONS__DEFAULT_NUM_DESCS, &idx);
+	if (n)
+		xsk_ring_cons__release(&xsk->comp, n);
+}
+
+static void send_xsk(void)
+{
+	struct xsk *xsk = xsk_sock;
+	struct xdp_desc *desc;
+	__u32 idx;
+
+	release_tx(xsk);
+
+	if (xsk_ring_prod__reserve(&xsk->tx, 1, &idx) != 1)
+		error(1, 0, "TX ring is full");
+
+	desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
+	desc->addr = (xsk->tx_head++ % UMEM_QLEN) * UMEM_FRAME_SIZE;
+	desc->len = cfg_pkt_len;
+
+	xsk_ring_prod__submit(&xsk->tx, 1);
+
+	sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
+}
+
+static void refill_rx(struct xsk *xsk, __u64 addr)
+{
+	__u32 idx;
+
+	if (xsk_ring_prod__reserve(&xsk->fill, 1, &idx) == 1) {
+		*xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
+		xsk_ring_prod__submit(&xsk->fill, 1);
+	}
+}
+
+static bool recv_xsk(bool block)
+{
+	const struct xdp_desc *desc;
+	__u64 comp_addr;
+	static int max_descs;
+	int pkt_cnt;
+	int xsk_fd;
+	__u64 addr;
+	__u32 idx;
+
+	xsk_fd = xsk_socket__fd(xsk_sock->socket);
+
+	while (1) {
+		struct xsk *xsk = xsk_sock;
+
+		++rx_tries;
+		pkt_cnt = xsk_ring_cons__peek(&xsk->rx, 1, &idx);
+		if (!pkt_cnt) {
+			if (!cfg_rx_polling && !cfg_skip_kick)
+				recvfrom(xsk_fd, NULL, 0, MSG_DONTWAIT, NULL, NULL);
+
+			++empty_rx_tries;
+
+			if (!block)
+				return false;
+
+			continue;
+		}
+
+		if (cfg_server_run && max_descs < pkt_cnt) {
+			max_descs = pkt_cnt;
+			printf("max_desc: %d\n", max_descs);
+		}
+
+		pkt_cnt = 1;
+		pkt_cnt = idx + pkt_cnt;
+		while (idx < pkt_cnt) {
+			desc = xsk_ring_cons__rx_desc(&xsk->rx, idx);
+			comp_addr = xsk_umem__extract_addr(desc->addr);
+			addr = xsk_umem__add_offset_to_addr(desc->addr);
+
+			if (cfg_verify)
+				verify_pkt(xsk_umem__get_data(xsk->umem_area, addr), desc->len);
+
+			xsk_ring_cons__release(&xsk->rx, 1);
+			refill_rx(xsk, comp_addr);
+			++idx;
+		}
+		return true;
+	}
+}
+
+static int do_send(void)
+{
+	if (!cfg_server_run) {
+		int ret = record_send();
+
+		if (ret) {
+			printf("returning\n");
+			return ret;
+		}
+	}
+
+	send_xsk();
+
+	return 0;
+}
+
+static void do_recv(bool block)
+{
+	bool read;
+	static uint64_t until;
+
+	if (cfg_server_delay)
+		if (get_current_time() < until)
+			return;
+
+	read = recv_xsk(block);
+	if (read && !cfg_server_run) {
+		record_recv();
+
+		until = cfg_server_delay + get_current_time();
+		++done_sends;
+	}
+}
+
+static void *rx_polling_run(void *arg)
+{
+	int xsk_fd;
+
+	xsk_fd = xsk_socket__fd(xsk_sock->socket);
+	printf("Doing rx polling in separate thread\n");
+
+	while (cfg_rx_polling) {
+		if (recvfrom(xsk_fd, NULL, 0, MSG_DONTWAIT, NULL, NULL) < 0)
+			error(1, errno, "kick_rx");
+	}
+
+	return NULL;
+}
+
+static void setup_rx_polling(void)
+{
+	printf("Do rx polling in separate thread\n");
+
+	pthread_create(&rx_polling_thread,
+		       NULL,
+		       rx_polling_run,
+		       NULL);
+}
+
+static void *do_client_period_send_run(void *arg)
+{
+	uint64_t now, prev = 0;
+
+	while (cfg_client_send_threaded) {
+		now = get_current_time();
+		if ((now - prev) >= cfg_client_send_period) {
+			if (do_send())
+				continue;
+
+			++pending_sends;
+			prev = now;
+		}
+	}
+
+	return NULL;
+}
+
+static void do_client_send_period(void)
+{
+	pthread_t send_thread;
+	uint64_t now, prev = 0;
+
+	if (cfg_client_send_threaded) {
+		printf("send in separate thread\n");
+		pthread_create(&send_thread,
+			       NULL,
+			       do_client_period_send_run,
+			       NULL);
+	}
+
+	while (true) {
+		if (!cfg_client_send_threaded) {
+			now = get_current_time();
+			if ((now - prev) >= cfg_client_send_period) {
+				do_send();
+				++pending_sends;
+				prev = now;
+			}
+		}
+
+		do_recv(false);
+	}
+
+	if (cfg_client_send_threaded) {
+		void *th_ret;
+
+		cfg_client_send_threaded = false;
+		pthread_join(send_thread, &th_ret);
+	}
+}
+
+static void do_client(void)
+{
+	int i;
+
+	if (cfg_client_send_period) {
+		do_client_send_period();
+		return;
+	}
+
+	i = 0;
+	while (i < cfg_outstanding_pkts) {
+		do_send();
+		++i;
+	}
+
+	while (true) {
+		do_send();
+		do_recv(true);
+	}
+}
+
+static void do_server(void)
+{
+	while (true) {
+		do_recv(true);
+		if (cfg_server_delay)
+			usleep(cfg_server_delay);
+
+		do_send();
+	}
+}
+
+static bool link_is_down(void)
+{
+	char path[PATH_MAX];
+	FILE *file;
+	char status;
+
+	snprintf(path, PATH_MAX, "/sys/class/net/%s/carrier", cfg_ifname);
+	file = fopen(path, "r");
+	if (!file)
+		error(1, errno, "%s", path);
+
+	if (fread(&status, 1, 1, file) != 1)
+		error(1, errno, "fread");
+
+	fclose(file);
+
+	return status == '0';
+}
+
+static void cleanup(void)
+{
+	cfg_rx_polling = false;
+	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
+
+	if (bpf_obj) {
+		opts.old_prog_fd = bpf_program__fd(bpf_obj->progs.rx);
+		if (opts.old_prog_fd >= 0)
+			bpf_xdp_detach(cfg_ifindex, cfg_xdp_flags, &opts);
+	}
+}
+
+static void setup_for_ipv4(void)
+{
+	cfg_family = PF_INET;
+	cfg_eth_proto = ETH_P_IP;
+	cfg_addr_len = sizeof(struct in_addr);
+	cfg_pkt_len = pkt_len_v4 + cfg_payload_size;
+	cfg_daddr = &cfg_daddr4;
+	cfg_saddr = &cfg_saddr4;
+}
+
+static void setup_for_ipv6(void)
+{
+	cfg_family = PF_INET6;
+	cfg_eth_proto = ETH_P_IPV6;
+	cfg_addr_len = sizeof(struct in6_addr);
+	cfg_pkt_len = pkt_len_v6 + cfg_payload_size;
+	cfg_daddr = &cfg_daddr6;
+	cfg_saddr = &cfg_saddr6;
+}
+
+static void parse_opts(int argc, char **argv)
+{
+	char *daddr = NULL, *saddr = NULL;
+	int c;
+
+	while ((c = getopt(argc, argv, "46B:D:d:hi:l:m:M:no:p:P:S:tTv")) != -1) {
+		switch (c) {
+		case '4':
+			setup_for_ipv4();
+			break;
+		case '6':
+			setup_for_ipv6();
+			break;
+		case 'B':
+			cfg_payload_size = atoi(optarg);
+			cfg_payload_size = MIN(cfg_payload_size,
+					       MAX_PAYLOAD_SIZE);
+			break;
+		case 'D':
+			daddr = optarg;
+			break;
+		case 'd':
+			cfg_server_delay = atol(optarg);
+			break;
+		case 'h':
+			cfg_server_run = true;
+			break;
+		case 'i':
+			cfg_ifname = optarg;
+			break;
+		case 'l':
+			cfg_log_f = atol(optarg);
+			break;
+		case 'm':
+			cfg_mac_src = optarg;
+			break;
+		case 'M':
+			cfg_mac_dst = optarg;
+			break;
+		case 'n':
+			cfg_skip_kick = true;
+			break;
+		case 'o':
+			cfg_outstanding_pkts = atoi(optarg);
+			break;
+		case 'p':
+			cfg_port = htons(atoi(optarg));
+			break;
+		case 'P':
+			cfg_client_send_period = atol(optarg);
+			break;
+		case 'S':
+			saddr = optarg;
+			break;
+		case 't':
+			cfg_rx_polling = true;
+			break;
+		case 'T':
+			cfg_client_send_threaded = true;
+			break;
+		case 'v':
+			cfg_verify = true;
+			break;
+		default:
+			error(1, 0, "%s: parse error", argv[0]);
+		}
+	}
+
+	if (cfg_family == PF_UNSPEC)
+		error(1, 0, "select one of -4 or -6");
+
+	if (!cfg_mac_src || !cfg_mac_dst || !saddr || !daddr)
+		error(1, 0, "all MAC and IP addresses must be set");
+
+	if (inet_pton(cfg_family, daddr, cfg_daddr) != 1)
+		error(1, 0, "dst addr parse error: dst ('-D')");
+	if (inet_pton(cfg_family, saddr, cfg_saddr) != 1)
+		error(1, 0, "src addr parse error: src ('-S')");
+
+	cfg_ifindex = if_nametoindex(cfg_ifname);
+	if (!cfg_ifindex)
+		error(1, 0, "ifname invalid");
+}
+
+static void handle_signal(int sig)
+{
+	exit(1);
+}
+
+int main(int argc, char *argv[])
+{
+	__u32 queue_id = 0;
+	int sock_fd;
+	int ret;
+
+	parse_opts(argc, argv);
+	init_pkt();
+
+	bpf_obj = xsk_rr_progs__open();
+	if (libbpf_get_error(bpf_obj))
+		error(1, libbpf_get_error(bpf_obj), "xsk_rr_progs__open");
+
+	ret = xsk_rr_progs__load(bpf_obj);
+	if (ret)
+		error(1, -ret, "xsk_rr_progs__load");
+
+	xsk_sock = calloc(1, sizeof(struct xsk));
+
+	bpf_obj->bss->port = cfg_port;
+
+	ret = open_xsk(xsk_sock);
+	if (ret)
+		error(1, -ret, "open_xsk");
+
+	sock_fd = xsk_socket__fd(xsk_sock->socket);
+
+	ret = bpf_map__update_elem(bpf_obj->maps.xsk, &queue_id,
+				   sizeof(queue_id), &sock_fd,
+				   sizeof(sock_fd), 0);
+	if (ret)
+		error(1, -ret, "bpf_map__update_elem");
+
+	ret = bpf_xdp_attach(cfg_ifindex,
+			     bpf_program__fd(bpf_obj->progs.rx),
+			     cfg_xdp_flags, NULL);
+	if (ret)
+		error(1, -ret, "bpf_xdp_attach");
+
+	atexit(cleanup);
+	signal(SIGINT, handle_signal);
+	signal(SIGTERM, handle_signal);
+
+	/* XDP may need a delay for device reinitialization */
+	do {
+		usleep(100 * 1000);
+	} while (link_is_down());
+
+	if (cfg_rx_polling)
+		setup_rx_polling();
+
+	if (cfg_server_run)
+		do_server();
+	else
+		do_client();
+}

base-commit: c3199adbe4ffffc7b6536715e0290d1919a45cd9
-- 
2.51.0.338.gd7d06c2dae-goog


