Return-Path: <netdev+bounces-302186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KXlsNFSDPmptHQkAu9opvQ
	(envelope-from <netdev+bounces-302186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:49:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 420E46CDB43
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:49:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Z8WMcu1G;
	dkim=pass header.d=redhat.com header.s=google header.b=DNp0OsRj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302186-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302186-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CD10306FD7B
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008A33F823A;
	Fri, 26 Jun 2026 13:48:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70A3F7AAC
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 13:48:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481720; cv=none; b=jkwoKM4oa3oAavT/xwMTzy8r/xP2c14C05tFuMwLEpWynyI9M8w9Iz8X3Kqhn1vStPm5rDzbLs6nupEXDSKIK26FQC+DDtzfGllQSydc71lPGY+f3E+j28f7mPCPh/rP89Yi1RYA1uzj//9OvHf1WD9wB3s1xHse3fQQI+KQOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481720; c=relaxed/simple;
	bh=h6wI67WE4wGINnOp1v4qFtLNzEeCT9OncC/LXQiBsJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bej9EaroZ9arieE0eISLPan5fIA3+GN5gOjKByqpfxnQt/7gHMgHL7gGenE3v34I/+AxDCBbiq36Bvr2B0/JURNpDttxCnthnA8Uzj9UJ9zyQNn/eRDe/gVhTLCHGCzy/It+4CPCrw05/HOl2FqJQun+y4RqyywPcU/7DKnlWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8WMcu1G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNp0OsRj; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782481718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+x55wPutcqcllhjFEZvXEglHQBic+9gv93y+ngfVIU=;
	b=Z8WMcu1G00ziXPxDt5oL2HnBrHNr56fg6wwVCHe3fNtnX53iw120nHUmFx63C8no6+kbcu
	d0lpW6HOzGNyoVgo3t416P+D5PvbkIBO6NorSXpLeCNU2vATb3A6prZ+1BLg7OMGx0CFuq
	JzGb7HRsAOnXdTKgADGtk3FyLWiILdI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-qhqEpBllOKy74tVGJMIVsA-1; Fri, 26 Jun 2026 09:48:37 -0400
X-MC-Unique: qhqEpBllOKy74tVGJMIVsA-1
X-Mimecast-MFC-AGG-ID: qhqEpBllOKy74tVGJMIVsA_1782481716
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4924207e640so7691815e9.3
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782481716; x=1783086516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+x55wPutcqcllhjFEZvXEglHQBic+9gv93y+ngfVIU=;
        b=DNp0OsRj3dogNcEviKvO2X5Zt+4Q5Jib1FpAtArSbEJycG7k3zNDdJts+Firx1yphb
         lJZfnjYprRWBCTT70Epmm+zEefLSVKy4jRsmAR0d6nfZaFfNDbiHfvT5+AXR/EvBod0C
         VLYjen95C7Zf5o/t4zhGJnObwUQ1B2HlEON4VpCSvFoSHvj319Gi5PLTlWCteCpKhpeu
         psH12XqOXkbnN9dEBJ8WFt6kNQzjLViG3UrLT0QRdlGsiHRvYhIDH7yNJWKXvxf1vWvM
         Sh7qfnrOWuXWbyYcj6GceK/09Wia8Zu4ZWXY40SBAqAC7/Vgyy13tbrptl57Pw4BO74C
         T3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481716; x=1783086516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+x55wPutcqcllhjFEZvXEglHQBic+9gv93y+ngfVIU=;
        b=nhPzIsrMgKMa5l/amXp/MicegcGRPriTeTSIbZ6HRkQxrVGp/CJK9a3kQAFbji7PYy
         lf5CNs6iAsw1cfSr9nmQBepZh9lRu7QvSvzgyIVLOGeqXBcyQf0PQqB9uxpnVyw/aVH0
         T6HIpeGyKKZEhJK9OpFLK/OIIiQF3uG6F8VJf2V0gwBplnO2JaWT5BH8TTvuFK0Feiiq
         pLPC/vGiwY/ybvy1pm92M+nnj3ksENKiyyuueKUSGLCQKMkpUjTjYwSsnNH9TNdHiQPN
         GsMhs79uz97+CTvLdjGhLQ8FLZ5dUKvBhAnqEXhDjq6l+q7gA+DJLNnHFbuRFvkm/W3d
         +9uQ==
X-Gm-Message-State: AOJu0YzfxpsR/XIWqsD821UaGW7OTTYSoUl3FrttkvTyEflu6WSwPeXT
	kttMKEKe5W4lMj8pHOjnRvZjF66/Rq49Z+NWGJ5y0MYb6juuoao2/dtAbZceh7EoaUOJJkokyoT
	r2PwM0VJiqiVKwaNF96HjNWUepUYid6OlFgnnNj+FGbuJPc3s0m2zQFHw3CaS1fDsJwCFHsuWJ2
	LYvIiVp7zNhjp87HgobQbaT6NccgOsjbsk4Y29bj4/7Q==
X-Gm-Gg: AfdE7cm933ZdUNI6wzZBvI5AU3YU4UNJIe3D6lMBXYWVbnx3bOaw1wao8hqRjiq4Tek
	1h7j106owFch8EWE61o4tnQ8zsi7v9pi5QVP1l/Ba7ROM4Aylgmu473z64Z/wduCQQuQgL+13H8
	xtzZkE82lhcmgfBu4IAv6bgE9Vi6fqIeLvNDKxgQ/kKOTOdoC42ZMpB+5d29zdjtySLSiKhdSYN
	gRtTan81lf0t3KkjDoAYlu8OlmkbaN+xno6yCdDh519fBznczw0bZOYUq2HmJYDD2UlQNgwOY3A
	nE9LWqRRbme2OQxCMc4gTtj7nvoNleILwpRZcI8pXvyICUDSHwh4X8AaBFPEtOkNXBbpTe83YVy
	6kPAPYaZV32EWFpBpzF8sjUHHirLGoBxmkyeLSF5mqfMhGc0=
X-Received: by 2002:a05:600c:1383:b0:492:46c3:c7dc with SMTP id 5b1f17b1804b1-4926fc3a838mr14856665e9.14.1782481716123;
        Fri, 26 Jun 2026 06:48:36 -0700 (PDT)
X-Received: by 2002:a05:600c:1383:b0:492:46c3:c7dc with SMTP id 5b1f17b1804b1-4926fc3a838mr14855905e9.14.1782481715451;
        Fri, 26 Jun 2026 06:48:35 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46dcbac0c9dsm15336242f8f.19.2026.06.26.06.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net 2/2] vsock/test: add test for small packets under pressure
Date: Fri, 26 Jun 2026 15:48:23 +0200
Message-ID: <20260626134823.206676-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626134823.206676-1-sgarzare@redhat.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302186-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:horms@kernel.org,m:sgarzare@redhat.com,m:linux-kernel@vger.kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:eperezma@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 420E46CDB43

From: Stefano Garzarella <sgarzare@redhat.com>

Add a test that sends 2 MB of data using randomly sized small packets
(129-512 bytes) over a SOCK_STREAM connection. Packets above
GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
forcing each one into its own skb.

Without receive queue collapsing, the per-skb overhead eventually
exceeds buf_alloc and the connection is reset. The test verifies
that all data arrives and that content integrity is preserved.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 87 ++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 76be0e4a7f0e..b4ff9f946565 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2347,6 +2347,88 @@ static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
 	close(fd);
 }
 
+/* Test that many small packets don't cause a connection reset under pressure
+ * and that data integrity is preserved.  Packet sizes vary randomly between
+ * 129 and 512 bytes, above GOOD_COPY_LEN (128) to bypass in-place coalescing
+ * in recv_enqueue, forcing each one into its own skb.  Without receive queue
+ * collapsing, the per-skb overhead eventually exceeds buf_alloc and the
+ * connection is reset.
+ */
+#define COLLAPSE_PKT_MIN 129
+#define COLLAPSE_PKT_MAX 512
+#define COLLAPSE_TOTAL (2 * 1024 * 1024)
+
+static void test_stream_collapse_client(const struct test_opts *opts)
+{
+	unsigned char *data;
+	unsigned long hash;
+	size_t offset = 0;
+	int i, fd;
+
+	data = malloc(COLLAPSE_TOTAL);
+	if (!data) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < COLLAPSE_TOTAL; i++)
+		data[i] = rand() & 0xff;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	while (offset < COLLAPSE_TOTAL) {
+		size_t pkt_size = COLLAPSE_PKT_MIN +
+			rand() % (COLLAPSE_PKT_MAX - COLLAPSE_PKT_MIN + 1);
+
+		pkt_size = min(pkt_size, COLLAPSE_TOTAL - offset);
+
+		send_buf(fd, data + offset, pkt_size, 0, pkt_size);
+		offset += pkt_size;
+	}
+
+	hash = hash_djb2(data, COLLAPSE_TOTAL);
+	control_writeulong(hash);
+
+	free(data);
+	close(fd);
+}
+
+static void test_stream_collapse_server(const struct test_opts *opts)
+{
+	unsigned long hash, remote_hash;
+	unsigned char *data;
+	int fd;
+
+	data = malloc(COLLAPSE_TOTAL);
+	if (!data) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	recv_buf(fd, data, COLLAPSE_TOTAL, 0, COLLAPSE_TOTAL);
+
+	hash = hash_djb2(data, COLLAPSE_TOTAL);
+	remote_hash = control_readulong();
+	if (hash != remote_hash) {
+		fprintf(stderr, "hash mismatch: local %lu remote %lu\n",
+			hash, remote_hash);
+		exit(EXIT_FAILURE);
+	}
+
+	free(data);
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2546,6 +2628,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_msg_peek_client,
 		.run_server = test_stream_peek_after_recv_server,
 	},
+	{
+		.name = "SOCK_STREAM small packets backpressure",
+		.run_client = test_stream_collapse_client,
+		.run_server = test_stream_collapse_server,
+	},
 	{},
 };
 
-- 
2.54.0


