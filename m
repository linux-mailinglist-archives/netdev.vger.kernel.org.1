Return-Path: <netdev+bounces-237136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE71C45B65
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 094784E9D02
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA43019CF;
	Mon, 10 Nov 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OssLsnAX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA27302CC9
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767939; cv=none; b=Wil2Bad0jLpqTDbOs9dRYIouLw3brcn2c2i7Y/+1Qw5X7AfH5IF0OdOnsgq27a5fT2AObEHHdUobiWWVPnkXmbS1YjADnjjiCYSV0EE5d8ruINQSi3heII7ZfR5cR9ph1EGBimPuS/cHcukL5qDH4WcOHv2DtbcahhufoR0U+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767939; c=relaxed/simple;
	bh=5Oe8UxlFvcrTjATLJF4A7v41HsedDz08rDKeYIpDXUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EmeMS0r5UJ6+7Eq/9vuStEKsVz2tndJu9Ydxp9JKtZsQaHhBfGwC8sNCHZfc6Cck7V8EjFQ9GEvhQ0IU6yv8G+SbEWiNBPGUkTeHuUdhShS8XxTFClhorxtznzdghFOu9czxD2OlgwmcZgO+pLmUH95w/hm1j9+Fr/06TZlzS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OssLsnAX; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8805c2acd64so90318606d6.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767936; x=1763372736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2ZwYTvSPBj0l0rPuy/Yhm3EdZfidTWs2QN3TmKdTns=;
        b=OssLsnAX+FoJoDKUmymqSyq9zKbGLw89Gv/4EiGFwRk0gg/kf0YTTZThAy0oeFe7XY
         xxkBMKqPqnftlXzZMIkDcU4eQem45918opYDuanru341ZUNehWB1VTOlaDjCGfhrZ1Bi
         ENa9Lo/ILT3+YqcNpWQ/j07RBUNGUa/mx+/BosCnl9cpEsLfdtmmTJ/eqmQxCfGGKoOu
         WrtkgUmYJk2lkhyywjxVWYyk7g+YygtHcrNGt3K0M5LbiViDOjckZZ0BSS9RnO7nA72c
         f7IqGosZdybHZgNkBeH0OYokn3ledup0831X1AIN5W4bkjaIhb+MLEuSjKk2cSzX09og
         ETkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767936; x=1763372736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2ZwYTvSPBj0l0rPuy/Yhm3EdZfidTWs2QN3TmKdTns=;
        b=K0jbkNG724CHs9zYiAwyplynUcMamhBA0Qv8G9s0Fi4o21AjEdiHf8X1hjHUFRit8x
         ipdVZM50Oihpnwm3cfjqaz9TsO2to+CI9BNoPCY3DUnN01IokNXA0ACy4vl5WawIAsGX
         DiiSnW/YAfEFSc2JIeB9fbZrSoDyC+VP+RPM4l6NrPKV+17MYZTQ4Z5aYNLsvk0fEqtH
         mI4wMS+ZuN87ncsnWqJo3DQCurPz/VnIJtWcLEMMMVbsT4w+3LZFNGtCrfqMudJPvwZn
         HDo53GSyHrhhBaqg4HkuJVtJ2TR87ACxs7QWHEcJQEMeoWvlOQe67m7nWYwtQOVWWMVy
         e45A==
X-Forwarded-Encrypted: i=1; AJvYcCUDVGefE23Jqv3ng8K3YC8Bv2JMwCSpyQJrinCRBQI94f75Ch4WnN6oo3eV5oL931mxqVFiqw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwLb+XHIYOZXkon0FKJ/cPhASzlrAgw5YJczSZKxt5sBm3sqfF
	oI0PaJ+ot36ZudW+XTZ3X5APV/LiG1eVF9PqVkrBG89r27/DC0K/6TMiC71fydfhwHIO2jpjPa7
	A4qzxTDIwH2VUBA==
X-Google-Smtp-Source: AGHT+IEXY9Ci9b2GO/6YPXsRP5ScRj6Em829q5nUYp8Iy36S8XSL0EMsfqs4HBlARoWiWrF26hHpUZazcOdk2Q==
X-Received: from qvzf7.prod.google.com ([2002:a05:6214:767:b0:882:2f2f:a0b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:19ea:b0:787:5934:697 with SMTP id 6a1803df08f44-882385c86bdmr92438606d6.8.1762767936516;
 Mon, 10 Nov 2025 01:45:36 -0800 (PST)
Date: Mon, 10 Nov 2025 09:45:05 +0000
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-11-edumazet@google.com>
Subject: [PATCH net-next 10/10] net: annotate a data-race in __dev_xmit_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

q->limit is read locklessly, add a READ_ONCE().

Fixes: 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 44022fdec655e40e70ff5e1894f55fc76235b00c..ac994974e2a81889fcc0a2e664edcdb7cfd0496d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4194,7 +4194,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	do {
 		if (first_n && !defer_count) {
 			defer_count = atomic_long_inc_return(&q->defer_count);
-			if (unlikely(defer_count > q->limit)) {
+			if (unlikely(defer_count > READ_ONCE(q->limit))) {
 				kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
 				return NET_XMIT_DROP;
 			}
-- 
2.51.2.1041.gc1ab5b90ca-goog


