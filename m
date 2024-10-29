Return-Path: <netdev+bounces-140161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D0F9B5663
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A987C1C224B9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E34520C02F;
	Tue, 29 Oct 2024 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Zg+0VQP7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719020B21F
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243167; cv=none; b=I16Pb2bjvF09BLAI3bL2DL9mlYC17Tb2skLh4YVKNsqzwdNNkm4po4RX+FjxohyPyPcmvNCV4KZ2t0wljNQk7LuX9EGo2Dy2oT26L4zZaqyNMsw+aDNHufzZgxtK9CnYgVZnjh60vANhaqsFf+c9ridPxAmu8tZYNq5oWR0ki7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243167; c=relaxed/simple;
	bh=N3Lp9/YMutyVAvs4ge9B26lNnGjZAtdOVSMB+PgeaiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1r1/8kbYMfCXzUQ7AVi75YfssBIqd07KKS3tCWAYETbT+URNhLyQ9WGQ7lBrMYSb3JIJVLMRI1NtRCqrc0PoecoM3FFujYWOcxNu0v1+e2ogqmozzYj0rcaIPU76iBLv6GZ94CN9cpkuWZVf7j3LoL0N/5WlLQt3PggW43ZWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Zg+0VQP7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-210e5369b7dso23665775ad.3
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1730243165; x=1730847965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqnj2vEyFSNWAQ9NLMcT3cBERALcNmYBRjCTByCN/C4=;
        b=Zg+0VQP7GcmqvgPBmT3+8KhUGQXcdqTa449/quuz+EvL8I5SYJfh7sGVt0lcj4xG/o
         0Hr8elUzmyYgVsqMX3UK+J++TQtgn4Q87JxcwN5+CizclUK+owJqLK737oqy0Ic/WKMl
         8VIv/+Un3SdGpuIBxYqg8lslGarXDZbHBbNAFHp5anzxewmAGOvcYKXwKY08CV1s//Ig
         KN+uwQd9h6kr9U1UBmEfdPeJjZa7G+mLz4sr2c1ozpluQfY96UViX8P2EJJzxPAAzx1c
         l45f9oeF97wQdNoKI6qH67xKAVws+TcBSuT0LAOydG+RBIng2As/kI7dD1HWDI8GEpeP
         joog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730243165; x=1730847965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqnj2vEyFSNWAQ9NLMcT3cBERALcNmYBRjCTByCN/C4=;
        b=I50ZPngaoYVnE3leeT5I4WdYKqxUMoQD5gp7ByEgX9xNh/wZIXXunpse7wlbsr5ZFf
         T5Y/pEEDRj0qvM4LLZB98CSeX44x/x8/zBIlDhMDMGQADgX/GgFXBDgSnrRRDieVl4kc
         1ekP6fZun7gKqVVrUDuoTY26CjJjqLoPUYzevlIIHBxq+I8LH6l5C8PqrfliVOOUwEkB
         SvpjIkcHC3wXsvNuxZHDJ5nL/Wqkso2gUeFYjIhLGDBflLCN/sdfbzodWFyvc5mBq3nN
         JBDRTQ+NDu2DFgEQ21UkQRdfEOBMFdGdk92Cab6cDFKmC+6YyEm0VuG1jEt5HbgWgY0j
         sSQw==
X-Forwarded-Encrypted: i=1; AJvYcCVDjSYiX324yUFxfXZJ6741wC99Li9zZ+UD0xTe8zVdTNyBIxXCYxhBJ7NDnXogWjQJ20JTZEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRulm3nggtD8iExaIhJEBT9FAY55EvDDaXKDVqlplvGZZI3kq
	612JQNCg2ncK+3BKbwMLx/wmEUIWFbP9yTJM09VLAoYyUnDbNd+JcXFbHkFpiOU=
X-Google-Smtp-Source: AGHT+IHcH5ACFreh+o5tc6t0ScpIrlXOC/ZFVAy3cOvOl9fhMlFQ0xiHDAR0tY+5UDsiwXRAOk5/Iw==
X-Received: by 2002:a17:903:2b04:b0:20c:a175:1942 with SMTP id d9443c01a7336-210c6c032cfmr169901245ad.24.1730243164839;
        Tue, 29 Oct 2024 16:06:04 -0700 (PDT)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf445d5sm71293115ad.42.2024.10.29.16.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:06:04 -0700 (PDT)
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
Subject: [PATCH v7 05/15] net: page_pool: add ->scrub mem provider callback
Date: Tue, 29 Oct 2024 16:05:08 -0700
Message-ID: <20241029230521.2385749-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029230521.2385749-1-dw@davidwei.uk>
References: <20241029230521.2385749-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Some page pool memory providers like io_uring need to catch the point
when the page pool is asked to be destroyed. ->destroy is not enough
because it relies on the page pool to wait for its buffers first, but
for that to happen a provider might need to react, e.g. to collect all
buffers that are currently given to the user space.

Add a new provider's scrub callback serving the purpose and called off
the pp's generic (cold) scrubbing path, i.e. page_pool_scrub().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/types.h | 1 +
 net/core/page_pool.c          | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 8a35fe474adb..fd0376ad0d26 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -157,6 +157,7 @@ struct memory_provider_ops {
 	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
 	int (*init)(struct page_pool *pool);
 	void (*destroy)(struct page_pool *pool);
+	void (*scrub)(struct page_pool *pool);
 };
 
 struct pp_memory_provider_params {
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index c21c5b9edc68..9a675e16e6a4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1038,6 +1038,9 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 
 static void page_pool_scrub(struct page_pool *pool)
 {
+	if (pool->mp_ops && pool->mp_ops->scrub)
+		pool->mp_ops->scrub(pool);
+
 	page_pool_empty_alloc_cache_once(pool);
 	pool->destroy_cnt++;
 
-- 
2.43.5


