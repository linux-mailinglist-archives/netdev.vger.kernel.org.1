Return-Path: <netdev+bounces-208141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277BB0A391
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F62BA80B1F
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A412DA75C;
	Fri, 18 Jul 2025 11:52:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B942D9ED7;
	Fri, 18 Jul 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839538; cv=none; b=rgqgB2tkqA64V3VL3jWfmeD5zziiDHBU6CZT8qfzCm2/EQQzE/whoQldIifCTF62i/GOKPCbiOZseFHsreCAoKr0hBIgcaHHG1wlt6IFV0D4DSIsig3jCjp6xj98T4Wtq5qIQo0WI+/KwNByjiKajOso2QV5jZjd+c94H3TtTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839538; c=relaxed/simple;
	bh=oagYvLPRp2ebesljFuBIVfa937xZLmXWPbPvbJX8Vb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7vkrZG9448RYN/ldhUs83vLoGxJob26jfC0mFnr/eltkb+riaUNSIqogjCNaoS4ECIrouIXB5o3aLC9aAtdpg507+LvpCLDrW9elmA72AXHPJY6wxfsTwk8kennUw+4ksdd8yCYeEy9sbBEGz3ixI5ja0vq5HaE05X7Nxgm68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so3572520a12.1;
        Fri, 18 Jul 2025 04:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839535; x=1753444335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsLTxz4UURCNf6IGkttLdx17vKela2kG3TZHARmy8BA=;
        b=ZCD4ob1o+5Kf+uCjkr3eh/NyCYZhPNyV2TJ4aeLpkRe2vP7rTrjy9F+8VDmB3O1SgJ
         drk12+b26BzZQbZKj7KrB+Aw3/Um4MgBSi5dZZN6YOthJ7vOsha1iF8VB/1dNs5+0Ev1
         4K6ttcDdCDyBdvU9bPvZcxwM0LyebfVzgE8sv4dJUuF1qND93M9msq1MZy87R4K24LBm
         I8X1yU03Bd0w9kVCWm2RBQmuJqRKeLq5sprhsPUB2vnwiQoasaio9V/9Rbt9ZpP0BZwU
         5fYWmvhk/wjGq7fnQIm+L4X9tKHznHdZ8+kCe5FysLB8kietaGcL9rMI8A2PAXFgCpfI
         mFbw==
X-Forwarded-Encrypted: i=1; AJvYcCVMgBUxsUf+Hbz3oGoD+2bYkERPmQOQMqwK9mxaMsLH4mVSvyQTyaopLsGDoHVC+YtUUENH7HI7jEG2Yms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLpKQ1YcjwURz2/jFQz6tH8G3zFT0OGec2PlDkAqCRXtMRPYu
	jMeMLkYYWLOZ49fKMuZCBf/nSEEXMWQO/FygqKC10jcm9fj6lLxoF+kE
X-Gm-Gg: ASbGncu6aH1BTP48lwRWG3EGEIuQ+i6zmjW8Q6pQwnGgWoNitxOMydqqVxHGXbKxQya
	eSmTiOGg/FvkSpQ/+l7GdgSib705VXm6KFpgCRUTY41nLj6u5aWNMbgoOEL7UXygz0BGC/FmJLy
	M6/2Wlscf56gElfwH4MP7qzaXD2yTZze8x+jRPHSEMJA9izFXZcbk5YDFxcq/BIZDIQZT1nNTJ6
	CYjPxcERX7LflPsmrrWV9/mF0o++flIJhnhNYMTgdehY8gJCzDkAMR7Bawndll++oFpWsFQ8CSt
	HdpkaRJ/d+NdUhSSAALlvUjHoOMnhgl3HTziZGDvavzp6QLHckfAK0/2wpP6GKXqp38d6Ba6zDu
	YYmjDyGsGRxLTW/HN2DHVn4Xy
X-Google-Smtp-Source: AGHT+IGjnXf2z0qwBj3yHRhAXXXCizvmwyzUS2jYmaauRD+o7hnGPU34FyHP+GwXPEwDwG6zshPBJw==
X-Received: by 2002:a05:6402:84a:b0:604:e440:1d0b with SMTP id 4fb4d7f45d1cf-61281f1db60mr10195225a12.4.1752839534581;
        Fri, 18 Jul 2025 04:52:14 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c90bc80bsm870521a12.68.2025.07.18.04.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:52:13 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 18 Jul 2025 04:52:01 -0700
Subject: [PATCH net-next 1/5] netpoll: Remove unused fields from inet_addr
 union
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-netconsole_ref-v1-1-86ef253b7a7a@debian.org>
References: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
In-Reply-To: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=714; i=leitao@debian.org;
 h=from:subject:message-id; bh=oagYvLPRp2ebesljFuBIVfa937xZLmXWPbPvbJX8Vb4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoejVqTf1QOktqecWWRvxZqaKjqAVseRIY868ky
 La3rNJ2JruJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHo1agAKCRA1o5Of/Hh3
 bSm7EACV72/mGXfANRp1qGgo+rOzxSe6Ckq1PFep0rln26Ol2rLJbo1pQvws0wlpDIRJ/KMIZUG
 7IIUmkZBhS3IK50ivKJl0EorXr2KO3JSZUgeMZOq3DTTEIsS7GtrKgMt53jDiGIoNSZN20nzpFB
 xE3sxmx/1LhJ0HqL8ntKkFTO5+4ypYgpwg1D7YblNe5Axdbhz9xeJMKjVt2+3qg4JkpDTTwzCc9
 o6wgaEm/p4Q9olJ5BtzXZ0bE6xeI/xwQ/4ve9auaDpNBNOnFdFV5m+GzKzSHCzg6UBL0FFwyZMC
 LS/N1lkjo5mKyrfABJvuDp4QiAaysBtsdIOr6yyGQGxOVTUA/RVJX5BZHu9K8Hj9ADGvdBTsHVq
 uXE3wSSUJV0uCMV9ffPh2ty+tumiIf0nqhQZJejHsM78wgCvE4IVn6y9n7tK11iIki0wS24UeK2
 3I85ca4lgH2wm7N+xOZlRS5gKo35SxrJlcBTEdI/fkTg9jSLzsS7ilC8BwB19sVNkIQdjqLhupU
 aUBYMHGJBIAMce0TGaFgtbcZ3THwJsz9PLU7Jkdm8a+iuiqx4u8NuuGVgYjGzBHlS0Ft0ss0C64
 5oSZXuTYZpK85oUG6GBJH8EStP41i8HxiOiQFQI7MnkHtSJIGLmBu/2qQIiZ9ThJqwTAGWF1n7Y
 EXQ4GsLv+PtUXqQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Clean up the inet_addr union by removing unused fields that are
redundant with existing members:

This simplifies the union structure while maintaining all necessary
functionality for both IPv4 and IPv6 address handling.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 735e65c3cc114..b5ea9882eda8b 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -15,10 +15,7 @@
 #include <linux/refcount.h>
 
 union inet_addr {
-	__u32		all[4];
 	__be32		ip;
-	__be32		ip6[4];
-	struct in_addr	in;
 	struct in6_addr	in6;
 };
 

-- 
2.47.1


