Return-Path: <netdev+bounces-197413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E7AD895C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AED63AF227
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4F92D5C8C;
	Fri, 13 Jun 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gw8DpVy7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C32D238B
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810043; cv=none; b=MAGfQOzQTiwS3nzB47JrysFbDc2SAptOvT++G5APcwSdzo2BEdYisZ32C/UOzCQyri1SC8fs8mmUfAQ5sZ8UY0HZ5EiZD38Hxh8FRE8DvGg4nvtbUIGpjLPYIPFD4d84yeIhdahxAJtVDpwNK4QyEPGPylC84Njv1tJYYRtjo+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810043; c=relaxed/simple;
	bh=QTrczzzIADGGhXZs1RyepLDlSuNI1nJRFJX9yYFYx0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyXahRN3/RveO5MWJ1c9eQZzkF8KuthBS24AynLvnP4H8Wkyu6WZsXjhLKMG8HFEVZ0oV9WSq4zKcE9sStPkUnVa3aenUDyjCbQXi1hkVDQa2sT15mh+OHS37sJgNvs4uDEfLvP0s4yEKmR5FD9hh/QglImVrAVgo5XpZJ9CSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gw8DpVy7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ade2db1b78bso35992166b.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749810038; x=1750414838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHGVmva+Xy6qyuinlqeBQ2q+u47g3zQhlkKKsvoN8Oc=;
        b=Gw8DpVy7AJ3xj9SIl+7sRZ99a0LBwxMTFMWKAKMQVR087HW71COYOBWfRZbobNTTTM
         26xafrddQGfQO+TMjI72k4HW7AdL1dZtm7z4GKdlWP3AJhCJEB9brJskb7zgO4VBSr7Q
         0lTNexjG+LRxMHmeBCsGIDBCcaLXtudpGaH8DRIBmPab9o/34Fyl2CdV1fod/vo9o/x1
         9ykZGvsfOosa7MXwTkd3RP5IZvlQMMOkArZcOUmNC3GHmR1wBxD4XZ9K1ofJ6pce3Qwh
         Q81gcJVufQW2Su/jcyRCPwsATVnMM4D1ZGZGIwhZgeV+pV9CDCWneV+aP0wcz/qBnuoN
         0GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749810038; x=1750414838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHGVmva+Xy6qyuinlqeBQ2q+u47g3zQhlkKKsvoN8Oc=;
        b=PheOYc+0wgDw3VZRWMX2288E6d6S71OmKv3m/DFjH9Hlz06dCwwj7LObMdEqL3nYgj
         45BJjqmeipQtA0CP2WjFLvoQfIo9K+5j5tG1puKLTcGcCwjMhMuAQNAWgUPZymywz9kn
         wMzoeKj7NzajkzRdBgE9Clgr6+qOYs8VujZjXnecYQR+JAkGX/V9JOzczPNaN54X/L0M
         wh+hHVdw39zFbadIqfQscygXgQY1vCZ/j39pbiAqLlJQyMA4vs9Ugmz8L8FnRHxASrEo
         9S5uw/EpFpPpcej69m72hRNNVk0Jxcqwq3BqMjSUaiiVEPKzP3FJMbtsGoMbjShJmGdJ
         fDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCayUyn+koO6zh+bTy91jy5r33X2ccDe+pZmEIRkrCp3H0bJDsipvCiKEplTNNN0ZRZXHhsrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYdA2vXt8gAd7rMwTzWFYs9LtpbhwES/GLQHetW87HXFV2I1o
	qWikZq9Y6Ski9MIncWYwzwKLMbsZVIY+W8V/uRSfvWov744ZesW0Gk8oSJ31wi08lpA=
X-Gm-Gg: ASbGncuNlzWBkBCNWpnq4G7A0gJz6ejt7Yj9vDZ+/7ScD1j/ajr37Q0ASmTu1e/ECXy
	Sj1rYTvKeRkFIhA+KsLtYeVL+V+KczfNX2YADkHW/FWHCdugT2+pOOII5w1W6l4GEDjvdLA85el
	+xu+tdcL5X6CBFIFJIiC5JyYBrmUNSPJwaYH0nsziu4KzNgfFmZNLRc0CAF7heD3l4yI263+LLR
	lQorGqj4Zdq9a6mFDta8yKGH+GPk/fFz++EBbS9eYSVgyRufgUox8+ACllyecuXxzTN2MFAhn9e
	ovOgOX+al5VTsTrxzukz4r7wRnzzgeXMqBtuLAkjHtxVxjcBsMIcc7xuZLfL7hZtQ/FL/q4Hlbp
	ri8VdhgP8U494VeDFLtuR7ygHBL+SsCTceKlsdRE69mBCldTqmtW9
X-Google-Smtp-Source: AGHT+IHERf48fkRQ7vR8j9BzlqUyFKtoSyqYNQsQlUq5+9EMSNWiLqNvIUxQG1VGlqq6lCv6XDF1iQ==
X-Received: by 2002:a17:907:2d14:b0:ad8:a07d:1729 with SMTP id a640c23a62f3a-adec55407fdmr89023366b.7.1749810038441;
        Fri, 13 Jun 2025 03:20:38 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec88ff61csm104205366b.78.2025.06.13.03.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:20:37 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org (open list:NETWORKING [TCP])
Cc: David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH net 2/2] tcp_metrics: use ssthresh value from dst if there is no metrics
Date: Fri, 13 Jun 2025 12:20:12 +0200
Message-ID: <20250613102012.724405-3-ptesarik@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613102012.724405-1-ptesarik@suse.com>
References: <20250613102012.724405-1-ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is no cached TCP metrics entry for a connection, initialize
tp->snd_ssthresh from the corresponding dst entry. Also move the check
against tp->snd_cwnd_clamp to the common path to ensure that the ssthresh
value is never greater than maximum cwnd, regardless where it came from.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 net/ipv4/tcp_metrics.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index dd8f3457bd72e..b08920abec0e6 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -479,6 +479,9 @@ void tcp_init_metrics(struct sock *sk)
 
 	if (dst_metric_locked(dst, RTAX_CWND))
 		tp->snd_cwnd_clamp = dst_metric(dst, RTAX_CWND);
+	val = dst_metric(dst, RTAX_SSTHRESH);
+	if (val)
+		tp->snd_ssthresh = val;
 
 	rcu_read_lock();
 	tm = tcp_get_metrics(sk, dst, false);
@@ -489,11 +492,8 @@ void tcp_init_metrics(struct sock *sk)
 
 	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
 	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
-	if (val) {
+	if (val)
 		tp->snd_ssthresh = val;
-		if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
-			tp->snd_ssthresh = tp->snd_cwnd_clamp;
-	}
 	val = tcp_metric_get(tm, TCP_METRIC_REORDERING);
 	if (val && tp->reordering != val)
 		tp->reordering = val;
@@ -537,6 +537,9 @@ void tcp_init_metrics(struct sock *sk)
 
 		inet_csk(sk)->icsk_rto = TCP_TIMEOUT_FALLBACK;
 	}
+
+	if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
+		tp->snd_ssthresh = tp->snd_cwnd_clamp;
 }
 
 bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst)
-- 
2.49.0


