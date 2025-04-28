Return-Path: <netdev+bounces-186605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414C1A9FDB9
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CFF5A697A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DA8214A80;
	Mon, 28 Apr 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn1Z19OY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CB2147E5
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745883004; cv=none; b=SIK1vVFPSupPWqS0IMtIM9LdT6388ErkR5YfF+AfCANwE9z948RnuGG9aWx7KpJQbgNgp+aqteVlhX/QVrpzQXNSrilfnKz3NFgX+09AZJ2JljW6qK+6KWy3GzObsoZWdxet7/YRF6CRG3Cahb7ZAmQvY+6FWPjQctg2e0HhtwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745883004; c=relaxed/simple;
	bh=YA6GBFUT/Io27+GChZN23tVuD5gOfpTV/AywSubvmYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQNr0ftwJKFqzbZmCM/kJ9n7iqbVFwQAbtVuctBwvMWfM/ryA9zfebdSRRx7QHVDCHOYCYsPKlU2Wv6rzx9/GxtJ6lnNhk9ocdT+PURuA5zMZScNXN7AG3pMd2CD54YcOex/9kYSn6vG13GUpYW89izdMq2jzLvrTW4LYgOq9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn1Z19OY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227cf12df27so51427075ad.0
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745883002; x=1746487802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alAfuCt3XQlNIjrwQoaumn2nOU6Sw4uPyJMonFDigSI=;
        b=Tn1Z19OYu19NxJy88IPI6z+SFeoKGiUHrsu8zok8va9889gPDrT9RQ7nq/JDM7HhVJ
         4ADhlsqc2vJx6vs5bmI9NA2RRzN3QRj/gOvH2IRkSWrW62a7y1Ish1C5UrXuyc5HhNUf
         5JXkg5bVXz+2YbGiILY7XnVvXxXE9esrRadvmZb9KLqEixc+9wqSM3dxn/pGqo67skDI
         mE1B5y/SCk6N0+hydd43KnVaRmECCs1JfdUKYpiclnANv5JA7/G1EnQ/gRZAaNSiaa/p
         UhUjeWAP7VmpLSlr0icsrhPv1Xj2ArsTPGOAfjRH019OnBK3IfFpGB68OaQ6HbBWFsWD
         fIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745883002; x=1746487802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alAfuCt3XQlNIjrwQoaumn2nOU6Sw4uPyJMonFDigSI=;
        b=QjYhgqgHgZBKLJ9HSsY8yVzphf+AE5Z4zH/7/vtrFcjtfWMn8Sw8Jv1z4+JGMUP2Or
         lBQYVyY2p8LC6XMeV69Q+ai9EYetAzOZhh81xwaPcVp2jJM6jwN/vu5s84uNee4+yuTw
         HvmEd3Me1bGl1pyL2nHEi6EaoyHizhLUzUggCRIbMLDHiYMDrqhO0cx7qNMP62uRXYlv
         hhiZQmWLNs8ABj+aiPrHp56Vnv3iUmaBGcK64NjTnVsEUZl46dF0MBc4vEce/HHjqQN6
         X+YKu2Eus+K+9u/D9m5fpyt5KbUEQNB8sMtmzqqqKdv3K+HMxfMehPwFXyA1xuKDegTM
         gnRg==
X-Gm-Message-State: AOJu0Ywjr//03LSHXfSs2aoIy9TcnoTFFfyC7qHTv6kBDPMLygq5twa/
	KtoTJdbHt1D//4dJ2fLrcF2Pws9iKfFakekOCE0mi7C+WTTEV950Y62gEdVN
X-Gm-Gg: ASbGncuDS3C7UruzXCoZX96DHbPKquLyHjE8EcSn7r0EG7YO5P/f63Q8hYu+VUPH6Kk
	/4Eez6WTfiT9mQxc6uN+1KFORDl3ZKspnNBLHRNdUqQPtWT6MiSBhlmuiKgKcBKJPVYXzh0AY7V
	5hC7nt/gx7idS3RqwSb6fvs9x/QMUBxyBjkhXlRhqkfEHIRggHXsdt6+TLckXyzf81Bo8gVs5qb
	ROuv52U2LaB+niMU0Df/JztPcCVxYhX1CDfdKR6jTo5nz/ho46BUSjAtvjVLphhGsQhvsW4c7QN
	PCrK4lTKEUPJUKgY/biPYgAwHXPXbc0UsV7MNTGL4ih34C6geoY=
X-Google-Smtp-Source: AGHT+IHeIAR2PQL6CVj1MLLy/z05jobwnJATIz2HMAoX4PfRvEyxmk5geY+09XQfpYOhBW5qw59Sow==
X-Received: by 2002:a17:903:1b68:b0:223:3394:3a2e with SMTP id d9443c01a7336-22de6c3dee1mr14409445ad.18.1745883001898;
        Mon, 28 Apr 2025 16:30:01 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4db97b3sm89248235ad.55.2025.04.28.16.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:30:01 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	alan@wylie.me.uk,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 1/2] sch_htb: make htb_deactivate() idempotent
Date: Mon, 28 Apr 2025 16:29:54 -0700
Message-Id: <20250428232955.1740419-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
References: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alan reported a NULL pointer dereference in htb_next_rb_node()
after we made htb_qlen_notify() idempotent.

It turns out in the following case it introduced some regression:

htb_dequeue_tree():
  |-> fq_codel_dequeue()
    |-> qdisc_tree_reduce_backlog()
      |-> htb_qlen_notify()
        |-> htb_deactivate()
  |-> htb_next_rb_node()
  |-> htb_deactivate()

For htb_next_rb_node(), after calling the 1st htb_deactivate(), the
clprio[prio]->ptr could be already set to  NULL, which means
htb_next_rb_node() is vulnerable here.

For htb_deactivate(), although we checked qlen before calling it, in
case of qlen==0 after qdisc_tree_reduce_backlog(), we may call it again
which triggers the warning inside.

To fix the issues here, we need to:

1) Make htb_deactivate() idempotent, that is, simply return if we
   already call it before.
2) Make htb_next_rb_node() safe against ptr==NULL.

Many thanks to Alan for testing and for the reproducer.

Fixes: 5ba8b837b522 ("sch_htb: make htb_qlen_notify() idempotent")
Reported-by: Alan J. Wylie <alan@wylie.me.uk>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_htb.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 4b9a639b642e..14bf71f57057 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
  */
 static inline void htb_next_rb_node(struct rb_node **n)
 {
-	*n = rb_next(*n);
+	if (*n)
+		*n = rb_next(*n);
 }
 
 /**
@@ -609,8 +610,8 @@ static inline void htb_activate(struct htb_sched *q, struct htb_class *cl)
  */
 static inline void htb_deactivate(struct htb_sched *q, struct htb_class *cl)
 {
-	WARN_ON(!cl->prio_activity);
-
+	if (!cl->prio_activity)
+		return;
 	htb_deactivate_prios(q, cl);
 	cl->prio_activity = 0;
 }
@@ -1485,8 +1486,6 @@ static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)
 {
 	struct htb_class *cl = (struct htb_class *)arg;
 
-	if (!cl->prio_activity)
-		return;
 	htb_deactivate(qdisc_priv(sch), cl);
 }
 
@@ -1740,8 +1739,7 @@ static int htb_delete(struct Qdisc *sch, unsigned long arg,
 	if (cl->parent)
 		cl->parent->children--;
 
-	if (cl->prio_activity)
-		htb_deactivate(q, cl);
+	htb_deactivate(q, cl);
 
 	if (cl->cmode != HTB_CAN_SEND)
 		htb_safe_rb_erase(&cl->pq_node,
@@ -1949,8 +1947,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 			/* turn parent into inner node */
 			qdisc_purge_queue(parent->leaf.q);
 			parent_qdisc = parent->leaf.q;
-			if (parent->prio_activity)
-				htb_deactivate(q, parent);
+			htb_deactivate(q, parent);
 
 			/* remove from evt list because of level change */
 			if (parent->cmode != HTB_CAN_SEND) {
-- 
2.34.1


