Return-Path: <netdev+bounces-120697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE395A429
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 19:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454421C212AD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1D1B2516;
	Wed, 21 Aug 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFV74yNN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6D4206B
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262823; cv=none; b=HBEp3126CfB8f4L+Rs90bvUKnw4y8M+R5xACxAdqx0IjFv4NygNRANtWS2y8Yv517e0ExeIzjjdvR1ekOeDxbesjpp0INQ8RCWcOTGTIxe0tNGTyQsRyTT/RD2X5NQ58AmJbxkLUp3dsyS885hsbD9WD1QJ0LEUXfX+2G2U6IPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262823; c=relaxed/simple;
	bh=wvIq78vKflWxIe1//9kI5ZOXJKEh9H+pWVQk9dkiOsA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BEEtORPJ1OXkMOrqp4s6P6B+iO+SRlTqFLVUQyQFJPw2RCxbI935WXT5XW/jnIkvjYAcRGCBPno8QLpgxvLZz52uCKL8ZqHbu7NylELu3ibFBxV+abV6cRfmRyVZZiiiWb2Qsk2uqo6YRLjvxspmYhtRPD3pjzAopoGHr83icM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFV74yNN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b46d8bc153so74671047b3.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724262820; x=1724867620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/CzOcdMWgptLPxpLQDWNF6iSLdDNs4WEmOScSsRe5K0=;
        b=fFV74yNNmTkRcxl4LxC/A14CiYnpSvkCw4nd25bOcaxhvy8VwmGg1VqOZMUYiX5Fdc
         o6G9qc8hacBWEWw80WDExOl52VYa9M1fI49Fc4Pu9QXMlgckxkmZTci2JeWMwtQMnhfV
         pwS52m/eA70f4Q7A8ZmjxErzT+kAUxO7gbV+rbbS0sTRjl9s22JZ4r6kJl8HzV6i7K3T
         IAi+Ebpo7N0ocrDKIXEBo5xLiiGyT9zsOOVJtEwnWqQyY2kFKo00idS9eyIGcFKgm1ql
         PRy0PN3Aj5iVC0wjKMGzJBRPaFEzIs92zVGsxHV9jizEjgwRVUj5qxI8+q8fgq5EQsz1
         RN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724262820; x=1724867620;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CzOcdMWgptLPxpLQDWNF6iSLdDNs4WEmOScSsRe5K0=;
        b=t/dXnuehvSlW+WSWtRq800VbV1WFBHNdFF1I9y+YcAtLgRyhMnxHPBfLLByv7fFsxE
         i44vj9GqZkMj3p+Cn3EqKYLlOwQJcWo2oNwgWIKFhghYfJpE+Lq8d6k5GwkfI4apt5G+
         2flYIP0wbt5lQdgq6vBOg9zDdWGA9A4vMzt8Uxoxthxg5N9yhxYN0K+dluwMeC1nZ6rH
         41npbneR+42iyefiowrO+2eobQYOYnuAbu/c2cp0Ho2U1Ieqs+4MYfUhyvDvZ/WBKfRY
         oHV8Fd2BabKFlnEZecjAFJ5kTQo3zO/li9hgDmgzHKQJ/JHwLkpizUE8lLsRar6ypK9w
         V+Sg==
X-Gm-Message-State: AOJu0YzZUw9bNi1qmDZ5iNsIn+I9xLozx7VuGq4LgvV4RMO/83towC0Y
	wKlz2KwASmDR56vDqZZD0ChdUoDEqUiWRwvbvYUsU6xQB6O2i1KwOwy4ceDobvG69++eBP7HLgu
	cHKzWvLaljw==
X-Google-Smtp-Source: AGHT+IGNr08bdLBCGU0GtIYqg1ESEjUmFKQzpVvJr03iAmqIH7KxsLwVaf/8R1ZrN5xckhJJM84tnZ6kdJYaTw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ab07:0:b0:e11:7105:956a with SMTP id
 3f1490d57ef6-e166541157bmr4709276.3.1724262820491; Wed, 21 Aug 2024 10:53:40
 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:53:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240821175339.1191779-1-edumazet@google.com>
Subject: [PATCH net] pktgen: use cpus_read_lock() in pg_net_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

I have seen the WARN_ON(smp_processor_id() != cpu) firing
in pktgen_thread_worker() during tests.

We must use cpus_read_lock()/cpus_read_unlock()
around the for_each_online_cpu(cpu) loop.

While we are at it use WARN_ON_ONCE() to avoid a possible syslog flood.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/pktgen.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ea55a758a475ab0ee22d9ac91f0ac9f0a6975e1f..197a50ef8e2e1bbe9f3906dfb80e80d913534b81 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3654,7 +3654,7 @@ static int pktgen_thread_worker(void *arg)
 	struct pktgen_dev *pkt_dev = NULL;
 	int cpu = t->cpu;
 
-	WARN_ON(smp_processor_id() != cpu);
+	WARN_ON_ONCE(smp_processor_id() != cpu);
 
 	init_waitqueue_head(&t->queue);
 	complete(&t->start_done);
@@ -3989,6 +3989,7 @@ static int __net_init pg_net_init(struct net *net)
 		goto remove;
 	}
 
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		int err;
 
@@ -3997,6 +3998,7 @@ static int __net_init pg_net_init(struct net *net)
 			pr_warn("Cannot create thread for cpu %d (%d)\n",
 				   cpu, err);
 	}
+	cpus_read_unlock();
 
 	if (list_empty(&pn->pktgen_threads)) {
 		pr_err("Initialization failed for all threads\n");
-- 
2.46.0.184.g6999bdac58-goog


