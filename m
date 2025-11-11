Return-Path: <netdev+bounces-237514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CDCC4CAD5
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F15D348083
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2B82F533E;
	Tue, 11 Nov 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXZRsPiB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1353E2F49FE
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853539; cv=none; b=Wk66g4qej96ZOB41imNfUFp6HH0h+EAaropezWQtv11jVnBOiTTWyfwkSF578oIH7CErgEPnuD1kWhQttJo9NVxGjGRviJkwBf9Y2EwBTc6F2N3kB3IqMCwSjzlQMs/BZH8aaErtFAyA1neWQF4+lcAJDy06hlE3Xousi/f6IoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853539; c=relaxed/simple;
	bh=PHJCJ+CP//xNCU6DBRlLRjz0EaWnfLm09kQ2eA5zMPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UZkT7jeV8woRiG9a+uS5RLnLv+AQtD0gGZCbNQ78mqMUsAY474rw7p0mZjjpz9uTdjAES5Xs7Ak/zhBFNMW10oQDn06TMHrUgV84BJNZDR1jE02IoN0UG4L33k0fgpvvvRHaNqpmSht0fbcN+UTLrPn5w/DmX0dqqHJE3vTkk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXZRsPiB; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-63e29ad5503so5822256d50.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853537; x=1763458337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKoQoFbnuQNmM9Bz6hnIh6jeyLi5x8PGlTQfv3shayg=;
        b=BXZRsPiBNR0SEZ5KpGTV2hde9orbuYe9U+k3+Nr4yuOwV3qLd87vEyhBnhKzVCxsG9
         OvXibisqLhpoVSlJpVi/MJeghTQ5YJOy+2liRw19gslHSBi/e9EGzYWazaCLCbbdGnfE
         OCsckgYIrVo0qayISww1LCGFetQG6RlY8W3wQA4x1FBCr+ijj6GsC6CAB2x7hXqaKMO/
         BNEoVKN8QiL0ayyJ5tQAyOllaxuicTD4fXj4jfeapgTGbPWMPGML23GiPJupLvIfxIRi
         egcUs4Ko7Wxn74Xc84r2hiai/DHc767nrWbFvcLjifFfXZF2+eim+HtqvAVSHCDCJezK
         TkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853537; x=1763458337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKoQoFbnuQNmM9Bz6hnIh6jeyLi5x8PGlTQfv3shayg=;
        b=ZoXixsQx72KUAxtF88dDTyMvlXJjRc+TU9pGG+uPrwDy4lKsyCCna6hzBBRvZ9Fb6h
         mi/jt6PebsgXhu4OPvmgsPwrSpOpPK7AQ7u6UdvvfnuBgTOJ48qdtjmreEgh3uHgh+J3
         +WcUULduh25ap5mCbRVzS2QvJ1A3JipfNjnKVlXf1uQQMovdVmiUICjuSxWmYgzU9vtU
         /bkUc80QYcwgthaJe9ebBfQ0r3Jdm0jJFxjdp8xU3SNuEMcp9UXaey70bRAdd4jUDrhY
         52myp4H+bfbx+rL/OlIbbRXFhn/ue6aDlkSLTswhYRo1O9B0YrPflA5sdjfa1TIkwwHO
         CDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUykZk6I5cTHNvNG/BYG6LG6wfhkuhtJ0mmP86GELwUNEURcV+iBfnYcBfJQ0Wjl+VFAKiJRZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQr7F7ipykjU/EEAB4cANqhkasRHrw1Gv6+1YRfNwyRMTxROs
	DhFH2mkELhyuA7oN+3jkkWNd5zzRVc2iv9qSVyryApoFpTArRvFJdYzOpDRn4a2jKYOnqIwDub/
	tADYW0kGYPK+IbA==
X-Google-Smtp-Source: AGHT+IHyiVuXq7gfaWwX+frfQMyJMn8+Wm3a0QRgmVH1csWD2ETPNcUtTluoC8S4sTbzeKD0zv7qQRD9cEBD0w==
X-Received: from yxvv12-n1.prod.google.com ([2002:a05:690e:428c:10b0:63f:2d9a:64df])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1594:20b0:640:d119:d330 with SMTP id 956f58d0204a3-640d45e6b58mr7759826d50.56.1762853537230;
 Tue, 11 Nov 2025 01:32:17 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:57 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/14] net_sched: sch_fq: move qdisc_bstats_update()
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
2.52.0.rc1.455.g30608eb744-goog


