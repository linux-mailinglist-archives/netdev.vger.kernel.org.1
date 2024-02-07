Return-Path: <netdev+bounces-69860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A512C84CD13
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DF4281867
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBCD7E766;
	Wed,  7 Feb 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXWfsr6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11476C99
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316973; cv=none; b=uuPU9cknr/khrKs9cUgfWGSJAA6qQceO5AAPG5wSFpVZTUpjioEhsZMApVtK86sgcdHagS4qZaS+rM23pQxCVLgm/zwQnbIUR5Mw4HNYQqgyQn0hZMz7+OcUUvIfToEA+VgDInfVwic3X3lcdxKW86F2oDPgl/fF7PJ6O7t6ZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316973; c=relaxed/simple;
	bh=P6PlwTTDk91K0CjVrearkQBMy1zvLO1tHcOKTzVZSBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYctq0/+vwsiBi7HrX1zcV4+ncfTgwSyDk9O4NkBIxG9PbLPfyaCZDdd1Y9VoPbYo6a607lF+840JQbHydzfek/G8LTFgYtDFtXlAG15NDTodI/uaqvzTT8d6HJdh1cbbgN1zGwGKefk6qtgSOX9NiJAqaDoPJ6vuIA39PMaJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXWfsr6w; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so95551066b.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707316969; x=1707921769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IrZ7ZNYsXKDBg7F86KQox1K2NwLqOhHWWvyghsa0Ef4=;
        b=hXWfsr6w6rGHdB7wSdl6BKZWsV8BlU7HD8pt0e2Tkn6fpjFFH1AL5AkFW/+B1FnB+X
         BVBiFRt/w23puEEhmz4l3jP148uNWQxz+3ymXpNraIRokeyHphVn0tfS5YX0GHbKo0LT
         Xt24wOD30+m9PpYTav1qU65UXG6icnXY5aaKOvWQa5bkaPcKimObE1pEWsawYU8iNJgk
         ybhz8g5Hi6G8OCS9NFkPfWONZ1emqVWXotaFSvL1SHV3ZA00mkBjnq6dyyK+70s9xUOt
         knNDqUtYpba0ex2BAVA+vkM9dmRaZOyEQ2ia694iRD27+x6sSMUxklRTdvXjOY/hHjhx
         8ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316969; x=1707921769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrZ7ZNYsXKDBg7F86KQox1K2NwLqOhHWWvyghsa0Ef4=;
        b=RZDd7+w9vbkurNdwaSEUHtuc5Y9umrLUaL4HwODyhqlEA0kYLnnT7AxzYW6GKqhegF
         T7GUtUZ6Vnics7rFPPde9Qj86VUCQDyPqZyuDzmWbTbmb1stEJKbBBh63B321Q8prz+l
         iM6p4g8PfwJQg6rud7ANWEFUHKbVdbqrzo6oIwiPdopbo1vzG3J4x4EQt7aJl0DWq2a8
         Z8zVMIK1PEWHGS7gazzYebMc/jBwsLcXkV20DQ7Vqpa0SNyBisG/xP0c3PqxIojQevvr
         E6MKzJek96I2MDvgA+u7tl4DCeZA2fjeq3j4jiXPDpTXSLp3X2nLEyfqMhTBw5MGfAU9
         HuRw==
X-Gm-Message-State: AOJu0YzKzF/Etk/t8WGJnQr3+1xhsKP9rPj+wMx146h8IhjrM1xSx/op
	WH40B8f6vaWhkkBoS4xWDzSV0wpkwlgUspk4XE+pMMtSIKwRKZIytXLzC5Q5
X-Google-Smtp-Source: AGHT+IEs3Du2ORmFIrCwEZ/gD3ush/0aIg/2bdwkS/GUU+S5LQUeOKnFMZ1yqi8/ra51a31SdQ6BSw==
X-Received: by 2002:a17:906:30c7:b0:a38:215c:89b with SMTP id b7-20020a17090630c700b00a38215c089bmr3075512ejb.73.1707316968953;
        Wed, 07 Feb 2024 06:42:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWbE+QJHqMheeRWbyrcvoOXakxce+JbUpLE5b7cqAARHmsrvDq7W2/b195yCdxQH2MmC5/yqm198qnJvqImylYbZVZXt7cRBilH07FryZWz35ZD4GDPVBhJxjH1AptP7rqy9X7uDcxFlubWloQeWyRD/WInbpts747EZ+qzj580geQrIC7aP9PwVZb9KXkoqI=
Received: from 127.com ([2620:10d:c092:600::1:fbbf])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709065a8a00b00a368903fc98sm814579ejq.136.2024.02.07.06.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:42:48 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH net-next] net: cache for same cpu skb_attempt_defer_free
Date: Wed,  7 Feb 2024 14:41:07 +0000
Message-ID: <2b94ee2e65cfd4d2d7f30896ec796f3f9af0a733.1707316651.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimise skb_attempt_defer_free() executed by the CPU the skb was
allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
disable softirqs and put the buffer into cpu local caches.

Trying it with a TCP CPU bound ping pong benchmark (i.e. netbench), it
showed a 1% throughput improvement (392.2 -> 396.4 Krps). Cross checking
with profiles, the total CPU share of skb_attempt_defer_free() dropped by
0.6%. Note, I'd expect the win doubled with rx only benchmarks, as the
optimisation is for the receive path, but the test spends >55% of CPU
doing writes.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/skbuff.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index edbbef563d4d..5ac3c353c8a4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6877,6 +6877,20 @@ void __skb_ext_put(struct skb_ext *ext)
 EXPORT_SYMBOL(__skb_ext_put);
 #endif /* CONFIG_SKB_EXTENSIONS */
 
+static void kfree_skb_napi_cache(struct sk_buff *skb)
+{
+	/* if SKB is a clone, don't handle this case */
+	if (skb->fclone != SKB_FCLONE_UNAVAILABLE || in_hardirq()) {
+		__kfree_skb(skb);
+		return;
+	}
+
+	local_bh_disable();
+	skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
+	napi_skb_cache_put(skb);
+	local_bh_enable();
+}
+
 /**
  * skb_attempt_defer_free - queue skb for remote freeing
  * @skb: buffer
@@ -6895,7 +6909,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
 	    !cpu_online(cpu) ||
 	    cpu == raw_smp_processor_id()) {
-nodefer:	__kfree_skb(skb);
+nodefer:	kfree_skb_napi_cache(skb);
 		return;
 	}
 
-- 
2.43.0


