Return-Path: <netdev+bounces-214786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AEEB2B3E3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FB952679C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30027A468;
	Mon, 18 Aug 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOWeY0Y6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116A1CAA85;
	Mon, 18 Aug 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554549; cv=none; b=UIxUUeQFwxe8L/ML/AtcP5nxN3jJO5wPepx7JkFsXHdRq7xB/7BsDG2pc2g68VjWeTZebghpg2YvU2KD3JdKGFPgqzBB13ukHWhXih1nfbFg9IE01cLiKXfkL0iusTJe4za9N13OZkvX0DQY7+ABHgD8ASYt0HAn34YhxS2AV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554549; c=relaxed/simple;
	bh=BbKQhsSie71PplRUIqtXnKtQMB2oshV1SJWnLXLpjls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mGZmXrTE4lsssJ5LWMWjOhPCWIBILeSpqlg/K/71TirU5vCHCILz4k15EGFaDp+rc11V1B2CxHdF118XfHGiXWw1ekixEdWe0W//TKbYqDRim1JIYVTsEDYHmYAeRReANjJfTDjibrL2QEnQu7f6skZFLyU0w7TVget73aYe840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOWeY0Y6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3bb81a0c36aso177700f8f.3;
        Mon, 18 Aug 2025 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755554544; x=1756159344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MMT+x+jbaJC9oySW558qkFj8oOION97HvJImMbStZp8=;
        b=mOWeY0Y6emOZIVbjQCM5Da6/PYrNyxDg58LESEPnRiT4YABhA/qEQI0XrFQNBvz3Jv
         SitjazQW9jhcTn8tnSFWeusjmwkmyBEdvWgIR3P957Om3dGu0c3tHzb5+BAButMSGbvQ
         z3upXnzT9f4mH9P7Cgy+V3jLFtHVTr7tCV9nlytKukQKXsrYrFLoandNKT7+sfJXd4Om
         QMDlMv+8ydteBABEfqkTSq5SraPAkwQr0gV7FWQgIjZQkfVUZHEa8S5RbfVtXpvuVKyd
         GHiN9V7fKx7quxECY9+BSGgWoLKOkwlUOadxZcc9lZJTJNVEBuebjyqQnOXWiWZQW1ZK
         2trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755554544; x=1756159344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMT+x+jbaJC9oySW558qkFj8oOION97HvJImMbStZp8=;
        b=VFZh2n3vrGg9zVgD36Ahu+bOZztMlv63eLjJCEfxUUCY70h8S+nFUfhYOA1Sc3Rgv1
         NeN8nJEkP1mCM/D4aypCzkCQKOMvosBRxQ76SSlzt/JNpDlTmU3GLuheQQrPH9WMk1G4
         Nv8cnK31ji4o+9fe4XC3H0Z5Q8V3nCZSHHyh+6Bk9KyJS+FME82Z9gWoZhuk3RouY5RK
         ucR0TMwfIrlAojVsyph+Cbr44tLqS4KSmep03LqPw0hcMIDRuXVP+d0wSDtQwyHdd4Y8
         UbJ0CVL2XVZ0fi2ib9BZ9WOsON1mU7D0JbVX//0fpLlu/CsN6nuP1oraMtJj71tBCKEj
         PiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY1woNxaK16Gxm/2J/JZZBq+UH4RQYw1Rqtm3ydw8rK40x9jsOxrOhAxboLzCgitJfKWzjd5Q2tJlV3EI=@vger.kernel.org, AJvYcCX9sPSjtkFBosAY8lVHMdln016Nw+xs5wSuiXHQfhrQbuKItjphMqCyyAI6eSTs1LhoKMFQ5082@vger.kernel.org
X-Gm-Message-State: AOJu0Ywed7XiPcFEK94pTXHjah69CttUG1hPHvIMG5yXpfoSb1HxTy46
	k5mynomNXMKUsstEkNdXJGeUfVIfUdnlu76Sz08FpwJLnTyZxRRP/4Zh
X-Gm-Gg: ASbGncsl2inzHDu03B92V4eAOOzFAGJo/bG6i4PrUIRNGom1Lf27fAXsfDB05NraFO3
	sRx7wNejA+FMQL5Tm7I6oD5VfP+bOjl07+EKRNcJQowdRwO6uFtCkYQLLKXdPRp54w9l/udKFk/
	B7dxurlO28nUIRTb+6uM45QlSNYu5DKvRCZa6bKcvqjxARc1CKp9kEWSu7DDl5dT7rQ5M64F/n3
	5/dBCiRGutloZbKdKjBJSx5tBsgtSqWqQGh+NvhjDS9uonaNikWVnSCautt+gmq3JLCLDz4qPqJ
	HKUH6lAAd3Rli6Tnhzeqd25Ov5uQRO3SMshjgd07nNZE1SmGM9F3CMkC2FwO4UgBgrPqUU5VUym
	95B0rF5yPPofKz5Znx7eGZpLuRlHMFg5+xRJZl/n5YlZ42PA0a9okRU7ruddv7pFRejfezmwztw
	==
X-Google-Smtp-Source: AGHT+IGqTqLQGaZ68f4i/kMGo2uN5+oqDEU0Zd691fQqoW6XRw2OaSXzy4vlDNXALNeaT0rKZcREXw==
X-Received: by 2002:a05:6000:290d:b0:3b9:13a4:731 with SMTP id ffacd0b85a97d-3c0ed7b8f3dmr67727f8f.10.1755554543409;
        Mon, 18 Aug 2025 15:02:23 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0748797acsm967410f8f.10.2025.08.18.15.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 15:02:22 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH net-next] ipv6: ip6_gre: replace strcpy with strscpy for tunnel name
Date: Tue, 19 Aug 2025 00:02:03 +0200
Message-Id: <20250818220203.899338-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the strcpy() call that copies the device name into
tunnel->parms.name with strscpy(), to avoid potential overflow
and guarantee NULL termination. This uses the two-argument
form of strscpy(), where the destination size is inferred
from the array type.

Destination is tunnel->parms.name (size IFNAMSIZ).

Tested in QEMU (Alpine rootfs):
 - Created IPv6 GRE tunnels over loopback
 - Assigned overlay IPv6 addresses
 - Verified bidirectional ping through the tunnel
 - Changed tunnel parameters at runtime (`ip -6 tunnel change`)

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 net/ipv6/ip6_gre.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 74d49dd6124d..c82a75510c0e 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -329,9 +329,9 @@ static struct ip6_tnl *ip6gre_tunnel_locate(struct net *net,
 	if (parms->name[0]) {
 		if (!dev_valid_name(parms->name))
 			return NULL;
-		strscpy(name, parms->name, IFNAMSIZ);
+		strscpy(name, parms->name);
 	} else {
-		strcpy(name, "ip6gre%d");
+		strscpy(name, "ip6gre%d");
 	}
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN,
 			   ip6gre_tunnel_setup);
@@ -1469,7 +1469,7 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strscpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
 	if (ret)
@@ -1529,7 +1529,7 @@ static void ip6gre_fb_tunnel_init(struct net_device *dev)
 
 	tunnel->dev = dev;
 	tunnel->net = dev_net(dev);
-	strcpy(tunnel->parms.name, dev->name);
+	strscpy(tunnel->parms.name, dev->name);
 
 	tunnel->hlen		= sizeof(struct ipv6hdr) + 4;
 }
@@ -1842,7 +1842,7 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strscpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
 	if (ret)
-- 
2.34.1


