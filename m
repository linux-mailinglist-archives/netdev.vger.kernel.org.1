Return-Path: <netdev+bounces-209731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF74B109FD
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC21CE4D3B
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA502D0C98;
	Thu, 24 Jul 2025 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLe4avPP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28F2D0C95;
	Thu, 24 Jul 2025 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359589; cv=none; b=bCrz1Ga78K5CKgXI0cofUd2AlTnHYsL+X67E/WL1zpcJwOAAC4PaMQuTF+5arjpdfMd49Xxq/AhO/CU6M2qxBibfR186dykw2mrpuXYxQqGMKi06DgvA8knIy+/b+zvA4747uT47mjFCDV/hWbvnwyb5xzsjfhgyRVsfayjPgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359589; c=relaxed/simple;
	bh=oKeVGy0RkekyqjulkjS05Gj0xAfuLQtvBA4WtI7tmEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxflI1Ixtl06RYz7ps8+2ht13/ydLt2OHBSNookkYT2f30JVKnFMhkzPNcVExgmoxTw439JniRHXjXxq8C1lctM4Do4vrDX4VM+FSefkzrDWcjrOyLMKtoYgAjQF++6x/zWgAbqn5SIyEkfUjRhVa7VGypXJHoDuFYdJgKV9Nm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLe4avPP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23694cec0feso8788805ad.2;
        Thu, 24 Jul 2025 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753359588; x=1753964388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FStyCwDnIrIXDZFkRPm9oX9c2zmQ9q098S2nJmrXCl0=;
        b=DLe4avPPzbkTARkHx0ofm+e+sTkSkhq/Ky/hWwMc1JkY4Z75keiU0458qOaiQhDWkC
         +H153uAkjGId7hwaHiLErbrTd/TOXwivE8B53PyPeBvmaLWKJKsPjNgR0XfZfrcMCLi0
         bRb2Gh066McEEQis9dc41mHT+K7EVszHr2N3/vPKTJZGvsSwi4SnBX40UyOCtCWcViA6
         fUTGAhbI6GaDHU7eMnFKsRN1riGxXdXtYACvBfo+xgI4jTzX/4K76l5UDnR/yEZpgJ1l
         gd1BEVqZcL8LCOTTg3NnGAwYf4q6A0EiA624D+oIioG1W5M8hDb9rBWvG66dFDh0L+tG
         rLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753359588; x=1753964388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FStyCwDnIrIXDZFkRPm9oX9c2zmQ9q098S2nJmrXCl0=;
        b=Jf0CnR/RZmmdaSxSFbVYpCI9pHLg3vBbYYmMvprWJ+iwORxwIFqGglXTWWbJhIaQF2
         Aw3QPvqqG59Wc4G4XlFQqeXzhurDGnsA9/beYkRh3+q94vkXz7HOIqiapmGg0ZgIAG58
         dN4/38FA11etnSXF+segDKjtSwPgX87NMsIhTTTb+ry0BgICYr+J4TXd9lDcTKVwpFVn
         lBnVgBrkjB4pajqyddxaTNA4ix4wGMFt28jInFJoavsm33ehrpOm6/aov/jiB1GbXepP
         CLRBD3gJumruzHQOUOQ0gOg1t6J6DGeGqLMLpk+5np5zjzadJBkjwdLwhxTuhKARql34
         lH9A==
X-Forwarded-Encrypted: i=1; AJvYcCXJEWbtuFVyKppWWEYVK71opAM934YNXodAxjdsNssg55rihsJpJua6OinUR//Uy8UXr8+8huD/csctDxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwojxbM1/iUJnNq5Ew0CBZE/HXRLsjGgRjbgVm2OEawOQNXedHT
	Su+RWacDlOe0lPGdU/3HdQW9NO10Zi0nx2UEOuzVrfjJGc23WViUfqs3
X-Gm-Gg: ASbGncv0fHkwk4RbP50Sb+v+pcOFI7riUhdC2OtUc5H6XH+H+40CU81ny7zacZ44Mi1
	FpF+iWGKUgkkIumtCR5wuLcOebxWnndRKtyGP3kNb/aehcrlJjgB7kgxpd2WzI03DBoOXNQwyyT
	X9oKNtIEbdK5QEMYLLdXvQVKHBErVpYOOl2r+ltzhXzSTGaZ07os/dizYHk9IcScgLIAn0zfp1x
	RzRnzBmOj8CszPpYZv43hiZYyUXvahB4OOC3mwRkzZz8pVm2zRwwzp4Tt47uv3jaXWKJUOP4NP1
	6G2a7l3a2lBk8bWQmQU6SpUDB++P6ixExJPMK2UGLynSy+bgYyiMGYaiZX3H/G7ZJC3rbH2EJgK
	R5BZxNBkBYnGmxw6WOEwUz1l0weTDIZ9EwnkmHg==
X-Google-Smtp-Source: AGHT+IGB8N3YZPg7cSXAGWXTZGMzCvsMzBYppYI5nZZWIppb0P3P361AX3A4odPgG7X7AIhDmGi9cg==
X-Received: by 2002:a17:903:2352:b0:226:38ff:1d6a with SMTP id d9443c01a7336-23f9814697amr88659185ad.7.1753359587669;
        Thu, 24 Jul 2025 05:19:47 -0700 (PDT)
Received: from C11-068.mioffice.cn ([2408:8607:1b00:c:9e7b:efff:fe4e:6cff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa491bad7sm14602825ad.214.2025.07.24.05.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:19:47 -0700 (PDT)
From: Pengtao He <hept.hept.hept@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Eric Biggers <ebiggers@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengtao He <hept.hept.hept@gmail.com>
Subject: [PATCH net-next v3] net/core: fix wrong return value in __splice_segment
Date: Thu, 24 Jul 2025 20:19:21 +0800
Message-ID: <20250724121921.1796-1-hept.hept.hept@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return true immediately when the last segment is processed,
avoid to walking once more in the frags loop.

Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
---
v3->v2:
Reduce once condition evaluation.
v2->v1:
Correct the commit message and target tree.
v1:
https://lore.kernel.org/netdev/20250723063119.24059-1-hept.hept.hept@gmail.com/
---
 net/core/skbuff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..23b776cd9879 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3112,7 +3112,9 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 		poff += flen;
 		plen -= flen;
 		*len -= flen;
-	} while (*len && plen);
+		if (!*len)
+			return true;
+	} while (plen);
 
 	return false;
 }
-- 
2.49.0


