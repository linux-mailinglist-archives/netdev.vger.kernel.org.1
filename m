Return-Path: <netdev+bounces-77303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2087133C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 03:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2103B25B91
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 02:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4680623;
	Tue,  5 Mar 2024 02:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEbo6TCw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEE7FBA0
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604154; cv=none; b=SUGJY8T6Jf+7vCXC5QPsUWNNpPQRGsCHhzjCxXmocazn1Qs6k96mfQSBSR638n51VYHgfk+PW8h6uZ0jC1gbr4DllmwZPJJsW87StvFeHQoC+66MTqgb0Mt4vgPFZzM8oNIisil2sESFzGeJYrjr/8kynO87KQkUy3fcSihxSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604154; c=relaxed/simple;
	bh=pfSBox9Ga0DV9HP7LL34Jt5xxP+j2xIrHHM73+n+DHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tml4KnULrZDMy3O7PngPI2Jwa2vAGl8mqTNqWNkVmFmiHApPquQW6dU6+9y3lqzY944dkF6+H4RWqg8TZTMXmWp8vAnHPq5CGlq4rT+Qfx/DvsKWB7zQWJa4FS0tVqIfY8ppEH52/BF003US/tra4UckyvYhmBDsq8chaevtKtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IEbo6TCw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso8540157276.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 18:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709604148; x=1710208948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdaLgPgB3k0IUnbuFiSyW7eJOw/whsgAOWZdbzevfeI=;
        b=IEbo6TCwFdZUX01ejpDAByTWlj7GWM/1Ee4u8lkbxk2BCG5QyHu54eYSJNWsCt19Oe
         z0DJBkWofvyJjgLB2J3bpRT4oR2somMb37WRQMF+ge5RivMifZFTH8XmY1jZjx2KrH1t
         GZqWD8fjceeWYcj5xFV0R0bax529vnpT42wgMpQ9Wm231Uwjuuy6jjyAe5mCJfEeU9HF
         8FtR0UIDfC/zW0gYIgAjirviy5pzCGH4SyDBqc8KLuEG0b6VG09/s3GxFDcogxhOLxQI
         hkj2a0dsphFjflcijLNWmwiEop4tWwyAuOTl4cxE3xeQmlo9qkU8fMw8W2e9oE0uYVa7
         31eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604148; x=1710208948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdaLgPgB3k0IUnbuFiSyW7eJOw/whsgAOWZdbzevfeI=;
        b=MJVbYXG9raBMImekkooKijPDQgKesa9kX3ySq9Mc4r1HfcMYRXXLhy+pnvKJhKjRXq
         yVvawefoOxsvNhs7zlnyV0QuLaOdBiBwBYYUpIYIErcAabITI01tw3f9dZF5inRuUQft
         59eB2L3KmYdY6u4n5H9T59FUWvZaWpICxKloQYnf+RPbAl00tW97XVKrGKh6d6s6uvXG
         PlxxaBiPlJQvGo8cQr0wU5g8mgiRttmbb+gUgo1G/WatG25qokx0RPpphgHJhs1HsSln
         HJws//cw4JajeibTiMVCbJIdMmPfo8eMhi71074p97v77oE5AZLpO0xG4luEXsSAOm4g
         QjnA==
X-Gm-Message-State: AOJu0YzpMTwUV7vLQR2lFpvReqA7eubAlB8UzDjUfttBTLE3BEd5D+By
	eXJsoz2ExLxiswBWKPqMnfrh4Oei+UnuUBRVqWWJMQNQRApbashHrWdGKc6PGiBJ6YeWFrU49h/
	xOzMgsKCt4xBn9+SoBB9X2GTUcAROeMAS9LduQcnRq3n8N2ulHPdYc1n02aazWYyKwnUsL8XER3
	UihKS62+EtpWLdzdXTHmXy5X4zUXzSpSDPn1h9/exS1dwL+D+2Ar4Z/2KlwFM=
X-Google-Smtp-Source: AGHT+IHQs0SIwa2ekbs3tLJ18U+t6mqdEQQQa57loe9W+ctuY8OVB4RpI+mzdPMB5Lnn+KZ21aUA8Q2c99dGnxQY1A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b614:914c:63cd:3830])
 (user=almasrymina job=sendgmr) by 2002:a5b:54c:0:b0:dc7:5925:92d2 with SMTP
 id r12-20020a5b054c000000b00dc7592592d2mr249722ybp.1.1709604147667; Mon, 04
 Mar 2024 18:02:27 -0800 (PST)
Date: Mon,  4 Mar 2024 18:01:49 -0800
In-Reply-To: <20240305020153.2787423-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305020153.2787423-15-almasrymina@google.com>
Subject: [RFC PATCH net-next v6 14/15] net: add devmem TCP documentation
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

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v1 -> v2:

- Missing spdx (simon)
- add to index.rst (simon)

---
 Documentation/networking/devmem.rst | 271 ++++++++++++++++++++++++++++
 Documentation/networking/index.rst  |   1 +
 2 files changed, 272 insertions(+)
 create mode 100644 Documentation/networking/devmem.rst

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
new file mode 100644
index 000000000000..4712f029e5ed
--- /dev/null
+++ b/Documentation/networking/devmem.rst
@@ -0,0 +1,271 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Device Memory TCP
+=================
+
+
+Intro
+=====
+
+Device memory TCP (devmem TCP) enables receiving data directly into device
+memory (dmabuf). The feature is currently implemented for TCP sockets.
+
+
+Opportunity
+-----------
+
+A large amount of data transfers have device memory as the source and/or
+destination. Accelerators drastically increased the volume of such transfers.
+Some examples include:
+
+- Distributed training, where ML accelerators, such as GPUs on different hosts,
+  exchange data among them.
+
+- Distributed raw block storage applications transfer large amounts of data with
+  remote SSDs, much of this data does not require host processing.
+
+Today, the majority of the Device-to-Device data transfers the network are
+implemented as the following low level operations: Device-to-Host copy,
+Host-to-Host network transfer, and Host-to-Device copy.
+
+The implementation is suboptimal, especially for bulk data transfers, and can
+put significant strains on system resources such as host memory bandwidth and
+PCIe bandwidth.
+
+Devmem TCP optimizes this use case by implementing socket APIs that enable
+the user to receive incoming network packets directly into device memory.
+
+Packet payloads go directly from the NIC to device memory.
+
+Packet headers go to host memory and are processed by the TCP/IP stack
+normally. The NIC must support header split to achieve this.
+
+Advantages:
+
+- Alleviate host memory bandwidth pressure, compared to existing
+  network-transfer + device-copy semantics.
+
+- Alleviate PCIe bandwidth pressure, by limiting data transfer to the lowest
+  level of the PCIe tree, compared to traditional path which sends data through
+  the root complex.
+
+
+More Info
+---------
+
+  slides, video
+    https://netdevconf.org/0x17/sessions/talk/device-memory-tcp.html
+
+  patchset
+    [RFC PATCH v3 00/12] Device Memory TCP
+    https://lore.kernel.org/lkml/20231106024413.2801438-1-almasrymina@google.com/T/
+
+
+Interface
+=========
+
+Example
+-------
+
+tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
+the RX path of this API.
+
+NIC Setup
+---------
+
+Header split, flow steering, & RSS are required features for devmem TCP.
+
+Header split is used to split incoming packets into a header buffer in host
+memory, and a payload buffer in device memory.
+
+Flow steering & RSS are used to ensure that only flows targeting devmem land on
+RX queue bound to devmem.
+
+Enable header split & flow steering:
+
+::
+
+	# enable header split (assuming priv-flag)
+	ethtool --set-priv-flags eth1 enable-header-split on
+
+	# enable flow steering
+	ethtool -K eth1 ntuple on
+
+Configure RSS to steer all traffic away from the target RX queue (queue 15 in
+this example):
+
+::
+
+	ethtool --set-rxfh-indir eth1 equal 15
+
+
+The user must bind a dmabuf to any number of RX queues on a given NIC using
+netlink API:
+
+::
+
+	/* Bind dmabuf to NIC RX queue 15 */
+	struct netdev_queue *queues;
+	queues = malloc(sizeof(*queues) * 1);
+
+	queues[0]._present.type = 1;
+	queues[0]._present.idx = 1;
+	queues[0].type = NETDEV_RX_QUEUE_TYPE_RX;
+	queues[0].idx = 15;
+
+	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+
+	req = netdev_bind_rx_req_alloc();
+	netdev_bind_rx_req_set_ifindex(req, 1 /* ifindex */);
+	netdev_bind_rx_req_set_dmabuf_fd(req, dmabuf_fd);
+	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
+
+	rsp = netdev_bind_rx(*ys, req);
+
+	dmabuf_id = rsp->dmabuf_id;
+
+
+The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
+that has been bound.
+
+Socket Setup
+------------
+
+The socket must be flow steering to the dmabuf bound RX queue:
+
+::
+
+	ethtool -N eth1 flow-type tcp4 ... queue 15,
+
+
+Receiving data
+--------------
+
+The user application must signal to the kernel that it is capable of receiving
+devmem data by passing the MSG_SOCK_DEVMEM flag to recvmsg:
+
+::
+
+	ret = recvmsg(fd, &msg, MSG_SOCK_DEVMEM);
+
+Applications that do not specify the MSG_SOCK_DEVMEM flag will receive an EFAULT
+on devmem data.
+
+Devmem data is received directly into the dmabuf bound to the NIC in 'NIC
+Setup', and the kernel signals such to the user via the SCM_DEVMEM_* cmsgs:
+
+::
+
+		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+			if (cm->cmsg_level != SOL_SOCKET ||
+				(cm->cmsg_type != SCM_DEVMEM_DMABUF &&
+				 cm->cmsg_type != SCM_DEVMEM_LINEAR))
+				continue;
+
+			dmabuf_cmsg = (struct dmabuf_cmsg *)CMSG_DATA(cm);
+
+			if (cm->cmsg_type == SCM_DEVMEM_DMABUF) {
+				/* Frag landed in dmabuf.
+				 *
+				 * dmabuf_cmsg->dmabuf_id is the dmabuf the
+				 * frag landed on.
+				 *
+				 * dmabuf_cmsg->frag_offset is the offset into
+				 * the dmabuf where the frag starts.
+				 *
+				 * dmabuf_cmsg->frag_size is the size of the
+				 * frag.
+				 *
+				 * dmabuf_cmsg->frag_token is a token used to
+				 * refer to this frag for later freeing.
+				 */
+
+				struct dmabuf_token token;
+				token.token_start = dmabuf_cmsg->frag_token;
+				token.token_count = 1;
+				continue;
+			}
+
+			if (cm->cmsg_type == SCM_DEVMEM_LINEAR)
+				/* Frag landed in linear buffer.
+				 *
+				 * dmabuf_cmsg->frag_size is the size of the
+				 * frag.
+				 */
+				continue;
+
+		}
+
+Applications may receive 2 cmsgs:
+
+- SCM_DEVMEM_DMABUF: this indicates the fragment landed in the dmabuf indicated
+  by dmabuf_id.
+
+- SCM_DEVMEM_LINEAR: this indicates the fragment landed in the linear buffer.
+  This typically happens when the NIC is unable to split the packet at the
+  header boundary, such that part (or all) of the payload landed in host
+  memory.
+
+Applications may receive no SO_DEVMEM_* cmsgs. That indicates non-devmem,
+regular TCP data that landed on an RX queue not bound to a dmabuf.
+
+
+Freeing frags
+-------------
+
+Frags received via SCM_DEVMEM_DMABUF are pinned by the kernel while the user
+processes the frag. The user must return the frag to the kernel via
+SO_DEVMEM_DONTNEED:
+
+::
+
+	ret = setsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_DONTNEED, &token,
+			 sizeof(token));
+
+The user must ensure the tokens are returned to the kernel in a timely manner.
+Failure to do so will exhaust the limited dmabuf that is bound to the RX queue
+and will lead to packet drops.
+
+
+Implementation & Caveats
+========================
+
+Unreadable skbs
+---------------
+
+Devmem payloads are inaccessible to the kernel processing the packets. This
+results in a few quirks for payloads of devmem skbs:
+
+- Loopback is not functional. Loopback relies on copying the payload, which is
+  not possible with devmem skbs.
+
+- Software checksum calculation fails.
+
+- TCP Dump and bpf can't access devmem packet payloads.
+
+
+Testing
+=======
+
+More realistic example code can be found in the kernel source under
+tools/testing/selftests/net/ncdevmem.c
+
+ncdevmem is a devmem TCP netcat. It works very similarly to netcat, but
+receives data directly into a udmabuf.
+
+To run ncdevmem, you need to run it a server on the machine under test, and you
+need to run netcat on a peer to provide the TX data.
+
+ncdevmem has a validation mode as well that expects a repeating pattern of
+incoming data and validates it as such:
+
+::
+
+	# On server:
+	ncdevmem -s <server IP> -c <client IP> -f eth1 -d 3 -n 0000:06:00.0 -l \
+		 -p 5201 -v 7
+
+	# On client:
+	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
+		tr \\n \\0 | head -c 5G | nc <server IP> 5201 -p 5201
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 69f3d6dcd9fd..d9f86514aa1e 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -48,6 +48,7 @@ Contents:
    cdc_mbim
    dccp
    dctcp
+   devmem
    dns_resolver
    driver
    eql
-- 
2.44.0.rc1.240.g4c46232300-goog


