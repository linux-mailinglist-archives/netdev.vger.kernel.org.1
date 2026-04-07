Return-Path: <netdev+bounces-275918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB0fJGTL1GmtxgcAu9opvQ
	(envelope-from <netdev+bounces-275918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:16:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E6C3ABCFE
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D99C3043FBB
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157739EF02;
	Tue,  7 Apr 2026 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3206M/x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7rymZQj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73333A0E99
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553249; cv=none; b=CGYEv8yfYNJg2HLWJqDbTCT1yH/H1V17aNaRDIJFowumYcwoA0ZUBrqIFIJbDQwZCV4e3z51CNw5yGSkuIiKConjzdHqa0LXeUK//qpjnFmOaLXMmldEU9UwWZ6N9uPGTXN0vkykxm/+Tx4ofu7y0WO/uOlSj6txKQGtCtCLLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553249; c=relaxed/simple;
	bh=TPyeaXldjZ/vNi3cTj7MlzLbGl/Ixp9Pbj/uTFr2sk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AXq3ex3FBQDJ6XKZw1Eym2Nyj32bXVSSMbH0cIZQzdeGWwSg28w5EHyNwASMuwDGmmX5PpaG8LHn2qihs1cxjrHEma3HjJKzDx+z4XbcEakX2Z6kCqOivykXRN/VPzytXhjIVpdvG+9p/rbzXXE3Ny/2zPQZh9Rpua3MqZPINhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3206M/x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7rymZQj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MvBSgtjWIPj7YtiYQ1QdgeAu7KbULO0Duu0OFbmnZU=;
	b=Y3206M/xTs2TDRr/lJLUS/y5+GhxLpu3pKz6HiN4T7bxK54jMTho8JYIN9iyOBjttvZbh1
	Bjwvwx2+/5ZdxYYdGDcCXxWa1NyEnDOA12zrT2GEWPa52XmmxRm6IulfOIxHez/I9GFr27
	zO1EFJayt/xU6xBjRKbaRuy7yfrNIqE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-XvJmONGQOcCqhMxIy59www-1; Tue, 07 Apr 2026 05:14:05 -0400
X-MC-Unique: XvJmONGQOcCqhMxIy59www-1
X-Mimecast-MFC-AGG-ID: XvJmONGQOcCqhMxIy59www_1775553245
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so58568115e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775553244; x=1776158044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MvBSgtjWIPj7YtiYQ1QdgeAu7KbULO0Duu0OFbmnZU=;
        b=X7rymZQjmzMh+azmi4F5vc6e4635bgO7zxenf3Ts58RlzGBol7OgBILGGoGrjqWLlV
         m903/w/68zYOC4RU8j0lfYgqPUnGCIybxmdsKZY1bl4qLK3chXEAqdk2/X477IZnS+Og
         ExaLcvO8n5dzBabvo/YAZO5lj3/KFjnmwvHd7qTEfu/cr16WjQSbSz3F+W6z8iE8znVE
         64MCoKWscpO5W7836p7DMMLMu0IttuCKCkJXAfm6zbhB2WJF2AsQezJf+KigvvfOqKY5
         HE2Gj3yjMByuEn9O6Q0Bd0kP5yruq1NW5FSHtOhx4McPfcupv9akLzXQyG0HGYJKf92C
         ROVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553244; x=1776158044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MvBSgtjWIPj7YtiYQ1QdgeAu7KbULO0Duu0OFbmnZU=;
        b=aOKRPvkp6zg9ZdTXo4nJVH/Wxpvv6fyCteqOCJikpsFUcuoveNZoWJS9WtDN1UuIoF
         ZmveV4j+V09cl1wojTkehpukAWf9j+TJwoF7QTOuewfG0e+0MyMbOXEvXT9j5QbCPClz
         Gqj60pO/hoNX1KAU+HUge14DLOUTDPz9mmBD1S4tmyX61dEvIrEL8cCmoKhZ3NUBaQBN
         N4u1xxyXun7LrFdvtP+VMeIEtHFbNc8QpY5kCa0En7mlrJjJeED9hqrLlLq5e7la6BWz
         jNsTXNQhIlrfqPj+8Aoc+lD1WSMMyHWYOba0jyosjsUwSR6rbh0FtEDuMCa94xwINM3C
         JGPA==
X-Forwarded-Encrypted: i=1; AJvYcCUMmvMvgQ7RjmQrwtqIe2UNe2T/U42uTMsrlNwpeXewxKrNWBF6a92rlbja3HMPzx/ngVrqAdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfAYwc8kGHpdkVu4ayMPtGjsECADF/kXPoSywjtUYgZvugiLXW
	ri37ltR5uOjxUtrFCA4qE2trdFAZSFebGLJ4M9bDQFPPOOkX2Xz/dXuyKZths8JncFMonprW+mp
	sYxiLRrAc4kHZCuZIZ4LlD3U6TwXtRA5NQbq/FtWmI5XGlgPMRi567FuwBy6mqOFyOChNBZm7ie
	5NKKsWJEObxZk+l9EZDtnQg7i8ioM+tKs7XV8lXE8XFhgh
X-Gm-Gg: AeBDieuL7QvbErhUQvy4tr4lPj7uryM6KOS/GFJ1uu4w1RvjJjbR6LBs90WAHkwR1jj
	t2V19BbRyYnWoQQC35ICctD6seSP8Dqho2L/oIVmrXc8amBko5z+fB55Vb9dljietbtAjDGiTl1
	qEud48xZInUWwKJ9rWmWj9PXjawMSHxF4B3BS11XlSf8HHRxrgz3heFULm5qLVzzGINxk0HMK5z
	qxfJzgbT3XiwrOWEHP1TO0LOIXQD5k7J7mrygm/twiZ6is/RFHu6+PKKmkFq4Oqu4gdzSeCI9Eq
	+fsGsbG5ZolNzMsPj0qxwdzFxjBmNrSkezC/Xf+llM3bTN4DJR5CpmTlAI0Y/pke5eLW43JI5IO
	iz83VwBKCAbSr00KOeZY6mO0dYT5DO3MMRIMJ8kUY0etma2X8mZGzk4j0xjNw
X-Received: by 2002:a05:600c:620d:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4889945faa5mr212240265e9.1.1775553244312;
        Tue, 07 Apr 2026 02:14:04 -0700 (PDT)
X-Received: by 2002:a05:600c:620d:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4889945faa5mr212239435e9.1.1775553243640;
        Tue, 07 Apr 2026 02:14:03 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:03 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 11:13:56 +0200
Subject: [PATCH net v2 2/3] vsock/test: handle MSG_PEEK in `recv_buf`
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-fix_peek-v2-2-2e2581dc8b7c@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-275918-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 29E6C3ABCFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
`recv` until all requested bytes are available or an error occurs.

The problem is how it calculates the amount of bytes read: MSG_PEEK
doesn't consume any bytes, will re-read the same bytes from the buffer
head, so, summing the return value every time is wrong.

Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
requested amount is more than the bytes available, the loop will never
terminate, because `recv` will never return EOF. For this reason we need
to compare the amount of read bytes with the number of bytes expected.

Add a check, and if the MSG_PEEK flag is present, update the counter of
read bytes differently, and break if we read the expected amount.

This allows us to simplify the `test_stream_credit_update_test`, by
reusing `recv_buf`.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/util.c       |  8 ++++++++
 tools/testing/vsock/vsock_test.c | 13 +------------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 9430ef5b8bc3..f12425ca99ed 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -399,6 +399,14 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		if (ret == 0 || (ret < 0 && errno != EINTR))
 			break;
 
+		if (flags & MSG_PEEK) {
+			if (ret == expected_ret) {
+				nread = ret;
+				break;
+			}
+			continue;
+		}
+
 		nread += ret;
 	} while (nread < len);
 	timeout_end();
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 5bd20ccd9335..bdb0754965df 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	}
 
 	/* Wait until there will be 128KB of data in rx queue. */
-	while (1) {
-		ssize_t res;
-
-		res = recv(fd, buf, buf_size, MSG_PEEK);
-		if (res == buf_size)
-			break;
-
-		if (res <= 0) {
-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
-			exit(EXIT_FAILURE);
-		}
-	}
+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);
 
 	/* There is 128KB of data in the socket's rx queue, dequeue first
 	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.

-- 
2.53.0


