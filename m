Return-Path: <netdev+bounces-97325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDCE8CAC51
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB57282732
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E176CDD5;
	Tue, 21 May 2024 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIchhHxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0B6CDC2;
	Tue, 21 May 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287686; cv=none; b=GxJlV10pdRUwG8Iu0hAvqPdQnNEijbmxpqsrhy0onzXCGK3527+CaKN/bAkulBFUZqIMkx0zfS33V4tpe3S+ewxNddBsJy4kCm3GMyGrQ6g1HUYxCd/MXziE8hH77Ol+ZJLu1IMwxPJbvfZOFiycaiXcgynWFs5Xmt1seTWsA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287686; c=relaxed/simple;
	bh=CXiGuTveBYvikiaixrSuzN6fvkoLiUDszUlj3xGQpqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PpQxu3n9bkLKaufseUqCDNdRctJqPQylmbn+Trdsi8HIZxaHTsVGhYNCaGq8Z1TPk8mh+0CKg1LiS0Phy8WYtOuMSJNZMqG3omAxOOucXATYoupFdgOkNBWE4xurX76VOniAi9CGxEhEpPJ6VOHBkwro3TucBs6DCVtNhjlPb7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIchhHxi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f0937479f8so100825035ad.3;
        Tue, 21 May 2024 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716287684; x=1716892484; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3sehLpck2yDqjDYvjgEiEstrq/QyxjTksSBaL92La0k=;
        b=VIchhHxiDLNJ+BMv013vvKhrqTZL6H9jVpweToPDwUKRq2gbeZuZj+w2ZWk6ooTC/D
         bK7aPBzkW98ZGOYyiQTMOjF/STx/H4y9QuQUhaNb/G2sGQE2/7oVNrPkudZ6CWsNhVUp
         pK2hFlctQ59wGXHhmSeQ5MRQTeD/InVYxzweLmG1qniBaV/8i6KITqq2+cFEBR0s9CRV
         514hS89YcL5O8OzVYT6hJzTpcWUmDTdGz2i2gwrp7Jm8zoy8nwv7zd2xRuBF/yQ1xb3r
         FiuoIp9ngV4cvMc28iWNLyCAads5CrmxFAizssFySOakULLtgKVsNBjQnuTp+5LXSFmG
         PDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716287684; x=1716892484;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sehLpck2yDqjDYvjgEiEstrq/QyxjTksSBaL92La0k=;
        b=lK1Vj3Pk51KcGdUfV8eZS2oUXMN+tizkBExlwEvzACXuoiQbSNzL8Difv4cKVlO/3x
         g1C2jSkNlSm5G25Hdn7AN4wVKqnp/v4uofsloNyW2eMa6DLotv3cxAE+J4zKYw0stGQg
         b5rx8bESr5Rb4cuTRcDbGOD9TaVjGUOsaoNbnpRIbLdj/ABEgg4YoigVu5T40AeYGJDd
         9CUPN2PDtrc496RlWVlKc2lSsLO1GttRvJcYmFtmwS5dzzimppK4UQi8R3WtA1HdyeCR
         s+WYBNLGSfjm+uMcT9L+kXsNW8+WFfZCdBPswf3eT+mu9NAo+iD5Vy90C686C8RZbsXT
         WZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCV5YIlRVs2FDQxFThvvqIIEv7AJNd1XhFl0nN0GjBfmz6GZS6mkIp0OdS27x9D6osAG72Xf9MeFh3LTdKg12aC7cFxSjahZpDWhFRTlot0COHlegvwb3VffAOtF9eYSTUg58hMa
X-Gm-Message-State: AOJu0YxwTWY6SngaD1I97zDrK9geU/5Fbd4IYRP7IiAIzRF0dVUa27DL
	D7DvpRkesuS+kTXcaoH906QTH0F+BOrtYeNSdb+PoLqWt2/uW4al
X-Google-Smtp-Source: AGHT+IE25aL/4/zxxn8w2FeumCv7Id50mPpsNfynpk5yhqLATIeyR5dw4/rKWteVt4uHrqMDd2BZXQ==
X-Received: by 2002:a17:903:184:b0:1f3:704:8304 with SMTP id d9443c01a7336-1f307048b69mr40697395ad.9.1716287683934;
        Tue, 21 May 2024 03:34:43 -0700 (PDT)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f312268e60sm4851155ad.15.2024.05.21.03.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:34:43 -0700 (PDT)
Date: Tue, 21 May 2024 19:34:38 +0900
From: Yewon Choi <woni9911@gmail.com>
To: Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Dae R. Jeong" <threeearcat@gmail.com>
Subject: [PATCH net v2] tls: fix missing memory barrier in tls_init
Message-ID: <Zkx4vjSFp0mfpjQ2@libra05>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Dae R. Jeong <threeearcat@gmail.com>

In tls_init(), a write memory barrier is missing, and store-store
reordering may cause NULL dereference in tls_{setsockopt,getsockopt}.

CPU0                               CPU1
-----                              -----
// In tls_init()
// In tls_ctx_create()
ctx = kzalloc()
ctx->sk_proto = READ_ONCE(sk->sk_prot) -(1)

// In update_sk_prot()
WRITE_ONCE(sk->sk_prot, tls_prots)     -(2)

                                   // In sock_common_setsockopt()
                                   READ_ONCE(sk->sk_prot)->setsockopt()

                                   // In tls_{setsockopt,getsockopt}()
                                   ctx->sk_proto->setsockopt()    -(3)

In the above scenario, when (1) and (2) are reordered, (3) can observe
the NULL value of ctx->sk_proto, causing NULL dereference.

To fix it, we rely on rcu_assign_pointer() which implies the release
barrier semantic. By moving rcu_assign_pointer() after ctx->sk_proto is
initialized, we can ensure that ctx->sk_proto are visible when
changing sk->sk_prot.

Fixes: d5bee7374b68 ("net/tls: Annotate access to sk_prot with READ_ONCE/WRITE_ONCE")
Signed-off-by: Yewon Choi <woni9911@gmail.com>
Signed-off-by: Dae R. Jeong <threeearcat@gmail.com>
Link: https://lore.kernel.org/netdev/ZU4OJG56g2V9z_H7@dragonet/T/
---
v2:
  - We don't get rid of tls_ctx_create() because it is called in multiple 
    places (tls_init(), tls_toe_bypass()). Instead, just move 
    rcu_assign_pointer() to the last of tls_ctx_create(). If needed, removing 
    tls_ctx_create() can be considered as later patch.
  - Added Fixes tag
v1: https://lore.kernel.org/all/ZU4Mk_RfzvRpwkmX@dragonet/

 net/tls/tls_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b4674f03d71a..90b7f253d363 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -816,9 +816,17 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 		return NULL;
 
 	mutex_init(&ctx->tx_lock);
-	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
 	ctx->sk = sk;
+	/* Release semantic of rcu_assign_pointer() ensures that
+	 * ctx->sk_proto is visible before changing sk->sk_prot in
+	 * update_sk_prot(), and prevents reading uninitialized value in
+	 * tls_{getsockopt, setsockopt}. Note that we do not need a
+	 * read barrier in tls_{getsockopt,setsockopt} as there is an
+	 * address dependency between sk->sk_proto->{getsockopt,setsockopt}
+	 * and ctx->sk_proto.
+	 */
+	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	return ctx;
 }
 
-- 
2.43.0


