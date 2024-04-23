Return-Path: <netdev+bounces-90368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86028ADE28
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4891C2186C
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2E94655F;
	Tue, 23 Apr 2024 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKy69j8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1181C698;
	Tue, 23 Apr 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856929; cv=none; b=O0pyFLPy7un9GjHF12BIotxW84myP+CVAD5ERTryj30+lww2RmiAKRI+WLzotHnG6dxH1/m9JvoQQ7UIIYfGPLRbF1PhEWSsUBYRFHcbiQ+GcMoc84PiRNkmzJuoAv0WEaIn87DbimNSoGwTVxP6ijOqvo6ra4+FITop3mrq0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856929; c=relaxed/simple;
	bh=OtI0qpXQDeqz30Gp/wuADu/hSlBB3PVvmN9MSoBAOsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtzZ1Iu2y7WDa2EQHvfJOZer2i7dOwfn2Sc9wK2KqbnpcahiyAi7UH7VZEn56YKQoT1BN8wTqzu4beqU9UGBUjdbN92NVFRYRijnQYxZQoSRpYcsYPfujjVWOq06QK+UiOIVS3FkvP3/tl9yDGJWLdwweS5hyjtLKrpWaghcTrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKy69j8Y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e5715a9ebdso43599345ad.2;
        Tue, 23 Apr 2024 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856928; x=1714461728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HYxE6qPJ+WBlSk1qBaTkX3iWt23hXj5IwR3Pv1tiJQ=;
        b=PKy69j8YPYQX05hsGYo+MkEjobnI9vPrSOwUmsRTair/tmXuI3pL8RnsWCXpBWqxEF
         Plh0HkFUS6+JlGB4xtizWrygQP8vm2EXFBeayTxesJQZj+ifdwIKWeHbZ/pDMSi/B10W
         Y215Bf+7AM1NdvFdnVIRjkqqrsRQEg5/Lwd3qULmiEMBtDqPhHbIhoxf+LTuSl3Ml0wp
         7TIexXceoBtXJCaXAtpAE8pgr1bgJ8PLO8vXwiKj6kgzHyIV8g/yQihbs+qdQDTtlzNy
         xOYmiE6ZOVkXLm2ok3Z2f7vSSPnZEgw0pYQsfH1l150QIZEw0TwVlG4Ibbn/0PkPxcAt
         cmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856928; x=1714461728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HYxE6qPJ+WBlSk1qBaTkX3iWt23hXj5IwR3Pv1tiJQ=;
        b=HLn97bmBhKANiZibF7TKVcNp5u86A7Spqiduz4+0DKsBQwVDY+58urrXlZ8xKLS4AN
         HZoc4mc14NzbcJCYvKhPl+/Y1/FG7lSHJDOGt4IjRTaj48GNbaoJGDW+b59xblzLkIVN
         iRUz47UKUHp4gj7fXwVG9GY88LjsfVCChA10MabnDKNFsuBfjC8x+USUkbsj3iNFazHf
         y7g32FTvZpdVIL3i3KZH3K6vHJUbwXO5fN9NakHA9iTOrNi96eas3qf/BLI4BHjaMw2m
         TQXslWvsOZvZZF0xJV4DAO2ietJqYIdt19snFjKThTCw77hS7uxC0BuNlMBIrbiPLm72
         uaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1rUnPiPnmoXZ4xjJ50gyy/Igs/hkWBKnWw95f8qfvvlhMgVA8d9YIYPJXRuX0V/cpvd7gcN0n2ZgxotalP1sl2HXWHQ4s3LLfCSGyK8WPr9dTAZHVZgPdy8BqKM3IdWCHTjUOd4Skb23I
X-Gm-Message-State: AOJu0Ywr0npD79X4KW91ZuGUHLqLV6ckedUyp+sUBvfOa46grXKLCGiX
	rG304oxJUdY2sR8pvom5OdCgjJ4xljxasTVY6dSnOgV5vgFEOwZv
X-Google-Smtp-Source: AGHT+IEVW3odWsBwH1bWV+MNF8o8UTAxXCCe8RNadga8mLZQiYMzT0wopshqT5yVbAmB7lCw+R+WCA==
X-Received: by 2002:a17:902:e84f:b0:1e3:e0ca:d8a3 with SMTP id t15-20020a170902e84f00b001e3e0cad8a3mr15113788plg.6.1713856927962;
        Tue, 23 Apr 2024 00:22:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001e0c956f0dcsm9330114pla.213.2024.04.23.00.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:22:07 -0700 (PDT)
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
Subject: [PATCH net-next v8 5/7] mptcp: support rstreason for passive reset
Date: Tue, 23 Apr 2024 15:21:35 +0800
Message-Id: <20240423072137.65168-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240423072137.65168-1-kerneljasonxing@gmail.com>
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
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
 net/mptcp/protocol.h | 28 ++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 22 +++++++++++++++++-----
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fdfa843e2d88..bbcb8c068aae 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -581,6 +581,34 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
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
+		/**
+		 * It should not happen, or else errors may occur
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


