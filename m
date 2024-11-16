Return-Path: <netdev+bounces-145558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E469CFD9C
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 10:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E8B1F281A7
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C70194A70;
	Sat, 16 Nov 2024 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS6LYye1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB919007E
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731750165; cv=none; b=Lvy0uhV6gfZy20mVgmNo0UwzQDDeONuAbARLUeG1tuATq2cigtOmBhXXBKp1bC9wnzu3lGEU/09b/YgkLoqO8Phkf5k5CrKqUiJUsQUhjG6RUhqvgntCiOSe/64/hI7tqpb3ky/H2+lVZInJB2MGkctm+5G32FnS61DmF4H+xcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731750165; c=relaxed/simple;
	bh=YD478yUNlcMk0PR0alh8RiTROYjT7uOprJ4cGSsc1Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MCvFQKtnyXYx9zTHLwPAoSTes4/W5dcyc3BFyq6pJmHPyo7cFfhLwaYir+VBv2N3siG5lVlHD61qhUiLmM5BVX/gN3NTd0l2QiyYl+S9p/1KITp7f6yCLYPbLanniHAk/Nt2AdAS223/GXjTwrNZnQ763GYxiSPOwIohjkCxfLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS6LYye1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-382378f359dso215769f8f.1
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 01:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731750162; x=1732354962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtmbgObVPqEcaQduRgeglVc17hEyE/OZ+SDbXbc3sGI=;
        b=SS6LYye1ifQLs6epKLHu+cgZrxLkr6LgBgaNHJBEg9GXADDIRqaufzzB/Z0E+AsNdc
         n1qT+WQGYioW2bAnuM9nEIfdDnpbYEeR92wBJCoKmM9mCrH8Gq78NcHe7UIfRhjGSVIt
         ch6HZsjsi32JMkxqQbjxJOIwEkWRrHNS/wDNOIqX65kXLIpHI2m0Ro8ThsrnYUuuJO0a
         /7pApqoZPKHgK4BcMvMoAndbDhurMC5/CS4EovWSB8djq1P8qTz8LxiiCIrMaAHjfULQ
         kNWjjdGKQxVEjvZNX50ENjYSiut4lPvwWxY4Ru4XFiDo96xkcg9QAmvvsAc/l8GiqpKg
         HlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731750162; x=1732354962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtmbgObVPqEcaQduRgeglVc17hEyE/OZ+SDbXbc3sGI=;
        b=iDE5e3fHpDr03Ntu4AxEQHGJDQ0HPlXVeSQCVQUogfGn8sZa6eDSxVykNfaMbyvnEX
         bNkcsUL+BtS70aZItRk2SEg4Foy3tPdwKtXkyyPCefJs75SDuT7vLkUYbwjcGwDBd7uD
         Z1fL1GnvmqIwLnpmXe/y2PL4t8OpQ2CUsFJd2x5grP0GThwvnFHXatDkmeCBDqU3Ee9i
         PtXZFI2DOlJbXSppyBeXbXIVEsRDjApeB7mleEURJexJB7LUmRU0GRBV/ROMQ8fmUwDc
         WxqKBKwO6SjfSK/ND38MiYhNTvDqkCg1bQpv5XgNnUTgxwLdWr05ClUyAHLt/dDpapkE
         BCoQ==
X-Gm-Message-State: AOJu0YyTj7d/K4I3du4WKCfZ/iH/3GJfopWgi0wamonjsng20dELKuV9
	S6fsXZzaN8B9s1M0MA5NwKIGxuNMaQibWsehbwHfCmUXqXwHrNGsD4u7wQ==
X-Google-Smtp-Source: AGHT+IG9bnWpsDFB6xY+zYwsG/sS2DIA3y4MZeQx5DSTZXDWsEti2EHlIWRTo5N3qMa5xysLd1Wivw==
X-Received: by 2002:a5d:5f43:0:b0:36c:ff0c:36d7 with SMTP id ffacd0b85a97d-38225a41fc3mr4717786f8f.2.1731750162019;
        Sat, 16 Nov 2024 01:42:42 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:592a:f022:ac3b:3ce8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbe7dfsm6700632f8f.56.2024.11.16.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 01:42:41 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] net: af_unix: clean up spurious drop reasons
Date: Sat, 16 Nov 2024 09:42:36 +0000
Message-ID: <20241116094236.28786-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use consume_skb() instead of kfree_skb() in the happy paths to clean up
spurious NOT_SPECIFIED drop reasons.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 net/unix/af_unix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 001ccc55ef0f..90bb8556ea04 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1705,7 +1705,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		unix_state_unlock(other);
 
 out:
-	kfree_skb(skb);
+	consume_skb(skb);
 	if (newsk)
 		unix_release_sock(newsk, 0);
 	if (other)
@@ -2174,7 +2174,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		unix_state_unlock(sk);
 	unix_state_unlock(other);
 out_free:
-	kfree_skb(skb);
+	consume_skb(skb);
 out:
 	if (other)
 		sock_put(other);
-- 
2.47.0


