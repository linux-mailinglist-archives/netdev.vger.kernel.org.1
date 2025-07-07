Return-Path: <netdev+bounces-204572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F34AFB3CE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80648423905
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC218299AB4;
	Mon,  7 Jul 2025 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXnHSpZ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7D288CAC
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893278; cv=none; b=TJIyjgPJ8psV/jh8bftMPzfMXTSo3OwogxwHzzTrYUyGEhtvVYn5gyRAL2ACr7pYr08G5lEEfCH2XLRw4LsNZ7GDG5orTaZuxMGosvAxrpj2WYZcjHE6dBfKl1ntApp0zO61rCE1p8dZgCva+Er2FLfIUL6jEMbg9n1of3qmlEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893278; c=relaxed/simple;
	bh=Epay6PuFDIiS3tlzae9r/obrjU8L21bh78W8XI4EnYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ck7cIVTaYuML2gHnNh6KDSA72JUBjykpbNxaXF08YbK13Q+i4lbPSpB/M2NarpGjdb7p72A9hbCtKzlccTAgU00tZ3gQ5RYdHMn6a2HBzFyd4q6pft23XGXHIsEdQOW/DO0+9dYrOq7yUOXJ22SqCtOpBwNT2YwamxScXh6xBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXnHSpZ2; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fabd295d12so58884226d6.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893276; x=1752498076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJO5y0sX+unuosADwOyrcivfEWKNSF72LJK5gMAJsHo=;
        b=JXnHSpZ2/ATb2VblbsioGuNTn+VLBYcrAXZmdgF9ifyiyMZjz/V8Wp+zmLm+CZu+zj
         IgHO7u84e5wjE0MODDeFbk92S1NIZNoQ4Q1ECROCyTfKuCUBZjYpYndfGcWww08Q7MyN
         lQVWDQ0DQTaRU2+5uycSpY1/bx6d1JXa2pNZXh5pGpNZuDk1YZ0DthIjzXpGaesQd+jq
         z2Imf6pHJN1pwa7LqyMysqC1aCl8KEQ6C8Iu9ikEj433HXXLyRv9yEnsmsC47GqM5xWD
         TFtivAd83Dc6KnVowY33Djq/qVHPH+GuseNebmBKDn3VXe0NzMWtVdjvmShHy9+Oy5QC
         AsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893276; x=1752498076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJO5y0sX+unuosADwOyrcivfEWKNSF72LJK5gMAJsHo=;
        b=Yzwv8b7HfZjfaizvMH4XCmCjqwPI4QirxCkCC6rWHZzV1ob6hRx76tfQroWqMsYwTA
         NX8fwtkj8fvCLrzh9ifqRQ1i2enlRPmsS1Q0D+W+qDRgN9acb+gz4dIyyxM4j7PAbNAB
         QFsX9SaTBFtSwMcpYGT8PcQYmt7wOEyTwkwCvWJktEbi5M8UXbZOitV3QbSEQlKyT+fB
         vckNfVnig5JITE3awaVMLB5ELe92Za8xdtFRPTGjNGkJmPwi+/OgNalKnxLracTjglzY
         pBz6t2MAqgArGuQEfjxd9HAmtrupxjEBK8S3wjC/nA+07vH2mATpiRhVQWMzOU/I8miF
         fdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOjjtOLpPJfbDtX1CgOQfpDa5nRTMO0b8NJZBe3+3PGoDQK/f/wnmMQZwS88643OoqQXrtPP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoLUP/AOsam5fPDA4xaAGiAR+eyn7sfESibcOw/zpj/1YiWZln
	PdxifkqJbipwSWN6w4CukIo20ZPBVxZyXVZNPJ7Ezkgvvlo/yssSBBfr/fUZpiY4uy7Mde8Az0j
	oL6Uv7Ccp4HXnEQ==
X-Google-Smtp-Source: AGHT+IFmSx5nmQaHwzdbSMkFAnmbwstzOfC/VdqcnHdO8P+O4OQ87ESFxEmE59JS9jh9IcBtFSGs1WRgOBw5KQ==
X-Received: from qvbna9.prod.google.com ([2002:a05:6214:2d49:b0:6fd:74cc:3ea7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4520:b0:6fb:4cbc:5b86 with SMTP id 6a1803df08f44-702d1544682mr126698046d6.18.1751893276109;
 Mon, 07 Jul 2025 06:01:16 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:00 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-2-edumazet@google.com>
Subject: [PATCH net-next 01/11] net_sched: act: annotate data-races in
 tcf_lastuse_update() and tcf_tm_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcf_tm_dump() reads fields that can be changed concurrently,
and tcf_lastuse_update() might race against itself.

Add READ_ONCE() and WRITE_ONCE() annotations.

Fetch jiffies once in tcf_tm_dump().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/act_api.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 404df8557f6a13420b18d9c52b9710fe86d084aa..e43bd9ec274730136ff10358f308e338c022d254 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -76,19 +76,24 @@ static inline void tcf_lastuse_update(struct tcf_t *tm)
 {
 	unsigned long now = jiffies;
 
-	if (tm->lastuse != now)
-		tm->lastuse = now;
-	if (unlikely(!tm->firstuse))
-		tm->firstuse = now;
+	if (READ_ONCE(tm->lastuse) != now)
+		WRITE_ONCE(tm->lastuse, now);
+	if (unlikely(!READ_ONCE(tm->firstuse)))
+		WRITE_ONCE(tm->firstuse, now);
 }
 
 static inline void tcf_tm_dump(struct tcf_t *dtm, const struct tcf_t *stm)
 {
-	dtm->install = jiffies_to_clock_t(jiffies - stm->install);
-	dtm->lastuse = jiffies_to_clock_t(jiffies - stm->lastuse);
-	dtm->firstuse = stm->firstuse ?
-		jiffies_to_clock_t(jiffies - stm->firstuse) : 0;
-	dtm->expires = jiffies_to_clock_t(stm->expires);
+	unsigned long firstuse, now = jiffies;
+
+	dtm->install = jiffies_to_clock_t(now - READ_ONCE(stm->install));
+	dtm->lastuse = jiffies_to_clock_t(now - READ_ONCE(stm->lastuse));
+
+	firstuse = READ_ONCE(stm->firstuse);
+	dtm->firstuse = firstuse ?
+		jiffies_to_clock_t(now - firstuse) : 0;
+
+	dtm->expires = jiffies_to_clock_t(READ_ONCE(stm->expires));
 }
 
 static inline enum flow_action_hw_stats tc_act_hw_stats(u8 hw_stats)
-- 
2.50.0.727.gbf7dc18ff4-goog


