Return-Path: <netdev+bounces-64644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18668361E8
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9C51F27B3C
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DF53F8FF;
	Mon, 22 Jan 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBRob5AZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51B47A43
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922782; cv=none; b=iRKOGREyZZRCIhyoZmPu02Zf1ekSdT/uvpcuQyJIfdAj4zVKv7XEM9vCet7eqKSRZ2jy8HoqzRsn71g4yvq46YaKVPWOFHd7qQZcrxwEx7SMICAXbwYUOQRWDRoS5V3OUibECbaPBej8ilNaa1+ZhGfQbZEiWQifB8o3g2OET9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922782; c=relaxed/simple;
	bh=6dOlWcUKbcebWSNV5ZPXFJrJi689QCLmhNcaqvJxhnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LXYSUDbJPG7c2tgarpY2wrOy41112nupSAv60xzhV7k9t8D/slxAu47pq9vW+D/3zFLeMLZIv47oQ8O9VZm8uyFrsim2Ull/LyySuaGVW41bQeRjYY5wAJSmz8sMtjFQ4vRuEvYM92GSHsLS7opHbuW3Kxsg7s5wExFV5zzCTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBRob5AZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf1c3816a3so3380008276.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705922780; x=1706527580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJcGY/070CxnAPQgxk2MB4NMkhA2yZaH3cqANTsmxW4=;
        b=kBRob5AZ8qUqO232Z1wGesrNtzQ+KK7GzSuqhSdmFGYplQTABeXGA9sF55lVfQ7MWh
         JjVpt8fxgRftiL77BUTWAiX8MSHyiwhCQp9Scwcw52crLE1ipYAKAxnmFRKE+ekZT29M
         TI4c2o8PPjHHAFK9F9K6eQpUFetzq9oTbA0YEudGX1ggAanhqb9J1dZDNymClb9kWDE+
         XgYETQLCtpiWQmqBDmmVylm1Wp7FwahZXc1aZ4YeIiqNJ+qa8QlwrjQnRxo1zJqG7R3I
         GyWXPI4tbXUaE3xVtYOKWJqZ9zC1hdD+zej2xa7+OX7fzjzQ3YB/UOUZ0iu+oZUO3w6b
         P8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922780; x=1706527580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJcGY/070CxnAPQgxk2MB4NMkhA2yZaH3cqANTsmxW4=;
        b=NzGsAKQ4xolIo5QhJWcUs8Gax/8xaYWb8o95II2gqe74T8sTEkIH9ScrAdIqYXnjJ2
         YCdY9SdFSp92WzTBKBZGHCmKdBW/6B2s0Gr5DchvWN4q9kRpzx1conMsKF6piiuNxXdi
         kesBZ2AJItxf4MZ9uzkpEihzEUqoXuyWRL/34Yn03bcldxF1AoHZSsA6d27R9xt0q60V
         moJ41FCa0kADYKjwFpPwBZwgq5BLbJq5x02c5BhmL+GRoSzo0XlC0zP7mOygvW9LNjJ0
         h/6y5xiIiPbHOfnHoRgfRIIQfOWxjylqgahViYwD/f/Ui3FjeVfyK2n6e8eP5J67TSAr
         FPKg==
X-Gm-Message-State: AOJu0YznBtWsomSB1nQ2JKmd6/k2YQgg5PK0rGEcgygtfBoi9j+lN8aZ
	5iX8ayFY4TUUV+imldACoQH7Ltdp+Wzdj+Melbyd07eo6S8EGWwWLc5kL6ZztOrIEN6g6T3Gc2L
	MiW+BYF+B2A==
X-Google-Smtp-Source: AGHT+IFLQAhCy31YOwxtuub93Jr8Y6cEYAx7ayvAbGpaEwJSuapu+NE1EsLNf8m7OKQSExEe6GfiTrbeWqBKWA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:dc4d:0:b0:dc2:6501:f45 with SMTP id
 y74-20020a25dc4d000000b00dc265010f45mr242466ybe.2.1705922780372; Mon, 22 Jan
 2024 03:26:20 -0800 (PST)
Date: Mon, 22 Jan 2024 11:26:03 +0000
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122112603.3270097-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122112603.3270097-10-edumazet@google.com>
Subject: [PATCH net-next 9/9] inet_diag: skip over empty buckets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>, Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After the removal of inet_diag_table_mutex, sock_diag_table_mutex
and sock_diag_mutex, I was able so see spinlock contention from
inet_diag_dump_icsk() when running 100 parallel invocations.

It is time to skip over empty buckets.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_diag.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 2c2d8b9dd8e9bb502e52e30dffc70da36d9b1c74..7adace541fe292851a66ccc4de1da2a60ac4714e 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1045,6 +1045,10 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 			num = 0;
 			ilb = &hashinfo->lhash2[i];
 
+			if (hlist_nulls_empty(&ilb->nulls_head)) {
+				s_num = 0;
+				continue;
+			}
 			spin_lock(&ilb->lock);
 			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
 				struct inet_sock *inet = inet_sk(sk);
@@ -1109,6 +1113,10 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 			accum = 0;
 			ibb = &hashinfo->bhash2[i];
 
+			if (hlist_empty(&ibb->chain)) {
+				s_num = 0;
+				continue;
+			}
 			spin_lock_bh(&ibb->lock);
 			inet_bind_bucket_for_each(tb2, &ibb->chain) {
 				if (!net_eq(ib2_net(tb2), net))
-- 
2.43.0.429.g432eaa2c6b-goog


