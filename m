Return-Path: <netdev+bounces-275920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI55Le7K1GmtxgcAu9opvQ
	(envelope-from <netdev+bounces-275920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:14:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BD03ABCBC
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8F79300616C
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037D3A6B96;
	Tue,  7 Apr 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dep0sHNL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fY9eb6h4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A839C018
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553250; cv=none; b=XWIehoja/gpFpNYIH7uAQDoyjg49PfGmtmFj8vJ8xh7y66y0UDv5G9My5jzdyEPt6EbcMeZAmocY7KnTyfxRN6q2Qz91gJpNwGVkuQbBhc9YecNva11izRvwLyqKp48kYOF/aTu1kJWeU8D/VoBgdwPD/ubLQqoW/lTb3GBWw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553250; c=relaxed/simple;
	bh=ip2wtGgcP4DvQiglidvGP+GnoassWfKVZlJvs+MlGRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sTmU68k1tfBIop7pxqh2WVVPQH8yucb2bq/KeqfecThC2InxxZSHpxBhC1/kA1RUG5/vWWg5SpNsAyZMTA5cwNnZ7NpNjQNfoYp8o0E4MUoFHeFz1q5WPjSLu7hpO9iqHbJ+aNpfgibHQxC7dAALLW5T4222TNNJDWWLL92+BZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dep0sHNL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fY9eb6h4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pofFwwc6ykPOXmyxDteFf7vraGRelyLMlwG/8lag20=;
	b=Dep0sHNLxICjsbyO3iSiNVFL9gPa6ldEDyrdBzY2e8QKq/W4rUXySaGa2EmgVIUzFRohQ9
	CvfUAIy3ywiuZIuGDPyrBDiALP5fuj+S6ZDQi8xLISoTGcUonGMzW6iQ3odocss0pESxao
	KANIfsZXlJNkwoQG4t6KHvlif8EuoMw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-bVIpim7qMwmN1YAdFqc_uA-1; Tue, 07 Apr 2026 05:14:06 -0400
X-MC-Unique: bVIpim7qMwmN1YAdFqc_uA-1
X-Mimecast-MFC-AGG-ID: bVIpim7qMwmN1YAdFqc_uA_1775553246
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4888b17ffa6so38444405e9.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775553245; x=1776158045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pofFwwc6ykPOXmyxDteFf7vraGRelyLMlwG/8lag20=;
        b=fY9eb6h4x/t00R4VcEiVmNVRumeGOI0SoU4s9EV4GpkrcPUVzgfmnZyvvf/xarfwPY
         Re3s/68iclRT9X7q+EygTPq0taKK3LJUDGtUCI98kSZJbRkJZyENQ87/PhQs/log/ZMZ
         x9XPE1PN2bVfPj557zNQfdWUnzaAnEzBjqb/B7ddEofhGA3604TL2yFc84x81bcqmukd
         G10wtsZPUsS5JV5qKKIqGhF+mtpmJvJs1see7enSLTkt1qouqx+8HFMAf+Axg+osAO9K
         QnBQz/k7uGVxPvfbzO8UVsO+0AwbItgm2b7qxMIhFYzT8qGoKRBohNXntqsuv0pHBrr9
         oWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553245; x=1776158045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5pofFwwc6ykPOXmyxDteFf7vraGRelyLMlwG/8lag20=;
        b=HEUe2So7kaELOAAZBjCdTQTGaTWTBwp7ObTTpy2gRWOEQO0+k8MnOsH71yL3TVUwT2
         XqfS7AbpCEd2/0/7bPWiHdyudWewtuQ5y8d51U4vdHETLlYoEIDonmwbWb0KK9t8OaIk
         RvvHt/tg8CI20wqOtp3/m1jyhuz+2b7tZMrfC8p7aVkfEhc3Km9QmU9yP8Tmi1iSpBAR
         N6LbwzAWrUaqsSFrz3j+cutlhTVjY9CPXFl7XZGrvIbQbp5PcoyD29WLpwZ8IPI+sHxe
         pstis3XvCL0R9Gzb4SoaOyhCbKL9T2J5T1zNdIZ1eHY0woYmuCv7uvG9N6Bcv6+dnYNj
         +d0g==
X-Forwarded-Encrypted: i=1; AJvYcCVM2WFhscXf+vjnWUB/A+fopXFVeVZ3q0l9m68svhjGTR2uNxNYJEl4fl6s0H8QzkRT6cuioZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKj/zEGZib3Q/nK3XpewQ2KRUcIz4d2NqFErtl9Rzl9ty9oyOs
	aQ6elEz+Z1T51zS4NdbQ+T+76rDLNis+cQC0qDCpCg5XpNwAkX0fy3w7BaUbQLRH/lsMB0webFq
	OUPKNiXUiIH0r5L99MTG22WF1q5F3QZ4NngPN31fWWYNPwCjudk628ku9crkyx+6PqKR77WVPJ4
	2JkreH61fDN1kSorroaHMbbxecw1s6TAkMNYjfx1PVEu+O
X-Gm-Gg: AeBDiesP4cKzmgvT3FC1/OGQ4YJjixap6A8XJrWKM0SKaD3nKwBtLbqRVtQBeUBv7w+
	BgtsuCmIudxIajNqnSEx/475/fnFN0Q7N7ajaIGMlH5tWIqImsLp51ZKv7vGh5RxTbMVJ7lOzYr
	wbqzxjWPPvPwsjP4g70r9cb/PmQ/3j/AmbrS2SmLkLM3vEigP5KxE9Apg6pbWNU3R1RieYWff2E
	Q03jbon4tB+upuVnVNLFfbSUbHICIc8F7QyRfYxQRcjOl9Ps+bgyPggKb8OgMHal1pZVZDHiPhr
	lgRR7f+g0oYNZ7/2bATVCnM5xNSdx2LyYAYQcIzl73QFAOnJZ72VRzH4kCfGHakJriIr4XktE/H
	CSdlm7cuEvJv7F86r7oBDrU+gVKtSkTHkLTra0h/y6e1LF5mZ71rH+wjAOsyo
X-Received: by 2002:a05:600c:1d86:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-4889970d844mr239703895e9.11.1775553245460;
        Tue, 07 Apr 2026 02:14:05 -0700 (PDT)
X-Received: by 2002:a05:600c:1d86:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-4889970d844mr239703185e9.11.1775553244880;
        Tue, 07 Apr 2026 02:14:04 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 11:13:57 +0200
Subject: [PATCH net v2 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-fix_peek-v2-3-2e2581dc8b7c@redhat.com>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
In-Reply-To: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-275920-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 74BD03ABCBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test that verifies MSG_PEEK works correctly after a partial
recv().

This is to test a bug that was present in the
`virtio_transport_stream_do_peek()` when computing the number of bytes to
copy: After a partial read, the peek function didn't take into
consideration the number of bytes that were already read. So peeking the
whole buffer would cause a out-of-bounds read, that resulted in a -EFAULT.

This test does exactly this: do a partial recv on a buffer, then try to
peek the whole buffer content.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index bdb0754965df..d38a90a86f34 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -346,6 +346,44 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 	return test_msg_peek_server(opts, false);
 }
 
+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
+{
+	unsigned char buf[MSG_PEEK_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(buf, 0, sizeof(buf));
+
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+
+	close(fd);
+}
+
+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
+{
+	unsigned char buf[MSG_PEEK_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Partial recv to advance offset within the skb */
+	recv_buf(fd, buf, 1, 0, 1);
+
+	/* Ask more bytes than available */
+	recv_buf(fd, buf, sizeof(buf), MSG_PEEK, sizeof(buf) - 1);
+
+	close(fd);
+}
+
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
 #define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
@@ -2509,6 +2547,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_tx_credit_bounds_client,
 		.run_server = test_stream_tx_credit_bounds_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
+		.run_client = test_stream_peek_after_recv_client,
+		.run_server = test_stream_peek_after_recv_server,
+	},
 	{},
 };
 

-- 
2.53.0


