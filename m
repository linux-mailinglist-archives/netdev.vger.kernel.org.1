Return-Path: <netdev+bounces-179752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4084FA7E6FF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F66C4445B2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79A20F09F;
	Mon,  7 Apr 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVmM0mel"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7C20E30C
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043774; cv=none; b=m1RzTFBW/eRM3yy0CX82H1LKp0p4k7E7/3zfXOzHLfqbF9iQD8QqGG/lI57BaNqrMvJZ3TBygMrxvVbCGMSHelw1OAQUPUcokThxFmqwdmbt201QWtKnzFhhjSHbgF72tp9CgBLSgDSbvmF7Siw32cJiDGBO5yHoH7v0/tiucHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043774; c=relaxed/simple;
	bh=P/e3u8Tsxhzhug2N2wuCk5Hqh5489kt2t2TYQKJanBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EVNBWyekcOvMfY/rl5CnCXZPEW8XS2l74OHiHhsOZ/YDrau8h1KkOvc504KavL3TnWYAvRIbmFaHnTcCkZan0gli1r4z7DkLrMV4Tz0K6INxx53/f5ltt90ev16j/usGKO6Zm6ndf606ncQu+UzxCQ1c7OJa4ZS3hiRjhRXhNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVmM0mel; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-47779dbdb62so165828481cf.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744043769; x=1744648569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDagasX2a34f77+Cj9kR7AJ2wGC1NyS0aITzzECd8QQ=;
        b=dVmM0melMhf67oUc23HLixfDw1+gY2GyWQxR+IO9DjJML5ms0ub++RgJSZZRTrk+ef
         rcH+vrzFS+WO6yfK1iopsMv6RLWfYfDAWIJoGGX83/tAfxQbKak6WKWD43cNtC7UFeBq
         CbpLvzCUZdT7JRK+u1B39hMk1id8GKGQDO0emvuOoN6l+2vuqmyiYB8N0BZc4EVLv5gh
         fstGx+IE9AP8MfOsYraK3yRRDWoOcFl4AY1PmEUyjNc1XaCDeZth7fW1gwob/xwGdUsc
         zPARzVOO5zSTth2Yu2JjuBnCm0TgLdkv98he+82/PHZDdvS90aeGAnEwe3QU0/C042dD
         uIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043769; x=1744648569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDagasX2a34f77+Cj9kR7AJ2wGC1NyS0aITzzECd8QQ=;
        b=GzIinSiiYX6TFO8c6oO2z5MYFxSfr0/JX6zJmMpuAqYhUqVfCd5YNkhO9M2XLay1gB
         f6yBbnbwRr2X/lrW9j1a+W2WTlqUTEedfcxMd1oT0GbnY2x6SalDPAeWvb41pKJITIhk
         VC+bRGYSlQwk8FERAwFS1K7dog8Z8XOIEgWUh5FRnXkDV8GNv1pgz7MfoHDlG9436hhL
         J6DCM97JXtwf57QHHxWQbR+rNXvvbQWd8oAMI/tMtpGH00iEU7qSERRSm65lC/GR70Qa
         qW0l695zF27Zhhj84ZClN3818bsqRNEliOHZwiz8bnKs1KIUVa0uXs3s9GXmmJD06t+x
         JFJw==
X-Forwarded-Encrypted: i=1; AJvYcCX8DgExNFsG6OQZoQAyYLFaLHUyrwblexd/W3jmM3DBJ1MkdUNqIHNsP5eFgmANSJ4iPBAh9Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2clgXM+a6PLObIRZKJWPFPVinc/okM9kXxFhn3VfHkwKiWEjq
	z2zNkN7xTvolXheiv38qRgmfTiZ7AJQPMpjikmBKe9+2PA/PGFUAZ8TGyOi0mhGeWwb0QuL27D6
	psA9xglxnfw==
X-Google-Smtp-Source: AGHT+IG6XSlx18vpQ9qlZeEQDiUnzMTFKj51rCfufoo/aZ/sZtLwST0AoM8+9i6hGCjWLPYCb2fmly6uzSsbVQ==
X-Received: from qtbha11.prod.google.com ([2002:a05:622a:2b0b:b0:478:e653:cc11])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1a1d:b0:476:7e72:3538 with SMTP id d75a77b69052e-479249c23afmr221176191cf.50.1744043769236;
 Mon, 07 Apr 2025 09:36:09 -0700 (PDT)
Date: Mon,  7 Apr 2025 16:36:00 +0000
In-Reply-To: <20250407163602.170356-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407163602.170356-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407163602.170356-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net: rps: annotate data-races around (struct sd_flow_limit)->count
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

softnet_seq_show() can read fl->count while another cpu
updates this field from skb_flow_limit().

Make this field an 'unsigned int', as its only consumer
only deals with 32 bit.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c        | 3 ++-
 net/core/dev.h        | 2 +-
 net/core/net-procfs.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f674236f34be..969883173182 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5049,7 +5049,8 @@ static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen)
 			fl->buckets[old_flow]--;
 
 		if (++fl->buckets[new_flow] > (FLOW_LIMIT_HISTORY >> 1)) {
-			fl->count++;
+			/* Pairs with READ_ONCE() in softnet_seq_show() */
+			WRITE_ONCE(fl->count, fl->count + 1);
 			rcu_read_unlock();
 			return true;
 		}
diff --git a/net/core/dev.h b/net/core/dev.h
index b1cd44b5f009..e855e1cb43fd 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -15,7 +15,7 @@ struct cpumask;
 /* Random bits of netdevice that don't need to be exposed */
 #define FLOW_LIMIT_HISTORY	(1 << 7)  /* must be ^2 and !overflow buckets */
 struct sd_flow_limit {
-	u64			count;
+	unsigned int		count;
 	u8			log_buckets;
 	unsigned int		history_head;
 	u16			history[FLOW_LIMIT_HISTORY];
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 3e92bf0f9060..69782d62fbe1 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -132,8 +132,9 @@ static int softnet_seq_show(struct seq_file *seq, void *v)
 
 	rcu_read_lock();
 	fl = rcu_dereference(sd->flow_limit);
+	/* Pairs with WRITE_ONCE() in skb_flow_limit() */
 	if (fl)
-		flow_limit_count = fl->count;
+		flow_limit_count = READ_ONCE(fl->count);
 	rcu_read_unlock();
 #endif
 
-- 
2.49.0.504.g3bcea36a83-goog


