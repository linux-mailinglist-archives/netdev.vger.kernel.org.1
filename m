Return-Path: <netdev+bounces-23646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559B476CE36
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E29C1C20AA2
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C22E8476;
	Wed,  2 Aug 2023 13:15:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ABB8826
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:15:15 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F96A1707
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:15:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1851c52f3dso6801705276.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690982113; x=1691586913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+sM5sJ2qdms3fKlpPUd1zYuVSaECtbbn+vX7buHvzY=;
        b=6TXfSVnKLmSU21vdlfSmUIh8HlHguDQegZx1lnbtFdz94UW/rWXT1UXiR/iwbtF4Zf
         oXu5aosGGANf7F2cPfyXzSfdx39qadj9aG4a8jGAVDTU6ulom2de2paYiyYZoCdDfSeX
         XthAm7q7l+yDVd2tqAdfZn7FvExWWPfMawk2dRDu4Ln0hGEeX7yJcvaRydUPj+n/L1Vm
         ysUrhef9R9IXqfLylsmslWKSTblBEOQdXtX3YCPfcORSYJcR3PY8DOVESwFhQATr4lyu
         CFA63mqfF1M85AbuTbn5wTGcnv9yeQAWvzlS1Mv1KL1DxUOJUmkBQovYI8fl+X08+PL8
         Ln8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982113; x=1691586913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+sM5sJ2qdms3fKlpPUd1zYuVSaECtbbn+vX7buHvzY=;
        b=CUnBqA2EmVIgUkBwp2wAHupDX7+ISbMCFDZKJnYhWRNKMb/o0v+Ac9eYtbs8rmugJn
         YhrlBB7rvfj1mEWMjZjjmb8XY8dphhoHrkJy2rJbO96IwBiGbYDk3qqB4DM0mCK8IDny
         u5rkv4Ghp2SNnw87KqCK39wokmgAh2nNwcxBgHAFWljpcSlb0o45LhjZ8ltZnkp4oRRL
         XE4r0IL6JsIzToQIOBbsXVgkqSOAV3jb26AKiXlh1aWkfoIhxpF/gG4aZSiCZtN/uf9b
         Ss77m35NmXRci0WCAD6Tuv6pJ+l2eandm7iZJS64nBERcni39ZhcWtQmt1MxwWeSfoL5
         Ejcg==
X-Gm-Message-State: ABy/qLajY50pTSp8PVbbMbLnVaf4D6ewqs84W2jh05UN6xtLK3tMk7T6
	c6m46Y0H1CBwX+vkvrymooKGaHIizPZTLQ==
X-Google-Smtp-Source: APBJJlF5qfGkQILQmUtKjkT9Vj+DL7PgiOah1nq+fEV0Ij3rrJwARpYV0YDavb1bGtbyURwXH4WXV+uiBJT6IA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100f:b0:cf9:3564:33cc with SMTP
 id w15-20020a056902100f00b00cf9356433ccmr131692ybt.13.1690982113495; Wed, 02
 Aug 2023 06:15:13 -0700 (PDT)
Date: Wed,  2 Aug 2023 13:15:00 +0000
In-Reply-To: <20230802131500.1478140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230802131500.1478140-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230802131500.1478140-7-edumazet@google.com>
Subject: [PATCH net 6/6] tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Whenever tcpm_new() reclaims an old entry, tcpm_suck_dst()
would overwrite data that could be read from tcp_fastopen_cache_get()
or tcp_metrics_fill_info().

We need to acquire fastopen_seqlock to maintain consistency.

For newly allocated objects, tcpm_new() can switch to kzalloc()
to avoid an extra fastopen_seqlock acquisition.

Fixes: 1fe4c481ba63 ("net-tcp: Fast Open client - cookie cache")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
---
 net/ipv4/tcp_metrics.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 4fd274836a48f73d0b1206adfa14c17c3b28bc30..99ac5efe244d3c654deaa8f8c0fffeeb5d5597b1 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -93,6 +93,7 @@ static struct tcpm_hash_bucket	*tcp_metrics_hash __read_mostly;
 static unsigned int		tcp_metrics_hash_log __read_mostly;
 
 static DEFINE_SPINLOCK(tcp_metrics_lock);
+static DEFINE_SEQLOCK(fastopen_seqlock);
 
 static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 			  const struct dst_entry *dst,
@@ -129,11 +130,13 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 	tcp_metric_set(tm, TCP_METRIC_REORDERING,
 		       dst_metric_raw(dst, RTAX_REORDERING));
 	if (fastopen_clear) {
+		write_seqlock(&fastopen_seqlock);
 		tm->tcpm_fastopen.mss = 0;
 		tm->tcpm_fastopen.syn_loss = 0;
 		tm->tcpm_fastopen.try_exp = 0;
 		tm->tcpm_fastopen.cookie.exp = false;
 		tm->tcpm_fastopen.cookie.len = 0;
+		write_sequnlock(&fastopen_seqlock);
 	}
 }
 
@@ -194,7 +197,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 		}
 		tm = oldest;
 	} else {
-		tm = kmalloc(sizeof(*tm), GFP_ATOMIC);
+		tm = kzalloc(sizeof(*tm), GFP_ATOMIC);
 		if (!tm)
 			goto out_unlock;
 	}
@@ -204,7 +207,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 	tm->tcpm_saddr = *saddr;
 	tm->tcpm_daddr = *daddr;
 
-	tcpm_suck_dst(tm, dst, true);
+	tcpm_suck_dst(tm, dst, reclaim);
 
 	if (likely(!reclaim)) {
 		tm->tcpm_next = tcp_metrics_hash[hash].chain;
@@ -556,8 +559,6 @@ bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst)
 	return ret;
 }
 
-static DEFINE_SEQLOCK(fastopen_seqlock);
-
 void tcp_fastopen_cache_get(struct sock *sk, u16 *mss,
 			    struct tcp_fastopen_cookie *cookie)
 {
-- 
2.41.0.640.ga95def55d0-goog


