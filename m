Return-Path: <netdev+bounces-275363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C7AUAHf90GnrDAcAu9opvQ
	(envelope-from <netdev+bounces-275363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 14:00:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4155039AFD9
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 14:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C6133011F1F
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBBA22ACEB;
	Sat,  4 Apr 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW7xr6jj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0B78F2F
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775304051; cv=none; b=j3Aj8v0sBIXed+PWdTaidWNnIQQjAka4Wgy5LDD/la3gvvMkAJdrEp1rmkjztqIkDDGRxfCwGuq+KKrS/WMcw87hFEyCcHjllF1p1kcfnlzwK7MWAOtyPQ5sSxgdLi4JrCE2jOZvwdIRRr4AP1bqc1pBt2IMmJULgRJMLf4PlRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775304051; c=relaxed/simple;
	bh=VtNyzCJlKiWPRpac2hpLDlz2iXAOQEuOZn/4dRgd62s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNZoHRSsUDPF44sY4C1K7uIj6o1db27zee1AeJWbwdMD05Op1HaptQ2ehWnrlIRYmcffZ7OqjWcvg5fhMYU//TfEM8qZ4Tuxvvo4MCW+5VHbMbv2pGj5wYiUx8fEOdOyv0qJdMNeLzPESqB+nzUotczqC0Yc1LPfisKP+3sHjTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW7xr6jj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso1552895e9.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775304047; x=1775908847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DkX4s/XI+c7PXdBRzFrMwSRV7dcHreB8F+csd9TnCY=;
        b=JW7xr6jjuJ2bsFi8P1Wc9azqr1LliIXXLLSAwyJ7OTx/5g6TmJWJdpRSJMlbHF/Y1j
         64v6+gY7yX+qhKPkWMLpZH4tJma0bRCYDRz0/sS52mdJ+4FySg6ONIJ74XeoiN/Gh6sN
         h1emWjYc9dPWGQP8h06Yi/rS7fc0aAy9tWxh+NPA7HuKQrb5nMKoS3WQayu5qvTcxfhY
         kfhMwAmz5lZLEjhhckpTJsDJ5Ir9OhNd1vR+37tWKagrs3q52jnBfFpSDNTrgAenSipl
         tsJY5r2b1VnAAA2ElXBcEdHwBwY/SNKI0B9QKqb/xqutnF8sRKEDcjh9ge3WqvxW1sv+
         S8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775304047; x=1775908847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DkX4s/XI+c7PXdBRzFrMwSRV7dcHreB8F+csd9TnCY=;
        b=IKkbm5WtFrlcYXpcxb2wxB4KNhFVr1BXNpHAeq64dlKMPpmD0ad8vjsKJj3D0lVtT7
         q0b7IpqK2O68bd5tQxquEd+U6MEkGhgTzwdORDz477CcuORyzFO8Et+g5Cp/CNhzbwzR
         u03GxqJ1JrFQtdNb6ALS8m23drlXVHH3t+8RbwGLDJ0Vj8NU650nH98S90TeBivJyscR
         S6a+mpb6JlLHAoYdRe+oAeD50w6+MK0hF05hi8WTkWcd/mkLH39x8zd/V/BZmWpWnFQW
         T/6NZsfr4+5p6A96DXHxO423TqStQndLw3v3lMccu+XJcM/5Ijpv1M3TIfNeo0+8pZSo
         BBMg==
X-Gm-Message-State: AOJu0YyB/DLN0BSM45dwxYfdDW7N70/BEyajaI5ijtY9v+Kex3mdcQpb
	6SvIF2AuDKFnifjxh3ECVX+aqmyq2wjozGOtX81MvaXSzb/6etXoA8nE
X-Gm-Gg: AeBDiet1ZRAAMzyWpKjvjVCjVGOS2VmztvWAAWriCh85UHjjcM4YaRl+PXQC7j7FnKV
	HfQO3hmxhrxh9z02YRpuAWxq3KygkwvSU0vZTuaIbanJYedlXTQE7YRAiy66J1ZHfq4VVMLGiGO
	SHkMxB4IvK01eGxtFfxTca3wRzrWtcfrtzOMuqQJyG7geBI56HkibIGaUdlLwW9CprceE6576LW
	9C8Wyqrl4cuaEcG9sdgAgxg5/QfhRcGJtEMOxg/cYcPS7UI5DAbgDMTMeixILrRByY7UIR3qB+v
	uGLezDj7yugP8RXsFLaLrQo73cZCWZnth55ABObHMlYBibHeDpq9VegIpIZKF+MVtRptsWK6jYL
	NyKdgv50520E6VqEH05ADP5rk1BrtYHSkdMl5Mc4tufk8C+haKvAmGC/dMHGTvH1uTRYJ6Rn3Hv
	awl5IvWOpgKlBy6HwuAYf8Ld8e+yZ8h9XF+dq7X5RN65M4kPj3c3I4UKvbWngoHViNomGsMhNR+
	7CuPOq/XXW0
X-Received: by 2002:a05:600c:821b:b0:487:1114:d42f with SMTP id 5b1f17b1804b1-488996a6ab4mr101774035e9.1.1775304047110;
        Sat, 04 Apr 2026 05:00:47 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f08sm26273009f8f.6.2026.04.04.05.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:00:46 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Qiliang Yuan <realwujing@gmail.com>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] treewide: use get_random_u{16,32,64}() where appropriate
Date: Sat,  4 Apr 2026 13:00:43 +0100
Message-ID: <20260404120043.85411-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275363-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,suse.cz,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4155039AFD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the typed random integer helpers instead of
get_random_bytes() when filling a single integer variable.
The helpers return the value directly, require no pointer
or size argument, and better express intent.

Skipped sites writing into __be16 fields (netdevsim) where
a direct assignment would trigger sparse endianness warnings.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/block/drbd/drbd_main.c                   | 4 ++--
 drivers/block/drbd/drbd_nl.c                     | 2 +-
 drivers/gpu/drm/i915/i915_hdcp_gsc.c             | 2 +-
 drivers/gpu/drm/xe/xe_gsc_submit.c               | 2 +-
 drivers/md/dm-vdo/indexer/index-layout.c         | 2 +-
 drivers/net/netdevsim/psample.c                  | 4 ++--
 drivers/target/iscsi/iscsi_target_seq_pdu_list.c | 2 +-
 fs/ext2/super.c                                  | 2 +-
 fs/ocfs2/super.c                                 | 2 +-
 net/ceph/auth_x.c                                | 2 +-
 net/core/net_namespace.c                         | 2 +-
 net/mac80211/mesh_plink.c                        | 2 +-
 net/mptcp/subflow.c                              | 4 ++--
 net/openvswitch/flow_table.c                     | 2 +-
 net/sctp/sm_make_chunk.c                         | 4 ++--
 net/tipc/node.c                                  | 2 +-
 16 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 200d464e984b..b1a721dd0496 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -874,7 +874,7 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
 	if (uuid && uuid != UUID_JUST_CREATED)
 		uuid = uuid + UUID_NEW_BM_OFFSET;
 	else
-		get_random_bytes(&uuid, sizeof(u64));
+		uuid = get_random_u64();
 	drbd_uuid_set(device, UI_BITMAP, uuid);
 	drbd_print_uuids(device, "updated sync UUID");
 	drbd_md_sync(device);
@@ -3337,7 +3337,7 @@ void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local)
 	u64 val;
 	unsigned long long bm_uuid;
 
-	get_random_bytes(&val, sizeof(u64));
+	val = get_random_u64();
 
 	spin_lock_irq(&device->ldev->md.uuid_lock);
 	bm_uuid = device->ldev->md.uuid[UI_BITMAP];
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index e201f0087a0f..377f60b40f28 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3173,7 +3173,7 @@ int drbd_adm_resume_io(struct sk_buff *skb, struct genl_info *info)
 			 * matching real data uuid exists).
 			 */
 			u64 val;
-			get_random_bytes(&val, sizeof(u64));
+			val = get_random_u64();
 			drbd_set_ed_uuid(device, val);
 			drbd_warn(device, "Resumed without access to data; please tear down before attempting to re-configure.\n");
 		}
diff --git a/drivers/gpu/drm/i915/i915_hdcp_gsc.c b/drivers/gpu/drm/i915/i915_hdcp_gsc.c
index 168b9ccbef3e..a0510f5ab25c 100644
--- a/drivers/gpu/drm/i915/i915_hdcp_gsc.c
+++ b/drivers/gpu/drm/i915/i915_hdcp_gsc.c
@@ -196,7 +196,7 @@ static ssize_t intel_hdcp_gsc_msg_send(struct intel_hdcp_gsc_context *gsc_contex
 
 	memset(header_in, 0, msg_size_in);
 	memset(header_out, 0, msg_size_out);
-	get_random_bytes(&host_session_id, sizeof(u64));
+	host_session_id = get_random_u64();
 	intel_gsc_uc_heci_cmd_emit_mtl_header(header_in, HECI_MEADDRESS_HDCP,
 					      msg_size_in, host_session_id);
 	memcpy(gsc_context->hdcp_cmd_in + sizeof(*header_in), msg_in, msg_in_len);
diff --git a/drivers/gpu/drm/xe/xe_gsc_submit.c b/drivers/gpu/drm/xe/xe_gsc_submit.c
index 08082b596501..195f99e6c3a8 100644
--- a/drivers/gpu/drm/xe/xe_gsc_submit.c
+++ b/drivers/gpu/drm/xe/xe_gsc_submit.c
@@ -49,7 +49,7 @@ u64 xe_gsc_create_host_session_id(void)
 {
 	u64 host_session_id;
 
-	get_random_bytes(&host_session_id, sizeof(u64));
+	host_session_id = get_random_u64();
 	host_session_id &= ~HOST_SESSION_CLIENT_MASK;
 	return host_session_id;
 }
diff --git a/drivers/md/dm-vdo/indexer/index-layout.c b/drivers/md/dm-vdo/indexer/index-layout.c
index 61edf2b72427..8707930c9910 100644
--- a/drivers/md/dm-vdo/indexer/index-layout.c
+++ b/drivers/md/dm-vdo/indexer/index-layout.c
@@ -256,7 +256,7 @@ static void create_unique_nonce_data(u8 *buffer)
 	u32 rand;
 	size_t offset = 0;
 
-	get_random_bytes(&rand, sizeof(u32));
+	rand = get_random_u32();
 	memcpy(buffer + offset, &now, sizeof(now));
 	offset += sizeof(now);
 	memcpy(buffer + offset, &rand, sizeof(rand));
diff --git a/drivers/net/netdevsim/psample.c b/drivers/net/netdevsim/psample.c
index 47d24bc64ee4..717d157c3ae2 100644
--- a/drivers/net/netdevsim/psample.c
+++ b/drivers/net/netdevsim/psample.c
@@ -94,7 +94,7 @@ static void nsim_dev_psample_md_prepare(const struct nsim_dev_psample *psample,
 	if (psample->out_tc_occ_max) {
 		u64 out_tc_occ;
 
-		get_random_bytes(&out_tc_occ, sizeof(u64));
+		out_tc_occ = get_random_u64();
 		md->out_tc_occ = out_tc_occ & (psample->out_tc_occ_max - 1);
 		md->out_tc_occ_valid = 1;
 	}
@@ -102,7 +102,7 @@ static void nsim_dev_psample_md_prepare(const struct nsim_dev_psample *psample,
 	if (psample->latency_max) {
 		u64 latency;
 
-		get_random_bytes(&latency, sizeof(u64));
+		latency = get_random_u64();
 		md->latency = latency & (psample->latency_max - 1);
 		md->latency_valid = 1;
 	}
diff --git a/drivers/target/iscsi/iscsi_target_seq_pdu_list.c b/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
index 75c37c8866c8..81e28e567a01 100644
--- a/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
+++ b/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
@@ -102,7 +102,7 @@ static void iscsit_create_random_array(u32 *array, u32 count)
 
 	for (i = 0; i < count; i++) {
 redo:
-		get_random_bytes(&j, sizeof(u32));
+		j = get_random_u32();
 		j = (1 + (int) (9999 + 1) - j) % count;
 		for (k = 0; k < i + 1; k++) {
 			j |= 0x80000000;
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 603f2641fe10..e4136490c883 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1151,7 +1151,7 @@ static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto failed_mount2;
 	}
 	sbi->s_gdb_count = db_count;
-	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
+	sbi->s_next_generation = get_random_u32();
 	spin_lock_init(&sbi->s_next_gen_lock);
 
 	/* per filesystem reservation list head & lock */
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index d7c58fd7d438..b875f01c9756 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2124,7 +2124,7 @@ static int ocfs2_initialize_super(struct super_block *sb,
 		osb->osb_cluster_stack[0] = '\0';
 	}
 
-	get_random_bytes(&osb->s_next_generation, sizeof(u32));
+	osb->s_next_generation = get_random_u32();
 
 	/*
 	 * FIXME
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 692e0b868822..936b43ae4a95 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -571,7 +571,7 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 			blob = enc_buf + SHA256_DIGEST_SIZE;
 		}
 
-		get_random_bytes(&auth->client_challenge, sizeof(u64));
+		auth->client_challenge = get_random_u64();
 		blob->client_challenge = auth->client_challenge;
 		blob->server_challenge = cpu_to_le64(xi->server_challenge);
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1057d16d5dd2..deb8b2ec5674 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -411,7 +411,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net_refcnt");
 	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net_notrefcnt");
 
-	get_random_bytes(&net->hash_mix, sizeof(u32));
+	net->hash_mix = get_random_u32();
 	net->dev_base_seq = 1;
 	net->user_ns = user_ns;
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 803106fc3134..7cbab90c8784 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -712,7 +712,7 @@ void mesh_plink_timer(struct timer_list *t)
 				"Mesh plink for %pM (retry, timeout): %d %d\n",
 				sta->sta.addr, sta->mesh->plink_retries,
 				sta->mesh->plink_timeout);
-			get_random_bytes(&rand, sizeof(u32));
+			rand = get_random_u32();
 			sta->mesh->plink_timeout = sta->mesh->plink_timeout +
 					     rand % sta->mesh->plink_timeout;
 			++sta->mesh->plink_retries;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5cfe19990f31..1a7736145dbc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -72,7 +72,7 @@ static void subflow_req_create_thmac(struct mptcp_subflow_request_sock *subflow_
 	struct mptcp_sock *msk = subflow_req->msk;
 	u8 hmac[SHA256_DIGEST_SIZE];
 
-	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
+	subflow_req->local_nonce = get_random_u32();
 
 	subflow_generate_hmac(READ_ONCE(msk->local_key),
 			      READ_ONCE(msk->remote_key),
@@ -1639,7 +1639,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
 	do {
-		get_random_bytes(&subflow->local_nonce, sizeof(u32));
+		subflow->local_nonce = get_random_u32();
 	} while (!subflow->local_nonce);
 
 	/* if 'IPADDRANY', the ID will be set later, after the routing */
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 61c6a5f77c2e..67d5b8c0fe79 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -167,7 +167,7 @@ static struct table_instance *table_instance_alloc(int new_size)
 
 	ti->n_buckets = new_size;
 	ti->node_ver = 0;
-	get_random_bytes(&ti->hash_seed, sizeof(u32));
+	ti->hash_seed = get_random_u32();
 
 	return ti;
 }
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 2c0017d058d4..de86ac088289 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2727,7 +2727,7 @@ __u32 sctp_generate_tag(const struct sctp_endpoint *ep)
 	__u32 x;
 
 	do {
-		get_random_bytes(&x, sizeof(__u32));
+		x = get_random_u32();
 	} while (x == 0);
 
 	return x;
@@ -2738,7 +2738,7 @@ __u32 sctp_generate_tsn(const struct sctp_endpoint *ep)
 {
 	__u32 retval;
 
-	get_random_bytes(&retval, sizeof(__u32));
+	retval = get_random_u32();
 	return retval;
 }
 
diff --git a/net/tipc/node.c b/net/tipc/node.c
index af442a5ef8f3..97aa970a0d83 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1275,7 +1275,7 @@ void tipc_node_check_dest(struct net *net, u32 addr,
 			goto exit;
 
 		if_name = strchr(b->name, ':') + 1;
-		get_random_bytes(&session, sizeof(u16));
+		session = get_random_u16();
 		if (!tipc_link_create(net, if_name, b->identity, b->tolerance,
 				      b->net_plane, b->mtu, b->priority,
 				      b->min_win, b->max_win, session,
-- 
2.53.0


