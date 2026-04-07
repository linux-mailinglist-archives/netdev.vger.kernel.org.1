Return-Path: <netdev+bounces-276035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEBHB5Uf1Wl/1AcAu9opvQ
	(envelope-from <netdev+bounces-276035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:15:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4063B0C4E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B4F6307D0BB
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DAD35F8C9;
	Tue,  7 Apr 2026 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oM/kS0m4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795D35F182
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574522; cv=none; b=V9N/73B3aZJF1xQ3XDjYVy//B5OIrPwTtx0ZMnGWf8RU74NdT8WupWPrYBwT1vK8qXxUaipYq6QsvSfBHyyoihba3g92G/KeMAvhDelaoF2WRlRUmJfqvQvWEqWG8ll1sI2DTp7/bNWCzXn6SRjH3J2FYsh7FHlgB4MKV95WjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574522; c=relaxed/simple;
	bh=jymJPdqyE0JtZYcOwQes2cGg9dVOktqNFZiLSsqTKKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVMGZVcdrs5k4dzqRsolXRFO3ZZI5Hk6G0U+iAenT9B21W8UOIjbd2NOVMqmo8j9Tq9Y0J38E8FmHTKC44p44PLrwuYcbEFnCKxZHDZxxc9lhna3Fv4+1A3jGRbtVZzFqVtyOwydWcxGiK9CnlYNkWugRlf922yqpZNnK9w/6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oM/kS0m4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso5433054f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775574519; x=1776179319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4jjEPCUJmZT2sKEYrMwlfVHfjzzKvnFJHfospIU05c=;
        b=oM/kS0m4cIuz+n/KMiXNxqknKvl6gXpm2xPRN5jiAHojDLjnyavSsbdvcq+/0+FaK6
         uGzGGxKxMk0+9b8oo2l+/+Mk6K8VXhHosQSUDhrYr+pjT4q7uAEj2DIdIYhSWfreT6ax
         thwqUGZpj6IDhk3ZDWY1xYAHNtEzg1EzpZhH6FT+aU6haOWulOci3yKNWwCAGlZZwm8Q
         2J7TKX3eU/dE/gGrbn7Weeu6QREpV2MXp2vhn4WJTbzqwlsoUVrEUYxhs10pqltAbbAZ
         QGSP/70jlOv6ctvjHoJtHrunN7+MLujgDbQxm+skTntIPPToDH81iCGspC+nsVNKZT55
         ffBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775574519; x=1776179319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4jjEPCUJmZT2sKEYrMwlfVHfjzzKvnFJHfospIU05c=;
        b=p/UBsF1dRMAOu6QVdT2nOoXL7VSehmmevcazdVxF3BYZ4PT8YND9gQl5H/U+8cz/C4
         +hVh7bsfkl9yWhO0NCVaWWTe/mpF0KKkvElDl0itqa712VoBj0CAwfXaQdxyNiF4wSZN
         xbnd6bwAATTF4ZODczf0+SjuIyHPChBXhMifq9o1EhNIeUJ6cqhHqSKRSVA83LQSm75b
         JK32s8uvMYS6mdyLdLaJKLK9vN6KyNOCjyLBFvY7ZP5fZZNLUnU6CssLr++VNkLnXegY
         K57i0LOOKs0S0SbMjcSK0VBPKWjfC7hyEJ7FrCjsrw28gnoRFbGic/WZmlU+hVjZdBks
         4QDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMmw6oTI6HRPY4/bshmcZvRLuhZSv+LFGNfY4UtZ9rjD6zUezO+8YhdaOTfXMjap0AmIgdxRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwISlVXlvPVTA9fr0S08HHEfmWCWYH9ooDIryNRnrT0tgXPJnBV
	r+N4lbi859HeGgcK3h64CsU280Ea2/0YUylTIgD2DuQOhTXilwwM4Awd
X-Gm-Gg: AeBDieuZNdrRCexMSJDEEr1uzBG8MjSHog+D5ovb5+MoT5GqGI39yH3lMiVJ07VkR5D
	xCdizEEjG4w7m0qH+SKAEwkIbn6cfVR+Lnh5lf+zFc+rd4V4N0GUPVhN5e3ITP8ZaBrmO68bc3Q
	/yni3/Vat2tQrgLdwnT1xaqpjzBkR5MgwZijzu69ubDToWYit07bVBbmdivHkiIaO8/shZRoQkl
	2t20SN2vrlu2pO4vMfj4F1v7MrkT39pM9NCWazxDzy3761zbBwgYcqtGchK7/WE2jNlN+60rxOA
	/2RJqzsqxlh67lc2u6xMf36xcNeZzvuRk02QG31VjXHIQAsexpcYgdAR/wTSxZ9/ggxvuc0FObb
	2CQ0iE8wlZ9VZNIOrccC3jDYLd/lIa/cYsYTbmLHRbjBUAr9nvgBSii5URKECsm8CdKvjoIkhVt
	cWHMmE0Mr/yEv80h6BFPHX2Y5Y+QvMv9DcT3EzfxuUMiGDIdy7kSXT+thmzTmUxYwV7WYRsL3j8
	ZzjNj+0bFw9
X-Received: by 2002:a05:6000:1446:b0:439:c69f:503a with SMTP id ffacd0b85a97d-43d292d5e8dmr26238497f8f.27.1775574518734;
        Tue, 07 Apr 2026 08:08:38 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c54bdsm52056417f8f.16.2026.04.07.08.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:08:37 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mptcp@lists.linux.dev,
	dev@openvswitch.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v4 net-next] net: use get_random_u{16,32,64}() where appropriate
Date: Tue,  7 Apr 2026 16:07:58 +0100
Message-ID: <20260407150758.5889-1-devnexen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,gmail.com,sipsolutions.net,redhat.com,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-276035-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.984];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF4063B0C4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the typed random integer helpers instead of
get_random_bytes() when filling a single integer variable.
The helpers return the value directly, require no pointer
or size argument, and better express intent.

Skipped sites writing into __be16 (netdevsim) and __le64
(ceph) fields where a direct assignment would trigger
sparse endianness warnings.

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---

Notes:
    Changes v3 -> v4:
    - Dropped net/ceph/auth_x.c site: client_challenge is __le64,
      direct assignment triggers sparse endianness warning
      (Matthieu Baerts)
    - Added Reviewed-by from Matthieu Baerts for net/mptcp changes
    
    v3: https://lore.kernel.org/netdev/20260405154816.4774-1-devnexen@gmail.com/
    v2: https://lore.kernel.org/netdev/Z/BfE0zn+DJxhBH7@debian/

 drivers/net/netdevsim/psample.c | 4 ++--
 net/core/net_namespace.c        | 2 +-
 net/mac80211/mesh_plink.c       | 2 +-
 net/mptcp/subflow.c             | 4 ++--
 net/openvswitch/flow_table.c    | 2 +-
 net/sctp/sm_make_chunk.c        | 4 ++--
 net/tipc/node.c                 | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

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


