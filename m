Return-Path: <netdev+bounces-196545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3362BAD5380
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7723AA367
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68DF25BF07;
	Wed, 11 Jun 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcdG42fq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C82E612E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640528; cv=none; b=dw7fkKEVcQ3HGAiFyLFCa4uhv2XvlBxWZj8LpVQjTIjTNH3g/mecaZqLUSY16Qw3+h4AyYlr98xmAG2W5nXFVTOA/v7JBEn1BeGHLNF881PNofEs/MOQkTDhL+OVM2x6gYd+1WUQSnPNrMzHjAn39uZqdids5gJ5xFk6Ko2T0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640528; c=relaxed/simple;
	bh=HPuIYAX/VTrdQjSDS7KazCt0DYTMtCK/w2XQwOjOqF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R7Z/QZLnpVLKYkA3ap7POia4PkOaqxFVMGedTsGtf47WUAFdykfEQ/N/RST+OtatDJobewBxzN1ReSjFLXyNw8HK6N4vsamlDWDbx1cheVbEljFPOi6xFHJrVjxcwJKkXEbmMoLKT4PfSivGo3Rg9wgH9CK6lVt3smaC0EcFEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tcdG42fq; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fb1c6b5ea7so54060326d6.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749640526; x=1750245326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6aYuOuepOLHnUdb8TRhjPvWKYz/EnrixU8+xU2r5gus=;
        b=tcdG42fqdzvlIx1jDDY38Wa0/EdfOgmB2rBTEu+ARSDLmrsHoXpb8YN4ZvTjfdk8nz
         YdwwLB/BgkW8OOlKvUqWT9Vc8oOBo6zKFupr3ADvWIdiX1dwPUbV2izcMOZ/B21n91t3
         Eya4f1PIh6SFSxbIZVGG1vUxHQv9LWCwZyq1iecBQqxf4u6dOORYxtO+8rOeuYCU6rpa
         rpgQ9PsyBVyuNyX7Tl/k5ctnQPXEnV1UigDQ/r7hbyxtyasGH5RKzPf7ztS/129zdxte
         8a+C4RNvDRnJc9ypYP2E6U118F6LVF5th/t+hsQWys4+aGuinUor19pzSOJgTOzltoEJ
         SJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640526; x=1750245326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aYuOuepOLHnUdb8TRhjPvWKYz/EnrixU8+xU2r5gus=;
        b=e7MJqvPsdgDG0nVjk80JD3om8Frj1Xi4mUVboUjy7Vh7odmDcecQhIRfYeGbKXmKsk
         arf79thTscwBe1TtOiwN8XY1RxYiodoheOUfpjIfCnD4FuQhdkXyZGPKPacJXgjaaA9T
         u6N3vLNdlLBuEOW+Wf6IgYYvw61Rw7C28GZyR5+lI4pKCB8FESBS8sRkJbWwrjUdr8KE
         wpst8AOoB9T176wav4riwxm3YtnjJ33oNU/XwnqAXZeY+F/D/rXvksBZQEvPZqnodtSD
         I4n4bCNiyshrb0clEUTH/JHSeLRSUdmC4jfFDVDyIQAyfdnimAm+dcM585S+/HfIEd1Z
         jTWg==
X-Forwarded-Encrypted: i=1; AJvYcCVSDBZBLRPCjdVLM4t0VrLPX0Lp055w6Cu+TxWDscubs7192zmpRH4FnDuKCg/UyN/UVlBsy+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+7WuvUcqgKmrKAFCXViJZtyEkj0ejknJamY1a63BBtfDDSl7
	sUPfGJufgTG5K70N/ckoB2duSmndhcwOPfxR4sJVuJc75vKncyngudExEIhQxZEbeOZeo0lZqRu
	21mUJ3XgyTZboMw==
X-Google-Smtp-Source: AGHT+IHpoLjnbwB0vHQmWa08xFmGro8Fad5inmoBMTrGurvJDnPu3uf+TWxoPm4zKgylcF+lgBIKzMDAAdT+Zw==
X-Received: from qvbok24.prod.google.com ([2002:a05:6214:3c98:b0:6fa:a516:e869])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ae5:0:b0:6fa:f94e:6e69 with SMTP id 6a1803df08f44-6fb2d0ce72emr33771806d6.9.1749640526061;
 Wed, 11 Jun 2025 04:15:26 -0700 (PDT)
Date: Wed, 11 Jun 2025 11:15:12 +0000
In-Reply-To: <20250611111515.1983366-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611111515.1983366-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611111515.1983366-3-edumazet@google.com>
Subject: [PATCH net 2/5] net_sched: red: fix a race in __red_change()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Gerrard Tai <gerrard.tai@starlabs.sg>
Content-Type: text/plain; charset="UTF-8"

Gerrard Tai reported a race condition in RED, whenever SFQ perturb timer
fires at the wrong time.

The race is as follows:

CPU 0                                 CPU 1
[1]: lock root
[2]: qdisc_tree_flush_backlog()
[3]: unlock root
 |
 |                                    [5]: lock root
 |                                    [6]: rehash
 |                                    [7]: qdisc_tree_reduce_backlog()
 |
[4]: qdisc_put()

This can be abused to underflow a parent's qlen.

Calling qdisc_purge_queue() instead of qdisc_tree_flush_backlog()
should fix the race, because all packets will be purged from the qdisc
before releasing the lock.

Fixes: 0c8d13ac9607 ("net: sched: red: delay destroying child qdisc on replace")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Suggested-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_red.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 1ba3e0bba54f0cc8d797ab9a7ffab529481b2d4e..4696c893cf553c4c6ecd2da75b47b3d40c80e812 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -285,7 +285,7 @@ static int __red_change(struct Qdisc *sch, struct nlattr **tb,
 	q->userbits = userbits;
 	q->limit = ctl->limit;
 	if (child) {
-		qdisc_tree_flush_backlog(q->qdisc);
+		qdisc_purge_queue(q->qdisc);
 		old_child = q->qdisc;
 		q->qdisc = child;
 	}
-- 
2.50.0.rc0.642.g800a2b2222-goog


