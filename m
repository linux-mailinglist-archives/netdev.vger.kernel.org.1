Return-Path: <netdev+bounces-79547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E975879DC5
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D41282B27
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946214533F;
	Tue, 12 Mar 2024 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JkleoP2c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578651448E1
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279883; cv=none; b=en/z/z34IMyvnZ/anGr5iGfrYK0WUAiPIvBcriZYrJUbrqt0qg7uRawRZnMdCHoho35zyt2H71TFHSG9WaKltK5mZ7bsb38MSMboS4T+ZDpvMbAjUgj5DP82FNow6s2w8f9pP4vghiXMg0OBeeLz2LMsvJsq8d+XwEZNKJopC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279883; c=relaxed/simple;
	bh=B6RRKQIm2WKzMYtzsA77lI1a0FvklUtMlXfjfN0wIbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNIp9X5ejHtEKHSUM0H/9lHv9+hD491Yi5U5Zwskr1bLQW6M01XiYnFkmxhrH92XtKjvtXHRc49krgTMGfKTV6vCV5KYCA2MxqbO4DuybY5ye23OJNJIjSjuILdPbL+74d5tRtiw9lXaLQ8UkgwIcBgyrkxIo4dEkUN+ZEMlpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JkleoP2c; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd9066b7c3so3118385ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 14:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1710279882; x=1710884682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj0cYgShXYH5VhmSnGepet0UkxqjvpM473hZF/0XZ3c=;
        b=JkleoP2ciwhG1a0lGMoEm507wXF8Rl4UE4M6rxhXOsvkkiMXsDIzDMZXMbq5xXteJ4
         r7xqc8Wg6WtHDXh3HUEK0pPzqVXK1CxkyVNM6dm8aI6MFHyF21yrdx52HPuoehDCYeZB
         ml5/Ls6v2tI1yb4/TPBmpzXXa3F/KGwrXfJFVgtNKp8njXrWz+m6XfDpqQwlhFx3ooev
         Mv2ip/9QeQuZy4pOgaBk/66zok6u9+pYm//2jbqgeyphMT2XTIuxxoexCRcEYPtgWEYv
         BoeO31snbw/44oXtBy+sD65qfkd/ND0lQzgWBfDbqD255LQahE0xumGXvgRWR96zeaRd
         RVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279882; x=1710884682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rj0cYgShXYH5VhmSnGepet0UkxqjvpM473hZF/0XZ3c=;
        b=vd7AeZIGTIC9KqXR/6iSCE+GiCl8umRaZsO01rJOUyesduZUTnalxbN+cYlNacKzaE
         SAku6UYmp8HM/jfDxZBVQWT2USlUTVqxI+i2yXdbRoATs042na3/ywmh6z3+jH6vl9MO
         G15BU6P/uCFwgNaNImWLlnyN0k7GyHyiEQD0p9lEcLFUVnCTRXvE6mUI8+s/eiAyfuQA
         GWNIRXNjORSNY0P9ld3ol9J5JCQeeERV/S1w/ZPcWRfO9jrWCOlAh5g4LEgZh1uL1/v9
         oT8Rv2UPpKoSG+oeWfTQIPRvcHx+quOtLPnXe7N2iJ39ZMl7VLZIJmv8Cg9DPFRYtBFI
         gAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXiEf+JvH0XUqjkiut4ZovkdcSPJZxtw0Bn9efRmEUQGEJbMHwHx0q7P4gMeY2WUKEx+DItdmrkPDt2NkquUQ4zKhCSKUq
X-Gm-Message-State: AOJu0YyXXRfvmaNqWbl02VD6/DJp58jvbz7mcs50DZzZSipzUAnYCw5S
	vsZW2gKnaaheFpZZs0sr+1Imf4s36cpGfvx4enD9hdPPS98G3W0rXI9Y/O38gjRVL1XRsmi33qZ
	V
X-Google-Smtp-Source: AGHT+IHXWW1fnHlG+Rl1vWCNUw0xrcw6qZRHYrzDZb+F06rysW+Ft1xEAXTu1TEH4AuY3fi9w6AfTg==
X-Received: by 2002:a17:902:f68b:b0:1db:e74b:5bbf with SMTP id l11-20020a170902f68b00b001dbe74b5bbfmr5003902plg.0.1710279881660;
        Tue, 12 Mar 2024 14:44:41 -0700 (PDT)
Received: from localhost (fwdproxy-prn-017.fbsv.net. [2a03:2880:ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e80c00b001ddb73e719dsm2049257plg.27.2024.03.12.14.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:44:41 -0700 (PDT)
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
	Mina Almasry <almasrymina@google.com>
Subject: [RFC PATCH v4 08/16] io_uring: setup ZC for an Rx queue when registering an ifq
Date: Tue, 12 Mar 2024 14:44:22 -0700
Message-ID: <20240312214430.2923019-9-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312214430.2923019-1-dw@davidwei.uk>
References: <20240312214430.2923019-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <davidhwei@meta.com>

RFC only, not for upstream

Just as with the previous patch, it will be migrated from ndo_bpf

This patch sets up ZC for an Rx queue in a net device when an ifq is
registered with io_uring. The Rx queue is specified in the registration
struct.

For now since there is only one ifq, its destruction is implicit during
io_uring cleanup.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zc_rx.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/io_uring/zc_rx.c b/io_uring/zc_rx.c
index 6987bb991418..521eeea04f9d 100644
--- a/io_uring/zc_rx.c
+++ b/io_uring/zc_rx.c
@@ -4,6 +4,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/io_uring.h>
+#include <linux/netdevice.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -11,6 +12,34 @@
 #include "kbuf.h"
 #include "zc_rx.h"
 
+typedef int (*bpf_op_t)(struct net_device *dev, struct netdev_bpf *bpf);
+
+static int __io_queue_mgmt(struct net_device *dev, struct io_zc_rx_ifq *ifq,
+			   u16 queue_id)
+{
+	struct netdev_bpf cmd;
+	bpf_op_t ndo_bpf;
+
+	ndo_bpf = dev->netdev_ops->ndo_bpf;
+	if (!ndo_bpf)
+		return -EINVAL;
+
+	cmd.command = XDP_SETUP_ZC_RX;
+	cmd.zc_rx.ifq = ifq;
+	cmd.zc_rx.queue_id = queue_id;
+	return ndo_bpf(dev, &cmd);
+}
+
+static int io_open_zc_rxq(struct io_zc_rx_ifq *ifq)
+{
+	return __io_queue_mgmt(ifq->dev, ifq, ifq->if_rxq_id);
+}
+
+static int io_close_zc_rxq(struct io_zc_rx_ifq *ifq)
+{
+	return __io_queue_mgmt(ifq->dev, NULL, ifq->if_rxq_id);
+}
+
 static int io_allocate_rbuf_ring(struct io_zc_rx_ifq *ifq,
 				 struct io_uring_zc_rx_ifq_reg *reg)
 {
@@ -49,6 +78,10 @@ static struct io_zc_rx_ifq *io_zc_rx_ifq_alloc(struct io_ring_ctx *ctx)
 
 static void io_zc_rx_ifq_free(struct io_zc_rx_ifq *ifq)
 {
+	if (ifq->if_rxq_id != -1)
+		io_close_zc_rxq(ifq);
+	if (ifq->dev)
+		dev_put(ifq->dev);
 	io_free_rbuf_ring(ifq);
 	kfree(ifq);
 }
@@ -79,9 +112,18 @@ int io_register_zc_rx_ifq(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
+	ret = -ENODEV;
+	ifq->dev = dev_get_by_index(current->nsproxy->net_ns, reg.if_idx);
+	if (!ifq->dev)
+		goto err;
+
 	ifq->rq_entries = reg.rq_entries;
 	ifq->if_rxq_id = reg.if_rxq_id;
 
+	ret = io_open_zc_rxq(ifq);
+	if (ret)
+		goto err;
+
 	ring_sz = sizeof(struct io_uring);
 	rqes_sz = sizeof(struct io_uring_rbuf_rqe) * ifq->rq_entries;
 	reg.mmap_sz = ring_sz + rqes_sz;
@@ -90,6 +132,7 @@ int io_register_zc_rx_ifq(struct io_ring_ctx *ctx,
 	reg.rq_off.tail = offsetof(struct io_uring, tail);
 
 	if (copy_to_user(arg, &reg, sizeof(reg))) {
+		io_close_zc_rxq(ifq);
 		ret = -EFAULT;
 		goto err;
 	}
-- 
2.43.0


