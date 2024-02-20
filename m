Return-Path: <netdev+bounces-73434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D585C6AC
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931851C21A9F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C82151CF3;
	Tue, 20 Feb 2024 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBuCZQGE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBF151CD8
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463031; cv=none; b=bNSX5ax4Zix7u7awl7kFe0Drm0Zm0WtPB+q7lYtrNDcGUOjwbxt+xB0u51Abj19jNQ5zJA8GnRLKg76QRkSf/Y7vrLubC1eb79YYae1e0HotxN7OGrm4Dzt440thEqvexsD9V/WS/VuJO4OSZqWJxx4rpzgaAp2hFYF6dr3iIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463031; c=relaxed/simple;
	bh=yAN3xT8EUV0i2CJy6NqtWV8aa+YkCcxRteYAC+EhA2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJutrg1VtGrTqUx5Ai4MnGX0rGmanglos5OK4VBlce1jpsMfyP5yyIlAL+wiwFb45M3ccPDfNhNRFCpcepZigbVouWJobC9eKkFBPfk4l6G+xFDLF3CmGQN1rYpnZOtyoTw8h9IIYqHRfirmxzQEJsBI4H4mZQAwJHyPmt26KiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBuCZQGE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708463028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HblB1EygQYmfDjQn4iPYkDY89+D2ws9zXge3PbtSVKM=;
	b=BBuCZQGE6bmxYYDC7w4utVjhCghV4dxTvA8Iqa+FQSxba1Vxg9JhwS7I5K07iwuLL9m4Lr
	aTEKecEeHs0qO07iGpma9M8m19tD7xfX5SkF7yUmOmmRuLu+p5NQavR8O4L2QldQFiViq9
	v200ulUThQvfitVtXEjAEbb2nMg+nkY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-4_oj4bO5Njq1PMeIFtaHWg-1; Tue, 20 Feb 2024 16:03:46 -0500
X-MC-Unique: 4_oj4bO5Njq1PMeIFtaHWg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a30f9374db7so706527766b.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 13:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463025; x=1709067825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HblB1EygQYmfDjQn4iPYkDY89+D2ws9zXge3PbtSVKM=;
        b=C7D+iur8TXGIdzBLU4EY70BN0HRpCDtCWHnfMkyWDEXyLaRk547LFv2kWUYl99+qGo
         2/KDUU38Ye8e9YCPfh/szNxsj0Q4TqJQQsR6WISKr+OZ+yOMTh4RGQZs2LeJ1oGrjwx7
         miJhDjK83oIMhgslzQnpkadrPXRd7KfYtRJFmxDLzLSJaCrXreg9lDk3X3lB1fVdZo85
         d5EgeIEuRWwipQ5J5Kt2pgLy06DaZwAtJAIEXGLxkUXNgamcnuWnh6/Y4qXlHNKLoo7w
         gT7Ceum10q7D36Mgrn0o6SRXTLJfezUKu0RiX6TYnmBpkMWkrvC80whEgHazx5iqXvaC
         x/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMaWkueZwAR/paP5joduCQAHdtb3+dlyjZQJQtGKC0dCkmpDkkE7GbJAHYLGXDxh88yHB66c+oTUdQ54Kw1keO+w3LciTe
X-Gm-Message-State: AOJu0YxWIeYJUlWQax7fIjegibzTap0SDtCd4PXY3BqI9eQ3vKXyOsY8
	8J6jgzvjeFKNaVforoMDabbj2rQyRI5beDGclNgVEe1Z7CE39/yqV7oYEGb0KTyl/lD886R2/wH
	OlsiF+7i8JlBmdO3K+vGeQ1B2valHmaUS/ejvovOqGdi0+c4lyDLT0A==
X-Received: by 2002:a17:906:55cb:b0:a3e:c1ef:e1bd with SMTP id z11-20020a17090655cb00b00a3ec1efe1bdmr5405407ejp.16.1708463025104;
        Tue, 20 Feb 2024 13:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgY95QbMUU0W/c1OW5idiuPM81C8CWORiKLmjeUIN4cqSY7c62j8zMAVZY0yACe7u0MSZG+A==
X-Received: by 2002:a17:906:55cb:b0:a3e:c1ef:e1bd with SMTP id z11-20020a17090655cb00b00a3ec1efe1bdmr5405384ejp.16.1708463024774;
        Tue, 20 Feb 2024 13:03:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bk10-20020a170906b0ca00b00a3ca744438csm4296469ejb.213.2024.02.20.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:03:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1BC1710F63EE; Tue, 20 Feb 2024 22:03:44 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 1/4] net: Register system page pool as an XDP memory model
Date: Tue, 20 Feb 2024 22:03:38 +0100
Message-ID: <20240220210342.40267-2-toke@redhat.com>
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

To make the system page pool usable as a source for allocating XDP
frames, we need to register it with xdp_reg_mem_model(), so that page
return works correctly. This is done in preparation for using the system
page pool for the XDP live frame mode in BPF_TEST_RUN; for the same
reason, make the per-cpu variable non-static so we can access it from
the test_run code as well.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c541550b0e6e..e1dfdf0c4075 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3345,6 +3345,7 @@ static inline void input_queue_tail_incr_save(struct softnet_data *sd,
 }
 
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
+DECLARE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
 
 static inline int dev_recursion_level(void)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index d8dd293a7a27..cdb916a647e7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -428,7 +428,7 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
  * PP consumers must pay attention to run APIs in the appropriate context
  * (e.g. NAPI context).
  */
-static DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
+DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
 
 #ifdef CONFIG_LOCKDEP
 /*
@@ -11739,12 +11739,20 @@ static int net_page_pool_create(int cpuid)
 		.pool_size = SYSTEM_PERCPU_PAGE_POOL_SIZE,
 		.nid = NUMA_NO_NODE,
 	};
+	struct xdp_mem_info info;
 	struct page_pool *pp_ptr;
+	int err;
 
 	pp_ptr = page_pool_create_percpu(&page_pool_params, cpuid);
 	if (IS_ERR(pp_ptr))
 		return -ENOMEM;
 
+	err = xdp_reg_mem_model(&info, MEM_TYPE_PAGE_POOL, pp_ptr);
+	if (err) {
+		page_pool_destroy(pp_ptr);
+		return err;
+	}
+
 	per_cpu(system_page_pool, cpuid) = pp_ptr;
 #endif
 	return 0;
@@ -11834,12 +11842,15 @@ static int __init net_dev_init(void)
 out:
 	if (rc < 0) {
 		for_each_possible_cpu(i) {
+			struct xdp_mem_info mem = { .type = MEM_TYPE_PAGE_POOL };
 			struct page_pool *pp_ptr;
 
 			pp_ptr = per_cpu(system_page_pool, i);
 			if (!pp_ptr)
 				continue;
 
+			mem.id = pp_ptr->xdp_mem_id;
+			xdp_unreg_mem_model(&mem);
 			page_pool_destroy(pp_ptr);
 			per_cpu(system_page_pool, i) = NULL;
 		}
-- 
2.43.0


