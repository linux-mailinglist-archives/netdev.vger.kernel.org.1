Return-Path: <netdev+bounces-162151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8179A25E5E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2D61626F2
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB720896B;
	Mon,  3 Feb 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="08NNN9OT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DD204C1B
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595520; cv=none; b=m8wE+0dcRxog0lXGTY+fNulvwWhsk2Y1w3by9DFVMmwqn/YTSLED9W/CiuBHiiDvlxgwEvqQqN78eUrPzV0xi8Q8Te8InCdZhQuh3FRAh0/YkhGhrtQ1yeuV7LWVcs9IOaAYl1E1jfHPdfbWU1ZiFzy+p6hGuXRYVAwwBjZiNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595520; c=relaxed/simple;
	bh=0Ona0rfK4onsUslQxN5eRvUOoRIzhu7r9G4zEqpYI9Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p8O01d7p+fZNozkDQWmx7/tspPI77AzrD6W2uxyEPx+NphFzh4zX9XFqYr3rlACXsceO50T4iizaJLQaV1Lon8njeXXK1zNZRmiZD/mxe6vmS/TBQ+JZxYr9c+f2Ce327iQ66icAh96FCr3i8DYC2TGYt7pxKMTbHqBEwPrgxiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=08NNN9OT; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-46790c5b1a5so48027601cf.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 07:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738595517; x=1739200317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cd8CI6eo9Rl03dgQJck0Q11LVpIo4GjR+K8YNdwzW7E=;
        b=08NNN9OTCxcaWIXgDe0F55tbDKxDbz8W3RIhMCqggdJsG0IChztGNuH8X1WMDaOGK4
         PYZ4EaExFykzkFMmCk3zs9emjaXvV/3LRU4m1ebbZfNz//BaZucsiT9HROnUY/RygbEZ
         h7OmIiBV1j3Lrflru60Ov8kkXZU4pTvbTxZuIn/dYfZHRt4emKDSqDnNCpAue6+idDIl
         E0DkMyNj7M2lVfaMgP2f9ZAZDQ5FFoCcE1TodnKSHyyOwXAnMY9cQzs/KUsSKNwxrqBH
         lVX6izD7qRieJsiH+EmXNrkwSTTmm8mwvnOWdzfPV3wXp3uhU5P5ZFtWnmDAU66nowBX
         jpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595517; x=1739200317;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cd8CI6eo9Rl03dgQJck0Q11LVpIo4GjR+K8YNdwzW7E=;
        b=fP6UmdrvrT0hkjFvOfPeGLYbRYtR4P9/YDgozrSrD9EGfkTN4dWIVIluww3SgHdScE
         qFYPdI+5ofmDgE+bIVtfJXVQeL/VtQalqH7U2kIdmxIL+m+WGBHlRKWQZyb+6EEide9k
         I/WZoasIoqe+TsFVk8wgOuTZCHMzHHLkuenWMIwGJqBc58/UF9/EBKcvTOSb1JkJ5xHR
         r6+Y1lzruGYaUGdhsgHMsh14ddg9YTfJgchSput8aZ4DtnhCjBbA6p2ecdQ+YmNzAkkg
         dU2hM4rOIpn6f4z7/f33zFQAZGpynd7c0K8IJWFfN8N7ZhS2SBCffMGUKS+nzBYq4uOT
         6pdg==
X-Gm-Message-State: AOJu0Yxqgu7N/rLMzBegnjtzWTTj6uS+cqsQqifTDDJS6ASzyDuWPyMu
	NGd9gPR2V7QIe0h1S6tHkCsuUFcA1PyPdiQrAvrb8UtosRnI2FRWT4yYYqQ3qm2/yTbEOpe0uzF
	yU/0Uo3kU5g==
X-Google-Smtp-Source: AGHT+IHuTyxaaZs70QzZsL4tZkt3xfq6IYomw/05FUcDKroxMkmGR22ElEBBYjAySj5vYuFa1EcfQ329cqlEvg==
X-Received: from qth17.prod.google.com ([2002:a05:622a:9011:b0:467:8351:3f77])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:489:b0:46c:728c:8862 with SMTP id d75a77b69052e-46fd0af64femr286127801cf.31.1738595517352;
 Mon, 03 Feb 2025 07:11:57 -0800 (PST)
Date: Mon,  3 Feb 2025 15:11:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203151152.3163876-1-edumazet@google.com>
Subject: [PATCH net-next] neighbour: remove neigh_parms_destroy()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

neigh_parms_destroy() is a simple kfree(), no need for
a forward declaration.

neigh_parms_put() can instead call kfree() directly.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/neighbour.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 89656d180bc60c57516d56be69774ed0c7b352b2..73260ca0fc22317e096ff5f17519e117f41ea48f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -832,12 +832,10 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 	return -ENOENT;
 }
 
-static void neigh_parms_destroy(struct neigh_parms *parms);
-
 static inline void neigh_parms_put(struct neigh_parms *parms)
 {
 	if (refcount_dec_and_test(&parms->refcnt))
-		neigh_parms_destroy(parms);
+		kfree(parms);
 }
 
 /*
@@ -1713,11 +1711,6 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 }
 EXPORT_SYMBOL(neigh_parms_release);
 
-static void neigh_parms_destroy(struct neigh_parms *parms)
-{
-	kfree(parms);
-}
-
 static struct lock_class_key neigh_table_proxy_queue_class;
 
 static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
-- 
2.48.1.362.g079036d154-goog


