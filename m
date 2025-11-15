Return-Path: <netdev+bounces-238820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1EAC5FDD6
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F05234E5DC0
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFB3207A0B;
	Sat, 15 Nov 2025 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBraT7Jp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1B1F7098
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172588; cv=none; b=eq/GYC+h+gpNb5WKmHlihstZRsy125f+4GWy9h5r75KS/rQtJVKnzGpRvDZiDoaIxrv9ZCjCCvZ5D0oM/CbvKe1DegUugLtFW2kuNxYcBcyWW/WneToE+mbfO3dRfrhFFaa9srN6Zu6R57DHlMC3ONAgZCnn32I/S2Y26xllvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172588; c=relaxed/simple;
	bh=83WFLG/0yy9m1qxQHSxPy4xE6qRhAJAt3YI/4MVjo3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fl683wwnQazE1xvaa3DO2ttJBONXfL4ScZHQ1Gty1MirRVCrJjTymoDwx8NGsApGBFV5ZYepGDe+1iS/d22c444jAQecEBBFu2Q95YMi30HBMkPxfN2HcSzjD6RF0xlO2dJKcTH6NxMwjZ1RtgGBrqvVh/SVDDQqVVBG8eLu9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBraT7Jp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-343823be748so3299886a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763172587; x=1763777387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TzLU75hqoXY4Y/mVADt0m82Z4Z19qwDZtm+29sfE5M=;
        b=eBraT7JpaWyEZ83xlYdPRG6cRpDvBHXqta6FSV11/FilZGTsNwwMhYs0hoV90e98r3
         gZ57g0d9HZg+wGZttdsr7s7KoRuPEvgaPJXidTCEOBfEz7gJVRCwkLOWOEmwgyXR1/jc
         aFZ2cWNgOpgjIv+lau529CXzLv5U2ltpkeSLGBg6q2cBXeeNA51cdqHYpgcxmtZu/4m3
         exDM9fMi1MrX8MggqyrNLWNbV+fFC7YSTZ8mRifxSLGxbaTCwyNZXuCWkGjHRZNIBKLD
         o7DTbrsSIgs8bKO0A3VshKSQLnE6Wk07Ida1VGGGGZ4uERsXQPQ9/4hoDZbniJnjEXyS
         nx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172587; x=1763777387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TzLU75hqoXY4Y/mVADt0m82Z4Z19qwDZtm+29sfE5M=;
        b=TB0+vF0f0C/WZeAbIyAkxmdX1foUlsQ03+0YxVXd1FVJIK71o/ZaxRa4KS1iR9NT1s
         FyvMC0l8AJiuynIYt9rYQONXaVuBU89+XYgEJMwRnRyAdKvspT8nOPM1OsXL/Jq2TLZ4
         lPOOUEhYsSvuEK6IzbPWg+E7ICJ4yB4sMlcTNmLXzPUFfRVUHnJGOgi3m3Ev71+EkWx0
         E1TJiV+jocvxY5d6n18fr49RxBgsEVpDawL58WjUZLY1Ksm91x0uKYfxpU+tua9srzpY
         yE0pWmmKqoZtytHNu+lvhrShNLmtgVaqk5AZJ5tagz5fs1Jgmb5+PX9CA2/pyMJxYw6J
         g1EA==
X-Forwarded-Encrypted: i=1; AJvYcCXDXKDGNPZJX82GedYQdswXPwf2oWZARn5nGx0PkiLibjQKMrVVZpMdcFSEUeOctas+Ny3pTqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UCrpgk3PpMhuN9Rme6YI4gWnyviTOKdDMISbja/V/tskPYGt
	YcoHfsu04S8SB8bt4Gw7CxVGI6VSLIm7PXQc1OG/DFMjvzWc8UpxlOY8Hg/ev67yqlIEkzYWYPq
	Q/tYU3A==
X-Google-Smtp-Source: AGHT+IECvfGQdfRSHPdZD/BEE+bgv/Uh0mhUHT1HN5jOekYDSPqjiMzZZGzvoMysTfzpI/IB0V9GLeXqU2Q=
X-Received: from pjbeu6.prod.google.com ([2002:a17:90a:f946:b0:341:4c7:aacc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1647:b0:33e:30e8:81cb
 with SMTP id 98e67ed59e1d1-343f9eb3971mr5479184a91.13.1763172586735; Fri, 14
 Nov 2025 18:09:46 -0800 (PST)
Date: Sat, 15 Nov 2025 02:08:36 +0000
In-Reply-To: <20251115020935.2643121-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251115020935.2643121-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251115020935.2643121-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/7] af_unix: Refine wait_for_unix_gc().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

unix_tot_inflight is a poor metric, only telling the number of
inflight AF_UNXI sockets, and we should use unix_graph_state instead.

Also, if the receiver is catching up with the passed fds, the
sender does not need to schedule GC.

GC only helps unreferenced cyclic SCM_RIGHTS references, and in
such a situation, the malicious sendmsg() will continue to call
wait_for_unix_gc() and hit the UNIX_INFLIGHT_SANE_USER condition.

Let's make only malicious users schedule GC and wait for it to
finish if a cyclic reference exists during the previous GC run.

Then, sane users will pay almost no cost for wait_for_unix_gc().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/garbage.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 280b9b07b1c0..a6929226d40d 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -543,7 +543,7 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 
-	unix_graph_cyclic_sccs = cyclic_sccs;
+	WRITE_ONCE(unix_graph_cyclic_sccs, cyclic_sccs);
 	WRITE_ONCE(unix_graph_state,
 		   cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC);
 }
@@ -577,7 +577,7 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 
-	unix_graph_cyclic_sccs = cyclic_sccs;
+	WRITE_ONCE(unix_graph_cyclic_sccs, cyclic_sccs);
 	WRITE_ONCE(unix_graph_state,
 		   cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC);
 }
@@ -629,19 +629,12 @@ void unix_schedule_gc(void)
 	queue_work(system_dfl_wq, &unix_gc_work);
 }
 
-#define UNIX_INFLIGHT_TRIGGER_GC 16000
-#define UNIX_INFLIGHT_SANE_USER (SCM_MAX_FD * 8)
+#define UNIX_INFLIGHT_SANE_USER		(SCM_MAX_FD * 8)
 
 static void wait_for_unix_gc(struct scm_fp_list *fpl)
 {
-	/* If number of inflight sockets is insane,
-	 * force a garbage collect right now.
-	 *
-	 * Paired with the WRITE_ONCE() in unix_inflight(),
-	 * unix_notinflight(), and __unix_gc().
-	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
-		unix_schedule_gc();
+	if (READ_ONCE(unix_graph_state) == UNIX_GRAPH_NOT_CYCLIC)
+		return;
 
 	/* Penalise users who want to send AF_UNIX sockets
 	 * but whose sockets have not been received yet.
@@ -649,6 +642,8 @@ static void wait_for_unix_gc(struct scm_fp_list *fpl)
 	if (READ_ONCE(fpl->user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
 		return;
 
-	if (READ_ONCE(gc_in_progress))
+	unix_schedule_gc();
+
+	if (READ_ONCE(unix_graph_cyclic_sccs))
 		flush_work(&unix_gc_work);
 }
-- 
2.52.0.rc1.455.g30608eb744-goog


