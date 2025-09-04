Return-Path: <netdev+bounces-219827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9914B433E3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80411179F7E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 07:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA0429BD80;
	Thu,  4 Sep 2025 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khyjtkZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095329B8D0
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970744; cv=none; b=eEczcBH+YApZN+cIQTDX+ot9pzO9iiVlYZ7XIzU0gzemtjp84ZwiVFprXXFavBAveTNpUif5IUIhURlP36zanFm3d2KYyXma03F2p9c2ba+rOT17/ByLPhaVZOaC5PtwcFyk2iE8ivkp1ijS3MDC/eDQMIhMjYJ+HwZXKHRB0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970744; c=relaxed/simple;
	bh=NoAEI1qxVcsQ6DYeN4T2CiFqL+okoOWU6OTz1fbr+8g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZOj3VYNWzCpPfm4zUSiZ7Mif+6vetBRTjttcosoSl9LkjUXCPY5jqNeyJiGXh5pvLPgUEJaeN9Ie3xXnl13NJ9eJ/5+K9Zh95XMcJa8t17Q+aeJ0KJJ1+aGkIXN0uNoYJL4yKBXdUotjMhPw+c0q0nQgWAof24kNOalso8kMYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khyjtkZH; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-8972110658cso829838241.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756970742; x=1757575542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MPQVkAFMgmOhR8+kYXpb7BN7WiH06c2CJj9w5v/CuXw=;
        b=khyjtkZHk2rFKrX4hwvWt39S5G9qU/wk3CFqk/ggoH1KHcrjDSpxtsJQxVDLGWxMs/
         alY6ShsmG+Thbhe+OwGkbIUvCj4q4kC+XjQe3FN5dJVEk4ETYAFtv2l4FiGTl9kk2i2h
         JoOnj9McYbhBQnCyo1xQgFjDpgmb4meuoGYhpPCXrL5vJYabJWYNfe7wZtwM3RDMsj81
         X6rwQmhfOT3NYLIuwB4Ux+LapFf2E7DA07DH+n0s3CsHxA4iXHqf0tT/u0NxKw3T5yf7
         v4p07LHT5gST/zfoONlK5jhSOsGi8ThkS1eiluqWxQTujsUeLNt0s54d42XGTZGk/N50
         NDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970742; x=1757575542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPQVkAFMgmOhR8+kYXpb7BN7WiH06c2CJj9w5v/CuXw=;
        b=gryMvNrtUG9Yr/BphktzYhXBegVrLLT1jnGH8Bxbh3E8H47AsFUYaABdRc9jKPglCN
         gA91sqXUwysBK/DAjSJLWa7JO13a5Hi9AMeP4nVn08HbJVkudFOtntFj+AEj/hhE0umg
         Hm9AQiN50G4LhijdnN9BlW3fr47qEmjxfQGPOiX5Cuuc4SiUAJgUtkZul03ua4daylzt
         mhDkwGokmwLBPL8ZxfeUM/CO723jY/cX4BZhl21tbL+YfkQs9k3Sseh3Hb7ju/FkM08t
         URr9gbilJqoon7SdEiRKzpddsF+jj9Q+HClmyR0FkWGRsJ+/AkCwizO7kJOHAnsy/j9p
         s3/g==
X-Forwarded-Encrypted: i=1; AJvYcCWz32K4sWayECRbVriejHczyYfcaKu5srFDYk2HyCLHUH9YdM1zyDQgSXNgQ1jjGkdHCVIJb+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ncbbJbYBRxqpy1oekzuP3W3l2AhN03y0QbjyiRJpXQA3Ds8W
	rT698rps81yWpPfb8XwZ1HVA04T1wSzNG40qUfOtSvFn5/43D869pveIxjE23Ic+TMaO3Xx0nXt
	3/a2x2ozSphx3fg==
X-Google-Smtp-Source: AGHT+IHbPWd89svBphXZ7pOsltABNLESlaMmG9uM8eaeOdLkw5PpSHqif8D5xIT1A7cB13jOEQimM/Mr8nVHGw==
X-Received: from vsbbw7.prod.google.com ([2002:a05:6102:5547:b0:523:510:faa5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4691:b0:524:2917:61aa with SMTP id ada2fe7eead31-52b1c149c51mr7026803137.32.1756970740886;
 Thu, 04 Sep 2025 00:25:40 -0700 (PDT)
Date: Thu,  4 Sep 2025 07:25:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904072537.2278210-1-edumazet@google.com>
Subject: [PATCH] audit: init ab->skb_list earlier in audit_buffer_alloc()
From: Eric Dumazet <edumazet@google.com>
To: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com, 
	Eric Paris <eparis@redhat.com>, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot found a bug in audit_buffer_alloc() if nlmsg_new() returns NULL.

We need to initialize ab->skb_list before calling audit_buffer_free()
which will use both the skb_list spinlock and list pointers.

Fixes: eb59d494eebd ("audit: add record for multiple task security contexts")
Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/68b93e3c.a00a0220.eb3d.0000.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org
---
 kernel/audit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index bd7474fd8d2c..707483879648 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1831,11 +1831,12 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 	if (!ab)
 		return NULL;
 
+	skb_queue_head_init(&ab->skb_list);
+
 	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
 
-	skb_queue_head_init(&ab->skb_list);
 	skb_queue_tail(&ab->skb_list, ab->skb);
 
 	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
-- 
2.51.0.338.gd7d06c2dae-goog


