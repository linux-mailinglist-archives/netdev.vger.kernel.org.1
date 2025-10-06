Return-Path: <netdev+bounces-228019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FA5BBF18D
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 21:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA4F1890F29
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 19:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB65214A9E;
	Mon,  6 Oct 2025 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F73tmKYs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5E1D6187
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779070; cv=none; b=HtHkLMELdd7svjUsNTIRypHa+hmqko6F+5irHB7HCrfeBtevbSlaYEtzxwnHbGk+Uduo+Xlhx373EgjSF0C4a+uVJbA5pHfcLyiBbtlCkytnoE0tWcIj5WTIuGKCNlLCutR1yxxu6mIiLFgZLM6Lpp1L8+t3nPzAQa13CXa1Bf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779070; c=relaxed/simple;
	bh=oYPGjt+uGeaQb9mp0fX63LbeT239EvBUIHrG7GEvDAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jrQ8wFoi9cKt4UCf/h1sNgDAJygZBYLElHKc6KMFQOEm57uyq0l8xESH0TTXDhwhw66MtAr57O7hl0kXfXROUxCWhn6ssWrmv1KSzYSFI3P3Fv1LMQTMYneMTEFnNWVhjaJcAqXiOaN6xY8JRXUlKHKiB/dBGzr/tF3fTD7qs1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F73tmKYs; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4e576157d54so86852131cf.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759779068; x=1760383868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TSA9KzdEX2/MRfG/jziR+UvLOc1nb+805Rmi4lzpxH8=;
        b=F73tmKYseufplDRZZjwEhbExEA57EqTCwuLw9sPEy65ShC4ICf1avgy/WGxjtApHoo
         GYbII5RU7G1o1xVqcvxj1KKylbSmCG2enxblbpr5iq7frfQTS+qC2QQuqkbTvCkMumR3
         LZvQBdFFXESa5NtbWNo9NtiwTiZzU0723NBxOPNKDw38sFZeQf4vWQktZp+1xVRsTueT
         SQ40XxPrl5W7coCwAP7UU7kOiifmJzbrXfOTX5rLRAdku8+RT2a9ztwGrFK7pl/G+OpD
         6TYiu5VmWdjyhttSoZcuFOW/m5AfFkHODy0bWtPN9/0Jm+og1L0IRQwvCVuj49caAV4m
         4vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779068; x=1760383868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSA9KzdEX2/MRfG/jziR+UvLOc1nb+805Rmi4lzpxH8=;
        b=v6v5mQgKa1W9vi6ENcAiczg7AfdeYXyiJZ0yAbrYQ/T4a2v5Ry4kB5pG+p0VNfX65f
         Upj+YbdZ4+5oyG3VSegDENDhVeUWgZsaHW6ZjECM3fecXTzFNIP3G0yenDsSiILOyHeb
         rTUhTWIwttGbJWEyvczzfuU78oDY0TV9SHvcbPsrJVKfz8yFK50Fh5+OGTS9zHcyTYIa
         GZ4mbJf3KCAShz30tRc/GuGgFItioViovai273rEkRbOdkQXD26mP1IrvpRWPHcv3uux
         Eb7c0NEQJoDdE1hBSpjSyCAKlcwdTOvS3E18I6gQxgtzhUxouSp9qwqowQRi8JN8bwkN
         1yxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhSyNHR1l2bJcdNRITwtqDqclNAdoJZ8VYrrK97Fdyc0uTrIRvhDWMsBhL2UlBSwAH6K6iwrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTS0wSQLcHzRaSEwRJ5FF5pzmb6ukpbgO3DlqiyIK/aeqxXle
	d6jGzwRrVDsok/ohRcBvxqqst6uNvZuYONGib4jeAJ2petiMiVohI0voBlvrqvAPzPlwhEvjrYf
	wNO83AEFtUqSSUQ==
X-Google-Smtp-Source: AGHT+IGnQX72+iob+xhEUwbq2ICm1u0/7i81osj09rVWc+3y/zxYBjvPGpjHMgNINU97wsuvDwsDsf+wWd3z1Q==
X-Received: from qknpw6.prod.google.com ([2002:a05:620a:63c6:b0:862:5dc7:9d70])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:6f14:0:b0:4dc:82dd:5611 with SMTP id d75a77b69052e-4e576ab8ec9mr163673641cf.48.1759779067996;
 Mon, 06 Oct 2025 12:31:07 -0700 (PDT)
Date: Mon,  6 Oct 2025 19:30:59 +0000
In-Reply-To: <20251006193103.2684156-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006193103.2684156-2-edumazet@google.com>
Subject: [PATCH RFC net-next 1/5] net: add add indirect call wrapper in skb_release_head_state()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While stress testing UDP senders on a host with expensive indirect
calls, I found cpus processing TX completions where showing
a very high cost (20%) in sock_wfree() due to
CONFIG_MITIGATION_RETPOLINE=y.

Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..c9c06f9a8d6085f8d0907b412e050a60c835a6e8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1136,7 +1136,9 @@ void skb_release_head_state(struct sk_buff *skb)
 	skb_dst_drop(skb);
 	if (skb->destructor) {
 		DEBUG_NET_WARN_ON_ONCE(in_hardirq());
-		skb->destructor(skb);
+		INDIRECT_CALL_3(skb->destructor,
+				tcp_wfree, __sock_wfree, sock_wfree,
+				skb);
 	}
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	nf_conntrack_put(skb_nfct(skb));
-- 
2.51.0.618.g983fd99d29-goog


