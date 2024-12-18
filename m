Return-Path: <netdev+bounces-152757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6CD9F5BBC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DF11885C26
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED22450EE;
	Wed, 18 Dec 2024 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Avswi1MT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51083597F
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482283; cv=none; b=rhhuyUxxzSuA6Jyo8jnI0ZkcBMBlmEkj0dO/o7WRuEnuwhwxLbVcHnVsi6oCbTH+/Axm2TxalbUQl35GEUyqBEzI6LnuWciuhVDwH98cNl9pBw4FyUhf6UTVL5SXRmaqgXsJ9F1r0Vv2tpphZM89KQiKBQ2a0nV3mQgB+Zqa95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482283; c=relaxed/simple;
	bh=135g8sWdi14q9q8Itt2VZQPm7R0gFcz1ULHZpEn4dmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVUKyb4u1wGmWh4ml+aD+zmdeXFfGUukcr0CTZ1WR5V/Rb1/RI3seP7KSdVreIg9g2i6k+1iwwYSWrPcMXO6xFktmgZ+PUTLCbcRE1NyV9yIAhkxp4kcrHjT26c/HXqI4OC2jflMG7i28PQhEREGn4BBLJw2jbgAvVmd0c+qEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Avswi1MT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725ee27e905so7524906b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734482281; x=1735087081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ73wFKVt12qccWHG7cPPzOfiVyAwI1MB/XTBNYCLeg=;
        b=Avswi1MT3cwCmp8ZmdnQvv6eSNnUtLFSxWtgryWPBUBQv3fnmraImOQdxuyzCx8zqb
         cDmVA1irUZ5SNO5S+VRr+O3Xb5d6RL4rXN06t+iPlPR3LbHlhwc5cR4PvAwYAXVCpXrQ
         Fp9gUV3jy5EgVYLp/fUo66PerxeZUctk6SbpUkH2KVeig71w0VR1zllAWmrd26KkUuUr
         a8ldijZFoD4c983kq4Vfk6FULYoe/Fkltj27Ig/vIhC45NlmaGqVmu72a6KTXEUYBvXS
         dkceQTUVzFcbd1CHllKp2qRfQOk7JsFGveFbsJmFlHxk5h3p6yKEkJZe6lA/u/xHIPkg
         Bacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482281; x=1735087081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ73wFKVt12qccWHG7cPPzOfiVyAwI1MB/XTBNYCLeg=;
        b=NJ0PYJSHnH7Sim7wkwpPqQJvHhH6Xuen1OF5Rqb9ewOv1GI+GLNcvm52ESVCcUVlDC
         ZR4Eb9K5UN2ig9r2SnJ1lZoiEgVb29+1akQ2bwuTUbO+rht6ucqjCLa0+H0VR0QIwrmR
         8ZjhyMsWPtyx23Pj6EAw3CbpLHsE8bqmTfTBvdw/SUApt4cpH7Go3oS/QnPi2EqMdJeK
         LPKyshkvdBcZTjxPneDzHwMwx6/7n0h58SaeaEsexiM6uEuVNc3xAoQgg9tgSbf1vYC0
         F5K0O4t3wEaLOY11sKKKQToVPqSjItl5M6GXF6Ed11DOimyJgm0vSYzACgjtyCY1RbPK
         +T5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaoqZriTlxFoOxjcMx3sj8ebdN3su3IgukEZxpvY5M9Z4XuIxH+I+BGqeByvYdkw8S8Iy8Yv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnxwxhAv6FpmJvXa6eHO8yAvVEWml8qYCOfrA2WQsgTxMre3GE
	WejQ37GMElhEO2uMgzQDrU+XcLRsZ5Zka1f9zZtSZMXLdLQtV9nNrWcUvf7lA9M=
X-Gm-Gg: ASbGnctiWcAA1aTGaj36gzOnkA9Jw/pBbrl0qM1caitgpiEjqiS/FRBbGbyIxwqHV7Z
	grossU7T23P41frQ1j6Q3mn4q3bw0bW/N1L0KLoHpP9m46+imisdT+Aug5Xx3/QeWXomCLjHFzi
	IRGDZQ9i6Y20rZmxckLEfc4O6AndhzaEKTEY9B2E4bPMrHYkFQtztQzSx+Yv2vC8hjeFozwrifm
	RwGqUL0SLtUv5/FBNnEy5Vw7opNqW3C9oECUq7zTw==
X-Google-Smtp-Source: AGHT+IEncnAy4AjWnukyzHbHIB+xx0R8pVx/ioXleyWjgeqxb6nBK1dbkbwXfUfkrn1tzDRwDHd5ig==
X-Received: by 2002:a05:6a21:c94:b0:1e1:a647:8a3f with SMTP id adf61e73a8af0-1e5b4824307mr2076401637.22.1734482281227;
        Tue, 17 Dec 2024 16:38:01 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad9f8sm7329764b3a.150.2024.12.17.16.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:38:00 -0800 (PST)
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
Subject: [PATCH net-next v9 05/20] net: page_pool: add mp op for netlink reporting
Date: Tue, 17 Dec 2024 16:37:31 -0800
Message-ID: <20241218003748.796939-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218003748.796939-1-dw@davidwei.uk>
References: <20241218003748.796939-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Add a mandatory memory provider callback that prints information about
the provider.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/types.h | 1 +
 net/core/devmem.c             | 9 +++++++++
 net/core/page_pool_user.c     | 3 +--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index d6241e8a5106..a473ea0c48c4 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -157,6 +157,7 @@ struct memory_provider_ops {
 	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
 	int (*init)(struct page_pool *pool);
 	void (*destroy)(struct page_pool *pool);
+	int (*nl_report)(const struct page_pool *pool, struct sk_buff *rsp);
 };
 
 struct pp_memory_provider_params {
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 48903b7ab215..df51a6c312db 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -394,9 +394,18 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 	return false;
 }
 
+static int mp_dmabuf_devmem_nl_report(const struct page_pool *pool,
+				      struct sk_buff *rsp)
+{
+	const struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+
+	return nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id);
+}
+
 static const struct memory_provider_ops dmabuf_devmem_ops = {
 	.init			= mp_dmabuf_devmem_init,
 	.destroy		= mp_dmabuf_devmem_destroy,
 	.alloc_netmems		= mp_dmabuf_devmem_alloc_netmems,
 	.release_netmem		= mp_dmabuf_devmem_release_page,
+	.nl_report		= mp_dmabuf_devmem_nl_report,
 };
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 8d31c71bea1a..61212f388bc8 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -214,7 +214,6 @@ static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		  const struct genl_info *info)
 {
-	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
 	size_t inflight, refsz;
 	void *hdr;
 
@@ -244,7 +243,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 			 pool->user.detach_time))
 		goto err_cancel;
 
-	if (binding && nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
+	if (pool->mp_ops && pool->mp_ops->nl_report(pool, rsp))
 		goto err_cancel;
 
 	genlmsg_end(rsp, hdr);
-- 
2.43.5


