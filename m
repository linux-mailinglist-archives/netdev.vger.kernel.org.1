Return-Path: <netdev+bounces-179427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE727A7C8BD
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 12:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB2A1887E54
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 10:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6A1BCA1C;
	Sat,  5 Apr 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="IOmHUGgI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4931DF723
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743848737; cv=none; b=rvSQa3AmZYE0v1X2cg0LXhtfTa7DQuinGbPmjYrzzYI+dJEoZk5X9i8wjzjn7NNX89TDy7xJ5+0AeJIKe7gZJbxbmaeQFJPat49v8b0cDr1k3/0zfUAxgbqTgkhSdY1mjIzxlQTdM55I0W3CImgbVid6/9qWIvAWC8O6J17sU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743848737; c=relaxed/simple;
	bh=qDbUGVc9ddRn0dviCjSgc3jstlkfiRFWLeY25SxpJaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnCiaoBC9iFuL24g2oZTBuDMMqgjHQXylKdTFVyndLNrZ6lOkvtw/G66GMmonU3k2yduofjArxn9Ii7WwHUYyjC1FgxvaTxRs/fUI4mVwnaxoT62Bk9GkE6e0BSKUzos8N5Nr3X382msiPcUej1VwOoEULPLGvdIjYGYNQISf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=IOmHUGgI; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso25446615e9.2
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743848734; x=1744453534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3p3N+NpdSfaO48hsEOGVkvt64Z/JP+ZSuhF28JzsA0=;
        b=IOmHUGgIyHN4hfcp8fTIupNyk0fkO+dHa2M0PTFE4alYcg6/krGFBg0B9+UjYXmvyk
         JK2112P2Vn7pPhfp+n12rLKgEA2oGvMBxTlXvqPYMdIiDlxiAAkJihPKLxnWLcSQ/Cag
         HonIx1O3uEVgkCc0b6J6jG9EUAvCkaijqCZFJkzb9TnmI51wNfo6gZAFHt0P9SJnJOQ/
         7hYLFoh1uFhfuXYrgXhrJG/FPsdvy6blgTC8gmjKyu5fwE3u/QkIp1viVQs6vTMqv0mL
         THcXz4c/W/VhbbDwcNBiBHOA15dHhPWtKkW6uQRoRQMqv88fabhe4a89wef+CRnbBbn9
         CUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743848734; x=1744453534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3p3N+NpdSfaO48hsEOGVkvt64Z/JP+ZSuhF28JzsA0=;
        b=nEp31NkeTehwtfq0qB1b+Fo/TuNvohe+ypLS8za2fAeDA+RC99C0y7Ajm8OAJL/bxN
         SIAO263lKUT1tlg2O82mgOIwBLfYQgVoDl5Z6ehgKc5DBL2hyfZqw4I+Nj1atUGIft9y
         EThcamFKY/2F+CGBMtPNjIYIHjQ2bFS/+KIp/S1hG0wY3cMhaj5ZhZmRV9YfDo+J48nC
         iNaemc0HJ5EIG5FAQg3F2Hyo37CXSOCHQfRi+J5jU38K04lMpqrL0hzeYy/ZICJs6xwp
         CrB9HzYjKNEKFjdSoHEB4kOPjL6iObZ79c99UPyeblykrFBxF55MPX8MvsE2guBHeBhD
         ZWgw==
X-Gm-Message-State: AOJu0YwrymdTS3Ho48F27l6GooerLWE+6RjG0evYx7R+wQhwhD0jM3Sg
	7zHrdyfyZoc3k85Poh7HfBdJV1pdtoYUXcu9d9Mp4f7anRDoQO655vWMjq/QtMk7dklmF+NFJYw
	4v0EM5w==
X-Gm-Gg: ASbGncs01SSEMa26CL9TxHV4YgkPczUrf5cb9iH/My7V2fCD8eEw3oX4emlJmqIUF0x
	pDfWRjkLPR0UBJvhU5E3ir8j8NsdIqodiq58CPTqF1DAnHJOXxxNrrUEJCRpuaWDcTCK+HmLPqy
	2/FrHjSz0OySdmlJuwNBUTrhHM3pHNjca48BbeApwCrFiwke233eYEHed7n75V40IxYatKx2T5a
	Ci5S5pFD0H3GJ3UPptLhVkSi/8V5eTBiQJxlNLSsigwbya8Gu8JMJYZXPQMwD/ZUJ47s1jOE6/s
	yetIdRRLLjoRzOF2qUK3VL0ULbBbzpurCmdrSgv2HAHwUxFdJlC7wMVPGs2RJHnz6LemulrX4ch
	g
X-Google-Smtp-Source: AGHT+IEBZ8NJfJ6jcZr8611CUZAbceEKAdRsLSk+mFfwMk7tvXvHh/qQYlpZkHchFr2NORuwj3yBjw==
X-Received: by 2002:a05:600c:a07:b0:43c:fb95:c752 with SMTP id 5b1f17b1804b1-43ecf843e91mr68245725e9.3.1743848733679;
        Sat, 05 Apr 2025 03:25:33 -0700 (PDT)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16ba978sm72524185e9.23.2025.04.05.03.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 03:25:33 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2] MAINTAINERS: update bridge entry
Date: Sat,  5 Apr 2025 13:25:04 +0300
Message-ID: <20250405102504.219970-1-razor@blackwall.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync with the kernel and update the bridge entry with the current bridge
maintainers. Roopa decided to withdraw and Ido has agreed to step in.

Link: https://lore.kernel.org/netdev/20250314100631.40999-1-razor@blackwall.org/
CC: Roopa Prabhu <roopa@nvidia.com>
CC: Ido Schimmel <idosch@nvidia.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
CC: David Ahern <dsahern@kernel.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84931abd561d..c9ea3ea5accb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26,7 +26,7 @@ T: git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git
 L: netdev@vger.kernel.org
 
 Ethernet Bridging - bridge
-M: Roopa Prabhu <roopa@nvidia.com>
+M: Ido Schimmel <idosch@nvidia.com>
 M: Nikolay Aleksandrov <razor@blackwall.org>
 L: bridge@lists.linux-foundation.org (moderated for non-subscribers)
 F: bridge/*
-- 
2.49.0


