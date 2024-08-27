Return-Path: <netdev+bounces-122268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C28A960941
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8D6B21E89
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4819EEA1;
	Tue, 27 Aug 2024 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iljnwqt9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE919DFAE
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759360; cv=none; b=j+56RqE42HX6bA8JEONC5z+V/mxFVBosAK9C9h3IBDKaemgsOoVhnkzo7Pe7FnTqW7LWabxGLCGOWVGp5KSfiRa1olHvmA3sGLrK9IksRl2s7Y3pVHVsqaIoEddSYGLr4g3WQERIlcVOH8J5qYPODlqINUR7leSm9iiG3wKaTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759360; c=relaxed/simple;
	bh=2Siwk+eoZn+UtzA3M0/PrBRxZKOZBRyUjbtOvXmjhF4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ys+Pgfa8487SDBfB5Qsb7cQ6hqO66QV3653s2cdcNwHZjeG2BWdcc9tuXYJctzs3Ag7KznA7BohtGqSdHAvUwOEfC84PNaGklyxXrWX7aZ3gD27EOdg2QpsM+bzktEv1oFZX2qLC9ijs0ZxecBnZDo6U52rLXy0VIuJW6uqa9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iljnwqt9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e164ceba5ffso9112713276.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724759358; x=1725364158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=69D5peCSYp2I00KAIuUBn8R/8xHCHZXugKONOw7+84s=;
        b=iljnwqt9EfBtkXv9f4vns4ZS961umxy3BVd02lbzvxHrv554rSYDiR0QgwQ1e1UECm
         XygjE5/7MdTMwAlHy9MIZ/HmhGP2peo5XJD2bn7MEzaBQRlT5LRD3TOy501xfmtq4z8B
         K0v2S8k6ufV2UntRqXy+u/F0FZtJRD5mRQfmdCToqQGQmohOj/i6pDix4T5ZVi9+sRGW
         CoRI30Bh4WM6y2lXsT0TMXnk8jTD0y8KfvzOTEogq5B7f9rwOogjuXkS3cr1F6pHbHS4
         KHydeT7OQtBcThVIhqgcZNoG6msDXQ9kCHXgxRAXp74Wg02hp142u0Na1UZYgnpBHctg
         TN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724759358; x=1725364158;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69D5peCSYp2I00KAIuUBn8R/8xHCHZXugKONOw7+84s=;
        b=N5LCXSrXq77Z45syLV49/H7w7RI7rT6heyplZIIjJ9BMfU4g13aeJzAE6M64RuEpWG
         7uk1OW/gxqr2+UTLEgcjbdJDuR8ZVBRrnWcgZ8bzi84PqqDkWvq2WAf+/cioJrjWDbmG
         s3nehEjrYfRoLA+Ad6wTQOa+VhFf1AnKMSarPdU1cBh+RhN2cI226+uBexTkhmdTd+dK
         87cZozBx4LveJ/D4ZIJyVxINPJ0uHxh89AjTU8LnjVBvtmkg8bP5TJfue9rMf2BuRygr
         9SQqoJpuko7cOwNYNxkByiTnOCuk5RSbfH/Z0+X+HJWitHQk8dYJ/VIYehsGB/HPs6xF
         MguA==
X-Gm-Message-State: AOJu0YzfP5GiYuYIw+8kWcdqIuTlfJW+1BHgBYe8Nlcj2UCVgVf6Ia/C
	j88dtyBKdUwuxEtt78hh00tORadVfwWpxv8uTW1WAR7Mn3IC0yrpf2nbazT5iW2rKRRGsPjcAo2
	zRwAumsY04A==
X-Google-Smtp-Source: AGHT+IHnqa0pwtZOjIl0VK1oOjnQLjUJtAYsw0qXoPW+TnvNIuLadlrfNkFpyCpw6qIzhhiMtSSFUFE2YY3KHA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:9:b0:e0e:cd5e:f8a5 with SMTP id
 3f1490d57ef6-e1a2a5b0213mr23484276.4.1724759358008; Tue, 27 Aug 2024 04:49:18
 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:49:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827114916.223377-1-edumazet@google.com>
Subject: [PATCH net] net: busy-poll: use ktime_get_ns() instead of local_clock()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Mina Almasry <almasrymina@google.com>, 
	Willem de Bruijn <willemb@google.com>, Joe Damato <jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"

Typically, busy-polling durations are below 100 usec.

When/if the busy-poller thread migrates to another cpu,
local_clock() can be off by +/-2msec or more for small
values of HZ, depending on the platform.

Use ktimer_get_ns() to ensure deterministic behavior,
which is the whole point of busy-polling.

Fixes: 060212928670 ("net: add low latency socket poll")
Fixes: 9a3c71aa8024 ("net: convert low latency sockets to sched_clock()")
Fixes: 37089834528b ("sched, net: Fixup busy_loop_us_clock()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mina Almasry <almasrymina@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Joe Damato <jdamato@fastly.com>
---
 include/net/busy_poll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 9b09acac538eed8dbaa2576bf2af926ecd98eb44..522f1da8b747ac73578d8fd93301d31835a6dae0 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -68,7 +68,7 @@ static inline bool sk_can_busy_loop(struct sock *sk)
 static inline unsigned long busy_loop_current_time(void)
 {
 #ifdef CONFIG_NET_RX_BUSY_POLL
-	return (unsigned long)(local_clock() >> 10);
+	return (unsigned long)(ktime_get_ns() >> 10);
 #else
 	return 0;
 #endif
-- 
2.46.0.295.g3b9ea8a38a-goog


