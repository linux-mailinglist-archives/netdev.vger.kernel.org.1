Return-Path: <netdev+bounces-205329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A58AFE36D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA651894241
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7CB2836BE;
	Wed,  9 Jul 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yKhYhSAE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398222820BA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051729; cv=none; b=VMOBDWm4WstumNj7c2Zdl9b4U+UYTTK8wx2Lw/VbHPPZDar4k9aE/KdjOLDZ3WAHcoq9j6ZZQQsZSKuz5pcMb3sn0UXfZG2GsySWv9p03b6SXtSxD3dMPIU715DKc+XhiSTk9kJU8H3Xgtd5bcAnG3Len4ho+mBGN7vkQfkOlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051729; c=relaxed/simple;
	bh=YuSmIoTtYwI38ijbtEQoGK0IFv2+ctFyjWwJaqzZz6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UFx+9+gRgzP709+WFPqEN+C9nj9FQxpHutd6CGxFu7plHek0vN4jJla9G+IV8TuuwqKDUCvR/creo1EHqfUrFHhMLw4+swTD9EoD7E0v8sYjM9jqmNwl21v7uRnwpulKInHQI0tkeG0+BnDEAcIRyFSzUpkbEYA0uMzB5tOKjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yKhYhSAE; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fb5f71b363so84828356d6.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051727; x=1752656527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVi23zK63YzlDzWGZPTWsUrqAjHMHuaK68/Hqwf4stU=;
        b=yKhYhSAExR6O/osBZu8HGZsnvE/S56VxkzwzKSvc7yWXtZ7Q+EioMtvIrA8XsA0+xo
         FT23D0MBEBpZ5ucv/oX8/GyjkcH1jFxFNHnjOchabqiOnZ6kwfwhCSsoktUpw/X3pJfX
         Ja8t1t9k4hNmIUZlnL7khoLOC5bB8bc+/WqtDP6/PUipCo80MWZgM/+PJZv3ijt65ZLN
         WmnU8F2zp1tbyyqKiAdjysOdfVEaDnZEe6XIeyxbWxXhU1PRW1+Vqzumd5eOYMw6tbSN
         YlF+jdKcav7qQy1C92U+Bfi18iGPRr0TGPCpjDKagy2ECWkLRGpRTnPA4a3ul4AnTV2R
         +rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051727; x=1752656527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVi23zK63YzlDzWGZPTWsUrqAjHMHuaK68/Hqwf4stU=;
        b=qGH/es4xVedK7d8bb5ecez0Y5Cs2dtRLvDaoJ1PwdcATVtoc4hRnQVTLco7XIN+Pwh
         2Y+ve7OPiEhu7zID6Et8EutsXnY65Lo3QsKT6OQnpZHedcGEyT6C8LNEcEDhJG3Jr2pu
         S5/pGnhIIyK8JFxU17As/VLYk0lwVr8t3ahDIfln+fDRlwvXJNG22iI2QRDkCueylTCu
         4Yvpyt4vVSLgkdNfysNmV98/OCL+VrRF4/PtbW/4qnr/qq896ZjHvYibZPiQLLoYmKEM
         VWVGHcmQqgxtRIam+PniujBjFiYpdaCO80K0WIsExaA9EC8tOBO0IpVc73YLZiKOD+n/
         irnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1d7G1XMA2XeB+3tps54cqK7NESdQZHalfb4HQQ1Max9/sodtZcRoLA8eTY8sNDhN+iBlUwrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KZ2AIdOfFb5CdgKLaSyCokkndhDkPD0bTT1uexKWbwNhbg/B
	l9qiYVFgLxpalN9KVDjTAc6KcVtJ6k97Bi1Mx9fkNqDg19cJ8SzDY1XrK1RnBstvGNARuPePE/S
	jZsEmaovJW4KHjA==
X-Google-Smtp-Source: AGHT+IHO74FGQIq2+KgOGz7d7JwIjliRYvowODebmmKMKDwZLf0btw6HeqnDvwyixI3CL+kmX/aNsdy40jvXpg==
X-Received: from qvbmd8.prod.google.com ([2002:a05:6214:5888:b0:6fa:d74f:1ebd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:8105:b0:704:9077:e0c8 with SMTP id 6a1803df08f44-7049077eab4mr4265426d6.3.1752051727152;
 Wed, 09 Jul 2025 02:02:07 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:01:53 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-2-edumazet@google.com>
Subject: [PATCH v2 net-next 01/11] net_sched: act: annotate data-races in
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
index 04781c92b43d6ab9cc6c81a88d5c6fe8c282c590..2894cfff2da3fba2b6e197dea35134e2aad5af80 100644
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


