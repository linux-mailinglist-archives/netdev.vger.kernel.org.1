Return-Path: <netdev+bounces-240694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A72C77EEE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6083C4E9A3A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FDD33D6D4;
	Fri, 21 Nov 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNnepu+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6033A02B
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713994; cv=none; b=JdKGcU2de4JNHj5IckT7UpVpSZs4b0xO0PjlHe6A3EKiHyjzovy1Z/N4q5v6lVkJgEg8nX6Z0q5RbAvTDDFXks4fD1Uq34U/+7P+bvEHPM1jECr96PUHF8QE85S2cA39bHqGahLTsYZK158lsjhYse6JqeTeTj6L7EQ+EPAxUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713994; c=relaxed/simple;
	bh=hQWilFT4N74eUvM8aeubIw76354Td+kefIBnh194ris=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fNL4tiVy2P7InopmMkw7pKbbp89uY9D1w3kLVqkDvWpOtA+mph9Ta4X5K9IDZTNdKuFjdLxdziX85Q9A8zHRBHjS171T3zD9ZxfwpFIdrqDLaTNcYP/WR/VKg+rjjDWVhqdYzcX1E8d7AzgKKJ48ON0GSCngqLlhjKg1fc2b/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MNnepu+N; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8824f62b614so57256596d6.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713991; x=1764318791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOYqtLViuD52P/GQflD60QINVtQoHqDNLW4K39813P0=;
        b=MNnepu+NTP0GlJ49tMVStBuI8ciQ6j70cGzFt4CdbetDTkjGzP0yiDFn1Wq+G4dTnY
         L4EhVftK35gx2fEqP2ijdWMA/WAitmGConOJaxesgA+0dCcqTTkgSPJrjOIAWACW/gLB
         qNqghMb1vUbpz1qOsXjW2jtx75EHxSknYWmscZcbAsSSvE8v2gHRhsJSJTR8q1jiP0Yn
         0DzoirhR5dye/052zs5gtcf/fGzt04s2RfZ+n5aidy87YTyYANHptrOlAruX5olsinD/
         kSzKy8YREggTZlbaIfB1TrDyEvDHj3gZQFKQRSll9ClUJOAA83TatTotcuazq1V1G7IL
         UJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713991; x=1764318791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOYqtLViuD52P/GQflD60QINVtQoHqDNLW4K39813P0=;
        b=JCLN6ngOeNlQj10ypFls1lZcp6R66+JXPR/3Gx1XdXRg5q9voHeoFcqmPlbsaXrplH
         osa+xWKc34epJAdlpTmM1CriQb3qdN0aISlElB55k7uqQCkZUw5SKLbs/Y07dpNpUGwd
         7OEVEUPwG919LizGFCRRQcfN3XFyS+Y/kuU+cdgUYmkfXlRs2EwpqG6ywKlypzkCRYft
         ERTki+3SATfbtzQnrDIoHXBUZPkJAH1KuiydKtzUKxRCqEij52gwVyCCF1eqfls3ydcz
         IJTPShJZpqO/6lbxyFaceXTnEjgoDSJfQJaacGcbEX4fbvUWH6zESGrSZYwOnZUouwQV
         ACpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWIqsSfXl0Nw2seYjDLPFh05aCUFJ8IAhXZoGWwV+FnrfpuqA9xCoZR5xZQwDJP/jbixRUfbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnWN/JmradLJjvCfHIeBf8ywGPAT7DEEXvcSELgJ26x0NuEM9
	n6ySnzlnrEsTjhpZ+vm4/Er+CngCZZVdWpVjjCsbO6vjy7lLhWNm2+Q9logLvokBCN2MV8Zx+9K
	l39i84BwdoNTybA==
X-Google-Smtp-Source: AGHT+IF/srsKD3oFfjjNQrJue4kHHOTHte2URKptos8olPZevLLyuzEWWdD+3qjq/Ct66sDxkWhZureJc6GAMQ==
X-Received: from qvboo13.prod.google.com ([2002:a05:6214:450d:b0:882:4d6e:ae58])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5c8e:0:b0:880:535d:d157 with SMTP id 6a1803df08f44-8847c544e8dmr21666806d6.31.1763713991553;
 Fri, 21 Nov 2025 00:33:11 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:52 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-11-edumazet@google.com>
Subject: [PATCH v3 net-next 10/14] net: prefech skb->priority in __dev_xmit_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Most qdiscs need to read skb->priority at enqueue time().

In commit 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
I added a prefetch(next), lets add another one for the second
half of skb.

Note that skb->priority and skb->hash share a common cache line,
so this patch helps qdiscs needing both fields.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index e19eb4e9d77c27535ab2a0ce14299281e3ef9397..53e2496dc4292284072946fd9131d3f9a0c0af44 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4246,6 +4246,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 
 		llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
 			prefetch(next);
+			prefetch(&next->priority);
 			skb_mark_not_on_list(skb);
 			rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
 			count++;
-- 
2.52.0.460.gd25c4c69ec-goog


