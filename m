Return-Path: <netdev+bounces-94924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8D58C103E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B24B2320E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270D415278C;
	Thu,  9 May 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSUvJBLe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A39381C8
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260721; cv=none; b=q4AON849ptllRUFvf1fOES5w0ENmrr7z+hiLhTJ9KNswzorJswh0urk0rJyxy+/qW+7iGpEhPXYTyIU5ORnJe0XahH5YPGaGDnV+fDKfcNDir8+oKYwYdQZnyIchEDprxauLxs1DX/JkAWXyLwOjlOZdmT4XrQekVMvQ/xpS21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260721; c=relaxed/simple;
	bh=RuA9/2FQ3AD7ToZOsjoYUinfISN4dsTHV3b6ZMt95D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEhV5DMRrLBWn0c6iuQ2gPmltSB+BUtJpKoT2enRegkbBHeUo5U8TU7DhSv1iirxQFVid0LBsfMefZQEKQyGL3rszSGNgoL911J8P6pTYz/j5YhvOkeRtKH9liYmFDjqXRJ0f5JctRc9leScUW9xaXoIWlQkJ789xtN2BzWf4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSUvJBLe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1edfc57ac0cso6425445ad.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260719; x=1715865519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WF3zVFppUFaTfw3JPJlBUBuWZODsc9HJQD7EjAmz90=;
        b=MSUvJBLeCD4XxgjPs8jzAt3VYwA6/nQXzBwANOgabHAJ6tBWOb8vbJpMOuDhUKdLW/
         aZRDuirYFcjOipKD3/H//kkBRJEOl0O2q7SIxitTTzfR1yCEZY780ptQwOSJJ9Ja0NNy
         nax1BLnx3KFqVYinWbhKFpWGJzwA/lRJjqOfRzTjshSZ7iimKzQm/5e1Ndf/N/N6iOhh
         BkVpYzYkpYkTsPpYxQ4EGhhdyp+zPnaRVkRQ1yaBwR/yAC2hC9Nzx5h4T+uY4IKS3y8X
         rILaC2YYjVGjQCEyPm3uf2QcFaCnrJrCFfFvRap/aK5Iu1j4NuC2FN//7LPyrnhbrGKJ
         zO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260719; x=1715865519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WF3zVFppUFaTfw3JPJlBUBuWZODsc9HJQD7EjAmz90=;
        b=lwZxlBvxnWhJmKgXC13pkTLcTnBRXBpCB5qhk028yj7ClOgTs3OMrNc+lo1IRSyRin
         DUn1vLgeNXGzCJshxCgfGo9jVxLu4Erjzkk5hEedwKBhDvh+qHa3+Du58OKhJ1gmpPoq
         OYEVFR/9kZPWv9irz1Fd3O425IL23HtI5xcgH4xtqvIam9HSj1VVQt1/8dBGcojkzVm2
         PgyTr33zqggSt3lEPkZ8ThvxrlbNLzFz8ppEoAbEmaj6HVoAdL8xZmlUA/SPPqtCqt8O
         dzD/jbTq+9iMNqGGGZ7MCpPqR9ULKV8bV1b4Yr6RTd1gq65y8tnpnDC7UUGme1luomJ8
         uE8g==
X-Gm-Message-State: AOJu0YyGgjS5jTCvn86Iv2lhcTU8M7YfkIpkqtkvNJLTWqJw25CdBixA
	Ndi3AywsyuKB+uEH2+0eQXWuzFRw2Gfi3SqGgXXl9B6GxD/EipCOs3RD05IfP5Y=
X-Google-Smtp-Source: AGHT+IGKWXAh9pM/iU9JBqc0dZjMUEhnsgjNOoM70Is1oR4k3Hd3cv5KDqLtBdGaFsCR2S2n5fOJng==
X-Received: by 2002:a17:902:a3cc:b0:1e4:6938:6fe3 with SMTP id d9443c01a7336-1eeb0b9aab3mr50075855ad.58.1715260718784;
        Thu, 09 May 2024 06:18:38 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada3d8sm13989055ad.99.2024.05.09.06.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:18:38 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 3/3] ipv6: sr: fix invalid unregister error path
Date: Thu,  9 May 2024 21:18:12 +0800
Message-ID: <20240509131812.1662197-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509131812.1662197-1-liuhangbin@gmail.com>
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path of seg6_init() is wrong in case CONFIG_IPV6_SEG6_LWTUNNEL
is not defined. In that case if seg6_hmac_init() fails, the
genl_unregister_family() isn't called.

This issue exist since commit 46738b1317e1 ("ipv6: sr: add option to control
lwtunnel support"), and commit 5559cea2d5aa ("ipv6: sr: fix possible
use-after-free and null-ptr-deref") replaced unregister_pernet_subsys()
with genl_unregister_family() in this error path.

Fixes: 46738b1317e1 ("ipv6: sr: add option to control lwtunnel support")
Reported-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv6/seg6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index c4ef96c8fdac..a31521e270f7 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -551,6 +551,8 @@ int __init seg6_init(void)
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 out_unregister_genl:
+#endif
+#if IS_ENABLED(CONFIG_IPV6_SEG6_LWTUNNEL) || IS_ENABLED(CONFIG_IPV6_SEG6_HMAC)
 	genl_unregister_family(&seg6_genl_family);
 #endif
 out_unregister_pernet:
-- 
2.43.0


