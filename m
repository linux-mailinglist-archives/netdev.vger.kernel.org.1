Return-Path: <netdev+bounces-86364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B7A89E7D0
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906C2B2257E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC5A5F;
	Wed, 10 Apr 2024 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY7AQULU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957710E5
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712505; cv=none; b=dv6GTvloIMJPNfblg8L6F0+YT13rkFR+i+qQNCzojRTxibmMZPqtKXxbqdUlSgf3JidugmI1E7jzkfCKwpbLKEsh63aWE1exhlHiABgmZoBvOKYosK52iIac1pRDGT9C92q3EaerXa8dYqTzrBEucqOEas94oEklisH7HlhHpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712505; c=relaxed/simple;
	bh=xyLjxx7D1MnoTKEGUNbchvElIztPjr1fquLXUF5guag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psjD2eVM0Drj3CnTHQZcSDOMpP/NAcIdW8j7SsfOR54g9BR9OF6/KmyG4ZjxgIBEcZ0Svw73pX5a58SP+GBp5zrJdKHD2whSySGKko+fu2YStqvE+yM8nzjyCY3KFp6HwGhC/NBUpHQcQW/xhinFZj7sdpdStKgg9IJVjBjYwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY7AQULU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-416a208d496so10141945e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 18:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712712502; x=1713317302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTbVUiSDWxgSBFyzZfdK8gIw/qFLjYpk9ybc3meZYo4=;
        b=cY7AQULUq8dmHU0GP2UHe+YyRcdkVfQz/rXRqqB4r5bwhfRohneWwkIHFKg/abLg/d
         Fkbjiz9zh685R/YHSF6gRsVJxh/IspdOWah9W17HquFaBo+aTNfyrEgdMaTHbfJt5V89
         Af/St46efE5mCFOCXTQ2jvyRqO/QgFXVCZ7UzIkwQxQ2z8sxlKE8GKZdB73DjQq4weAs
         1Tmc8NBU18Ez7g8n5P+knXrJ2iT/h/KUKzFJvaV+JutiEG8C6s8PQF/SW783cQ7QFR3j
         pMlYIF0rmVRJeHuMSPkSqMekMgpsnGy76NfPQOkgq7zkl0byZtuwq2Z/MmwKG3sAwNcP
         XyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712712502; x=1713317302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTbVUiSDWxgSBFyzZfdK8gIw/qFLjYpk9ybc3meZYo4=;
        b=XIblrr4QGl7YdnVlqlc8adNHq/CVqA+tJT39x/hgV3IzpvJIujvYrU49oYcpnshj+v
         L5m3A9GgSuc7v96la6eg18NWL5wUqby2mWgds40Wq9jAkUaKW8V7W6+NEPxad2LQ1/5R
         XQKNJawt48mUVF0K8JMgTr0hVOLy6H6L8L7dVfdEUGf9FgLrY2gRJU12WaBSLtjzchB3
         LEbfBQ4ezk/PeXBfBf+bP5yOma2NR01dMTGidi1MfLyAtFx02rWNPUn6aELWqRDPlmnK
         BTZZ1bi0yPFbqWzw1pKu6jisiHuwG+xK7EFzNyHrrA/YnI5/i8idAYdxh5k+huJlFy3z
         L+Gg==
X-Gm-Message-State: AOJu0YwQc5enTr7Tkwdr2Uk6+dHHi+S+CE5p+j8cYePTnzOMDIxFUi7Q
	DCWqav4d0FywQzmFcYxT2PvqiimDbFL4b8beBLJ19/cA+QEPq5RBlehkDQ+W
X-Google-Smtp-Source: AGHT+IEzIsbSYMEObh68A4b3DBbKZ0lM3F10HTSJiaB5ZLvINtui/wHRP7C3Q9gIOTmMJ7mOI7JxzQ==
X-Received: by 2002:a7b:c4c9:0:b0:414:86a3:8e8d with SMTP id g9-20020a7bc4c9000000b0041486a38e8dmr790095wmk.22.1712712501713;
        Tue, 09 Apr 2024 18:28:21 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.132.24])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b00416b8da335esm659522wmo.48.2024.04.09.18.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 18:28:21 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH net-next v4 1/2] net: cache for same cpu skb_attempt_defer_free
Date: Wed, 10 Apr 2024 02:28:09 +0100
Message-ID: <a887463fb219d973ec5ad275e31194812571f1f5.1712711977.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712711977.git.asml.silence@gmail.com>
References: <cover.1712711977.git.asml.silence@gmail.com>
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
 net/core/skbuff.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 21cd01641f4c..62b07ed3af98 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6974,6 +6974,19 @@ void __skb_ext_put(struct skb_ext *ext)
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
@@ -6992,7 +7005,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
 	    !cpu_online(cpu) ||
 	    cpu == raw_smp_processor_id()) {
-nodefer:	__kfree_skb(skb);
+nodefer:	kfree_skb_napi_cache(skb);
 		return;
 	}
 
-- 
2.44.0


