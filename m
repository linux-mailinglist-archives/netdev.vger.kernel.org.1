Return-Path: <netdev+bounces-288203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMK4KMXJBmrynwIAu9opvQ
	(envelope-from <netdev+bounces-288203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:22:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374654A7CF
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC7130A0FFE
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437B3E3DB6;
	Fri, 15 May 2026 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W27fIjDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4203E558A
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829317; cv=none; b=sU8gCKoI4uEoBidt1bacam8MplKxPviYwpVFbdPij7VyMPD0s2sfx0b80+YWMSIP8E9Q0PcKdboghx+Qbxtghy+tJb9GvP188H+L0stKAPUKOf6c2oxkCtyAsqEV/j91gbUGIiaWpY012Jp7/CXEnQQpB1nC+0Zd5Bb61Wq+7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829317; c=relaxed/simple;
	bh=y6Bzb9etlG78l2NqztoQN6BbGaDS/+gd+9oPK48n85c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WxgBdEMApgC/quly/QX/Afe2gh0UF0eut++kA4vA5YCUvtqykYgNtHqCKiG/iIa/rvfb7TEy9welpOlyFQaSix6jpblrEi7M+9KjbNUvqQypje4xNXLAgL8ejfrhMTwNEkeRckZit6as1gyBGsKGGwf5CqfTlrC/OTb9xwFvKUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W27fIjDY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso17965694a91.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778829315; x=1779434115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7ZlPkIkqmKvNasnPRGcDgLQoUl4ateLXAilwoiwRQE=;
        b=W27fIjDY0dDxlWSkgCQz1LRdMQuTVbtSLS6J8+ojLLs+pyruFaMTw5b++/0H7SQyY+
         iUhPGWrdby9ZfPKzIZxW4+6hR3JacewlIq/I6fyRQXbpNLiYHgeFz4JeeegyESyane8U
         75EdRWAIIC5OiOFz7tqHVyBd3do9WqZkwN5Z6O7LRTn8+LYu2tcnGp1G5elZET92GzVa
         Da3nutNakFnh/eL6s2yzZUCNjaIEARq/iPf8BEicdVRd9FH/5bu2UuqHnt/ajAlN++L8
         mjP1am+VjPbcPBiFCm49gMXCmZbx/d9PyYdQATZvDTiwKlHhNFifW8VYhUMZS6ApKos2
         y7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778829315; x=1779434115;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J7ZlPkIkqmKvNasnPRGcDgLQoUl4ateLXAilwoiwRQE=;
        b=SAfOMjgAubQWVAGYRqdWJjq/G6un+wSazBSi8la3dkK6xQ/cjbCiBXA+TvxXUTXPNs
         62J4zZ14edS0hjFZsm9hHdhT4CdOHDlK2lyRcEGgVR8hwHCAdY0PbT2EdlgfjoiM9JVT
         B9ESk6Px6VG/iOoUy7YpP0ZxyIx2w3c1nRG0vCxeGx8cx3KxX8kMVK9sNAMO4Ve551uZ
         r+FNfRIwXyQVmK7DlZiLJ9wDq15gXg4tb4/toztsNt7BviCMvqCkzcRrk2XW7NmF3+F2
         Q6t79MCvEfcpYfyYGLoO53TYRgNvlNfaaR87dfz7xw8ZHCUfU/N0x03qH/Nl5tr1xRiK
         RUhg==
X-Forwarded-Encrypted: i=1; AFNElJ9Kc2fEqmfMlWkMT/Sm0edKPzOWSl/p3QBbybym4BUdmR6lnOcU9OIvs0PI0/9t7QO8EXB8ZR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrL2a6z9h3nEe3BHSonjsIEXqtkipifhK2grMkgnh3hN2qkH8D
	yclz0c+kOSTJn90hrWwr7nyjZ3ZFirbsLdH/0Yva5sg4fHQAoAfgFZQGWntdzX8Cm43wBnG1i8b
	0+y7/Xoclzf4E/NUNWmYJYiKp0Q==
X-Received: from pgbcs6.prod.google.com ([2002:a05:6a02:4186:b0:c7e:68a1:910c])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d9e:b0:398:bbd6:80b9 with SMTP id adf61e73a8af0-3b22eb994ecmr3197634637.23.1778829314381;
 Fri, 15 May 2026 00:15:14 -0700 (PDT)
Date: Fri, 15 May 2026 16:15:03 +0900
In-Reply-To: <20260515071504.2054786-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515071504.2054786-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515071504.2054786-2-yuyanghuang@google.com>
Subject: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2374654A7CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288203-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,lunn.ch,iogearbox.net,gmail.com,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The bpf(cmd, attr, size) syscall copies up to 'size' bytes on input, but
several commands write outputs back to userspace unconditionally. Because
copy_to_user() does not fault on adjacent mapped memory, a short userspace
buffer results in out-of-bounds writes, potentially overwriting adjacent
userspace memory.

Address this by introducing two policies based on field type:

1) Mandatory fields (original ABI): Return -EINVAL in __sys_bpf() if the
   buffer size does not cover them. This hardens the syscall front-gate
   for the following commands:
   - BPF_PROG_QUERY (min size: query.prog_cnt)
   - BPF_PROG_TEST_RUN (min size: test.duration)
   - BPF_*_GET_NEXT_ID (min size: next_id)
   - BPF_OBJ_GET_INFO_BY_FD (min size: info.info_len)
   - BPF_TASK_FD_QUERY (minimum size: task_fd_query.probe_addr)
   - BPF_MAP_*_BATCH (min size: batch.flags)

2) Optional fields (later revisions): Skip writeback if the buffer size
   does not cover the field. This is applied to BPF_PROG_QUERY's
   'query.revision'. Older userspace passing a smaller size (e.g., 40
   bytes) will have the write safely skipped. This size-gating pattern
   mirrors the existing precedent used for 'log_true_size' (verifier.c)
   and 'btf_log_true_size' (btf.c).

To support this, the user-declared 'size' is plumbed from __sys_bpf()
through the query dispatchers (cgroup, tcx, netkit) to the underlying
writeback helpers in cgroup.c and mprog.c.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
Link: https://lore.kernel.org/r/CANP3RGfZTXM_u=3DE_atoomPZXutoQJ02nOMkCCR-Y=
BZbOm2suWA@mail.gmail.com
---
 drivers/net/netkit.c       |  5 +++--
 include/linux/bpf-cgroup.h |  5 +++--
 include/linux/bpf_mprog.h  |  4 ++--
 include/net/netkit.h       |  6 ++++--
 include/net/tcx.h          |  5 +++--
 kernel/bpf/cgroup.c        | 13 +++++++------
 kernel/bpf/mprog.c         |  5 +++--
 kernel/bpf/syscall.c       | 34 +++++++++++++++++++++++++++++-----
 kernel/bpf/tcx.c           |  5 +++--
 9 files changed, 57 insertions(+), 25 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5e2eecc3165d..680607d6e039 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -813,7 +813,8 @@ int netkit_prog_detach(const union bpf_attr *attr, stru=
ct bpf_prog *prog)
 	return ret;
 }
=20
-int netkit_prog_query(const union bpf_attr *attr, union bpf_attr __user *u=
attr)
+int netkit_prog_query(const union bpf_attr *attr, union bpf_attr __user *u=
attr,
+		      u32 uattr_size)
 {
 	struct net_device *dev;
 	int ret;
@@ -826,7 +827,7 @@ int netkit_prog_query(const union bpf_attr *attr, union=
 bpf_attr __user *uattr)
 		ret =3D PTR_ERR(dev);
 		goto out;
 	}
-	ret =3D bpf_mprog_query(attr, uattr, netkit_entry_fetch(dev, false));
+	ret =3D bpf_mprog_query(attr, uattr, uattr_size, netkit_entry_fetch(dev, =
false));
 out:
 	rtnl_unlock();
 	return ret;
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index b2e79c2b41d5..4d0cc65976a1 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -421,7 +421,7 @@ int cgroup_bpf_prog_detach(const union bpf_attr *attr,
 			   enum bpf_prog_type ptype);
 int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *pr=
og);
 int cgroup_bpf_prog_query(const union bpf_attr *attr,
-			  union bpf_attr __user *uattr);
+			  union bpf_attr __user *uattr, u32 uattr_size);
=20
 const struct bpf_func_proto *
 cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog);
@@ -452,7 +452,8 @@ static inline int cgroup_bpf_link_attach(const union bp=
f_attr *attr,
 }
=20
 static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
-					union bpf_attr __user *uattr)
+					union bpf_attr __user *uattr,
+					u32 uattr_size)
 {
 	return -EINVAL;
 }
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 0b9f4caeeb0a..fa479ace854a 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -72,7 +72,7 @@
  *   // bpf_mprog user-side lock
  *   // fetch active @entry from attach location
  *   [...]
- *   ret =3D bpf_mprog_query(attr, uattr, entry);
+ *   ret =3D bpf_mprog_query(attr, uattr, uattr_size, entry);
  *   // bpf_mprog user-side unlock
  *
  *  Data/fast path:
@@ -329,7 +329,7 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
 		     u32 flags, u32 id_or_fd, u64 revision);
=20
 int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr __user *uat=
tr,
-		    struct bpf_mprog_entry *entry);
+		    u32 uattr_size, struct bpf_mprog_entry *entry);
=20
 static inline bool bpf_mprog_supported(enum bpf_prog_type type)
 {
diff --git a/include/net/netkit.h b/include/net/netkit.h
index 9ec0163739f4..fe209d1f9a64 100644
--- a/include/net/netkit.h
+++ b/include/net/netkit.h
@@ -9,7 +9,8 @@
 int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int netkit_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int netkit_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
-int netkit_prog_query(const union bpf_attr *attr, union bpf_attr __user *u=
attr);
+int netkit_prog_query(const union bpf_attr *attr, union bpf_attr __user *u=
attr,
+		      u32 uattr_size);
 INDIRECT_CALLABLE_DECLARE(struct net_device *netkit_peer_dev(struct net_de=
vice *dev));
 #else
 static inline int netkit_prog_attach(const union bpf_attr *attr,
@@ -31,7 +32,8 @@ static inline int netkit_prog_detach(const union bpf_attr=
 *attr,
 }
=20
 static inline int netkit_prog_query(const union bpf_attr *attr,
-				    union bpf_attr __user *uattr)
+				    union bpf_attr __user *uattr,
+				    u32 uattr_size)
 {
 	return -EINVAL;
 }
diff --git a/include/net/tcx.h b/include/net/tcx.h
index 23a61af13547..610626b39676 100644
--- a/include/net/tcx.h
+++ b/include/net/tcx.h
@@ -166,7 +166,7 @@ int tcx_prog_detach(const union bpf_attr *attr, struct =
bpf_prog *prog);
 void tcx_uninstall(struct net_device *dev, bool ingress);
=20
 int tcx_prog_query(const union bpf_attr *attr,
-		   union bpf_attr __user *uattr);
+		   union bpf_attr __user *uattr, u32 uattr_size);
=20
 static inline void dev_tcx_uninstall(struct net_device *dev)
 {
@@ -194,7 +194,8 @@ static inline int tcx_prog_detach(const union bpf_attr =
*attr,
 }
=20
 static inline int tcx_prog_query(const union bpf_attr *attr,
-				 union bpf_attr __user *uattr)
+				 union bpf_attr __user *uattr,
+				 u32 uattr_size)
 {
 	return -EINVAL;
 }
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 876f6a81a9b6..2c2bdaa86aa7 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1208,7 +1208,7 @@ static int cgroup_bpf_detach(struct cgroup *cgrp, str=
uct bpf_prog *prog,
=20
 /* Must be called with cgroup_mutex held to avoid races. */
 static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *a=
ttr,
-			      union bpf_attr __user *uattr)
+			      union bpf_attr __user *uattr, u32 uattr_size)
 {
 	__u32 __user *prog_attach_flags =3D u64_to_user_ptr(attr->query.prog_atta=
ch_flags);
 	bool effective_query =3D attr->query.query_flags & BPF_F_QUERY_EFFECTIVE;
@@ -1259,7 +1259,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, co=
nst union bpf_attr *attr,
 		return -EFAULT;
 	if (!effective_query && from_atype =3D=3D to_atype)
 		revision =3D cgrp->bpf.revisions[from_atype];
-	if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
+	if (uattr_size >=3D offsetofend(union bpf_attr, query.revision) &&
+	    copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
 		return -EFAULT;
 	if (attr->query.prog_cnt =3D=3D 0 || !prog_ids || !total_cnt)
 		/* return early if user requested only program count + flags */
@@ -1312,12 +1313,12 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
 }
=20
 static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *att=
r,
-			    union bpf_attr __user *uattr)
+			    union bpf_attr __user *uattr, u32 uattr_size)
 {
 	int ret;
=20
 	cgroup_lock();
-	ret =3D __cgroup_bpf_query(cgrp, attr, uattr);
+	ret =3D __cgroup_bpf_query(cgrp, attr, uattr, uattr_size);
 	cgroup_unlock();
 	return ret;
 }
@@ -1520,7 +1521,7 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr=
, struct bpf_prog *prog)
 }
=20
 int cgroup_bpf_prog_query(const union bpf_attr *attr,
-			  union bpf_attr __user *uattr)
+			  union bpf_attr __user *uattr, u32 uattr_size)
 {
 	struct cgroup *cgrp;
 	int ret;
@@ -1529,7 +1530,7 @@ int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	if (IS_ERR(cgrp))
 		return PTR_ERR(cgrp);
=20
-	ret =3D cgroup_bpf_query(cgrp, attr, uattr);
+	ret =3D cgroup_bpf_query(cgrp, attr, uattr, uattr_size);
=20
 	cgroup_put(cgrp);
 	return ret;
diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
index 1394168062e8..822d9c4c0db4 100644
--- a/kernel/bpf/mprog.c
+++ b/kernel/bpf/mprog.c
@@ -393,7 +393,7 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
 }
=20
 int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr __user *uat=
tr,
-		    struct bpf_mprog_entry *entry)
+		    u32 uattr_size, struct bpf_mprog_entry *entry)
 {
 	u32 __user *uprog_flags, *ulink_flags;
 	u32 __user *uprog_id, *ulink_id;
@@ -413,7 +413,8 @@ int bpf_mprog_query(const union bpf_attr *attr, union b=
pf_attr __user *uattr,
 	}
 	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
 		return -EFAULT;
-	if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
+	if (uattr_size >=3D offsetofend(union bpf_attr, query.revision) &&
+	    copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
 		return -EFAULT;
 	if (copy_to_user(&uattr->query.count, &count, sizeof(count)))
 		return -EFAULT;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a3c0214ca934..a46b0510d9e2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4654,7 +4654,7 @@ static int bpf_prog_detach(const union bpf_attr *attr=
)
 #define BPF_PROG_QUERY_LAST_FIELD query.revision
=20
 static int bpf_prog_query(const union bpf_attr *attr,
-			  union bpf_attr __user *uattr)
+			  union bpf_attr __user *uattr, u32 uattr_size)
 {
 	if (!bpf_net_capable())
 		return -EPERM;
@@ -4693,7 +4693,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_GETSOCKOPT:
 	case BPF_CGROUP_SETSOCKOPT:
 	case BPF_LSM_CGROUP:
-		return cgroup_bpf_prog_query(attr, uattr);
+		return cgroup_bpf_prog_query(attr, uattr, uattr_size);
 	case BPF_LIRC_MODE2:
 		return lirc_prog_query(attr, uattr);
 	case BPF_FLOW_DISSECTOR:
@@ -4706,10 +4706,10 @@ static int bpf_prog_query(const union bpf_attr *att=
r,
 		return sock_map_bpf_prog_query(attr, uattr);
 	case BPF_TCX_INGRESS:
 	case BPF_TCX_EGRESS:
-		return tcx_prog_query(attr, uattr);
+		return tcx_prog_query(attr, uattr, uattr_size);
 	case BPF_NETKIT_PRIMARY:
 	case BPF_NETKIT_PEER:
-		return netkit_prog_query(attr, uattr);
+		return netkit_prog_query(attr, uattr, uattr_size);
 	default:
 		return -EINVAL;
 	}
@@ -6260,20 +6260,30 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uat=
tr, unsigned int size)
 		err =3D bpf_prog_detach(&attr);
 		break;
 	case BPF_PROG_QUERY:
-		err =3D bpf_prog_query(&attr, uattr.user);
+		if (size < offsetofend(union bpf_attr, query.prog_cnt))
+			return -EINVAL;
+		err =3D bpf_prog_query(&attr, uattr.user, size);
 		break;
 	case BPF_PROG_TEST_RUN:
+		if (size < offsetofend(union bpf_attr, test.duration))
+			return -EINVAL;
 		err =3D bpf_prog_test_run(&attr, uattr.user);
 		break;
 	case BPF_PROG_GET_NEXT_ID:
+		if (size < offsetofend(union bpf_attr, next_id))
+			return -EINVAL;
 		err =3D bpf_obj_get_next_id(&attr, uattr.user,
 					  &prog_idr, &prog_idr_lock);
 		break;
 	case BPF_MAP_GET_NEXT_ID:
+		if (size < offsetofend(union bpf_attr, next_id))
+			return -EINVAL;
 		err =3D bpf_obj_get_next_id(&attr, uattr.user,
 					  &map_idr, &map_idr_lock);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
+		if (size < offsetofend(union bpf_attr, next_id))
+			return -EINVAL;
 		err =3D bpf_obj_get_next_id(&attr, uattr.user,
 					  &btf_idr, &btf_idr_lock);
 		break;
@@ -6284,6 +6294,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr=
, unsigned int size)
 		err =3D bpf_map_get_fd_by_id(&attr);
 		break;
 	case BPF_OBJ_GET_INFO_BY_FD:
+		if (size < offsetofend(union bpf_attr, info.info_len))
+			return -EINVAL;
 		err =3D bpf_obj_get_info_by_fd(&attr, uattr.user);
 		break;
 	case BPF_RAW_TRACEPOINT_OPEN:
@@ -6296,22 +6308,32 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uat=
tr, unsigned int size)
 		err =3D bpf_btf_get_fd_by_id(&attr);
 		break;
 	case BPF_TASK_FD_QUERY:
+		if (size < offsetofend(union bpf_attr, task_fd_query.probe_addr))
+			return -EINVAL;
 		err =3D bpf_task_fd_query(&attr, uattr.user);
 		break;
 	case BPF_MAP_LOOKUP_AND_DELETE_ELEM:
 		err =3D map_lookup_and_delete_elem(&attr);
 		break;
 	case BPF_MAP_LOOKUP_BATCH:
+		if (size < offsetofend(union bpf_attr, batch.flags))
+			return -EINVAL;
 		err =3D bpf_map_do_batch(&attr, uattr.user, BPF_MAP_LOOKUP_BATCH);
 		break;
 	case BPF_MAP_LOOKUP_AND_DELETE_BATCH:
+		if (size < offsetofend(union bpf_attr, batch.flags))
+			return -EINVAL;
 		err =3D bpf_map_do_batch(&attr, uattr.user,
 				       BPF_MAP_LOOKUP_AND_DELETE_BATCH);
 		break;
 	case BPF_MAP_UPDATE_BATCH:
+		if (size < offsetofend(union bpf_attr, batch.flags))
+			return -EINVAL;
 		err =3D bpf_map_do_batch(&attr, uattr.user, BPF_MAP_UPDATE_BATCH);
 		break;
 	case BPF_MAP_DELETE_BATCH:
+		if (size < offsetofend(union bpf_attr, batch.flags))
+			return -EINVAL;
 		err =3D bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
 	case BPF_LINK_CREATE:
@@ -6324,6 +6346,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr=
, unsigned int size)
 		err =3D bpf_link_get_fd_by_id(&attr);
 		break;
 	case BPF_LINK_GET_NEXT_ID:
+		if (size < offsetofend(union bpf_attr, next_id))
+			return -EINVAL;
 		err =3D bpf_obj_get_next_id(&attr, uattr.user,
 					  &link_idr, &link_idr_lock);
 		break;
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 02db0113b8e7..2a91f6075511 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -119,7 +119,8 @@ void tcx_uninstall(struct net_device *dev, bool ingress=
)
 		tcx_entry_free(entry);
 }
=20
-int tcx_prog_query(const union bpf_attr *attr, union bpf_attr __user *uatt=
r)
+int tcx_prog_query(const union bpf_attr *attr, union bpf_attr __user *uatt=
r,
+		   u32 uattr_size)
 {
 	bool ingress =3D attr->query.attach_type =3D=3D BPF_TCX_INGRESS;
 	struct net *net =3D current->nsproxy->net_ns;
@@ -132,7 +133,7 @@ int tcx_prog_query(const union bpf_attr *attr, union bp=
f_attr __user *uattr)
 		ret =3D -ENODEV;
 		goto out;
 	}
-	ret =3D bpf_mprog_query(attr, uattr, tcx_entry_fetch(dev, ingress));
+	ret =3D bpf_mprog_query(attr, uattr, uattr_size, tcx_entry_fetch(dev, ing=
ress));
 out:
 	rtnl_unlock();
 	return ret;
--=20
2.54.0.563.g4f69b47b94-goog


