Return-Path: <netdev+bounces-120272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 174DF958BF4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52386B218F7
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAA3196DA2;
	Tue, 20 Aug 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ws81Y0Qj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04051A01BF
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170147; cv=none; b=HQF4quYqdbIxjCm0YbeasZuipSr6RCyEnfeQVamfYDfEjjmvLe30bR/TBN1P5QvvDOY5yOYcnOiOUdgjvZqThUTvfueWVSzI4niTf0SUOZKK2c5yGChie4abRfpIcvznBqi5ymTRymjcv1dKkxbrU1Y1hNSetoGChaCYas4cvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170147; c=relaxed/simple;
	bh=cBxJXRv1j7JPSGU5x07vrhxOOjZMJkC6Cbyjhtc1Ib8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QSuWFCJZUXnAgMIE8/LurkosfvDJrZY+aIltrq+blNWc3oOznP5Xdwn0bbHsz1bxux8IXubDkn5/Pr1fk/SmLHpQ1Y7npwRCPxinCrk5CZaGQn5k1n1wrAzVYoFHMNAElGTBDrvdQHjCvAv83PBvdOIJtLiOXV96iYb04RnPRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ws81Y0Qj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b41e02c255so67865157b3.3
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724170145; x=1724774945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pdf5j74DbpMUw4v4CbxVsm1FC9sUV/TYhieddF+Uvwg=;
        b=ws81Y0QjveJUA/6X25roMMszxfh2VrzG8I0l0zXTjNOW4s+sHB1DWTCz/eAYtHS83C
         Le/WY9r26g0OFpQhiQ5DNW7S81fat6rMF7P272A4WXyVef3zyHwFIP4c3L/WLEpd780t
         +GsUs9IhQpbcqFsXdo+KNxdjIN3aSc4korBoawT5YtML2f96BtNiA6JFmO4E7D6Ezlfh
         h8bw84h+otWX0oZar6zVprONpaUod5wKtuQ/SDBuxYeoSn0GO7YdP4m8hlTHkxpa81Xp
         4s9LS7nHqmXltUsU6nkZo9x706EX8DZGpVDSqdIK4JSRweVLMNF8LebRzqlJXpr7EGNj
         Nr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724170145; x=1724774945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pdf5j74DbpMUw4v4CbxVsm1FC9sUV/TYhieddF+Uvwg=;
        b=r54Yk0ftgdfvBX6fFqzmI8q5Xduh3hijo96+sqNqP0fAvNUelLQtmxWZOFdGdzdhX5
         H9NHf5bmJvlpXk9o7YW6Jl8N3b2o9WBhDQmJg+ld1Er616Z/X2Xym3pNEes7AEDCmR/I
         ubFi6zB+IOxokes6l5OwyM9T+qW6wWb12HAiPeX/hplVNu/TePrq7lxPkJCLmXIu5dAB
         mR7s8r3yHsAQaV++WDKi1diniJ2CbvTCDloce8AQlwYZa98KW2cAlv0pzoBkktZob9pb
         dXtdMNNHuf9rlhevXU2cNfdgOMDGEtOlALAHZbmKAg4hFJGyBzFAbX8QDwFvDaLUlFcU
         pLqA==
X-Forwarded-Encrypted: i=1; AJvYcCXbVIo8OsBycWgmjrj8qzEK+77zPi3LhHbkRLEVwzqf0b7o1wzhJdnw4BjnjhdZLBKMiv1f4cG/xmrMf4ANvqoGcKKsgqfS
X-Gm-Message-State: AOJu0YyOm3WJIpeTUspWQNMyLoPbngDZ6p/AVYU3MXsP5ae6tPzT5NgK
	iFjjcrejNiYFqwo5+EF9UzEYvHdo8Fik6eQM0Ai4Dhs+XfiItfXGAUhXPf4d9aQ6yHG/rOfd1WW
	kdmMz7HGfnw==
X-Google-Smtp-Source: AGHT+IF/3GJpweV1K84wCnjMJEH5W2KvoH788u47Wd+dYPh+JbS2xQzXP29jafKM7X374IJYcqYC8r3OMdAAbg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:4f01:b0:69b:c01:82a5 with SMTP
 id 00721157ae682-6b1bbb4e422mr2148707b3.7.1724170144767; Tue, 20 Aug 2024
 09:09:04 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:08:59 +0000
In-Reply-To: <20240820160859.3786976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240820160859.3786976-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820160859.3786976-4-edumazet@google.com>
Subject: [PATCH v2 net 3/3] ipv6: prevent possible UAF in ip6_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Vasily Averin <vasily.averin@linux.dev>
Content-Type: text/plain; charset="UTF-8"

If skb_expand_head() returns NULL, skb has been freed
and the associated dst/idev could also have been freed.

We must use rcu_read_lock() to prevent a possible UAF.

Fixes: 0c9f227bee11 ("ipv6: use skb_expand_head in ip6_xmit")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vasily Averin <vasily.averin@linux.dev>
---
 net/ipv6/ip6_output.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 1b9ebee7308f02a626c766de1794e6b114ae8554..f26841f1490f5c31e3b09bce5773391e779128e1 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -287,11 +287,15 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		head_room += opt->opt_nflen + opt->opt_flen;
 
 	if (unlikely(head_room > skb_headroom(skb))) {
+		/* Make sure idev stays alive */
+		rcu_read_lock();
 		skb = skb_expand_head(skb, head_room);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+			rcu_read_unlock();
 			return -ENOBUFS;
 		}
+		rcu_read_unlock();
 	}
 
 	if (opt) {
-- 
2.46.0.184.g6999bdac58-goog


