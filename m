Return-Path: <netdev+bounces-238822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA44C5FDD9
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F28535AC0E
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5A91EB1A4;
	Sat, 15 Nov 2025 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCWmHm6K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE720A5F3
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172593; cv=none; b=KVzmBpi36vNWe6gra+uH1ZdYi2uxvA5olZSmx97oAvYhXC6Xm67TgXW8bsEwAEveWfusMCVuutLCbd87Ut5804ZoSzShP1mwEGpz4HDR94PAXoX5RvRmcxasciI9PtHo6Ojgi65nVYBPEReixjUcXC/Vn3+0xL7raQZJb6P0g8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172593; c=relaxed/simple;
	bh=aPmPfFLwCvkI/WBDxrd5BVJ1KGzz8KnbbH2bidTcX3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fUcEKaTnPK5OR5vxqnqLBn5VjV0zy3I1BRp341pzhscjnh2dSQUbpI3FIG91XO4yAELLfOMfAeXdmLCSsNNbb7eOna2x6zp4SczrdT7EAigUG+7tsjoIqhfDDSCwa2oqbtwTqcfZOnqE4rdH0ghic9TgljxI0R0nv6sjNw/mKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCWmHm6K; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2956f09f382so23185065ad.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763172590; x=1763777390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=thJcAYT9pfFuIr+VM8tAlHtJysaDKRkyaAXYP+Vcx/Q=;
        b=nCWmHm6Ka3EJWLBwCiqNK8rfBeCzXOecGCq79lVx8YvizUdTcNQIKzDDmTxkssRi13
         ugUzsfwqtVZLAf4ORkh0gWU2sCL4A0WG8jraLQyh8+P81gVfN2DO8s1u6bOLsZ5JSAd8
         Oe3OOX+5w+3mWHrmtc8dpucYRLcuN8f8VB6xDkvVrIFnN2N4C9uRp5WXkvZ/diz9QN/J
         DR7ql3oCnWLPZskGRxfbpJrg3rvntNbPEk84WeRrAiV0wE0n7i18WghOfqKw62MK9KxK
         em86QBZFsBIu9QSzh8l23uiIXsy6gq+ijqZWJoH5ONNRRADKELaoms7GxMx8ckJ/D6qO
         KNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172590; x=1763777390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thJcAYT9pfFuIr+VM8tAlHtJysaDKRkyaAXYP+Vcx/Q=;
        b=mQtCxxxf+2BSx11ADnUomOoovII3JbRN7gA1w87ruD2UEmHBStu+OxqPGbtC+kbjwF
         ys4qMQsLdfjJOgc0JbRqZko107+hhDvQC9MdI875W2roK3nkbrR9+rJdV3qRTX4EPA1H
         bFAuNbSPvuF/oEDjEjcXzJwFACIEWwY9R+pCS9Ixh/xcoyTjwS1zwinAqBmvFD1qeh8f
         1stJpIWgBsuGEd3snRtdpPEwLLcQzVOqcCJTkCnKKG3we+HxDspARr1bSuin8FPWbme+
         YuFg/YiI5LjpuldqAhGp0TPfL6nXolnUN2XtMQnftq8AGBoMZOyF781j//0URwrZvaQ9
         Xuhw==
X-Forwarded-Encrypted: i=1; AJvYcCXnzYf+OCa6lEuzdUsuR+4WDImYKlVDauAnRmyM9HFWVYUkRDHGRb0Vl/3Be604EEIb5r7102w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQ76/ruwc3Use2N1grfC7gV1UIEQHMkF60K6jGjUl2A6RQJHU
	pm8pPfalq/vrFIIJB4EoB0I3eZfYwH3Xg0fekpvgotHnnWNGH3Yh1vfoIExr4N03rFXGNIm799G
	sl+ehFQ==
X-Google-Smtp-Source: AGHT+IFk/GEnx2ARodhebVyXBcqUge95FBVFr4FUnkpTm39OptesQ4YaCJiinDCrqLj0v7IF9LGuzh1Pkwk=
X-Received: from plkp5.prod.google.com ([2002:a17:902:6b85:b0:298:223a:1f1c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c2f:b0:295:82d0:9baa
 with SMTP id d9443c01a7336-29867f965b8mr64729875ad.17.1763172589849; Fri, 14
 Nov 2025 18:09:49 -0800 (PST)
Date: Sat, 15 Nov 2025 02:08:38 +0000
In-Reply-To: <20251115020935.2643121-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251115020935.2643121-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251115020935.2643121-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 7/7] af_unix: Consolidate unix_schedule_gc() and wait_for_unix_gc().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

unix_schedule_gc() and wait_for_unix_gc() share some code.

Let's consolidate the two.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c |  2 +-
 net/unix/af_unix.h |  2 +-
 net/unix/garbage.c | 28 +++++++++-------------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 34952242bd81..e518116f8171 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -733,7 +733,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 
 	/* ---- Socket is dead now and most probably destroyed ---- */
 
-	unix_schedule_gc();
+	unix_schedule_gc(NULL);
 }
 
 struct unix_peercred {
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index 2f1bfe3217c1..c4f1b2da363d 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -29,7 +29,7 @@ void unix_del_edges(struct scm_fp_list *fpl);
 void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
-void unix_schedule_gc(void);
+void unix_schedule_gc(struct user_struct *user);
 
 /* SOCK_DIAG */
 long unix_inq_len(struct sock *sk);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index fe1f74345b66..78323d43e63e 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -279,8 +279,6 @@ void unix_update_edges(struct unix_sock *receiver)
 	}
 }
 
-static void wait_for_unix_gc(struct scm_fp_list *fpl);
-
 int unix_prepare_fpl(struct scm_fp_list *fpl)
 {
 	struct unix_vertex *vertex;
@@ -302,7 +300,7 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
 	if (!fpl->edges)
 		goto err;
 
-	wait_for_unix_gc(fpl);
+	unix_schedule_gc(fpl->user);
 
 	return 0;
 
@@ -614,21 +612,9 @@ static void unix_gc(struct work_struct *work)
 
 static DECLARE_WORK(unix_gc_work, unix_gc);
 
-void unix_schedule_gc(void)
-{
-	if (READ_ONCE(unix_graph_state) == UNIX_GRAPH_NOT_CYCLIC)
-		return;
-
-	if (READ_ONCE(gc_in_progress))
-		return;
-
-	WRITE_ONCE(gc_in_progress, true);
-	queue_work(system_dfl_wq, &unix_gc_work);
-}
-
 #define UNIX_INFLIGHT_SANE_USER		(SCM_MAX_FD * 8)
 
-static void wait_for_unix_gc(struct scm_fp_list *fpl)
+void unix_schedule_gc(struct user_struct *user)
 {
 	if (READ_ONCE(unix_graph_state) == UNIX_GRAPH_NOT_CYCLIC)
 		return;
@@ -636,11 +622,15 @@ static void wait_for_unix_gc(struct scm_fp_list *fpl)
 	/* Penalise users who want to send AF_UNIX sockets
 	 * but whose sockets have not been received yet.
 	 */
-	if (READ_ONCE(fpl->user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
+	if (user &&
+	    READ_ONCE(user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
 		return;
 
-	unix_schedule_gc();
+	if (!READ_ONCE(gc_in_progress)) {
+		WRITE_ONCE(gc_in_progress, true);
+		queue_work(system_dfl_wq, &unix_gc_work);
+	}
 
-	if (READ_ONCE(unix_graph_cyclic_sccs))
+	if (user && READ_ONCE(unix_graph_cyclic_sccs))
 		flush_work(&unix_gc_work);
 }
-- 
2.52.0.rc1.455.g30608eb744-goog


