Return-Path: <netdev+bounces-84213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93E8960DD
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2269D28A5E9
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 00:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46DA1C291;
	Wed,  3 Apr 2024 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4g+DePk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53ED1B5B1
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103675; cv=none; b=oY/3gkgWUakqKsCH2Mb2etn4wzfuftV5rNEOp9XCaPde3pII8Haky1++rFabS20fl6To9k2ausZVTaqQ5Opooq7XH67s016N9/Zcjpm2wIy+W/vfWCw9fWa0Gw5lGc8hncn1riZkh1xgDMUuejkDwO776fDrnKdN6kj7tmsPSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103675; c=relaxed/simple;
	bh=xFTAZD9KiJJOW2yUnRdKg1aeM3LKxDpVKUim5i6Calc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dCxhPzI19p8D1ZAVWH1HCxYKGXhLG+0+/dcM9VUtnqXNPh5Scji4NwAWoGqtv4vsYcDJKs+dOe2SqScRZb+paCjcFxxUw2SJoFI38wiQmrf8TT/jPlLoDY//ZvlNAALFPS9NOj34h9HTfjWq0i7tpX9DhwIPJB7dXqYgBpX6YMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4g+DePk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610b96c8ca2so102368227b3.2
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 17:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712103671; x=1712708471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nhXcrf/psLdQ173XjHGFDimEkHTNNBO9mtpBEGwTzo=;
        b=q4g+DePkrmwf4/3V6yCPyr1dOtRp6gszNglVDNxNeqL3Rv5JFSJXc5oJASzxp1JUak
         1P8qHtvJ/UYKM8g5kUMTQHVwNECgAun76dhI7wThp8wyDqnN8GLxjitwCqDjzJ4gLztM
         WIWI3Xesqn0Wvkw+k2bqrmy+dMvyfbmU19RylKJ67oKMx2SIwMlrwX86g6xZ3GuZCgUv
         sL/IsP/nY2XY3hWAse1K3FW8VKWRKTdZ/nf3Y53TlRKpj3Cocl0u1miBMChk7V9qh2Dq
         bVLtLFFkpzUvEMAHLSPLiYaF4hF9OBgYpix03lNGL8VnKgjDqJ4GyOldK+l7GPSqoMeQ
         Uk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712103671; x=1712708471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nhXcrf/psLdQ173XjHGFDimEkHTNNBO9mtpBEGwTzo=;
        b=waipyToWnM4s4Pgn8VqQy6RsTA8DF8N9ibvmMSmHWLz8z8eztWwj0t+bnlfKu1Frqp
         FtPN6r/Oe/JPqKv57zTRFdMP2BSKK/C9fTzLUHo4ZsqaVPMRFQfG3vKTkJCXkei0QldV
         y3biC25LTjrP0/21LQqr+v+ZaXI2kYY0SxOcuGxb1/ieCc6nqXySMNdvYoYmPfd8q/aA
         fabJg9yFsFE7PQfjGMTpvWtZ6OZiz8umk2x4ydX+MfRUpATewE/QGMelCKF2+gdXWFOv
         9uLwVBoTQ0992IEG2n62jUIdMPmo8Qk6qaD/7muQrf5LNK/lGwK/HgWha+AOlpzRdpd8
         0xlQ==
X-Gm-Message-State: AOJu0YxFD9vK/Pa+2IibJI4ptxPSn7FY/9yjY2+jHaFAMwXEluzoLlxT
	RERaRnsu4LKhiIkCvPFzb85GDkWtzPLwHVuWbcJjZZrPU8bhrtlkHrQJjxNWA00F5HRhNhE83Y4
	Cur/la4TJTHF9aNYc7L80/X3TmnXkh1CWnOU6CuVZ3dDnAJBx6MZH4m1ZebcW/81jWOF+lv8Agd
	50urGS+WeO1ox8cMm/WoApoVicFDpRfrgxj66mLqUCQ7cLpjFNt0ZwKbbOct4=
X-Google-Smtp-Source: AGHT+IHMXdCvPN5+ndYi96zUruWX8N0e3AstuGfCxpXeaq2Uu1jKjeIcbqjKoYhElRNSOqkr/xQVDtinASCTT2HEZg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a81:52c7:0:b0:615:102e:7d3b with SMTP
 id g190-20020a8152c7000000b00615102e7d3bmr1133480ywb.1.1712103670342; Tue, 02
 Apr 2024 17:21:10 -0700 (PDT)
Date: Tue,  2 Apr 2024 17:20:42 -0700
In-Reply-To: <20240403002053.2376017-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403002053.2376017-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403002053.2376017-6-almasrymina@google.com>
Subject: [RFC PATCH net-next v8 05/14] netdev: netdevice devmem allocator
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
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Florian Westphal <fw@strlen.de>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Aleksander Lobakin <aleksander.lobakin@intel.com>, Michael Lass <bevan@bi-co.net>, 
	Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement netdev devmem allocator. The allocator takes a given struct
netdev_dmabuf_binding as input and allocates net_iov from that
binding.

The allocation simply delegates to the binding's genpool for the
allocation logic and wraps the returned memory region in a net_iov
struct.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v8:
- Rename netdev_dmabuf_binding -> net_devmem_dmabuf_binding to avoid
  patch-by-patch build error.
- Move niov->pp_magic/pp/pp_ref_counter usage to later patch to avoid
  patch-by-patch build error.

v7:
- netdev_ -> net_devmem_* naming (Yunsheng).

v6:
- Add comment on net_iov_dma_addr to explain why we don't use
  niov->dma_addr (Pavel)
- Refactor new functions into net/core/devmem.c (Pavel)

v1:
- Rename devmem -> dmabuf (David).

---
 include/net/devmem.h | 13 +++++++++++++
 include/net/netmem.h | 40 ++++++++++++++++++++++++++++++++++++++++
 net/core/devmem.c    | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/include/net/devmem.h b/include/net/devmem.h
index fa03bdabdffd..cd3186f5d1fb 100644
--- a/include/net/devmem.h
+++ b/include/net/devmem.h
@@ -68,7 +68,20 @@ int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding);
+struct net_iov *
+net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
+void net_devmem_free_dmabuf(struct net_iov *ppiov);
 #else
+static inline struct net_iov *
+net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
+{
+	return NULL;
+}
+
+static inline void net_devmem_free_dmabuf(struct net_iov *ppiov)
+{
+}
+
 static inline void
 __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 {
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 72e932a1a948..33014370a885 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -14,8 +14,48 @@
 
 struct net_iov {
 	struct dmabuf_genpool_chunk_owner *owner;
+	unsigned long dma_addr;
 };
 
+static inline struct dmabuf_genpool_chunk_owner *
+net_iov_owner(const struct net_iov *niov)
+{
+	return niov->owner;
+}
+
+static inline unsigned int net_iov_idx(const struct net_iov *niov)
+{
+	return niov - net_iov_owner(niov)->niovs;
+}
+
+/* This returns the absolute dma_addr_t calculated from
+ * net_iov_owner(niov)->owner->base_dma_addr, not the page_pool-owned
+ * niov->dma_addr.
+ *
+ * The absolute dma_addr_t is a dma_addr_t that is always uncompressed.
+ *
+ * The page_pool-owner niov->dma_addr is the absolute dma_addr compressed into
+ * an unsigned long. Special handling is done when the unsigned long is 32-bit
+ * but the dma_addr_t is 64-bit.
+ *
+ * In general code looking for the dma_addr_t should use net_iov_dma_addr(),
+ * while page_pool code looking for the unsigned long dma_addr which mirrors
+ * the field in struct page should use niov->dma_addr.
+ */
+static inline dma_addr_t net_iov_dma_addr(const struct net_iov *niov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
+
+	return owner->base_dma_addr +
+	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
+}
+
+static inline struct net_devmem_dmabuf_binding *
+net_iov_binding(const struct net_iov *niov)
+{
+	return net_iov_owner(niov)->binding;
+}
+
 /* netmem */
 
 /**
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 02a6abaecf40..268fc8455a6d 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -103,6 +103,42 @@ static int net_devmem_restart_rx_queue(struct net_device *dev, int rxq_idx)
 	return err;
 }
 
+struct net_iov *
+net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
+{
+	struct dmabuf_genpool_chunk_owner *owner;
+	unsigned long dma_addr;
+	struct net_iov *niov;
+	ssize_t offset;
+	ssize_t index;
+
+	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
+					(void **)&owner);
+	if (!dma_addr)
+		return NULL;
+
+	offset = dma_addr - owner->base_dma_addr;
+	index = offset / PAGE_SIZE;
+	niov = &owner->niovs[index];
+
+	niov->dma_addr = 0;
+
+	net_devmem_dmabuf_binding_get(binding);
+
+	return niov;
+}
+
+void net_devmem_free_dmabuf(struct net_iov *niov)
+{
+	struct net_devmem_dmabuf_binding *binding = net_iov_binding(niov);
+	unsigned long dma_addr = net_iov_dma_addr(niov);
+
+	if (gen_pool_has_addr(binding->chunk_pool, dma_addr, PAGE_SIZE))
+		gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
+
+	net_devmem_dmabuf_binding_put(binding);
+}
+
 /* Protected by rtnl_lock() */
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
-- 
2.44.0.478.gd926399ef9-goog


