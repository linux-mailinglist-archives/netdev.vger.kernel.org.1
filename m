Return-Path: <netdev+bounces-230298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1EBE64E0
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7D719C8A2F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 04:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00DA3115AF;
	Fri, 17 Oct 2025 04:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7c3nDdT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF043112D1
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675057; cv=none; b=n71TW35lovLN74yeUnYz2ZQkrDTmnr+08YWQ0Vaf+ecWqAj1f37jtr4RDB/hqRms/t4kCfSvf7szxiwNvgPynl2H87ZVviyMduuxJyUqmVnCvElFL9LLz1LByYU8kwpRzt0vu40BE0VrtzFILtwcNyIDhh1uaNjSYduKw/M/BWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675057; c=relaxed/simple;
	bh=mttQhbqh9z6Fex4BCtrcnr1DTRxAJlfyNZNJHALHqyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3+g2WbF14dJ5fGEr8HpeG6E4IS7f2ePCvZZUqsIsw64VxakeXcMCGMkbR7rQYkGRBw4ZHAu4hhtfXrbUDakN+W5YZsF9QPD5INdo2XX6VNFNc/glQ8HTuFTyPuqqQoJPRbf5AYZ7wS5oLGvOq1Xeuc6uJ7g4KzfYmuqHkXM60Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7c3nDdT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-791c287c10dso1270214b3a.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 21:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675055; x=1761279855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/JQ/MpeHG5sNknRkM9q2VtRpwwB6bENwljP0w05Adc=;
        b=i7c3nDdTKDlHHj8Q0yMl5eIchL06dCa/mrMQ1ixYOS18+An9jDZoFY9wLW7KT9Qp0K
         1ykwNkcNiELAWAYO21Q61B1HCnCPEDpXPNdyYeJUzpEcAQxcbEOgmixaBWDOQdNa1Jnz
         mTa17l7NBwQ+1b+5ARm63fUnqwIOCc5wilG16AQaT02W2DT1qqYkAzAhWUQlh1hRt+cV
         WTcotKBnScmaMb0EKrI2sJ0sOhzJ/Kaiz8pghCybbWFcBZEIKswHNApk8/IfK35zFdbt
         hs8gcgJmHBGGE0lUN4yuOvq9D/R+ejGQrPVaQ/FupRbxlpS0wb+nK1zOWmzZUflha/qW
         jI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675055; x=1761279855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/JQ/MpeHG5sNknRkM9q2VtRpwwB6bENwljP0w05Adc=;
        b=sUminwuyPQlCCztEA87WrA6anK7sGfcaHN3Sec2heuToPPxe8eOEw+/gRr9NwiXqRl
         wLKNMbhX4eFq1W5MQrcxn8npLDNdJvOqUxaCpgUGB51y+1PvEGz45BvlfeHTIAukoxwR
         Te9Vn9ya6F2OrdVePZcRl/kfo/j33+QZROZ9vxq2sHalMHu24cpxcGsT0lc0zWpKoz/E
         5Lw3A24mzxxlQcTMyrcTQxsb5hEHfM0xNXf4XzPISzdpdukJBAQIcZ2bCXxZd2IsOyF2
         wKkhExG+z1r1stTf0AG34N5GHetyScU91a9w1qnQ5N2zKPOARd85qgd8/j2QM7Chh+4P
         3oHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT4kuGqiIqb3N/4jDAOeNWvB4oifvuEZ2OX8eH0j0KCWVUpiREj4OpGNpSYm62S02uUA0vMYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBGQSjk7heZyx+Hgd9zZ8Z8AYNJ6TWEMeFnmoB0Guen1sobpt
	4O+UDEVshyCQfk6HIeumiRYpYfPY4qTVrn6+ZU8NS0duIwvsHwZ9aoHh
X-Gm-Gg: ASbGncuQ2lCBbBdYVSuXotA/BrPcG+gIh2C1gVqZifJXzzNTSk/jItf52iH0Op5gIl8
	UrwE6OQDvBDqqDKq52dlFQLg7eba2s/kGNdqBM7z8T8JRvthpB1MzOtlx4KhLwO/rFT/sWneB3f
	muRinBoWlGqd96rAh8onzPXEFGhdoO+xGhkHIhqlwfDaxRioHu/vjj5tBj5eSGJu5+G0cV6B4IP
	gyfpZOGqxJBwE3+dTxBE8SVsThvSA3zhV96e0S8kHFrKdFDwbMGo2DdsokPqDq+ZWLDLSx8vv+R
	TiCCL8yE7zVW2TbNJsaK1eA2ZMzMRg822JwHVjbbcvJJ/lInLHzzzNQcLePUDR7sFvmU7Og7UU+
	LaujBUFlODm8Aug0d1kBBht8ECPKjT7km/1RwFfhQkG9SluCmpETH56cmPyepkEwhclc2qtZFlU
	ABt2+48wqetLauMtyERfqcVrno/nD7/35ozo7CTROsYooVtldGzt8ljaQ/yEx11t6dA/j4XX/8a
	AjSEukbnhQU/09cW9UG
X-Google-Smtp-Source: AGHT+IHyaWxT0M6jcSDOPiAWWc/zLGVBhm66Pbmfou5gKKgW6rFVAYlwZs/wPGPlImKOfJEIkfaYVg==
X-Received: by 2002:a17:90b:1d88:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-33bcf90c003mr2038589a91.29.1760675054825;
        Thu, 16 Oct 2025 21:24:14 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:24:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 7/7] nvmet-tcp: Support KeyUpdate
Date: Fri, 17 Oct 2025 14:23:12 +1000
Message-ID: <20251017042312.1271322-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receive
a KeyUpdate handshake type then the underlying TLS keys need to be
updated.

If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe host sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v4:
 - Restructure code to avoid #ifdefs and forward declarations
 - Use a helper function for checking -EKEYEXPIRED
 - Remove all support for initiating KeyUpdate
 - Use helper function for restoring callbacks
v3:
 - Use a write lock for sk_user_data
 - Fix build with CONFIG_NVME_TARGET_TCP_TLS disabled
 - Remove unused variable
v2:
 - Use a helper function for KeyUpdates
 - Ensure keep alive timer is stopped
 - Wait for TLS KeyUpdate to complete

 drivers/nvme/target/tcp.c | 205 ++++++++++++++++++++++++++------------
 1 file changed, 143 insertions(+), 62 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8aeec4a7f136..4ef25df2791a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
 
 	/* TLS state */
 	key_serial_t		tls_pskid;
+	key_serial_t		user_session_id;
 	struct delayed_work	tls_handshake_tmo_work;
 
 	unsigned long           poll_end;
@@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
 	struct sockaddr_storage	sockaddr_peer;
 	struct work_struct	release_work;
 
+	struct completion       tls_complete;
+
 	int			idx;
 	struct list_head	queue_list;
 
@@ -214,6 +217,10 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+				   handshake_key_update_type keyupdate);
+#endif
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -832,6 +839,23 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 	return 1;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
+{
+	if (ret == -EKEYEXPIRED &&
+	    queue->state != NVMET_TCP_Q_DISCONNECTING &&
+	    queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
+					return true;
+
+	return false;
+}
+#else
+static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
+{
+	return false;
+}
+#endif
+
 static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 		int budget, int *sends)
 {
@@ -1106,6 +1130,103 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+static void nvmet_tcp_release_queue(struct kref *kref)
+{
+	struct nvmet_tcp_queue *queue =
+		container_of(kref, struct nvmet_tcp_queue, kref);
+
+	WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
+	queue_work(nvmet_wq, &queue->release_work);
+}
+
+static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
+{
+	spin_lock_bh(&queue->state_lock);
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		/* Socket closed during handshake */
+		tls_handshake_cancel(queue->sock->sk);
+	}
+	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
+		queue->state = NVMET_TCP_Q_DISCONNECTING;
+		kref_put(&queue->kref, nvmet_tcp_release_queue);
+	}
+	spin_unlock_bh(&queue->state_lock);
+}
+
+static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
+{
+	struct socket *sock = queue->sock;
+
+	if (!queue->state_change)
+		return;
+
+	write_lock_bh(&sock->sk->sk_callback_lock);
+	sock->sk->sk_data_ready =  queue->data_ready;
+	sock->sk->sk_state_change = queue->state_change;
+	sock->sk->sk_write_space = queue->write_space;
+	sock->sk->sk_user_data = NULL;
+	write_unlock_bh(&sock->sk->sk_callback_lock);
+}
+
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
+{
+	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
+			struct nvmet_tcp_queue, tls_handshake_tmo_work);
+
+	pr_warn("queue %d: TLS handshake timeout\n", queue->idx);
+	/*
+	 * If tls_handshake_cancel() fails we've lost the race with
+	 * nvmet_tcp_tls_handshake_done() */
+	if (!tls_handshake_cancel(queue->sock->sk))
+		return;
+	spin_lock_bh(&queue->state_lock);
+	if (WARN_ON(queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)) {
+		spin_unlock_bh(&queue->state_lock);
+		return;
+	}
+	queue->state = NVMET_TCP_Q_FAILED;
+	spin_unlock_bh(&queue->state_lock);
+	nvmet_tcp_schedule_release_queue(queue);
+	kref_put(&queue->kref, nvmet_tcp_release_queue);
+}
+
+static int update_tls_keys(struct nvmet_tcp_queue *queue)
+{
+	int ret;
+
+	cancel_work(&queue->io_work);
+	queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+
+	nvmet_tcp_restore_socket_callbacks(queue);
+
+	INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
+			  nvmet_tcp_tls_handshake_timeout);
+
+	ret = nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete,
+							10 * HZ);
+
+	if (ret <= 0) {
+		tls_handshake_cancel(queue->sock->sk);
+		return ret;
+	}
+
+	queue->state = NVMET_TCP_Q_LIVE;
+
+	return 0;
+}
+#else
+static int update_tls_keys(struct nvmet_tcp_queue *queue)
+{
+	return -EPFNOSUPPORT;
+}
+#endif
+
 static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 		struct msghdr *msg, char *cbuf)
 {
@@ -1131,6 +1252,9 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 			ret = -EAGAIN;
 		}
 		break;
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		ret = -EAGAIN;
+		break;
 	default:
 		/* discard this record type */
 		pr_err("queue %d: TLS record %d unhandled\n",
@@ -1340,6 +1464,8 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
 		if (unlikely(ret < 0)) {
+			if (nvmet_tls_key_expired(queue, ret))
+					goto done;
 			nvmet_tcp_socket_error(queue, ret);
 			goto done;
 		} else if (ret == 0) {
@@ -1351,29 +1477,6 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	return ret;
 }
 
-static void nvmet_tcp_release_queue(struct kref *kref)
-{
-	struct nvmet_tcp_queue *queue =
-		container_of(kref, struct nvmet_tcp_queue, kref);
-
-	WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
-	queue_work(nvmet_wq, &queue->release_work);
-}
-
-static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
-{
-	spin_lock_bh(&queue->state_lock);
-	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
-		/* Socket closed during handshake */
-		tls_handshake_cancel(queue->sock->sk);
-	}
-	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
-		queue->state = NVMET_TCP_Q_DISCONNECTING;
-		kref_put(&queue->kref, nvmet_tcp_release_queue);
-	}
-	spin_unlock_bh(&queue->state_lock);
-}
-
 static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
 {
 	queue->poll_end = jiffies + usecs_to_jiffies(idle_poll_period_usecs);
@@ -1404,8 +1507,12 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
 		if (ret > 0)
 			pending = true;
-		else if (ret < 0)
+		else if (ret < 0) {
+			if (ret == -EKEYEXPIRED)
+				break;
+
 			return;
+		}
 
 		ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
 		if (ret > 0)
@@ -1415,6 +1522,11 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
+	if (ret == -EKEYEXPIRED) {
+		update_tls_keys(queue);
+		pending = true;
+	}
+
 	/*
 	 * Requeue the worker if idle deadline period is in progress or any
 	 * ops activity was recorded during the do-while loop above.
@@ -1517,21 +1629,6 @@ static void nvmet_tcp_free_cmds(struct nvmet_tcp_queue *queue)
 	kfree(cmds);
 }
 
-static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
-{
-	struct socket *sock = queue->sock;
-
-	if (!queue->state_change)
-		return;
-
-	write_lock_bh(&sock->sk->sk_callback_lock);
-	sock->sk->sk_data_ready =  queue->data_ready;
-	sock->sk->sk_state_change = queue->state_change;
-	sock->sk->sk_write_space = queue->write_space;
-	sock->sk->sk_user_data = NULL;
-	write_unlock_bh(&sock->sk->sk_callback_lock);
-}
-
 static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
@@ -1794,6 +1891,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status) {
 		queue->tls_pskid = peerid;
+		queue->user_session_id = user_session_id;
 		queue->state = NVMET_TCP_Q_CONNECTING;
 	} else
 		queue->state = NVMET_TCP_Q_FAILED;
@@ -1809,32 +1907,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	else
 		nvmet_tcp_set_queue_sock(queue);
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
-}
-
-static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
-{
-	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
-			struct nvmet_tcp_queue, tls_handshake_tmo_work);
-
-	pr_warn("queue %d: TLS handshake timeout\n", queue->idx);
-	/*
-	 * If tls_handshake_cancel() fails we've lost the race with
-	 * nvmet_tcp_tls_handshake_done() */
-	if (!tls_handshake_cancel(queue->sock->sk))
-		return;
-	spin_lock_bh(&queue->state_lock);
-	if (WARN_ON(queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)) {
-		spin_unlock_bh(&queue->state_lock);
-		return;
-	}
-	queue->state = NVMET_TCP_Q_FAILED;
-	spin_unlock_bh(&queue->state_lock);
-	nvmet_tcp_schedule_release_queue(queue);
-	kref_put(&queue->kref, nvmet_tcp_release_queue);
+	complete(&queue->tls_complete);
 }
 
 static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
-	handshake_key_update_type keyupdate)
+				   handshake_key_update_type keyupdate)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
@@ -1852,11 +1929,15 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_session_id = queue->user_session_id;
+
+	init_completion(&queue->tls_complete);
 
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
 		ret = tls_server_hello_psk(&args, GFP_KERNEL);
 	else
 		ret = tls_server_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
+
 	if (ret) {
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
 		pr_err("failed to start TLS, err=%d\n", ret);
-- 
2.51.0


