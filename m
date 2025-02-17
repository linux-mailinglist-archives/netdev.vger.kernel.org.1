Return-Path: <netdev+bounces-167045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E361A38815
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49233B4609
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D118C22576D;
	Mon, 17 Feb 2025 15:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31DA22541C;
	Mon, 17 Feb 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807304; cv=none; b=DISuyioPcD6nhtgwlZZlNWJwb9sGayIPEFWlahyOGjr6mUg/OPeBXwLhSDEvkR6wv5v3or8OrrDmgRR1JAymW8qcNINyQp0hReaArOWjADR+Y8GA1yfz9EHa72UnNhK5cxJwWZMk9MrXRUrhEAmhszwW4iG8iBm7iGyQNXV9a70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807304; c=relaxed/simple;
	bh=/lEU7xULHAxpZlni8AN8DMboE77iRpAYV9/tk9IUOWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GUW+s6eROIBOL6x6R88vWFR08ynAr0+3c0LNA+/sYNN9Ju60+F3ZtmHHSEewqf/626D4GtqdpaO5YAF5rlwoYamvJ57PD6dyU4rSRDKlb8dR2X3lewLeROVaZoQs+7Vvx4vP3kQvo0BZRb98BtlKcqjpJ7Rtyg3neUtZjhtLcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso5703140a12.1;
        Mon, 17 Feb 2025 07:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739807301; x=1740412101;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/1TpPTCwLBrR1Kg3bSBlDuh3UE64GUFqlUJpFTwfGE=;
        b=G0tp/dPoRYQh/uoxqzYK+5tbdiitFxKT1CLYd/ZXgalDq241Flut8pp0U9OY/WgxA1
         gHjopvCRVCVuEAJlAma1rMUv+IToHBMvwcBb3mJBHxg80D0GOEXNCElTTjSYrUlr3nIi
         30deSvdIvNUfCTjcGA1+XlTFZthj8ew+KLQ2VvvIznDgZDFrg/jFf+i57W1d1ijtPc20
         Zms6sgnmX5iX/vefa6ZKyWvN97J7lrf+DFrNLMeKxZX2XrUdLHDJiMhgtYBtaeO56OKS
         9TPdMMNHCWUIhFLyYBi5IB6aoy0GuvQfM3LxIZBPo+uEvw7JNyJlQ9Arz62/uRT5HHNx
         9Fjg==
X-Forwarded-Encrypted: i=1; AJvYcCWWuJWWqV/6xiDmISWlyJdyyYDtqrX7M8M12qyC20DSdBfi3Tbd0moG2CC4yoUbVNafG24Gp70/R/6rpFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjXfv1PbmUS0SzRHOP/9ZsFSP7YoNj4g3mqTiBTdkOvB5sAyH
	Qn6zIt3GLMhWPD+PNruI43osX9NayHH+4lktJDvmmH5JhHtAHckD
X-Gm-Gg: ASbGncunUcc33wZKzX2WtalrZGvklgq3RAZtFQr3+oVnFRFyoglbZwctq1+BaVuCZmD
	wdPwTii+X9zEqOkk65dMQu74FThwHv/fgoSyqS2lzrzwXEK5cqCVuxY279mecQvJ7/7eUaHeaG8
	qxd/Y2NO/PsPHw4iypvh2OG1lMd0tbQkgLSgWqXXxuMIF+G4hQg69R7lO/pJeffZejA95coaGA7
	ulvbDsKtUuy1k1kdvyiB73LtW+tu8E19EJe79miB5xkjVyn0xjiA4EIe+haXahIW1nNwzQe01xx
	UyhVkg==
X-Google-Smtp-Source: AGHT+IGa1bidXafeMjDwaHLsDjxINfvO4wZU3rw0YCPBPybKrh47+RviRoxnX7Rhi2G5tYu7f0aAPA==
X-Received: by 2002:a17:906:f59c:b0:ab3:76fb:96ab with SMTP id a640c23a62f3a-abb70e4e1d9mr1096890266b.57.1739807300877;
        Mon, 17 Feb 2025 07:48:20 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9f8442c0sm177973466b.150.2025.02.17.07.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:48:20 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 17 Feb 2025 07:48:13 -0800
Subject: [PATCH net-next v2] net: Remove redundant variable declaration in
 __dev_change_flags()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-old_flags-v2-1-4cda3b43a35f@debian.org>
X-B4-Tracking: v=1; b=H4sIADxas2cC/23NQQqDMBBG4auEf21KMtW2cdV7FClRRx2QpCQiF
 vHuBdddP/jejsxJOKNWOxKvkiUG1IoKhW7yYWQtPWoFMlQZsqWOc/8eZj9mXdFjYFNRebcdCoV
 P4kG203oh8KIDbwuaQmGSvMT0PSerPfsfb7XaanLG3Vp3dc67Z8+t+HCJaURzHMcPXFLGwq0AA
 AA=
X-Change-ID: 20250214-old_flags-528fe052471c
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, andrew@lunn.ch
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1938; i=leitao@debian.org;
 h=from:subject:message-id; bh=/lEU7xULHAxpZlni8AN8DMboE77iRpAYV9/tk9IUOWo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBns1pDYujvLAfw5utcmAgE+6mDEDCDH4OpvaK6t
 QFU1Qp78/OJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7NaQwAKCRA1o5Of/Hh3
 bUmYD/0ccF1Vxf3F4MLAjdje/sP41HsJTtFkDULzfzqbkQ4pGvE755kWqw4lbuix80ntioQDj81
 LrIUBOgJfJpg7GnV+aDMW5FriICKAsK8T4pxsWhqyDBC3eRQJvpsviJ9Pif+uG2rKtLwdBAnJWc
 esbOfKORfDD7VTVWD2vX+aarHjNHcgn/TGRwDU9rM5GJPejpNE7HeDv3KJ5TvpYmMS0nZsO3Wtc
 jzD0UAGXqSZk2A2ph56jqwTCGkIJC6bQLALxx0GBsvdOLZnc16WvZ8yceDG+typbcpYitHe8FIs
 tTkj8Vvcj7BvmfAC++HZLfEIsEhi3lvr2fSL4Lsjdfs4Q+IXYOcVDYvWpbfaQSmeEJHNj6LB0Ly
 u0XCBwQtQWFiA9cuYvvK44b2DHtmsAGbXwep/W+TZUccDqzu5rvnMjSsnT5NMf0JTyWGUZ+vi8y
 hxGF3gJEK7PFyyM3zal/FBAavTQPJZSinxu0/lowBJPjwG73tEY0cIOZdcqNp1pEYLmGMqdumSV
 Vlj9KiILvur5H8BXFVLayI7lkggpS1lici0MODmxINQlFoSOq1emuv9IcPlJolW7AXEElYKMPwp
 g/Rx2gMjPMX22dh9SzjFbLUwQl/V6uF0Sa0NoMfXUEfDecZWgDv6yRUu1nyWLJCK3WZE8kqdjI9
 UXeQfVGST6gjrOw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The old_flags variable is declared twice in __dev_change_flags(),
causing a shadow variable warning. This patch fixes the issue by
removing the redundant declaration, reusing the existing old_flags
variable instead.

	net/core/dev.c:9225:16: warning: declaration shadows a local variable [-Wshadow]
	9225 |                 unsigned int old_flags = dev->flags;
	|                              ^
	net/core/dev.c:9185:15: note: previous declaration is here
	9185 |         unsigned int old_flags = dev->flags;
	|                      ^
	1 warning generated.

Remove the redundant inner declaration and reuse the existing old_flags
variable since its value is not needed outside the if block, and it is
safe to reuse the variable. This eliminates the warning while
maintaining the same functionality.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
Changes in v2:
- Improve the commit message to specify that there is no impact reusing
  the variable (Andrew)
- Remove the Fixes tag, since we do not want this to be backported.
  (Andrew)
- Link to v1: https://lore.kernel.org/r/20250214-old_flags-v1-1-29096b9399a9@debian.org
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d5ab9a4b318ea4926c200ef20dae01eaafa18c6b..cd2474a138201e6ee86acf39ca425d57d8d2e9b4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9182,7 +9182,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 
 	if ((flags ^ dev->gflags) & IFF_PROMISC) {
 		int inc = (flags & IFF_PROMISC) ? 1 : -1;
-		unsigned int old_flags = dev->flags;
+		old_flags = dev->flags;
 
 		dev->gflags ^= IFF_PROMISC;
 

---
base-commit: 7a7e0197133d18cfd9931e7d3a842d0f5730223f
change-id: 20250214-old_flags-528fe052471c

Best regards,
-- 
Breno Leitao <leitao@debian.org>


