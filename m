Return-Path: <netdev+bounces-274420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJOuKp8mzmnElAYAu9opvQ
	(envelope-from <netdev+bounces-274420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:19:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB7385CF8
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 508A8304CE97
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444C3BB9F0;
	Thu,  2 Apr 2026 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee+ShTDa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="owHOynwE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD34331A53
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117892; cv=none; b=Tzruk19Z29w0VGCoEARSKhZM9VkxvTbFXLYrsA4vCIpfrACvkvpVx4auh6CamY0MZPS/OlveeWxJY50n+MjNrNAZgi3YYBE0rbMwKhp79oGp9Xq15ANXJEJTap2QQc1+1qKzTj7mwY6zIs78r35ge5lr7zAAq2yEcFeEC/UmoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117892; c=relaxed/simple;
	bh=NzXbQuc9ZBk4ObBGtzGs9iu2lFssJbUQBjuKFCUY22k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsdrFezH9EXCpFeZPb60uUbtstc3oQgmmKc4GilxUMZibZVgE8CX8X7Mk7SgDgEj3oTq/uGna4g665Mv49woXJFNvJC1lRQZfRE1zl6fGixe7FLLy8SlfCNUg1yldcJCYw/XOjFVMprShXd7K27A1uk1TtvIW4SzNlGlMGPjWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ee+ShTDa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=owHOynwE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775117890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDGMK8W32A9IJKOzV8D749M8i2eS/0zQjVDT1eVv+dU=;
	b=ee+ShTDaotIHVZmwm7wMtTBxWonWx9v8oqeRfbeMg5CHi/wOC2VTr7OJ2UeGr8lCU+scN5
	a73bM09TEh5cvBzFSnGpnbZKPaKvg+9oNL3FxNQ5PZa9MiXsv3mKXpLDkU97hdKSqUHPJK
	hrT5fQ75II2RGoHK1wSORNvECzsPtBg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-APHHf8SeOBSCLAs7D2J1uA-1; Thu, 02 Apr 2026 04:18:08 -0400
X-MC-Unique: APHHf8SeOBSCLAs7D2J1uA-1
X-Mimecast-MFC-AGG-ID: APHHf8SeOBSCLAs7D2J1uA_1775117888
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4852ccff333so6975635e9.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775117887; x=1775722687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDGMK8W32A9IJKOzV8D749M8i2eS/0zQjVDT1eVv+dU=;
        b=owHOynwEUJ9LbR2VCRKu8Zqb4/6FAPKGGM7+a/h/FVB07tQfYUjU3kzo/8+xpypoq4
         ljvB+IqRBc8HKl1RpuYg+/NQX69pzkh0t6oSW0NOTD/6DqO1/efgWYjcDEqLyQfCAA+9
         Rds6+MhubGmOIqomlc6gGUPwJjCPAWXguZZrF/d9FuNb42g97zBcg5JxXqRPhl0Bx4w7
         XeSFQVU7JR03MT63P3cYJRQEr8lUcqWyETPGWEXoOBpYF+hs+j+51ISPClsXZcHKAY/+
         JDjxqD+EYLklHTBq2FOji5jjPSJHO72E3c8n1BSneYvlUDGb2w7nWj5R5JH0epBOi64v
         t9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117887; x=1775722687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eDGMK8W32A9IJKOzV8D749M8i2eS/0zQjVDT1eVv+dU=;
        b=jwB4rmtfiJQlkJhIa3wSLdESjQp+XP7AWHUbGmV9vxAytTo1NEXbAtnFTi7fW53B5I
         3XQ05zNLhVi6WBrNl26JOrzFQnD1kdGpIbvtkD1vDPcyAWgJ0BJJi6kRjpC1Rk0MdPgq
         BI6JmImdED5l0csxPUaEmkm3g3LJe+6MEmDltgCJz3OEo1ilzy5oQTXVx3nCdP7yNBQq
         ihcnVaMbDXvr6Lp3cfwuNMnMbGgS0W4ju46BHAzp6WqgNPqTiMCyy6jtBTtNtYTtdVxp
         nxhcsSAz6ggdTFknGyO+s8lQpHhudCYsJV627Y6jLmQyuIjC0loC1g9sJrPLxCKkt70O
         8PlA==
X-Forwarded-Encrypted: i=1; AJvYcCXCO23CB826Tta0eVFqCXvoG71TttL7oDEoQw6tNbT7tOJVC7it58C/wGirRErZx7YKAyvIbac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84QHZj9o7RrhFSi+VUivD7ns5Gdf9Qi19E0oe8Dmij7DiCtXL
	1OFOZ5m6B0G6n9w1MwbD78oFo1JSE5kYjEbxzmD5JurO5r/Gm9OOMMXasTiEAQMs6liV4JjQpsE
	X+mupeuyDKc0I3Ve/lSEqnThjOtf6se607GOzdqmQgodn1EYU3285wabhnA==
X-Gm-Gg: ATEYQzxQHOnkLLkxOPBN1bL++xKalN4aDsUHILQ9QXiFJ+sZPey8UAkoO0gUeJBwciP
	87K4QhUVajILrnrfkINFEG8pz8c0NqDosEozeeZmlTePLq/9J2072e731IGkUTVehJuyojr4Po9
	wwA1ZbqJhGC9/OrYl7eRnISxjJ7ATbOcUsSiLYCuLNeA3yBI0Go69mO/IjJYb3qOr3qyaJ4g+jS
	nAfTWDcyY4amAq8V/LLPcOgSxlG1nBf7MmnuW6tbsLaargxB0dNdD9w+JOiAPXSt8+SR9XsCw2z
	weXQjHzNIkaEau4BkOeo8m+TYBGTSi92zgFBFMn0r6XPw6rFlqjsRD9hFtZJiu4yH2G+aVLfBUe
	tTICxyMZ6txLFFUyFB9aRnSAYyxNX7C16BdxtQH7zQOXxfeJTBGVIElf5y4jJ
X-Received: by 2002:a05:600c:8184:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-48883590456mr113866175e9.14.1775117887563;
        Thu, 02 Apr 2026 01:18:07 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-48883590456mr113865405e9.14.1775117887065;
        Thu, 02 Apr 2026 01:18:07 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm214476005e9.0.2026.04.02.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:18:06 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 02 Apr 2026 10:18:02 +0200
Subject: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
In-Reply-To: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
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
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-274420-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19AB7385CF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test that verifies MSG_PEEK works correctly after a partial
recv().

This is to test a bug that was present in the `virtio_transport_stream_do_peek()`
when computing the number of bytes to copy: After a partial read, the
peek function didn't take into consideration the number of bytes that
were already read. So peeking the whole buffer would cause a out-of-bounds read,
that resulted in a -EFAULT.

This test does exactly this: do a partial recv on a buffer, then try to
peek the whole buffer content.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 	return test_msg_peek_server(opts, false);
 }
 
+#define PEEK_AFTER_RECV_LEN 100
+
+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
+{
+	unsigned char buf[PEEK_AFTER_RECV_LEN];
+	int fd;
+	int i;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < sizeof(buf); i++)
+		buf[i] = (unsigned char)i;
+
+	control_expectln("SRVREADY");
+
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+
+	close(fd);
+}
+
+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
+{
+	unsigned char buf[PEEK_AFTER_RECV_LEN];
+	int half = PEEK_AFTER_RECV_LEN / 2;
+	ssize_t ret;
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
+	recv_buf(fd, buf, half, 0, half);
+
+	/* Try to peek more than what remains: should return only 'half'
+	 * bytes. Note: we can't use recv_buf() because it loops until
+	 * all requested bytes are returned.
+	 */
+	ret = recv(fd, buf, sizeof(buf), MSG_PEEK);
+	if (ret < 0) {
+		perror("recv");
+		exit(EXIT_FAILURE);
+	} else if (ret != half) {
+		fprintf(stderr, "MSG_PEEK after partial recv returned %d (expected %d)\n",
+			ret, half);
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
 #define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
@@ -2520,6 +2579,11 @@ static struct test_case test_cases[] = {
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


