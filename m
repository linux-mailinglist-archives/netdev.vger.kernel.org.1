Return-Path: <netdev+bounces-73437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF6285C6B3
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DC1283A7F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C88E151CE8;
	Tue, 20 Feb 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULk+RhD7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19B152DF9
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463037; cv=none; b=JRWktyjMvU4U65WBK5d4YKbdNEjtt8DefUAA7PyQV7z4mghwa0nkWWKIInYhc2ybe0nLZ2LvTZPCVLGN0y9ZyJ6DrhDNktNvD0fJ0AC7Kr84zqMtTqDePRUrCOdUObgFpfmH3m17oV6Q0DbjII7QozmSH2CKAQw0cvHpwqiHb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463037; c=relaxed/simple;
	bh=yFzbobEZz1Ejk+C4hN4SD4uxZslKPofrmu/6I7dSQg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKTHLOSjaOpIQo/YIzOL4lMcTGtZ6CiiIam9XYVymzc+UwPElaNKBjmhV0i7rfm9fgFwS81UtFER3yQRxzRyoaME7Ud5+FecVjpjyxwPp76aQ9WAOWg+ZtIuSzs0yF0xLwrRpN21nidpMeMKZOYLoOsI0MYD9GjKOJp1fPjxPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULk+RhD7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708463031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Cx1B6cH8M4WwsZid+9jIkWUL8B6BHRlRdPrxUHWq74=;
	b=ULk+RhD7OCsoEmArRML5uzqjsMXbjZuZq+IdvH7er7QtYxFwgnJDrFJsOkNoHdXszx0ARC
	maKq/aXnH3xzmNM/1hiQgNsYZpU/aBxZK7J9epWkckJtp3ptjtKpwcuOS2uMKcmUrH6dUy
	3ybaVDA2Yyjq/sRVQVWcGGQH4J+gKEo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-gP-_dnYWMwuwxQudGsc6CQ-1; Tue, 20 Feb 2024 16:03:49 -0500
X-MC-Unique: gP-_dnYWMwuwxQudGsc6CQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-564902d757bso1377408a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 13:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463028; x=1709067828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Cx1B6cH8M4WwsZid+9jIkWUL8B6BHRlRdPrxUHWq74=;
        b=OPpTp4qLypVOQKfRSCefTa0LpxiuDPMH5cCzjYKFp6bYvvsVa86SyxK35BUrOCgCcb
         YMR0wSdmcRsx8B0UxW9CK788rLM/sTXTQIlhN0HFFZWrDTHmzeBVCEy8lKbnAel0IEd+
         FeGVD6xLN7ZVKGw30BQqYbyFWB47FsxFQWl89saID34BCRV6TS4wSLf1L1ub6LEgONJ+
         a34W5PcvAU3GXVNP/QbCeeeFBQBaY5LbRIm+1GN8U5+XBS6Ko2zTGki6kKYSfpbjp7Tf
         K1ynoK964rr3WVQGuZZdrV64EVEtBlcx646g6l7zNtrryfEB0cM6+lS5F/q69/eIQ6gB
         e1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXde2/Gv0iCUj7bz0PsPgvBQeuPxBLTdDwW0GtuRIvGLPoe3j0dvtv3tP3z3s+Gm+xE+z7oqueKuzNcx4IZQPra7ZsBsJK/
X-Gm-Message-State: AOJu0YxiAAtUIMOPCnj/gnHFSEMkV6zFjjQ0LGjL91ro+5EFTi07JF7x
	eRnmGBYVpQpYqOWI41f5emSD87LhMhBFr5/twluVoVRFG+K2PAHTsf/Lim1tuXUUufzSBUQZWtg
	51qZ3QdAUdiKBM3zXGnMgzAUvU/egobw79r8t0GTplEvxj522IZ3CRw==
X-Received: by 2002:a05:6402:1801:b0:564:7007:e14c with SMTP id g1-20020a056402180100b005647007e14cmr5349840edy.22.1708463028748;
        Tue, 20 Feb 2024 13:03:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5BIwE4aBq1el+YWIDllK4swwpI2BtcI/vhibgBqxmx+4xoGKaTodyN0sy/hQFFO/BQtXUDA==
X-Received: by 2002:a05:6402:1801:b0:564:7007:e14c with SMTP id g1-20020a056402180100b005647007e14cmr5349836edy.22.1708463028551;
        Tue, 20 Feb 2024 13:03:48 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ew14-20020a056402538e00b005602346c3f5sm3983025edb.79.2024.02.20.13.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:03:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1F90210F63F4; Tue, 20 Feb 2024 22:03:45 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/4] page pool: Remove init_callback parameter
Date: Tue, 20 Feb 2024 22:03:41 +0100
Message-ID: <20240220210342.40267-5-toke@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220210342.40267-1-toke@redhat.com>
References: <20240220210342.40267-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The only user of the init_callback parameter to page pool was the
BPF_TEST_RUN code. Since that has now been moved to use a different
scheme, we can get rid of the init callback entirely.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/page_pool/types.h | 4 ----
 net/core/page_pool.c          | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 3828396ae60c..2f5975ab2cd0 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -69,9 +69,6 @@ struct page_pool_params {
 	);
 	struct_group_tagged(page_pool_params_slow, slow,
 		struct net_device *netdev;
-/* private: used by test code only */
-		void (*init_callback)(struct page *page, void *arg);
-		void *init_arg;
 	);
 };
 
@@ -129,7 +126,6 @@ struct page_pool {
 	struct page_pool_params_fast p;
 
 	int cpuid;
-	bool has_init_callback;
 
 	long frag_users;
 	struct page *frag_page;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 89c835fcf094..fd054b6f773a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -217,8 +217,6 @@ static int page_pool_init(struct page_pool *pool,
 		 */
 	}
 
-	pool->has_init_callback = !!pool->slow.init_callback;
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
 	if (!pool->recycle_stats)
@@ -428,8 +426,6 @@ static void page_pool_set_pp_info(struct page_pool *pool,
 	 * the overhead is negligible.
 	 */
 	page_pool_fragment_page(page, 1);
-	if (pool->has_init_callback)
-		pool->slow.init_callback(page, pool->slow.init_arg);
 }
 
 static void page_pool_clear_pp_info(struct page *page)
-- 
2.43.0


