Return-Path: <netdev+bounces-247123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 058C9CF4B33
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35DC03008C76
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A0333A9FD;
	Mon,  5 Jan 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgI/DOAm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282DB29B793
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630659; cv=none; b=FJ0cCx9N36kjbKr+waJo1gvPacCnNT3q2zIWOn/q6TIg74yfunsq60vFTdZC+MEuFT+PxO+Qsue4DJUPKh415esa9A8kYJibksG5ggC8jGm5MFgw+cAz/uIyg6aMY4g4/+WJS8GpWcLtGZBxSAT8jD/uDrdiQpqzsdvZdMNo+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630659; c=relaxed/simple;
	bh=wHwhAPhD83nWNJFNxcMn1te1Y+pXbZLwm0tVYCxYWZA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LUG4JecV55wteCXzmk43GOM5T+y1g+nEJThPq3vOJmLNyOijRoR4vibni6NmOK5GjlkL0aOjhVjvjDdxAEzGvASD0QMHw+QxXViSWn6kCeip/Vdx9ITI2Uosv6ptbAzdsPInJNIMt++qa/EUzTqUFnHOcLG56u9TAuDKKwDP78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgI/DOAm; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b51396f3efso12362185a.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767630655; x=1768235455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YVOGqlOIC247JfblwzhJp8YnQ5+u7pfxNyL594zoHzw=;
        b=zgI/DOAmQdDqble9DjMI65iS1FaLDHmsfX3XlP2axIoT/xuayqHEnYxYL3gJG6nRoS
         gH9RyTwFL6rPAyFmbrUi7cBYjra3i63HNSAjCFUJ3wlmXEHAtSoTLwus0vwv3umMLOs6
         +4+SCKHGadSASVPkc1XppJoyavmmwbvEaBrcncECvJAnD++B5PCVG0gn6Ngsy3tVeJ54
         oVeM+UKsQ944O92yl3zZIQTAXzGzzumARmvFpU7FVhZgEE0shAiP03ZnCdEd4pqua0tc
         BpUdEg39Z2432QZK4CiYP2oQxHQhDCOjO3tTYdeKaxFxBBVMqJRfaLba6uhC3/ecQXrl
         gx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767630655; x=1768235455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVOGqlOIC247JfblwzhJp8YnQ5+u7pfxNyL594zoHzw=;
        b=Ko8QU3P/9q9RAURtJy7phbFh/iBOoRh+8uUDWIerVxXYTqQ9nGpVKIx9Ut3fVz6pww
         21Qg8ww8tWcEvXNv1ap9aQtXkMymXjafjyygooUtdouh/F0vnIk5IZmy7Se3sBY3sAZN
         bB/lluhih+ag4EmfcuIPtfRSOT2IVtiPlCG3REZbQID70r9RToEfHhc2ASULv5UrTOdB
         jqI6kqSP6+aGXdnkFZEGkp2+oo+um73MrMaKhxji6Ekg8JQsnSbEp/aV9q+C6Sy33loO
         RMnB4qrG78UtWJLf7B5Rt5m3rbCV+5bFdxJWaZP+ZqlDjYsC7S+4fLcwhtCBN/dQAD60
         6vhA==
X-Forwarded-Encrypted: i=1; AJvYcCUrFafrsKJ9VQ+Oque+akIRdjQxi9e9BA4sDYvBadleAohtjBjeSvXkxrLLVsElql3P68jXtjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu7pblh6loI0/e19GQ1xzxdvAJgee1U//m5ihanl5NBw3jMKHm
	y5W9L5RkPLbJ7pjKnaOwkyqSCrbpI/stWw/VhLXqTHl8ZYPANdpykw7CKJQzPLf7IvvE38pHxLh
	tgctl9EoSmmRkwg==
X-Google-Smtp-Source: AGHT+IELoD4YguTSXmJ5/a+OJTtu1TqBITyDH5dGQ07hoAoODiBqzLt4xVYRaa2jG4CGH+oc/YbMIMzIxNjiLA==
X-Received: from qkay11.prod.google.com ([2002:a05:620a:a08b:b0:8bb:73ed:929c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:40c2:b0:8ba:1326:8c56 with SMTP id af79cd13be357-8c37eba48f3mr21427685a.63.1767630655392;
 Mon, 05 Jan 2026 08:30:55 -0800 (PST)
Date: Mon,  5 Jan 2026 16:30:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260105163054.13698-1-edumazet@google.com>
Subject: [PATCH net-next] net: fully inline backlog_unlock_irq_restore()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some arches (like x86) do not inline spin_unlock_irqrestore().

backlog_unlock_irq_restore() is in RPS/RFS critical path,
we prefer using spin_unlock() + local_irq_restore() for
optimal performance.

Also change backlog_unlock_irq_restore() second argument
to avoid a pointless dereference.

No difference in net/core/dev.o code size.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 36dc5199037e..c711da335510 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -246,12 +246,11 @@ static inline void backlog_lock_irq_disable(struct softnet_data *sd)
 }
 
 static inline void backlog_unlock_irq_restore(struct softnet_data *sd,
-					      unsigned long *flags)
+					      unsigned long flags)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
-		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
-	else
-		local_irq_restore(*flags);
+		spin_unlock(&sd->input_pkt_queue.lock);
+	local_irq_restore(flags);
 }
 
 static inline void backlog_unlock_irq_enable(struct softnet_data *sd)
@@ -5247,7 +5246,7 @@ void kick_defer_list_purge(unsigned int cpu)
 		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
 			__napi_schedule_irqoff(&sd->backlog);
 
-		backlog_unlock_irq_restore(sd, &flags);
+		backlog_unlock_irq_restore(sd, flags);
 
 	} else if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
 		smp_call_function_single_async(cpu, &sd->defer_csd);
@@ -5334,14 +5333,14 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 		}
 		__skb_queue_tail(&sd->input_pkt_queue, skb);
 		tail = rps_input_queue_tail_incr(sd);
-		backlog_unlock_irq_restore(sd, &flags);
+		backlog_unlock_irq_restore(sd, flags);
 
 		/* save the tail outside of the critical section */
 		rps_input_queue_tail_save(qtail, tail);
 		return NET_RX_SUCCESS;
 	}
 
-	backlog_unlock_irq_restore(sd, &flags);
+	backlog_unlock_irq_restore(sd, flags);
 
 cpu_backlog_drop:
 	reason = SKB_DROP_REASON_CPU_BACKLOG;
-- 
2.52.0.351.gbe84eed79e-goog


