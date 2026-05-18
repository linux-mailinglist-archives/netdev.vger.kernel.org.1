Return-Path: <netdev+bounces-288931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JxSEvzOCmrv8QQAu9opvQ
	(envelope-from <netdev+bounces-288931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:34:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8D0568E03
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AC7F304F381
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BC3E8C75;
	Mon, 18 May 2026 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwP93Hes"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCDE3E5A03
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092674; cv=none; b=IDF2jAUf8nQT2Ee/NEuka3p9D2vcI5YaF/D5NwECTVq9riKqwKFPTqvMCTmX9jeIEEnFHSnOtrw8eGzipVhuVTtMANN23ODboGOrNTxrUXqwrVI6BmbEyzo2JwvnQ3iYSdw/kK2+kQY4nCRVz8ENZLEIsEOP1dAZSG+XBaYudrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092674; c=relaxed/simple;
	bh=EHgHOpolMsJgH/MdJzYlHny2DKJzGcU3MGg/LHKX5ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lukrdfpoxaQSKOPhWJCl+uSsrsNGstqy6K8wUS3nlRcnmlLIRo1o/7s29JE9Zc/U830ey614sSBtitgpk7CFqyKr5NUUfK+EDXOso/tXU1k4EPWAGz1c0fDi1HwkFsaKz0jHV7GcOAeTFkAwLUWcG6zMx4RmJDExfcmM4AmTwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwP93Hes; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so1079996a91.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092672; x=1779697472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdHUXdjwsPh3UPR55DujBC6V4JfFvconq24bKSSPddg=;
        b=SwP93Hesd5/P/yy53oE2bFJn0hZHnoExuhk4V1FGeiP5VlBx5DPauDH7r3eD0Py6d3
         vETeNzIY6nHwcy7lAwuR1v/46TQ96foZOyzV9yGvAj6D3EMZX2xIgnL0phO2ndEsbxqA
         pW7bOvYazSu9xUutMyq78hDFD1JzhE3U7yQqPXwPTvsDm6uc+1HFwPoPyrDpEJZiV/m1
         5nJHu9+NiTDFOMV+Pfi3dnnr4cYGDhSkr6ecHrjDtwxDB4IYwa5pUeJiSUlkkGlsgm1c
         D+5rGTZQWux5ZV+HgmyYy9au+hr3ugFERP5/frj2enjlRO1sgz2SjfZZwoSn4QSa+x94
         vE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092672; x=1779697472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdHUXdjwsPh3UPR55DujBC6V4JfFvconq24bKSSPddg=;
        b=IDZ3TsQllLzR4/UzaK52SZHqnx+Eb704g/3Uz4E4Nd8b1+0EObQkZJriidB6SPiZbB
         mxazY18V1OzjwDwqHvgdVtpsqRwAlVKhO4TaqtZtPiLKmPWIcRjaJ/9niOT2Ls3/F8UD
         VofEvJGAcfUKt/Y2H9DzkpRHh/tzlsC/knkyKzVqHdDIDOBXu2WXDjlN60GwFlsrGCcI
         4rWAJzPT1dXHzODuj2o0tePhfxdrrj9ryUyCBdxyl6mVIcEmCXGgipTy7Qv42oUky/F2
         9ACQQjkKCKW7b8qc9ksnPDjO7Te/K3DghPl9mkSbLHxlQp5JkjHlGH7QYpTns8C6+Qww
         qYDg==
X-Gm-Message-State: AOJu0YwvE1+ENkvMfAfDPXftdIAFumd8QInSQkQReocCSnFHzwnFTgxJ
	tVy3AOvQTaUQkQSYI2bZ4GkMRn7YVpapOsC60WvK47g1rEGueX6DBOOk
X-Gm-Gg: Acq92OEQxL4hrXD10mGojr1CSPYjqXxzX1/mSspfT20OKlCNlt1eX08UmUaUUHQkCSZ
	14iH6zR7S/r7lNHRLrk8coU52i+tJfZn7ro1pS69u81YMDn1MOy+H/7pNEkcvKLNVDAL3PtqiV0
	QmjlYmITJ7T0tnw6TPtUZtDI9YODnElr/NlStXf+4WT9jBtBnVjkfLifKph+WSSpmiO0VaoVWE6
	6an+htiFEItG0VHhI3NVbNaVtdqSjz6FTA/S1VrY4dhXuVfhHNCIflXFU5C3E/9VnpzWXbgpjX/
	WxaosO6ew10LaeoMmvfYkBKLLDrfZATXhYyn7Lz9h8ijcz82O0EUZbUCGTxqJhnvzDq/gpYeZOC
	JHfAieeidha+mZUO0EdXIzhU22h6n6IPr3uSmZbNgoRsKBr26kaN6h14QSNUJxcTTRLTyjP/K+1
	Oanz90Tl0PSFf1Bk7HkHGpJnGlNeHgsaOyQ+6y3lokg6VGcF/dSIygO+vvPeE00vSyPe6jB2f/E
	VA+DOAxrTRs+RitFU0so22gs667cQ==
X-Received: by 2002:a17:90b:38cf:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-369519c6bcfmr13392257a91.5.1779092672232;
        Mon, 18 May 2026 01:24:32 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:31 -0700 (PDT)
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
Subject: [PATCH net-next 4/6] bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
Date: Mon, 18 May 2026 16:23:42 +0800
Message-Id: <20260518082344.96647-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB8D0568E03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288931-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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


