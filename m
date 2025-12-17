Return-Path: <netdev+bounces-245226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1567CC93BB
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD6C830436D6
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009633BBD4;
	Wed, 17 Dec 2025 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMJmwxe6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8B2DF145
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995163; cv=none; b=QQXGbxSWsckC5uK1IGOgbZzCfTcpfbrsNmrNEGWbLiBQYWLpjk8U1HHCVt+PTZ4V0Nu0+dJiwf7zCuGXZUUNxsArMExPaGvKrQRMf7qnAkoPu/ug5iXgze5W13R1QKhIjq4BFy4qz48JXi0C63VEPbBbFg9DrxX9MsC+OWIN0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995163; c=relaxed/simple;
	bh=wEb7l9+dIaLrF3lOxuBu98VyqaJvK7HaA2qlpIF1m8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRVxpKSf68qYzTTr/xO0qQYr92s54cVYuavbMUek1LKNMULkbhtJ3/LnIfearMxXVsLLPglg6SXLE+JOu4MJsFN/E11cd+dVaa8erJbdx/zFfDTrNY3R0kymWsn1RWz5rJeds5jm0G5arNh1tR+2pa5tLIKYV+HgqfbjcwIAKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMJmwxe6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-598f81d090cso6655099e87.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995154; x=1766599954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbWRXdgRl3LSSNhNbS1goR3DTsrT8qwsPNUfgEKOHFM=;
        b=AMJmwxe6e3qInCTSDqPgOpxkBY6S+OuSUKcbnI6M3baax9apxG+fw/fm838sXn8uGb
         cSEk7IkO95C96WX+iPC+ue1nnUoWerPFtG1uhvGga3mHnQHs5Q60n42/4j8YJWp80QQd
         Y/hoBIcvOVK7XijVle7OwqQZ5NcZ0Fig0NrfQFRhhPUwlE9D7gH8ZkHGQCiKuHbvtac9
         DRgPq+VNMi00peI5lHkMTdq71jKg2OiFKEf9qNKZoHavibz1Hi3i67oNpE6cJqqYLbYy
         m2R8eQP8JnbOx+nvEs5DLk1+UOjZhy9ME6KPQvaqrqJo7te0U+OihE8c3FFWtjM4gesc
         G7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995154; x=1766599954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NbWRXdgRl3LSSNhNbS1goR3DTsrT8qwsPNUfgEKOHFM=;
        b=mIg5wPcXatvR4OFm3d7xP7zV4uaeXDiNGPNSAlq2Td6aj5IUBqIkF51+eT8aH/vuTx
         B830XMUHYe0d9+dip+hes1Pef3WXOW/+RX3PiK1MlUzoDgCtECt40pvs+fW8fPvdN0Bh
         q/5bVyFKofOUEn5IcgzLRhsM8GaO3aP8zyJjRtrZQ3Mo5+kmTqr7gc1NB2F+zDobuXn+
         mgbq+DAPUusAKQlR6dGxgOKKL6vG1sJ2fz7fNHO31NSeVkZpSdPgxas4AHukBOtGTgzT
         IqQ8oaBMHCqwHjg3/D3mmfc4YQi08V4fOO8vDOWbn3mvtY5yXKCrnzrV7citxfM5+s/I
         LZUA==
X-Forwarded-Encrypted: i=1; AJvYcCUmg5fmSUk8fzFMUhtdjIfQohSBwJ/j2xfjqcCNvHeaXY9srFe/g8YOZ3f7bqHrb6uPXthzHA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkcM32DmKstPSUONC5aIRV5sd3q5CRVAOxwlCSGBbSATKWKLGx
	1OJXQ1FlhdYAFS/flyzPcdg0csQjrjKUsoDVtvphSLycoYtZEAaWPCIo
X-Gm-Gg: AY/fxX5EJAPageqa6Jtogdo124PnN+g3+bQhHQ3YrLWKGfiRdURoWzC8cHWoqCuAMaw
	qtvcYcQLDYgJ199FSPSG79jRZrowi7oLnCdLhe23thKVDPflTWvgnA6AbE3iVow6J3H05DbtgXK
	tjEjnA7ebqnrr4kh6XPoNOuaAALzZkfmDoHg3g+ubZKUS+VKg/PpHCP2jX2wjLy9sCzYHlZLLrx
	p8MYt9KT5GCZOuLZ3/r7nuPz+ngnhtSDdV9Y6S/GOYGl+hMPNvKjXbt8FofK5dNsOlPkhc4Igib
	7PtxAquDKHeMid9uJXwXhlLNkiIz+Wn+BbLWjhfnrRIrhdUpVbVJguHtgWAnbqyTnI4nNUTw14d
	To5kzbyAXYlh4/G/nt6DJauww+KOXLSEjgWKVs9LY41wRVt3fw43dJHLiOzqHb0EIErw0DfqzQX
	T2On6KnHrqqPFaducYHTxDaw==
X-Google-Smtp-Source: AGHT+IEL8x2ZTlMBEs3LqicoHEeKL6huCiyi0aBC5yPRWitKdewpftY1eFTFYFReON3iTv0egPnjNQ==
X-Received: by 2002:a05:6512:230e:b0:598:dea9:4f4d with SMTP id 2adb3069b0e04-598faa98d29mr6053767e87.53.1765995153840;
        Wed, 17 Dec 2025 10:12:33 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da790efsm2591419e87.102.2025.12.17.10.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:32 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v4 3/4] vsock/test: fix seqpacket message bounds test
Date: Wed, 17 Dec 2025 19:12:05 +0100
Message-Id: <20251217181206.3681159-4-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217181206.3681159-1-mlbnkm1@gmail.com>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test requires the sender (client) to send all messages before waking
up the receiver (server).

Since virtio-vsock had a bug and did not respect the size of the TX
buffer, this test worked, but now that we have fixed the bug, it hangs
because the sender fills the TX buffer before waking up the receiver.

Set the buffer size in the sender (client) as well, as we already do for
the receiver (server).

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 tools/testing/vsock/vsock_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 9e1250790f33..0e8e173dfbdc 100644
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
+				sock_buf_size,
+				"setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+				sock_buf_size,
+				"setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
 	/* Wait, until receiver sets buffer size. */
 	control_expectln("SRVREADY");
 
-- 
2.34.1


