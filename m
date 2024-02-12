Return-Path: <netdev+bounces-70903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5F850FC4
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F95A280F6D
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 09:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709212B81;
	Mon, 12 Feb 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGOAPQRA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD817560
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730199; cv=none; b=pbvvN54F4Q29FMAlr2boHMuIYkQF8EUxYV3XExt200n9LEGOZ3udZRLhyJIz/wQZ8yRR4PrYwxOEz/pawQxpmBTMvCW/xWNahQDoinf5iNGHEKuFqzyY6Rh4YwXjbDvVENSrofOfB2V/rPvV5kHZuzd7AYurLcsLnzhAICVA5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730199; c=relaxed/simple;
	bh=TStINRVFhm9HzVI+/oSLRgbCmC3937DPOtZqDEpQyOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nV0w1jYcOJyMiUFJKBFjg7E5sUr4wMuRiuo6VYrfJjTJ0wrVexQFriozKGnxySUkgYD13sLYQ6kXF0UVzEkCZoBWgt+1uHvj1pWHvqixe0zcW12q9jhWQNVbFGFD5HBR3odyH4ewvvrnRus2LyKQ4EYPC7i1y20yXiE7Vi/YXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGOAPQRA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d746856d85so21711015ad.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 01:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707730197; x=1708334997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNRRMX/M9s6K5W6pc2GtqVUZ7M9Go0EAy58TztDkPPw=;
        b=TGOAPQRARUpNXphmQxkklVxlWpk8cP90eAD+nOBZv6cR6a6k4vR0QptC+JxBtaEKP6
         jcW65ZJUZCSAmCK0wCYkBY2IwHGguV526CWgzQ+E8fvAPaXA3wP5DJUw3uNOjzwkNa7r
         3M9KvybaAlCd5/Z1ijVvhNPFJ8Upi26TczNtBnTOcJUy8cb5/m22BfUqKWTdgMt5y7iS
         Ge20a5k8M8yqDziY5b6lR0A2XLciQs1Lvjvp7lCbrMy9O08oDb1T9x0FpeYYII9aY57g
         SdAhY7AVrr00ZwZo2fUqqDc76CTvCXZKNhh1d0vsJ0CdgxdSndhdWr2Pxuza5v60ys+A
         S5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730197; x=1708334997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNRRMX/M9s6K5W6pc2GtqVUZ7M9Go0EAy58TztDkPPw=;
        b=GpDTOmZclcGc4h6toDxJSUPWamRHFclPh/X4v6KlmWmg8cW3Ul/c/VsrVGAxKaf7nf
         rkMREA8RwaGTej6XB0SezXMGAVkBrZqwYcxWXfhbZKLyJT2E4WzIJQFw5+X5tnAKiQ0w
         6zU5YMJa20hFBSozAza01oIojfPpG5m/hrCvttsGpzsmnRdF2IO7deA+8Qvn8dERlek7
         2HY/PUpyTySyhcMBDxHCPpBinYDL1OeuZ59h/VT0h5SVkoyxfTA2gcF941OzfSq5Oi1B
         a55qOU4KqhFkStuUFLo3CzLpKwvIL01bQJ3/zpUELHY50uvwGzvx0YN7mEURHyZQ/0yL
         ikuw==
X-Gm-Message-State: AOJu0YwIzxHWYmEzF8CGH/5aQbmbHP+UuTz022rgK3wk1/eL++SAcX0r
	Edwn36I00n8/K2vBNk0ad515vFBWT1kzciiQJpsN3Vfl18Pi7s3h
X-Google-Smtp-Source: AGHT+IHsJTEDdXMZVxetFTN8HYeMum+VaNLWhNv/hoFEjgMF/CV6vtPJ+OxhuJzYj6NBiiZES5RNTg==
X-Received: by 2002:a17:903:595:b0:1d8:f06f:5cfa with SMTP id jv21-20020a170903059500b001d8f06f5cfamr4617367plb.59.1707730197461;
        Mon, 12 Feb 2024 01:29:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwCzZOaq7gLAvD+ShZqympOTeF0y41nQLAm7+p07/9BZBf31Ay9XkVT5X77URcCs6LyXXAnc0NQeIDtT+N7MDrZv732YWlRSaaR4lj342viQLJDG/b4z1MqeB0kGP7Qff1vdpabtoPR2Zrf0qch0u7DKRC75TL13wn+c6rME8+MnmcyEGPaMCqXQkEpQXIgD5juKMtmaYzFuc87AkzldtFVpTeZJ9CkFU31iLmA90=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id mg12-20020a170903348c00b001da18699120sm4220211plb.43.2024.02.12.01.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:29:56 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 6/6] tcp: get rid of NOT_SEPCIFIED reason in tcp_v4/6_do_rcv
Date: Mon, 12 Feb 2024 17:28:27 +0800
Message-Id: <20240212092827.75378-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240212092827.75378-1-kerneljasonxing@gmail.com>
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Finally we can drop this obscure reason in receive path  because
we replaced with many other more accurate reasons before.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 1 -
 net/ipv6/tcp_ipv6.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c886c671fae9..82e63f6af34b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1907,7 +1907,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		return 0;
 	}
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (tcp_checksum_complete(skb))
 		goto csum_err;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 73fef436dbf6..29a0fe0c8101 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1623,7 +1623,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (np->rxopt.all)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
-- 
2.37.3


