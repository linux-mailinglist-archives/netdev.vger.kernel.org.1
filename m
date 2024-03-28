Return-Path: <netdev+bounces-83016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B88906C6
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3091F23D65
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F83131BBB;
	Thu, 28 Mar 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xfgA/28H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5AA3BBC3
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645400; cv=none; b=ujAVry1CtFhKq2W6SfStXXbfVYaJeuvur7y/xdw0QpA0GWpJUXK2+C+VH9o5U686AhsVqZDT8zvinYDmYidZYhjK/ahBK6hsxuN9lMJpUh1RYTpyVJ5iG9CHef/tbiB+0MdLUHD18kBuaVBA8A7EGhbtpl91e+rzABDh0G1Bh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645400; c=relaxed/simple;
	bh=a5vZkEq5DezRtLOpRv6IVjtsS4YsnwOaL3X+e14DSBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UXbY5HOegI0btudfNVF2z2biSgxTyoCuqzD0htsGs3BLH5U8xZ4DAAPba4z675YDFOCPM/+XMR8O3XxB332bxWnkKrQh1Bwte6pBJ33wFoCeXQWJ84JNR33lUyFmgZZUtakLHnpqEb3CkHjE4qntBUx2ZU/QYl2gQR5Em1EX8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xfgA/28H; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1421488276.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711645398; x=1712250198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhxv1Ra6YkEoXOpZkudRcI7LgeFiDY3fBalWZj0ho38=;
        b=xfgA/28HjItDtn9QOudKxF8mfVhD4GU9FTHLjTm6tnZGZO4htphJIYvDp3ISbDZN4F
         jMjtPzwhzPYceGN6lEuKJlg9ZqDBiIY2xW7vVzqSofiGdYQs8Da340a7vGlY+P6G/Jit
         AlTAXE2JrglVgeflM8S8JoCyDf5d/p7jdwzaQY/Zm0k38YahcPfVYoqbBcewPLBwXJm5
         JDSyofZhQN19VJLYEgHpPGK0t75gaBwhA/T7ffBtHZdz66LEi0F3LeVCi3K9ASi+gq7J
         C9NOhWuY0AvOAKkCSV37lGYIRNeeMiDwxQDmmvuAC+9MdBRM6O99tlvKE5h9LipMbpeN
         64/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645398; x=1712250198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhxv1Ra6YkEoXOpZkudRcI7LgeFiDY3fBalWZj0ho38=;
        b=S58xJpfDU6nVdGcdwcVoZHXfJ40ewP+qsFMz4gzaOn/8O3pq3sAFQAmWut8JBXMOxy
         8tZsfqo2fWS5JedvxuUA6ctgZogVsdGiyG8x86mrOAa+ckiJI8VKWzn8Xai/WvvAtyME
         eraJypxfs9yHzKLkCrDnwl2uL6hMcrcISJ9G7QPMMdxm3nn09L5v6PP5DwSS/wuIgDe/
         BCk2Yv927v0oLFGp79NIS8K0I2xZCLYQNJWLZKK/DE/9XwSubL7LEHgBRTiO8UwUiHJd
         wpSxc1tlAjuun1k5toP6k1olm1xoxcDf22aS/L2Y250HCmY2bcLwumI7i4N1ECmBIl+F
         VKVg==
X-Gm-Message-State: AOJu0YyHOhDUPo1YTr71Khhg9KBH8uk0Aniwl2BxLHorHJR//z32Ml29
	sJZI2UPCPNE+O39D3EG4tpspMK6PqrULsRo00uqS5C080vwIBqJTbxFitnovr2VuHs9sJFLjnF2
	4nfQ4hydsdg==
X-Google-Smtp-Source: AGHT+IGKBdCTZx/gyFlLk9bokGh571tTVNzKSnkODppmlHg4A4lprmaymYJNOpTmAFDpbcq4bcD9sgzEog4BXw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b06:b0:dcc:94b7:a7a3 with SMTP
 id eh6-20020a0569021b0600b00dcc94b7a7a3mr250092ybb.12.1711645398283; Thu, 28
 Mar 2024 10:03:18 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:03:06 +0000
In-Reply-To: <20240328170309.2172584-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328170309.2172584-6-edumazet@google.com>
Subject: [PATCH net-next 5/8] net: enqueue_to_backlog() cleanup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We can remove a goto and a label by reversing a condition.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index be2392ba56bc57bed456e2748b332d4971c83a4e..4e52745f23412bac6d3ff1b9f4d9f2ce4a2eb666 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4806,20 +4806,18 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	backlog_lock_irq_save(sd, &flags);
 	qlen = skb_queue_len(&sd->input_pkt_queue);
 	if (qlen <= max_backlog && !skb_flow_limit(skb, qlen)) {
-		if (qlen) {
-enqueue:
-			__skb_queue_tail(&sd->input_pkt_queue, skb);
-			input_queue_tail_incr_save(sd, qtail);
-			backlog_unlock_irq_restore(sd, &flags);
-			return NET_RX_SUCCESS;
+		if (!qlen) {
+			/* Schedule NAPI for backlog device. We can use
+			 * non atomic operation as we own the queue lock.
+			 */
+			if (!__test_and_set_bit(NAPI_STATE_SCHED,
+						&sd->backlog.state))
+				napi_schedule_rps(sd);
 		}
-
-		/* Schedule NAPI for backlog device
-		 * We can use non atomic operation since we own the queue lock
-		 */
-		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
-			napi_schedule_rps(sd);
-		goto enqueue;
+		__skb_queue_tail(&sd->input_pkt_queue, skb);
+		input_queue_tail_incr_save(sd, qtail);
+		backlog_unlock_irq_restore(sd, &flags);
+		return NET_RX_SUCCESS;
 	}
 
 	backlog_unlock_irq_restore(sd, &flags);
-- 
2.44.0.478.gd926399ef9-goog


