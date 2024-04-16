Return-Path: <netdev+bounces-88296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B698A69CB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1D228319C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C62C129A8D;
	Tue, 16 Apr 2024 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y13cHZL6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44F1292FF
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267640; cv=none; b=i8XLltc0M89NfcWpimHga/IH8pRw98cgIc96ELP4KjPERX1ApenpcYgqkVcN/OrlAjxZrtLcG/Roln1TsaffWKYRhfW4jEsPC4HIboe6x5sboqh1tkn/M/DMAK1qYnEOSojISWgVDmIXB11cvgP0FAcdp38cNdbimjHanNdxZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267640; c=relaxed/simple;
	bh=0VTQYJ78QzBxqF81nvpNqVGCLyn+HEz3ONaeMbi9mG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3UBJIdPNLbzE5HRxFQfPxTJbQz/8ZS1SA2QqwiB72wuNTD7ET7dyaUaKb84RFXOvyMMjlzxLWokeGVAeuFqgALc/naeFnfm8+3jXYryuhO/9iFnMhWgnYV3Mnf5lQzQH5nV61MG124OSEaW7za5mfWudL4OCFD7H+i6Dk9aIOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y13cHZL6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so3795170b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267638; x=1713872438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=Y13cHZL6mRYlxxUwlZmxo7II2wKO6TOBkaavawC477RxuiDOJXpAxL1OT8KM+/cM+Y
         WKx39zvr5VCp8Lcnx80j2Wm0bQm8u1uwQ1Cin8N+MAvHY9P+ngV9mkzqz0arm1N8yc3v
         D04JLgzkWJLrT6QL8h612w/+oENPBsJAHJ/6TcvtUX7gDbTUv6JMS/MKaCG40OELz30H
         gbNTM1MbwV3r9H1aeXBUVUHtmA4RyeiR2kfLdXN1tK9ExPo8+O2SAGxwUeBYcq5i3jsm
         hMamTAv3EvDJuo4fEt2PIiFwl5fZHdzpls7H1mWEuDaQGYa+wEObdWewTPD/a4WPaOfE
         0uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267638; x=1713872438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=IULLvmUUlcOPs6WDJyRRsaBAUBQpK65kbtFgaLKSJTQ2JY7mA5uzz0rlLxIahjeQl6
         8XVesF0WJ72HyLkEl9PNwWenS2OIdV6s6NEagyiLmfKbu3t6t+ZQJb3EqifmZWhzBn/p
         SEOqlcQDa01BlT7QHvkFzLvEigR3F8nG11ZzreDCOfCB6Mdt0ZHQIydlEYMR5nu5ntdo
         koyr6HUx3bO7onMSjF7fZidcHwUnJqTkAqBgjKKpLGUfHrxLzCvL8MY3g+l1cFoxwlAO
         b4CPA02oPpwjxSFOtdhzK2eNHnVPP/s2qeWHCGjAMV+J5U38Ibp/qii01Yw7+Bd7qXb3
         KZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFgh/BEjNNGwlQrNP+VThSWdPaHdKOO6Mzh6P7w/QkW/PXxpM/VVEzB1SUbVZzBFkQdA5YG6NStSlTVnX5ecr+JRV7evJs
X-Gm-Message-State: AOJu0YyXXGjNIDqIQo6Xns+1WycJXyGACqHxdLeuHMUuBEPawewoRoH5
	m0e73OkQkpD4b+7ySIIKTB8ksltyNqVE5ND4g2PpNIXX9AC16wC8
X-Google-Smtp-Source: AGHT+IFe+4nCe+cABIheFzccWhrHioYgnYZncmu/Al9/d2IKxv2fJ/4SVd7hf79T+RJDu8mJNzEp/g==
X-Received: by 2002:aa7:8888:0:b0:6ea:8b0c:584 with SMTP id z8-20020aa78888000000b006ea8b0c0584mr17359372pfe.9.1713267638254;
        Tue, 16 Apr 2024 04:40:38 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b006e6c16179dbsm8862045pfo.24.2024.04.16.04.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:40:37 -0700 (PDT)
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
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 5/7] mptcp: support rstreason for passive reset
Date: Tue, 16 Apr 2024 19:40:01 +0800
Message-Id: <20240416114003.62110-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240416114003.62110-1-kerneljasonxing@gmail.com>
References: <20240416114003.62110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It relys on what reset options in the skb are as rfc8684 says. Reusing
this logic can save us much energy. This patch replaces most of the prior
NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/subflow.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ac867d277860..bde4a7fdee82 100644
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
+		reason = convert_mptcp_reason(mpext->reset_reason);
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
+		reason = convert_mptcp_reason(mpext->reset_reason);
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
+	reason = convert_mptcp_reason(mptcp_get_ext(skb)->reset_reason);
+	req->rsk_ops->send_reset(sk, skb, reason);
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3


