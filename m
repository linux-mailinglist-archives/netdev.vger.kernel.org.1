Return-Path: <netdev+bounces-290472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJvzHIYVD2otFAYAu9opvQ
	(envelope-from <netdev+bounces-290472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:24:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1315A72BF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6252323D456
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4883E92BA;
	Thu, 21 May 2026 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTj/xJu9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB03E92A5
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371623; cv=none; b=bNpHr1BCUlF0tfWZ0P+7vB57EmFQJL8Tjig9qeEFLiO3w2zhUpCSciSTVSWCsu4WZS5K3ABKdcQ3KPfEY+FyiDTEc5Hq3NX3KoTzB2Zj/Sq2STxUxCTX97ifU4Fnf1fUCnxfNDX9IZd1ozRQcTZPxwWuEnAmzrAkGAXTh3V5tkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371623; c=relaxed/simple;
	bh=EHgHOpolMsJgH/MdJzYlHny2DKJzGcU3MGg/LHKX5ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qp1xYz91AyFmPzDUorv2Z1k0ca4M4C8OEeYsEXGg/ijXdYL7Tl7/lywhaYzxQXJHbterKmLkeDrhjiigZjFaMhzYQ7jqAfiGbGC0yID85SXE7+g78Xs/n22p1+Wcew+mIBiKQVjJEhiULw4nmc0UTHqzhkvDNXxQm+EEYsSnwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTj/xJu9; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so2538475a12.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371622; x=1779976422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdHUXdjwsPh3UPR55DujBC6V4JfFvconq24bKSSPddg=;
        b=dTj/xJu9pDixU3/HHjtsywG4L3c+nJUst7VLAiFmTWov+3J1lypV07kh4YJfseUgdZ
         D0B3hl45qCHK7WQuY2aEL0StboODJT6Z2qPkmkzDs2FP4gfywmvo4BLkUXbG38jqYZqk
         vBggFJjaPidBEqvcvuqkiP7lMc0IvdHbttO97DdDXpa1okj3DWhMg6x4UwP6JUsI0YeY
         aJLAEt3dQmyFjFhyRR167E4kInUdoMWD9hNGdPUz+j3C8h3NLGtITCs2hQUKOifmNIyL
         CGKn28gyDLVymhn3IQI0HvdB9hDpzEwpSR3kWBg0nvEK5HdMz4PtQH5tf8e4VmZtBjzZ
         XwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371622; x=1779976422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdHUXdjwsPh3UPR55DujBC6V4JfFvconq24bKSSPddg=;
        b=QrZPhLU8Z0ym8HkCs5Z5rSVldvGjJmrUF5SfKWBVYtRl8mme/913zjfAQMaTzTAvQC
         gjuCBbANRRJPqdVO3Mdbvn3stsTpvTnGjN6tG3pW/W+wCd8PIDq6CpbHChkGyaLzNa9t
         Cx4ywxp98GyLwkXjhkubA8sqZH6g0vyZKbv3U06Mem5LfcfPOIEM0K7ZIoicbGkYLW9d
         WNLjIlo7oa0HdNyC68GRBEIatW/6LiQsLMo3vY9IdYOG4ljLnf1Y3XuPpmGumgLmSfAA
         sV3Imz+RUsMX/TG0oqvGHX8qsgKH5h6XHe9zDsqowGAJjcf48H1WHPavyWJvBHTuM3NB
         BO0Q==
X-Gm-Message-State: AOJu0YzQJDkpTg9DS36gRy0xZIv3apDdOcH+q5jonUg98INaSJdnjbXY
	RvfeBTP09yB/1AGB9n1l3EnFRYAZPrFRkJjQD72pHU+8Lq2Th/CXtgVl
X-Gm-Gg: Acq92OGqyXiyVeLji8bHiEgfMdlPDdaMmptjcHKNcgkb+LzNWPqGNs8SyzBLkh2Z3nG
	v3+5/ClHaPrTtfWn3Zq67uoqZHordNEdlIUcAOtJmdIFt0lQWb+ahkZBtIa96HD6rqWAJtJdW/q
	yXkqM0yLRwkck9rNBmlvNGxsRVA2Lac+ogsYvN23daCwc8SR/NfqVbV2hlpDM7Bj39foDCNymKN
	Odswsv2+tx+ed9h87OfdIWFvszWchfXUj95EMmtdAAo0k8mTwkOJjUHG7Vay1stXtg0ADQmqCQQ
	8THuxkUvCv+/2jh2YTwYujloKjZboQJ/T9DaJFza1YBbyAVMDLkZBUuLawKBkbcgr4ACf9UHaDn
	SPW7fxF5duz7St1T4p0pPIPCKp1POuOeF4KN7Mehub2aIIN0McOAJZPhqAYzWOAymbEvrEEfg8C
	Tzg2P9zfkmpJDac5ccpr/KwAX9C45nDncTR34SI5uuAZonzcpdkweg/tOQeWD+MUUrUkN/UtG0X
	33VQCj/AJNz2No8ZzItPXmWsopiK1Y=
X-Received: by 2002:a17:902:d4c9:b0:2ba:7610:3f21 with SMTP id d9443c01a7336-2bea30a645emr30750305ad.5.1779371621598;
        Thu, 21 May 2026 06:53:41 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:40 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 4/6] bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
Date: Thu, 21 May 2026 21:52:42 +0800
Message-Id: <20260521135244.40869-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260521135244.40869-1-kerneljasonxing@gmail.com>
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290472-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sock_ops.sk:url]
X-Rspamd-Queue-Id: 7E1315A72BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

This is the prep patch adding BPF_SOCK_OPS_TSTAMP_RCV_CB cb and the rx
tunnel to allow kernel to report timestamps.

It's possible to have both software and hardware timestamps in the last
skb from this recv syscall, so the tunnel bpf_skops_rx_timestamping()
supports four slots to record and report.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h             |  6 ++++++
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/sock.c                | 18 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 4 files changed, 34 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index cf0e82e46482..14945cd69c84 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3138,10 +3138,16 @@ int sock_set_timestamping(struct sock *sk, int optname,
 
 #if defined(CONFIG_CGROUP_BPF)
 void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
+void bpf_skops_rx_timestamping(struct sock *sk,
+			       struct scm_timestamping_internal *tss, int op);
 #else
 static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
 {
 }
+static inline void bpf_skops_rx_timestamping(struct sock *sk,
+					     struct scm_timestamping_internal *tss, int op)
+{
+}
 #endif
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1e09b5cd7a39..113a2a72cbf4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7169,6 +7169,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_TSTAMP_RCV_CB,	/* Called in tcp_recvmsg() to record
+					 * sw/hw timestamp of the last skb
+					 * after receiving all the data when
+					 * SK_BPF_CB_RX_TIMESTAMPING is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/sock.c b/net/core/sock.c
index f3d78da3aeba..81a234e10fd3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -952,6 +952,24 @@ void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
 	bpf_skops_init_skb(&sock_ops, skb, 0);
 	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
 }
+
+void bpf_skops_rx_timestamping(struct sock *sk,
+			       struct scm_timestamping_internal *tss, int op)
+{
+	struct bpf_sock_ops_kern sock_ops;
+	u64 sw_tstamp = ktime_to_ns(tss->ts[0]);
+	u64 hw_tstamp = ktime_to_ns(tss->ts[2]);
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = op;
+	sock_ops.is_fullsock = 1;
+	sock_ops.sk = sk;
+	sock_ops.args[0] = (u32)sw_tstamp;
+	sock_ops.args[1] = (u32)(sw_tstamp >> 32);
+	sock_ops.args[2] = (u32)hw_tstamp;
+	sock_ops.args[3] = (u32)(hw_tstamp >> 32);
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
 #endif
 
 void sock_set_keepalive(struct sock *sk)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 677be9a47347..483ff4497d51 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7168,6 +7168,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_TSTAMP_RCV_CB,	/* Called in tcp_recvmsg() to record
+					 * sw/hw timestamp of the last skb
+					 * after receiving all the data when
+					 * SK_BPF_CB_RX_TIMESTAMPING is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.7


