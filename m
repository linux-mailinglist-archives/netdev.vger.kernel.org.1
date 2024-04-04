Return-Path: <netdev+bounces-85048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E52899236
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 01:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3152D1F231DE
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 23:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCB613C680;
	Thu,  4 Apr 2024 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mbt2p35a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415D13BC38
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273915; cv=none; b=YbdT3cgI87R7kQ9funracLdTqvf6tQ4O4RwSThYBvCcOFznbLemyQmS55ZMVs5bA/B+9Yv6EPCxS6yEovoKnT40fbfdWBWDCUXiSBh+mITiCf4dH5MLozK/GqiAGHfGRZJqpCOhlYpDE4CQH+yApJPQFP9eP7fW7qJDXvyI9+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273915; c=relaxed/simple;
	bh=JKUtZjUvHM6bUjgHrnrEhHm6LtkSdRubkyUbNAt7ejk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miWC6RrEi+F+PfHHXxEr/x09kGKWQJ+EAGOU33dViBJcAaYAWQI7I0qmgqQdphYW/kLlc3KPL0wd91itxaQIi72gJmo0aSr0YwD3v9tyacJDtMFoZJgtw/NbEe9fvE9zVUP7b7ykghaN3pTIFV8Fn3PHWeIncTPchbZJqF8gdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mbt2p35a; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343d88460cdso362292f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712273911; x=1712878711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ig9XvshF/3U4rqJUTUlLBuVOsDHakaUwZL+kE4GfOLQ=;
        b=Mbt2p35afmLblRHqMfIzVFP4npENEcogRLK7RmRN263nQwT3hHJhtRegzsLmNm9v1I
         ZD7i4yV1HDFv/dwkjn/xrs5uzkwAND7Au/MwA0icMOPA3KbEsdtrv7MtOnQY5jdeNZqe
         tE9JbjCNdHzHwEMTog7Qtyo9/TQFKC0jQtA4I5+iW3KNWn49SknuoW7QGgVqVGddp/JI
         3+TBF4D/6XB6mCWxPAILJ0Kl86NOQwjVQ8NR4S1goLX+6k+h0g7/1BtfQNZLTdl5Idso
         Nh0EgPhpkEhL1khqSn2uDpDRKEfqN/mglNjV+LAaIjcdRSUrvTCxsJqenOl/bRykejLV
         /Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712273911; x=1712878711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ig9XvshF/3U4rqJUTUlLBuVOsDHakaUwZL+kE4GfOLQ=;
        b=hmSmLO8U1E5wanv4DQTyGJrn2Tt4B3wPMlhj6Cz4zNeg5ZSkRyTSC9aWy2VXwc8lWE
         Bz29W5LdoQNmrrsf7Ty/uY4tLViEjts4qPxJ54q5BreOrM7w3NAShCFAYWoKWoa8RNIN
         mb9sU1N5WSjSczi1BPBlNeKHugd8U9J46cn0IYi6IS4OUNtpE4ATH8G6iXt4bZs1fRrP
         qMukNvSnQQt6H1BrP9CW8MAgOv3CVGi8MhV16kCsq1ySW3xlQH+H1RjIOsY3eL5OTJB1
         B39G2ZlRuNeSzuan4K7QnsaYl1vtrk5DFTB2pMYOXQB8x4Y3kHD1y+xCQvIJvUwOmXQ+
         CflA==
X-Gm-Message-State: AOJu0YxncAnWE0GHt/nOfwLleFMqVix4a5Vl7ly4eFu5W3Zg0BRU8VHb
	pxZu/cb9EHC/OlfkJf2uk6NDXyDqQHbZfNsiIoQwWFxBD3yp1uG012dnLUEw
X-Google-Smtp-Source: AGHT+IGFan5SUbs2DcewEskTfKNrgSI3rD0ftaXoNbXR2WUKxHXL9IjHcGXpcASKe/zr2wcyTCOQyg==
X-Received: by 2002:a05:6000:a83:b0:33e:2a76:bb90 with SMTP id dh3-20020a0560000a8300b0033e2a76bb90mr2559151wrb.65.1712273911255;
        Thu, 04 Apr 2024 16:38:31 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.144.46])
        by smtp.gmail.com with ESMTPSA id o14-20020adfe80e000000b003436a3cae6dsm510333wrm.98.2024.04.04.16.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 16:38:30 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH RESEND net-next v3] net: cache for same cpu skb_attempt_defer_free
Date: Fri,  5 Apr 2024 00:38:27 +0100
Message-ID: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimise skb_attempt_defer_free() when run by the same CPU the skb was
allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
disable softirqs and put the buffer into cpu local caches.

CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
I'd expect the win doubled with rx only benchmarks, as the optimisation
is for the receive path, but the test spends >55% of CPU doing writes.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

v3: rebased, no changes otherwise

v2: pass @napi_safe=true by using __napi_kfree_skb()

 net/core/skbuff.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2a5ce6667bbb..c4d36e462a9a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6968,6 +6968,19 @@ void __skb_ext_put(struct skb_ext *ext)
 EXPORT_SYMBOL(__skb_ext_put);
 #endif /* CONFIG_SKB_EXTENSIONS */
 
+static void kfree_skb_napi_cache(struct sk_buff *skb)
+{
+	/* if SKB is a clone, don't handle this case */
+	if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
+		__kfree_skb(skb);
+		return;
+	}
+
+	local_bh_disable();
+	__napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
+	local_bh_enable();
+}
+
 /**
  * skb_attempt_defer_free - queue skb for remote freeing
  * @skb: buffer
@@ -6986,7 +6999,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
 	    !cpu_online(cpu) ||
 	    cpu == raw_smp_processor_id()) {
-nodefer:	__kfree_skb(skb);
+nodefer:	kfree_skb_napi_cache(skb);
 		return;
 	}
 
-- 
2.44.0


