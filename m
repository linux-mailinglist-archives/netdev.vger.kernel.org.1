Return-Path: <netdev+bounces-84295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1E589666C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACC61F2154E
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 07:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8525C60D;
	Wed,  3 Apr 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBjPf7v5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562B58AAC;
	Wed,  3 Apr 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129543; cv=none; b=mHmOHiMLTnF9m+qZVka5h0Xw0PTF6k0T4VtTPNk6vQ/lA05OhyVzGcXMy2Kj6+9UiMspcfRP+G6517soidVg+6kRX7zl4Su54uUluLRojc497WpMDqFISO/j+rAPhKrcQ7tfLFBVWG9UkNy6pGdE9xbE+9iNnacMLZg6cCmZo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129543; c=relaxed/simple;
	bh=YJHF94tDUSTWCiWPr7aQkKYgxgeg1GDBFAggrN+81Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sD4UrIeFifl/1LSPTVX8TIu5gxWW2GV6uvCJSY8nQPFWFJcrqj5r7g7t8TPUl2Yx0CbevcSBctHoU4/13xKQrK85j7x5G2e/qBEAf6rIqXMOm3o4HqELGb5L+KZLL4zonhQpe6INkUji9BDylChEy1bo3s3f8DmHmp4I/zMC2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBjPf7v5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e244c7cbf8so28333915ad.0;
        Wed, 03 Apr 2024 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712129541; x=1712734341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zCgjlonmz37DPEbA0Oytli/YhfsEeASyIn4O2vwvxk=;
        b=MBjPf7v5wdvJWSm88QtDY6d926euwW9svVyzJjcMIZm1h1Y7KQ1d82qxxwbqprcDqN
         2SsA1pFtc8Su2ytlYto8uQDVfVoq0amdAvTrEpPJZx/828xj7FQfdg2wBD/CVvIFrBwt
         6lF3aUbdA+ThDK1Q9jMuJKQ81BUW5ss3TEpOBzIBIbgEsx0tadyTSvvSulQ0NNxrGJkM
         TAHyCziWudNkVnH8bnQsOJG/VRNe0TCFAeL3etvL3p/Xn0ZqqAVbo80SNVmaPsIQSBA7
         lDgUENPY4Nwuja2+cHi36L5nyCM9xLEbUJVQtX8s8BI059pt6/igPrueByyXkBj6iR6h
         UqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129541; x=1712734341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zCgjlonmz37DPEbA0Oytli/YhfsEeASyIn4O2vwvxk=;
        b=NMkRHH6RkkzPuROYKf8BMBp85F3eadprPLmFTCmgA7JN4MO/s9qPo3J4IQWcgHwHOE
         rw0RkacX74P5LR4Tb7orSdSVndtBtDdyOo/YfuPohWsXIrX3NqEcQUTjR3pHgeQlMz6p
         m5UDGg8NenyCfkYwj2ZxGVeE46AJ5vEh7XnVyz7q2oSw7IoxqTqwdeulBbbDhDFTGBAn
         ENAjuc++1Zvv8sYd7EhCx7oFlRfzD5BZ2fxsa/6s7Gxnd/zNGZ1FpNqIwIlpCz6L4wKB
         RPeoh9gtqDvnyoW19ujTNnuw+sJ16sfxm43l2QiuRCpqhSknLrvgzb9pusry7fzur57c
         +fbg==
X-Forwarded-Encrypted: i=1; AJvYcCVYR0+vc6ZkRl+befQUgpIDjAASPk5xE6WiFkPy1DyeqkRKgQ0PjZ5XqnRtlOw0oQAq1+/yHDrTZWgf01eTzi1f1nlXmxhcFU0qLQ+9iiExWDl8ke1gGvG7tWhMw4weaw9dmfZvNuVRyX77
X-Gm-Message-State: AOJu0YxABKMILwRJodVz+YkdzMTP63L8kpVNwfV3k8osIpzJEov10Lgw
	unT5oIjnQlKlzHfic8bZ5y4KDaecVT7kQ8xdihQO3SXuq7Km2Tt+
X-Google-Smtp-Source: AGHT+IGQjU3jEmF0zn6HJ43TC+8/OqIPRh3EVeutbaaMEY/geLwKt4KxdUvOo/y5b7ARumXYuHjDzw==
X-Received: by 2002:a17:902:f606:b0:1e2:88fd:c220 with SMTP id n6-20020a170902f60600b001e288fdc220mr2055084plg.44.1712129541416;
        Wed, 03 Apr 2024 00:32:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001e03b2f7ab1sm12563067plg.92.2024.04.03.00.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:32:20 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 5/6] mptcp: support rstreason for passive reset
Date: Wed,  3 Apr 2024 15:31:43 +0800
Message-Id: <20240403073144.35036-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240403073144.35036-1-kerneljasonxing@gmail.com>
References: <20240403073144.35036-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It relys on what reset options in MPTCP does as rfc8684 says. Reusing
this logic can save us much energy. This patch replaces all the prior
NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/subflow.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a68d5d0f3e2a..24668d3020aa 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -304,7 +304,10 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 
 	dst_release(dst);
 	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		/* According to RFC 8684, 3.2. Starting a New Subflow,
+		 * we should use an "MPTCP specific error" reason code.
+		 */
+		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_MPTCP_RST_EMPTCP);
 	return NULL;
 }
 
@@ -371,7 +374,10 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 
 	dst_release(dst);
 	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		/* According to RFC 8684, 3.2. Starting a New Subflow,
+		 * we should use an "MPTCP specific error" reason code.
+		 */
+		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_MPTCP_RST_EMPTCP);
 	return NULL;
 }
 #endif
@@ -778,6 +784,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	bool fallback, fallback_is_fatal;
 	struct mptcp_sock *owner;
 	struct sock *child;
+	int reason;
 
 	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
 
@@ -833,7 +840,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 */
 		if (!ctx || fallback) {
 			if (fallback_is_fatal) {
-				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
+				reason = MPTCP_RST_EMPTCP;
+				subflow_add_reset_reason(skb, reason);
 				goto dispose_child;
 			}
 			goto fallback;
@@ -861,7 +869,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		} else if (ctx->mp_join) {
 			owner = subflow_req->msk;
 			if (!owner) {
-				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				reason = MPTCP_RST_EPROHIBIT;
+				subflow_add_reset_reason(skb, reason);
 				goto dispose_child;
 			}
 
@@ -875,13 +884,18 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
+					reason = MPTCP_RST_EUNSPEC;
 					goto dispose_child;
 				}
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
 			}
 
-			if (!mptcp_finish_join(child))
+			if (!mptcp_finish_join(child)) {
+				struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+
+				reason = subflow->reset_reason;
 				goto dispose_child;
+			}
 
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
 			tcp_rsk(req)->drop_req = true;
@@ -901,7 +915,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	req->rsk_ops->send_reset(sk, skb, convert_mptcp_reason(reason));
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3


