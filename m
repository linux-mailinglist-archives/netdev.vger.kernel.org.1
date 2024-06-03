Return-Path: <netdev+bounces-100371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF738E45E2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1BC2862FD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD174297;
	Mon,  3 Jun 2024 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxxyG5XL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0056C2135A
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450300; cv=none; b=tiEFw1ClGDblJW+iBKwpnRCkujJL9xry6k+JnLmgAQ1bNEx1/La1WkeLtiLudeyIJuZ5WE003RyA8SNKE7DKSi5oJcMulnQy9rLXRi6HU36EseaUa+gVOudo23mWG4AsuTROqqAux1CRTRmJjuqlv6I/QKJQO3Ekqp2jMlQqbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450300; c=relaxed/simple;
	bh=AJoUBMsz6agHYdEPaEjV3txCv7iqII+LqtEiV8fYFFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uMEmfM4pwYjCLk9hG9SOA/qtbO0KwbfheIC+Jg3fsUC/7DPv85K+pSRbPVs06k15AeE+Ixi7Orv/SWHAJNoW5wx1bvsCPMN/k/9GjT6OOHCldxysDbDtI3tdyyxAla6Zp+6vu8oeDaPtUYdT4XvRa+xCtEbMzURF6wqIw19v5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxxyG5XL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a50486746so5896747b3.3
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717450298; x=1718055098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBFFcucXZV92P+br9RMybEzvRwOHbiaF06U92SwZE+c=;
        b=KxxyG5XLYTFyobIbfUhe4nOw8m82RanDVoo4zfzySjF7kloI5shq/h6HqcVK9t6WmF
         +0nfqyWpqv2/KNNKiGfsYzicworieqg6rk+p85xeGPtq8uEBu9kdIxtfZnfWw6x1KTCV
         4jvEFujxOl7+TmzEuNclexoRSsP71uA04ZjkpgNRe0ErexTbPV2w+/HzzU14UvVuGnpI
         2PcyQNzf6PyecdFtfPCTm+fntUuLZy99Af9KLyQoSNf+gxFM+T+yAOuyeNHt9b4QYV/9
         KQQZPRyV0qOdngwzT5HH73F0xk+5tl/RdPv2nBWJsBoI2KAvwRLwgbR1ATXKV4NVuDtE
         oPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450298; x=1718055098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBFFcucXZV92P+br9RMybEzvRwOHbiaF06U92SwZE+c=;
        b=Wo0JXNdN4J/sOgFPJUv9W0u1wa7NbUPgQ3jQRvG4V/unU9/g6g4WU29p4LMiE54GXk
         TKnBhIug3XBvHoHmMgJev/X25sL58vBfra+dgk2UhasInz4TiLgMTBQdrzBg6UQCxUfs
         vR5WLqO2gvmIrT253IzncCKqE4OVVPk0YmqBtqKbzezKS1xXCW1rQQ7o6SCYHXVAjKN+
         WuXN94upQ4gfhuuA8zhUS3sThANAZ49XVtSBFNacxW45fCU+L1QSJmaW7wVD+UDJI6+7
         6KG7UQy9bhtqsrT+Ta3UdYWI1kj0TplSNao85HlnkmoOoEcVVi1wISthFQCG4LLgr8Uk
         yCCg==
X-Gm-Message-State: AOJu0Yy9mwyPQbv+bZSHuSrYl6O+KdfPqzO0eZ5cWU6b7Oud4sfjMIMh
	y5I5Dq3m/zwtEUDqOKkFTPD9L+v35ZSoII7nNTi7aMPRySlXSXly2H9bsL/CQ+NFFA==
X-Google-Smtp-Source: AGHT+IGa/7B4l+lmjQhstDeiCwHQlAdzz6ZGDw9st5t6DLrtXvi8kOPXZepM4z3B+fK49a2qwm1C77Q=
X-Received: from yyd.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:13c9])
 (user=yyd job=sendgmr) by 2002:a05:6902:100a:b0:de5:3003:4b64 with SMTP id
 3f1490d57ef6-dfa73bc14a1mr640899276.1.1717450297845; Mon, 03 Jun 2024
 14:31:37 -0700 (PDT)
Date: Mon,  3 Jun 2024 21:30:53 +0000
In-Reply-To: <20240603213054.3883725-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240603213054.3883725-1-yyd@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240603213054.3883725-2-yyd@google.com>
Subject: [PATCH net-next v3 1/2] tcp: derive delack_max with tcp_rto_min helper
From: Kevin Yang <yyd@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com, 
	kerneljasonxing@gmail.com, pabeni@redhat.com, tonylu@linux.alibaba.com, 
	horms@kernel.org, David.Laight@aculab.com, Kevin Yang <yyd@google.com>
Content-Type: text/plain; charset="UTF-8"

Rto_min now has multiple sources, ordered by preprecedence high to
low: ip route option rto_min, icsk->icsk_rto_min.

When derive delack_max from rto_min, we should not only use ip
route option, but should use tcp_rto_min helper to get the correct
rto_min.

Signed-off-by: Kevin Yang <yyd@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/tcp_output.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f97e098f18a5..090fb0c24599 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4163,16 +4163,9 @@ EXPORT_SYMBOL(tcp_connect);
 
 u32 tcp_delack_max(const struct sock *sk)
 {
-	const struct dst_entry *dst = __sk_dst_get(sk);
-	u32 delack_max = inet_csk(sk)->icsk_delack_max;
-
-	if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
-		u32 rto_min = dst_metric_rtt(dst, RTAX_RTO_MIN);
-		u32 delack_from_rto_min = max_t(int, 1, rto_min - 1);
+	u32 delack_from_rto_min = max(tcp_rto_min(sk), 2) - 1;
 
-		delack_max = min_t(u32, delack_max, delack_from_rto_min);
-	}
-	return delack_max;
+	return min(inet_csk(sk)->icsk_delack_max, delack_from_rto_min);
 }
 
 /* Send out a delayed ack, the caller does the policy checking
-- 
2.45.1.288.g0e0cd299f1-goog


