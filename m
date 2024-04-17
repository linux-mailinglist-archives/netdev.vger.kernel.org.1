Return-Path: <netdev+bounces-88618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B808A7EB2
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC41285E08
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509D212BEAB;
	Wed, 17 Apr 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwepoc0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560A18C19;
	Wed, 17 Apr 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343934; cv=none; b=CymLPCe0AU0pM9+c0Ab233qcFggKb8lyfWPAlahLAcRCY1cN6jvfZvYIfpZeyHnw+j3O2RKh9CJuJixZCGjb1xNwQvIvaTNCzYDJjlYVcze3s+FMLw++cozihqmx+Gml0aWd/2xl+VnxJ04DKDAqGwJO60xsjGOfFXlvTq+Wwek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343934; c=relaxed/simple;
	bh=0VTQYJ78QzBxqF81nvpNqVGCLyn+HEz3ONaeMbi9mG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUsBOU5cUTR8wPiS2bpf+bRfSugdQ+0p9lmRCw43HD7i3AUMlx0SrDE2U5J7WhGAyHXGYwxCGsn2+bGrKNFv/p5wpOIBVLC6pXAWXTsH9EIIlLx6vjVKFFuy7ganu1ztx2p9sN61b5VI6iGYiT3tcevY0HftffVdOly4rNRCKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwepoc0h; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e651a9f3ffso19136445ad.1;
        Wed, 17 Apr 2024 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343932; x=1713948732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=hwepoc0hwEkoTkgabdoKmy+TU6HL7EaqT2m5LQ7UmL6EId7Q4qkz4+ZdV5alCKfuum
         u0K4Y08KD8zZKUr7tFH4SiBhTwQ4v4TpduJwaBL7mrjzCnxUjqsPv33lOQs8F9H6x2v3
         YyX19iiUp9l8jBNAQaERCM2hCDjAJiLTzdgJO9H3N6L+/+49O/einD9Jw9kpfrh0qiOJ
         nkF8PJuiQAHIinkGYP72IfFyOfo1IEPG4AAluF6QkRDJyaMRvzjm3oF/71Tjoh2JyQ9T
         LZfO2xvu5cIFcE45ZNrjthS4F9pV6FBprPtrw4ciwpCv4VWGQQCZmUA6wFN9R4FTR/JN
         5kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343932; x=1713948732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=vzaoZco60l/vh6frj3cllCgCAhsbZcIqMrGcgIIc0lS362H7ziLcZgVFb04GAg8OoA
         YF1KGrf9VAYQ96rQoKsk8RgqwANXcsz1xVsa7YcBMaGUPhbXeFvagEWHDpi9IfLZNKyl
         ion3tGikfqKzP7vItd1SER2UrOCHu3WyMsdSp+N998Jq9GNhgN2bHkjlAuC4gtr/VS/H
         qwHCM6nUIGUhdulO31oA0fon3pUAUWer9UglqFky6h4dT5Qi+22CVUtyLVrf6g1PobQ5
         ymJOc3+FWK9Y65Cgc9bI1x6fQjdibcWD9v4sFogymT+mJWctRwAWU9ZQN4IvLrnlr2Ar
         nL5g==
X-Forwarded-Encrypted: i=1; AJvYcCWes2N5asdu1bnnCsqhSc7oPBvmtPOYVoZCw9Sne9WqBh2rZKSQVK2MfkHHTPlsOilKpQGTv5CCjV4iGFL/J06D6Svg4vL8RHWdD5elBI0T4nTgHAQ7+mmD24Ph9bMsLeIGiMnG1xwlUKIW
X-Gm-Message-State: AOJu0YyH5zuKBw1qvcZkMZMXbYgYVdgmTj5I3Hl05XmdnzEpjA5bd2p1
	kjon3+OMgOTHoZJ8zKigGTRwkGcIbsaZE1/PNdZvaKD82/pqhGVJ
X-Google-Smtp-Source: AGHT+IGb1GCq6VCXcHLtXm6+/ujsreRYJ8WgJnDnrP/LMg8mwAcBoz7jeK4UHTFovEpjLVVRw0LdNQ==
X-Received: by 2002:a17:902:e84e:b0:1e4:4887:74f0 with SMTP id t14-20020a170902e84e00b001e4488774f0mr16829170plg.36.1713343932188;
        Wed, 17 Apr 2024 01:52:12 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:52:11 -0700 (PDT)
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
Date: Wed, 17 Apr 2024 16:51:41 +0800
Message-Id: <20240417085143.69578-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240417085143.69578-1-kerneljasonxing@gmail.com>
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
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


