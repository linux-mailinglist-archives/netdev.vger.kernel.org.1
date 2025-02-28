Return-Path: <netdev+bounces-170714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3252A49A74
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAD016958F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3630326E176;
	Fri, 28 Feb 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0W7Wfp9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61B26E166
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748982; cv=none; b=m08JMBdMZ2nMGrDIOo++iGz7HdQhj7N4p8sW9in5Q4F9tGKhh3vt3OXer2nT8rHbc7h4aGt8391PNizSpi+o4bimXvBXK9ZYPQLZbByDrnYB8eNBdW6jsiQX1OWRZn2ahJ2J9sVfExJ/OdvnLgjrfYu3sgWiubG/JaHG9/yourA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748982; c=relaxed/simple;
	bh=FTYAPGA3SjXYPOXqynWOP8ZK5fmOsZH0A+0ezoAF2ic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QddTaWmsTcnWKKIiMUytYS3sORq3tP5L/g1/+sy0WtwLOl70CrkfN5K2SpyuwUxAxAzdfpQhf3CZMzTl9uz5fwJzyxFx3UZ/bo/M3Nmv4uD9XDL7zUD2BcuzRx0uRMVWi8MAgH+XALsPT05mM3aWEvvfqslb6m/LUeCym8A/FGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0W7Wfp9; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e890855f09so51814236d6.2
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 05:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740748979; x=1741353779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4n0xFPxK7p0S/n7CVqaTwUqyGjTiJKBUlxqkm44laGU=;
        b=G0W7Wfp9pHYDcmXuxnXyX4g94ogjJQrOXzHZQcYx7ii9p/AyXQC7mGO7DnoYKEWUIC
         QladEXtEr+fjjnF66r7cv5rz6iczSh5nFaxXZqzcLQSXLwUOWMQDHZ6jtuVaiR3BZKVq
         YDnh007lLUb5IksVpeN6p6qZSYzyTOiFa0/nZcPbNoUIJhV46VVZftEw2EY68TbOfulQ
         XcUPRacjw7oEedo2ubKAMhCMvF1ayoFxrTrRT1ee1GrtAnA9iMXbRpgd4Cm1IssdWXXh
         rS/rzPEnbWHPDkgE0IUFmXRqkHUg6wKPDYt4IHM3xk/pDSCn62D2xYpuERA+zbJKMXmV
         Dxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748979; x=1741353779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4n0xFPxK7p0S/n7CVqaTwUqyGjTiJKBUlxqkm44laGU=;
        b=PMIAP/EA30iucEbMMKnKjBSMNTY2iYuAbalb1LECTSWFd+57NNxtP29U0p/FEtcqMr
         yCZt9xa95JD1qx84aUQsrjk5UI+Bc9EwbX9NfnLR1a42B5FRE9BsC+2JR+BhvK2BLuGD
         ce+OP3fVn+5z5LGJ2AdIvXnT5XNdEw33O2lR9RqOT7KErE/VDVFaSvYRXkCHBO9z5Van
         khC35lKfBaEHnEVpUn9cy5ST+VG5QTwd+skfDNNa4IZP32g8420KHr/5HyX7SDFjjN+D
         fuST1Y00xuNycVhSHJNjsywYZYjj+SkCXh5e/awG7C0fD+1wN3wm022COwoMfGbQO+Qa
         3Dhw==
X-Forwarded-Encrypted: i=1; AJvYcCUCxeSyeAxut7d4lK2tA4d8NunRcQWOoAv4sznZ+AHd4IGXtjq8EMezSygJizMw4Jql4nuT2bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhxX6pVlb4QxmVmx41e+9AmUbQZG3qr/gQnXXdsaNKw8HSFN6T
	b19fBcCXNRIRebcXX/q77lOMCwQQUrkGNSrGgG4P8nPz31Jp2AAZEQfsLNkvXbaqBFGOCksBlU0
	wKAYekEydkg==
X-Google-Smtp-Source: AGHT+IE2U2ElO05g8LFt8D2CDYzHIZnnUVe2mfEJZoO8G5T6fL+YMGKpeYj1DaLjAmZApk+AG5WT1GO0mtjmHw==
X-Received: from qvbel19.prod.google.com ([2002:ad4:59d3:0:b0:6e6:4c2d:279d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:e8d:b0:6e8:7bc8:a850 with SMTP id 6a1803df08f44-6e8a0ad9445mr56886256d6.0.1740748979497;
 Fri, 28 Feb 2025 05:22:59 -0800 (PST)
Date: Fri, 28 Feb 2025 13:22:48 +0000
In-Reply-To: <20250228132248.25899-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228132248.25899-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228132248.25899-7-edumazet@google.com>
Subject: [PATCH net-next 6/6] tcp: tcp_set_window_clamp() cleanup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove one indentation level.

Use max_t() and clamp() macros.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1184866922130aff0f4a4e6d5c0d95fd42713b7d..eb5a60c7a9ccdd23fb78a74d614c18c4f7e281c9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3693,33 +3693,33 @@ EXPORT_SYMBOL(tcp_sock_set_keepcnt);
 
 int tcp_set_window_clamp(struct sock *sk, int val)
 {
+	u32 old_window_clamp, new_window_clamp;
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (!val) {
 		if (sk->sk_state != TCP_CLOSE)
 			return -EINVAL;
 		WRITE_ONCE(tp->window_clamp, 0);
-	} else {
-		u32 new_rcv_ssthresh, old_window_clamp = tp->window_clamp;
-		u32 new_window_clamp = val < SOCK_MIN_RCVBUF / 2 ?
-						SOCK_MIN_RCVBUF / 2 : val;
+		return 0;
+	}
 
-		if (new_window_clamp == old_window_clamp)
-			return 0;
+	old_window_clamp = tp->window_clamp;
+	new_window_clamp = max_t(int, SOCK_MIN_RCVBUF / 2, val);
 
-		WRITE_ONCE(tp->window_clamp, new_window_clamp);
-		if (new_window_clamp < old_window_clamp) {
-			/* need to apply the reserved mem provisioning only
-			 * when shrinking the window clamp
-			 */
-			__tcp_adjust_rcv_ssthresh(sk, tp->window_clamp);
+	if (new_window_clamp == old_window_clamp)
+		return 0;
 
-		} else {
-			new_rcv_ssthresh = min(tp->rcv_wnd, tp->window_clamp);
-			tp->rcv_ssthresh = max(new_rcv_ssthresh,
-					       tp->rcv_ssthresh);
-		}
-	}
+	WRITE_ONCE(tp->window_clamp, new_window_clamp);
+
+	/* Need to apply the reserved mem provisioning only
+	 * when shrinking the window clamp.
+	 */
+	if (new_window_clamp < old_window_clamp)
+		__tcp_adjust_rcv_ssthresh(sk, new_window_clamp);
+	else
+		tp->rcv_ssthresh = clamp(new_window_clamp,
+					 tp->rcv_ssthresh,
+					 tp->rcv_wnd);
 	return 0;
 }
 
-- 
2.48.1.711.g2feabab25a-goog


