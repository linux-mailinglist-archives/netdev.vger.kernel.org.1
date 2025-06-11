Return-Path: <netdev+bounces-196548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F76AD537D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2084B170C3E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AF2609DC;
	Wed, 11 Jun 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5XYFDRm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746C025D8F5
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640533; cv=none; b=UeSKVSpPR9KuXbePUe4KALtzhCAP65SRXVqPA3ILgQ+0Wmtv2tiGQihOwgxpybk9gaEGUrtrzhYylJvm38eccdqwMm7X7og1L4iy1zBOUWt9OpiGnP15iH3a6mcVyWFEYqzr1hQNrrNc/kixKAwtkLzFrgtJ10T50wGSg3vbo3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640533; c=relaxed/simple;
	bh=eEiRv//C2BzKinFAXrKqXAaIHrmUQ24XPB3qEDOMesc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gp/zN0wVhNuU8n4nysESAlkxex5rkNPPo8SncCEFk9UxH7RLWgZx9qEoyL3idjUOlmx6fLFNnO5ru7Pbx8y33oaF4mf6uT1H9Zrjm1RWDhbPcQf7MjvCNG4W8j6mjaMlRMyWqowRX7ah37dOj7/DprXnxp6OWco9MjY1PypWnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5XYFDRm; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4e7b91a3568so196494137.2
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749640531; x=1750245331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ao9thH/4RNDeSoUTczCfjhxATNH7CJztbn/5qgBazUM=;
        b=b5XYFDRmqEYgXOKb6hlmRpgLLaxvDuTDr0IfDMe6Wp8FFqxoiMvfojHKF8wUqHNb0j
         zBHU6ChitZirUiMwzg4AuoD3xazp1IpjXmdp+9d2YFU/wEZJOyLUBDXoBl9qHG0ljqfe
         bZGZ4rTo3toKcY7/8MPvK+iX304JReYuZdkRzr+YV7dM4yYNO23QUmElfix3yFc+QBRO
         xx/Ve2FyRJ+iW17bGUn6Wz+WsexpRFdQXnFbxMnqOjWUv1I4YfL6xv+a7Iqpp3ipr10W
         m36ycyVQSyqXAdf1jOuXrRdxSBdmWTev4c6p2C3/oxa/gtcjT1Az6I42cy0FQXomt+j0
         NYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640531; x=1750245331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ao9thH/4RNDeSoUTczCfjhxATNH7CJztbn/5qgBazUM=;
        b=kejAGOPvYTJ3QDgIrOiu4SWTSbjgZa1cOVkC2RCrue41bsTA7VokAQjRYxuR5ZaIWM
         fmQyhU4hzRlf+FvzPOFyKXUXOdnJqsHX94PtIfl2q6k9NMU7/Tx2hMuDh7yTn2ZqaUes
         kUhNIgJ5LNcnRq6hZMHjo+w/76UX5arD+11KLuOC9oQW8cvjzM7Z6e61BWABT92J1HGX
         DBqHAcBs3/DgNtH3jLZnYA3WxgH/6sfymFkcoUttYujKofe2tTGkhN7q9mmSdAlhDPY4
         uW6FG899cZi+1yK7W2EhfNiC50WqQ99dHJzPMmSEw+joHwf3JgheO/JNDbR0E2TsuQqY
         Z1WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYPji0kMAOa08Hi7Hql3MkCpKS5kuPEhS3YSckP4qDX2PnNKdzJ4hBfgPVAcq3JybPQNZMMRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDX33tPYulnXOp34Bv0JE1tvhZn4D5PtW+JlsUjFVbfMMpqwP3
	NQoPHIIwIxh6xYKj0O+dRAD9O8yGhfeUas7QFIKT/t+xFCD2v6mBWjaimhNCvsU2aFwmf1TqAnr
	TfMRZOcbAvDVGCQ==
X-Google-Smtp-Source: AGHT+IGECxdwLSSn4et89zEdan7hsiHnbuCbB78XQCFNus8Z87No653DrKrIZIc1gy49q5MCbkt/tHGXsmgR7g==
X-Received: from vsej16.prod.google.com ([2002:a05:6102:3350:b0:4e7:b265:438d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:6888:b0:4e5:8b76:44c5 with SMTP id ada2fe7eead31-4e7bbc4f091mr2051979137.22.1749640531335;
 Wed, 11 Jun 2025 04:15:31 -0700 (PDT)
Date: Wed, 11 Jun 2025 11:15:15 +0000
In-Reply-To: <20250611111515.1983366-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611111515.1983366-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611111515.1983366-6-edumazet@google.com>
Subject: [PATCH net 5/5] net_sched: remove qdisc_tree_flush_backlog()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This function is no longer used after the four prior fixes.

Given all prior uses were wrong, it seems better to remove it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 629368ab2787f9ddeff8dbb0a825d9d30e5b0f0c..638948be4c50e2e6f5899ded17943de55d4f94f5 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -973,14 +973,6 @@ static inline void qdisc_qstats_qlen_backlog(struct Qdisc *sch,  __u32 *qlen,
 	*backlog = qstats.backlog;
 }
 
-static inline void qdisc_tree_flush_backlog(struct Qdisc *sch)
-{
-	__u32 qlen, backlog;
-
-	qdisc_qstats_qlen_backlog(sch, &qlen, &backlog);
-	qdisc_tree_reduce_backlog(sch, qlen, backlog);
-}
-
 static inline void qdisc_purge_queue(struct Qdisc *sch)
 {
 	__u32 qlen, backlog;
-- 
2.50.0.rc0.642.g800a2b2222-goog


