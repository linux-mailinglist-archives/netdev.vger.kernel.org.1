Return-Path: <netdev+bounces-278820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLK8LIuq32mOXgAAu9opvQ
	(envelope-from <netdev+bounces-278820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:11:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78824405B8C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 327E6302AF06
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC96B3DC4DA;
	Wed, 15 Apr 2026 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyXobKPU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o2A2d6F+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EAA3DBD4C
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265790; cv=none; b=PjEPSvQ8Qcr614qRlt/1VuSk5qp065Dgm47STJ68TIM8AJLlcYfvlPJfuG86ihWZoq23RWJiTzaf6P7I187FiXr+XR0jj319Ck7N5pZgfU1YZzlsuYd1CLqE6X4YejFiI1UrnQkT3EZQvOn0X6AQdjUIhabkVnH2vHC3+hYNdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265790; c=relaxed/simple;
	bh=LicrGY4V+zsv5KZ7wlpKw3NN40iL41s8FOtyi0yIhNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBWzCvdrozjaNxYaaRoVWMq6SyLPgdk+5gJyYuwYxi5dZ1hJtfn5R5PXJQwgQgnA96isJqns8C4bLQTBRiuGnE7UZEe+VyB2podiYQFsaeACHBTiyGCpL0IxkFTB6jxtBmOzfcZmxBCjgDbVB1OM7KyO/nUypnO3bWNPAKcNQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyXobKPU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o2A2d6F+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKxh1xV1gWd+m52UTAHmFCb6N+6HL0A4jah73SCv02s=;
	b=dyXobKPU3JTxpqO7pJAwggxD2XE52pYdqlpL/Owv/dSgfrUpZpMcKytlchoLq90+KcJ0KX
	Yxtk5Aei5dcueg9SU16tOJwg1YBEpODykIrWMyzaQEK8Zq3fUuak6ztfO9Ic4YUmjPiuGC
	iAoVgZjvv6D0kualSkVjqlM2qg9NKME=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-VEH70OBMP5uZFYmCFFYVQA-1; Wed, 15 Apr 2026 11:09:47 -0400
X-MC-Unique: VEH70OBMP5uZFYmCFFYVQA-1
X-Mimecast-MFC-AGG-ID: VEH70OBMP5uZFYmCFFYVQA_1776265786
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d780757eeso2154693f8f.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776265786; x=1776870586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKxh1xV1gWd+m52UTAHmFCb6N+6HL0A4jah73SCv02s=;
        b=o2A2d6F+75vl5Ap9D8rf4PS4GkwQlkp8oaYJoChMnv8akyPduPm/7tFmSEBy3UgzUu
         n8YO5kpxdw9wuAAPV1UlrzOAm5s5vCcBt6QUaF4eGqVhmlu6L6to1SIXOL6BjK3U/s29
         RpuK2p4t7gEnLzB3vzZUuDd4iAK/YSm4/WDGvKkvY+tt4s7Gt10ICHp0vv7magaGi5HW
         Cb3bI48NL1+4MLNFxAOu09XejI4vkftZnaUfrxqUngI/Do4Qz9SGAtoZ9Er9yKOoorvN
         ecOXYNMICPoyLy3m5n+GTpV4c59sRT2uYtifpCSWIQHhviK9LKMD3qmmX/aXukRYEVtA
         YwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265786; x=1776870586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKxh1xV1gWd+m52UTAHmFCb6N+6HL0A4jah73SCv02s=;
        b=EBTXEXM3XougApTpTaukP3fbuMkYlcKel5SlDi4eIpLsCiQQ71VAGSehJR4K9TFjdj
         zgfnl2nOcTcptj7Ys6xXfZOq737HWwbdXJqG08qPPk/UGZ9y00/8VDFMdKFq/X3hcet9
         MPGfwG8i0E1Z2pxfJvlSOawf4zkT7q10lzWGHvRgf6d97MQWnBj1vjfwb6BnEBGPE0h0
         cpahRRbUjq2krcCpLBY/5CDLmvSbZ5Es1CmeXmLcaP5lG4YhWuGdFUf0H0TVLp0oYdvR
         P67S6XgaoNkLY9nP3jeMrKZbt2HUYaxJdzJD8XfA31tvE6x0Ky7bqj2h5rC6mY/qoScf
         913w==
X-Forwarded-Encrypted: i=1; AFNElJ+GsrefAYSry2EO4FAtEvJ0bhqntWimcaSsPVdGiImIDScZ2pfBqtIw6DeFPiASpDrNeMat380=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ot9mniUh4C0W9acE/6AUy5UPEr62HNaWw0IagpjHOKGiovgU
	6gTMzvXrH3kOe08qV2kIwkxUkgoPkt08hL5fK96J2MW6umubIi9h+33kMq3lYD70QhVy8f4uImx
	91ZXdJX1inpraR9YeRNVPj2oU97xz5ZLIfFrYtu2F+1uEBz6O8xvTTex3iw==
X-Gm-Gg: AeBDieteTovW1hawdeJ6HWY/ibPMFxw5kHmlTbCWo3Li+ysZdrNglAkcg4IxXCZsx13
	f7iN2J6nT7+OjL4dDyjwiNdiM9gYdkgIfYYwFU6rLcfukMvYBhwqasmqmZwCDiM/odZVX3bgBSS
	BlYfcgZ53Kx7x8UQPPu0tjqm4pubrPgvL6T3dvFDG6nNHR+hjAOpB0gb1JvQsnFdY/Qh6Z5m3G0
	SzHEmShmAHMSj6MI60UbTHHvqOUdpS9RfCKxitkb+6MHkx4akMOVeUa8jiCBLcC2TE7Ey4C/Jmw
	kYKpBScDuBFaMDpQV8eGAgojYL9gEbmiQShp00MT0ykJAdYlZoZ/0XWF+HEDF1nNWkeLNnZGSh5
	iNYIrPKynxw2QZlBsbgUfDa5JLCiy5gxWlJzuHCm2F9BrpizjeM1prk/IQSdr
X-Received: by 2002:a05:6000:2a84:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43d7a5e8360mr12790589f8f.15.1776265785707;
        Wed, 15 Apr 2026 08:09:45 -0700 (PDT)
X-Received: by 2002:a05:6000:2a84:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43d7a5e8360mr12790549f8f.15.1776265785199;
        Wed, 15 Apr 2026 08:09:45 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:43 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 15 Apr 2026 17:09:30 +0200
Subject: [PATCH net v4 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-fix_peek-v4-3-8207e872759e@redhat.com>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
In-Reply-To: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-278820-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78824405B8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test that verifies MSG_PEEK works correctly after a partial
recv().

This is to test a bug that was present in the
`virtio_transport_stream_do_peek()` when computing the number of bytes to
copy: After a partial read, the peek function didn't take into
consideration the number of bytes that were already read. So peeking the
whole buffer would cause an out-of-bounds read, that resulted in a -EFAULT.

This test does exactly this: do a partial recv on a buffer, then try to
peek the whole buffer content. The test re-uses
`test_stream_msg_peek_client()` to also cover this scenario.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index bdb0754965df..76be0e4a7f0e 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -346,6 +346,38 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 	return test_msg_peek_server(opts, false);
 }
 
+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
+{
+	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
+	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("SRVREADY");
+
+	/* Partial recv to advance offset within the skb */
+	recv_buf(fd, buf_normal, 1, 0, 1);
+
+	/* Peek with a buffer larger than the remaining data */
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek) - 1);
+
+	/* Consume the remaining data */
+	recv_buf(fd, buf_normal, sizeof(buf_normal) - 1, 0, sizeof(buf_normal) - 1);
+
+	/* Compare full peek and normal read. */
+	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek) - 1)) {
+		fprintf(stderr, "Full peek data mismatch\n");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
 #define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
@@ -2509,6 +2541,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_tx_credit_bounds_client,
 		.run_server = test_stream_tx_credit_bounds_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
+		.run_client = test_stream_msg_peek_client,
+		.run_server = test_stream_peek_after_recv_server,
+	},
 	{},
 };
 

-- 
2.53.0


