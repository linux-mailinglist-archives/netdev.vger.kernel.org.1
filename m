Return-Path: <netdev+bounces-64637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4D08361E1
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D47F1C26D6C
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63AD3EA83;
	Mon, 22 Jan 2024 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmxKoM9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1483EA69
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922770; cv=none; b=BF51MkMhE4xkcYLbLja0L1kGJ1EqgHbhNL0lQ/+DoLJ3EL2MEbaIKLK/X8g/d5XUG2lF52LZblE5rp6dqkvWJz5oGjjYYLxVBslelQvzDefU2Lqzo4zW5I0/N3rRlsxV/1RyeJbPEi+tEBsIPixcxrdmzt7Xyx/d2hLyNFY1MTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922770; c=relaxed/simple;
	bh=7Fe+TFXqCauVUCOcfDexU0dUDmi4TmvCrq76rkUQzuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KpPX415NORilPmMXa/Whc/MGW7/fPPcFpWKBEh3rrSYKn8fvHD9sJSevejtzhXsBTCwEgzps1QNxTnbj1vNte1YcqCEI80dxYaBHzSZJgXQNjHoBOxUXsXgePBf6B46MZ2dAXi1a5SlSOPzWdeLziKwMh4dXx3oGDTQogBRgx/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmxKoM9w; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffac5f7afeso22791887b3.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705922768; x=1706527568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFntozLhw8+bc0bAC0mMMhLA5x+C0rT2h1hZnN3PwTI=;
        b=cmxKoM9wa31fJRDiRkiZVYvKR3QA7zqsl9qqMpXOVxEvy6BAEQiZ/RV+mqKNQR79U0
         UHtOoajDqVFmEXGkgmx7DlIL7LzlADVbVE5R9mpB71EEn5IvnoTBZBW3lSrqi2tfRb3W
         weJdpWAbc/21AQ5bCKnxPx2WTcCpEBGoQ8VOVg0z/S1bd/appKr6dPljsQL/gdh7RPrc
         +NUD6tOWvOfu8akCguDTbHAEKN0/QcrHYDvakVQ6hjRbVLyoydMz0Fy+aMOmFimTHp51
         8+kSHTilVbic+9kdzMZnTcSnEWKDC7Q6zLz4dk75RwrGowZBBNFsf5ZK59ZS09VM/4sr
         AKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922768; x=1706527568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFntozLhw8+bc0bAC0mMMhLA5x+C0rT2h1hZnN3PwTI=;
        b=DvZve3ZwW8EZKX16ZSCVq0/iHIT1y0Y7w34utgv/rtB90TLlgC+YyFko8CiKPPpo/3
         OlK/yVGBr3Q6VARz4fn7Z454s8Jni4zrR5yAA5RGG3rnyAEN9HzyuSfRYfIx2Pcu4v0k
         vDfHoZBNqbMgFWKO6MAoz+NkoJdldQ8joBKK1iPj2+0RwgpMVuc95vhvsduFR17VJ/BR
         AfHX00nixrkvEOsQTprlHDBmJk46YucbCPK2pLLWd4jMEo8sLdWr/XX3fW3Iw43FUySo
         VDeaSKtUW8BibGZAJN1nnU2wZ5WRiLGIHu/kbsopYyrgn11g1ce+4SafyC1zdINjZHiv
         wcuA==
X-Gm-Message-State: AOJu0YzxyfTjHzYftMXeykr80O1nzwnA83wwSVP5sf/o8m/7PIWYXyIX
	bNZ5LPD3k3fS3OOL3xpt/yrpT4lM+2DH3P1LoP4QYitTkwko6ovFggHJJ1EebBQ6k5DFKq7xxul
	2MGuZlK+BZw==
X-Google-Smtp-Source: AGHT+IE28xc6A9nBy4Kyfn3sTVM7ThwkNWZLRR1bBPhhAaixUtJcAwqnRQcEzQEx1BZ6wz/ZPiDkS6fBVx8+kg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:ec5:b0:5ff:780b:f3d8 with SMTP
 id cs5-20020a05690c0ec500b005ff780bf3d8mr2039972ywb.8.1705922768455; Mon, 22
 Jan 2024 03:26:08 -0800 (PST)
Date: Mon, 22 Jan 2024 11:25:56 +0000
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122112603.3270097-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122112603.3270097-3-edumazet@google.com>
Subject: [PATCH net-next 2/9] inet_diag: annotate data-races around inet_diag_table[]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>, Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_diag_lock_handler() reads inet_diag_table[proto] locklessly.

Use READ_ONCE()/WRITE_ONCE() annotations to avoid potential issues.

Fixes: d523a328fb02 ("[INET]: Fix inet_diag dead-lock regression")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_diag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 8e6b6aa0579e1c94def819a1f9eab8b946771ba7..9804e9608a5a0294b3ffabc4b5bb87ac1b96b09e 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -57,7 +57,7 @@ static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
 		return ERR_PTR(-ENOENT);
 	}
 
-	if (!inet_diag_table[proto])
+	if (!READ_ONCE(inet_diag_table[proto]))
 		sock_load_diag_module(AF_INET, proto);
 
 	mutex_lock(&inet_diag_table_mutex);
@@ -1503,7 +1503,7 @@ int inet_diag_register(const struct inet_diag_handler *h)
 	mutex_lock(&inet_diag_table_mutex);
 	err = -EEXIST;
 	if (!inet_diag_table[type]) {
-		inet_diag_table[type] = h;
+		WRITE_ONCE(inet_diag_table[type], h);
 		err = 0;
 	}
 	mutex_unlock(&inet_diag_table_mutex);
@@ -1520,7 +1520,7 @@ void inet_diag_unregister(const struct inet_diag_handler *h)
 		return;
 
 	mutex_lock(&inet_diag_table_mutex);
-	inet_diag_table[type] = NULL;
+	WRITE_ONCE(inet_diag_table[type], NULL);
 	mutex_unlock(&inet_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(inet_diag_unregister);
-- 
2.43.0.429.g432eaa2c6b-goog


