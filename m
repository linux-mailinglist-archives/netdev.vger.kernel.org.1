Return-Path: <netdev+bounces-94111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A2E8BE262
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE5228C43F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DF1158D6D;
	Tue,  7 May 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWjsXC49"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A5E6CDB1;
	Tue,  7 May 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085832; cv=none; b=oPu9J7XrET+aHkR85gVwNtZ2pRQ9QKeM8yjnAo9hV52LEyjse6ucM7XKTrCd6+e5LbBrruSkhiYoOYmSewiaQu1Mc6APOV5TfK+nIvXarJtFniJ95nUn2Q+w6bHKWPbKr8qpXkzwBQOXlmqJPrKvfr0uyxQd1CBr/RFTudID/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085832; c=relaxed/simple;
	bh=Fdw3Uq6FEPRXufspQMbgG3TS8Lw8taqj/1zCK6girO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RNo345F7dW3X0IPDpfXLoD9COpCMqnw/eGSKaMnKXWblGQIkfgQ8L/F6+D8Gzzz3KoK1PaFyuKWQsLRO44vWiC+AGgwCY5d0xItVKI/wWfNcNUq5z5DUGoQAnXLwYXYxwhUjw7xWYN87Pr3C6c78pKsDe/8L2wmFINyd3MEWqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWjsXC49; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2e242b1df60so37348921fa.1;
        Tue, 07 May 2024 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715085829; x=1715690629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8GyKjDI+jVJzoUqihNVdIo6Wq2mpBnHDTxCj86/HJU=;
        b=BWjsXC49kuNvJiiE1c5BPKNckopzi9aW8nibdwhzN5x4i+VZz2t2ZZky2hMPXgkQyi
         PIK+UGL/W+2F9HKPXerAAW1hhgycsN70UgEJmoyJ90pLvNq678KGipT4cAm8cqwuKw4Q
         bXWs6Cliix1k033utyibEv65bYZVwWBFxDnzSe0/je9p3avnoYY9OxScAtucfDOZtF7A
         bgENjft3RajX68x4g7MOKZxboRGDaH+6QNjw13GVn3/3c19sIs9/MAZF7gt3WIWdD27g
         9kHKGYIpeEmPFgG7KH1R9JVhqfLqfAyko4yg21Rl15UCB7ZSo6ui+1t9wZz5UNG6KWUG
         sqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715085829; x=1715690629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8GyKjDI+jVJzoUqihNVdIo6Wq2mpBnHDTxCj86/HJU=;
        b=AWjr8YSM+mteuocwTBgm7XEvz9MBqGvZCkzzCE85tc5Fu6NMTRvDDNsYMYDpp+QRCz
         EvZWA7lA7ff7vjteeiWssriAWNenBAbguIFJeUCaxidmtt7SJGf0YUYnlXjWKHZOgYCR
         5S3ID565VJ2vA7JuHV0LR0Wl1XMi7jFUkJNtH9JL+7nCtLTKnB1j1o7T78bNlD/2a8sY
         K1JyAcTmn2mxllv6stK60fNacgmO/wZS98dWdM7nmN/gUhEiqacjoPmnN1fLH7KmCEEO
         7VPlRBcypzPHO0ep3pMyPCYKnk+vMWLSSFYYrHlqCNwO4BPNNe0OdTlsXCG9S9+i0d5S
         3P+A==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3h0Et+cIo8fPdQDsxbWCGzsOfYpTHwa6mNrxXg1AIfWeTClpPpfnO+ZqpePpT70jFnPl+5e8wqZhd0ogVJykA2M1wCTywT08jwMwsgw5aR+HG/3iT5Im76zAcvgFfpSs8uLs
X-Gm-Message-State: AOJu0YxBwEBL1Xncp2m8ZHSJVzTjDJnIXZHty+mtKYSkdtYZ7ZPJekkY
	HiVx/b9v/5DmQRAbCLFfXHweqaLW0O9UKonqGmAEGwBb6Vt3aTLN
X-Google-Smtp-Source: AGHT+IFHc+0z1+JCQJPFoXA3akwq8HNYDjHWGqqrWzoTJ1buSar8nUO1akR4p6xn3GSzCitM+ru0Bw==
X-Received: by 2002:a2e:a6a1:0:b0:2df:faf0:c5e4 with SMTP id q33-20020a2ea6a1000000b002dffaf0c5e4mr11218713lje.23.1715085828649;
        Tue, 07 May 2024 05:43:48 -0700 (PDT)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c1c0d00b0041be58cdf83sm19555059wms.4.2024.05.07.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:43:48 -0700 (PDT)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next v2 1/4] net: route: expire rt if the dst it holds is expired
Date: Tue,  7 May 2024 14:42:26 +0200
Message-Id: <20240507124229.446802-2-leone4fernando@gmail.com>
In-Reply-To: <20240507124229.446802-1-leone4fernando@gmail.com>
References: <20240507124229.446802-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rt_is_expired is used to verify that a cached dst is valid.
Currently, this function ignores the rt.dst->expires value.

Add a check to rt_is_expired that validates that the dst is not expired.

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 net/ipv4/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5fd54103174f..4e6b7a67f177 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -389,7 +389,8 @@ static inline int ip_rt_proc_init(void)
 
 static inline bool rt_is_expired(const struct rtable *rth)
 {
-	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev));
+	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev)) ||
+	       (rth->dst.expires && time_after(jiffies, rth->dst.expires));
 }
 
 void rt_cache_flush(struct net *net)
-- 
2.34.1


