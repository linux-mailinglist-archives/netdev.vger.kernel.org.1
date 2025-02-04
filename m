Return-Path: <netdev+bounces-162758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B6A27DE1
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EE516733D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A551C21ADBC;
	Tue,  4 Feb 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Mf0wS6//"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538321ADB4
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706187; cv=none; b=r5ALKOBeMpJ/wZwdiLSbBehhetbidb7h2V7Ccpkdoa5vFYCW1guD/4ZIsUKojn8ovQpJ+Fe8tbEfoar2YGZynSSW9Ii44sazxUawTo9WMmM6qr8Y/2tyUV0LjjsAq1JIjjg1wBhz2pSq9aqaCowV+13BZZ1raulXN6PfniCreeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706187; c=relaxed/simple;
	bh=MXm9cNzcNAKRwy4sqAWVUwxI2/xHrAmidqJORw4XcS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfVNXmIa0M0AaUuxHQ4zGqbA2kNDVO0iTqjZhFeccXaUA63zUDOmVjY/ebU+2sDnTxfUs5Y5YPhj5aYcoBLbkeX0sUMY0Q+pj1aoTk6lC7CVzMQ5QqIZtWUhAM0TojuqakBVDE3kP4anuMvAIx0dar5U8nXR+guouqUGY9lnoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Mf0wS6//; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f0c4275a1so14426155ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706185; x=1739310985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9LdqNR7jRyKbZmm3+EwvlUzO8DkJ2xrN0yhlIHcgzw=;
        b=Mf0wS6//sPc1MQQ9J+8pbXPlOHmHVGcm3xOfv15CglB4yKV57NooF3CtnfV8/OLIZl
         Fh/RM35Z7+R/RIBddgDpTlhTB3o3DzM8A/PAasEI6G4jHIPbqwN5fJiOnX0XnixQLzOs
         qIZpEXeszrCe80njWQXm+ExptviNRxPY03VRhFGwLYX0pO1Frb8h2QDcl2J8TPvulcFs
         kWXrOFvqKwUk3vXE7u0epPNjP2Y81JqgLqeQQJNaOkGeb+eJ64J9COLq9GPSBGitajlI
         xiI6uhdIOae4yWVjFMODHQgv1IaXkF96DocSQ2Oj6JMsz8gts5MZKuO1g22SVLMqOyX+
         rXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706185; x=1739310985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9LdqNR7jRyKbZmm3+EwvlUzO8DkJ2xrN0yhlIHcgzw=;
        b=dDD4MwnRuYcKo36EKMUX2tPJY9Yku3vQwvpEUk4QOGXon67TiQu8o3W34DSoJ05HzX
         MrDumCPtJKrfHQ6BwSNQ5gzhvr/O3CkTpyBMZB7uqCaIy2Dk4WMK7GPz05B/gMOLK5MW
         6c7ZH/7QO5mcZnj7WPvFN1HMCWGfkht2YoGzKFtm9BqeTK1KNXySP5r/xBTzWxhIfz2n
         peZ1OGWkwsISgfnpSruUF+VsPHoTeW2TQrZtlicQwUR3E/K++L8KiH1DuqxLjz3kUCdX
         O4uozLY2bl2bKdo5chbNG1/cP+NULGFYINhVZxu01B66FrYFZrbkJcF6Vl0vG77qMH30
         o2DA==
X-Gm-Message-State: AOJu0YxxupgJQAeswQybbck+oyrHoUx04pSpEkECaSOgUZuWQO8zn5wf
	iEcUojiI/W/D4zjVDrh767wfSdpD/FGEm/udfFUYCGvs3gAQOD9tVian+lJ2TbPiVaTqJ0um4Tm
	a
X-Gm-Gg: ASbGncvBcFsoyJ/PTFz/mHrEjTZso7T7OZMys0gvaDOkgVS9MsMYz+nPAIq50UOadLx
	RUQiy63Not5Qf1BJStgGnhE52OPqgPStLVd0KQtEitO1/5ZBbKlj+Qc1UmvceWuPkWHyZLnc0q8
	NMDn+gQ8YS2z3HGWG2m1WgRs1XUrQEpEHRzF9lfDEFBy8KVRjoK1RTpogGgA+V35TOREPhlgEF2
	Vaxohk/ZlUQuNoNIaLVFw56iD7OHbffvGpEICp51REii5BcJH1sswibk5xYD+ZxwamujMEBo/8=
X-Google-Smtp-Source: AGHT+IECgOtFsPT2Y4kChST0pUJKzsOLP/lThVWBw6QmlrKvi5S3KvwH7Ikz9NQkERFo7gFIZI8gFg==
X-Received: by 2002:a05:6a00:2181:b0:72a:bc6a:3a88 with SMTP id d2e1a72fcca58-73035214d2fmr560465b3a.22.1738706185337;
        Tue, 04 Feb 2025 13:56:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba322sm11049926b3a.110.2025.02.04.13.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:25 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
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
Subject: [PATCH net-next v13 01/10] net: page_pool: don't cast mp param to devmem
Date: Tue,  4 Feb 2025 13:56:12 -0800
Message-ID: <20250204215622.695511-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
References: <20250204215622.695511-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

page_pool_check_memory_provider() is a generic path and shouldn't assume
anything about the actual type of the memory provider argument. It's
fine while devmem is the only provider, but cast away the devmem
specific binding types to avoid confusion.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/page_pool_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 6677e0c2e256..d5e214c30c31 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -356,7 +356,7 @@ void page_pool_unlist(struct page_pool *pool)
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
-	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
+	void *binding = rxq->mp_params.mp_priv;
 	struct page_pool *pool;
 	struct hlist_node *n;
 
-- 
2.43.5


