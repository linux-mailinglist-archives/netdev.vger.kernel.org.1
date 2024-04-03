Return-Path: <netdev+bounces-84209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798038960B9
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07511F248BE
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 00:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71818E542;
	Wed,  3 Apr 2024 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyXcu5Gu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D67B64E
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103666; cv=none; b=QcQLu248GSof4XlnE+aB9vzdugGIfQfSLF/474PqWEUYP2mNSgT9EEQ0sQJ0NxANqmbRL2lz9K8vIiiqByWJ6QQfPFzxUfXS3Y/dSNSAvU/VobV4DLuFF5FKnQ7hwENMpBGyz9wevh2S+vnZSk26NfaBu6cWW2OuvwYEvtgPA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103666; c=relaxed/simple;
	bh=gWRcyKODjkpOwskuiMoFPxRJnFLhBJ+2aQ4yyFxaS+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ig7C6uCG1aH9KajYrFkwXFAWpy1k6Pneaxao7q2wcm/JGwD+Wo0M3yhNUwJAB75BhfulxF6fXltVc1bDuEskn+UCPkWgEnbhkPPlxbOl7OAXt/ozuxbPqp/hlCtDSpMKX+G8p+6DTugoIwtKDAuITW/Dcy6WuZ8tGQYwu+CWOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyXcu5Gu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615365a5ee0so4780147b3.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 17:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712103662; x=1712708462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i9/eCQL3Z814esAM4yERlEsKsNnrs1jkfV4Puiw4Jo8=;
        b=WyXcu5GuyT8e2gg9I5dDRvpX2n2DoeyKtZhlt/msvothhPAP76crP4/+R1s/MZkfLf
         kaZBwZ2JhtmM1jSd+BayGOt7+GLhNAwHmw6e80oGtuSm8bqHgCQbNvNYXyTHgufjnIei
         v9+LvA/ZQn9w57AcfaBy/OsA5kFt1NmDyi8we+xiogO2de/1X/cxhA85ahmy639xty9g
         rM8WOg5QDLmzweyqAV6I3qNZnGk1xCRVSey4RLaqbfiPU2XGGRL40cDaUsXST/Q7V6xo
         LnBthZNGHkswrgGaHXBMzDBAA8p2L3UWdXwTTuZkTmjZeVvCK9iztltm2yqSGNHOgXOs
         hWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712103662; x=1712708462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9/eCQL3Z814esAM4yERlEsKsNnrs1jkfV4Puiw4Jo8=;
        b=cSEGTBasuwh9xEHysFt9fjlNqH6z6yVaoUVTNM9slMAYll/nlaVkSi8GM91NYdjBN6
         SdBDPocv8LbLG9TtE2jY1LRXuJ6LtUMUH5fEbgvE4mfJ/NZjLIFf421A0+W8uZVALtri
         WaeKGoIS7SgCJrTriWu2TzyFihuwPCog4Wk9rG9YwwwDbEn0y/2LBD7LVWnsA319ZR5m
         uFy/eArf8AYAAsVS5G6QtD+QeijpsY5hDwyb//MQr+IA01efQJdetGQc9h6jKjSXSzlC
         DWNP8zRPMcQKW7h4aYxCDIAP1zViKQD3Xz9Se2jJb7gGD99HI03gKjLaHw8Cy6SYpgee
         ZwMQ==
X-Gm-Message-State: AOJu0YxZCpd44pSlToBt+AG/Gj94QN+/KzBKMEuaKYtcGkqCaInL10ss
	05NQZfT8DNt6l4V54mYBE7qsF6hG6FW2K4etYg3fq/oWMZI84BiNLE70lwBoAnTiwkJLtV6Z8mT
	cDw3EakGyS0IYMyYoVmNuRmV9NslySkv9hBEno/ldJNk5XjsyxThRk74W/VCynaw8MbuGrkZu0V
	NEkG2sTicsjP/AA1uyFJGf32PYGBDy1UN3TqG/cr3EW37O/2wjelHHiBoL6PA=
X-Google-Smtp-Source: AGHT+IEZw1b9YZ8Zp4JXJHyLl5eFcaHCSQtcR+nvQGLDuxNqnIQQLwTQ0GAhyCF5Qg5vadT+0s6oURJ/cEWaFMIVxQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a81:b703:0:b0:615:f67:53e2 with SMTP
 id v3-20020a81b703000000b006150f6753e2mr206828ywh.2.1712103661503; Tue, 02
 Apr 2024 17:21:01 -0700 (PDT)
Date: Tue,  2 Apr 2024 17:20:38 -0700
In-Reply-To: <20240403002053.2376017-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403002053.2376017-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403002053.2376017-2-almasrymina@google.com>
Subject: [RFC PATCH net-next v8 01/14] queue_api: define queue api
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
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

This API enables the net stack to reset the queues used for devmem TCP.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/netdevice.h   |  3 +++
 include/net/netdev_queues.h | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7d12b5a9380f..a0bd542d143a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1957,6 +1957,7 @@ enum netdev_reg_state {
  *	@sysfs_rx_queue_group:	Space for optional per-rx queue attributes
  *	@rtnl_link_ops:	Rtnl_link_ops
  *	@stat_ops:	Optional ops for queue-aware statistics
+ *	@queue_mgmt_ops:	Optional ops for queue management
  *
  *	@gso_max_size:	Maximum size of generic segmentation offload
  *	@tso_max_size:	Device (as in HW) limit on the max TSO request size
@@ -2339,6 +2340,8 @@ struct net_device {
 
 	const struct netdev_stat_ops *stat_ops;
 
+	const struct netdev_queue_mgmt_ops *queue_mgmt_ops;
+
 	/* for setting kernel sock attribute on TCP connection setup */
 #define GSO_MAX_SEGS		65535u
 #define GSO_LEGACY_MAX_SIZE	65536u
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1ec408585373..337df0860ae6 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -60,6 +60,33 @@ struct netdev_stat_ops {
 			       struct netdev_queue_stats_tx *tx);
 };
 
+/**
+ * struct netdev_queue_mgmt_ops - netdev ops for queue management
+ *
+ * @ndo_queue_mem_alloc: Allocate memory for an RX queue. The memory returned
+ *			 in the form of a void* can be passed to
+ *			 ndo_queue_mem_free() for freeing or to ndo_queue_start
+ *			 to create an RX queue with this memory.
+ *
+ * @ndo_queue_mem_free:	Free memory from an RX queue.
+ *
+ * @ndo_queue_start:	Start an RX queue at the specified index.
+ *
+ * @ndo_queue_stop:	Stop the RX queue at the specified index.
+ */
+struct netdev_queue_mgmt_ops {
+	void *			(*ndo_queue_mem_alloc)(struct net_device *dev,
+						       int idx);
+	void			(*ndo_queue_mem_free)(struct net_device *dev,
+						      void *queue_mem);
+	int			(*ndo_queue_start)(struct net_device *dev,
+						   int idx,
+						   void *queue_mem);
+	int			(*ndo_queue_stop)(struct net_device *dev,
+						  int idx,
+						  void **out_queue_mem);
+};
+
 /**
  * DOC: Lockless queue stopping / waking helpers.
  *
-- 
2.44.0.478.gd926399ef9-goog


