Return-Path: <netdev+bounces-233407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C450FC12C79
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CB84654C4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F55283C9D;
	Tue, 28 Oct 2025 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUkSLXZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA20281525
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622714; cv=none; b=tbUVFQfOFIvHGgQwa6hO6uYLzbA0TjjzM1y1vgDbqQVs3yc06qGaFS+4PDcrYInX18OqPcV8np4OZrM/d/mA64xuQfmG7iUie1IHvMQG9X2oER5iMruRid8vivxYoCEarTlzm5joJ5NMGTgOitee8Fx6pJngxA8/2Lyw1LqU+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622714; c=relaxed/simple;
	bh=8/pfidaiaUyYQbW0/s0uPGz4kBeoweGAakGMwxL/wBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U/IK/0V034j8c9wCvlHbaxRx6px6gXPmyHQ/WhJDdOt0mvQPAb4KJTKWcEyPPfn9eef+bTGL/PZhdNUdNSsxwkTmknXA0zwz8Z06oqGfFXbsYE7saYB++re1v5aX0iQgd5YgVirgCN6ZU+lerlBzIIM1xQbuuPvNdAFdMz4wwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kUkSLXZ3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-269880a7bd9so55169795ad.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622712; x=1762227512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tFoHMvBbx9ZxZyYe1M9iNPLfQOd2igeIKU/Zy2VfjDk=;
        b=kUkSLXZ3g8HnSmRJGJDQcwkJ2olCw16W48XaIaZD4VgBDJFoIN9h2vur7goHIyC45P
         Tm3cDZqW5gaFN2F831SkvH1SVVIhX9JcnjOndzLxLZ6de+kShEE9Hs9mnE8JPPFxmOGo
         ujpa3kiXfR9ejEfS+fuFx1d4zJ4CVnPE8wWusd/uwX1WNnBF7OdIP5zLfm6FNg+cKBlQ
         kaJdJLTg5Hzn9FqqA1sPvNBAJmf3P4SESPLs2CPgGAj5ZR6JNnQW+h2Ey/0ukaslvGT9
         OoEcuQ7wkWUuKbrqfLI+Qm0tdKW7aBQogZ0DzeUMlicB6pmgdJ8fm7OxBtOVumKdiolh
         01+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622712; x=1762227512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFoHMvBbx9ZxZyYe1M9iNPLfQOd2igeIKU/Zy2VfjDk=;
        b=SBli46w+jIVrx9FYwXQCyo/Jxyk21DBOnSnMSrOHtqvuLzHz/hUamnVkJRcJ/84Jd5
         yjGFfA6xFilvid3pRBCs+WvuqqpQ5/JUc9KxGBF/X98HuQUyZ+99MVoCiMl3wqnB9Nnr
         OkzgdPxcTaC0c9GWLNBmjtAznKSPNxuDn6mN4h/UaawLmIf/VcvOyTjyZR0jSDDZOjcT
         dexL+Jf84k/CjCaQhp0ESVje27rVdfQQm1IyqsT2F5fCYv7PezfPA3Aja7Cd26cQw5Tz
         jYMxqsT8bRme9jIlbnjkpZFWYhoNBr91Z+kl+f1O624EX6fG7sca7aajqCN9NCwzPr9y
         5nJg==
X-Forwarded-Encrypted: i=1; AJvYcCWZKUPb2wlL1ED0pe5jN1dc3kx3osUku79/W3kvuXBjTsHn6TXWGreXnHB/99K2ReFq7YUmszA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTG996yMx/Pvss2KI5BcV2sKdQnaldn6pdXAAG3m/umTH1ZA1
	6R4Ha5PZjzYMx8Lbg2+RHvn3QZ/z5VbLR/aBleKh3eOF0GqWFHSdKQbynQodpOraQ7BYU3jec+h
	XuqG3kw==
X-Google-Smtp-Source: AGHT+IGWmEh1EmoPlludd/dJ9yyPBMvJvenf5CX6gxnn6ywyHx79O7PwpPw0XWu+tIwPbbF2XI40Rj8B7wo=
X-Received: from plgt3.prod.google.com ([2002:a17:902:e843:b0:273:8fca:6e12])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2443:b0:267:9a29:7800
 with SMTP id d9443c01a7336-294cb6a7dacmr25216655ad.59.1761622712526; Mon, 27
 Oct 2025 20:38:32 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:36:59 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/13] ipv6: Add in6_dev_rcu().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

rcu_dereference_rtnl() does not clearly tell whether the caller
is under RCU or RTNL.

Let's add in6_dev_rcu() to make it easy to remove __in6_dev_get()
in the future.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/addrconf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 9e5e95988b9e..78e8b877fb25 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -347,6 +347,11 @@ static inline struct inet6_dev *__in6_dev_get(const struct net_device *dev)
 	return rcu_dereference_rtnl(dev->ip6_ptr);
 }
 
+static inline struct inet6_dev *in6_dev_rcu(const struct net_device *dev)
+{
+	return rcu_dereference(dev->ip6_ptr);
+}
+
 static inline struct inet6_dev *__in6_dev_get_rtnl_net(const struct net_device *dev)
 {
 	return rtnl_net_dereference(dev_net(dev), dev->ip6_ptr);
-- 
2.51.1.838.g19442a804e-goog


