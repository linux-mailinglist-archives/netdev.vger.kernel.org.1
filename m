Return-Path: <netdev+bounces-226555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92A5BA1EEC
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 01:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13AF561087
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40B2ECE97;
	Thu, 25 Sep 2025 23:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jpw1Un5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089F2ECE80
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841774; cv=none; b=aZXvWQcJaUvs1CIfCFqQKKbKKz64TWHt4eaTMyWnVQcKs42A+BXdSZytiPYYp/bg8xD5V+/fhlqjlw7QE2WoRzxUo64+hY+ojquCvBl1j3tQg5qQA8ZKfSqKKe5FuvcJm7mmnQH8Q9kWW96Z1RRyuImrNYYJCwsUsU/gq5kcywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841774; c=relaxed/simple;
	bh=beLWI5HIWM2n9su3bPYkHX2DbAB3XqgRxpQAye+vnS4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rS+7OCW17mGzJexZrBwn4dBi3eB0lsuVj+fmIpQre2XTsK1pwFxeINBasLVO+heCw+itR3tP4FOPro3j6pQm1LlBzmEaOXtrbnskI8xakPDXL+RFH3xCvg+NkLWeci2SWG7Sp/8PozkX44+zK8dtmi57rSdBoEf5AKhezc7V6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jpw1Un5r; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8271bdaccf9so237614585a.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 16:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758841772; x=1759446572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xomlX6VmzHWgqNgYFbnSrGwxTWFRPMfuJZoN5fCrkkE=;
        b=Jpw1Un5r5B53biWhkk0eCW3aBIPGMEEjSAZ1GiriElBXUUzqC5PGSrAAvKnCSlXzu9
         +GQqXdBBP3BxpYQXWzCLQgWbGlv7gPF2YBTd2i9etF0Jd1kzPAG1he0mJf5hT9jxO4Mm
         ikdoW4hVgAa4IEdoZs+07cG7kKs+JIzCm58XakdF2VeQqEmWmKTR5ubVQXCzCZcz/HuS
         CAuo97w33buWCJ+836RxDhke9bCFlflvOhooyOB/CFY8LpQsutC2tmgKs6/AZH1YWBlp
         acqSN2PiDiIbiH+hH3QdND8KJjxnNdj4TbW460Z/kuDjSADKlwszTt3Tg74HhqAQ6X9u
         PqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841772; x=1759446572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xomlX6VmzHWgqNgYFbnSrGwxTWFRPMfuJZoN5fCrkkE=;
        b=mXm9s0foY7qYz4aaJ4dGMtdGywSs8VG1pMknCevAnnIiyhtBxlCi4hU74ZA6sm43lU
         MUuRjJMlU1I4Ni8WqLybnaTb9U5y4uD4VlVSzlwyEWcqdVTy309nJRS96Bbv6nqMuAWJ
         jsx4pPDBo7UExIwRs8eiZfokvUNgZ7osk6p4prRJI72rxivYFXup/hoZo6/OiJIdJl64
         d2TavG8AiC0R0KSLY/+XZoZyAk3FO6SoRhz4uj/cBiynfDO0gsHhyn3C3ITe8N67iU0G
         1MvONnvVD0ENvNfi4SdANFf4aO3k/in1TVF5LdG+ofX0lk4AN2qlzZGynk+wB8r/xCLE
         MHTg==
X-Forwarded-Encrypted: i=1; AJvYcCVia2ZVZrJWqpT1D67Jy35XGfF8EAWkvt5fF4LEShXCJ8RfGl8/L177AWl2ONyr63RVNFfKy/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHL4Lf5eRu5cWkaM3k3hZqN3P6jAnDqC7eK3VOxqaOsQpHnZJ
	M/eBGMOXcE7/Dg3rjpxPRuYBJIBU5gTk+AQyb8CBdYqZc2sssZGSecZI0N5S6XhPX3rcT5Abvz5
	geUF8lE6qr0yo9g==
X-Google-Smtp-Source: AGHT+IF9h4sVwKbI5cdLTRwwZ8QGWrEtfLI/06cieQcnN7duVK8LUm3R3ALwnNCTuYseVi6cwrXIiW/DOq9wew==
X-Received: from qkpa3.prod.google.com ([2002:a05:620a:4383:b0:85a:8ea3:11db])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4146:b0:85f:37ba:b94 with SMTP id af79cd13be357-85f37ba0f76mr284842185a.82.1758841771561;
 Thu, 25 Sep 2025 16:09:31 -0700 (PDT)
Date: Thu, 25 Sep 2025 23:09:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925230929.3727873-1-edumazet@google.com>
Subject: [PATCH net-next] net: remove one stac/clac pair from move_addr_to_user()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Convert the get_user() and __put_user() code to the
fast masked_user_access_begin()/unsafe_{get|put}_user()
variant.

This patch increases the performance of an UDP recvfrom()
receiver (netserver) on 120 bytes messages by 7 %
on an AMD EPYC 7B12 64-Core Processor platform.

Presence of audit_sockaddr() makes difficult
to avoid the stac/clac pair in the copy_to_user() call,
this is left for a future patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/socket.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 682969deaed35df05666cc7711e5e29f7a445c07..5bc4ee0bb75d64039a2259ef01ab811b1d20034b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -276,28 +276,41 @@ int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *k
 static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
 			     void __user *uaddr, int __user *ulen)
 {
-	int err;
 	int len;
 
 	BUG_ON(klen > sizeof(struct sockaddr_storage));
-	err = get_user(len, ulen);
-	if (err)
-		return err;
+
+	if (can_do_masked_user_access())
+		ulen = masked_user_access_begin(ulen);
+	else if (!user_access_begin(ulen, 4))
+		return -EFAULT;
+
+	unsafe_get_user(len, ulen, efault_end);
+
 	if (len > klen)
 		len = klen;
-	if (len < 0)
-		return -EINVAL;
+	/*
+	 *      "fromlen shall refer to the value before truncation.."
+	 *                      1003.1g
+	 */
+	if (len >= 0)
+		unsafe_put_user(klen, ulen, efault_end);
+
+	user_access_end();
+
 	if (len) {
+		if (len < 0)
+			return -EINVAL;
 		if (audit_sockaddr(klen, kaddr))
 			return -ENOMEM;
 		if (copy_to_user(uaddr, kaddr, len))
 			return -EFAULT;
 	}
-	/*
-	 *      "fromlen shall refer to the value before truncation.."
-	 *                      1003.1g
-	 */
-	return __put_user(klen, ulen);
+	return 0;
+
+efault_end:
+	user_access_end();
+	return -EFAULT;
 }
 
 static struct kmem_cache *sock_inode_cachep __ro_after_init;
-- 
2.51.0.536.g15c5d4f767-goog


