Return-Path: <netdev+bounces-133153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE5F9951BF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B061C25A1E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC251DF73C;
	Tue,  8 Oct 2024 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ws8HlNuo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977061DF74F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397874; cv=none; b=JbUHT8Qp7GpsBUGsef13eX4gdRmpBxlYdxkwwby31g/ZHg7/tckjgR74/Sqs/tS7aOq2E+JX9kskavuUiC0IUDsR3rYN3efFJWc+mvWcJS6D2fBb+Ev39GQR2CboNSi0KZgMuUoyy/hHk6ZgmVwZtqNP1wuxo1zTywc+ojTcYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397874; c=relaxed/simple;
	bh=IDSKzEZYUJNpanHrxo2Bklp8g30Rv+Ba3+Y0il+LunI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JTuPTQvYkWxe3R9X+iJMA6sGZIMGEwYc0AVIZUXjb2yoTGuJDZP+N4PxF7WGoMO8EomCSheY0JaOGC96kpcA5mDb6RjQR2Up/jRP36vPCImB6xRcjRtt18KCEwB5HnxrlCxOgv9gHrkcWBJhK4FWav5INTGw+RBHo87/qJejIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ws8HlNuo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e25b39871fso95818947b3.0
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728397871; x=1729002671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i6OPcl5l9BjOa2Z2d0porYllA4hLIFkcoUeaIDuJ5y0=;
        b=ws8HlNuohHeyQbvJZSLMe7YZr9UAclAfuS6sC0HgDKM1FGxp9+X0nbGuZdFFRJfNK3
         oDXe97abynugGkaNcUPKA7QE0Y6jAwNCUysnyG70nOcz/u8iY85EnjNyGr2VK3SR+Tuc
         sTP15Q4vJTaqXxsvRdEPC9ZSdh+CixXraEIaDmT1Qh5Vdr6j6BnF2qUztSsx68nrKn8c
         PptGW1vhipnPbY0V5WGB8HFlF1HiV1uFuPqJ13HjphC1Xng6Uz1+zGElqV4I82eQvqz+
         dJj+pHw59h1mduSRUEwqVWD0/yxGY4Zsn1ZuqRlHUw2hIpuYnrlzoA8CB6AN0ejqofId
         wa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397871; x=1729002671;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6OPcl5l9BjOa2Z2d0porYllA4hLIFkcoUeaIDuJ5y0=;
        b=BG61Q1XBOVuFRBJgQazOXziG+wz6NkzQFo9zrI46cNryMZDSk4+Wa3VcB42wzeiAQN
         w8BhoUladCgzW86skWJN6IWujW5/4QyhEr97IJz/Fk+YvK5/Odv+a4kTLK2N9PLW28K7
         vSvPnA1tqF+waom0c2k8w7OOm4zw02aGgKsqkZ38FYwWUFS1RM/QXyIsjitvV1+v7Oa6
         YfLfBvvFKTHVWd/fIBnZmqX+gViQpq9cP+7RbVxvIpB2qQ5Qujz+x0beO9uy6cysg+Mp
         MQ7BCXXo5JDQFWLU1yzF1ZKd1gfnSYF6xp5G6gGWmA6AcdN7TnME8DJ7VYARxKNyy/V6
         6DfQ==
X-Gm-Message-State: AOJu0YwZLTlpMiYqzpalYpRJBO/0NLQQ94p4t3jReG1QSJexTmfTB30+
	EYwcQjs7rgbNm5sVQVnk3qqszq03QOHrM1hwXvWUgInq0UbBwNgb4lHgtX3zY6cWtnRylQLXEXz
	aV/t2l6D9lw==
X-Google-Smtp-Source: AGHT+IF0UFw4eTd6H2GPEvhxTkvL+yymYpoE75BN6vWX0pASMAtlJ0uqowyqGykFKymhKdXkjAFNDkNfAIWJYA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:61c2:b0:6e3:f32:5fc8 with SMTP
 id 00721157ae682-6e30f32636cmr907197b3.1.1728397871576; Tue, 08 Oct 2024
 07:31:11 -0700 (PDT)
Date: Tue,  8 Oct 2024 14:31:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008143110.1064899-1-edumazet@google.com>
Subject: [PATCH net] net: do not delay dst_entries_add() in dst_release()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Xin Long <lucien.xin@gmail.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"

dst_entries_add() uses per-cpu data that might be freed at netns
dismantle from ip6_route_net_exit() calling dst_entries_destroy()

Before ip6_route_net_exit() can be called, we release all
the dsts associated with this netns, via calls to dst_release(),
which waits an rcu grace period before calling dst_destroy()

dst_entries_add() use in dst_destroy() is racy, because
dst_entries_destroy() could have been called already.

Decrementing the number of dsts must happen sooner.

Notes:

1) in CONFIG_XFRM case, dst_destroy() can call
   dst_release_immediate(child), this might also cause UAF
   if the child does not have DST_NOCOUNT set.
   IPSEC maintainers might take a look and see how to address this.

2) There is also discussion about removing this count of dst,
   which might happen in future kernels.

Fixes: f88649721268 ("ipv4: fix dst race in sk_dst_get()")
Closes: https://lore.kernel.org/lkml/CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com/T/
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/core/dst.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index 95f533844f17f119c09f335ccf9bf09515dd3606..9552a90d4772dce49b5fe94d2f1d8da6979d9908 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -109,9 +109,6 @@ static void dst_destroy(struct dst_entry *dst)
 		child = xdst->child;
 	}
 #endif
-	if (!(dst->flags & DST_NOCOUNT))
-		dst_entries_add(dst->ops, -1);
-
 	if (dst->ops->destroy)
 		dst->ops->destroy(dst);
 	netdev_put(dst->dev, &dst->dev_tracker);
@@ -159,17 +156,27 @@ void dst_dev_put(struct dst_entry *dst)
 }
 EXPORT_SYMBOL(dst_dev_put);
 
+static void dst_count_dec(struct dst_entry *dst)
+{
+	if (!(dst->flags & DST_NOCOUNT))
+		dst_entries_add(dst->ops, -1);
+}
+
 void dst_release(struct dst_entry *dst)
 {
-	if (dst && rcuref_put(&dst->__rcuref))
+	if (dst && rcuref_put(&dst->__rcuref)) {
+		dst_count_dec(dst);
 		call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
+	}
 }
 EXPORT_SYMBOL(dst_release);
 
 void dst_release_immediate(struct dst_entry *dst)
 {
-	if (dst && rcuref_put(&dst->__rcuref))
+	if (dst && rcuref_put(&dst->__rcuref)) {
+		dst_count_dec(dst);
 		dst_destroy(dst);
+	}
 }
 EXPORT_SYMBOL(dst_release_immediate);
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


