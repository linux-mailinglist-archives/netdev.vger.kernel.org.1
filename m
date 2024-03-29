Return-Path: <netdev+bounces-83363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890CB8920B1
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2557A1F23665
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA444E1BE;
	Fri, 29 Mar 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGZcE/gi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5A45BEA
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726957; cv=none; b=i5zBJS0s1r6y6Bzon+USDda02WyD6+OaIH7I9WeBQl3gPdwneVaiWQKk9CWABXY4vvrn4LBy0Xm0KnZGRUWhJ7Peq0kSK21tu0cbEjxVhMdGLgw+b9MrkmAzb62WLNVM4bAistO7X/nq/JLcfyuWxXlx6+e3rGHg3Lz1FxoBl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726957; c=relaxed/simple;
	bh=eOGR39DCoGOQg+oNMRIwC8g01mQpk7BViTnhKr2Lp7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fQcWL7nrg5Dej8rJKtR2dquAnCg/jCM1z73Y5kUr5+Ya19w7eiPzQ4Z0ivjWyDRXHN/OP1DZcSQ+1qjwUsgiYKkcXJmy5U3YiqGovHOd1EUIEUkgykxHTjJV6wAVHphgdM5oBdoqxZVcGqbaNZ9PSrIJOJWToHLcVFfjduaJPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mGZcE/gi; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-78a087e8b70so373415985a.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711726955; x=1712331755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMXzAltYqOJOzOEzXcMQc99mG0oMwOhh00KlVSFtR2g=;
        b=mGZcE/gizSnX+v+bEChcHUbpo/owq0xb2jIid1PJIpQLOPvJSv1uRtOocWWYrTPZCc
         2OoeW5LqAZTQcIYS3+Djrrfvya/Zw8sxz1MhSrVLx8JVzKeq1yMuGgCBn65+UanA7KPK
         opbf0WUXm1iOBhRAwy1ocGv+rkLS50DEP+//1paYlE5K/2Y746sJUWtRDMLqOkYOUiMr
         1swY/u3jNJkoCbdlyu5qcgh4DFQuBuamOeEKz+QIu3mQs+4SzmwEwkt+0/iRScPrN0XV
         oYAhfeWyj3Au8GH+Ezq3RueeM2lKpubP1qxeVYGc1mQGPbg0yFujCWKZsiN0/pU03hOR
         /FzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726955; x=1712331755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMXzAltYqOJOzOEzXcMQc99mG0oMwOhh00KlVSFtR2g=;
        b=eviOFdNdYnNZ/v47i+kOeRZK127kDyCxEdSMclsD/MlVsH2KccO2WCKpVdKPSWB0zq
         0vNc5w1pU015MOq+zOcK6devz5H/4UZatXyvoMeSGYuLET1j8I388uXxpQ2cwQZYTApj
         jZ6n+ec/7YkkqYSQjsokUbtD0sXiinv2YhOMxgqrzyo+gvQ6apfN5GX0NieHHUUI5c2c
         IWYSvDX7gGv84sCp372b5U7mR7fR9N/Bvx6ZULh5Ey76OH71dQBQRCuWZ2NxkMpMSXRX
         Yw3UVeHyU7vezDUKdTBw9HQUZWENLPHOHxS+YoUVQlTJlkszZUfqstz5qTxIWci75CO4
         EFyw==
X-Gm-Message-State: AOJu0Yz6Qd7M39Ee+TYzJAKI3OXSKGHmaR3LbRYU5Cng5ZqCVgFTOPf5
	7huk2jgthW0UJgPR0g6Umx0p/lndQQG9ipg/0muUlLyjGmO88Da1TCBoApHja6l9zpvoRvjmd4g
	G4/WYFzlehA==
X-Google-Smtp-Source: AGHT+IFO6e1huPIUMg0iN+arYwtte3emedADA72AYRMmN3msuI8LKpVGzxMnX+8f2yNW7ypLQx0TX8rYEYlcwQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:a9b:b0:78a:5d7c:b608 with SMTP
 id v27-20020a05620a0a9b00b0078a5d7cb608mr40897qkg.2.1711726954760; Fri, 29
 Mar 2024 08:42:34 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:42:22 +0000
In-Reply-To: <20240329154225.349288-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329154225.349288-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/8] net: enqueue_to_backlog() cleanup
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
index 02c98f115243202c409ee00c16e08fb0cf4d9ab9..0a8ccb0451c30a39f8f8b45d26b7e5548b8bfba4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4816,20 +4816,18 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
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


