Return-Path: <netdev+bounces-283136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNJJM+9Y9GkvAwIAu9opvQ
	(envelope-from <netdev+bounces-283136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:40:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6012F4AB009
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BD03025A78
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 07:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193DE36897B;
	Fri,  1 May 2026 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFZ2EmHA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FEC36E495
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777621190; cv=none; b=DbHBibDizS2ClWWi3kuBRg5Mg+eQAF/MJ2wg4/BorXp7qguyWEP5Lk4ZEkfzw3aKspdx6j/7S4c6NnHx9t8+Tc7gggRZEyBlsyL6kxAk1eH9xHjbCQEXn+1oL/ezKgm+IRdMag9h7LC/05iGgkHijmiJJcK+axl1Y5ve0kKFEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777621190; c=relaxed/simple;
	bh=/EdJRkBzR4+HWhVmk7W9lHzBTXBrDpq8Np6bFNq3hYk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RQgh0mqad4oiZWptGVCTxc9Y8mv/8JMrdi6Oj5pUTFM/+Z+UsOkKXRjlDAc8paGz3+8b/yqaZlsOw6uAcIc0UW2xfXXdpBP779Xx0ZWywYHZsirKQR9DAs43sI8u7I9O6nsGAD9a2VDFIyTgD4w13NAjcItq7zJv4B5TS9H7ruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFZ2EmHA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f780a13c9so1252777b3a.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777621188; x=1778225988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GlkY9B/hZRdnA5xCeKkByHlw6PSTFvRnLOHMGMZes10=;
        b=FFZ2EmHAZygpQ3HPb10fGbTs3z08L3paozW4fPjZhrLFJmiMUN3WV3yo3Aywypd5jS
         1SSk9tJaHHtAZmLmkZgwjalwTvCP8VgZRwQ8DrULFNssg2lJEjH6OvXc8z3n7YqLjrTU
         ocdoVp6wFqed6I4A200pgaGyutgO60jkJtznBEZQOR0Gwh5Ug/H5WTjKEFJkm6GDyYXS
         7wDtz9V3wgBXRufxlJHba4m43rXECsFYlC2MeBkzTwGzvLd03VOyF98S+l5ARxBzTUqP
         WlNtFYNMLSQdr86o3+/qXDulCV8C9EwL7GrulAjdlhtLBCNtd8IPIeBhrI9MJW+Cjz3T
         6Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777621188; x=1778225988;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlkY9B/hZRdnA5xCeKkByHlw6PSTFvRnLOHMGMZes10=;
        b=iFBJshfoNr/BDvlBzdZGWeJmXIxNnpRAX5YCL44sGdXRr5eEAoy3WJ2qF532YoXMad
         VmHW8ihosUWbdd+62ct0oc5a/yj+7hJGFSI2ZYTgQU1TzKjqCP9eYOjwT9FDvw+x/XNg
         6HOv1/Fdv0JPxcNBiFRNvptuOdmCYvzl5eP3Haop2n+nkzWRiMnaS4EfI0odGlH/ykgq
         4bGW10N7DZHUCZB0fCNnblnqHqkoKKX+ZQiV1M/RF2q+PUs9nNwZKWmdDOt9hdzOXwRb
         mNMgm/ViiHO7pET9zdNuZ6UJZG47C8jmpXCp+bpfRmxl7AhfWCaJv5LXUnm/yyWWF6zW
         W7nQ==
X-Forwarded-Encrypted: i=1; AFNElJ8B1sij4H0tKR4eDDGM8QA7TUVnIyQMBmLHmwVm9QbiMfPeeZhEDsoBqEDIokWOoxo87zI4pvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1C7uBUWrPUX3Z8A+B9XTLxXz46t93WKWe2F7Ewnesmbn+2QZM
	sPZyYl+AF7UG2z/WT5BbSOn8wyUwwmgz+n+JngGXH+EfyvbDlqjiJbaBtDjFVwfQ8M7pzS/+VTK
	wCnb+2A==
X-Received: from pfaj5.prod.google.com ([2002:aa7:9285:0:b0:82f:a2bb:a7cf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:420b:b0:82c:eb69:1936
 with SMTP id d2e1a72fcca58-8350000a929mr5205358b3a.19.1777621187815; Fri, 01
 May 2026 00:39:47 -0700 (PDT)
Date: Fri,  1 May 2026 07:39:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501073945.1884564-1-kuniyu@google.com>
Subject: [PATCH v1 net] af_unix: Set gc_in_progress to true in unix_gc().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Igor Ushakov <sysroot314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6012F4AB009
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283136-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Igor Ushakov reported that unix_gc() could run with gc_in_progress
being false if the work is scheduled while running:

  Thread 1         Thread 2                     Thread 3
  --------         --------                     --------
                   unix_schedule_gc()           unix_schedule_gc()
                   `- if (!gc_in_progress)      `- if (!gc_in_progress)
                      |- gc_in_progress = true     |
                      `- queue_work()              |
  unix_gc() <----------------/                     |
  |                                                |- gc_in_progress = true
  ...                                              `- queue_work()
  |                                                       |
  `- gc_in_progress = false                               |
                                                          |
  unix_gc() <---------------------------------------------'
  |
  ... /* gc_in_progress == false */
  |
  `- gc_in_progress = false

unix_peek_fpl() relies on gc_in_progress not to confuse GC
by MSG_PEEK.

Let's set gc_in_progress to true in unix_gc().

Fixes: 8b90a9f819dc ("af_unix: Run GC on only one CPU.")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/garbage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index a7967a345827..0783555e2526 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -607,6 +607,8 @@ static void unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (unix_graph_state == UNIX_GRAPH_NOT_CYCLIC) {
@@ -649,10 +651,8 @@ void unix_schedule_gc(struct user_struct *user)
 	    READ_ONCE(user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
 		return;
 
-	if (!READ_ONCE(gc_in_progress)) {
-		WRITE_ONCE(gc_in_progress, true);
+	if (!READ_ONCE(gc_in_progress))
 		queue_work(system_dfl_wq, &unix_gc_work);
-	}
 
 	if (user && READ_ONCE(unix_graph_cyclic_sccs))
 		flush_work(&unix_gc_work);
-- 
2.54.0.545.g6539524ca2-goog


