Return-Path: <netdev+bounces-245034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E76CC5AE5
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73BD93012DC8
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 01:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BEF1E412A;
	Wed, 17 Dec 2025 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO6/Qka3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAA18CC13
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765934155; cv=none; b=MmhJ1mgBfVXsHXJJU5IkbcF1EXbmR4CKi6vP9wbQ6kpIt0a4Be8zRwr2WHRWPQusG7SVqLjqifWQgZYJ2HmB9dYwEcafHRZt48fn0HG0PMmQU5fGAEsBWBNM6GeNs3dWMNN7iAAYbbUEJXQoSHEWXOnue/1C2HgfLM5EwSBiLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765934155; c=relaxed/simple;
	bh=5NqdR0KahKnnPoX+6MD1dyWNtJM/5gJGED+S8VpfHBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tfJvPJeJGtfkD7t33b3GCXMx9R7VNY/YToVPkymtE3DbTyfMh9ne26dSMSa+x5uNEXZ3viDnvfSOeZQDDfmFo4aKb8TYMModWwC91DAJR6JIMxHKfsdRAyUbbq62x7k3c5Ov+tRJm2bFjd5ae7Vh7GSxBd3s+/zlFmkWu/1ChBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO6/Qka3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29e619586deso7943775ad.3
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 17:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765934153; x=1766538953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAPpQXLFQFMqUELx3ET/17MTkGzZAB2Bx7aG6WIuk/g=;
        b=mO6/Qka3JfRVoiIP16g7khJ4iOnCKB/oZZ19aZYjUBxyv3+6S5fIfaF5/bglcGYFE4
         qBpobkRyrpZWRAw5M4zegE5rfVMVNE3nEWDoLKTe8KSoQD79CYUkGOzDF5W9BuECBCV7
         0mU//LiPmsGKObdNr6/BiN0Ct58+RPfSo1p6LyRDdFMPCwEB3vw02uPa3oJPGLlDIof1
         kN9xvJzHvmYQBszGGH1e9Ok+Qo82hStTZx+jS6ADDIlIFrzlvwgRPRxa1W5f2gxj8uIs
         zMb6z4zyw5etHlJQZ+ahoDI5Ne0dk8Z3aNq2jJb3kUkvf4cByjBMQTeeTYk88vbPlUgM
         rMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765934153; x=1766538953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAPpQXLFQFMqUELx3ET/17MTkGzZAB2Bx7aG6WIuk/g=;
        b=ApJx6qw7pG/tcbr5RrEHX6Os/hHxEsRnt/+cjmKzY9eO9PIQJnDdxPgF4aa8LBDYbg
         D+t7wg9RPv2PbpLzD2LxL2QkzrnCUyD3z9MP7gMol+IIh3eu/4ZeIX09WIyqbTU9PU7/
         91a4Waxz0WaeljaSnfhiO8ub8WYLCJB2USWrWXNzZ3TxKAIqpWHwKCOSfjdKjscBp3ux
         WGSR/36aKYAipQi130uDaropesDF16twa3hQntOK/xxnaxeCbRZb7m9A6BAly2xi+dmw
         NGd3GA04BAoE/RhJhJf06emjylZvdigCa258w/t6VRsyW1ik3cDnxNLlqK1QggZ5v72U
         yDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+qNgZsw9i/8Yst5pau42aNNCmHtrUwezsU27h/5kISI0NQhET72pVmVGWmWTaeXghuY/Dnww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwF0xEQeaZqBv0LTJXgkclHHpJwZuoncKLvkF5QEP0TVdN3SyQ
	Z3EfKByW9gYZrM7VSIrQe/O5NYpVugnSYn2+wveTuPz3sOWWEw+hLIIv
X-Gm-Gg: AY/fxX5HGszJCtu7ETBySvYExp5Nqxb6f7ioC0OKwp2W+Ptg8f+ksCYGRCsDB8W6xIl
	xtVqv38ketczlzXQwSn/yoKvegqABJuIYaaN9Iw+YktpyrW5XpnEvEOulUM7YS9l3cZdlx+QTiy
	PJGmhzFsx7Pay2R7+MWz5mTsAGL5nMvY2losgmLD/Gx245bJ7ibIduBrxA1eTKWWJoMoKIqWPjI
	YN17ycQuoSKzMWeSeX7pJpCyH69KwXCECKzVIA2tDpLjngv3Pom0cU9+i0K2XsK7BvoKskMIPbn
	g0Hpdfnp33l4e2Wov7FQ8OEzYmMrmOt7udvWF45C0VYubH7r3ou91fZGayOoGhl640O1RAXqFZM
	Mlvd6sXul13vF3ao1Y2+eNrrD8jrpis6RNm+i65tkC4AuzYSGXXRlj0W5rO6gMiSbJ/USZ4xYtG
	yhjA+t7S6OjiOl4QmL+JTlQCbaF/Y92zLxnYw+3+hDNmWgMPe/1ItGws3M484BwN4WPqEbxZZO
X-Google-Smtp-Source: AGHT+IFZrDf9vqRQ/g6EePpa5uBEVkMmx0VjSy5xkIfuhbvdzQMUtH3Bh0xKcFCQL8LtdAKwzvNqvQ==
X-Received: by 2002:a17:90b:3f0e:b0:349:2cdd:434a with SMTP id 98e67ed59e1d1-34abd7602f0mr12147245a91.5.1765934153401;
        Tue, 16 Dec 2025 17:15:53 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cfdc61cecsm641012a91.9.2025.12.16.17.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 17:15:52 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH] nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()
Date: Wed, 17 Dec 2025 10:15:38 +0900
Message-Id: <20251217011538.16029-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <307c2afe-8e8e-4edf-b6d1-1056fe8949f6@kernel.org>
References: <307c2afe-8e8e-4edf-b6d1-1056fe8949f6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().

In nfc_llcp_recv_hdlc(), the LLCP_CLOSED branch releases the socket lock and
drops the reference, but the function continues to operate on llcp_sock/sk and
later runs release_sock() and nfc_llcp_sock_put() again on the common exit path.

Return immediately after the CLOSED cleanup to avoid refcount/lock imbalance and
to avoid using the socket after dropping the reference.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index beeb3b4d2..be01ec9f4 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1089,6 +1089,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
-- 
2.34.1


