Return-Path: <netdev+bounces-26425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86244777BBE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DFB1C20B11
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB8E20CB4;
	Thu, 10 Aug 2023 15:06:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3419214ED
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:06:44 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C2826BD
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:06:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 1BD972187D;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691680001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7Mf7IlyvTZvr7wlKReG/EoCUWD/Gk7IxpEQlIaV9SU=;
	b=cGTbvm5PeL3KCLfgli331SVOD2aIia8MfO+DXd8ShYpaufKf4ldamg3606S1+yhHY0dsba
	UC8XyclGzthcHzHvaKpBoFc1oWekwQtUoFxHB2BrKBjTbOkih0NVlk3kTxwLiPMpOMTEBv
	KrA/8he4lvta6JwoROV86f0gaS6CCUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691680001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7Mf7IlyvTZvr7wlKReG/EoCUWD/Gk7IxpEQlIaV9SU=;
	b=bY6QEYV9Rtgy8nrFe54GkoakVE4au3ZuXAiwlIj7QqvanjywXhZGCKsuuD2yiBsgaHvaD9
	coD9KJNydLBIBZDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 065B12C165;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5246651CAE5C; Thu, 10 Aug 2023 17:06:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/17] nvmet-tcp: enable TLS handshake upcall
Date: Thu, 10 Aug 2023 17:06:29 +0200
Message-Id: <20230810150630.134991-17-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810150630.134991-1-hare@suse.de>
References: <20230810150630.134991-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add functions to start the TLS handshake upcall when
the TCP TSAS sectype is set to 'tls1.3' and add a config
option NVME_TARGET_TCP_TLS.
And move the 'state' lock to an irq-safe lock as the 'done'
callback from the TLS handshake will be running in interrupt
context.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/Kconfig    |  15 ++++
 drivers/nvme/target/configfs.c |  21 +++++
 drivers/nvme/target/nvmet.h    |   1 +
 drivers/nvme/target/tcp.c      | 140 ++++++++++++++++++++++++++++++++-
 4 files changed, 174 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 79fc64035ee3..8a6c9cae804c 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -84,6 +84,21 @@ config NVME_TARGET_TCP
 
 	  If unsure, say N.
 
+config NVME_TARGET_TCP_TLS
+	bool "NVMe over Fabrics TCP target TLS encryption support"
+	depends on NVME_TARGET_TCP
+	select NVME_COMMON
+	select NVME_KEYRING
+	select NET_HANDSHAKE
+	select KEYS
+	help
+	  Enables TLS encryption for the NVMe TCP target using the netlink handshake API.
+
+	  The TLS handshake daemon is availble at
+	  https://github.com/oracle/ktls-utils.
+
+	  If unsure, say N.
+
 config NVME_TARGET_AUTH
 	bool "NVMe over Fabrics In-band Authentication support"
 	depends on NVME_TARGET
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index eef01370ff40..13f6629481b2 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -15,6 +15,7 @@
 #ifdef CONFIG_NVME_TARGET_AUTH
 #include <linux/nvme-auth.h>
 #endif
+#include <linux/nvme-keyring.h>
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
 
@@ -402,6 +403,17 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 	return -EINVAL;
 
 found:
+	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
+		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
+			pr_err("TLS is not supported\n");
+			return -EINVAL;
+		}
+		if (!port->keyring) {
+			pr_err("TLS keyring not configured\n");
+			return -EINVAL;
+		}
+	}
+
 	nvmet_port_init_tsas_tcp(port, sectype);
 	/*
 	 * The TLS implementation currently does not support
@@ -1820,6 +1832,7 @@ static void nvmet_port_release(struct config_item *item)
 	flush_workqueue(nvmet_wq);
 	list_del(&port->global_entry);
 
+	key_put(port->keyring);
 	kfree(port->ana_state);
 	kfree(port);
 }
@@ -1869,6 +1882,14 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (nvme_keyring_id()) {
+		port->keyring = key_lookup(nvme_keyring_id());
+		if (IS_ERR(port->keyring)) {
+			pr_warn("NVMe keyring not available, disabling TLS\n");
+			port->keyring = NULL;
+		}
+	}
+
 	for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
 		if (i == NVMET_DEFAULT_ANA_GRPID)
 			port->ana_state[1] = NVME_ANA_OPTIMIZED;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8cfd60f3b564..7f9ae53c1df5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -158,6 +158,7 @@ struct nvmet_port {
 	struct config_group		ana_groups_group;
 	struct nvmet_ana_group		ana_default_group;
 	enum nvme_ana_state		*ana_state;
+	struct key			*keyring;
 	void				*priv;
 	bool				enabled;
 	int				inline_data_size;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a79ede885865..6eebc1157900 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -8,9 +8,13 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/key.h>
 #include <linux/nvme-tcp.h>
+#include <linux/nvme-keyring.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <net/tls.h>
+#include <net/handshake.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
 #include <crypto/hash.h>
@@ -66,6 +70,16 @@ device_param_cb(idle_poll_period_usecs, &set_param_ops,
 MODULE_PARM_DESC(idle_poll_period_usecs,
 		"nvmet tcp io_work poll till idle time period in usecs: Default 0");
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+/*
+ * TLS handshake timeout
+ */
+static int tls_handshake_timeout = 10;
+module_param(tls_handshake_timeout, int, 0644);
+MODULE_PARM_DESC(tls_handshake_timeout,
+		 "nvme TLS handshake timeout in seconds (default 10)");
+#endif
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
@@ -122,6 +136,7 @@ struct nvmet_tcp_cmd {
 
 enum nvmet_tcp_queue_state {
 	NVMET_TCP_Q_CONNECTING,
+	NVMET_TCP_Q_TLS_HANDSHAKE,
 	NVMET_TCP_Q_LIVE,
 	NVMET_TCP_Q_DISCONNECTING,
 };
@@ -156,6 +171,10 @@ struct nvmet_tcp_queue {
 	struct ahash_request	*snd_hash;
 	struct ahash_request	*rcv_hash;
 
+	/* TLS state */
+	key_serial_t		tls_pskid;
+	struct delayed_work	tls_handshake_work;
+
 	unsigned long           poll_end;
 
 	spinlock_t		state_lock;
@@ -195,6 +214,7 @@ static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue);
 static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue);
+static void nvmet_tcp_data_ready(struct sock *sk);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -1289,7 +1309,8 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 {
 	spin_lock_bh(&queue->state_lock);
-	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
+	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE &&
+	    queue->state != NVMET_TCP_Q_DISCONNECTING) {
 		queue->state = NVMET_TCP_Q_DISCONNECTING;
 		queue_work(nvmet_wq, &queue->release_work);
 	}
@@ -1546,7 +1567,11 @@ static void nvmet_tcp_data_ready(struct sock *sk)
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(nvmet_tcp_get_queue(queue))) {
-		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		if (queue->data_ready)
+			queue->data_ready(sk);
+		if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
+			queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
+				      &queue->io_work);
 		nvmet_tcp_put_queue(queue);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -1659,6 +1684,91 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	return ret;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static void nvmet_tcp_tls_handshake_done(void *data, int status,
+					 key_serial_t peerid)
+{
+	struct nvmet_tcp_queue *queue = data;
+
+	pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
+		 queue->idx, peerid, status);
+	spin_lock_bh(&queue->state_lock);
+	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+		pr_warn("queue %d: TLS handshake already completed\n",
+			queue->idx);
+		spin_unlock_bh(&queue->state_lock);
+		/*
+		 * Do not decrease the refcount here, as we only
+		 * take a single reference in nvmet_tcp_tls_handshake()
+		 */
+		return;
+	}
+	if (!status)
+		queue->tls_pskid = peerid;
+	queue->state = NVMET_TCP_Q_CONNECTING;
+	spin_unlock_bh(&queue->state_lock);
+
+	cancel_delayed_work_sync(&queue->tls_handshake_work);
+	if (status) {
+		pr_debug("queue %d: TLS handshake error %d, resetting\n",
+			 queue->idx, status);
+		nvmet_tcp_schedule_release_queue(queue);
+		nvmet_tcp_put_queue(queue);
+		return;
+	}
+
+	pr_debug("queue %d: resetting queue callbacks after TLS handshake\n",
+		 queue->idx);
+	nvmet_tcp_set_queue_sock(queue);
+	nvmet_tcp_put_queue(queue);
+}
+
+static void nvmet_tcp_tls_handshake_timeout_work(struct work_struct *w)
+{
+	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
+			struct nvmet_tcp_queue, tls_handshake_work);
+
+	pr_debug("queue %d: TLS handshake timeout\n", queue->idx);
+	nvmet_tcp_tls_handshake_done((void *)queue, -ETIMEDOUT, 0);
+}
+
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
+{
+	int ret = -EOPNOTSUPP;
+	struct tls_handshake_args args;
+
+	if (!nvmet_tcp_get_queue(queue)) {
+		pr_warn("queue %d: cannot start TLS, queue freed\n", queue->idx);
+		return -EINVAL;
+	}
+	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+		pr_warn("queue %d: cannot start TLS in state %d\n",
+			queue->idx, queue->state);
+		nvmet_tcp_put_queue(queue);
+		return -EINVAL;
+	}
+
+	pr_debug("queue %d: TLS ServerHello\n", queue->idx);
+	memset(&args, 0, sizeof(args));
+	args.ta_sock = queue->sock;
+	args.ta_done = nvmet_tcp_tls_handshake_done;
+	args.ta_data = queue;
+	args.ta_keyring = key_serial(queue->port->nport->keyring);
+	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+
+	ret = tls_server_hello_psk(&args, GFP_KERNEL);
+	if (ret) {
+		pr_err("queue %d: failed to start TLS, err=%d\n",
+		       queue->idx, ret);
+		nvmet_tcp_put_queue(queue);
+	} else {
+		queue_delayed_work(nvmet_wq, &queue->tls_handshake_work,
+				   tls_handshake_timeout * HZ);
+	}
+	return ret;
+}
+#endif
+
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1677,7 +1787,11 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	queue->port = port;
 	queue->nr_cmds = 0;
 	spin_lock_init(&queue->state_lock);
-	queue->state = NVMET_TCP_Q_CONNECTING;
+	if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
+	    NVMF_TCP_SECTYPE_TLS13)
+		queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+	else
+		queue->state = NVMET_TCP_Q_CONNECTING;
 	INIT_LIST_HEAD(&queue->free_list);
 	init_llist_head(&queue->resp_list);
 	INIT_LIST_HEAD(&queue->resp_send_list);
@@ -1708,10 +1822,30 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	INIT_DELAYED_WORK(&queue->tls_handshake_work,
+			  nvmet_tcp_tls_handshake_timeout_work);
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		struct sock *sk = queue->sock->sk;
+
+		/* Restore the default callbacks before starting upcall */
+		read_lock_bh(&sk->sk_callback_lock);
+		sk->sk_user_data = NULL;
+		sk->sk_data_ready = port->data_ready;
+		read_unlock_bh(&sk->sk_callback_lock);
+		if (!nvmet_tcp_tls_handshake(queue))
+			return;
+
+		/* TLS handshake failed, terminate the connection */
+		goto out_destroy_sq;
+	}
+#endif
+
 	ret = nvmet_tcp_set_queue_sock(queue);
 	if (!ret)
 		return;
 
+out_destroy_sq:
 	queue->state = NVMET_TCP_Q_DISCONNECTING;
 	mutex_lock(&nvmet_tcp_queue_mutex);
 	list_del_init(&queue->queue_list);
-- 
2.35.3


