Return-Path: <netdev+bounces-120127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AEB95862E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67091C21D75
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBEA18E74F;
	Tue, 20 Aug 2024 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aImrQsU0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A68918E054;
	Tue, 20 Aug 2024 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154892; cv=none; b=Tqu3N4+zaWPYjQjD+WleYv+zoRVliid+3kz/y+PcwC+QOGxfQU5nWs1IkDV4erAeZMUi1dc/5gSYLTlhMZaiOi7iFW3DigQkRU9ts4MXqqs5i5MK6XDVrCEltv7yJbN+4CU0S1v+0xAhZDCVmZQJo7mP3X6rVXHgsl6iVDeBGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154892; c=relaxed/simple;
	bh=yQ8ynkivFpeUnJnm+bjAjKQKaQiN6hgYUruRwDdfZGg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Sb1Doge1KCyN4efzf7qUy+xgRCMDKQLLqz7N5omhuv0wkMl5ejAm+n23uSm5mdv1LYXgH5oKQcgEQ4pTwqcmGkkZgul61P0XvNpCpZjfJLZ76e44ffLMjbIk7L8kOK6RXcWmT8oVVE7ZcDJ8IhLGXRjL4cYfGn5hUB1RaOYk8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aImrQsU0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7106cf5771bso4381953b3a.2;
        Tue, 20 Aug 2024 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724154890; x=1724759690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4l+S2gup120Wyh/3bctSkp8RCid291o4Is+yzzc0jos=;
        b=aImrQsU0NcB7jC7uBbmro6Re5/C69Uwo+BIcUimNbLliAOQ9KdtRDuyBrI06Njqfrk
         EBFxY8d9s5Ki0atlrplTC38l08Hth7DQW5/vlLU8Bjz9stMWOTiVEzA7z2Oa/5x2j2kq
         U6rbEeicT6jkcAOGBjDwutDy7+8s09vi0LpwsXsUe2sRFzuVHE3tdqoeD5jSxpvtjBHA
         yPkpPOm2R333LaGyzKsgE9MU6MdqaWYIavx2dhijlGRHdbvlGKjHs3F3uYhmSPitqM3Y
         vP7HHi0HSvqcYQPjcN9pUwHQBvy5zYmYitfgKen2yYtBQhpAgXsCGCbdsD6L4HNt9SGQ
         zaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154890; x=1724759690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4l+S2gup120Wyh/3bctSkp8RCid291o4Is+yzzc0jos=;
        b=NDMqpvGvbhy7LrPzGIp157nDtd5nZUIaH9kSVLTiEEfo/0cpzewDLIOQz3yhEywAMG
         LgUSuNAmiy+kHIYqt/6FqNQxIMrtytG1utx9NDRsbWTvzOzcFjJd748SEqGDN+KLmcdH
         sxhqZsSIJvxxV64k20XF8mMmaa7NY79+D731V9vKlYxWdcqTadCHn3z9HmPFX+km18fX
         ByVp/rosflza7cGNs8dv8vQ9QMrVu65qIfbfrh4iAi2/prTxE9tbPm64dQVDUNSwE61t
         cqwXBPt8EWPfAqq5FQXsdU4ZuSba8EtDxWHVdNwiiIhHIlltC+l1Pel44vv65/8G9G6P
         cvdA==
X-Forwarded-Encrypted: i=1; AJvYcCW+M6rYQjd6f+Vcd9TJlTUT1sNBZnupH5q6OY+J5q7Y29CpP4BlwR/dwM6EMoSoC19Cy6vih+je@vger.kernel.org, AJvYcCX2wiVKNMP3bAzHw6+EevbyMu+opsWsozDY34r0yYiwfPaEVrX+deXoaK02W9XfddKzP9lXAbL5n2+Od6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxopnaBr6AIvbfV6KuZZZlqJt4bqmEXXSsLaBjWlonq5Ia5Tui7
	7u+wTUOM+IoriVXmIxVTB4W0ZNBS1ry3TTb3ddvq/XyKZOCezi19
X-Google-Smtp-Source: AGHT+IG4LDUkFPIOil8kfhohO8vqVNIdjdbvQMacNFcHW+QG5f2cw3Q0vVZsjWhCxt+5q7E2l/Sqaw==
X-Received: by 2002:a05:6a21:9206:b0:1c8:ebd2:85ab with SMTP id adf61e73a8af0-1c9050639a0mr14536623637.51.1724154890250;
        Tue, 20 Aug 2024 04:54:50 -0700 (PDT)
Received: from localhost.localdomain ([58.18.89.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d99479sm9122953a91.48.2024.08.20.04.54.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Aug 2024 04:54:49 -0700 (PDT)
From: Xi Huang <xuiagnh@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuiagnh@gmail.com
Subject: [PATCH] ipv6: remove redundant check
Date: Tue, 20 Aug 2024 19:54:42 +0800
Message-Id: <20240820115442.49366-1-xuiagnh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

err varibale will be set everytime,like -ENOBUFS and in if (err < 0),
 when code gets into this path. This check will just slowdown
the execution and that's all.

Signed-off-by: Xi Huang <xuiagnh@gmail.com>
---
 net/ipv6/addrconf.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f70d8757a..7372ae469 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5617,8 +5617,7 @@ static void inet6_ifa_notify(int event, struct inet6_ifaddr *ifa)
 	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_IFADDR, NULL, GFP_ATOMIC);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_IPV6_IFADDR, err);
+	rtnl_set_sk_err(net, RTNLGRP_IPV6_IFADDR, err);
 }
 
 static void ipv6_store_devconf(const struct ipv6_devconf *cnf,
@@ -6173,8 +6172,7 @@ void inet6_ifinfo_notify(int event, struct inet6_dev *idev)
 	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_IFINFO, NULL, GFP_ATOMIC);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_IPV6_IFINFO, err);
+	rtnl_set_sk_err(net, RTNLGRP_IPV6_IFINFO, err);
 }
 
 static inline size_t inet6_prefix_nlmsg_size(void)
@@ -6241,8 +6239,7 @@ static void inet6_prefix_notify(int event, struct inet6_dev *idev,
 	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_PREFIX, NULL, GFP_ATOMIC);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_IPV6_PREFIX, err);
+	rtnl_set_sk_err(net, RTNLGRP_IPV6_PREFIX, err);
 }
 
 static void __ipv6_ifa_notify(int event, struct inet6_ifaddr *ifp)
-- 
2.34.1


