Return-Path: <netdev+bounces-54995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E884809217
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1ACB20B7B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2D50256;
	Thu,  7 Dec 2023 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGCl2jxF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36E170F
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 12:13:24 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d42c43d8daso8354007b3.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 12:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701980003; x=1702584803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xn6buCrGR0vgnL7mOEqOirgThpbJiAXtrF8s5TzWL8Q=;
        b=TGCl2jxFcrRRJumbf/Lt3unEGRcLIAUmjrmbeGUuq8sZhxjPsCU/H93Iq3XTFNwjHu
         EGr6zeLmqxMSDH91r0Rz6EeQgrH6qkkQCsKEo/0+pTDeY6itArfSjC82m05JVmeZbQQs
         TWh7XyIcCbR8LktboahM65CRs53CSujher1i4FHKwm0F0dEFjdzPQUer7SVuqioJfFfo
         oq9SEGwzXBHM5wsXKaL92NZU5iyYOwZ0MU9XI8QwPK2j/AdwRM8QVGvsiWzRUcw/pQ1p
         cc/FJv41X8WHa9VTA7TBit1mx+tJHNYLlGdsOMTM7M3PUhmF2G7yj+9Y9wdNYs6B5hC2
         zG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701980003; x=1702584803;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xn6buCrGR0vgnL7mOEqOirgThpbJiAXtrF8s5TzWL8Q=;
        b=GPXMNCPEWPSscjlGWqnvMRra6EcB7msYn/1vUfkv9X5aQL3mDVojXg1giTIsPpOTZD
         0hBJiS6aA6rLY0ZV7UP+WFy6w5MZ8vkJX0pgKj+0p5Hyn5KvL2Vfl1r+bfmloLQectBt
         lelt6HywlD3Kx/MOd+x0zxKFwsV7S8GsFRL1Yr+UinxmVluyIHPXy5tVyS8LJCU1bTOF
         Rcyw7Yp8CVzk2xG1fA8s9lzFkrQed8Xujdej3grJsqOoNI7Jh9q9Z4AiyDkOY8Hl3CGo
         kqn3aCU2UGkQQaCHDBiwDaiwVjL4jiPVwptfaTu1xt0sDZflFmpka2kvJYWgOBIseBwG
         a7cg==
X-Gm-Message-State: AOJu0YwSOzEXNXXDpO6Pd5T8dEr/3orzInJ5QwzhGUdEC5k1MZMq78pR
	yWjvE8VbhqosynsMxOX/6S8C97GDPxiF1Q==
X-Google-Smtp-Source: AGHT+IFNgy791H4vzQtxCkFFoz9BWR1fvXfVAVJaTfF1Nkhhx3DyH0j39sVKTOSGeLJovafhNV6iSWm/SyfiWQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:fe09:0:b0:5c1:4b36:85bf with SMTP id
 j9-20020a81fe09000000b005c14b3685bfmr74346ywn.1.1701980003377; Thu, 07 Dec
 2023 12:13:23 -0800 (PST)
Date: Thu,  7 Dec 2023 20:13:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231207201322.549000-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: do not check fib6_has_expires() in fib6_info_release()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com, 
	Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"

My prior patch went a bit too far, because apparently fib6_has_expires()
could be true while f6i->gc_link is not hashed yet.

fib6_set_expires_locked() can indeed set RTF_EXPIRES
while f6i->fib6_table is NULL.

Original syzbot reports were about corruptions caused
by dangling f6i->gc_link.

Fixes: 5a08d0065a91 ("ipv6: add debug checks in fib6_info_release()")
Reported-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/net/ip6_fib.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index e1e7a894863a7891610ce5afb2034473cc208d3e..95ed495c3a4028457baf1503c367d2e7a6e14770 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -329,7 +329,6 @@ static inline bool fib6_info_hold_safe(struct fib6_info *f6i)
 static inline void fib6_info_release(struct fib6_info *f6i)
 {
 	if (f6i && refcount_dec_and_test(&f6i->fib6_ref)) {
-		DEBUG_NET_WARN_ON_ONCE(fib6_has_expires(f6i));
 		DEBUG_NET_WARN_ON_ONCE(!hlist_unhashed(&f6i->gc_link));
 		call_rcu(&f6i->rcu, fib6_info_destroy_rcu);
 	}
-- 
2.43.0.472.g3155946c3a-goog


