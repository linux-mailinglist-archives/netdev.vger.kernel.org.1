Return-Path: <netdev+bounces-86999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FEE8A13BC
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4AC288D21
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEFE14AD26;
	Thu, 11 Apr 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqm3RVBv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1C14AD31
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836635; cv=none; b=QZa223+PUJruhLY51PbpUc0ECvah7fu+3Pmtwhy1vD4I9RoH4ySKQZrnRtUgeXLoJnCFx+iCR/HW5XHMXCIj1T6rTp0d1aOzgXkdt80tsLDI8pYizQOrEVbVhluqkyDpvLYIBE9wgNK4S9yVzJmDVHbYWaVvpFjLjc1pEpUH7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836635; c=relaxed/simple;
	bh=hWy3YGmkxWsTcp/zGL5RAIH6IGzWY2P3DpM0v8axmXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NTZV6ZSggUz+L2WbgopTVs8i248+claHP59zQk6/VTAnkd7jMyzTZG1AEkV8453hx8GNMsupv6/282XM+C8BoSNdC1WzIBGotZf6Ozl6mhpi/lDZYYuwZbjgqMUuTXrVENjfsIerrguyE7WxgQdvAD9RMEqhcgWbag6iv0ynXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nqm3RVBv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e424bd30fbso31146605ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836634; x=1713441434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+ZpBqN9wkpehzV9bwSaxvgN0i8FpFSb8wa56tsf7uE=;
        b=Nqm3RVBv/UXmIuLiQlqkCDgfEpeLNCEvHmEV28ONcBeZZNrRDY/N+nd6cP8D828MTS
         eIgN8eclvbs7zjPdBs6SVl63n4e/Fn9WEq8HI2/TnCtZ+01yFCkHBGvr3wr/aOkM2sPn
         dV9LmuFO/mqUijH5RbttWBzANavIc1hwqdLS50qNeF5gRyUOXyL0A2Rx/MfknCPr7cNS
         eLk5+G8BkEX559d1W2NhZWmdarybabhm6S5s+9TNNYCaq/rlBy7uHK3y1veVIIC+6dFE
         otQM9nJYMxX5S1fK7BK4/i8ZpRoui1Z87QBqvLeNZu2W+1fbYqAjMMxj8knPXku8Ktbw
         1Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836634; x=1713441434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+ZpBqN9wkpehzV9bwSaxvgN0i8FpFSb8wa56tsf7uE=;
        b=L2BkOdRhgtHY8O95ne7S+QiU8sSk+UDjLBDvgGz8x4pDeJ5/QBkw9Q8sN9V/bPOWai
         jSXcZiQLO7mAmjeaAmRobF8VWSZD3IIHw20uy6kwW9WEeUnCJlq3KJ+bBRpgtM7h5k9y
         uA8w874ENn6IiIwRxSFf5ewFiA2JgxEzteqquFANLdQfKdevdlrKGi0WNexSKrarPxok
         S5FkGptbFIBg/M19S7SuHhIEyTBa6dXMituS2IZkSbRO0y3wEbaDqa106VdrtjIvSqaH
         7j0u13KJ4HlnUslj0LcZ8do//PjW3BCmJTqCXIjUosZXG2ZRIZxSHahHCZg4gqOKigm1
         PSog==
X-Forwarded-Encrypted: i=1; AJvYcCVosjVG4tAgixALbguIegC3/es4AVnG/nQ0pSBHgLfkBq7FfwT0Zj/d9s+Klr3xYJ+oKrr7j/AmHX0AhN2lfOmg+obgszT7
X-Gm-Message-State: AOJu0YyCGvsaI1QE3WCQH9mXRmNIyZgZdGMu8vtREAgV8+NnPH78+4Pk
	sxx2wQFWQ6OwYANdFE3JPpSqwTK7b0kpvGCOtgw0OhNFt7BzecTe
X-Google-Smtp-Source: AGHT+IE0GsoNBivZ1/ktea9PqQlxiMwaMWZZIv74Staw/lpFZm33RXkHsdNOCFeaAdnOkZ2h5KSZlQ==
X-Received: by 2002:a17:903:11cd:b0:1e4:b1c7:9a7a with SMTP id q13-20020a17090311cd00b001e4b1c79a7amr7510161plh.22.1712836633768;
        Thu, 11 Apr 2024 04:57:13 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001e20587b552sm1011840plf.163.2024.04.11.04.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:57:13 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/6] mptcp: support rstreason for passive reset
Date: Thu, 11 Apr 2024 19:56:29 +0800
Message-Id: <20240411115630.38420-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240411115630.38420-1-kerneljasonxing@gmail.com>
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
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
 net/mptcp/subflow.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ba0a252c113f..25eaad94cb79 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -308,8 +308,12 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason = convert_mptcp_reason(mpext->reset_reason);
+
+		tcp_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }
 
@@ -375,8 +379,12 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason = convert_mptcp_reason(mpext->reset_reason);
+
+		tcp6_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }
 #endif
@@ -783,6 +791,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	bool fallback, fallback_is_fatal;
 	struct mptcp_sock *owner;
 	struct sock *child;
+	enum sk_rst_reason reason;
 
 	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
 
@@ -911,7 +920,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
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


