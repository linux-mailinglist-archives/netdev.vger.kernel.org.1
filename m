Return-Path: <netdev+bounces-199099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F014ADEED5
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5861646CA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF92EACF8;
	Wed, 18 Jun 2025 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/qL+k/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097C2EAB84
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255732; cv=none; b=GoWHBkNwp+HFKoMEFoLyPU10UnHgFl/WhCj1NKGaPlJi9EmdTmbGmbAwWWUTtQmpe3+uKc85AgZpbsdjkG1bPH/qCrpZr3krBlLDGlEi25vxQdUk2JkgNKHxwjYkonLb65tdDghs8Yy5h90HcKz+RLjXSymuM5hesmRZ3O20Cds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255732; c=relaxed/simple;
	bh=as4hr2pkeiJwV+mjIOp91WXa9weijSBnTuTmiChnlJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aWp2hzjaxb/hCxWIYBqT2AmVYUr1sDKPsJNlfRilVO0dHg0kLR1BDHDkZBmQ6hUk7JNGVt5DLYrPrL7LzSX1fWIJhFCybxQtrBsvwbZeU8s4aP/9pi1YU/aDNJ8l/WXtjYvrtK5cSmKDWuc5KmwtMMCUKGVV01a62QC9wNZy36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/qL+k/v; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a587a96f0aso195295531cf.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750255730; x=1750860530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0oSgpc/ixYySGKuAcje8gt2adL4OhK1cPwTfYtJezek=;
        b=p/qL+k/vpgcVitBvzLJwb5K6NHw464SkpOepmpg/wlx20QMBzjMnnkcKEISd1PShMC
         az605QUi2Cxna299xQPZ1wZEn/GS4/DbEPSGeMf5BZIoXoPEy3tyamJxfs7bmaR9Tqti
         e+ENl1d3DfyM1mMMsGtufkm5Y/rv1SocGHt4LZ71cVCeUJIgx8QJH49aOlMwAQzK+XVa
         +ZWVWSPScW6Dub4fGELmKLoWm+82wv0IGuBnKj1AZbXRqbb+raKE0mEdfajlmUIjq18t
         qP74ji6b1SyYwLbRrausMvFaSQcYpsERVSX9RP8D1r7vDpVtqTkEPhcSuU5tuh2pFLh7
         THAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750255730; x=1750860530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oSgpc/ixYySGKuAcje8gt2adL4OhK1cPwTfYtJezek=;
        b=R4Y3SKAcszEtUktBKwilTZeHri3wEVyaBFyPlwEqvgL/GZKxgpQg+o5/mMEDxSZKrR
         EhvVUhP+PR/W4g8P2SM35HwnRu0Uif1yrNxDHJcVyrq2QySONqa6IMttIUeJo8EkGljb
         P1sG6i9w5tmB6xA63gLAMs0B1mSZ0apvVPKs0Ey6DaiCaHEXXV1BDTBvPWOlhIFZiQkL
         FZAYQi3/2Xv6y1W7UYW9vHvpmbEF8tTAG9BPXli4EtaMtDMHSFg3O57Af6qOtcjsUZiI
         p6cQgiOOFCfC1l6XwTtZzamo8O3/2RIU5tTaVD6okrfguWak+NZzyzs+qSBliuFpJd2A
         5PWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDzjsRVYPa+/a9RjKJC+Twyz7mgKhuahZN1Iz6J1jwcjra7OcA4WWyBU9g7a2BKIYUPbiaQF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9C8LRpbQjPysLxQX9mMqbcRQozOpw80ViotjG+QIAP8pQ1ucZ
	vSmsjJCxx4DH4ziZXS/jHAGCRRFYq0DYdQ0qd9wi7ylJrSLdKi49tfYrSIWLJJuj0y+TnlrfPmj
	Mn7xwbO21TB1gbQ==
X-Google-Smtp-Source: AGHT+IHSUmmpYfT06xELokgDqTewtUCHh4ReO1GDJQci3SaAMiXNj+xYRIUn6qB3zPUN4BYyrYvvY3n8wqyXEA==
X-Received: from qtar2.prod.google.com ([2002:ac8:5c82:0:b0:480:3049:24e2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:148b:b0:476:95dd:521c with SMTP id d75a77b69052e-4a73c683b34mr253186661cf.45.1750255730080;
 Wed, 18 Jun 2025 07:08:50 -0700 (PDT)
Date: Wed, 18 Jun 2025 14:08:44 +0000
In-Reply-To: <20250618140844.1686882-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618140844.1686882-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250618140844.1686882-3-edumazet@google.com>
Subject: [PATCH net 2/2] net: atm: fix /proc/net/atm/lec handling
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

/proc/net/atm/lec must ensure safety against dev_lec[] changes.

It appears it had dev_put() calls without prior dev_hold(),
leading to imbalance and UAF.

Fixes: da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/atm/lec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index 1e1f3eb0e2ba3cc1caa52e49327cecb8d18250e7..afb8d3eb2185078eb994e70c67d581e6dd96a452 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -909,7 +909,6 @@ static void *lec_itf_walk(struct lec_state *state, loff_t *l)
 	v = (dev && netdev_priv(dev)) ?
 		lec_priv_walk(state, l, netdev_priv(dev)) : NULL;
 	if (!v && dev) {
-		dev_put(dev);
 		/* Partial state reset for the next time we get called */
 		dev = NULL;
 	}
@@ -933,6 +932,7 @@ static void *lec_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct lec_state *state = seq->private;
 
+	mutex_lock(&lec_mutex);
 	state->itf = 0;
 	state->dev = NULL;
 	state->locked = NULL;
@@ -950,8 +950,9 @@ static void lec_seq_stop(struct seq_file *seq, void *v)
 	if (state->dev) {
 		spin_unlock_irqrestore(&state->locked->lec_arp_lock,
 				       state->flags);
-		dev_put(state->dev);
+		state->dev = NULL;
 	}
+	mutex_unlock(&lec_mutex);
 }
 
 static void *lec_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-- 
2.50.0.rc2.696.g1fc2a0284f-goog


