Return-Path: <netdev+bounces-240688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A19ACC77EB2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D02334B384
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE7433C194;
	Fri, 21 Nov 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbIFq2oB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2433BBB7
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713986; cv=none; b=NfjfL0Vv6kWTowLrUTKxCxFSfx9EO0r07uoiaW8haPN5En6KzJS5KOziXSOohwOELJVTLQLlwIrLj+wFSkP/jnSdDxkusjwUY+JduR7XXWF9ToVertbdcydbBM66aJR5MGyUtTPNXHLPJb8cGhSwtZUQqv9VOwCAZidcDSiRYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713986; c=relaxed/simple;
	bh=qwHstb0iGyEyqQHtHMk01Tb4HZFbd5G9nk7ROmVgwX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eMARIDox2WDbTl+79vESagd/JKF33F0GOJOugOJaDb0jCsZFpZj1rDa8kS19LgPi/E2vmqCTIGjcNzyg+wHa5U/ETpne3P+WcAAXIrF2ZKze+thMgqFCZbINMLCR1uVup6LrD56WaCtRbKt/P5UN2l7VNot/PSlcvn96dso8OL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbIFq2oB; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8824292911cso67444346d6.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713984; x=1764318784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnwN524788PKNTskAR0FRYehDzdhEIP0fDw60JQrF8Y=;
        b=jbIFq2oB8vP6NyXFvAkQS+Z078gpb/zuP6swvis1EesflhkCr+oRGm2vagZ6bdNgbj
         389KhpRb8m05ZAyofrE4czdlBokbjt6/wdhiYsjpbrBDkenS1Plx1GRAfMHDjZYvYeS7
         AKTzbC/6Kyzit3WBiF6SMshCjrBXJtJ4o7IlNchnZhiCpROhm+Uv8ITk/xRj8t2Xuh/i
         sKZ+pqUoq68cJ6GbGah30XxEP0uzH9M9yoCLhGtJV55B3Hr9MXFI42kBzbQ6CiQwCd6u
         TFdXht+Hra9JgHHfEWJydzyqdspJp+0xCbfQeISO9QJy5fG0DRsV5ITLmuS8GBxZk6Do
         TG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713984; x=1764318784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnwN524788PKNTskAR0FRYehDzdhEIP0fDw60JQrF8Y=;
        b=HZ5KUF9qWFrdtXwkM7HvI5nYMJoeW/AAS8K6DOhgaBNQIY4gzOmuiY3eDJaDpqa2tL
         macWiXwJJ7qq3fhsiSdSOhTrB6gck+CcGrND4DRi1QrGjqwOONpDev1jRhWdgwv8yNno
         oAQviFY2ggrtflR+qBcwYtBJlKAGTUfpwShRy1n8uTgB4aow1DnfEVSo4kDSI6B0uYgO
         G1X1AlUtpS1g1fQAAJxK33nQcM8kCYRTraVEzkI9+hrPPC/oC1S5RxGQdXsOUbMhOvxr
         iaB9NAZCxtbd1P9KrAujUsgQrI2CL32k5Ei7r8e2E0sd3EPiV3aO2pTyjFZQkSCejkJF
         BNiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyp/f8UnbuWlsVaUUtZdYujnHpFYb97rIDiSf3RH4Ln3iCiq5k9bBwdcanMV1qnxvPc076Z4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnl5UyzzFs6a9ynzc2Vy00i++7Ty8Cgg7WdjW+mi9vcnJ+9CWZ
	sqkwjGReJGfncJ3xBI4UPXUW+p4BKJdankq4jnoQe2cWEniiX0nKY6hFcSQh7/klleetrMrzf5O
	6fzX+FsVamhzwUg==
X-Google-Smtp-Source: AGHT+IGKS9pYBAvcGhZ7TG3xg92o/6kkaVwxoD9EcCUDhjSq7RUqA3m+5nT6C/Dl/rWb7h24rinlnVhyXQj/IA==
X-Received: from qvboi2.prod.google.com ([2002:a05:6214:43c2:b0:880:65e3:ffd0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5f48:0:b0:880:53a8:404d with SMTP id 6a1803df08f44-884700800d1mr91910116d6.3.1763713984160;
 Fri, 21 Nov 2025 00:33:04 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:46 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-5-edumazet@google.com>
Subject: [PATCH v3 net-next 04/14] net: use qdisc_pkt_len_segs_init() in sch_handle_ingress()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sch_handle_ingress() sets qdisc_skb_cb(skb)->pkt_len.

We also need to initialize qdisc_skb_cb(skb)->pkt_segs.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 895c3e37e686f0f625bd5eec7079a43cbd33a7eb..e19eb4e9d77c27535ab2a0ce14299281e3ef9397 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4434,7 +4434,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		*pt_prev = NULL;
 	}
 
-	qdisc_skb_cb(skb)->pkt_len = skb->len;
+	qdisc_pkt_len_segs_init(skb);
 	tcx_set_ingress(skb, true);
 
 	if (static_branch_unlikely(&tcx_needed_key)) {
-- 
2.52.0.460.gd25c4c69ec-goog


