Return-Path: <netdev+bounces-250639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69FFD3872D
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB133316EDB9
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F651397AC5;
	Fri, 16 Jan 2026 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayqZt4Bf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m5kNUg74"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD52362154
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594309; cv=none; b=moLu1fAP5XP7mMHf7tQteXkinlEhylwwHJf5wV+lCFJjrTUIXq9zaz5+7sGn+T8bG6AylZ+tkchO4D/HcKEOJoY39OMwYcWpnDciWDgoxLAMB7LsrxRb+tHCJQf7p4hoOclRfyY9sDa0zF6VO4hLIjr6vhb0H+SZy9zBYJTiQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594309; c=relaxed/simple;
	bh=JvMvAj7ZpINza73ylybZV6srp9RLkEGmGWUWUCTvQu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+oim0KN/QawJ1D2PDyK/xG4mqY0UN7Fc6U0e4dHdiQ6AJaP0gqP+cwdfVBwYznkT896EVzaspiZDoSVAtdPZr2RhfI+h3s4gH1igi+bQn46jDZwCHz6HcjI10qE/TUr9626aaTyG+XGvJZ2Fa94j+dSjvQoyCxggk6Bmit/UVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayqZt4Bf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m5kNUg74; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voXLQ/q07d6hv5Ud8qhwOuK2vYxSCpA8ze6BckDLUOE=;
	b=ayqZt4Bfw8vSKG08AqUzXNpECx1VNYTMWEYaddurqM/SiK1DLUyNzicZr3Fk8wmCu+LRlA
	0aE3GrbachCQP+I5eN5h26IaaD/PvUCTYQ3yOJ3i6gLnuuV2nE+0WkvE3u1Ar2cnFZA8Mm
	k4xqJW+7gYRxIEIgVZ9aMHfUCgxp28U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-5-SwE4wLNquL3IOUE3hCkQ-1; Fri, 16 Jan 2026 15:11:45 -0500
X-MC-Unique: 5-SwE4wLNquL3IOUE3hCkQ-1
X-Mimecast-MFC-AGG-ID: 5-SwE4wLNquL3IOUE3hCkQ_1768594304
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f54so25842075e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768594303; x=1769199103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voXLQ/q07d6hv5Ud8qhwOuK2vYxSCpA8ze6BckDLUOE=;
        b=m5kNUg74zz8kfvQ5DnCKWIU76Pvo56scDHZ+OAOh8DJrW+M2kyqz//SaTeFmVVrFvt
         KHom3G/sAK1lboUsAeoQ6m7OT/6IVcBp+VIWdzJLLAXuhqgUpkfuA/Ha+tHKcMgufxU5
         cfSPFQhNLcKu6kMxeHuJLHBPfqgGmlDwGBNxwjyVLtDsTtzgA5IuYbi4aBfS8bSOWBAW
         iYp7NCikuBL4CWZMbwKqXlHaH9H6Vz2PUOpvr10moRZ3mYxRzh/0wHGw42kkDtX1O176
         sxJSgy8XIFxZx+9cguBz5XOJXtYPirsq83RNPDam4SzdcrkKpuY2LDNQ8uiGMNJEoxsK
         6xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594303; x=1769199103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=voXLQ/q07d6hv5Ud8qhwOuK2vYxSCpA8ze6BckDLUOE=;
        b=hbAzoKWKl2ByDcISkb6oe+rj0IoU+Bo+o/CXrnpUdB1x7sWfwGt9la29Z9Rby6L0tY
         mvYvzGWG058AoTQs4nFhuAiFO6A+nWcZhlRyLMhU7n6JPixU2gGpcCbWAVlsHzy5pSPh
         1dvZylJ3JhYWyv5O7alKxbEiJIV1zsBUQNYSNggx5riEMYS/XbZ1tvxr0uZW+B2Utpwu
         bXtX+r+dFUSlJ/DUQdNEcBG5CYUY+I/sTMDto3ntsRifqdRJTjh1B1bsKPSEtfKcd+qH
         OUTQqo8OVk17Eq5XW6wS2QuTCbU/2YoCyibd3DaUyg8+UiD+jMcw037SZG9PTGGsQ8sS
         STqA==
X-Gm-Message-State: AOJu0Yz/s0bLyvJnsdR9D7OlBFSdqBe/FZfhycfKRtcxintgQdvPrZ87
	ug8HRLFKwM33Q99fZNq+6cxl9DwR2pUl9XK3Ehu8sjQOyB+fpcUa3GvIZ3QhpFNBXhIxPFJB4Zo
	429oNUUK4jT5LxRE022XKq4iY6ns12iqIAVNlDWqgyf0wsmZEh7WWaNkgPa1z1JpdxBKgvcoVhr
	MDEGbrV/b5zZP1IBVc5GNDGgsgZvNGMYJSvgryo/AR2A==
X-Gm-Gg: AY/fxX68fuTudevMQSFEV/u0gkKpF3GEenZhSdilC/YT4BQv2z2ZfZO0iut5WpSTSat
	pODpEWtKpR/s1AxxAy83c8GHTEoEOht98IAlNU9XSw0WpbVEeD7phMTtzRylMoEmlt+lUbucUxT
	vlTqICs8MhuNVh5bNE8raEsBmmv/hnAMQmyOYTqUbQ/3evy9Py5Sbuaq6mppY5kEgQH6xu4L4wn
	PNDbtWh5o7M1kdf0rywfYiLqU3YvxHNLwTe8gsjsF6VoF7jTiOiqtnOOIlp1JATexnpjP11l3Pv
	3mTTJxvBHlaeG2lU7fLtgo2eZbOGN71qEcRVgPaHrz/DU7AkH6EwutyB5gFMaWEuBuI/h5JpuJn
	mBuGZAaD5r1ov8vPvKVc3jdQwcVrs+JfDs89nOTDDsVe7tr/QH5Nj8lAOom/N
X-Received: by 2002:a05:600c:5912:b0:471:793:e795 with SMTP id 5b1f17b1804b1-47f3b7a4005mr59206345e9.0.1768594303295;
        Fri, 16 Jan 2026 12:11:43 -0800 (PST)
X-Received: by 2002:a05:600c:5912:b0:471:793:e795 with SMTP id 5b1f17b1804b1-47f3b7a4005mr59206165e9.0.1768594302869;
        Fri, 16 Jan 2026 12:11:42 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c00esm58061155e9.2.2026.01.16.12.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:11:41 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net v5 2/4] vsock/test: fix seqpacket message bounds test
Date: Fri, 16 Jan 2026 21:11:21 +0100
Message-ID: <20260116201123.271102-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116201123.271102-1-sgarzare@redhat.com>
References: <20260116201123.271102-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index bbe3723babdc..ad1eea0f5ab8 100644
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


