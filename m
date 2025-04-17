Return-Path: <netdev+bounces-183971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26885A92E05
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28961887B6B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EDC22ACCA;
	Thu, 17 Apr 2025 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F04rA7no"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC5226D0F
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931755; cv=none; b=WsG41931sE2q86PHCeA5TMhg7oO6GGJ34cd2lyjT9mMA69OubAhNd9o1OFpoxKGjz6pVX+6hQF6JMdnIB2lPDb5aMKBPZWRdzWIhZDOr4IuW8xTnRP2djQAlWcKgkw0pj63xrFRQrY8JSV+BS63mTR+hpdtkx7lxQjSrmw1njBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931755; c=relaxed/simple;
	bh=NeEtl0JyBuBfw49B2XTpAH0+6fht1E94LTL5fw/u2mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MvsfML2PYjt0C0pZpWHK7LhD3DkrQ0NjwPCm7UW4f57cqQV6VgCz5bhhNBAxwPJWnFmPZFiRjrl7GrkGkkEKCLZgyM0oSFlBeJkZ7KzmMwg6gT2CUzeiw+0C+eJ/+58mwROzes2CHd8f5FEpAB2QeSAvc7ZqyJufVyyn9uHBpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F04rA7no; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22403329f9eso10577935ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931752; x=1745536552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=00AFS0dK/JcGiS86FrD0eZND+4+TxFoXvhHvSO3Mfac=;
        b=F04rA7noIFIu0IFytGL4WZBFFCWBVxQoLOLsJ7mDT2oQw+AXX3Wglg82ZlQgixTRIN
         G0v+rl3KYiKhYarHBgfsCjP/zZOsdg62W/F2JF4QxfMhWQ2v/7mduev1lRBfcaXqYCIk
         XeUIZWPoTcf7MRPvmZelkoFsxYfJvFY8IuGMYsJo6YEZzs9h4sY+XjZJd4cStnGrvAle
         ZCK8oRocIHQKfcW0RWxKF1onBQ9v3HX//QxmPmBU7LEPv+4m/tNz4Ww6ze6O+KUE6vpl
         EjW8p+67aYLzS+RQShW2XY4huPo2ZG0Yh4mjOY2RzksXemjsV3VnZhdqh1Of5K9bs95H
         xoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931752; x=1745536552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00AFS0dK/JcGiS86FrD0eZND+4+TxFoXvhHvSO3Mfac=;
        b=nzw5ojqIEkXWcLq3Av4jBYXHrdYUX0E4v6b4Q5va+XFklLgSSuVZrJXdOX4l1e997a
         PjYIgOdKu0oFxXhYT9V5XsAWokcK3Nqu88tz3LFHKL5j50ACmdpbUdwYsDoqwwRHT66w
         ySG3Vdz8j3tpdeybEtyXIzU3oQvxcNkDMrWFoYn4yBN7Ilp53l17TZkb28C6Nlyf2vgu
         UES/ShDYx8Bmb7PiMAFKNJhhdx/ucsIuZB4qt8bI11W8w899nFiesAFO+Gu1k15VZ/0q
         Qgp57bvsPMvzbcSVc+XeQRvgJHaqr4Se1k/9/J6Gbhhj3PSgvkBRtfP6XsJzd7UUVMpz
         Arkw==
X-Gm-Message-State: AOJu0YxF67fTcBVBSZMLTKriKvx5ySF6j/LVt7Ax0mhy/xfZDhRtpv7Q
	3yvFyVJbiJ8PzTQIyE8nXttsiiP8u16pcLndi6uKmE2IkdIHA8ldI6qlbe4KEzFg6t0knwIA7sh
	Fo1nz7UghPySbczHZFW/cBEm7fSHCAUSmDPDFNpz1mkPIjsjT1FQggr8F1F7rN9PGxQ/H24LFYE
	y+ILb2efHDxbtP3dHD2dTFaBcqNsxap4ys7HBfqEyYOCvN6NS76nleR38COCk=
X-Google-Smtp-Source: AGHT+IHafWrM7cs+MI3iV0RuAM6mba99LEtrOyQd8pjffWGPtooqo/nTDaM0O2k7fwxrPoxXcPYwnXqfYFv0sCw7Zg==
X-Received: from plbbh9.prod.google.com ([2002:a17:902:a989:b0:21f:b748:a1c8])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d489:b0:224:e33:8896 with SMTP id d9443c01a7336-22c53285bbbmr8808575ad.11.1744931751514;
 Thu, 17 Apr 2025 16:15:51 -0700 (PDT)
Date: Thu, 17 Apr 2025 23:15:36 +0000
In-Reply-To: <20250417231540.2780723-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417231540.2780723-6-almasrymina@google.com>
Subject: [PATCH net-next v9 5/9] net: add devmem TCP TX documentation
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Add documentation outlining the usage and details of the devmem TCP TX
API.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v5:
- Address comments from Stan and Bagas

v4:
- Mention SO_BINDTODEVICE is recommended (me/Pavel).

v2:
- Update documentation for iov_base is the dmabuf offset (Stan)

---
 Documentation/networking/devmem.rst | 150 +++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index eb678ca45496..a6cd7236bfbd 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -62,15 +62,15 @@ More Info
     https://lore.kernel.org/netdev/20240831004313.3713467-1-almasrymina@google.com/
 
 
-Interface
-=========
+RX Interface
+============
 
 
 Example
 -------
 
-tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
-the RX path of this API.
+./tools/testing/selftests/drivers/net/hw/ncdevmem:do_server shows an example of
+setting up the RX path of this API.
 
 
 NIC Setup
@@ -235,6 +235,148 @@ can be less than the tokens provided by the user in case of:
 (a) an internal kernel leak bug.
 (b) the user passed more than 1024 frags.
 
+TX Interface
+============
+
+
+Example
+-------
+
+./tools/testing/selftests/drivers/net/hw/ncdevmem:do_client shows an example of
+setting up the TX path of this API.
+
+
+NIC Setup
+---------
+
+The user must bind a TX dmabuf to a given NIC using the netlink API::
+
+        struct netdev_bind_tx_req *req = NULL;
+        struct netdev_bind_tx_rsp *rsp = NULL;
+        struct ynl_error yerr;
+
+        *ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+
+        req = netdev_bind_tx_req_alloc();
+        netdev_bind_tx_req_set_ifindex(req, ifindex);
+        netdev_bind_tx_req_set_fd(req, dmabuf_fd);
+
+        rsp = netdev_bind_tx(*ys, req);
+
+        tx_dmabuf_id = rsp->id;
+
+
+The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
+that has been bound.
+
+The user can unbind the dmabuf from the netdevice by closing the netlink socket
+that established the binding. We do this so that the binding is automatically
+unbound even if the userspace process crashes.
+
+Note that any reasonably well-behaved dmabuf from any exporter should work with
+devmem TCP, even if the dmabuf is not actually backed by devmem. An example of
+this is udmabuf, which wraps user memory (non-devmem) in a dmabuf.
+
+Socket Setup
+------------
+
+The user application must use MSG_ZEROCOPY flag when sending devmem TCP. Devmem
+cannot be copied by the kernel, so the semantics of the devmem TX are similar
+to the semantics of MSG_ZEROCOPY::
+
+	setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
+
+It is also recommended that the user binds the TX socket to the same interface
+the dma-buf has been bound to via SO_BINDTODEVICE::
+
+	setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname, strlen(ifname) + 1);
+
+
+Sending data
+------------
+
+Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
+
+The user should create a msghdr where,
+
+* iov_base is set to the offset into the dmabuf to start sending from
+* iov_len is set to the number of bytes to be sent from the dmabuf
+
+The user passes the dma-buf id to send from via the dmabuf_tx_cmsg.dmabuf_id.
+
+The example below sends 1024 bytes from offset 100 into the dmabuf, and 2048
+from offset 2000 into the dmabuf. The dmabuf to send from is tx_dmabuf_id::
+
+       char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
+       struct dmabuf_tx_cmsg ddmabuf;
+       struct msghdr msg = {};
+       struct cmsghdr *cmsg;
+       struct iovec iov[2];
+
+       iov[0].iov_base = (void*)100;
+       iov[0].iov_len = 1024;
+       iov[1].iov_base = (void*)2000;
+       iov[1].iov_len = 2048;
+
+       msg.msg_iov = iov;
+       msg.msg_iovlen = 2;
+
+       msg.msg_control = ctrl_data;
+       msg.msg_controllen = sizeof(ctrl_data);
+
+       cmsg = CMSG_FIRSTHDR(&msg);
+       cmsg->cmsg_level = SOL_SOCKET;
+       cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
+       cmsg->cmsg_len = CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
+
+       ddmabuf.dmabuf_id = tx_dmabuf_id;
+
+       *((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) = ddmabuf;
+
+       sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
+
+
+Reusing TX dmabufs
+------------------
+
+Similar to MSG_ZEROCOPY with regular memory, the user should not modify the
+contents of the dma-buf while a send operation is in progress. This is because
+the kernel does not keep a copy of the dmabuf contents. Instead, the kernel
+will pin and send data from the buffer available to the userspace.
+
+Just as in MSG_ZEROCOPY, the kernel notifies the userspace of send completions
+using MSG_ERRQUEUE::
+
+        int64_t tstop = gettimeofday_ms() + waittime_ms;
+        char control[CMSG_SPACE(100)] = {};
+        struct sock_extended_err *serr;
+        struct msghdr msg = {};
+        struct cmsghdr *cm;
+        int retries = 10;
+        __u32 hi, lo;
+
+        msg.msg_control = control;
+        msg.msg_controllen = sizeof(control);
+
+        while (gettimeofday_ms() < tstop) {
+                if (!do_poll(fd)) continue;
+
+                ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
+
+                for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+                        serr = (void *)CMSG_DATA(cm);
+
+                        hi = serr->ee_data;
+                        lo = serr->ee_info;
+
+                        fprintf(stdout, "tx complete [%d,%d]\n", lo, hi);
+                }
+        }
+
+After the associated sendmsg has been completed, the dmabuf can be reused by
+the userspace.
+
+
 Implementation & Caveats
 ========================
 
-- 
2.49.0.805.g082f7c87e0-goog


