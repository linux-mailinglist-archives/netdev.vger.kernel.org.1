Return-Path: <netdev+bounces-237133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F198EC45B53
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A007D4E99FF
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79546302760;
	Mon, 10 Nov 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17pW+k5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5290302158
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767934; cv=none; b=aQtol0Nnggz8YQP3+dcWFI2tchYnwYx1JyTC8IxOUUDLeOCR/IQFWVRJIYW4mhS0JdUHErZGY24COxTJHKsbTsjcYRe291+RhbPg5B/6uD4a3NT7OWtW0ybJwbZwz35t9vcSplRK99m9E2bcBnmF2OKJvIlPByhWSf1qbY3Jzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767934; c=relaxed/simple;
	bh=WbgbEWH//Ad7zoVs46W86iap+3YMcevGaluj9W1QLpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fhwJsP1JgFGTQWXcwlfDhMdPo1zF+npjpRNZQ1fmFlPvDh1HSV2JAdRjJzoAKPHQMCw1co4o6Tm7NNdfy+GgiebWB7yY/0QF8la4WNxN7qxwALddNvD9iSmHcIexpw4dWKQ7viNJtp6BUndi+XaFXiwytH+sgkMtzgxZP5l7lu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17pW+k5C; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-786a0fe77d9so46839047b3.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767932; x=1763372732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1S3tHvUI2JwnHZb5ykTGUNH7xemy+ivFYSnPdOb1Uw=;
        b=17pW+k5CN36jL0naAksuP8WgJtY9t53HmfdYTTXuzUX9e08Ukegn+HxBt0n1L+GyOx
         dfYBNQOumLQxrETG3Ihqi1EjXVcOxMqLWmOTM/PvRzByARsJJ0clRDfwHpQ24NlXGLMm
         ZWppsJAefRvCNcPCHEgTxWYXKdDB3rj6nKTRqGS52SE4D61PEw2BpEFIoT1yXbhIZMVa
         TyxtI7Yi4OuMDNztMlSy4c5IbeGl4fLR548ynRqroA9ms/kvZH+aMyyV5wW6dVW8FebV
         ghm8Pm3qiIQIXcSt06Su1GgpZFcSus+Ot+jxLYmbZAC64z++Lb8T97Lx3dCC2H7K4IYv
         KRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767932; x=1763372732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1S3tHvUI2JwnHZb5ykTGUNH7xemy+ivFYSnPdOb1Uw=;
        b=o6T1MLw5gmlI2CLQZn45JJF+QOds/hZMxmhkPjM6M9iVycTr/gZh0o7TlnClTyIjP/
         t/HDXVlUiTXClAxaR0YdNqe+0puK9ps7BRdzcF3cRaqUFtyJUE9aS1oK0E+sNZX+6kEN
         BCkkoKnpfuHtR5QGdot0d2b0YQZpL45VpgGr/yvzqwzdrdOEhHKoMmrVsxdFduIAiaha
         ZnBwIFPWHyM0sVwa9SuTn67LOB7b35eko6/GqxZhORsy+wrpmznQCSa3rXvjBcya/7ys
         jKTPeNYn9SdVBZ/YFWP7JOd6o3dTWtgQ7WnD8/QYh+2bILYz8e7qYkZAnvFuLalqgZUK
         rDIg==
X-Forwarded-Encrypted: i=1; AJvYcCWfP/m0MM5Uy+vPpVsFZ+mUuuGzfmEJbYos1VsDEUsyE3kZ/35FtRrvzk7R3VNa8AHzdUyixY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUpGY4ZqVxo5dZhNHAJRdUXfgw9Tpv2BZ7/TArN3rTJeHcSMb
	++e/6s2BpcgUnRf5e4mEQj41lSFQVz3uowl7S8mHIvXrdSXM08NnfbkuaVT7pC51P3jSzT1V94c
	tVHWKBrH5xPC4xA==
X-Google-Smtp-Source: AGHT+IEBcNtpHmKPZB1r1iQAChT69UhdBnOy32U7kRnCzoc2bJxZCAJaukbC9HqXJoQWWbYrn8JisOUMbqe6yw==
X-Received: from ywbdb15.prod.google.com ([2002:a05:690c:dcf:b0:787:d456:2e83])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6284:b0:787:c849:6544 with SMTP id 00721157ae682-787d535092cmr71778847b3.5.1762767931958;
 Mon, 10 Nov 2025 01:45:31 -0800 (PST)
Date: Mon, 10 Nov 2025 09:45:02 +0000
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-8-edumazet@google.com>
Subject: [PATCH net-next 07/10] net_sched: sch_fq: move qdisc_bstats_update()
 to fq_dequeue_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Group together changes to qdisc fields to reduce chances of false sharing
if another cpu attempts to acquire the qdisc spinlock.

  qdisc_qstats_backlog_dec(sch, skb);
  sch->q.qlen--;
  qdisc_bstats_update(sch, skb);

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index fee922da2f99c0c7ac6d86569cf3bbce47898951..0b0ca1aa9251f959e87dd5dc504fbe0f4cbc75eb 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -497,6 +497,7 @@ static void fq_dequeue_skb(struct Qdisc *sch, struct fq_flow *flow,
 	skb_mark_not_on_list(skb);
 	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
+	qdisc_bstats_update(sch, skb);
 }
 
 static void flow_queue_add(struct fq_flow *flow, struct sk_buff *skb)
@@ -776,7 +777,6 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		f->time_next_packet = now + len;
 	}
 out:
-	qdisc_bstats_update(sch, skb);
 	return skb;
 }
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


