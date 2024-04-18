Return-Path: <netdev+bounces-89218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064BB8A9B5B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC07E1F22E62
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F77A161B58;
	Thu, 18 Apr 2024 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcDuZDwS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1516191A;
	Thu, 18 Apr 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447205; cv=none; b=JOZUzIypXfRg/skOjEfSBjnfWIqyzrPtkksnQidhvYOlCm7XVoM9/dsTRmlRf93UKCmRB2LXMkA2FChouSvEOJTS3L/tMrYUqP+dMsrb70DdEIAzboYywCFDkRyW6ssL8qjbjjTUnQxcdBYyl972CpBWwx+XV/piWyiA3Y+GiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447205; c=relaxed/simple;
	bh=0VTQYJ78QzBxqF81nvpNqVGCLyn+HEz3ONaeMbi9mG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T11/whMzlJgtivpOCrK4cTNPmQv5XxwxJJzlj7M7EW1MMHvfhuQbNpYW3Dc4j6ydUnIGe6JrYGRNZ4pjKFVQ0AOttkQgR6tLKRCBn+MOz3NL1eJjSsGEUzDs7YyogSghhoW5qWx98NwvOM3/lQY3s7+8IQ23VoamJ5k6IK4UFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcDuZDwS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so484992a12.0;
        Thu, 18 Apr 2024 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447201; x=1714052001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=FcDuZDwSsvims06NRP97WDhY7hXdKKyGtOVx8rx0wGsDC7QN629z1LbUg/vRUIh4Mg
         Z7BNPyrBi7V7Nk7QFzkxzVzB28aHA1YEwvoWOJuOsjRS2ZWfypDoaARAJbPXQhAOI6O2
         uWFxYOVA4KX803B9foGtHa15LAlwBqU+Joaora5rNLUVQWG+lFkMETVJ9fStnGHgljAX
         m5prCiYCQakVgHAsOPD5zzCQIOSszkVPWHUlj3xsqIAzLLZlmVrxEegLFnZ0a83lZq6B
         SP57oPurUb/rWcf2HWpWgcBsOQ5e/XfWNPaeYVwdVsdUaaDPwgOiAjfGWsra6+vUlt5O
         ovHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447201; x=1714052001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=THcGo0qDCnVZiOB+6uiS0stJ7sVtCWL27q2MO5eZy+gC+brhs7yBeQ2jMjueuGZmyn
         +H49MumoaWen82Ej9ztxY3QyJ2qBf0R4NrTDFuvpYH5JXr3GHk17lrRXgeVjgYZS8hgc
         zs83Gm5K6lShplD4VxWrs1MFwuJLkLu/gFrlvDDs4JJvwL9SBDCvUMu8+4bOQnptlDTn
         UN3xOmHVVwA2ajAPNW7INRQAIXHmCm9snUOlLPCmBlqHF9kovZixWgPKrf7Amf5it5vq
         wVMJBpcQGS9bTo551HxurCS5CBRczVtOhURy9s3B4e4x+PiPlPamHRh7NaWFvPkOUjY5
         D2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWODAPAhqddwqH7tmNbsAkJdMOmoPnr3PZPdPqEm95NM3Rxwr4kWosOV4iRFABikJfotvGnZ4b+qPwQmEw/rnosVYST7xOYaJ4HkiN4q18+PnRMdIxT88tj2yV6oiS73zY4jxtV9X1eqobb
X-Gm-Message-State: AOJu0YwbWBMN8Dd7CzuBphD18l4wcbUm9kwyHnvP8yTCCdm1CdpnrQx/
	91LF8l/Vlg2v50Z/wWkzEz89/Zr0n7jHr86bEhlGKm9PNwsADU2r
X-Google-Smtp-Source: AGHT+IGMbYGT+4r7l48YeX26jDG6pDsGMoPErFYy8ztTXEf3VIYQtA2NVt7fUXK18aYuqwfc+8Oj6A==
X-Received: by 2002:a17:90a:f104:b0:2a2:4fa8:faae with SMTP id cc4-20020a17090af10400b002a24fa8faaemr2687259pjb.15.1713447201214;
        Thu, 18 Apr 2024 06:33:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm1448819pjb.22.2024.04.18.06.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:33:20 -0700 (PDT)
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
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 5/7] mptcp: support rstreason for passive reset
Date: Thu, 18 Apr 2024 21:32:46 +0800
Message-Id: <20240418133248.56378-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240418133248.56378-1-kerneljasonxing@gmail.com>
References: <20240418133248.56378-1-kerneljasonxing@gmail.com>
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


