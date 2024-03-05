Return-Path: <netdev+bounces-77290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDE68712A8
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 03:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB802281AF7
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 02:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A9718C08;
	Tue,  5 Mar 2024 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOAGPinq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234F18049
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604124; cv=none; b=Get8RSVGcu94N8iuB2qoVqNeQuiCMyod2zY1K04Q5o5JKLCQwOwM7HUfFLekqeb95bS3HQxOzydY74wkHh+qMBhKtqg7MpFdUl4qzz6INRDOFZGqnwUBISLlV9yi7vFzQTNuGhWhtg1Pq1hw4qU5V9BgvM0oaLwzSIz76N/fgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604124; c=relaxed/simple;
	bh=VcAq+8sPLS5iB4yXv3NBRB5uIgbi5Zb5VcGf/lhRiGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mErUVarl2aVavglHs2f8Mz/p5m/i9AnXg79DN4aOxH/gWhUIMQ97VEPfjIWmKtrsxovwxsJPsfiZvjOVuIfb+qGJsFG4GGPOuxeAhx26GV4sZEY+EGEn+f1dlqPx6XHhXOqRnOiBtEsh2bEcSvxPgNy1EAm3cHq7uB3BJDrzfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOAGPinq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso7986217276.3
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 18:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709604120; x=1710208920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Na1UZEy/GVYcP9OgTRpAH79YV4s5dC/8SJ0CqP6QkUQ=;
        b=SOAGPinqVL6jLI6F/9qU7rdsc1wI4Kab05iu4Eal0k5PFI7K5rXmfGdPKieAk0pBAA
         oGx/qepbdzcpLpo+3o6p11H/kYhpD1r/wtceTPnNFJ7EfQ4i0td+DmJvYjZwonOndeMg
         JuXtYENZii5Ep4SzuyccbI3Np3AGwqVT8INYZv2Ed6Cdd2xcD1b43oai0RjNgds989pq
         pRwp6svHhLUGhbNt5eV5LvVJ0N02c+7YyHtznAjVCv7rHn4+1xN2wVvaxtYDNE7wL4Y8
         ST9FQMNb89vEVzH3pV/zJUX2+SR+MOOFfOzlJ1auEkVAtBIKVL148AJaj422gzQW5viE
         yQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604120; x=1710208920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Na1UZEy/GVYcP9OgTRpAH79YV4s5dC/8SJ0CqP6QkUQ=;
        b=ku4dJ1AH9DWnCv4SxSsBAZQNi/EB/TRiZdBBhEbFJrkpfve7S3U1/RL9FxPsqFemBx
         zrVM611i89YKO4cZY/MqaGFtbyZ7v81yMETVyn9BkY3mTBi9BV4M7OYpPGdSz7S4sV+e
         Ep8MoViSi0V4oYnSvACrlllrBrg8KhysInnN5ee+PPHoXyJU7udWSHySrvnv2VWx0I8C
         xd5nTdsgHnEZjjmaRQsPtQb7O/4Y2upvlmGtAn4rJkCeFlgJ1gdTaOY4xRM0B+alxw7H
         AOxtTywhV2HO0toExBD2re0+avlZPzZUjjpJSUOeWPgwFldfdUQ/IZEfVjf5OOS5uD3p
         XXFw==
X-Gm-Message-State: AOJu0YxQpzIGfCGx8wujr/3tfKd++wme6RSJVsWwb/KySrwqlxYUJQt4
	adO6GxmKsNwLz5pt8vYVcppjANdvWXLtiqrCBnnF/5LW2S321ReJQ6R0lfHIpVQQG9KNaWTrBEk
	0nB2dybrWciHYmS3j4oIIgBFrd9qGZmxFVegvoFstu6M6KQq0bOq5dsI//DDFo3YelhkvXbENkB
	Gi/aPCv/eucj/rc6Zb+fq8EFcqOruziLqGbqwrA/scsq10RMkypRekcGTmA4A=
X-Google-Smtp-Source: AGHT+IGpPTZKtcPN8U9sdm9ezESJ/sJ5oiNSY59vHDkx0uXjzdGQiK9QV6X9ugUC+YOriupaZX7copF8kyJbbuA8Ug==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b614:914c:63cd:3830])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1004:b0:dc2:3441:897f with
 SMTP id w4-20020a056902100400b00dc23441897fmr2713866ybt.6.1709604119594; Mon,
 04 Mar 2024 18:01:59 -0800 (PST)
Date: Mon,  4 Mar 2024 18:01:36 -0800
In-Reply-To: <20240305020153.2787423-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305020153.2787423-2-almasrymina@google.com>
Subject: [RFC PATCH net-next v6 01/15] queue_api: define queue api
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

This API enables the net stack to reset the queues used for devmem.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/netdevice.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c41019f34179..3105c586355d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1435,6 +1435,20 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ *
+ * void *(*ndo_queue_mem_alloc)(struct net_device *dev, int idx);
+ *	Allocate memory for an RX queue. The memory returned in the form of
+ *	a void * can be passed to ndo_queue_mem_free() for freeing or to
+ *	ndo_queue_start to create an RX queue with this memory.
+ *
+ * void	(*ndo_queue_mem_free)(struct net_device *dev, void *);
+ *	Free memory from an RX queue.
+ *
+ * int (*ndo_queue_start)(struct net_device *dev, int idx, void *);
+ *	Start an RX queue at the specified index.
+ *
+ * int (*ndo_queue_stop)(struct net_device *dev, int idx, void **);
+ *	Stop the RX queue at the specified index.
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1679,6 +1693,16 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
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
 };
 
 /**
-- 
2.44.0.rc1.240.g4c46232300-goog


