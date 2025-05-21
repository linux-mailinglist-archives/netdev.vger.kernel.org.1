Return-Path: <netdev+bounces-192299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15ADABF4FD
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508613BB812
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24A26E176;
	Wed, 21 May 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8YPmsb7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13E26E145
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832330; cv=none; b=S4BgG2OGpNvo4uRV78GSlXlx5qNpM6qIutQOLPgAmwmIcV7RwYkqxml3enV1WTxX7H+xlEFr4KAebDKpI1wkeyenz7aZVaT2F3Nk+UzXDZjxO6NGAfqmiyBjRZuzdZcOu8lK3aV9s2CO+N0T+DgbT6gUX3zIXzk7tTYkwwoP0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832330; c=relaxed/simple;
	bh=sET+JP30XH2vndFawVkJ+lo/9fQG9u6Fq9nQGRLbOgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lb++EYB+fTP85pwh1N7YWAkoaXcXexaoRkOMM/WcqrLmkg+eVeUZ4w402PzFvurJ+NHFRAaQ1ZHHuNINBZCzhySDPrhM9SF8kkuiWu2aM0pj+XZkbYxFdsWxiVJoKqfyiE0l6M+Ti7V1jFfyF9JAI9FW3LI0DJnCNA2FkWAL0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8YPmsb7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-afc857702d1so5943829a12.3
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 05:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747832328; x=1748437128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNtWIFfA6Jkt69A7oEbtGtcZO8oSJxs0GTIB+9lBpFU=;
        b=b8YPmsb7EJ7tPo0hj2aUm80Q3F4mFUZv5StfFsFxYcGWonDZBnU0EKzBBKC3TwckoI
         BgKnBCWuM0ypXwY6/LXbGH7ZV5aG/5rUxRKhsZQo9CBbtKBPSNkzAuzTk9OClSNGJBHQ
         EUOcMriDtcEyamDjji+GtYLLt+mODe18vjnawZRcb5a1xLPXhmfOVSrCndPobnTthhRg
         npseT/wmRFkfn3LbkpvgEh3dwV2azYU8Bytb0uDeWL8uh4FX/9PXdvzklAF5xU08bgjF
         xi90SXWvGNWSZGZg/Jd+neeryCRhzZoF0wxEZvagp2ES3mxtNzggfuXEqP8oUay0FiFt
         fyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747832328; x=1748437128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNtWIFfA6Jkt69A7oEbtGtcZO8oSJxs0GTIB+9lBpFU=;
        b=gE3kOwnIMSKmTcA26oGgRiEH0sh5Qp7fXjwXrA4dRfhV12RVUNVHVbEds/ITk0WqSa
         e+Mz7IeE8Y05pXWjDokHxbQeiDak1cdTpjM+ar0zjjaXZQ8YQxt1nn+/DtPooA9W15ev
         LpOqvAnPpuSAhSvoDfZee/iZ84upeBLLixoHRz2huqzTk91/mp140HxyQmXkl0oCDcsa
         y6KY5FEO8J+3D9s1t2Fr/qX4M2wxyA4mOs4vm7AXlk4XiCsFnBgkR0tyOCOupNQTXS83
         8usF04iAGsy0cJtqNrirYN8RvstATaTIu5DJaWWcWXpxA4OdwYWwDVQ/g1UKgvZLlJr1
         rYOw==
X-Gm-Message-State: AOJu0YymunqloVgZmRPjcWQzdcPXhq/Kp11XB+20GGRVfz8erz91lsp3
	xTKGoaQLFCcEObH1G7U0mVLIcCQM1mHSWo8i8iwssD8XaLVpv+PM9uFhitH61wFV
X-Gm-Gg: ASbGncuWpi9U4hugfi3VAzI3rsRzBwTEl+qt1FWvYVIO9jpiWgrmvNeI7VaKCGBDG4c
	uKdJf/VTCi3/CNdmZLorJgr89JwyTzARc5dgrIuVtPnkMFVqeWZ3DEo/XNbqJqScBQQiYFG6bQt
	ej34kRSAcm3VUJjYGGXZVEXKL6dnL4SqaZR4aCN3s/tBbX0gDx5x+ZhF0l9B29DkPlsFxo9Idw/
	HzZxUqcEh6OuuBB3gqS62nseJBs0rEi7AhH649qbvN3ojlnum9gxgk20JLxRU5QzoaNUB1vZ5wb
	QKRHdbL4cD4Gpbp405z+PrQhP3Ox8El5RxkkobNhaMYPv4QVOzLITaNZORs2fX/aCf1DYs4xU2f
	TMg==
X-Google-Smtp-Source: AGHT+IGQQQGuYJiALi5gz/+8jYGdGNJ4so/Xs3F8HwSfzxgmm6P9c+MLdUwEXbM/BarlSWFM71GtQA==
X-Received: by 2002:a17:903:2342:b0:223:90ec:80f0 with SMTP id d9443c01a7336-231d4516a4fmr317534985ad.22.1747832327755;
        Wed, 21 May 2025 05:58:47 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adba85sm92760775ad.73.2025.05.21.05.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 05:58:47 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: netdev@vger.kernel.org
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH v4] net: rds: Replace strncpy with strscpy in connection setup
Date: Wed, 21 May 2025 18:28:36 +0530
Message-Id: <20250521125836.3507369-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521055417.3091176-1-shankari.ak0208@gmail.com>
References: <20250521055417.3091176-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaces strncpy() with strscpy_pad() for copying the transport field.
Unlike strscpy(), strscpy_pad() ensures the destination buffer is fully padded with null bytes, avoiding garbage data.
This is safer for struct copies and comparisons. As strncpy() is deprecated (see: kernel.org/doc/html/latest/process/deprecated.html#strcpy),
this change improves correctness and adheres to kernel guidelines for safe, bounded string handling.

Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 net/rds/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..4689062db84f 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -749,7 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo->laddr = conn->c_laddr.s6_addr32[3];
 	cinfo->faddr = conn->c_faddr.s6_addr32[3];
 	cinfo->tos = conn->c_tos;
-	strncpy(cinfo->transport, conn->c_trans->t_name,
+	strscpy_pad(cinfo->transport, conn->c_trans->t_name,
 		sizeof(cinfo->transport));
 	cinfo->flags = 0;
 
@@ -775,7 +775,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
 	cinfo6->laddr = conn->c_laddr;
 	cinfo6->faddr = conn->c_faddr;
-	strncpy(cinfo6->transport, conn->c_trans->t_name,
+	strscpy_pad(cinfo6->transport, conn->c_trans->t_name,
 		sizeof(cinfo6->transport));
 	cinfo6->flags = 0;
 
-- 
2.34.1


