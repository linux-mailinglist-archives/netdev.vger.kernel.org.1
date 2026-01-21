Return-Path: <netdev+bounces-251826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJkaH6igcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:47:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B5254A42
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E84EC5E5C54
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4733F47AF75;
	Wed, 21 Jan 2026 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITou7ufz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jr0qjS68"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E10478848
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988208; cv=none; b=kIwIWUU/FU2BtWGVebhDEtpCCW62daxPalqBEPVzeFB4YmqriJXX4zw7sPiWsBYlKEfEO5FBmsHYjwGl8pDE2DPQ97A+yw89zCZyn90UY4PkLRccqPAVM/2gyIV51ek9ijJ1RQZPX6926NkFvADsRQuaI7nj4h3nxH0syUhtKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988208; c=relaxed/simple;
	bh=PcAOc3r6px2QPynOOTZs4aSgXDaZ3NGUJGTa4O51yqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrVR+hto46K7PmzutKRqniILV5rahyxdb/g2nbE7YcfmVWCuZGoeNKs2ewK/FYXb8EqmhFI+nn8Yy1DDYBPp7EM1sSljDXUgDhNeQZw1YD5p4kLatr55xWoXkMZ1zn1w3/1mEBsag7uwlPfxxXaeTIfmCNqYFFvGSv73ZOdZtD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITou7ufz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jr0qjS68; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zDKTURxMpN1giCRjW7fiv4qni6ys721eKds24IdkTk=;
	b=ITou7ufzLDLpgwlVKRe57PAI4bzmFefP7nf27m17TkKArI68+ekv/qx6J2ORCpcJVKQ4oB
	hnXQEHZUlKTbvVeX3EWMptWBVGw9jmFuzIEdqAurMnCP0NqJcp108EjVeDIVnBfDzJWcTc
	BSezKEzhxjJi6885or+5/m8yrF8NJP0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-0G-JZisAPPW-uDlzsKjuxw-1; Wed, 21 Jan 2026 04:36:44 -0500
X-MC-Unique: 0G-JZisAPPW-uDlzsKjuxw-1
X-Mimecast-MFC-AGG-ID: 0G-JZisAPPW-uDlzsKjuxw_1768988203
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4801e9e7159so29974805e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768988202; x=1769593002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zDKTURxMpN1giCRjW7fiv4qni6ys721eKds24IdkTk=;
        b=jr0qjS68OTXX6cjhVTpCkO7OLdYWpUuRWINo10x7ukf2qK1cR/ccKfpX/RSJ4NVG0z
         7I/683TLPuLTd1UWqbfxATGk3754DZnh8OwvEx4ch1QdNCqhRE84n5HOtkr7lWWrqiEC
         qSyExrykmqjoMSX46zMYGpUFY3EXgGj1Y2t6NbApKnItpv/5RgrkBC7FN3HCj/BLolT6
         8cMXnna2YXmKzp1VX4etTRfnk/4bHt9JintAMr2IB1GJvTBhWDsLB5MoFlC2Nz8PYxBf
         nX2HwebYUxxDUit50txv8Q2FJ/23A3lB97gq0dlaRzffEqM+6364tflpL8RNraeV+WjT
         +u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988202; x=1769593002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6zDKTURxMpN1giCRjW7fiv4qni6ys721eKds24IdkTk=;
        b=HULg1Ry8rwBJurDST+q7+OUY/2SICRbAlsGYU4oJQ991zeNoju8LytoTp41PadW4Nb
         pHAMt+Nwt+sJ7kBTCSVjS8CihKHlh160Xxu9eEKWG0eBMoFm3l8QL4SAt/x2m5lb8vyc
         H6bwh0fUewCID0WsFCe45J9NPahPPpB96OEhC++kxcC+KOapiJz7W/4cmk9Ke9pRbfTA
         j6nndTPWOe4rOHYK5tjmKJw9c9WtpURdvMH9oFUMAvCWgB3kRxjMya9HAXytDUqK6MsP
         UgQrgWAvQ8BX9+WWzrR/IzQ4YzXNtrW/X6QG3S8xrfT+5EP7St2dL+KybBq94yyVqrpY
         Sz1w==
X-Gm-Message-State: AOJu0YwTRhrXYFGg8gqruaWlKpkrKow0fQVQHiB9rse+BlZc4OIXSP3N
	eekjCOyoFs4hhMc7fE3ofbsoSaLpzOhqI8NGeVEt4Jf9uYcbgTlzq+C8sTrPYxmD9O3lVPFnTg6
	0mV6Nr7jHR5XSN3QBW/98b0ryram3mXzaq/v0pK4tcUV1N1ya2UaDLyCCkkz8NePIjJp6rkH0Qg
	yweX4ZwiPMYAEFVs94wrzqjW3Py1gW2V3i5DHW5EhWBQ==
X-Gm-Gg: AZuq6aKuXbULkcjtaACHwTAVL3qczzsrHq3nQvzmHuMdR0lp0dC/JP6C4kQvkCfyTET
	6YwbEFV+ZU9ezLVnWttUCjcBp2jCtOklSopHscKlZb9XWOZ2r09pnu7tL4ciDPcmjPDobsP0S4C
	ABiqUweFzg4dFxNvL1FW085o1OcFqHAM+WwA2fyeqAhEuCO4bsL64Qpk1crG1J0bEg3HWU24FT2
	IJy0XOadPW5yVymso8aVFGxvVZ0dGm1eN9qxz1rV0M2iPrLtiti5m7Nf0dHqCrsterMHLxrgxV1
	lcrI63iMqEc9cIKIgw62egsXoIywNtsxe8fJqFrz7+cjsqmUT86wl11evSUMUb7/W+9aChfPhIO
	0BgEHLN5UPVimc0VS60dN5egYJ0ZS1ruuq422I8hhPxcVCqrFQn06Djt08Wnn
X-Received: by 2002:a05:600c:3e0d:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-4803e803c1amr77560945e9.36.1768988202262;
        Wed, 21 Jan 2026 01:36:42 -0800 (PST)
X-Received: by 2002:a05:600c:3e0d:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-4803e803c1amr77560335e9.36.1768988201797;
        Wed, 21 Jan 2026 01:36:41 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f42907141sm355976705e9.9.2026.01.21.01.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:40 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>
Subject: [PATCH net v6 2/4] vsock/test: fix seqpacket message bounds test
Date: Wed, 21 Jan 2026 10:36:26 +0100
Message-ID: <20260121093628.9941-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121093628.9941-1-sgarzare@redhat.com>
References: <20260121093628.9941-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251826-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 22B5254A42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefano Garzarella <sgarzare@redhat.com>

The test requires the sender (client) to send all messages before waking
up the receiver (server).
Since virtio-vsock had a bug and did not respect the size of the TX
buffer, this test worked, but now that we are going to fix the bug, the
test hangs because the sender would fill the TX buffer before waking up
the receiver.

Set the buffer size in the sender (client) as well, as we already do for
the receiver (server).

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 27e39354499a..668fbe9eb3cc 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -351,6 +351,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 {
+	unsigned long long sock_buf_size;
 	unsigned long curr_hash;
 	size_t max_msg_size;
 	int page_size;
@@ -363,6 +364,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
+	sock_buf_size = SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
 	/* Wait, until receiver sets buffer size. */
 	control_expectln("SRVREADY");
 
-- 
2.52.0


