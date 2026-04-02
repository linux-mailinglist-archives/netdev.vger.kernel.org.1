Return-Path: <netdev+bounces-274689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKloMkbQzmmRqQYAu9opvQ
	(envelope-from <netdev+bounces-274689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:23:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 752B638DEB4
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCB1C307C212
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C138B7B4;
	Thu,  2 Apr 2026 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="lcf85bG2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF08384232
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161290; cv=none; b=cWgAKDBZ6VIRkDyhaZFXatBhcMzkWgnms6Xisjx8wk4fl1QIiUMUADvHf9S07kEvtGcemzZa7stWbvn76KfDmh7OrqVDsd//fcVQ1BD36/yC5AvHRNuV+E1X9P785bpBRume8jZH9964TL8/gBGLlhLam6xdnIQW/lTEEIx94cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161290; c=relaxed/simple;
	bh=oj4CR66ZVmIPJPX8Di9YwO1ydMpzm6XDBerJfg5CCiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSZXnW2wLSaaXt+zCXUS/hIQjNChMyJEK/y6j//BsSfFvVAIvCbtZvfFncC/+dCQ0RFIsyU6n8d/vSLYnadhvUDmxGJChhmZYY/oD6N+ZbprfbdUrG5L36YV6uYoGhHuTuNw8n6dcOT4ljgwPT+qeyhS+q3dkDpQA2BKCuUWfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=lcf85bG2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c70e4654eso600181b3a.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775161288; x=1775766088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe6c9tiANrtdfEa1pUVULMIJIY4THGoCRZXn+gDHoys=;
        b=lcf85bG259peSzRHulCoqybg0K/Ipdfmt8zLzzMFguKeNUPwBgIist/u9fhiJ9DeaE
         TNybCuN/SFGekfvwvmP94qBuuJUrNeE+420hDNZ8dyVcYZdLEiQM6oNZnM9TVtps6i7u
         7rK1yv60aAIMj3pGLySG9MIeyI9eCW/DYEnXU1MrFa18w56xuBc+6ifVWWT4W1gQieIA
         q+u1UQbGlIUnIs+M0t8LlKOkwDM9uqhJ8Dx9vgykYY+9PsLrmqC67XmQV8QjEKJCgrCs
         RzsQ6/0OFYaNA6/KUPjDRX9zYdrSgnapwy2VEvZZlJAjV3JDqShMn/Ysja1djBWGA/Kz
         9mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161288; x=1775766088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qe6c9tiANrtdfEa1pUVULMIJIY4THGoCRZXn+gDHoys=;
        b=TYfM9gLXF4oSGqv5MJekOqFT5hlcsJfevA+amY6O2vlrb/L2/4oGPvg8VKH3F1cpVe
         iq1oe7O3zPP2IzVKo4jaSkB57OvM7hm4o9PFU/vrBI5uJK34S3dhF5yY0pVJ2z7wKZqc
         XWVJAaTwNLJZypLEx7SQU+ALWcfxZdS3P6+HUEzOK7taL+nkBoi8h3dl+e5rAd7P3pHt
         9PJawf0kuF81yTTiyLscREG+RMWVfZprsgTL4BBbO8ldCnGQJD0kV6Ilyywb4dZW9BEB
         2a0d7vk+yKlc0aIVuzrX1+49wbcGZcSTZUFibXkMUkNbelJlNlo/lKQrG3zNNRNob1MI
         1Mwg==
X-Gm-Message-State: AOJu0Yx2H6o4mlaPRnZL0I/TLjXk0fkrLaRMWF0Q/fUjJhik0tO0/Lkd
	RAdVf8WDJfnLGp8R7o1VrSQfgtdI48wrkaRMGTuoiHlb8y+C79Dc8XPlujMSz+GP6+vxclDFv/Q
	o9X5Y
X-Gm-Gg: ATEYQzwsZex+UIlYf6WB8rLFO74YlrPGpGj6hTCd2DVrsjBAp5A/MB3/A83FQEcORMQ
	U8AGYu2XOpwb3+fboju2qEiaWwNAwlJoGX9cMPyhnH2wonoOgMLTXR6zeohUCM7Jvc2mXHfJe1Z
	6FDF2CcK6lXegkZ0+id1igjVbJG9bHuM2pklqXG+r/l3pzK1W40oweanMaSH/WMv5YVvTv/QP6a
	CBkMQSJcUe4LMGFVSBAVjR3S65ncZ7fKgodPJkS/ayvE3H8v9GCtZVwZMgpJJj+4p/NvOeNDwY9
	IJqbnN6F5JkB0AQLpSLQ2iYUTzcR6n8B0QIRwvv38JuJu7ntOKFZqfJB1+XKtgzVnoFRZen5do9
	4DGCNIwPoQ3ej99Bu3bOOrEQVgP28oOy2G2p6ohaUss41HUR+fWkL8uHYnj6gJt2Pqc0YBGYmaI
	L8tdORNKJm7nVW3Zh0wgQ1j9g5/pbpdLom
X-Received: by 2002:a05:6a20:7346:b0:398:aaac:a079 with SMTP id adf61e73a8af0-39f2f215352mr254159637.45.1775161288372;
        Thu, 02 Apr 2026 13:21:28 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm3345621a12.24.2026.04.02.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:21:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Yousuk Seung <ysseung@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 7/7] net/sched: netem: fix slot delay calculation overflow
Date: Thu,  2 Apr 2026 13:19:35 -0700
Message-ID: <20260402202037.176299-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402202037.176299-1-stephen@networkplumber.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274689-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 752B638DEB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_slot_next() computes a random delay between min_delay and
max_delay using:

  get_random_u32() * (max_delay - min_delay) >> 32

This overflows signed 64-bit arithmetic when the delay range exceeds
approximately 2.1 seconds (2^31 nanoseconds), producing a negative
result that effectively disables slot-based pacing. This is a
realistic configuration for WAN emulation (e.g., slot 1s 5s).

Use mul_u64_u32_shr() which handles the widening multiply without
overflow.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index c82f76af41aa..d47e1b0d7942 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -660,9 +660,8 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
 	if (!q->slot_dist)
 		next_delay = q->slot_config.min_delay +
-				(get_random_u32() *
-				 (q->slot_config.max_delay -
-				  q->slot_config.min_delay) >> 32);
+			mul_u64_u32_shr(q->slot_config.max_delay - q->slot_config.min_delay,
+					get_random_u32(), 32);
 	else
 		next_delay = tabledist(q->slot_config.dist_delay,
 				       (s32)(q->slot_config.dist_jitter),
-- 
2.53.0


