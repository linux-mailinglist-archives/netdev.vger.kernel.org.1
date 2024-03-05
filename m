Return-Path: <netdev+bounces-77292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C238712C5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 03:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234B91C20EB1
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 02:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D4241E0;
	Tue,  5 Mar 2024 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NcqkfsWx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA7199BC
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604128; cv=none; b=sSv31qVv8k+ixEFAcbprCGSFxuC2f4nKn1klmO0eCru/u2tXZFcBtxdLEUhsaZ9xr2jaNY3C9i4qee7n9mecGmHQaLC4R/m/TWtqKka3a6tTTuf27h4/wn4RzQOtJMnEmHAyRcweRyQy4+CMUbnK+XnkeTyasjOyfdnnZ7bEe5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604128; c=relaxed/simple;
	bh=j/IwFTAQYqvdz7NJGn1fdITXlRNyG53+OSdMfig6/Ik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlEiLk/KiE2spsMauTIL2XQDG3EEPBbpcCw9gfSfWwH9NCP3KUT4OeRHWRxN2aupCD/oZUs8Y0No1wQEn6yFUk9qTW0uI8nJa+C+wvmZVk9m4qsYroAsUAYQlnOE74FxJmIPlWmaXOqq+Lmj3WCa4uZ6urmGkIWX/6z9xcPK8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NcqkfsWx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso2209990276.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 18:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709604124; x=1710208924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9Y5Scp28ZqCYcu39ok93LJAzx/1WlCB4rvVWoIV5aE=;
        b=NcqkfsWxY92T8H72Q9KWic205+OP/btpDnXvreJr99ioZjxLcpxGPAPeHdA8VbxZ9N
         yOWwBMB60bBDxr3ekQV5X8SGGpELD4G3vBDA9jgtIz6weGM8jItW6iJVoHzDFibxE4Ho
         2FO3BL6ft8GdJ0PfeY/82lad8Oqt9ta1nWdW7mHZqasIaVAwwvCGlcgAcQ3pM2QjkzsI
         caL/oV9hEk+9QotKVpWtwdvXnJjmY5XTTjQ+besky1m+C4CTf8HPr34KflMzuDOkATIx
         eVMO29Wh/O5oamxGbEsuEt2k6QfaXNNU5L1HcHA/21lrfFSdKPFmxK9GRqgVa7TCA/8X
         ZyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604124; x=1710208924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9Y5Scp28ZqCYcu39ok93LJAzx/1WlCB4rvVWoIV5aE=;
        b=OKT0HFy4R96DKEfwYvZMtY8gnWuof7ACIHuA45Y5FRqf624OlqH9rKlh4ootkrD1r9
         6uV4kifeUUceUhaDUL5bO1RXrgQ1uaqdPKvieuk6NfzDG6o3YxRrI/AJeWXbRqFtTp6W
         zXdWWqG41Axn1vlwlbgpNgAUyVa63qKz+F1Ns1pfottSkoMbvBdQKmpoF1Ho9yh3AYFP
         /jwyMK0ow4BjW4u2hfVaghV9f4TeLsB7VzdN54YGTn+e4Lz5+fALK2IUvDAdCE/LCsfD
         /d+oaeZMqxaILDavQog54LzGemxs/6bj53CgjO6QTFJ0ICHL1r7x0gqnPs7qnSht3415
         4/1Q==
X-Gm-Message-State: AOJu0Yx8ac7zg15Oi+LiEHrZy0LmLX0dsOGE9QyXJlbZzEUm1oy6Ye4v
	xko3IyoWHTeb/iMq7Q4olHNjfh53HiHaqk815PNjNiumLDBzw5QLOneGg4DDj9XBpj2KvRmLPVu
	pPiA9CWaY6lenQ0nf+LVJ3W/+H+lZfswPteKAzrQTHs5DrZiZbz+HfxDvy1RGJ34WkRpQny3x06
	s9/+/RsIBQgkXrtWIyrV1iS+zvzBsRJbFcapk7w1q2GYDqfNSiTGXFQPlCSm4=
X-Google-Smtp-Source: AGHT+IEWVOX8ecOfPBAQKvSAdDi7mXxA37voW2PjP2/k7/WW1wkAZw+RIjB2g4prAu6X3Z9fh0hm2+1kWtRsqaYHTQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b614:914c:63cd:3830])
 (user=almasrymina job=sendgmr) by 2002:a25:690d:0:b0:dcc:5463:49a8 with SMTP
 id e13-20020a25690d000000b00dcc546349a8mr245459ybc.6.1709604123917; Mon, 04
 Mar 2024 18:02:03 -0800 (PST)
Date: Mon,  4 Mar 2024 18:01:38 -0800
In-Reply-To: <20240305020153.2787423-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305020153.2787423-4-almasrymina@google.com>
Subject: [RFC PATCH net-next v6 03/15] net: page_pool: factor out page_pool
 recycle check
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

The check is duplicated in 2 places, factor it out into a common helper.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 8776fcad064a..fe9de4ecce94 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -684,6 +684,11 @@ static bool page_pool_recycle_in_cache(struct page *page,
 	return true;
 }
 
+static bool __page_pool_page_can_be_recycled(const struct page *page)
+{
+	return page_ref_count(page) == 1 && !page_is_pfmemalloc(page);
+}
+
 /* If the page refcnt == 1, this will try to recycle the page.
  * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
  * the configured size min(dma_sync_size, pool->max_len).
@@ -705,7 +710,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	 * page is NOT reusable when allocated when system is under
 	 * some pressure. (page_is_pfmemalloc)
 	 */
-	if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
+	if (likely(__page_pool_page_can_be_recycled(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
 		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
@@ -820,7 +825,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 	if (likely(page_pool_unref_page(page, drain_count)))
 		return NULL;
 
-	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
+	if (__page_pool_page_can_be_recycled(page)) {
 		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
 			page_pool_dma_sync_for_device(pool, page, -1);
 
-- 
2.44.0.rc1.240.g4c46232300-goog


