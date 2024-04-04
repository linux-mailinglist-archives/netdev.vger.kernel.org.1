Return-Path: <netdev+bounces-84884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB9D898888
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 15:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE31B2505F
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEEF8528D;
	Thu,  4 Apr 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MH/5PQ++"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0A76023
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236074; cv=none; b=nRyYLCkVuCYFLg3IIcL3jH2U7b/SjCZ+FJBgH83+GUQKyNsZNXS4oAvyjXd7d/rFVcaTHyS7dGuD2LEl1w1UDsygOZgHACOZsI10rBaPi4BYYwHcgtDaf09D9iEB32HiCTgGtMGhNfaG99g/VtIc+RX+8bqK5FhVjMZhAVk03/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236074; c=relaxed/simple;
	bh=4526Fd1fMfbhSrs9bB5+r+6tShBLe8V2w8nQ+cxEkDw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iI8nrwwwCq5Mza8Ve3ouWqXB2IXk6riDJ2IhlItk73w+irY1iJsRCYRNPihGTa11mAPS3gWefIaK/Vyt2+jeOkRtQMemfYS8IvZC5aTJYBcGhX/V0v3I5mV+s9YJoP5cmczgNtW/YfGUsKuBgJivwVS+Ki9Bw8dGhDiQQ/7OcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MH/5PQ++; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso1788932276.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 06:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712236072; x=1712840872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JM1Ymy2GYNlXNELpSROfsqQYCiahY84PSa/fHJKiB7Y=;
        b=MH/5PQ++eUTwmA4dhz4MEON0mRAeJ2QucmxujWVF/bSr7mXfqw8BAjcnkkl9MoThAM
         43aj9dOBP40j250ClYtZiUH3gGJGWn2Pn6PtCZJ185b0CAWkAR6vOj39ndsX22syXPwf
         uAe6BG1UINDSfagO4q1atrQtTfxX+3Sw7b9G7nLjMTDv006eKYSL5JoXT3C9Y2SvGS4/
         hAx9yAYp0JvFgf7Q+0lFNR8APAb5QgWJfi14cRghR1/yxHrecK4KbwZU6gANLXAILRT7
         eHkT7IlqcYKKkNSCKLpmyIOxHwkBpZTWeVXyUU58YbwT4M+ehLD4Nrj+DFOBSB2n/l+e
         nB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712236072; x=1712840872;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JM1Ymy2GYNlXNELpSROfsqQYCiahY84PSa/fHJKiB7Y=;
        b=F7rxKM5pkXNvygwKlExNceyu2hMNlgSgeiSa85zJWT+8n3Eb6eUQNF3f5ITGYSOsXn
         Jt7am9FMKGJQafx5TJnMeL5OWIizQdJBLAXA6T8PS25/y2CgLQzeTDqC1uTuKTPvcmNO
         tn9AaWhZfUdQsD2m/sdJYlxyDiCOj9fGWAw7W4VPTSeT1MMNSrk6vvAMDzEwGfOUk9RI
         5eHSe4oRJClH82ge3xu2x7ou64P5zqRZtg4eq9zCNozbd1/7w0CI8ZJHN0gGMM9C31vj
         qfq8LlqAcY9zEY4BWnUMCsNcuXg0c+pblkAUA5tT0osBm6qgT8Hyp1BNMNq4jBkDuY5Y
         FJcQ==
X-Gm-Message-State: AOJu0Yx7Kf0CzRyfxr77981TbJSXtRgbNRVwqszBMlez5eggu+/sdJ+m
	LttxrfH2klKandsfg5xN/HbBuAFGfTKjcOKmU2hBWCqYnaWxX87AAaRVqwcP08k06IJoLIzJ4d+
	sYOZogrNsaw==
X-Google-Smtp-Source: AGHT+IFlEDAJVh49qEj42qUQaZbkZQf2GvUtjXB4l74E/w8NK6AIZd9D2dDzuT1DLBil/5Fm69Ukry/qdBMMJw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b83:b0:dd9:2782:d1c6 with SMTP
 id fj3-20020a0569022b8300b00dd92782d1c6mr859445ybb.1.1712236072490; Thu, 04
 Apr 2024 06:07:52 -0700 (PDT)
Date: Thu,  4 Apr 2024 13:07:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404130751.2532093-1-edumazet@google.com>
Subject: [PATCH net-next] inet: frags: delay fqdir_free_fn()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

fqdir_free_fn() is using very expensive rcu_barrier()

When one netns is dismantled, we often call fqdir_exit()
multiple times, typically lauching fqdir_free_fn() twice.

Delaying by one second fqdir_free_fn() helps to reduce
the number of rcu_barrier() calls, and lock contention
on rcu_state.barrier_mutex.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_fragment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index c88c9034d63004e7763f60b3211dc319172c8d06..faaec92a46ac03e1fd4d1dfaf9a7fa080148ca2b 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -175,7 +175,7 @@ static void fqdir_free_fn(struct work_struct *work)
 	}
 }
 
-static DECLARE_WORK(fqdir_free_work, fqdir_free_fn);
+static DECLARE_DELAYED_WORK(fqdir_free_work, fqdir_free_fn);
 
 static void fqdir_work_fn(struct work_struct *work)
 {
@@ -184,7 +184,7 @@ static void fqdir_work_fn(struct work_struct *work)
 	rhashtable_free_and_destroy(&fqdir->rhashtable, inet_frags_free_cb, NULL);
 
 	if (llist_add(&fqdir->free_list, &fqdir_free_list))
-		queue_work(system_wq, &fqdir_free_work);
+		queue_delayed_work(system_wq, &fqdir_free_work, HZ);
 }
 
 int fqdir_init(struct fqdir **fqdirp, struct inet_frags *f, struct net *net)
-- 
2.44.0.478.gd926399ef9-goog


