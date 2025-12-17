Return-Path: <netdev+bounces-245064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B40ACC6858
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E086630B0936
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD133C1A3;
	Wed, 17 Dec 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ifLg6BQt"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F8933A6F1;
	Wed, 17 Dec 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958830; cv=none; b=arh8Gsg+Phrmkkuys7Eln3DbWB1o8U+b38UM8Xk2SBDMd9wNY2piBD4igm/u4rcQSe6kWWqv0JpA8eX9ZJPteE3picL4Dff1vjMfdY+ZgDzEvw21OlX7nKcalrpVSHw+dBHfaSi0LQrRN/gYBx42ec7knNK3VmPV5Ec6fF6jLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958830; c=relaxed/simple;
	bh=BuxpFwc23BuG07NFuGO7TIrc3xZphhbkYJq+RBOKwDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlX+Ydm9yrWcOqeH8i+/YIZqtdTkNtzCqeYIU1n9OYahry1AhcVSYI2CUCpbAyWZuZ+KE27oLKJLl/qJLithZadrBD9Jo8CEb0mDUu9SnE1Ah0IMUCXKfEfoMqJ6LxpJ/iH9k169qxeLo5GN4XPi2qcwIxrQ7izq3dG9HTCpHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ifLg6BQt; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=a/8nlU3CGVl1Hh/xQ5mwaJ+sb0xrwBFylCaB8PCyC9M=;
	b=ifLg6BQtgK70WLY2GXPvDNfAx9rvQdGbbiq2IYq0YF3AO6Z5di6Q9iUPVoi+GY
	EzkshHuCr0o9G5H9nv2kH+q+VkdEqXQuX7hTZ9W+hSib/ZP/TI0Dwqjq6MA9m86e
	J/zrxE9F3WV48+N2881jSmwD8lgFtX9NORH8QBh2pea6E=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXPv1zZEJpCHbGAw--.5008S3;
	Wed, 17 Dec 2025 16:06:13 +0800 (CST)
From: 15927021679@163.com
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH 01/14] examples/vhost_user_rdma: implement core application initialization for supporting vhost_user_rdma device
Date: Wed, 17 Dec 2025 16:05:11 +0800
Message-ID: <20251217080605.38473-2-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217080605.38473-1-15927021679@163.com>
References: <20251217080605.38473-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXPv1zZEJpCHbGAw--.5008S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsveHDUUUU
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8xUhqWlCZHXvvAAA3H

From: xiongweimin <xiongweimin@kylinos.cn>

This commit introduces the main initialization routine for vHost RDMA
application built on DPDK. The implementation includes:

1. DPDK EAL environment initialization with proper signal handling
2. Argument parsing for application-specific configuration
3. Creation of shared memory resources:
   - Packet buffer pools with per-core caching
   - Optimized ring buffers for RX/TX with SP/MC synchronization flags
4. Backend network device detection and initialization
5. Worker thread launch across available cores
6. Multi-device support with shared/dedicated resource allocation
7. vHost device construction and driver registration

Key features:
- NUMA-aware resource allocation using rte_socket_id()
- Optimized ring flags (SP_ENQ, MC_HTS_DEQ) for lockless operation
- Graceful shutdown handling through signal interception
- Resource isolation for multi-device configurations

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Change-Id: I1a42aeaa04595d13fc392452c1c9ca3f97442acc
---
 examples/meson.build                      |   1 +
 examples/vhost_user_rdma/main.c           | 607 ++++++++++++++++++
 examples/vhost_user_rdma/meson.build      |  45 ++
 examples/vhost_user_rdma/vhost_rdma.c     | 697 +++++++++++++++++++++
 examples/vhost_user_rdma/vhost_rdma.h     | 444 ++++++++++++++
 examples/vhost_user_rdma/vhost_rdma_ib.c  | 647 ++++++++++++++++++++
 examples/vhost_user_rdma/vhost_rdma_ib.h  | 710 ++++++++++++++++++++++
 examples/vhost_user_rdma/vhost_rdma_log.h |  52 ++
 examples/vhost_user_rdma/vhost_rdma_pkt.h | 296 +++++++++
 9 files changed, 3499 insertions(+)
 create mode 100644 examples/vhost_user_rdma/main.c
 create mode 100644 examples/vhost_user_rdma/meson.build
 create mode 100644 examples/vhost_user_rdma/vhost_rdma.c
 create mode 100644 examples/vhost_user_rdma/vhost_rdma.h
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_ib.c
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_ib.h
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_log.h
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_pkt.h

diff --git a/examples/meson.build b/examples/meson.build
index 8e8968a1fa..780d49d4b4 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -54,6 +54,7 @@ all_examples = [
         'vdpa',
         'vhost',
         'vhost_blk',
+        'vhost_user_rdma',
         'vhost_crypto',
         'vm_power_manager',
         'vm_power_manager/guest_cli',
diff --git a/examples/vhost_user_rdma/main.c b/examples/vhost_user_rdma/main.c
new file mode 100644
index 0000000000..d5dda47e4e
--- /dev/null
+++ b/examples/vhost_user_rdma/main.c
@@ -0,0 +1,607 @@
+/*
+ * Vhost-user RDMA Device - Initialization and Packet Forwarding
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C) 2025 KylinSoft Inc. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ */
+
+#include <signal.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <sys/types.h>
+#include <sys/queue.h>
+#include <stdarg.h>
+#include <ctype.h>
+#include <errno.h>
+
+/* DPDK headers */
+#include <rte_memory.h>
+#include <rte_launch.h>
+#include <rte_eal.h>
+#include <rte_per_lcore.h>
+#include <rte_lcore.h>
+#include <rte_debug.h>
+#include <rte_log.h>
+#include <rte_ethdev.h>
+#include <rte_mbuf.h>
+#include <rte_ring.h>
+#include <rte_malloc.h>
+#include <dev_driver.h>
+
+/* Local headers */
+#include "vhost_rdma_ib.h"
+#include "vhost_rdma.h"
+#include "vhost_rdma_pkt.h"
+#include "vhost_rdma_log.h"
+
+/**
+ * Maximum length for Unix socket path
+ */
+#define SOCKET_PATH_MAX		 64
+
+/**
+ * Default number of RX/TX descriptors
+ */
+#define MAX_NB_RXD			  1024
+#define MAX_NB_TXD			  1024
+
+/**
+ * Size of shared rings between vhost devices and datapath
+ */
+#define MAX_RING_COUNT		  1024
+
+/**
+ * Default number of mbufs in memory pool
+ */
+#define NUM_MBUFS_DEFAULT	   (1UL << 16)  // 65536
+
+/**
+ * Cache size for per-lcore mbuf cache
+ */
+#define MBUF_CACHE_SIZE		 256
+
+/**
+ * Data buffer size in each mbuf
+ */
+#define MBUF_DATA_SIZE		  RTE_MBUF_DEFAULT_BUF_SIZE
+
+/* Forward declarations */
+extern struct vhost_rdma_device g_vhost_rdma_dev[];
+
+/* Global configuration */
+static char *socket_path;				/* Array of socket paths */
+static int nb_sockets = 0;					  /* Number of vhost sockets */
+static uint16_t pair_port_id = UINT16_MAX;	  /* Physical port ID to forward packets */
+static volatile bool force_quit;		/* Signal to exit cleanly */
+
+/* Stats and feature flags */
+static uint32_t enable_stats;			   /* Enable periodic stats printing (seconds) */
+static uint32_t enable_tx_csum;			 /* Enable TX checksum offload */
+static int total_num_mbufs = NUM_MBUFS_DEFAULT;/* Total mbufs across pools */
+
+/* Shared resources */
+static struct rte_ring *vhost_rdma_rx_ring;
+static struct rte_ring *vhost_rdma_tx_ring;
+static struct rte_mempool *vhost_rdma_mbuf_pool;
+
+/* Per-lcore info for device management */
+struct lcore_info {
+	uint32_t device_num;
+	TAILQ_HEAD(vhost_dev_tailq_list, vhost_rdma_device) vdev_list;
+};
+
+static struct lcore_info lcore_info[RTE_MAX_LCORE];
+static unsigned int lcore_ids[RTE_MAX_LCORE];
+
+/* Port configuration templates */
+static struct rte_eth_conf default_port_config;
+
+static struct rte_eth_conf offload_port_config = {
+	.txmode = {
+				.offloads = RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+							RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+							RTE_ETH_TX_OFFLOAD_TCP_CKSUM,
+	},
+};
+
+enum {
+#define OPT_STATS			   "stats"
+	OPT_STATS_NUM,
+#define OPT_SOCKET_FILE		 "socket-file"
+	OPT_SOCKET_FILE_NUM,
+#define OPT_TX_CSUM			 "tx-csum"
+	OPT_TX_CSUM_NUM,
+#define OPT_NUM_MBUFS		   "total-num-mbufs"
+	OPT_NUM_MBUFS_NUM,
+};
+
+/**
+ * @brief Unregister all registered vhost drivers.
+ *
+ * Called during signal cleanup to ensure no stale sockets remain.
+ *
+ * @param socket_num Number of socket paths to unregister
+ */
+static void
+unregister_drivers(int socket_num)
+{
+	int i, ret;
+
+	for (i = 0; i < socket_num; i++) {
+		const char *path = socket_path + i * SOCKET_PATH_MAX;
+		ret = rte_vhost_driver_unregister(path);
+		if (ret != 0) {
+			RDMA_LOG_ERR("Failed to unregister vhost driver for socket %s\n", path);
+		} else {
+				RDMA_LOG_INFO("Unregistered socket: %s\n", path);
+		}
+	}
+}
+
+/**
+ * @brief Signal handler for graceful shutdown (SIGINT).
+ *
+ * Cleans up vhost driver registrations and exits.
+ */
+static void
+vhost_rdma_signal_handler(__rte_unused int signum)
+{
+	RDMA_LOG_INFO("Received SIGINT, shutting down...\n");
+
+	if((signum == SIGINT) || (signum == SIGTERM))
+		force_quit = true;
+
+	unregister_drivers(nb_sockets);
+	exit(0);
+}
+
+/**
+ * @brief Initialize an Ethernet port with given offload settings.
+ *
+ * Configures one RX/TX queue, sets up descriptor rings, starts the port.
+ *
+ * @param port_id The port identifier
+ * @param offload Whether to enable hardware offloads
+ * @return 0 on success, negative on failure
+ */
+static int
+vhost_rdma_init_port(uint16_t port_id, bool offload)
+{
+	int ret;
+	uint16_t nb_rxd = MAX_NB_RXD;
+	uint16_t nb_txd = MAX_NB_TXD;
+	struct rte_eth_dev_info dev_info;
+	struct rte_eth_conf port_conf = offload ? offload_port_config : default_port_config;
+	struct rte_eth_txconf txconf;
+	struct rte_ether_addr addr;
+	char mac_str[RTE_ETHER_ADDR_FMT_SIZE];
+
+	RDMA_LOG_INFO("Initializing port %u with %s offloads\n", port_id,
+				offload ? "enabled" : "disabled");
+
+	ret = rte_eth_dev_info_get(port_id, &dev_info);
+	if (ret < 0) {
+		RDMA_LOG_ERR("Failed to get device info for port %u\n", port_id);
+		goto out;
+	}
+
+	ret = rte_eth_dev_configure(port_id, 1, 1, &port_conf);
+	if (ret < 0) {
+		RDMA_LOG_ERR("Failed to configure port %u\n", port_id);
+		goto out;
+	}
+
+	ret = rte_eth_dev_adjust_nb_rx_tx_desc(port_id, &nb_rxd, &nb_txd);
+	if (ret < 0) {
+		LOG_WARN("Failed to adjust number of descriptors for port %u\n", port_id);
+	}
+
+	ret = rte_eth_rx_queue_setup(port_id, 0, nb_rxd,
+						rte_eth_dev_socket_id(port_id),
+						NULL,
+						vhost_rdma_mbuf_pool);
+	if (ret < 0) {
+		RDMA_LOG_ERR("Failed to setup RX queue for port %u\n", port_id);
+		goto out;
+	}
+
+	txconf = dev_info.default_txconf;
+	txconf.offloads = port_conf.txmode.offloads;
+	ret = rte_eth_tx_queue_setup(port_id, 0, nb_txd,
+							rte_eth_dev_socket_id(port_id),
+							&txconf);
+	if (ret < 0) {
+		RDMA_LOG_ERR("Failed to setup TX queue for port %u\n", port_id);
+		goto out;
+	}
+
+	ret = rte_eth_dev_start(port_id);
+	if (ret < 0) {
+		RDMA_LOG_ERR("Failed to start port %u\n", port_id);
+		goto out;
+	}
+
+	ret = rte_eth_promiscuous_enable(port_id);
+	if (ret < 0) {
+		LOG_WARN("Failed to enable promiscuous mode on port %u\n", port_id);
+	}
+
+	ret = rte_eth_macaddr_get(port_id, &addr);
+	if (ret == 0) {
+		rte_ether_format_addr(mac_str, sizeof(mac_str), &addr);
+		RDMA_LOG_INFO("Port %u MAC address: %s\n", port_id, mac_str);
+	} else {
+		LOG_WARN("Could not read MAC address for port %u\n", port_id);
+	}
+
+out:
+	return ret;
+}
+
+/**
+ * @brief Print usage information.
+ */
+static void
+vhost_rdma_usage(const char *prgname)
+{
+	printf("%s [EAL options] --\n"
+		"	-p PORTMASK\n"
+		"	--socket-file <path>		: Path to vhost-user socket (can be repeated)\n"
+		"	--stats <N>					: Print stats every N seconds (0=disable)\n"
+		"	--tx-csum <0|1>				: Disable/enable TX checksum offload\n"
+		"	--total-num-mbufs <N>		: Total number of mbufs in pool (default: %ld)\n",
+		prgname, NUM_MBUFS_DEFAULT);
+}
+
+/**
+ * @brief Parse a numeric option safely.
+ *
+ * @param q_arg Input string
+ * @param max_valid_value Maximum allowed value
+ * @return Parsed integer or -1 on error
+ */
+static int
+vhost_rdma_parse_num_opt(const char *q_arg, uint32_t max_valid_value)
+{
+	char *end = NULL;
+	unsigned long num;
+
+	errno = 0;
+	num = strtoul(q_arg, &end, 10);
+
+	if (!q_arg || q_arg[0] == '\0' || end == NULL || *end != '\0')
+		return -1;
+	if (errno != 0 || num > max_valid_value)
+		return -1;
+
+	return (int)num;
+}
+
+/**
+ * @brief Parse and store vhost socket path.
+ *
+ * Supports multiple sockets via repeated --socket-file.
+ *
+ * @param q_arg Socket file path
+ * @return 0 on success, -1 on failure
+ */
+static int
+vhost_rdma_parse_socket_path(const char *q_arg)
+{
+	char *old_ptr;
+
+	if (strnlen(q_arg, SOCKET_PATH_MAX) >= SOCKET_PATH_MAX) {
+		RTE_LOG(ERR, VHOST_CONFIG, "Socket path too long: %s\n", q_arg);
+		return -1;
+	}
+
+	old_ptr = socket_path;
+	socket_path = realloc(socket_path, SOCKET_PATH_MAX * (nb_sockets + 1));
+	if (socket_path == NULL) {
+		free(old_ptr);
+		return -1;
+	}
+
+	strncpy(socket_path + nb_sockets * SOCKET_PATH_MAX, q_arg, SOCKET_PATH_MAX - 1);
+	socket_path[(nb_sockets + 1) * SOCKET_PATH_MAX - 1] = '\0';
+
+	RDMA_LOG_INFO("Registered socket[%d]: %s\n",
+				nb_sockets, socket_path + nb_sockets * SOCKET_PATH_MAX);
+
+	nb_sockets++;
+	return 0;
+}
+
+/**
+ * @brief Parse command-line arguments.
+ *
+ * Supported options:
+ *   --socket-file, --stats, --tx-csum, --total-num-mbufs
+ *
+ * @param argc Argument count
+ * @param argv Argument vector
+ * @return 0 on success, -1 on failure
+ */
+static int
+vhost_rdma_parse_args(int argc, char **argv)
+{
+	int opt, ret;
+	int option_idx;
+	const char *prgname = argv[0];
+
+	static struct option lgopts[] = {
+		{ "stats",			required_argument, NULL, OPT_STATS_NUM },
+		{ "socket-file",	required_argument, NULL, OPT_SOCKET_FILE_NUM },
+		{ "tx-csum",		required_argument, NULL, OPT_TX_CSUM_NUM },
+		{ "total-num-mbufs",required_argument, NULL, OPT_NUM_MBUFS_NUM },
+		{ NULL, 0, NULL, 0 }
+	};
+
+	while ((opt = getopt_long(argc, argv, "",
+							  lgopts, &option_idx)) != EOF) {
+		switch (opt) {
+		case OPT_STATS_NUM:
+			ret = vhost_rdma_parse_num_opt(optarg, INT32_MAX);
+			if (ret < 0) {
+				RTE_LOG(ERR, VHOST_CONFIG, "Invalid value for --stats\n");
+				vhost_rdma_usage(prgname);
+				return -1;
+			}
+			enable_stats = ret;
+			break;
+
+		case OPT_NUM_MBUFS_NUM:
+			ret = vhost_rdma_parse_num_opt(optarg, INT32_MAX);
+			if (ret < 0 || ret == 0) {
+				RTE_LOG(ERR, VHOST_CONFIG, "Invalid value for --total-num-mbufs\n");
+				vhost_rdma_usage(prgname);
+				return -1;
+			}
+			total_num_mbufs = ret;
+			break;
+
+		case OPT_SOCKET_FILE_NUM:
+			if (vhost_rdma_parse_socket_path(optarg) < 0) {
+				RTE_LOG(ERR, VHOST_CONFIG, "Invalid socket path: %s\n", optarg);
+				vhost_rdma_usage(prgname);
+				return -1;
+			}
+			break;
+
+		case OPT_TX_CSUM_NUM:
+			ret = vhost_rdma_parse_num_opt(optarg, 1);
+			if (ret < 0) {
+				RTE_LOG(ERR, VHOST_CONFIG, "Invalid value for --tx-csum (must be 0 or 1)\n");
+				vhost_rdma_usage(prgname);
+				return -1;
+			}
+			enable_tx_csum = ret;
+			break;
+
+		default:
+			vhost_rdma_usage(prgname);
+			return -1;
+		}
+	}
+
+	if (nb_sockets == 0) {
+		RTE_LOG(ERR, VHOST_CONFIG, "At least one --socket-file must be specified.\n");
+		vhost_rdma_usage(prgname);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+vhost_rdma_main_loop(__rte_unused void* arg) 
+{
+	while (!force_quit) {
+
+	}
+	return 0;
+}
+
+/**
+ * @brief Application entry point.
+ *
+ * Initializes EAL, parses args, sets up ports, mempools, rings,
+ * registers vhost drivers, launches threads.
+ */
+int main(int argc, char **argv)
+{
+	unsigned lcore_id, core_id = 0;
+	int ret;
+	uint16_t port_id;
+	bool pair_found = false;
+	struct rte_eth_dev_info dev_info;
+
+	force_quit = false;
+	enable_stats = 0;
+	enable_tx_csum = 0;
+
+	/* Register signal handler for clean shutdown */
+	signal(SIGINT, vhost_rdma_signal_handler);
+	signal(SIGTERM, vhost_rdma_signal_handler);
+
+	/* Initialize DPDK Environment Abstraction Layer */
+	ret = rte_eal_init(argc, argv);
+	if (ret < 0)
+		rte_panic("Unable to initialize DPDK EAL\n");
+
+	argc -= ret;
+	argv += ret;
+
+	rte_log_set_global_level(RTE_LOG_NOTICE);
+
+	/* Parse application-specific arguments */
+	if (vhost_rdma_parse_args(argc, argv) != 0) {
+		rte_exit(EXIT_FAILURE, "Argument parsing failed\n");
+	}
+
+	/* Initialize per-lcore data structures */
+	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
+		TAILQ_INIT(&lcore_info[lcore_id].vdev_list);
+		if (rte_lcore_is_enabled(lcore_id)) {
+			lcore_ids[core_id++] = lcore_id;
+		}
+	}
+
+	if (rte_lcore_count() < 2) {
+		rte_exit(EXIT_FAILURE, "At least two cores required (one main + one worker)\n");
+	}
+
+	/*
+	 * Create shared memory pool for mbufs
+	 * Used by both RX and TX paths
+	 */
+	vhost_rdma_mbuf_pool = rte_pktmbuf_pool_create(
+							"mbuf_pool_shared",
+							total_num_mbufs,
+							MBUF_CACHE_SIZE,
+							sizeof(struct vhost_rdma_pkt_info),
+							MBUF_DATA_SIZE,
+							rte_socket_id());
+
+	if (vhost_rdma_mbuf_pool == NULL) {
+		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool: %s\n", rte_strerror(rte_errno));
+	}
+
+	/*
+	 * Create shared rings for packet exchange
+	 * SP_ENQ: Single-producer enqueue (from NIC)
+	 * MC_HTS_DEQ: Multi-consumer with HTS dequeue (to workers)
+	 */
+	vhost_rdma_rx_ring = rte_ring_create(
+		"ring_rx_shared",
+		MAX_RING_COUNT,
+		rte_socket_id(),
+		RING_F_SP_ENQ | RING_F_MC_HTS_DEQ
+	);
+	if (vhost_rdma_rx_ring == NULL)
+		rte_exit(EXIT_FAILURE, "Failed to create RX ring: %s\n", rte_strerror(rte_errno));
+
+	vhost_rdma_tx_ring = rte_ring_create(
+		"ring_tx_shared",
+		MAX_RING_COUNT,
+		rte_socket_id(),
+		RING_F_MP_HTS_ENQ | RING_F_SC_DEQ
+	);
+	if (vhost_rdma_tx_ring == NULL)
+		rte_exit(EXIT_FAILURE, "Failed to create TX ring: %s\n", rte_strerror(rte_errno));
+
+	/*
+	 * Find and initialize backend Ethernet device (e.g., net_tap or net_vhost)
+	 */
+	RTE_ETH_FOREACH_DEV(port_id) {
+		ret = rte_eth_dev_info_get(port_id, &dev_info);
+		if (ret != 0) {
+			RDMA_LOG_ERR("Failed to get info for port %u\n", port_id);
+			continue;
+		}
+
+		if (!pair_found &&
+			(strcmp(dev_info.driver_name, "net_tap") == 0 ||
+			 strcmp(dev_info.driver_name, "net_vhost") == 0)) {
+
+			pair_port_id = port_id;
+			pair_found = true;
+
+			ret = vhost_rdma_init_port(port_id, !!enable_tx_csum);
+			if (ret != 0) {
+				rte_exit(EXIT_FAILURE, "Failed to initialize port %u: %s\n",
+						port_id, rte_strerror(-ret));
+			}
+
+			RDMA_LOG_INFO("Using device %s (port %u) as backend interface\n",
+						dev_info.device->name, port_id);
+		}
+	}
+
+	if (!pair_found) {
+		rte_exit(EXIT_FAILURE, "No suitable backend Ethernet device found\n");
+	}
+
+	/*
+	 * Setup per-vhost-device resources and register vhost drivers
+	 */
+	char name_buf[SOCKET_PATH_MAX];
+	for (int i = 0; i < nb_sockets; i++) {
+		const char *sock_path = socket_path + i * SOCKET_PATH_MAX;
+		struct vhost_rdma_device *dev = &g_vhost_rdma_dev[i];
+
+		dev->vid = i;
+
+		if (i == 0) {
+			/* Use shared resources for first device */
+			dev->rx_ring = vhost_rdma_rx_ring;
+			dev->tx_ring = vhost_rdma_tx_ring;
+			dev->mbuf_pool = vhost_rdma_mbuf_pool;
+		} else {
+			/* Create dedicated resources for additional devices */
+			snprintf(name_buf, sizeof(name_buf), "dev%u_rx_ring", i);
+			dev->rx_ring = rte_ring_create(name_buf, MAX_RING_COUNT,
+										rte_socket_id(), RING_F_SP_ENQ | RING_F_MC_HTS_DEQ);
+			if (!dev->rx_ring)
+				rte_exit(EXIT_FAILURE, "Failed to create RX ring %d\n", i);
+
+			snprintf(name_buf, sizeof(name_buf), "dev%u_tx_ring", i);
+			dev->tx_ring = rte_ring_create(name_buf, MAX_RING_COUNT,
+										rte_socket_id(), RING_F_MP_HTS_ENQ | RING_F_SC_DEQ);
+			if (!dev->tx_ring)
+				rte_exit(EXIT_FAILURE, "Failed to create TX ring %d\n", i);
+
+			snprintf(name_buf, sizeof(name_buf), "dev%u_mbuf_pool", i);
+			dev->mbuf_pool = rte_pktmbuf_pool_create(name_buf,
+												total_num_mbufs,
+												MBUF_CACHE_SIZE,
+												sizeof(struct vhost_rdma_pkt_info),
+												MBUF_DATA_SIZE,
+												rte_socket_id());
+			if (!dev->mbuf_pool)
+				rte_exit(EXIT_FAILURE, "Failed to create mbuf pool %d\n", i);
+		}
+
+		snprintf(name_buf, sizeof(name_buf), "dev%u_task_ring", i);
+		dev->task_ring = rte_ring_create(name_buf, MAX_RING_COUNT,
+										rte_socket_id(),
+										RING_F_MP_HTS_ENQ | RING_F_MC_HTS_DEQ);
+		if (!dev->task_ring)
+			rte_exit(EXIT_FAILURE, "Failed to create task ring %d\n", i);		
+
+		/* Construct and register vhost device */
+		ret = vhost_rdma_construct(dev, sock_path, i);
+		if (ret < 0) {
+			RDMA_LOG_ERR("Failed to construct vhost device %d\n", i);
+			continue;
+		}
+
+		ret = rte_vhost_driver_start(sock_path);
+		if (ret < 0) {
+			RDMA_LOG_ERR("Failed to start vhost driver for %s\n", sock_path);
+		} else {
+			RDMA_LOG_INFO("Successfully started vhost driver: %s\n", sock_path);
+		}
+	}
+
+	/* Wait for all worker threads to complete (they won't unless forced) */
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		rte_eal_wait_lcore(lcore_id);
+	}
+
+	vhost_rdma_main_loop(NULL);
+
+	/* Cleanup */
+	rte_eal_cleanup();
+	free(socket_path);
+
+	RDMA_LOG_INFO("Application terminated gracefully.\n");
+	return 0;
+}
diff --git a/examples/vhost_user_rdma/meson.build b/examples/vhost_user_rdma/meson.build
new file mode 100644
index 0000000000..d6ccaf32a4
--- /dev/null
+++ b/examples/vhost_user_rdma/meson.build
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2017 Intel Corporation
+
+# meson file, for building this example as part of a main DPDK build.
+#
+# To build this example as a standalone application with an already-installed
+# DPDK instance, use 'make'
+
+if not is_linux
+    build = false
+    subdir_done()
+endif
+
+deps += ['vhost', 'timer']
+
+allow_experimental_apis = true
+
+cflags_options = [
+        '-std=c11',
+        '-Wno-strict-prototypes',
+        '-Wno-pointer-arith',
+        '-Wno-maybe-uninitialized',
+        '-Wno-discarded-qualifiers',
+        '-Wno-old-style-definition',
+        '-Wno-sign-compare',
+        '-Wno-stringop-overflow',
+        '-O3',
+        '-g',
+        '-DALLOW_EXPERIMENTAL_API',
+        '-DDEBUG_RDMA',
+        '-DDEBUG_RDMA_DP',
+]
+
+foreach option:cflags_options
+    if cc.has_argument(option)
+        cflags += option
+    endif
+endforeach
+
+sources = files(
+    'main.c',
+    'vhost_rdma.c',
+    'vhost_rdma_ib.c',
+)
+
diff --git a/examples/vhost_user_rdma/vhost_rdma.c b/examples/vhost_user_rdma/vhost_rdma.c
new file mode 100644
index 0000000000..2cf47a6baa
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma.c
@@ -0,0 +1,697 @@
+/*
+ * Vhost-user RDMA device : init and packets forwarding
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <unistd.h>
+#include <stdlib.h>
+
+#include <rte_malloc.h>
+#include <rte_bitmap.h>
+#include <rte_common.h>
+#include <rte_ring.h>
+#include <rte_vhost.h>
+#include <rte_malloc.h>
+
+#include "vhost_rdma.h"
+#include "vhost_rdma_ib.h"
+#include "vhost_rdma_pkt.h"
+#include "vhost_rdma_log.h"
+
+#define VHOST_MAX_DEVICES 32
+
+struct vhost_rdma_device g_vhost_rdma_dev[MAX_VHOST_RDMA_DEV_NUM];
+struct vhost_rdma_net_dev g_vhost_rdma_net_dev[MAX_VHOST_RDMA_DEV_NUM];
+
+/**
+ * @brief Install required vhost-user protocol features for RDMA device.
+ *
+ * Enables CONFIG and MQ features which are essential for multi-queue
+ * and configuration space access in vhost-user frontend.
+ *
+ * @param path Socket or VFIO device path used by vhost driver
+ */
+static void
+vhost_rdma_install_rte_compat_hooks(const char *path)
+{
+	uint64_t protocol_features = 0;
+
+	if (!path) {
+		RDMA_LOG_ERR("Invalid path parameter");
+		return;
+	}
+
+	/* Retrieve current protocol features */
+	if (rte_vhost_driver_get_protocol_features(path, &protocol_features) < 0) {
+		RDMA_LOG_DEBUG("Failed to get protocol features for %s, assuming 0", path);
+		protocol_features = 0;
+	}
+
+	/* Enable mandatory features */
+	protocol_features |= (1ULL << VHOST_USER_PROTOCOL_F_CONFIG);  // For GET/SET_CONFIG
+	protocol_features |= (1ULL << VHOST_USER_PROTOCOL_F_MQ);	  // Multi-queue support
+
+	if (rte_vhost_driver_set_protocol_features(path, protocol_features) < 0) {
+		RDMA_LOG_ERR("Failed to set protocol features on %s", path);
+	} else {
+		RDMA_LOG_DEBUG("Enabled CONFIG and MQ features for %s", path);
+	}
+}
+
+/**
+ * @brief Construct a net device with given queues.
+ *
+ * Initializes the per-device queue mapping and state.
+ *
+ * @param queues Array of vhost-user queues
+ * @param idx	Device index
+ */
+void
+vhost_rdma_net_construct(struct vhost_user_queue *queues, int idx)
+{
+	if (idx < 0 || idx >= VHOST_MAX_DEVICES) {
+		RDMA_LOG_ERR("Invalid device index: %d", idx);
+		return;
+	}
+
+	if (!queues) {
+		RDMA_LOG_ERR("NULL queues pointer for device %d", idx);
+		return;
+	}
+
+	g_vhost_rdma_net_dev[idx].queues = queues;
+	g_vhost_rdma_net_dev[idx].started = false;
+
+	RDMA_LOG_DEBUG("Net device %d constructed with queues=%p", idx, queues);
+}
+
+/**
+ * @brief Initialize an object pool with bitmap-based allocation tracking.
+ *
+ * Allocates contiguous memory for `num` objects and a bitmap to track usage.
+ * Optionally reserves index 0 (when !start_zero), useful for representing invalid handles.
+ *
+ * @param pool	   [out] Pool structure to initialize
+ * @param name	   Name used in memory allocation (can be NULL)
+ * @param num		Number of objects to allocate
+ * @param size	   Size of each object
+ * @param start_zero If true, index 0 is usable; else reserved
+ * @param cleanup	Optional callback called on free (can be NULL)
+ *
+ * @return 0 on success, -1 on failure
+ */
+int
+vhost_rdma_pool_init(struct vhost_rdma_pool *pool,
+					const char *name,
+					uint32_t num,
+					uint32_t size,
+					bool start_zero,
+					void (*cleanup)(void *))
+{
+	void *mem = NULL;
+	uint32_t actual_num;
+	struct rte_bitmap *bmp = NULL;
+	const char *pool_name = name ? name : "vhost_rdma_pool";
+
+	if (!pool || num == 0 || size == 0) {
+		RDMA_LOG_ERR("Invalid parameters: pool=%p, num=%u, size=%u", pool, num, size);
+		return -1;
+	}
+
+	/* Adjust total number: reserve index 0 if needed */
+	actual_num = start_zero ? num : num + 1;
+
+	/* Allocate object storage */
+	pool->objs = rte_zmalloc(pool_name, actual_num * size, RTE_CACHE_LINE_SIZE);
+	if (!pool->objs) {
+		RDMA_LOG_ERR("Failed to allocate %u * %u bytes for objects", actual_num, size);
+		goto err_objs;
+	}
+
+	/* Allocate bitmap metadata */
+	uint32_t bmp_size = rte_bitmap_get_memory_footprint(actual_num);
+	mem = rte_zmalloc(pool_name, bmp_size, RTE_CACHE_LINE_SIZE);
+	if (!mem) {
+		RDMA_LOG_ERR("Failed to allocate %u bytes for bitmap", bmp_size);
+		goto err_bmp_mem;
+	}
+
+	/* Initialize bitmap */
+	bmp = rte_bitmap_init(actual_num, mem, bmp_size);
+	if (!bmp) {
+		RDMA_LOG_ERR("Failed to init bitmap with %u bits", actual_num);
+		goto err_bmp_init;
+	}
+
+	/* Mark all slots as FREE (bitmap: SET = free) */
+	for (uint32_t i = 0; i < actual_num; i++) {
+		rte_bitmap_set(bmp, i);
+	}
+
+	/* Reserve index 0 if not starting from zero */
+	if (!start_zero) {
+		rte_bitmap_clear(bmp, 0);  /* Now allocated/reserved */
+	}
+
+	/* Finalize pool setup */
+	pool->bitmap = bmp;
+	pool->bitmap_mem = mem;
+	pool->num = actual_num;
+	pool->size = size;
+	pool->cleanup = cleanup;
+
+	RDMA_LOG_DEBUG("Pool '%s' initialized: %u entries, obj_size=%u, start_zero=%d",
+				pool_name, actual_num, size, start_zero);
+
+	return 0;
+
+err_bmp_init:
+	rte_free(mem);
+err_bmp_mem:
+	rte_free(pool->objs);
+err_objs:
+	return -1;
+}
+
+/**
+ * @brief Get pointer to object at given index if it is currently allocated.
+ *
+ * Does NOT check thread safety.
+ *
+ * @param pool Pool instance
+ * @param idx  Object index
+ * @return Pointer to object if allocated, NULL otherwise or if out-of-bounds
+ */
+void *
+vhost_rdma_pool_get(struct vhost_rdma_pool *pool, uint32_t idx)
+{
+	if (!pool || idx >= pool->num) {
+		RDMA_LOG_DEBUG("Invalid pool or index: pool=%p, idx=%u, num=%u",
+					pool, idx, pool ? pool->num : 0);
+		return NULL;
+	}
+
+	/* Bitmap: SET = free, CLEAR = allocated */
+	if (rte_bitmap_get(pool->bitmap, idx)) {
+		RDMA_LOG_DEBUG("Object at index %u is free, cannot get", idx);
+		return NULL;
+	}
+
+	return RTE_PTR_ADD(pool->objs, idx * pool->size);
+}
+
+/**
+ * @brief Allocate a new object from the pool.
+ *
+ * Finds the first available slot, clears its bit (marks as used), optionally zeroes memory,
+ * and returns a pointer. Also outputs the assigned index via `idx` parameter.
+ *
+ * @param pool Pool to allocate from
+ * @param idx  [out] Assigned index (optional, pass NULL if not needed)
+ * @return Pointer to allocated object, or NULL if no space
+ */
+void *
+vhost_rdma_pool_alloc(struct vhost_rdma_pool *pool, uint32_t *idx)
+{
+	uint32_t pos = 0;
+	uint64_t slab = 0;
+	void *obj;
+
+	if (!pool) {
+		RDMA_LOG_ERR("NULL pool");
+		return NULL;
+	}
+
+	__rte_bitmap_scan_init(pool->bitmap);
+	int found = rte_bitmap_scan(pool->bitmap, &pos, &slab);
+	if (!found) {
+		RDMA_LOG_DEBUG("No free objects in pool");
+		return NULL;
+	}
+
+	uint32_t allocated_idx = pos + __builtin_ctzll(slab);
+	obj = RTE_PTR_ADD(pool->objs, allocated_idx * pool->size);
+
+	/* Zero-initialize new object */
+	memset(obj, 0, pool->size);
+
+	/* Mark as allocated */
+	rte_bitmap_clear(pool->bitmap, allocated_idx);
+
+	if (idx) {
+		*idx = allocated_idx;
+	}
+
+	RDMA_LOG_DEBUG("Allocated object at index %u", allocated_idx);
+	return obj;
+}
+
+/**
+ * @brief Free an object back into the pool.
+ *
+ * Calls optional cleanup callback before releasing.
+ * Not thread-safe — must be externally synchronized.
+ *
+ * @param pool Pool containing the object
+ * @param idx  Index of object to free
+ */
+void
+vhost_rdma_pool_free(struct vhost_rdma_pool *pool, uint32_t idx)
+{
+	if (!pool || idx >= pool->num) {
+		RDMA_LOG_ERR("Invalid pool or index: pool=%p, idx=%u", pool, idx);
+		return;
+	}
+
+	void *obj = vhost_rdma_pool_get(pool, idx);
+	if (!obj) {
+		RDMA_LOG_DEBUG("Index %u already free, skipping", idx);
+		return;  /* Idempotent: already free */
+	}
+
+	/* Call user-defined cleanup hook */
+	if (pool->cleanup) {
+		pool->cleanup(obj);
+	}
+
+	/* Return to free list */
+	rte_bitmap_set(pool->bitmap, idx);
+
+	RDMA_LOG_DEBUG("Freed object at index %u", idx);
+}
+
+/**
+ * @brief Destroy the entire pool and release all memory.
+ *
+ * WARNING: Caller must ensure no live references exist.
+ * Does NOT call cleanup() on remaining live objects.
+ *
+ * @param pool Pool to destroy
+ */
+void
+vhost_rdma_pool_destroy(struct vhost_rdma_pool *pool)
+{
+	if (!pool) {
+		return;
+	}
+
+	if (pool->bitmap_mem) {
+		rte_bitmap_free(pool->bitmap);  /* Frees internal state too */
+		rte_free(pool->bitmap_mem);
+		pool->bitmap = NULL;
+		pool->bitmap_mem = NULL;
+	}
+
+	if (pool->objs) {
+		rte_free(pool->objs);
+		pool->objs = NULL;
+	}
+
+	pool->num = 0;
+	pool->size = 0;
+	pool->cleanup = NULL;
+
+	RDMA_LOG_DEBUG("Pool destroyed");
+}
+
+/**
+ * @brief Set up the vhost-user network backend for a given device.
+ *
+ * Initializes guest memory mapping, negotiates features (e.g., merged RX buffers),
+ * sets header length accordingly, disables unnecessary notifications during setup,
+ * and marks the device as started.
+ *
+ * @param vid Vhost device ID (from rte_vhost driver)
+ */
+void
+vs_vhost_rdma_net_setup(int vid)
+{
+	struct vhost_rdma_net_dev *dev;
+	uint64_t negotiated_features = 0;
+	int ret;
+
+	/* Validate input */
+	if (vid < 0 || vid >= VHOST_MAX_DEVICES) {
+		RDMA_LOG_ERR("Invalid vhost device ID: %d", vid);
+		return;
+	}
+
+	dev = &g_vhost_rdma_net_dev[vid];
+	if (!dev) {
+		RDMA_LOG_ERR("Device structure not initialized for vid=%d", vid);
+		return;  /* Should never happen */
+	}
+
+	/* Initialize device context */
+	dev->vid = vid;
+	dev->started = false;
+
+	/* Step 1: Get negotiated VirtIO features */
+	if (rte_vhost_get_negotiated_features(vid, &negotiated_features) < 0) {
+		RDMA_LOG_ERR("Failed to get negotiated features for vid=%d", vid);
+		return;
+	}
+	dev->features = negotiated_features;
+
+	/* Step 2: Determine virtio-net header size based on features */
+	if (negotiated_features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+							(1ULL << VIRTIO_F_VERSION_1))) {
+		dev->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+		RDMA_LOG_DEBUG("Using merged RX buffer header (size=%zu) for vid=%d",
+					dev->hdr_len, vid);
+	} else {
+		dev->hdr_len = sizeof(struct virtio_net_hdr);
+		RDMA_LOG_DEBUG("Using standard net header (size=%zu) for vid=%d",
+					dev->hdr_len, vid);
+	}
+
+	/* Step 3: Get guest memory table (VA->GPA/HPA translation) */
+	if (dev->mem) {
+		rte_free(dev->mem);
+		dev->mem = NULL;
+	}
+
+	ret = rte_vhost_get_mem_table(vid, &dev->mem);
+	if (ret < 0 || dev->mem == NULL) {
+		RDMA_LOG_ERR("Failed to retrieve guest memory layout for vid=%d", vid);
+		return;
+	}
+
+	RDMA_LOG_INFO("Guest memory table acquired: %u regions mapped", dev->mem->nregions);
+
+	/* Step 4: Disable guest notification during initial setup */
+	ret = rte_vhost_enable_guest_notification(vid, VHOST_NET_RXQ, 0);
+	if (ret < 0) {
+		RDMA_LOG_ERR("Failed to disable RX queue kick suppression for vid=%d", vid);
+	}
+
+	ret = rte_vhost_enable_guest_notification(vid, VHOST_NET_TXQ, 0);
+	if (ret < 0) {
+		RDMA_LOG_ERR("Failed to disable TX queue kick suppression for vid=%d", vid);
+	}
+
+	/* Final step: Mark device as ready */
+	dev->started = true;
+
+	RDMA_LOG_INFO("vhost-user net device vid=%d setup completed successfully", vid);
+}
+
+/**
+ * @brief Callback: A new vhost-user device has been negotiated and is ready for setup.
+ *
+ * This function initializes the backend RDMA device context, sets up networking parameters,
+ * allocates required resources, and marks the device as started.
+ *
+ * @param vid Vhost device identifier assigned by rte_vhost
+ * @return 0 on success, negative on failure (though return value is often ignored)
+ */
+static int
+vhost_rdma_new_device(int vid)
+{
+	struct vhost_rdma_device *dev;
+
+	/* Validate device ID */
+	if (vid < 0 || vid >= VHOST_MAX_DEVICES) {
+		RDMA_LOG_ERR("Invalid vhost device ID: %d", vid);
+		return -1;
+	}
+
+	dev = &g_vhost_rdma_dev[vid];
+
+	/* Avoid re-initializing an already started device */
+	if (dev->started) {
+		RDMA_LOG_DEBUG("Device vid=%d already started, skipping initialization", vid);
+		return 0;
+	}
+
+	/* Setup network layer: features, header size, memory table */
+	vs_vhost_rdma_net_setup(vid);
+
+	/* Finalize device state */
+	dev->vid = vid;
+	dev->started = true;
+	dev->stopped = false;
+
+	RDMA_LOG_INFO("New vhost-RDMA device created: vid=%d", vid);
+	return 0;
+}
+
+/**
+ * @brief Clean up guest memory mapping for a vhost device.
+ *
+ * Frees memory allocated by rte_vhost_get_mem_table().
+ * Safe to call multiple times (idempotent).
+ *
+ * @param vid Device ID
+ */
+static void
+vs_vhost_rdma_net_remove(int vid)
+{
+	struct vhost_rdma_net_dev *net_dev;
+
+	if (vid < 0 || vid >= VHOST_MAX_DEVICES) {
+		RDMA_LOG_ERR("Invalid device ID in net_remove: %d", vid);
+		return;
+	}
+
+	net_dev = &g_vhost_rdma_net_dev[vid];
+
+	if (net_dev->mem) {
+		RDMA_LOG_DEBUG("Freeing guest memory table for vid=%d", vid);
+		rte_free(net_dev->mem);	/* Use rte_free() because allocated via DPDK */
+		net_dev->mem = NULL;
+	} else {
+		RDMA_LOG_DEBUG("No memory table to free for vid=%d", vid);
+	}
+}
+
+/**
+ * @brief Destroy and release all resources associated with a vhost-RDMA device.
+ *
+ * Called when frontend disconnects or device is removed.
+ * Ensures safe teardown of IB context, queues, memory mappings, and notification states.
+ *
+ * @param vid Vhost device ID
+ */
+static void
+vhost_rdma_destroy_device(__rte_unused int vid)
+{
+	struct vhost_rdma_device *dev;
+	struct vhost_user_queue *vq;
+	unsigned int lcore_id;
+
+	if (vid < 0 || vid >= VHOST_MAX_DEVICES) {
+		RDMA_LOG_ERR("Attempted to destroy invalid device ID: %d", vid);
+		return;
+	}
+
+	dev = &g_vhost_rdma_dev[vid];
+
+	if (!dev->started) {
+		RDMA_LOG_DEBUG("Device vid=%d not started, nothing to destroy", vid);
+		return;
+	}
+
+	/* Mark device as stopping */
+	dev->started = false;
+	dev->stopped = true;
+
+	RDMA_LOG_INFO("Destroying vhost-RDMA device: vid=%d", vid);
+
+	/*
+	 * Wait gracefully until device is no longer in use.
+	 * Use atomic counter if available, or yield CPU.
+	 *
+	 * Note: Original code had `while (dev->inuse == 0)` which waits forever if never used!
+	 * Should be: while (dev->inuse > 0)
+	 */
+	while (dev->inuse > 0) {
+		lcore_id = rte_lcore_id();
+		if (lcore_id != RTE_MAX_LCORE) {
+			rte_pause();	/* Yield CPU time on polling lcore */
+		} else {
+			rte_delay_us_block(100);  /* Background thread sleep */
+		}
+	}
+
+	/* Step 1: Remove from network subsystem */
+	vs_vhost_rdma_net_remove(vid);
+
+	/* Step 2: Destroy InfiniBand/RDMA components (QP, CQ, MR cleanup) */
+	vhost_rdma_destroy_ib(dev);
+
+	/* Step 3: Persist vring indices before shutdown */
+	for (int i = 0; i < NUM_VHOST_QUEUES; i++) {
+		vq = &dev->vqs[i];
+
+		if (vq->enabled) {
+			int ret = rte_vhost_set_vring_base(dev->vid, i,
+											vq->last_avail_idx,
+											vq->last_used_idx);
+			if (ret < 0) {
+				RDMA_LOG_ERR("Failed to save vring base for queue %d", i);
+			}
+
+			vq->enabled = false;
+			RDMA_LOG_DEBUG("Disabled vring %d", i);
+		}
+	}
+
+	/* Step 4: Free per-device memory table (if any) */
+	if (dev->mem) {
+		RDMA_LOG_DEBUG("Freeing device memory table for vid=%d", vid);
+		rte_free(dev->mem);
+		dev->mem = NULL;
+	}
+
+	RDMA_LOG_INFO("vhost-RDMA device destroyed successfully: vid=%d", vid);
+}
+
+static enum rte_vhost_msg_result extern_vhost_pre_msg_handler(__rte_unused int vid, void *_msg)
+{
+	struct vhost_rdma_device *dev;
+	struct vhost_user_rdma_msg *msg = _msg;
+
+	dev = &g_vhost_rdma_dev[vid];
+
+	switch ((int)msg->request) {
+	case VHOST_USER_GET_VRING_BASE:
+	case VHOST_USER_SET_VRING_BASE:
+	case VHOST_USER_SET_VRING_ADDR:
+	case VHOST_USER_SET_VRING_NUM:
+	case VHOST_USER_SET_VRING_KICK:
+	case VHOST_USER_SET_VRING_CALL:
+	case VHOST_USER_SET_MEM_TABLE:
+		break;
+	case VHOST_USER_GET_CONFIG: {
+		rte_memcpy(msg->payload.cfg.region, &dev->rdma_config, sizeof(dev->rdma_config));
+		return RTE_VHOST_MSG_RESULT_REPLY;
+	}
+	case VHOST_USER_SET_CONFIG:
+	default:
+		break;
+	}
+
+	return RTE_VHOST_MSG_RESULT_NOT_HANDLED;
+}
+
+struct rte_vhost_user_extern_ops g_extern_vhost_ops = {
+	.pre_msg_handle = extern_vhost_pre_msg_handler,
+};
+
+static int vhost_rdma_new_connection(int vid)
+{
+	int ret = 0;
+
+	ret = rte_vhost_extern_callback_register(vid, &g_extern_vhost_ops, NULL);
+	if (ret != 0)
+		RDMA_LOG_ERR(
+			"rte_vhost_extern_callback_register failed for vid = %d\n",
+			vid);
+
+	g_vhost_rdma_dev[vid].vid = vid;
+	return ret;
+}
+
+static int vhost_rdma_vring_state_changed(int vid, uint16_t queue_id, int enable)
+{
+	struct vhost_rdma_device *dev = &g_vhost_rdma_dev[vid];
+	struct vhost_user_queue *vq;
+
+	assert(dev->vid == vid);
+
+	if (enable) {
+		vq = &dev->vqs[queue_id];
+
+		if (vq->enabled)
+			return 0;
+
+		vq->id = queue_id;
+
+		assert(rte_vhost_get_vhost_vring(dev->vid, queue_id,
+										&vq->vring) == 0);
+
+		assert(rte_vhost_get_vring_base(dev->vid, queue_id,
+						&vq->last_avail_idx,
+						&vq->last_used_idx) == 0);
+
+		vq->enabled = true;
+		/*
+		 * ctrl_handler MUST start when the virtqueue is enabled,
+		 * NOT start in new_device(). because driver will query some
+		 * informations through ctrl vq in ib_register_device() when
+		 * the device is not enabled.
+		 */
+		if (queue_id == VHOST_NET_ROCE_CTRL_QUEUE && !dev->ctrl_intr_registered) {
+			assert(rte_vhost_get_mem_table(vid, &dev->mem) == 0);
+			assert(dev->mem != NULL);
+
+			dev->ctrl_intr_handle.fd = dev->vqs[VHOST_NET_ROCE_CTRL_QUEUE].vring.kickfd;
+			dev->ctrl_intr_handle.type = RTE_INTR_HANDLE_EXT;
+			rte_intr_callback_register(&dev->ctrl_intr_handle,
+						vhost_rdma_handle_ctrl_vq, dev);
+			dev->ctrl_intr_registered = 1;
+		}
+	}
+	return 0;
+}
+
+static const struct rte_vhost_device_ops vhost_rdma_device_ops = {
+	.new_device =  vhost_rdma_new_device,
+	.destroy_device = vhost_rdma_destroy_device,
+	.new_connection = vhost_rdma_new_connection,
+	.vring_state_changed = vhost_rdma_vring_state_changed,
+};
+
+int vhost_rdma_construct(struct vhost_rdma_device *dev, const char *path, int idx)
+{
+	int ret;
+
+	unlink(path);
+
+	ret = rte_vhost_driver_register(path, 0);
+	if (ret != 0) {
+		RDMA_LOG_ERR("Socket %s already exists\n", path);
+		return ret;
+	}
+
+	ret = rte_vhost_driver_set_features(path, VHOST_RDMA_FEATURE);
+	if (ret != 0) {
+		RDMA_LOG_ERR("Set vhost driver features failed\n");
+		rte_vhost_driver_unregister(path);
+		return ret;
+	}
+
+	dev->stopped = false;
+	dev->inuse = 0;
+
+	/* set vhost user protocol features */
+	vhost_rdma_install_rte_compat_hooks(path);
+
+	dev->rdma_vqs = &dev->vqs[VHOST_NET_ROCE_CTRL_QUEUE];
+
+	vhost_rdma_net_construct(dev->vqs, idx);
+
+	vhost_rdma_init_ib(dev);
+	rte_spinlock_init(&dev->port_lock);
+
+	rte_vhost_driver_callback_register(path,
+					&vhost_rdma_device_ops);
+
+	for (int i = 0; i < VHOST_RDMA_NUM_OF_COUNTERS; i++) {
+		rte_atomic64_init(&dev->stats_counters[i]);
+	}
+
+	if(dev->tx_ring){
+		rte_eal_mp_remote_launch(vhost_rdma_task_scheduler, dev, SKIP_MAIN);
+	}
+
+	return 0;
+}
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma.h b/examples/vhost_user_rdma/vhost_rdma.h
new file mode 100644
index 0000000000..c1531d1a7a
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma.h
@@ -0,0 +1,444 @@
+/*
+ * Vhost-user RDMA device : init and packets forwarding
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef VHOST_RDMA_H_
+#define VHOST_RDMA_H_
+
+#include <stdint.h>
+#include <stdbool.h>
+
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_vhost.h>
+#include <rte_interrupts.h>
+#include <rte_atomic.h>
+#include <rte_spinlock.h>
+#include <rte_mempool.h>
+#include <rte_ring.h>
+#include <rte_bitmap.h>
+
+#include "vhost_rdma_ib.h"
+#include "eal_interrupts.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * @brief Number of vhost queues.
+ *
+ * One CTRL VQ + 64 CQ + 64 TX + 64 RX event queues
+ */
+#define NUM_VHOST_QUEUES			193
+
+/**
+ * @brief Maximum GID table length
+ */
+#define VHOST_MAX_GID_TBL_LEN		512
+
+/**
+ * @brief Port PKey table length (single entry for default)
+ */
+#define VHOST_PORT_PKEY_TBL_LEN		1
+
+/**
+ * @brief Number of RDMA ports supported (currently only one)
+ */
+#define NUM_OF_VHOST_RDMA_PORT		1
+
+
+#define MAX_VHOST_RDMA_DEV_NUM		16
+
+#define VIRTIO_NET_F_ROCE			48
+
+#define VHOST_NET_ROCE_CTRL_QUEUE	0
+
+#define VHOST_RDMA_GID_TYPE_ILLIGAL	(-1u)
+
+#define DEFAULT_IB_MTU VHOST_RDMA_IB_MTU_1024
+
+#define VHOST_NET_RXQ 0
+#define VHOST_NET_TXQ 1
+
+/* VIRTIO_F_EVENT_IDX is NOT supported now */
+#define VHOST_RDMA_FEATURE ((1ULL << VIRTIO_F_VERSION_1) |\
+	(1ULL << VIRTIO_RING_F_INDIRECT_DESC) | \
+	(1ULL << VHOST_USER_F_PROTOCOL_FEATURES) | \
+	(1ULL << VHOST_USER_PROTOCOL_F_STATUS) | \
+	(1ULL << VIRTIO_NET_F_CTRL_VQ) | \
+	(1ULL << VIRTIO_NET_F_ROCE))
+
+__rte_always_inline uint32_t
+roundup_pow_of_two(uint32_t n)
+{
+	return n < 2 ? n : (1u << (32 - __builtin_clz (n - 1)));
+}
+
+/**
+ * @brief Counter types for statistics in vhost RDMA device
+ */
+enum vhost_rdma_counters {
+	VHOST_RDMA_CNT_SENT_PKTS,
+	VHOST_RDMA_CNT_RCVD_PKTS,
+	VHOST_RDMA_CNT_DUP_REQ,
+	VHOST_RDMA_CNT_OUT_OF_SEQ_REQ,
+	VHOST_RDMA_CNT_RCV_RNR,
+	VHOST_RDMA_CNT_SND_RNR,
+	VHOST_RDMA_CNT_RCV_SEQ_ERR,
+	VHOST_RDMA_CNT_COMPLETER_SCHED,
+	VHOST_RDMA_CNT_RETRY_EXCEEDED,
+	VHOST_RDMA_CNT_RNR_RETRY_EXCEEDED,
+	VHOST_RDMA_CNT_COMP_RETRY,
+	VHOST_RDMA_CNT_SEND_ERR,
+	VHOST_RDMA_CNT_LINK_DOWNED,
+	VHOST_RDMA_CNT_RDMA_SEND,
+	VHOST_RDMA_CNT_RDMA_RECV,
+	VHOST_RDMA_NUM_OF_COUNTERS
+};
+
+struct vhost_rdma_net_dev {
+	int vid;
+	uint64_t features;
+	size_t hdr_len;
+	bool started;
+	struct rte_vhost_memory *mem;
+	struct vhost_user_queue *queues;
+}__rte_cache_aligned;
+
+struct vhost_user_queue {
+	struct  rte_vhost_vring vring;
+	uint16_t last_avail_idx;
+	uint16_t last_used_idx;
+	uint16_t id;
+	bool enabled;
+};
+
+/**
+ * @brief Configuration structure exposed to guest via virtio config space
+ *
+ * All fields are in little-endian byte order.
+ */
+struct vhost_rdma_config {
+	uint32_t phys_port_cnt;			/**< Physical port count */
+	uint64_t sys_image_guid;		/**< System image GUID */
+	uint32_t vendor_id;				/**< Vendor ID */
+	uint32_t vendor_part_id;		/**< Vendor part number */
+	uint32_t hw_ver;				/**< Hardware version */
+	uint64_t max_mr_size;			/**< Max memory region size */
+	uint64_t page_size_cap;			/**< Page size capabilities */
+	uint32_t max_qp;				/**< Max number of QPs */
+	uint32_t max_qp_wr;				/**< Max work requests per QP */
+	uint64_t device_cap_flag;		/**< Device capability flags */
+	uint32_t max_send_sge;			/**< Max SGEs in send WR */
+	uint32_t max_recv_sge;			/**< Max SGEs in recv WR */
+	uint32_t max_sge_rd;			/**< Max SGEs for RD operations */
+	uint32_t max_cq;				/**< Max completion queues */
+	uint32_t max_cqe;				/**< Max entries per CQ */
+	uint32_t max_mr;				/**< Max memory regions */
+	uint32_t max_pd;				/**< Max protection domains */
+	uint32_t max_qp_rd_atom;		/**< Max RDMA read-atoms per QP */
+	uint32_t max_res_rd_atom;		/**< Max responder resources */
+	uint32_t max_qp_init_rd_atom;	/**< Max initiator RD atoms */
+	uint32_t atomic_cap;			/**< Atomic operation support */
+	uint32_t max_mw;				/**< Max memory windows */
+	uint32_t max_mcast_grp;			/**< Max multicast groups */
+	uint32_t max_mcast_qp_attach;	/**< Max QPs per multicast group */
+	uint32_t max_total_mcast_qp_attach;/**< Total multicast attachments */
+	uint32_t max_ah;				/**< Max address handles */
+	uint32_t max_fast_reg_page_list_len;	/**< Fast registration page list len */
+	uint32_t max_pi_fast_reg_page_list_len;	/**< PI fast reg list len */
+	uint16_t max_pkeys;				/**< Max partition keys */
+	uint8_t  local_ca_ack_delay;	/**< Local CA ACK delay */
+	uint8_t	 reserved[5];			/* Pad to 8-byte alignment before variable area */
+	uint8_t  reserved1[64];			/**< Reserved for future use */
+};
+
+/**
+ * @brief Device attributes (host-native format, not exposed directly)
+ */
+struct vhost_rdma_dev_attr {
+	uint64_t max_mr_size;
+	uint64_t page_size_cap;
+	uint32_t hw_ver;
+	uint32_t max_qp_wr;
+	uint64_t device_cap_flags;
+	uint32_t max_qps;
+	uint32_t max_cqs;
+	uint32_t max_send_sge;
+	uint32_t max_recv_sge;
+	uint32_t max_sge_rd;
+	uint32_t max_cqe;
+	uint32_t max_mr;
+	uint32_t max_mw;
+	uint32_t max_pd;
+	uint32_t max_qp_rd_atom;
+	uint32_t max_qp_init_rd_atom;
+	uint32_t max_ah;
+	uint32_t max_fast_reg_page_list_len;
+	uint8_t  local_ca_ack_delay;
+};
+
+/**
+ * @brief Port-level attributes
+ */
+struct vhost_rdma_port_attr {
+	uint32_t bad_pkey_cntr;		/**< Bad PKey counter */
+	uint32_t qkey_viol_cntr;	/**< QKey violation counter */
+};
+
+/**
+ * @brief GID entry with type indicator
+ */
+struct vhost_rdma_gid {
+#define VHOST_RDMA_GID_TYPE_INVALID ((uint32_t)(-1))
+	uint32_t type;				/**< GID type: RoCEv1, RoCEv2, etc. */
+	uint8_t  gid[16];			/**< 128-bit GID value */
+};
+
+/**
+ * @brief Generic object pool for managing RDMA resources
+ */
+struct vhost_rdma_pool {
+	void *objs;					/**< Array of allocated objects */
+	uint32_t num;				/**< Number of objects in pool */
+	uint32_t size;				/**< Size of each object */
+
+	struct rte_bitmap *bitmap;	/**< Bitmap tracking free slots */
+	void *bitmap_mem;			/**< Memory backing the bitmap */
+
+	void (*cleanup)(void *arg);	/**< Optional cleanup function */
+};
+
+/**
+ * @brief Main RDMA vhost device structure
+ */
+struct vhost_rdma_device {
+	int							  vid;			/**< Vhost-Rdma device ID */
+	int							  started;		/**< Device start state */
+	volatile bool				stopped;		/**< Stop flag for threads */
+	volatile int				inuse;			/**< Reference count */
+
+	/* Memory and resource management */
+	struct rte_vhost_memory		*mem;			/**< Guest physical memory map */
+	struct rte_mempool			*mbuf_pool;		/**< mbuf pool for packet I/O */
+	struct rte_ring				*tx_ring;		/**< TX ring for outbound packets */
+	struct rte_ring				*rx_ring;		/**< RX ring for inbound packets */
+
+	/* Queues */
+	struct vhost_user_queue		vqs[NUM_VHOST_QUEUES];	/**< All vhost queues */
+	struct vhost_user_queue		*rdma_vqs;		/**< Shortcut to RDMA queues */
+	struct vhost_user_queue		*cq_vqs;		/**< Shortcut to CQ notification queues */
+	struct vhost_user_queue		*qp_vqs;		/**< Shortcut to QP data queues */
+	struct rte_ring				*task_ring;		/**< Task scheduling ring */
+
+	/* Interrupt handling for control plane */
+	struct rte_intr_handle		ctrl_intr_handle;	/**< Control interrupt handle */
+	int							ctrl_intr_registered;	/**< Whether interrupt is registered */
+
+	/* Virtio-net configuration (exposed to guest) */
+	struct virtio_net_config	config;				/**< Generic virtio-net config */
+	struct vhost_rdma_config	rdma_config;		/**< RDMA-specific config */
+	uint32_t					max_inline_data;	/**< Max inline data size */
+
+	/* Device attributes (cached from config) */
+	struct vhost_rdma_dev_attr	attr;			 /**< Cached device attributes */
+
+	/* Single port support */
+	struct vhost_rdma_port_attr	port_attr;		/**< Port-level counters */
+	rte_spinlock_t				port_lock;		/**< Lock for port access */
+	unsigned int				mtu_cap;		/**< MTU capability */
+	struct vhost_rdma_gid		gid_tbl[VHOST_MAX_GID_TBL_LEN]; /**< GID table */
+	struct vhost_rdma_qp		*qp_gsi;		/**< Global shared inbox QP? */
+
+	/* Resource pools */
+	struct vhost_rdma_pool		pd_pool;		/**< Protection domain pool */
+	struct vhost_rdma_pool		mr_pool;		/**< Memory region pool */
+	struct vhost_rdma_pool		cq_pool;		 /**< Completion queue pool */
+	struct vhost_rdma_pool		qp_pool;		 /**< Queue pair pool */
+	struct vhost_rdma_pool		ah_pool;		/**< Address handle pool */
+
+	/* Statistics counters */
+	rte_atomic64_t				stats_counters[VHOST_RDMA_NUM_OF_COUNTERS];
+};
+
+#define vhost_rdma_drop_ref(obj, dev, type) \
+	do { \
+		if (rte_atomic32_dec_and_test(&(obj)->refcnt)) { \
+			struct vhost_rdma_pool* pool = &(dev)->type##_pool; \
+			if (pool->cleanup) { \
+				pool->cleanup(obj); \
+			} \
+			vhost_rdma_pool_free(pool, (obj)->type##n); \
+		} \
+	}while(0)
+
+#define vhost_rdma_add_ref(obj) rte_atomic32_inc(&(obj)->refcnt)
+
+/**
+ * @brief Check if there is a new available descriptor in the virtqueue.
+ *
+ * This function compares the current avail->idx from the guest with the last
+ * processed index. If they differ, at least one new descriptor is ready.
+ *
+ * @param vq  Pointer to the virtual queue.
+ * @return	true if a new descriptor is available, false otherwise.
+ */
+static __rte_always_inline bool
+vhost_rdma_vq_is_avail(struct vhost_user_queue *vq)
+{
+	return vq->vring.avail->idx != vq->last_avail_idx;
+}
+
+/**
+ * @brief Get pointer to element at given index in a generic data ring.
+ *
+ * Used for accessing pre-allocated memory pools where each element has fixed size.
+ *
+ * @param queue	 Pointer to the queue containing data buffer.
+ * @param idx	   Index of the desired element.
+ * @return		  Pointer to the data at position idx.
+ */
+static __rte_always_inline void *
+vhost_rdma_queue_get_data(struct vhost_rdma_queue *queue, size_t idx)
+{
+	return queue->data + queue->elem_size * idx;
+}
+
+/**
+ * @brief Retrieve the next available descriptor index from the avail ring.
+ *
+ * Reads the descriptor index at the current position in the avail ring,
+ * increments last_avail_idx, and returns the descriptor index.
+ *
+ * @param vq  Pointer to the virtual queue.
+ * @return	Index of the first descriptor in the incoming request chain.
+ */
+static __rte_always_inline uint16_t
+vhost_rdma_vq_get_desc_idx(struct vhost_user_queue *vq)
+{
+	uint16_t desc_idx;
+	uint16_t last_avail_idx;
+
+	/* Mask with ring size to handle wraparound */
+	last_avail_idx = vq->last_avail_idx & (vq->vring.size - 1);
+	desc_idx = vq->vring.avail->ring[last_avail_idx];
+
+	/* Advance the local index tracker */
+	vq->last_avail_idx++;
+
+	return desc_idx;
+}
+
+/**
+ * @brief Get the next descriptor in the chain, if any.
+ *
+ * Checks the VRING_DESC_F_NEXT flag. If set, returns pointer to the next
+ * descriptor using the 'next' field as an index into the descriptor table.
+ *
+ * @param table  Base address of the descriptor table.
+ * @param desc   Current descriptor.
+ * @return	   Pointer to next descriptor, or NULL if end of chain.
+ */
+static __rte_always_inline struct vring_desc *
+vhost_rdma_vring_get_next_desc(struct vring_desc *table, struct vring_desc *desc)
+{
+	if (desc->flags & VRING_DESC_F_NEXT)
+		return &table[desc->next];
+
+	return NULL;
+}
+
+/**
+ * @brief Add a used descriptor entry to the used ring.
+ *
+ * Records that a buffer has been consumed by the host/device, including its
+ * original descriptor index and the number of bytes written.
+ *
+ * Uses memory barriers to ensure ordering before updating used->idx.
+ *
+ * @param vq	 Virtual queue.
+ * @param idx	Descriptor index being returned.
+ * @param len	Number of bytes written (for writeable descriptors).
+ */
+static __rte_always_inline void
+vhost_rdma_queue_push(struct vhost_user_queue *vq, uint16_t idx, uint32_t len)
+{
+	struct vring_used *used = vq->vring.used;
+	uint16_t slot = used->idx & (vq->vring.size - 1);
+
+	used->ring[slot].id  = idx;
+	used->ring[slot].len = len;
+
+	/* Full memory barrier before incrementing idx to ensure visibility */
+	rte_smp_mb();
+	used->idx++;
+	rte_smp_mb();
+}
+
+/**
+ * @brief Notify the frontend (guest) about used descriptor updates.
+ *
+ * Calls into the DPDK vhost library to signal the guest via eventfd or doorbell.
+ *
+ * @param vid  Virtual host device ID.
+ * @param vq   Pointer to the virtual queue that needs notification.
+ */
+static __rte_always_inline void
+vhost_rdma_queue_notify(int vid, struct vhost_user_queue *vq)
+{
+	rte_vhost_vring_call(vid, vq->id);
+}
+
+/**
+ * @brief Translate Guest Physical Address (GPA) to Virtual VA in host.
+ *
+ * Wrapper around DPDK's rte_vhost_va_from_guest_pa(). This function performs
+ * address translation using the guest memory map provided through vhost-user.
+ *
+ * @param mem  Pointer to vhost memory region mapping.
+ * @param gpa  Guest physical address to translate.
+ * @param len  [in/out] On input: requested length; on output: actual mapped length.
+ * @return	 Host virtual address corresponding to GPA, or 0 on failure.
+ */
+static __rte_always_inline uint64_t
+gpa_to_vva(struct rte_vhost_memory *mem, uint64_t gpa, uint64_t *len)
+{
+	assert(mem != NULL);
+	return rte_vhost_va_from_guest_pa(mem, gpa, len);
+}
+
+int vhost_rdma_construct(struct vhost_rdma_device *dev, const char *path, int idx);
+void vhost_rdma_net_construct(struct vhost_user_queue *queues, int idx);
+void vs_vhost_rdma_net_setup(int vid);
+
+
+void vhost_rdma_destroy(const char* path);
+int vhost_rdma_pool_init(struct vhost_rdma_pool* pool,
+						 const char* name,
+						 uint32_t num,
+						 uint32_t size,
+						 bool start_zero,
+						 void (*cleanup)(void*));
+void* vhost_rdma_pool_get(struct vhost_rdma_pool* pool, uint32_t idx);
+void vhost_rdma_pool_free(struct vhost_rdma_pool* pool, uint32_t idx);
+void* vhost_rdma_pool_alloc(struct vhost_rdma_pool* pool, uint32_t *idx);
+void vhost_rdma_pool_destroy(struct vhost_rdma_pool* pool);
+
+extern struct vhost_rdma_device g_vhost_rdma_dev[MAX_VHOST_RDMA_DEV_NUM];
+extern struct vhost_rdma_net_dev g_vhost_rdma_net_dev[MAX_VHOST_RDMA_DEV_NUM];
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* VHOST_RDMA_H_ */
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.c b/examples/vhost_user_rdma/vhost_rdma_ib.c
new file mode 100644
index 0000000000..5535a8696b
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.c
@@ -0,0 +1,647 @@
+/*
+ * Vhost-user RDMA device : init and packets forwarding
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <unistd.h>
+#include <sys/uio.h>
+#include <stdlib.h>
+
+#include <rte_ethdev.h>
+#include <rte_spinlock.h>
+#include <rte_malloc.h>
+
+#include "vhost_rdma.h"
+#include "vhost_rdma_ib.h"
+#include "vhost_rdma_log.h"
+#include "vhost_rdma_pkt.h"
+
+#define CHK_IOVEC(tp, iov) \
+	do { \
+		if(iov->iov_len < sizeof(*tp)) { \
+			RDMA_LOG_ERR("%s: " #iov " iovec is too small : %ld, %ld", __func__, sizeof(*tp), iov->iov_len); \
+			return -1; \
+		} \
+		tp = iov->iov_base; \
+	} while(0); \
+
+#define DEFINE_VIRTIO_RDMA_CMD(cmd, handler) [cmd] = {handler, #cmd}
+
+#define CTRL_NO_CMD __rte_unused struct iovec *__in
+#define CTRL_NO_RSP __rte_unused struct iovec *__out
+
+/**
+ * @brief Free resources held by a response entry in the RDMA responder path.
+ *
+ * Cleans up mbuf (for ATOMIC) or MR reference (for RDMA READ), then resets type.
+ * Uses RDMA_LOG_* macros for consistent logging.
+ *
+ * @param qp Queue Pair (currently unused)
+ * @param res Response resource to free (in/out)
+ */
+void
+free_rd_atomic_resource(__rte_unused struct vhost_rdma_qp *qp,
+						struct vhost_rdma_resp_res *res)
+{
+	if (!res) {
+		RDMA_LOG_ERR("Cannot free NULL response resource");
+		return;
+	}
+
+	switch (res->type) {
+	case VHOST_ATOMIC_MASK: {
+		struct rte_mbuf *mbuf = res->atomic.mbuf;
+		if (mbuf) {
+			RDMA_LOG_DEBUG("Freeing mbuf=%p from ATOMIC response", mbuf);
+			rte_pktmbuf_free(mbuf);
+			res->atomic.mbuf = NULL;
+		}
+		break;
+	}
+
+	case VHOST_READ_MASK: {
+		struct vhost_rdma_mr *mr = res->read.mr;
+		if (mr) {
+			RDMA_LOG_DEBUG("Dropping MR reference %p from RDMA READ response", mr);
+			vhost_rdma_drop_ref(mr, qp->dev, mr);
+			res->read.mr = NULL;
+		}
+		break;
+	}
+
+	case 0:
+		/* Already freed — silent no-op */
+		break;
+
+	default:
+		RDMA_LOG_ERR("Unknown response resource type %u (possible memory corruption)", res->type);
+		break;
+	}
+
+	/* Reset type to mark as free */
+	res->type = 0;
+}
+
+/**
+ * @brief Free all RD/Atomic response resources allocated for a Queue Pair.
+ *
+ * Iterates through the pre-allocated array of response tracking entries
+ * (used for RDMA READ and ATOMIC operations), frees associated mbufs or MRs,
+ * then releases the entire array memory.
+ *
+ * Safe to call multiple times (idempotent).
+ *
+ * @param qp Pointer to the Queue Pair whose response resources should be freed
+ */
+void
+free_rd_atomic_resources(struct vhost_rdma_qp *qp)
+{
+	if (!qp) {
+		RDMA_LOG_ERR("Cannot free response resources: qp is NULL");
+		return;
+	}
+
+	if (!qp->resp.resources) {
+		RDMA_LOG_DEBUG("No response resources to free for QP %u", qp->qpn);
+		return;
+	}
+
+	const uint32_t max_ops = qp->attr.max_dest_rd_atomic;
+
+	RDMA_LOG_DEBUG("Freeing %u RD/Atomic response resources for QP %u",
+				   max_ops, qp->qpn);
+
+	for (uint32_t i = 0; i < max_ops; i++) {
+		struct vhost_rdma_resp_res *res = &qp->resp.resources[i];
+
+		/* Frees internal resources (mbuf or mr) and resets type */
+		free_rd_atomic_resource(qp, res);
+	}
+
+	/* Now free the entire array */
+	rte_free(qp->resp.resources);
+	qp->resp.resources = NULL;
+
+	RDMA_LOG_DEBUG("Successfully freed response resource array for QP %u", qp->qpn);
+}
+
+
+/**
+ * @brief Clean up a vhost RDMA queue.
+ */
+void
+vhost_rdma_queue_cleanup(struct vhost_rdma_qp *qp, struct vhost_rdma_queue *queue)
+{
+	if (!queue)
+		return;
+
+	if (queue->cb && qp)
+		rte_intr_callback_unregister(&queue->intr_handle, queue->cb, qp);
+
+	rte_free(queue->data);
+	queue->data = NULL;
+}
+
+/**
+ * @brief Cleanup callback for MR: reset type.
+ */
+void
+vhost_rdma_mr_cleanup(void *arg)
+{
+	struct vhost_rdma_mr *mr = arg;
+
+	if (mr)
+		mr->type = VHOST_MR_TYPE_NONE;
+}
+
+/**
+ * @brief Cleanup callback for QP: drop references and free resources.
+ */
+void
+vhost_rdma_qp_cleanup(void *arg)
+{
+	struct vhost_rdma_qp *qp = arg;
+
+	if (!qp)
+		return;
+
+	if (qp->scq) {
+		vhost_rdma_drop_ref(qp->scq, qp->dev, cq);
+		qp->scq = NULL;
+	}
+
+	if (qp->rcq) {
+		vhost_rdma_drop_ref(qp->rcq, qp->dev, cq);
+		qp->rcq = NULL;
+	}
+
+	if (qp->pd) {
+		vhost_rdma_drop_ref(qp->pd, qp->dev, pd);
+		qp->pd = NULL;
+	}
+
+	if (qp->resp.mr) {
+		vhost_rdma_drop_ref(qp->resp.mr, qp->dev, mr);
+		qp->resp.mr = NULL;
+	}
+
+	free_rd_atomic_resources(qp);
+}
+
+void
+vhost_rdma_init_ib(struct vhost_rdma_device *dev)
+{
+	uint32_t qpn;
+
+	if (!dev) {
+		return;
+	}
+
+	/* Initialize device attributes (virtio-rdma IB capability) */
+	dev->attr.max_qps = 64;
+	dev->attr.max_cqs = 64;
+	dev->attr.max_mr_size = UINT64_MAX;
+	dev->attr.page_size_cap = 0xFFFFF000U;
+	dev->attr.max_qp_wr = 1024;
+	dev->attr.device_cap_flags = VIRTIO_IB_DEVICE_RC_RNR_NAK_GEN;
+	dev->attr.max_send_sge = 32;
+	dev->attr.max_recv_sge = 32;
+	dev->attr.max_sge_rd = 32;
+	dev->attr.max_cqe = 1024;
+	dev->attr.max_mr = 0x00001000;
+	dev->attr.max_mw = 0;
+	dev->attr.max_pd = 0x7FFC;
+	dev->attr.max_qp_rd_atom = 128;
+	dev->attr.max_qp_init_rd_atom = 128;
+	dev->attr.max_ah = 100;
+	dev->attr.max_fast_reg_page_list_len = 512;
+	dev->attr.local_ca_ack_delay = 15;
+
+	/* Point to the RDMA configuration structure for cleaner assignment */
+	struct vhost_rdma_config  *cfg = &dev->rdma_config;
+
+	/* Copy basic limits from device attributes */
+	cfg->max_qp						= dev->attr.max_qps;
+	cfg->max_cq						= dev->attr.max_cqs;
+	cfg->max_mr						= dev->attr.max_mr;
+	cfg->max_pd						= dev->attr.max_pd;
+	cfg->max_ah						= dev->attr.max_ah;
+	cfg->max_cqe					= dev->attr.max_cqe;
+	cfg->max_qp_wr					= dev->attr.max_qp_wr;
+	cfg->max_send_sge				= dev->attr.max_send_sge;
+	cfg->max_recv_sge				= dev->attr.max_recv_sge;
+	cfg->max_sge_rd					= dev->attr.max_sge_rd;
+	cfg->max_qp_rd_atom				= dev->attr.max_qp_rd_atom;
+	cfg->max_qp_init_rd_atom		= dev->attr.max_qp_init_rd_atom;
+	cfg->max_mr_size				= dev->attr.max_mr_size;
+	cfg->max_mw						= dev->attr.max_mw;
+	cfg->max_fast_reg_page_list_len	= dev->attr.max_fast_reg_page_list_len;
+	cfg->page_size_cap				= dev->attr.page_size_cap;
+	cfg->device_cap_flag			= dev->attr.device_cap_flags;
+	cfg->local_ca_ack_delay			= dev->attr.local_ca_ack_delay;
+	cfg->phys_port_cnt				= 1;
+	cfg->max_pkeys					= 1;
+	cfg->vendor_id					= 0x1AF4;
+	cfg->vendor_part_id				= 0x0042;
+	cfg->sys_image_guid				= 1;
+
+	/* Derived capabilities */
+	cfg->max_res_rd_atom = cfg->max_qp_rd_atom * cfg->max_qp;
+	cfg->max_total_mcast_qp_attach = 8192UL * 56UL;
+	cfg->max_pi_fast_reg_page_list_len = cfg->max_fast_reg_page_list_len / 2;
+
+	/* Inline data and MTU settings */
+	dev->max_inline_data = dev->attr.max_send_sge * sizeof(struct vhost_user_rdma_sge);
+	dev->mtu_cap = ib_mtu_enum_to_int(DEFAULT_IB_MTU);
+
+	/* Reset port counters */
+	dev->port_attr.bad_pkey_cntr = 0;
+	dev->port_attr.qkey_viol_cntr = 0;
+
+	/* Initialize GID table (illegal by default) */
+	for (int i = 0; i < VHOST_MAX_GID_TBL_LEN; i++) {
+		dev->gid_tbl[i].type = VHOST_RDMA_GID_TYPE_ILLIGAL; /* Typo? Should be ILLEGAL? */
+	}
+
+	/* Setup virtual queue mappings:
+	 * rdma_vqs[0] is reserved (likely control),
+	 * cq_vqs starts at index 1,
+	 * qp_vqs follows after all CQs.
+	 */
+	dev->cq_vqs = &dev->rdma_vqs[1];
+	dev->qp_vqs = &dev->rdma_vqs[1 + dev->attr.max_cqs];
+
+	/* Initialize resource pools */
+	vhost_rdma_pool_init(&dev->pd_pool, "pd_pool", dev->attr.max_pd,
+						 sizeof(struct vhost_rdma_pd), false, NULL);
+
+	vhost_rdma_pool_init(&dev->mr_pool, "mr_pool", dev->attr.max_mr,
+						 sizeof(struct vhost_rdma_mr), false, vhost_rdma_mr_cleanup);
+
+	vhost_rdma_pool_init(&dev->cq_pool, "cq_pool", dev->attr.max_cqs,
+						 sizeof(struct vhost_rdma_cq), true, NULL);  /* Shared across cores? */
+
+	vhost_rdma_pool_init(&dev->qp_pool, "qp_pool", dev->attr.max_qps,
+						 sizeof(struct vhost_rdma_qp), false, vhost_rdma_qp_cleanup);
+
+	vhost_rdma_pool_init(&dev->ah_pool, "ah_pool", dev->attr.max_ah,
+						 sizeof(struct vhost_rdma_av), false, NULL);
+
+	/* Allocate special GSI QP (QP number 1), used for subsystem management (e.g., SM in IB) */
+	dev->qp_gsi = vhost_rdma_pool_alloc(&dev->qp_pool, &qpn);
+	if (!dev->qp_gsi) {
+		return;  /* Failed to allocate GSI QP */
+	}
+	vhost_rdma_add_ref(dev->qp_gsi);  /* Hold a reference */
+	assert(qpn == 1);  /* GSI must be assigned QPN 1 */
+}
+
+/**
+ * @brief Destroy and clean up all RDMA resources associated with the device.
+ *
+ * This function safely releases all allocated QPs, CQs, MRs, PDs, and AVs,
+ * then destroys their respective memory pools.
+ *
+ * Note: It assumes no external references exist to these objects.
+ */
+void
+vhost_rdma_destroy_ib(struct vhost_rdma_device *dev)
+{
+	struct vhost_rdma_mr *mr;
+	struct vhost_rdma_pd *pd;
+	struct vhost_rdma_cq *cq;
+	struct vhost_rdma_qp *qp;
+	struct vhost_rdma_av *av;
+	uint32_t i;
+
+	if (!dev) {
+		return;
+	}
+
+	/* Clean up Memory Regions (MR): cleanup callback may have already reset state */
+	for (i = 0; i < dev->attr.max_mr; i++) {
+		mr = vhost_rdma_pool_get(&dev->mr_pool, i);
+		if (mr) {
+			vhost_rdma_pool_free(&dev->mr_pool, i);  /* Triggers cleanup if registered */
+		}
+	}
+
+	/* Clean up Protection Domains (PD) */
+	for (i = 0; i < dev->attr.max_pd; i++) {
+		pd = vhost_rdma_pool_get(&dev->pd_pool, i);
+		if (pd) {
+			vhost_rdma_pool_free(&dev->pd_pool, i);
+		}
+	}
+
+	/* Clean up Completion Queues (CQ) */
+	for (i = 0; i < dev->attr.max_cqs; i++) {
+		cq = vhost_rdma_pool_get(&dev->cq_pool, i);
+		if (cq) {
+			vhost_rdma_pool_free(&dev->cq_pool, i);
+		}
+	}
+
+	/* Clean up Queue Pairs (QP): must drain SQ/RQ before freeing */
+	for (i = 0; i < dev->attr.max_qps; i++) {
+		qp = vhost_rdma_pool_get(&dev->qp_pool, i);
+		if (qp) {
+			/* Cleanup send and receive queues (e.g., unregister intr handlers, free ring buffers) */
+			vhost_rdma_queue_cleanup(qp, &qp->sq.queue);
+			vhost_rdma_queue_cleanup(qp, &qp->rq.queue);
+
+			/* Now free the QP from the pool (triggers vhost_rdma_qp_cleanup if set) */
+			vhost_rdma_pool_free(&dev->qp_pool, i);
+		}
+	}
+
+	/* Clean up Address Handles (AH / AV) */
+	for (i = 0; i < dev->attr.max_ah; i++) {
+		av = vhost_rdma_pool_get(&dev->ah_pool, i);
+		if (av) {
+			vhost_rdma_pool_free(&dev->ah_pool, i);
+		}
+	}
+
+	/*
+	 * Destroy resource pools.
+	 * This frees internal pool metadata and backing arrays.
+	 * Pools should be empty at this point.
+	 */
+	vhost_rdma_pool_destroy(&dev->mr_pool);
+	vhost_rdma_pool_destroy(&dev->pd_pool);
+	vhost_rdma_pool_destroy(&dev->cq_pool);
+	vhost_rdma_pool_destroy(&dev->qp_pool);
+	vhost_rdma_pool_destroy(&dev->ah_pool);
+}
+
+/**
+ * @brief Convert a guest physical address payload into iovec entries.
+ *
+ * This function translates a contiguous memory region (starting at 'payload'
+ * with length 'remaining') into one or more iovecs by looking up the virtual
+ * address via gpa_to_vva(). The resulting iovecs are stored in 'iovs', and
+ * 'iov_index' is updated accordingly.
+ *
+ * @param mem		 Pointer to vhost memory structure for GPA->VVA translation.
+ * @param iovs		Array of iovec structures to fill.
+ * @param iov_index   Current index in the iovs array (updated on success).
+ * @param payload	 Guest physical address (GPA) of the data.
+ * @param remaining   Total number of bytes left to translate.
+ * @param num_iovs	Maximum number of iovecs allowed.
+ * @return			0 on success, -1 on error (e.g., translation failure or overflow).
+ */
+static int
+desc_payload_to_iovs(struct rte_vhost_memory *mem,
+					 struct iovec *iovs,
+					 uint32_t *iov_index,
+					 uintptr_t payload,
+					 uint64_t remaining,
+					 uint16_t num_iovs)
+{
+	void *vva;
+	uint64_t len;
+
+	do {
+		if (*iov_index >= num_iovs) {
+			RDMA_LOG_ERR("MAX_IOVS reached");
+			return -1;
+		}
+
+		len = remaining;
+		vva = (void *)(uintptr_t)gpa_to_vva(mem, payload, &len);
+		if (!vva || !len) {
+			RDMA_LOG_ERR("failed to translate desc address.");
+			return -1;
+		}
+
+		iovs[*iov_index].iov_base = vva;
+		iovs[*iov_index].iov_len = len;
+
+		payload += len;
+		remaining -= len;
+		(*iov_index)++;
+	} while (remaining);
+
+	return 0;
+}
+
+/**
+ * @brief Set up iovecs from vring descriptors for a given request.
+ *
+ * Parses the descriptor chain starting at 'req_idx'. Handles both direct and
+ * indirect descriptors. Fills the provided 'iovs' array with valid memory
+ * regions derived from GPA-to-VVA translation. Also counts input/output descriptors.
+ *
+ * @param mem		 Vhost memory configuration for address translation.
+ * @param vq		  Virtual queue containing the descriptor ring.
+ * @param req_idx	 Index of the first descriptor in the chain.
+ * @param iovs		Pre-allocated iovec array to populate.
+ * @param num_iovs	Size of the iovs array (maximum entries).
+ * @param num_in	  Output: number of writable (input) descriptors.
+ * @param num_out	 Output: number of readable (output) descriptors.
+ * @return			Number of filled iovecs on success, -1 on error.
+ */
+int
+setup_iovs_from_descs(struct rte_vhost_memory *mem,
+					  struct vhost_user_queue *vq,
+					  uint16_t req_idx,
+					  struct iovec *iovs,
+					  uint16_t num_iovs,
+					  uint16_t *num_in,
+					  uint16_t *num_out)
+{
+	struct vring_desc *desc = &vq->vring.desc[req_idx];
+	struct vring_desc *desc_table;
+	uint32_t iovs_idx = 0;
+	uint64_t len;
+	uint16_t in = 0, out = 0;
+
+	/* Handle indirect descriptors */
+	if (desc->flags & VRING_DESC_F_INDIRECT) {
+		len = desc->len;
+		desc_table = (struct vring_desc *)(uintptr_t)gpa_to_vva(mem, desc->addr, &len);
+		if (!desc_table || !len) {
+			RDMA_LOG_ERR("failed to translate desc address.");
+			return -1;
+		}
+		assert(len == desc->len);
+		desc = desc_table;
+	} else {
+		desc_table = vq->vring.desc;
+	}
+
+	/* Walk through descriptor chain */
+	do {
+		if (iovs_idx >= num_iovs) {
+			RDMA_LOG_ERR("MAX_IOVS reached\n");
+			return -1;
+		}
+
+		if (desc->flags & VRING_DESC_F_WRITE) {
+			in++;  /* Descriptor allows write from device perspective (input) */
+		} else {
+			out++; /* Descriptor allows read (output) */
+		}
+
+		/* Translate payload (address + length) into iovec(s) */
+		if (desc_payload_to_iovs(mem, iovs, 
+							&iovs_idx, 
+							desc->addr, 
+							desc->len, 
+							num_iovs) != 0) {
+			RDMA_LOG_ERR("Failed to convert desc payload to iovs");
+			return -1;
+		}
+
+		/* Move to next descriptor in chain */
+		desc = vhost_rdma_vring_get_next_desc(desc_table, desc);
+	} while (desc != NULL);
+
+	*num_in = in;
+	*num_out = out;
+	return iovs_idx;
+}
+
+static int
+vhost_rdma_query_device(struct vhost_rdma_device *dev, CTRL_NO_CMD,
+			struct iovec *out)
+{
+	struct vhost_rdma_ack_query_device *rsp;
+
+	CHK_IOVEC(rsp, out);
+
+	rsp->max_mr_size = dev->attr.max_mr_size;
+	rsp->page_size_cap = dev->attr.page_size_cap;
+	rsp->max_qp_wr = dev->attr.max_qp_wr;
+	rsp->device_cap_flags = dev->attr.device_cap_flags;
+	rsp->max_send_sge = dev->attr.max_send_sge;
+	rsp->max_recv_sge = dev->attr.max_recv_sge;
+	rsp->max_sge_rd = dev->attr.max_sge_rd;
+	rsp->max_cqe = dev->attr.max_cqe;
+	rsp->max_mr = dev->attr.max_mr;
+	rsp->max_pd = dev->attr.max_pd;
+	rsp->max_qp_rd_atom = dev->attr.max_qp_rd_atom;
+	rsp->max_qp_init_rd_atom = dev->attr.max_qp_init_rd_atom;
+	rsp->max_ah = dev->attr.max_ah;
+	rsp->local_ca_ack_delay = dev->attr.local_ca_ack_delay;
+
+	return 0;
+}
+
+/* Command handler table declaration */
+struct {
+	int (*handler)(struct vhost_rdma_device *dev, struct iovec *in, struct iovec *out);
+	const char *name;  /* Name of the command (for logging) */
+} cmd_tbl[] = {
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_DEVICE, vhost_rdma_query_device),
+};
+
+/**
+ * @brief Main handler for control virtqueue events.
+ *
+ * Processes incoming requests from the control virtual queue. Waits for kick
+ * notification via eventfd, then processes available descriptor chains.
+ * Each chain contains a header followed by optional input/output data.
+ * Executes corresponding handler based on command ID.
+ *
+ * @param arg  Pointer to vhost_rdma_device instance.
+ */
+void
+vhost_rdma_handle_ctrl_vq(void *arg)
+{
+	struct vhost_rdma_device *dev = arg;
+	struct vhost_rdma_ctrl_hdr *hdr;
+	struct vhost_user_queue *ctrl_vq = &dev->rdma_vqs[0];
+	struct iovec data_iovs[4];		/* Fixed-size iovec buffer */
+	struct iovec *in_iovs, *out_iovs;
+	uint16_t desc_idx, num_in, num_out;
+	uint8_t *status;
+	int kick_fd, nbytes, i, in_len;
+
+	kick_fd = ctrl_vq->vring.kickfd;
+
+	/* Wait until we get a valid kick (notification) */
+	do {
+		uint64_t kick_data;
+		nbytes = eventfd_read(kick_fd, &kick_data);
+		if (nbytes < 0) {
+			if (errno == EINTR || errno == EWOULDBLOCK || errno == EAGAIN) {
+				continue;  /* Retry on transient errors */
+			}
+			RDMA_LOG_ERR("Failed to read kickfd of ctrl virtq: %s", strerror(errno));
+		}
+		break;
+	} while (1);
+
+	/* Process all available requests in the control queue */
+	while (vhost_rdma_vq_is_avail(ctrl_vq)) {
+		desc_idx = vhost_rdma_vq_get_desc_idx(ctrl_vq);
+		/* Build iovecs from descriptor chain */
+		if (setup_iovs_from_descs(dev->mem, ctrl_vq,
+								desc_idx, data_iovs, 4,
+								&num_in, &num_out) < 0) {
+			RDMA_LOG_ERR("read from desc failed");
+			break;
+		}
+		/* Split iovecs into output (device reads) and input (device writes) */
+		out_iovs = data_iovs;
+		in_iovs = &data_iovs[num_out];
+		in_len = 0;
+
+		/* Calculate total input data length */
+		for (i = 0; i < num_in; i++) {
+			in_len += in_iovs[i].iov_len;
+		}
+
+		/* First output iovec should contain the control header */
+		hdr = (struct vhost_rdma_ctrl_hdr *)out_iovs[0].iov_base;
+		status = (uint8_t *)in_iovs[0].iov_base;
+
+		/* Validate header size */
+		if (out_iovs[0].iov_len != sizeof(*hdr)) {
+			RDMA_LOG_ERR("invalid header");
+			*status = VIRTIO_NET_ERR;
+			goto pushq;
+		}
+
+		/* Check if command ID is within valid range */
+		if (hdr->cmd >= (sizeof(cmd_tbl) / sizeof(cmd_tbl[0]))) {
+			RDMA_LOG_ERR("unknown cmd %d", hdr->cmd);
+			*status = VIRTIO_NET_ERR;
+			goto pushq;
+		}
+
+		/* Dispatch command handler; set status based on result */
+		*status = (cmd_tbl[hdr->cmd].handler(dev,
+										num_out > 1 ? &out_iovs[1] : NULL,
+										num_in > 1 ? &in_iovs[1] : NULL) == 0)
+				  ? VIRTIO_NET_OK
+				  : VIRTIO_NET_ERR;
+
+pushq:
+		/* Log command execution result */
+		RDMA_LOG_INFO("cmd=%d %s status: %d",
+					hdr->cmd,
+					cmd_tbl[hdr->cmd].name ? cmd_tbl[hdr->cmd].name : "unknown",
+					*status);
+
+		/* Return used descriptor to the avail ring and notify frontend */
+		vhost_rdma_queue_push(ctrl_vq, desc_idx, in_len);
+		vhost_rdma_queue_notify(dev->vid, ctrl_vq);
+	}
+}
+
+int
+vhost_rdma_task_scheduler(void *arg)
+{
+	return 0;
+}
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.h b/examples/vhost_user_rdma/vhost_rdma_ib.h
new file mode 100644
index 0000000000..4ac896d82e
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.h
@@ -0,0 +1,710 @@
+/**
+ * @file vhost_rdma_ib.h
+ * @brief Vhost-user RDMA device: IB emulation layer and control path definitions.
+ *
+ * This header defines the internal data structures, constants, and function interfaces
+ * used by the vhost-user RDMA backend to emulate InfiniBand/RoCE semantics over virtio.
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __VHOST_RDMA_IB_H__
+#define __VHOST_RDMA_IB_H__
+
+#include <netinet/in.h>
+#include <linux/virtio_net.h>
+
+#include <rte_spinlock.h>
+#include <rte_atomic.h>
+#include <rte_timer.h>
+#include <rte_mbuf.h>
+#include <rte_ring.h>
+#include <rte_vhost.h>
+#include <linux/vhost_types.h>
+
+#include "eal_interrupts.h"
+
+/* Forward declarations */
+struct vhost_rdma_device;
+struct vhost_queue;
+
+/**
+ * @defgroup constants Constants & Limits
+ * @{
+ */
+
+/** Invalid opcode marker */
+#define OPCODE_NONE			(-1)
+
+/** Device capability flags */
+#define VIRTIO_IB_DEVICE_RC_RNR_NAK_GEN	(1 << 0)
+
+/** Maximum number of memory regions in vhost-user memory table */
+#define VHOST_USER_MEMORY_MAX_NREGIONS	8
+
+/** Maximum size for config space read/write operations */
+#define VHOST_USER_MAX_CONFIG_SIZE	256
+
+/** ROCE control command types (virtio-rdma extension) */
+#define VHOST_RDMA_CTRL_ROCE					6
+#define VHOST_RDMA_CTRL_ROCE_QUERY_DEVICE		0
+#define VHOST_RDMA_CTRL_ROCE_QUERY_PORT			1
+#define VHOST_RDMA_CTRL_ROCE_CREATE_CQ			2
+#define VHOST_RDMA_CTRL_ROCE_DESTROY_CQ			3
+#define VHOST_RDMA_CTRL_ROCE_CREATE_PD			4
+#define VHOST_RDMA_CTRL_ROCE_DESTROY_PD			5
+#define VHOST_RDMA_CTRL_ROCE_GET_DMA_MR			6
+#define VHOST_RDMA_CTRL_ROCE_ALLOC_MR			7
+#define VHOST_RDMA_CTRL_ROCE_REG_USER_MR		9
+#define VHOST_RDMA_CTRL_ROCE_MAP_MR_SG			8
+#define VHOST_RDMA_CTRL_ROCE_DEREG_MR			10
+#define VHOST_RDMA_CTRL_ROCE_CREATE_QP			11
+#define VHOST_RDMA_CTRL_ROCE_MODIFY_QP			12
+#define VHOST_RDMA_CTRL_ROCE_QUERY_QP			13
+#define VHOST_RDMA_CTRL_ROCE_DESTROY_QP			14
+#define VHOST_RDMA_CTRL_ROCE_QUERY_PKEY			15
+#define VHOST_RDMA_CTRL_ROCE_ADD_GID			16
+#define VHOST_RDMA_CTRL_ROCE_DEL_GID			17
+#define VHOST_RDMA_CTRL_ROCE_REQ_NOTIFY_CQ		18
+
+struct vhost_rdma_ack_query_device {
+#define VIRTIO_IB_DEVICE_RC_RNR_NAK_GEN	(1 << 0)
+		/* Capabilities mask */
+		uint64_t device_cap_flags;
+		/* Largest contiguous block that can be registered */
+		uint64_t max_mr_size;
+		/* Supported memory shift sizes */
+		uint64_t page_size_cap;
+		/* Hardware version */
+		uint32_t hw_ver;
+		/* Maximum number of outstanding Work Requests (WR) on Send Queue (SQ) and Receive Queue (RQ) */
+		uint32_t max_qp_wr;
+		/* Maximum number of scatter/gather (s/g) elements per WR for SQ for non RDMA Read operations */
+		uint32_t max_send_sge;
+		/* Maximum number of s/g elements per WR for RQ for non RDMA Read operations */
+		uint32_t max_recv_sge;
+		/* Maximum number of s/g per WR for RDMA Read operations */
+		uint32_t max_sge_rd;
+		/* Maximum size of Completion Queue (CQ) */
+		uint32_t max_cqe;
+		/* Maximum number of Memory Regions (MR) */
+		uint32_t max_mr;
+		/* Maximum number of Protection Domains (PD) */
+		uint32_t max_pd;
+		/* Maximum number of RDMA Read perations that can be outstanding per Queue Pair (QP) */
+		uint32_t max_qp_rd_atom;
+		/* Maximum depth per QP for initiation of RDMA Read operations */
+		uint32_t max_qp_init_rd_atom;
+		/* Maximum number of Address Handles (AH) */
+		uint32_t max_ah;
+		/* Local CA ack delay */
+		uint8_t local_ca_ack_delay;
+		/* Padding */
+		uint8_t padding[3];
+		/* Reserved for future */
+		uint32_t reserved[14];
+};
+
+
+/**
+ * @defgroup qp_states Queue Pair States
+ * @{
+ */
+enum vhost_rdma_ib_qp_state {
+	VHOST_RDMA_IB_QPS_RESET,
+	VHOST_RDMA_IB_QPS_INIT,
+	VHOST_RDMA_IB_QPS_RTR,
+	VHOST_RDMA_IB_QPS_RTS,
+	VHOST_RDMA_IB_QPS_SQD,
+	VHOST_RDMA_IB_QPS_SQE,
+	VHOST_RDMA_IB_QPS_ERR
+};
+/** @} */
+
+/**
+ * @defgroup mtu_sizes IB MTU Sizes
+ * @{
+ */
+enum vhost_rdma_ib_mtu {
+	VHOST_RDMA_IB_MTU_256	= 1,
+	VHOST_RDMA_IB_MTU_512	= 2,
+	VHOST_RDMA_IB_MTU_1024	= 3,
+	VHOST_RDMA_IB_MTU_2048	= 4,
+	VHOST_RDMA_IB_MTU_4096	= 5
+};
+/** @} */
+
+/**
+ * @defgroup wc_status Work Completion Status Codes
+ * @{
+ */
+enum vhost_rdma_ib_wc_status {
+	VHOST_RDMA_IB_WC_SUCCESS,
+	VHOST_RDMA_IB_WC_LOC_LEN_ERR,
+	VHOST_RDMA_IB_WC_LOC_QP_OP_ERR,
+	VHOST_RDMA_IB_WC_LOC_PROT_ERR,
+	VHOST_RDMA_IB_WC_WR_FLUSH_ERR,
+	VHOST_RDMA_IB_WC_BAD_RESP_ERR,
+	VHOST_RDMA_IB_WC_LOC_ACCESS_ERR,
+	VHOST_RDMA_IB_WC_REM_INV_REQ_ERR,
+	VHOST_RDMA_IB_WC_REM_ACCESS_ERR,
+	VHOST_RDMA_IB_WC_REM_OP_ERR,
+	VHOST_RDMA_IB_WC_RETRY_EXC_ERR,
+	VHOST_RDMA_IB_WC_RNR_RETRY_EXC_ERR,
+	VHOST_RDMA_IB_WC_REM_ABORT_ERR,
+	VHOST_RDMA_IB_WC_FATAL_ERR,
+	VHOST_RDMA_IB_WC_RESP_TIMEOUT_ERR,
+	VHOST_RDMA_IB_WC_GENERAL_ERR
+};
+/** @} */
+
+/**
+ * @defgroup res_state Responder Resource States
+ * @{
+ */
+enum vhost_rdma_res_state {
+	VHOST_RDMA_RES_STATE_NEXT,
+	VHOST_RDMA_RES_STATE_NEW,
+	VHOST_RDMA_RES_STATE_REPLAY,
+};
+/** @} */
+
+/**
+ * @defgroup vhost_user_requests Vhost-user Message Types
+ * @{
+ */
+enum vhost_user_rdma_request {
+	VHOST_USER_NONE = 0,
+	VHOST_USER_GET_FEATURES = 1,
+	VHOST_USER_SET_FEATURES = 2,
+	VHOST_USER_SET_OWNER = 3,
+	VHOST_USER_RESET_OWNER = 4,
+	VHOST_USER_SET_MEM_TABLE = 5,
+	VHOST_USER_SET_LOG_BASE = 6,
+	VHOST_USER_SET_LOG_FD = 7,
+	VHOST_USER_SET_VRING_NUM = 8,
+	VHOST_USER_SET_VRING_ADDR = 9,
+	VHOST_USER_SET_VRING_BASE = 10,
+	VHOST_USER_GET_VRING_BASE = 11,
+	VHOST_USER_SET_VRING_KICK = 12,
+	VHOST_USER_SET_VRING_CALL = 13,
+	VHOST_USER_SET_VRING_ERR = 14,
+	VHOST_USER_GET_PROTOCOL_FEATURES = 15,
+	VHOST_USER_SET_PROTOCOL_FEATURES = 16,
+	VHOST_USER_GET_QUEUE_NUM = 17,
+	VHOST_USER_SET_VRING_ENABLE = 18,
+	VHOST_USER_GET_CONFIG = 24,
+	VHOST_USER_SET_CONFIG = 25,
+	VHOST_USER_MAX
+};
+/** @} */
+
+/**
+ * @brief QP capabilities structure
+ */
+struct vhost_rdma_qp_cap {
+	uint32_t max_send_wr;			/**< Max work requests in send queue */
+	uint32_t max_send_sge;			/**< Max scatter-gather elements per send WR */
+	uint32_t max_recv_wr;			/**< Max work requests in receive queue */
+	uint32_t max_recv_sge;			/**< Max SGEs per receive WR */
+	uint32_t max_inline_data;		/**< Max inline data size supported */
+};
+
+/**
+ * @brief Global route attributes (used in AH/GRH)
+ */
+struct vhost_rdma_global_route {
+	uint8_t dgid[16];				/**< Destination GID or MGID */
+	uint32_t flow_label;			/**< IPv6-style flow label */
+	uint8_t sgid_index;				/**< Source GID table index */
+	uint8_t hop_limit;				/**< TTL/Hop Limit */
+	uint8_t traffic_class;			/**< Traffic class field */
+};
+
+/**
+ * @brief Address Handle (AH) attributes
+ */
+struct vhost_rdma_ah_attr {
+	struct vhost_rdma_global_route grh; /**< GRH fields */
+	uint8_t sl;							/**< Service Level */
+	uint8_t static_rate;				/**< Static rate (encoding) */
+	uint8_t port_num;					/**< Physical port number */
+	uint8_t ah_flags;					/**< Flags (e.g., GRH present) */
+	uint8_t dmac[6];					/**< Destination MAC address (for RoCE) */
+} __rte_packed;
+
+/**
+ * @brief Queue Pair attributes
+ */
+struct vhost_rdma_qp_attr {
+	enum vhost_rdma_ib_qp_state qp_state;		/**< Target QP state */
+	enum vhost_rdma_ib_qp_state cur_qp_state;	/**< Current QP state */
+	enum vhost_rdma_ib_mtu path_mtu;			/**< Path MTU */
+	uint32_t qkey;								/**< QKey for UD/RC */
+	uint32_t rq_psn;							/**< Receive PSN */
+	uint32_t sq_psn;							/**< Send PSN */
+	uint32_t dest_qp_num;						/**< Remote QPN */
+	uint32_t qp_access_flags;					/**< Access permissions */
+	uint8_t sq_draining;						/**< Is SQ draining? */
+	uint8_t max_rd_atomic;						/**< Max outstanding RDMA reads/atomics */
+	uint8_t max_dest_rd_atomic;					/**< Max at responder side */
+	uint8_t min_rnr_timer;						/**< Minimum RNR NAK timer value */
+	uint8_t timeout;							/**< Timeout exponent for ACKs */
+	uint8_t retry_cnt;							/**< Retry counter limit */
+	uint8_t rnr_retry;							/**< RNR retry count */
+	uint32_t rate_limit;						/**< Rate limit (Mb/s) */
+	struct vhost_rdma_qp_cap cap;				/**< QP capacity limits */
+	struct vhost_rdma_ah_attr ah_attr;			/**< AH attributes for RC/UC */
+};
+
+/**
+ * @brief Protection Domain (PD)
+ */
+struct vhost_rdma_pd {
+	struct vhost_rdma_device *dev;	/**< Backing device */
+	uint32_t pdn;					/**< PD identifier */
+	rte_atomic32_t refcnt;			/**< Reference count */
+};
+
+/**
+ * @brief Generic queue abstraction (used for SQ/RQ)
+ */
+struct vhost_rdma_queue {
+	struct vhost_user_queue *vq;	/**< Associated vhost vring */
+	void *data;						/**< Ring buffer base pointer */
+	size_t elem_size;				/**< Size of each element */
+	size_t num_elems;				/**< Number of elements */
+	uint16_t consumer_index;		/**< Consumer index (local) */
+	uint16_t producer_index;		/**< Producer index (from guest) */
+
+	struct rte_intr_handle intr_handle; /**< Interrupt handler */
+	rte_intr_callback_fn cb;		/**< Optional callback on kick */
+};
+
+/**
+ * @brief Padded memory region layout (fixed-size vhost_memory)
+ */
+struct vhost_memory_padded {
+	uint32_t nregions;				/**< Number of valid regions */
+	uint32_t padding;				/**< Alignment padding */
+	struct vhost_memory_region regions[VHOST_USER_MEMORY_MAX_NREGIONS];
+};
+
+/**
+ * @brief Configuration access payload
+ */
+struct vhost_user_rdma_config {
+	uint32_t offset;				/**< Offset in config space */
+	uint32_t size;					/**< Data size */
+	uint32_t flags;					/**< Reserved/flags */
+	uint8_t region[VHOST_USER_MAX_CONFIG_SIZE]; /**< Config data */
+};
+
+/**
+ * @brief Vhost-user RDMA message structure
+ */
+struct vhost_user_rdma_msg {
+	enum vhost_user_rdma_request request;
+
+#define VHOST_USER_VERSION_MASK		0x3
+#define VHOST_USER_REPLY_MASK		(0x1 << 2)
+	uint32_t flags;					/**< Version and reply flag */
+	uint32_t size;					/**< Payload size */
+
+	union {
+#define VHOST_USER_VRING_IDX_MASK	0xff
+#define VHOST_USER_VRING_NOFD_MASK	(0x1 << 8)
+		uint64_t u64;
+		struct vhost_vring_state state;
+		struct vhost_vring_addr addr;
+		struct vhost_memory_padded memory;
+		struct vhost_user_rdma_config cfg;
+	} payload;
+} __rte_packed;
+
+/**
+ * @brief Completion Queue (CQ)
+ */
+struct vhost_rdma_cq {
+	struct vhost_queue *vq;			/**< Notification V-ring */
+	rte_spinlock_t cq_lock;			/**< Protect CQ operations */
+	uint8_t notify;					/**< Notify pending flag */
+	bool is_dying;					/**< Being destroyed */
+
+	uint32_t cqn;					/**< CQ identifier */
+	rte_atomic32_t refcnt;			/**< Reference count */
+};
+
+/**
+ * @brief Send Queue (SQ) container
+ */
+struct vhost_rdma_sq {
+	rte_spinlock_t lock;			/**< Guard SQ access */
+	struct vhost_rdma_queue queue;	/**< Underlying ring */
+};
+
+/**
+ * @brief Receive Queue (RQ) container
+ */
+struct vhost_rdma_rq {
+	rte_spinlock_t lock;			/**< Guard RQ access */
+	struct vhost_rdma_queue queue;	/**< Underlying ring */
+};
+
+/**
+ * @brief Address Vector (AV) - cached routing info
+ */
+struct vhost_rdma_av {
+	uint8_t network_type;			/**< e.g., IPv4/IPv6/Ethernet */
+	uint8_t dmac[6];				/**< Destination MAC */
+	struct vhost_rdma_global_route grh; /**< GRH fields */
+
+	union {
+		struct sockaddr_in _sockaddr_in;
+		struct sockaddr_in6 _sockaddr_in6;
+	} sgid_addr, dgid_addr;			/**< GID resolution cache (optional) */
+};
+
+/**
+ * @brief Lightweight task abstraction with scheduling support
+ */
+struct vhost_rdma_task {
+	char name[8];					/**< Task name (debug) */
+	int state;						/**< Execution state */
+	bool destroyed;					/**< Marked for cleanup */
+	rte_atomic16_t sched;			/**< Scheduled flag */
+	rte_spinlock_t state_lock;		/**< Lock for state transitions */
+	struct rte_ring *task_ring;		/**< Work submission ring */
+
+	int (*func)(void *arg);			/**< Task function */
+	void *arg;						/**< Argument to func */
+	int ret;						/**< Return code */
+};
+
+/**
+ * @brief Requester-side operation tracking
+ */
+struct vhost_rdma_req_info {
+	enum vhost_rdma_ib_qp_state state;
+	int wqe_index;					/**< Current WQE index */
+	uint32_t psn;					/**< Packet Sequence Number */
+	int opcode;						/**< Operation type */
+	rte_atomic32_t rd_atomic;		/**< Outstanding RDMA read/atomic count */
+	int wait_fence;					/**< Fence required */
+	int need_rd_atomic;				/**< Need atomic resource */
+	int wait_psn;					/**< Waiting for PSN gap */
+	int need_retry;					/**< Should retry */
+	int noack_pkts;					/**< Packets sent without ACK */
+	struct vhost_rdma_task task;	/**< Retransmission task */
+};
+
+/**
+ * @brief Completer-side retry and retransmit context
+ */
+struct vhost_rdma_comp_info {
+	uint32_t psn;					/**< Last packet PSN */
+	int opcode;
+	int timeout;					/**< Timeout occurred */
+	int timeout_retry;
+	int started_retry;
+	uint32_t retry_cnt;
+	uint32_t rnr_retry;
+	struct vhost_rdma_task task;	/**< RNR/retry handling task */
+};
+
+/**
+ * @brief Scatter-Gather Element (SGE)
+ */
+struct vhost_rdma_sge {
+	__le64 addr;					/**< Guest virtual address */
+	__le32 length;					/**< Length in bytes */
+	__le32 lkey;					/**< Local key */
+};
+
+/**
+ * @brief DMA transfer context
+ */
+struct vhost_rdma_dma_info {
+	uint32_t length;				/**< Total transfer length */
+	uint32_t resid;					/**< Remaining bytes */
+	uint32_t cur_sge;				/**< Current SGE index */
+	uint32_t num_sge;				/**< Total SGE count */
+	uint32_t sge_offset;			/**< Offset within current SGE */
+	uint32_t reserved;
+	union {
+		uint8_t *inline_data;		/**< Inline data pointer */
+		struct vhost_rdma_sge *sge;	/**< SGE array */
+		void *raw;					/**< Generic pointer */
+	};
+};
+
+/**
+ * @brief Receive Work Queue Entry (WQE)
+ */
+struct vhost_rdma_recv_wqe {
+	__aligned_u64 wr_id;			/**< User-defined WR ID */
+	__u32 num_sge;
+	__u32 padding;
+	struct vhost_rdma_dma_info dma;	/**< DMA context */
+};
+
+/**
+ * @brief Memory Region (MR) types
+ */
+enum vhost_rdma_mr_type {
+	VHOST_MR_TYPE_NONE,
+	VHOST_MR_TYPE_DMA,
+	VHOST_MR_TYPE_MR,
+};
+
+/**
+ * @brief MR lifecycle states
+ */
+enum vhost_rdma_mr_state {
+	VHOST_MR_STATE_ZOMBIE,
+	VHOST_MR_STATE_INVALID,
+	VHOST_MR_STATE_FREE,
+	VHOST_MR_STATE_VALID,
+};
+
+/**
+ * @brief Memory Region (MR) object
+ */
+struct vhost_rdma_mr {
+	struct vhost_rdma_pd *pd;		/**< Owning PD */
+	enum vhost_rdma_mr_type type;	/**< Type of MR */
+	enum vhost_rdma_mr_state state;	/**< State machine */
+	uint64_t va;					/**< Virtual address (host VA) */
+	uint64_t iova;					/**< IOVA / virtual address in guest */
+	size_t length;					/**< Length of mapping */
+	uint32_t offset;				/**< Offset in page array */
+	int access;						/**< Access flags (e.g., LOCAL_WRITE) */
+
+	uint32_t lkey;					/**< Local key */
+	uint32_t rkey;					/**< Remote key */
+
+	uint32_t npages;				/**< Number of mapped pages */
+	uint32_t max_pages;				/**< Allocated page array size */
+	uint64_t *pages;				/**< Array of page addresses */
+
+	uint32_t mrn;					/**< MR identifier */
+	rte_atomic32_t refcnt;			/**< Reference counter */
+};
+
+/**
+ * @brief Responder resource (used for replay and ACK handling)
+ */
+struct vhost_rdma_resp_res {
+	int type;						/**< Resource type */
+	int replay;						/**< Is this a replay? */
+	uint32_t first_psn;
+	uint32_t last_psn;
+	uint32_t cur_psn;
+	enum vhost_rdma_res_state state;
+
+	union {
+		struct {
+			struct rte_mbuf *mbuf;	/**< Packet buffer */
+		} atomic;
+		struct {
+			struct vhost_rdma_mr *mr;
+			uint64_t va_org;		/**< Original VA */
+			uint32_t rkey;
+			uint32_t length;
+			uint64_t va;			/**< Current VA */
+			uint32_t resid;			/**< Residual length */
+		} read;
+	};
+};
+
+/**
+ * @brief Response processing context (responder side)
+ */
+struct vhost_rdma_resp_info {
+	enum vhost_rdma_ib_qp_state state;
+	uint32_t msn;					/**< Message sequence number */
+	uint32_t psn;					/**< Current PSN */
+	uint32_t ack_psn;				/**< Acknowledged PSN */
+	int opcode;
+	int drop_msg;					/**< Drop current message */
+	int goto_error;				 /**< Transition to error state */
+	int sent_psn_nak;				/**< Has sent NAK */
+	enum vhost_rdma_ib_wc_status status;
+	uint8_t aeth_syndrome;			/**< AETH error code */
+
+	/* Receive path only */
+	struct vhost_rdma_recv_wqe *wqe;
+
+	/* RDMA read / atomic operations */
+	uint64_t va;
+	uint64_t offset;
+	struct vhost_rdma_mr *mr;
+	uint32_t resid;
+	uint32_t rkey;
+	uint32_t length;
+	uint64_t atomic_orig;
+
+	/* Circular buffer of responder resources */
+	struct vhost_rdma_resp_res *resources;
+	unsigned int res_head;
+	unsigned int res_tail;
+	struct vhost_rdma_resp_res *res;
+
+	struct vhost_rdma_task task;	/**< Timeout/retry task */
+};
+
+/**
+ * @brief Queue Pair (QP)
+ */
+struct vhost_rdma_qp {
+	struct vhost_rdma_device *dev;	/**< Parent device */
+	struct vhost_rdma_qp_attr attr; /**< Current attributes */
+	uint32_t qpn;					/**< Queue Pair Number */
+	uint8_t type;					/**< QP type (RC/UC/UD) */
+	unsigned int valid;				/**< Is QP active? */
+	unsigned int mtu;				/**< Effective MTU in bytes */
+
+	struct vhost_rdma_pd *pd;		/**< Owning PD */
+	struct vhost_rdma_cq *scq;		/**< Send CQ */
+	struct vhost_rdma_cq *rcq;		/**< Receive CQ */
+
+	uint8_t sq_sig_all;				/**< Every send WQE signals completion */
+
+	struct vhost_rdma_sq sq;		/**< Send Queue */
+	struct vhost_rdma_rq rq;		/**< Receive Queue */
+	void *srq;						/**< Shared Receive Queue (reserved) */
+
+	uint32_t dst_cookie;			/**< Cookie from destination */
+	uint16_t src_port;				/**< Source UDP port (RoCE) */
+
+	struct vhost_rdma_av av;		/**< Cached path information */
+
+	struct rte_ring *req_pkts;		/**< Request packets ring (from guest) */
+	struct rte_mbuf *req_pkts_head; /**< Head for peeking packets */
+	struct rte_ring *resp_pkts;	 /**< Response packets ring (to guest) */
+
+	struct vhost_rdma_req_info req; /**< Requester context */
+	struct vhost_rdma_comp_info comp; /**< Completer context */
+	struct vhost_rdma_resp_info resp; /**< Responder context */
+
+	rte_atomic32_t ssn;			 /**< Send Sequence Number */
+	rte_atomic32_t mbuf_out;		/**< Number of mbufs in flight */
+	int need_req_mbuf;				/**< Need more mbufs for requests */
+
+	/* Retransmission timer (RC only) */
+	struct rte_timer retrans_timer;
+	uint64_t qp_timeout_ticks;
+
+	/* RNR NAK handling timer */
+	struct rte_timer rnr_nak_timer;
+
+	rte_spinlock_t state_lock;		/**< Protect state changes */
+	rte_atomic32_t refcnt;			/**< Reference count */
+};
+
+/**
+ * @brief User-space SGE (control path)
+ */
+struct vhost_user_rdma_sge {
+	uint64_t addr;					/**< Host/user virtual address */
+	uint32_t length;
+	uint32_t lkey;
+};
+
+struct vhost_rdma_ctrl_hdr {
+	uint8_t cmd;
+};
+
+/**
+ * @brief Convert IB MTU enum to byte size
+ * @param mtu The MTU enum value
+ * @return Byte size on success, -1 if invalid
+ */
+static inline int
+ib_mtu_enum_to_int(enum vhost_rdma_ib_mtu mtu)
+{
+	switch (mtu) {
+	case VHOST_RDMA_IB_MTU_256:  return  256;
+	case VHOST_RDMA_IB_MTU_512:  return  512;
+	case VHOST_RDMA_IB_MTU_1024: return 1024;
+	case VHOST_RDMA_IB_MTU_2048: return 2048;
+	case VHOST_RDMA_IB_MTU_4096: return 4096;
+	default:					 return -1;
+	}
+}
+
+/* Function declarations */
+
+/**
+ * @brief Initialize RDMA device's IB attributes and resource pools
+ * @param dev RDMA device instance
+ */
+void vhost_rdma_init_ib(struct vhost_rdma_device *dev);
+
+/**
+ * @brief Destroy all IB resources and release memory pools
+ * @param dev RDMA device instance
+ */
+void vhost_rdma_destroy_ib(struct vhost_rdma_device *dev);
+
+/**
+ * @brief Handle control virtqueue messages (device configuration)
+ * @param arg Pointer to device or thread context
+ */
+void vhost_rdma_handle_ctrl_vq(void *arg);
+
+/**
+ * @brief Main scheduler loop for RDMA tasks (retries, timeouts)
+ * @param arg Device context
+ * @return 0 on exit
+ */
+int vhost_rdma_task_scheduler(void *arg);
+
+/**
+ * @brief Cleanup callback for MR pool objects
+ * @param arg Pointer to struct vhost_rdma_mr
+ */
+void vhost_rdma_mr_cleanup(void *arg);
+
+/**
+ * @brief Cleanup callback for QP pool objects
+ * @param arg Pointer to struct vhost_rdma_qp
+ */
+void vhost_rdma_qp_cleanup(void *arg);
+
+/**
+ * @brief Clean up a vhost_rdma_queue (drain rings, unregister interrupts)
+ * @param qp Owning QP
+ * @param queue Queue to clean
+ */
+void vhost_rdma_queue_cleanup(struct vhost_rdma_qp *qp, struct vhost_rdma_queue *queue);
+
+/**
+ * @brief Release one RDMA read/atomic responder resource
+ * @param qp QP owning the resource
+ * @param res Resource to free
+ */
+void free_rd_atomic_resource(struct vhost_rdma_qp *qp, struct vhost_rdma_resp_res *res);
+
+/**
+ * @brief Release all RDMA read/atomic responder resources
+ * @param qp QP whose resources to free
+ */
+void free_rd_atomic_resources(struct vhost_rdma_qp *qp);
+
+int setup_iovs_from_descs(struct rte_vhost_memory *mem,
+						struct vhost_user_queue *vq,
+						uint16_t req_idx,
+						struct iovec *iovs,
+						uint16_t num_iovs,
+						uint16_t *num_in,
+						uint16_t *num_out);
+
+#endif /* __VHOST_RDMA_IB_H__ */
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_log.h b/examples/vhost_user_rdma/vhost_rdma_log.h
new file mode 100644
index 0000000000..dfb4d1adae
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_log.h
@@ -0,0 +1,52 @@
+/*
+ * Vhost-user RDMA device : init and packets forwarding
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __VHOST_RDMA_LOG_H__
+#define __VHOST_RDMA_LOG_H__
+
+#include <rte_log.h>
+
+#define RTE_LOGTYPE_VHOST_CONFIG RTE_LOGTYPE_USER2
+#define RTE_LOGTYPE_ETHER RTE_LOGTYPE_USER3
+#define RTE_LOGTYPE_RDMA RTE_LOGTYPE_USER1
+
+#define LOG_DEBUG_DP(f, ...) RTE_LOG_DP(DEBUG, ETHER, f "\n", ##__VA_ARGS__)
+#define LOG_INFO_DP(f, ...) RTE_LOG_DP(INFO, ETHER, f "\n", ##__VA_ARGS__)
+#define LOG_WARN_DP(f, ...) RTE_LOG_DP(WARNING, ETHER, f "\n", ##__VA_ARGS__)
+#define LOG_ERR_DP(f, ...) RTE_LOG_DP(ERR, ETHER, f "\n", ##__VA_ARGS__)
+
+#define LOG_DEBUG(f, ...) RTE_LOG(DEBUG, ETHER, f "\n", ##__VA_ARGS__)
+#define LOG_INFO(f, ...) RTE_LOG(INFO, ETHER, f "\n", ##__VA_ARGS__)
+#define LOG_WARN(f, ...) RTE_LOG(WARNING, ETHER, f "\n", ##__VA_ARGS__)
+#define LOG_ERR(f, ...) RTE_LOG(ERR, ETHER, f "\n", ##__VA_ARGS__)
+
+#define RDMA_LOG_DEBUG(f, ...) RTE_LOG(DEBUG, RDMA, "[ %s ]: " f "\n", __func__, ##__VA_ARGS__)
+#define RDMA_LOG_INFO(f, ...) RTE_LOG(INFO, RDMA, "[ %s ]: " f "\n", __func__, ##__VA_ARGS__)
+#define RDMA_LOG_ERR(f, ...) RTE_LOG(ERR, RDMA, "[ %s ]: " f "\n", __func__, ##__VA_ARGS__)
+
+#ifdef DEBUG_RDMA_DP
+#define RDMA_LOG_DEBUG_DP(f, ...) RTE_LOG(DEBUG, RDMA, "[%u] " f "\n", \
+					rte_lcore_id(), ##__VA_ARGS__)
+#define RDMA_LOG_INFO_DP(f, ...) RTE_LOG(INFO, RDMA, "[%u] " f "\n", \
+					rte_lcore_id(), ##__VA_ARGS__)
+#define RDMA_LOG_ERR_DP(f, ...) RTE_LOG(ERR, RDMA, "[%u] " f "\n", \
+					rte_lcore_id(), ##__VA_ARGS__)
+#else
+#define RDMA_LOG_DEBUG_DP(f, ...) RTE_LOG_DP(DEBUG, RDMA, "[%u] " f "\n", \
+						rte_lcore_id(), ##__VA_ARGS__)
+#define RDMA_LOG_INFO_DP(f, ...) RTE_LOG_DP(INFO, RDMA, "[%u] " f "\n", \
+						rte_lcore_id(), ##__VA_ARGS__)
+#define RDMA_LOG_ERR_DP(f, ...) RTE_LOG_DP(ERR, RDMA, "[%u] " f "\n", \
+						rte_lcore_id(), ##__VA_ARGS__)
+#endif
+
+#endif
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_pkt.h b/examples/vhost_user_rdma/vhost_rdma_pkt.h
new file mode 100644
index 0000000000..2bbc030e0a
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_pkt.h
@@ -0,0 +1,296 @@
+/**
+ * @file vhost_rdma_pkt.h
+ * @brief Vhost-user RDMA packet format and opcode definitions.
+ *
+ * This header defines the internal packet representation, InfiniBand/RoCE header layout,
+ * opcode mapping, and control flags used during packet parsing and transmission
+ * in the vhost-user RDMA backend.
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __VHOST_RDMA_PKT_H__
+#define __VHOST_RDMA_PKT_H__
+
+#include <stdint.h>
+#include <stddef.h>
+
+#include <rte_byteorder.h>
+#include <rte_mbuf.h> /* For struct rte_mbuf if needed later */
+
+/* Forward declarations */
+struct vhost_rdma_dev;
+struct vhost_rdma_qp;
+struct vhost_rdma_send_wqe;
+
+#ifndef BIT
+#define BIT(x) (1U << (x))	/**< Generate bitmask from bit index */
+#endif
+
+/**
+ * @defgroup constants Constants & Limits
+ * @{
+ */
+
+/** Maximum number of QP types supported for WR mask dispatching */
+#define WR_MAX_QPT					8
+
+/** Invalid opcode marker */
+#define OPCODE_NONE					(-1)
+
+/** Total number of defined opcodes (must be power-of-2 >= 256) */
+#define VHOST_NUM_OPCODE			256
+
+/** @} */
+
+/**
+ * @defgroup wr_masks Work Request Type Masks
+ * @{
+ */
+enum vhost_rdma_wr_mask {
+	WR_INLINE_MASK				= BIT(0),	 /**< WR contains inline data */
+	WR_ATOMIC_MASK				= BIT(1),	 /**< WR is an atomic operation */
+	WR_SEND_MASK				= BIT(2),	 /**< WR is a send-type operation */
+	WR_READ_MASK				= BIT(3),	 /**< WR initiates RDMA read */
+	WR_WRITE_MASK				= BIT(4),	 /**< WR performs RDMA write */
+	WR_LOCAL_OP_MASK			= BIT(5),	 /**< WR triggers local memory op */
+
+	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
+	WR_READ_WRITE_OR_SEND_MASK	= WR_READ_OR_WRITE_MASK | WR_SEND_MASK,
+	WR_WRITE_OR_SEND_MASK		= WR_WRITE_MASK | WR_SEND_MASK,
+	WR_ATOMIC_OR_READ_MASK		= WR_ATOMIC_MASK | WR_READ_MASK,
+};
+/** @} */
+
+/**
+ * @brief Metadata about each Work Request (WR) opcode
+ *
+ * Used to determine which operations are valid per QP type.
+ */
+struct vhost_rdma_wr_opcode_info {
+	const char *name;							/**< Human-readable name */
+	enum vhost_rdma_wr_mask mask[WR_MAX_QPT];	/**< Validity per QP type */
+};
+
+/* Extern declaration of global opcode metadata table */
+extern struct vhost_rdma_wr_opcode_info vhost_rdma_wr_opcode_info[];
+
+/**
+ * @defgroup hdr_types Header Types (for offset tracking)
+ * @{
+ */
+enum vhost_rdma_hdr_type {
+	VHOST_RDMA_LRH,			/**< Link Layer Header (InfiniBand only) */
+	VHOST_RDMA_GRH,			/**< Global Route Header (IPv6-style GIDs) */
+	VHOST_RDMA_BTH,			/**< Base Transport Header */
+	VHOST_RDMA_RETH,		/**< RDMA Extended Transport Header */
+	VHOST_RDMA_AETH,		/**< Acknowledge/Error Header */
+	VHOST_RDMA_ATMETH,		/**< Atomic Operation Request Header */
+	VHOST_RDMA_ATMACK,		/**< Atomic Operation Response Header */
+	VHOST_RDMA_IETH,		/**< Immediate Data + Error Code Header */
+	VHOST_RDMA_RDETH,		/**< Reliable Datagram Extended Transport Header */
+	VHOST_RDMA_DETH,		/**< Datagram Endpoint Identifier Header */
+	VHOST_RDMA_IMMDT,		/**< Immediate Data Header */
+	VHOST_RDMA_PAYLOAD,		/**< Payload section */
+	NUM_HDR_TYPES			/**< Number of known header types */
+};
+/** @} */
+
+/**
+ * @defgroup hdr_masks Header Presence and Semantic Flags
+ * @{
+ */
+enum vhost_rdma_hdr_mask {
+	VHOST_LRH_MASK			= BIT(VHOST_RDMA_LRH),
+	VHOST_GRH_MASK			= BIT(VHOST_RDMA_GRH),
+	VHOST_BTH_MASK			= BIT(VHOST_RDMA_BTH),
+	VHOST_IMMDT_MASK		= BIT(VHOST_RDMA_IMMDT),
+	VHOST_RETH_MASK			= BIT(VHOST_RDMA_RETH),
+	VHOST_AETH_MASK			= BIT(VHOST_RDMA_AETH),
+	VHOST_ATMETH_MASK		= BIT(VHOST_RDMA_ATMETH),
+	VHOST_ATMACK_MASK		= BIT(VHOST_RDMA_ATMACK),
+	VHOST_IETH_MASK			= BIT(VHOST_RDMA_IETH),
+	VHOST_RDETH_MASK		= BIT(VHOST_RDMA_RDETH),
+	VHOST_DETH_MASK			= BIT(VHOST_RDMA_DETH),
+	VHOST_PAYLOAD_MASK		= BIT(VHOST_RDMA_PAYLOAD),
+
+	/* Semantic packet type flags */
+	VHOST_REQ_MASK			= BIT(NUM_HDR_TYPES + 0),	/**< Request packet */
+	VHOST_ACK_MASK			= BIT(NUM_HDR_TYPES + 1),	/**< ACK/NACK packet */
+	VHOST_SEND_MASK			= BIT(NUM_HDR_TYPES + 2),	/**< Send operation */
+	VHOST_WRITE_MASK		= BIT(NUM_HDR_TYPES + 3),	/**< RDMA Write */
+	VHOST_READ_MASK			= BIT(NUM_HDR_TYPES + 4),	/**< RDMA Read */
+	VHOST_ATOMIC_MASK		= BIT(NUM_HDR_TYPES + 5),	/**< Atomic operation */
+
+	/* Packet fragmentation flags */
+	VHOST_RWR_MASK			= BIT(NUM_HDR_TYPES + 6),	/**< RDMA with Immediate + Invalidate */
+	VHOST_COMP_MASK			= BIT(NUM_HDR_TYPES + 7),	/**< Completion required */
+
+	VHOST_START_MASK		= BIT(NUM_HDR_TYPES + 8),	/**< First fragment */
+	VHOST_MIDDLE_MASK		= BIT(NUM_HDR_TYPES + 9),	/**< Middle fragment */
+	VHOST_END_MASK			= BIT(NUM_HDR_TYPES + 10), /**< Last fragment */
+
+	VHOST_LOOPBACK_MASK		= BIT(NUM_HDR_TYPES + 12), /**< Loopback within host */
+
+	/* Composite masks */
+	VHOST_READ_OR_ATOMIC	= (VHOST_READ_MASK | VHOST_ATOMIC_MASK),
+	VHOST_WRITE_OR_SEND		= (VHOST_WRITE_MASK | VHOST_SEND_MASK),
+};
+/** @} */
+
+/**
+ * @brief Per-opcode metadata for parsing and validation
+ */
+struct vhost_rdma_opcode_info {
+	const char *name;							/**< Opcode name (e.g., "RC SEND_FIRST") */
+	int length;									/**< Fixed payload length (if any) */
+	int offset[NUM_HDR_TYPES];					/**< Offset of each header within packet */
+	enum vhost_rdma_hdr_mask mask;				/**< Header presence and semantic flags */
+};
+
+/* Global opcode info table (indexed by IB opcode byte) */
+extern struct vhost_rdma_opcode_info vhost_rdma_opcode[VHOST_NUM_OPCODE];
+
+/**
+ * @brief Helper macro to define IB opcodes by transport and operation
+ *
+ * Expands to e.g.: `IB_OPCODE_RC_SEND_FIRST = IB_OPCODE_RC + IB_OPCODE_SEND_FIRST`
+ */
+#define IB_OPCODE(transport, op) \
+	IB_OPCODE_ ## transport ## _ ## op = \
+		(IB_OPCODE_ ## transport + IB_OPCODE_ ## op)
+
+/**
+ * @defgroup ib_opcodes InfiniBand OpCode Definitions
+ *
+ * Based on IBTA Vol 1 Table 38 and extended for RoCE semantics.
+ * @{
+ */
+
+enum {
+	/* Transport types (base values) */
+	IB_OPCODE_RC								= 0x00,	/**< Reliable Connection */
+	IB_OPCODE_UC								= 0x20,	/**< Unreliable Connection */
+	IB_OPCODE_RD								= 0x40,	/**< Reliable Datagram */
+	IB_OPCODE_UD								= 0x60,	/**< Unreliable Datagram */
+	IB_OPCODE_CNP								= 0x80,	/**< Congestion Notification Packet */
+	IB_OPCODE_MSP								= 0xe0,	/**< Manufacturer Specific Protocol */
+
+	/* Operation subtypes */
+	IB_OPCODE_SEND_FIRST						= 0x00,
+	IB_OPCODE_SEND_MIDDLE						= 0x01,
+	IB_OPCODE_SEND_LAST							= 0x02,
+	IB_OPCODE_SEND_LAST_WITH_IMMEDIATE			= 0x03,
+	IB_OPCODE_SEND_ONLY							= 0x04,
+	IB_OPCODE_SEND_ONLY_WITH_IMMEDIATE			= 0x05,
+	IB_OPCODE_RDMA_WRITE_FIRST					= 0x06,
+	IB_OPCODE_RDMA_WRITE_MIDDLE					= 0x07,
+	IB_OPCODE_RDMA_WRITE_LAST					= 0x08,
+	IB_OPCODE_RDMA_WRITE_LAST_WITH_IMMEDIATE	= 0x09,
+	IB_OPCODE_RDMA_WRITE_ONLY					= 0x0a,
+	IB_OPCODE_RDMA_WRITE_ONLY_WITH_IMMEDIATE	= 0x0b,
+	IB_OPCODE_RDMA_READ_REQUEST					= 0x0c,
+	IB_OPCODE_RDMA_READ_RESPONSE_FIRST			= 0x0d,
+	IB_OPCODE_RDMA_READ_RESPONSE_MIDDLE			= 0x0e,
+	IB_OPCODE_RDMA_READ_RESPONSE_LAST			= 0x0f,
+	IB_OPCODE_RDMA_READ_RESPONSE_ONLY			= 0x10,
+	IB_OPCODE_ACKNOWLEDGE						= 0x11,
+	IB_OPCODE_ATOMIC_ACKNOWLEDGE				= 0x12,
+	IB_OPCODE_COMPARE_SWAP						= 0x13,
+	IB_OPCODE_FETCH_ADD							= 0x14,
+	/* 0x15 is reserved */
+	IB_OPCODE_SEND_LAST_WITH_INVALIDATE			= 0x16,
+	IB_OPCODE_SEND_ONLY_WITH_INVALIDATE			= 0x17,
+
+	/* Real opcodes generated via IB_OPCODE() macro */
+	IB_OPCODE(RC, SEND_FIRST),
+	IB_OPCODE(RC, SEND_MIDDLE),
+	IB_OPCODE(RC, SEND_LAST),
+	IB_OPCODE(RC, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RC, SEND_ONLY),
+	IB_OPCODE(RC, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RC, RDMA_WRITE_FIRST),
+	IB_OPCODE(RC, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(RC, RDMA_WRITE_LAST),
+	IB_OPCODE(RC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RC, RDMA_WRITE_ONLY),
+	IB_OPCODE(RC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RC, RDMA_READ_REQUEST),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_FIRST),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_MIDDLE),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_LAST),
+	IB_OPCODE(RC, RDMA_READ_RESPONSE_ONLY),
+	IB_OPCODE(RC, ACKNOWLEDGE),
+	IB_OPCODE(RC, ATOMIC_ACKNOWLEDGE),
+	IB_OPCODE(RC, COMPARE_SWAP),
+	IB_OPCODE(RC, FETCH_ADD),
+	IB_OPCODE(RC, SEND_LAST_WITH_INVALIDATE),
+	IB_OPCODE(RC, SEND_ONLY_WITH_INVALIDATE),
+
+	/* UC opcodes */
+	IB_OPCODE(UC, SEND_FIRST),
+	IB_OPCODE(UC, SEND_MIDDLE),
+	IB_OPCODE(UC, SEND_LAST),
+	IB_OPCODE(UC, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(UC, SEND_ONLY),
+	IB_OPCODE(UC, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(UC, RDMA_WRITE_FIRST),
+	IB_OPCODE(UC, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(UC, RDMA_WRITE_LAST),
+	IB_OPCODE(UC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(UC, RDMA_WRITE_ONLY),
+	IB_OPCODE(UC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+
+	/* RD opcodes */
+	IB_OPCODE(RD, SEND_FIRST),
+	IB_OPCODE(RD, SEND_MIDDLE),
+	IB_OPCODE(RD, SEND_LAST),
+	IB_OPCODE(RD, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RD, SEND_ONLY),
+	IB_OPCODE(RD, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RD, RDMA_WRITE_FIRST),
+	IB_OPCODE(RD, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(RD, RDMA_WRITE_LAST),
+	IB_OPCODE(RD, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(RD, RDMA_WRITE_ONLY),
+	IB_OPCODE(RD, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(RD, RDMA_READ_REQUEST),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_FIRST),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_MIDDLE),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_LAST),
+	IB_OPCODE(RD, RDMA_READ_RESPONSE_ONLY),
+	IB_OPCODE(RD, ACKNOWLEDGE),
+	IB_OPCODE(RD, ATOMIC_ACKNOWLEDGE),
+	IB_OPCODE(RD, COMPARE_SWAP),
+	IB_OPCODE(RD, FETCH_ADD),
+
+	/* UD opcodes */
+	IB_OPCODE(UD, SEND_ONLY),
+	IB_OPCODE(UD, SEND_ONLY_WITH_IMMEDIATE)
+};
+/** @} */
+
+/**
+ * @brief Runtime packet context used during processing
+ */
+struct vhost_rdma_pkt_info {
+	struct vhost_rdma_dev		*dev;			/**< Owning device */
+	struct vhost_rdma_qp		*qp;			/**< Associated QP */
+	struct vhost_rdma_send_wqe	*wqe;			/**< Corresponding send WQE (if applicable) */
+	uint8_t						*hdr;			/**< Pointer to BTH (Base Transport Header) */
+	uint32_t					mask;			/**< Semantic flags (from vhost_rdma_hdr_mask) */
+	uint32_t					psn;			/**< Packet Sequence Number from BTH */
+	uint16_t					pkey_index;		/**< Partition key index */
+	uint16_t					paylen;			/**< Payload length (BTH to ICRC) */
+	uint8_t						port_num;		/**< Port this packet was received on */
+	uint8_t						opcode;			/**< BTH opcode field */
+};
+
+#endif /* __VHOST_RDMA_PKT_H__ */
\ No newline at end of file
-- 
2.43.0


