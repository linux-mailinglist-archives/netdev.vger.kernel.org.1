Return-Path: <netdev+bounces-159076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C4A14531
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BA53A6996
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8F61DD0D6;
	Thu, 16 Jan 2025 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="od2ha1vm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8521DC98C
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069433; cv=none; b=epzbTGPEo+68+kIHEvQyyTWfedcvy/xTe/95Vz8VdVnUbqocnR5H72da/COtty5u7BHE8WCPy5aZPpXeapub20vTWTzPc3R67orVI97L20jJ01HEp+ksy1J0fknT3fVNU9vhL7MKOMJpra2AerAmGl7q3YBRIEMxMbmUwnsV188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069433; c=relaxed/simple;
	bh=RN9FRieTmgxqv0c+YKrWG+l7gQJLp/gap7HunHQoqkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZhI7iEzc/T4Ql9r4vCuzw1RBvfHILQFLSC9P7eSdVx0bAhWTshqyH8+ZzodNLLcJl2mMgjVlrcO0jLI0cijRzkVp7UyFZdUk6cSzZMDy+9ZPM2qFnAzGxnPVtSOef2mdgu4apy13Sol3TZyXjA4j8XAdysJn6JYvL1/FN4yzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=od2ha1vm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21654fdd5daso25847465ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1737069431; x=1737674231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BJhQIF+q/BdwFZrWY61E+04UcDJKhF4LPhTAqO37Wg=;
        b=od2ha1vmCSnx2GPPc2VFpwBis9SehbZGYgEg6D85/YltIu0aibdL6cNBMudEYe26bu
         lSpXNQWqzWFRzYELuLvWX0CI4yECAoWWdFHisB5IJr6YAZfKfe4+poXBL/iGjjAjDFAr
         jxvdlxgnRKbNe8xaDmSecDKkf4TlPxD1cpQ7PFHC0maccd1URseX3xXKRY+8q4IsgsBs
         X9Q8WyqcVCRMwk1L36ewZ/IzGRYI5qeEsUapwjx97KwZukrAQZ719vy9v0lzkYodxiRz
         JFHO1paHwBENbRoqAHROPdYMf+a84V2+NFuQklf6jBZI6pOk0/Yz1bt79xNNfZBE+Go+
         B5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069431; x=1737674231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BJhQIF+q/BdwFZrWY61E+04UcDJKhF4LPhTAqO37Wg=;
        b=p6SutnsOBbE+LbrgSBmdCYIemuwZhLtV6u5lk+lr0NBiEmAVwgelNy2bW2mOECbM/O
         k5PpfhsCe/RagumMkDkXgQbQdZ5cHOwwHBCR4P9EtksOYvlgay9ZO+f+QbGt4za0Mdpy
         uXZmKC8OdrvuKrn1Vy4j7jI52gAZXnZ+aSJw/pCbYjEaUgiY2meWV7SI+CPfWjv3gJAF
         lqhUttVVrQOwh0dsQtQd2hWBZpQ23dVveP3Dboc2sKDPdXbnl5fCXrga/cnnpYNJIy1N
         hZPs3QWg3xXHu5THgEmi0bwmkY5VM8PsfkI6Du21uJIF5NnW54zLr5Sit9VHIvd8qDNO
         d6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlEZ6sJTlhL2ivx3KlZ2VLJgbKnM7eOvZOUM11m65tS/yysQNdUU8ORYZb15k+ccbCzFtFet4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0SUEus+sSvzzWnd3+fQ8gxSOV2Mk1jbG2BK+INV5nWVDIvcG
	FjxvCjfF75N0qmpBpANSs8Kn9eWMIJVBCITSKHUXUcPSA0yhViDgbiU5D6wHDa8=
X-Gm-Gg: ASbGncvpa8fTjRX8+hNqFlBbjLlqEqSDF7oLVMukPeGKTkDuy6a3InPRvTcM07KFi60
	Oyh+XuvsUeZPv3Y/VvOFDB+kll9McPu5vS9T695BgiTdQY2WOgUAY4i9GBgPlBGlqY7eL2Wqv3M
	TW6HL9xf7k37V6G/cmRdavtje6G1Mqtw5lqQp2xAgJdZvbH1aDF933UqMGl9myGogIJGqxiRlDU
	ncoLAK9ya1ULLRdeukv7GrGb2SpQwzNmtjS+AbXRw==
X-Google-Smtp-Source: AGHT+IE+7rz3+FtLlOzp302hQQdyqhKM3dH46xWgJ2OQJD08zD8IPa2x4VJMSn0MPslS5ttQnIdHyQ==
X-Received: by 2002:a17:903:244d:b0:215:b5c6:9ed3 with SMTP id d9443c01a7336-21c353e4d1emr10178125ad.12.1737069431391;
        Thu, 16 Jan 2025 15:17:11 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac461sm4986015ad.112.2025.01.16.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:17:11 -0800 (PST)
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
Subject: [PATCH net-next v11 01/21] net: page_pool: don't cast mp param to devmem
Date: Thu, 16 Jan 2025 15:16:43 -0800
Message-ID: <20250116231704.2402455-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250116231704.2402455-1-dw@davidwei.uk>
References: <20250116231704.2402455-1-dw@davidwei.uk>
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
index 48335766c1bf..8d31c71bea1a 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -353,7 +353,7 @@ void page_pool_unlist(struct page_pool *pool)
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
-	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
+	void *binding = rxq->mp_params.mp_priv;
 	struct page_pool *pool;
 	struct hlist_node *n;
 
-- 
2.43.5


