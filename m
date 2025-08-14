Return-Path: <netdev+bounces-213542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3707B258B9
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 03:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2BB881E6F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 01:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70FA86323;
	Thu, 14 Aug 2025 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJrdgbic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B029A2;
	Thu, 14 Aug 2025 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755133282; cv=none; b=oq8bYfGddNIiNgXOm/aiK+fbS8ysWqg8e+NOLH22iJCNlsXQI1Wsgj4E3Rr8jWuxQ+nhJUKK8guC21H6nZpTUS7nJAixkmPhUR/JpATVOluXt4+zvuvSbYIJjJCjVJColj+TU6Y8J8kvy7XkIIuf6TTmZ0NGrBuCCb3RjMHaLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755133282; c=relaxed/simple;
	bh=BgYADDZNn1QGP8McyCKnNLHgPx6xFyxwoBH73J/vNdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lsu2LnQaOYmGslFBVvfPOGwOMIXexyFb5pAefmn4KTSYW2Mo7kpL52ty0uC8CM/O1ZEc7crIq/VgKj3zB4AOVRvlf+CG6sTysnrZ3Gt2KKuCsQJ2aciADDndPlTy1bwjzyUU0hGR/0WMyvu4iN68vePTyqzpjPNRYckML2p/W/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJrdgbic; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326e8005bso496691a91.3;
        Wed, 13 Aug 2025 18:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755133280; x=1755738080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmRK/OcA855B8uL5oM9h+iArfFvDj2KGuj3BbBAIWG8=;
        b=VJrdgbicpBJeD7Y0otxXNDcDVoJ6Emn/IiuUYH99jMZicRuFlcyE0GPYQh5g+i8XpT
         KgrI6stzDyAKL8wti14R8uJig7I5OohPzWnEGcfoGB5wnsf7yiCYP98XKbaCYIoNtg6u
         VF8OyFa9gLAZHH3NiAOBT9QlRWmTD8D3zbFiZaMRuEt8KV0QzZ0M8y5RGCeVvj2EJcQs
         XvhiRrc5Az1hrTI5ZImVFtRr55vh6yflxt0tm9i0/+gFWlkQyz9evMAXsKNRfNX5yTAN
         jhP6+YuyuQjNjzEKX8dJUU8dYuCYLvUkKQGJLSutwUKdonRW1ykjmw87OPNKs+Y0j32/
         n4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755133280; x=1755738080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmRK/OcA855B8uL5oM9h+iArfFvDj2KGuj3BbBAIWG8=;
        b=qDljnSUdu8Yo1mfAtWq5zz6zGKX4WmAiawx3c6zBrFVummJWMFkk9EPVdJHRJGpQ6x
         9/wTc6P2n6JREJK79IZZGEcwBHex6Px57ITpTEdNZiR82jPLGISHwHuWZz0yoLHRGZgd
         qA16NpXqIbxIevfsWzkTuD8F5ybzKr+TRaDghitOdoDmeR+8qFSjt4967LYYU60AMIhP
         APmKVAba+ObZhx9eXfzK/EJJUZ/7ZOQ62q31EGsbzKIsB9xH0HxrdbmCoO3FmocvEz7N
         ZxT4l9dblwh0CNMm1qRrQvezoOQcl2/QOy5STye4z59fexTWtNleApz6GdrT3gbgdJ6s
         bquQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyV0SGO9oPoTfCix3XMsfUdl1l353CFPf9FKniR5FoxXqW+ogwS08cuzMcj0HjuJOszutx+ez93nMYxlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTg5b1QWTyLcDmVLmzZOpY4jnYxCI3SFXIm4YwfO4XtEzCP7K
	YHmbrYxidQJpIRCpU9LXLEAXvArsI8cOrqN565BVxTeng2VRA442P6rw
X-Gm-Gg: ASbGncv/Ec/15YPcGjOsAhJwX2heZCLYdrOyHpP/Untw8gatlAiYhuoc2eDVRQ/MOML
	o7irMtNCW/0uu0UIDWgOaNtQAAm0Sfv74exjMBCSYTN12/pWi1bGiEU6LegKJbp+jmFCTc93SEe
	aG5O/3SXviTEGZ+5RiLzlyHMbIUbF3AVX2F22t7cfs1KLyQX0ihghEgW0jW78BWKJDmhZZZq+uF
	8Asr+QXfowtiywfT2Ffizp6fEExC3WuVvgr5y1Fr2hplI0HFwkZJsmlbWjrGexaCWrjieVuDkXJ
	Gpsxt1cNfcgsBWWSVsXtny0IZu2vSMyGDP0X3bZH6gqLVhsJ2m1UWMZwqX1GP8k/bdVrcoidAN6
	x3OwmY8zMgvTtqMRYnNtmO5kQvmkJVWaIYTnTCkI=
X-Google-Smtp-Source: AGHT+IHDR6XFwjRkc0kzqrP7D67S7zPiaBmX+TUC2HvECQZ+ZVfklosVZ/Uw+7Oh/OvHf5p5iL9bbQ==
X-Received: by 2002:a17:90b:3c05:b0:31f:ad:aa1b with SMTP id 98e67ed59e1d1-3232799c039mr1746682a91.3.1755133280318;
        Wed, 13 Aug 2025 18:01:20 -0700 (PDT)
Received: from C11-068.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b46ea0780d8sm6785378a12.29.2025.08.13.18.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 18:01:19 -0700 (PDT)
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
Subject: [PATCH net-next v4] net/core: fix wrong return value in __splice_segment
Date: Thu, 14 Aug 2025 09:01:11 +0800
Message-ID: <20250814010111.15167-1-hept.hept.hept@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If *len is equal to 0 at the beginning of __splice_segment
it returns true directly. But when decreasing *len from
a positive number to 0 in __splice_segment, it returns false.
The caller needs to call __splice_segment again.

Recheck *len if it changes, return true in time.
Reduce unnecessary calls to __splice_segment.

Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
---
v4:
Correct the commit message.
v3:
Reduce once condition evaluation.
v2:
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


