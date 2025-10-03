Return-Path: <netdev+bounces-227711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B79EBB5E78
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 06:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F225B19C6183
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 04:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1141E3DD7;
	Fri,  3 Oct 2025 04:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLg2Xc5z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D431EB5DB
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465935; cv=none; b=ZzlbbWN7gexprth1gnf95fM4x8azKdved8xPTrHB2m+6H7/SZRBNnv+Le/qJTKWBUqGr+IrJVN4JaJ35qhFjDV72sZ2TMca+W3xX0GrMS7QLwU9nNjyHRTeTGMP5mhupNIsvvB/3aowLWP87TJsfU6+bWCRZKv4di131QbGhy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465935; c=relaxed/simple;
	bh=JAlYfyPNqHylTqfeyHuOgAsuZYGxJ4FRoTTsZarTucI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1yv1m8EpuVBX/ieo9lh5hLsX9IQqu8ERMbg9rjfB1esHltkngxCbyZwJWReObQgihMV0AGY9wRGJ0K32MaRr7+/3/jg8uFMH0CPNoC+oT+y5c1GZpUY/zyIewS4UhnJ0otwGUGCS09NwcrSdM1cZ9Ic77MYCLm5QWEUeLqUpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLg2Xc5z; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso1896224a91.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 21:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465932; x=1760070732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkrZ7jtnwuJJMNWE3SjrPhibeXNwDkGrjN+iU3yJy1Y=;
        b=LLg2Xc5zQvDDt/a3NLiNPWcrt5sOeeOfirB0Ti7rCS+kJTtytQKl1B9QkbFv6oUOTa
         lYXnz81cGrPFBYW+APJc8HxWdpQ1aJSlBUqqbG/CbtGJ0rh12FPzpohtAS//sltcmDV6
         06mFLNlIeYYk4YDcnvSwHdoEyLoKknyIYhgg8tS6f2RupIVcWVAx0hM8S0jHA+lrBH9l
         I4fCHHAZ75Wk9qnpiTIO1lLDOUOA+iRzbCA0tX2axiK8//dbfaxiFGC+mjGRDlurCZw3
         xvXGz8g/LYzBtjWbGPuIYKuihbTloYvF/NODvS52/1J/y5hyF5nM5bfoM/UpLcVnMIAs
         5s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465932; x=1760070732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkrZ7jtnwuJJMNWE3SjrPhibeXNwDkGrjN+iU3yJy1Y=;
        b=l4lg9suwjeMYZ8V/iYkETMZkS1qggvaNezvmZVC4RUTFia4aU6VSvYyIoGfvGDQwmR
         Sj33fVwngQqR7/G2OEja2TwLbP3DSk8QnrZdkGUFte0Dyf1LpcWtuaU0uDq9LJ8nQoNT
         ubR3PMB5fsW2LaujkGG1C1J9m5PqxQ2MQQ9+wYMn7pneqzZpjf9Lcd6sc+bU4ra8GYIY
         nc66I4icQk0jCNWhl800OebInC//4BHCtE8K5HolmNyLAsJ7YnemoYUThQjvjrsJrrkG
         f0QCiGECGULFn+uCgL9Tyup7vUOXxUY2AxFCTCIOV5iQDhmAMRKn8SagHvne+PDGnNTX
         GaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGB5cKs1ZN7nVLpw9DLwVrk8p4W8+T04qnsrCV1pYBo/9ZBPGAnqLBQuZDEuYCScjlM8Rkdtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6fzGGg5YBjFbsBq26/wWBeJlR5+L+xsubakqrlEZm1JPMPOuQ
	gsLOtA/S9uXwxn/Py5XuofTX4UhevVMIxgPvk/ZB/Add+Mvxmd4yaTSm
X-Gm-Gg: ASbGncsS4uOF5JdrefysDtxfReRuiKQYtv2pK8lFJAuYGgBKnim+4XxymjPoJhhJB0T
	4a+DudYbcCgCw8214/lbnzYIQlu6IAglPiPLKw7G7nV6ssiYndmxMQnf/7X8zJI5VJGeuieqZ1k
	We51wVJh8MoqRaXIYJdb3V3lbM4F4g/VhPKw2Hrd1s9MpHG/9S9dGVfjhaPFcz1zUe2fg5BaELY
	4Syp1pEQHPY0weQZtHqPHREsERT4al29VAfUnI9ea8xBHjzk6iYsbXL+9gS9HxJutOamFvLuqQW
	BbUAaMVI3LUXNFVlWpaEB0WfVxlFKv9wGXH7jqBPJzaM3Me+CxEigAKmjXpZKBqdCPsWexOTJfP
	V5rEG9AFV7shq2Xll8OGhxeyj/4zxNUygIj12ezjUFDAW52fFeMKcYF4B2nEMisEK+B1Z9w34th
	QUfuu1oVTSTPiKsRAvMCcp53t/ImM5vnmakel2znsaGmPHCiP1JilT
X-Google-Smtp-Source: AGHT+IH3IfnWMDfyEsoSYvKJgmusiDgvOmiSTci9njbVxgtI3mIq48SZ262dEJui5ekxAzN1f2De9Q==
X-Received: by 2002:a17:90b:3145:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-339c27b0fbbmr2111487a91.33.1759465932024;
        Thu, 02 Oct 2025 21:32:12 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:11 -0700 (PDT)
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
Subject: [PATCH v3 1/8] net/handshake: Store the key serial number on completion
Date: Fri,  3 Oct 2025 14:31:32 +1000
Message-ID: <20251003043140.1341958-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace to include a key serial number when completing a
handshake with the HANDSHAKE_CMD_DONE command.

We then store this serial number and will provide it back to userspace
in the future. This allows userspace to save data to the keyring and
then restore that data later.

This will be used to support the TLS KeyUpdate operation, as now
userspace can resume information about a established session.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v3:
 - No change
v2:
 - Change "key-serial" to "session-id"

 Documentation/netlink/specs/handshake.yaml |  4 ++++
 Documentation/networking/tls-handshake.rst |  2 ++
 drivers/nvme/host/tcp.c                    |  3 ++-
 drivers/nvme/target/tcp.c                  |  3 ++-
 include/net/handshake.h                    |  4 +++-
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 +++--
 net/handshake/tlshd.c                      | 15 +++++++++++++--
 net/sunrpc/svcsock.c                       |  4 +++-
 net/sunrpc/xprtsock.c                      |  4 +++-
 10 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..a273bc74d26f 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -87,6 +87,9 @@ attribute-sets:
         name: remote-auth
         type: u32
         multi-attr: true
+      -
+        name: session-id
+        type: u32
 
 operations:
   list:
@@ -123,6 +126,7 @@ operations:
             - status
             - sockfd
             - remote-auth
+            - session-id
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
index 6f5ea1646a47..d7287890056a 100644
--- a/Documentation/networking/tls-handshake.rst
+++ b/Documentation/networking/tls-handshake.rst
@@ -60,6 +60,8 @@ fills in a structure that contains the parameters of the request:
         key_serial_t    ta_my_privkey;
         unsigned int    ta_num_peerids;
         key_serial_t    ta_my_peerids[5];
+        key_serial_t    user_session_id;
+
   };
 
 The @ta_sock field references an open and connected socket. The consumer
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9ef1d4aea838..700c37af52ba 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1691,7 +1691,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		qid, queue->io_cpu);
 }
 
-static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
+	key_serial_t user_session_id)
 {
 	struct nvme_tcp_queue *queue = data;
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..4ef4dd140ada 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1780,7 +1780,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
 }
 
 static void nvmet_tcp_tls_handshake_done(void *data, int status,
-					 key_serial_t peerid)
+					 key_serial_t peerid,
+					 key_serial_t user_session_id)
 {
 	struct nvmet_tcp_queue *queue = data;
 
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8ebd4f9ed26e..dc2222fd6d99 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -18,7 +18,8 @@ enum {
 };
 
 typedef void	(*tls_done_func_t)(void *data, int status,
-				   key_serial_t peerid);
+				   key_serial_t peerid,
+				   key_serial_t user_session_id);
 
 struct tls_handshake_args {
 	struct socket		*ta_sock;
@@ -31,6 +32,7 @@ struct tls_handshake_args {
 	key_serial_t		ta_my_privkey;
 	unsigned int		ta_num_peerids;
 	key_serial_t		ta_my_peerids[5];
+	key_serial_t		user_session_id;
 };
 
 int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index 662e7de46c54..b68ffbaa5f31 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -55,6 +55,7 @@ enum {
 	HANDSHAKE_A_DONE_STATUS = 1,
 	HANDSHAKE_A_DONE_SOCKFD,
 	HANDSHAKE_A_DONE_REMOTE_AUTH,
+	HANDSHAKE_A_DONE_SESSION_ID,
 
 	__HANDSHAKE_A_DONE_MAX,
 	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index f55d14d7b726..6cdce7e5dbc0 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 };
 
 /* HANDSHAKE_CMD_DONE - do */
-static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
+static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_SESSION_ID + 1] = {
 	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_SESSION_ID] = { .type = NLA_U32, },
 };
 
 /* Ops table for handshake */
@@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.cmd		= HANDSHAKE_CMD_DONE,
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
-		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
+		.maxattr	= HANDSHAKE_A_DONE_SESSION_ID,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 081093dfd553..2549c5dbccd8 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -26,7 +26,8 @@
 
 struct tls_handshake_req {
 	void			(*th_consumer_done)(void *data, int status,
-						    key_serial_t peerid);
+						    key_serial_t peerid,
+						    key_serial_t user_session_id);
 	void			*th_consumer_data;
 
 	int			th_type;
@@ -39,6 +40,8 @@ struct tls_handshake_req {
 
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
+
+	key_serial_t		user_session_id;
 };
 
 static struct tls_handshake_req *
@@ -55,6 +58,7 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
+	treq->user_session_id = TLS_NO_PRIVKEY;
 	return treq;
 }
 
@@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
 		if (i >= treq->th_num_peerids)
 			break;
 	}
+
+	nla_for_each_attr(nla, head, len, rem) {
+		if (nla_type(nla) == HANDSHAKE_A_DONE_SESSION_ID) {
+			treq->user_session_id = nla_get_u32(nla);
+			break;
+		}
+	}
 }
 
 /**
@@ -105,7 +116,7 @@ static void tls_handshake_done(struct handshake_req *req,
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
 	treq->th_consumer_done(treq->th_consumer_data, -status,
-			       treq->th_peerid[0]);
+			       treq->th_peerid[0], treq->user_session_id);
 }
 
 #if IS_ENABLED(CONFIG_KEYS)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e2c5e0e626f9..4ec3119bd113 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -444,13 +444,15 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
  * @data: address of xprt to wake
  * @status: status of handshake
  * @peerid: serial number of key containing the remote peer's identity
+ * @user_session_id: serial number of the userspace session ID
  *
  * If a security policy is specified as an export option, we don't
  * have a specific export here to check. So we set a "TLS session
  * is present" flag on the xprt and let an upper layer enforce local
  * security policy.
  */
-static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
+static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
+				   key_serial_t user_session_id)
 {
 	struct svc_xprt *xprt = data;
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 3aa987e7f072..bce0f43bef65 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2589,9 +2589,11 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
  * @data: address of xprt to wake
  * @status: status of handshake
  * @peerid: serial number of key containing the remote's identity
+ * @user_session_id: serial number of the userspace session ID
  *
  */
-static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
+static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
+				  key_serial_t user_session_id)
 {
 	struct rpc_xprt *lower_xprt = data;
 	struct sock_xprt *lower_transport =
-- 
2.51.0


