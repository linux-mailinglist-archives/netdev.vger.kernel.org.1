Return-Path: <netdev+bounces-140069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFBB9B5287
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137D9281C4F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C8206979;
	Tue, 29 Oct 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bul6MrTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ECA1FBF50
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229269; cv=none; b=FCDFsuFFYPydyLWOPVDsFNCBbsr0HR6dN796z+DeBfSqpwZps3NFGp5uAaAOMZvghFg37gfekvP6Kj0ZnNX+e5DfFHpHhoRkxmxBnMcxFMM3fS2fb/NXNSewK7a9nAZbofzPM+YPDv3XUfuQmpCtvl0BDcDGn9MGjfLEccmKIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229269; c=relaxed/simple;
	bh=3UhEieaknUneJis3jCbLMO6I3Gg9X4OU/6wjwUnFr+g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N4CTV28A3NRblN+p+4R3i40FXHto/lhAsly557+z1UOYFUi0w+3J1h9MZyg91PRN7E35FZCCoyS7ljetYDHusc3IUSg01HuVq9SRySWPxN4AY98rbYN8ByS34vHiM3uoKKTNSTjf/v37I4iHvMOGQY0ZdVNsF+Thw0Yx1nWEivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bul6MrTu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7fb84f999so87814747b3.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730229267; x=1730834067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UHdXf/fUGlmc7HyCf2vvKvm/HbjPfBhF67YCLFlFMrQ=;
        b=bul6MrTui+l0+IE2IYAbQRDg+gtEHmK9cBGL4VXDe5tTVgsXpsgcYoVHMkIYTUp1tA
         M1b85WlbGBOF6JqxZLrejkn9spnowu5d9VRDIQ8jk99K/N00WMygIRgysFlDeD0P+62P
         ki1euQW6fhvTnXibForkWP36fJwDi9GTfbVcRP04WtzKZWx/KZMSt8HTfQ9Y9nMKHxQH
         mCYA0/TM7N4FW14KxcvtWw6Q5mpWk6mYmjhCtcT4fywac2sHqbll4eyjcYEdLli/rhbF
         XDveKbcWPEI+QCf7N6Rbw3XA9R0OKT5BMv8MlVfV/gtSuBbhNa6/qG1in0+6H4nssb99
         Gjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730229267; x=1730834067;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHdXf/fUGlmc7HyCf2vvKvm/HbjPfBhF67YCLFlFMrQ=;
        b=a891SE0wFGOjpwSHhZCRWAzJYnj9urnNYDJlOm+GsYBKS5vkrYIQnm90Dz7erktIb0
         RONgubL2qZIXZgVoNKCK/sjEYeBqBvYOF8RpMCUExy0FlrT06BAepqaBrBERfoDWU54G
         bK4CpleVF1W/NKil9DyTWMqkgpehV42/K5KYYzQy1Ga0duUDobvKKwRYfpksGknos1A5
         G2G0Ru5wNIT3MavgdnMthFBxNbSkQBHAxd/I0ZsUfecKvC1JLAXrMgByeqrybMg+CCW1
         J0N5exK6nguXl0WoeoNtegkqjGa7qWs5jM7zvCE9drJlJsOYnbCRI3rtrNXD0+C+tOwJ
         xRSw==
X-Gm-Message-State: AOJu0YwfXTaR9lk1S2Q8nHtzGTx0j1lhgZsOeYmPy4Gs/1GnrAvKdiA0
	EZVr4NLC0E/bVQf1I3JtQeSAjMi8gAUMzjggX+t+HdT2pL8QKecf3GoagQxpNlQudbeHGuYwyTD
	J3BBvHmecYA==
X-Google-Smtp-Source: AGHT+IFqdSVjxr156q4pyILS//lTk4hPn19zHxkcnTjtlysYjpluHh5VRfxNW26EEztkCdKaafaxJdzuq502+Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a5b:2ca:0:b0:e30:bf92:7a64 with SMTP id
 3f1490d57ef6-e30bf927b96mr2306276.2.1730229266759; Tue, 29 Oct 2024 12:14:26
 -0700 (PDT)
Date: Tue, 29 Oct 2024 19:14:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029191425.2519085-1-edumazet@google.com>
Subject: [PATCH net-next] dql: annotate data-races around dql->last_obj_cnt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dql->last_obj_cnt is read/written from different contexts,
without any lock synchronization.

Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/dynamic_queue_limits.h | 2 +-
 lib/dynamic_queue_limits.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index 281298e77a1579cba1f92a3b3f03b8be089fd38f..808b1a5102e7c0bbbcd9676b0dacadad2f0ee49a 100644
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -127,7 +127,7 @@ static inline void dql_queued(struct dql *dql, unsigned int count)
 	if (WARN_ON_ONCE(count > DQL_MAX_OBJECT))
 		return;
 
-	dql->last_obj_cnt = count;
+	WRITE_ONCE(dql->last_obj_cnt, count);
 
 	/* We want to force a write first, so that cpu do not attempt
 	 * to get cache line containing last_obj_cnt, num_queued, adj_limit
diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index e49deddd3de9fe9e98d6712559cf48d12a0a2537..c1b7638a594ac43f947e00decabbd3468dcb53de 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -179,7 +179,7 @@ void dql_completed(struct dql *dql, unsigned int count)
 
 	dql->adj_limit = limit + completed;
 	dql->prev_ovlimit = ovlimit;
-	dql->prev_last_obj_cnt = dql->last_obj_cnt;
+	dql->prev_last_obj_cnt = READ_ONCE(dql->last_obj_cnt);
 	dql->num_completed = completed;
 	dql->prev_num_queued = num_queued;
 
-- 
2.47.0.163.g1226f6d8fa-goog


