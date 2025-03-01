Return-Path: <netdev+bounces-170967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718E7A4ADC7
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 21:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615BB1892A89
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36A01E9B1A;
	Sat,  1 Mar 2025 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iH1ae+D4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392B1E8320
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740860077; cv=none; b=h65vdXPx41GpjKjpmxEmgncDuboi0Ip/bmusgf/x14wFL3L6uvA4nhIuqZea/m/rY2ykKQd3Kgu9UbvBj1SQecAuDpXLVM3gBZpoxU2FsMX8kGlviclOuuZniWjeZr93fk8YU1FGnB0i1wqUaUj8clzvRQewuZX/+X6++8G5fBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740860077; c=relaxed/simple;
	bh=FTYAPGA3SjXYPOXqynWOP8ZK5fmOsZH0A+0ezoAF2ic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R4kScBxEMgUpUUaKoYnEdg1ibLHqK/+KDvY8gB+ehGKnCYiVUkuwZrkk0QqGX5jaLbYBLJP+qSU/Dq9Gg2gj4USNno6ZWkGYsSClxYT3EwOXXY7RRGudpIeFQWk6FD0izAfydzpsz0D603WjupuzO/XYs3itvdIVDF49TC+igU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iH1ae+D4; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e67c58f0f7so39751686d6.3
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 12:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740860075; x=1741464875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4n0xFPxK7p0S/n7CVqaTwUqyGjTiJKBUlxqkm44laGU=;
        b=iH1ae+D4+1SESWaSUWbRepfctLzamfN87ZnXM0Mvanq4jN9LPk+cF2mpKj80p6hTAC
         CxXy9driMx/W9HVDCKPKm5Y8s3pxjvMGr/5n+7696DsuBFTVL546LCybspFMZfyZbidb
         AkyjSglnm2D3JXUyitavHpRL5887rcHtmRak5k0DaP7IWJ4DLY0hUIsdEtOUw0uKI7R5
         h9Nq3Fw6kKbdT0MQUfMLcAU6MdaUtMKVBdTm8LF527uIzkwEDvMH4/LJbOGxCa+S/yfO
         ABsQXAaJ9wPdFvKr/cxzIRlIlt7wNhdL+IBQdd9Hj2UDOO3mX72d0jew/n42Y9PVhYDB
         IZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740860075; x=1741464875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4n0xFPxK7p0S/n7CVqaTwUqyGjTiJKBUlxqkm44laGU=;
        b=qGQqtNBRMl88GNOdk88+9UPf2X8QrBYM/RhOqwDX/PlrwHPwaypoN5hTLQEGYLvb+Z
         Gx3/0FKaM8ccbFf7x1THpnRHcJg+Iz+LgYFaF5IsaPPi31sQRa34sS3TgLVsySre6yTy
         3DOGyVf1dgnm8kXr7lOktdtkKqsoTMJxNKqTryyM3MKMtNKSYlVl9ehMNwaJbaBO9xzx
         dXARQEe0e31t6JM5HoaIb70+XH5yRhiJaHi7s7yn/LtIKn+JcLlqlv6fTApvuWg2Vu13
         YRO9fp3gtbUFzr+IhaJjMJ3LyjRfC93I91BC3EcOJEBF4eP12OIHmxzovaDmzZ3gv//V
         xb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxYoRDMsu1uMx2mo6u4ZpiMis6qp2LX/Ax5oUvM9FPMVmYrG7vSVgSoWmw7YtX20+GvyXlgEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaXrBopHh413ilUB61TAZxYRrWE5lzuGpWSAaONAiOr8LGnflj
	Gl7/8H+i0YSMLubpcK6b8ScN23U99BWwaGHYQz+IKnXgM0xhIskwiiYnpwNCjk1uXD4ZrNpTzaU
	ts9fLDQwb/g==
X-Google-Smtp-Source: AGHT+IEDkr1bl3B/kKUnYskkcqQj/VfPBzV6Ga8sg/OqcIl2IQ19mzG4BrRxMkx9vgKIgeByqxqFguVI7Fzr5A==
X-Received: from qvop5.prod.google.com ([2002:a0c:fac5:0:b0:6e6:5f0e:8032])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5cad:0:b0:6e4:2f7f:d0bb with SMTP id 6a1803df08f44-6e8a0cccae9mr128294576d6.4.1740860075167;
 Sat, 01 Mar 2025 12:14:35 -0800 (PST)
Date: Sat,  1 Mar 2025 20:14:24 +0000
In-Reply-To: <20250301201424.2046477-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250301201424.2046477-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250301201424.2046477-7-edumazet@google.com>
Subject: [PATCH v2 net-next 6/6] tcp: tcp_set_window_clamp() cleanup
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


