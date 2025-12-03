Return-Path: <netdev+bounces-243404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D0C9F1C7
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 14:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDF793480EA
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA4D2ED846;
	Wed,  3 Dec 2025 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnhFXwuN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0E1C84BB
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768069; cv=none; b=dnQnvUAGD8qp9F9KJr13r61VJhre/574SRDf2/gN7t3NQtGtBy3JGPeIzWC/P82SP+dU8HiuSguxsEgME6gMeVlwSSE9AQpHzoQAJXrFUyzPV63SlYnzbBb9QnT7MBKxFJKL/NbOZKTQ3pgLgLE8Z5kU7dlwGHpH0kyfBIm2St0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768069; c=relaxed/simple;
	bh=kXb9EXDI0w6rlp0MQqZEPQpBKY6yd2TMS5PpRbp7jfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhMLTilqsnDfc4gpH3HVjuxDve9RfGnJfZsJsd2WrjJ1g7m6Upn2N5ZrO9o27PB9exXib7aAxHQlKqGBp/QSeH2ZiUNtHFiOd37fYR1PyF3BAjt1/7eMx/vQm6wypH9wVsGqT6c6QnRCjDp4jEo3IvuSYviv9T+6RQ2ndLYyx60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnhFXwuN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2ce8681eso3112615f8f.0
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 05:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764768066; x=1765372866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixub8XFHVSgu8xKWFM7EAHafTMzwTmdJy3P9B7hAoq0=;
        b=NnhFXwuNmhwLaN+lis/q9ciFf+mpYG8Esrv7wdUUghPCdlZMQTVqFgqtKAl0sXURda
         1raQ392fPlFy89izTsUl5z7IvKpVeJoYiOi6LW3NS5c1nuYMMZ+rWIhn8DB8XoN/hSNT
         DBrFh87vwZm6d5Cd9TxrJy8GiL4EgckwLWBfVT7dhrczMXYxwpmSCT8XVZbgzinbv1gC
         xrJH8nCQksVQI12LdbrB81bNc9K3jeRwfvFh6ioehKcwXiJYp/HbvtgK4iO9CbNrOz2D
         p9y2je/P13lreRYmENJWqDdygXhI5cjv0U2FA3Mb6FfAgTOTNcGwou00/lLu9viWGJWo
         q04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764768066; x=1765372866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ixub8XFHVSgu8xKWFM7EAHafTMzwTmdJy3P9B7hAoq0=;
        b=kqBKUEm+jI6i9oCHBG/FdLjI6774gn4ZRVpvexc8biXU7TsfTkmVabullBlYkBPY6B
         CQQ8vvCQK31zzMxO+Za9Ohs/MTrCTpq8JlWW4qFIcPPiAxOtYGZNYw6+KbLvv/SHcf65
         QiHWDFD4otX+/As/ZKuGxtn6bREALo9pi5vwZtt5wx6OfmpwHOd56LP7W9Jx5vZZrwEa
         havNvGBU1K+iQtpQuoi3VDIaACn0pcmmfPmK+HVUOUZfqTgnxhc+fahflkuN6dQ9hBhD
         DGh5NATYRdkRErjHGxwMOzye7Ep8/BrqYLhi6EvsSCE14thqt//y8SOnT3GCgjcTfzSI
         xY9A==
X-Forwarded-Encrypted: i=1; AJvYcCVj/jeMWrCKYf/T3qN2PJJLTsrI7tc56t1cb4FUKuTYRIkLNaSWOhBQccemL6Jc0PNRFUuTdmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztL8Auceiz8hKOvAsSy3szSmLJ6Z3ZVjFsOthwGIDTtyPuR4v1
	TNpLVwSUg6JxDYfjckkd/QSp8pcaeAXT7NATEYZlOgUJ7g22TGcZVT3kYlc8bhTh2TE=
X-Gm-Gg: ASbGncuigyCsX/WZgelavJqRXZck6A1LqZkoCnrsJpqXHxGZfhM2WiMU8HHrf/1Sk5c
	G0r4+5zQRRX+ZUXYv8+UWAbYiP/p3POwC2WNKTYLqlSr97e0fzlZgXrbVIonUl0C9AX+fRcnQ4U
	sXr8veS43307lbC5ItvOZPCvWqBm1FxEyhr8h6psv3eQGpLikytIcWprIKgozg3/9h6LZezh6+6
	wwvO5kyqubZrNdYvHp2EEr8ux3NFxHzp8WLAam0RS4j2A8yDr8qp7eAakuXusdehlxC11INtBDq
	nRHZsnhrUVaLWiSCwek92yycPoNtbP9Pkj7Z4nsvkM8R/Mo9oCh1aXvlt94cd3X10O4jGgOKYh+
	wjJ7lwtowlSQj/JxIK/IV/G5NORy0pbUJ9e+le8u90ykUtIy8Sgt1G6FMGJFBM42QGPb47cCmDJ
	4rQfhtMrXOAubinYCa3SW5OjV/v+U5BL3+qcpMPvbXOOBS6xOHoJyoVAmp
X-Google-Smtp-Source: AGHT+IE4AeJ6aS7oH/n2k7/ppuOBNMDGhlZaf+A0cMgyYi7/c9LKJwGBVEPpcxhM5VTn/A1CjTFe7g==
X-Received: by 2002:a5d:588b:0:b0:42b:3746:3b85 with SMTP id ffacd0b85a97d-42f731c2ea0mr2446622f8f.45.1764768066307;
        Wed, 03 Dec 2025 05:21:06 -0800 (PST)
Received: from osboxes.. (108.228-30-62.static.virginmediabusiness.co.uk. [62.30.228.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3022sm39923141f8f.4.2025.12.03.05.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 05:21:05 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH] netfilter: nft_set_hash: fix potential NULL deref in nft_rhash_deactivate
Date: Wed,  3 Dec 2025 13:20:44 +0000
Message-ID: <20251203132044.57242-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nft_rhash_deactivate(), rhashtable_lookup() may return NULL when the
set element is not found, but the function unconditionally returns
&he->priv.

Dereferencing a member of a NULL pointer is undefined behavior in C.
Although the current struct layout places 'priv' at offset 0 (making
this behave like returning NULL), this is fragile and relies on
implementation details.

Make the NULL case explicit and return NULL when the lookup fails.

Fixes: c07b3b683133 ("netfilter: nf_tables: add rhashtable set backend")

Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 net/netfilter/nft_set_hash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index ba01ce75d6de..9ff25ebf93cf 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -231,6 +231,9 @@ nft_rhash_deactivate(const struct net *net, const struct nft_set *set,
 
 	rcu_read_unlock();
 
+	if (!he)
+		return NULL;
+
 	return &he->priv;
 }
 
-- 
2.45.2


