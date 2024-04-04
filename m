Return-Path: <netdev+bounces-84716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD76C89821D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 09:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA351C25C41
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 07:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317715812B;
	Thu,  4 Apr 2024 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiIr335E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07475677D;
	Thu,  4 Apr 2024 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215297; cv=none; b=F+Efb6nYRuw7JzULn1/dd8yjpCN0JD90QR/C0VQzhwVt2+wMyjdE7Vq/oJWU5efDzChGct3ihzv8n2dsxWRy3mqChq1XWoRTGfDCWLc8MiCE+VH1JsXZaHE5yZKRtZYiQ0KviqYqrWQGo7fA9uSz0uClWG7hm33hC8QpZt16k3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215297; c=relaxed/simple;
	bh=YJHF94tDUSTWCiWPr7aQkKYgxgeg1GDBFAggrN+81Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6AM+jYaa6lHi30aQOqNABipEHWk3ocSMIGSHv1LiqXcvyuvbCtLsxoFBflKPoAfe8gUfHf+sMpnmyQ3c7AsX+iw07lyNqnuB5u2Zhxd4DaahdM8uNpYOOy0uId+o7VRgPRp+qqQXZYdBa5VIi2yadzQF45bANB8VmltCZTfe7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiIr335E; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0f0398553so5775175ad.3;
        Thu, 04 Apr 2024 00:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712215295; x=1712820095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zCgjlonmz37DPEbA0Oytli/YhfsEeASyIn4O2vwvxk=;
        b=JiIr335EoPjD1xctYMQYToshhTcJ5mp+L/BC9R6evWKa7vASfoKqF3n0ebGcBZqaJv
         r96+rp7iHLGbozH2aqFvXXInjK2G050PI+rUimkUf0q6InfENLNUnUDQTeuMbfXUOrVC
         iMZPdep8Kh9L/5HW5Orh/363icoWMMpz7Kd3l+cxLnxqKYuIBHiD20q2JfRgR4XiEV5N
         BOVlxp2gUykEHheAAySqPgQXS1LIKn3pm2/+BjBNTf3OaeQU7oulETzndht9SbwtRuQw
         oEyYDhZz4VHtcGiusG6WJdGvgivfKwnpZzrZOQJYkfn7iI52Fl2OMwjVcTx5ofLjT5Dy
         6kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215295; x=1712820095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zCgjlonmz37DPEbA0Oytli/YhfsEeASyIn4O2vwvxk=;
        b=XApDuuDloEF+I9VD+X9KYHACpVL1DLR2WUXyp8VMLaMDOVtpGSQhrkYj78ReGSBwm5
         HQSRK2W4bWwT8Gfn9qTdNLTJhjYtPNy+UmGm7Y9ddKYd9kkDXmYD7LE4Zfzpx0NIIq2I
         zBjTd1drbYeyjginxm6IKP/QXsKRBQGXw278rQmu/wrg/b7g4Nb0R7wLIUYNyqWUujMm
         z8D0bvaG1rYmIqM7QRg8SI/qYrSMhHvE8pUC4X54Ccb0L7jDOyfyaGedqJvxycpKhQ7w
         brOWZaMCdP6Wym3etm3/UwONnzqtIN048ljLbbdNhIl8+RoccN3OthTVDm5WYXe+1jwg
         djWw==
X-Forwarded-Encrypted: i=1; AJvYcCWMWXVSn6B4PIdwHSzxPdMbd0GLLxK517EBB/tE+UQA5bxORpx3DPovzEQQNf2nd2pxLqEWmea9NGu1PXLaZkFGMmC8BxaZGvjXLw1If+Et+POxqxw+5tVT+oj/sgz3y1IvgYVMbA6s2eGE
X-Gm-Message-State: AOJu0YyxBbp5zJJOaHbuXJKS/+2u1JV76BIiR3MbbhElcJCgSRh5YeZo
	zc0VxFTJlUVZdvcHkKb9CO29kiPT3VKHVjfk3muz2chxXvO8IPVV
X-Google-Smtp-Source: AGHT+IEa5+T77JAdTma2XOgWwr9eA4re9vQQ278n8wGaPTDE+cp9slsp+aNVcEu07OClKPDzo6pJhA==
X-Received: by 2002:a17:902:ecd0:b0:1e0:e8b7:1fa2 with SMTP id a16-20020a170902ecd000b001e0e8b71fa2mr1782922plh.21.1712215294850;
        Thu, 04 Apr 2024 00:21:34 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001db5b39635dsm14606399plp.277.2024.04.04.00.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:21:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/6] mptcp: support rstreason for passive reset
Date: Thu,  4 Apr 2024 15:20:46 +0800
Message-Id: <20240404072047.11490-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240404072047.11490-1-kerneljasonxing@gmail.com>
References: <20240404072047.11490-1-kerneljasonxing@gmail.com>
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


