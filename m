Return-Path: <netdev+bounces-156455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCC1A067CB
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EC216781C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB820468C;
	Wed,  8 Jan 2025 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="GJPHVQ7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A561A2396
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374026; cv=none; b=BhG5qGqyroPDUbmAH1cnDUY0S+9sU0n85dTjUV+QA5U04VAtOcHKQxiPVwnEndm1Z5/Ba64QtTA73craRLg0hRZ2DKnQgkn7cEGUWdnD3LtjHo1p4rwWO20vf8wUtRW3pOtswfvcreeEJHKQeGAIyCGYoPDOtA5PBG5Xi+yS1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374026; c=relaxed/simple;
	bh=VAoUMQEGqjLFxP/Xbi0jSPU2djzzUYFnXJh5BOeqN14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su/5ssjjfGWx2g8DCqBDWYRsgrj0OtDE9Tw3JWHOY51KPCgzuyhYDkFBGxV8Dg16CLsJ0l5v5dG41MxQw/D1Xu8In9MJ+/tiIH+vgRqnhml6uz4z+w0VpFfJwMEPgaEZc+UqgXWO/dSr28KTvoARyruGU5/KLS+TreS3iP8xAZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=GJPHVQ7i; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21654fdd5daso3390945ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 14:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736374024; x=1736978824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtABS+dmyoe0kdyaoBin9gQ/i6vhks1kSLsluvXpY8o=;
        b=GJPHVQ7inCWfegO88IZpUo3aoT5KH4s8ZEgdc753YYwwzzEWt6WnlSGNw0Xp4IDtWP
         P37Zz4GIf/qLi3dFEeohaIRVx/SRNTTDE84LD6mqdkXe9ERGOEsvW/QcwnR6UczhtNia
         r3XGz83qXoeG2mISTDahcwrwapk3KNNHPZdleolvN7cwO1lml8HH1cun0YLStEtCshC8
         ahVkXdAKaAXJlkKnYmebk3+JZWN8pjumiWJOH6uOOdvS4zfhN8djdA7LymwktMsBiFfx
         vAwQuXUp7JvDjgQxGAGrRNBm+y10gQnXp73Wh3AmRPCAo2qnMRovmEFBZEJtX+BkDHYh
         9LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374024; x=1736978824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtABS+dmyoe0kdyaoBin9gQ/i6vhks1kSLsluvXpY8o=;
        b=oL1PRdUCxONthZ5BZTjLrM+QY+/Wjt33w0AdozTlPEzF3gbZZON2FiAlQJcoN/ePGh
         FIpq4zDRADtQlLPsrfimz/dz/x6Id3ncJnErXGb4LBluhOOeRp/cHrJazb1onmiUd2tG
         JxSJbo40Ve3hAMIxwyT7L6F2dEOJfnVyk1ip+bWdSoRnN8FZ9OrKz+Rg2hSAq6FWSXuI
         3pyciY4fT/kKcetLk2DUrZkw8lmHuE9CuiMbwZV3RBpqa2gkmsWgqo1xONy7MKtGXJQy
         qMd7XZKBoYob6BVWWHDe1x7BwSfVS53rob2+jSYCXux9dZ/4m6kbk0KW7a46zBzYj+95
         TYUA==
X-Forwarded-Encrypted: i=1; AJvYcCVfgidxWWEQWwqJHvzAMbSHm/IB8nGjdUSUpi8AZ479heEnMOGMnXgNIbf1F/tNCDbotp6pke0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxAvGNYJReOnaV+dGqSANtLCzK+zRNHpohk0nVJe0DFM4SYWY
	Q2kQhSApWAO4xtxBW0NTqzdYt+0ybuSPNNPQFpuT7B6MrjioslbtjmVRLn1USkc=
X-Gm-Gg: ASbGncuh0nSSSPnHJ/IhZnlApvYGvTQdK90UpzQGlFyGicTlIc8jxSGokHxAeH3p5xX
	alExlj0nCTrta37YhrgwDHOACoGBOdbLczcePkjv0hlIjj3MYgd4pJjpdqDJrfe2sCIzj82P9LW
	aG0xCMT2sG9vi53kfaITxwZzExKXbe+Emthg7GwJP5M/R73hDZp39jdYwyquXWKjHdHSBsuRaUJ
	KTVt9Hs9BYAdaWMDiwriT4AI6ofcynPQrQJkjrD
X-Google-Smtp-Source: AGHT+IGDDgScB0l1nhJ5EZNjTq3i4T3SvpWHOaO5xF5nuTlOcFaaBYfOnCUs22uz9e2PIY798zrLKA==
X-Received: by 2002:a05:6a20:c88d:b0:1dc:e8d:c8f0 with SMTP id adf61e73a8af0-1e88d0bfd48mr8336038637.29.1736374024131;
        Wed, 08 Jan 2025 14:07:04 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbafesm36622053b3a.128.2025.01.08.14.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:07:03 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v10 01/22] net: make page_pool_ref_netmem work with net iovs
Date: Wed,  8 Jan 2025 14:06:22 -0800
Message-ID: <20250108220644.3528845-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108220644.3528845-1-dw@davidwei.uk>
References: <20250108220644.3528845-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

page_pool_ref_netmem() should work with either netmem representation, but
currently it casts to a page with netmem_to_page(), which will fail with
net iovs. Use netmem_get_pp_ref_count_ref() instead.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 543f54fa3020..582a3d00cbe2 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -307,7 +307,7 @@ static inline long page_pool_unref_page(struct page *page, long nr)
 
 static inline void page_pool_ref_netmem(netmem_ref netmem)
 {
-	atomic_long_inc(&netmem_to_page(netmem)->pp_ref_count);
+	atomic_long_inc(netmem_get_pp_ref_count_ref(netmem));
 }
 
 static inline void page_pool_ref_page(struct page *page)
-- 
2.43.5


