Return-Path: <netdev+bounces-91180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED50C8B194B
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A593D2885BF
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4314199BC;
	Thu, 25 Apr 2024 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by6AxfIk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF10210FF;
	Thu, 25 Apr 2024 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014853; cv=none; b=Gk3c2r8J4UOBw8kX41v6y7EaAzEz/mVtME+PJW7sM1yx0hx67c1fS7ZZYRs3SjOF30Ca8luKgcU82noRSI3VVOUbWtOHg6XHzU+Krlfe43Is876eBWxzMayJQRxcvt4JYIRP4dwGJF+TH680CtjyRLjPurc6ufDWSLREfgY6FSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014853; c=relaxed/simple;
	bh=ZzdnPsiqXb+gwrlJNqitSNDymZ6BXbM5YRkAduTF0Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rT6zEfm64WygQQ4ceD+hfYpfhG7AiT9ivNpHvvM6bLUapZwTVd0AmuGaM+m710srfq27JiBnA9dcgvC2L4LqO64MhvbDY6BeoTPjtkFcYzEwD1X6CQBnFLcGaBem6wZOaLZPqjZ3fGbcbfWOQvE4zMBNLhIK1W4wit5cDBTZGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by6AxfIk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso1150048b3a.1;
        Wed, 24 Apr 2024 20:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014852; x=1714619652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMtORYJbYGS95Jxb6SGnELiDnvrnb/ZXbQDgC0mXKKg=;
        b=by6AxfIkJy6ylQNLS0pjnsuENOD6lHCmpT2V1lyX0g1NKvnckHQk+RT8IuleCsjyUw
         BCwqo+urtdn9a9VwRbiKp8Bl/YUF3Yuki3OfPSmyO7UBWLBhZIWF9po4Smc5MAAtpYis
         LFZ7nxT+UVOwVFcACbTTTHd7X1Ld4pm7vnEsfmvDZ3e3bM9T/CWeTr3wEdI6UbLZHuyU
         5r2oKtQ/72Hz46xZTpOH9kthGejbuvDNW31PzurJPqCYl3TXboHPbAcM8TrMor56Y/lq
         7ZMAim7XLvLv8gj4m+pD5NYcPU3vFAffmIgDl44QRU1BXFpOl74qSuC7A9QHizdgxbng
         iKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014852; x=1714619652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMtORYJbYGS95Jxb6SGnELiDnvrnb/ZXbQDgC0mXKKg=;
        b=YBmXLido6ZLC/XBNKnhjinY5JVaOdgxNLJDN0VPQig4jKs2ie7WO2eo1I5YzipK43V
         K8TP8ZC0tZYdRiSxDmdAdZa+DMRilcTH2xh+RDpFPekmDOwSDOqZvAw54jgbXMnQqMPQ
         PGEzAmNk2EpOEZTyGtCr6XR9ACrudmQMlPzwnLD8+LPAkGBM1RzbiGeg7BRfb4mJPPTJ
         u0h3JXfLcSdgKxbevmTpMjrCnhSpRaUv3DbiaTvRmUdhsSDadcH74D7UvDEdXtdg3wWf
         n+swqtYytZqTnymIfnbvDYaxO31vLi7u2PgVWUpw7DFQ1CtTj/udSAZqo5T1306OxSja
         z5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnTlZG9P3WL7dqr8qsT4pppbhJf62a3KiKJPa+/saMD0fPmeNI1VjSsoZFAfJonE3HLAt8RAo2YlzXZUApwwGzRNVmwczTAvyNcFSg9tNzXN9LgetbJId4VtxffDUIZpyXsHaepbBoSknN
X-Gm-Message-State: AOJu0YzfbxjrIB0eVC3gVh7bcAQtmjqcpKxQGSEdjj5VzQzX1wy7lgdx
	Es9YFBaNR+iOafB8/Qg/CDOVmJV7ZOTuMBS2D94LRf8S5nAyy6Z9
X-Google-Smtp-Source: AGHT+IHrRlMjZbB3EeKQMBe+MK774H9qalWmFJTcDp4e7CQEiCEC7v5c1cJQZnuGPwrmYiUrvX7Dqg==
X-Received: by 2002:a05:6a20:3c92:b0:1aa:954f:d466 with SMTP id b18-20020a056a203c9200b001aa954fd466mr2428226pzj.23.1714014851801;
        Wed, 24 Apr 2024 20:14:11 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id gm8-20020a056a00640800b006e740d23674sm12588884pfb.140.2024.04.24.20.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 20:14:11 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v9 5/7] mptcp: support rstreason for passive reset
Date: Thu, 25 Apr 2024 11:13:38 +0800
Message-Id: <20240425031340.46946-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240425031340.46946-1-kerneljasonxing@gmail.com>
References: <20240425031340.46946-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It relies on what reset options in the skb are as rfc8684 says. Reusing
this logic can save us much energy. This patch replaces most of the prior
NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 27 +++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 22 +++++++++++++++++-----
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fdfa843e2d88..252618859ee8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -581,6 +581,33 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 	WRITE_ONCE(subflow->local_id, -1);
 }
 
+/* Convert reset reasons in MPTCP to enum sk_rst_reason type */
+static inline enum sk_rst_reason
+sk_rst_convert_mptcp_reason(u32 reason)
+{
+	switch (reason) {
+	case MPTCP_RST_EUNSPEC:
+		return SK_RST_REASON_MPTCP_RST_EUNSPEC;
+	case MPTCP_RST_EMPTCP:
+		return SK_RST_REASON_MPTCP_RST_EMPTCP;
+	case MPTCP_RST_ERESOURCE:
+		return SK_RST_REASON_MPTCP_RST_ERESOURCE;
+	case MPTCP_RST_EPROHIBIT:
+		return SK_RST_REASON_MPTCP_RST_EPROHIBIT;
+	case MPTCP_RST_EWQ2BIG:
+		return SK_RST_REASON_MPTCP_RST_EWQ2BIG;
+	case MPTCP_RST_EBADPERF:
+		return SK_RST_REASON_MPTCP_RST_EBADPERF;
+	case MPTCP_RST_EMIDDLEBOX:
+		return SK_RST_REASON_MPTCP_RST_EMIDDLEBOX;
+	default:
+		/* It should not happen, or else errors may occur
+		 * in MPTCP layer
+		 */
+		return SK_RST_REASON_ERROR;
+	}
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ac867d277860..fb7abf2d01ca 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -309,8 +309,13 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason;
+
+		reason = sk_rst_convert_mptcp_reason(mpext->reset_reason);
+		tcp_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }
 
@@ -377,8 +382,13 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason;
+
+		reason = sk_rst_convert_mptcp_reason(mpext->reset_reason);
+		tcp6_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }
 #endif
@@ -783,6 +793,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct mptcp_subflow_request_sock *subflow_req;
 	struct mptcp_options_received mp_opt;
 	bool fallback, fallback_is_fatal;
+	enum sk_rst_reason reason;
 	struct mptcp_sock *owner;
 	struct sock *child;
 
@@ -913,7 +924,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	reason = sk_rst_convert_mptcp_reason(mptcp_get_ext(skb)->reset_reason);
+	req->rsk_ops->send_reset(sk, skb, reason);
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3


