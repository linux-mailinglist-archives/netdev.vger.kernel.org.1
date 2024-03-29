Return-Path: <netdev+bounces-83365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B3892117
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C82B2767B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992E14F5E6;
	Fri, 29 Mar 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4mwpcM9E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BDB45BEA
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726960; cv=none; b=UStsotenNhWNFrQ2L4xQa9T7jOmbQxEfegGEsnNuajGwOlmTyTPVsstBcyBkr2fp9PQXP8pAjQ7wT199EGQLJxs1iYggt0kYB+2ICwnkbNhhG7q3yOF8ZnVhjEZ7Rhi7CXJfaec+kV4VzKl/1RkHXYv1qsKrfM0bofDDrrofnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726960; c=relaxed/simple;
	bh=Rh2Np/oxrvww/pqriWwAwgIkuhL/a6F/FV9Z7mjLlW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UECdEj7SeGzJgu5KvWo5QP/PcI8n0RjXx7BKSSlBYO3Ts0RAT/2FEONDGSJuE6OHrukJIABpXfW+J7OkOwepBWkrPlAzAun++OpciE1+GjeSySOuNQBdYlegcYySJWs0Nuhx6MDE59dFpCzaWENQPt7I5TyIAlhQlAGUnZqPR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4mwpcM9E; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60f9d800a29so33197087b3.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711726958; x=1712331758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0G6bhQ6kaT728Eab6u6g1DkBmh7dQX51z7FtoBdHYBs=;
        b=4mwpcM9EXUm8iANwDNHHGMmYeqFEvzBZ+m55HHRmE/T4Mltcrfoa+2/G1g0caIpICs
         j+/5XIXewBoS1hBDcuDRHGWBAsCJ/qTw05PKLWE3pdZc183zui3x3rzYZt7xFx88xTzv
         LlmVwi65ikmec5TEAhU6u4L4l3jemCj0AfdJGAYMFyKJ0e5IYBUY+QY0+SOrAN3QK/2X
         OKRgN0N3ulEOtUAk85SFIxUg/CxZw1+F+zAPggBcmyMQMkocNpsmZ/sGlJaQeco4jZOq
         4XStz/frj2JBuAqAfdEbARyECKwckNSOq5Vxsc4ojkQjwWkOtrcezk07xtCHekzz+ybJ
         EeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726958; x=1712331758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0G6bhQ6kaT728Eab6u6g1DkBmh7dQX51z7FtoBdHYBs=;
        b=JbC7cYq3lbqSLqwn7Y9qRO58z+iIGnoT2lTyilhiM3gImfH54RUpgsOTU6rsWEsFRK
         OiPSFc2CBe4BTEifdZeUXQP3SMUTdsUqVeRBDvePqv4I8aKYahVOut3Bvc/aNWkVskp7
         HwNFtfSMv0u5a4V9AL8poDiaPYnbC0NkSCv5v86Oydt17tUPjvj0Kpm6/6r7b9Kv9aMi
         zV87ptncall4ZDqE7j75bggEFBs3r4urQt5ZQvjXYC0QwswTpJ3ZYUkqqZY0jLETStj5
         CsZED7JuPNYJrXPat+5HcgT4aic+sNphHYEzldDVSj0cC2Awh/Q6lH3qRDqa96yptP4l
         ykfw==
X-Gm-Message-State: AOJu0Yw1+X9nAtIDAKvYTHZit6yK+dQAWQvRUSmEg87Ht+LOO+cfS+3N
	fhCRpqW3VAQMk7+2bGilx4zlOI1ik8V5RmR3Uw1W469GXnPZ2ihJ2iBs3KZDVU6CSWyo1e9h/pK
	Vi2aFxUrg7A==
X-Google-Smtp-Source: AGHT+IF+5zEeqKi8VzsZSSLseOPFpjHOXzblatzM+elVpqOvGbjx1j+F2b5CWWFXjAFL37k7lqZfoh8kVH+p3Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:260f:b0:dbe:387d:a8ef with SMTP
 id dw15-20020a056902260f00b00dbe387da8efmr164191ybb.1.1711726957962; Fri, 29
 Mar 2024 08:42:37 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:42:24 +0000
In-Reply-To: <20240329154225.349288-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329154225.349288-8-edumazet@google.com>
Subject: [PATCH v2 net-next 7/8] net: rps: add rps_input_queue_head_add() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

process_backlog() can batch increments of sd->input_queue_head,
saving some memory bandwidth.

Also add READ_ONCE()/WRITE_ONCE() annotations around
sd->input_queue_head accesses.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rps.h |  9 +++++++--
 net/core/dev.c    | 13 ++++++++-----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index 10ca25731c1ef766715fe7ee415ad0b71ec643a8..a93401d23d66e45210acc73f0326087813b69d59 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -138,11 +138,16 @@ static inline void rps_input_queue_tail_save(u32 *dest, u32 tail)
 #endif
 }
 
-static inline void rps_input_queue_head_incr(struct softnet_data *sd)
+static inline void rps_input_queue_head_add(struct softnet_data *sd, int val)
 {
 #ifdef CONFIG_RPS
-	sd->input_queue_head++;
+	WRITE_ONCE(sd->input_queue_head, sd->input_queue_head + val);
 #endif
 }
 
+static inline void rps_input_queue_head_incr(struct softnet_data *sd)
+{
+	rps_input_queue_head_add(sd, 1);
+}
+
 #endif /* _NET_RPS_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index 79073bbc9a644049cacf8433310f4641745049e9..818699dea9d7040ee74532ccdebf01c4fd6887cc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4528,7 +4528,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	out:
 #endif
 		rflow->last_qtail =
-			per_cpu(softnet_data, next_cpu).input_queue_head;
+			READ_ONCE(per_cpu(softnet_data, next_cpu).input_queue_head);
 	}
 
 	rflow->cpu = next_cpu;
@@ -4610,7 +4610,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		 */
 		if (unlikely(tcpu != next_cpu) &&
 		    (tcpu >= nr_cpu_ids || !cpu_online(tcpu) ||
-		     ((int)(per_cpu(softnet_data, tcpu).input_queue_head -
+		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
 		      READ_ONCE(rflow->last_qtail))) >= 0)) {
 			tcpu = next_cpu;
 			rflow = set_rps_cpu(dev, skb, rflow, next_cpu);
@@ -4665,7 +4665,7 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 		rflow = &flow_table->flows[flow_id];
 		cpu = READ_ONCE(rflow->cpu);
 		if (rflow->filter == filter_id && cpu < nr_cpu_ids &&
-		    ((int)(per_cpu(softnet_data, cpu).input_queue_head -
+		    ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
 			   READ_ONCE(rflow->last_qtail)) <
 		     (int)(10 * flow_table->mask)))
 			expire = false;
@@ -6045,9 +6045,10 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			rcu_read_lock();
 			__netif_receive_skb(skb);
 			rcu_read_unlock();
-			rps_input_queue_head_incr(sd);
-			if (++work >= quota)
+			if (++work >= quota) {
+				rps_input_queue_head_add(sd, work);
 				return work;
+			}
 
 		}
 
@@ -6070,6 +6071,8 @@ static int process_backlog(struct napi_struct *napi, int quota)
 		backlog_unlock_irq_enable(sd);
 	}
 
+	if (work)
+		rps_input_queue_head_add(sd, work);
 	return work;
 }
 
-- 
2.44.0.478.gd926399ef9-goog


